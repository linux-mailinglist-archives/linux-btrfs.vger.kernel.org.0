Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2964F123C5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 02:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfLRBT5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 20:19:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:49742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfLRBT4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 20:19:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3F012AF79
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 01:19:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs-progs: disk-io: Verify the bytenr passed in is mapped for read_tree_block()
Date:   Wed, 18 Dec 2019 09:19:39 +0800
Message-Id: <20191218011942.9830-4-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218011942.9830-1-wqu@suse.com>
References: <20191218011942.9830-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For a fuzzed image, `btrfs check` will segfault at open_ctree() stage:
  $ btrfs check --mode=lowmem issue_207.raw
  Opening filesystem to check...
  extent_io.c:665: free_extent_buffer_internal: BUG_ON `eb->refs < 0` triggered, value 1
  btrfs(+0x6bf67)[0x56431d278f67]
  btrfs(+0x6c16e)[0x56431d27916e]
  btrfs(alloc_extent_buffer+0x45)[0x56431d279db5]
  btrfs(read_tree_block+0x59)[0x56431d2848f9]
  btrfs(btrfs_setup_all_roots+0x29c)[0x56431d28535c]
  btrfs(+0x78903)[0x56431d285903]
  btrfs(open_ctree_fs_info+0x90)[0x56431d285b60]
  btrfs(+0x45a01)[0x56431d252a01]
  btrfs(main+0x94)[0x56431d2220c4]
  /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7f6e28519153]
  btrfs(_start+0x2e)[0x56431d22235e]

[CAUSE]
The fuzzed image has a strange log root bytenr:
  log_root                61440
  log_root_transid        0

In fact, the log_root seems to be fuzzed, as its transid is 0, which is
invalid.

Note that range [61440, 77824) covers the physical offset of the primary
super block.

The bug is caused by the following sequence:
1. cache for tree block [64K, 68K) is created by open_ctree()
   __open_ctree_fd()
   |- btrfs_setup_chunk_tree_and_device_map()
      |- btrfs_read_sys_array()
         |- sb = btrfs_find_create_tree_block()
         |- free_extent_buffer(sb)

   This created an extent buffer [64K, 68K) in fs_info->extent_cache, then
   reduce the refcount of that eb back to 0, but not freed yet.

2. Try to read that corrupted log root
   __open_ctree_fd()
   |- btrfs_setup_chunk_tree_and_device_map()
   |- btrfs_setup_all_roots()
      |- find_and_setup_log_root()
         |- read_tree_block()
            |- btrfs_find_create_tree_block()
               |- alloc_extent_buffer()

   The final alloc_extent_buffer() will try to free that cached eb
   [64K, 68K), since it doesn't match with current search.
   And since that cached eb is already released (refcount == 0), the
   extra free_extent_buffer() will cause above BUG_ON().

[FIX]
Here we fix it through a more comprehensive method, instead of simply
verifying log_root_transid, here we just don't pollute eb cache when
reading sys chunk array.

So that we won't have an eb cache [64K, 68K), and will error out at
logical mapping phase.

Issue: #207
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent_io.c | 26 ++++++++++++++++++++++++++
 extent_io.h |  2 ++
 volumes.c   |  3 ++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/extent_io.c b/extent_io.c
index d4a68279..7f05a729 100644
--- a/extent_io.c
+++ b/extent_io.c
@@ -765,6 +765,32 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	return eb;
 }
 
+/*
+ * Allocate a dummy extent buffer which won't be inserted into extent
+ * buffer cache.
+ *
+ * This mostly allows super block read write using existing eb infrastructure
+ * without pulluting the eb cache.
+ *
+ * This is especially important to avoid injecting eb->start == SZ_64K, as
+ * fuzzed image could have invalid tree bytenr covers super block range,
+ * and cause ref count underflow.
+ */
+struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
+						u64 bytenr, u32 blocksize)
+{
+	struct extent_buffer *ret;
+
+	ret = __alloc_extent_buffer(fs_info, bytenr, blocksize);
+	if (!ret)
+		return NULL;
+
+	ret->tree = NULL;
+	ret->flags |= EXTENT_BUFFER_DUMMY;
+
+	return ret;
+}
+
 int read_extent_from_disk(struct extent_buffer *eb,
 			  unsigned long offset, unsigned long len)
 {
diff --git a/extent_io.h b/extent_io.h
index 1715acc6..c6b8acf9 100644
--- a/extent_io.h
+++ b/extent_io.h
@@ -149,6 +149,8 @@ struct extent_buffer *find_first_extent_buffer(struct extent_io_tree *tree,
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 bytenr, u32 blocksize);
 struct extent_buffer *btrfs_clone_extent_buffer(struct extent_buffer *src);
+struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
+						u64 bytenr, u32 blocksize);
 void free_extent_buffer(struct extent_buffer *eb);
 void free_extent_buffer_nocache(struct extent_buffer *eb);
 int read_extent_from_disk(struct extent_buffer *eb,
diff --git a/volumes.c b/volumes.c
index 143164f0..44789f20 100644
--- a/volumes.c
+++ b/volumes.c
@@ -2144,7 +2144,8 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 				fs_info->nodesize);
 		return -EINVAL;
 	}
-	sb = btrfs_find_create_tree_block(fs_info, BTRFS_SUPER_INFO_OFFSET);
+	sb = alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET,
+				       BTRFS_SUPER_INFO_SIZE);
 	if (!sb)
 		return -ENOMEM;
 	btrfs_set_buffer_uptodate(sb);
-- 
2.24.1

