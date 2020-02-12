FROM python:3.8.1-buster
RUN apt update && apt upgrade -y
RUN pip install pelican==4.2.0
WORKDIR /site
RUN mkdir -p /site-generated
ENTRYPOINT ["pelican", "-Dr", "-o", "/site-generated"]