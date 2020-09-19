# mapchina

An R package storing geospatial vector data format (shapefile) of China administrative divisions to the county-level.

中华人民共和国县级行政区划矢量地图数据

[![Build Status](https://travis-ci.org/xmc811/mapchina.svg?branch=master)](https://travis-ci.org/xmc811/mapchina)
[![Build status](https://ci.appveyor.com/api/projects/status/lrtfd685ytnj9yvd/branch/master?svg=true)](https://ci.appveyor.com/project/xmc811/mapchina/branch/master)


### Examples

To browse the top rows of the shapefile:

查看矢量地图数据：

```R
head(china)
```

```R
# Output 输出
Simple feature collection with 6 features and 13 fields
geometry type:  MULTIPOLYGON
dimension:      XY
bbox:           xmin: 115.4248 ymin: 39.44473 xmax: 116.8805 ymax: 41.05936
geographic CRS: WGS 84
# A tibble: 6 x 14
  Code_County Code_Perfecture Code_Province Name_Province Name_Perfecture Name_County Pinyin Pop_2000 Pop_2010 Pop_2017 Pop_2018   Area Density
  <chr>       <chr>           <chr>         <chr>         <chr>           <chr>       <chr>     <dbl>    <dbl>    <dbl>    <dbl>  <dbl>   <dbl>
1 110101      1101            11            北京市        NA              东城区      Dōngc…   881763   919253       NA   822000   41.8  19670.
2 110102      1101            11            北京市        NA              西城区      Xīché…  1232823  1243315       NA  1179000   50.5  23360.
3 110114      1101            11            北京市        NA              昌平区      Chāng…   614821  1660501       NA  2108000 1342     1571.
4 110115      1101            11            北京市        NA              大兴区      Dàxīn…   671444  1365112       NA  1796000 1053     1706.
5 110111      1101            11            北京市        NA              房山区      Fángs…   814367   944832       NA  1188000 1995      595.
6 110116      1101            11            北京市        NA              怀柔区      Huáir…   296002   372887       NA   414000 2123      195.
# … with 1 more variable: geometry <MULTIPOLYGON [°]>
```

To plot the population density rank of Beijing, Tianjin, and Hebei:

京津冀县级人口密度排名作图：

```R
library(tidyverse)

df <- china %>%
        filter(Code_Province %in% c("11","12","13"))

ggplot() +
        geom_sf(data = df,
                aes(fill = rank(Density))) +
        scale_fill_distiller(palette = "BuPu", direction = 1) +
        theme_bw() +
        theme(legend.position = "none")
        
```

<p align="center">
<img src=https://github.com/xmc811/mapchina/blob/master/images/plot_1.png/>
</p>



