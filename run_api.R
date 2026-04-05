# Start Agrisaviour R API (Plumber) — Loan Advisory + Risk Analysis
#
# One-time setup in R (or RStudio):
#   install.packages(c("plumber", "jsonlite"), repos = "https://cloud.r-project.org")
#
# Run from project root (d:\agrisavoiurrrr):
#   Rscript r-api/run_api.R
#
# Or from inside r-api/:
#   Rscript run_api.R
#
# Default: http://127.0.0.1:8000  —  GET /health  POST /loan-advice  POST /risk-analysis
# Other port:  set PORT=9000  (PowerShell: $env:PORT=9000; Rscript r-api/run_api.R)

if (!requireNamespace("plumber", quietly = TRUE)) {
  stop("Install plumber: install.packages(c('plumber','jsonlite'), repos='https://cloud.r-project.org')")
}
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("Install jsonlite: install.packages('jsonlite', repos='https://cloud.r-project.org')")
}

root <- getwd()
path <- if (basename(root) == "r-api") {
  "plumber.R"
} else {
  file.path("r-api", "plumber.R")
}

if (!file.exists(path)) {
  stop("Cannot find ", path, " — cd to the project root (folder that contains r-api/) or to r-api/ and try again.")
}

port <- as.integer(Sys.getenv("PORT", unset = "8000"))
message("Agrisaviour R API: http://127.0.0.1:", port, " (Swagger: /__docs__/ or /__swagger__/ depending on plumber version)")
plumber::plumb(path)$run(host = "0.0.0.0", port = port)
