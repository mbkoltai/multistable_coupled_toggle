# Creating multistability by coupling self-activating genetic components

Creating multistability with 2/3/4 stable fixed points by connecting self-activating genes via double inhibition.

<!--- comments like this --->
This repository contains a few MATLAB scripts to model the stationary and dynamical behavior of a toggle switch [1] where the two genes (variables) inhibit each other but also have nonlinear self-activation. This is an abstract, ordinary differential equation (ODE) model that does not describe stochastic fluctuations or the details of the underlying biochemical processes (transcription, translation, folding etc), as my interest here was to model multistable behavior in general.

My idea (coming from this paper) was that if the genes are bistable on their own then their nullclines can have 9 intersection points, ie. the two-dimensional systems when these genes are coupled can have up to 4 stable fixed points. Imagine two 'S' letters, one aligned with the x axis, the other with the y - how many times can they intersect?

All commands for running calculations and visualizing plots are in the main script [multistable.m](https://github.com/mbkoltai/multistable_coupled_toggle/blob/master/multistable.m), the other files are functions.

For a detailed explanation of the equations and visualizations see [this post](https://mbkoltai.github.io/multistable/) on my blog.

References

[1] [Gardner, T.S., Cantor, C.R. and Collins, J.J., 2000. Construction of a genetic toggle switch in Escherichia coli. Nature, 403(6767), p.339.](https://www.nature.com/articles/35002131)
[2] Lu, M., Jolly, M.K., Gomoto, R., Huang, B., Onuchic, J. and Ben-Jacob, E., 2013. Tristability in cancer-associated microRNA-TF chimera toggle switch. The journal of physical chemistry B, 117(42), pp.13164-13174.
