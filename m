Return-Path: <linux-btrfs+bounces-16941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B07B873DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 00:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44021CC1828
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 22:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E7F2FDC47;
	Thu, 18 Sep 2025 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kvXzUdjq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kvXzUdjq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5122F39C5
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234853; cv=none; b=klS/I5OW/WmYWGOhoSZf4UCXfpP+A61X4nrN0ptvRpRHIQyKfUht1e7mYEjAv/JxhH99BjXbVBki5yvpWct+VsjtV+0dW6fDMDXPSLFOATT1jWHpKhtWINV8amr99Xa33ICheM0CfXSqBME2HTgO0+Ru8dWeqaLftp5SrLN6Mo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234853; c=relaxed/simple;
	bh=5dvf2wrLfxSLrOhQhx5ojX1STH2Ex5COclJeqRnr8yw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RihMvK3DLlDInM/MQ2+GeeG6ZQpPs9p3y4xuX9Uh6wVv67doUW/ZVVDLVny/HFHPBqVIUgcGBxz6LdzoiPo3WBI2gJEcvO6fhfNXE+3nWFXSxUSaFaQwJyUqJCp411rLsHhAR7MD5A39sJfYLH/ode9OflWojf6gC0VvNX6SP4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kvXzUdjq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kvXzUdjq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32CDB21F9B;
	Thu, 18 Sep 2025 22:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758234849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gr0dH9dgYbSDHuaHtv6Cl/v0zhXfRKwmB3ll1dZjgjo=;
	b=kvXzUdjqWU3mJnb+2IcoVaZExVTsXamW3fM+NyXnDSN7Y8V1GQ5XJhhROJ9GO+bYlVzYQx
	E4MHcAU3o5pCI3MyxlUSDmCmw1wbaRVdwSQqvAj4CJvGZx0mY5d0z0O9VKJNpDiY+SEapN
	YqqkaQoPIt5y4/P5mPSMVZnXFdoLYhU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758234849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gr0dH9dgYbSDHuaHtv6Cl/v0zhXfRKwmB3ll1dZjgjo=;
	b=kvXzUdjqWU3mJnb+2IcoVaZExVTsXamW3fM+NyXnDSN7Y8V1GQ5XJhhROJ9GO+bYlVzYQx
	E4MHcAU3o5pCI3MyxlUSDmCmw1wbaRVdwSQqvAj4CJvGZx0mY5d0z0O9VKJNpDiY+SEapN
	YqqkaQoPIt5y4/P5mPSMVZnXFdoLYhU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2892D13A39;
	Thu, 18 Sep 2025 22:34:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MJBtNt+IzGh5WgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 18 Sep 2025 22:34:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH 2/3] btrfs/192 btrfs/30[456]: explicitly specify block size to avoid false alerts
Date: Fri, 19 Sep 2025 08:03:46 +0930
Message-ID: <20250918223347.10390-3-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250918223347.10390-1-wqu@suse.com>
References: <20250918223347.10390-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[BUG]
When running the experimental block size > page support, the test cases
btrfs/192 and btrfs/30[456] fail with the following error:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMPT_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

btrfs/192 436s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/192.out.bad)
    --- tests/btrfs/192.out	2022-05-11 11:25:30.746666664 +0930
    +++ /home/adam/xfstests/results//btrfs/192.out.bad	2025-09-18 18:34:10.511152624 +0930
    @@ -1,2 +1,2 @@
     QA output created by 192
    -Silence is golden
    +ERROR: illegal nodesize 4096 (smaller than 8192)
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/192.out /home/adam/xfstests/results//btrfs/192.out.bad'  to see the entire diff)

btrfs/304 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/304.out.bad)
    --- tests/btrfs/304.out	2024-07-15 16:17:42.639999997 +0930
    +++ /home/adam/xfstests/results//btrfs/304.out.bad	2025-09-18 18:44:13.761000000 +0930
    @@ -10,7 +10,7 @@
     leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
     fs uuid <UUID>
     chunk uuid <UUID>
    -	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
    +	item 0 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
     			stripe 0 devid 1 physical XXXXXXXXX
     total bytes XXXXXXXX
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/304.out /home/adam/xfstests/results//btrfs/304.out.bad'  to see the entire diff)

btrfs/305 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/305.out.bad)
    --- tests/btrfs/305.out	2024-07-15 16:17:42.639999997 +0930
    +++ /home/adam/xfstests/results//btrfs/305.out.bad	2025-09-18 18:44:14.914196231 +0930
    @@ -12,11 +12,9 @@
     leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
     fs uuid <UUID>
     chunk uuid <UUID>
    -	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
    +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
     			stripe 0 devid 1 physical XXXXXXXXX
    -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/305.out /home/adam/xfstests/results//btrfs/305.out.bad'  to see the entire diff)

btrfs/306 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/306.out.bad)
    --- tests/btrfs/306.out	2024-07-15 16:17:42.639999997 +0930
    +++ /home/adam/xfstests/results//btrfs/306.out.bad	2025-09-18 18:44:16.075000000 +0930
    @@ -14,7 +14,7 @@
     chunk uuid <UUID>
     	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
     			stripe 0 devid 1 physical XXXXXXXXX
    -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
    +	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
     			stripe 0 devid 2 physical XXXXXXXXX
     total bytes XXXXXXXX
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/306.out /home/adam/xfstests/results//btrfs/306.out.bad'  to see the entire diff)

Please note that, btrfs bs > ps is still under development.
This is only an early run to expose false alerts.

[CAUSE]
The test case btrfs/192 requires 4K nodesize to bump up tree size, and
btrfs/30[456] all requires 4K block size as the workload is designed
with that.

However if the QA runner is specify other block size (8K in this case),
it will break the 4K block size assumption of those tests, either
results mkfs failure in btrfs/192, or output difference for
btrfs/30[456].

[FIX]
Just explicitly specify the 4K block size during mkfs.

And since we're here, remove the out-of-date page size check, as btrfs
has subpage block size support for a while.
Instead use a more accurate supported sector size check, this allows the
test to be run on aarch64 with 64K page size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/192 | 8 ++------
 tests/btrfs/304 | 5 ++---
 tests/btrfs/305 | 5 ++---
 tests/btrfs/306 | 5 ++---
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/tests/btrfs/192 b/tests/btrfs/192
index 0a8ab2c1..56ec2b28 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -33,11 +33,7 @@ _require_btrfs_mkfs_feature "no-holes"
 _require_log_writes
 _require_scratch
 _require_attrs
-
-# We require a 4K nodesize to ensure the test isn't too slow
-if [ $(_get_page_size) -ne 4096 ]; then
-	_notrun "This test doesn't support non-4K page size yet"
-fi
+_require_btrfs_support_sectorsize 4096
 
 runtime=30
 nr_cpus=$("$here/src/feature" -o)
@@ -55,7 +51,7 @@ $BLKDISCARD_PROG $LOGWRITES_DMDEV > /dev/null 2>&1
 # Use no-holes to avoid warnings of missing file extent items (expected
 # for holes due to mix of buffered and direct IO writes).
 # And use 4K nodesize to bump tree height.
-_log_writes_mkfs -O no-holes -n 4k >> $seqres.full
+_log_writes_mkfs -O no-holes -n 4k -s 4k >> $seqres.full
 _log_writes_mount
 
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/src > /dev/null
diff --git a/tests/btrfs/304 b/tests/btrfs/304
index b7ed66af..18f73590 100755
--- a/tests/btrfs/304
+++ b/tests/btrfs/304
@@ -20,8 +20,7 @@ _require_btrfs_fs_feature "raid_stripe_tree"
 _require_btrfs_fs_feature "free_space_tree"
 _require_btrfs_free_space_tree
 _require_btrfs_no_compress
-
-test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
+_require_btrfs_support_sectorsize 4096
 
 test_4k_write()
 {
@@ -31,7 +30,7 @@ test_4k_write()
 	_scratch_dev_pool_get $ndevs
 
 	echo "==== Testing $profile ===="
-	_scratch_pool_mkfs -d $profile -m $profile -O raid-stripe-tree
+	_scratch_pool_mkfs -s 4k -d $profile -m $profile -O raid-stripe-tree
 	_scratch_mount
 
 	$XFS_IO_PROG -fc "pwrite 0 4k" "$SCRATCH_MNT/foo" | _filter_xfs_io
diff --git a/tests/btrfs/305 b/tests/btrfs/305
index ad060853..45747627 100755
--- a/tests/btrfs/305
+++ b/tests/btrfs/305
@@ -21,8 +21,7 @@ _require_btrfs_fs_feature "raid_stripe_tree"
 _require_btrfs_fs_feature "free_space_tree"
 _require_btrfs_free_space_tree
 _require_btrfs_no_compress
-
-test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
+_require_btrfs_support_sectorsize 4096
 
 test_8k_new_stripe()
 {
@@ -32,7 +31,7 @@ test_8k_new_stripe()
 	_scratch_dev_pool_get $ndevs
 
 	echo "==== Testing $profile ===="
-	_scratch_pool_mkfs -d $profile -m $profile -O raid-stripe-tree
+	_scratch_pool_mkfs -s 4k -d $profile -m $profile -O raid-stripe-tree
 	_scratch_mount
 
 	# Fill the first stripe up to 64k - 4k
diff --git a/tests/btrfs/306 b/tests/btrfs/306
index b47c446b..db3defc8 100755
--- a/tests/btrfs/306
+++ b/tests/btrfs/306
@@ -21,8 +21,7 @@ _require_btrfs_fs_feature "raid_stripe_tree"
 _require_btrfs_fs_feature "free_space_tree"
 _require_btrfs_free_space_tree
 _require_btrfs_no_compress
-
-test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
+_require_btrfs_support_sectorsize 4096
 
 test_4k_write_64koff()
 {
@@ -32,7 +31,7 @@ test_4k_write_64koff()
 	_scratch_dev_pool_get $ndevs
 
 	echo "==== Testing $profile ===="
-	_scratch_pool_mkfs -d $profile -m $profile -O raid-stripe-tree
+	_scratch_pool_mkfs -s 4k -d $profile -m $profile -O raid-stripe-tree
 	_scratch_mount
 
 	# precondition one stripe
-- 
2.51.0


