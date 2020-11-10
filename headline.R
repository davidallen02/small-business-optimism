library(magrittr)

sboitotl <- readxl::read_excel(path = "data.xlsx", sheet = "sboitotl", skip = 3) %>%
  set_colnames(c("dates","values")) %>%
  dplyr::slice_max(dates, n = 170)

p <- sboitotl %>%
  ggplot2::ggplot(ggplot2::aes(dates, values)) +
  ggplot2::geom_line(color = "#850237", size = 2) +
  ggplot2::labs(title = "NFIB Small Business Optimism Index") +
  ggplot2::theme(
    plot.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(3.25)),
    legend.title = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(size = ggplot2::rel(1.5)),
    legend.position = "bottom",
    axis.title = ggplot2::element_blank(),
    axis.text = ggplot2::element_text(size = ggplot2::rel(1.5))
  )

ggplot2::ggsave(
  filename = "sboitotl.png",
  plot     = p,
  width    = 13.33,
  height   = 7,
  units    = 'in'
)