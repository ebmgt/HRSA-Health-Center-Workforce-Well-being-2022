# This file is available at https://EBMgt.github.io/HRSA-Well-being
# Author:rbadgett@kumc.edu with ChatGPT
# Permissions:
#* Code GNU GPLv3 https://choosealicense.com/licenses/gpl-3.0/
#* Images CC BY-NC-SA 4.0 https://creativecommons.org/licenses/by-nc-sa/4.0/
# Optimized for coding with R Studio document outline view


#== Startup ======
#* Set working directory -----
#usethis::edit_r_environ("project")
if (Sys.getenv("RSTUDIO") != "1"){
  args <- commandArgs(trailingOnly = FALSE)
  script_path <- sub("--file=", "", args[grep("--file=", args)])  
  script_path <- dirname(script_path)
  setwd(script_path)
}else{
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
getwd()

# ____________________________________________----
# Functions -----
function_libraries_install <- function(packages){
  install.packages(setdiff(packages, rownames(installed.packages())), 
                   repos = "https://cloud.r-project.org/",
                   #type = "binary"
  )
  for(package_name in packages)
  {
    library(package_name, character.only=TRUE, quietly = FALSE);
    cat('Installing package: ', package_name)
  }
  #tk_messageBox(type = "ok", paste(packages, collapse="\n"), title="Packages installed")
}

# ____________________________________________----
# Packages/libraries -----
packages_essential <- c(
  "rstudioapi",
  "data.table",
  "openxlsx2"
)

function_libraries_install(packages_essential)

# __________________________________------
# Data grab -----
filename <- "WorkforceSurvey_Output_Nat_PUF_randomized.csv"
data.import <- NULL
data.import<- read.table(filename, header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
file.extension<- substr(filename,regexpr("\\.[^\\.]*$", filename)+1, nchar(filename))
if (file.extension == 'csv'){
  data.import   <- read.csv(filename, header=TRUE, sep=",", na.strings="NA", dec=".", stringsAsFactors=FALSE, strip.white=TRUE)
}else{
  wb.temp <- loadWorkbook(filename)
  data.import <- read.xlsx (wb.temp, sheet = 1, startRow = 4, colNames = TRUE, na.strings = "NA", detectDates = TRUE)
}
nrow(data.import)
colnames(data.import)

# The PUF is stacked: each respondent has separate randomly located records
# for demographic information and job characteristics. Restrict to the
# national-demographic record so each respondent is represented once here.
dt_HRSA <- as.data.table(data.import)[Grouping == "Nat_Demog"]

# ____________________-----
# HRSA PUF validation against published report -----

# Published comparison values are from HRSA Health Center Workforce Well-being National Data Report - 2022:
#   Table A3.1: burnout mean, SD, number of items, Cronbach alpha
#   Table A3.7: gender counts and gender-specific burnout means

# ____________________-----
# Define OLBI burnout items -----

##* 1) Positive-worded OLBI items -----

olbi_rev <- c(
  "S_E8", "S_E10", "S_E12", "S_E13",
  "S_E14", "S_E17", "S_E20", "S_E21"
)


##* 2) Negative-worded OLBI items -----

olbi_dir <- c(
  "S_E6", "S_E7", "S_E9", "S_E11",
  "S_E15", "S_E16", "S_E18", "S_E19"
)


# ____________________-----
# Confirm sample size and burnout items -----

##* 1) Check total number of respondents -----

n_HRSA_PUF <- nrow(dt_HRSA)


##* 2) Check that all 16 burnout items are present -----

olbi_all <- c(olbi_rev, olbi_dir)

olbi_items_present <- olbi_all %in% names(dt_HRSA)


dt_HRSA_sample_validation <- data.frame(
  Measure = c(
    "Total respondents",
    "Burnout items present"
  ),
  PUF = c(
    n_HRSA_PUF,
    sum(olbi_items_present)
  ),
  HRSA_report = c(
    52568,
    16
  )
)

# ____________________-----
# Examine individual burnout items -----

##* 1) Calculate released and all-item-reversed means -----

dt_HRSA_OLBI_item_check <- data.table::rbindlist(
  lapply(
    paste0("S_E", 6:21),
    function(item) {

      x <- dt_HRSA[[item]]

      data.table::data.table(
        Item = item,
        Item_wording = ifelse(
          item %in% olbi_rev,
          "Positive-worded",
          "Negative-worded"
        ),
        N = sum(!is.na(x)),
        PUF_released_mean = mean(x, na.rm = TRUE),
        Mean_after_7_minus_response = mean(7 - x, na.rm = TRUE)
      )
    }
  )
)


##* 2) Round item means for display -----

dt_HRSA_OLBI_item_check[
  ,
  c(
    "PUF_released_mean",
    "Mean_after_7_minus_response"
  ) := lapply(.SD, round, 3),
  .SDcols = c(
    "PUF_released_mean",
    "Mean_after_7_minus_response"
  )
]


# ____________________-----
# Construct OLBI burnout score -----

# The HRSA codebook did not make the released PUF scoring direction clear.
# The following three plausible strategies were tested but did not reproduce
# the OLBI summary statistics in the published HRSA National Data Report.
# They are retained here for transparency but are deliberately disabled.
#
# if (FALSE) is used instead of if (1 == 2) because it states the intent
# directly to readers: keep this code visible, but do not execute it.


##* 1) Unsuccessful strategy: use released PUF values without reversal -----

if (FALSE) {

  # Disabled: this strategy did not create OLBI scores that matched
  # the published PDF summary report.

  mat_OLBI_scored <- as.matrix(
    dt_HRSA[, c(olbi_rev, olbi_dir), with = FALSE]
  )
}


##* 2) Unsuccessful strategy: reverse positive-worded items only -----

if (FALSE) {

  # Disabled: this conventional OLBI strategy did not create OLBI scores
  # that matched the published PDF summary report.

  mat_OLBI_scored <- cbind(
    7 - as.matrix(
      dt_HRSA[, olbi_rev, with = FALSE]
    ),
    as.matrix(
      dt_HRSA[, olbi_dir, with = FALSE]
    )
  )
}


##* 3) Unsuccessful strategy: reverse negative-worded items only -----

if (FALSE) {

  # Disabled: reversing the opposite item set also did not create OLBI
  # scores that matched the published PDF summary report.

  mat_OLBI_scored <- cbind(
    as.matrix(
      dt_HRSA[, olbi_rev, with = FALSE]
    ),
    7 - as.matrix(
      dt_HRSA[, olbi_dir, with = FALSE]
    )
  )
}


##* 4) Successful strategy: reverse all 16 released PUF item values -----

# This transformation reproduced the published overall OLBI mean,
# gender-specific means, SD, and Cronbach alpha within rounding.

mat_OLBI_scored <- 7 - as.matrix(
  dt_HRSA[, c(olbi_rev, olbi_dir), with = FALSE]
)


##* 5) Calculate number of answered burnout items -----

n_OLBI_answered <- rowSums(
  !is.na(mat_OLBI_scored)
)


##* 6) Calculate respondent mean score -----

dt_HRSA[, OLBI_mean_score :=
          rowMeans(
            mat_OLBI_scored,
            na.rm = TRUE
          )
]


##* 7) Apply HRSA two-thirds completion criterion -----

# At least 11 of 16 items must be answered.

dt_HRSA[
  n_OLBI_answered < 11,
  OLBI_mean_score := NA_real_
]


# ____________________-----
# Calculate Cronbach alpha -----

##* 1) Restrict alpha calculation to complete item responses -----

mat_OLBI_complete <- mat_OLBI_scored[
  complete.cases(mat_OLBI_scored),
  ,
  drop = FALSE
]


##* 2) Calculate item and total-score variances -----

n_OLBI_items <- ncol(mat_OLBI_complete)

var_OLBI_items <- apply(
  mat_OLBI_complete,
  2,
  var
)

var_OLBI_total <- var(
  rowSums(mat_OLBI_complete)
)


##* 3) Calculate Cronbach alpha -----

alpha_OLBI <- (
  n_OLBI_items /
    (n_OLBI_items - 1)
) * (
  1 -
    sum(var_OLBI_items) /
    var_OLBI_total
)


# ____________________-----
# Compare overall burnout statistics with report -----

##* 1) Create validation table -----

dt_HRSA_burnout_validation <- data.frame(
  Statistic = c(
    "Total respondents",
    "Valid burnout scores",
    "Complete cases for alpha",
    "Burnout mean",
    "Burnout SD",
    "Cronbach alpha"
  ),
  PUF = c(
    nrow(dt_HRSA),
    sum(!is.na(dt_HRSA$OLBI_mean_score)),
    nrow(mat_OLBI_complete),
    mean(
      dt_HRSA$OLBI_mean_score,
      na.rm = TRUE
    ),
    sd(
      dt_HRSA$OLBI_mean_score,
      na.rm = TRUE
    ),
    alpha_OLBI
  ),
  HRSA_report = c(
    52568,
    NA,
    NA,
    3.01,
    0.85,
    0.92
  )
)




# ____________________-----
# Reconcile gender counts -----

##* 1) Published gender counts from Table A3.7 -----

# Published categories:
# Male                                  7,473
# Female                               44,045
# Female-to-Male                           43
# Male-to-Female                           35
# Neither exclusively male nor female    177
# Something else                          169
# Don't know/not sure                     394

n_report_male <- 7473

n_report_nonmale <- sum(
  44045,
  43,
  35,
  177,
  169,
  394
)

n_report_missing <- 52568 -
  n_report_male -
  n_report_nonmale


##* 2) Obtain PUF gender counts -----

gender_character <- as.character(
  dt_HRSA$D_REC_GenderCat2
)

n_PUF_male <- sum(
  gender_character == "1",
  na.rm = TRUE
)

n_PUF_nonmale <- sum(
  gender_character == "2",
  na.rm = TRUE
)

n_PUF_missing <- nrow(dt_HRSA) -
  n_PUF_male -
  n_PUF_nonmale


##* 3) Compare PUF with published counts -----

dt_HRSA_gender_counts <- data.frame(
  Gender_group = c(
    "Male",
    "Non-male",
    "Missing / suppressed",
    "Total"
  ),
  HRSA_report = c(
    n_report_male,
    n_report_nonmale,
    n_report_missing,
    52568
  ),
  PUF = c(
    n_PUF_male,
    n_PUF_nonmale,
    n_PUF_missing,
    nrow(dt_HRSA)
  )
)


##* 4) Calculate differences -----

dt_HRSA_gender_counts$Difference_PUF_minus_report <-
  dt_HRSA_gender_counts$PUF -
  dt_HRSA_gender_counts$HRSA_report


# ____________________-----
# Calculate burnout scores by PUF gender -----

##* 1) Summarize burnout within each PUF gender group -----

dt_HRSA_OLBI_gender <- dt_HRSA[
  ,
  .(
    N_total = .N,
    N_OLBI = sum(
      !is.na(OLBI_mean_score)
    ),
    Mean = mean(
      OLBI_mean_score,
      na.rm = TRUE
    ),
    SD = sd(
      OLBI_mean_score,
      na.rm = TRUE
    )
  ),
  by = D_REC_GenderCat2
]


##* 2) Add readable gender labels -----

dt_HRSA_OLBI_gender[
  ,
  Gender := data.table::fifelse(
    as.character(D_REC_GenderCat2) == "1",
    "Male",
    data.table::fifelse(
      as.character(D_REC_GenderCat2) == "2",
      "Non-male",
      "Missing / suppressed"
    )
  )
]


##* 3) Arrange columns -----

dt_HRSA_OLBI_gender <- dt_HRSA_OLBI_gender[
  ,
  .(
    Gender,
    N_total,
    N_OLBI,
    Mean,
    SD
  )
]


# ____________________-----
# Compare gender-specific burnout with published report -----

##* 1) Calculate approximate published non-male mean -----

# Table A3.7 reports each non-male category separately.
# This weighted value is approximate because the published
# category means are rounded to two decimal places.

report_nonmale_counts <- c(
  44045,
  43,
  35,
  177,
  169,
  394
)

report_nonmale_means <- c(
  3.01,
  3.05,
  3.24,
  3.55,
  3.62,
  3.51
)

report_nonmale_mean <- weighted.mean(
  report_nonmale_means,
  report_nonmale_counts
)


##* 2) Extract PUF gender means -----

PUF_male_mean <- mean(
  dt_HRSA$OLBI_mean_score[
    gender_character == "1"
  ],
  na.rm = TRUE
)

PUF_nonmale_mean <- mean(
  dt_HRSA$OLBI_mean_score[
    gender_character == "2"
  ],
  na.rm = TRUE
)


##* 3) Create gender burnout comparison -----

dt_HRSA_gender_burnout_validation <- data.frame(
  Gender_group = c(
    "Male",
    "Non-male"
  ),
  PUF_mean = c(
    PUF_male_mean,
    PUF_nonmale_mean
  ),
  HRSA_report_mean = c(
    2.93,
    report_nonmale_mean
  )
)

# ____________________-----
# Quantify apparent gender suppression -----

##* 1) Calculate changes in classifications -----

n_male_removed <- n_report_male -
  n_PUF_male

n_nonmale_removed <- n_report_nonmale -
  n_PUF_nonmale

n_missing_added <- n_PUF_missing -
  n_report_missing


##* 2) Display suppression arithmetic -----

dt_HRSA_gender_suppression <- data.frame(
  Finding = c(
    "Fewer male classifications in PUF",
    "Fewer non-male classifications in PUF",
    "Additional missing/suppressed classifications",
    "Male + non-male reductions"
  ),
  N = c(
    n_male_removed,
    n_nonmale_removed,
    n_missing_added,
    n_male_removed + n_nonmale_removed
  )
)

# ____________________-----
# Display HRSA validation results as a webpage -----

##* 1) Function to convert a data frame to HTML -----

function_df_to_html <- function(
    df,
    caption = NULL,
    footer = NULL,
    table_class = NULL
) {

  # Escape HTML-sensitive characters in ordinary table content.
  escape_html <- function(x) {
    x <- as.character(x)
    x <- gsub("&", "&amp;", x, fixed = TRUE)
    x <- gsub("<", "&lt;", x, fixed = TRUE)
    x <- gsub(">", "&gt;", x, fixed = TRUE)
    x
  }

  df_display <- as.data.frame(df, stringsAsFactors = FALSE)

  # Format numeric values without scientific notation.
  df_display[] <- lapply(
    df_display,
    function(x) {
      if (is.numeric(x)) {
        ifelse(
          is.na(x),
          "",
          format(
            round(x, 3),
            trim = TRUE,
            scientific = FALSE
          )
        )
      } else {
        ifelse(
          is.na(x),
          "",
          escape_html(x)
        )
      }
    }
  )

  header_html <- paste0(
    "<tr>",
    paste0(
      "<th>",
      escape_html(names(df_display)),
      "</th>",
      collapse = ""
    ),
    "</tr>"
  )

  rows_html <- apply(
    df_display,
    1,
    function(x) {
      paste0(
        "<tr>",
        paste0(
          "<td>",
          x,
          "</td>",
          collapse = ""
        ),
        "</tr>"
      )
    }
  )

  caption_html <- if (!is.null(caption)) {
    paste0(
      "<h2>",
      escape_html(caption),
      "</h2>"
    )
  } else {
    ""
  }

  footer_html <- if (!is.null(footer)) {
    paste0(
      "<div class='footer'>",
      escape_html(footer),
      "</div>"
    )
  } else {
    ""
  }

  class_html <- if (!is.null(table_class)) {
    paste0(" class='", table_class, "'")
  } else {
    ""
  }

  paste0(
    "<div class='table-section'>",
    caption_html,
    "<table",
    class_html,
    ">",
    "<thead>",
    header_html,
    "</thead>",
    "<tbody>",
    paste0(rows_html, collapse = ""),
    "</tbody>",
    "</table>",
    footer_html,
    "</div>"
  )
}


##* 2) Create webpage display tables -----

# Table 1: use the same report-first organization as the GitHub page.
dt_HRSA_sample_validation_display <- data.frame(
  Measure = c(
    "Oldenburg Burnout Items (OLBI) present",
    "Total respondents"
  ),
  `HRSA National Data Report (PDF file)` = c(
    16,
    52568
  ),
  `CSV data file (PUF, Public Use File)` = c(
    sum(olbi_items_present),
    n_HRSA_PUF
  ),
  check.names = FALSE
)


# Table 2: gender counts and PUF-minus-report differences.
dt_HRSA_gender_counts_display <- data.frame(
  `Gender group` = dt_HRSA_gender_counts$Gender_group,
  `HRSA National Data Report (PDF file)` = dt_HRSA_gender_counts$HRSA_report,
  `CSV data file (PUF, Public Use File)` = dt_HRSA_gender_counts$PUF,
  `Difference: PUF minus report` =
    dt_HRSA_gender_counts$Difference_PUF_minus_report,
  check.names = FALSE
)


# Table 3: overall OLBI validation.
dt_HRSA_burnout_validation_display <- data.frame(
  Statistic = c(
    "Mean",
    "SD",
    "Cronbach alpha"
  ),
  `HRSA National Data Report (PDF file)` = c(
    "3.01",
    "0.85",
    "0.92"
  ),
  `CSV data file (PUF, Public Use File)` = c(
    sprintf(
      "%.3f",
      mean(
        dt_HRSA$OLBI_mean_score,
        na.rm = TRUE
      )
    ),
    sprintf(
      "%.3f",
      sd(
        dt_HRSA$OLBI_mean_score,
        na.rm = TRUE
      )
    ),
    sprintf(
      "%.3f",
      alpha_OLBI
    )
  ),
  check.names = FALSE
)


# Table 4: gender-specific OLBI means.
dt_HRSA_gender_burnout_display <- data.frame(
  `Gender group` = c(
    "Male",
    "Non-male"
  ),
  `HRSA National Data Report (PDF file)` = c(
    "2.93",
    paste0(
      "~",
      sprintf("%.3f", report_nonmale_mean),
      "*"
    )
  ),
  `CSV data file (PUF, Public Use File)` = c(
    sprintf("%.3f", PUF_male_mean),
    sprintf("%.3f", PUF_nonmale_mean)
  ),
  check.names = FALSE
)


# Table 5: detailed PUF results by gender.
dt_HRSA_OLBI_gender_display <- as.data.frame(
  dt_HRSA_OLBI_gender,
  stringsAsFactors = FALSE
)

gender_order <- match(
  c(
    "Male",
    "Non-male",
    "Missing / suppressed"
  ),
  dt_HRSA_OLBI_gender_display$Gender
)

dt_HRSA_OLBI_gender_display <-
  dt_HRSA_OLBI_gender_display[
    gender_order[
      !is.na(gender_order)
    ],
    ,
    drop = FALSE
  ]

names(dt_HRSA_OLBI_gender_display) <- c(
  "Gender group",
  "Total respondents",
  "Respondents with OLBI data",
  "Mean",
  "SD"
)


##* 3) Assemble webpage tables -----

html_tables <- paste0(

  function_df_to_html(
    dt_HRSA_sample_validation_display,
    caption = "1. Sample size and burnout-item counts comparison",
    table_class = "table-standard"
  ),

  function_df_to_html(
    dt_HRSA_gender_counts_display,
    caption = "2. Gender counts comparison",
    table_class = "table-standard gender-counts"
  ),

  function_df_to_html(
    dt_HRSA_burnout_validation_display,
    caption = "3. Overall burnout validation",
    table_class = "table-standard"
  ),

  function_df_to_html(
    dt_HRSA_gender_burnout_display,
    caption = "4. Burnout by gender comparison",
    footer = paste0(
      "*Approximate weighted mean of the published non-male ",
      "gender categories; published category means were rounded."
    ),
    table_class = "table-standard"
  ),

  function_df_to_html(
    dt_HRSA_OLBI_gender_display,
    caption = "5. Detailed CSV burnout results by gender",
    table_class = "table-detailed"
  )
)


##* 4) Build webpage -----

html_page <- paste0(
  "<!DOCTYPE html>",
  "<html>",
  "<head>",
  "<meta charset='UTF-8'>",
  "<meta name='viewport' content='width=device-width, initial-scale=1'>",

  "<style>",

  "body {",
  "  font-family: Arial, sans-serif;",
  "  margin: 24px;",
  "  color: #222;",
  "  max-width: 1200px;",
  "}",

  "h1 {",
  "  font-size: 22px;",
  "  margin-bottom: 24px;",
  "}",

  "h2 {",
  "  font-size: 16px;",
  "  margin-top: 28px;",
  "  margin-bottom: 8px;",
  "}",

  "table {",
  "  border-collapse: collapse;",
  "  width: auto;",
  "  margin-bottom: 6px;",
  "}",

  "th {",
  "  font-weight: bold;",
  "  text-align: left;",
  "  padding: 7px 12px;",
  "  border-bottom: 2px solid #999;",
  "  vertical-align: bottom;",
  "}",

  "td {",
  "  padding: 7px 12px;",
  "  border-bottom: 1px solid #ddd;",
  "}",

  "td:not(:first-child),",
  "th:not(:first-child) {",
  "  text-align: right;",
  "}",

  ".table-standard th:nth-child(1),",
  ".table-standard td:nth-child(1),",
  ".table-detailed th:nth-child(1),",
  ".table-detailed td:nth-child(1) {",
  "  width: 300px;",
  "  min-width: 300px;",
  "  max-width: 300px;",
  "}",

  ".table-standard th:nth-child(2),",
  ".table-standard td:nth-child(2),",
  ".table-standard th:nth-child(3),",
  ".table-standard td:nth-child(3),",
  ".table-detailed th:nth-child(2),",
  ".table-detailed td:nth-child(2),",
  ".table-detailed th:nth-child(3),",
  ".table-detailed td:nth-child(3) {",
  "  width: 220px;",
  "  min-width: 220px;",
  "  max-width: 220px;",
  "}",

  ".gender-counts th:nth-child(4),",
  ".gender-counts td:nth-child(4),",
  ".table-detailed th:nth-child(4),",
  ".table-detailed td:nth-child(4),",
  ".table-detailed th:nth-child(5),",
  ".table-detailed td:nth-child(5) {",
  "  width: 180px;",
  "  min-width: 180px;",
  "  max-width: 180px;",
  "}",

  ".gender-counts tbody tr:not(:last-child) td:nth-child(3),",
  ".gender-counts tbody tr:not(:last-child) td:nth-child(4) {",
  "  color: red;",
  "  font-weight: bold;",
  "}",

  ".table-section {",
  "  margin-bottom: 30px;",
  "}",

  ".footer {",
  "  margin-top: 7px;",
  "  font-size: 12px;",
  "  font-style: italic;",
  "}",

  "</style>",
  "</head>",

  "<body>",

  "<h1>",
  "HRSA PUF validation against published report",
  "</h1>",

  html_tables,

  "</body>",
  "</html>"
)


##* 5) Save and display webpage -----

# Save a stable copy in the working directory so the output can be
# inspected in a browser or published alongside the analysis code.

var_HRSA_validation_html <- file.path(
  getwd(),
  "HRSA_validation_results.html"
)

writeLines(
  html_page,
  var_HRSA_validation_html
)

viewer <- getOption("viewer")

if (!is.null(viewer)) {
  viewer(var_HRSA_validation_html)
} else {
  utils::browseURL(var_HRSA_validation_html)
}
