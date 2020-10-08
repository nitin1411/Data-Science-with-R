#Hypothesis testing assignments
#1. diameter of cutlets
c <- Cutlets
mean(c$Unit.A)
sd(c$Unit.A)
mean(c$Unit.B)
sd(c$Unit.B)
t.test(c$Unit.A, c$Unit.B ,
       alternative = c("two.sided"),
       mu = 0.054794, paired = TRUE, var.equal = FALSE,
       conf.level = 0.95)



7.019091 - 6.964297
var(c$Unit.A)
var(c$Unit.B)


#TAT of laboratories
lab <- LabTAT
t.test(lab$Laboratory.1, alternative = c("two.sided"), mu = 0, paired = FALSE, var.equal = FALSE, conf.level = 0.95)
t.test(lab$Laboratory.2, alternative = c("two.sided"), mu = 0, paired = FALSE, var.equal = FALSE, conf.level = 0.95)
t.test(lab$Laboratory.3, alternative = c("two.sided"), mu = 0, paired = FALSE, var.equal = FALSE, conf.level = 0.95)
t.test(lab$Laboratory.4, alternative = c("two.sided"), mu = 0, paired = FALSE, var.equal = FALSE, conf.level = 0.95)


t.test(lab$Laboratory.1, lab$Laboratory.2, lab$Laboratory.3,lab$Laboratory.4, alternative = c("two.sided"), mu = 0, paired = TRUE, var.equal = FALSE, conf.level = 0.95)
t.test(lab$Laboratory.1, lab$Laboratory.2, lab$Laboratory.3,lab$Laboratory.4, alternative = c("two.sided"), conf.level = 0.95)

#Buyer ratio
br <- `Buyer.Ratio...Sheet1.(1)`
table(br$Male, br$Female)
chisq.test(br$Male, br$Female, correct = FALSE)


#defect in order forms





#male-female during weekday-weekend 
table(Faltoons$Weekdays, Faltoons$Weekend)
prop.test(table(Faltoons$Weekdays, Faltoons$Weekend), correct =  FALSE)






