Micah Kraml Eckert 
Team Shrub (Myers-Smith), University of British Columbia
Water Ecosystem Land Loss Project (WELL)

Water Ecosystem Land Loss Project Climate Database

location: Simpson Point, Qikiqatruk - Herschel Island, Yukon, Canada
timeframe: June to September, 2025

Description: This dataset contains climate and hydrological data which is used to determine the drivers of flooding events at Simpson Point 
in order to inform the management of Qikiqtaruk, the development of the ECCC Coastal Flood Prediction and Alerting Program, and the Yukon 
Parks' Ecological Monitoring Program. Data is used primarily in Micah Eckert MSc Thesis at the University of British Columbia.

Variable metadata: 

datetime - the day and time given in Whitehorse time with format YYYY-MM-DD HH-MM-SS. All data was collected on even minute intervals and then resampled to 30 minute intervals across the ice-free season. 

wl_(...) - these variables describe the elevation of water (m.a.s.l), whether ground water or inundation which is in reference to average sea level during the 2025 ice-free season. These values are directly comparable, being in identical vertical reference formats. the name, following wl_ (eg. polarbear, tidewell) describes the ground water well from where these data were collected from. Collected by Solinst Levelogger 5 LTC sensors. See WELL DESCRIPTION.

height_ (...) - these variables describe the water level (m) relative to ground level at each well site. These are not comparable as they are at different location, but represent inundation levels during floods, and the depth to groundwater or tidal water outside of flooding events. the name, following height_ (eg. polarbear, tidewell) describes the ground water well from where these data were collected from. Collected by Solinst Levelogger 5 LTC sensors. See WELL DESCRIPTION.

temp_(...) - these variables show water temperature (C) at each well site. Collected by Solinst Levelogger 5 LTC sensors. See WELL DESCRIPTION.

cond_(...) - these variables describe the electrical conductivity (uS) of water at each well site. Collected by Solinst Levelogger 5 LTC sensors. See WELL DESCRIPTION.

level_(...) - these variables describe the unnormalized water column height (m) which is comparable to absolute pressure (unusable in current state). Collected by Solinst Levelogger 5 LTC sensors. See WELL DESCRIPTION.

astrotide - this variable represents modelled astronomical tide, using data collected from the Tide Well. Tide is calculated usign Tidal Harmonic Constituent Analysis using 30 constituents constained to 3 month relevance. Processed using R package, TideHarmonics. See WELL DESCRIPTION.

surge - the magnitude of storm surge (m) and other small residuals of tidal signal, calcualted as the differnece between water level (wl_tidewell) and astrotide (astronomical tide). 

wind_direction - the direction of wind (0-360 degrees), collected from a HOBO wind station on Simpson Point. 

wind_speed - the speeds (m/s) of wind, collected from a HOBO wind station on Simpson Point.

gust_speed - the maximum speed (m/s) of wind during each sampling frame (5 minute period), then averaged to 30 minute intervals. collected from a HOBO wind station on Simpson Point.

solar_radiation - the solar power (W/m^2) collected by HOBO solar rad sensors, averaged to 30 minute intervals. 

air_temp - the air temperautre (C), collected by HOBO temperature logger - ERROR / Struct by lightning. Find alternative. 

air_pressure - air pressure (kPa) collected by Solinst Barrologger 5 situated in the air column at PolarBear well.

significant_wave_height_(...) - height (m) of waves representing the 66th percentile of each sampling effort. Standard in wave measurements as 1/2 the height of theoretical maximum waves. Collection from RBR Solo3 pressure transducer. The character at the end of significant_wave_height_ (eg. n, w, s) describes the orientation of the collection.

significant_wave_period_(...) - period (s) of waves representing the 66th percentile of each sampling effort. Collection from RBR Solo3 pressure transducer. The character at the end of significant_wave_period_ (eg. n, w, s) describes the orientation of the collection.

maximum_wave_height_(...) - the maximum height (m) of all waves during each 30 minute sampling effort. Collection from RBR Solo3 pressure transducer. The character at the end of maximum_wave_height_ (eg. n, w, s) describes the orientation of the collection. 

maximum_wave_period_(...) - the maximum period (s) of all waves during each 30 minute sampling effort. Collection from RBR Solo3 pressure transducer. The character at the end of maximum_wave_period_ (eg. n, w, s) describes the orientation of the collection.

average_wave_height_(...) - the height height (m) of all waves during each 30 minute sampling effort. Collection from RBR Solo3 pressure transducer. The character at the end of average_wave_height_ (eg. n, w, s) describes the orientation of the collection.

average_wave_period_(...) - the average period (s) of all waves during each 30 minute sampling effort. Collection from RBR Solo3 pressure transducer. The character at the end of average_wave_period_ (eg. n, w, s) describes the orientation of the collection.

wave_energy_(...) the total wave energy during each sampling effort, calculated in RUSKIN using the sum of wave action over time. 

WELL DESCRIPTION 
Tidewell - records raw tidal signal without ground interference. Located at the western tip of Simpson Point.
PolarBear - well adjacent to the runway near the gas shack on Simpson Point. 
Muskox - well adjacent to the Mission House on Simpson Point. 
Beluga - well located in between the runway and the wind haven on the western half of Simpson Point.
Fox - well located on the floodplain east of Simpson Point at the southern freshwater outflow. 
Snowy - well located on the floodplain east of Simpson Point at the west freshwater outflow. 

RBR DESCRIPTION 
_s - RBR located at 1m depth directly south of the boardwalk to the runway. 
_n - RBR located at 1m depth directly north of the wind haven 
_w - RBR located at the very western end of Simpson Point at 1m depth. 






