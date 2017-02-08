# Network learning via multi-agent inverse transportation problems
Despite the ubiquity of transportation data, statistical inference methods alone are not able to explain mechanistic relations within a network. Inverse optimization methods that capture network structure fulfill this gap, but they are designed to take observations of the same model to learn the parameters of that model. New inverse optimization models and supporting algorithms are proposed to learn the parameters of heterogeneous travelers’ route optimization such that the value of shared network resources (e.g. link capacity dual prices) can be inferred. The inferred values are internally consistent with each agent’s optimization program. We prove that the method can obtain unique dual prices for a network shared by these agents, in polynomial time. Three experiments are conducted. The first one, conducted on a 4-node network, verifies the methodology to obtain heterogeneous link cost parameters even when a mixed logit model cannot provide meaningful results. The second is a parameter recovery test on the Nguyen-Dupuis network that shows that unique latent link capacity dual prices can be inferred using the proposed method. The last test on the same network demonstrates how a monitoring system in an online learning environment can be designed using this method.

