# Math::Polynomial::Chebyshev

Raku package for functionalities based on Chebyshev polynomials.

------

## Installation

From Zef ecosystem:

```
zef install Math::Polynomial::Chebyshev 
```

From GitHub:

```
zef install https://github.com/antononcube/Raku-Math-Polynomial-Chebyshev.git
```

-------

## Usage examples

Evaluate the numerical value of the Chebyshev polynomial of first kind $T_2(3)$:

```perl6
use Math::Polynomial::Chebyshev;

chebyshev-t(2, 0.3)
```

The default method is "recursive":

```perl6
chebyshev-t(2, 6, method => 'recursive')
```

Here is an invocation of the  "trigonometric" method:

```perl6
chebyshev-t(2, 3, method => 'trigonometric')
```

Plot the 10th Chebyshev-T polynomial:

```perl6
use Text::Plot;

chebyshev-t(6, (-1, -0.99 ... 1).Array)
==> text-list-plot(width => 80)
```
