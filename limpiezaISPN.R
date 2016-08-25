
library(dplyr)
library(tidyr)

Censos_2011 <- read.csv("C:/Users/JC/Desktop/ISPN/Censos_ISPN_2011.csv", sep=";") %>%
  mutate(ID = paste(site, date, observer, dive, replicate)) %>%
  select(-site, -date, -observer, -dive, -replicate)

species_2011 <- read.csv("C:/Users/JC/Desktop/ISPN/species_2013.csv", sep =";")

Registros_2011 <- read.csv("C:/Users/JC/Desktop/ISPN/Registros_ISPN_2011.csv", sep=";") %>%
  mutate(ID = paste(site, date, observer, dive, replicate)) %>%
  left_join(Censos_2011, by = "ID") %>%
  left_join(species_2011, by = "species") %>%
  mutate(GeneroEspecie = paste(Genero, Especie, sep = " "),
         Comunidad = NA,
         Latitud = NA,
         Longitud = NA,
         Habitat = NA,
         Zonificacion = NA,
         TipoProteccion = NA,
         ANP = NA,
         Transecto = NA,
         ClaseT = NA) %>%
  select(ID,
         dive,
         replicate,
         Fecha = date,
         Comunidad,
         Sitio = site,
         Latitud ,
         Longitud,
         Habitat,
         Zonificacion,
         TipoProteccion,
         ANP,
         BuzoMonitor = observer,
         HoraInicial = start_time,
         HoraFinal = end_time,
         ProfundidadInicial = depth,
         ProfundidadFinal = depth,
         Temperatura = temperature,
         Visibilidad = visibility,
         Corriente = current,
         Transecto,
         Genero,
         Especie,
         GeneroEspecie,
         Sexo = sex,
         ClaseT,
         Talla = size_observed,
         Abundancia = abundance,
         Clase,
         FM = other_depth_information)

transectos_peces <- read.csv("C:/Users/JC/Desktop/ISPN/limpios/transectos_peces2011.csv", sep =";")
transectos_invert <- read.csv("C:/Users/JC/Desktop/ISPN/limpios/transectos_invert2011.csv", sep = ";")

peces <- filter(Registros_2011, Clase == "fish") %>%
  left_join(transectos_peces, by = "ID") %>%
  mutate(Transecto.x = Transecto.y) %>%
  select(-Transecto.y) %>%
  rename(Transecto = Transecto.x)

invert <- filter(Registros_2011, Clase == "invert") %>%
  left_join(transectos_invert, by = "ID") %>%
  mutate(Transecto.x = Transecto.y) %>%
  select(-Transecto.y, -ClaseT, -Talla) %>%
  rename(Transecto = Transecto.x)


write.table(peces, file = "C:/Users/JC/Desktop/ISPN/limpios/peces2011.csv", row.names = F, sep = ";")
write.table(invert, file = "C:/Users/JC/Desktop/ISPN/limpios/invert2011.csv", row.names = F, sep = ";")


########################################

species_2013 <- read.csv("C:/Users/JC/Desktop/ISPN/species_2013.csv", sep =";")

Registros_2013 <- read.csv("C:/Users/JC/Desktop/ISPN/Registros_ISPN_2013.csv", sep=";") %>%
  mutate(ID = paste(site, date, observer, dive, replicate)) %>%
  left_join(species_2013, by = "species") %>%
  mutate(GeneroEspecie = paste(Genero, Especie, sep = " "),
         Comunidad = NA,
         Latitud = NA,
         Longitud = NA,
         Habitat = NA,
         Zonificacion = NA,
         TipoProteccion = NA,
         ANP = NA,
         Transecto = NA,
         ClaseT = NA,
         HoraInicial = NA,
         HoraFinal = NA,
         ProfundidadInicial = NA,
         ProfundidadFinal = NA,
         Temperatura = NA,
         Visibilidad = NA,
         Corriente = NA,
         FM = NA) %>%
  select(ID,
         dive,
         replicate,
         Fecha = date,
         Comunidad,
         Sitio = site,
         Latitud ,
         Longitud,
         Habitat,
         Zonificacion,
         TipoProteccion,
         ANP,
         BuzoMonitor = observer,
         HoraInicial,
         HoraFinal,
         ProfundidadFinal,
         Temperatura,
         Visibilidad,
         Corriente,
         Transecto,
         Genero,
         Especie,
         GeneroEspecie,
         Sexo = sex,
         ClaseT,
         Talla = size_observed,
         Abundancia = abundance,
         Clase,
         FM)

transectos_invert <- read.csv("C:/Users/JC/Desktop/ISPN/limpios/transectos_invert2013.csv", sep = ";")

peces_2013 <- filter(Registros_2013, Clase == "fish")

invert_2013 <- filter(Registros_2013, Clase == "invert") %>%
  left_join(transectos_invert, by = "ID") %>%
  mutate(Transecto.x = Transecto.y) %>%
  select(-Transecto.y, -ClaseT, -Talla) %>%
  rename(Transecto = Transecto.x)

write.table(peces_2013, file = "C:/Users/JC/Desktop/ISPN/limpios/peces2013.csv", row.names = F, sep = ";")
write.table(invert_2013, file = "C:/Users/JC/Desktop/ISPN/limpios/invert2013.csv", row.names = F, sep = ";")

peces = rbind(peces, peces_2013)
invert = rbind(invert, invert_2013)


write.table(peces, file = "C:/Users/JC/Desktop/ISPN/limpios/peces2011y2013.csv", row.names = F, sep = ";")
write.table(invert, file = "C:/Users/JC/Desktop/ISPN/limpios/invert2011y2013.csv", row.names = F, sep = ";")
