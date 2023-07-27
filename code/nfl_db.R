#### NFL Database ####

library(tidyverse)
library(nflfastR)
library(DBI)
library(RSQLite)

#### Links ####
# https://www.nflfastr.com
# https://www.nflfastr.com/articles/beginners_guide.html
# https://www.nflfastr.com/articles/nflfastR.html
# https://jthomasmock.github.io/nfl_plotting_cookbook/#How_to_improve_your_nflfastR_graphics
# https://www.opensourcefootball.com/posts/2020-09-28-nflfastr-ep-wp-and-cp-models/
# https://www.opensourcefootball.com/posts/2021-04-13-creating-a-model-from-scratch-using-xgboost-in-r/


#### Update & Query Database ####

update_db(dbdir = "./", dbname = "nfl_pbp_db")

connection <- DBI::dbConnect(RSQLite::SQLite(), "../nfl_sql_db/nfl_pbp_db")
connection

dbListTables(connection)

dbListFields(connection, "nflfastR_pbp") %>% head(10)

pbp_db <- dplyr::tbl(connection, "nflfastR_pbp")

dak <- pbp_db %>%
    filter(name == "D.Prescott" & posteam == "DAL") %>%
    select(desc, epa) %>%
    collect()
dak

dbDisconnect(connection)




pbp <- nflfastR::load_pbp(c(2013:2022))
schedule <- fast_scraper_schedules(2013:2022)
# player_stats <- load_player_stats(c(2013:2022))
# weekly <- calculate_series_conversion_rates(pbp, weekly = FALSE)
weekly <- calculate_series_conversion_rates(pbp, weekly = TRUE)
glimpse(pbp)

