#Week 7 Day 3 homework - notes for Delphine

#Overall would advise creating a theme/function if reusing the same (even the labels too)

## How to stop the residual line stopping short

#Method 1
ggplot(data = project) +
  aes(x = estimated_length, y = actual_length) +
  geom_point(, 
             colour = "powderblue") +
  geom_smooth(, 
              method = "lm", colour = "deepskyblue1") +
  geom_point(data = project_less_non_inf, aes(x = estimated_length, y = actual_length), 
             colour = "yellow1") +
  geom_smooth(data = project_less_non_inf, 
              aes(x = estimated_length, y = actual_length), 
              method = "lm", colour = "orange", linetype = "dotted") +
  labs(
    x = "Estimated Project Length",
    y = "Actual Project Length",
    title = "Linear Regression"
  ) +
  theme_dark() +
  theme(
    title = element_text(size = 12, face = "bold"), 
    axis.title = element_text(size = 8, face = "bold"), 
    panel.grid = element_line(colour = "grey67")
  )


#Method 2
ggplot() +
  geom_point(data = project, aes(x = estimated_length, y = actual_length), 
             colour = "powderblue") +
  geom_smooth(data = project, 
              aes(x = estimated_length, y = actual_length), 
              method = "lm", colour = "deepskyblue1") +
  geom_point(data = project_less_inf, aes(x = estimated_length, y = actual_length), 
             colour = "yellow1") +
  geom_smooth(data = project_less_inf, 
              aes(x = estimated_length, y = actual_length), 
              method = "lm", colour = "orange", linetype = "dotted", fullrange = T) +
  labs(
    x = "Estimated Project Length",
    y = "Actual Project Length",
    title = "Linear Regression"
  ) +
  theme_dark() +
  theme(
    title = element_text(size = 12, face = "bold"), 
    axis.title = element_text(size = 8, face = "bold"), 
    panel.grid = element_line(colour = "grey67")
  )


## Adding legend manually 

#Base R 
#removing the 2 black entries 
#if adding legend in base R basically need to spell out agin what wrote when specifying plot

#ggplot

#where possible restrcuture so can split line by group rather than layering mulitple lines 

ggplot(project) +
  aes(x = estimated_length, y = actual_length) +
 # geom_point(colour = "powderblue") +
  geom_smooth(method = "lm", mapping=aes(colour="deepskyblue1")) +
  geom_smooth(method = "rlm", linetype = "dotted", mapping=aes(colour = "orange")) +
  scale_colour_manual(name="legend", values=c("deepskyblue1", "orange"), labels = c("lm fit", "rlm fit"))



