library(magrittr)

sales_exp <- readxl::read_excel(path = "./data.xlsx", sheet = "sboisals", skip = 3)
capex_exp <- readxl::read_excel(path = "./data.xlsx", sheet = "sboicaps", skip = 3)
uncertainty <- readxl::read_excel(path = "./data.xlsx", sheet = "sboiuncr", skip = 3)
hiring <- readxl::read_excel(path = "./data.xlsx", sheet = "sboihire", skip = 3)

sboi <- sales_exp %>%
  dplyr::left_join(capex_exp, by = "Dates") %>%
  dplyr::left_join(uncertainty, by = "Dates") %>%
  dplyr::left_join(hiring, by = "Dates") %>%
  set_colnames(c("Dates", "Sales Expectations", "Capital Outlays", "Uncertainty","Hiring Plans")) %>%
  reshape2::melt(id.vars = "Dates") %>%
  dplyr::group_by(variable) %>%
  dplyr::slice_max(Dates, n = 60)

p <- sboi %>%
  ggplot2::ggplot(ggplot2::aes(Dates, value, color = variable)) +
  ggplot2::geom_line(size = 2) +
  ggplot2::facet_wrap(. ~ variable, nrow = 2) +
  ggplot2::scale_color_manual(values = c("#850237", "black","blue","red")) +
  ggplot2::labs(title = "NFIB Small Business Optimism") +
  ggplot2::theme(
    plot.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(3.25)),
    legend.title = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(size = ggplot2::rel(1.5)),
    legend.position = "none",
    axis.title = ggplot2::element_blank(),
    axis.text = ggplot2::element_text(size = ggplot2::rel(1.5)),
    strip.text = ggplot2::element_text(size = ggplot2::rel(1.5), color = "white"),
    strip.background = ggplot2::element_rect(fill = "#850237")
  )

ggplot2::ggsave(
  filename = "./major-indexes.png",
  plot     = p,
  width    = 13.33,
  height   = 6.75,
  units    = 'in'
)