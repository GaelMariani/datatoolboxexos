
#' Get ecoregion data
#'
#' @return data.frame with info on ecoregions
#' @export
#'
data_ecoregion <- function(){

 readr::read_csv(here::here("data", "wwf-wildfinder", "wildfinder-ecoregions_list.csv"))

}


#' Get mammals species data
#'
#' @return data.frame with info on mammals
#' @export
#'
data_mammals <- function(){

  readr::read_csv(here::here("data", "wwf-wildfinder", "wildfinder-mammals_list.csv"))

}


#' Get mammals ecoregions data
#'
#' @return data.frame with info on which mammals in ecoregions
#' @export
#'
data_mammals_ecoregion <- function(){

  readr::read_csv(here::here("data", "wwf-wildfinder", "wildfinder-ecoregions_species.csv"))

}


#' Exctract Ursidae species
#'
#' @return a tibble with only info on Ursidae species
#' @export
#'
extract_ursidae <- function(sp) {

  extr_ursidae <- sp %>%
    dplyr::filter(family == "Ursidae", sci_name != "Ursus malayanus") %>%
    dplyr::select(species_id, sci_name, common)
    #dplyr::left_join(., ecoreg_sp, by = "species_id") %>% # first join with ecoreg_sp data
    #dplyr::left_join(., ecoreg, by = "ecoregion_id")  # second join with ecoreg data

  return(extr_ursidae)
}

#' Ecoregion ursidae
#'
#' @return number of different ecoregions in which we found each of the 7 species
#' @export
#'
get_necoregions <- function(Ursidae){

  ecoreg_ursidae <- Ursidae %>%
    dplyr::group_by(sci_name) %>%
    dplyr::summarise(n_ecoreg= dplyr::n_distinct(ecoregion))

  return(ecoreg_ursidae)

}


#' Join_data
#'
#' @return join ursus, sp_eco, eco_list
#' @export
#'
join_data <- function(data_ursus, data_speco, data_eco) {

  ## Première jointure
  data_ursus %>%
    dplyr::left_join(data_speco) %>%
    ## second
    dplyr::left_join(data_eco, by = "ecoregion_id")


}
