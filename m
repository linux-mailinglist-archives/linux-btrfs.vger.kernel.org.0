Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24F621239A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgGBMoG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 08:44:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:54894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgGBMoG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 08:44:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 517C0F3BB;
        Thu,  2 Jul 2020 12:44:03 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/8] btrfs: Streamline btrfs_get_io_failure_record logic
Date:   Thu,  2 Jul 2020 15:23:29 +0300
Message-Id: <20200702122335.9117-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702122335.9117-1-nborisov@suse.com>
References: <20200702122335.9117-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make the function directly return a pointer to a failure record and
adjust callers to handle it. Also refactor the logic inside so that
the case which allocates the failure record for the first time is not
handled in an 'if' arm, saving us a level of indentation. Finally make
the function static as it's not used outside of extent_io.c .

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-io-tree.h |   2 -
 fs/btrfs/extent_io.c      | 131 +++++++++++++++++++-------------------
 2 files changed, 65 insertions(+), 68 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 62eef5b1dfc6..c955b77d8604 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -239,8 +239,6 @@ int set_state_failrec(struct extent_io_tree *tree, u64 start,
 		      struct io_failure_record *failrec);
 void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
 		u64 end);
-int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
-				struct io_failure_record **failrec_ret);
 int free_io_failure(struct extent_io_tree *failure_tree,
 		    struct extent_io_tree *io_tree,
 		    struct io_failure_record *rec);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6f0891ad353b..3a0090ee5e0f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2450,8 +2450,9 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
 	spin_unlock(&failure_tree->lock);
 }
 
-int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
-		struct io_failure_record **failrec_ret)
+static
+struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode,
+						      u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct io_failure_record *failrec;
@@ -2463,64 +2464,7 @@ int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
 	u64 logical;
 
 	failrec = get_state_failrec(failure_tree, start);
-	if (IS_ERR(failrec)) {
-		failrec = kzalloc(sizeof(*failrec), GFP_NOFS);
-		if (!failrec)
-			return -ENOMEM;
-
-		failrec->start = start;
-		failrec->len = end - start + 1;
-		failrec->this_mirror = 0;
-		failrec->bio_flags = 0;
-		failrec->in_validation = 0;
-
-		read_lock(&em_tree->lock);
-		em = lookup_extent_mapping(em_tree, start, failrec->len);
-		if (!em) {
-			read_unlock(&em_tree->lock);
-			kfree(failrec);
-			return -EIO;
-		}
-
-		if (em->start > start || em->start + em->len <= start) {
-			free_extent_map(em);
-			em = NULL;
-		}
-		read_unlock(&em_tree->lock);
-		if (!em) {
-			kfree(failrec);
-			return -EIO;
-		}
-
-		logical = start - em->start;
-		logical = em->block_start + logical;
-		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
-			logical = em->block_start;
-			failrec->bio_flags = EXTENT_BIO_COMPRESSED;
-			extent_set_compress_type(&failrec->bio_flags,
-						 em->compress_type);
-		}
-
-		btrfs_debug(fs_info,
-			"Get IO Failure Record: (new) logical=%llu, start=%llu, len=%llu",
-			logical, start, failrec->len);
-
-		failrec->logical = logical;
-		free_extent_map(em);
-
-		/* set the bits in the private failure tree */
-		ret = set_extent_bits(failure_tree, start, end,
-					EXTENT_LOCKED | EXTENT_DIRTY);
-		if (ret >= 0)
-			ret = set_state_failrec(failure_tree, start, failrec);
-		/* set the bits in the inode's tree */
-		if (ret >= 0)
-			ret = set_extent_bits(tree, start, end, EXTENT_DAMAGED);
-		if (ret < 0) {
-			kfree(failrec);
-			return ret;
-		}
-	} else {
+	if (!IS_ERR(failrec)) {
 		btrfs_debug(fs_info,
 			"Get IO Failure Record: (found) logical=%llu, start=%llu, len=%llu, validation=%d",
 			failrec->logical, failrec->start, failrec->len,
@@ -2530,11 +2474,67 @@ int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
 		 * (e.g. with a list for failed_mirror) to make
 		 * clean_io_failure() clean all those errors at once.
 		 */
+
+		return failrec;
 	}
 
-	*failrec_ret = failrec;
+	failrec = kzalloc(sizeof(*failrec), GFP_NOFS);
+	if (!failrec)
+		return ERR_PTR(-ENOMEM);
 
-	return 0;
+	failrec->start = start;
+	failrec->len = end - start + 1;
+	failrec->this_mirror = 0;
+	failrec->bio_flags = 0;
+	failrec->in_validation = 0;
+
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, start, failrec->len);
+	if (!em) {
+		read_unlock(&em_tree->lock);
+		kfree(failrec);
+		return ERR_PTR(-EIO);
+	}
+
+	if (em->start > start || em->start + em->len <= start) {
+		free_extent_map(em);
+		em = NULL;
+	}
+	read_unlock(&em_tree->lock);
+	if (!em) {
+		kfree(failrec);
+		return ERR_PTR(-EIO);
+	}
+
+	logical = start - em->start;
+	logical = em->block_start + logical;
+	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
+		logical = em->block_start;
+		failrec->bio_flags = EXTENT_BIO_COMPRESSED;
+		extent_set_compress_type(&failrec->bio_flags,
+					 em->compress_type);
+	}
+
+	btrfs_debug(fs_info,
+		    "Get IO Failure Record: (new) logical=%llu, start=%llu, len=%llu",
+		    logical, start, failrec->len);
+
+	failrec->logical = logical;
+	free_extent_map(em);
+
+	/* set the bits in the private failure tree */
+	ret = set_extent_bits(failure_tree, start, end,
+			      EXTENT_LOCKED | EXTENT_DIRTY);
+	if (ret >= 0) {
+		ret = set_state_failrec(failure_tree, start, failrec);
+		/* set the bits in the inode's tree */
+		ret = set_extent_bits(tree, start, end, EXTENT_DAMAGED);
+	} else if (ret < 0) {
+		kfree(failrec);
+		return ERR_PTR(ret);
+	}
+
+	return failrec;
 }
 
 static bool btrfs_check_repairable(struct inode *inode, bool needs_validation,
@@ -2659,16 +2659,15 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 	struct bio *repair_bio;
 	struct btrfs_io_bio *repair_io_bio;
 	blk_status_t status;
-	int ret;
 
 	btrfs_debug(fs_info,
 		   "repair read error: read error at %llu", start);
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
-	ret = btrfs_get_io_failure_record(inode, start, end, &failrec);
-	if (ret)
-		return errno_to_blk_status(ret);
+	failrec = btrfs_get_io_failure_record(inode, start, end);
+	if (IS_ERR(failrec))
+		return errno_to_blk_status(PTR_ERR(failrec));
 
 	need_validation = btrfs_io_needs_validation(inode, failed_bio);
 
-- 
2.17.1

