Return-Path: <linux-btrfs+bounces-4177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF3B8A2540
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 06:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9AC1F2295C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 04:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A28134CC;
	Fri, 12 Apr 2024 04:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oapX8oCM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RFby3H1z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06300D51E;
	Fri, 12 Apr 2024 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896906; cv=none; b=RjZ7bXHgsNVAgnpEQVY+gnxP2RHh9Y8GsXnSECz8KQcKcwZTDyK0eroJnHTU1UPkPFvmpmWI3RJqT8+ZsYv4J15iZUX7EaBlaOXXEKDVqvaageSwxVK5/IW6qTpiFAKVXZJxFPYz7z8j3ZxJOy8j4lxfn3/+3pIjgQ0eGDMCDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896906; c=relaxed/simple;
	bh=PszrNJg+fdAi3VFLwqhrrEUVwtHHArbNKRfyG0fKq5w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s10cPA4k+k8sYgnrhUsIbhIQ4KXs4PzVS5R45lT38m7+c9YgfOmDLzIGJJwDkRr3bF1mEVRLXUTM6al2rzKx7ImYKooryislubL1r3b1QvoASNKQDf+Lg+zKeVlClaPlqqTQnH8SUj6OGoidATbC51bNofJ5Hd+sBsYQInWFBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oapX8oCM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RFby3H1z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9B1637E32;
	Fri, 12 Apr 2024 04:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712896901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szGtdEU+Wv8pzN6GB+yXxT3gtLlzWP8T83f52M6Mf24=;
	b=oapX8oCMTEFVaBLYbW9pWz+BPcuKtrpdAwK+lFpQxI3CEJhGWRzGCU7AlIws08wmmHfCOU
	Pss2xqr9ajjnGxUFhYy3P8197XFR/AlY6lWZ7ah7lKG1Ouhpi/6W12CXB+0q5ylnoYc62t
	UwvYHn5B1sVZQZrwtIrepfXP/jwXiT8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712896900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szGtdEU+Wv8pzN6GB+yXxT3gtLlzWP8T83f52M6Mf24=;
	b=RFby3H1ze6mBq/U0LyQ7zew4q0U80d5y1WVEUO3XGRnFg8DN1DH/DRJg6Gl0PHTSdx30hp
	FTq+XgPT1gJoUuV6NA+F5MJwXHDmkXXuvBqqv/s6KXnx3crZXuNI7V1CbFkIEbEuOqkd2k
	eanQ7YZwE3wt/oRS33hYFsdgH7tXs5Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D763D1368B;
	Fri, 12 Apr 2024 04:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SL+MJYO7GGYcOgAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 12 Apr 2024 04:41:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2 2/2] fstests: btrfs: use _btrfs for 'subvolume snapshot' command
Date: Fri, 12 Apr 2024 14:11:17 +0930
Message-ID: <6dc43e0811a2aa3a632f7dbb616684d5f0d4432e.1712896667.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

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
Just use the recommended way to run simple btrfs command, _btrfs, for
those all "btrfs subvolume snapshot" call sites, and remove the line
from golden output.

The only case not utilizing `_btrfs` is btrfs/300, which utilize
user_do(), which doesn't have the fstests functions.

The "_btrfs()" helper has the following advantages:

- Save the command line arguments and output into $seqres.full
  For easier debugging

- Check the return value of the btrfs command

This would ensure future informative output change would not trigger
such situation any more.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/001     |  2 +-
 tests/btrfs/001.out |  1 -
 tests/btrfs/152     | 14 ++++++--------
 tests/btrfs/152.out |  2 --
 tests/btrfs/168     |  6 ++----
 tests/btrfs/168.out |  2 --
 tests/btrfs/169     |  6 ++----
 tests/btrfs/169.out |  2 --
 tests/btrfs/170     |  3 +--
 tests/btrfs/170.out |  1 -
 tests/btrfs/187     |  6 ++----
 tests/btrfs/187.out |  2 --
 tests/btrfs/188     |  6 ++----
 tests/btrfs/188.out |  2 --
 tests/btrfs/189     |  6 ++----
 tests/btrfs/189.out |  2 --
 tests/btrfs/191     |  6 ++----
 tests/btrfs/191.out |  2 --
 tests/btrfs/200     |  6 ++----
 tests/btrfs/200.out |  2 --
 tests/btrfs/202     |  3 +--
 tests/btrfs/202.out |  1 -
 tests/btrfs/203     |  6 ++----
 tests/btrfs/203.out |  2 --
 tests/btrfs/226     |  3 +--
 tests/btrfs/226.out |  1 -
 tests/btrfs/276     |  2 +-
 tests/btrfs/276.out |  1 -
 tests/btrfs/280     |  2 +-
 tests/btrfs/280.out |  1 -
 tests/btrfs/281     |  3 +--
 tests/btrfs/281.out |  1 -
 tests/btrfs/283     |  3 +--
 tests/btrfs/283.out |  1 -
 tests/btrfs/287     |  6 ++----
 tests/btrfs/287.out |  2 --
 tests/btrfs/293     |  4 ++--
 tests/btrfs/293.out |  2 --
 tests/btrfs/300     |  2 +-
 tests/btrfs/300.out |  1 -
 tests/btrfs/302     |  3 +--
 tests/btrfs/302.out |  1 -
 tests/btrfs/314     |  3 +--
 tests/btrfs/314.out |  2 --
 44 files changed, 37 insertions(+), 98 deletions(-)

diff --git a/tests/btrfs/001 b/tests/btrfs/001
index 6c2639990373..5d2707c7c09d 100755
--- a/tests/btrfs/001
+++ b/tests/btrfs/001
@@ -26,7 +26,7 @@ dd if=/dev/zero of=$SCRATCH_MNT/foo bs=1M count=1 &> /dev/null
 echo "List root dir"
 ls $SCRATCH_MNT
 echo "Creating snapshot of root dir"
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
 echo "List root dir after snapshot"
 ls $SCRATCH_MNT
 echo "List snapshot dir"
diff --git a/tests/btrfs/001.out b/tests/btrfs/001.out
index c782bde96091..9b493fab3891 100644
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
index 75f576c3cfca..63e69d104c68 100755
--- a/tests/btrfs/152
+++ b/tests/btrfs/152
@@ -31,10 +31,8 @@ mkdir $SCRATCH_MNT/subvol{1,2}/.snapshots
 touch $SCRATCH_MNT/subvol{1,2}/foo
 
 # Create base snapshots and send them
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
-	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
-	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT/subvol1 $SCRATCH_MNT/subvol1/.snapshots/1
+_btrfs subvolume snapshot -r $SCRATCH_MNT/subvol2 $SCRATCH_MNT/subvol2/.snapshots/1
 for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
 	$BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2> /dev/null | \
 		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} | _filter_scratch
@@ -45,8 +43,8 @@ for i in `seq 1 10`; do
 	prev=$i
 	curr=$((i+1))
 
-	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
-		$SCRATCH_MNT/subvol1/.snapshots/${curr} > /dev/null
+	_btrfs subvolume snapshot -r $SCRATCH_MNT/subvol1 \
+		$SCRATCH_MNT/subvol1/.snapshots/${curr}
 	($BTRFS_UTIL_PROG send -p $SCRATCH_MNT/subvol1/.snapshots/${prev} \
 		$SCRATCH_MNT/subvol1/.snapshots/${curr} 2> /dev/null | \
 		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv1_1) > /dev/null &
@@ -54,8 +52,8 @@ for i in `seq 1 10`; do
 		$SCRATCH_MNT/subvol1/.snapshots/${curr} 2> /dev/null | \
 		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv1_2) > /dev/null &
 
-	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
-		$SCRATCH_MNT/subvol2/.snapshots/${curr} > /dev/null
+	_btrfs subvolume snapshot -r $SCRATCH_MNT/subvol2 \
+		$SCRATCH_MNT/subvol2/.snapshots/${curr}
 	($BTRFS_UTIL_PROG send -p $SCRATCH_MNT/subvol2/.snapshots/${prev} \
 		$SCRATCH_MNT/subvol2/.snapshots/${curr} 2> /dev/null | \
 		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/recv2_1) > /dev/null &
diff --git a/tests/btrfs/152.out b/tests/btrfs/152.out
index a95bb5797162..33dd36e840e3 100644
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
index acc58b51ee39..994121d49bd0 100755
--- a/tests/btrfs/168
+++ b/tests/btrfs/168
@@ -73,8 +73,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro false
 
 # Create a snapshot of the subvolume, to be used later as the parent snapshot
 # for an incremental send operation.
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap1
 
 # First do a full send of this snapshot.
 $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
@@ -87,8 +86,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K" $SCRATCH_MNT/sv1/baz >>$seqres.full
 
 # Create a second snapshot of the subvolume, to be used later as the send
 # snapshot of an incremental send operation.
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap2 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap2
 
 # Temporarily turn the second snapshot to read-write mode and then open a file
 # descriptor on its foo file.
diff --git a/tests/btrfs/168.out b/tests/btrfs/168.out
index 6cfce8cd666c..f7eca2d7c421 100644
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
index 009fdaee7c46..0570e7ce1aa6 100755
--- a/tests/btrfs/169
+++ b/tests/btrfs/169
@@ -43,8 +43,7 @@ $XFS_IO_PROG -f -c "falloc -k 0 4M" \
 	     -c "pwrite -S 0xea 0 1M" \
 	     $SCRATCH_MNT/foobar | _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
     | _filter_scratch
 
@@ -53,8 +52,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
 # extent we allocated earlier (3Mb < 4Mb).
 $XFS_IO_PROG -c "fpunch 1M 2M" $SCRATCH_MNT/foobar
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
 		 $SCRATCH_MNT/snap2 2>&1 | _filter_scratch
 
diff --git a/tests/btrfs/169.out b/tests/btrfs/169.out
index ba77bf0adbe3..a6df713aceed 100644
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
index ab105d36fb96..4b4569e9c3cd 100755
--- a/tests/btrfs/170
+++ b/tests/btrfs/170
@@ -45,8 +45,7 @@ echo "File digest after write:"
 md5sum $SCRATCH_MNT/foobar | _filter_scratch
 
 # Create a snapshot of the subvolume where our file is.
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
 
 # Cleanly unmount the filesystem.
 _scratch_unmount
diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
index 4c5fd87a8b17..8ad959f31ba2 100644
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
index d3cf05a1bd92..0a6f92b3eb3c 100755
--- a/tests/btrfs/187
+++ b/tests/btrfs/187
@@ -151,8 +151,7 @@ for ((n = 0; n < 4; n++)); do
 done
 wait ${create_pids[@]}
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
 
 # Add some more files, so that that are substantial differences between the
 # two test snapshots used for an incremental send later.
@@ -183,8 +182,7 @@ for ((n = 0; n < 4; n++)); do
 done
 wait ${setxattr_pids[@]}
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
 
 full_send_loop 5 &
 full_send_pid=$!
diff --git a/tests/btrfs/187.out b/tests/btrfs/187.out
index ab522cfe7e8c..8e65c281e8e7 100644
--- a/tests/btrfs/187.out
+++ b/tests/btrfs/187.out
@@ -1,3 +1 @@
 QA output created by 187
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
-Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
diff --git a/tests/btrfs/188 b/tests/btrfs/188
index fcaf84b15053..e09cf1ecfda8 100755
--- a/tests/btrfs/188
+++ b/tests/btrfs/188
@@ -44,8 +44,7 @@ _scratch_mount
 $XFS_IO_PROG -f -c "pwrite -S 0xab 0 500K" $SCRATCH_MNT/foobar | _filter_xfs_io
 $XFS_IO_PROG -c "falloc -k 1200K 800K" $SCRATCH_MNT/foobar
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
@@ -53,8 +52,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 # Now punch a hole that drops all the extents within the file's size.
 $XFS_IO_PROG -c "fpunch 0 500K" $SCRATCH_MNT/foobar
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
index 260988e60084..99eb3133ca0a 100644
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
index ec6e56fa0020..eda280ab82a9 100755
--- a/tests/btrfs/189
+++ b/tests/btrfs/189
@@ -45,8 +45,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xc7 0 2M" $SCRATCH_MNT/bar | _filter_xfs_io
 $XFS_IO_PROG -f -c "pwrite -S 0x4d 0 2M" $SCRATCH_MNT/baz | _filter_xfs_io
 $XFS_IO_PROG -f -c "pwrite -S 0xe2 0 2M" $SCRATCH_MNT/zoo | _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
@@ -70,8 +69,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1600K 0 128K" $SCRATCH_MNT/zoo \
 # operations.
 $XFS_IO_PROG -c "truncate 710K" $SCRATCH_MNT/bar
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
index 79c70b03a1ba..b4984d37cfab 100644
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
index 3c565d0ad209..d15b2313b9c2 100755
--- a/tests/btrfs/191
+++ b/tests/btrfs/191
@@ -43,8 +43,7 @@ $XFS_IO_PROG -f -s -c "pwrite -S 0xb8 -b 64K 0 512K" $SCRATCH_MNT/foo \
 $XFS_IO_PROG -c "pwrite -S 0xb8 512K 512K" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Create the base snapshot and the parent send stream from it.
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1 2>&1 \
 	| _filter_scratch
@@ -54,8 +53,7 @@ $XFS_IO_PROG -f -c "pwrite -S 0xb8 0 1M" $SCRATCH_MNT/bar | _filter_xfs_io
 
 # Create the second snapshot, used for the incremental send, before doing the
 # file deduplication.
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2
 
 # Now before creating the incremental send stream:
 #
diff --git a/tests/btrfs/191.out b/tests/btrfs/191.out
index 4269803cce1e..471c05da4b03 100644
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
index 5ce3775f2222..b32f3139e307 100755
--- a/tests/btrfs/200
+++ b/tests/btrfs/200
@@ -51,8 +51,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
 $XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
@@ -63,8 +62,7 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
index 3eec567e97fe..306d9b24a16c 100644
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
index 5f0429f18bf9..d6077853af22 100755
--- a/tests/btrfs/202
+++ b/tests/btrfs/202
@@ -27,8 +27,7 @@ _scratch_mount
 
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
-	| _filter_scratch
+_btrfs subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c
 
 # Need the dummy entry created so that we get the invalid removal when we rmdir
 ls $SCRATCH_MNT/c/b
diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
index 7f33d49f889c..28d52e3f27c7 100644
--- a/tests/btrfs/202.out
+++ b/tests/btrfs/202.out
@@ -1,4 +1,3 @@
 QA output created by 202
 Create subvolume 'SCRATCH_MNT/a'
 Create subvolume 'SCRATCH_MNT/a/b'
-Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
diff --git a/tests/btrfs/203 b/tests/btrfs/203
index e506118e2cd2..11a34d20ae31 100755
--- a/tests/btrfs/203
+++ b/tests/btrfs/203
@@ -43,8 +43,7 @@ _scratch_mount
 # file in the parent snapshot.
 $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 64K" $SCRATCH_MNT/foobar | _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
 
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 	| _filter_scratch
@@ -69,8 +68,7 @@ $XFS_IO_PROG -c "pwrite -S 0xab 512K 64K" \
 	     -c "reflink $SCRATCH_MNT/foobar 448K 192K 192K" \
 	     $SCRATCH_MNT/foobar | _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1
 
 $BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
 		 $SCRATCH_MNT/incr 2>&1 | _filter_scratch
diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
index 58739a98cd1b..67ec1bd7c13d 100644
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
diff --git a/tests/btrfs/226 b/tests/btrfs/226
index 7034fcc7b2a5..a2bfe9770167 100755
--- a/tests/btrfs/226
+++ b/tests/btrfs/226
@@ -50,8 +50,7 @@ $XFS_IO_PROG -s -c "pwrite -S 0xab 0 64K" \
 	     -c "pwrite -S 0xcd 64K 64K" \
 	     $SCRATCH_MNT/f2 | _filter_xfs_io
 
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap \
-    | _filter_scratch
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
 
 # Write into the range of the first extent so that that range no longer has a
 # shared extent.
diff --git a/tests/btrfs/226.out b/tests/btrfs/226.out
index c63982b0ba4a..815217ac5129 100644
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
index f15f20824350..70dadd93fdd2 100755
--- a/tests/btrfs/276
+++ b/tests/btrfs/276
@@ -105,7 +105,7 @@ sync
 echo "Number of non-shared extents in the whole file: $(count_not_shared_extents)"
 
 # Creating a snapshot.
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
 
 # We have a snapshot, so now all extents should be reported as shared.
 echo "Number of shared extents in the whole file: $(count_shared_extents)"
diff --git a/tests/btrfs/276.out b/tests/btrfs/276.out
index 352e06b4d4b2..e30ca1886adf 100644
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
index fc049adb0b19..d4f613cedc2d 100755
--- a/tests/btrfs/280
+++ b/tests/btrfs/280
@@ -37,7 +37,7 @@ _scratch_mount -o compress
 $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Create a RW snapshot of the default subvolume.
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
 
 echo
 echo "File foo fiemap before COWing extent:"
diff --git a/tests/btrfs/280.out b/tests/btrfs/280.out
index 5371f3b01551..c5ecf6882745 100644
--- a/tests/btrfs/280.out
+++ b/tests/btrfs/280.out
@@ -1,7 +1,6 @@
 QA output created by 280
 wrote 134217728/134217728 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
 
 File foo fiemap before COWing extent:
 
diff --git a/tests/btrfs/281 b/tests/btrfs/281
index ddc7d9e8b06d..290ccaca6235 100755
--- a/tests/btrfs/281
+++ b/tests/btrfs/281
@@ -52,8 +52,7 @@ $XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 0 64K" $SCRATCH_MNT/foo \
 	| _filter_xfs_io
 
 echo "Creating snapshot and a send stream for it..."
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
 $BTRFS_UTIL_PROG send --compressed-data -f $send_stream $SCRATCH_MNT/snap 2>&1 \
 	| _filter_scratch
 
diff --git a/tests/btrfs/281.out b/tests/btrfs/281.out
index 2585e3e567db..0b775689d8c8 100644
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
index 118df08b8958..8fa282ee4145 100755
--- a/tests/btrfs/283
+++ b/tests/btrfs/283
@@ -57,8 +57,7 @@ _cp_reflink $SCRATCH_MNT/foo $SCRATCH_MNT/baz
 $XFS_IO_PROG -c "pwrite -S 0xcd -b 64K 64K 64K" $SCRATCH_MNT/foo | _filter_xfs_io
 
 echo "Creating snapshot and a send stream for it..."
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
 
 $BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap 2>&1 | _filter_scratch
 
diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
index 286dae332eff..7c7d9f730bd4 100644
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
index 64e6ef35250c..24d8e66a7a42 100755
--- a/tests/btrfs/287
+++ b/tests/btrfs/287
@@ -111,10 +111,8 @@ echo "resolve first extent +3M offset with ignore offset option:"
 query_logical_ino -o $bytenr
 
 # Now create two snapshots and then do some queries.
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
-	| _filter_scratch
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
-	| _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
 
 snap1_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap1)
 snap2_id=$(_btrfs_get_subvolid $SCRATCH_MNT snap2)
diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
index 30eac8fa444c..4814594fc224 100644
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
index 06f96dc414b0..09139f195d12 100755
--- a/tests/btrfs/293
+++ b/tests/btrfs/293
@@ -32,9 +32,9 @@ swap_file="$SCRATCH_MNT/swapfile"
 _format_swapfile $swap_file $(($(_get_page_size) * 64)) >> $seqres.full
 
 echo "Creating first snapshot..."
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 | _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
 echo "Creating second snapshot..."
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2 | _filter_scratch
+_btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap2
 
 echo "Activating swap file... (should fail due to snapshots)"
 _swapon_file $swap_file 2>&1 | _filter_scratch
diff --git a/tests/btrfs/293.out b/tests/btrfs/293.out
index fd04ac9139b8..5da7accc9535 100644
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
index 8a0eaecf87f7..4ea22a01c8ec 100755
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
index 6e94447e87ac..8611f606aaf7 100644
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
index f3e6044b5251..3b52892d56ee 100755
--- a/tests/btrfs/302
+++ b/tests/btrfs/302
@@ -45,8 +45,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
 
 # Now create a snapshot of the subvolume and make it accessible from within the
 # subvolume.
-$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
-		 $SCRATCH_MNT/subvol/snap | _filter_scratch
+_btrfs subvolume snapshot -r $SCRATCH_MNT/subvol $SCRATCH_MNT/subvol/snap
 
 # Now unmount and mount again the fs. We want to verify we are able to read all
 # metadata for the snapshot from disk (no IO failures, etc).
diff --git a/tests/btrfs/302.out b/tests/btrfs/302.out
index 8770aefc99c8..e89d12977c62 100644
--- a/tests/btrfs/302.out
+++ b/tests/btrfs/302.out
@@ -1,4 +1,3 @@
 QA output created by 302
 Create subvolume 'SCRATCH_MNT/subvol'
-Create a readonly snapshot of 'SCRATCH_MNT/subvol' in 'SCRATCH_MNT/subvol/snap'
 OK
diff --git a/tests/btrfs/314 b/tests/btrfs/314
index 887cb69eb79c..da594d396ca6 100755
--- a/tests/btrfs/314
+++ b/tests/btrfs/314
@@ -42,8 +42,7 @@ send_receive_tempfsid()
 	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
 
 	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
-	$BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
-						_filter_testdir_and_scratch
+	_btrfs subvolume snapshot -r ${src} ${src}/snap1
 
 	echo Send ${src} | _filter_testdir_and_scratch
 	$BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
index 21963899c2b2..8a311671b8f9 100644
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


