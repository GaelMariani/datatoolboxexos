
#' Get pantheria data
#'
#' @return data.frame with pantheria data
#' @export
#'
pantheria <- function(){

  readr::read_delim(here::here("data", "pantheria-traits", "PanTHERIA_1-0_WR05_Aug2008.txt"), delim = "\t")

}


#' Tidy the dataset
#'
#' @return data.frame with tidy data
#' @export
#'
tidy_pantheria <- function(pantheria){

  pantheria_tidy <- pantheria %>%
    dplyr::mutate(order  = as.factor(MSW05_Order),
                  family = as.factor(MSW05_Family)) %>%
    # janitor::clean_names() %>%
    dplyr::rename(adult_bodymass = `5-1_AdultBodyMass_g`,
                  dispersal_age  = `7-1_DispersalAge_d`,
                  gestation      = `9-1_GestationLen_d`,
                  homerange      = `22-2_HomeRange_Indiv_km2`,
                  litter_size    = `16-1_LittersPerYear`,
                  longevity      = `17-1_MaxLongevity_m`) %>%
    dplyr::select(order, family, adult_bodymass, dispersal_age, gestation, homerange, litter_size, longevity) %>% # select the wanted column
    dplyr::na_if(-999) # remove NA
}

#' Explore the data
#'
#' @return a tibble with mean home range by family? Standard deviation? The sample size?
#' @export
#'
explo_data <- function(tidy_pantheria){

  tidy_pantheria %>%
    filter(!is.na(homerange)) %>%
    group_by(family) %>%
    summarise(m = mean(homerange), sd = sd(homerange),n = n())
}


#' Bar chart of the number of entries per family
#'
#' @return A ggplot bar chart of the number of entries per family
#' @export
#'
Graph1 <- function(tidy_pantheria){

  plot1 <- tidy_pantheria %>%
    group_by(family) %>% # group by family
    mutate(n = n()) %>% # calculate number of entries per family
    filter(n > 100) %>% # select only the families with more than 100 entries
    ggplot() +
    aes(x = fct_reorder(family, n), y = n) + # order bars
    geom_col() +
    coord_flip() + # flip the bar chart
    xlab("Family") + # add label for X axis
    ylab("Counts") + # add label for Y axis
    ggtitle("Number of entries per family") + # add title
    theme_bw()

  return(plot1)

}

#' Scatter plot of litter size as a function of longevity
#'
#' @return A ggplot scatter plot of litter size as a function of longevity
#' @export
#'
Graph2 <- function(tidy_pantheria) {

  plot2 <- tidy_pantheria %>%
    filter(!is.na(litter_size), !is.na(longevity)) %>%
    group_by(family) %>% # group by family
    mutate(n = n()) %>% # count the number of entries per family
    mutate(longevity = longevity / 12) %>% # Change month to year
    filter(n > 10) %>% # select only those families with more than 50 entries
    ggplot() +
    aes(x = longevity, y = litter_size, col = family) + # scatter plot
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) + # se = TRUE to add confidence intervals
    xlab("Longevity") + # add label for X axis
    ylab("Litter size") + # add label for Y axis
    ggtitle("Scatterplot") + # add title
    facet_wrap(~ family, nrow = 3) + # split in several panels,
  # one for each family
  # remove scale = 'free' for
  # same scale for all plots
    theme_bw()

  return(plot2)

}



