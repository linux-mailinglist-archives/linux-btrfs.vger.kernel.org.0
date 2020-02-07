Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC37D15578F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 13:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBGMXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 07:23:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbgBGMXN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 07:23:13 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA75F20720
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2020 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581078192;
        bh=x0W4rjJHo2XDSOTp64Wcc6HKOtcDrZiH3YP4M/koYKE=;
        h=From:To:Subject:Date:From;
        b=kQdaSu8AdwPg0IjAo2p6e1KXF7l3qq2k1/n2Pnvx2ZCm77tKpKCFIKS+9SML9dLAt
         RUdBlDbpKu7UV4l3ksNZGpmL+AWUMXhHoCcV272ADTEG/JwUysmkLatyS4FLYUbH8C
         EjuRunRTymAnn5H23igmaBr3sm6LEHQrmyArkQTg=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix race between shrinking truncate and fiemap
Date:   Fri,  7 Feb 2020 12:23:09 +0000
Message-Id: <20200207122309.17209-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When there is a fiemap executing in parallel with a shrinking truncate we
can end up in a situation where we have extent maps for which we no longer
have corresponding file extent items. This is generally harmless and at
the moment the only consequences are missing file extent items representing
holes after we expand the file size again after the truncate operation
removed the prealloc extent items, and stale information for future fiemap
calls (reporting extents that no longer exist or may have been reallocated
to other files for example).

Consider the following example:

1) Our inode has a size of 128Kb, one 128Kb extent at file offset 0 and
   a 1Mb prealloc extent at file offset 128Kb;

2) Task A starts doing a shrinking truncate of our inode to reduce it to
   a size of 64Kb. Before it searches the subvolume tree for file extent
   items to delete, it drops all the extent maps in the range from 64Kb
   to (u64)-1 by calling btrfs_drop_extent_cache();

3) Task B starts doing a fiemap against our inode. When looking up for the
   inode's extent maps in the range from 128Kb to (u64)-1, it doesn't find
   any in the inode's extent map tree, since they were removed by task A.
   Because it didn't find any in the extent map tree, it scans the inode's
   subvolume tree for file extent items, and it finds the 1Mb prealloc
   extent at file offset 128Kb, then it creates an extent map based on
   that file extent item and adds it to inode's extent map tree (this ends
   up being done by btrfs_get_extent() <- btrfs_get_extent_fiemap() <-
   get_extent_skip_holes());

4) Task A then drops the prealloc extent at file offset 128Kb and shrinks
   the 128Kb extent file offset 0 to a length of 64Kb. The truncation
   operation finishes and we end up with an extent map representing a 1Mb
   prealloc extent at file offset 128Kb, despite we don't have any more
   that extent;

After this the two types of problems we have are:

1) Future calls to fiemap always report that a 1Mb prealloc extent exists
   at file offset 128Kb. This is stale information, no longer correct;

2) If the size of the file is increased, by a truncate operation that
   increases the file size or by a write into a file offset > 64Kb for
   example, we end up not inserting file extent items to represent
   holes for any range between 128Kb and 128Kb + 1Mb, since the hole
   expansion function, btrfs_cont_expand() will skip hole insertion
   for any range for which an extent map exists that represents a
   prealloc extent. This causes fsck to complain about missing file
   extent items when not using the NO_HOLES feature.

The second issue could be often triggered by test case generic/561 from
fstests, which runs fsstress and duperemove in parallel, and duperemove
does frequent fiemap calls.

Essentially the problems happens because fiemap does not acquire the
inode's lock while truncate does, and fiemap locks the file range in the
inode's iotree while truncate does not. So fix the issue by making
btrfs_truncate_inode_items() lock the file range from the new file size
to (u64)-1, so that it serializes with fiemap.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac22ba472c68..90c404ae242a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4684,6 +4684,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	u64 bytes_deleted = 0;
 	bool be_nice = false;
 	bool should_throttle = false;
+	const u64 lock_start = ALIGN_DOWN(new_size, fs_info->sectorsize);
+	struct extent_state *cached_state = NULL;
 
 	BUG_ON(new_size > 0 && min_type != BTRFS_EXTENT_DATA_KEY);
 
@@ -4700,6 +4702,9 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	path->reada = READA_BACK;
 
+	lock_extent_bits(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
+			 &cached_state);
+
 	/*
 	 * We want to drop from the next block forward in case this new size is
 	 * not block aligned since we will be keeping the last block of the
@@ -4993,6 +4998,9 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		btrfs_inode_safe_disk_i_size_write(inode, last_size);
 	}
 
+	unlock_extent_cached(&BTRFS_I(inode)->io_tree, lock_start, (u64)-1,
+			     &cached_state);
+
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.11.0

