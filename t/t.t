use Devel::XDebug;
$FORUMS = [
	{
		title => "��������� �� �������������",
		forums => [
			{
				title => "������� �����",
				description => "����� ����� ���������� �������� ������� �����"
			},
			{
				title => "����������",
				description => "������ ���������� � ��������� �� ������ ������"
			}
		],
		rights => "ADMIN_ONLY",
		moders => []
	},
	{
		title => "�������� �����",
		forums => [
			{
				title => "���������� �����",
				description => "����� ����� ��������� ��� ���� � ������� ����������� �� ��� �����������������"
			}
		],
		rights => "REGISTERED_ONLY",
		moders => ["�����"]
	},
	{
		title => "������",
		forums => [
			{
				title => "������",
				description => "�� �������� � ������ �������"
			},
			{
				title => "���",
				description => "����� ����� ��������� ����, �� ����������� � ������ �����."
			}
		],
		rights => "PUBLIC",
		moder => ["�����"]
	}
];
$retval = eval{debug(0, 0, '$FORUMS' => $FORUMS)};
if($retval eq 1)
{
	warn "Test successed!";
}
else
{
	warn "Test failure";
}
