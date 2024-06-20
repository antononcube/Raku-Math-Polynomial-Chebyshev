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

**Remark:** Currently, the trigonometric method is implemented only for the Chebyshev polynomials of first kind.
(Chebyshev-T).

Plot the 10th Chebyshev-T polynomial:

```perl6
use Text::Plot;

my @x = (-1, -0.99 ... 1);
text-list-plot(@x, chebyshev-t(6, @x), width => 80)
```

Here we make a Chebyshev-T function:

```perl6
chebyshev-u(4)
```

--------

## References

### Articles

[WK1] Wolfram Koepf,
["Efficient Computation of Chebyshev Polynomials in Computer Algebra"](https://www.researchgate.net/publication/2321141_Efficient_Computation_of_Chebyshev_Polynomials_in_Computer_Algebra). 
(1999),
Computer Algebra Systems: A Practical Guide. 79-99.

[Wk1] Wikipedia entry, [Chebyshev polynomials](https://en.wikipedia.org/wiki/Chebyshev_polynomials).

### Packages

[AAp1] Anton Antonov, 
[Text::Plot Raku package](https://github.com/antononcube/Raku-Text-Plot),
(2022-2023),
[GitHub/antononcube](https://github.com/antononcube).

[AAp2] Anton Antonov,
[Math::Fitting Raku package](https://github.com/antononcube/Raku-Math-Fitting),
(2024),
[GitHub/antononcube](https://github.com/antononcube).

[SFp1] Solomon Foster,
[Math::ChebyshevPolynomial Raku package](https://github.com/colomon/Math-ChebyshevPolynomial),
(2013-2015),
[GitHub/colomon](https://github.com/colomon).