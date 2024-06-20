use v6.d;


unit module Math::Polynomial::Chebyshev;

#----------------------------------------------------------
proto sub chebyshev-t-rec(UInt:D $k, $x, %cheb) {*}

multi sub chebyshev-t-rec(UInt:D $k, Numeric:D $x, %cheb) {

    if %cheb{($k, $x).join(':')}:exists {
        return %cheb{($k, $x).join(':')};
    }

    my $res = do given $k {
        when 0 { 1 }
        when 1 { $x }
        default {
            2 * $x * chebyshev-t-rec($k-1, $x, %cheb) - chebyshev-t-rec($k-2, $x, %cheb);
        }
    };

    %cheb.push(Pair.new(($k, $x).join(':'), $res));

    return $res;
}

multi sub chebyshev-t-rec(UInt:D $k, @x, %cheb) {

    if %cheb{$k}:exists {
        return %cheb{$k};
    }

    my @res = do given $k {
        when 0 { (1 xx @x.elems).Array }
        when 1 { @x }
        default {
            2 <<*<< @x <<*>> chebyshev-t-rec($k-1, @x, %cheb) <<->> chebyshev-t-rec($k-2, @x, %cheb);
        }
    };

    %cheb{$k} = @res;

    return @res;
}

#----------------------------------------------------------
proto sub chebyshev-t-trig(UInt:D $k, Numeric:D $x) {*}

multi sub chebyshev-t-trig(UInt:D $k, Numeric:D $x) {
    return do given $x {
        when $_.abs ≤ 1 { cos($k * acos($x)) }
        when $_ ≥ 1 { cosh($k * acosh($x)) }
        when $_ ≤ -1 { (-1) ** $k * cosh($k * acosh($x)) }
    }
}

#----------------------------------------------------------
proto sub chebyshev-t(UInt:D $k, $x, :$method is copy = Whatever) is export {*}

multi sub chebyshev-t(UInt:D $k, :$method is copy = Whatever) {

}

multi sub chebyshev-t(UInt:D $k, $x, :$method is copy = Whatever) {

    if $method.isa(Whatever) || $method.isa(WhateverCode) {
        $method = 'recursive';
    }
    die 'The value of $method is expected to be a string, Whatever, or WhateverCode'
    unless $method ~~ Str:D;

    if !($x ~~ Numeric:D || $x ~~ Positional:D && $x.all ~~ Numeric:D ) {
        die 'The second argument is expected to be number or a list of numbers.';
    }

    return do given $method.lc {
        when $_ ∈ <recursive rec> {
            my %cheb = %();
            chebyshev-t-rec($k, $x, %cheb);
        }
        when $_ ∈ <trigonometric trig> {
            $x ~~ Numeric:D ?? chebyshev-t-trig($k, $x) !! $x.map({ chebyshev-t-trig($k, $_) });
        }
        default {
            die 'Do not know how to process the given method spec.';
        }
    }
}