library(ggplot2)
library(gridExtra)
library(dplyr)

# Set working directory to source file location
#setwd("~/Documents/CS_Courses/CS_510/Midterm Project")
df <- read.csv(file = "Data/DonorSearch Insights.csv")
constituents <- df[,c("Total.Gift.Amount", "Constituency.Type", "Pref_Year", "Estimated.Capacity", "Wealth.Based.Capacity", "Acquisition.Rank", "Retention.Rank", "Upgrade.Rank", "Lifetime.Value.Rank", "Acquisition.Score", "Retention.Score", "Upgrade.Score", "Lifetime.Value.Score")]
constituents$Wealth.Based.Capacity <- substr(constituents$Wealth.Based.Capacity, 5, nchar(constituents$Wealth.Based.Capacity))
constituents$Wealth.Based.Capacity <- gsub(" ", "\n", constituents$Wealth.Based.Capacity)
constituents[constituents$Wealth.Based.Capacity == "$10\nMillion\n-\n$50\nMillion", "Wealth.Based.Capacity"] = "$10 Million\n-\n$50 Million"
constituents[constituents$Wealth.Based.Capacity == "$50\nMillion\n-\n$100\nMillion", "Wealth.Based.Capacity"] = "$50 Million\n-\n$100 Million"
constituents[constituents$Wealth.Based.Capacity == "$100\nMillion+", "Wealth.Based.Capacity"] = "$100 Million+"
constituents$Wealth.Based.Capacity <- factor(constituents$Wealth.Based.Capacity, levels=c("Unable\nto\nRate", "$1\n-\n$2,499", "$2,500\n-\n$4,999", "$5,000\n-\n$9,999", "$10,000\n-\n$14,999", "$15,000\n-\n$24,999", "$25,000\n-\n$49,999", "$50,000\n-\n$99,999", "$100,000\n-\n$249,999", "$250,000\n-\n$499,999", "$500,000\n-\n$999,999", "$1,000,000\n-\n$4,999,999", "$5,000,000\n-\n$9,999,999", "$10 Million\n-\n$50 Million", "$50 Million\n-\n$100 Million", "$100 Million+"))
non_donors <- constituents[constituents$Acquisition.Rank != "",]
constituents <- constituents %>% mutate(Constituency.Type = if_else(Constituency.Type == "Alumni", "Alumni", "Non-Alumni"))
constituents <- constituents %>% mutate(Donor.Type = if_else(Total.Gift.Amount > 0, "Donor", "Non-Donor"))

# Scatter Plots of Score Distributions
acq_scatter <- ggplot(non_donors,aes(x = Estimated.Capacity, y = Acquisition.Score, color = Acquisition.Rank)) + 
  geom_point() + 
  facet_grid(.~Wealth.Based.Capacity, scales = "free") +
  scale_color_manual(values = c("#48C2CB", "#3394A8", "#1D6786", "#083963")) +
  labs(x = "Wealth Based Capacity", y = "Acquisition Score", color = "Acquisition Rank") + 
  theme_bw() + 
  theme(legend.position = "bottom",
        strip.text.x = element_text(size = 4), 
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing.x = unit(0,"line"))

ret_scatter <- ggplot(constituents,aes(x = Estimated.Capacity, y = Retention.Score, color = Retention.Rank)) + 
  geom_point() + 
  facet_grid(.~Wealth.Based.Capacity,scales="free") +
  scale_color_manual(values = c("#F38531", "#D9632B", "#C04125", "#A61F1F")) +
  labs(x = "Wealth Based Capacity", y = "Retention Score", color = "Retention Rank") + 
  theme_bw() + 
  theme(legend.position = "bottom",
        strip.text.x = element_text(size = 4), 
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing.x = unit(0,"line"))

upg_scatter <- ggplot(constituents,aes(x = Estimated.Capacity, y = Upgrade.Score, color = Upgrade.Rank)) + 
  geom_point() + 
  facet_grid(.~Wealth.Based.Capacity,scales = "free") +
  scale_color_manual(values = c("#73BCDC", "#3C7C94", "#053C4B")) +
  labs(x = "Wealth Based Capacity", y = "Upgrade Score", color = "Upgrade Rank") + 
  theme_bw() + 
  theme(legend.position = "bottom",
        strip.text.x = element_text(size = 4), 
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing.x = unit(0,"line"))

ltv_scatter <- ggplot(constituents,aes(x = Estimated.Capacity, y = Lifetime.Value.Score, color = Lifetime.Value.Rank)) + 
  geom_point() + 
  facet_grid(.~Wealth.Based.Capacity,scales = "free") +
  scale_color_manual(values = c("#C1D8DF", "#94B4B9", "#679092")) +
  labs(x = "Wealth Based Capacity", y = "Lifetime Value Score", color = "Lifetime Value Rank") + 
  theme_bw() + 
  theme(legend.position = "bottom",
        strip.text.x = element_text(size = 4), 
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing.x = unit(0,"line"))

scatter <- grid.arrange(acq_scatter, ret_scatter, upg_scatter, ltv_scatter, nrow = 2)
ggsave("Images/DonorSearch Insights Scatter.png", scatter, width = 13, height = 9, units = "in")

# Bar Plots of Score Distribution
acq_bar <- ggplot(non_donors,aes(x=Wealth.Based.Capacity, fill=Acquisition.Rank)) + 
  geom_bar() + 
  scale_fill_manual(values = c("#48C2CB", "#3394A8", "#1D6786", "#083963")) +
  labs(x = "Wealth Based Capacity", y = "Number of Constituents", fill = "Acquisition Rank") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust=1, vjust = 0.5),
        panel.grid.minor = element_blank())

ret_bar <- ggplot(constituents,aes(x=Wealth.Based.Capacity, fill=Retention.Rank)) + 
  geom_bar() + 
  scale_fill_manual(values = c("#F38531", "#D9632B", "#C04125", "#A61F1F")) +
  labs(x = "Wealth Based Capacity", y = "Number of Constituents", fill = "Retention Rank") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust=1, vjust=0.5),
        panel.grid.minor = element_blank())

upg_bar <- ggplot(constituents,aes(x=Wealth.Based.Capacity, fill=Upgrade.Rank)) + 
  geom_bar() + 
  scale_fill_manual(values = c("#73BCDC", "#3C7C94", "#053C4B")) +
  labs(x = "Wealth Based Capacity", y = "Number of Constituents", fill = "Upgrade Rank") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust=1, vjust=0.5),
        panel.grid.minor = element_blank())

ltv_bar <- ggplot(constituents,aes(x=Wealth.Based.Capacity, fill=Lifetime.Value.Rank)) + 
  geom_bar() + 
  scale_fill_manual(values = c("#C1D8DF", "#94B4B9", "#679092")) +
  labs(x = "Wealth Based Capacity", y = "Number of Constituents", fill = "Lifetime Value Rank") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust=1, vjust=0.5),
        panel.grid.minor = element_blank())

bar <- grid.arrange(acq_bar, ret_bar, upg_bar, ltv_bar, nrow = 2)
ggsave("Images/DonorSearch Insights Bar.png", bar, width = 13, height = 9, units = "in")

# Alumni vs. Non-Alumni
alumni <- constituents %>% group_by(Constituency.Type, Donor.Type) %>% summarise(Frequency = n())
alumni_plot <- ggplot(alumni, aes(x = Constituency.Type, y = Frequency, fill = Donor.Type, label = Frequency)) +
  geom_bar(stat = "identity") + 
  geom_text(size = 3, position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = c("#48C2CB","#F38531")) +
  labs(x = "Constituency Type", y = "Number of Constituents", fill = "Donor Type", title = "Number of Constituents by Constituency Type") + 
  theme_classic()
ggsave("Images/DonorSearch Insights Alumni.png", alumni_plot, width = 9, height = 13, units = "in")

# Number of Constituents by Graduation Year
grad_year <- constituents %>% count(Pref_Year, Donor.Type) %>%  na.omit()
grad_plot <- ggplot(grad_year, aes(x = Pref_Year, y = n, color = Donor.Type)) +
  geom_line() + 
  scale_color_manual(values = c("#48C2CB","#F38531")) +
  labs(x = "Graduation Year", y = "Number of Constituents", color = "Donor Type", title = "Number of Constituents by Graduation Year") + 
  theme_bw()
ggsave("Images/DonorSearch Insights Graduation.png", grad_plot, width = 13, height = 9, units = "in")
