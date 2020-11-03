##################################################
#
#Data and Code fir the CESAB Datatoolbox Exercices
#
##################################################


# ----- clean workspace
rm(list = ls())

# ----- install/update packages
devtools::install_deps()

# ----- install compendium package (rend dispo les fonctions du compendium dispo)
devtools::install(build = FALSE)

# ----- Knit exo dplyr
rmarkdown::render(here::here("exercices","exo_dplyr.Rmd"))

# ----- Knit exo spatial
rmarkdown::render(here::here("exercices","exo_spatial.Rmd"))
