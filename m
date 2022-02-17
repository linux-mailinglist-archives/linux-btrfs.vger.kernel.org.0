Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF04B9FDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 13:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbiBQMMd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 07:12:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiBQMMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 07:12:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA48B10FD5
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 04:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8612FB82178
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7435C340E8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 12:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645099934;
        bh=DM1dYjUCXh8Pu1+xXdFGk1JavhWZVwwHuk0KGpqCDls=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mLbk++uttR1JbhmZPoEKQrJQEY4giyYAeqxskyvTb79GYqb7VqcDN+5BhKPLBnINs
         M4NaqDx36AITq+yj8RS5344qW4SoYbxtE9/a9Ot6BjtC8grdQRL282f979lSXiYJqi
         Dq9W8/TLMwLUP0FIpcaGMHosBMj7UC3QTmZblo/Npt7JZvzyNvOE8mJZ/X/9vDtb4H
         ho8bkm6neBYCNO3TJJD71zdUf+jh+T4IYdkl+M57E1/QxPJ1YO1LNdnqsHcF1/m2ie
         2KqR2ZDLxmjLpNRxheT4pwyAgWx3i73DFepenA4viSUAXwoiDUDcBFpMaF0ZnANv2y
         TWisM97EwYhyw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: hold on to less memory when logging checksums during full fsync
Date:   Thu, 17 Feb 2022 12:12:04 +0000
Message-Id: <af99e2bbf1763be579800f2679b0327e44cdf745.1645098951.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1645098951.git.fdmanana@suse.com>
References: <cover.1645098951.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a full fsync, at copy_items(), we iterate over all extents and
then collect their checksums into a list. After copying all the extents to
the log tree, we then log all the previously collected checksums.

Before the previous patch in the series (subject "btrfs: stop copying old
file extents when doing a full fsync"), we had to do it this way, because
while we were iterating over the items in the leaf of the subvolume tree,
we were holding a write lock on a leaf of the log tree, so logging the
checksums for an extent right after we collected them could result in a
deadlock, in case the checksum items ended up in the same leaf.

However after the previous patch in the series we now do a first iteration
over all the items in the leaf of the subvolume tree before locking a path
in the log tree, so we can now log the checksums right after we have
obtained them. This avoids holding in memory all checksums for all extents
in the leaf while copying items from the source leaf to the log tree. The
amount of memory used to hold all checksums of the extents in a leaf can
be significant. For example if a leaf has 200 file extent items referring
to 1M extents, using the default crc32c checksums, would result in using
over 200K of memory (not accounting for the extra overhead of struct
btrfs_ordered_sum), with smaller or less extents it would be less, but
it could be much more with more extents per leaf and/or much larger
extents.

So change copy_items() to log the checksums for an extent after looking
them up, and then free their memory, as they are no longer necessary.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 602aa10c9d88..513baf073510 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4410,12 +4410,9 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	char *ins_data;
 	int i;
 	int dst_index;
-	struct list_head ordered_sums;
 	const bool skip_csum = (inode->flags & BTRFS_INODE_NODATASUM);
 	const u64 i_size = i_size_read(&inode->vfs_inode);
 
-	INIT_LIST_HEAD(&ordered_sums);
-
 	ins_data = kmalloc(nr * sizeof(struct btrfs_key) +
 			   nr * sizeof(u32), GFP_NOFS);
 	if (!ins_data)
@@ -4432,6 +4429,9 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 	for (i = 0; i < nr; i++) {
 		const int src_slot = start_slot + i;
 		struct btrfs_root *csum_root;
+		struct btrfs_ordered_sum *sums;
+		struct btrfs_ordered_sum *sums_next;
+		LIST_HEAD(ordered_sums);
 		u64 disk_bytenr;
 		u64 disk_num_bytes;
 		u64 extent_offset;
@@ -4505,6 +4505,15 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		if (ret)
 			goto out;
 
+		list_for_each_entry_safe(sums, sums_next, &ordered_sums, list) {
+			if (!ret)
+				ret = log_csums(trans, inode, log, sums);
+			list_del(&sums->list);
+			kfree(sums);
+		}
+		if (ret)
+			goto out;
+
 add_to_batch:
 		ins_sizes[dst_index] = btrfs_item_size(src, src_slot);
 		batch.total_data_size += ins_sizes[dst_index];
@@ -4578,20 +4587,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 out:
 	kfree(ins_data);
 
-	/*
-	 * we have to do this after the loop above to avoid changing the
-	 * log tree while trying to change the log tree.
-	 */
-	while (!list_empty(&ordered_sums)) {
-		struct btrfs_ordered_sum *sums = list_entry(ordered_sums.next,
-						   struct btrfs_ordered_sum,
-						   list);
-		if (!ret)
-			ret = log_csums(trans, inode, log, sums);
-		list_del(&sums->list);
-		kfree(sums);
-	}
-
 	return ret;
 }
 
-- 
2.33.0

