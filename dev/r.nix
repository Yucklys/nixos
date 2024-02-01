{ config, pkgs, inputs, ... }:

with pkgs;
let
  R-packages = rWrapper.override{ packages = with rPackages; [ ggplot2
                                                               dplyr
                                                               xts
                                                               rmarkdown
                                                             ]; };
  
  Rstudio-packages = rstudioWrapper.override {
    packages = with rPackages; [ ggplot2
                                 dplyr
                                 devtools
                                 rmarkdown
                                 tidyverse
                                 tinytex
                               ]; };
in
{
  environment.systemPackages = with pkgs; [
    R-packages
    Rstudio-packages
  ];
}
