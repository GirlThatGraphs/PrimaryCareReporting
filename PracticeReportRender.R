library(beepr)
library(emayili)
library(dplyr)
library(DBI)
library(odbc)
library(dbplyr)

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


Reports %>%
  pwalk(rmarkdown::render, input = "PracticeReport.Rmd")

beep(4)


# Alternatively, if you want to programmatically find each of the sub_task dirs
my_dirs <- intersect(list.files("PracticeReports/", pattern = ReportDate, recursive = TRUE, include.dirs = TRUE),
                  list.files("PracticeReports/", pattern = ".pdf", recursive = TRUE, include.dirs = TRUE))



for(file in my_dirs) {
file.copy(paste("PracticeReports/",file, sep=""), "S:/Shared Area/Assurance Framework practice reports/2022_23/Practice Reports/202209 September")
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
  emayili::text("The practice profile reports have been run and are saved: S:/Shared Area/Assurance Framework practice reports/2022_23/Practice Reports/202209 September. 
                
                Kind Regards, Elaine.")

smtp(email, verbose = TRUE)

beep(4)


usethis::edit_r_environ()

