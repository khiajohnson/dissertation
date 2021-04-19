Linear mixed model fit by REML. t-tests use Satterthwaite's method ['lmerModLmerTest']
Formula: vot_centered ~ 1 + segment * language + avg_phone_dur_z + is_post_pausal +      (segment * language | talker) + (1 | word)
   Data: df
Control: lmerControl(optimizer = "optimx", calc.derivs = FALSE, optCtrl = list(method = "nlminb",      starttests = FALSE, kkt = FALSE))

REML criterion at convergence: 83473

Scaled residuals: 
    Min      1Q  Median      3Q     Max 
-3.6760 -0.6253 -0.0538  0.5756  4.2056 

Random effects:
 Groups   Name                     Variance Std.Dev. Corr                         
 word     (Intercept)              131.122  11.451                                
 talker   (Intercept)               37.296   6.107                                
          segmentk                   3.242   1.800    0.30                        
          segmentt                   7.620   2.761   -0.47 -0.93                  
          languageEnglish            3.099   1.760    0.26 -0.07  0.24            
          segmentk:languageEnglish   1.064   1.032   -0.53 -0.10  0.09 -0.12      
          segmentt:languageEnglish   2.334   1.528    0.37  0.08  0.01  0.13 -0.98
 Residual                          359.556  18.962                                
Number of obs: 9458, groups:  word, 912; talker, 34

Fixed effects:
                           Estimate Std. Error         df t value Pr(>|t|)    
(Intercept)                 3.62149    1.22210   55.76379   2.963  0.00447 ** 
segmentk                   -1.08935    0.64526  223.88394  -1.688  0.09276 .  
segmentt                    1.90788    0.99502  212.54893   1.917  0.05652 .  
languageEnglish             2.81140    0.59413  226.26043   4.732 3.92e-06 ***
avg_phone_dur_z             7.75443    0.22641 9240.26624  34.249  < 2e-16 ***
is_post_pausalTRUE          2.96226    0.37879 9097.65583   7.820 5.85e-15 ***
segmentk:languageEnglish    0.69769    0.48981  361.54396   1.424  0.15519    
segmentt:languageEnglish    0.08203    0.71626  321.75050   0.115  0.90889    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Correlation of Fixed Effects:
            (Intr) sgmntk sgmntt lnggEn avg___ i__TRU sgmntk:E
segmentk     0.260                                            
segmentt    -0.271 -0.836                                     
langgEnglsh -0.003 -0.243  0.285                              
avg_phn_dr_ -0.034  0.030 -0.029 -0.024                       
is_pst_TRUE -0.003  0.002  0.004  0.032 -0.080                
sgmntk:lngE -0.311 -0.208  0.089  0.318  0.007  0.000         
sgmntt:lngE  0.270  0.092 -0.023 -0.238 -0.009 -0.003 -0.826  
optimizer (optimx) convergence code: 1 (none)

$emmeans
segment = k:
 language  emmean   SE    df lower.CL upper.CL
 Cantonese  -2.61 2.44 226.1   -7.416     2.19
 English     7.05 1.56  77.5    3.942    10.15

segment = t:
 language  emmean   SE    df lower.CL upper.CL
 Cantonese   1.46 1.60 194.8   -1.683     4.61
 English     9.43 1.82 107.6    5.825    13.03

segment = p:
 language  emmean   SE    df lower.CL upper.CL
 Cantonese   4.14 2.52 170.8   -0.828     9.12
 English     4.96 1.91  73.4    1.144     8.77

Results are averaged over the levels of: is_post_pausal 
Degrees-of-freedom method: kenward-roger 
Confidence level used: 0.95 

$contrasts
segment = k:
 contrast            estimate   SE  df t.ratio p.value
 Cantonese - English   -9.656 2.43 427 -3.972  0.0001 

segment = t:
 contrast            estimate   SE  df t.ratio p.value
 Cantonese - English   -7.962 2.25 183 -3.536  0.0005 

segment = p:
 contrast            estimate   SE  df t.ratio p.value
 Cantonese - English   -0.813 2.78 215 -0.293  0.7699 

Results are averaged over the levels of: is_post_pausal 
Degrees-of-freedom method: kenward-roger 