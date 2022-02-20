## terceiro exercício
library(rvest)
library(dplyr)
library(ggplot2)
library(stargazer)
library(gsubfn)
library(scales)

###web scraping google scholar
##acemoglu citations

acemoglu <- read_html("https://scholar.google.com.br/citations?user=l9Or8EMAAAAJ&hl=pt-BR&oi=ao")

Citations <- acemoglu %>%
  html_nodes("#gsc_a_b .gsc_a_c") %>%
  html_text() %>%
  as.numeric()
df_citations <- as.data.frame(Citations)

Title <- acemoglu %>%
  html_nodes("#gsc_a_t .gsc_a_at") %>%
  html_text()
df_title <- as.data.frame(Title)

#merging both
acemoglu_20 <- cbind(df_title, df_citations)

#making a table with stargazer
table_acemoglu_20 <- stargazer(acemoglu_20, summary = FALSE, title =  "Acemoglu's top 20 papers by citation", type = "html")

#saving data frames
write.table(acemoglu_20, "acemoglu_20.csv", sep = ";", col.names = TRUE)

##top 10 researchers by citation MIT
mit <- read_html("https://scholar.google.com.br/citations?view_op=view_org&hl=pt-BR&org=16345133980181568013")

Names_mit <- mit %>%
  html_nodes ("#gsc_sa_ccl .gsc_1usr .gs_ai_name") %>%
  html_text()
df_names_mit <- as.data.frame(Names_mit)

cit_mit <- mit %>%
  html_nodes("#gsc_sa_ccl .gsc_1usr .gs_ai_t .gs_ai_cby") %>%
  html_text()
Citations_mit = gsub("Citado por", '', cit_mit)
Citations_mit <- as.numeric(Citations_mit)
df_citations_mit <- as.data.frame(Citations_mit)

#merging both
mit_10 <- cbind(df_names_mit, df_citations_mit)

#plotting
mit_plot <- mit_10 %>%
  ggplot(aes(x=Names_mit, y=Citations_mit)) + 
  geom_bar(stat = "identity") + 
  scale_y_continuous(labels = label_number(big.mark = ".", decimal.mark = ","), limits = c(0, 400000)) +
  geom_text(aes(label = Citations_mit), vjust = -1, hjust = 0.5, size = 4, color = "black") +
  labs(title="Number os Citations -\nMit researchers", y = "Citations",x = "Names")

mit_plot

#saving data frames
write.table(mit_10, "mit_10.csv", sep = ";", col.names = TRUE)

