#' Local climate velocity
#'
#' Function to calculate the velocity of climate change after Burrows et al. 2011
#' based on local climatic temporal trends and spatial gradients.
#'
#' @param tempTrend The output from the tempTrend function containing the long-term linear climatic trends.
#' @param spatGrad The output from the tempTrend function containing the magnitudes and angles for the spatial climatic gradient.
#'
#' @return A \code{RasterStack} containing the climate velocity magnitude ("voccMag",
#' km/yr for unprojected rasters and spatial unit/year for projected rasters) and
#' angle("voccAng" in degrees C).
#'
#' @export
#' @author Jorge Garcia Molinos
#' @examples
#'
#' data(HSST)
#' yrSST <- sumSeries(HSST, p = "1969-01/2009-12", yr0 = "1955-01-01", l = nlayers(HSST), fun = function(x) colMeans(x, na.rm = TRUE),
#' freqin = "months", freqout = "years")
#' tr <- tempTrend(yrSST, th = 10)
#' sg <- spatGrad(yrSST, th = 0.0001, projected = FALSE)
#'
#' # Magnitude and angle of the climate velocity (km/yr) 1960-2009
#'
#' v <- lVoCC(tr,sg)
#' plot(v)
#'
#' @rdname lVoCC

lVoCC <- function(tempTrend, spatGrad){
VoCC <- tempTrend[[1]]/spatGrad[[1]]
# velocity angles have opposite direction to the spatial climatic gradient
VoCCang <- spatGrad[[2]] + 180
VoCCang[] <- ifelse(VoCCang[] >= 360, VoCCang[] - 360, VoCCang[])
output <- stack(VoCC,VoCCang)
names(output) <- c("voccMag", "voccAng")
return(output)
}

