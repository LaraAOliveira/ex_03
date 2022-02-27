FROM rocker/tidyverse:4.0.0

RUN R -e "install.packages('rvest')"
RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('ggplot2')"
RUN R -e "install.packages('stargazer')"
RUN R -e "install.packages('gsubfn')"
RUN R -e "install.packages('scales')"

COPY /inputs /inputs
COPY /outputs /outputs
COPY /3o_ex.R /3o_ex.R

CMD Rscript /3o_ex.R