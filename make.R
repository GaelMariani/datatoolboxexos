##################################################
#
#Data and Code for the CESAB Datatoolbox Exercices
#
##################################################


# ----- clean workspace
rm(list = ls())

# ----- install/update packages
devtools::install_deps()

# ----- install compendium package (rend dispo les fonctions du compendium dispo)
#devtools::install(build = FALSE) #dispo dans tout l'ordi
devtools::load_all() #dispo juste pour le projet

# ----- Knit exo dplyr
rmarkdown::render(here::here("exercices","exo_dplyr.Rmd"))

# ----- Knit exo ggplot
rmarkdown::render(here::here("exercices","exo_ggplot.Rmd"))

# ----- Knit exo spatial
rmarkdown::render(here::here("exercices","exo_spatial.Rmd"))
