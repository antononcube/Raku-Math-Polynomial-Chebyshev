use v6.d;


unit module Math::Polynomial::Chebyshev;

#==========================================================
# Chebyshev recursive (universal)
#==========================================================
proto sub chebyshev-rec(Str:D $t, UInt:D $k, $x, %cheb) {*}

multi sub chebyshev-rec(Str:D $t, UInt:D $k, Numeric:D $x, %cheb) {

    if %cheb{($k, $x).join(':')}:exists {
        return %cheb{($k, $x).join(':')};
    }

    my $res = do given $k {
        when 0 { 1 }
        when 1 { $t.lc eq 't' ?? $x !! 2 * $x }
        default {
            2 * $x * chebyshev-rec($t, $k-1, $x, %cheb) - chebyshev-rec($t, $k-2, $x, %cheb);
        }
    };

    %cheb.push(Pair.new(($k, $x).join(':'), $res));

    return $res;
}

multi sub chebyshev-rec(Str:D $t, UInt:D $k, @x, %cheb) {

    if %cheb{$k}:exists {
        return %cheb{$k};
    }

    my @res = do given $k {
        when 0 { (1 xx @x.elems).Array }
        when 1 { $t.lc eq 't' ?? @x !! 2 <<*<< @x }
        default {
            2 <<*<< @x <<*>> chebyshev-rec($t, $k-1, @x, %cheb) <<->> chebyshev-rec($t, $k-2, @x, %cheb);
        }
    };

    %cheb{$k} = @res;

    return @res;
}

#==========================================================
# Chebyshev trig
#==========================================================
proto sub chebyshev-t-trig(UInt:D $k, Numeric:D $x) {*}

multi sub chebyshev-t-trig(UInt:D $k, Numeric:D $x) {
    return do given $x {
        when $_.abs ≤ 1 { cos($k * acos($x)) }
        when $_ ≥ 1 { cosh($k * acosh($x)) }
        when $_ ≤ -1 { (-1) ** $k * cosh($k * acosh($x)) }
    }
}

#----------------------------------------------------------
proto sub chebyshev-u-trig(UInt:D $k, Numeric:D $x) {*}

multi sub chebyshev-u-trig(UInt:D $k, Numeric:D $x) {
    return do given $x {
        when $_.abs ≤ 1 { cos($k * acos($x)) }
        when $_ ≥ 1 { cosh($k * acosh($x)) }
        when $_ ≤ -1 { (-1) ** $k * cosh($k * acosh($x)) }
    }
}

#==========================================================
# Chebyshev universal
#==========================================================-
proto sub chebyshev(UInt:D $k, $x, :$type, :$method) {*}

multi sub chebyshev(UInt:D $k, $x, Str:D :$type = 'T', :$method is copy = Whatever) {

    die 'The value of $type is expected to be "T" or "U".'
    unless $type.lc ∈ <t u>;

    if $method.isa(Whatever) || $method.isa(WhateverCode) {
        $method = 'recursive';
    }
    die 'The value of $method is expected to be a string, Whatever, or WhateverCode'
    unless $method ~~ Str:D;

    if !($x ~~ Numeric:D || $x ~~ Positional:D && $x.all ~~ Numeric:D ) {
        die 'The second argument is expected to be number or a list of numbers.';
    }

    return do given ($type.lc, $method.lc) {
        when $_.tail ∈ <recursive rec> {
            my %cheb = %();
            chebyshev-rec($type, $k, $x, %cheb);
        }
        when $_.tail ∈ <trigonometric trig> {
            if $_.head eq 't' {
                $x ~~ Numeric:D ?? chebyshev-t-trig($k, $x) !! $x.map({ chebyshev-t-trig($k, $_) });
            } else {
                die 'Trigonometric method is implemented only for Chebyshev T (first kind) polynomials.';
            }
        }
        default {
            die 'Do not know how to process the given method spec.';
        }
    }
}

#==========================================================
# Chebyshev T
#==========================================================
proto sub chebyshev-t(UInt:D $k, |) is export {*}

multi sub chebyshev-t(UInt:D $k, :$method is copy = Whatever) {
    return { chebyshev-t($k, $_, :$method) };
}

multi sub chebyshev-t(UInt:D $k, Whatever, :$method is copy = Whatever) {
    return { chebyshev-t($k, $_, :$method) };
}

multi sub chebyshev-t(UInt:D $k, $x, :$method is copy = Whatever) {
    return chebyshev($k, $x, type => 'T', :$method);
}

#==========================================================
# Chebyshev U
#==========================================================
proto sub chebyshev-u(UInt:D $k, |) is export {*}

multi sub chebyshev-u(UInt:D $k, :$method is copy = Whatever) {
    return { chebyshev-u($k, $_, :$method) };
}

multi sub chebyshev-t(UInt:D $k, Whatever, :$method is copy = Whatever) {
    return { chebyshev-u($k, $_, :$method) };
}

multi sub chebyshev-u(UInt:D $k, $x, :$method is copy = Whatever) {
    return chebyshev($k, $x, type => 'U', :$method);
}