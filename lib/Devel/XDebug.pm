package Devel::XDebug;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(debug);
$VERSION = "0.0.2";
$ERROR_BIGREF_LEVEL = \5;
$ERROR_BIGREF_MSG = \"Error: one of the references refers to itself!";
sub debug
{
	my($dt, %exprs) = @_;
	print "Content-type: text/plain" if($dt eq 'cgi');
	print "eXtended Debug Dump:\n\n";
	my @res = ();	
	foreach(keys %exprs)
	{
		print "$_ = ";
		push @res, dump_debug($exprs{$_});
		print "\n\n";
	}
	print "\n\neXtended Debug Dump OK.\n";
	return get_retval(\@res);
}
sub dump_debug
{
	my $ref = shift;
	my $type = ref($ref);
	if(!$ref)
	{
		print "{undef}";
		return 0;
	}
	if($type eq '')
	{
		print "\"", quotemeta($ref), "\"";
	}
	elsif($type eq 'REF')
	{
		$level = shift;
		$level = 0 if(!$level);
		print "\\";
		if($level >= $$ERROR_BIGREF_LEVEL)
		{
			print $$ERROR_BIGREF_MSG;
			return -1;
		}
		return dump_debug($$ref, $level + 1);
	}
	elsif($type eq 'SCALAR')
	{
		print "\\";
		return dump_debug($$ref);
	}
	elsif($type eq 'ARRAY')
	{
		print "[";
		$i = 1;
		my @res = ();
		foreach(@$ref)
		{
			push @res, dump_debug($_);
			print ", " if($i != @$ref);
			$i ++;
		}
		print "]";
		return get_retval(\@res);
	}
	elsif($type eq 'HASH')
	{
		print "{";
		my $i = 1;
		my @keys = keys %$ref;
		my @res = ();
		foreach(@keys)
		{
			push @res, dump_debug($_);
			print " => ";
			push @res, dump_debug($ref -> {$_});
			print ", " if($i != @keys);
			$i ++;
		}
		print "}";
		return get_retval(\@res);
	}
	else
	{
		print "{$type}";
	}
	return 1;
}
sub get_retval
{
	my $res = shift;
	foreach(@$res)
	{
		return -1 if($_ == -1);
	}
	foreach(@$res)
	{
		return 1 if($_ == 1);
	}
	return 0;
}
__END__

=head1 NAME

Devel::XDebug - eXtended Debug Dumper

=head1 VERSION

=head2 version

0.0.2.

=head2 stability

 This module usually works good and is stable
 (Not like the previous version! ;)).
 
 You may use it now not fearing.

=head1 SYNOPSIS

use Devel::XDebug;

debug($style, 'REF1' => $REF1, 'REF2' => $REF2);

=head1 DESCRIPTION

The eXtended Debug Dumper makes extended reports about variables
for debug usage. It also supports debug for CGI applications. 

=head2 Functions

=over

=item debug($style, %ddata)

Prints report for values of the hash-array '%ddata' also using
keys as labels using debug style $style(look 'Styles').

Returns: 1 if successed, 0 if nothing done(when all variables are
undefined) and -1 when reference error detected.

=back

=head2 Styles

Now only 'cgi' style is supported(when before dump standard HTTP
header for text/plain is printed).

All other values of '$style' are ignored.

=back

=head2 Errors

This module can catch reference errors. That means that requests
like this will be found:

 use Devel::XDebug;
 $val = "My value";
 $ref = \$val;
 $ref = \$ref; # Here is error!
 debug(0, '$ref' => $ref);

If self-reference level becomes greater than value of
$$Devel::XDebug::ERROR_BIGREF_LEVEL error message appends the
XDebug log. Dump will be continued from the next element.

You may change the value of $Devel::XDebug::ERROR_BIGREF_LEVEL.
By default it is \5. 

=back

=head1 EXAMPLE

=head2 PROGRAM

 use Devel::XDebug;
 %profiles = (
 	P1 => [qw(func1 func2)],
 	P2 => [qw(func3 func4)]
 );
 debug(0, '\%profiles' => \%profiles);

=back

=head2 RESULTS

 eXtended Debug Dump:

 \%profiles = {"P2" => ["func3", "func4"], "P1" => ["func1", "func2"]}



 eXtended Debug Dump OK.

=back

=head1 BUGS

Please write me about them.

=head1 AUTHOR

Edward Chernenko <specpc@yandex.ru>

Copyright ©Spectrum. All rights reserved.

This software is distributed under the terms of the Artistic License
<URL:http://ams.wiw.org/code/artistic.txt>.
