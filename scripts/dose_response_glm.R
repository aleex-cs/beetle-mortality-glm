# Load grouped beetle mortality data
beetle_grouped <- read.csv("data/beetle-grouped.txt", sep = "")

# Plot proportion of deaths vs log dose
plot(beetle_grouped$logdose, beetle_grouped$dead / beetle_grouped$n,
     xlab = "Log Dose",
     ylab = "Proportion Dead",
     main = "Observed Mortality vs Log Dose")

# Fit GLMs with different link functions
model_logit  <- glm(cbind(dead, n - dead) ~ logdose,
                    family = binomial(link = "logit"), data = beetle_grouped)

model_probit <- glm(cbind(dead, n - dead) ~ logdose,
                    family = binomial(link = "probit"), data = beetle_grouped)

model_cloglog <- glm(cbind(dead, n - dead) ~ logdose,
                     family = binomial(link = "cloglog"), data = beetle_grouped)

# Add fitted curves to the plot
x_plot <- seq(1.6, 2, length = 500)
lines(x_plot, predict(model_logit,
                      newdata = data.frame(logdose = x_plot),
                      type = "response"), col = "red")
lines(x_plot, predict(model_probit,
                      newdata = data.frame(logdose = x_plot),
                      type = "response"), col = "green")
lines(x_plot, predict(model_cloglog,
                      newdata = data.frame(logdose = x_plot),
                      type = "response"), col = "blue")

# Correlations between observed proportions and fitted values
cor(beetle_grouped$dead / beetle_grouped$n, fitted(model_logit))
cor(beetle_grouped$dead / beetle_grouped$n, fitted(model_probit))
cor(beetle_grouped$dead / beetle_grouped$n, fitted(model_cloglog))
