Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07043C6A53
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhGMGS3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36750 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhGMGS2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 94544221D2
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bRiuEyXkkun8ut4UK6s93X6ayeghGficPM397ZX/HXI=;
        b=ET/JJSYYTLTFV3FvarnhV6hpWDjCn39JzzzXa8yKW0HpqRZIZZ5b/O+yoC7AqhN1e/NS73
        VxoDgmjIpJSZ83VGBD+YzNmnLddwDFwKBh0zjo+dcjc1uKKyjbwF0SidS59H+I1WFce/3q
        8adA0wS5Qyh2hWDcvF/MgH+YIRlENUc=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D1A7E139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yPu8JIkv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/27] btrfs: refactor submit_compressed_extents()
Date:   Tue, 13 Jul 2021 14:15:04 +0800
Message-Id: <20210713061516.163318-16-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a big hunk of code inside a while() loop, with tons of strange
jump for error handling.

It's definitely not to the code standard of today.

Move the code into a new function, submit_one_async_extent().

Since we're here, also do the following modifications:

- Comment style change
  To follow the current scheme

- Don't fallback to non-compressed write then hitting ENOSPC
  If we hit ENOSPC for compressed write, how could we reserve more space
  for non-compressed write?
  Thus we go error path directly.
  This removes the retry: label.

- Add more comment for super long parameter list
  Explain which parameter is for, so we don't need to check the
  prototype.

- Move the error handling to submit_one_async_extent()
  Thus no strange code like:

  out_free:
	...
	goto again;

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 278 +++++++++++++++++++++++------------------------
 1 file changed, 137 insertions(+), 141 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cb6cb99eb454..7931c4a5bc5d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -838,163 +838,129 @@ static void free_async_extent_pages(struct async_extent *async_extent)
 	async_extent->pages = NULL;
 }
 
-/*
- * phase two of compressed writeback.  This is the ordered portion
- * of the code, which only gets called in the order the work was
- * queued.  We walk all the async extents created by compress_file_range
- * and send them down to the disk.
- */
-static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
+static int submit_one_async_extent(struct btrfs_inode *inode,
+				   struct async_chunk *async_chunk,
+				   struct async_extent *async_extent,
+				   u64 *alloc_hint)
 {
-	struct btrfs_inode *inode = BTRFS_I(async_chunk->inode);
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct async_extent *async_extent;
-	u64 alloc_hint = 0;
+	struct extent_io_tree *io_tree = &inode->io_tree;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key ins;
 	struct extent_map *em;
-	struct btrfs_root *root = inode->root;
-	struct extent_io_tree *io_tree = &inode->io_tree;
 	int ret = 0;
+	u64 start = async_extent->start;
+	u64 end = async_extent->start + async_extent->ram_size - 1;
 
-again:
-	while (!list_empty(&async_chunk->extents)) {
-		async_extent = list_entry(async_chunk->extents.next,
-					  struct async_extent, list);
-		list_del(&async_extent->list);
-
-retry:
-		lock_extent(io_tree, async_extent->start,
-			    async_extent->start + async_extent->ram_size - 1);
-		/* did the compression code fall back to uncompressed IO? */
-		if (!async_extent->pages) {
-			int page_started = 0;
-			unsigned long nr_written = 0;
-
-			/* allocate blocks */
-			ret = cow_file_range(inode, async_chunk->locked_page,
-					     async_extent->start,
-					     async_extent->start +
-					     async_extent->ram_size - 1,
-					     &page_started, &nr_written, 0);
-
-			/* JDM XXX */
+	lock_extent(io_tree, start, end);
 
-			/*
-			 * if page_started, cow_file_range inserted an
-			 * inline extent and took care of all the unlocking
-			 * and IO for us.  Otherwise, we need to submit
-			 * all those pages down to the drive.
-			 */
-			if (!page_started && !ret)
-				extent_write_locked_range(&inode->vfs_inode,
-						  async_extent->start,
-						  async_extent->start +
-						  async_extent->ram_size - 1,
-						  WB_SYNC_ALL);
-			else if (ret && async_chunk->locked_page)
-				unlock_page(async_chunk->locked_page);
-			kfree(async_extent);
-			cond_resched();
-			continue;
-		}
-
-		ret = btrfs_reserve_extent(root, async_extent->ram_size,
-					   async_extent->compressed_size,
-					   async_extent->compressed_size,
-					   0, alloc_hint, &ins, 1, 1);
-		if (ret) {
-			free_async_extent_pages(async_extent);
-
-			if (ret == -ENOSPC) {
-				unlock_extent(io_tree, async_extent->start,
-					      async_extent->start +
-					      async_extent->ram_size - 1);
-
-				/*
-				 * we need to redirty the pages if we decide to
-				 * fallback to uncompressed IO, otherwise we
-				 * will not submit these pages down to lower
-				 * layers.
-				 */
-				extent_range_redirty_for_io(&inode->vfs_inode,
-						async_extent->start,
-						async_extent->start +
-						async_extent->ram_size - 1);
+	/* We have fall back to uncompressed write */
+	if (!async_extent->pages) {
+		int page_started = 0;
+		unsigned long nr_written = 0;
 
-				goto retry;
-			}
-			goto out_free;
-		}
 		/*
-		 * here we're doing allocation and writeback of the
-		 * compressed pages
+		 * Call cow_file_range() to run the delalloc range directly,
+		 * since we won't go to nocow or async path again.
 		 */
-		em = create_io_em(inode, async_extent->start,
-				  async_extent->ram_size, /* len */
-				  async_extent->start, /* orig_start */
-				  ins.objectid, /* block_start */
-				  ins.offset, /* block_len */
-				  ins.offset, /* orig_block_len */
-				  async_extent->ram_size, /* ram_bytes */
-				  async_extent->compress_type,
-				  BTRFS_ORDERED_COMPRESSED);
-		if (IS_ERR(em))
-			/* ret value is not necessary due to void function */
-			goto out_free_reserve;
-		free_extent_map(em);
-
-		ret = btrfs_add_ordered_extent_compress(inode,
-						async_extent->start,
-						ins.objectid,
-						async_extent->ram_size,
-						ins.offset,
-						async_extent->compress_type);
-		if (ret) {
-			btrfs_drop_extent_cache(inode, async_extent->start,
-						async_extent->start +
-						async_extent->ram_size - 1, 0);
-			goto out_free_reserve;
-		}
-		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
-
+		ret = cow_file_range(inode, async_chunk->locked_page,
+				     start, end, &page_started, &nr_written, 0);
 		/*
-		 * clear dirty, set writeback and unlock the pages.
+		 * If @page_started, cow_file_range() inserted an
+		 * inline extent and took care of all the unlocking
+		 * and IO for us.  Otherwise, we need to submit
+		 * all those pages down to the drive.
 		 */
-		extent_clear_unlock_delalloc(inode, async_extent->start,
-				async_extent->start +
-				async_extent->ram_size - 1,
-				NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
-				PAGE_UNLOCK | PAGE_START_WRITEBACK);
-		if (btrfs_submit_compressed_write(inode, async_extent->start,
-				    async_extent->ram_size,
-				    ins.objectid,
-				    ins.offset, async_extent->pages,
-				    async_extent->nr_pages,
-				    async_chunk->write_flags,
-				    async_chunk->blkcg_css)) {
-			const u64 start = async_extent->start;
-			const u64 end = start + async_extent->ram_size - 1;
-
-			btrfs_writepage_endio_finish_ordered(inode, NULL, start,
-							     end, 0);
-
-			extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
-						     PAGE_END_WRITEBACK |
-						     PAGE_SET_ERROR);
-			free_async_extent_pages(async_extent);
-		}
-		alloc_hint = ins.objectid + ins.offset;
+		if (!page_started && !ret)
+			extent_write_locked_range(&inode->vfs_inode, start,
+						  end, WB_SYNC_ALL);
+		else if (ret && async_chunk->locked_page)
+			unlock_page(async_chunk->locked_page);
 		kfree(async_extent);
-		cond_resched();
+		return ret;
+	}
+
+	ret = btrfs_reserve_extent(root, async_extent->ram_size,
+				   async_extent->compressed_size,
+				   async_extent->compressed_size,
+				   0, *alloc_hint, &ins, 1, 1);
+	if (ret) {
+		free_async_extent_pages(async_extent);
+		/*
+		 * Here we used to try again by going back to non-compressed
+		 * path for ENOSPC.
+		 * But we can't reserve space even for compressed size, how
+		 * could it work for uncompressed size which requires larger
+		 * size?
+		 * So here we directly go error path.
+		 */
+		goto out_free;
+	}
+
+	/*
+	 * Here we're doing allocation and writeback of the
+	 * compressed pages
+	 */
+	em = create_io_em(inode, start,
+			  async_extent->ram_size, /* len */
+			  start, /* orig_start */
+			  ins.objectid, /* block_start */
+			  ins.offset, /* block_len */
+			  ins.offset, /* orig_block_len */
+			  async_extent->ram_size, /* ram_bytes */
+			  async_extent->compress_type,
+			  BTRFS_ORDERED_COMPRESSED);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto out_free_reserve;
+	}
+	free_extent_map(em);
+
+	ret = btrfs_add_ordered_extent_compress(inode, start, /* file_offset */
+					ins.objectid,	/* disk_bytenr */
+					async_extent->ram_size, /* num_bytes */
+					ins.offset, /* disk_num_bytes */
+					async_extent->compress_type);
+	if (ret) {
+		btrfs_drop_extent_cache(inode, start, end, 0);
+		goto out_free_reserve;
 	}
-	return;
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+
+	/*
+	 * clear dirty, set writeback and unlock the pages.
+	 */
+	extent_clear_unlock_delalloc(inode, start, end,
+			NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
+			PAGE_UNLOCK | PAGE_START_WRITEBACK);
+	if (btrfs_submit_compressed_write(inode, start, /* file_offset */
+			    async_extent->ram_size, /* num_bytes */
+			    ins.objectid, /* disk_bytenr */
+			    ins.offset, /* compressed_len */
+			    async_extent->pages, /* compressed_pages */
+			    async_extent->nr_pages,
+			    async_chunk->write_flags,
+			    async_chunk->blkcg_css)) {
+		const u64 start = async_extent->start;
+		const u64 end = start + async_extent->ram_size - 1;
+
+		btrfs_writepage_endio_finish_ordered(inode, NULL, start,
+						     end, 0);
+
+		extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
+					     PAGE_END_WRITEBACK |
+					     PAGE_SET_ERROR);
+		free_async_extent_pages(async_extent);
+	}
+	*alloc_hint = ins.objectid + ins.offset;
+	kfree(async_extent);
+	return ret;
+
 out_free_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_free:
-	extent_clear_unlock_delalloc(inode, async_extent->start,
-				     async_extent->start +
-				     async_extent->ram_size - 1,
+	extent_clear_unlock_delalloc(inode, start, end,
 				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW |
 				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
@@ -1002,7 +968,37 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				     PAGE_END_WRITEBACK | PAGE_SET_ERROR);
 	free_async_extent_pages(async_extent);
 	kfree(async_extent);
-	goto again;
+	return ret;
+}
+
+/*
+ * phase two of compressed writeback.  This is the ordered portion
+ * of the code, which only gets called in the order the work was
+ * queued.  We walk all the async extents created by compress_file_range
+ * and send them down to the disk.
+ */
+static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
+{
+	struct btrfs_inode *inode = BTRFS_I(async_chunk->inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct async_extent *async_extent;
+	u64 alloc_hint = 0;
+	int ret = 0;
+
+	while (!list_empty(&async_chunk->extents)) {
+		async_extent = list_entry(async_chunk->extents.next,
+					  struct async_extent, list);
+		list_del(&async_extent->list);
+
+		ret = submit_one_async_extent(inode, async_chunk, async_extent,
+					      &alloc_hint);
+		/* Just for developer */
+		btrfs_debug(fs_info,
+"async extent submission failed root=%lld inode=%llu start=%llu len=%llu ret=%d",
+			    inode->root->root_key.objectid,
+			    btrfs_ino(inode), async_extent->start,
+			    async_extent->ram_size, ret);
+	}
 }
 
 static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
-- 
2.32.0

