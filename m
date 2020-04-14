Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD81A7092
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 03:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbgDNBeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Apr 2020 21:34:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:47186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgDNBeK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Apr 2020 21:34:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 534EEABC7
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Apr 2020 01:34:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: Remove extent_buffer::tree member
Date:   Tue, 14 Apr 2020 09:34:04 +0800
Message-Id: <20200414013404.41830-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This member can be fetched from eb::fs_info, and no caller really
depends on that member to determine if an eb is dummy. We have eb::flags
to determine that.

Kernel doesn't have such member either.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
NOTE: Another candidate to cleanup is eb::cache_node, in kernel we use
radix tree, thus no need for any structure in eb.

But in btrfs-progs, we also rely on extent_io_tree to do cache size
limitation, and for U-boot there is no radix tree implemented yet.

Thus eb::cache_node may live for a longer time.
---
 disk-io.c   |  7 ++++---
 extent_io.c | 14 +++++---------
 extent_io.h |  1 -
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/disk-io.c b/disk-io.c
index c895bd277491..093a87cc9c48 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -371,8 +371,8 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 		ret = read_whole_eb(fs_info, eb, mirror_num);
 		if (ret == 0 && csum_tree_block(fs_info, eb, 1) == 0 &&
 		    check_tree_block(fs_info, eb) == 0 &&
-		    verify_parent_transid(eb->tree, eb, parent_transid, ignore)
-		    == 0) {
+		    verify_parent_transid(&fs_info->extent_cache, eb,
+					  parent_transid, ignore) == 0) {
 			if (eb->flags & EXTENT_BAD_TRANSID &&
 			    list_empty(&eb->recow)) {
 				list_add_tail(&eb->recow,
@@ -1951,7 +1951,8 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid)
 	if (!ret)
 		return ret;
 
-	ret = verify_parent_transid(buf->tree, buf, parent_transid, 1);
+	ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,
+				    parent_transid, 1);
 	return !ret;
 }
 
diff --git a/extent_io.c b/extent_io.c
index 4b5acb1aabf0..5ec8f41de265 100644
--- a/extent_io.c
+++ b/extent_io.c
@@ -619,7 +619,6 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *info,
 	eb->cache_node.start = bytenr;
 	eb->cache_node.size = blocksize;
 	eb->fs_info = info;
-	eb->tree = &info->extent_cache;
 	INIT_LIST_HEAD(&eb->recow);
 	INIT_LIST_HEAD(&eb->lru);
 	memset_extent_buffer(eb, 0, 0, blocksize);
@@ -634,8 +633,6 @@ struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src)
 	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
 	if (!new)
 		return NULL;
-	/* cloned eb is not linked into fs_info->extent_cache */
-	new->tree = NULL;
 
 	copy_extent_buffer(new, src, 0, 0, src->len);
 	new->flags |= EXTENT_BUFFER_DUMMY;
@@ -645,13 +642,13 @@ struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src)
 
 static void free_extent_buffer_final(struct extent_buffer *eb)
 {
-	struct extent_io_tree *tree = eb->tree;
-
 	BUG_ON(eb->refs);
-	BUG_ON(tree && tree->cache_size < eb->len);
 	list_del_init(&eb->lru);
 	if (!(eb->flags & EXTENT_BUFFER_DUMMY)) {
+		struct extent_io_tree *tree = &eb->fs_info->extent_cache;
+
 		remove_cache_extent(&tree->cache, &eb->cache_node);
+		BUG_ON(tree->cache_size < eb->len);
 		tree->cache_size -= eb->len;
 	}
 	free(eb);
@@ -786,7 +783,6 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (!ret)
 		return NULL;
 
-	ret->tree = NULL;
 	ret->flags |= EXTENT_BUFFER_DUMMY;
 
 	return ret;
@@ -970,7 +966,7 @@ out:
 
 int set_extent_buffer_dirty(struct extent_buffer *eb)
 {
-	struct extent_io_tree *tree = eb->tree;
+	struct extent_io_tree *tree = &eb->fs_info->extent_cache;
 	if (!(eb->flags & EXTENT_DIRTY)) {
 		eb->flags |= EXTENT_DIRTY;
 		set_extent_dirty(tree, eb->start, eb->start + eb->len - 1);
@@ -981,7 +977,7 @@ int set_extent_buffer_dirty(struct extent_buffer *eb)
 
 int clear_extent_buffer_dirty(struct extent_buffer *eb)
 {
-	struct extent_io_tree *tree = eb->tree;
+	struct extent_io_tree *tree = &eb->fs_info->extent_cache;
 	if (eb->flags & EXTENT_DIRTY) {
 		eb->flags &= ~EXTENT_DIRTY;
 		clear_extent_dirty(tree, eb->start, eb->start + eb->len - 1);
diff --git a/extent_io.h b/extent_io.h
index 8b65e2d2181b..bf934dfcbdf1 100644
--- a/extent_io.h
+++ b/extent_io.h
@@ -89,7 +89,6 @@ struct extent_buffer {
 	struct cache_extent cache_node;
 	u64 start;
 	u64 dev_bytenr;
-	struct extent_io_tree *tree;
 	struct list_head lru;
 	struct list_head recow;
 	u32 len;
-- 
2.26.0

