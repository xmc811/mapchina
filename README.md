# mapchina

An R package storing the geospatial shapefile (vector data) of China administrative divisions to the county/district-level.

### 中华人民共和国区县级行政区划矢量地图数据

[![Build Status](https://travis-ci.org/xmc811/mapchina.svg?branch=master)](https://travis-ci.org/xmc811/mapchina)
[![Build status](https://ci.appveyor.com/api/projects/status/lrtfd685ytnj9yvd/branch/master?svg=true)](https://ci.appveyor.com/project/xmc811/mapchina/branch/master)

### Installation

```R
install.packages("mapchina")
library(mapchina)
```

---

## Examples 使用示例

### 1. Browsing the dataframe of the shapefile 
### 查看矢量地图数据

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

The main data object `china` is a dataframe, with each row as one county/district level administrative division of China. 
To plot the map of a particular region, you can `filter()` codes or names to subset the dataframe. 
The codes are stored in variables `Code_Province`, `Code_Perfecture`, and `Code_County`, 
and the names are stored in `Name_Province`, `Name_Perfecture`, and `Name_County`.
The codes and names follow the 3-level hierarchy: Province (2-digit), Perfecture (4-digit), and County (6-digit).

在矢量数据`china`中，行政区划的中文名与代码均分为三级：省级、地级与县级，可使用`filter()`进行任意筛选。


注意：直辖市、特别行政区、台湾地区、省直管市以及其他特殊行政区域的地级区域名称`Name_Perfecture`为`NA`。用户可根据作图需要进行修改。

---

### 2. Plotting the population density rank of Beijing, Tianjin, and Hebei 
### 京津冀县级人口密度排名作图

Since the shapefile data is also a dataframe, it can be plotted by ggplot grammer of graphics. The geometric object is `geom_sf()`. 

```R
library(tidyverse)
library(sf)

df <- china %>%
        filter(Code_Province %in% c("11","12","13"))

ggplot(data = df) +
        geom_sf(aes(fill = rank(Density))) +
        scale_fill_distiller(palette = "BuPu", direction = 1) +
        theme_bw() +
        theme(legend.position = "none")
```

<p align="center">
<img src=https://github.com/xmc811/mapchina/blob/master/images/plot_1.png/>
</p>

---

### 3. Plotting the map with customized data
### 使用新加入的数据作图

New data can be added to the shapefile dataframe as new variables

```R
df$Var <- runif(nrow(df))

ggplot(data = df) +
        geom_sf(aes(fill = Var)) +
        scale_fill_distiller(palette = "YlOrRd") +
        theme_bw() +
        theme(legend.position = "none")
```

<p align="center">
<img src=https://github.com/xmc811/mapchina/blob/master/images/plot_2.png/>
</p>

---

### 4. Plotting the map with random color, but no two adjacent regions have the same color. 
### 随机颜色作图并使得相邻区域颜色不一样

We use greedy coloring algorithm to solve the problem. The function `generate_map_colors()` takes a shapefile dataframe as input and outputs a list of index for filling colors.

```R
df2 <- china %>%
        filter(Code_Province %in% c("32"))

ggplot(data = df2) +
        geom_sf(aes(fill = factor(generate_map_colors(df2)))) +
        scale_fill_brewer(palette = "Set3") +
        theme_bw() +
        theme(legend.position = "none")
```

<p align="center">
<img src=https://github.com/xmc811/mapchina/blob/master/images/plot_3.png/>
</p>


---

### 5. Plotting the administrative divisions at higher levels (province or perfecture level)
### 对省地级行政区作图

The geometry of county-level divisions can be merged to higher level divisions by functions `group_by()`, `summarise()`, and `sf::st_union()`.

县级行政区可被合并为地级或省级行政区进行作图。

```R
df3 <- china %>%
        filter(Code_Province %in% as.character(31:36))

df3 <- df3 %>%
        group_by(Name_Province) %>%
        summarise(geometry = st_union(geometry))

ggplot(data = df3) +
        geom_sf(aes(fill = Name_Province)) +
        scale_fill_brewer(palette = "Set3") +
        theme_bw() +
        theme(legend.position = "none")
```

<p align="center">
<img src=https://github.com/xmc811/mapchina/blob/master/images/plot_4.png/>
</p>


---

### 6. Adding Chinese characters to the map
### 在地图中加入汉字标记

To add Chinese characters for the map, R package `showtext` is required.

```R
if (!require("showtext")) {
install.packages("showtext")

showtext::showtext_auto()

ggplot(data = df3) +
        geom_sf(aes(fill = Name_Province)) +
        scale_fill_brewer(palette = "Set3") +
        theme_bw() +
        theme(legend.position = "none") +
        geom_sf_label(aes(label = Name_Province))
```

<p align="center">
<img src=https://github.com/xmc811/mapchina/blob/master/images/plot_5.png/>
</p>


---

### 7. A comprehensive example
### 综合示例：多省地图，按地级行政区划随机着色并加汉字标记，各级区划分界线不同


```R
showtext::showtext_auto()

df4 <- china %>%
        filter(Code_Province %in% c("32","34"))

df4_prov <- df4 %>%
        group_by(Name_Province) %>%
        summarise(geometry = st_union(geometry))

df4_perf <- df4 %>%
        group_by(Name_Perfecture) %>%
        summarise(geometry = st_union(geometry))

ggplot() +
        geom_sf(data = df4_perf,
                aes(fill = factor(generate_map_colors(df4_perf))),
                linetype = "solid", size = 0.5) +
        scale_fill_brewer(palette = "Pastel1") +
        geom_sf(data = df4, alpha = 0, linetype = "dashed", size = 0.2) +
        geom_sf(data = df4_prov, alpha = 0, linetype = "solid", size = 1.2) +
        geom_sf_label(data = df4_perf, aes(label = Name_Perfecture)) +
        theme_bw() +
        theme(legend.position = "none")
```

<p align="center">
<img src=https://github.com/xmc811/mapchina/blob/master/images/plot_6.png/>
</p>


