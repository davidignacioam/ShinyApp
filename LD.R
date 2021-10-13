

####  LIBRARIES  #### 

# SQL
library(DBI)
library(RMySQL)
# Shiny
library(shiny) # General interface
library(shinyWidgets) # Some Widgets
library(shinycssloaders) # For withSpinner()
library(fresh) # For shiny colors
library(shinydashboard) # For the general Structure
library(dashboardthemes) # For customized logo
library(shinymanager) # For Login
# install.packages("shinydashboardPlus")
# installr::uninstall.packages("shinydashboardPlus")
# require(devtools)
# install_version("shinydashboardPlus", version = "0.7.5")
library(shinydashboardPlus) # For boxPlus()
# Time
library(lubridate)
# Cluster
library(factoextra)
# Statistics
library(EnvStats) # For cv()
library(stats) # For describe()
# Visualization
library(ggplot2) # General Graphics
library(plotly) # For interactive interfaces
library(DT) # For datatable()
# Data Manipulation
library(janitor) # For rownames_to_column()
library(tidyr) # For drop NA & Spread
library(dplyr) # For select, arrange, filter and many others
# Others
library(xlsx) # For write.xlsx()
library(rdrop2) # For Dropbox connection


####  SQL  #### 

# Connection
con <- DBI::dbConnect(
  drv = RMySQL::MySQL(),
  user = ,
  password = ,
  dbname = ,
  host = ,
  Trusted_Connection = "True"
)
# Encodin UTF-8 in SQL
dbSendQuery(con, "SET NAMES utf8")

####  QUERIES  #### 

####  df_CED  #### 
df_CED <- 
  dbGetQuery(
    con,
    "
    ##############  DIAGNÓSTICOS Y EVENTO CLÍNICO  ##############
  
    SELECT 
    # Jugador
    CONCAT(us.name,' ',us.last_name) AS Jugador,
    pl.birthday AS FechaNacimiento,
    IF (pl.side = 1, 'Diestro', 'Zurdo') AS Lateralidad,
    pl.height AS Estatura,
    pl.initial_weight AS Peso,
    ct.name_category AS Categoría,
    pt.name_position AS Posición,
    # Evento Clínico
    ce.id AS ID_EventoClínico,
    DATE(ce.created) AS FechaEventoClínico,
    DATE(ceh.start_date) AS FechaInicio,
    DATE(ceh.end_date) AS FechaTérmino,
    ins.name AS Instancia,
    mm.name AS InstanciaPartido,
    sev.name AS Presentación,
    smc.name AS MecanismoEspecífico,
    gmc.name AS MecanismoGeneral,
    # Diagnóstico
    dg.id AS ID_Diagnóstico,
    DATE(dg.created) AS FechaDiagnóstico,
    CASE dg.side 
      WHEN '1' THEN 'Derecha'
      WHEN '2' THEN 'Izquierda'
      WHEN '3' THEN 'Derecha y Izquierda'
      WHEN '4' THEN 'No aplica'
    END AS Lado,
    dgt.name AS Categoría_I,
    sdg.name AS Categoría_II,
    pa.name AS Diagnóstico,
    dga.id AS ID_Disponibilidad,
    act.name_availability_condition_type AS Disponibilidad,
    dga.created AS FechaDisponibilidad,
    pm.name AS Material_Proc_Refl,
    dgc.name AS Complemento_I,
    sm.name AS Complemento_II,
    gr.name AS Agrupación,
    bz.name AS ZonaCorporal,
    br.name AS RegiónCorporal
      
    FROM player pl 
      # Jugador
      LEFT JOIN user us ON us.id = pl.id_user 
            AND us.deleted = 0
            AND us.id_user_type = 12
            AND us.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN user_type ust ON ust.id = us.id_user_type 
      LEFT JOIN category_type ct ON pl.id_category_type = ct.id
      LEFT JOIN position_type pt ON pl.id_position_type = pt.id	
      # Evento Clínico
      LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
            AND ce.deleted = 0 
            AND ce.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN clinical_event_history ceh ON ceh.id_clinical_event = ce.id
      LEFT JOIN instance ins ON ins.id = ce.id_instance
      LEFT JOIN match_moment mm ON mm.id = ce.id_match_moment
      LEFT JOIN severity sev ON sev.id = ce.id_severity
      LEFT JOIN specific_mechanism smc ON smc.id = ce.id_specific_mechanism
      LEFT JOIN general_mechanism gmc ON gmc.id = ce.id_general_mechanism
      # Diagnóstico
      LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
            AND dg.deleted = 0
            AND dg.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN diagnostic_type dgt ON dgt.id = dg.id_diagnostic_type
      LEFT JOIN sub_diagnostic sdg ON sdg.id = dg.id_sub_diagnostic
      LEFT JOIN pathology pa ON pa.id = dg.id_pathology
      LEFT JOIN diagnostic_complement dgc ON dgc.id = dg.id_diagnostic_complement
      LEFT JOIN procedure_material pm ON pm.id = dg.id_procedure_material
      LEFT OUTER JOIN diagnostic_availability dga ON dga.id_diagnostic = dg.id 
            AND dga.deleted = 0
            AND dga.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN availability_condition ac ON ac.id = dga.id_availability_condition
            AND ac.deleted = 0
            AND ac.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN availability_condition_type act ON ac.id_availability_condition_type = act.id
      # Músculo Esquelétio
      LEFT JOIN skeletal_muscle sm ON sm.id = dg.id_skeletal_muscle
      LEFT JOIN grouper gr ON gr.id = sm.id_grouper
      LEFT JOIN body_zone bz ON bz.id = sm.id_body_zone
      LEFT JOIN body_region br ON br.id = bz.id_body_region
    
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'AUDAXITALIANO'
    ;
    "
  ) %>% as.data.frame() 
####  df_KT  #### 
df_KT <- 
  dbGetQuery(
    con,
    "
    ##############  TRATAMIENTO KINÉSICO  ##############

    SELECT DISTINCT
    # Jugador
    concat(us.name,' ',us.last_name) AS Jugador,
    ct.name_category AS Categoría,
    # Tratamiento Kinésico
    kt.id_diagnostic AS ID_Diagnóstico,
    kt.id AS ID_TratamientoKinésico,
    kt.date AS FechaTratamientoKinésico,
    UPPER(kt.text) AS TratamientoKinésico
        
    FROM player pl 
      # Jugador
      LEFT JOIN user us ON us.id = pl.id_user 
            AND us.deleted = 0
            AND us.id_user_type = 12
            AND us.tenant_code = 'AUDAXITALIANO' 
      LEFT JOIN user_type ust ON ust.id = us.id_user_type 
      LEFT JOIN category_type ct ON pl.id_category_type = ct.id
      # Evento Clínico
      LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
            AND ce.deleted = 0 
            AND ce.tenant_code = 'AUDAXITALIANO'
      # Diagnóstico
      LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
            AND dg.deleted = 0
            AND dg.tenant_code = 'AUDAXITALIANO'
      # Tratamiento Kinésico
      LEFT JOIN kinesic_treatment kt ON kt.id_diagnostic = dg.id 
            AND kt.deleted = 0
            AND kt.tenant_code = 'AUDAXITALIANO'
        
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'AUDAXITALIANO'
    
    ;
    "
  ) %>% as.data.frame() 
####  df_KA  #### 
df_KA <- 
  dbGetQuery(
    con,
    "
    ##############  ACCIÓN KINÉSICA  ##############

    SELECT DISTINCT
    # Jugador
    concat(us.name,' ',us.last_name) AS Jugador,
    ct.name_category AS Categoría,
    # Tratamiento Kinésico
    kt.id_diagnostic AS ID_Diagnóstico,
    kt.id AS ID_AcciónKinésica,
    kt.date AS FechaAcciónKinésica,
    UPPER(kt.text) AS AcciónKinésica
        
    FROM player pl 
      # Jugador
      LEFT JOIN user us ON us.id = pl.id_user 
            AND us.deleted = 0
            AND us.id_user_type = 12
            AND us.tenant_code = 'AUDAXITALIANO' # COLOCOLO
      LEFT JOIN user_type ust ON ust.id = us.id_user_type 
      LEFT JOIN category_type ct ON pl.id_category_type = ct.id
      # Evento Clínico
      LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
            AND ce.deleted = 0 
            AND ce.tenant_code = 'AUDAXITALIANO'
      # Diagnóstico
      LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
            AND dg.deleted = 0
            AND dg.tenant_code = 'AUDAXITALIANO'
      # Tratamiento Kinésico
      LEFT JOIN kinesic_treatment kt ON pl.id = kt.id_player 
            AND kt.deleted = 0
            AND kt.tenant_code = 'AUDAXITALIANO'
        
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'AUDAXITALIANO'
    
    ;
    "
  ) %>% as.data.frame() 
####  df_EO  #### 
df_EO <- 
  dbGetQuery(
    con,
    "
    ##############  EVALUACIÓN OBJETIVO  ##############

    SELECT DISTINCT
    # Jugador
    CONCAT(us.name,' ',us.last_name) AS Jugador,
    ct.name_category AS Categoría,
    # Diagnóstico
    dg.id AS ID_Diagnóstico,
    DATE(dg.created) AS FechaDiagnóstico,
    # Evaluación Objetivo
    evob.text AS EvaluaciónObjetivo
    
    FROM player AS pl 
      # Jugador
      LEFT JOIN user AS us 
             ON us.id = pl.id_user 
            AND us.deleted = 0
            AND us.id_user_type = 12
            AND us.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN user_type AS ust 
             ON ust.id = us.id_user_type 
      LEFT JOIN category_type AS ct 
             ON pl.id_category_type = ct.id
      # Evento Clínico
      LEFT JOIN clinical_event AS ce 
             ON pl.id = ce.id_player 
            AND ce.deleted = 0 
            AND ce.tenant_code = 'AUDAXITALIANO'
      # Diagnóstico
      LEFT JOIN diagnostic AS dg 
             ON ce.id = dg.id_clinical_event 
            AND dg.deleted = 0
            AND dg.tenant_code = 'AUDAXITALIANO'
      # Evaluación Objetivo
      LEFT JOIN evaluation_objective AS evob 
             ON dg.id = evob.id_diagnostic
    
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'AUDAXITALIANO'
    
    ;
    "
  ) %>% as.data.frame() 
####  df_MED  #### 
df_MED <- 
  dbGetQuery(
    con,
    "
    ##############  MEDICINA  ##############

    SELECT DISTINCT
    # Jugador
    concat(us.name,' ',us.last_name) AS Jugador,
    ct.name_category AS Categoría,
    # Diagnóstico
    dg.id AS ID_Diagnóstico,
    DATE(dg.created) AS FechaDiagnóstico,
    # Medicina
    med.id AS ID_Medicamento,
    med.name AS Medicamento,
    medc.name AS ClasificaciónMed,
    medv.name AS Vía,
    dgm.dose AS Dosis
    
    FROM player pl 
      # Jugador
      LEFT JOIN user us ON us.id = pl.id_user 
            AND us.deleted = 0
            AND us.id_user_type = 12
            AND us.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN user_type ust ON ust.id = us.id_user_type 
      LEFT JOIN category_type ct ON pl.id_category_type = ct.id
      # Evento Clínico
      LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
            AND ce.deleted = 0 
            AND ce.tenant_code = 'AUDAXITALIANO'
      # Diagnóstico
      LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
            AND dg.deleted = 0
            AND dg.tenant_code = 'AUDAXITALIANO'
      # Medicina
      LEFT JOIN diagnostic_medicine dgm ON dgm.id_diagnostic = dg.id 
            AND dgm.deleted = 0
            AND dgm.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN medicine med ON med.id = dgm.id_medicine
      LEFT JOIN medicine_classification medc ON medc.id = dgm.id_medicine_classification
      LEFT JOIN medicine_via medv ON medv.id = dgm.id_medicine_via
    
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'AUDAXITALIANO'
    
    ;
    "
  ) %>% as.data.frame() %>% drop_na()
####  df_AC  #### 
df_AC <- 
  dbGetQuery(
    con,
    "
    ##############  CONDICIÓN DE DISPONIBILIDAD  ##############

    SELECT DISTINCT
    # Jugador
    concat(us.name,' ',us.last_name) AS Jugador,
    ct.name_category AS Categoría,
    pt.name_position AS Posición,
    # Condición de Disponibilidad
    act.name_availability_condition_type AS CondiciónDisponibilidad,
    DATE(max(ac.created)) AS FechaCondición
    
    FROM player pl 
      # Jugador
      LEFT JOIN user us ON us.id = pl.id_user 
            AND us.deleted = 0
            AND us.id_user_type = 12
            AND us.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN user_type ust ON ust.id = us.id_user_type 
      LEFT JOIN category_type ct ON pl.id_category_type = ct.id
      LEFT JOIN position_type pt ON pl.id_position_type = pt.id
      # Condición de Disponibilidad
      LEFT JOIN availability_condition ac ON pl.id = ac.id_player 
            And ac.deleted = 0
            AND ac.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN availability_condition_type act 
              ON ac.id_availability_condition_type = act.id
    
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'AUDAXITALIANO'
    
    GROUP BY DATE(ac.created), pl.id
    
    ORDER BY pl.id asc, DATE(max(ac.created)) desc
    
    ;
    "
  ) %>% as.data.frame()
####  df_MED  #### 
df_MED <- 
  dbGetQuery(
    con,
    "
    ##############  MEDICINA  ##############

    SELECT DISTINCT
    # Jugador
    concat(us.name,' ',us.last_name) AS Jugador,
    ct.name_category AS Categoría,
    # Diagnóstico
    dg.id AS ID_Diagnóstico,
    DATE(dg.created) AS FechaDiagnóstico,
    # Medicina
    med.id AS ID_Medicamento,
    med.name AS Medicamento,
    medc.name AS ClasificaciónMed,
    medv.name AS Vía,
    dgm.dose AS Dosis
    
    FROM player pl 
      # Jugador
      LEFT JOIN user us ON us.id = pl.id_user 
            AND us.deleted = 0
            AND us.id_user_type = 12
            AND us.tenant_code = 'AUDAXITALIANO' 
      LEFT JOIN user_type ust ON ust.id = us.id_user_type 
      LEFT JOIN category_type ct ON pl.id_category_type = ct.id
      # Evento Clínico
      LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
            AND ce.deleted = 0 
            AND ce.tenant_code = 'AUDAXITALIANO'
      # Diagnóstico
      LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
            AND dg.deleted = 0
            AND dg.tenant_code = 'AUDAXITALIANO'
      # Medicina
      LEFT JOIN diagnostic_medicine dgm ON dgm.id_diagnostic = dg.id 
            AND dgm.deleted = 0
            AND dgm.tenant_code = 'AUDAXITALIANO'
      LEFT JOIN medicine med ON med.id = dgm.id_medicine
      LEFT JOIN medicine_classification medc ON medc.id = dgm.id_medicine_classification
      LEFT JOIN medicine_via medv ON medv.id = dgm.id_medicine_via
    
    WHERE pl.deleted = 0 
     AND pl.tenant_code = 'AUDAXITALIANO'
    
    ;
    "
  ) %>% as.data.frame() %>% drop_na()

# Disconnection
dbDisconnect(con)


####  DATA WRANGLING  #### 

####  DF_PD  #### 
## Downloading
drop_auth(rdstoken = "dropbox_token.rds")
drop_download('ReConquer/R Data/AUDAXITALIANO/df_PD.rds', overwrite = TRUE)
drop_download('ReConquer/R Data/AUDAXITALIANO/df_PD_F.rds', overwrite = TRUE)
## Reading
df_PD <- readRDS("df_PD.rds") 
df_PD_F <- readRDS("df_PD_F.rds") 
# df_PD <- readRDS("/Users/usuario/Dropbox/ReConquer/R Data/AUDAXITALIANO/df_PD.rds")
# df_PD_F <- readRDS("/Users/usuario/Dropbox/ReConquer/R Data/AUDAXITALIANO/df_PD_F.rds")

####  DF_CED  #### 
# Previous Events
#df_CED$Instancia <- df_CED$Instancia %>% replace_na("Evento clínico externo (Selección/Club)")
# Reading Columns as Factors
for (i in 1:ncol(df_CED)) {
  df_CED[,i] <- df_CED[,i] %>% as.factor()
}
# Date Vasriables
df_CED <- 
  df_CED %>% 
  mutate(Edad = df_CED$FechaNacimiento %>% 
           as.Date() %>% 
           eeptools::age_calc(units='years') %>% 
           round(0)) 
df_CED$FechaEventoClínico <- df_CED$FechaEventoClínico %>% as.Date()
df_CED$FechaDiagnóstico <- df_CED$FechaDiagnóstico %>% as.Date()
df_CED$FechaDisponibilidad <- df_CED$FechaDisponibilidad %>% as.Date()
df_CED$FechaInicio <- df_CED$FechaInicio %>% as.Date()
df_CED$FechaTérmino <- df_CED$FechaTérmino %>% as.Date()
# Others
df_CED$Complemento_II <- 
  gsub("\\s*\\([^\\)]+\\)","",
       as.character(df_CED$Complemento_II)) %>% as.factor() 
df_CED$MecanismoEspecífico <- 
  gsub("\\s*\\([^\\)]+\\)","",
       as.character(df_CED$MecanismoEspecífico)) %>% as.factor()
df_CED$MecanismoGeneral <- 
  gsub("\\s*\\([^\\)]+\\)","",
       as.character(df_CED$MecanismoGeneral)) %>% as.factor()
df_CED$Diagnóstico <- 
  gsub("\\s*\\([^\\)]+\\)","",
       as.character(df_CED$Diagnóstico)) %>% as.factor()
df_CED$Presentación <- 
  gsub("\\s*\\([^\\)]+\\)","",
       as.character(df_CED$Presentación)) %>% as.factor()
# Selecting Variables
df.S.0 <- 
  c(
    # Jugador
    "Edad","Posición","Lateralidad","Estatura",
    # Formulario Diagnóstico
    "Categoría_II","Lado",
    # Mecanismo Lesión
    "Instancia","Presentación","MecanismoGeneral",
    # Distribución Lesiones
    "ZonaCorporal","RegiónCorporal","Agrupación"
  )
df.S.1 <- 
  select(
    df_CED,
    # Jugador
    "Edad","Posición","Lateralidad","Estatura",
    # Formulario Diagnóstico
    "Categoría_I","Categoría_II","Diagnóstico",
    "Complemento_I","Complemento_II","Lado",
    "Disponibilidad",
    # Mecanismo Lesión
    "Instancia","InstanciaPartido","Presentación",
    "MecanismoEspecífico","MecanismoGeneral",
    # Distribución Lesiones
    "ZonaCorporal","RegiónCorporal","Agrupación"
  )
df.S.2 <- 
  c(
    # Jugador
    "Edad","Posición","Lateralidad","Estatura",
    # Formulario Diagnóstico
    "Categoría_I","Categoría_II","Diagnóstico",
    "Complemento_I","Complemento_II","Lado",
    "Disponibilidad","Material_Proc_Refl",
    # Mecanismo Lesión
    "Instancia","InstanciaPartido","Presentación",
    "MecanismoEspecífico","MecanismoGeneral",
    # Distribución Lesiones
    "ZonaCorporal","RegiónCorporal","Agrupación"
  )

####  DF_KT  #### 
# Deifning Nature
df_KT$FechaTratamientoKinésico[df_KT$FechaTratamientoKinésico  == "NULL"] <- NA
df_KT$Jugador <- df_KT$Jugador %>% as.factor()
df_KT$Categoría <- df_KT$Categoría %>% as.factor()
df_KT$FechaTratamientoKinésico <- df_KT$FechaTratamientoKinésico %>% as.Date()
# Loop for removing \n
for (row in seq(1,nrow(df_KT),by=1)) {
  df_KT[row,"TratamientoKinésico"] <- df_KT[row,"TratamientoKinésico"] %>% stringr::str_replace("\n", " ")
}
# Defining Category Values
df_KT <- 
  df_KT %>%
  filter(!is.na(ID_TratamientoKinésico)) %>%
  select(!ID_Diagnóstico)

####  DF_KA  #### 
# Deifning Nature
df_KA$FechaAcciónKinésica[df_KA$FechaAcciónKinésica  == "NULL"] <- NA
df_KA$Jugador <- df_KA$Jugador %>% as.factor()
df_KA$Categoría <- df_KA$Categoría %>% as.factor()
df_KA$FechaAcciónKinésica <- df_KA$FechaAcciónKinésica %>% as.Date()
# Loop for removing \n
for (row in seq(1,nrow(df_KA),by=1)) {
  df_KA[row,"AcciónKinésica"] <- 
    df_KA[row,"AcciónKinésica"] %>% 
    stringr::str_replace("\n", " ")
}
# Defining Category Values
df_KA <- 
  df_KA %>%
  filter(!is.na(ID_AcciónKinésica)) %>%
  select(!ID_Diagnóstico)

####  DF_EO  #### 

df_EO$Jugador <- df_EO$Jugador %>% as.factor()
df_EO$Categoría <- df_EO$Categoría %>% as.factor()
df_EO$FechaDiagnóstico <- df_EO$FechaDiagnóstico %>% as.Date()
df_EO$EvaluaciónObjetivo <- df_EO$EvaluaciónObjetivo %>% as.character()
# df_EO$EvaluaciónObjetivo[is.na(df_EO$EvaluaciónObjetivo)] <- "Sin texto."
df_EO <- 
  df_EO %>% 
  filter(!is.na(ID_Diagnóstico)) %>%
  select(!ID_Diagnóstico)

####  DF_AC  #### 
# Deifning Nature
df_AC$CondiciónDisponibilidad <- df_AC$CondiciónDisponibilidad %>% as.factor()
df_AC$Posición <- df_AC$Posición %>% as.factor()
df_AC$Jugador <- df_AC$Jugador %>% as.factor()
df_AC$Categoría <- df_AC$Categoría %>% as.factor()
df_AC$FechaCondición <- df_AC$FechaCondición %>% as.Date()

####  DF_MED  #### 
# Deifning Nature
df_MED$ClasificaciónMed <- df_MED$ClasificaciónMed %>% as.factor()
df_MED$Vía <- df_MED$Vía %>% as.factor()
df_MED$Dosis <- df_MED$Dosis %>% as.numeric()
df_MED$Medicamento <- df_MED$Medicamento %>% as.factor()
df_MED$Jugador <- df_MED$Jugador %>% as.factor()
df_MED$Categoría <- df_MED$Categoría %>% as.factor()
df_MED$FechaDiagnóstico <- df_MED$FechaDiagnóstico %>% as.Date()

####  DF_TL  #### 

# Empty DF
empty_df_TL <- 
  data.frame(
    Jugador= factor(),
    Instancia = factor(),
    Categoría = factor(),
    Categoría_I = factor(),
    Disponibilidad = factor(),
    FechaInicio = Date(),
    FechaTérmino = Date()
  )
# Player Levels
player_levels <- 
  df_CED$Jugador %>% 
  unique() %>% 
  as.vector()
# Loop for Player
for (player in player_levels) {
  # Filtering
  df_player <- 
    df_CED %>%
    filter(
      Jugador %in% player
    ) %>%
    select(
      Jugador,
      Instancia,
      Categoría,
      Categoría_I,
      ID_Diagnóstico,
      Disponibilidad,
      FechaInicio = FechaDisponibilidad,
      FechaTérmino
    ) %>%
    distinct() 
  # Saving Ids
  ID_TL <- 
    df_player$ID_Diagnóstico %>% 
    unique() %>% 
    as.vector()
  # Loop for ID
  for (id in ID_TL) {
    # Filtering
    df_filter <- 
      df_player %>%
      filter(
        ID_Diagnóstico %in% id
      )
    # Condition for rows
    if (nrow(df_filter) >= 2) {
      # Condition for Date
      for (i in seq(2,nrow(df_filter))) {
        df_filter$FechaTérmino[i-1] <- 
          df_filter$FechaInicio[i]
      }
    } 
    # Building DF
    empty_df_TL <- 
      rbind(
        empty_df_TL,
        df_filter
      )
  }
  # Deleting current object
  rm(df_filter)
}
# Final DF
df_TL_new <- 
  empty_df_TL %>% 
  filter(
    Disponibilidad != "Descanso"
  ) %>% 
  drop_na() %>% 
  mutate(TimeLoss = 0) %>% 
  select(
    Jugador,
    Categoría,
    Categoría_I,
    Disponibilidad,
    Instancia,
    FechaInicio,
    FechaTérmino,
    TimeLoss
  )

# Loop for Time Loss Value
for (i in seq(1,nrow(df_TL_new), by=1)) {
  if (
    (df_TL_new$Categoría_I[i] %in% c("Lesión","Enfermedad","Molestia") & 
     df_TL_new$Disponibilidad[i] %in% c("Apto para entrenar sintomático",
                                        "Apto para Entrenar")) |
    difftime(df_TL_new$FechaTérmino[i], 
             df_TL_new$FechaInicio[i], 
             units = c("days")) %>% as.numeric() == 0
  ) {
    df_TL_new$TimeLoss[i] <- 0
  } else {
    df_TL_new$TimeLoss[i] <- 
      (difftime(df_TL_new$FechaTérmino[i], 
                df_TL_new$FechaInicio[i], 
                units = c("days")) %>% as.numeric()) - 1
  }
}
# Adding Severity
df_TL <- 
  df_TL_new %>%
  filter(
    TimeLoss >= 0,
    !Categoría_I == "Molestia"
  ) %>% 
  mutate(
    Severidad = case_when(
      TimeLoss > 28 ~ "Severa",
      TimeLoss >= 8 & TimeLoss <= 28 ~ "Moderada",
      TimeLoss >= 4 & TimeLoss < 8 ~ "Leve",
      TimeLoss >= 1 & TimeLoss < 4 ~ "Mínima",
      TimeLoss == 0 ~ "Sin ausencia"
    )
  ) %>%
  rename(
    Momento = Instancia,
    FechaInicio_TimeLoss = FechaInicio,
    FechaTérmino_TimeLoss = FechaTérmino
  ) 

## Defining specific Objects
date.range <- 
  seq.Date(
    from = Sys.Date() - 180,
    to = Sys.Date(),
    by = "day"
  )

####  TEXTS  #### 
## Header Logo
customLogo <- shinyDashboardLogoDIY(
  boldText = "RA"
  ,mainText = "   |AUDAXITALIANO|"
  ,textSize = 18
  ,badgeText = NULL
  ,badgeTextColor = NULL
  ,badgeTextSize = NULL
  ,badgeBackColor = NULL
  ,badgeBorderRadius = NULL
)
## Tab 1
na.cat <- 
  "ERROR: Se debe agregar al menos una Variable Categórica en la Tabla de Frecuencias."
na.time <- 
  "ERROR: No existen suficientes registros en este rango de Tiempo para poder generar la Visualización."
na.time.med <- 
  "ERROR: 
No existen suficientes registros de esta Medición en este rango de Tiempo para poder generar la Visualización"
na.cl.com <- 
  "ERROR: No hay suficientes mediciones de este jugador para poder generar la comparación."
## Notifications
not1 <- 
  HTML('
  <center>
  <i class="fas fa-users fa center" style="color:#00C0EF;"></i>
  <i class="far fa-calendar-alt fa center" style="color:#00C0EF;"></i>
  <h5><strong>Con estos símbolos seleccionas el Plantel e intervalo de Fecha de interés: 
  ambos filtros se aplicarán a todas las Visualizaciones.</strong></h5>
  </center>
       ')
not2 <- 
  HTML('
  <center>
  <i class="fas fa-mouse-pointer fa center" style="color:#00C0EF;"></i>
  <h5><strong>Selecciona la Pestaña y las Variables o Atributos de interés 
  que te permitirán sacar el máximo potencial a los datos.</strong></h5>
  </center>
       ')
not3 <- 
  HTML('
  <center>
  <i class="fas fa-question-circle fa center" style="color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite acceder a información sobre la Descripción, 
  Utilidad y Ejemplo de la Visualización en el cual se ubica el botón.</strong></h5>
  </center>
       ')
not4 <- 
  HTML('
  <center>
  <i class="fas fa-file-alt fa center" style="color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite acceder a información sobre 
  las Variables que componen la Selección en el cual se ubica el botón.</strong></h5>
  </center>
       ')
not5 <- 
  HTML('
  <center>
  <i class="fas fa-sliders-h fa center" style="color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite acceder a la Selección de 
  las Variables que forman la Visualización.</strong></h5>
  </center>
       ')
not6 <- 
  HTML('
  <center>
  <i class="fas fa-download fa center" style="color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite descargar las Tablas. 
  El ".xlsx" descarga en formato Excel, 
  mientras que el ".csv· descarga en formato CSV.</strong></h5>
  </center>
       ')
not7 <- 
  HTML('
  <center>
  <i class="fas fa-camera fa center" style="color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite descargar las Gráficas. 
  Este se ubica en la parte superior derecha las Visualizaciones.</strong></h5>
  </center>
       ')


####  CSS  #### 
css <- "

  /*     Error     */ 
  
  .shiny-output-error-validation {
    visibility: hidden; 
  }
  .shiny-output-error:before { 
    visibility: hidden; 
  }
  .shiny-output-error { 
    visibility: hidden; 
  }
  
  /*     General     */ 
  
  .content-wrapper {
    background-color: #EDEDED;
  }
  .navbar-nav li a {
    font-size: 13px;
    font-weight: bold;
  }
  .navbar-nav li a:hover{
    font-size: 13px;
    font-weight: bold;
  }
  .skin-black .main-header {
    border-right: 1.3px solid #142c59;
  }
  .skin-black .main-header .navbar {
    background-color: #FFFFFF;
    border-bottom: 1.3px solid #142c59;
  }
  .skin-black .main-header .logo {
    font-weight: bold;
    color: #FFFFFF;
    background: #142c59;
  }
  .skin-black .main-header .logo:hover {
    font-weight: bold;
    color: #FFFFFF;
    background-color: #142c59;
  }
  .skin-black .main-sidebar { 
    background-color: #142c59;
    /*  background: linear-gradient(30deg, #050505F2, #050505F2, #050505F2, #00C0EF); */ 
  }
  .navbar-custom-menu>.navbar-nav>li>.dropdown-menu {
    color: black;
    font-size: 14px;
    background-color: #FFFFFF;
    border-top-left-radius: 0px;
    border-top-right-radius: 0px;
    border-bottom-right-radius: 0px;
    border-bottom-left-radius: 0px;
    border-bottom: 1.3px solid #030303;
    border-right: 1.3px solid #030303;
    border-left: 1.3px solid #030303;
    }
    #dropdownBlock_info li {
    width: 500px;
  }
  
  /*     Box     */ 
  
  .box-body {
    padding: 1px;
    margin: 0px;
  }
  .primary-box {
    padding: 1px;
  }
  .skin-black .box-primary {
    padding: 0px;
    border-radius: 0px;
    font-size: 13px;
    box-shadow: 4px 4px 4px rgb(0 0 0 / 30%);
  }
  .skin-black .box-primary:hover {
    box-shadow: 8px 8px 8px rgb(0 0 0 / 40%);
  }
  .skin-black .box.box-solid.box-primary {
    border-top: none; 
    border-bottom: none; 
    border-right: none; 
    border-left: none; 
  }
  .skin-black .box.box-solid.box-primary>.box-header {
    color: #FFFFFF;
    background: linear-gradient(35deg, #142c59, #00C0EF);
  }

  .skin-black .box-success {
    background: #142c59;
    color: white;
  }
  .skin-black .box.box-solid.box-success>.box-header {
    background: #142c59;
  }
  .skin-black .box.box-solid.box-success {
    border-top: none; 
    border-bottom: none; 
    border-right: none; 
    border-left: none; 
  }
  
  /*     Modal     */ 
  
  .modal-body {
    border: 0px;
    padding: 0px;
    margin: 0px;
  }
  #btn-modal {
    background-color: #050505F2;
    color: white;
  }
  .modal-content {
    border: 0px;
    padding: 0px;
    margin: 0px;
  }
  body {
    margin: 0px;
    padding: 0px;
  }
  .modal {
    font-family: arial, sans-serif , serif;
    border-radius: 0px;
    margin: 0px;
  }
  .modal-footer {
    text-align:center;
  }
  .bg-header {
    background: linear-gradient(60deg, #142c59, #00C0EF);
    border-radius: 0px 0px 0px 0px;
    padding: 20px;
    margin: 0px;
  hr{
   width: 90%;
   color: #ccc;
  } 
  
  "

####  DELETE  #### 
rm(con,df,json,json_n,df_Json,json_df,json_m,json_df_b,json_df_c,empty_df_TL,df_TL_new)


## fun::random_password(50, replace = FALSE, extended = FALSE)
## AUDAXITALIANO : AUDAXITALIANOp7nh3zeSx0a6XdJfIPLCM51uQ4rHWGR9EqDsBjvitVFKw8NAyc

