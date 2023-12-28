Return-Path: <linux-btrfs+bounces-1149-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E873C81F4BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Dec 2023 06:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506062839A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Dec 2023 05:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8E2568;
	Thu, 28 Dec 2023 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TQkDDYS3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TQkDDYS3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86841FDC;
	Thu, 28 Dec 2023 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 980861FCE2;
	Thu, 28 Dec 2023 05:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703741796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XmDJThqdFBSkPF7BINAMiQCUeKIYUL2AmIZsiTA/ERE=;
	b=TQkDDYS3wymJMI37TUGZYA7XpA1S2YyMJM5xZcvAtUcWP9iHvhi1n8f59S99ri6s3zDv3w
	0pjCozVjNfGRq3A9JFmgiWXuY4N2Z0/OaUsV6g55ljuUgGHErq6iWjh+/FstgYFMJ1FoJl
	L0T60/PgVkSFzfwUbzimvaP70o02ffU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703741796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XmDJThqdFBSkPF7BINAMiQCUeKIYUL2AmIZsiTA/ERE=;
	b=TQkDDYS3wymJMI37TUGZYA7XpA1S2YyMJM5xZcvAtUcWP9iHvhi1n8f59S99ri6s3zDv3w
	0pjCozVjNfGRq3A9JFmgiWXuY4N2Z0/OaUsV6g55ljuUgGHErq6iWjh+/FstgYFMJ1FoJl
	L0T60/PgVkSFzfwUbzimvaP70o02ffU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 304AE1329E;
	Thu, 28 Dec 2023 05:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4DAiM2IJjWUaOgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 28 Dec 2023 05:36:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/016: fix a false alert due to xattrs mismatch
Date: Thu, 28 Dec 2023 16:06:12 +1030
Message-ID: <ae441bd376587124becd9141ed690598d4ed281a.1703741660.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.90
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Flag: NO

[BUG]
When running btrfs/016 after any other test case, it would fail on a
SELinux enabled environment:

  btrfs/015 1s ...  0s
  btrfs/016 1s ... [failed, exit status 1]- output mismatch (see ~/xfstests-dev/results//btrfs/016.out.bad)
      --- tests/btrfs/016.out	2023-12-28 10:39:36.481027970 +1030
      +++ ~/xfstests-dev/results//btrfs/016.out.bad	2023-12-28 15:53:10.745436664 +1030
      @@ -1,2 +1,3 @@
       QA output created by 016
      -Silence is golden
      +fssum failed
      +(see ~/xfstests-dev/results//btrfs/016.full for details)
      ...
      (Run 'diff -u ~/xfstests-dev/tests/btrfs/016.out ~/xfstests-dev/results//btrfs/016.out.bad'  to see the entire diff)
  Ran: btrfs/015 btrfs/016
  Failures: btrfs/016
  Failed 1 of 2 tests

[CAUSE]
The test case itself would try to use a blank SELinux context for the
SCRATCH_MNT, to control the xattrs.

But the initial send stream is generated from $TEST_DIR, which may still
have the default SELinux mount context.

And such mismatch in the SELinux xattr (source on $TEST_DIR still has
the extra xattr, meanwhile the receve end on $SCRATCH_MNT doesn't) would
lead to above mismatch.

[FIX]
Instead of doing all the edge juggling using $TEST_DIR, this time we do
all the work on $SCRATCH_MNT.

This means we would generate the initial send stream from $SCRATCH_MNT,
then reformat the fs, mount scratch again, receive and verify.

This does not only fix the above false alerts, but also simplify the
cleanup.
We no longer needs to cleanup the extra file for the initial send
stream, as they are on the scratch device and would be formatted anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/016 | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/tests/btrfs/016 b/tests/btrfs/016
index 35609329ba0e..9371b3316332 100755
--- a/tests/btrfs/016
+++ b/tests/btrfs/016
@@ -12,22 +12,11 @@ _begin_fstest auto quick send prealloc
 tmp=`mktemp -d`
 tmp_dir=send_temp_$seq
 
-# Override the default cleanup function.
-_cleanup()
-{
-	$BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/snap > /dev/null 2>&1
-	$BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/snap1 > /dev/null 2>&1
-	$BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/send > /dev/null 2>&1
-	rm -rf $TEST_DIR/$tmp_dir
-	rm -f $tmp.*
-}
-
 # Import common functions.
 . ./common/filter
 
 # real QA test starts here
 _supported_fs btrfs
-_require_test
 _require_scratch
 _require_fssum
 _require_xfs_io_command "falloc"
@@ -41,29 +30,33 @@ export SELINUX_MOUNT_OPTIONS=""
 
 _scratch_mount
 
-mkdir $TEST_DIR/$tmp_dir
-$BTRFS_UTIL_PROG subvolume create $TEST_DIR/$tmp_dir/send \
+mkdir $SCRATCH_MNT/$tmp_dir
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/$tmp_dir/send \
 	> $seqres.full 2>&1 || _fail "failed subvolume create"
 
-_ddt of=$TEST_DIR/$tmp_dir/send/foo bs=1M count=10 >> $seqres.full \
+_ddt of=$SCRATCH_MNT/$tmp_dir/send/foo bs=1M count=10 >> $seqres.full \
 	2>&1 || _fail "dd failed"
-$BTRFS_UTIL_PROG subvolume snapshot -r $TEST_DIR/$tmp_dir/send \
-	$TEST_DIR/$tmp_dir/snap >> $seqres.full 2>&1 || _fail "failed snap"
-$XFS_IO_PROG -c "fpunch 1m 1m" $TEST_DIR/$tmp_dir/send/foo
-$BTRFS_UTIL_PROG subvolume snapshot -r $TEST_DIR/$tmp_dir/send \
-	$TEST_DIR/$tmp_dir/snap1 >> $seqres.full 2>&1 || _fail "failed snap"
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/$tmp_dir/send \
+	$SCRATCH_MNT/$tmp_dir/snap >> $seqres.full 2>&1 || _fail "failed snap"
+$XFS_IO_PROG -c "fpunch 1m 1m" $SCRATCH_MNT/$tmp_dir/send/foo
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/$tmp_dir/send \
+	$SCRATCH_MNT/$tmp_dir/snap1 >> $seqres.full 2>&1 || _fail "failed snap"
 
-$FSSUM_PROG -A -f -w $tmp/fssum.snap $TEST_DIR/$tmp_dir/snap >> $seqres.full \
+$FSSUM_PROG -A -f -w $tmp/fssum.snap $SCRATCH_MNT/$tmp_dir/snap >> $seqres.full \
 	2>&1 || _fail "fssum gen failed"
-$FSSUM_PROG -A -f -w $tmp/fssum.snap1 $TEST_DIR/$tmp_dir/snap1 >> $seqres.full \
+$FSSUM_PROG -A -f -w $tmp/fssum.snap1 $SCRATCH_MNT/$tmp_dir/snap1 >> $seqres.full \
 	2>&1 || _fail "fssum gen failed"
 
-$BTRFS_UTIL_PROG send -f $tmp/send.snap $TEST_DIR/$tmp_dir/snap >> \
+$BTRFS_UTIL_PROG send -f $tmp/send.snap $SCRATCH_MNT/$tmp_dir/snap >> \
 	$seqres.full 2>&1 || _fail "failed send"
-$BTRFS_UTIL_PROG send -p $TEST_DIR/$tmp_dir/snap \
-	-f $tmp/send.snap1 $TEST_DIR/$tmp_dir/snap1 \
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/$tmp_dir/snap \
+	-f $tmp/send.snap1 $SCRATCH_MNT/$tmp_dir/snap1 \
 	>> $seqres.full 2>&1 || _fail "failed send"
 
+_scratch_unmount
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
 $BTRFS_UTIL_PROG receive -f $tmp/send.snap $SCRATCH_MNT >> $seqres.full 2>&1 \
 	|| _fail "failed recv"
 $BTRFS_UTIL_PROG receive -f $tmp/send.snap1 $SCRATCH_MNT >> $seqres.full 2>&1 \
@@ -74,5 +67,10 @@ $FSSUM_PROG -r $tmp/fssum.snap $SCRATCH_MNT/snap >> $seqres.full 2>&1 \
 $FSSUM_PROG -r $tmp/fssum.snap1 $SCRATCH_MNT/snap1 >> $seqres.full 2>&1 \
 	|| _fail "fssum failed"
 
+# Unset the selinux mount options and restore whatever the default one for
+# test device.
+unset SELINUX_MOUNT_OPTIONS
+_test_cycle_mount
+
 echo "Silence is golden"
 status=0 ; exit
-- 
2.43.0


