# HRSA-Health-Center-Workforce-Well-being-2022
Validity assessment of the HRSA data compared to thee HRSA public report

Short URL: [https://EBMgt.github.io/HRSA-Well-being](https://EBMgt.github.io/HRSA-Well-being)

## Summary of assessment of validity:
* The data in the HRSA CSV file, compared to the summary report in the HRSA PDF file, have matching number of total respondents to the 2022 survey; however,
 * The number of respondents by gender differ
 * The mean Copenhagen Burnout Inventory (CBI) scores by gender vary
 * The values for the burnout means, standard deviations, and Chronbach alpha all have important discrepancies between the data file and the report.
* Conclusion. the publically available data file is invalid to use for analysis of the presence of a Simpson-like paradox in the rates of burnout at the individual versus group level.

<h3>1. Sample size and burnout-item counts comparison</h3>

<table>
  <thead>
    <tr>
      <th width="300">Measure</th>
      <th width="220" align="right">HRSA National Data Report:<br>(PDF file)</th>
      <th width="220" align="right">CSV data file<br>(PUF, Public Use File)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Copenhagen Burnout Items (CBI) present</td>
      <td align="right">16</td>
      <td align="right">16</td>
    </tr>
    <tr>
      <td>Total respondents</td>
      <td align="right">52568</td>
      <td align="right">52568</td>
    </tr>
  </tbody>
</table>

<h3>2. Gender counts comparison</h3>

<table>
  <thead>
    <tr>
      <th width="300">Gender group</th>
      <th width="220" align="right">HRSA National Data Report:<br>(PDF file)</th>
      <th width="220" align="right">CSV data file<br>(PUF, Public Use File)</th>
      <th width="180" align="right">Difference<br>PUF minus report</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Male</td>
      <td align="right">7473</td>
      <td align="right">7384</td>
      <td align="right">-89</td>
    </tr>
    <tr>
      <td>Non-male</td>
      <td align="right">44863</td>
      <td align="right">44773</td>
      <td align="right">-90</td>
    </tr>
    <tr>
      <td>Missing / suppressed</td>
      <td align="right">232</td>
      <td align="right">411</td>
      <td align="right">179</td>
    </tr>
    <tr>
      <td>Total</td>
      <td align="right">52568</td>
      <td align="right">52568</td>
      <td align="right">0</td>
    </tr>
  </tbody>
</table>

## HRSA files:
* Original locations
  * https://data.hrsa.gov/data/dashboards
  * * [Health Center Workforce Well-being Survey](https://data.hrsa.gov/topics/health-centers/workforce-well-being) (gives file not found error after successful retrieval of [January 23, 2025](https://web.archive.org/web/20250123185618/))
* Wayback Machine (Internet Archive)
  * https://web.archive.org/web/20260000000000*/https://data.hrsa.gov/data/dashboards
  * * https://web.archive.org/web/20250123185618/https://data.hrsa.gov/topics/health-centers/workforce-well-being (archive date January 23, 2025)
* Copies in this repository
  * [Files-HRSA](../master/Files-HRSA)

## Validity assessment of datafiles and R code (do they reproduce values in the 2022 report):
* 

[Edit this page](../../edit/master/README.md) - [History](../../commits/master/README.md)  - 
[Issues and comments](../../issues?q=is%3Aboth+is%3Aissue)
