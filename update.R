# Run this script to update embeddings.csv
library(tidyverse)
source("src/gemini.R")

cfg <- config::get(config = "template")

file_names <- list.files(path = cfg$folder, pattern = "\\.txt$", full.names = TRUE)

df <- 
    file_names %>% 
    map_df(~{
        
        tmplt_title <- gsub(".txt", "", basename(.x))
        
        tmplt_content <- readLines(.x)
        tmplt_query <- tmplt_content[!grepl("^SQL", tmplt_content)]
        
        emb <- 
            prompt_to_embedding(prompt_lines = tmplt_content,
                                task_type = "retrieval_document",
                                task_title = tmplt_title)
        
        
        data.frame(Title = tmplt_title,
                   Embeddings = I(list(emb)))
    })

df$Embeddings <- sapply(df$Embeddings, \(x) paste(x, collapse = ","))

write.csv(df, file = cfg$embeddings, row.names = FALSE)

