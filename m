Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8AD142CE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 15:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgATOJ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 09:09:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:49094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgATOJX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 09:09:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE737B1A8;
        Mon, 20 Jan 2020 14:09:21 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/11] btrfs: Make btrfs_pin_extent_for_log_replay take transaction handle
Date:   Mon, 20 Jan 2020 16:09:13 +0200
Message-Id: <20200120140918.15647-7-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120140918.15647-1-nborisov@suse.com>
References: <20200120140918.15647-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparation for refactoring pinned extents tracking.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h       | 2 +-
 fs/btrfs/extent-tree.c | 4 ++--
 fs/btrfs/tree-log.c    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1fe1cbe20bba..c6ce8c047814 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2462,7 +2462,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			     u64 offset, int metadata, u64 *refs, u64 *flags);
 int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num,
 		     int reserved);
-int btrfs_pin_extent_for_log_replay(struct btrfs_fs_info *fs_info,
+int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 				    u64 bytenr, u64 num_bytes);
 int btrfs_exclude_logged_extents(struct extent_buffer *eb);
 int btrfs_cross_ref_exist(struct btrfs_root *root,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cf6048fa6e9a..a9a54b7ae15a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2627,13 +2627,13 @@ int btrfs_pin_extent(struct btrfs_trans_handle *trans,
 /*
  * this function must be called within transaction
  */
-int btrfs_pin_extent_for_log_replay(struct btrfs_fs_info *fs_info,
+int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 				    u64 bytenr, u64 num_bytes)
 {
 	struct btrfs_block_group *cache;
 	int ret;

-	cache = btrfs_lookup_block_group(fs_info, bytenr);
+	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
 	if (!cache)
 		return -EINVAL;

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ccbac7663d3b..b535d409a728 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -313,7 +313,7 @@ static int process_one_buffer(struct btrfs_root *log,
 	}

 	if (wc->pin)
-		ret = btrfs_pin_extent_for_log_replay(fs_info, eb->start,
+		ret = btrfs_pin_extent_for_log_replay(wc->trans, eb->start,
 						      eb->len);

 	if (!ret && btrfs_buffer_uptodate(eb, gen, 0)) {
@@ -6151,7 +6151,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * each subsequent pass.
 			 */
 			if (ret == -ENOENT)
-				ret = btrfs_pin_extent_for_log_replay(fs_info,
+				ret = btrfs_pin_extent_for_log_replay(trans,
 							log->node->start,
 							log->node->len);
 			free_extent_buffer(log->node);
--
2.17.1

