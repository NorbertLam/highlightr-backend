import re
import os
from os import listdir
import requests
import statistics
from collections import defaultdict
from dotenv import load_dotenv

keyWords = {
    'lul',
    'lulw',
    'omegalul',
    'ez',
    'pog',
    'pogger',
    'poggers',
    'pogu',
    'pogchamp',
    'pepehands',
    'gachibass',
    'gachigasm',
    'pepega',
    'ezclap'}
INTERVAL_SIZE = 20 # 20 represents interval of 20 seconds


def readFile(vodId):
  chatLog = []

  with open("{}.txt".format(vodId)) as f:
    for line in f:
      parseLine(line, chatLog)

    return chatLog


def parseLine(line, chatLog):
  newLine = re.sub(r'[\[\]]', '', line)
  splitLine = newLine.split(' ')
  time = splitLine[0]
  comments = " ".join(line.split(' ')[2:]).lower().strip()

  if chatLog and time in chatLog[-1]:
    chatLog[-1][time].append(comments)
  else:
    chatDict = defaultdict(list)
    chatLog.append(chatDict)
    chatDict[time].append(comments)


def parseChatLog(chatLog):
  parsedChat = []

  for i in range(0, len(chatLog), INTERVAL_SIZE):
    if i + INTERVAL_SIZE > len(chatLog):
      break

    time = list(chatLog[i].keys())[0]
    count = 0
    score = 0

    for k in range(i, i + INTERVAL_SIZE):
      comments = list(chatLog[k].values())[0]
      count += len(comments)
      score += countLikeTerms(comments)

    parsedChat.append((time, count, score))

  return parsedChat


def countLikeTerms(comments):
  score = 0

  for comment in comments:
    score += len(keyWords.intersection(set(comment.split())))

  return score

 # Calculates slope on amount of comments between 20 second intervals.
def calculateparsedChat(parsedChat):
  normalizedChat = []
  allScores = []

  for i in range(len(parsedChat) - 1):
    time = parsedChat[i][0]
    deriv = (parsedChat[i + 1][1] - parsedChat[i][1]) / INTERVAL_SIZE
    score = parsedChat[i][2] / INTERVAL_SIZE
    allScores.append(score)
    normalizedChat.append((time, round(deriv, 2), round(score, 2)))

  return (normalizedChat, allScores)


def getTimeStamps(vodId, normalizedChat, allScores):
  median = statistics.median(allScores)

  for item in normalizedChat:
    if item[1] > 1 and item[2] > median:
      addHighlightToDb(item[0], vodId)


def addVodToDb(vodId):
  r = requests.get(
      "https://api.twitch.tv/helix/videos?id={}".format(vodId),
      headers={'Client-ID': os.getenv("KEY")})
  displayname = r.json()['data'][0]['user_name'].lower().replace(" ", "")
  getFromRails = requests.get(
      "http://localhost:3000/api/v1/streamers/{}".format(displayname))
  posting = requests.post(
      "http://localhost:3000/api/v1/vod",
      data={
          'streamer_id': getFromRails.json()['id'],
          'twitch_id': vodId,
          'login': displayname})

  return posting.json()['id']


def addHighlightToDb(hightlight, vodId):
  requests.post(
      "http://localhost:3000/api/v1/highlight",
      data={"start": hightlight, "vod_id": vodId})


def getHighlights(vodId):
  chatLog = readFile(vodId)
  parsedChat = parseChatLog(chatLog)
  (normalizedChat, allScores) = calculateparsedChat(parsedChat)
  railsVodId = 1
  getTimeStamps(railsVodId, normalizedChat, allScores)


if __name__ == "__main__":
  load_dotenv()

  for item in listdir():
    fileName = os.path.split(item)[1].split('.')[0]

    if fileName.isdigit():
      getHighlights(fileName)
