devtools::load_all()
usethis::use_pipe()

### Drake ###

usethis::use_r(name="plan.R")
usethis::use_r(name = "wrangle.R")
dir.create("output")
dir.create("output/plots")
dir.create("output/text")


# add needed packages
usethis::use_package("dplyr") # and all other package but directly writed in DESCRIPTION
# use_package ne marche que si le package est déjà installé
devtools::install_deps() # ==> to install all package in the DESCRIPTION file


usethis::use_build_ignore(".drake")
usethis::use_build_ignore("_drake.R")
usethis::use_build_ignore("output/")
usethis::use_build_ignore("make.R")
