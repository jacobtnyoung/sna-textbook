# =============================================================================== #
# Build PAUL REVERE data files for SNA textbook.
# =============================================================================== #


# ----
# This syntax file builds data files stored in the sna-textbook repo.
# These data files are used in the 507 and the SAND course.
# This script is run once to build the files and export them 
# to the data folder in the sna-textbook repo.

# Paul Revere Conspiracy
# The Paul Revere conspiracy dataset concerns relationships between 254 people 
# and their affiliations with seven different organizations in Boston. 
# The dataset refers to Paul Revere, who was responsible for organizing a local militia 
# of Boston's revolutionary movement (see http://en.wikipedia.org/wiki/Sons_of_Liberty). 
# The dataset was analysed by Kieran Healy of Duke University. This dataset has been 
# reconstructed by looking at the information presented in the appendix of the book 
# "Paul Revere's Ride" published by David Fischer (1994).

# Reference: Fischer, D. (1994), "Paul Revere's ride", Oxford University Press. 
# Retrieved from: http://kieranhealy.org/blog/archives/2013/06/09/using-metadata-to-find-paul-revere/. 

# data retrieved from: 
# http://www.casos.cs.cmu.edu/tools/datasets/external/paulrevere/paulrevere.zip


# ----
# Setup.

rm( list=ls() )

library( network ) # for working with the network object


# ----
# Load the data.

matFile <- "/Users/jyoung20/Dropbox (ASU)/GitHub_repos/sna-textbook/data/build-syntax/build-raw-data/PAUL-REVERE.csv" 

mat <- as.matrix(
  read.csv( 
    matFile,
    as.is = TRUE,
    header = TRUE,
    row.names = 1
  )
)

# =============================================================================== #
# END FILE.
# =============================================================================== #