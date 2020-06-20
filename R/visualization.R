
# Plotting Functions

#' Main Plotting Function
#'
#' @param area An integer vector - the area code of administraive divisions. Default value is \code{32} for Jiangsu Province.
#' @param palette A string - the RColorBrewer palette used to color map. Default value is \code{"Set3"}
#' @param simplify_ratio A double - Between 0 and 1. The simplification ratio of map generation.
#' @param prov_line A string - The linetype of province-level divisions.
#' @param perf_line A string - The linetype of perfecture-level divisions.
#' @param county_line A string - The linetype of county-level divisions.
#'
#' @return A plot
#' @importFrom dplyr filter arrange
#' @importFrom magrittr %>%
#' @importFrom RColorBrewer brewer.pal
#' @importFrom ggplot2 ggplot scale_fill_manual theme_bw theme geom_sf
#' @importFrom rmapshaper ms_simplify
#' @export

plot_china <- function(area = 32,
                       palette = "Set3",
                       simplify_ratio = 0.05,
                       prov_line = "solid",
                       perf_line = "solid",
                       county_line = "dashed") {

        df <- china %>%
                filter(Code_Province == area) %>%
                arrange(Code_County) %>%
                ms_simplify(keep = simplify_ratio)

        df_prov <- df %>%
                group_by(Code_Province) %>%
                summarise(geometry = st_union(geometry))

        df_perf <- df %>%
                group_by(Code_Perfecture) %>%
                summarise(geometry = st_union(geometry))

        colors <- brewer.pal(8, palette)

        color_vec <- colors[generate_map_colors(df)]

        ggplot() +
                geom_sf(data = df,
                        aes(fill = Code_County),
                        linetype = county_line,
                        size = 0.2) +
                scale_fill_manual(values = color_vec) +
                theme_bw() +
                theme(legend.position = "none") +
                geom_sf(data = df_perf,
                        linetype = perf_line,
                        size = 0.5,
                        alpha = 0) +
                geom_sf(data = df_prov,
                        linetype = prov_line,
                        size = 1,
                        alpha = 0)

}
