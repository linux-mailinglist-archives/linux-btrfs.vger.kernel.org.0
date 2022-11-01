Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3166152CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKAUMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKAUMF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B361E3CB
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 98439336F4;
        Tue,  1 Nov 2022 20:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wb7rGO8xz/7Z3JLON6ils6X9E4qwhNY8CxFegs8XkE=;
        b=VZYtw3iGmLBfwmKwl33oLR+Kvy6AR3TDCE9RFCHlEu7sqp2iUQRQN9oOYYhUrXKBQxq1hs
        m5mlk92R9jFmBIWhquskakhqrAuIJnNkptslIbndlQy+wEh8hZ0d8dBBKm/Ebt2+0SGpwF
        /n34FDiN/Y3oWCkBJ3sX8H5j6JF/pKk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 904A52C142;
        Tue,  1 Nov 2022 20:11:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E0D46DA79D; Tue,  1 Nov 2022 21:11:42 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 01/40] btrfs: change how repair action is passed to btrfs_repair_one_sector
Date:   Tue,  1 Nov 2022 21:11:42 +0100
Message-Id: <76a74d0aca9d0c16bab3bb1811b3f86f572b03ab.1667331828.git.dsterba@suse.com>
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

There's a function pointer passed to btrfs_repair_one_sector that will
submit the right bio for repair. However there are only two callbacks,
for buffered and for direct IO. This can be simplified to a bool-based
switch and call either function, indirect calls in this case is an
unnecessary abstraction. This allows to remove the submit_bio_hook_t
typedef.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h |  3 +++
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/extent_io.c   | 14 +++++++++-----
 fs/btrfs/extent_io.h   |  6 +-----
 fs/btrfs/inode.c       |  9 ++++-----
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d21c30bf7053..fa0c72cabd8f 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -414,6 +414,9 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirror_num);
 void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
+void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio,
+				 int mirror_num,
+				 enum btrfs_compression_type compress_type);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 52df6c06cc91..e84764ef250b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -196,7 +196,7 @@ static void end_compressed_bio_read(struct btrfs_bio *bbio)
 			refcount_inc(&cb->pending_ios);
 			ret = btrfs_repair_one_sector(inode, bbio, offset,
 						      bv.bv_page, bv.bv_offset,
-						      btrfs_submit_data_read_bio);
+						      true);
 			if (ret) {
 				refcount_dec(&cb->pending_ios);
 				status = errno_to_blk_status(ret);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2ec989b83f54..44ff41304247 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -797,7 +797,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 
 int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 			    u32 bio_offset, struct page *page, unsigned int pgoff,
-			    submit_bio_hook_t *submit_bio_hook)
+			    bool submit_buffered)
 {
 	u64 start = failed_bbio->file_offset + bio_offset;
 	struct io_failure_record *failrec;
@@ -856,11 +856,15 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 		    failrec->this_mirror);
 
 	/*
-	 * At this point we have a bio, so any errors from submit_bio_hook()
-	 * will be handled by the endio on the repair_bio, so we can't return an
+	 * At this point we have a bio, so any errors from bio submission will
+	 * be handled by the endio on the repair_bio, so we can't return an
 	 * error here.
 	 */
-	submit_bio_hook(inode, repair_bio, failrec->this_mirror, 0);
+	if (submit_buffered)
+		btrfs_submit_data_read_bio(inode, repair_bio, failrec->this_mirror, 0);
+	else
+		btrfs_submit_dio_repair_bio(inode, repair_bio, failrec->this_mirror, 0);
+
 	return BLK_STS_OK;
 }
 
@@ -951,7 +955,7 @@ static void submit_data_read_repair(struct inode *inode,
 
 		ret = btrfs_repair_one_sector(inode, failed_bbio,
 				bio_offset + offset, page, pgoff + offset,
-				btrfs_submit_data_read_bio);
+				true);
 		if (!ret) {
 			/*
 			 * We have submitted the read repair, the page release
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a5ec1475988f..321680f229c6 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -70,10 +70,6 @@ struct extent_io_tree;
 int __init extent_buffer_init_cachep(void);
 void __cold extent_buffer_free_cachep(void);
 
-typedef void (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
-					 int mirror_num,
-					 enum btrfs_compression_type compress_type);
-
 typedef blk_status_t (extent_submit_bio_start_t)(struct inode *inode,
 		struct bio *bio, u64 dio_file_offset);
 
@@ -277,7 +273,7 @@ struct io_failure_record {
 
 int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 			    u32 bio_offset, struct page *page, unsigned int pgoff,
-			    submit_bio_hook_t *submit_bio_hook);
+			    bool submit_buffered);
 void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end);
 int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 			   struct page *page, unsigned int pg_offset);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 255959574724..b9aa805bbe55 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7922,9 +7922,9 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	bio_endio(&dip->bio);
 }
 
-static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
-				  int mirror_num,
-				  enum btrfs_compression_type compress_type)
+void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio,
+				 int mirror_num,
+				 enum btrfs_compression_type compress_type)
 {
 	struct btrfs_dio_private *dip = btrfs_bio(bio)->private;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -7959,8 +7959,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 			int ret;
 
 			ret = btrfs_repair_one_sector(inode, bbio, offset,
-					bv.bv_page, bv.bv_offset,
-					submit_dio_repair_bio);
+					bv.bv_page, bv.bv_offset, false);
 			if (ret)
 				err = errno_to_blk_status(ret);
 		}
-- 
2.37.3

