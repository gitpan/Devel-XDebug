use Devel::XDebug;
%P = (
	P1 => [qw(func1 func2)],
	P2 => [qw(func3 func4)]
);
$retval = eval{debug(0, '\%P' => \%P)};
if($retval == 1)
{
	warn "Test successed!";
}
elsif($retval == 0)
{
	warn "Error! Finished OK but nothing dumped.";
}
else
{
	warn "Test failure!";
}
