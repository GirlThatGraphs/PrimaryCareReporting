library(beepr)
library(emayili)
library(dplyr)
library(DBI)
library(odbc)
library(dbplyr)
library(purrr)

SQL_CONNECTION <- dbConnect(odbc(), 
                            driver = "SQL Server",
                            server ="BIS-000-SP08.bis.xswhealth.nhs.uk, 14431",
                            database ="Analyst_SQL_Area",
                            trustedconnection = TRUE)

ReportDate <- gsub("-","",Sys.Date())

Practices <- tbl(SQL_CONNECTION, in_schema("SOM", "REFERENCE_FEDERATION")) |> 
  collect() |> 
  filter(`MergePracticeCode` != 'L85612') |> 
  select(MergePracticeCode, PracticeDescription) |> 
  distinct() |> 
  mutate(output_file = stringr::str_c("PracticeReports/", ReportDate," ", MergePracticeCode," ", PracticeDescription,".pdf")) 


Reports <- tibble(
  output_file = Practices$output_file,
  params = map(Practices$MergePracticeCode, ~list(param_1 = .))
)

# 
# USE THIS IF RERUNING AND SOME REPORTS ARE MADE
# 
# my_dirsX <- intersect(list.files("PracticeReports/", pattern = ReportDate, recursive = TRUE, include.dirs = TRUE),
#                      list.files("PracticeReports/", pattern = ".pdf", recursive = TRUE, include.dirs = TRUE))
# 
# my_dirsY <- data.frame(my_dirsX) |>
#   mutate(my_dirsX = paste("PracticeReports/", my_dirsX, sep=""))
# 
# Reports %>%
#   filter(!output_file %in% my_dirsY$my_dirsX) |>
# ##  slice(-1) |>
#   pwalk(rmarkdown::render, input = "PracticeReport.Rmd")


Reports %>%
 pwalk(rmarkdown::render, input = "PracticeReport.Rmd")


beep(4)









my_dirs <- intersect(list.files("PracticeReports/", pattern = ReportDate, recursive = TRUE, include.dirs = TRUE),
                  list.files("PracticeReports/", pattern = ".pdf", recursive = TRUE, include.dirs = TRUE))

for(file in my_dirs) {
file.copy(paste("PracticeReports/",file, sep=""), "S:/Shared Area/Assurance Framework practice reports/2022_23/Practice Reports/202212 December")
}
beep(4)





smtp <- emayili::server(host = "send.nhs.net",
                        port = 587,
                        username = Sys.getenv("email"),
                        password = Sys.getenv("emailpassword"))

email <- emayili::envelope() |>
  emayili::from("elaine.gunns@nhs.net") |>
  emayili::to("kelly.coller@nhs.net", "somccg.generalpractice@nhs.net", "elaine.gunns@nhs.net") |>
  emayili::subject("Practice Profile Reports") |> 
  emayili::text("The practice profile reports have been run and are saved: S:/Shared Area/Assurance Framework practice reports/2022_23/Practice Reports/202212 December. 
                
                Kind Regards, Elaine.")

smtp(email, verbose = TRUE)

beep(4)






