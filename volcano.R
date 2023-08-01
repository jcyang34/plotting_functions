
top_DEs_all$diffexpressed <- "NO"
top_DEs_all$diffexpressed[top_DEs_all$avg_logFC > 2 & top_DEs_all$p_val_adj < 1e-10] <- "UP"
top_DEs_all$diffexpressed[top_DEs_all$avg_logFC < -2 & top_DEs_all$p_val_adj < 1e-10] <- "DOWN"
top_DEs_all$delabel <- NA
top_DEs_all$delabel[top_DEs_all$diffexpressed != "NO"] <- top_DEs_all$gene[top_DEs_all$diffexpressed != "NO"]


top_DEs_all$DE <- top_DEs_all$diffexpressed != "NO"

top_DEs_all$regions <- top_DEs_all$region
top_DEs_all$regions[top_DEs_all$regions == "INS"] <- "Insular Cortex"
top_DEs_all$regions[top_DEs_all$regions == "PFC"] <- "Prefrontal Cortex"
top_DEs_all$regions[top_DEs_all$regions == "VST"] <- "Ventral Striatum"

top_DEs_all$avg_logFC <- -(top_DEs_all$avg_logFC)

volcano_p <- ggplot(data=top_DEs_all, aes(x=avg_logFC, y=-log10(p_val_adj), col=cell_type,shape=regions,label=delabel,alpha=DE)) +
  geom_point(size=3) +
 theme_linedraw() +
  geom_text_repel( max.overlaps =30) +
  scale_color_manual(values=celltype_level0_color_palette) +
  scale_alpha_discrete(range = c(0.1, 0.9))+
  geom_vline(xintercept=c(-2, 2), col=c("blue","red"), linetype="dotted",size=1) +
  annotate(geom="text", x=3, y=30, label="HIV+",
             color="red",size=5) + 
  annotate(geom="text", x=-3, y=30, label="CTR",
           color="blue",size=5)+
  geom_hline(yintercept=-log10(1e-10), col="black", linetype="dotted",size=1) + 
  theme(axis.text=element_text(size=12),
         axis.title=element_text(size=14,face="bold"),
        legend.title=element_text(size=14,face = "bold"), 
        legend.text=element_text(size=12))
