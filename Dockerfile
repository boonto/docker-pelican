FROM python:3.8.2-buster
RUN apt update && apt upgrade -y
RUN apt install -y \
    texlive-base \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-fonts-recommended
RUN pip install pelican==4.2.0
WORKDIR /site
RUN mkdir -p /site-generated
ENTRYPOINT ["pelican", "-Dr", "-o", "/site-generated"]
