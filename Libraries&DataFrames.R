

####  Importing Libraries and Data Frames source("Libraries&DataFrames.R")

## Importing Libraries
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


### Importing xlsx
df_CED <- xlsx::read.xlsx(
  "Data/ClinicalEvent.xlsx", sheetIndex = 1, header=TRUE, encoding="UTF-8"
) %>% 
  as.data.frame() 
df_PD <- xlsx::read.xlsx(
  "Data/PlayerDimension.xlsx", sheetIndex = 1, header=TRUE, encoding="UTF-8"
) %>% as.data.frame()


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


## df_PD
# Defining Nature
df_PD$Categoría <- df_PD$Categoría %>% as.factor()
df_PD$Jugador <- df_PD$Jugador %>% as.factor()
df_PD$FechaDimensión <- df_PD$FechaDimensión %>% as.Date()
df_PD$Dimensión <- df_PD$Dimensión %>% as.factor()
df_PD$TipoMedición <- df_PD$TipoMedición %>% as.factor()
df_PD$Medición <- df_PD$Medición %>% as.factor()
df_PD$ValorMedición <- df_PD$ValorMedición %>% as.numeric()
# Removing NA
df_PD <- df_PD %>% tidyr::drop_na() 


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
    border-right: 1.3px solid #050505F2;
  }
  .skin-black .main-header .navbar {
    background-color: #FFFFFF;
    border-bottom: 1.3px solid #050505F2;
  }
  .skin-black .main-header .logo {
    font-weight: bold;
    color: #FFFFFF;
    background: #050505F2;
  }
  .skin-black .main-header .logo:hover {
    font-weight: bold;
    color: #FFFFFF;
    background-color: #050505F2;
  }
  .skin-black .main-sidebar { 
    background-color: #050505F2;
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
    background: linear-gradient(35deg, #050505F2, #00C0EF);
  }
  
  /*     Others     */ 
  
  .shiny-output-error-validation {
    visibility: hidden; 
  }
  .shiny-output-error { 
    visibility: hidden; 
  }
  .shiny-output-error:before { 
    visibility: hidden; 
  }
  
  
  "



# /*     Table     */ 
#   
#   .dataTable tbody tr:hover {
#     background: linear-gradient(35deg, #050505F2, #00C0EF);
#                                 color: #FFFFFF;
#   } 

# .primary-box {
#   padding-left: 0px; 
# } 
# .primary-box-icon {
#   padding-left: 0px; 
# } 
# .primary-box-content {
#   padding-left: -2px; 
# } 

# .navbar-nav > dropdownBlock  {
#   background-color: black;
#   box-shadow: 10px 10px 10px darkgrey;

# .shiny-output-error-validation {
#   color: #2FB4CC; 
#     font-size: 15px; 
#   font-weight: bold; 
#   text-align: center
# }
















