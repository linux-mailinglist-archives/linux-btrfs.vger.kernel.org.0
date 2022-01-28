Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A143A49F4FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 09:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347225AbiA1INX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 03:13:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42758 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347224AbiA1INW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 03:13:22 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 900751F398
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 08:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643357601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTNjWfEc1haLVxVdLyf5t4cffByxA5Xfl7WsNBcyaZA=;
        b=sBWx3I0gurnOIb66PRmgMSGRlfJ+K8hRlkPHdH02GbOaFBlv7v3qmO0JrbtDLS6+zlnlnd
        HZjeBm+g+N4KiIw9R/BFBMsuwA0lHTBwis7FnFmXOUcrw7Co6hLN7mVxgYbOO+9ea4x9dC
        kIwIoV6B+ftEWAhjO81qg5i71rbGoiY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7692139C4
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 08:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6HxGLKCl82FjVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 08:13:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: defrag: allow defrag_one_cluster() to large extent which is not a target
Date:   Fri, 28 Jan 2022 16:12:58 +0800
Message-Id: <fce83045d775e59ab8a6746e5ad09c474a0c90a2.1643357469.git.wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643357469.git.wqu@suse.com>
References: <cover.1643357469.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the rework of btrfs_defrag_file(), we always call
defrag_one_cluster() and increase the offset by cluster size, which is
only 256K.

But there are cases where we have a large extent (e.g. 128M) which
doesn't need to be defragged at all.

Before the refactor, we can directly skip the range, but now we have to
scan that extent map again and again until the cluster moves after the
non-target extent.

Fix the problem by allow defrag_one_cluster() to increase
btrfs_defrag_ctrl::last_scanned to the end of an extent, if and only if
the last extent of the cluster is not a target.

The test script looks like this:

	mkfs.btrfs -f $dev > /dev/null

	mount $dev $mnt

	# As btrfs ioctl uses 32M as extent_threshold
	xfs_io -f -c "pwrite 0 64M" $mnt/file1
	sync
	# Some fragemented range to defrag
	xfs_io -s -c "pwrite 65548k 4k" \
		  -c "pwrite 65544k 4k" \
		  -c "pwrite 65540k 4k" \
		  -c "pwrite 65536k 4k" \
		  $mnt/file1
	sync

	echo "=== before ==="
	xfs_io -c "fiemap -v" $mnt/file1
	echo "=== after ==="
	btrfs fi defrag $mnt/file1
	sync
	xfs_io -c "fiemap -v" $mnt/file1
	umount $mnt

With extra ftrace put into defrag_one_cluster(), before the patch it
would result tons of loops:

(As defrag_one_cluster() is inlined, the function name is its caller)

  btrfs-126062  [005] .....  4682.816026: btrfs_defrag_file: r/i=5/257 start=0 len=262144
  btrfs-126062  [005] .....  4682.816027: btrfs_defrag_file: r/i=5/257 start=262144 len=262144
  btrfs-126062  [005] .....  4682.816028: btrfs_defrag_file: r/i=5/257 start=524288 len=262144
  btrfs-126062  [005] .....  4682.816028: btrfs_defrag_file: r/i=5/257 start=786432 len=262144
  btrfs-126062  [005] .....  4682.816028: btrfs_defrag_file: r/i=5/257 start=1048576 len=262144
  ...
  btrfs-126062  [005] .....  4682.816043: btrfs_defrag_file: r/i=5/257 start=67108864 len=262144

But with this patch there will be just one loop, then directly to the
end of the extent:

  btrfs-130471  [014] .....  5434.029558: defrag_one_cluster: r/i=5/257 start=0 len=262144
  btrfs-130471  [014] .....  5434.029559: defrag_one_cluster: r/i=5/257 start=67108864 len=16384

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 67ba934be99e..592a542164a4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1197,10 +1197,11 @@ struct defrag_target_range {
  */
 static int defrag_collect_targets(struct btrfs_inode *inode,
 				  const struct btrfs_defrag_ctrl *ctrl,
-				  u64 start, u32 len, bool locked,
-				  struct list_head *target_list)
+				  u64 start, u32 len, u64 *last_scanned_ret,
+				  bool locked, struct list_head *target_list)
 {
 	bool do_compress = ctrl->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
+	bool last_target = false;
 	u64 cur = start;
 	int ret = 0;
 
@@ -1210,6 +1211,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		bool next_mergeable = true;
 		u64 range_len;
 
+		last_target = false;
 		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
 		if (!em)
 			break;
@@ -1259,6 +1261,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		}
 
 add:
+		last_target = true;
 		range_len = min(extent_map_end(em), start + len) - cur;
 		/*
 		 * This one is a good target, check if it can be merged into
@@ -1302,6 +1305,17 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			kfree(entry);
 		}
 	}
+	if (!ret && last_scanned_ret) {
+		/*
+		 * If the last extent is not a target, the caller can skip to
+		 * the end of that extent.
+		 * Otherwise, we can only go the end of the spcified range.
+		 */
+		if (!last_target)
+			*last_scanned_ret = cur;
+		else
+			*last_scanned_ret = start + len;
+	}
 	return ret;
 }
 
@@ -1405,7 +1419,7 @@ static int defrag_one_range(struct btrfs_inode *inode,
 	 * And this time we have extent locked already, pass @locked = true
 	 * so that we won't relock the extent range and cause deadlock.
 	 */
-	ret = defrag_collect_targets(inode, ctrl, start, len, true,
+	ret = defrag_collect_targets(inode, ctrl, start, len, NULL, true,
 				     &target_list);
 	if (ret < 0)
 		goto unlock_extent;
@@ -1448,6 +1462,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 			      struct btrfs_defrag_ctrl *ctrl, u32 len)
 {
 	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	u64 last_scanned;
 	struct defrag_target_range *entry;
 	struct defrag_target_range *tmp;
 	LIST_HEAD(target_list);
@@ -1455,7 +1470,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 
 	BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
 	ret = defrag_collect_targets(inode, ctrl, ctrl->last_scanned, len,
-				     false, &target_list);
+				     &last_scanned, false, &target_list);
 	if (ret < 0)
 		goto out;
 
@@ -1496,6 +1511,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		list_del_init(&entry->list);
 		kfree(entry);
 	}
+	if (!ret)
+		ctrl->last_scanned = last_scanned;
 	return ret;
 }
 
@@ -1624,7 +1641,6 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		btrfs_inode_unlock(inode, 0);
 		if (ret < 0)
 			break;
-		ctrl->last_scanned = cluster_end + 1;
 		if (ret > 0) {
 			ret = 0;
 			break;
-- 
2.34.1

