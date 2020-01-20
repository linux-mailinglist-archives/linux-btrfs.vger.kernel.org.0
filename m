Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910E7142CE9
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 15:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgATOJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 09:09:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:49038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbgATOJW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 09:09:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7650B15B;
        Mon, 20 Jan 2020 14:09:20 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 02/11] btrfs: Make btrfs_pin_extent take trans handle
Date:   Mon, 20 Jan 2020 16:09:09 +0200
Message-Id: <20200120140918.15647-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120140918.15647-1-nborisov@suse.com>
References: <20200120140918.15647-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparation for switching pinned extent tracking to a per-transaction
basis.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h       |  4 ++--
 fs/btrfs/extent-tree.c | 18 +++++++-----------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f90b82050d2d..11eaabe104b8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2460,8 +2460,8 @@ int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len);
 int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info, u64 bytenr,
 			     u64 offset, int metadata, u64 *refs, u64 *flags);
-int btrfs_pin_extent(struct btrfs_fs_info *fs_info,
-		     u64 bytenr, u64 num, int reserved);
+int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num,
+		     int reserved);
 int btrfs_pin_extent_for_log_replay(struct btrfs_fs_info *fs_info,
 				    u64 bytenr, u64 num_bytes);
 int btrfs_exclude_logged_extents(struct extent_buffer *eb);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0163fdd59f8f..31ae94a7591c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1705,8 +1705,8 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 
 	if (trans->aborted) {
 		if (insert_reserved)
-			btrfs_pin_extent(trans->fs_info, node->bytenr,
-					 node->num_bytes, 1);
+			btrfs_pin_extent(trans, node->bytenr, node->num_bytes,
+					 1);
 		return 0;
 	}
 
@@ -1721,8 +1721,7 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 	else
 		BUG();
 	if (ret && insert_reserved)
-		btrfs_pin_extent(trans->fs_info, node->bytenr,
-				 node->num_bytes, 1);
+		btrfs_pin_extent(trans, node->bytenr, node->num_bytes, 1);
 	return ret;
 }
 
@@ -1867,8 +1866,7 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 	spin_unlock(&delayed_refs->lock);
 
 	if (head->must_insert_reserved) {
-		btrfs_pin_extent(fs_info, head->bytenr,
-				 head->num_bytes, 1);
+		btrfs_pin_extent(trans, head->bytenr, head->num_bytes, 1);
 		if (head->is_data) {
 			ret = btrfs_del_csums(trans, fs_info->csum_root,
 					      head->bytenr, head->num_bytes);
@@ -2612,14 +2610,12 @@ static int pin_down_extent(struct btrfs_block_group *cache,
 	return 0;
 }
 
-int btrfs_pin_extent(struct btrfs_fs_info *fs_info,
+int btrfs_pin_extent(struct btrfs_trans_handle *trans,
 		     u64 bytenr, u64 num_bytes, int reserved)
 {
 	struct btrfs_block_group *cache;
 
-	ASSERT(fs_info->running_transaction);
-
-	cache = btrfs_lookup_block_group(fs_info, bytenr);
+	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
 	BUG_ON(!cache); /* Logic error */
 
 	pin_down_extent(cache, bytenr, num_bytes, reserved);
@@ -3345,7 +3341,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 	    (ref->type == BTRFS_REF_DATA &&
 	     ref->data_ref.ref_root == BTRFS_TREE_LOG_OBJECTID)) {
 		/* unlocks the pinned mutex */
-		btrfs_pin_extent(fs_info, ref->bytenr, ref->len, 1);
+		btrfs_pin_extent(trans, ref->bytenr, ref->len, 1);
 		old_ref_mod = new_ref_mod = 0;
 		ret = 0;
 	} else if (ref->type == BTRFS_REF_METADATA) {
-- 
2.17.1

