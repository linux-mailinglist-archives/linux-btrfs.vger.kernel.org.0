Return-Path: <linux-btrfs+bounces-3028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2513887272B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 19:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A656F2838F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AF658128;
	Tue,  5 Mar 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oHGVpTYT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oHGVpTYT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E631BC26;
	Tue,  5 Mar 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665175; cv=none; b=IJec0boMkrtq7K6bHh+5y293TtrKO9i+cCjK0//tHl/hucHzxLW9vw4ZbEFo6odqK8z0CaJzXYm0huf0wXmvVt0dmK1C/J8GJJhBEGIkOQXGQJo+8dMPHAZry6mpYCQ1y8hksTfjAwn3MbTNK4SjGyWjQn7x6BGsRDyFYuST3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665175; c=relaxed/simple;
	bh=bEPViQRIALUwLRmHbD4kPtiF/bNpw/Bj6eDl1xFqdsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUx3JV0n17NE6EEhj4PUpDaAhBdhYdxWHSg+80OOXBaplEAC7xwt3AbkNb6GQtPC2oqanK3/aJbynEKEHaxKA9YzCHxrkzmk1af1dg4utjVurZbTFkPDqPf4/1Jq9/LoaeFM8DGIHHZHJpwXnOZ0ngZuM1WuVefMcuR2bK7Y3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oHGVpTYT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oHGVpTYT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65CC134B4C;
	Tue,  5 Mar 2024 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vKSPm1DbA2X+OhDsfsV30BH30GefQh7qeubHQ5HUhI=;
	b=oHGVpTYTx8t2V+TeY7aPmR0fIevyZx6Ex424561POCvjJ9jXUSkBYE7M1pHfC8ryC2Oj3J
	jNMS64RTV36npt+8tiT6xnfLF34J2GG9wnt3qmmJmJivvGzbimd996rOG+CbRmRFlBXLMl
	veqbOwsFryBbAkDdLE4xHG8Q+Xw775Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709665169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2vKSPm1DbA2X+OhDsfsV30BH30GefQh7qeubHQ5HUhI=;
	b=oHGVpTYTx8t2V+TeY7aPmR0fIevyZx6Ex424561POCvjJ9jXUSkBYE7M1pHfC8ryC2Oj3J
	jNMS64RTV36npt+8tiT6xnfLF34J2GG9wnt3qmmJmJivvGzbimd996rOG+CbRmRFlBXLMl
	veqbOwsFryBbAkDdLE4xHG8Q+Xw775Q=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F4E613466;
	Tue,  5 Mar 2024 18:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4ApBF5Fr52VQBQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 05 Mar 2024 18:59:29 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs/400: test normal qgroup operations in a compress friendly way
Date: Tue,  5 Mar 2024 19:52:24 +0100
Message-ID: <7d8ea24daf7f62ff620f8ebca9e81aa9d6021d01.1709664047.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1709664047.git.dsterba@suse.com>
References: <cover.1709664047.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oHGVpTYT
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 65CC134B4C
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

From: Josef Bacik <josef@toxicpanda.com>

btrfs/022 currently fails if you are testing with -o compress because it
does a limit exceed test which will pass with compression on.

However the other functionality this test tests is completely acceptable
with compression enabled.  Handle this by breaking the test into two
tests, one that simply tests the qgroup exceed limits test that requires
no compression, and the rest of the tests that do not have the no
compression restriction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/022     |  86 ++---------------------------------
 tests/btrfs/400     | 107 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/400.out |   2 +
 3 files changed, 112 insertions(+), 83 deletions(-)
 create mode 100755 tests/btrfs/400
 create mode 100644 tests/btrfs/400.out

diff --git a/tests/btrfs/022 b/tests/btrfs/022
index b1ef2fdf787640..32ad80bf9c64e8 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -4,7 +4,7 @@
 #
 # FS QA Test No. 022
 #
-# Test the basic functionality of qgroups
+# Test the basic qgroup exceed case
 #
 . ./common/preamble
 _begin_fstest auto qgroup limit
@@ -17,59 +17,8 @@ _require_scratch
 _require_qgroup_rescan
 _require_btrfs_qgroup_report
 
-# Test to make sure we can actually turn it on and it makes sense
-_basic_test()
-{
-	echo "=== basic test ===" >> $seqres.full
-	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
-	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
-	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
-	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
-	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid >> \
-		$seqres.full 2>&1
-	[ $? -eq 0 ] || _fail "couldn't find our subvols quota group"
-	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
-		$FSSTRESS_AVOID
-	_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT/a \
-		$SCRATCH_MNT/b
-
-	# the shared values of both the original subvol and snapshot should
-	# match
-	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
-	a_shared=$(echo $a_shared | $AWK_PROG '{ print $2 }')
-	echo "subvol a id=$subvolid" >> $seqres.full
-	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
-	echo "subvol b id=$subvolid" >> $seqres.full
-	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
-	b_shared=$(echo $b_shared | $AWK_PROG '{ print $2 }')
-	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT >> $seqres.full
-	[ $b_shared -eq $a_shared ] || _fail "shared values don't match"
-}
-
-#enable quotas, do some work, check our values and then rescan and make sure we
-#come up with the same answer
-_rescan_test()
-{
-	echo "=== rescan test ===" >> $seqres.full
-	# first with a blank subvol
-	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
-	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
-	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
-	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
-		$FSSTRESS_AVOID
-	sync
-	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
-	echo "qgroup values before rescan: $output" >> $seqres.full
-	refer=$(echo $output | $AWK_PROG '{ print $2 }')
-	excl=$(echo $output | $AWK_PROG '{ print $3 }')
-	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
-	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
-	echo "qgroup values after rescan: $output" >> $seqres.full
-	[ $refer -eq $(echo $output | $AWK_PROG '{ print $2 }') ] || \
-		_fail "reference values don't match after rescan"
-	[ $excl -eq $(echo $output | $AWK_PROG '{ print $3 }') ] || \
-		_fail "exclusive values don't match after rescan"
-}
+# This test requires specific data usage, skip if we have compression enabled
+_require_no_compress
 
 #basic exceed limit testing
 _limit_test_exceed()
@@ -82,43 +31,14 @@ _limit_test_exceed()
 	_ddt of=$SCRATCH_MNT/a/file bs=10M count=1 >> $seqres.full 2>&1
 	[ $? -ne 0 ] || _fail "quota should have limited us"
 }
-
-#basic noexceed limit testing
-_limit_test_noexceed()
-{
-	echo "=== limit not exceed test ===" >> $seqres.full
-	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
-	_run_btrfs_util_prog quota enable $SCRATCH_MNT
-	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
-	_run_btrfs_util_prog qgroup limit 5M 0/$subvolid $SCRATCH_MNT
-	_ddt of=$SCRATCH_MNT/a/file bs=4M count=1 >> $seqres.full 2>&1
-	[ $? -eq 0 ] || _fail "should have been allowed to write"
-}
-
 units=`_btrfs_qgroup_units`
 
-_scratch_mkfs > /dev/null 2>&1
-_scratch_mount
-_basic_test
-_scratch_unmount
-_check_scratch_fs
-
-_scratch_mkfs > /dev/null 2>&1
-_scratch_mount
-_rescan_test
-_scratch_unmount
-_check_scratch_fs
-
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount
 _limit_test_exceed
 _scratch_unmount
 _check_scratch_fs
 
-_scratch_mkfs > /dev/null 2>&1
-_scratch_mount
-_limit_test_noexceed
-
 # success, all done
 echo "Silence is golden"
 status=0
diff --git a/tests/btrfs/400 b/tests/btrfs/400
new file mode 100755
index 00000000000000..ad0363fb72d186
--- /dev/null
+++ b/tests/btrfs/400
@@ -0,0 +1,107 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Facebook.  All Rights Reserved.
+#
+# FS QA Test No. 400
+#
+# Test qgroups to validate the creation works, the counters are sane, rescan
+# works, and we do not get failures when we write less than the limit amount.
+#
+. ./common/preamble
+_begin_fstest auto qgroup limit
+
+# Import common functions.
+. ./common/filter
+
+_supported_fs btrfs
+_require_scratch
+_require_btrfs_qgroup_report
+
+# Test to make sure we can actually turn it on and it makes sense
+_basic_test()
+{
+	echo "=== basic test ===" >> $seqres.full
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
+	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid >> \
+		$seqres.full 2>&1
+	[ $? -eq 0 ] || _fail "couldn't find our subvols quota group"
+	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
+		$FSSTRESS_AVOID
+	_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT/a \
+		$SCRATCH_MNT/b
+
+	# the shared values of both the original subvol and snapshot should
+	# match
+	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
+	a_shared=$(echo $a_shared | $AWK_PROG '{ print $2 }')
+	echo "subvol a id=$subvolid" >> $seqres.full
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
+	echo "subvol b id=$subvolid" >> $seqres.full
+	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
+	b_shared=$(echo $b_shared | $AWK_PROG '{ print $2 }')
+	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT >> $seqres.full
+	[ $b_shared -eq $a_shared ] || _fail "shared values don't match"
+}
+
+#enable quotas, do some work, check our values and then rescan and make sure we
+#come up with the same answer
+_rescan_test()
+{
+	echo "=== rescan test ===" >> $seqres.full
+	# first with a blank subvol
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
+		$FSSTRESS_AVOID
+	sync
+	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
+	echo "qgroup values before rescan: $output" >> $seqres.full
+	refer=$(echo $output | $AWK_PROG '{ print $2 }')
+	excl=$(echo $output | $AWK_PROG '{ print $3 }')
+	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
+	echo "qgroup values after rescan: $output" >> $seqres.full
+	[ $refer -eq $(echo $output | $AWK_PROG '{ print $2 }') ] || \
+		_fail "reference values don't match after rescan"
+	[ $excl -eq $(echo $output | $AWK_PROG '{ print $3 }') ] || \
+		_fail "exclusive values don't match after rescan"
+}
+
+#basic noexceed limit testing
+_limit_test_noexceed()
+{
+	echo "=== limit not exceed test ===" >> $seqres.full
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+	_run_btrfs_util_prog qgroup limit 5M 0/$subvolid $SCRATCH_MNT
+	_ddt of=$SCRATCH_MNT/a/file bs=4M count=1 >> $seqres.full 2>&1
+	[ $? -eq 0 ] || _fail "should have been allowed to write"
+}
+
+units=`_btrfs_qgroup_units`
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+_basic_test
+_scratch_unmount
+_check_scratch_fs
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+_rescan_test
+_scratch_unmount
+_check_scratch_fs
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+_limit_test_noexceed
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/400.out b/tests/btrfs/400.out
new file mode 100644
index 00000000000000..c940c6206bcd81
--- /dev/null
+++ b/tests/btrfs/400.out
@@ -0,0 +1,2 @@
+QA output created by 400
+Silence is golden
-- 
2.42.1


