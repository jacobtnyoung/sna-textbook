# =============================================================================== #
# Download PHX arrest data files for SNA textbook.
# =============================================================================== #

# ----
# This syntax file builds data files stored in the sna-textbook repo.
# These data files are used in the 507 and the SAND course.
# This script is run once to build the files and export them 
# to the data folder in the sna-textbook repo.

# This file takes the downloaded file and cleans the data.

# ----
# Clear workspace and load needed libraries

rm( list = ls() )

library( here )    # for accessing local directory
library( dplyr )   # for working with the data
library( network ) # for building the networks

# ----
# load data file

dat <- readRDS( file = here( "data/build-syntax/build-raw-data/arrest-raw.rds" ) )


# ----
# clean data and restructure for creating networks

dat.edgelist <- dat %>% 
  select( YEAR, UNIQUE_NAME_ID, ARST_OFFICER, HUNDREDBLOCKADDR ) %>%  # keep the variables you need
  group_by( HUNDREDBLOCKADDR, ARST_OFFICER ) %>%                # group by address then officer id
  filter( n() > 1 ) %>%                                         # only keep cases that involve more than 1 person arrested
  arrange( ARST_OFFICER ) %>%                                   # arrange by arresting officer
  mutate( incident_id = cur_group_id() ) %>%                    # create unique id for event
  ungroup() %>%                                                 # un-group the data
  group_by( UNIQUE_NAME_ID ) %>%                                # group by unique person id
  mutate( person_id = cur_group_id() ) %>%                      # create a unique person id that is numeric
  ungroup() 
#View( dat.edgelist )

# create the networks for each year ----

# check the years
table( dat.edgelist$YEAR )

# write the function
year.network <- function( edgelist, year ) {

  dat.edgelist.year <- edgelist %>% 
    select( YEAR, person_id, incident_id ) %>%            # keep the year, person, and incident id for the edgelist
    arrange( YEAR ) %>%                                   # arrange by year
    filter( YEAR == year ) %>%                            # keep based on year
    select( person_id, incident_id ) %>%                  # keep the incident and person id for the edgelist
    arrange( person_id, incident_id )                     # arrange by incident then person id
  
  mat.edgelist.year <- cbind(                             # coerce to an object to a character
    as.character( dat.edgelist.year$person_id ),
    as.character( dat.edgelist.year$incident_id )
  ) 
  
  net.year <- as.network(                                 # create the network
    mat.edgelist.year, 
    bipartite=length( unique( mat.edgelist.year[,1] ) ), 
    matrix.type="edgelist"
  )
  
  print(  table( duplicated( dat.edgelist.year ) ) )      # print out the number of duplicates
  
  return( net.year )                                      # function returns an object of class network
  
}


!!! finish writing this to have the components

First you need to create the projection,
Then you identify the first component,
then you make that a variable,
then you pass that to the network for the bipartite graph
then you select the bipartite network based on that attribute



# ----
# Execute the function for each year

net.2018 <- year.network( edgelist = dat.edgelist, year = 2018 )
net.2019 <- year.network( edgelist = dat.edgelist, year = 2019 )
net.2020 <- year.network( edgelist = dat.edgelist, year = 2020 )
net.2021 <- year.network( edgelist = dat.edgelist, year = 2021 )
net.2022 <- year.network( edgelist = dat.edgelist, year = 2022 )
net.2023 <- year.network( edgelist = dat.edgelist, year = 2023 )


# ----
# Save the file

net.list <- list( net.2018, net.2019, net.2020, net.2021, net.2022, net.2023 )

saveRDS( net.list, 
         file = here( "PAF-593-rodeo/arrest-cleaned.rds" ) 
         )

# readRDS( file = here( "PAF-593-rodeo/arrest-cleaned.rds" ) )


# =============================================================================== #
# END FILE.
# =============================================================================== #