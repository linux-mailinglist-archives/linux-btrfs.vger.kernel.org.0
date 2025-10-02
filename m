Return-Path: <linux-btrfs+bounces-17327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3342BBB22FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 02:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6527A441E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 00:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFCC1758B;
	Thu,  2 Oct 2025 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uEmPE5q0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uEmPE5q0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89A1CFBA
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366649; cv=none; b=mhcs+3bezCQyb4S807REz+7GImUr+GrtQ7KM/5S6OIy+cnCt9pTmwE0F3r+lGhClfUJ8ds83mFSnbnpZCB843cxR6Dwm6/n1s8aV04l31V0RUuxq1xMQVJ9k1lOmoTi7gmY/5GvUHPOj0hzNCmxxUmjSvdC7yztf0M8SW7vKTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366649; c=relaxed/simple;
	bh=zQ2eP0Wsu8S6D6/fwiZpYzj5luYUbDweXvWMjZ4vwBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAlhXeeaioMO7AiFNSIRA/UGP/2Rz3OcENuyCQpYrh22G0//BA8CNLB4NrgHNRygutDhaMFshWFt2S6BZ8SPjLgFRnRcY0dMweeIKG3fsqR3MDI9JLp2HqEk7/cZkGlKo/dCT6BJNeyqojOdUOg/X2vXj3dUKb9E5aUyLkMU0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uEmPE5q0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uEmPE5q0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C69E81F7FD;
	Thu,  2 Oct 2025 00:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759366634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wrFG8VRkzrSlM7VOMmYiWOuM4PK9dJCri8aqCE8F94=;
	b=uEmPE5q0dFsCy6Gma6Ar8+GXn+O3ooVHTxHTlC2RY5pMkFTo6o5fxG0tvoDJ+qRcCQYf7G
	04VzWZs18b3zmCvfoSCyq+D6JVBLkaIyfMGTgCFgoaOa1fLj/B25mpuBVWZrom1te3GBOM
	tRNZWS83A0Lj+zMyJPthess7HQU/Udg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uEmPE5q0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759366634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wrFG8VRkzrSlM7VOMmYiWOuM4PK9dJCri8aqCE8F94=;
	b=uEmPE5q0dFsCy6Gma6Ar8+GXn+O3ooVHTxHTlC2RY5pMkFTo6o5fxG0tvoDJ+qRcCQYf7G
	04VzWZs18b3zmCvfoSCyq+D6JVBLkaIyfMGTgCFgoaOa1fLj/B25mpuBVWZrom1te3GBOM
	tRNZWS83A0Lj+zMyJPthess7HQU/Udg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76F0613A42;
	Thu,  2 Oct 2025 00:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6MkIDunN3WgxVgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 02 Oct 2025 00:57:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2 2/3] btrfs/192 btrfs/30[456]: explicitly specify block size to avoid false alerts
Date: Thu,  2 Oct 2025 10:26:47 +0930
Message-ID: <20251002005648.47021-3-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251002005648.47021-1-wqu@suse.com>
References: <20251002005648.47021-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C69E81F7FD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

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

Reviewed-by: Zorro Lang <zlang@redhat.com>
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


