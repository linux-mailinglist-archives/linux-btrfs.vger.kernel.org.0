Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8983E5153C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380031AbiD2SfO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380027AbiD2SfO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:35:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529EACB03C
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:31:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EEF6D1F893;
        Fri, 29 Apr 2022 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651257113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hn09VCrayHgJD9ko7LoWcxM+1QHELaUwaeUVR8Pg/6c=;
        b=Bbgw85edLe+nYDsS1lFbyps9eNx+dcYg9IxmAoJfAjFW54fGU2uvyDcTWNbXAFSIh0gMD1
        K7SKlD+OuKmUrYpQQlKL6kQ7wL4MheEjEYacb76QSzWR7HlZgSKAVgHXuuGzP4EJ0sFTfN
        Q0uP9E2op0HJYlXngQKG26hRj9zJ5JQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E721A2C143;
        Fri, 29 Apr 2022 18:31:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 588C8DA7DE; Fri, 29 Apr 2022 20:27:46 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 9/9] btrfs: rename bio_ctrl::bio_flags to compress_type
Date:   Fri, 29 Apr 2022 20:27:46 +0200
Message-Id: <b0e40d3891317a39aa94e0e7299ee140459c00db.1651255990.git.dsterba@suse.com>
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

The bio_ctrl is the last use of bio_flags that has been converted to
compress type everywhere else.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d757ccd8f6cc..95093b0f09b0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -144,7 +144,7 @@ struct tree_entry {
  */
 struct btrfs_bio_ctrl {
 	struct bio *bio;
-	unsigned long bio_flags;
+	unsigned int compress_type;
 	u32 len_to_stripe_boundary;
 	u32 len_to_oe_boundary;
 };
@@ -3270,10 +3270,10 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	ASSERT(bio);
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
 	ASSERT(bio_ctrl->len_to_oe_boundary && bio_ctrl->len_to_stripe_boundary);
-	if (bio_ctrl->bio_flags != compress_type)
+	if (bio_ctrl->compress_type != compress_type)
 		return 0;
 
-	if (bio_ctrl->bio_flags != BTRFS_COMPRESS_NONE)
+	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
 		contig = bio->bi_iter.bi_sector == sector;
 	else
 		contig = bio_end_sector(bio) == sector;
@@ -3316,7 +3316,7 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	 * The split happens for real compressed bio, which happens in
 	 * btrfs_submit_compressed_read/write().
 	 */
-	if (bio_ctrl->bio_flags != BTRFS_COMPRESS_NONE) {
+	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE) {
 		bio_ctrl->len_to_oe_boundary = U32_MAX;
 		bio_ctrl->len_to_stripe_boundary = U32_MAX;
 		return 0;
@@ -3375,7 +3375,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	else
 		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
 	bio_ctrl->bio = bio;
-	bio_ctrl->bio_flags = compress_type;
+	bio_ctrl->compress_type = compress_type;
 	bio->bi_end_io = end_io_func;
 	bio->bi_private = &inode->io_tree;
 	bio->bi_opf = opf;
@@ -3455,7 +3455,7 @@ static int submit_extent_page(unsigned int opf,
 	ASSERT(pg_offset < PAGE_SIZE && size <= PAGE_SIZE &&
 	       pg_offset + size <= PAGE_SIZE);
 	if (force_bio_submit && bio_ctrl->bio) {
-		submit_one_bio(bio_ctrl->bio, mirror_num, bio_ctrl->bio_flags);
+		submit_one_bio(bio_ctrl->bio, mirror_num, bio_ctrl->compress_type);
 		bio_ctrl->bio = NULL;
 	}
 
@@ -3497,7 +3497,7 @@ static int submit_extent_page(unsigned int opf,
 		if (added < size - offset) {
 			/* The bio should contain some page(s) */
 			ASSERT(bio_ctrl->bio->bi_iter.bi_size);
-			submit_one_bio(bio_ctrl->bio, mirror_num, bio_ctrl->bio_flags);
+			submit_one_bio(bio_ctrl->bio, mirror_num, bio_ctrl->compress_type);
 			bio_ctrl->bio = NULL;
 		}
 		cur += added;
@@ -3814,7 +3814,7 @@ int btrfs_readpage(struct file *file, struct page *page)
 	 * bio to do the cleanup.
 	 */
 	if (bio_ctrl.bio)
-		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
+		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.compress_type);
 	return ret;
 }
 
@@ -5273,7 +5273,7 @@ void extent_readahead(struct readahead_control *rac)
 		free_extent_map(em_cached);
 
 	if (bio_ctrl.bio)
-		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
+		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.compress_type);
 }
 
 /*
@@ -6760,7 +6760,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	}
 
 	if (bio_ctrl.bio) {
-		submit_one_bio(bio_ctrl.bio, mirror_num, bio_ctrl.bio_flags);
+		submit_one_bio(bio_ctrl.bio, mirror_num, bio_ctrl.compress_type);
 		bio_ctrl.bio = NULL;
 	}
 
-- 
2.34.1

