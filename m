Return-Path: <linux-btrfs+bounces-3990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A66989A77B
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 00:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C3B1F2208E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 22:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664CB33080;
	Fri,  5 Apr 2024 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GJAggg4h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GJAggg4h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7098493;
	Fri,  5 Apr 2024 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357933; cv=none; b=N36GRKSw2DSmFh6n5YgNsFQk0ucs8ru/Y4/n+/jOrnLggXnkOqz7it0cMEOEQIrBiFuFZ542/k9NjaG35qjWhVs12XmF+CKJYcxt/8wnif0G9vPHOnyhPAJ3xm8kPSSRJPNZ66ZslrwHGjAZHvbGJEehJPuxBYrzLBRxtaa5MhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357933; c=relaxed/simple;
	bh=Zq2ZzXIRTa+xobQCBwy1nrjeX2AHEvtOYOcBpfQuJkE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=V7nR8A2xUtzXEUg5aOMQRM8f5rPWd3sShzQSCXRcwH4d3MDDewbDStpg+jQVebeqiNB9ibHis9XDk9VSrZy8VIt/GUIsiGUqEqy67V6U/baJnnoFnUB20WmvkDNcsghueVjPfdxSJLm3dWoE66wqfQlbU+zyualxHTJfXlb2KLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GJAggg4h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GJAggg4h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FE6A1F79C;
	Fri,  5 Apr 2024 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712357928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=p69uUv2mW1Mp7hHdAhCj+oWdSjxS/Aq5GjLd4egksPw=;
	b=GJAggg4hYL6c3BGdh0a1nWBMHy6gdSzCs2OXFyZ3yOqDKQPGbDp5Ep1hCcRLtLgFvD3iMS
	IM2bf8tXjoyVIWI2mXxNZ6Jg88IjtXK2Y1IOIUpqHULZ+pV/RrFn/StYYKYY6l7g1+srjr
	CZIz0RO44EMUra2Q3cPwLODxPFeaFM8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GJAggg4h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712357928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=p69uUv2mW1Mp7hHdAhCj+oWdSjxS/Aq5GjLd4egksPw=;
	b=GJAggg4hYL6c3BGdh0a1nWBMHy6gdSzCs2OXFyZ3yOqDKQPGbDp5Ep1hCcRLtLgFvD3iMS
	IM2bf8tXjoyVIWI2mXxNZ6Jg88IjtXK2Y1IOIUpqHULZ+pV/RrFn/StYYKYY6l7g1+srjr
	CZIz0RO44EMUra2Q3cPwLODxPFeaFM8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C0756139E8;
	Fri,  5 Apr 2024 22:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WXTPHCaCEGYPWQAAn2gu4w
	(envelope-from <wqu@suse.com>); Fri, 05 Apr 2024 22:58:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: redirect stdout of "btrfs subvolume snapshot" to fix output change
Date: Sat,  6 Apr 2024 09:28:24 +1030
Message-ID: <20240405225824.8230-1-wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3FE6A1F79C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]

[BUG]
All the touched test cases would fail after btrfs-progs commit
5f87b467a9e7 ("btrfs-progs: subvolume: output the prompt line only when
the ioctl succeeded") due to golden output mismatch.

[CAUSE]
Although the patch I sent to the mail list doesn't change the output at
all but only a timing change, David uses this patch to unify the output
of "btrfs subvolume create" and "btrfs subvolume snapshot".

Unfortunately this changes the output and causes mismatch with
golden output.

[FIX]
Just redirect stdout of "btrfs subvolume snapshot" to $seqres.full.
Any error from "btrfs subvolume" subgroup would lead to error messages
into stderr, and cause golden output mismatch.

This can be comprehensively greped by
'grep -IR "Create a" tests/btrfs/*.out' command.

In fact, we have around 274 "btrfs subvolume snapshot|create" calls in the
existing test cases, meanwhile only around 61 calls are populating
golden output (22 for subvolume creation, and 39 for snapshot creation).

Thus majority of the snapshot/subvolume creation is not populating
golden output already.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This is just a quick fix for the test failures, if accepted, further
cleanup would be done for unnecessary golden output for "btrfs
subvolume" subgroup.
---
 tests/btrfs/001     | 2 +-
 tests/btrfs/001.out | 1 -
 tests/btrfs/152     | 6 +++---
 tests/btrfs/152.out | 2 --
 tests/btrfs/168     | 4 ++--
 tests/btrfs/168.out | 2 --
 tests/btrfs/169     | 6 +++---
 tests/btrfs/169.out | 2 --
 tests/btrfs/170     | 3 +--
 tests/btrfs/170.out | 1 -
 tests/btrfs/187     | 5 +++--
 tests/btrfs/187.out | 3 +--
 tests/btrfs/188     | 6 +++---
 tests/btrfs/188.out | 2 --
 tests/btrfs/189     | 9 +++++----
 tests/btrfs/189.out | 2 --
 tests/btrfs/191     | 4 ++--
 tests/btrfs/191.out | 2 --
 tests/btrfs/200     | 8 ++++----
 tests/btrfs/200.out | 2 --
 tests/btrfs/202     | 2 +-
 tests/btrfs/202.out | 1 -
 tests/btrfs/203     | 8 ++++----
 tests/btrfs/203.out | 2 --
 tests/btrfs/208.out | 6 ------
 tests/btrfs/226     | 2 +-
 tests/btrfs/226.out | 1 -
 tests/btrfs/276     | 2 +-
 tests/btrfs/276.out | 1 -
 tests/btrfs/280     | 3 ++-
 tests/btrfs/280.out | 1 -
 tests/btrfs/281     | 2 +-
 tests/btrfs/281.out | 1 -
 tests/btrfs/283     | 2 +-
 tests/btrfs/283.out | 1 -
 tests/btrfs/287     | 4 ++--
 tests/btrfs/287.out | 2 --
 tests/btrfs/293     | 6 ++++--
 tests/btrfs/293.out | 2 --
 tests/btrfs/300     | 2 +-
 tests/btrfs/300.out | 1 -
 tests/btrfs/302     | 2 +-
 tests/btrfs/302.out | 1 -
 tests/btrfs/314     | 2 +-
 tests/btrfs/314.out | 2 --
 45 files changed, 48 insertions(+), 83 deletions(-)

diff --git a/tests/btrfs/001 b/tests/btrfs/001
index 6c263999..7d79c454 100755
--- a/tests/btrfs/001
+++ b/tests/btrfs/001
@@ -26,7 +26,7 @@ dd if=/dev/zero of=$SCRATCH_MNT/foo bs=1M count=1 &> /dev/null
 echo "List root dir"
 ls $SCRATCH_MNT
 echo "Creating snapshot of root dir"
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap >> $seqres.full
 echo "List root dir after snapshot"
 ls $SCRATCH_MNT
 echo "List snapshot dir"
diff --git a/tests/btrfs/001.out b/tests/btrfs/001.out
index c782bde9..9b493fab 100644
--- a/tests/btrfs/001.out
+++ b/tests/btrfs/001.out
@@ -3,7 +3,6 @@ Creating file foo in root dir
 List root dir
 foo
 Creating snapshot of root dir
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 List root dir after snapshot
 foo
 snap
diff --git a/tests/btrfs/152 b/tests/btrfs/152
index 75f576c3..d26cd77a 100755
--- a/tests/btrfs/152
+++ b/tests/btrfs/152
@@ -32,12 +32,12 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
 
 # Create base snapshots and send them
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
-	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
+	$SCRATCH_MNT/subvol1/.snapshots/1 >> $seqres.full
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
-	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
+	$SCRATCH_MNT/subvol2/.snapshots/1 >> $seqres.full
 for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
 	$BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2> /dev/null | \
-		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} | _filter_scratch
+		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} >> $seqres.full
 done
 
 # Now do 10 loops of concurrent incremental send/receives
diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
index a95bb579..33dd36e8 100644
--- a/tests/btrfs/152.out
+++ b/tests/btrfs/152.out
@@ -5,8 +5,6 @@ Create subvolume 'SCRATCH_MNT/recv1_1'
 Create subvolume 'SCRATCH_MNT/recv1_2'
 Create subvolume 'SCRATCH_MNT/recv2_1'
 Create subvolume 'SCRATCH_MNT/recv2_2'
-Create a readonly snapshot of 'SCRATCH_MNT/subvol1' in 'SCRATCH_MNT/subvol1/.snapshots/1'
-Create a readonly snapshot of 'SCRATCH_MNT/subvol2' in 'SCRATCH_MNT/subvol2/.snapshots/1'
 At subvol 1
 At subvol 1
 At subvol 1
diff --git a/tests/btrfs/168 b/tests/btrfs/168
index acc58b51..97d00ba9 100755
--- a/tests/btrfs/168
+++ b/tests/btrfs/168
@@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro false
 # Create a snapshot of the subvolume, to be used later as the parent snapshot
 # for an incremental send operation.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap1 \
-	| _filter_scratch
+	>> $seqres.full
 
 # First do a full send of this snapshot.
 $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
@@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K" $SCRATCH_MNT/sv1/baz >>$seqres.full
 # Create a second snapshot of the subvolume, to be used later as the send
 # snapshot of an incremental send operation.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap2 \
-	| _filter_scratch
+	>> $seqres.full
 
 # Temporarily turn the second snapshot to read-write mode and then open a file
 # descriptor on its foo file.
diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
index 6cfce8cd..f7eca2d7 100644
--- a/tests/btrfs/168.out
+++ b/tests/btrfs/168.out
@@ -1,9 +1,7 @@
 QA output created by 168
 Create subvolume 'SCRATCH_MNT/sv1'
 At subvol SCRATCH_MNT/sv1
-Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap1'
 At subvol SCRATCH_MNT/snap1
-Create a readonly snapshot of 'SCRATCH_MNT/sv1' in 'SCRATCH_MNT/snap2'
 At subvol SCRATCH_MNT/snap2
 At subvol sv1
 OK
diff --git a/tests/btrfs/169 b/tests/btrfs/169
index 009fdaee..c215f281 100755
--- a/tests/btrfs/169
+++ b/tests/btrfs/169
@@ -43,8 +43,8 @@ $XFS_IO_PROG -f -c "falloc -k 0 4M" \
 	     -c "pwrite -S 0xea 0 1M" \
 	     $SCRATCH_MNT/foobar | _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 2>&1 \
-	| _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
+	>> $seqres.full
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
     | _filter_scratch
 
@@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
 $XFS_IO_PROG -c "fpunch 1M 2M" $SCRATCH_MNT/foobar
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 2>&1 \
-	| _filter_scratch
+	>> $seqres.full
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
 		 $SCRATCH_MNT/snap2 2>&1 | _filter_scratch
 
diff --git a/tests/btrfs/169.out b/tests/btrfs/169.out
index ba77bf0a..a6df713a 100644
--- a/tests/btrfs/169.out
+++ b/tests/btrfs/169.out
@@ -1,9 +1,7 @@
 QA output created by 169
 wrote 1048576/1048576 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
 At subvol SCRATCH_MNT/snap1
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
 At subvol SCRATCH_MNT/snap2
 File digest in the original filesystem:
 d31659e82e87798acd4669a1e0a19d4f  SCRATCH_MNT/snap2/foobar
diff --git a/tests/btrfs/170 b/tests/btrfs/170
index ab105d36..29a15162 100755
--- a/tests/btrfs/170
+++ b/tests/btrfs/170
@@ -45,8 +45,7 @@ echo "File digest after write:"
 md5sum $SCRATCH_MNT/foobar | _filter_scratch
 
 # Create a snapshot of the subvolume where our file is.
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap 2>&1 \
-	| _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap 2>&1 >> $seqres.full
 
 # Cleanly unmount the filesystem.
 _scratch_unmount
diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
index 4c5fd87a..8ad959f3 100644
--- a/tests/btrfs/170.out
+++ b/tests/btrfs/170.out
@@ -3,6 +3,5 @@ wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File digest after write:
 85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 File digest after mounting the filesystem again:
 85054e9e74bc3ae186d693890106b71f  SCRATCH_MNT/foobar
diff --git a/tests/btrfs/187 b/tests/btrfs/187
index d3cf05a1..86c411b6 100755
--- a/tests/btrfs/187
+++ b/tests/btrfs/187
@@ -152,7 +152,7 @@ done
 wait ${create_pids[@]}
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
-	| _filter_scratch
+	>> $seqres.full
 
 # Add some more files, so that that are substantial differences between the
 # two test snapshots used for an incremental send later.
@@ -184,7 +184,7 @@ done
 wait ${setxattr_pids[@]}
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
-	| _filter_scratch
+	>> $seqres.full
 
 full_send_loop 5 &
 full_send_pid=$!
@@ -221,5 +221,6 @@ wait $balance_pid
 #
 _dmesg_since_test_start | grep -E -e '\bBTRFS error \(device .*?\):'
 
+echo "Silence is golden"
 status=0
 exit
diff --git a/tests/btrfs/187.out b/tests/btrfs/187.out
index ab522cfe..331a07c6 100644
--- a/tests/btrfs/187.out
+++ b/tests/btrfs/187.out
@@ -1,3 +1,2 @@
 QA output created by 187
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
+Silence is golden
diff --git a/tests/btrfs/188 b/tests/btrfs/188
index fcaf84b1..1578095a 100755
--- a/tests/btrfs/188
+++ b/tests/btrfs/188
@@ -44,8 +44,8 @@ _scratch_mount
 $XFS_IO_PROG -f -c "pwrite -S 0xab 0 500K" $SCRATCH_MNT/foobar | _filter_xfs_io
 $XFS_IO_PROG -c "falloc -k 1200K 800K" $SCRATCH_MNT/foobar
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base \
+	>> $seqres.full
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
@@ -54,7 +54,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 $XFS_IO_PROG -c "fpunch 0 500K" $SCRATCH_MNT/foobar
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+	>> $seqres.full
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
index 260988e6..99eb3133 100644
--- a/tests/btrfs/188.out
+++ b/tests/btrfs/188.out
@@ -1,9 +1,7 @@
 QA output created by 188
 wrote 512000/512000 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
 At subvol SCRATCH_MNT/base
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
 At subvol SCRATCH_MNT/incr
 File digest in the original filesystem:
 816df6f64deba63b029ca19d880ee10a  SCRATCH_MNT/incr/foobar
diff --git a/tests/btrfs/189 b/tests/btrfs/189
index ec6e56fa..618de266 100755
--- a/tests/btrfs/189
+++ b/tests/btrfs/189
@@ -45,8 +45,9 @@ $XFS_IO_PROG -f -c "pwrite -S 0xc7 0 2M" $SCRATCH_MNT/bar | _filter_xfs_io
 $XFS_IO_PROG -f -c "pwrite -S 0x4d 0 2M" $SCRATCH_MNT/baz | _filter_xfs_io
 $XFS_IO_PROG -f -c "pwrite -S 0xe2 0 2M" $SCRATCH_MNT/zoo | _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base \
+	>> $seqres.full
+
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
@@ -70,8 +71,8 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1600K 0 128K" $SCRATCH_MNT/zoo \
 # operations.
 $XFS_IO_PROG -c "truncate 710K" $SCRATCH_MNT/bar
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr \
+	>> $seqres.full
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
index 79c70b03..b4984d37 100644
--- a/tests/btrfs/189.out
+++ b/tests/btrfs/189.out
@@ -7,13 +7,11 @@ wrote 2097152/2097152 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
 At subvol SCRATCH_MNT/base
 linked 131072/131072 bytes at offset 655360
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 linked 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
 At subvol SCRATCH_MNT/incr
 At subvol base
 At snapshot incr
diff --git a/tests/btrfs/191 b/tests/btrfs/191
index 3c565d0a..c01abb5a 100755
--- a/tests/btrfs/191
+++ b/tests/btrfs/191
@@ -44,7 +44,7 @@ $XFS_IO_PROG -c "pwrite -S 0xb8 512K 512K" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Create the base snapshot and the parent send stream from it.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1 \
-	| _filter_scratch
+	>> $seqres.full
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1 2>&1 \
 	| _filter_scratch
@@ -55,7 +55,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xb8 0 1M" $SCRATCH_MNT/bar | _filter_xfs_io
 # Create the second snapshot, used for the incremental send, before doing the
 # file deduplication.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2 \
-	| _filter_scratch
+	>> $seqres.full
 
 # Now before creating the incremental send stream:
 #
diff --git a/tests/btrfs/191.out b/tests/btrfs/191.out
index 4269803c..471c05da 100644
--- a/tests/btrfs/191.out
+++ b/tests/btrfs/191.out
@@ -3,11 +3,9 @@ wrote 524288/524288 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 524288/524288 bytes at offset 524288
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
 At subvol SCRATCH_MNT/mysnap1
 wrote 1048576/1048576 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
 deduped 524288/524288 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 deduped 524288/524288 bytes at offset 524288
diff --git a/tests/btrfs/200 b/tests/btrfs/200
index 5ce3775f..520e7f21 100755
--- a/tests/btrfs/200
+++ b/tests/btrfs/200
@@ -51,8 +51,8 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
 $XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base \
+	>> $seqres.full
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
@@ -63,8 +63,8 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr \
+	>> $seqres.full
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
index 3eec567e..306d9b24 100644
--- a/tests/btrfs/200.out
+++ b/tests/btrfs/200.out
@@ -5,11 +5,9 @@ linked 65536/65536 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
 At subvol SCRATCH_MNT/base
 linked 65536/65536 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
 At subvol SCRATCH_MNT/incr
 At subvol base
 At snapshot incr
diff --git a/tests/btrfs/202 b/tests/btrfs/202
index 5f0429f1..1c8c5647 100755
--- a/tests/btrfs/202
+++ b/tests/btrfs/202
@@ -28,7 +28,7 @@ _scratch_mount
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
-	| _filter_scratch
+	>> $seqres.full
 
 # Need the dummy entry created so that we get the invalid removal when we rmdir
 ls $SCRATCH_MNT/c/b
diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
index 7f33d49f..28d52e3f 100644
--- a/tests/btrfs/202.out
+++ b/tests/btrfs/202.out
@@ -1,4 +1,3 @@
 QA output created by 202
 Create subvolume 'SCRATCH_MNT/a'
 Create subvolume 'SCRATCH_MNT/a/b'
-Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
diff --git a/tests/btrfs/203 b/tests/btrfs/203
index e506118e..e4ec533f 100755
--- a/tests/btrfs/203
+++ b/tests/btrfs/203
@@ -43,8 +43,8 @@ _scratch_mount
 # file in the parent snapshot.
 $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 64K" $SCRATCH_MNT/foobar | _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base \
+	>> $seqres.full
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
@@ -69,8 +69,8 @@ $XFS_IO_PROG -c "pwrite -S 0xab 512K 64K" \
 	     -c "reflink $SCRATCH_MNT/foobar 448K 192K 192K" \
 	     $SCRATCH_MNT/foobar | _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr \
+	>> $seqres.full
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 		 $SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
index 58739a98..67ec1bd7 100644
--- a/tests/btrfs/203.out
+++ b/tests/btrfs/203.out
@@ -1,7 +1,6 @@
 QA output created by 203
 wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
 At subvol SCRATCH_MNT/base
 wrote 65536/65536 bytes at offset 524288
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -15,7 +14,6 @@ wrote 65536/65536 bytes at offset 786432
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 linked 196608/196608 bytes at offset 196608
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
 At subvol SCRATCH_MNT/incr
 File foobar digest in the original filesystem:
 2b76b23b62fdbbbcae1ee37eec84fd7d
diff --git a/tests/btrfs/208.out b/tests/btrfs/208.out
index dc5761ba..d8f2b31a 100644
--- a/tests/btrfs/208.out
+++ b/tests/btrfs/208.out
@@ -1,17 +1,11 @@
 QA output created by 208
-Create subvolume 'SCRATCH_MNT/subvol1'
-Create subvolume 'SCRATCH_MNT/subvol2'
-Create subvolume 'SCRATCH_MNT/subvol3'
 Current subvolume ids:
 subvol1
 subvol2
 subvol3
-Delete subvolume 'SCRATCH_MNT/subvol1'
 After deleting one subvolume:
 subvol2
 subvol3
-Delete subvolume 'SCRATCH_MNT/subvol3'
 Last remaining subvolume:
 subvol2
-Delete subvolume 'SCRATCH_MNT/subvol2'
 All subvolumes removed.
diff --git a/tests/btrfs/226 b/tests/btrfs/226
index 7034fcc7..017ff479 100755
--- a/tests/btrfs/226
+++ b/tests/btrfs/226
@@ -51,7 +51,7 @@ $XFS_IO_PROG -s -c "pwrite -S 0xab 0 64K" \
 	     $SCRATCH_MNT/f2 | _filter_xfs_io
 
 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap \
-    | _filter_scratch
+	>> $seqres.full
 
 # Write into the range of the first extent so that that range no longer has a
 # shared extent.
diff --git a/tests/btrfs/226.out b/tests/btrfs/226.out
index c63982b0..815217ac 100644
--- a/tests/btrfs/226.out
+++ b/tests/btrfs/226.out
@@ -13,7 +13,6 @@ wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 pwrite: Resource temporarily unavailable
diff --git a/tests/btrfs/276 b/tests/btrfs/276
index f15f2082..b484d20e 100755
--- a/tests/btrfs/276
+++ b/tests/btrfs/276
@@ -105,7 +105,7 @@ sync
 echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
 
 # Creating a snapshot.
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap >> $seqres.full
 
 # We have a snapshot, so now all extents should be reported as shared.
 echo "Number of shared extents in the whole file: $(count_shared_extents)"
diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
index 352e06b4..e30ca188 100644
--- a/tests/btrfs/276.out
+++ b/tests/btrfs/276.out
@@ -1,6 +1,5 @@
 QA output created by 276
 Number of non-shared extents in the whole file: 2000
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 Number of shared extents in the whole file: 2000
 wrote 65536/65536 bytes at offset 524288
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/280 b/tests/btrfs/280
index fc049adb..41d3caa7 100755
--- a/tests/btrfs/280
+++ b/tests/btrfs/280
@@ -37,7 +37,8 @@ _scratch_mount -o compress
 $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Create a RW snapshot of the default subvolume.
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap \
+	>> $seqres.full
 
 echo
 echo "File foo fiemap before COWing extent:"
diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
index 5371f3b0..c5ecf688 100644
--- a/tests/btrfs/280.out
+++ b/tests/btrfs/280.out
@@ -1,7 +1,6 @@
 QA output created by 280
 wrote 134217728/134217728 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 
 File foo fiemap before COWing extent:
 
diff --git a/tests/btrfs/281 b/tests/btrfs/281
index ddc7d9e8..c9efeb67 100755
--- a/tests/btrfs/281
+++ b/tests/btrfs/281
@@ -53,7 +53,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 0 64K" $SCRATCH_MNT/foo \
 
 echo "Creating snapshot and a send stream for it..."
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
-	| _filter_scratch
+	>> $seqres.full
 $BTRFS_UTIL_PROG send --compressed-data -f $send_stream $SCRATCH_MNT/snap 2>&1 \
 	| _filter_scratch
 
diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
index 2585e3e5..0b775689 100644
--- a/tests/btrfs/281.out
+++ b/tests/btrfs/281.out
@@ -6,7 +6,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 linked 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Creating snapshot and a send stream for it...
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 At subvol SCRATCH_MNT/snap
 Creating a new filesystem to receive the send stream...
 At subvol snap
diff --git a/tests/btrfs/283 b/tests/btrfs/283
index 118df08b..2ddd95bc 100755
--- a/tests/btrfs/283
+++ b/tests/btrfs/283
@@ -58,7 +58,7 @@ $XFS_IO_PROG -c "pwrite -S 0xcd -b 64K 64K 64K" $SCRATCH_MNT/foo | _filter_xfs_i
 
 echo "Creating snapshot and a send stream for it..."
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
-	| _filter_scratch
+	>> $seqres.full
 
 $BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap 2>&1 | _filter_scratch
 
diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
index 286dae33..7c7d9f73 100644
--- a/tests/btrfs/283.out
+++ b/tests/btrfs/283.out
@@ -4,7 +4,6 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Creating snapshot and a send stream for it...
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 At subvol SCRATCH_MNT/snap
 Creating a new filesystem to receive the send stream...
 At subvol snap
diff --git a/tests/btrfs/287 b/tests/btrfs/287
index 64e6ef35..33f4a341 100755
--- a/tests/btrfs/287
+++ b/tests/btrfs/287
@@ -112,9 +112,9 @@ query_logical_ino -o $bytenr
 
 # Now create two snapshots and then do some queries.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
-	| _filter_scratch
+	>> $seqres.full
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
-	| _filter_scratch
+	>> $seqres.full
 
 snap1_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap1)
 snap2_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap2)
diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
index 30eac8fa..4814594f 100644
--- a/tests/btrfs/287.out
+++ b/tests/btrfs/287.out
@@ -41,8 +41,6 @@ resolve first extent +3M offset with ignore offset option:
 inode 257 offset 16777216 root 5
 inode 257 offset 8388608 root 5
 inode 257 offset 2097152 root 5
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
 resolve first extent:
 inode 257 offset 16777216 snap2
 inode 257 offset 8388608 snap2
diff --git a/tests/btrfs/293 b/tests/btrfs/293
index 06f96dc4..a6bd68e6 100755
--- a/tests/btrfs/293
+++ b/tests/btrfs/293
@@ -32,9 +32,11 @@ swap_file="$SCRATCH_MNT/swapfile"
 _format_swapfile $swap_file $(($(_get_page_size) * 64)) >> $seqres.full
 
 echo "Creating first snapshot..."
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
+	>> $seqres.full
 echo "Creating second snapshot..."
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 \
+	>> $seqres.full
 
 echo "Activating swap file... (should fail due to snapshots)"
 _swapon_file $swap_file 2>&1 | _filter_scratch
diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
index fd04ac91..5da7accc 100644
--- a/tests/btrfs/293.out
+++ b/tests/btrfs/293.out
@@ -1,8 +1,6 @@
 QA output created by 293
 Creating first snapshot...
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
 Creating second snapshot...
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
 Activating swap file... (should fail due to snapshots)
 swapon: SCRATCH_MNT/swapfile: swapon failed: Invalid argument
 Deleting first snapshot...
diff --git a/tests/btrfs/300 b/tests/btrfs/300
index 8a0eaecf..4ea22a01 100755
--- a/tests/btrfs/300
+++ b/tests/btrfs/300
@@ -43,7 +43,7 @@ $BTRFS_UTIL_PROG subvolume create subvol;
 touch subvol/{1,2,3};
 $BTRFS_UTIL_PROG subvolume create subvol/subsubvol;
 touch subvol/subsubvol/{4,5,6};
-$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot;
+$BTRFS_UTIL_PROG subvolume snapshot subvol snapshot > /dev/null;
 "
 
 find $test_dir/. -printf "%M %u %g ./%P\n"
diff --git a/tests/btrfs/300.out b/tests/btrfs/300.out
index 6e94447e..8611f606 100644
--- a/tests/btrfs/300.out
+++ b/tests/btrfs/300.out
@@ -1,7 +1,6 @@
 QA output created by 300
 Create subvolume './subvol'
 Create subvolume 'subvol/subsubvol'
-Create a snapshot of 'subvol' in './snapshot'
 drwxr-xr-x fsgqa fsgqa ./
 drwxr-xr-x fsgqa fsgqa ./subvol
 -rw-r--r-- fsgqa fsgqa ./subvol/1
diff --git a/tests/btrfs/302 b/tests/btrfs/302
index f3e6044b..5dcd5295 100755
--- a/tests/btrfs/302
+++ b/tests/btrfs/302
@@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
 # Now create a snapshot of the subvolume and make it accessible from within the
 # subvolume.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
-		 $SCRATCH_MNT/subvol/snap | _filter_scratch
+		 $SCRATCH_MNT/subvol/snap >> $seqres.full
 
 # Now unmount and mount again the fs. We want to verify we are able to read all
 # metadata for the snapshot from disk (no IO failures, etc).
diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
index 8770aefc..e89d1297 100644
--- a/tests/btrfs/302.out
+++ b/tests/btrfs/302.out
@@ -1,4 +1,3 @@
 QA output created by 302
 Create subvolume 'SCRATCH_MNT/subvol'
-Create a readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol/snap'
 OK
diff --git a/tests/btrfs/314 b/tests/btrfs/314
index 887cb69e..719a930a 100755
--- a/tests/btrfs/314
+++ b/tests/btrfs/314
@@ -43,7 +43,7 @@ send_receive_tempfsid()
 
 	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
 	$BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
-						_filter_testdir_and_scratch
+		>> $seqres.full
 
 	echo Send ${src} | _filter_testdir_and_scratch
 	$BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
index 21963899..8a311671 100644
--- a/tests/btrfs/314.out
+++ b/tests/btrfs/314.out
@@ -3,7 +3,6 @@ QA output created by 314
 From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
 wrote 9000/9000 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
 Send SCRATCH_MNT
 At subvol SCRATCH_MNT/snap1
 Receive TEST_DIR/314/tempfsid_mnt
@@ -14,7 +13,6 @@ Recv:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/snap1/foo
 From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
 wrote 9000/9000 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/314/tempfsid_mnt/snap1'
 Send TEST_DIR/314/tempfsid_mnt
 At subvol TEST_DIR/314/tempfsid_mnt/snap1
 Receive SCRATCH_MNT
-- 
2.44.0


