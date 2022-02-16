# Docker image with [Pelican](https://blog.getpelican.com/)

Create a volume for the output files.
```
docker volume create pelican_files
```
Run the pelican build with your site, replace `<your-site-dir>` with the directory of your Pelican source files. The output will be written into the previously created volume `pelican_files`. Changes are regenerated automatically.
```
docker run --detach \
--name=pelican \
--volume <your-site-dir>:/site \
--volume pelican_files:/site-generated \
boonto/pelican:3.10.2-4.7.2
```
May be used in conjunction with the [nginx](https://hub.docker.com/_/nginx) container to serve the output.
```
docker run --detach \
--name=site \
--volume pelican_files:/usr/share/nginx/html:ro \
nginx
```
Also provides `matplotlib`, `latex` and the [Source Sans](https://github.com/adobe-fonts/source-sans) font for use with the [m.css](https://mcss.mosra.cz/themes/pelican/) Pelican theme.