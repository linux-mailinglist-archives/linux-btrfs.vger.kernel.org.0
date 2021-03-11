Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2E33375C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 15:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhCKOcA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 09:32:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233934AbhCKObd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 09:31:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D145C64FE2;
        Thu, 11 Mar 2021 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615473092;
        bh=1sLxWq+aZf5wLlrnsk/Uo8KzAsj6NAr40yldOC3ZIiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYSrgSwtAF73DhvFDefTD8Wxb0ZQl/XxdvFx7vyRzTfkRWJT+VtyCnUN4mVWcE+9x
         KbL2B9ZWLLf17D1JH59PMWv4YLXEu+66WTskJl/feXpmrcjA4Y74XTF7Q+7mxaA9Q8
         2qeoyUwtesho7ZR6P3CgoIpf+RGDHfR95gB6bTfDvjOsK82fRzH+bp/k9v3oD6/G5C
         ozgsyAM6+Qv8+vePCzS58S8EH2h7YLI15novQdze0rpgKUocfJZRdU4P6kClO1gjGO
         L73fGxBV9469wgdai/gmPsmNM0k7FfvA6vF37dYICDkupoIxIQadAcopjsGyJVuJ/r
         KOJGnhWyTzbuw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 8/9] btrfs: add and use helper to get lowest sequence number for the tree mod log
Date:   Thu, 11 Mar 2021 14:31:12 +0000
Message-Id: <feacff1f69ca0caf17f04ca106271620d3151718.1615472583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615472583.git.fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There are two places outside the tree mod log module that extract the
lowest sequence number of the tree mod log. These places end up
duplicating code and open coding the logic and internal implementation
details of the tree mod log. So add a helper to the tree mod log module
and header that returns the lowest sequence number or 0 if there aren't
any tree mod log users at the moment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c  | 31 ++++++++-----------------------
 fs/btrfs/tree-mod-log.c | 25 +++++++++++++++++++++++++
 fs/btrfs/tree-mod-log.h |  1 +
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index d87472a68bf4..7a3131cbf1fb 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -495,16 +495,7 @@ void btrfs_merge_delayed_refs(struct btrfs_trans_handle *trans,
 	if (head->is_data)
 		return;
 
-	read_lock(&fs_info->tree_mod_log_lock);
-	if (!list_empty(&fs_info->tree_mod_seq_list)) {
-		struct btrfs_seq_list *elem;
-
-		elem = list_first_entry(&fs_info->tree_mod_seq_list,
-					struct btrfs_seq_list, list);
-		seq = elem->seq;
-	}
-	read_unlock(&fs_info->tree_mod_log_lock);
-
+	seq = btrfs_tree_mod_log_lowest_seq(fs_info);
 again:
 	for (node = rb_first_cached(&head->ref_tree); node;
 	     node = rb_next(node)) {
@@ -518,23 +509,17 @@ void btrfs_merge_delayed_refs(struct btrfs_trans_handle *trans,
 
 int btrfs_check_delayed_seq(struct btrfs_fs_info *fs_info, u64 seq)
 {
-	struct btrfs_seq_list *elem;
+	u64 min_seq = btrfs_tree_mod_log_lowest_seq(fs_info);
 	int ret = 0;
 
-	read_lock(&fs_info->tree_mod_log_lock);
-	if (!list_empty(&fs_info->tree_mod_seq_list)) {
-		elem = list_first_entry(&fs_info->tree_mod_seq_list,
-					struct btrfs_seq_list, list);
-		if (seq >= elem->seq) {
-			btrfs_debug(fs_info,
-				"holding back delayed_ref %#x.%x, lowest is %#x.%x",
-				(u32)(seq >> 32), (u32)seq,
-				(u32)(elem->seq >> 32), (u32)elem->seq);
-			ret = 1;
-		}
+	if (min_seq != 0 && seq >= min_seq) {
+		btrfs_debug(fs_info,
+			    "holding back delayed_ref %#x.%x, lowest is %#x.%x",
+			    (u32)(seq >> 32), (u32)seq,
+			    (u32)(min_seq >> 32), (u32)min_seq);
+		ret = 1;
 	}
 
-	read_unlock(&fs_info->tree_mod_log_lock);
 	return ret;
 }
 
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index c854cebf27f6..b2083b575e21 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -885,3 +885,28 @@ int btrfs_old_root_level(struct btrfs_root *root, u64 time_seq)
 	return level;
 }
 
+/*
+ * Return the lowest sequence number in the tree modification log.
+ *
+ * @fs_info:	the filesystem context
+ *
+ * Returns the sequence number of the oldest tree modification log user, which
+ * corresponds to the lowest sequence number of all existing users. If there are
+ * no users it returns 0.
+ */
+u64 btrfs_tree_mod_log_lowest_seq(struct btrfs_fs_info *fs_info)
+{
+	u64 ret = 0;
+
+	read_lock(&fs_info->tree_mod_log_lock);
+	if (!list_empty(&fs_info->tree_mod_seq_list)) {
+		struct btrfs_seq_list *elem;
+
+		elem = list_first_entry(&fs_info->tree_mod_seq_list,
+					struct btrfs_seq_list, list);
+		ret = elem->seq;
+	}
+	read_unlock(&fs_info->tree_mod_log_lock);
+
+	return ret;
+}
diff --git a/fs/btrfs/tree-mod-log.h b/fs/btrfs/tree-mod-log.h
index 2f7396ea57ae..d218f8a661bc 100644
--- a/fs/btrfs/tree-mod-log.h
+++ b/fs/btrfs/tree-mod-log.h
@@ -48,5 +48,6 @@ int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
 int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
 				   int dst_slot, int src_slot,
 				   int nr_items);
+u64 btrfs_tree_mod_log_lowest_seq(struct btrfs_fs_info *fs_info);
 
 #endif /* BTRFS_TREE_MOD_LOG_H */
-- 
2.28.0

