library(ggplot2)

# Set working directory to source file location
#setwd("~/Documents/CS_Courses/CS_510/Midterm Project")
constituents <- read.csv(file = "Data/DonorSearch Aristotle.csv")
sample_constituents <- constituents[constituents$Estimated.Capacity <= 1000000, ]
sample_constituents <- sample_constituents[sample(nrow(sample_constituents), 15000), ]
sample_constituents$Donor.Type <- sample(c("Donor","Non-Donor"), size = nrow(sample_constituents), replace = TRUE)

for (i in seq(1,50,by=1)){
  sample_constituents$Aristotle.Score <- sample_constituents$Aristotle.Score+rnorm(nrow(sample_constituents))
  sample_constituents$Aristotle.Score[sample_constituents$Aristotle.Score > 100] <- 100
  sample_constituents$Aristotle.Score[sample_constituents$Aristotle.Score <= 0] <- 1
  sample_constituents$Size <- 1/log(sample_constituents$Estimated.Capacity + 1)
  aristotle_scatter <- ggplot(sample_constituents,aes(x = Estimated.Capacity, y = Aristotle.Score, color = Donor.Type, size = Size)) + 
    geom_point(alpha = 0.5) + 
    scale_color_manual(values = c("#DE9934","#31CAE1"), guide = "none") +
    scale_size(guide="none", range = c(1,15)) +
    ylim(0,100) +
    labs(x = "Estimated Capacity", y = "Aristotle Score") + 
    theme_classic() + 
    theme(axis.title = element_text(color = "white"),
          axis.text = element_text(color = "white"),
          axis.line = element_line(color = "white"),
          axis.ticks = element_line(color = "white"),
          panel.background = element_rect(fill = "#303841",colour = NA),
          plot.background = element_rect(fill = "#303841",colour = NA))
  aristotle_scatter
  ggsave(paste("animAristotle/Aristotle_",i,".png",sep=""), aristotle_scatter, bg = "#303841", width = 17.333, height = 7.5, units = "in", dpi = 100)
}
