FROM ubuntu:14.04

MAINTAINER Shubham Patil "shubham.patil@weboniselab.com"


RUN apt-get update && apt-get install -y \
	python-pip \
	python \
	mongodb \
	git 

EXPOSE 5000

COPY . $HOME/flask-app

WORKDIR $HOME/flask-app

RUN pip install -r requirements.txt \
	&& chmod +x database-backup.sh \
	&& chmod +x log-rotation.sh \
	&& cp flask-docker-cronjob /etc/cron.d/flask-docker-cron \
	&& chmod 644 /etc/cron.d/flask-docker-cron \
	&& touch /var/log/flask-docker-db-backup.log \
	&& service mongodb restart

ENTRYPOINT ["python"]

CMD ["server.py"]
