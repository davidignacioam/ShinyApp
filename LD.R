

####  I. SETTINGS  #### 

####  LIBRARIES  #### 
# SQL
library(DBI)
library(RMySQL)
# Shiny
library(shiny) # General interface
library(shinyWidgets) # Some Widgets
library(shinycssloaders) # For withSpinner()
library(fresh) # For shiny colors
library(shinydashboard) # For the general Structuress
library(dashboardthemes) # For customized logo
library(shinymanager) # For Login
library(shinybusy) # Loading modal
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
library(RColorBrewer) # For colors
#display.brewer.all()
# Data Manipulation
library(janitor) # For rownames_to_column()
library(tidyr) # For drop NA & Spread
library(dplyr) # For select, arrange, filter and many others
# R Markdown
library(rmarkdown)
library(rmdformats)
library(knitr) # For pretty table interfaces
library(kableExtra) # For scroll_boxs
# Others
library(xlsx) # For write.xlsx()
library(rdrop2) # For Dropbox connection
library(emayili) # For sending emails
library(emojifont)
load.fontawesome()


## Staring Time
start_tenant_time <- 
  Sys.time()


####  Dropbox Token  #### 
drop_auth(rdstoken = "dropbox_token.rds")


####  TENANT  #### 
## Value
tenant <- "some_tenant"

####  DATE  #### 

## Variables
line_with_bar <- 0
line_with_point <- .6

## Loop
date_filter <- 
  Sys.Date() - 4

## Selector
# Team
if (tenant == "some_tenant") {
  date_range <- 
    seq.Date(
      from = Sys.Date() - 15,
      to = Sys.Date(),
      by = "day"
    )
} else {
  date_range <- 
    seq.Date(
      from = Sys.Date() - 60,
      to = Sys.Date(),
      by = "day"
    )
}


####  FUNCTIONS  #### 

## Dropbox Download
dropboxDownload <- function(tenant, object) {
  drop_download(stringr::str_glue('ReConquer/R Data/{tenant}/{object}', 
                                  local_path = ""), 
                overwrite = TRUE)
}

## Dropbox Upload
dropboxUpload <- function(tenant, object) {
  drop_upload(stringr::str_glue("{object}"), 
              stringr::str_glue("ReConquer/R Data/{tenant}/"), 
              mode = "overwrite")
}

## Empty Chart
emptyChart <- function(message) {
  df <- 
    data.frame(Col1 = 1, Col2 = 0)
  ggplotly(
    ggplot(df, aes(x = Col1, y = Col2)) +
      geom_line() +
      labs(x = NULL, y = NULL, fill = NULL) +
      theme(
        axis.text.x = element_text(color="white"),
        axis.ticks.x = element_blank(), 
        panel.grid.major.x = element_blank(),
        axis.text.y = element_text(color="white"),
        axis.ticks.y = element_blank(), 
        # panel.grid.major.y = element_blank(),
        panel.grid.major = element_line(colour="#00000018"),
        panel.grid.minor = element_line(colour="#00000018"),
        panel.background = element_rect(fill="transparent", colour=NA)
      ),
    tooltip = c("x")
  ) %>% 
    add_annotations(
      x = 1,
      y = 0,
      text = message,
      showarrow = FALSE
    ) %>%
    config(collaborate = F, doubleClick = F, displayModeBar = FALSE)
}

## Empty Message
emptyMessage <- function(variable) {
  paste(
    "No se registran suficientes datos de <br> <b>", 
    variable, 
    "</b> <br> para generar la Visualización"
  )
}

## groupBarPlot
groupBarPlot <- function(df) {
  
  if (nrow(filter(df, Cantidad != 0)) == 0) {
    
    emptyChart(
      "<b>No hay Registros Disponibles</b>"
    )
    
  } else {
    
    ggplotly(
      ggplot(df, aes(x=Complemento_II, y=Cantidad, fill=Complemento_II)) +
        geom_bar(
          stat="identity", 
          alpha=.7, color="black",
          width=.7, size=.3
        ) +
        scale_y_continuous(
          limits = c(0, ifelse(max(df$Cantidad) == 0,3,max(df$Cantidad))),
          breaks = seq(1,ifelse(max(df$Cantidad) == 0,3,max(df$Cantidad)),
                       ifelse(max(df$Cantidad)>4,2,1))
        ) +
        labs(x=NULL, y=NULL, fill=NULL) +
        #scale_fill_brewer(palette = "Set1") +
        #scale_fill_brewer(palette = "Paired") +
        theme(axis.text.x=element_text(angle=45, hjust=1, 
                                       color=ifelse(sum(df$Cantidad) == 0,"white","black")),
              panel.grid.major.x = element_blank(),
              panel.grid.major=element_line(colour="#00000018"),
              panel.grid.minor=element_line(colour="#00000018"),
              panel.background=element_rect(fill="transparent",colour=NA)),
      tooltip = c("x","y")
    ) 
    
  }
  
}

## Value Box General
createValueBoxes_G <- function(df, h = 4, w = 6, padding=0.5, rows = 2){
  # verify our inputs
  if (!is.data.frame(df)) {
    stop(paste("Argument", deparse(substitute(df)), "must be a data.frame."))
  }
  if(!all(i <- rlang::has_name(df,c("values", "infos", "icons")))){
    stop(sprintf(
      "%s does not contain: %s",
      deparse(substitute(df)),
      paste(columns[!i], collapse=", ")))
  }
  boxes = nrow(df) # number of items passed
  # calculate the grid
  cols = boxes/rows
  plotdf <- data.frame(
    x = rep(seq(0, (w+padding)*cols-1, w+padding), times=rows),
    y = rep(seq(0, (h+padding)*rows-1, h+padding), each=cols),
    h = rep(h, boxes),
    w = rep(w, boxes),
    value = df$values,
    info = df$infos,
    icon = fontawesome(df$icons),
    font_family = c(rep("fontawesome-webfont", boxes)),
    color = "#1D79C4D6"
  )
  print(plotdf)
  ggplot(plotdf, aes(x, y, height = h, width = w, label = info)) +
    ## Create the tiles using the `color` column
    geom_tile(aes(fill = color)) +
    ## Add the numeric values as text in `value` column
    geom_text(color = "white", fontface = "bold", size = 15,
              aes(label = value, x = x - w/2.2, y = y + h/4), hjust = 0) +
    ## Add the labels for each box stored in the `info` column
    geom_text(size = 6, color = "white", fontface = "bold",
              aes(label = info, x = x - w/2.2, y = y-h/4), hjust = 0) +
    coord_fixed() +
    scale_fill_manual(values=c("#1D79C4D6")) +
    ## Use `geom_text()` to add the icons by specifying the unicode symbol.
    geom_text(size = 30, aes(label = icon, family = font_family,
                             x = x + w/4, y = y + h/8), alpha = 0.25) +
    theme_void() +
    guides(fill = FALSE)
} 

##  Value Box PCR
createValueBoxes_PCR <- function(df, h = 4, w = 6, padding=0.5, rows = 2){
  # verify our inputs
  if (!is.data.frame(df)) {
    stop(paste("Argument", deparse(substitute(df)), "must be a data.frame."))
  }
  if(!all(i <- rlang::has_name(df,c("values", "infos", "icons")))){
    stop(sprintf(
      "%s does not contain: %s",
      deparse(substitute(df)),
      paste(columns[!i], collapse=", ")))
  }
  boxes = nrow(df) # number of items passed
  # calculate the grid
  cols = boxes/rows
  plotdf <- data.frame(
    x = rep(seq(0, (w+padding)*cols-1, w+padding), times=rows),
    y = rep(seq(0, (h+padding)*rows-1, h+padding), each=cols),
    h = rep(h, boxes),
    w = rep(w, boxes),
    value = df$values,
    info = df$infos,
    icon = fontawesome(df$icons),
    font_family = c(rep("fontawesome-webfont", boxes)),
    color = c("#2FC91ED6","#C71E1ED6")
  )
  print(plotdf)
  ggplot(plotdf, aes(x, y, height = h, width = w, label = info)) +
    ## Create the tiles using the `color` column
    geom_tile(aes(fill = color)) +
    ## Add the numeric values as text in `value` column
    geom_text(color = "white", fontface = "bold", size = 15,
              aes(label = value, x = x - w/2.2, y = y + h/4), hjust = 0) +
    ## Add the labels for each box stored in the `info` column
    geom_text(size = 6, color = "white", fontface = "bold",
              aes(label = info, x = x - w/2.2, y = y-h/4), hjust = 0) +
    coord_fixed() +
    scale_fill_manual(values=c("#2FC91ED6","#C71E1ED6")) +
    ## Use `geom_text()` to add the icons by specifying the unicode symbol.
    geom_text(size = 30, aes(label = icon, family = font_family,
                             x = x + w/4, y = y + h/8), alpha = 0.25) +
    theme_void() +
    guides(fill = FALSE)
} 


####  TEXT  #### 
## Header Logo
customLogo <- shinyDashboardLogoDIY(
  boldText = "RA"
  ,mainText = stringr::str_glue(" |{tenant}|")
  ,textSize = 18
  ,badgeText = NULL
  ,badgeTextColor = NULL
  ,badgeTextSize = NULL
  ,badgeBackColor = NULL
  ,badgeBorderRadius = NULL
)
## Notifications
not1 <- 
  HTML('
  <center>
  <i class="fas fa-users fa center" style = "color:#00C0EF;"></i>
  <i class = "far fa-calendar-alt fa center" style = "color:#00C0EF;"></i>
  <h5><strong>Con estos símbolos seleccionas el Plantel e intervalo de Fecha de interés: 
  ambos filtros se aplicarán a todas las Visualizaciones.</strong></h5>
  </center>
  ')
not2 <- 
  HTML('
  <center>
  <i class = "fas fa-mouse-pointer fa center" style = "color:#00C0EF;"></i>
  <h5><strong>Selecciona la Pestaña y las Variables o Atributos de interés 
  que te permitirán sacar el máximo potencial a los datos.</strong></h5>
  </center>
  ')
not3 <- 
  HTML('
  <center>
  <i class = "fas fa-question-circle fa center" style = "color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite acceder a información sobre la Descripción, 
  Utilidad y Ejemplo de la Visualización en el cual se ubica el botón.</strong></h5>
  </center>
  ')
not4 <- 
  HTML('
  <center>
  <i class = "fas fa-file-alt fa center" style = "color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite acceder a información sobre 
  las Variables que componen la Selección en el cual se ubica el botón.</strong></h5>
  </center>
  ')
not5 <- 
  HTML('
  <center>
  <i class = "fas fa-sliders-h fa center" style = "color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite acceder a la Selección de 
  las Variables que forman la Visualización.</strong></h5>
  </center>
  ')
not6 <- 
  HTML('
  <center>
  <i class = "fas fa-download fa center" style = "color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite descargar las Tablas. 
  El ".xlsx" descarga en formato Excel, 
  mientras que el ".csv· descarga en formato CSV.</strong></h5>
  </center>
  ')
not7 <- 
  HTML('
  <center>
  <i class = "fas fa-camera fa center" style = "color:#00C0EF;"></i>
  <h5><strong>Este símbolo te permite descargar las Gráficas. 
  Este se ubica en la parte superior derecha las Visualizaciones.</strong></h5>
  </center>
  ')



####  II. SQL  #### 

####  Connection  #### 
# Types
dbi_PROD <- 
  list()
dbi_QA <- 
  list()
dbi_SAMPLE <- 
  list()
# Current Connection
con <- 
  do.call(
    DBI::dbConnect, 
    dbi_PROD
  )
# Encodin UTF-8 in SQL
dbSendQuery(
  con, 
  "SET NAMES utf8"
)

####  df_PLAYER  #### 
df_PC <- 
  dbGetQuery(
    con,
    stringr::str_glue(
      "
      ##############  LOGIN   ##############

      # Jugador
      SELECT
        pl.id AS ID_Jugador,
        CONCAT(us.name,' ',us.last_name) AS Jugador,
        ct.id AS ID_Categoría,
        ct.name_category AS Categoría
      
      FROM player pl 
        # Jugador
        LEFT JOIN user AS us ON us.id = pl.id_user 
              AND us.deleted = 0
              AND us.id_user_type = 12
              AND us.tenant_code = '{tenant}'
        LEFT JOIN category_type AS ct ON pl.id_category_type = ct.id
      
      WHERE pl.deleted = 0
      
      ;
      "
    )
  ) %>% 
  as.data.frame() %>% 
  drop_na()
####  df_USER  #### 
df_USER <- 
  dbGetQuery(
    con,
    stringr::str_glue(
      "
      ##############  LOGIN   ##############

      SELECT
        us.id AS ID_Usuario,
        CONCAT(us.name,' ',us.last_name) AS Usuario,
        ct.name_category AS Categoría,
        us.email AS Email
      
      FROM user AS us 
        LEFT JOIN user_category_type AS usct 
               ON usct.id_user = us.id 
        LEFT JOIN category_type AS ct 
               ON usct.id_category_type = ct.id
      
      WHERE us.tenant_code = '{tenant}'
      
      ;
      "
    )
  ) %>% 
  as.data.frame() %>% 
  drop_na()
####  df_CED  #### 
df_CED <- 
  dbGetQuery(
    con,
    stringr::str_glue(
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
        dg.comments AS Comentarios,
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
        LEFT JOIN user AS us ON us.id = pl.id_user 
              AND us.deleted = 0
              AND us.id_user_type = 12
              AND us.tenant_code = '{tenant}'
        LEFT JOIN user_type AS ust ON ust.id = us.id_user_type 
        LEFT JOIN category_type AS ct ON pl.id_category_type = ct.id
        LEFT JOIN position_type AS pt ON pl.id_position_type = pt.id	
        # Evento Clínico
        LEFT JOIN clinical_event AS ce ON pl.id = ce.id_player 
              AND ce.deleted = 0 
              AND ce.tenant_code = '{tenant}'
        LEFT JOIN clinical_event_history AS ceh ON ceh.id_clinical_event = ce.id
        LEFT JOIN instance AS ins ON ins.id = ce.id_instance
        LEFT JOIN match_moment AS mm ON mm.id = ce.id_match_moment
        LEFT JOIN severity AS sev ON sev.id = ce.id_severity
        LEFT JOIN specific_mechanism AS smc ON smc.id = ce.id_specific_mechanism
        LEFT JOIN general_mechanism AS gmc ON gmc.id = ce.id_general_mechanism
        # Diagnóstico
        LEFT JOIN diagnostic AS dg ON ce.id = dg.id_clinical_event 
              AND dg.deleted = 0
              AND dg.tenant_code = '{tenant}'
        LEFT JOIN diagnostic_type AS dgt ON dgt.id = dg.id_diagnostic_type
        LEFT JOIN sub_diagnostic AS sdg ON sdg.id = dg.id_sub_diagnostic
        LEFT JOIN pathology AS pa ON pa.id = dg.id_pathology
        LEFT JOIN diagnostic_complement AS dgc ON dgc.id = dg.id_diagnostic_complement
        LEFT JOIN procedure_material AS pm ON pm.id = dg.id_procedure_material
        LEFT OUTER JOIN diagnostic_availability AS dga ON dga.id_diagnostic = dg.id 
              AND dga.deleted = 0
              AND dga.tenant_code = '{tenant}'
        LEFT JOIN availability_condition AS ac ON ac.id = dga.id_availability_condition
              AND ac.deleted = 0
              AND ac.tenant_code = '{tenant}'
        LEFT JOIN availability_condition_type AS act ON ac.id_availability_condition_type = act.id
        # Músculo Esquelétio
        LEFT JOIN skeletal_muscle AS sm ON sm.id = dg.id_skeletal_muscle
        LEFT JOIN grouper AS gr ON gr.id = sm.id_grouper
        LEFT JOIN body_zone AS bz ON bz.id = sm.id_body_zone
        LEFT JOIN body_region AS br ON br.id = bz.id_body_region
      
      WHERE pl.deleted = 0 
        AND pl.tenant_code = '{tenant}'
      
      ;
      "
    )
  ) %>% 
  as.data.frame() 
####  df_CED_TE  #### 
df_CED_TE <- 
  dbGetQuery(
    con,
    stringr::str_glue(
      "
      ##############  DIAGNÓSTICOS Y EVENTO CLÍNICO  ##############
      
      SELECT 
        # Jugador
        CONCAT(us.name,' ',us.last_name) AS Jugador,
        ct.name_category AS Categoría,
        # Diagnóstico
        dg.id AS ID_Diagnóstico,
        DATE(dg.created) AS FechaDiagnóstico,
        dgt.name AS Categoría_I,
        pa.name AS Diagnóstico,
        sm.name AS Complemento_II,
        # Tratamiento Kinésico
        kt.date AS FechaTratamientoKinésico,
        kt.text AS TratamientoKinésico,
        # Evaluación Objetivo
        evob.date AS FechaEvaluaciónObjetivo,
        evob.text AS EvaluaciónObjetivo,
        ins.name AS Instancia
      
      FROM player pl 
        # Jugador
        LEFT JOIN user AS us ON us.id = pl.id_user 
              AND us.deleted = 0
              AND us.id_user_type = 12
              AND us.tenant_code = '{tenant}'
        LEFT JOIN user_type AS ust ON ust.id = us.id_user_type 
        LEFT JOIN category_type AS ct ON pl.id_category_type = ct.id
        # Evento Clínico
        LEFT JOIN clinical_event AS ce ON pl.id = ce.id_player 
              AND ce.deleted = 0 
              AND ce.tenant_code = '{tenant}'
        LEFT JOIN instance AS ins ON ins.id = ce.id_instance
        # Diagnóstico
        LEFT JOIN diagnostic AS dg ON ce.id = dg.id_clinical_event 
              AND dg.deleted = 0
              AND dg.tenant_code = '{tenant}'
        LEFT JOIN pathology AS pa 
             ON pa.id = dg.id_pathology
        LEFT JOIN diagnostic_type AS dgt ON dgt.id = dg.id_diagnostic_type
        LEFT JOIN diagnostic_complement AS dgc ON dgc.id = dg.id_diagnostic_complement
        # Músculo Esquelétio
        LEFT JOIN skeletal_muscle AS sm ON sm.id = dg.id_skeletal_muscle
        # Tratamiento Kinésico
        LEFT JOIN kinesic_treatment AS kt ON kt.id_diagnostic = dg.id 
              AND kt.deleted = 0
              AND kt.tenant_code = '{tenant}'
        # Evaluación Objetivo
        LEFT JOIN evaluation_objective AS evob ON dg.id = evob.id_diagnostic
       
      WHERE pl.deleted = 0 
        AND pl.tenant_code = '{tenant}'
      
      ;
      "
    )
  ) %>% 
  as.data.frame() 
####  df_KT  #### 
df_KT <- 
  dbGetQuery(
    con,
    stringr::str_glue(
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
        LEFT JOIN user AS us ON us.id = pl.id_user 
              AND us.deleted = 0
              AND us.id_user_type = 12
              AND us.tenant_code = '{tenant}' 
        LEFT JOIN user_type AS ust ON ust.id = us.id_user_type 
        LEFT JOIN category_type AS ct ON pl.id_category_type = ct.id
        # Evento Clínico
        LEFT JOIN clinical_event AS ce ON pl.id = ce.id_player 
              AND ce.deleted = 0 
              AND ce.tenant_code = '{tenant}'
        # Diagnóstico
        LEFT JOIN diagnostic AS dg ON ce.id = dg.id_clinical_event 
              AND dg.deleted = 0
              AND dg.tenant_code = '{tenant}'
        # Tratamiento Kinésico
        LEFT JOIN kinesic_treatment AS kt ON kt.id_diagnostic = dg.id 
              AND kt.deleted = 0
              AND kt.tenant_code = '{tenant}'
          
      WHERE pl.deleted = 0 
        AND pl.tenant_code = '{tenant}'
      
      ;
      "
    )
  ) %>% 
  as.data.frame() 
####  df_KA  #### 
df_KA <- 
  dbGetQuery(
    con,
    stringr::str_glue(
      "
      ##############  ACCIÓN TERAPÉUTICA  ##############
  
      SELECT DISTINCT
        # Jugador
        concat(us.name,' ',us.last_name) AS Jugador,
        ct.name_category AS Categoría,
        # Tratamiento Kinésico
        kt.id_diagnostic AS ID_Diagnóstico,
        kt.id AS ID_AcciónTerapéutica,
        kt.date AS FechaAcciónTerapéutica,
        kt.text AS AcciónTerapéutica
          
      FROM player pl 
        # Jugador
        LEFT JOIN user AS us ON us.id = pl.id_user 
              AND us.deleted = 0
              AND us.id_user_type = 12
              AND us.tenant_code = '{tenant}' 
        LEFT JOIN user_type AS ust ON ust.id = us.id_user_type 
        LEFT JOIN category_type AS ct ON pl.id_category_type = ct.id
        # Evento Clínico
        LEFT JOIN clinical_event AS ce ON pl.id = ce.id_player 
              AND ce.deleted = 0 
              AND ce.tenant_code = '{tenant}'
        # Diagnóstico
        LEFT JOIN diagnostic AS dg ON ce.id = dg.id_clinical_event 
              AND dg.deleted = 0
              AND dg.tenant_code = '{tenant}'
        # Tratamiento Kinésico
        LEFT JOIN kinesic_treatment AS kt ON pl.id = kt.id_player 
              AND kt.deleted = 0
              AND kt.tenant_code = '{tenant}'
          
      WHERE pl.deleted = 0 
        AND pl.tenant_code = '{tenant}'
      
      ;
      "
    )
  ) %>% 
  as.data.frame()
####  df_EO  #### 
df_EO <- 
  dbGetQuery(
    con,
    stringr::str_glue(
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
              AND us.tenant_code = '{tenant}'
        LEFT JOIN user_type AS ust 
               ON ust.id = us.id_user_type 
        LEFT JOIN category_type AS ct 
               ON pl.id_category_type = ct.id
        # Evento Clínico
        LEFT JOIN clinical_event AS ce 
               ON pl.id = ce.id_player 
              AND ce.deleted = 0 
              AND ce.tenant_code = '{tenant}'
        # Diagnóstico
        LEFT JOIN diagnostic AS dg 
               ON ce.id = dg.id_clinical_event 
              AND dg.deleted = 0
              AND dg.tenant_code = '{tenant}'
        # Evaluación Objetivo
        LEFT JOIN evaluation_objective AS evob 
               ON dg.id = evob.id_diagnostic
      
      WHERE pl.deleted = 0 
        AND pl.tenant_code = '{tenant}'
      
      ;
      "
    )
  ) %>% 
  as.data.frame() 
####  df_MED  #### 
df_MED <- 
  dbGetQuery(
    con,
    stringr::str_glue(
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
        LEFT JOIN user AS us ON us.id = pl.id_user 
              AND us.deleted = 0
              AND us.id_user_type = 12
              AND us.tenant_code = '{tenant}'
        LEFT JOIN user_type AS ust ON ust.id = us.id_user_type 
        LEFT JOIN category_type AS ct ON pl.id_category_type = ct.id
        # Evento Clínico
        LEFT JOIN clinical_event AS ce ON pl.id = ce.id_player 
              AND ce.deleted = 0 
              AND ce.tenant_code = '{tenant}'
        # Diagnóstico
        LEFT JOIN diagnostic AS dg ON ce.id = dg.id_clinical_event 
              AND dg.deleted = 0
              AND dg.tenant_code = '{tenant}'
        # Medicina
        LEFT JOIN diagnostic_medicine AS dgm ON dgm.id_diagnostic = dg.id 
              AND dgm.deleted = 0
              AND dgm.tenant_code = '{tenant}'
        LEFT JOIN medicine AS med ON med.id = dgm.id_medicine
        LEFT JOIN medicine_classification AS medc ON medc.id = dgm.id_medicine_classification
        LEFT JOIN medicine_via AS medv ON medv.id = dgm.id_medicine_via
      
      WHERE pl.deleted = 0 
        AND pl.tenant_code = '{tenant}'
      
      ;
      "
    )
  ) %>% 
  as.data.frame() %>% 
  drop_na()
####  df_AC  #### 
df_AC <- 
  dbGetQuery(
    con,
    stringr::str_glue(
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
        LEFT JOIN user AS us ON us.id = pl.id_user 
              AND us.deleted = 0
              AND us.id_user_type = 12
              AND us.tenant_code = '{tenant}'
        LEFT JOIN user_type AS ust ON ust.id = us.id_user_type 
        LEFT JOIN category_type AS ct ON pl.id_category_type = ct.id
        LEFT JOIN position_type AS pt ON pl.id_position_type = pt.id
        # Condición de Disponibilidad
        LEFT JOIN availability_condition AS ac ON pl.id = ac.id_player 
              And ac.deleted = 0
              AND ac.tenant_code = '{tenant}'
        LEFT JOIN availability_condition_type AS act ON ac.id_availability_condition_type = act.id
      
      WHERE pl.deleted = 0 
        AND pl.tenant_code = '{tenant}'
      
      GROUP BY DATE(ac.created), pl.id
      
      ORDER BY pl.id asc, DATE(max(ac.created)) desc
      
      ;
      "
    )
  ) %>% 
  as.data.frame()
####  df_DM  #### 
df_DM <- 
  dbGetQuery(
    con,
    stringr::str_glue(
      "
      ##############  MEDICIONES DIARIAS  ##############

      SELECT DISTINCT
        # DM ID
        dm.id AS ID_DM,
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
        LEFT JOIN user AS us ON us.id = pl.id_user 
              AND us.deleted = 0
              AND us.id_user_type = 12
              AND us.tenant_code = '{tenant}'
        LEFT JOIN user_type AS ust ON ust.id = us.id_user_type 
        LEFT JOIN category_type AS ct ON pl.id_category_type = ct.id
        LEFT JOIN position_type AS pt ON pl.id_position_type = pt.id
        # Mediciones Diarias
        LEFT JOIN daily_measurements AS dm ON dm.id_player = pl.id 
              AND dm.deleted = 0
              # AND dm.tenant_code = '{tenant}'
        LEFT JOIN measurement_type AS mt ON mt.id = dm.measurement_type  
              AND mt.deleted = 0
              # AND mt.tenant_code = '{tenant}'
      
      WHERE pl.deleted = 0 
        AND pl.tenant_code = '{tenant}'
      
      ;
      "
      
    )
  ) %>% 
  as.data.frame() 
####  df_PD_G  #### 
df_PD_G <- 
  dbGetQuery(
    con,
    stringr::str_glue(
      "
      ##############  DIMENSIONES DE JUGADOR  ##############
      
      SELECT 
        # PD ID
        pldm.id AS ID_PlayerDimension,
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
        LEFT JOIN user AS us ON us.id = pl.id_user 
              AND us.deleted = 0
              AND us.id_user_type = 12
              AND us.tenant_code = '{tenant}'
        LEFT JOIN user_type AS ust ON ust.id = us.id_user_type 
        LEFT JOIN category_type AS ct ON pl.id_category_type = ct.id
        # Dimensiones de Jugador
        LEFT JOIN player_dimension AS pldm ON pl.id = pldm.id_player 
              AND pldm.deleted = 0
              # AND us.tenant_code = '{tenant}'
        LEFT JOIN dimension AS dm ON dm.id = pldm.id_dimension
              # AND dm.tenant_code = '{tenant}'
          
      WHERE pl.deleted = 0 
        AND pl.tenant_code = '{tenant}'
          
        ;
        "
    )     
  )
####  df_MED  #### 
df_MED <- 
  dbGetQuery(
    con,
    stringr::str_glue(
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
        LEFT JOIN user AS us ON us.id = pl.id_user 
              AND us.deleted = 0
              AND us.id_user_type = 12
              AND us.tenant_code = '{tenant}' 
        LEFT JOIN user_type AS ust ON ust.id = us.id_user_type 
        LEFT JOIN category_type AS ct ON pl.id_category_type = ct.id
        # Evento Clínico
        LEFT JOIN clinical_event AS ce ON pl.id = ce.id_player 
              AND ce.deleted = 0 
              AND ce.tenant_code = '{tenant}'
        # Diagnóstico
        LEFT JOIN diagnostic AS dg ON ce.id = dg.id_clinical_event 
              AND dg.deleted = 0
              AND dg.tenant_code = '{tenant}'
        # Medicina
        LEFT JOIN diagnostic_medicine AS dgm ON dgm.id_diagnostic = dg.id 
              AND dgm.deleted = 0
              AND dgm.tenant_code = '{tenant}'
        LEFT JOIN medicine AS med ON med.id = dgm.id_medicine
        LEFT JOIN medicine_classification AS medc ON medc.id = dgm.id_medicine_classification
        LEFT JOIN medicine_via AS medv ON medv.id = dgm.id_medicine_via
      
      WHERE pl.deleted = 0 
        AND pl.tenant_code = '{tenant}'
      
      ;
      "
    )
  ) %>% 
  as.data.frame() %>% 
  drop_na()

####  Disconnection  ####
dbDisconnect(con)
rm(con)



####  III. IMPORTING  #### 

if ( nrow(drop_na(df_PD_G)) != 0 ) {
  
  ####  1. df_PD_G != 0  ####  
  
  # DF
  df_PD_date <- 
    df_PD_G %>% 
    filter(FechaDimensión >= date_filter) 
  
  ####  PD Current ID  #### 
  
  if (nrow(df_PD_date) != 0) {
    
    ####  1.1. df_PD != 0  ####  
    
    # PD
    df_PD <- 
      df_PD_date %>% 
      drop_na() %>% 
      distinct() %>%
      select(!c(Medición, ID_PlayerDimension))
    
    # Defining Specific Json's Meters Data Frame
    df_Json <- 
      df_PD_date %>% 
      drop_na() %>% 
      distinct() %>%
      select(Medición)
    
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
        json_df_b <- 
          json_n[[j]] %>%
          jsonlite::fromJSON()
        for (b in (1:length(json_df_b))) {
          json_df <- 
            json_df_b[[b]]
          for (k in (1:length(json_df$meters))) {
            json_m <- 
              json_df$meters[[k]] %>%
              as.data.frame() %>%
              mutate("TipoMedición" = json_df$name)
            if (df_PD[i,"Dimensión"] %in% "Masoterápea") { 
              json_m <- 
                json_m %>%
                mutate("value" = 0)
            }
            json_df_c <-
              cbind(json_m,
                    df_PD[i,] %>%
                      slice(rep(1:n(), each = nrow(json_m))))
            df <- 
              rbind(df,json_df_c)
          }
        }
      }
    }
    
    # Renaming, Relocating and Filtering
    df_PD <- 
      df %>% 
      select(-id) %>% 
      rename(
        "Medición" = name,
        "ValorMedición" = value
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
    df_PD <- 
      df_PD %>% 
      filter(!ValorMedición == "")
    
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
                "58" = "Negativo",
                "59" = "Positivo",
                "60" = "Negativo",
                "61" = "Positivo"
              )
          ) %>%
          select(!ValorMedición) %>%
          rename(ValorMedición = PCR)
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
    
    ####  DF_PD  #### 
    df_PD <- 
      df_PD %>% 
      filter(
        !Dimensión %in% "Masoterápea",
        !Medición %in% c("PCR","Estress")
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
    # Droping NA
    df_PD <- 
      df_PD %>% 
      drop_na() %>% 
      filter(ValorMedición >= 0)
    # Re-defining Values
    df_PD$Medición <- 
      df_PD$Medición %>% 
      plyr::revalue(c(
        "Nivel de percepción por el esfuerzo" = "Percepción subjetiva del esfuerzo",
        "Total Duration" = "Minutos de exposición",
        "Dolor muscular" = "Estado general muscular",
        "Estado de ánimo" = "Humor / Estado de ánimo",
        'T.Q.R Recuperación física' = 'T.Q.R'
      )) 
    
    df_PD$Medición <- 
      factor(
        df_PD$Medición, 
        unique(df_PD$Medición)
      )
    
    
    ####  DM Current ID  ####  
    if (nrow(drop_na(df_DM)) != 0) {
      
      ## DM
      df_DM_date <- 
        df_DM %>% 
        filter(FechaMedición >= date_filter) 
      
      if (nrow(df_DM_date) != 0) {
        
        ####  Merging DM  ####  
        df_PD <- 
          df_PD %>% 
          rbind(
            df_DM_date %>%
              select(!ID_DM) %>% 
              rename(
                "Medición" = TipoMedición,
                "TipoMedición" = MomentoMedición,
                "FechaDimensión" = FechaMedición
              ) %>%
              mutate(
                Dimensión = "GPS",
                Medición =  stringr::str_replace(Medición, " \\s*\\([^\\)]+\\)", "")
              ) %>% 
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
        
        ####  DF_PD  #### 
        df_PD <- 
          df_PD %>%
          distinct() %>% 
          filter(
            !Dimensión %in% "Masoterápea",
            !Medición %in% c("PCR","Estress")
          )
        df_PD$ValorMedición <- df_PD$ValorMedición %>% as.numeric()
        df_PD$Categoría <- df_PD$Categoría %>% as.factor()
        df_PD$Jugador <- df_PD$Jugador %>% as.factor()
        df_PD$FechaDimensión <- df_PD$FechaDimensión %>% as.Date()
        df_PD$TipoMedición <- df_PD$TipoMedición %>% as.factor()
        df_PD$Medición <- df_PD$Medición %>% as.factor()
        df_PD$Dimensión <- df_PD$Dimensión %>% as.factor()
        
      }
      
    }
    
    ####  MERGING DFs  ####
    dropboxDownload(tenant, 'df_PD.rds')
    df_PD_prev <- 
      readRDS("df_PD.rds") %>%
      filter(FechaDimensión < date_filter)
    df_PD <- 
      rbind(
        df_PD,
        df_PD_prev
      ) %>% 
      distinct()
    dropboxDownload(tenant, 'df_PD_F.rds')
    df_PD_F_prev <- 
      readRDS("df_PD_F.rds") %>%
      filter(FechaDimensión < date_filter)
    df_PD_F <- 
      rbind(
        df_PD_F,
        df_PD_F_prev
      ) %>% 
      distinct()
    
    # Dropbox
    saveRDS(df_PD, file = "df_PD.rds")
    saveRDS(df_PD_F, file = "df_PD_F.rds")
    dropboxUpload(tenant, 'df_PD.rds')
    dropboxUpload(tenant, 'df_PD_F.rds')
    
    # Deleting
    rm(json_df, json_df_b, json_df_c, json_m, df_PD_prev, df_PD_F_prev, df_PD_date, df_DM, df_DM_date)
    
  } else if (nrow(drop_na(df_DM)) != 0) {
    
    ####  1.2. df_DM != 0  ####  
    
    ## DM
    df_DM_date <- 
      df_DM %>% 
      filter(FechaMedición >= date_filter) 
    
    if (nrow(df_DM_date) != 0) {
      
      # Merginf DM
      df_PD <- 
        df_DM_date %>%
        select(!ID_DM) %>% 
        rename(
          "Medición" = TipoMedición,
          "TipoMedición" = MomentoMedición,
          "FechaDimensión" = FechaMedición
        ) %>%
        mutate(
          Dimensión = "GPS",
          Medición =  stringr::str_replace(Medición, " \\s*\\([^\\)]+\\)", "")
        ) %>% 
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
      
      ####  DF_PD  #### 
      df_PD <- 
        df_PD %>% 
        filter(
          !Dimensión %in% "Masoterápea",
          !Medición %in% c("PCR","Estress")
        )
      df_PD$ValorMedición <- df_PD$ValorMedición %>% as.numeric()
      df_PD$Categoría <- df_PD$Categoría %>% as.factor()
      df_PD$Jugador <- df_PD$Jugador %>% as.factor()
      df_PD$FechaDimensión <- df_PD$FechaDimensión %>% as.Date()
      df_PD$TipoMedición <- df_PD$TipoMedición %>% as.factor()
      df_PD$Medición <- df_PD$Medición %>% as.factor()
      df_PD$Dimensión <- df_PD$Dimensión %>% as.factor()
      
      
      ## Merging with Previous Data Frames
      dropboxDownload(tenant, 'df_PD.rds')
      df_PD_prev <- 
        readRDS("df_PD.rds")
      df_PD <- 
        rbind(
          df_PD,
          df_PD_prev
        ) %>% 
        distinct()
      
      # Dropbox
      saveRDS(df_PD, file = "df_PD.rds")
      dropboxUpload(tenant, 'df_PD.rds')
      
      # Deleting
      rm(df_PD_prev, df_PD_date, df_DM, df_DM_date)
      
    }
    
    # Deleting
    rm(df_PD_prev, df_PD_date, df_DM, df_DM_date)
    
  }
  
} else if (nrow(drop_na(df_DM)) != 0) {
  
  ####  2. df_DM != 0  ####  
  
  ## DM
  df_DM_date <- 
    df_DM %>% 
    filter(FechaMedición >= date_filter) 
  
  if (nrow(df_DM_date) != 0) {
    
    # Merging DM
    df_PD <- 
      df_DM_date %>%
      select(!ID_DM) %>% 
      rename(
        "Medición" = TipoMedición,
        "TipoMedición" = MomentoMedición,
        "FechaDimensión" = FechaMedición
      ) %>%
      mutate(
        Dimensión = "GPS",
        Medición =  stringr::str_replace(Medición, " \\s*\\([^\\)]+\\)", "")
      ) %>% 
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
    
    ####  DF_PD  #### 
    df_PD <- 
      df_PD %>% 
      filter(
        !Dimensión %in% "Masoterápea",
        !Medición %in% c("PCR","Estress")
      )
    df_PD$ValorMedición <- df_PD$ValorMedición %>% as.numeric()
    df_PD$Categoría <- df_PD$Categoría %>% as.factor()
    df_PD$Jugador <- df_PD$Jugador %>% as.factor()
    df_PD$FechaDimensión <- df_PD$FechaDimensión %>% as.Date()
    df_PD$TipoMedición <- df_PD$TipoMedición %>% as.factor()
    df_PD$Medición <- df_PD$Medición %>% as.factor()
    df_PD$Dimensión <- df_PD$Dimensión %>% as.factor()
    
    ####  MERGING DFs  ####
    dropboxDownload(tenant, 'df_PD.rds')
    df_PD_prev <- 
      readRDS("df_PD.rds")
    df_PD <- 
      rbind(
        df_PD,
        df_PD_prev
      ) %>% 
      distinct()
    
    # Dropbox
    saveRDS(df_PD, file = "df_PD.rds")
    dropboxUpload(tenant, 'df_PD.rds')
    
    # Deleting
    rm(df_PD_prev, df_DM, df_DM_date)
    
  }
  
}

####  DF_PD  #### 
dropboxDownload(tenant, 'df_PD.rds')
df_PD <- 
  readRDS("df_PD.rds") 
dropboxDownload(tenant, 'df_PD_F.rds')
df_PD_F <- 
  readRDS("df_PD_F.rds") 



####  IV. DATA WRANGLING  #### 

####  df_PD_F  ####
df_PD_F$Categoría <- df_PD_F$Categoría %>% as.factor()
df_PD_F$Jugador <- df_PD_F$Jugador %>% as.factor()
df_PD_F$FechaDimensión <- df_PD_F$FechaDimensión %>% as.Date()
df_PD_F$TipoMedición <- df_PD_F$TipoMedición %>% as.factor()
df_PD_F$Medición <- df_PD_F$Medición %>% as.factor()
df_PD_F$ValorMedición <- df_PD_F$ValorMedición %>% as.factor()

####  df_PD  #### 
## Adding new Variables
df_PD <- 
  rbind(
    ## Internal Workload
    full_join(
      df_PD %>%
        filter(
          Medición %in% "Percepción subjetiva del esfuerzo" 
        ) %>%
        group_by(
          Jugador,
          Categoría,
          FechaDimensión,
          Dimensión,
          TipoMedición
        ) %>%
        summarise(
          Esfuerzo = sum(ValorMedición)
        ) %>%
        as.data.frame() ,
      df_PD %>%
        filter(
          Medición %in% "Minutos de exposición" 
        ) %>%
        group_by(
          Jugador,
          Categoría,
          FechaDimensión,
          Dimensión,
          TipoMedición
        ) %>%
        summarise(
          Minutos = sum(ValorMedición)
        ) %>%
        as.data.frame(),
      by = c('Jugador',
             'Categoría',
             'FechaDimensión',
             'Dimensión',
             'TipoMedición')
    ) %>%
      mutate(
        Medición = 'Carga Interna',
        ValorMedición = as.numeric(Esfuerzo*Minutos)
      ) %>%
      select(!c(Esfuerzo, Minutos)),
    ## Total Wellness
    df_PD %>%
      filter(
        Medición %in% c("Nivel de energía",
                        "Humor / Estado de ánimo",
                        "Estado general muscular",
                        "Calidad del sueño")
      ) %>%
      group_by(
        Jugador,
        Categoría,
        FechaDimensión,
        Dimensión,
        TipoMedición
      ) %>%
      summarise(
        TotalWellness = sum(ValorMedición)
      ) %>%
      as.data.frame() %>%
      mutate(
        Medición = 'Total Wellness',
        ValorMedición = TotalWellness
      ) %>%
      select(!TotalWellness),
    ## General DF
    df_PD
  ) %>% 
  drop_na() %>%
  distinct()
## Values
df_PD$ValorMedición <- df_PD$ValorMedición %>% as.numeric()
df_PD$Categoría <- df_PD$Categoría %>% as.factor()
df_PD$Jugador <- df_PD$Jugador %>% as.factor()
df_PD$FechaDimensión <- df_PD$FechaDimensión %>% as.Date()
df_PD$TipoMedición <- df_PD$TipoMedición %>% as.factor()
df_PD$Medición <- df_PD$Medición %>% as.factor()
df_PD$Dimensión <- df_PD$Dimensión %>% as.factor()

####  df_USER  #### 
df_USER$ID_Usuario <- df_USER$ID_Usuario %>% as.factor()
df_USER$Usuario <- df_USER$Usuario %>% as.factor()
df_USER$Categoría <- df_USER$Categoría %>% as.factor()
df_USER$Email <- df_USER$Email %>% as.factor()

####  df_CED  #### 
# Previous Events
df_CED$Instancia <- 
  df_CED$Instancia %>% 
  replace_na("Entrenamiento") #"Evento clínico externo (Selección/Club)"
# Reading Columns as Factors
for (i in 1:ncol(df_CED)) {
  df_CED[,i] <- 
    df_CED[,i] %>% 
    as.factor()
}
# Date Variables
df_CED <- 
  df_CED %>% 
  mutate(Edad = df_CED$FechaNacimiento %>% 
           as.Date() %>% 
           eeptools::age_calc(units = 'years') %>% 
           round(0)) 
df_CED$FechaEventoClínico <- df_CED$FechaEventoClínico %>% as.Date()
df_CED$FechaEvento <- df_CED$FechaEvento %>% as.Date()
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
####
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
####

####  df_CED_TE  #### 
# Deifning Nature
df_CED_TE$FechaDiagnóstico[df_CED_TE$FechaDiagnóstico  == "NULL"] <- NA
df_CED_TE$Categoría <- df_CED_TE$Categoría %>% as.factor()
df_CED_TE$Jugador <- df_CED_TE$Jugador %>% as.factor()
df_CED_TE$Categoría_I <- df_CED_TE$Categoría_I %>% as.factor()
df_CED_TE$Diagnóstico <- df_CED_TE$Diagnóstico %>% as.factor()
df_CED_TE$Complemento_II <- df_CED_TE$Complemento_II %>% as.factor()
df_CED_TE$FechaTratamientoKinésico <- df_CED_TE$FechaTratamientoKinésico %>% as.Date()
df_CED_TE$FechaEvaluaciónObjetivo <- df_CED_TE$FechaEvaluaciónObjetivo %>% as.Date()
df_CED_TE$FechaDiagnóstico <- df_CED_TE$FechaDiagnóstico %>% as.Date()
# Loop for removing \n
for (row in seq(1,nrow(df_CED_TE),by=1)) {
  df_CED_TE[row,"TratamientoKinésico"] <- 
    df_CED_TE[row,"TratamientoKinésico"] %>% 
    stringr::str_replace("\n", " ")
}
# Defining Category Values
df_CED_TE <- 
  df_CED_TE %>%
  #filter(!is.na(ID_TratamientoKinésico)) %>%
  select(!ID_Diagnóstico) %>%
  mutate(
    Complemento_II = Complemento_II %>% tidyr::replace_na("Sin complemento"),
    EvaluaciónObjetivo = EvaluaciónObjetivo %>% tidyr::replace_na("Sin evaluación"),
    TratamientoKinésico = TratamientoKinésico %>% tidyr::replace_na("Sin tratamiento")
  )


####  df_KT  #### 
# Deifning Nature
df_KT$FechaTratamientoKinésico[df_KT$FechaTratamientoKinésico  == "NULL"] <- NA
df_KT$Jugador <- df_KT$Jugador %>% as.factor()
df_KT$Categoría <- df_KT$Categoría %>% as.factor()
df_KT$FechaTratamientoKinésico <- df_KT$FechaTratamientoKinésico %>% as.Date()
# Loop for removing \n
for (row in seq(1,nrow(df_KT),by = 1)) {
  df_KT[row,"TratamientoKinésico"] <- 
    df_KT[row,"TratamientoKinésico"] %>% 
    stringr::str_replace("\n", " ")
}
# Defining Category Values
df_KT <- 
  df_KT %>%
  filter(!is.na(ID_TratamientoKinésico)) %>%
  select(!ID_Diagnóstico)

####  df_KA  ####
df_KA$FechaAcciónTerapéutica[df_KA$FechaAcciónTerapéutica  == "NULL"] <- NA
df_KA$Jugador <- df_KA$Jugador %>% as.factor()
df_KA$Categoría <- df_KA$Categoría %>% as.factor()
df_KA$FechaAcciónTerapéutica <- df_KA$FechaAcciónTerapéutica %>% as.Date()
df_KA <- 
  df_KA %>%
  mutate(
    AcciónTerapéutica = case_when(
      stringr::str_detect(df_KA$AcciónTerapéutica, "hiperbárica") ~ "Cámara Hiperbática",
      stringr::str_detect(df_KA$AcciónTerapéutica, "hiperbáricas") ~ "Cámara Hiperbática",
      stringr::str_detect(df_KA$AcciónTerapéutica, "Hiperbárica") ~ "Cámara Hiperbárica",
      stringr::str_detect(df_KA$AcciónTerapéutica, "fria") ~ "Inmersión Crioterapia",
      stringr::str_detect(df_KA$AcciónTerapéutica, "fría") ~ "Inmersión Crioterapia",
      stringr::str_detect(df_KA$AcciónTerapéutica, "hielo") ~ "Inmersión Crioterapia",
      stringr::str_detect(df_KA$AcciónTerapéutica, "Quiropraxia") ~ "Quiropraxia",
      stringr::str_detect(df_KA$AcciónTerapéutica, "quiropraxia") ~ "Quiropraxia",
      stringr::str_detect(df_KA$AcciónTerapéutica, "quiropráctico") ~ "Quiropraxia",
      stringr::str_detect(df_KA$AcciónTerapéutica, "quiropractico") ~ "Quiropraxia",
      stringr::str_detect(df_KA$AcciónTerapéutica, "Vendaje") ~ "Taping",
      stringr::str_detect(df_KA$AcciónTerapéutica, "Taping") ~ "Taping",
      stringr::str_detect(df_KA$AcciónTerapéutica, "taping") ~ "Taping",
      stringr::str_detect(df_KA$AcciónTerapéutica, "Lib") ~ "Lib Miofascial",
      stringr::str_detect(df_KA$AcciónTerapéutica, "lib") ~ "Lib Miofascial",
      stringr::str_detect(df_KA$AcciónTerapéutica, "Activaci") ~ "Activación",
      stringr::str_detect(df_KA$AcciónTerapéutica, "activaci") ~ "Activación",
      stringr::str_detect(df_KA$AcciónTerapéutica, "Vacuna") ~ "Vacuna",
      stringr::str_detect(df_KA$AcciónTerapéutica, "Podolog") ~ "Podología",
      stringr::str_detect(df_KA$AcciónTerapéutica, "podolog") ~ "Podología",
      stringr::str_detect(df_KA$AcciónTerapéutica, "Antígeno") ~ "Antígeno",
      stringr::str_detect(df_KA$AcciónTerapéutica, "antígeno") ~ "Antígeno",
      stringr::str_detect(df_KA$AcciónTerapéutica, "Antigeno") ~ "Antígeno",
      stringr::str_detect(df_KA$AcciónTerapéutica, "antigeno") ~ "Antígeno"
    ) %>% 
      as.factor()
  ) %>%
  filter(!is.na(ID_AcciónTerapéutica)) %>%
  select(!ID_Diagnóstico)

####  df_EO  #### 
df_EO$Jugador <- df_EO$Jugador %>% as.factor()
df_EO$Categoría <- df_EO$Categoría %>% as.factor()
df_EO$FechaDiagnóstico <- df_EO$FechaDiagnóstico %>% as.Date()
df_EO$EvaluaciónObjetivo <- df_EO$EvaluaciónObjetivo %>% as.character()
# df_EO$EvaluaciónObjetivo[is.na(df_EO$EvaluaciónObjetivo)] <- "Sin texto."
df_EO <- 
  df_EO %>% 
  filter(!is.na(ID_Diagnóstico)) %>%
  select(!ID_Diagnóstico)

####  df_AC  #### 
# Deifning Nature
df_AC$CondiciónDisponibilidad <- df_AC$CondiciónDisponibilidad %>% as.factor()
df_AC$Posición <- df_AC$Posición %>% as.factor()
df_AC$Jugador <- df_AC$Jugador %>% as.factor()
df_AC$Categoría <- df_AC$Categoría %>% as.factor()
df_AC$FechaCondición <- df_AC$FechaCondición %>% as.Date()

####  df_MED  #### 
# Deifning Nature
df_MED$ClasificaciónMed <- df_MED$ClasificaciónMed %>% as.factor()
df_MED$Vía <- df_MED$Vía %>% as.factor()
df_MED$Dosis <- df_MED$Dosis %>% as.numeric()
df_MED$Medicamento <- df_MED$Medicamento %>% as.factor()
df_MED$Jugador <- df_MED$Jugador %>% as.factor()
df_MED$Categoría <- df_MED$Categoría %>% as.factor()
df_MED$FechaDiagnóstico <- df_MED$FechaDiagnóstico %>% as.Date()

####  df_TL  #### 
if (tenant == "some_tenant") {
  
  ####  Old
  
  # Downloading
  dropboxDownload(tenant, 'df_TL_old.rds')
  df_TL_old <- 
    readRDS("df_TL_old.rds")
  
  # Deifning Nature
  df_TL_old$TimeLoss <- df_TL_old$TimeLoss %>% as.numeric()
  df_TL_old$Jugador <- df_TL_old$Jugador %>% as.factor()
  df_TL_old$Categoría <- df_TL_old$Categoría %>% as.factor()
  df_TL_old$Diagnóstico <- df_TL_old$Diagnóstico %>% as.factor()
  df_TL_old$Momento <- df_TL_old$Momento %>% as.factor()
  df_TL_old$FechaTérmino_TimeLoss <- df_TL_old$FechaTérmino_TimeLoss %>% as.Date()
  df_TL_old$FechaInicio_TimeLoss <- df_TL_old$FechaInicio_TimeLoss %>% as.Date()
  # Final DF
  df_TL_old <- 
    df_TL_old %>% 
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
  
  ####  New
  
  ## Creating Time Loss Data Frame
  # Empty DF
  empty_df_TL <- 
    data.frame(
      Jugador = factor(),
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
  for (i in seq(1,nrow(df_TL_new), by = 1)) {
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
  df_TL_new <- 
    df_TL_new %>%
    filter(TimeLoss >= 0) %>% 
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
  ####  Merge
  df_TL <- 
    df_TL_new %>% 
    rbind(
      df_TL_old %>% 
        select(!Diagnóstico) %>% 
        relocate(colnames(df_TL_new))
    )
  
  # Deleting
  rm(df_TL_old, df_TL_new, empty_df_TL, df_player)
  
} else {
  
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
  
  # Deleting
  rm(df_TL_new, empty_df_TL, df_player)
  
}

####  df_BM  ####
# Dimensions
dimensions <- c(
  'Plataforma de fuerza',
  "Miotone",
  "Nórdicos Isquiotibiales",
  "Índice postural dinámico para tobillo",
  "Fuerza Isométrica",
  "Isocinética",
  'Core Plank Test',
  "Consumo máximo de oxigeno"
)
# Initial DF
df_BM <- 
  df_PD %>%
  filter(
    Dimensión %in% dimensions
  ) %>%
  mutate(
    Medición = paste(TipoMedición, Medición, sep = "-")
  ) %>%
  select(
    Jugador,
    Categoría,
    FechaDimensión,
    Dimensión,
    Medición,
    ValorMedición
  ) %>%
  mutate(
    ValorMétrica = 0
  )
# Main Loop
for (row in seq(1:nrow(df_BM))) {
  
  ####  Plataforma Fuerza 
  if (df_BM$Medición[row] == "Abalakov-Valor Altura máxima") {
    if (df_BM$ValorMedición[row] <= 41) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 45) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] == "CMJ-Valor Altura máxima") {
    if (df_BM$ValorMedición[row] <= 34) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 38.6) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] == "SQ-Índice de utilización de brazos") {
    if (df_BM$ValorMedición[row] <= 7) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 14) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] == "SQ-Índice Elástico sj cmj") {
    if (df_BM$ValorMedición[row] <= 4) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 10) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] == "SQ-Valor Altura máxima") {
    if (df_BM$ValorMedición[row] <= 32) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 36) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  
  ####  Miotone  
  if (df_BM$Medición[row] %in% c(
    "Relación dere/izq-Aquiles asimetría %",
    "Relación dere/izq-Biceps femoral asimetría %",
    "Relación dere/izq-Semitendinoso asimetría %"
  )) {
    if (df_BM$ValorMedición[row] >= 4.9) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] <= 16.1) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  
  ####  Nórdicos Isquio. 
  if (df_BM$Medición[row] %in% c(
    "Derecha-Valor N",
    "Izquierda-Valor N"
  )) {
    if (df_BM$ValorMedición[row] <= 189.9) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 279.1) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] == "Relaciónn dere/izq-Asimetría %") {
    if (df_BM$ValorMedición[row] >= 20.1) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] <= 10) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  
  ####  Índice Postural
  if (df_BM$Medición[row] %in% c(
    "Derecha-Plano anteroposterior valor promedio/DS",
    "Izquierda-Plano anteroposterior valor promedio/DS"
  )) {
    if (
      df_BM$ValorMedición[row] >= 0.31 |
      df_BM$ValorMedición[row] <= 0.09
    ) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (
      df_BM$ValorMedición[row] <= 0.23 &
      df_BM$ValorMedición[row] >= 0.17
    ) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] %in% c(
    "Derecha-Plano mediolateral valor promedio/DS",
    "Izquierda-Plano mediolateral valor promedio/DS"
  )) {
    if (
      df_BM$ValorMedición[row] >= 0.82 |
      df_BM$ValorMedición[row] <= 0.47
    ) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (
      df_BM$ValorMedición[row] <= 0.71 &
      df_BM$ValorMedición[row] >= 0.59
    ) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] %in% c(
    "Derecha-Plano vertical superior valor promedio/DS",
    "Izquierda-Plano vertical superior valor promedio/DS"
  )) {
    if (
      df_BM$ValorMedición[row] >= 2.8 |
      df_BM$ValorMedición[row] <= 1.89
    ) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (
      df_BM$ValorMedición[row] <= 0.55 &
      df_BM$ValorMedición[row] >= 0.05
    ) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] %in% c(
    "Derecha-Plano general valor promedio/DS",
    "Izquierda-Plano general valor promedio/DS"
  )) {
    if (
      df_BM$ValorMedición[row] >= 2.81 |
      df_BM$ValorMedición[row] <= 1.99
    ) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (
      df_BM$ValorMedición[row] <= 2.66 &
      df_BM$ValorMedición[row] >= 2.16
    ) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  
  ####  Fuerza Isométrica
  if (df_BM$Medición[row] %in% c(
    "Derecha-Cuádriceps 60° valor N/m",
    "Izquierda-Cuádriceps 60° valor N/m"
  )) {
    if (df_BM$ValorMedición[row] <= 139.9) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 186) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] %in% c(
    "Derecha-Isquiotibiales 30° valor N/m",
    "Izquierda-Isquiotibiales 30° valor N/m"
  )) {
    if (df_BM$ValorMedición[row] <= 59.9) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 186) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] %in% c(
    "Relación dere/izq-Cuádriceps 60° asimetría%",
    "Relación dere/izq-Isquiotibiales 30° asimetría %"
  )) {
    if (df_BM$ValorMedición[row] >= 20.1) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] <= 9.9) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] %in% c(
    "Relación dere/izq-Cuádriceps 60° Relación Qcps/Iqt",
    "Relación dere/izq-Isquiotibiales 30° Relación Qcps/Iqt"
  )) {
    if (
      df_BM$ValorMedición[row] >= 75.1 |
      df_BM$ValorMedición[row] <= 39.9
    ) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (
      df_BM$ValorMedición[row] <= 65 &
      df_BM$ValorMedición[row] >= 55
    ) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  
  ####  Fuerza Isométrica
  if (df_BM$Medición[row] %in% c(
    "Derecha-Torque máximo cuádriceps",
    "Izquierda-Torque máximo cuádriceps"
  )) {
    if (df_BM$ValorMedición[row] <= 179.9) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 200.1) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] %in% c(
    "Derecha-Torque máximo isquiotibial",
    "Izquierda-Torque máximo isquiotibial"
  )) {
    if (df_BM$ValorMedición[row] <= 129.9) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 160) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  if (df_BM$Medición[row] %in% c(
    "Relación dere/izq-Relación qcps/iqt der%",
    "Relación dere/izq-Relación qcps/iqt izq %"
  )) {
    if (
      df_BM$ValorMedición[row] >= 75.1 |
      df_BM$ValorMedición[row] <= 39.9
    ) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (
      df_BM$ValorMedición[row] <= 65 &
      df_BM$ValorMedición[row] >= 55
    ) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  
  ####  Core Plank Test
  if (df_BM$Medición[row] == "Core Plank Test-Valor") {
    if (df_BM$ValorMedición[row] <= 59.9) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 180) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  
  ####  Vo2max
  if (df_BM$Medición[row] == "Consumo máximo de oxigeno-Vo2max relativo al peso") {
    if (df_BM$ValorMedición[row] <= 35) {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 1
    } else if (df_BM$ValorMedición[row] >= 45) {
      df_BM$ValorMétrica[row] <- 0
    } else {
      df_BM$ValorMétrica[row] <- 
        df_BM$ValorMétrica[row] + 0.5
    }
  }
  
}



####  V. CSS  #### 
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
    height: 30px;
    border-bottom: 1.8px solid #EDEDED; #142c59
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
  #dropdownBlock_info li {
    width: 650px;
  }

  # .navbar-custom-menu>.navbar-nav>li>.dropdown-menu {
  #   color: black;
  #   font-size: 14px;
  #   background-color: #FFFFFF;
  #   border-top-left-radius: 0px;
  #   border-top-right-radius: 0px;
  #   border-bottom-right-radius: 0px;
  #   border-bottom-left-radius: 0px;
  #   border-bottom: 1.3px solid #030303;
  #   border-right: 1.3px solid #030303;
  #   border-left: 1.3px solid #030303;
  # }

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
    box-shadow: 1px 1px 1px 1px rgb(0 0 0 / 10%);
  }
  # .skin-black .box-primary:hover {
  #   box-shadow: 5px 5px 5px rgb(0 0 0 / 40%);
  # }
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
  
  .select-input {
    height: 5x;
    #font-size: 24pt;
    padding-top: 5px;
    padding-bottom: 0px;
  }

  "


####  VI. MAIL  #### 
smtp <- 
  server(
    host = "smtp.gmail.com",
    port = 465,
    username = "reconquer.analytics@gmail.com",
    password = "DataScience$2313"
  )


####  VII. DOWNLOADS  #### 

## Reports
drop_download(stringr::str_glue('ReConquer/Report_G.Rmd',
                                local_path = ""),
              overwrite = TRUE)
drop_download(stringr::str_glue('ReConquer/Report_I.Rmd',
                                local_path = ""),
              overwrite = TRUE)
drop_download(stringr::str_glue('ReConquer/Report_I_C.Rmd',
                                local_path = ""),
              overwrite = TRUE)
## Modals
drop_download(stringr::str_glue('ReConquer/Modals.zip',
                                local_path = ""),
              overwrite = TRUE)


####  VII. OTHERS  #### 

## Unzip Modals
unzip(
  'Modals.zip'
  #'/Users/usuario/Documents/RStudio/Projects/ReConquer/Modals.zip'
)
file.remove(
  'Modals.zip'
  #'/Users/usuario/Documents/RStudio/Projects/ReConquer/Modals.zip'
)

## Years
data_years <- 
  as.integer(unique(lubridate::year(df_PD$FechaDimensión)))

## Ending Time
end_tenant_time <- 
  Sys.time()

## Total Time
total_tenant_time <- 
  difftime(
    end_tenant_time,
    start_tenant_time,
    units = c("secs")
  ) %>% 
  as.numeric() %>%
  round(1)

print(
  paste(
    "Tiempo de procesamiento Inicial del Tenant ", tenant, 
    " con fecha ", Sys.time(), ": ", 
    as.numeric(total_tenant_time), " segundos.", 
    sep = ""
  )
)


