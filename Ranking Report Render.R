library(beepr)
library(emayili)

ReportDate <- gsub("-","",Sys.Date())

rmarkdown::render("RankingReport.Rmd", 
                  output_file = paste("FinalReports/",ReportDate," SHS Ranking Report", sep=""),
                  params = list(param_1 = "Symphony Healthcare Services"))


rmarkdown::render("RankingReport.Rmd", 
                  output_file = paste("FinalReports/",ReportDate," Ranking Report", sep=""),
                  params = list(param_1 = "All"))


rmarkdown::render("RankingReport.Rmd", 
                  output_file = paste("FinalReports/",ReportDate," Chard Ranking Report", sep=""),
                  params = list(param_1 = "Chard"))

beep(4)

file.copy(paste("FinalReports/",ReportDate," SHS Ranking Report.html", sep=""), "//somerset.xswhealth.nhs.uk/CCG/Directorate/Shared Area/Assurance Framework practice reports/2022_23/SHS")
file.copy(paste("FinalReports/",ReportDate," Ranking Report.html", sep=""), "//somerset.xswhealth.nhs.uk/CCG/Directorate/Shared Area/Assurance Framework practice reports/2022_23")
file.copy(paste("FinalReports/",ReportDate," Chard Ranking Report.html", sep=""), "//somerset.xswhealth.nhs.uk/CCG/Directorate/Shared Area/Assurance Framework practice reports/2022_23/Chard")

beep(4)

smtp <- emayili::server(host = "send.nhs.net",
                        port = 587,
                        username = Sys.getenv("email"),
                        password = Sys.getenv("emailpassword"))

email <- emayili::envelope() |>
  emayili::from("elaine.gunns@nhs.net") |>
  emayili::to("elaine.gunns@nhs.net", "kelly.coller@nhs.net", "patricia.hymas@nhs.net", "melanie.nixon2@nhs.net") |>
  emayili::subject("Monthly Ranking Reports") |> 
  emayili::text("The ranking reports have been run and are saved: S:/Shared Area/Assurance Framework practice reports/2022_23. Please let me know if there are any issues.")

smtp(email, verbose = TRUE)

beep(4)