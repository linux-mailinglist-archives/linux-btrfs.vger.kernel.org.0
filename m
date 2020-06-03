Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9E41EC911
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgFCFz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:55:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:42468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgFCFz4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 524F7AFF8;
        Wed,  3 Jun 2020 05:55:56 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 07/46] btrfs: Make btrfs_csum_one_bio takae btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:07 +0300
Message-Id: <20200603055546.3889-8-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Will enable converting btrfs_submit_compressed_write to btrfs_inode more
easily.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/compression.c | 5 +++--
 fs/btrfs/ctree.h       | 4 ++--
 fs/btrfs/file-item.c   | 3 +--
 fs/btrfs/inode.c       | 8 ++++----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c6e648603f85..4f52cd8af517 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -475,7 +475,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 			BUG_ON(ret); /* -ENOMEM */

 			if (!skip_sum) {
-				ret = btrfs_csum_one_bio(inode, bio, start, 1);
+				ret = btrfs_csum_one_bio(BTRFS_I(inode), bio,
+							 start, 1);
 				BUG_ON(ret); /* -ENOMEM */
 			}

@@ -507,7 +508,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	BUG_ON(ret); /* -ENOMEM */

 	if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, start, 1);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, start, 1);
 		BUG_ON(ret); /* -ENOMEM */
 	}

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3e8063f9b30a..55add0881615 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2830,8 +2830,8 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
 int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
-blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
-		       u64 file_start, int contig);
+blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
+				u64 file_start, int contig);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 9d311e834b20..7d5ec71615b8 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -522,10 +522,9 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
  *		 means this bio can contains potentially discontigous bio vecs
  *		 so the logical offset of each should be calculated separately.
  */
-blk_status_t btrfs_csum_one_bio(struct inode *vfsinode, struct bio *bio,
+blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 		       u64 file_start, int contig)
 {
-	struct btrfs_inode *inode = BTRFS_I(vfsinode);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct btrfs_ordered_sum *sums;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7615b73feb30..d20afd95ab4d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2149,7 +2149,7 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
 	struct inode *inode = private_data;
 	blk_status_t ret = 0;

-	ret = btrfs_csum_one_bio(inode, bio, 0, 0);
+	ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 	BUG_ON(ret); /* -ENOMEM */
 	return 0;
 }
@@ -2214,7 +2214,7 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 					  0, inode, btrfs_submit_bio_start);
 		goto out;
 	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(inode, bio, 0, 0);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 		if (ret)
 			goto out;
 	}
@@ -7597,7 +7597,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
 {
 	struct inode *inode = private_data;
 	blk_status_t ret;
-	ret = btrfs_csum_one_bio(inode, bio, offset, 1);
+	ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, offset, 1);
 	BUG_ON(ret); /* -ENOMEM */
 	return 0;
 }
@@ -7658,7 +7658,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
-		ret = btrfs_csum_one_bio(inode, bio, file_offset, 1);
+		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, 1);
 		if (ret)
 			goto err;
 	} else {
--
2.17.1

