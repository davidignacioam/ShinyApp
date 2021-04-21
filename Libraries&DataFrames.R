

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
  user = "reconquer-api",
  password = "024C18f18683A8bed5ec$",
  dbname = "reconquerdb",
  host = "triceps-reconquer-rds-qa.cbubsie7wfl3.us-east-1.rds.amazonaws.com",
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
df_MD <- 
  dbGetQuery(
    con,
    "
    ##############  MEDICIONES DIARIAS  ##############
    
    SELECT 
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
    LEFT JOIN user us ON us.id = pl.id_user AND us.deleted = 0
    LEFT JOIN user_type ust ON ust.id = us.id_user_type 
    LEFT JOIN category_type ct ON pl.id_category_type = ct.id
    LEFT JOIN position_type pt ON pl.id_position_type = pt.id
    # Mediciones Diarias
    LEFT JOIN daily_measurements dm ON dm.id_player = pl.id AND dm.deleted = 0
    LEFT JOIN measurement_type mt ON mt.id = dm.measurement_type  
    
    WHERE pl.deleted = 0 
    ;
    "
  ) %>% as.data.frame()
# Disconnection
dbDisconnect(con)


### Data Transformation

## DF_MD
# Removing NA
df_MD <- df_MD %>% tidyr::drop_na() 
# Defining Nature
df_MD$FechaMedición <- df_MD$FechaMedición %>% as.Date()
df_MD$ValorMedición <- df_MD$ValorMedición %>% as.numeric()
df_MD$MomentoMedición <- df_MD$MomentoMedición %>% as.factor()
df_MD$TipoMedición <- df_MD$TipoMedición %>% as.factor()
df_MD$Lateralidad <- df_MD$Lateralidad %>% as.factor()
df_MD$Categoría <- df_MD$Categoría %>% as.factor()
df_MD$Posición <- df_MD$Posición %>% as.factor()
df_MD$Jugador <- df_MD$Jugador %>% as.factor()
# Defining specific Objects
date.range_tab1 <- seq.Date(from=Sys.Date()-60,to=Sys.Date(),by="day")

## DF_CED
# Creating NULL values
df_CED[is.na(df_CED)] <- "NULL"
# Reading Columns as Factors
for (i in 1:ncol(df_CED)) {
  df_CED[,i] <- df_CED[,i] %>% as.factor()
}
# Defining Nature
df_CED$FechaDiagnóstico <- df_CED$FechaDiagnóstico %>% as.Date()
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
df_CED$Lado <- plyr::revalue(df_CED$Lado, c("1"="Derecha")) 
df_CED$Lado <- plyr::revalue(df_CED$Lado, c("2"="Izquierda"))
df_CED$Lado <- plyr::revalue(df_CED$Lado, c("3"="Derecha y Izquierda"))
df_CED$Lado <- plyr::revalue(df_CED$Lado, c("4"="No aplica"))
# Selecting Variables
df.S.1 <- 
  select(
    df_CED,
    # Formulario Diagnóstico
    "Categoría_I","Categoría_II","Diagnóstico",
    "Complemento_I","Complemento_II","Lado",
    "Disponibilidad","Material_Proc_Refl",
    # Mecanismo Lesión
    "InstanciaPartido","Presentación",
    "MecanismoEspecífico","MecanismoGeneral",
    # Distribución Lesiones
    "ZonaCorporal","RegiónCorporal",
    "Agrupación"
  )
df.S.2 <- 
  c(
    # Formulario Diagnóstico
    "Categoría_I","Categoría_II","Diagnóstico",
    "Complemento_I","Complemento_II","Lado",
    "Disponibilidad","Material_Proc_Refl",
    # Mecanismo Lesión
    "InstanciaPartido","Presentación",
    "MecanismoEspecífico","MecanismoGeneral",
    # Distribución Lesiones
    "ZonaCorporal","RegiónCorporal",
    "Agrupación"
)

### Text
## Header Logo
customLogo <- shinyDashboardLogoDIY(
  boldText = "ReConquer Analytics"
  ,mainText = "v1.0"
  ,textSize = 16
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
## Notifications
not1 <- 
  HTML('
  <center>
  <i class="far fa-address-card fa-2x center" style="color:#1C70D6;"></i>
  <i class="far fa-calendar-alt fa-2x center" style="color:#1C70D6;"></i>
  <h5><strong>Selecciona el Plantel (o Jugador) e intervalo de Fecha de interés, 
  <br> ya que ambos filtros se aplicarán a todas las Visualizaciones.</strong></h5>
  </center>
       ')
not2 <- 
  HTML('
  <center>
  <i class="fas fa-mouse-pointer fa-2x center" style="color:#1C70D6;"></i>
  <h5><strong>Selecciona las Variables o Atributos de interés
  <br> que te permitirán sacar el máximo potencial a los datos.</strong></h5>
  </center>
       ')
not3 <- 
  HTML('
  <center>
  <i class="fas fa-question-circle fa-2x center" style="color:#1C70D6;"></i>
  <h5><strong>Este símbolo te permite acceder a información 
  <br> sobre lDescripción, Utilidad y Ejemplo de la Visualización 
  <br> en el cual se ubica el botón.</strong></h5>
  </center>
       ')
not4 <- 
  HTML('
  <center>
  <i class="fas fa-file-alt fa-2x center" style="color:#1C70D6;"></i>
  <h5><strong>Este símbolo te permite acceder a información 
  <br> sobre las Variables que componen la Selección 
  <br> en el cual se ubica el botón.</strong></h5>
  </center>
       ')
not5 <- 
  HTML('
  <center>
  <i class="fas fa-sliders-h fa-2x center" style="color:#1C70D6;"></i>
  <h5><strong>Este símbolo te permite acceder 
  <br>a la Selección de las Variables que forman la Visualización.</strong></h5>
  </center>
       ')


### CSS code
css <- "
  .skin-blue .main-sidebar {background-color: #FFFFFF;} 
  
  .navbar-nav > .messages-menu > .dropdown-menu > li.header, 
  .navbar-nav > .notifications-menu > .dropdown-menu > li.header, 
  .navbar-nav > .tasks-menu > .dropdown-menu > li.header {
      border-top-left-radius: 0px;
      border-top-right-radius: 0px;
      border-bottom-right-radius: 0;
      border-bottom-left-radius: 0;
      background-color: #FFFFFF;
      padding: 10px 10px;
      border-bottom: 0px solid #F2F2F2;
      color: #ffffff; font-size: 1px;
  }
      
  .content-wrapper, 
  .right-side {
  background-color: #F5F5F5;
  }
      
  .skin-blue .box {
  font-size: 14px;
  border-top: none;
  border-radius: 1px;
  box-shadow: 4px 4px 4px rgb(0 0 0 / 20%);
  }
  
  # .skin-blue .box:hover {box-shadow: 6px 6px 6px rgb(0 0 0 / 40%);}
  
  .navbar-custom-menu>.navbar-nav>li>.dropdown-menu {
  width:450px
  }
       
  .shiny-output-error-validation {
  color: #2FB4CC; 
  font-size: 15px; 
  font-weight: bold; 
  text-align: center
  }
  "















