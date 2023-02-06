wbopendata, indicator(si.pov.dday ) clear long


drop if  si_pov_dday == .

sort  countryname year

bysort  countryname : gen diff_pov = (si_pov_dday-si_pov_dday[_n-1])/(year-year[_n-1])

encode region, gen(reg)

gen ctry_chl = countryname + " " + string(year[_n-1]) + "-" + string(year)  if countrycode == "CHL"

encode ctry_chl, gen(ctry)



drop if regionname == "Aggregates"



alorenz diff_pov, gp points(300) xdecrease markvar(ctry)               ///
        ytitle("Change in Poverty (p.p.)") xtitle("Proportion of regional episodes of poverty reduction (%)")   ///
        legend(off) title("Poverty Reduction")                                            ///
        legend(off) note("Source: World Development Indicators using Azevedo, J.P. (2011) wbopendata: Stata module to " "access World Bank databases, Statistical Software Components S457234 Boston College Department of Economics.", size(*.7))

