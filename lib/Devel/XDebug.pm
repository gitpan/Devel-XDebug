package Devel::XDebug;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(debug);
$VERSION = "0.0.1";
sub debug
{
	my($dtype, $after, %refs) = @_;
	print "Content-type: text/plain\n\n" if($dtype eq "cgi");
	print "eXtended Debug Dump:\n\n";
	foreach(keys %refs)
	{
		print "$_: ";
		dump_debug($refs{$_});
		print "\n";
	}
	print "\n\neXtended Debug Dump OK.\n";
	&$after() if($after);
	return 1;
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
		print $ref;
	}
	elsif($type eq 'REF')
	{
		print "{REF}";
		dump_debug($$ref);
	}
	elsif($type eq 'SCALAR')
	{
		print "{SCALAR}$$ref\n";
	}
	elsif($type eq 'ARRAY')
	{
		print "{ARRAY}(";
		foreach(@$ref)
		{
			dump_debug($_);
		}
		print ")";
	}
	elsif($type eq 'HASH')
	{
		print "{HASH}(";
		foreach(keys %$ref)
		{
			dump_debug($_);
			print " = (";
			dump_debug($ref -> {$_});
		}
		print "))";
	}
	elsif($type eq 'CODE')
	{
		print "{CODE}";
	}
	elsif($type eq 'GLOB')
	{
		print "{GLOB}";
	}
	print " ";
	return 1;
}

__END__

=head1 NAME

Devel::XDebug - eXtended Debug Dumper

=head1 VERSION

=head2 version

0.0.1.

=head2 stability

This module is absolute stable.
You may use it not fearing.

=head1 SYNOPSIS

use Devel::XDebug;

debug($style, \&do_after, 'REF1' => $REF1, 'REF2' => $REF2);

=head1 DESCRIPTION

The eXtended Debug Dumper makes extended reports about variables
for debug usage. It also supports debug for CGI applications. 

=head2 Functions

=over

=item debug($style, \&proc, %ddata)

Prints report for values of the hash-array '%ddata' also using
keys as labels. If style is 'cgi', script prints HTTP header for
text/plain data before dump. Other values of '$style' are ignored.
After dump this function executes '&proc' if this param isn't 0.

Returns: 1 if successed, undef if there are problems.

=back

=head1 EXAMPLE

use Devel::XDebug;

$first_letters = [

	{
		"A" => 1,
		"B" => 2,
		"C" => 3		
	},
	{
		"D" => 4,
		"E" => 5,
		"F" => 6
	}	
];

debug(0, die, '$first_letters' => $first_letters);

=head1 AUTHOR

Edward Chernenko <specpc@yandex.ru>

Copyright ©Spectrum. All rights reserved.

This software is distributed under the terms of the Artistic License
<URL:http://ams.wiw.org/code/artistic.txt>.
