
# Helper Functions

generate_map_colors <- function(sf) {

        bd <- st_intersects(sf, sf, sparse = FALSE)

        n <- nrow(sf)

        colors <- rep(0, n)

        for (i in seq_along(1:n)) {

                colors[i] <- get_mex(bd[i,], colors, i)

        }
        return(colors)
}

get_mex <- function(v, colors, idx) {

        res <- (v * colors)[1:idx]
        return(match(FALSE, 1:idx %in% res))
}
