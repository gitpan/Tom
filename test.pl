
###################################### SIMPLE TESTS FOR TOM #################

END { 
	if ($t == $success && $t > 0) {
		print "All tests successful -- Tom Ok!\n"
	} else {
#		my $newt = $t - $success;
		print "Tests failed ($newt out of $t).\n";
	}
}

$t++;
print "load......";
eval "use Tom qw ( repair );";
if ($@) {
	print "failed\n";
	$success -= 1;
} else {
	print "ok\n";
	$success += 1;
}

$t++;
print "obj.......";
my $obj = new Tom Class => 'TestSuite';
if (ref($obj) eq 'Tom') {
	print "ok\n";
	$success++
} else {
	print "failed\n";
	$success--;
}

$t++;
print "declare...";
$obj->declare(Name => 'Useless', Code => '{ 1; }');

if (exists $obj->{Useless}) {
	print "ok\n";
	$success++;
} else { print "failed\n"; $success--; }

$t++;
print "store.....";
my $tmp = $obj->store();
if ($tmp) {
	print "ok\n";
	$success++;
} else {
	print "failed\n";
	$success--;
}

$t++;
print "repair....";
my $newobj = repair($tmp);
if (ref($newobj) eq 'Tom') {
	print "ok\n";
	$success++;
} else { print "failed\n"; $success--; }

$t++;
print "insert....";
$me = bless {}, "TestSuite";
if ($newobj->insert($me)) {
	print "ok\n";
	$success++;
} else { print "failed\n"; $success--; }
