Return-Path: <linux-btrfs+bounces-2487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 717D1859DC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 09:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966621C221CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4712134A;
	Mon, 19 Feb 2024 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="idMZwNQT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="idMZwNQT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627420DCB;
	Mon, 19 Feb 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329617; cv=none; b=kbKrEP4uyi9WpmHmL4O5Ha6RxJBM0hPizR9/6Qq7tQZsw6nKp/QEOKdJqcK77RTKzK5l6IZrtxArSFWdapbOWMf7npAbD3SIJfJsxmP4qJJfZNaPryvrXFWDeOnnZg5TnlkXINnG6M2GOduY2dVqFMRxXRw7Fd3V8qvtxq74ZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329617; c=relaxed/simple;
	bh=HO3LpJVkyUxBJMSpfYK2zIVW52LP1sIPeKNOxbtrLHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q/HYF6iHBzmc2NmEacJMOs7YdGmh7ZFix7yHzzuFT6NU8SQcByhN8UObA0E3z+Pawn9Ym9LlzTveJxQ6VlpXDiiTsZ7e4bgVyHWpU6FVgpusnjz4amhnnL3s60nDwLRF4NkpL/kKpIAmaO58y/kBt/Zcg+BnaP2nXumO7sTn3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=idMZwNQT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=idMZwNQT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E8C11FD0C;
	Mon, 19 Feb 2024 08:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708329611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E4+gffStzxRy8aKVtcC4o0uv08VNjyH3EAUYiYtf960=;
	b=idMZwNQTFyTlCrwOuJE+ckwERS9ChVHPWwJaPCFtiyWVT5k6E17u54JQgrkOgsbEhDgbS1
	V0yBOPuvRY4rloeEogr1oWeG2lT3Noir5z4F9BUf/UB2VGVnYMa6yiRNtXsORKGl/MmxEY
	Z2TCzI/sk/jrd2OYgV7PavDRouBCVMc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708329611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E4+gffStzxRy8aKVtcC4o0uv08VNjyH3EAUYiYtf960=;
	b=idMZwNQTFyTlCrwOuJE+ckwERS9ChVHPWwJaPCFtiyWVT5k6E17u54JQgrkOgsbEhDgbS1
	V0yBOPuvRY4rloeEogr1oWeG2lT3Noir5z4F9BUf/UB2VGVnYMa6yiRNtXsORKGl/MmxEY
	Z2TCzI/sk/jrd2OYgV7PavDRouBCVMc=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 836EB13585;
	Mon, 19 Feb 2024 08:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0egAEYoK02UxOgAAn2gu4w
	(envelope-from <wqu@suse.com>); Mon, 19 Feb 2024 08:00:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/016: fix a false alert due to xattrs mismatch
Date: Mon, 19 Feb 2024 18:30:07 +1030
Message-ID: <20240219080007.70318-1-wqu@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=idMZwNQT
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -0.51
X-Rspamd-Queue-Id: 8E8C11FD0C
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
Fix the false alerts by disable XATTR checks.

Furthermore instead of doing all the edge juggling using $TEST_DIR, this
time we do all the work on $SCRATCH_MNT.

This means we would generate the initial send stream from $SCRATCH_MNT,
then reformat the fs, mount scratch again, receive and verify.

We no longer needs to cleanup the extra file for the initial send
stream, as they are on the scratch device and would be formatted anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add -T option to avoid xattrs checks
  Since this test case is only verify the hole punching behavior, XATTR
  is not our interest.
---
 tests/btrfs/016 | 53 ++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/tests/btrfs/016 b/tests/btrfs/016
index 35609329..37119363 100755
--- a/tests/btrfs/016
+++ b/tests/btrfs/016
@@ -12,58 +12,48 @@ _begin_fstest auto quick send prealloc
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
 
 _scratch_mkfs > /dev/null 2>&1
-
-#receive needs to be able to setxattrs, including the selinux context, if we use
-#the normal nfs context thing it screws up our ability to set the
-#security.selinux xattrs so we need to disable this for this test
-export SELINUX_MOUNT_OPTIONS=""
-
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
+# -A disable access time check.
+# And -T disable xattrs to prevent SELinux changes causing false alerts, and the
+# test case only cares about hole punching.
+$FSSUM_PROG -AT -f -w $tmp/fssum.snap $SCRATCH_MNT/$tmp_dir/snap >> $seqres.full \
 	2>&1 || _fail "fssum gen failed"
-$FSSUM_PROG -A -f -w $tmp/fssum.snap1 $TEST_DIR/$tmp_dir/snap1 >> $seqres.full \
+$FSSUM_PROG -AT -f -w $tmp/fssum.snap1 $SCRATCH_MNT/$tmp_dir/snap1 >> $seqres.full \
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
@@ -75,4 +65,5 @@ $FSSUM_PROG -r $tmp/fssum.snap1 $SCRATCH_MNT/snap1 >> $seqres.full 2>&1 \
 	|| _fail "fssum failed"
 
 echo "Silence is golden"
-status=0 ; exit
+status=0
+exit
-- 
2.43.1


