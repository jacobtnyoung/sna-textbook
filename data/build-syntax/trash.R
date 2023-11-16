


  dat.edgelist.year <- dat.edgelist %>% 
    select( YEAR, person_id, incident_id ) %>%        # keep the year, person, and incident id for the edgelist
    arrange( YEAR ) %>%                               # arrange by year
    filter( YEAR == 2023 ) %>%                        # keep based on year
    select( person_id, incident_id ) %>%              # keep the incident and person id for the edgelist
    arrange( person_id, incident_id )                 # arrange by incident then person id
  
  mat.edgelist.year <- cbind(
    as.character( dat.edgelist.year$person_id ),
    as.character( dat.edgelist.year$incident_id )
  )
  
  net.year <- as.network(                             # create the network
    mat.edgelist.year, 
    bipartite=length( unique( mat.edgelist.year[,1] ) ), 
    matrix.type="edgelist"
  )
  
  # check for duplicates
  table( duplicated( dat.edgelist.year ) )
  
  
  oneMode <- as.matrix( net.year ) %*% t( as.matrix( net.year ) )
  
  # find the component membership
  cd <- component.dist( as.matrix( oneMode ), connected="weak" )
  
  # find largest size
  max( cd$csize )
  
  # find which component is the largest
  sort( table( cd$membership ), decreasing = TRUE )[1]
  
  # assign membership as a attribute
  as.numeric(names(sort( table( cd$membership ), decreasing = TRUE )[1]))
  
  now assign this as an attribute
  
  
  !!!HERE: working through this, trying to reduce the size of the network
  I think you need to build out a variable for this
  
  
  return( net.year )                                 # function returns an object of class network
  
}