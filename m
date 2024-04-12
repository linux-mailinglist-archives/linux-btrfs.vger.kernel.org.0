Return-Path: <linux-btrfs+bounces-4178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348598A2541
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 06:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB26A285427
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 04:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB018C1A;
	Fri, 12 Apr 2024 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WpuRvlL0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WpuRvlL0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC9BA33;
	Fri, 12 Apr 2024 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896907; cv=none; b=MIM21z2cctRU13K8/o6OAPbX09dXbTEyI4mS7CFP3qOr5mAXMDmSwIaaLtx+Fr0t9GSV+U9wleTnAad9Af4srNTaBcWYcyHZag6C+qYcySEi9T2LZYh7qDdnwlHoPRgP43T+h4rCJQo69j/G4scI/Pnl7dP4Szw5+iCjLoCsegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896907; c=relaxed/simple;
	bh=5iRTzFOSZ+AFqAooFSJWCTMaRCCKtCV74gNI0vwczoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILTCs16UO9O0Ig5RMvRWkw9f3+revGPulaagaCOnHQb++tt1YBCGYnVnayOcNroYBLt8FvzxTnLh9gZZRNENa+DO7cPW5H0f34Vp/yalEKdxOIRl1hlDC4RktKCFBccRTlhOiztVYkj7dwCSW1iExWGSfycVPsussSUDKGhLsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WpuRvlL0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WpuRvlL0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 612045F7BE;
	Fri, 12 Apr 2024 04:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712896899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V304Q0r5crDfXkZjwj6Ox48Z9Ida2+9WzVkMTq74c50=;
	b=WpuRvlL0SD/WFGZg/iRd/INSlcXRzgNCUzcW3cBE28aH1P9nKjAVpin9H8rpv7f6KxeP3A
	52v8Qvhg9foJVh9ULAmolyABjoc8NnATWtDHsKwy9VFSDyuHvpgUjqAu3Pq2gOmw04pnlk
	XI0DWlEYZ6G2lJO3lfqZAQpVAx6DIYM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WpuRvlL0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712896899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V304Q0r5crDfXkZjwj6Ox48Z9Ida2+9WzVkMTq74c50=;
	b=WpuRvlL0SD/WFGZg/iRd/INSlcXRzgNCUzcW3cBE28aH1P9nKjAVpin9H8rpv7f6KxeP3A
	52v8Qvhg9foJVh9ULAmolyABjoc8NnATWtDHsKwy9VFSDyuHvpgUjqAu3Pq2gOmw04pnlk
	XI0DWlEYZ6G2lJO3lfqZAQpVAx6DIYM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94E111368B;
	Fri, 12 Apr 2024 04:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OEzhEoG7GGYcOgAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 12 Apr 2024 04:41:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2 1/2] fstests: btrfs: rename _run_btrfs_util_prog to _btrfs
Date: Fri, 12 Apr 2024 14:11:16 +0930
Message-ID: <fc228d4f0056a421f22de1638fd69d59827dc641.1712896667.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712896667.git.wqu@suse.com>
References: <cover.1712896667.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 612045F7BE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

For simple btrfs commands like "btrfs subvolume create", the output is
only informative, meanwhile the output format may still change in the
future.

Normally we already have quite some test cases just redirect the output
for null or seqres.full, without knowing we have a better suitable
function `_run_btrfs_util_prog()` already.

This patch firstly rename the function to a much shorter name `_btrfs`,
then move it to the top of `common/btrfs`, and add a comment
recommending to use it when possible.

The use of `_btrfs` mostly matches the real world usage of btrfs-progs
(just "btrfs" command), and no need to do any filtering or redirection,
and would be the recommended way for future test cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs    | 15 ++++++++-------
 tests/btrfs/004 |  2 +-
 tests/btrfs/007 |  6 +++---
 tests/btrfs/011 | 10 +++++-----
 tests/btrfs/017 |  6 +++---
 tests/btrfs/022 |  6 +++---
 tests/btrfs/025 | 20 ++++++++++----------
 tests/btrfs/028 |  4 ++--
 tests/btrfs/030 | 12 ++++++------
 tests/btrfs/034 | 12 ++++++------
 tests/btrfs/038 | 20 ++++++++++----------
 tests/btrfs/039 | 12 ++++++------
 tests/btrfs/040 | 12 ++++++------
 tests/btrfs/041 |  2 +-
 tests/btrfs/042 | 10 +++++-----
 tests/btrfs/043 | 12 ++++++------
 tests/btrfs/044 | 12 ++++++------
 tests/btrfs/045 | 12 ++++++------
 tests/btrfs/046 | 14 +++++++-------
 tests/btrfs/048 | 16 ++++++++--------
 tests/btrfs/050 |  6 +++---
 tests/btrfs/051 |  6 +++---
 tests/btrfs/052 |  2 +-
 tests/btrfs/053 | 12 ++++++------
 tests/btrfs/054 | 18 +++++++++---------
 tests/btrfs/057 |  6 +++---
 tests/btrfs/058 |  4 ++--
 tests/btrfs/077 | 12 ++++++------
 tests/btrfs/080 |  2 +-
 tests/btrfs/083 | 12 ++++++------
 tests/btrfs/084 | 12 ++++++------
 tests/btrfs/085 |  4 ++--
 tests/btrfs/087 | 12 ++++++------
 tests/btrfs/090 |  2 +-
 tests/btrfs/091 |  8 ++++----
 tests/btrfs/092 | 12 ++++++------
 tests/btrfs/094 | 12 ++++++------
 tests/btrfs/097 | 12 ++++++------
 tests/btrfs/099 |  4 ++--
 tests/btrfs/100 |  6 +++---
 tests/btrfs/101 |  6 +++---
 tests/btrfs/104 | 10 +++++-----
 tests/btrfs/105 | 14 +++++++-------
 tests/btrfs/108 |  6 +++---
 tests/btrfs/109 |  6 +++---
 tests/btrfs/110 | 16 ++++++++--------
 tests/btrfs/111 | 20 ++++++++++----------
 tests/btrfs/117 | 18 +++++++++---------
 tests/btrfs/118 |  8 ++++----
 tests/btrfs/119 |  6 +++---
 tests/btrfs/120 |  4 ++--
 tests/btrfs/121 |  2 +-
 tests/btrfs/122 | 10 +++++-----
 tests/btrfs/123 |  2 +-
 tests/btrfs/124 | 10 +++++-----
 tests/btrfs/125 | 18 +++++++++---------
 tests/btrfs/126 |  4 ++--
 tests/btrfs/127 | 12 ++++++------
 tests/btrfs/128 | 12 ++++++------
 tests/btrfs/129 | 12 ++++++------
 tests/btrfs/130 |  2 +-
 tests/btrfs/139 |  6 +++---
 tests/btrfs/153 |  4 ++--
 tests/btrfs/161 |  4 ++--
 tests/btrfs/162 |  6 +++---
 tests/btrfs/163 | 12 ++++++------
 tests/btrfs/164 | 12 ++++++------
 tests/btrfs/166 |  2 +-
 tests/btrfs/167 |  2 +-
 tests/btrfs/218 |  2 +-
 tests/btrfs/272 | 14 +++++++-------
 tests/btrfs/273 |  6 +++---
 tests/btrfs/278 | 14 +++++++-------
 tests/btrfs/320 | 16 ++++++++--------
 74 files changed, 339 insertions(+), 338 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 99bd5ace674f..3bb17e771de6 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -4,6 +4,12 @@
 
 . common/module
 
+# The recommended way to execute simple "btrfs" command.
+_btrfs()
+{
+	run_check $BTRFS_UTIL_PROG $*
+}
+
 _btrfs_get_subvolid()
 {
 	local mnt=$1
@@ -70,11 +76,6 @@ _require_btrfs_dump_super()
 	fi
 }
 
-_run_btrfs_util_prog()
-{
-	run_check $BTRFS_UTIL_PROG $*
-}
-
 _require_btrfs_mkfs_feature()
 {
 	if [ -z $1 ]; then
@@ -766,14 +767,14 @@ _qgroup_rescan()
 	local dev=$(findmnt -n -o SOURCE $mnt)
 
 	_check_regular_qgroup $dev || return 1
-	_run_btrfs_util_prog quota rescan -w $mnt
+	_btrfs quota rescan -w $mnt
 }
 
 _require_qgroup_rescan()
 {
 	_scratch_mkfs >>$seqres.full 2>&1
 	_scratch_mount
-	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	_btrfs quota enable $SCRATCH_MNT
 	# Wait for the first rescan.
 	$BTRFS_UTIL_PROG quota rescan -W $SCRATCH_MNT || \
 				_notrun "not able to wait on a quota rescan"
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 381ad072fdcf..d886d1f08d3d 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -166,7 +166,7 @@ workout()
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p $procs -n 2000 \
 		$FSSTRESS_AVOID
 
-	_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT \
+	_btrfs subvolume snapshot $SCRATCH_MNT \
 		$SCRATCH_MNT/$snap_name
 
 	run_check _scratch_unmount >/dev/null 2>&1
diff --git a/tests/btrfs/007 b/tests/btrfs/007
index ed7d143a0d70..dae7d6e5323e 100755
--- a/tests/btrfs/007
+++ b/tests/btrfs/007
@@ -52,7 +52,7 @@ workout()
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -n $ops $FSSTRESS_AVOID -x \
 		"$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base"
 
-	_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
+	_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
 
 	echo "# $BTRFS_UTIL_PROG send $SCRATCH_MNT/base > ${send_files_dir}/base.snap" \
 		>> $seqres.full
@@ -76,10 +76,10 @@ workout()
 		|| _fail "size=$fsz mkfs failed"
 	_scratch_mount "-o noatime"
 
-	_run_btrfs_util_prog receive $SCRATCH_MNT < $send_files_dir/base.snap
+	_btrfs receive $SCRATCH_MNT < $send_files_dir/base.snap
 	run_check $FSSUM_PROG -r $send_files_dir/base.fssum $SCRATCH_MNT/base
 
-	_run_btrfs_util_prog receive $SCRATCH_MNT < $send_files_dir/incr.snap
+	_btrfs receive $SCRATCH_MNT < $send_files_dir/incr.snap
 	run_check $FSSUM_PROG -r $send_files_dir/incr.fssum $SCRATCH_MNT/incr
 }
 
diff --git a/tests/btrfs/011 b/tests/btrfs/011
index d8b5a9782750..fd53429c9745 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -131,12 +131,12 @@ workout()
 	_require_fs_space $SCRATCH_MNT $((2 * 512 * 1024)) #2.5G
 
 	fill_scratch $fssize $with_cancel
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 
 	echo -e "Replace from $source_dev to $SPARE_DEV\\n" >> $seqres.full
 	btrfs_replace_test $source_dev $SPARE_DEV "" $with_cancel $quick
 
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 
 	# Skip -r test for configs without mirror OR replace cancel
 	if echo $mkfs_options | grep -E -qv "raid1|raid5|raid6|raid10" || \
@@ -175,7 +175,7 @@ btrfs_replace_test()
 
 	if [ "${with_cancel}Q" = "cancelQ" ]; then
 		# background the replace operation (no '-B' option given)
-		_run_btrfs_util_prog replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
+		_btrfs replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
 		sleep $wait_time
 		$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT 2>&1 >> $seqres.full
 
@@ -203,7 +203,7 @@ btrfs_replace_test()
 			# replace operation.
 			(sleep $wait_time; sync) > /dev/null 2>&1 &
 		fi
-		_run_btrfs_util_prog replace start -Bf $replace_options $source_dev $target_dev $SCRATCH_MNT
+		_btrfs replace start -Bf $replace_options $source_dev $target_dev $SCRATCH_MNT
 
 		$BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
 		cat $tmp.tmp >> $seqres.full
@@ -221,7 +221,7 @@ btrfs_replace_test()
 	# exit values != 0, including detected correctable and uncorrectable
 	# errors on the device.
 	sync; sync
-	_run_btrfs_util_prog scrub start -B $SCRATCH_MNT
+	_btrfs scrub start -B $SCRATCH_MNT
 
 	# Two tests are performed, the 1st is to btrfsck the filesystem,
 	# and the 2nd test is to mount the filesystem.
diff --git a/tests/btrfs/017 b/tests/btrfs/017
index 496cc7df1b19..60358f6261ac 100755
--- a/tests/btrfs/017
+++ b/tests/btrfs/017
@@ -38,7 +38,7 @@ EXTENT_SIZE=$((2 * $BLOCK_SIZE))
 $XFS_IO_PROG -f -d -c "pwrite 0 $EXTENT_SIZE" $SCRATCH_MNT/foo \
 	| _filter_xfs_io_blocks_modified
 
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
 
 $CLONER_PROG -s 0 -d 0 -l $EXTENT_SIZE $SCRATCH_MNT/foo $SCRATCH_MNT/foo-reflink
 
@@ -48,8 +48,8 @@ $CLONER_PROG -s 0 -d 0 -l $EXTENT_SIZE $SCRATCH_MNT/foo \
 $CLONER_PROG -s 0 -d 0 -l $EXTENT_SIZE $SCRATCH_MNT/foo \
 	     $SCRATCH_MNT/snap/foo-reflink2
 
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
+_btrfs quota rescan -w $SCRATCH_MNT
 
 rm -fr $SCRATCH_MNT/foo*
 rm -fr $SCRATCH_MNT/snap/foo*
diff --git a/tests/btrfs/022 b/tests/btrfs/022
index 32ad80bf9c64..e7f4e9bbc68b 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -24,10 +24,10 @@ _require_no_compress
 _limit_test_exceed()
 {
 	echo "=== limit exceed test ===" >> $seqres.full
-	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
-	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	_btrfs subvolume create $SCRATCH_MNT/a
+	_btrfs quota enable $SCRATCH_MNT
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
-	_run_btrfs_util_prog qgroup limit 5M 0/$subvolid $SCRATCH_MNT
+	_btrfs qgroup limit 5M 0/$subvolid $SCRATCH_MNT
 	_ddt of=$SCRATCH_MNT/a/file bs=10M count=1 >> $seqres.full 2>&1
 	[ $? -ne 0 ] || _fail "quota should have limited us"
 }
diff --git a/tests/btrfs/025 b/tests/btrfs/025
index 26f95c7d9a1e..1f20cfc0ee32 100755
--- a/tests/btrfs/025
+++ b/tests/btrfs/025
@@ -33,25 +33,25 @@ _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 run_check $XFS_IO_PROG -f -c "truncate 819200" $SCRATCH_MNT/foo
-_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
+_btrfs filesystem sync $SCRATCH_MNT
 
 run_check $XFS_IO_PROG -c "falloc -k 819200 667648" $SCRATCH_MNT/foo
-_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
+_btrfs filesystem sync $SCRATCH_MNT
 
 run_check $XFS_IO_PROG -c "pwrite 1482752 2978" $SCRATCH_MNT/foo
-_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
+_btrfs filesystem sync $SCRATCH_MNT
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT \
+_btrfs subvolume snapshot -r $SCRATCH_MNT \
     $SCRATCH_MNT/mysnap1
 
 run_check $XFS_IO_PROG -c "truncate 883305" $SCRATCH_MNT/foo
-_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
+_btrfs filesystem sync $SCRATCH_MNT
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT \
+_btrfs subvolume snapshot -r $SCRATCH_MNT \
     $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+_btrfs send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
     $SCRATCH_MNT/mysnap2 2>&1
 
 md5sum $SCRATCH_MNT/foo | _filter_scratch
@@ -63,10 +63,10 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/1.snap $SCRATCH_MNT
 md5sum $SCRATCH_MNT/mysnap1/foo | _filter_scratch
 
-_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/2.snap $SCRATCH_MNT
 md5sum $SCRATCH_MNT/mysnap2/foo | _filter_scratch
 
 _scratch_unmount
diff --git a/tests/btrfs/028 b/tests/btrfs/028
index d860974ec207..b0b633d3b695 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -24,7 +24,7 @@ _require_btrfs_qgroup_report
 _scratch_mkfs >/dev/null
 _scratch_mount
 
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
 _qgroup_rescan $SCRATCH_MNT
 
 # Increase the probability of generating de-refer extent, and decrease
@@ -51,7 +51,7 @@ wait
 # to cancel running or paused balance.
 $BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
 
-_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
+_btrfs filesystem sync $SCRATCH_MNT
 
 _scratch_unmount
 
diff --git a/tests/btrfs/030 b/tests/btrfs/030
index bce5ba1e73db..7d1fe5226d43 100755
--- a/tests/btrfs/030
+++ b/tests/btrfs/030
@@ -83,7 +83,7 @@ echo "ola" > $SCRATCH_MNT/a/b/bar1/bar2/bar3/bar4/hello.txt
 #                      |-- bar4          (ino 275)
 #                           |--hello.txt (ino 276)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 echo " world" >> $SCRATCH_MNT/a/b/c/file.txt
 mv $SCRATCH_MNT/a/b/c/d $SCRATCH_MNT/a/b/c2/d2
@@ -137,14 +137,14 @@ mv $SCRATCH_MNT/a/b/bar1 $SCRATCH_MNT/a/b/k44/bar3/bar2/k11
 #                   |-- bar2/               (ino 273)
 #                        |-- k11/           (ino 272)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
     $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -f $tmp/2.snap -p $SCRATCH_MNT/mysnap1 \
+_btrfs send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -f $tmp/2.snap -p $SCRATCH_MNT/mysnap1 \
     $SCRATCH_MNT/mysnap2
 
 _scratch_unmount
@@ -152,10 +152,10 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
 
-_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
 
 _scratch_unmount
diff --git a/tests/btrfs/034 b/tests/btrfs/034
index abda75db76a9..e0f767e6675e 100755
--- a/tests/btrfs/034
+++ b/tests/btrfs/034
@@ -45,14 +45,14 @@ do
 		$SCRATCH_MNT/foo | _filter_xfs_io
 done
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 $XFS_IO_PROG -c "truncate 3882008" $SCRATCH_MNT/foo
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -f $tmp/2.snap -p $SCRATCH_MNT/mysnap1 \
+_btrfs send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -f $tmp/2.snap -p $SCRATCH_MNT/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
 md5sum $SCRATCH_MNT/foo | _filter_scratch
@@ -64,10 +64,10 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/1.snap $SCRATCH_MNT
 md5sum $SCRATCH_MNT/mysnap1/foo | _filter_scratch
 
-_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/2.snap $SCRATCH_MNT
 md5sum $SCRATCH_MNT/mysnap2/foo | _filter_scratch
 
 _scratch_unmount
diff --git a/tests/btrfs/038 b/tests/btrfs/038
index 13e507013743..a391c972e6e8 100755
--- a/tests/btrfs/038
+++ b/tests/btrfs/038
@@ -39,7 +39,7 @@ $XFS_IO_PROG -f -c "truncate 118811" $SCRATCH_MNT/foo
 $XFS_IO_PROG -c "pwrite -S 0x0d -b 39987 92267 39987" \
 	$SCRATCH_MNT/foo | _filter_xfs_io
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT \
+_btrfs subvolume snapshot -r $SCRATCH_MNT \
 	$SCRATCH_MNT/mysnap1
 
 $XFS_IO_PROG -c "pwrite -S 0x3e -b 80000 200000 80000" \
@@ -47,7 +47,7 @@ $XFS_IO_PROG -c "pwrite -S 0x3e -b 80000 200000 80000" \
 
 # Sync to avoid btrfs merging file extent items, which would make the test
 # succeed when it should fail.
-_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
+_btrfs filesystem sync $SCRATCH_MNT
 
 $XFS_IO_PROG -c "pwrite -S 0xdc -b 10000 250000 10000" \
 	$SCRATCH_MNT/foo | _filter_xfs_io
@@ -55,10 +55,10 @@ $XFS_IO_PROG -c "pwrite -S 0xff -b 10000 300000 10000" \
 	$SCRATCH_MNT/foo | _filter_xfs_io
 
 # will be used for incremental send to be able to issue clone operations
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT \
+_btrfs subvolume snapshot -r $SCRATCH_MNT \
 	$SCRATCH_MNT/clones_snap
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT \
+_btrfs subvolume snapshot -r $SCRATCH_MNT \
 	$SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
@@ -67,9 +67,9 @@ run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 run_check $FSSUM_PROG -A -f -w $tmp/clones.fssum $SCRATCH_MNT/clones_snap \
 	-x $SCRATCH_MNT/clones_snap/mysnap1 -x $SCRATCH_MNT/clones_snap/mysnap2
 
-_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -f $tmp/clones.snap $SCRATCH_MNT/clones_snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 \
+_btrfs send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -f $tmp/clones.snap $SCRATCH_MNT/clones_snap
+_btrfs send -p $SCRATCH_MNT/mysnap1 \
 	-c $SCRATCH_MNT/clones_snap -f $tmp/2.snap $SCRATCH_MNT/mysnap2
 
 _scratch_unmount
@@ -78,13 +78,13 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
 
-_run_btrfs_util_prog receive -f $tmp/clones.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/clones.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/clones.fssum $SCRATCH_MNT/clones_snap 2>> $seqres.full
 
-_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
 
 _scratch_unmount
diff --git a/tests/btrfs/039 b/tests/btrfs/039
index c2d7c20cbc0d..96367d754c0e 100755
--- a/tests/btrfs/039
+++ b/tests/btrfs/039
@@ -58,7 +58,7 @@ mv $SCRATCH_MNT/e $SCRATCH_MNT/a/b/f/g
 #             |-- g      (ino 263)
 #                 |-- e  (ino 261)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 mv $SCRATCH_MNT/a/b/c $SCRATCH_MNT/a/b/x
 mv $SCRATCH_MNT/a/b/x/d $SCRATCH_MNT/a/b/x/y
@@ -77,14 +77,14 @@ mv $SCRATCH_MNT/a/b/w/g/e $SCRATCH_MNT/a/b/w/g/z
 #             |-- g      (ino 263)
 #                 |-- z  (ino 261)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+_btrfs send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 _scratch_unmount
@@ -93,10 +93,10 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
 
-_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
 
 _scratch_unmount
diff --git a/tests/btrfs/040 b/tests/btrfs/040
index 35bd12cd0030..8cd2ddf73fdd 100755
--- a/tests/btrfs/040
+++ b/tests/btrfs/040
@@ -56,7 +56,7 @@ ln $SCRATCH_MNT/a/b/c/foo.txt $SCRATCH_MNT/a/b/baz.txt
 #         |
 #         |-- baz.txt      (ino 261)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 rm -f $SCRATCH_MNT/a/b/c/foo.txt
 rm -f $SCRATCH_MNT/a/b/c/bar.txt
@@ -70,14 +70,14 @@ rmdir $SCRATCH_MNT/a/b/c
 #     |-- b/               (ino 258)
 #         |-- baz.txt      (ino 261)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+_btrfs send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 _scratch_unmount
@@ -86,10 +86,10 @@ _check_btrfs_filesystem $SCRATCH_DEV
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
 
-_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
 
 _scratch_unmount
diff --git a/tests/btrfs/041 b/tests/btrfs/041
index 5b4577641d47..ff6b03b7bcc2 100755
--- a/tests/btrfs/041
+++ b/tests/btrfs/041
@@ -75,7 +75,7 @@ test_btrfs_restore()
 	# read compressed file extents that have a non-zero data offset field,
 	# resulting either in decompression failure or reading a wrong section
 	# of the extent.
-	_run_btrfs_util_prog restore $SCRATCH_DEV $restore_dir
+	_btrfs restore $SCRATCH_DEV $restore_dir
 	md5sum $restore_dir/foo | cut -d ' ' -f 1
 }
 
diff --git a/tests/btrfs/042 b/tests/btrfs/042
index 230f8fc05dcb..9a965caeaa74 100755
--- a/tests/btrfs/042
+++ b/tests/btrfs/042
@@ -21,13 +21,13 @@ _scratch_mount
 
 LIMIT_SIZE=$((10 * 1024 * 1024))
 
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog qgroup create 1/1 $SCRATCH_MNT
-_run_btrfs_util_prog qgroup limit $LIMIT_SIZE 1/1 $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
+_btrfs qgroup create 1/1 $SCRATCH_MNT
+_btrfs qgroup limit $LIMIT_SIZE 1/1 $SCRATCH_MNT
 
 for i in `seq 10 -1 1`; do
 	#add newly created subvolume qgroup to it's parent qgroup
-	_run_btrfs_util_prog subvolume create -i 1/1 \
+	_btrfs subvolume create -i 1/1 \
 		$SCRATCH_MNT/subv_$i
 done
 
@@ -38,7 +38,7 @@ for i in `seq 10 -1 1`; do
 done
 
 wait
-_run_btrfs_util_prog filesystem sync $SCRATCH_MNT \
+_btrfs filesystem sync $SCRATCH_MNT \
 	>>$seqres.full 2>&1
 
 total_written=0
diff --git a/tests/btrfs/043 b/tests/btrfs/043
index 14b7cb71d0d7..07c9534d4d85 100755
--- a/tests/btrfs/043
+++ b/tests/btrfs/043
@@ -68,7 +68,7 @@ mkdir $SCRATCH_MNT/a/b/d4
 #         |
 #         |-- d4/          (ino 270)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 rm -f $SCRATCH_MNT/a/b/c/foo.txt
 mv $SCRATCH_MNT/a/b/y $SCRATCH_MNT/a/b/YY
@@ -99,14 +99,14 @@ rmdir $SCRATCH_MNT/a/b/d1
 #          |-- d2/         (ino 268)
 #              |-- d3/     (ino 269)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+_btrfs send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 _check_scratch_fs
@@ -115,10 +115,10 @@ _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/044 b/tests/btrfs/044
index 0864d0401b0e..e5c2957f7f57 100755
--- a/tests/btrfs/044
+++ b/tests/btrfs/044
@@ -57,7 +57,7 @@ chmod 0777 $SCRATCH_MNT/a/b/c/d/e
 #             |
 #             |-- f/                  (ino 263)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 echo 'mundo' >> $SCRATCH_MNT/a/b/c/d/e/file.txt
 mv $SCRATCH_MNT/a/b/c/d/e/file.txt $SCRATCH_MNT/a/b/c/d/e/file2.txt
@@ -79,14 +79,14 @@ chmod 0700 $SCRATCH_MNT/a/b/f2/e2
 #             |-- e2             (ino 261)
 #                 |-- file2.txt  (ino 263)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+_btrfs send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 _check_scratch_fs
@@ -95,10 +95,10 @@ _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/045 b/tests/btrfs/045
index 9b23730b1e96..438b8e55edc3 100755
--- a/tests/btrfs/045
+++ b/tests/btrfs/045
@@ -186,7 +186,7 @@ mkdir $SCRATCH_MNT/%a/%c/%e
 #     |-- %c/                     (ino 305)
 #         |-- %e/                 (ino 307)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # case 1), mentioned above
 ln $SCRATCH_MNT/a/c/b2/file4 $SCRATCH_MNT/a/c/b2/f/file6
@@ -325,15 +325,15 @@ mv $SCRATCH_MNT/%a/foo $SCRATCH_MNT/%a/%b/%g/%e2/%f2
 #                       |-- %c2/       (ino 305)
 #                            |-- foo   (ino 316)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $tmp/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $tmp/2.fssum -x $SCRATCH_MNT/mysnap2/mysnap1 \
 	$SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -f $tmp/1.snap $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $tmp/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 _check_scratch_fs
@@ -342,10 +342,10 @@ _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/046 b/tests/btrfs/046
index 8b65fb1f1ecb..ffac4f14b142 100755
--- a/tests/btrfs/046
+++ b/tests/btrfs/046
@@ -45,7 +45,7 @@ _scratch_mount
 
 $XFS_IO_PROG -f -c "falloc -k 0 268435456" $SCRATCH_MNT/foo
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap0
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap0
 
 $XFS_IO_PROG -c "pwrite -S 0x01 -b 9216 16190218 9216" $SCRATCH_MNT/foo \
 	| _filter_xfs_io
@@ -250,12 +250,12 @@ $XFS_IO_PROG -c "pwrite -S 0xa9 -b 9216 18423680 9216" $SCRATCH_MNT/foo \
 $XFS_IO_PROG -c "pwrite -S 0xb0 -b 1121 165901483 1121" $SCRATCH_MNT/foo \
 	| _filter_xfs_io
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 $XFS_IO_PROG -c "pwrite -S 0xff -b 10 16190218 10" $SCRATCH_MNT/foo \
 	| _filter_xfs_io
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 echo "File digests in the original filesystem:"
 md5sum $SCRATCH_MNT/foo | _filter_scratch
@@ -263,8 +263,8 @@ md5sum $SCRATCH_MNT/mysnap0/foo | _filter_scratch
 md5sum $SCRATCH_MNT/mysnap1/foo | _filter_scratch
 md5sum $SCRATCH_MNT/mysnap2/foo | _filter_scratch
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 _check_scratch_fs
@@ -272,8 +272,8 @@ _scratch_unmount
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File digests in the replica filesystem:"
 md5sum $SCRATCH_MNT/mysnap1/foo | _filter_scratch
diff --git a/tests/btrfs/048 b/tests/btrfs/048
index aa2030b12df6..3116c1b822c4 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -57,7 +57,7 @@ $BTRFS_UTIL_PROG property get $SCRATCH_MNT/testdir label 2>&1 |
 echo "***"
 
 echo -e "\nTesting subvolume ro property"
-_run_btrfs_util_prog subvolume create $SCRATCH_MNT/sv1
+_btrfs subvolume create $SCRATCH_MNT/sv1
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1 ro
 echo "***"
 $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro foo 2>&1 |
@@ -149,12 +149,12 @@ $BTRFS_UTIL_PROG property get $SCRATCH_MNT/testdir/subdir1 compression
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/testdir/subdir1/foobar compression
 echo "***"
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 touch $SCRATCH_MNT/testdir/subdir1/foobar2
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 _scratch_unmount
@@ -162,8 +162,8 @@ _check_scratch_fs
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/mysnap2/testdir/subdir1 compression
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/mysnap2/testdir/subdir1/foobar \
 	compression
@@ -194,7 +194,7 @@ touch $SCRATCH_MNT/dir1/subdir1/foo
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/dir1/subdir1/foo compression
 
 echo -e "\nTesting subvolume property inheritance"
-_run_btrfs_util_prog subvolume create $SCRATCH_MNT/sv1
+_btrfs subvolume create $SCRATCH_MNT/sv1
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1 compression
 touch $SCRATCH_MNT/sv1/file2
 $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1/file2 compression
diff --git a/tests/btrfs/050 b/tests/btrfs/050
index ef1b3139112b..5efc2cd97e8c 100755
--- a/tests/btrfs/050
+++ b/tests/btrfs/050
@@ -68,9 +68,9 @@ for i in `seq 1 $NUM_LINKS`; do
 	rm -f $TEST_PATH/foobar_link_`printf "%04d" $i`
 done
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
 
 _scratch_unmount
 _check_scratch_fs
@@ -78,7 +78,7 @@ _check_scratch_fs
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
 status=0
diff --git a/tests/btrfs/051 b/tests/btrfs/051
index f0ac86aa2ce9..57b5534c592d 100755
--- a/tests/btrfs/051
+++ b/tests/btrfs/051
@@ -44,9 +44,9 @@ TEST_PATH="$SCRATCH_MNT/fdmanana/.config/google-chrome-mysetup/Default/Pepper_Da
 mkdir -p $TEST_PATH
 echo "hello world" > $TEST_PATH/amaiAdvancedStreamingPlugin.txt
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
 
 _scratch_unmount
 _check_scratch_fs
@@ -54,7 +54,7 @@ _check_scratch_fs
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
 status=0
diff --git a/tests/btrfs/052 b/tests/btrfs/052
index 0d60d413250a..15b33f699ec8 100755
--- a/tests/btrfs/052
+++ b/tests/btrfs/052
@@ -124,7 +124,7 @@ test_btrfs_clone_same_file()
 
 	# Check that after defragmenting the file and re-mounting, the file
 	# content remains exactly the same as before.
-	_run_btrfs_util_prog filesystem defragment $SCRATCH_MNT/foo
+	_btrfs filesystem defragment $SCRATCH_MNT/foo
 	_scratch_cycle_mount
 	od -t x1 $SCRATCH_MNT/foo | _filter_od
 
diff --git a/tests/btrfs/053 b/tests/btrfs/053
index 67239f10d3ab..4d1886189af8 100755
--- a/tests/btrfs/053
+++ b/tests/btrfs/053
@@ -52,7 +52,7 @@ echo "hello world" > $SCRATCH_MNT/foobar
 $SETFATTR_PROG -n user.xattr_name_1 -v `$PERL_PROG -e 'print "A" x 6000;'` \
 	$SCRATCH_MNT/foobar
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
 # Update existing xattr value and add a new xattr too.
@@ -61,12 +61,12 @@ $SETFATTR_PROG -n user.xattr_name_1 -v `$PERL_PROG -e 'print "Z" x 6666;'` \
 $SETFATTR_PROG -n user.xattr_name_2 -v `$PERL_PROG -e 'print "U" x 5555;'` \
 	$SCRATCH_MNT/foobar
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 _scratch_unmount
@@ -75,10 +75,10 @@ _check_scratch_fs
 _scratch_mkfs "--nodesize $leaf_size" >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 status=0
diff --git a/tests/btrfs/054 b/tests/btrfs/054
index f1b5b2c3f14f..2d729957b480 100755
--- a/tests/btrfs/054
+++ b/tests/btrfs/054
@@ -49,22 +49,22 @@ _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 mkdir $SCRATCH_MNT/testdir
-_run_btrfs_util_prog subvolume create $SCRATCH_MNT/first_subvol
+_btrfs subvolume create $SCRATCH_MNT/first_subvol
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # Replace the directory testdir with a subvolume that has the same name.
 rmdir $SCRATCH_MNT/testdir
-_run_btrfs_util_prog subvolume create $SCRATCH_MNT/testdir
+_btrfs subvolume create $SCRATCH_MNT/testdir
 
 # Delete the subvolume first_subvol and create a directory with the same name.
-_run_btrfs_util_prog subvolume delete $SCRATCH_MNT/first_subvol
+_btrfs subvolume delete $SCRATCH_MNT/first_subvol
 mkdir $SCRATCH_MNT/first_subvol
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 _scratch_unmount
@@ -73,11 +73,11 @@ _check_scratch_fs
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 [ -e $SCRATCH_MNT/first_subvol ] && \
 	echo "Subvolume first_subvol was not supposed to be replicated by full send!"
 
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 [ -e $SCRATCH_MNT/testdir ] && \
 	echo "Directory testdir was supposed to be deleted after incremental send!"
 
diff --git a/tests/btrfs/057 b/tests/btrfs/057
index e932a6572177..1956697326f1 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -25,14 +25,14 @@ _scratch_mount
 run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p 5 -n 1000 \
 		$FSSTRESS_AVOID >&/dev/null
 
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT \
+_btrfs subvolume snapshot $SCRATCH_MNT \
 	$SCRATCH_MNT/snap1
 
 run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p 5 -n 1000 \
        $FSSTRESS_AVOID >&/dev/null
 
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
+_btrfs quota rescan -w $SCRATCH_MNT
 
 echo "Silence is golden"
 # btrfs check will detect any qgroup number mismatch.
diff --git a/tests/btrfs/058 b/tests/btrfs/058
index 493f2c54efac..999501a15df8 100755
--- a/tests/btrfs/058
+++ b/tests/btrfs/058
@@ -50,8 +50,8 @@ sleep 3
 # With the tmpfile open, create a RO snapshot and use it for a send operation.
 # The send operation used to fail with -ESTALE due to the presence of the
 # orphan inode.
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap
-_run_btrfs_util_prog send -f /dev/null $SCRATCH_MNT/mysnap
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap
+_btrfs send -f /dev/null $SCRATCH_MNT/mysnap
 
 status=0
 exit
diff --git a/tests/btrfs/077 b/tests/btrfs/077
index 4cfd6ed75c79..bdb5d38ec68b 100755
--- a/tests/btrfs/077
+++ b/tests/btrfs/077
@@ -67,7 +67,7 @@ mkdir -p $SCRATCH_MNT/Z/Z2
 # |---- Z/                                          (ino 265)
 #       |---- Z2/                                   (ino 266)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 mkdir $SCRATCH_MNT/OSD
 mv $SCRATCH_MNT/merlin/RC/OSD $SCRATCH_MNT/OSD/OSD-Plane_788
@@ -98,14 +98,14 @@ mv $SCRATCH_MNT/OSDz $SCRATCH_MNT/fdm/RCz
 #                                                    |---- Sourcez/  (ino 264)
 #
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 _check_scratch_fs
@@ -114,10 +114,10 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/080 b/tests/btrfs/080
index ac9d9b6422d1..f8d091bd61bb 100755
--- a/tests/btrfs/080
+++ b/tests/btrfs/080
@@ -39,7 +39,7 @@ create_snapshot()
 {
 	local ts=`date +'%H_%M_%S_%N'`
 
-	_run_btrfs_util_prog subvolume snapshot -r \
+	_btrfs subvolume snapshot -r \
 		$SCRATCH_MNT $SCRATCH_MNT/"${ts}_snap"
 }
 
diff --git a/tests/btrfs/083 b/tests/btrfs/083
index e09769dd484d..440258d0fec0 100755
--- a/tests/btrfs/083
+++ b/tests/btrfs/083
@@ -63,7 +63,7 @@ mkdir $SCRATCH_MNT/f
 # |
 # |---- f/                                (ino 264)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # Now make inode 257 a child of inode 259 and rename inode 258 to the name that
 # inode 257 had before. When the incremental send processes inode 257, it can't
@@ -107,14 +107,14 @@ mv $SCRATCH_MNT/d $SCRATCH_MNT/e
 # |     |----- e2/                        (ino 262)
 #              |---- file2                (ino 263)
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
@@ -123,10 +123,10 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/084 b/tests/btrfs/084
index 04ccbb91a52f..0bffe10b881c 100755
--- a/tests/btrfs/084
+++ b/tests/btrfs/084
@@ -55,7 +55,7 @@ mkdir -p $SCRATCH_MNT/data/p1/p2
 #         |---- p1/                       (ino 263)
 #               |---- p2/                 (ino 264)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # Now move directories around such that for the subtrees with the path "p1/p2"
 # we end up swapping the parents, that is, inode 263 becomes the parent of
@@ -82,14 +82,14 @@ mv $SCRATCH_MNT/data/n4/p1/n2/p1 $SCRATCH_MNT/data
 #         |---- p1/                       (ino 260)
 #               |---- p2/                 (ino 264)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
@@ -98,9 +98,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/085 b/tests/btrfs/085
index bcbf1a05dc83..4b6d18b53bc0 100755
--- a/tests/btrfs/085
+++ b/tests/btrfs/085
@@ -106,14 +106,14 @@ test_orphan()
 
 new_subvolume()
 {
-	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/testdir
+	_btrfs subvolume create $SCRATCH_MNT/testdir
 }
 
 new_default()
 {
 	new_subvolume
 	SUB=$($BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{print $2}')
-	_run_btrfs_util_prog subvolume set-default $SUB $SCRATCH_MNT
+	_btrfs subvolume set-default $SUB $SCRATCH_MNT
 
 	_unmount_flakey
 	_mount_flakey
diff --git a/tests/btrfs/087 b/tests/btrfs/087
index 59a775efff90..c7e96db4207b 100755
--- a/tests/btrfs/087
+++ b/tests/btrfs/087
@@ -97,7 +97,7 @@ mv $SCRATCH_MNT/data/n1 $SCRATCH_MNT/data/n4/t5/p2/p1/p2/n2/t1/t7/p1/n1
 #                       |
 #                       |--- t7/                                (ino 264)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # The following sequence of directory renames resulted in an infinite path build
 # loop when attempting to build the path for inode 266. This is because the
@@ -149,14 +149,14 @@ mv $SCRATCH_MNT/data/n4/t1/n2/p1/p2/p1/p2/t7 $SCRATCH_MNT/data/n4/t1/t7
 #                  |
 #                  |--- t7/                           (ino 264)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
@@ -165,9 +165,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/090 b/tests/btrfs/090
index 3693a3ad0f40..bc4d310a1b1c 100755
--- a/tests/btrfs/090
+++ b/tests/btrfs/090
@@ -31,7 +31,7 @@ TOTAL_DEVS=`echo $SCRATCH_DEV_POOL | wc -w`
 
 _scratch_pool_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
 
-_run_btrfs_util_prog filesystem show $FIRST_POOL_DEV | \
+_btrfs filesystem show $FIRST_POOL_DEV | \
 	_filter_btrfs_filesystem_show $TOTAL_DEVS
 
 # success, all done
diff --git a/tests/btrfs/091 b/tests/btrfs/091
index a71e03406f8c..b4074349f2a7 100755
--- a/tests/btrfs/091
+++ b/tests/btrfs/091
@@ -31,11 +31,11 @@ run_check _scratch_mkfs "--nodesize $NODESIZE"
 # also disable all compression, or output will mismatch with golden output
 _try_scratch_mount "-o compress=no,compress-force=no" 2> /dev/null
 
-_run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv1
-_run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv2
-_run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv3
+_btrfs subvolume create $SCRATCH_MNT/subv1
+_btrfs subvolume create $SCRATCH_MNT/subv2
+_btrfs subvolume create $SCRATCH_MNT/subv3
 
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
 _qgroup_rescan $SCRATCH_MNT
 
 $XFS_IO_PROG -f -c "pwrite 0 256K" $SCRATCH_MNT/subv1/file1 | _filter_xfs_io
diff --git a/tests/btrfs/092 b/tests/btrfs/092
index f752f97296b3..7b310e8250fc 100755
--- a/tests/btrfs/092
+++ b/tests/btrfs/092
@@ -75,7 +75,7 @@ mv $SCRATCH_MNT/data/t3 $SCRATCH_MNT/data/n4/t2/t7/t4/t5/t6/n2/t7
 #                                          |-- t7/                    (ino 262)
 #                                               |-- t3/               (ino 267)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # The sequence of directory rename operations below made the btrfs incremental
 # send implementation enter an infinite loop when building path strings. The
@@ -136,14 +136,14 @@ mv $SCRATCH_MNT/data/n4/n1/t2/n2/t7 $SCRATCH_MNT/data/n4/n1/t2
 #                      |
 #                      |-- t7/                                        (ino 262)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
@@ -152,9 +152,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/094 b/tests/btrfs/094
index 75804465d0ad..8e57927825cd 100755
--- a/tests/btrfs/094
+++ b/tests/btrfs/094
@@ -70,7 +70,7 @@ $XFS_IO_PROG -c "pwrite -S 0xbb $((16 * $BLOCK_SIZE)) $((28 * $BLOCK_SIZE))" \
 $XFS_IO_PROG -c "pwrite -S 0xcc $((45 * $BLOCK_SIZE)) $((3 * $BLOCK_SIZE))" \
 	     -c "fsync" $SCRATCH_MNT/foo | _filter_xfs_io_blocks_modified
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # Now clone that same region of the 32 block extent into a new file, so that it
 # gets referenced twice and the incremental send operation below decides to
@@ -79,10 +79,10 @@ touch $SCRATCH_MNT/bar
 $CLONER_PROG -s $((44 * $BLOCK_SIZE)) -d $((44 * $BLOCK_SIZE)) -l $BLOCK_SIZE \
 	$SCRATCH_MNT/foo $SCRATCH_MNT/bar
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 echo "File contents in the original filesystem:"
@@ -99,8 +99,8 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File contents in the new filesystem:"
 echo "mysnap1/foo"
diff --git a/tests/btrfs/097 b/tests/btrfs/097
index 16ed7e008fc7..5db5108f2a80 100755
--- a/tests/btrfs/097
+++ b/tests/btrfs/097
@@ -40,7 +40,7 @@ BLOCK_SIZE=$(_get_block_size $SCRATCH_MNT)
 $XFS_IO_PROG -f -c "pwrite -S 0xaa $((32 * $BLOCK_SIZE)) $((16 * $BLOCK_SIZE))" \
 	     $SCRATCH_MNT/foo | _filter_xfs_io_blocks_modified
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # Now clone parts of the original extent into lower offsets of the file.
 #
@@ -71,10 +71,10 @@ $CLONER_PROG -s $(((32 + 4) * $BLOCK_SIZE)) -d 0 -l $((4 * $BLOCK_SIZE)) \
 $CLONER_PROG -s $(((32 + 12) * $BLOCK_SIZE)) -d $((4 * $BLOCK_SIZE)) \
 	     -l $((4 * $BLOCK_SIZE)) $SCRATCH_MNT/foo $SCRATCH_MNT/foo
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 echo "File contents in the original filesystem:"
@@ -86,8 +86,8 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File contents in the new filesystem:"
 od -t x1 $SCRATCH_MNT/mysnap2/foo | _filter_od
diff --git a/tests/btrfs/099 b/tests/btrfs/099
index f3a2002a0720..01c6080018a7 100755
--- a/tests/btrfs/099
+++ b/tests/btrfs/099
@@ -28,8 +28,8 @@ _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
 _require_fs_space $SCRATCH_MNT $(($FILESIZE * 2 / 1024))
 
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
-_run_btrfs_util_prog qgroup limit $FILESIZE 0/5 $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
+_btrfs qgroup limit $FILESIZE 0/5 $SCRATCH_MNT
 
 # loop 5 times without sync to ensure reserved space leak will happen
 for i in `seq 1 5`; do
diff --git a/tests/btrfs/100 b/tests/btrfs/100
index 410e83ba1761..97977a8cd19d 100755
--- a/tests/btrfs/100
+++ b/tests/btrfs/100
@@ -33,7 +33,7 @@ _dmerror_init
 _mkfs_dev "-f -d raid1 -m raid1 $dev1 $DMERROR_DEV"
 _dmerror_mount
 
-_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+_btrfs filesystem show -m $SCRATCH_MNT
 $BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | _filter_btrfs_filesystem_show
 
 error_devid=`$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT |\
@@ -47,9 +47,9 @@ run_check $FSSTRESS_PROG -d $SCRATCH_MNT -n 200 -p 8 $FSSTRESS_AVOID -x \
 # now load the error into the DMERROR_DEV
 _dmerror_load_error_table
 
-_run_btrfs_util_prog replace start -B $error_devid $dev2 $SCRATCH_MNT
+_btrfs replace start -B $error_devid $dev2 $SCRATCH_MNT
 
-_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+_btrfs filesystem show -m $SCRATCH_MNT
 $BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | _filter_btrfs_filesystem_show
 
 echo "=== device replace completed"
diff --git a/tests/btrfs/101 b/tests/btrfs/101
index e8ed8c5c7351..96472aaefe3d 100755
--- a/tests/btrfs/101
+++ b/tests/btrfs/101
@@ -34,7 +34,7 @@ _dmerror_init
 _mkfs_dev -f -d raid1 -m raid1 $dev1 $dev2 $DMERROR_DEV
 _dmerror_mount
 
-_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+_btrfs filesystem show -m $SCRATCH_MNT
 $BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | _filter_btrfs_filesystem_show
 
 error_devid=`$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT |\
@@ -48,9 +48,9 @@ run_check $FSSTRESS_PROG -d $SCRATCH_MNT -n 200 -p 8 $FSSTRESS_AVOID -x \
 # now load the error into the DMERROR_DEV
 _dmerror_load_error_table
 
-_run_btrfs_util_prog device delete $error_devid $SCRATCH_MNT
+_btrfs device delete $error_devid $SCRATCH_MNT
 
-_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+_btrfs filesystem show -m $SCRATCH_MNT
 $BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | _filter_btrfs_filesystem_show
 
 echo "=== device delete completed"
diff --git a/tests/btrfs/104 b/tests/btrfs/104
index c9528eb13d61..fa260a5692cd 100755
--- a/tests/btrfs/104
+++ b/tests/btrfs/104
@@ -77,7 +77,7 @@ _scratch_mount
 
 # populate the default subvolume and create a snapshot ('snap1')
 _explode_fs_tree 1 $SCRATCH_MNT/files
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap1
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap1
 
 # create new btree nodes in this snapshot. They will become shared
 # with the next snapshot we create.
@@ -88,12 +88,12 @@ _explode_fs_tree 1 $SCRATCH_MNT/snap1/files-snap1
 #
 # As a result of this action, snap2 will get an implied ref to the
 # 128K extent created in the default subvolume.
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2
+_btrfs subvolume snapshot $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2
 _explode_fs_tree 1 $SCRATCH_MNT/snap2/files-snap2
 
 # Enable qgroups now that we have our filesystem prepared. This
 # will kick off a scan which we will have to wait for.
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
 _qgroup_rescan $SCRATCH_MNT
 
 # Remount to clear cache, force everything to disk
@@ -109,10 +109,10 @@ _scratch_cycle_mount
 # the root finding code in qgroup accounting due to snap1 no longer
 # providing a path to it. This was fixed by the first two patches
 # referenced above.
-_run_btrfs_util_prog subvolume delete $SCRATCH_MNT/snap1
+_btrfs subvolume delete $SCRATCH_MNT/snap1
 
 # "btrfs filesystem sync" will trigger subvolume deletion
-_run_btrfs_util_prog filesystem sync $SCRATCH_MNT
+_btrfs filesystem sync $SCRATCH_MNT
 
 # Qgroup will be checked by fstest at _check_scratch_fs()
 
diff --git a/tests/btrfs/105 b/tests/btrfs/105
index b6cc23b928f2..64ed916fe0fa 100755
--- a/tests/btrfs/105
+++ b/tests/btrfs/105
@@ -39,8 +39,8 @@ _scratch_mount
 mkdir -p $SCRATCH_MNT/foo
 $XFS_IO_PROG -f -c "pwrite -S 0xaa 0 64K" $SCRATCH_MNT/foo/bar | _filter_xfs_io
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 echo "File digest before being replaced:"
 md5sum $SCRATCH_MNT/mysnap1/foo/bar | _filter_scratch
@@ -61,11 +61,11 @@ rm -f $SCRATCH_MNT/mysnap2/foo/bar
 $XFS_IO_PROG -f -c "pwrite -S 0xbb 0 96K" \
 	$SCRATCH_MNT/mysnap2/foo/bar | _filter_xfs_io
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/mysnap2 \
+_btrfs subvolume snapshot -r $SCRATCH_MNT/mysnap2 \
 	$SCRATCH_MNT/mysnap2_ro
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2_ro
 
 echo "File digest in the original filesystem after being replaced:"
@@ -77,8 +77,8 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File digest in the new filesystem:"
 # Must match the digest from the new file.
diff --git a/tests/btrfs/108 b/tests/btrfs/108
index 0f734e9cfa0d..ce9201032655 100755
--- a/tests/btrfs/108
+++ b/tests/btrfs/108
@@ -48,13 +48,13 @@ $XFS_IO_PROG -c "pwrite -S 0xbb 50K 10K" \
 	-c "fpunch 70K 10k" \
 	$SCRATCH_MNT/foo | _filter_xfs_io
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
 
 echo "File digests in the original filesystem:"
 md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
 md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/snap
 
 # Now recreate the filesystem by receiving the send stream and verify we get
 # the same file contents that the original filesystem had.
@@ -62,7 +62,7 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 
 # We expect the destination filesystem to have exactly the same file data as
 # the original filesystem.
diff --git a/tests/btrfs/109 b/tests/btrfs/109
index c545733e067a..6a918e3a5ba8 100755
--- a/tests/btrfs/109
+++ b/tests/btrfs/109
@@ -58,13 +58,13 @@ $XFS_IO_PROG -c "pwrite -S 0xbb 0K 40K"    \
 cp --reflink=always $SCRATCH_MNT/foo $SCRATCH_MNT/bar
 
 # Create our snapshot for the send operation.
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
 
 echo "File digests in the original filesystem:"
 md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
 md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/snap
 
 # Now recreate the filesystem by receiving the send stream and verify we get
 # the same file contents that the original filesystem had.
@@ -77,7 +77,7 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount "-o compress"
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 
 echo "File digests in the new filesystem:"
 # Must match the digests we got in the original filesystem.
diff --git a/tests/btrfs/110 b/tests/btrfs/110
index 86049233b490..b572001ef2ef 100755
--- a/tests/btrfs/110
+++ b/tests/btrfs/110
@@ -37,20 +37,20 @@ _scratch_mount
 $XFS_IO_PROG -f -c "pwrite -S 0xaa 0K 32K" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Create the first snapshot.
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
 
 echo "File digest in the first filesystem, first snapshot:"
 md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
 
 # Save send stream for this snapshot.
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
 
 # Create a new filesystem and receive the snapshot.
 _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 
 echo "File digest in the second filesystem, first snapshot:"
 # Must match the digest we got in the first filesystem.
@@ -58,18 +58,18 @@ md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
 
 # Snapshot the first snapshot as rw, modify this new snapshot and then snapshot
 # it as RO to use in a send operation (send requires RO snapshots).
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2_rw
+_btrfs subvolume snapshot $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2_rw
 
 $XFS_IO_PROG -c "pwrite -S 0xbb 4K 4K" \
 	$SCRATCH_MNT/snap2_rw/foo | _filter_xfs_io
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/snap2_rw \
+_btrfs subvolume snapshot -r $SCRATCH_MNT/snap2_rw \
 	$SCRATCH_MNT/snap2
 
 echo "File digest in the second filesystem, second snapshot:"
 md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
 
-_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+_btrfs send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/snap2
 
 # Create a new filesystem and receive both the first snapshot, through the first
@@ -80,12 +80,12 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 # Receiving the second snapshot used to fail because the send stream used an
 # incorrect value for the clone sources uuid field - it used the uuid of
 # snapshot 1, which is different on each filesystem, instead of the received
 # uuid value, which is preserved across different filesystems.
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File digests in the third filesystem:"
 # Must match the digests we got in the previous filesystems.
diff --git a/tests/btrfs/111 b/tests/btrfs/111
index f03555bbbec9..7eb551d43d3f 100755
--- a/tests/btrfs/111
+++ b/tests/btrfs/111
@@ -37,13 +37,13 @@ _scratch_mount
 $XFS_IO_PROG -f -c "pwrite -S 0xaa 0K 32K" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Create the first snapshot.
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
 
 # Modify our file and create the second snapshot, used later for an incremental
 # send operation.
 $XFS_IO_PROG -c "pwrite -S 0xbb 4K 4K" $SCRATCH_MNT/foo | _filter_xfs_io
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
 
 echo "File digests in the first filesystem:"
 md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
@@ -51,8 +51,8 @@ md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
 
 # Save send streams for the snapshots. For the first one we use a full send
 # operation and the for the second snapshot we use an incremental send.
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
+_btrfs send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/snap2
 
 # Create a new filesystem and receive the snapshots.
@@ -60,8 +60,8 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -vv -f $send_files_dir/1.snap $SCRATCH_MNT
-_run_btrfs_util_prog receive -vv -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -vv -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -vv -f $send_files_dir/2.snap $SCRATCH_MNT
 
 echo "File digests in the second filesystem:"
 # Must match the digests we got in the first filesystem.
@@ -83,8 +83,8 @@ sync
 # Now create send streams for the snapshots from this new filesystem. For the
 # first snapshot we do a full send while for the second snapshot we do an
 # incremental send.
-_run_btrfs_util_prog send -f $send_files_dir/1_2.snap $SCRATCH_MNT/snap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2_2.snap \
+_btrfs send -f $send_files_dir/1_2.snap $SCRATCH_MNT/snap1
+_btrfs send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2_2.snap \
 	$SCRATCH_MNT/snap2
 
 # Create a new filesystem and receive the send streams we just created from the
@@ -97,8 +97,8 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -vv -f $send_files_dir/1_2.snap $SCRATCH_MNT
-_run_btrfs_util_prog receive -vv -f $send_files_dir/2_2.snap $SCRATCH_MNT
+_btrfs receive -vv -f $send_files_dir/1_2.snap $SCRATCH_MNT
+_btrfs receive -vv -f $send_files_dir/2_2.snap $SCRATCH_MNT
 
 echo "File digests in the third filesystem:"
 # Must match the digests we got in the first and second filesystems.
diff --git a/tests/btrfs/117 b/tests/btrfs/117
index 6539827b5a40..580db9a1bbec 100755
--- a/tests/btrfs/117
+++ b/tests/btrfs/117
@@ -28,7 +28,7 @@ _scratch_mount
 mkdir -p $SCRATCH_MNT/a/b/c
 $XFS_IO_PROG -f -c "pwrite -S 0xfd 0 128K" $SCRATCH_MNT/a/b/c/x | _filter_xfs_io
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
 
 # Create a bunch of small and empty files, this is just to make sure our
 # subvolume's btree gets more than 1 leaf, a condition necessary to trigger a
@@ -46,13 +46,13 @@ $XFS_IO_PROG -c "pwrite -S 0xab 32K 16K" $SCRATCH_MNT/a/b/c/y | _filter_xfs_io
 
 # Will be used as an extra source root for clone operations for the incremental
 # send operation below.
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/clones_snap
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/clones_snap
 
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
 
-_run_btrfs_util_prog send -f $tmp/1.snap $SCRATCH_MNT/snap1
-_run_btrfs_util_prog send -f $tmp/clones.snap $SCRATCH_MNT/clones_snap
-_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 \
+_btrfs send -f $tmp/1.snap $SCRATCH_MNT/snap1
+_btrfs send -f $tmp/clones.snap $SCRATCH_MNT/clones_snap
+_btrfs send -p $SCRATCH_MNT/snap1 \
 	-c $SCRATCH_MNT/clones_snap -f $tmp/2.snap $SCRATCH_MNT/snap2
 
 echo "File digests in the original filesystem:"
@@ -64,9 +64,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $tmp/1.snap $SCRATCH_MNT
-_run_btrfs_util_prog receive -f $tmp/clones.snap $SCRATCH_MNT
-_run_btrfs_util_prog receive -f $tmp/2.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/1.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/clones.snap $SCRATCH_MNT
+_btrfs receive -f $tmp/2.snap $SCRATCH_MNT
 
 echo "File digests in the new filesystem:"
 # Should match the digests we had in the original filesystem.
diff --git a/tests/btrfs/118 b/tests/btrfs/118
index bd47748d8a8c..ddacc30e2c19 100755
--- a/tests/btrfs/118
+++ b/tests/btrfs/118
@@ -37,8 +37,8 @@ _mount_flakey
 # fsync the mount point path, crash and mount to replay the log. This should
 # succeed and after the filesystem is mounted the snapshot should not be visible
 # anymore.
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap1
-_run_btrfs_util_prog subvolume delete $SCRATCH_MNT/snap1
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap1
+_btrfs subvolume delete $SCRATCH_MNT/snap1
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT
 _flakey_drop_and_remount
 [ -e $SCRATCH_MNT/snap1 ] && echo "Snapshot snap1 still exists after log replay"
@@ -46,8 +46,8 @@ _flakey_drop_and_remount
 # Similar scenario as above, but this time the snapshot is created inside a
 # directory and not directly under the root (mount point path).
 mkdir $SCRATCH_MNT/testdir
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/testdir/snap2
-_run_btrfs_util_prog subvolume delete $SCRATCH_MNT/testdir/snap2
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/testdir/snap2
+_btrfs subvolume delete $SCRATCH_MNT/testdir/snap2
 $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir
 _flakey_drop_and_remount
 [ -e $SCRATCH_MNT/testdir/snap2 ] && \
diff --git a/tests/btrfs/119 b/tests/btrfs/119
index d1926da99ee3..59615fcfacf3 100755
--- a/tests/btrfs/119
+++ b/tests/btrfs/119
@@ -32,7 +32,7 @@ _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
 
 # Create 2 directories with one file in one of them.
 # We use these just to trigger a transaction commit later, moving the file from
@@ -53,8 +53,8 @@ $XFS_IO_PROG -f -s -c "pwrite -S 0xaa 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io
 # power failure happens before the dedicated kernel thread does the snapshot
 # deletion, the next time the filesystem is mounted it resumes the snapshot
 # deletion.
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
-_run_btrfs_util_prog subvolume delete $SCRATCH_MNT/snap
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
+_btrfs subvolume delete $SCRATCH_MNT/snap
 
 # Now overwrite half of the extents we wrote before. Because we made a snapshpot
 # before, which isn't really deleted yet (since no transaction commit happened
diff --git a/tests/btrfs/120 b/tests/btrfs/120
index ba297bbb9abf..d351e8d58c57 100755
--- a/tests/btrfs/120
+++ b/tests/btrfs/120
@@ -31,9 +31,9 @@ _require_dm_target flakey
 
 populate_testdir()
 {
-	_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT \
+	_btrfs subvolume snapshot $SCRATCH_MNT \
 		$SCRATCH_MNT/testdir/snap
-	_run_btrfs_util_prog subvolume delete $SCRATCH_MNT/testdir/snap
+	_btrfs subvolume delete $SCRATCH_MNT/testdir/snap
 	rmdir $SCRATCH_MNT/testdir
 	mkdir $SCRATCH_MNT/testdir
 }
diff --git a/tests/btrfs/121 b/tests/btrfs/121
index 009f3b721728..860f97a8d320 100755
--- a/tests/btrfs/121
+++ b/tests/btrfs/121
@@ -23,7 +23,7 @@ _require_scratch
 
 _scratch_mkfs >/dev/null
 _scratch_mount
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
 # The qgroup '1/10' does not exist. The kernel should either gives an error
 # (newer kernel with invalid qgroup detection) or ignore it (older kernel with
 # above fix).
diff --git a/tests/btrfs/122 b/tests/btrfs/122
index 0d585a99972a..e4ab6a74d242 100755
--- a/tests/btrfs/122
+++ b/tests/btrfs/122
@@ -20,13 +20,13 @@ _require_btrfs_qgroup_report
 
 _scratch_mkfs >> $seqres.full
 _scratch_mount
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
 
 mkdir "$SCRATCH_MNT/snaps"
 
 # First make some simple snapshots - the bug was initially reproduced like this
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/empty1"
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/empty2"
+_btrfs subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/empty1"
+_btrfs subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/empty2"
 
 # This forces the fs tree out past level 0, adding at least one tree
 # block which must be properly accounted for when we make our next
@@ -37,8 +37,8 @@ for i in `seq 0 640`; do
 done
 
 # Snapshot twice.
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/snap1"
-_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/snap2"
+_btrfs subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/snap1"
+_btrfs subvolume snapshot $SCRATCH_MNT "$SCRATCH_MNT/snaps/snap2"
 
 _scratch_unmount
 
diff --git a/tests/btrfs/123 b/tests/btrfs/123
index 4c5b7e116a4d..7b3efb427810 100755
--- a/tests/btrfs/123
+++ b/tests/btrfs/123
@@ -38,7 +38,7 @@ _pwrite_byte 0xcdcdcdcd 0 32m $SCRATCH_MNT/large | _filter_xfs_io
 sync
 
 # enable quota and rescan to get correct number
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
 _qgroup_rescan $SCRATCH_MNT
 
 # now balance data block groups to corrupt qgroup
diff --git a/tests/btrfs/124 b/tests/btrfs/124
index 3d8141a109f0..701d874cd648 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -71,7 +71,7 @@ echo "max_fs_sz=$max_fs_sz count=$count" >> $seqres.full
 echo "-----Initialize -----" >> $seqres.full
 _scratch_pool_mkfs "-mraid1 -draid1" >> $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
-_run_btrfs_util_prog filesystem show
+_btrfs filesystem show
 dd if=/dev/zero of="$SCRATCH_MNT"/tf1 bs=$bs count=1 \
 					>>$seqres.full 2>&1
 echo "unmount" >> $seqres.full
@@ -91,7 +91,7 @@ echo "Write data with degraded mount"
 # the device used for mounting.
 
 _mount -o degraded $dev1 $SCRATCH_MNT >>$seqres.full 2>&1
-_run_btrfs_util_prog filesystem show
+_btrfs filesystem show
 dd if=/dev/zero of="$SCRATCH_MNT"/tf2 bs=$bs count=$count \
 					>>$seqres.full 2>&1
 checkpoint1=`md5sum $SCRATCH_MNT/tf2`
@@ -103,9 +103,9 @@ echo >> $seqres.full
 echo "-----Mount normal-----" >> $seqres.full
 echo
 echo "Mount normal and balance"
-_run_btrfs_util_prog device scan
+_btrfs device scan
 _scratch_mount >> $seqres.full 2>&1
-_run_btrfs_util_prog filesystem show
+_btrfs filesystem show
 echo >> $seqres.full
 _run_btrfs_balance_start ${SCRATCH_MNT} >>$seqres.full
 
@@ -120,7 +120,7 @@ _scratch_unmount
 # un-scan the btrfs devices
 _btrfs_forget_or_module_reload
 _mount -o degraded $dev2 $SCRATCH_MNT >>$seqres.full 2>&1
-_run_btrfs_util_prog filesystem show
+_btrfs filesystem show
 checkpoint3=`md5sum $SCRATCH_MNT/tf2`
 echo $checkpoint3 >> $seqres.full 2>&1
 
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 1b6e5d78b2f1..64b815349dae 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -78,8 +78,8 @@ _scratch_pool_mkfs "-mraid5 -draid5" >> $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 dd if=/dev/zero of="$SCRATCH_MNT"/tf1 bs=$bs count=1 \
 					>>$seqres.full 2>&1
-_run_btrfs_util_prog filesystem show
-_run_btrfs_util_prog filesystem df $SCRATCH_MNT
+_btrfs filesystem show
+_btrfs filesystem df $SCRATCH_MNT
 
 #-------------degraded-init-------------------
 echo >> $seqres.full
@@ -95,8 +95,8 @@ _btrfs_forget_or_module_reload
 _mount -o degraded,device=$dev2 $dev1 $SCRATCH_MNT >>$seqres.full 2>&1
 dd if=/dev/zero of="$SCRATCH_MNT"/tf2 bs=$bs count=$count \
 					>>$seqres.full 2>&1
-_run_btrfs_util_prog filesystem show
-_run_btrfs_util_prog filesystem df $SCRATCH_MNT
+_btrfs filesystem show
+_btrfs filesystem df $SCRATCH_MNT
 checkpoint1=`md5sum $SCRATCH_MNT/tf2`
 echo $checkpoint1 >> $seqres.full 2>&1
 
@@ -107,14 +107,14 @@ echo
 echo "Mount normal and balance"
 
 _scratch_unmount
-_run_btrfs_util_prog device scan
+_btrfs device scan
 _scratch_mount >> $seqres.full 2>&1
 
 echo >> $seqres.full
 _run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full
 
-_run_btrfs_util_prog filesystem show
-_run_btrfs_util_prog filesystem df ${SCRATCH_MNT}
+_btrfs filesystem show
+_btrfs filesystem df ${SCRATCH_MNT}
 
 checkpoint2=`md5sum $SCRATCH_MNT/tf2`
 echo $checkpoint2 >> $seqres.full 2>&1
@@ -131,8 +131,8 @@ _btrfs_forget_or_module_reload
 
 _mount -o degraded,device=${dev2} $dev3 $SCRATCH_MNT >>$seqres.full 2>&1
 
-_run_btrfs_util_prog filesystem show
-_run_btrfs_util_prog filesystem df $SCRATCH_MNT
+_btrfs filesystem show
+_btrfs filesystem df $SCRATCH_MNT
 checkpoint3=`md5sum $SCRATCH_MNT/tf2`
 echo $checkpoint3 >> $seqres.full 2>&1
 
diff --git a/tests/btrfs/126 b/tests/btrfs/126
index 1bb24e00f98a..9eda16f5417d 100755
--- a/tests/btrfs/126
+++ b/tests/btrfs/126
@@ -27,9 +27,9 @@ _scratch_mkfs >/dev/null
 # Use enospc_debug mount option to trigger restrict space info check
 _scratch_mount "-o enospc_debug"
 
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
 _qgroup_rescan $SCRATCH_MNT
-_run_btrfs_util_prog qgroup limit 512K 0/5 $SCRATCH_MNT
+_btrfs qgroup limit 512K 0/5 $SCRATCH_MNT
 
 # The amount of written data may change due to different nodesize at mkfs time,
 # so redirect stdout to seqres.full.
diff --git a/tests/btrfs/127 b/tests/btrfs/127
index f21531729e6b..dc57ffcf0a80 100755
--- a/tests/btrfs/127
+++ b/tests/btrfs/127
@@ -111,7 +111,7 @@ mkdir $SCRATCH_MNT/case_4/other_dir
 #         |
 #         |---- other_dir/                                           (ino 284)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # case 1
 #
@@ -214,14 +214,14 @@ mv $SCRATCH_MNT/case_4/ance $SCRATCH_MNT/case_4/tmp/other_dir/wait_dir/desc
 #                                       |---- desc/                  (ino 282)
 #                                               |---- ance/          (ino 283)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
@@ -230,9 +230,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/128 b/tests/btrfs/128
index baf194cf6f74..a226ecc3b312 100755
--- a/tests/btrfs/128
+++ b/tests/btrfs/128
@@ -54,7 +54,7 @@ mkdir $SCRATCH_MNT/del/y
 #       |--- x/                                                 (ino 261)
 #       |--- y/                                                 (ino 262)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # It used to be that when attempting to issue an rmdir operation for inode 259,
 # the kernel allocated an orphan_dir_info structure so that later after doing
@@ -80,14 +80,14 @@ rmdir $SCRATCH_MNT/del
 # |--- c/                                                       (ino 260)
 #      |--- tmp/                                                (ino 258)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
@@ -96,9 +96,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/129 b/tests/btrfs/129
index 4e3046f3f38c..a3a0de8daff3 100755
--- a/tests/btrfs/129
+++ b/tests/btrfs/129
@@ -53,7 +53,7 @@ mkdir $SCRATCH_MNT/del/x
 #       |--- tmp/                                               (ino 258)
 #       |--- x/                                                 (ino 261)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 # When inode 260 was processed, rename operations for it and for inode 258 were
 # issued (the rename for inode 260 must happen before the rename for inode 258).
@@ -76,14 +76,14 @@ rmdir $SCRATCH_MNT/del
 # |--- c/                                                       (ino 260)
 #      |--- tmp/                                                (ino 258)
 #
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
 run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
 	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
 
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1
+_btrfs send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/mysnap2
 
 # Now recreate the filesystem by receiving both send streams and verify we get
@@ -92,9 +92,9 @@ _scratch_unmount
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
 
 echo "Silence is golden"
diff --git a/tests/btrfs/130 b/tests/btrfs/130
index 6d9ddd4883dd..12cf8041e204 100755
--- a/tests/btrfs/130
+++ b/tests/btrfs/130
@@ -46,7 +46,7 @@ for i in $(seq 1 $(($nr_extents - 1))); do
 done
 
 # create a RO snapshot, so we can send out the snapshot
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/ro_snap
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/ro_snap
 
 # send out the subvolume, and it will either:
 # 1) OOM since memory is allocated inside a O(n^3) loop
diff --git a/tests/btrfs/139 b/tests/btrfs/139
index f3d92ba468b6..da314d573f49 100755
--- a/tests/btrfs/139
+++ b/tests/btrfs/139
@@ -28,10 +28,10 @@ _scratch_mount
 
 SUBVOL=$SCRATCH_MNT/subvol
 
-_run_btrfs_util_prog subvolume create $SUBVOL
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs subvolume create $SUBVOL
+_btrfs quota enable $SCRATCH_MNT
 _qgroup_rescan $SCRATCH_MNT
-_run_btrfs_util_prog qgroup limit -e 1G $SUBVOL
+_btrfs qgroup limit -e 1G $SUBVOL
 
 # Write and delete files within 1G limits, multiple times
 for i in $(seq 1 5); do
diff --git a/tests/btrfs/153 b/tests/btrfs/153
index 4a5fe2b8ce4f..1ee0e62cde52 100755
--- a/tests/btrfs/153
+++ b/tests/btrfs/153
@@ -23,9 +23,9 @@ _require_xfs_io_command "falloc"
 _scratch_mkfs >/dev/null
 _scratch_mount
 
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
 _qgroup_rescan $SCRATCH_MNT
-_run_btrfs_util_prog qgroup limit 100M 0/5 $SCRATCH_MNT
+_btrfs qgroup limit 100M 0/5 $SCRATCH_MNT
 
 testfile1=$SCRATCH_MNT/testfile1
 testfile2=$SCRATCH_MNT/testfile2
diff --git a/tests/btrfs/161 b/tests/btrfs/161
index 5aac8fe93a3b..8b10157afdaa 100755
--- a/tests/btrfs/161
+++ b/tests/btrfs/161
@@ -34,7 +34,7 @@ create_seed()
 		/dev/null
 	echo -- golden --
 	od -x $SCRATCH_MNT/foobar
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
 	$BTRFS_TUNE_PROG -S 1 $dev_seed
 	run_check _mount $dev_seed $SCRATCH_MNT
@@ -42,7 +42,7 @@ create_seed()
 
 create_sprout()
 {
-	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >> \
+	_btrfs device add -f $dev_sprout $SCRATCH_MNT >> \
 		$seqres.full
 	_scratch_unmount
 	run_check _mount $dev_sprout $SCRATCH_MNT
diff --git a/tests/btrfs/162 b/tests/btrfs/162
index 1d8dbf9546be..eed91bf68c2b 100755
--- a/tests/btrfs/162
+++ b/tests/btrfs/162
@@ -37,7 +37,7 @@ create_seed()
 		/dev/null
 	echo -- gloden --
 	od -x $SCRATCH_MNT/foobar
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
 	$BTRFS_TUNE_PROG -S 1 $dev_seed
 }
@@ -45,7 +45,7 @@ create_seed()
 create_sprout_seed()
 {
 	run_check _mount $dev_seed $SCRATCH_MNT
-	_run_btrfs_util_prog device add -f $dev_sprout_seed $SCRATCH_MNT >>\
+	_btrfs device add -f $dev_sprout_seed $SCRATCH_MNT >>\
 		$seqres.full
 	_scratch_unmount
 	$BTRFS_TUNE_PROG -S 1 $dev_sprout_seed
@@ -54,7 +54,7 @@ create_sprout_seed()
 create_next_sprout()
 {
 	run_check _mount $dev_sprout_seed $SCRATCH_MNT
-	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >>\
+	_btrfs device add -f $dev_sprout $SCRATCH_MNT >>\
 		$seqres.full
 	_scratch_unmount
 	run_check _mount $dev_sprout $SCRATCH_MNT
diff --git a/tests/btrfs/163 b/tests/btrfs/163
index da31cfb8f1dd..2943d98a6e34 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -50,7 +50,7 @@ create_seed()
 		/dev/null
 	echo -- golden --
 	od -x $SCRATCH_MNT/foobar
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
 	$BTRFS_TUNE_PROG -S 1 $dev_seed
 	run_check _mount $dev_seed $SCRATCH_MNT
@@ -58,9 +58,9 @@ create_seed()
 
 add_sprout()
 {
-	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >>\
+	_btrfs device add -f $dev_sprout $SCRATCH_MNT >>\
 		$seqres.full
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 	_mount -o remount,rw $dev_sprout $SCRATCH_MNT
 	$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 4M" $SCRATCH_MNT/foobar2 >\
 		/dev/null
@@ -68,8 +68,8 @@ add_sprout()
 
 replace_sprout()
 {
-	_run_btrfs_util_prog replace start -fB $dev_sprout $dev_replace_tgt $SCRATCH_MNT
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs replace start -fB $dev_sprout $dev_replace_tgt $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
 	_btrfs_forget_or_module_reload
 	run_check _mount -o device=$dev_seed $dev_replace_tgt $SCRATCH_MNT
@@ -84,7 +84,7 @@ seed_is_mountable()
 {
 	_btrfs_forget_or_module_reload
 	run_check _mount $dev_seed $SCRATCH_MNT
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
 }
 
diff --git a/tests/btrfs/164 b/tests/btrfs/164
index bc62b535ca0c..002cdd4c319a 100755
--- a/tests/btrfs/164
+++ b/tests/btrfs/164
@@ -40,7 +40,7 @@ create_seed()
 		/dev/null
 	echo -- gloden --
 	od -x $SCRATCH_MNT/foobar
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
 	$BTRFS_TUNE_PROG -S 1 $dev_seed
 	run_check _mount $dev_seed $SCRATCH_MNT
@@ -48,19 +48,19 @@ create_seed()
 
 add_sprout()
 {
-	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >>\
+	_btrfs device add -f $dev_sprout $SCRATCH_MNT >>\
 		$seqres.full
 	run_check mount -o rw,remount $dev_seed $SCRATCH_MNT
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 }
 
 delete_seed()
 {
-	_run_btrfs_util_prog device delete $dev_seed $SCRATCH_MNT
+	_btrfs device delete $dev_seed $SCRATCH_MNT
 	_scratch_unmount
 	_btrfs_forget_or_module_reload
 	run_check _mount $dev_sprout $SCRATCH_MNT
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 	echo -- sprout --
 	od -x $SCRATCH_MNT/foobar
 	_scratch_unmount
@@ -69,7 +69,7 @@ delete_seed()
 seed_is_mountable()
 {
 	run_check _mount $dev_seed $SCRATCH_MNT
-	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_btrfs filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
 }
 
diff --git a/tests/btrfs/166 b/tests/btrfs/166
index 47f7f9b38deb..df034d5de634 100755
--- a/tests/btrfs/166
+++ b/tests/btrfs/166
@@ -35,7 +35,7 @@ _mount_flakey
 
 # Enable qgroups on the filesystem. This will start the qgroup rescan kernel
 # thread.
-_run_btrfs_util_prog quota enable $SCRATCH_MNT
+_btrfs quota enable $SCRATCH_MNT
 
 # Simulate a power failure, while the qgroup rescan kernel thread is running,
 # and then mount the filesystem to check that mounting the filesystem does not
diff --git a/tests/btrfs/167 b/tests/btrfs/167
index 7ab2fdbaa60e..429ea3869a62 100755
--- a/tests/btrfs/167
+++ b/tests/btrfs/167
@@ -37,7 +37,7 @@ _pwrite_byte 0xcd 0 128K $SCRATCH_MNT/nodatasum_file > /dev/null
 sync
 
 # Replace the device
-_run_btrfs_util_prog replace start -Bf 1 $SPARE_DEV $SCRATCH_MNT
+_btrfs replace start -Bf 1 $SPARE_DEV $SCRATCH_MNT
 
 # Unmount to drop all cache so next read will read from disk
 _scratch_unmount
diff --git a/tests/btrfs/218 b/tests/btrfs/218
index b0434834ff65..a44d05f07a26 100755
--- a/tests/btrfs/218
+++ b/tests/btrfs/218
@@ -39,7 +39,7 @@ $BTRFS_TUNE_PROG -S 1 $dev_seed
 
 # Mount the seed device and add the rw device
 _mount -o ro $dev_seed $SCRATCH_MNT
-_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >> $seqres.full
+_btrfs device add -f $dev_sprout $SCRATCH_MNT >> $seqres.full
 $BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
 _scratch_unmount
 
diff --git a/tests/btrfs/272 b/tests/btrfs/272
index a49ec0760fac..0ae1e5e1bd66 100755
--- a/tests/btrfs/272
+++ b/tests/btrfs/272
@@ -32,15 +32,15 @@ _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
 # Create a file and 2000 hard links to the same inode
-_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
+_btrfs subvolume create $SCRATCH_MNT/vol
 touch $SCRATCH_MNT/vol/foo
 for i in {1..2000}; do
 	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
 done
 
 # Create a snapshot for a full send operation
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
 
 # Remove 2000 hard links and re-create the last 1000 links
 for i in {1..2000}; do
@@ -51,8 +51,8 @@ for i in {1001..2000}; do
 done
 
 # Create another snapshot for an incremental send operation
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap2
-_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+_btrfs subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap2
+_btrfs send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
 		     $SCRATCH_MNT/snap2
 
 $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/snap1
@@ -67,7 +67,7 @@ _scratch_mount
 
 # Add the first snapshot to the new filesystem by applying the first send
 # stream.
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 
 # The incremental receive operation below used to fail with the following
 # error:
@@ -79,7 +79,7 @@ _run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
 # operation cannot handle the duplicated paths, which are stored in
 # different ways, well, so it decides to issue a link operation for the
 # existing path. This results in the receiver to fail with the above error.
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/snap1
 $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/snap2
diff --git a/tests/btrfs/273 b/tests/btrfs/273
index dc9c21328613..a6b3fd42112b 100755
--- a/tests/btrfs/273
+++ b/tests/btrfs/273
@@ -110,14 +110,14 @@ get_meta_bgs() {
 }
 
 # This test case does not return the result because
-# _run_btrfs_util_prog will call _fail() in the error case anyway.
+# _btrfs will call _fail() in the error case anyway.
 stress_metadata_bgs() {
 	local metabgs=$(get_meta_bgs)
 	local count=0
 
 	while : ; do
-		_run_btrfs_util_prog subvolume snapshot ${SCRATCH_MNT} ${SCRATCH_MNT}/snap$i
-		_run_btrfs_util_prog filesystem sync ${SCRATCH_MNT}
+		_btrfs subvolume snapshot ${SCRATCH_MNT} ${SCRATCH_MNT}/snap$i
+		_btrfs filesystem sync ${SCRATCH_MNT}
 		cur_metabgs=$(get_meta_bgs)
 		if [[ "${cur_metabgs}" != "${metabgs}" ]]; then
 			break
diff --git a/tests/btrfs/278 b/tests/btrfs/278
index ff59ebd29d7b..75af26824ebd 100755
--- a/tests/btrfs/278
+++ b/tests/btrfs/278
@@ -31,7 +31,7 @@ mkdir $send_files_dir
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
-_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
+_btrfs subvolume create $SCRATCH_MNT/vol
 
 # Creating the first snapshot looks like:
 #
@@ -53,7 +53,7 @@ mkdir $SCRATCH_MNT/vol/changed_subcase1.dir
 touch $SCRATCH_MNT/vol/changed_subcase1.dir/foo
 mkdir $SCRATCH_MNT/vol/changed_subcase2.dir
 touch $SCRATCH_MNT/vol/changed_subcase2.dir/foo
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
 
 # Delete the deleted.*, create a new file and a new directory, and then
 # take the second snapshot looks like:
@@ -72,7 +72,7 @@ unlink $SCRATCH_MNT/vol/deleted.file
 rmdir $SCRATCH_MNT/vol/deleted.dir
 touch $SCRATCH_MNT/vol/new.file
 mkdir $SCRATCH_MNT/vol/new.dir
-_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap2
+_btrfs subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap2
 
 # Set the snapshot "snap1" to read-write mode and turn several inodes to
 # orphans, so that the snapshot will look like this:
@@ -139,7 +139,7 @@ rmdir $SCRATCH_MNT/snap2/new.dir
 $BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap2 ro true
 
 # Test that a full send operation can handle orphans with no paths
-_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
+_btrfs send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
 
 # Test that an incremental send operation can handle orphans.
 #
@@ -181,7 +181,7 @@ _run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
 # the receive operation will fail with a wrong unlink on a non-empty
 # directory.
 #
-_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
+_btrfs send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
 		     $SCRATCH_MNT/snap2
 
 $FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/snap1
@@ -206,10 +206,10 @@ _scratch_mount
 
 # Add the first snapshot to the new filesystem by applying the first send
 # stream.
-_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/1.snap $SCRATCH_MNT
 
 # Test the incremental send stream
-_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
+_btrfs receive -f $send_files_dir/2.snap $SCRATCH_MNT
 
 $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/snap1
 $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/snap2
diff --git a/tests/btrfs/320 b/tests/btrfs/320
index df7acdbb3deb..1197d95b6e21 100755
--- a/tests/btrfs/320
+++ b/tests/btrfs/320
@@ -23,8 +23,8 @@ _require_scratch_qgroup
 _basic_test()
 {
 	echo "=== basic test ===" >> $seqres.full
-	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
-	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
+	_btrfs subvolume create $SCRATCH_MNT/a
+	_btrfs quota enable $SCRATCH_MNT/a
 	_qgroup_rescan $SCRATCH_MNT
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
 	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid >> \
@@ -32,7 +32,7 @@ _basic_test()
 	[ $? -eq 0 ] || _fail "couldn't find our subvols quota group"
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
 		$FSSTRESS_AVOID
-	_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT/a \
+	_btrfs subvolume snapshot $SCRATCH_MNT/a \
 		$SCRATCH_MNT/b
 
 	# the shared values of both the original subvol and snapshot should
@@ -54,8 +54,8 @@ _rescan_test()
 {
 	echo "=== rescan test ===" >> $seqres.full
 	# first with a blank subvol
-	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
-	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
+	_btrfs subvolume create $SCRATCH_MNT/a
+	_btrfs quota enable $SCRATCH_MNT/a
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
 		$FSSTRESS_AVOID
@@ -77,10 +77,10 @@ _rescan_test()
 _limit_test_noexceed()
 {
 	echo "=== limit not exceed test ===" >> $seqres.full
-	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
-	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	_btrfs subvolume create $SCRATCH_MNT/a
+	_btrfs quota enable $SCRATCH_MNT
 	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
-	_run_btrfs_util_prog qgroup limit 5M 0/$subvolid $SCRATCH_MNT
+	_btrfs qgroup limit 5M 0/$subvolid $SCRATCH_MNT
 	_ddt of=$SCRATCH_MNT/a/file bs=4M count=1 >> $seqres.full 2>&1
 	[ $? -eq 0 ] || _fail "should have been allowed to write"
 }
-- 
2.44.0


