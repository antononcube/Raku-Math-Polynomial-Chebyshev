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
```
# -0.82
```

The default method is "recursive":

```perl6
chebyshev-t(2, 6, method => 'recursive')
```
```
# 71
```

Here is an invocation of the  "trigonometric" method:

```perl6
chebyshev-t(2, 3, method => 'trigonometric')
```
```
# 17
```

Plot the 10th Chebyshev-T polynomial:

```perl6
use Text::Plot;

chebyshev-t(6, (-1, -0.99 ... 1).Array)
==> text-list-plot(width => 80)
```
```
# +---+-----------------+----------------+-----------------+----------------+----+      
# |                                                                              |      
# +   *               *****                              *****              *    +  1.00
# |                  **   **                           **    **                  |      
# |    *            *       *                          *      **            *    |      
# |                **       **                        *        *                 |      
# +                *          *                      *          *                +  0.50
# |    *          *           **                    **          **          *    |      
# |              **            *                    *            **              |      
# |     *        *              *                 **              *        *     |      
# +             **               *                *               **             +  0.00
# |     *       *                **              *                 *       *     |      
# |     *      **                 *             **                 **      *     |      
# +      *     *                   *            *                   *     *      + -0.50
# |      *    **                   **          *                    **    *      |      
# |      *   **                      *        *                      *    *      |      
# |       *  *                        **    **                        *  *       |      
# +       ***                          ******                         ****       + -1.00
# |                                                                              |      
# +---+-----------------+----------------+-----------------+----------------+----+      
#     0.00              50.00            100.00            150.00           200.00
```
