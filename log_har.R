#install.packages("HARtools")
#install.packages("rjson")

#load library
library(HARtools)
library(rjson)


#read file .har
har <- readHAR(har = file.choose())

#number of entries
size <- length(har[["log"]][["entries"]])

#url composity
endereco <- ""
ref <- "--referer url"

dados <- c()

for (i in seq(1:size)) {
  fileLine <- har[["log"]][["entries"]][[i]][["response"]][["content"]][["text"]]
  videoid <- fromJSON(fileLine)$video$vimeoid
  videoTitle <- fromJSON(fileLine)$video$title
  line <- paste(paste(endereco, videoid, sep = ""), paste(ref), paste("-o ", "'", videoTitle, ".mp4", "'", sep = ""), sep = " ")
  dados <- c(dados, line)
}

#write bash file
write(dados, "file.sh")
