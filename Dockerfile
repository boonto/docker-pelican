FROM python:3.8.3-slim-buster
ARG PELICAN_VERSION=4.2.0
ARG SOURCE_CODE_PRO_VERSION=3.006R
ARG MATPLOTLIB_VERSION=3.2.1
RUN apt update && apt upgrade -y
RUN apt install wget unzip fontconfig -y
RUN wget https://github.com/adobe-fonts/source-sans-pro/releases/download/${SOURCE_CODE_PRO_VERSION}/source-sans-pro-${SOURCE_CODE_PRO_VERSION}.zip && \
    unzip source-sans-pro-${SOURCE_CODE_PRO_VERSION}.zip && \
    rm source-sans-pro-${SOURCE_CODE_PRO_VERSION}.zip && \
    mkdir -p /usr/share/fonts/opentype/adobe/ && \
    cp source-sans-pro-${SOURCE_CODE_PRO_VERSION}/OTF/*.otf /usr/share/fonts/opentype/adobe/ && \
    rm -rf source-sans-pro-${SOURCE_CODE_PRO_VERSION} && \
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
