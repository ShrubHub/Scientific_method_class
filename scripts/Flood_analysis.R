library(tidyverse)
library(data.table)
library(lubridate)
library(lme4)
library(lmerTest)

floody_times <- fread(file.path("data","flood","WELL_database2025.csv"))

# Create a list of all of the variables in flood_times
names(floody_times)

# Turn variable datetime into the variables year, month, day, hour
floody_times <- floody_times %>%
  mutate(datetime = as.POSIXct(datetime, format="%Y-%m-%d %H:%M:%S", tz="UTC")) %>%
  mutate(Year = lubridate::year(datetime),
         Month = lubridate::month(datetime),
         Day = lubridate::day(datetime),
         Hour = lubridate::hour(datetime),
         DOY = lubridate::yday(datetime))

# Reshape floody_times to long format turning tidywell, polarbear, beluga, muskox, fox, snowy into a single variable wellname with corresponding waterlevel values
floody_times_long <- floody_times %>%
  pivot_longer(
    cols = starts_with(c("wl", "height", "temp", "cond", "level")),
    names_to = c(".value", "wellname"), 
    names_sep = "_")

# Create a summary of floody_times_long of the mean wl, height, temp, cond and level per DOY
floody_times_summary <- floody_times_long %>%
  group_by(DOY, wellname) %>%
  summarize(mean_wl = mean(wl), na.rm = TRUE,
            mean_height = mean(height), na.rm = TRUE,
            mean_temp = mean(temp), na.rm = TRUE,
            mean_cond = mean(cond), na.rm = TRUE,
            mean_level = mean(level), na.rm = TRUE,
            mean_astrotide = mean(astrotide), na.rm = TRUE,
            mean_surge = mean(surge), na.rm = TRUE,
            mean_wind_direction = mean(wind_direction), na.rm = TRUE,
            mean_wind_speed = mean(wind_speed), na.rm = TRUE,
            mean_gust_speed = mean(gust_speed), na.rm = TRUE,
            mean_solar_radiation = mean(solar_radiation), na.rm = TRUE,
            mean_precipitation = mean(precipitation), na.rm = TRUE,
            mean_air_temp = mean(air_temp), na.rm = TRUE,
            mean_air_pressure = mean(air_pressure), na.rm = TRUE,
            mean_significant_wave_height_s = mean(significant_wave_height_s), na.rm = TRUE,
            mean_significant_wave_period_s = mean(significant_wave_period_s), na.rm = TRUE,
            mean_maximum_wave_height_s = mean(maximum_wave_height_s), na.rm = TRUE,
            mean_maximum_wave_period_s = mean(maximum_wave_period_s), na.rm = TRUE,
            mean_average_wave_height_s = mean(average_wave_height_s), na.rm = TRUE,
            mean_average_wave_period_s = mean(average_wave_period_s), na.rm = TRUE,
            mean_wave_energy_s = mean(wave_energy_s), na.rm = TRUE,
            mean_significant_wave_height_n = mean(significant_wave_height_n), na.rm = TRUE,
            mean_significant_wave_period_w = mean(significant_wave_period_w), na.rm = TRUE,
            mean_maximum_wave_height_w = mean(maximum_wave_height_w), na.rm = TRUE,
            mean_maximum_wave_period_w = mean(maximum_wave_period_w), na.rm = TRUE,
            mean_average_wave_height_w = mean(average_wave_height_w), na.rm = TRUE,
            mean_average_wave_period_w = mean(average_wave_period_w), na.rm = TRUE,
            mean_wave_energy_w = mean(wave_energy_w), na.rm = TRUE)

# Question: How does water level vary over time among the wells?

# Create a figure of the trend in water level for all wells
ggplot(data = floody_times_summary, aes(x = DOY, y = mean_wl, color = wellname ))+
  geom_line()+
  theme_classic()+
  labs(x = "Day of Year", y = "Water Level")+
  scale_color_viridis_d(option = "mako")

# Create a figure of the trend in water level for the wells beluga, polarbear, muskox and tidewell only
floody_times_filtered <- floody_times_summary %>%
  filter(wellname %in% c("beluga", "polarbear", "muskox", "tidewell"))

ggplot(data = floody_times_filtered, aes(x = mean_maximum_wave_height_w, y = mean_wl, color = wellname ))+
  geom_point()+
  geom_smooth()+
  theme_classic()+
  labs(x = "wave height", y = "Water Level")+
  # add dashed line at y = 0.22
  geom_hline(yintercept = 0.22, linetype = "dashed")+
  scale_color_viridis_d(option = "mako")

# Run a statistical model to test the effect of mean_maximum_wave_height_w on mean_wl, with wellname as a random effect
model_flood_1 <- lmer(mean_wl ~ mean_maximum_wave_height_w + (1|wellname),
                      data = floody_times_filtered)
summary(model_flood_1)
