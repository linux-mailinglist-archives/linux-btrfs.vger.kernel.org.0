Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98C27F937
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgJAF6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:58:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgJAF6F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:58:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LK7eHJRxARkK6h4xsTdp8OjW14GAmuDTVrMBlQ+ahRI=;
        b=gvL1yRzmhgBzjwG5VpOZuo6ExVj55xcQUOCi+WfXRsKfAGQnvlGXjkJbK9ICaT3WZ4Q/ly
        3GqF2yxrdQMMifj0BbWF98bzCSWn1cYJG9g49YBBwh9Mk7ldkXr+CdLpmGra1CY2391AKM
        52iC6ZbM4tdUPZUEhpp+W7zChU28LMw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87081B31D
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 05:58:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9 05/12] btrfs: space-info: update btrfs_update_space_info() to handle block group removal
Date:   Thu,  1 Oct 2020 13:57:37 +0800
Message-Id: <20201001055744.103261-6-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001055744.103261-1-wqu@suse.com>
References: <20201001055744.103261-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update btrfs_update_space_info() to handle block group removal, by
adding a new paramter, @add, to indicate whether we're adding or
removing a block group.

This allows btrfs_remove_block_group() to call btrfs_update_space_info()
instead of doing it manually.

Also since we're here, sink the parameters, as we always call
btrfs_update_space_info() with values extracted from a block group, just
pass the btrfs_block_group paramter in directly.

This also removes the btrfs_fs_info prameter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 23 +++----------------
 fs/btrfs/space-info.c  | 50 +++++++++++++++++++++++++++++-------------
 fs/btrfs/space-info.h  |  4 +---
 3 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 262805b96b9b..bbe3c4cd28d8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1085,22 +1085,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 
 	btrfs_remove_free_space_cache(block_group);
 
-	spin_lock(&block_group->space_info->lock);
-	list_del_init(&block_group->ro_list);
-
-	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
-		WARN_ON(block_group->space_info->total_bytes
-			< block_group->length);
-		WARN_ON(block_group->space_info->bytes_readonly
-			< block_group->length);
-		WARN_ON(block_group->space_info->disk_total
-			< block_group->length * factor);
-	}
-	block_group->space_info->total_bytes -= block_group->length;
-	block_group->space_info->bytes_readonly -= block_group->length;
-	block_group->space_info->disk_total -= block_group->length * factor;
-
-	spin_unlock(&block_group->space_info->lock);
+	btrfs_update_space_info(block_group, false, NULL);
 
 	/*
 	 * Remove the free space for the block group from the free space tree
@@ -1988,8 +1973,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		goto error;
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
-	btrfs_update_space_info(info, cache->flags, cache->length,
-				cache->used, cache->bytes_super, &space_info);
+	btrfs_update_space_info(cache, true, &space_info);
 
 	cache->space_info = space_info;
 
@@ -2194,8 +2178,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	 * the rbtree, update the space info's counters.
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
-	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, &cache->space_info);
+	btrfs_update_space_info(cache, true, &cache->space_info);
 	btrfs_update_global_block_rsv(fs_info);
 
 	link_block_group(cache);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 475968ccbd1d..c86baa331612 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -257,29 +257,49 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
-			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+void btrfs_update_space_info(struct btrfs_block_group *bg, bool add,
 			     struct btrfs_space_info **space_info)
 {
+	struct btrfs_fs_info *info = bg->fs_info;
 	struct btrfs_space_info *found;
 	int factor;
 
-	factor = btrfs_bg_type_to_factor(flags);
-
-	found = btrfs_find_space_info(info, flags);
+	factor = btrfs_bg_type_to_factor(bg->flags);
+	found = btrfs_find_space_info(info, bg->flags);
 	ASSERT(found);
 	spin_lock(&found->lock);
-	found->total_bytes += total_bytes;
-	found->disk_total += total_bytes * factor;
-	found->bytes_used += bytes_used;
-	found->disk_used += bytes_used * factor;
-	found->bytes_readonly += bytes_readonly;
-	if (total_bytes > 0)
-		found->full = 0;
-	btrfs_try_granting_tickets(info, found);
+	if (add) {
+		found->total_bytes += bg->length;
+		found->disk_total += bg->length * factor;
+		found->bytes_used += bg->used;
+		found->disk_used += bg->used * factor;
+		found->bytes_readonly += bg->bytes_super;
+		if (bg->length > 0)
+			found->full = 0;
+		btrfs_try_granting_tickets(info, found);
+	} else {
+		/* The block group to be removed should be empty */
+		WARN_ON(bg->used || !bg->ro);
+
+		/* For removal, we need more overflow check */
+		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
+			WARN_ON(found->total_bytes < bg->length);
+			WARN_ON(found->bytes_readonly < bg->length);
+			WARN_ON(found->disk_total < bg->length * factor);
+		}
+		found->total_bytes -= bg ->length;
+		found->bytes_readonly -= bg->length;
+		found->disk_total -= bg->length * factor;
+
+		/*
+		 * Also remove the block group from ro list since we're
+		 * delete it from the space info accounting.
+		 */
+		list_del_init(&bg->ro_list);
+	}
 	spin_unlock(&found->lock);
-	*space_info = found;
+	if (space_info)
+		*space_info = found;
 }
 
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index c3c64019950a..3b5081511d7a 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -117,9 +117,7 @@ DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
-void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
-			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
+void btrfs_update_space_info(struct btrfs_block_group *bg, bool add,
 			     struct btrfs_space_info **space_info);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 					       u64 flags);
-- 
2.28.0

