Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0620DCF1F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2019 06:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfJHEtm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Oct 2019 00:49:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:33588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729647AbfJHEtm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Oct 2019 00:49:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4504AF56
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2019 04:49:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/7] btrfs-progs: Refactor excluded extent functions to use fs_info
Date:   Tue,  8 Oct 2019 12:49:30 +0800
Message-Id: <20191008044936.157873-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008044936.157873-1-wqu@suse.com>
References: <20191008044936.157873-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following functions are just using @root to reach fs_info:
- exclude_super_stripes
- free_excluded_extents
- add_excluded_extent

Refactor them to use fs_info directly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c  |  4 ++--
 ctree.h       |  4 ++--
 extent-tree.c | 20 ++++++++++----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/check/main.c b/check/main.c
index c2d0f3949c5e..94ffab46cb70 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5552,7 +5552,7 @@ static int check_space_cache(struct btrfs_root *root)
 		}
 
 		if (btrfs_fs_compat_ro(root->fs_info, FREE_SPACE_TREE)) {
-			ret = exclude_super_stripes(root, cache);
+			ret = exclude_super_stripes(root->fs_info, cache);
 			if (ret) {
 				errno = -ret;
 				fprintf(stderr,
@@ -5561,7 +5561,7 @@ static int check_space_cache(struct btrfs_root *root)
 				continue;
 			}
 			ret = load_free_space_tree(root->fs_info, cache);
-			free_excluded_extents(root, cache);
+			free_excluded_extents(root->fs_info, cache);
 			if (ret < 0) {
 				errno = -ret;
 				fprintf(stderr,
diff --git a/ctree.h b/ctree.h
index 0d12563b7261..8c7b3cb40151 100644
--- a/ctree.h
+++ b/ctree.h
@@ -2568,9 +2568,9 @@ int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 			      u64 num_bytes);
 int btrfs_free_block_group(struct btrfs_trans_handle *trans,
 			   struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
-void free_excluded_extents(struct btrfs_root *root,
+void free_excluded_extents(struct btrfs_fs_info *fs_info,
 			   struct btrfs_block_group_cache *cache);
-int exclude_super_stripes(struct btrfs_root *root,
+int exclude_super_stripes(struct btrfs_fs_info *fs_info,
 			  struct btrfs_block_group_cache *cache);
 u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
 		       struct btrfs_fs_info *info, u64 start, u64 end);
diff --git a/extent-tree.c b/extent-tree.c
index 932af2c644bd..19d1ea0df570 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2716,7 +2716,7 @@ int btrfs_read_block_groups(struct btrfs_root *root)
 		if (btrfs_chunk_readonly(info, cache->key.objectid))
 			cache->ro = 1;
 
-		exclude_super_stripes(root, cache);
+		exclude_super_stripes(info, cache);
 
 		ret = update_space_info(info, cache->flags, found_key.offset,
 					btrfs_block_group_used(&cache->item),
@@ -2760,7 +2760,7 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	cache->flags = type;
 	btrfs_set_block_group_flags(&cache->item, type);
 
-	exclude_super_stripes(fs_info->extent_root, cache);
+	exclude_super_stripes(fs_info, cache);
 	ret = update_space_info(fs_info, cache->flags, size, bytes_used,
 				&cache->space_info);
 	BUG_ON(ret);
@@ -3551,16 +3551,16 @@ int btrfs_record_file_extent(struct btrfs_trans_handle *trans,
 }
 
 
-static int add_excluded_extent(struct btrfs_root *root,
+static int add_excluded_extent(struct btrfs_fs_info *fs_info,
 			       u64 start, u64 num_bytes)
 {
 	u64 end = start + num_bytes - 1;
-	set_extent_bits(&root->fs_info->pinned_extents,
+	set_extent_bits(&fs_info->pinned_extents,
 			start, end, EXTENT_UPTODATE);
 	return 0;
 }
 
-void free_excluded_extents(struct btrfs_root *root,
+void free_excluded_extents(struct btrfs_fs_info *fs_info,
 			   struct btrfs_block_group_cache *cache)
 {
 	u64 start, end;
@@ -3568,11 +3568,11 @@ void free_excluded_extents(struct btrfs_root *root,
 	start = cache->key.objectid;
 	end = start + cache->key.offset - 1;
 
-	clear_extent_bits(&root->fs_info->pinned_extents,
+	clear_extent_bits(&fs_info->pinned_extents,
 			  start, end, EXTENT_UPTODATE);
 }
 
-int exclude_super_stripes(struct btrfs_root *root,
+int exclude_super_stripes(struct btrfs_fs_info *fs_info,
 			  struct btrfs_block_group_cache *cache)
 {
 	u64 bytenr;
@@ -3583,7 +3583,7 @@ int exclude_super_stripes(struct btrfs_root *root,
 	if (cache->key.objectid < BTRFS_SUPER_INFO_OFFSET) {
 		stripe_len = BTRFS_SUPER_INFO_OFFSET - cache->key.objectid;
 		cache->bytes_super += stripe_len;
-		ret = add_excluded_extent(root, cache->key.objectid,
+		ret = add_excluded_extent(fs_info, cache->key.objectid,
 					  stripe_len);
 		if (ret)
 			return ret;
@@ -3591,7 +3591,7 @@ int exclude_super_stripes(struct btrfs_root *root,
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = btrfs_rmap_block(root->fs_info,
+		ret = btrfs_rmap_block(fs_info,
 				       cache->key.objectid, bytenr,
 				       &logical, &nr, &stripe_len);
 		if (ret)
@@ -3618,7 +3618,7 @@ int exclude_super_stripes(struct btrfs_root *root,
 			}
 
 			cache->bytes_super += len;
-			ret = add_excluded_extent(root, start, len);
+			ret = add_excluded_extent(fs_info, start, len);
 			if (ret) {
 				kfree(logical);
 				return ret;
-- 
2.23.0

