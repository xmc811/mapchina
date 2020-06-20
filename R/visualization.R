
# Plotting Functions

#' Main Plotting Function
#'
#' @param area An integer vector - the area code of administraive divisions
#' @param palette A string - the palette used to color map
#'
#' @return A plot
#' @importFrom dplyr filter arrange
#' @importFrom magrittr %>%
#' @importFrom RColorBrewer brewer.pal
#' @importFrom ggplot2 ggplot scale_fill_manual theme_bw theme geom_sf
#' @export

plot_china <- function(area = 11,
                       palette = "Set1") {

        df <- china %>%
                filter(Code_Province == area) %>%
                arrange(Code_County)

        colors <- brewer.pal(8, palette)

        color_vec <- colors[generate_map_colors(df)]

        ggplot(df) +
                geom_sf(aes(fill = Code_County)) +
                scale_fill_manual(values = color_vec) +
                theme_bw() +
                theme(legend.position = "none")

}
