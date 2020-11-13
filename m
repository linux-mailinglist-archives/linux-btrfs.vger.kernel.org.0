Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F245F2B19F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 12:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKMLV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 06:21:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKMLV6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 06:21:58 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F5C8207DE
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605266512;
        bh=qSx0ILCsgcLd4HfUcTqkgNgvWu2vdBFzBqvC1M8+VnE=;
        h=From:To:Subject:Date:From;
        b=H6yZQknyBj4ICPlr2iY+FV13CWAdmZIz3j8np96SkfBzrmsXR4hRjZQtQRfsB6yfi
         8Q5QBwxsssaDv01TgiyV3RFPxPT0axLmXGcRddNwD9LG7HosE6OiVV5ZQ9XkEdI+6p
         99Fg9st434s5UblcH4W0zLWOzOY5+GRRwG9Ogmvk=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: skip unnecessary searches for xattrs when logging an inode
Date:   Fri, 13 Nov 2020 11:21:49 +0000
Message-Id: <eb0d75e48d9dcc438cc618e0a47be8e299e22649.1605266359.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Every time we log an inode we lookup in the fs/subvol tree for xattrs and
if we have any, log them into the log tree. However it is very common to
have inodes without any xattrs, so doing the search wastes times, but more
importanly it adds contention on the fs/subvol tree locks, either making
the logging code block and wait for tree locks or making the logging code
making other concurrent operations block and wait.

The most typical use cases where xattrs are used are when capabilities or
ACLs are defined for an inode, or when SELinux is enabled.

This change makes the logging code detect when an inode does not have
xattrs and skip the xattrs search the next time the inode is logged,
unless the inode is evicted and loaded again or a xattr is added to the
inode. Therefore skipping the search for xattrs on inodes that don't ever
have xattrs and are fsynced with some frequency.

The following script that calls dbench was used to measure the impact of
this change on a VM with 8 cpus, 16Gb of ram, using a raw NVMe device
directly (no intermediary filesystem on the host) and using a non-debug
kernel (default configuration on Debian distributions):

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdk
  MNT=/mnt/sdk
  MOUNT_OPTIONS="-o ssd"

  mkfs.btrfs -f -m single -d single $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  dbench -D $MNT -t 200 40

  umount $MNT

The results before this change:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    5761605     0.172   312.057
 Close        4232452     0.002    10.927
 Rename        243937     1.406   277.344
 Unlink       1163456     0.631   298.402
 Deltree          160    11.581   221.107
 Mkdir             80     0.003     0.005
 Qpathinfo    5221410     0.065   122.309
 Qfileinfo     915432     0.001     3.333
 Qfsinfo       957555     0.003     3.992
 Sfileinfo     469244     0.023    20.494
 Find         2018865     0.448   123.659
 WriteX       2874851     0.049   118.529
 ReadX        9030579     0.004    21.654
 LockX          18754     0.003     4.423
 UnlockX        18754     0.002     0.331
 Flush         403792    10.944   359.494

Throughput 908.444 MB/sec  40 clients  40 procs  max_latency=359.500 ms

The results after this change:

 Operation      Count    AvgLat    MaxLat
 ----------------------------------------
 NTCreateX    6442521     0.159   230.693
 Close        4732357     0.002    10.972
 Rename        272809     1.293   227.398
 Unlink       1301059     0.563   218.500
 Deltree          160     7.796    54.887
 Mkdir             80     0.008     0.478
 Qpathinfo    5839452     0.047   124.330
 Qfileinfo    1023199     0.001     4.996
 Qfsinfo      1070760     0.003     5.709
 Sfileinfo     524790     0.033    21.765
 Find         2257658     0.314   125.611
 WriteX       3211520     0.040   232.135
 ReadX        10098969     0.004    25.340
 LockX          20974     0.003     1.569
 UnlockX        20974     0.002     3.475
 Flush         451553    10.287   331.037

Throughput 1011.77 MB/sec  40 clients  40 procs  max_latency=331.045 ms

+10.8% throughput, -8.2% max latency

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 7 +++++++
 fs/btrfs/tree-log.c    | 8 ++++++++
 fs/btrfs/xattr.c       | 4 +++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 34f5fc318fc1..e135a71ec179 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -35,6 +35,13 @@ enum {
 	BTRFS_INODE_IN_DELALLOC_LIST,
 	BTRFS_INODE_HAS_PROPS,
 	BTRFS_INODE_SNAPSHOT_FLUSH,
+	/*
+	 * Set and used when logging an inode and it serves to signal that an
+	 * inode does not have xattrs, so subsequent fsyncs can avoid searching
+	 * for xattrs to log. This bit must be cleared whenever a xattr is added
+	 * to an inode.
+	 */
+	BTRFS_INODE_NO_XATTRS,
 };
 
 /* in memory btrfs inode */
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 932a74a236eb..17a08a7bf6cc 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4574,6 +4574,10 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 	const u64 ino = btrfs_ino(inode);
 	int ins_nr = 0;
 	int start_slot = 0;
+	bool found_xattrs = false;
+
+	if (test_bit(BTRFS_INODE_NO_XATTRS, &inode->runtime_flags))
+		return 0;
 
 	key.objectid = ino;
 	key.type = BTRFS_XATTR_ITEM_KEY;
@@ -4612,6 +4616,7 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 			start_slot = slot;
 		ins_nr++;
 		path->slots[0]++;
+		found_xattrs = true;
 		cond_resched();
 	}
 	if (ins_nr > 0) {
@@ -4621,6 +4626,9 @@ static int btrfs_log_all_xattrs(struct btrfs_trans_handle *trans,
 			return ret;
 	}
 
+	if (!found_xattrs)
+		set_bit(BTRFS_INODE_NO_XATTRS, &inode->runtime_flags);
+
 	return 0;
 }
 
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 95d9aebff2c4..e51774201d53 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -213,9 +213,11 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 	}
 out:
 	btrfs_free_path(path);
-	if (!ret)
+	if (!ret) {
 		set_bit(BTRFS_INODE_COPY_EVERYTHING,
 			&BTRFS_I(inode)->runtime_flags);
+		clear_bit(BTRFS_INODE_NO_XATTRS, &BTRFS_I(inode)->runtime_flags);
+	}
 	return ret;
 }
 
-- 
2.28.0

