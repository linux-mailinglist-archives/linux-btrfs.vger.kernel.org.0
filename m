Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95456152CB
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKAUMJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiKAUMG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CB51C92C
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E4860336F9;
        Tue,  1 Nov 2022 20:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q062sFYt0JU/xu4nNA1ljKhLgHFRmNgBb2Zn89fKa4g=;
        b=auVOqXvygR2WVGw5eFRkTltRo1OxQzuAoJc+EGyPjCzSoeonxGUGwRDzFAczT7pIpa+EGI
        mu/hTEqemHoYO9VgwLCeV5oNVLqsPK2BVh25dlGdaEGXZ8w7lGHha83vusg/o/9aEmD3oo
        kS7zLWp4i8aiyMquYpwXoovBl6S9sOs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DD54F2C141;
        Tue,  1 Nov 2022 20:12:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 313A2DA79D; Tue,  1 Nov 2022 21:11:47 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 03/40] btrfs: change how submit bio callback is passed to btrfs_wq_submit_bio
Date:   Tue,  1 Nov 2022 21:11:47 +0100
Message-Id: <78ecd8b8e911d5750ec03b07a159a3ea511481a2.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a callback function parameter for btrfs_wq_submit_bio that can
be one of: metadata, buffered data, direct io data. The callback
abstraction is unnecessary as we have all functions available.

Replace the parameter with a command that leads to a direct call in
run_one_async_start. The called functions can be then simplified and we
can also remove the extent_submit_bio_start_t typedef.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h |  5 +++++
 fs/btrfs/disk-io.c     | 33 +++++++++++++++++++++++----------
 fs/btrfs/disk-io.h     | 12 ++++++++++--
 fs/btrfs/extent_io.h   |  3 ---
 fs/btrfs/inode.c       | 15 +++++++--------
 5 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 62019d7c1cbd..72cf235b7beb 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -415,6 +415,11 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
 void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio, int mirror_num);
+blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
+				    u64 dio_file_offset);
+blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
+					      struct bio *bio,
+					      u64 dio_file_offset);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c099d046170..f2d5677a9e6f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -86,10 +86,10 @@ static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
 struct async_submit_bio {
 	struct inode *inode;
 	struct bio *bio;
-	extent_submit_bio_start_t *submit_bio_start;
+	enum btrfs_wq_submit_cmd submit_cmd;
 	int mirror_num;
 
-	/* Optional parameter for submit_bio_start used by direct io */
+	/* Optional parameter for used by direct io */
 	u64 dio_file_offset;
 	struct btrfs_work work;
 	blk_status_t status;
@@ -637,8 +637,22 @@ static void run_one_async_start(struct btrfs_work *work)
 	blk_status_t ret;
 
 	async = container_of(work, struct  async_submit_bio, work);
-	ret = async->submit_bio_start(async->inode, async->bio,
-				      async->dio_file_offset);
+	switch (async->submit_cmd) {
+	case WQ_SUBMIT_METADATA:
+		ret = btree_submit_bio_start(async->inode, async->bio,
+					     async->dio_file_offset);
+		break;
+	case WQ_SUBMIT_DATA:
+		ret = btrfs_submit_bio_start(async->inode, async->bio,
+					     async->dio_file_offset);
+
+		break;
+	case WQ_SUBMIT_DATA_DIO:
+		ret = btrfs_submit_bio_start_direct_io(async->inode, async->bio,
+						       async->dio_file_offset);
+
+		break;
+	}
 	if (ret)
 		async->status = ret;
 }
@@ -689,8 +703,7 @@ static void run_one_async_free(struct btrfs_work *work)
  * - false in case of error
  */
 bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
-			 u64 dio_file_offset,
-			 extent_submit_bio_start_t *submit_bio_start)
+			 u64 dio_file_offset, enum btrfs_wq_submit_cmd cmd)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	struct async_submit_bio *async;
@@ -702,7 +715,7 @@ bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
 	async->inode = inode;
 	async->bio = bio;
 	async->mirror_num = mirror_num;
-	async->submit_bio_start = submit_bio_start;
+	async->submit_cmd = cmd;
 
 	btrfs_init_work(&async->work, run_one_async_start, run_one_async_done,
 			run_one_async_free);
@@ -736,8 +749,8 @@ static blk_status_t btree_csum_one_bio(struct bio *bio)
 	return errno_to_blk_status(ret);
 }
 
-static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
-					   u64 dio_file_offset)
+blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
+				    u64 dio_file_offset)
 {
 	/*
 	 * when we're called for a write, we're already in the async
@@ -776,7 +789,7 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 	 * happen in parallel across all CPUs.
 	 */
 	if (should_async_write(fs_info, BTRFS_I(inode)) &&
-	    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, btree_submit_bio_start))
+	    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, WQ_SUBMIT_METADATA))
 		return;
 
 	ret = btree_csum_one_bio(bio);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 6edc66b4b4d3..5998b2589830 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -113,9 +113,17 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_read_extent_buffer(struct extent_buffer *buf, u64 parent_transid,
 			     int level, struct btrfs_key *first_key);
+
+enum btrfs_wq_submit_cmd {
+	WQ_SUBMIT_METADATA,
+	WQ_SUBMIT_DATA,
+	WQ_SUBMIT_DATA_DIO,
+};
+
 bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
-			 u64 dio_file_offset,
-			 extent_submit_bio_start_t *submit_bio_start);
+			 u64 dio_file_offset, enum btrfs_wq_submit_cmd cmd);
+blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
+				    u64 dio_file_offset);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 321680f229c6..b3d4b568fe33 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -70,9 +70,6 @@ struct extent_io_tree;
 int __init extent_buffer_init_cachep(void);
 void __cold extent_buffer_free_cachep(void);
 
-typedef blk_status_t (extent_submit_bio_start_t)(struct inode *inode,
-		struct bio *bio, u64 dio_file_offset);
-
 #define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE)
 struct extent_buffer {
 	u64 start;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da9d3a8e2d93..962e39b4f7cb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2550,8 +2550,8 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
  * At IO completion time the cums attached on the ordered extent record
  * are inserted into the btree
  */
-static blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
-					   u64 dio_file_offset)
+blk_status_t btrfs_submit_bio_start(struct inode *inode, struct bio *bio,
+				    u64 dio_file_offset)
 {
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
 }
@@ -2758,8 +2758,7 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
 	    !btrfs_is_data_reloc_root(bi->root)) {
 		if (!atomic_read(&bi->sync_writers) &&
-		    btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
-					btrfs_submit_bio_start))
+		    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, WQ_SUBMIT_DATA))
 			return;
 
 		ret = btrfs_csum_one_bio(bi, bio, (u64)-1, false);
@@ -7966,9 +7965,9 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 	return err;
 }
 
-static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
-						     struct bio *bio,
-						     u64 dio_file_offset)
+blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
+					      struct bio *bio,
+					      u64 dio_file_offset)
 {
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, false);
 }
@@ -8016,7 +8015,7 @@ static void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
 		/* Check btrfs_submit_data_write_bio() for async submit rules */
 		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers) &&
 		    btrfs_wq_submit_bio(inode, bio, 0, file_offset,
-					btrfs_submit_bio_start_direct_io))
+					WQ_SUBMIT_DATA_DIO))
 			return;
 
 		/*
-- 
2.37.3

