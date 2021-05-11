

####  Importing Libraries and Data Frames source("Libraries&DataFrames.R")

## Importing Libraries
# SQL
library(DBI)
library(RMySQL)
# Shiny
library(shiny) # General interface
library(shinythemes) # Some Shiny themes
library(shinyWidgets) # Some Widgets
library(shinycssloaders) # For using css syntax
library(shinydashboard) # For the general Structure
library(dashboardthemes) # For customized logo
library(shinydashboardPlus) # For boxPlus()
library(shinymanager) # For Login
# Time
library(lubridate)
# Cluster
library(factoextra)
# Statistics
library(EnvStats) # For cv()
library(stats) # For describe()
library(psych)
library(ppcor) # For partical correlation pcor()
library(Hmisc) # For normal correlarion rcorr()
# Visualization
library(ggplot2) # General Graphics
library(plotly) # For interactive interfaces
library(ggthemes) # Some ggplot() themes
library(ggridges) # For geom_density_ridges()
library(ggpubr) # For cor()
library(GGally) # For ggpairs
library(psych) # For pairs.panels()
library(viridis) # For Colors
library(corrr) # For Networks
library(ggcorrplot) # For ggcorrplot()
library(PerformanceAnalytics) # For chart.Correlation()
library(ggalluvial) # For geom_alluvium()
library(ggradar)
# Data Manipulation
library(dplyr) # For select, arrange and many others
library(DT) # For datatable()
library(janitor) # For rownames_to_column()
# Others
library(xlsx) # For ecporting. xlsx files

## SQL 
# Connection
con <- dbConnect(
  drv = RMySQL::MySQL(),
  user = "",
  password = "",
  dbname = "",
  host = "",
  Trusted_Connection = "True"
)
# Encodin UTF-8 in SQL
dbSendQuery(con, "SET NAMES utf8")
# Creating the Data Frame
df_CED <- 
  dbGetQuery(
    con,
    "
    ##############  DIAGNÓSTICOS Y EVENTO CLÍNICO  ##############
  
    SELECT 
    # Jugador
    concat(us.name,' ',us.last_name) AS Jugador,
    pl.birthday AS FechaNacimiento,
    if (pl.side=1,'Diestro','Zurdo') AS Lateralidad,
    pl.height AS Estatura,
    pl.initial_weight AS Peso,
    ct.name_category AS Categoría,
    pt.name_position AS Posición,
    # Evento Clínico
    ce.id AS ID_EventoClínico,
    ins.name AS Instancia,
    mm.name AS InstanciaPartido,
    sev.name AS Presentación,
    smc.name AS MecanismoEspecífico,
    gmc.name AS MecanismoGeneral,
    # Diagnóstico
    dg.id AS ID_Diagnóstico,
    dg.side AS Lado,
    dgt.name AS Categoría_I,
    sdg.name AS Categoría_II,
    pa.name AS Diagnóstico,
    act.name_availability_condition_type AS Disponibilidad,
    pm.name AS Material_Proc_Refl,
    dgc.name AS Complemento_I,
    sm.name AS Complemento_II,
    gr.name AS Agrupación,
    bz.name AS ZonaCorporal,
    br.name AS RegiónCorporal,
    dg.created AS FechaDiagnóstico,
    # Medicina
    med.id AS ID_Medicamento,
    med.name AS Medicamento,
    medc.name AS ClasificaciónMed,
    # Tratamiento Kinésico 
    kt.id AS ID_TratamientoKinésico,
    kt.text AS TratamientoKinésico,
    kt.created AS FechaTratamientoKinésico,
    # Objetivo Evaluación
    eo.id AS ID_ObjetivoEvaluación,
    eo.text AS ObjetivoEvaluación,
    eo.created AS FechaObjetivoEvaluación
      
    FROM player pl 
    
    # Jugador
    LEFT JOIN user us ON us.id = pl.id_user 
      AND us.deleted = 0
      AND us.id_user_type = 12
      AND us.tenant_code = 'TRICEPS'
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    LEFT JOIN position_type pt ON pl.id_position_type = pt.id	
    # Evento Clínico
    LEFT JOIN clinical_event ce ON pl.id = ce.id_player 
      AND ce.deleted = 0 
      AND ce.tenant_code = 'TRICEPS'
    LEFT JOIN instance ins ON ins.id = ce.id_instance
    LEFT JOIN match_moment mm ON mm.id = ce.id_match_moment
    LEFT JOIN severity sev ON sev.id = ce.id_severity
    LEFT JOIN specific_mechanism smc ON smc.id = ce.id_specific_mechanism
    LEFT JOIN general_mechanism gmc ON gmc.id = ce.id_general_mechanism
    # Diagnóstico
    LEFT JOIN diagnostic dg ON ce.id = dg.id_clinical_event 
      AND dg.deleted = 0
      AND dg.tenant_code = 'TRICEPS'
    LEFT JOIN diagnostic_type dgt ON dgt.id = dg.id_diagnostic_type
    LEFT JOIN sub_diagnostic sdg ON sdg.id = dg.id_sub_diagnostic
    LEFT JOIN pathology pa ON pa.id = dg.id_pathology
    LEFT JOIN diagnostic_complement dgc ON dgc.id = dg.id_diagnostic_complement
    LEFT JOIN procedure_material pm ON pm.id = dg.id_procedure_material
    LEFT OUTER JOIN diagnostic_availability dga ON dga.id_diagnostic = dg.id 
      AND dga.deleted = 0
      AND dga.tenant_code = 'TRICEPS'
    LEFT JOIN availability_condition ac ON ac.id = dga.id_availability_condition
      AND ac.deleted = 0
      AND ac.tenant_code = 'TRICEPS'
    LEFT JOIN availability_condition_type act ON ac.id_availability_condition_type = act.id
    # Músculo Esquelétio
    LEFT JOIN skeletal_muscle sm ON sm.id = dg.id_skeletal_muscle
    LEFT JOIN grouper gr ON gr.id = sm.id_grouper
    LEFT JOIN body_zone bz ON bz.id = sm.id_body_zone
    LEFT JOIN body_region br ON br.id = bz.id_body_region
    # Medicina
    LEFT JOIN diagnostic_medicine dgm ON dgm.id_diagnostic = dg.id 
      AND dgm.deleted = 0
      AND dgm.tenant_code = 'TRICEPS'
    LEFT JOIN medicine med ON med.id = dgm.id_medicine
    LEFT JOIN medicine_classification medc ON medc.id = dgm.id_medicine_classification
    LEFT JOIN medicine_via medv ON medv.id = dgm.id_medicine_via
    # Otros
    LEFT JOIN kinesic_treatment kt ON kt.id_diagnostic = dg.id 
      AND kt.deleted = 0
      AND kt.tenant_code = 'TRICEPS'
    LEFT JOIN evaluation_objective eo ON eo.id_diagnostic = dg.id 
      AND eo.deleted = 0
      AND eo.tenant_code = 'TRICEPS'
    
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'TRICEPS'
    ;
    "
  ) %>% as.data.frame() 
# Creating General PlayerDimension Data Frame
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
      AND us.tenant_code = 'TRICEPS'
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    # Dimensiones de Jugador
    LEFT JOIN player_dimension pldm ON pl.id = pldm.id_player 
      AND pldm.deleted = 0
      AND us.tenant_code = 'TRICEPS'
    LEFT JOIN dimension dm ON dm.id = pldm.id_dimension
      AND dm.tenant_code = 'TRICEPS'
      
    WHERE pl.deleted = 0 
      AND pl.tenant_code = 'TRICEPS'
      
    ;
    "
  )
# Disconnection
dbDisconnect(con)

### Data Transformation

## DF_CED
# Reading Columns as Factors
for (i in 1:ncol(df_CED)) {
  df_CED[,i] <- df_CED[,i] %>% as.factor()
}
# Date Vasriasbles
df_CED <- df_CED %>% mutate(Edad = FechaNacimiento %>% as.Date() %>% eeptools::age_calc(units='years') %>% round(0)) 
df_CED$FechaDiagnóstico <- df_CED$FechaDiagnóstico %>% as.Date()
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

## DF_PD
# Defining Specific PlayerDimension Data Frame
df_PD <- 
  df_PD_G %>% select(-Medición)
# Defining Specific Json's Meters Data Frame
df_Json <- 
  df_PD_G %>% select(Medición)
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
    json_df <- json_n[[j]]
    for (k in (1:length(json_df$meters))) {
      json_m <- json_df$meters[[k]] %>% 
        as.data.frame() %>% 
        mutate("TipoMedición"=json_df$name)
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
  ) %>% 
  filter(Medición != "PCR") 
# Removing NA
df_PD <- df_PD %>% tidyr::drop_na() 
# Defining Nature
df_PD$Categoría <- df_PD$Categoría %>% as.factor()
df_PD$Jugador <- df_PD$Jugador %>% as.factor()
df_PD$FechaDimensión <- df_PD$FechaDimensión %>% as.Date()
df_PD$Dimensión <- df_PD$Dimensión %>% as.factor()
df_PD$TipoMedición <- df_PD$TipoMedición %>% as.factor()
df_PD$Medición <- df_PD$Medición %>% as.factor()
df_PD$ValorMedición <- df_PD$ValorMedición %>% as.numeric()

## Defining specific Objects
date.range <- seq.Date(from=Sys.Date()-60,to=Sys.Date(),by="day")

### Text
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
  "ERROR: No existen suficientes registros de esta Medición en este rango de Tiempo para poder generar la Visualización"
na.cl.com <- 
  "ERROR: No hay suficientes mediciones de este jugador para poder generar la comparación."
## Notifications
not1 <- 
  HTML('
  <center>
  <i class="far fa-address-card fa-2x center" style="color:#00C0EF;"></i>
  <i class="far fa-calendar-alt fa-2x center" style="color:#00C0EF;"></i>
  <h5><strong>Selecciona el Plantel (o Jugador) e intervalo de Fecha de interés, ya que ambos filtros se aplicarán a todas las Visualizaciones.</strong></h5>
  </center>
       ')
not2 <- 
  HTML('
  <center>
  <i class="fas fa-mouse-pointer fa-2x center" style="color:#00C0EF;"></i>
  <h5><strong>Selecciona la Pestaña y las Variables o Atributos de interés que te permitirán sacar el máximo potencial a los datos.</strong></h5>
  </center>
       ')
not3 <- 
  HTML('
  <center>
  <i class="fas fa-question-circle fa-2x center" style="color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite acceder a información sobre la Descripción, Utilidad y Ejemplo de la Visualización en el cual se ubica el botón.</strong></h5>
  </center>
       ')
not4 <- 
  HTML('
  <center>
  <i class="fas fa-file-alt fa-2x center" style="color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite acceder a información sobre las Variables que componen la Selección en el cual se ubica el botón.</strong></h5>
  </center>
       ')
not5 <- 
  HTML('
  <center>
  <i class="fas fa-sliders-h fa-2x center" style="color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite acceder a la Selección de las Variables que forman la Visualización.</strong></h5>
  </center>
       ')

### CSS
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
    box-shadow: 6px 6px 6px rgb(0 0 0 / 40%);
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

