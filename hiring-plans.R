library(magrittr)

sboihire <- readxl::read_excel(path = "data.xlsx", sheet = "sboihire", skip = 2) %>%
  set_colnames(c("dates","values")) %>%
  dplyr::slice_max(dates, n = 170)

p <- sboihire %>%
  ggplot2::ggplot(ggplot2::aes(dates, values)) +
  ggplot2::geom_line(color = "#850237", size = 2) +
  ggplot2::labs(
    title = "Small Business Hiring Plans",
    subtitle = "Net Percentage of Firms Hiring"
  ) +
  ggplot2::theme(
    plot.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(3.25)),
    plot.subtitle = ggplot2::element_text(size = ggplot2::rel(2)),
    legend.title = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(size = ggplot2::rel(1.5)),
    legend.position = "bottom",
    axis.title = ggplot2::element_blank(),
    axis.text = ggplot2::element_text(size = ggplot2::rel(1.5))
  )

ggplot2::ggsave(
  filename = "sboihire.png",
  plot     = p,
  width    = 13.33,
  height   = 7.5,
  units    = 'in'
)