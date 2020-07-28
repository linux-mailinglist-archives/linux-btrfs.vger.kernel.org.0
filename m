Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCE722FF05
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 03:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgG1Bm5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 21:42:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:60296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG1Bm4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 21:42:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E82DB580;
        Tue, 28 Jul 2020 01:43:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Hans van Kranenburg <hans@knorrie.org>
Subject: [PATCH] btrfs: trace: output proper root owner for trace_find_free_extent()
Date:   Tue, 28 Jul 2020 09:42:49 +0800
Message-Id: <20200728014249.35532-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The current trace event always output result like this:

 find_free_extent: root=2(EXTENT_TREE) len=16384 empty_size=0 flags=4(METADATA)
 find_free_extent: root=2(EXTENT_TREE) len=16384 empty_size=0 flags=4(METADATA)
 find_free_extent: root=2(EXTENT_TREE) len=8192 empty_size=0 flags=1(DATA)
 find_free_extent: root=2(EXTENT_TREE) len=8192 empty_size=0 flags=1(DATA)
 find_free_extent: root=2(EXTENT_TREE) len=4096 empty_size=0 flags=1(DATA)
 find_free_extent: root=2(EXTENT_TREE) len=4096 empty_size=0 flags=1(DATA)

It's driving me crazy, as it's saying we're allocating data extent for
EXTENT tree, which is not even possible.

It's because we always use EXTENT tree as the owner for
trace_find_free_extent() without using the @root from
btrfs_reserve_extent().

This patch will change the parameter to use proper @root for
trace_find_free_extent() to make life a little easier.

Now it looks much better:
 find_free_extent: root=5(FS_TREE) len=16384 empty_size=0 flags=36(METADATA|DUP)
 find_free_extent: root=5(FS_TREE) len=8192 empty_size=0 flags=1(DATA)
 find_free_extent: root=5(FS_TREE) len=16384 empty_size=0 flags=1(DATA)
 find_free_extent: root=5(FS_TREE) len=4096 empty_size=0 flags=1(DATA)
 find_free_extent: root=5(FS_TREE) len=8192 empty_size=0 flags=1(DATA)
 find_free_extent: root=5(FS_TREE) len=16384 empty_size=0 flags=36(METADATA|DUP)
 find_free_extent: root=7(CSUM_TREE) len=16384 empty_size=0 flags=36(METADATA|DUP)
 find_free_extent: root=2(EXTENT_TREE) len=16384 empty_size=0 flags=36(METADATA|DUP)
 find_free_extent: root=1(ROOT_TREE) len=16384 empty_size=0 flags=36(METADATA|DUP)

Reported-by: Hans van Kranenburg <hans@knorrie.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c       |  7 ++++---
 include/trace/events/btrfs.h | 10 ++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 61ede335f6c3..fa7d83051587 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3913,11 +3913,12 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
  * |- Push harder to find free extents
  *    |- If not found, re-iterate all block groups
  */
-static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
+static noinline int find_free_extent(struct btrfs_root *root,
 				u64 ram_bytes, u64 num_bytes, u64 empty_size,
 				u64 hint_byte_orig, struct btrfs_key *ins,
 				u64 flags, int delalloc)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret = 0;
 	int cache_block_group_error = 0;
 	struct btrfs_block_group *block_group = NULL;
@@ -3949,7 +3950,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ins->objectid = 0;
 	ins->offset = 0;
 
-	trace_find_free_extent(fs_info, num_bytes, empty_size, flags);
+	trace_find_free_extent(root, num_bytes, empty_size, flags);
 
 	space_info = btrfs_find_space_info(fs_info, flags);
 	if (!space_info) {
@@ -4198,7 +4199,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
 	WARN_ON(num_bytes < fs_info->sectorsize);
-	ret = find_free_extent(fs_info, ram_bytes, num_bytes, empty_size,
+	ret = find_free_extent(root, ram_bytes, num_bytes, empty_size,
 			       hint_byte, ins, flags, delalloc);
 	if (!ret && !is_data) {
 		btrfs_dec_block_group_reservations(fs_info, ins->objectid);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 863335ecb7e8..b9241836d4f7 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1176,25 +1176,27 @@ DEFINE_EVENT(btrfs__reserved_extent,  btrfs_reserved_extent_free,
 
 TRACE_EVENT(find_free_extent,
 
-	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 num_bytes,
+	TP_PROTO(const struct btrfs_root *root, u64 num_bytes,
 		 u64 empty_size, u64 data),
 
-	TP_ARGS(fs_info, num_bytes, empty_size, data),
+	TP_ARGS(root, num_bytes, empty_size, data),
 
 	TP_STRUCT__entry_btrfs(
+		__field(	u64,	root_objectid		)
 		__field(	u64,	num_bytes		)
 		__field(	u64,	empty_size		)
 		__field(	u64,	data			)
 	),
 
-	TP_fast_assign_btrfs(fs_info,
+	TP_fast_assign_btrfs(root->fs_info,
+		__entry->root_objectid	= root->root_key.objectid;
 		__entry->num_bytes	= num_bytes;
 		__entry->empty_size	= empty_size;
 		__entry->data		= data;
 	),
 
 	TP_printk_btrfs("root=%llu(%s) len=%llu empty_size=%llu flags=%llu(%s)",
-		  show_root_type(BTRFS_EXTENT_TREE_OBJECTID),
+		  show_root_type(__entry->root_objectid),
 		  __entry->num_bytes, __entry->empty_size, __entry->data,
 		  __print_flags((unsigned long)__entry->data, "|",
 				 BTRFS_GROUP_FLAGS))
-- 
2.27.0

