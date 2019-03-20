FROM rocker/binder:3.5.2

FROM rocker/rstudio:3.5.2

FROM rocker/tidyverse:3.5.2

FROM rocker/r-ver:3.5.2

## Copies your repo files into the Docker Container
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}

## Become normal user again
USER ${NB_USER}
