library(tidyverse)
library(lubridate)
library(data.table)

meeps_per_hour_temps <- fread(file.path("data","pika","meeps_per_hour.csv"))

## bad histogram
ggplot(meeps_per_hour_temps,aes(x= Meeps ))+
  geom_histogram(color = "grey20")


## good histogram
ggplot(meeps_per_hour_temps,aes(x= Meeps,fill = device ))+
  geom_histogram(color = "grey20",boundary = 0,binwidth = 1)+
  facet_wrap(~device )+
  scale_fill_viridis_d(option = 'mako')+
  theme_classic()


## bad temp meep relationship
ggplot(data = meeps_per_hour_temps, aes(x = temp_mean, y = Meeps))+
  geom_point()+
  geom_smooth()+
  labs(x = "Temp", y = "Meeps")

## good temp meep relationship
ggplot(data = meeps_per_hour_temps, aes(x = temp_mean, y = Meeps, colour = device ))+
  geom_point()+
  geom_smooth(method = "glm",method.args = list(family = poisson()),formula = y ~ poly(x,2),fill = "grey85")+
  theme_classic()+
  labs(x = "Temp", y = "Meeps")+
  scale_color_viridis_d(option = "mako")

## time 
ggplot(data = meeps_per_hour_temps, aes(x = time_h, y = Meeps, color = device ))+
  geom_point()+
  geom_line()+
  #geom_smooth(method = "gam",fill = "grey85")+
  theme_classic()+
  labs(x = "Time", y = "Meeps")+
  scale_color_viridis_d(option = "mako")

## hour 
ggplot(data = meeps_per_hour_temps, aes(x = hour, y = Meeps, color = device ))+
  geom_point()+
  geom_smooth(method = "glm",method.args = list(family = poisson()),formula = y ~ poly(x,2),fill = "grey85")+
  theme_classic()+
  labs(x = "hour", y = "Meeps")+
  scale_color_viridis_d(option = "mako")

## day, boxplor
ggplot(data = meeps_per_hour_temps, aes(x = as.character(day), y = Meeps, fill = device ))+
  geom_boxplot()+
  theme_classic()+
  labs(x = "day", y = "Meeps")+
  scale_fill_viridis_d(option = "mako")

library(brms)

##bad model
model_meep_1 <- brm(Meeps ~ temp_mean,
                    data = meeps_per_hour_temps,
                    #backend = "cmdstanr", # only if pb
                    iter = 1500,
                    warmup = 400,
                    chains = 3,
                    cores = 3)


## mid model
model_meep_2 <- brm(Meeps ~ temp_mean + (temp_mean|device),
                    data = meeps_per_hour_temps,
                    family = poisson,
                    #backend = "cmdstanr", # only if pb
                    iter = 1000,
                    warmup = 200,
                    chains = 3,
                    cores = 3)

## good model
meeps_per_hour_temps$tim_h_char <- as.character(meeps_per_hour_temps$time_h)
model_meep_3 <- brm(Meeps ~ poly(temp_mean,2) + (poly(temp_mean,2)|device)  +(1|tim_h_char),
                    data = meeps_per_hour_temps,
                    family = negbinomial,
                    #backend = "cmdstanr", # only if pb
                    iter = 1000,
                    warmup = 200,
                    chains = 3,
                    cores = 3,
                    init = 0 )


pp_check(model_meep_3)
summary(model_meep_3)
plot(model_meep_3)

## predicting device level predictions
prediction <- fitted(model_meep_3,new=meeps_per_hour_temps,re_formula = ~ (poly(temp_mean,2)|device) )
prediction <- cbind(meeps_per_hour_temps,prediction)

## predicting the global/popualtion/marginal effect
global_effect <- fitted(model_meep_3,new=meeps_per_hour_temps,re_formula = NA ) 
global_effect <- cbind(meeps_per_hour_temps,global_effect)

## The device - specific prediction
ggplot(data = prediction, aes(x = temp_mean, y = Meeps, colour = device , fill = device))+
  geom_point()+
  geom_ribbon(aes( ymin = Q2.5, ymax = Q97.5 ),color = NA, alpha = 0.25)+
  geom_line(aes( y = Estimate))+
  theme_classic()+
  labs(x = "Temp", y = "Meeps")+
  scale_color_viridis_d(option = "mako")+
  scale_fill_viridis_d(option = "mako")

## The global effect - specific prediction
ggplot(data = global_effect, aes(x = temp_mean, y = Meeps, colour = device , fill = device))+
  geom_point()+
  geom_ribbon(aes( ymin = Q2.5, ymax = Q97.5 ),fill = "grey60",color = NA, alpha = 0.25)+
  geom_line(aes( y = Estimate),color = "blue",lwd = 1)+
  theme_classic()+
  labs(x = "Temp", y = "Meeps")+
  scale_color_viridis_d(option = "mako")+
  scale_fill_viridis_d(option = "mako")

## model reflexion: use a zero inflated distribution? 
