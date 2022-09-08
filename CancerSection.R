```{r FINGERTIPS_CANCER, eval=FALSE, include=FALSE}
fingertips_cancer <- fingertips_data(IndicatorID = c(92600,91339,93725,93726,91355,91356), AreaTypeID = "All", AreaCode = c(code,'E38000150','E92000001'))

FingertipsYear <- '2020/21'

fingertips_cancer <- fingertips_cancer %>% 
  filter(`Timeperiod` == '2020/21',
         `AreaType` %in% c('GP', 'England','CCGs (from Apr 2021)')) %>% 
  select(`IndicatorName`, `AreaName`, `Value`) %>% 
  unique() %>% 
  mutate(Value = round(Value,0)) %>% 
  pivot_wider(names_from = AreaName, values_from = Value)
```




<!-- ## Cancer Screening  -->
  
  <!-- Results for the Financial Year `r FingertipsYear` (latest available). -->
  
  ```{r CancerScreening, eval=FALSE, include=FALSE}
kable(
  fingertips_cancer %>% select(1, 4, 3, 2) %>%  arrange(`England`),
  col.names = c("Indicator", "Practice", "CCG", "England"),
  format = "latex",
  booktabs = T,
  align = "l",
  linesep = ""
) %>%
  kable_styling(latex_options = c("striped"), position = "left") %>%
  row_spec(0,
           bold = T) 
```

<!-- Cancer screening data is sourced from Fingertips. -->
  <!-- \href{https://fingertips.phe.org.uk/profile/cancerservices}{{\color{blue}{\underline{https://fingertips.phe.org.uk/profile/cancerservices}}}} -->
  