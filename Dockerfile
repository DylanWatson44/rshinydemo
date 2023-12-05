FROM rocker/shiny:4.0.5

RUN apt-get update && apt-get install -y \
    libgdal-dev \
    gdal-bin \
    libgeos-dev \
    libproj-dev \
    libsqlite3-dev \
    libssl-dev \
    libudunits2-dev

RUN R -e 'install.packages(c(\
              "shiny", \
              "sf", \
              "shinydashboard", \
              "ggplot2",\
              "viridis" \
            )\
          )'

# copy the app directory into the image
COPY ./shiny-app/* /srv/shiny-server/

# run app
CMD ["/usr/bin/shiny-server"]