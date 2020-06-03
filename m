Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CC31EC909
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFCF4D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgFCFz6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 083A4B003;
        Wed,  3 Jun 2020 05:55:59 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 24/46] btrfs: Make __endio_write_update_ordered take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:24 +0300
Message-Id: <20200603055546.3889-25-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It really wants btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 561bd8b4d7f3..964ebc0a8413 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -89,7 +89,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 ram_bytes, int compress_type,
 				       int type);

-static void __endio_write_update_ordered(struct inode *inode,
+static void __endio_write_update_ordered(struct btrfs_inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate);

@@ -133,7 +133,8 @@ static inline void btrfs_cleanup_ordered_extents(struct inode *inode,
 		bytes -= PAGE_SIZE;
 	}

-	return __endio_write_update_ordered(inode, offset, bytes, false);
+	return __endio_write_update_ordered(BTRFS_I(inode), offset, bytes,
+					    false);
 }

 static int btrfs_dirty_inode(struct inode *inode);
@@ -7422,7 +7423,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		pos += submitted;
 		length -= submitted;
 		if (write)
-			__endio_write_update_ordered(inode, pos, length, false);
+			__endio_write_update_ordered(BTRFS_I(inode), pos,
+						     length, false);
 		else
 			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
 				      pos + length - 1);
@@ -7454,7 +7456,8 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 		return;

 	if (bio_op(dip->dio_bio) == REQ_OP_WRITE) {
-		__endio_write_update_ordered(dip->inode, dip->logical_offset,
+		__endio_write_update_ordered(BTRFS_I(dip->inode),
+					     dip->logical_offset,
 					     dip->bytes,
 					     !dip->dio_bio->bi_status);
 	} else {
@@ -7540,25 +7543,25 @@ static blk_status_t btrfs_check_read_dio_bio(struct inode *inode,
 	return err;
 }

-static void __endio_write_update_ordered(struct inode *inode,
+static void __endio_write_update_ordered(struct btrfs_inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_ordered_extent *ordered = NULL;
 	struct btrfs_workqueue *wq;
 	u64 ordered_offset = offset;
 	u64 ordered_bytes = bytes;
 	u64 last_offset;

-	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
+	if (btrfs_is_free_space_inode(inode))
 		wq = fs_info->endio_freespace_worker;
 	else
 		wq = fs_info->endio_write_workers;

 	while (ordered_offset < offset + bytes) {
 		last_offset = ordered_offset;
-		if (btrfs_dec_test_first_ordered_pending(BTRFS_I(inode), &ordered,
+		if (btrfs_dec_test_first_ordered_pending(inode, &ordered,
 							 &ordered_offset,
 							 ordered_bytes,
 							 uptodate)) {
--
2.17.1

