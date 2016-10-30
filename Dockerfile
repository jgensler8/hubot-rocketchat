FROM node:0.12.4

RUN npm install -g coffee-script yo generator-hubot  &&  \
	useradd hubot -m

USER hubot

WORKDIR /home/hubot

ENV BOT_NAME "hubot"
ENV BOT_OWNER ""
ENV BOT_DESC "Hubot for Kubenetes End to End"

ENV EXTERNAL_SCRIPTS=hubot-diagnostics,hubot-help,hubot-jenkins-notifier,hubot-yardmaster,hubot-kubernetes,hubot-docker

RUN yo hubot --owner="$BOT_OWNER" --name="$BOT_NAME" --description="$BOT_DESC" --defaults --adapter=irc

CMD node -e "console.log(JSON.stringify('$EXTERNAL_SCRIPTS'.split(',')))" > external-scripts.json && \
  npm install $(node -e "console.log('$EXTERNAL_SCRIPTS'.split(',').join(' '))") && \
	bin/hubot --name $BOT_NAME --adapter irc
