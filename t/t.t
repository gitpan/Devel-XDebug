use Devel::XDebug;
$FORUMS = [
	{
		title => "Сообщения от администрации",
		forums => [
			{
				title => "Новости сайта",
				description => "Здесь будут освещаться основные новости сайта"
			},
			{
				title => "Объявления",
				description => "Важные объявления и сообщения от админа форума"
			}
		],
		rights => "ADMIN_ONLY",
		moders => []
	},
	{
		title => "Основной форум",
		forums => [
			{
				title => "Обсуждение сайта",
				description => "Здесь можно обсуждать наш сайт и вносить предложения по его совершенствованию"
			}
		],
		rights => "REGISTERED_ONLY",
		moders => ["Админ"]
	},
	{
		title => "Разное",
		forums => [
			{
				title => "Разное",
				description => "Не вошедшее в другие разделы"
			},
			{
				title => "Трёп",
				description => "Здесь можно обсуждать темы, не относящиеся к нашему сайту."
			}
		],
		rights => "PUBLIC",
		moder => ["Админ"]
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
