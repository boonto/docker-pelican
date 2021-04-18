FROM python:3.9.4-slim-buster
ARG PELICAN_VERSION=4.6.0
ARG SOURCE_SANS_VERSION=3.028R
ARG MATPLOTLIB_VERSION=3.4.1
RUN apt update && apt upgrade -y
RUN apt install wget unzip fontconfig -y

RUN wget https://github.com/adobe-fonts/source-sans/releases/download/${SOURCE_SANS_VERSION}/source-sans-3v028R.zip && \
    unzip source-sans-3v028R.zip -d source-sans && \
    rm source-sans-3v028R.zip && \
    mkdir -p /usr/share/fonts/opentype/adobe/ && \
    cp source-sans/OTF/*.otf /usr/share/fonts/opentype/adobe/ && \
    rm -rf source-sans && \
    fc-cache -f -v
RUN apt install -y \
    texlive-base \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-fonts-recommended
RUN pip install pelican==${PELICAN_VERSION}
RUN pip install matplotlib==${MATPLOTLIB_VERSION}
WORKDIR /site
RUN mkdir -p /site-generated
ENTRYPOINT ["pelican", "-Dr", "-o", "/site-generated"]
