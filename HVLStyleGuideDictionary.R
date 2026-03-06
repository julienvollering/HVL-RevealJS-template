# HVL Style Guide Dictionary
# Based on Høgskulen på Vestlandet (Western Norway University of Applied Sciences)
# Design Manual 2017

# ==============================================================================
# TYPOGRAPHY
# ==============================================================================

# Profile Fonts (for designers, professional publications)
hvl_fonts_profile <- list(
  title = list(
    family = "NB Akademie Std",
    weights = c(
      "Light",
      "Light Italic",
      "Regular",
      "Italic",
      "Medium",
      "Medium Italic",
      "Bold",
      "Bold Italic",
      "Black"
    ),
    usage = "Titles, subtitles, and ingresses (lead paragraphs)"
  ),

  body = list(
    family = "Lyon Text",
    weights = c(
      "Regular",
      "Italic",
      "Semibold",
      "Semibold Italic",
      "Bold",
      "Bold Italic",
      "Black"
    ),
    usage = "Body text, with Italic and Bold for emphasis"
  ),

  captions = list(
    family = "NB Akademie Std",
    weight = "Light",
    usage = "Image captions, graphs, footnotes, infographics, fact boxes"
  )
)

# Office Fonts (for general staff use in MS Office)
hvl_fonts_office <- list(
  title = list(
    family = "Arial",
    weights = c("Regular", "Italic", "Bold", "Bold Italic"),
    usage = "Titles, subtitles, and ingresses"
  ),

  body = list(
    family = "Georgia",
    weights = c("Regular", "Italic", "Bold", "Bold Italic"),
    usage = "Body text, with Italic and Bold for emphasis"
  ),

  captions = list(
    family = "Arial",
    weight = "Regular",
    usage = "Image captions, graphs, footnotes, infographics"
  )
)

# ==============================================================================
# COLORS - Signal Colors (Signalfarge)
# ==============================================================================

hvl_colors_signal <- list(
  sjøgrønn = list(
    name = "Sjøgrønn (Sea Green)",
    pms = "PMS 7710 U",
    cmyk = c(81, 0, 23, 0),
    rgb = c(0, 175, 186),
    hex = "#00AFBA"
  ),

  grønn = list(
    name = "Grønn (Green)",
    pms = "PMS 2267 U",
    cmyk = c(32, 0, 42, 0),
    rgb = c(151, 223, 154),
    hex = "#96DE99"
  ),

  lys_blå = list(
    name = "Lys Blå (Light Blue)",
    pms = "PMS 3105 U",
    cmyk = c(44, 0, 11, 0),
    rgb = c(100, 208, 223),
    hex = "#64D0DF"
  ),

  gul = list(
    name = "Gul (Yellow)",
    pms = "PMS 114 U",
    cmyk = c(0, 4, 87, 0),
    rgb = c(249, 222, 69),
    hex = "#F9DE45"
  ),

  oransje = list(
    name = "Oransje (Orange)",
    pms = "PMS 7416 U",
    cmyk = c(0, 72, 70, 0),
    rgb = c(235, 104, 82),
    hex = "#EB6851"
  )
)

# ==============================================================================
# COLORS - Support Colors (Støttefarge)
# ==============================================================================

hvl_colors_support <- list(
  mørk_blå_1 = list(
    name = "Mørk Blå 1 (Dark Blue 1)",
    pms = "PMS 7704 U",
    cmyk = c(93, 4, 8, 24),
    rgb = c(0, 138, 175),
    hex = "#008AAF"
  ),

  mørk_blågrønn = list(
    name = "Mørk Blågrønn (Dark Blue-Green)",
    pms = "PMS 3285 U",
    cmyk = c(98, 0, 59, 0),
    rgb = c(0, 148, 130),
    hex = "#009382"
  ),

  mørk_blå_2 = list(
    name = "Mørk Blå 2 (Dark Blue 2)",
    pms = "PMS 3035 U",
    cmyk = c(100, 30, 19, 76),
    rgb = c(0, 67, 87),
    hex = "#004357"
  ),

  mørk_rød = list(
    name = "Mørk Rød (Dark Red)",
    pms = "PMS 7421 U",
    cmyk = c(18, 100, 45, 67),
    rgb = c(109, 36, 57),
    hex = "#6D2439"
  )
)

# ==============================================================================
# COLORS - Additional Tones (Tilleggstoner)
# ==============================================================================

hvl_colors_additional <- list(
  hvit = list(
    name = "Hvit (White)",
    pms = "White",
    cmyk = c(0, 0, 0, 0),
    rgb = c(255, 255, 255),
    hex = "#FFFFFF"
  ),

  grå_mørk = list(
    name = "Grå Mørk (Dark Gray)",
    pms = "PMS 2332 U",
    cmyk = c(50, 42, 44, 6),
    rgb = c(143, 138, 131),
    hex = "#8F8A83"
  ),

  grå_medium = list(
    name = "Grå Medium (Medium Gray)",
    pms = "PMS 2331 U",
    cmyk = c(32, 26, 29, 3),
    rgb = c(176, 172, 165),
    hex = "#B0ACA5"
  ),

  grå_lys = list(
    name = "Grå Lys (Light Gray)",
    pms = "PMS 434 U",
    cmyk = c(5, 6, 8, 10),
    rgb = c(210, 205, 200),
    hex = "#D2CDC8"
  ),

  blågrå_mørk = list(
    name = "Blågrå Mørk (Dark Blue-Gray)",
    pms = "PMS 444 U",
    cmyk = c(45, 16, 25, 50),
    rgb = c(112, 124, 124),
    hex = "#707B7B"
  ),

  blågrå_medium = list(
    name = "Blågrå Medium (Medium Blue-Gray)",
    pms = "PMS 442 U",
    cmyk = c(25, 7, 19, 20),
    rgb = c(172, 183, 178),
    hex = "#ACB7B2"
  ),

  blågrå_lys = list(
    name = "Blågrå Lys (Light Blue-Gray)",
    pms = "PMS 5455 U",
    cmyk = c(17, 4, 6, 4),
    rgb = c(201, 213, 218),
    hex = "#C9D5DA"
  )
)

# ==============================================================================
# CONVENIENCE FUNCTIONS
# ==============================================================================

# Extract hex colors as a named vector
hvl_hex_palette <- function(palette = "all") {
  all_colors <- c(
    hvl_colors_signal,
    hvl_colors_support,
    hvl_colors_additional
  )

  hex_colors <- sapply(all_colors, function(x) x$hex)
  names(hex_colors) <- names(all_colors)

  if (palette == "signal") {
    return(sapply(hvl_colors_signal, function(x) x$hex))
  } else if (palette == "support") {
    return(sapply(hvl_colors_support, function(x) x$hex))
  } else if (palette == "additional") {
    return(sapply(hvl_colors_additional, function(x) x$hex))
  } else {
    return(hex_colors)
  }
}

# Get RGB values as a matrix
hvl_rgb_palette <- function(palette = "all") {
  all_colors <- c(
    hvl_colors_signal,
    hvl_colors_support,
    hvl_colors_additional
  )

  if (palette == "signal") {
    colors <- hvl_colors_signal
  } else if (palette == "support") {
    colors <- hvl_colors_support
  } else if (palette == "additional") {
    colors <- hvl_colors_additional
  } else {
    colors <- all_colors
  }

  rgb_matrix <- t(sapply(colors, function(x) x$rgb))
  rownames(rgb_matrix) <- names(colors)
  colnames(rgb_matrix) <- c("R", "G", "B")

  return(rgb_matrix)
}

# ==============================================================================
# USAGE EXAMPLES
# ==============================================================================

# Example: Get all hex colors
# all_hex <- hvl_hex_palette()

# Example: Get only signal colors
# signal_hex <- hvl_hex_palette("signal")

# Example: Use in ggplot2
# library(ggplot2)
# ggplot(data, aes(x, y, color = category)) +
#   geom_point() +
#   scale_color_manual(values = hvl_hex_palette("signal"))

# Example: Access specific color
# primary_color <- hvl_colors_signal$sjøgrønn$hex  # "#00AFBA"
