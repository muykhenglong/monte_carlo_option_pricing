# Advanced Financial Modeling and Option Pricing

This repository contains MATLAB functions for sophisticated option pricing techniques using Monte Carlo simulations and control variate methods.

## Repository Contents

### Geometric Brownian Motion
- **`GBM.m`**: Simulates stock price paths under the assumption that prices follow a geometric Brownian motion, a fundamental stochastic process used in financial modeling. This model forms the backbone for simulating the underlying asset paths in option pricing.
- **`GBMwJumps.m`**: Extends the `GBM` model by incorporating jumps, modeled using a Poisson process combined with normally distributed jumps. This model reflects more realistic market scenarios where price jumps (due to news or events) are observed, enhancing the modeling of asset paths for sophisticated option pricing.

### Monte Carlo Simulations
Monte Carlo methods are used for pricing options when analytical solutions are difficult to derive. They rely on the repeated random sampling to compute the results.

- **`EurCallMC.m`**: Uses basic Monte Carlo simulation to estimate the price of European call options. This function is a straightforward application of the Monte Carlo method to the Black-Scholes model.
- **`AsianMC.m`**: Prices Asian options, which are options where the payoff depends on the average price of the underlying asset over a certain period, rather than the price at a single point in time.

### Control Variate Methods
Control variate methods are a variance reduction technique used in Monte Carlo simulations. By using a control variate, a known quantity with a known expected value, the variance of the simulation output can be reduced.

- **`ControlAsian.m`**: Enhances the accuracy of Asian option pricing using the control variate method.
- **`STControlMC.m`**: Applies control variates using the stock prices at maturity to improve the accuracy of pricing calculations for standard options.

### Antithetic Variates
Antithetic variates are another variance reduction technique that involves generating pairs of negatively correlated random variables to reduce the error in simulation.

- **`EuroAntithetic.m`**: Improves the efficiency of European option pricing simulations by generating antithetic paths, which are negatively correlated to each other, thus reducing the variance of the estimator.

### Exotic Options
Exotic options are more complex than standard options, often having features that make them behave differently from ordinary call and put options.

- **`ExchangeMC.m`**: Prices exchange options, which allow the holder to exchange one asset for another. The function simulates two correlated asset paths and calculates the option's payoff based on the difference in their final prices.
