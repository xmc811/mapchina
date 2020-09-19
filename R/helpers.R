
# Helper Functions

#' Generate map colors by greedy coloring algorithm so that bordering features are colored differently
#'
#' @param sf An simple feature dataframe - the shapefile of investigation
#'
#' @return An integer vector - the indices of map colors
#' @importFrom sf st_intersects
#'
#' @examples
#' generate_map_colors(head(china, 10))
#'
#' @export

generate_map_colors <- function(sf) {

        bd <- st_intersects(sf, sf, sparse = FALSE)

        n <- nrow(sf)

        colors <- rep(0, n)

        for (i in seq_along(1:n)) {

                colors[i] <- get_mex(bd[i,], colors, i)

        }
        return(colors)
}

#' Get the mex number of a vector
#'
#' @param v An logical vector - the intersection vector
#' @param colors An integer vector - the color assignment vector
#' @param idx An integer - the index
#'
#' @return An integer
#'
#' @examples
#' get_mex(c(TRUE,TRUE,FALSE,FALSE,TRUE), 1:5, 4)
#'
#' @export

get_mex <- function(v, colors, idx) {

        res <- (v * colors)[1:idx]
        return(match(FALSE, 1:idx %in% res))
}



