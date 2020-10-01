Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA527F938
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgJAF6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:58:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:40244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgJAF6H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:58:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6bRolufmTc+LjcKcO4eEj82qYiqTWj/g8cfI+brliHo=;
        b=cO5gLgRUK4rXHW3bINGKXDfrW4yR8t8lzQBArUo/YZ/5m5tnjStO3DmpLvEqNQ9PoBlm5D
        jZf/x+emUXSK/2GUeCAUkDfFgrY+JalLBWmo0LlKRsIUKOmcOIM/+RW+OJ8Rz59+FIbAY0
        Ff/HCUKaNDp4yVBhOCxH/fJzmv3McFY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C08C1B320
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 05:58:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9 06/12] btrfs: block-group: introduce btrfs_revert_block_group()
Date:   Thu,  1 Oct 2020 13:57:38 +0800
Message-Id: <20201001055744.103261-7-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001055744.103261-1-wqu@suse.com>
References: <20201001055744.103261-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introudces a new function, btrfs_revert_block_group(), to
revert a newly created but not yet finished block group.

This is for error handling where we just called btrfs_make_block_group()
but then some error happened.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 33 +++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/space-info.c  | 12 +++++++++---
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bbe3c4cd28d8..dc70d3581bf0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2190,6 +2190,39 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	return 0;
 }
 
+/*
+ * This is a function to revert the newly created block group, mostly for error
+ * handling.
+ *
+ * Unlike btrfs_remove_block_group(), since the new block group hasn't
+ * finished creating, it's much easier to remove it.
+ */
+void btrfs_revert_block_group(struct btrfs_trans_handle *trans, u64 bytenr)
+{
+	struct btrfs_block_group *bg;
+
+	bg = btrfs_lookup_block_group(trans->fs_info, bytenr);
+
+	if (!bg)
+		return;
+	trace_btrfs_remove_block_group(bg);
+
+	btrfs_update_space_info(bg, false, NULL);
+	unlink_block_group(bg);
+
+	btrfs_delayed_refs_rsv_release(trans->fs_info, 1);
+	list_del_init(&bg->bg_list);
+
+	del_block_group(bg);
+
+	/* One for the lookup reference */
+	btrfs_put_block_group(bg);
+
+	/* Finally free the last reference */
+	WARN_ON(refcount_read(&bg->refs) != 1);
+	btrfs_put_block_group(bg);
+}
+
 /*
  * Mark one block group RO, can be called several times for the same block
  * group.
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index adfd7583a17b..619ca97254fb 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -248,6 +248,7 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg);
 int btrfs_read_block_groups(struct btrfs_fs_info *info);
 int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 			   u64 type, u64 chunk_offset, u64 size);
+void btrfs_revert_block_group(struct btrfs_trans_handle *trans, u64 bytenr);
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 			     bool do_chunk_alloc);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c86baa331612..64b6e1d44f47 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -278,8 +278,14 @@ void btrfs_update_space_info(struct btrfs_block_group *bg, bool add,
 			found->full = 0;
 		btrfs_try_granting_tickets(info, found);
 	} else {
+		/* We get called for either removing an unused bg, or a newly
+		 * created bg.
+		 * Use their ro bit to determine which the case is.
+		 */
+		bool ro = bg->ro;
+
 		/* The block group to be removed should be empty */
-		WARN_ON(bg->used || !bg->ro);
+		WARN_ON(bg->used);
 
 		/* For removal, we need more overflow check */
 		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
@@ -288,9 +294,9 @@ void btrfs_update_space_info(struct btrfs_block_group *bg, bool add,
 			WARN_ON(found->disk_total < bg->length * factor);
 		}
 		found->total_bytes -= bg ->length;
-		found->bytes_readonly -= bg->length;
 		found->disk_total -= bg->length * factor;
-
+		if (ro)
+			found->bytes_readonly -= bg->length;
 		/*
 		 * Also remove the block group from ro list since we're
 		 * delete it from the space info accounting.
-- 
2.28.0

