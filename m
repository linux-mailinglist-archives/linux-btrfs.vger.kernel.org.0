Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5855153BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380029AbiD2SfN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380024AbiD2SfM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:35:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42801C7EBB
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:31:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D2E791F894;
        Fri, 29 Apr 2022 18:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651257111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6L1gdEGjy9bXGMyoTlW0gFtuM1UtQNHUNYRGDu4mHc=;
        b=L0PWBSsK11a8WwmHvkyjAfHw530nymaUOYRLvCf3XYaJ8VrHEtfMlVc4af7V3JfaBX46nd
        898UqWBRG7Tin8OBuH8pQAnolwZbQSRGhhu8zqhgxezjisxdARPV77q/DjeaOB25npqwsN
        C+M5IuloTppXdReJ8q3eaGIC4np/yz0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CAEE02C145;
        Fri, 29 Apr 2022 18:31:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 34618DA7DE; Fri, 29 Apr 2022 20:27:44 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 8/9] btrfs: rename bio_flags in parameters and switch type
Date:   Fri, 29 Apr 2022 20:27:44 +0200
Message-Id: <767562d3faff56665a6e4918d98bcf2e8f743bbf.1651255990.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651255990.git.dsterba@suse.com>
References: <cover.1651255990.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several functions take parameter bio_flags that was simplified to just
compress type, unify it and change the type accordingly.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h     |  2 +-
 fs/btrfs/extent_io.c | 28 ++++++++++++++--------------
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     |  6 +++---
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6834d6913b3d..2811c8df93f4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3252,7 +3252,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 
 /* inode.c */
 void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
-			   int mirror_num, unsigned long bio_flags);
+			   int mirror_num, unsigned int compress_type);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca3d4a6a3b10..d757ccd8f6cc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -178,7 +178,7 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 	return ret;
 }
 
-static void submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_flags)
+static void submit_one_bio(struct bio *bio, int mirror_num, unsigned int compress_type)
 {
 	struct extent_io_tree *tree = bio->bi_private;
 
@@ -189,7 +189,7 @@ static void submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_fl
 
 	if (is_data_inode(tree->private_data))
 		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
-					    bio_flags);
+					    compress_type);
 	else
 		btrfs_submit_metadata_bio(tree->private_data, bio, mirror_num);
 	/*
@@ -3246,7 +3246,7 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
  *                a contiguous page to the previous one
  * @size:	portion of page that we want to write
  * @pg_offset:	starting offset in the page
- * @bio_flags:	flags of the current bio to see if we can merge them
+ * @compress_type:   compression type of the current bio to see if we can merge them
  *
  * Attempt to add a page to bio considering stripe alignment etc.
  *
@@ -3258,7 +3258,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 			      struct page *page,
 			      u64 disk_bytenr, unsigned int size,
 			      unsigned int pg_offset,
-			      unsigned long bio_flags)
+			      unsigned int compress_type)
 {
 	struct bio *bio = bio_ctrl->bio;
 	u32 bio_size = bio->bi_iter.bi_size;
@@ -3270,7 +3270,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	ASSERT(bio);
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
 	ASSERT(bio_ctrl->len_to_oe_boundary && bio_ctrl->len_to_stripe_boundary);
-	if (bio_ctrl->bio_flags != bio_flags)
+	if (bio_ctrl->bio_flags != compress_type)
 		return 0;
 
 	if (bio_ctrl->bio_flags != BTRFS_COMPRESS_NONE)
@@ -3359,7 +3359,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 			 unsigned int opf,
 			 bio_end_io_t end_io_func,
 			 u64 disk_bytenr, u32 offset, u64 file_offset,
-			 unsigned long bio_flags)
+			 unsigned long compress_type)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio;
@@ -3370,12 +3370,12 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
 	 */
-	if (bio_flags != BTRFS_COMPRESS_NONE)
+	if (compress_type != BTRFS_COMPRESS_NONE)
 		bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	else
 		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
 	bio_ctrl->bio = bio;
-	bio_ctrl->bio_flags = bio_flags;
+	bio_ctrl->bio_flags = compress_type;
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = &inode->io_tree;
 	bio->bi_opf = opf;
@@ -3434,7 +3434,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
  * @end_io_func:     end_io callback for new bio
  * @mirror_num:	     desired mirror to read/write
  * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
- * @bio_flags:	flags of the current bio to see if we can merge them
+ * @compress_type:   compress type for current bio
  */
 static int submit_extent_page(unsigned int opf,
 			      struct writeback_control *wbc,
@@ -3443,7 +3443,7 @@ static int submit_extent_page(unsigned int opf,
 			      size_t size, unsigned long pg_offset,
 			      bio_end_io_t end_io_func,
 			      int mirror_num,
-			      unsigned long bio_flags,
+			      unsigned int compress_type,
 			      bool force_bio_submit)
 {
 	int ret = 0;
@@ -3468,7 +3468,7 @@ static int submit_extent_page(unsigned int opf,
 			ret = alloc_new_bio(inode, bio_ctrl, wbc, opf,
 					    end_io_func, disk_bytenr, offset,
 					    page_offset(page) + cur,
-					    bio_flags);
+					    compress_type);
 			if (ret < 0)
 				return ret;
 		}
@@ -3476,14 +3476,14 @@ static int submit_extent_page(unsigned int opf,
 		 * We must go through btrfs_bio_add_page() to ensure each
 		 * page range won't cross various boundaries.
 		 */
-		if (bio_flags != BTRFS_COMPRESS_NONE)
+		if (compress_type != BTRFS_COMPRESS_NONE)
 			added = btrfs_bio_add_page(bio_ctrl, page, disk_bytenr,
 					size - offset, pg_offset + offset,
-					bio_flags);
+					compress_type);
 		else
 			added = btrfs_bio_add_page(bio_ctrl, page,
 					disk_bytenr + offset, size - offset,
-					pg_offset + offset, bio_flags);
+					pg_offset + offset, compress_type);
 
 		/* Metadata page range should never be split */
 		if (!is_data_inode(&inode->vfs_inode))
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 1fa40ab561df..a33bd6140820 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -66,7 +66,7 @@ struct extent_io_tree;
 
 typedef void (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
 					 int mirror_num,
-					 unsigned long bio_flags);
+					 unsigned int compress_type);
 
 typedef blk_status_t (extent_submit_bio_start_t)(struct inode *inode,
 		struct bio *bio, u64 dio_file_offset);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e8db1e7d0ec6..7ebb172ff7ab 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2571,7 +2571,7 @@ static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
  *    c-3) otherwise:			async submit
  */
 void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
-			   int mirror_num, unsigned long bio_flags)
+			   int mirror_num, unsigned int compress_type)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -2600,7 +2600,7 @@ void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 		if (ret)
 			goto out;
 
-		if (bio_flags != BTRFS_COMPRESS_NONE) {
+		if (compress_type != BTRFS_COMPRESS_NONE) {
 			/*
 			 * btrfs_submit_compressed_read will handle completing
 			 * the bio if there were any errors, so just return
@@ -7786,7 +7786,7 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 }
 
 static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
-				  int mirror_num, unsigned long bio_flags)
+				  int mirror_num, unsigned int compress_type)
 {
 	struct btrfs_dio_private *dip = bio->bi_private;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-- 
2.34.1

