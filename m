Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9317C142CE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 15:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgATOJ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 09:09:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:49146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgATOJZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 09:09:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AA4E3B1CA;
        Mon, 20 Jan 2020 14:09:22 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/11] btrfs: Factor out pinned extent clean up in btrfs_delete_unused_bgs
Date:   Mon, 20 Jan 2020 16:09:17 +0200
Message-Id: <20200120140918.15647-11-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120140918.15647-1-nborisov@suse.com>
References: <20200120140918.15647-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Next patch is going to refactor how pinned extents are tracked which
will necessitate changing this code. To ease that work and contain the
changes factor the code now in preparation, this will also help review.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 69 ++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 14851584e245..48bb9e08f2e8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1233,6 +1233,45 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 	return ret;
 }

+static bool clean_pinned_extents(struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	u64 start = bg->start;
+	u64 end = start + bg->length - 1;
+	int ret;
+
+	/*
+	 * Hold the unused_bg_unpin_mutex lock to avoid racing with
+	 * btrfs_finish_extent_commit(). If we are at transaction N,
+	 * another task might be running finish_extent_commit() for the
+	 * previous transaction N - 1, and have seen a range belonging
+	 * to the block group in freed_extents[] before we were able to
+	 * clear the whole block group range from freed_extents[]. This
+	 * means that task can lookup for the block group after we
+	 * unpinned it from freed_extents[] and removed it, leading to
+	 * a BUG_ON() at unpin_extent_range().
+	 */
+	mutex_lock(&fs_info->unused_bg_unpin_mutex);
+	ret = clear_extent_bits(&fs_info->freed_extents[0], start, end,
+			  EXTENT_DIRTY);
+	if (ret)
+		goto failure;
+
+	ret = clear_extent_bits(&fs_info->freed_extents[1], start, end,
+			  EXTENT_DIRTY);
+	if (ret)
+		goto failure;
+	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+
+	return true;
+
+failure:
+	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+	btrfs_dec_block_group_ro(bg);
+	return false;
+
+}
+
 /*
  * Process the unused_bgs list and remove any that don't have any allocated
  * space inside of them.
@@ -1250,7 +1289,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)

 	spin_lock(&fs_info->unused_bgs_lock);
 	while (!list_empty(&fs_info->unused_bgs)) {
-		u64 start, end;
 		int trimming;

 		block_group = list_first_entry(&fs_info->unused_bgs,
@@ -1329,35 +1367,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * We could have pending pinned extents for this block group,
 		 * just delete them, we don't care about them anymore.
 		 */
-		start = block_group->start;
-		end = start + block_group->length - 1;
-		/*
-		 * Hold the unused_bg_unpin_mutex lock to avoid racing with
-		 * btrfs_finish_extent_commit(). If we are at transaction N,
-		 * another task might be running finish_extent_commit() for the
-		 * previous transaction N - 1, and have seen a range belonging
-		 * to the block group in freed_extents[] before we were able to
-		 * clear the whole block group range from freed_extents[]. This
-		 * means that task can lookup for the block group after we
-		 * unpinned it from freed_extents[] and removed it, leading to
-		 * a BUG_ON() at btrfs_unpin_extent_range().
-		 */
-		mutex_lock(&fs_info->unused_bg_unpin_mutex);
-		ret = clear_extent_bits(&fs_info->freed_extents[0], start, end,
-				  EXTENT_DIRTY);
-		if (ret) {
-			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
-			btrfs_dec_block_group_ro(block_group);
+		if (!clean_pinned_extents(block_group))
 			goto end_trans;
-		}
-		ret = clear_extent_bits(&fs_info->freed_extents[1], start, end,
-				  EXTENT_DIRTY);
-		if (ret) {
-			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
-			btrfs_dec_block_group_ro(block_group);
-			goto end_trans;
-		}
-		mutex_unlock(&fs_info->unused_bg_unpin_mutex);

 		/*
 		 * At this point, the block_group is read only and should fail
--
2.17.1

