# Load grouped beetle mortality data
dose        <- c(1, 2, 4, 8, 16, 32)   # ml/l
male_dead   <- c(1, 4, 9, 13, 18, 20)
female_dead <- c(0, 2, 6, 10, 12, 16)

dose_rep   <- rep(dose, 2)
log2_dose  <- log2(dose_rep)

# b) Fit model with sex as a binary predictor
response1 <- cbind(c(male_dead, female_dead),
                   20 - c(male_dead, female_dead))
sex1 <- rep(c("male", "female"), each = 6)

model_sex <- glm(response1 ~ sex1, family = binomial)
summary(model_sex)

# c) Fit model on aggregated totals
response2 <- cbind(c(sum(male_dead), sum(female_dead)),
                   20 * 6 - c(sum(male_dead), sum(female_dead)))
sex2 <- unique(sex1)

model_sex_total <- glm(response2 ~ sex2, family = binomial)
summary(model_sex_total)

# d) Dose effect ignoring sex
model_dose_full <- glm(response1 ~ log2_dose, family = binomial)
summary(model_dose_full)

response3 <- cbind(male_dead + female_dead, 40 - (male_dead + female_dead))
model_dose_collapsed <- glm(response3 ~ log2_dose[1:6], family = binomial)
summary(model_dose_collapsed)

# e) Add both predictors: sex + dose
model_additive <- glm(response1 ~ sex1 + log2_dose, family = binomial)
summary(model_additive)

# f) Full interaction model
model_interaction <- glm(response1 ~ sex1 * log2_dose, family = binomial)
summary(model_interaction)

# g) Compare models
AIC(model_sex, model_dose_full, model_additive, model_interaction)
anova(model_sex, model_dose_full, model_additive, model_interaction)

# h) Confidence intervals, weights, and diagnostics
beta <- coef(model_additive)
beta_vcov <- vcov(model_additive)
se <- sqrt(diag(beta_vcov))

# Confidence intervals (Wald)
cbind(beta - se * qnorm(0.975),
      beta + se * qnorm(0.975))

# Fisher Information Matrix
X <- model.matrix(model_additive)
eta <- X %*% beta
p <- 1 / (1 + exp(-eta))
W <- diag(as.numeric(p * (1 - p)))

solve(t(X) %*% W %*% X)

# Predicted probabilities and linear predictors
predict(model_additive, type = "response")
predict(model_additive, type = "link")

# Residuals
resid(model_additive)

# Dispersion estimate
deviance(model_additive) / df.residual(model_additive)
