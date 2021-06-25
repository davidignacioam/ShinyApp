

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


####  SQL  #### 
 
# Connection
con <- DBI::dbConnect(
  drv = RMySQL::MySQL(),
  user = "",
  password = "",
  dbname = "",
  host = "",
  Trusted_Connection = ""
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
  
    SELECT DISTINCT
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
    SUBSTRING(DATE(dg.created),1,4) AS AñoEventoClínico,
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
    act.name_availability_condition_type AS Disponibilidad,
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
      AND us.tenant_code = 'ANFP'
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    LEFT JOIN position_type pt ON pl.id_position_type = pt.id	
    # Evento Clínico
    LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
      AND ce.deleted = 0 
      AND ce.tenant_code = 'ANFP'
    LEFT JOIN instance ins ON ins.id = ce.id_instance
    LEFT JOIN match_moment mm ON mm.id = ce.id_match_moment
    LEFT JOIN severity sev ON sev.id = ce.id_severity
    LEFT JOIN specific_mechanism smc ON smc.id = ce.id_specific_mechanism
    LEFT JOIN general_mechanism gmc ON gmc.id = ce.id_general_mechanism
    # Diagnóstico
    LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
      AND dg.deleted = 0
      AND dg.tenant_code = 'ANFP'
    LEFT JOIN diagnostic_type dgt ON dgt.id = dg.id_diagnostic_type
    LEFT JOIN sub_diagnostic sdg ON sdg.id = dg.id_sub_diagnostic
    LEFT JOIN pathology pa ON pa.id = dg.id_pathology
    LEFT JOIN diagnostic_complement dgc ON dgc.id = dg.id_diagnostic_complement
    LEFT JOIN procedure_material pm ON pm.id = dg.id_procedure_material
    LEFT OUTER JOIN diagnostic_availability dga ON dga.id_diagnostic = dg.id 
      AND dga.deleted = 0
      AND dga.tenant_code = 'ANFP'
    LEFT JOIN availability_condition ac ON ac.id = dga.id_availability_condition
      AND ac.deleted = 0
      AND ac.tenant_code = 'ANFP'
    LEFT JOIN availability_condition_type act ON ac.id_availability_condition_type = act.id
    # Músculo Esquelétio
    LEFT JOIN skeletal_muscle sm ON sm.id = dg.id_skeletal_muscle
    LEFT JOIN grouper gr ON gr.id = sm.id_grouper
    LEFT JOIN body_zone bz ON bz.id = sm.id_body_zone
    LEFT JOIN body_region br ON br.id = bz.id_body_region
    
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'ANFP'
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
    kt.text AS TratamientoKinésico
        
    FROM player pl 
        
    # Jugador
    LEFT JOIN user us ON us.id = pl.id_user 
      AND us.deleted = 0
      AND us.id_user_type = 12
      AND us.tenant_code = 'ANFP' # COLOCOLO
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    # Evento Clínico
    LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
      AND ce.deleted = 0 
      AND ce.tenant_code = 'ANFP'
    # Diagnóstico
    LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
      AND dg.deleted = 0
      AND dg.tenant_code = 'ANFP'
    # Tratamiento Kinésico
    LEFT JOIN kinesic_treatment kt ON kt.id_diagnostic = dg.id 
      AND kt.deleted = 0
      AND kt.tenant_code = 'ANFP'
        
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'ANFP'
    
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
    kt.text AS AcciónKinésica
        
    FROM player pl 
        
    # Jugador
    LEFT JOIN user us ON us.id = pl.id_user 
      AND us.deleted = 0
      AND us.id_user_type = 12
      AND us.tenant_code = 'ANFP' # COLOCOLO
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    # Evento Clínico
    LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
      AND ce.deleted = 0 
      AND ce.tenant_code = 'ANFP'
    # Diagnóstico
    LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
      AND dg.deleted = 0
      AND dg.tenant_code = 'ANFP'
    # Tratamiento Kinésico
    LEFT JOIN kinesic_treatment kt ON pl.id = kt.id_player 
      AND kt.deleted = 0
      AND kt.tenant_code = 'ANFP'
        
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'ANFP'
    
    ;
    "
  ) %>% as.data.frame() 
####  df_PD_G  #### 
df_PD_G <- 
  dbGetQuery(
    con,
    "
    ##############  DIMENSIONES DE JUGADOR  ##############
    
    SELECT 
    # Jugador
    concat(us.name,' ',us.last_name) AS Jugador,
    ct.name_category AS Categoría,
    # Dimensiones de Jugador
    dm.name AS Dimensión,
    pldm.date AS FechaDimensión,
    # Meters
    pldm.meters AS Medición
    
    FROM player pl 
    
    # Jugador
    LEFT JOIN user us ON us.id = pl.id_user 
      AND us.deleted = 0
      AND us.id_user_type = 12
      AND us.tenant_code = 'ANFP'
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    # Dimensiones de Jugador
    LEFT JOIN player_dimension pldm ON pl.id = pldm.id_player 
      AND pldm.deleted = 0
      AND us.tenant_code = 'ANFP'
    LEFT JOIN dimension dm ON dm.id = pldm.id_dimension
      #AND dm.tenant_code = 'ANFP'
      
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'ANFP'
      
    ;
    "
  )
####  df_DM  #### 
df_DM <- 
  dbGetQuery(
    con,
    "
    ##############  MEDICIONES DIARIAS  ##############
    
    SELECT DISTINCT
    # Jugador
    concat(us.name,' ',us.last_name) AS Jugador,
    if (pl.side=1,'Diestro','Zurdo') AS Lateralidad,
    pl.height AS Estatura,
    pl.initial_weight AS Peso,
    ct.name_category AS Categoría,
    pt.name_position AS Posición,
    # Mediciones Diarias
    if (dm.measurement_moment=1,'Entrenamiento','Partido') AS MomentoMedición,
    mt.name AS TipoMedición,
    dm.value AS ValorMedición,
    dm.date AS FechaMedición
    
    FROM player pl 
    
    # Jugador
    LEFT JOIN user us ON us.id = pl.id_user 
      AND us.deleted = 0
      AND us.id_user_type = 12
      AND us.tenant_code = 'ANFP'
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    LEFT JOIN position_type pt ON pl.id_position_type = pt.id
    # Mediciones Diarias
    LEFT JOIN daily_measurements dm ON dm.id_player = pl.id 
      AND dm.deleted = 0
      AND dm.tenant_code = 'ANFP'
    LEFT JOIN measurement_type mt ON mt.id = dm.measurement_type  
      AND mt.deleted = 0
      AND mt.tenant_code = 'ANFP'
    
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'ANFP'
      
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
    AND us.tenant_code = 'ANFP' # COLOCOLO
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    # Evento Clínico
    LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
    AND ce.deleted = 0 
    AND ce.tenant_code = 'ANFP'
    # Diagnóstico
    LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
    AND dg.deleted = 0
    AND dg.tenant_code = 'ANFP'
    # Medicina
    LEFT JOIN diagnostic_medicine dgm ON dgm.id_diagnostic = dg.id 
    AND dgm.deleted = 0
    AND dgm.tenant_code = 'ANFP'
    LEFT JOIN medicine med ON med.id = dgm.id_medicine
    LEFT JOIN medicine_classification medc ON medc.id = dgm.id_medicine_classification
    LEFT JOIN medicine_via medv ON medv.id = dgm.id_medicine_via
    
    WHERE pl.deleted = 0 
    AND pl.tenant_code = 'ANFP'
    
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
      AND us.tenant_code = 'ANFP'
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    LEFT JOIN position_type pt ON pl.id_position_type = pt.id
    # Condición de Disponibilidad
    LEFT JOIN availability_condition ac ON pl.id = ac.id_player 
      And ac.deleted = 0
      AND ac.tenant_code = 'ANFP'
    LEFT JOIN availability_condition_type act 
        ON ac.id_availability_condition_type = act.id
    
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'ANFP'
    
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
    AND us.tenant_code = 'ANFP' # COLOCOLO
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    # Evento Clínico
    LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
    AND ce.deleted = 0 
    AND ce.tenant_code = 'ANFP'
    # Diagnóstico
    LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
    AND dg.deleted = 0
    AND dg.tenant_code = 'ANFP'
    # Medicina
    LEFT JOIN diagnostic_medicine dgm ON dgm.id_diagnostic = dg.id 
    AND dgm.deleted = 0
    AND dgm.tenant_code = 'ANFP'
    LEFT JOIN medicine med ON med.id = dgm.id_medicine
    LEFT JOIN medicine_classification medc ON medc.id = dgm.id_medicine_classification
    LEFT JOIN medicine_via medv ON medv.id = dgm.id_medicine_via
    
    WHERE pl.deleted = 0 
    AND pl.tenant_code = 'ANFP'
    
    ;
    "
  ) %>% as.data.frame() %>% drop_na()

# Disconnection
dbDisconnect(con)

####  DF_TL  #### 
df_TL <- xlsx::read.xlsx(
  "Data/Excel/TimeLoss.xlsx", sheetIndex = 1, header=TRUE, encoding="UTF-8"
) %>% as.data.frame() 


####  DATA WRANGLING  #### 

####  DF_CED  #### 
# Previous Events
df_CED$Instancia <- 
  df_CED$Instancia %>% replace_na("Evento Clínico desde club de procedencia")
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
df_CED$FechaEvento <- df_CED$FechaEvento %>% as.Date()
df_CED$FechaDiagnóstico <- df_CED$FechaDiagnóstico %>% as.Date()
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
# Changing Some Values
# df_CED$Lado <- plyr::revalue(df_CED$Lado, c("1"="Derecha")) 
# df_CED$Lado <- plyr::revalue(df_CED$Lado, c("2"="Izquierda"))
# df_CED$Lado <- plyr::revalue(df_CED$Lado, c("3"="Derecha y Izquierda"))
# df_CED$Lado <- plyr::revalue(df_CED$Lado, c("4"="No aplica"))
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
    "Disponibilidad","Material_Proc_Refl",
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

####  DF_PD I  #### 
# Defining Specific PlayerDimension Data Frame
df_PD <- 
  df_PD_G %>% drop_na() %>% select(-Medición)
# Defining Specific Json's Meters Data Frame
df_Json <- 
  df_PD_G %>% drop_na() %>% select(Medición)
# Condition for NA values
json <- 
  df_Json$Medición #[-which(sapply(df_Json$Medición, is.na))]
# Creating DF's Structutre
df <- 
  data.frame(
    "id" = integer(),
    "name" = character(),
    "value" = double(),
    "TipoMedición" = character(),
    "Jugador" = character(),      
    "Categoría" = character(),             
    "Dimensión" = character(),             
    "FechaDimensión" = character()     
  )
# Triple Loop for Building the whole DT
for (i in (1:length(json))) {
  json_n <-
    json[i] %>%
    jsonlite::fromJSON()
  for (j in (1:length(json_n))) {
    json_df_b <- json_n[[j]] %>%
      jsonlite::fromJSON()
    json_df <- json_df_b[[j]]
    for (k in (1:length(json_df$meters))) {
      json_m <- json_df$meters[[k]] %>%
        as.data.frame() %>%
        mutate("TipoMedición"=json_df$name)
      if (df_PD[i,"Dimensión"] %in% "Masoterápea") { 
        json_m <- json_m %>%
          mutate("value" = 0)
      }
      json_df_c <-
        cbind(json_m,
              df_PD[i,] %>%
                slice(rep(1:n(), each = nrow(json_m))))
      df <- rbind(df,json_df_c)
    }
  }
}
# Renaming, Relocating and Filtering
df_PD <- 
  df %>% 
  select(-id) %>% 
  rename(
    "Medición"=name,
    "ValorMedición"=value
  ) %>% 
  relocate(
    "Jugador", 
    "Categoría",           
    "FechaDimensión",
    "Dimensión",
    "TipoMedición",
    "Medición",
    "ValorMedición"
  )  
# Removing NA
df_PD <- df_PD %>% filter(!ValorMedición == "")
# Merging DFs
df_PD <- 
  df_PD %>% 
  rbind(
    df_DM %>% 
      rename(
        "Medición"=TipoMedición,
        "TipoMedición"=MomentoMedición,
        "FechaDimensión"=FechaMedición
      ) %>%
      mutate(Dimensión="Mediciones Diarias") %>%
      relocate(
        Jugador,
        Categoría,
        FechaDimensión,
        Dimensión,
        TipoMedición,
        Medición,
        ValorMedición
      ) %>%
      select(!c(Posición,Peso,Estatura,Lateralidad))
  )
####  df_PD_F  #### 
df_PD_F <- 
  rbind(
    df_PD %>% 
      filter(
        Dimensión %in% "Masoterápea"
      ),
    df_PD %>% 
      filter(
        Medición %in% "PCR"
      ) %>%
      mutate(
        PCR = df_PD %>%
          filter(
            Medición %in% "PCR"
          ) %>% 
          pull(ValorMedición) %>%
          recode(
            "0"="Negativo",
            "1"="Positivo"
          )
      ) %>%
      select(!ValorMedición) %>%
      rename(ValorMedición=PCR)
  )
df_PD_F$Categoría <- df_PD_F$Categoría %>% as.factor()
df_PD_F$Jugador <- df_PD_F$Jugador %>% as.factor()
df_PD_F$FechaDimensión <- df_PD_F$FechaDimensión %>% as.Date()
df_PD_F$TipoMedición <- df_PD_F$TipoMedición %>% as.factor()
df_PD_F$Medición <- 
  gsub("\\s*\\([^\\)]+\\)","",
       as.character(df_PD_F$Medición)) %>% as.factor()
df_PD_F$Medición <- df_PD_F$Medición %>% as.factor()
df_PD_F$ValorMedición <- df_PD_F$ValorMedición %>% as.factor()
####  DF_PD II  #### 
df_PD <- 
  df_PD %>% 
  filter(
    !Dimensión %in% "Masoterápea",
    !Medición %in% "PCR"
  )
df_PD$ValorMedición <- df_PD$ValorMedición %>% as.numeric()
df_PD$Categoría <- df_PD$Categoría %>% as.factor()
df_PD$Jugador <- df_PD$Jugador %>% as.factor()
df_PD$FechaDimensión <- df_PD$FechaDimensión %>% as.Date()
df_PD$TipoMedición <- df_PD$TipoMedición %>% as.factor()
df_PD$Medición <- df_PD$Medición %>% as.factor()
df_PD$Medición <- 
  gsub("\\s*\\([^\\)]+\\)","",
       as.character(df_PD$Medición)) %>% as.factor()
df_PD$Dimensión <- df_PD$Dimensión %>% as.factor()
df_PD <- df_PD %>% drop_na() %>% filter(ValorMedición >= 0)

####  DF_TL  #### 
# Deifning Nature
df_TL$TimeLoss <- df_TL$TimeLoss %>% as.numeric()
df_TL$Jugador <- df_TL$Jugador %>% as.factor()
df_TL$Categoría <- df_TL$Categoría %>% as.factor()
df_TL$Diagnóstico <- df_TL$Diagnóstico %>% as.factor()
df_TL$Momento <- df_TL$Momento %>% as.factor()
df_TL$FechaTérmino_TimeLoss <- df_TL$FechaTérmino_TimeLoss %>% as.Date()
# Final DF
df_TL <- 
  df_TL %>% 
  drop_na() %>% 
  mutate(
    Severidad = case_when(
      TimeLoss > 28 ~ "Severa",
      TimeLoss >= 8 & TimeLoss <= 28 ~ "Moderada",
      TimeLoss >= 4 & TimeLoss < 8 ~ "Leve",
      TimeLoss >= 1 & TimeLoss < 4 ~ "Mínima",
      TimeLoss == 0 ~ "Sin ausencia"
      )
    ) 
# # Severity Loop
# for (i in seq(1,nrow(df_TL))) {
#   if (df_TL[i,"TimeLoss"] > 28) {
#     df_TL[i,"Severidad"] <- "Severa"
#   } else if (df_TL[i,"TimeLoss"] >= 8) {
#     df_TL[i,"Severidad"] <- "Moderada"
#   } else if (df_TL[i,"TimeLoss"] >= 4) {
#     df_TL[i,"Severidad"] <- "Leve"
#   } else if (df_TL[i,"TimeLoss"] >= 1) {
#     df_TL[i,"Severidad"] <- "Mínima"
#   } else {
#     df_TL[i,"Severidad"] <- "Sin ausencia"
#   }
# }

####  DF_KT  #### 
# Deifning Nature
df_KT$FechaTratamientoKinésico[df_KT$FechaTratamientoKinésico  == "NULL"] <- NA
df_KT$Jugador <- df_KT$Jugador %>% as.factor()
df_KT$Categoría <- df_KT$Categoría %>% as.factor()
df_KT$FechaTratamientoKinésico <- df_KT$FechaTratamientoKinésico %>% as.Date()
df_KT <- 
  df_KT %>%
  mutate(
    TratamientoKinésico = case_when(
      stringr::str_detect(TratamientoKinésico, "fria") ~ "Inmersión Agua Fría",
      stringr::str_detect(TratamientoKinésico, "fría") ~ "Inmersión Agua Fría",
      stringr::str_detect(TratamientoKinésico, "hielo") ~ "Inmersión Agua Fría",
      stringr::str_detect(df_KT$TratamientoKinésico, "Quiropraxia")  ~ "Quiropraxia",
      stringr::str_detect(df_KT$TratamientoKinésico, "quiropraxia")  ~ "Quiropraxia",
      stringr::str_detect(df_KT$TratamientoKinésico, "quiropráctico")  ~ "Quiropraxia",
      stringr::str_detect(df_KT$TratamientoKinésico, "quiropractico")  ~ "Quiropraxia",
      stringr::str_detect(df_KT$TratamientoKinésico, "Vendaje")  ~ "Taping",
      stringr::str_detect(df_KT$TratamientoKinésico, "Taping")  ~ "Taping",
      stringr::str_detect(df_KT$TratamientoKinésico, "taping")  ~ "Taping",
      stringr::str_detect(df_KT$TratamientoKinésico, "Lib")  ~ "Lib Miofascial",
      stringr::str_detect(df_KT$TratamientoKinésico, "lib")  ~ "Lib Miofascial",
      stringr::str_detect(TratamientoKinésico, "Activación") ~ "Activación",
      stringr::str_detect(TratamientoKinésico, "activación") ~ "Activación",
      stringr::str_detect(df_KT$TratamientoKinésico, "Vacuna")  ~ "Vacuna",
      stringr::str_detect(TratamientoKinésico, "Podología") ~ "Podología"
    ) %>% 
      as.factor()
  ) %>%
  filter(!is.na(ID_TratamientoKinésico)) %>%
  select(!ID_Diagnóstico)

####  DF_KA  #### 
# Deifning Nature
df_KA$FechaAcciónKinésica[df_KA$FechaAcciónKinésica  == "NULL"] <- NA
df_KA$Jugador <- df_KA$Jugador %>% as.factor()
df_KA$Categoría <- df_KA$Categoría %>% as.factor()
df_KA$FechaAcciónKinésica <- df_KA$FechaAcciónKinésica %>% as.Date()
df_KA <- 
  df_KA %>%
  mutate(
    AcciónKinésica = case_when(
      stringr::str_detect(AcciónKinésica, "fria") ~ "Inmersión Agua Fría",
      stringr::str_detect(AcciónKinésica, "fría") ~ "Inmersión Agua Fría",
      stringr::str_detect(AcciónKinésica, "hielo") ~ "Inmersión Agua Fría",
      stringr::str_detect(df_KA$AcciónKinésica, "Quiropraxia")  ~ "Quiropraxia",
      stringr::str_detect(df_KA$AcciónKinésica, "quiropraxia")  ~ "Quiropraxia",
      stringr::str_detect(df_KA$AcciónKinésica, "quiropráctico")  ~ "Quiropraxia",
      stringr::str_detect(df_KA$AcciónKinésica, "quiropractico")  ~ "Quiropraxia",
      stringr::str_detect(df_KA$AcciónKinésica, "Vendaje")  ~ "Taping",
      stringr::str_detect(df_KA$AcciónKinésica, "Taping")  ~ "Taping",
      stringr::str_detect(df_KA$AcciónKinésica, "taping")  ~ "Taping",
      stringr::str_detect(df_KA$AcciónKinésica, "Lib")  ~ "Lib Miofascial",
      stringr::str_detect(df_KA$AcciónKinésica, "lib")  ~ "Lib Miofascial",
      stringr::str_detect(AcciónKinésica, "Activación") ~ "Activación",
      stringr::str_detect(AcciónKinésica, "activación") ~ "Activación",
      stringr::str_detect(df_KA$AcciónKinésica, "Vacuna")  ~ "Vacuna",
      stringr::str_detect(AcciónKinésica, "Podología") ~ "Podología"
    ) %>% 
      as.factor()
  ) %>%
  filter(!is.na(ID_AcciónKinésica)) %>%
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



## Defining specific Objects
date.range <- 
  seq.Date(
    from = Sys.Date() - 60,
    to = Sys.Date(),
    by = "day"
    )

####  TEXTS  #### 
## Header Logo
customLogo <- shinyDashboardLogoDIY(
  boldText = "RA"
  ,mainText = "    v1.0"
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
    width: 600px;
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
rm(con,df,json,json_n,df_Json,json_df,json_m,json_df_b,json_df_c,df_PD_G,df_DM)
