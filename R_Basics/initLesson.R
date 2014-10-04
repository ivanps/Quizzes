# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

rm(list=ls())
suppressMessages(library(RCurl))

NPREG <- 25
cal <- 0
sid <- ""
qpts <- 100/NPREG

# Path to installed lesson
.lessonpath <- file.path(path.package("swirl"), "Courses", "Quizzes",
                         "R_Basics")
# Path to dataset
.datapath <- file.path(.lessonpath, "flag.data.txt")
# Load dataset
flags <- read.csv(.datapath, header=FALSE)
# Set column names
colnames(flags) <- c("name", "landmass", "zone", "area", "population",
                     "language", "religion", "bars", "stripes", "colours",
                     "red", "green", "blue", "gold", "white", "black",
                     "orange", "mainhue", "circles", "crosses", "saltires",
                     "quarters", "sunstars", "crescent", "triangle",
                     "icon", "animate", "text", "topleft", "botright")
