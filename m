Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2477A5153C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380022AbiD2SfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380019AbiD2SfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:35:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B756D84E
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:31:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 61FB021878;
        Fri, 29 Apr 2022 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651257105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=stCi+ySlaIK1aCuY7e2I+EEK24io/cH+b0UKmhCk+uA=;
        b=pkIrKHrIGtv/rcJntVTojvpN0FH4Jv9Um/MmssNWC3Iig4XhxpSpuKMQh/zWF9CZhJTKJu
        caAwA1gPN4j8n7jcpNl5ryEsRUPxFYMbEgraFBx8YkJp3ENU0FObffHZDypRkTa4S33HrG
        WdwpXSu36pgvlpDDW/mMvR1Lko6OHPM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5A1E82C141;
        Fri, 29 Apr 2022 18:31:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF4DCDA7DE; Fri, 29 Apr 2022 20:27:37 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/9] btrfs: simplify handling of bio_ctrl::bio_flags
Date:   Fri, 29 Apr 2022 20:27:37 +0200
Message-Id: <53713d1b4ca97a63b046f1f256b43dc5d4b26a8b.1651255990.git.dsterba@suse.com>
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

The bio_flags are used only to encode the compression and there are no
other EXTENT_BIO_* flags, so the compress type can be stored directly.
The struct member name is left unchanged and will be cleaned in later
patches.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 13 ++++++-------
 fs/btrfs/extent_io.h | 11 ++---------
 fs/btrfs/inode.c     |  2 +-
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 15d27cc21750..efea465d0e9b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -29,6 +29,7 @@
 #include "subpage.h"
 #include "zoned.h"
 #include "block-group.h"
+#include "compression.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -2561,7 +2562,6 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	logical = em->block_start + logical;
 	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
 		logical = em->block_start;
-		failrec->bio_flags = EXTENT_BIO_COMPRESSED;
 		extent_set_compress_type(&failrec->bio_flags, em->compress_type);
 	}
 
@@ -3273,7 +3273,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	if (bio_ctrl->bio_flags != bio_flags)
 		return 0;
 
-	if (bio_ctrl->bio_flags & EXTENT_BIO_COMPRESSED)
+	if (bio_ctrl->bio_flags != BTRFS_COMPRESS_NONE)
 		contig = bio->bi_iter.bi_sector == sector;
 	else
 		contig = bio_end_sector(bio) == sector;
@@ -3316,7 +3316,7 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	 * The split happens for real compressed bio, which happens in
 	 * btrfs_submit_compressed_read/write().
 	 */
-	if (bio_ctrl->bio_flags & EXTENT_BIO_COMPRESSED) {
+	if (bio_ctrl->bio_flags != BTRFS_COMPRESS_NONE) {
 		bio_ctrl->len_to_oe_boundary = U32_MAX;
 		bio_ctrl->len_to_stripe_boundary = U32_MAX;
 		return 0;
@@ -3370,7 +3370,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
 	 */
-	if (bio_flags & EXTENT_BIO_COMPRESSED)
+	if (bio_flags != BTRFS_COMPRESS_NONE)
 		bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	else
 		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
@@ -3476,7 +3476,7 @@ static int submit_extent_page(unsigned int opf,
 		 * We must go through btrfs_bio_add_page() to ensure each
 		 * page range won't cross various boundaries.
 		 */
-		if (bio_flags & EXTENT_BIO_COMPRESSED)
+		if (bio_flags != BTRFS_COMPRESS_NONE)
 			added = btrfs_bio_add_page(bio_ctrl, page, disk_bytenr,
 					size - offset, pg_offset + offset,
 					bio_flags);
@@ -3682,7 +3682,6 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		BUG_ON(end < cur);
 
 		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
-			this_bio_flag |= EXTENT_BIO_COMPRESSED;
 			extent_set_compress_type(&this_bio_flag,
 						 em->compress_type);
 		}
@@ -3690,7 +3689,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		iosize = min(extent_map_end(em) - cur, end - cur + 1);
 		cur_end = min(extent_map_end(em) - 1, end);
 		iosize = ALIGN(iosize, blocksize);
-		if (this_bio_flag & EXTENT_BIO_COMPRESSED)
+		if (this_bio_flag != BTRFS_COMPRESS_NONE)
 			disk_bytenr = em->block_start;
 		else
 			disk_bytenr = em->block_start + extent_offset;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index b390ec79f9a8..ba793cb7a3a2 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -9,13 +9,6 @@
 #include <linux/btrfs_tree.h>
 #include "ulist.h"
 
-/*
- * flags for bio submission. The high bits indicate the compression
- * type for this bio
- */
-#define EXTENT_BIO_COMPRESSED 1
-#define EXTENT_BIO_FLAG_SHIFT 16
-
 enum {
 	EXTENT_BUFFER_UPTODATE,
 	EXTENT_BUFFER_DIRTY,
@@ -150,12 +143,12 @@ static inline void extent_changeset_free(struct extent_changeset *changeset)
 static inline void extent_set_compress_type(unsigned long *bio_flags,
 					    int compress_type)
 {
-	*bio_flags |= compress_type << EXTENT_BIO_FLAG_SHIFT;
+	*bio_flags = compress_type;
 }
 
 static inline int extent_compress_type(unsigned long bio_flags)
 {
-	return bio_flags >> EXTENT_BIO_FLAG_SHIFT;
+	return bio_flags;
 }
 
 struct extent_map_tree;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac37e5088fc8..e8db1e7d0ec6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2600,7 +2600,7 @@ void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 		if (ret)
 			goto out;
 
-		if (bio_flags & EXTENT_BIO_COMPRESSED) {
+		if (bio_flags != BTRFS_COMPRESS_NONE) {
 			/*
 			 * btrfs_submit_compressed_read will handle completing
 			 * the bio if there were any errors, so just return
-- 
2.34.1

