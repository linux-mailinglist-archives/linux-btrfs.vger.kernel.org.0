Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7F15C173
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2019 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfGAQu6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 12:50:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:39242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbfGAQu6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 12:50:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 194B4ABC7
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2019 16:50:57 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: Return number of compressed extents directly in compress_file_range
Date:   Mon,  1 Jul 2019 19:50:54 +0300
Message-Id: <20190701165055.15483-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

compress_file_range returns a void, yet uses a function parameter as a
return value. Make that more idiomatic by simply returning the number
of compressed extents directly. Also track such extents in more aptly
named variables. No functional changes

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4e183c2d3555..3b0bf5ea9eb6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -440,8 +440,7 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
  * are written in the same order that the flusher thread sent them
  * down.
  */
-static noinline void compress_file_range(struct async_chunk *async_chunk,
-					 int *num_added)
+static noinline int compress_file_range(struct async_chunk *async_chunk)
 {
 	struct inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -457,6 +456,7 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
 	int i;
 	int will_compress;
 	int compress_type = fs_info->compress_type;
+	int compressed_extents = 0;
 	int redirty = 0;
 
 	inode_should_defrag(BTRFS_I(inode), start, end, end - start + 1,
@@ -619,7 +619,7 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
 		 */
 		total_in = ALIGN(total_in, PAGE_SIZE);
 		if (total_compressed + blocksize <= total_in) {
-			*num_added += 1;
+			compressed_extents += 1;
 
 			/*
 			 * The async work queues will take care of doing actual
@@ -636,7 +636,7 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
 				cond_resched();
 				goto again;
 			}
-			return;
+			return compressed_extents;
 		}
 	}
 	if (pages) {
@@ -675,9 +675,9 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
 		extent_range_redirty_for_io(inode, start, end);
 	add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
 			 BTRFS_COMPRESS_NONE);
-	*num_added += 1;
+	compressed_extents += 1;
 
-	return;
+	return compressed_extents;
 
 free_pages_out:
 	for (i = 0; i < nr_pages; i++) {
@@ -685,6 +685,8 @@ static noinline void compress_file_range(struct async_chunk *async_chunk,
 		put_page(pages[i]);
 	}
 	kfree(pages);
+
+	return 0;
 }
 
 static void free_async_extent_pages(struct async_extent *async_extent)
@@ -1122,12 +1124,12 @@ static noinline int cow_file_range(struct inode *inode,
 static noinline void async_cow_start(struct btrfs_work *work)
 {
 	struct async_chunk *async_chunk;
-	int num_added = 0;
+	int compressed_extents = 0;
 
 	async_chunk = container_of(work, struct async_chunk, work);
 
-	compress_file_range(async_chunk, &num_added);
-	if (num_added == 0) {
+	compressed_extents = compress_file_range(async_chunk);
+	if (compressed_extents == 0) {
 		btrfs_add_delayed_iput(async_chunk->inode);
 		async_chunk->inode = NULL;
 	}
-- 
2.17.1

