# HRSA-Health-Center-Workforce-Well-being-2022
Validity assessment of the HRSA data compared to thee HRSA public report

Short URL: [https://EBMgt.github.io/HRSA-Well-being](https://EBMgt.github.io/HRSA-Well-being)

## Summary of assessment of validity:
* The data in the HRSA CSV file, compared to the summary report in the HRSA PDF file, have matching number of total respondents to the 2022 survey; however,
 * The number of respondents by gender differ
 * The mean Copenhagen Burnout Inventory (CBI) scores by gender vary
 * The values for the burnout means, standard deviations, and Chronbach alpha all have important discrepancies between the data file and the report.
* Conclusion: the publically available data file is invalid to use for detailed analyses of the relationship between gender and burnout as the public file cannot reproduce basic, summary values of gender and burnout that were published in the 2022 PDF report.

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
      <td align="right">7473</b></td>
      <td align="right">$\color{red}{\text{\textbf{7384}}}$</td>
      <td align="right">$\color{red}{\text{\textbf{-89}}}$</td>
    </tr>
    <tr>
      <td>Non-male</td>
      <td align="right">44863</td>
      <td align="right">$\color{red}{\text{\textbf{44773}}}$</td>
      <td align="right">$\color{red}{\text{\textbf{-90}}}$</td>
    </tr>
    <tr>
      <td>Missing / suppressed</td>
      <td align="right">232</td>
      <td align="right">$\color{red}{\text{\textbf{411}}}$</td>
      <td align="right">$\color{red}{\text{\textbf{179}}}$</td>
    </tr>
    <tr>
      <td>Total</td>
      <td align="right">52568</td>
      <td align="right">52568</td>
      <td align="right">0</td>
    </tr>
  </tbody>
</table>

<h3>3. Overall burnout validation</h3>

<table>
  <thead>
    <tr>
      <th width="300">Statistic</th>
      <th width="220" align="right">HRSA National Data Report:<br>(PDF file)</th>
      <th width="220" align="right">CSV data file<br>(PUF, Public Use File)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Mean</td>
      <td align="right">$3.01</td>
      <td align="right">$\color{red}{\text{\textbf{3.203}}}$</td>
    </tr>
    <tr>
      <td>SD</td>
      <td align="right">0.85</td>
      <td align="right">$\color{red}{\text{\textbf{0.373}}}$</td>
    </tr>
    <tr>
      <td>Cronbach alpha</td>
      <td align="right">0.92</td>
      <td align="right">$\color{red}{\text{\textbf{0.255}}}$</td>
    </tr>
  </tbody>
</table>

<h3>4. Burnout by gender comparison</h3>

<table>
  <thead>
    <tr>
      <th width="300">Gender group</th>
      <th width="220" align="right">HRSA National Data Report:<br>(PDF file)</th>
      <th width="220" align="right">CSV data file<br>(PUF, Public Use File)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Male</td>
      <td align="right">2.93</td>
      <td align="right">$\color{red}{\text{\textbf{3.207}}}$</td>
    </tr>
    <tr>
      <td>Non-male</td>
      <td align="right">~3.019*</td>
      <td align="right">$\color{red}{\text{\textbf{3.202}}}$</td>
    </tr>
  </tbody>
</table>

<p><small><i>*Approximate weighted mean of the published non-male gender categories; published category means were rounded.</i></small></p>

<h3>5. Detailed CSV burnout results by gender</h3>

<table>
  <thead>
    <tr>
      <th width="300">Gender group</th>
      <th width="220" align="right">Total respondents</th>
      <th width="220" align="right">Respondents with<br>OLBI data</th>
      <th width="180" align="right">Mean</th>
      <th width="180" align="right">SD</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Male</td>
      <td align="right">7384</td>
      <td align="right">7384</td>
      <td align="right">3.207</td>
      <td align="right">0.381</td>
    </tr>
    <tr>
      <td>Non-male</td>
      <td align="right">44773</td>
      <td align="right">44767</td>
      <td align="right">3.202</td>
      <td align="right">0.372</td>
    </tr>
    <tr>
      <td>Missing / suppressed</td>
      <td align="right">411</td>
      <td align="right">410</td>
      <td align="right">3.250</td>
      <td align="right">0.378</td>
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
