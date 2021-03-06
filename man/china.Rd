% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{china}
\alias{china}
\title{China administraive division shapefile data}
\format{
A simple feature dataframe of China administrative divisions

\describe{
\item{Code_County}{Code of county-level administrative division.}
\item{Code_Perfecture}{Code of perfecture-level administrative division.}
\item{Code_Province}{Code of province-level administrative division.}
\item{Name_Province}{Chinese name of province-level administrative division.}
\item{Name_Perfecture}{Chinese name of perfecture-level administrative division.}
\item{Name_County}{Chinese name of county-level administrative division.}
\item{Pinyin}{Chinese Pinyin.}
\item{Pop_2000}{Population in Year 2000.}
\item{Pop_2010}{Population in Year 2010.}
\item{Pop_2017}{Estimated population in Year 2017.}
\item{Pop_2018}{Estimated population in Year 2018.}
\item{Area}{Land area in square km.}
\item{Density}{Population density in every square km.}
\item{Geometry}{vector geometry of the administrative division.}
}
}
\source{
<https://www.openstreetmap.org/> <http://www.mca.gov.cn/article/sj/xzqh/1980/2019/202002281436.html>
}
\usage{
china
}
\description{
A simple feature dataframe of China administrative divisions. The data was originally queried from OpenStreetMap and manually corrected for errors in QGIS
}
\examples{
head(china)
}
\keyword{datasets}
