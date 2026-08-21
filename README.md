# HRSA-Health-Center-Workforce-Well-being-2022
Validity assessment of the HRSA data compared to thee HRSA public report

Short URL: [https://EBMgt.github.io/HRSA-Well-being](https://EBMgt.github.io/HRSA-Well-being)

## Summary of assessment of validity:

* The HRSA CSV Public Use File (PUF) and the 2022 HRSA National Data Report contain the same total number of respondents (52,568) after restricting the PUF to `Grouping = "Nat_Demog"`. The PUF is a stacked dataset in which each respondent has two randomly located records, one record with demographics and the other with job descriptions.

* The numbers of respondents classified by gender differ between the PUF and the published report: the PUF contains 89 fewer males, 90 fewer non-males, and 179 more missing/suppressed gender classifications. If these differences represent reclassification of those respondents, **179 of 52,568 respondents (0.34%)** had their gender classification changed or suppressed in the PUF.

* The scoring transformation that reproduces the HRSA results was not clear in the HRSA codebook and was identified by testing alternative combinations of OLBI item direction and 1–6 Likert-response direction against the published summary statistics. Reversing **all 16 released PUF OLBI item values (`7 − response`)** reproduces the published overall burnout mean, gender-specific means, standard deviations, and Cronbach alpha within roundings.

* **Conclusion:** The PUF reproduces the published OLBI results, but its gender classification does not exactly reproduce the published gender counts. Consequently, analyses that depend on the PUF gender variable—particularly analyses of gender composition within organizational or geographic strata—should be interpreted cautiously until the reason for the discrepancy is established.

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
      <td>Oldenburg Burnout Items (OLBI) present</td>
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
      <th width="220" align="right">CSV data file*<br>(PUF, Public Use File)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Mean</td>
      <td align="right">3.01</td>
      <td align="right">3.007</td>
    </tr>
    <tr>
      <td>SD</td>
      <td align="right">0.85</td>
      <td align="right">0.854</td>
    </tr>
    <tr>
      <td>Cronbach alpha</td>
      <td align="right">0.92</td>
      <td align="right">0.913</td>
    </tr>
  </tbody>
</table>

<h3>4. Burnout by gender comparison</h3>

<table>
  <thead>
    <tr>
      <th width="300">Gender group</th>
      <th width="220" align="right">HRSA National Data Report:<br>(PDF file)</th>
      <th width="220" align="right">CSV data file*<br>(PUF, Public Use File)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Male</td>
      <td align="right">2.93</td>
      <td align="right">2.924</td>
    </tr>
    <tr>
      <td>Non-male</td>
      <td align="right">~3.019†</td>
      <td align="right">3.019</td>
    </tr>
  </tbody>
</table>

<p><small><i>* These values are calculated after 1) all sixteen OLBI survey items have each been subtracted from 7 to reverse their values on a six point scale, then the mean of the values if the respondent answered at least eleven of the sixteen OLBI items.</i><br><i>† Approximate weighted mean of the non-male gender categories in the 2022 report PDF (<a href="../master/Files-HRSA">local copy of the report</a>); these means were rounded.</i></small></p>

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
      <td align="right">2.924</td>
      <td align="right">0.867</td>
    </tr>
    <tr>
      <td>Non-male</td>
      <td align="right">44773</td>
      <td align="right">44767</td>
      <td align="right">3.019</td>
      <td align="right">0.851</td>
    </tr>
    <tr>
      <td>Missing / suppressed</td>
      <td align="right">411</td>
      <td align="right">410</td>
      <td align="right">3.207</td>
      <td align="right">0.862</td>
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

## Validity assessment of datafiles - R code to reproduce the tables on this page:
*  [Files-R](../master/Files-R)

[Edit this page](../../edit/master/README.md) - [History](../../commits/master/README.md)  - 
[Issues and comments](../../issues?q=is%3Aboth+is%3Aissue)
