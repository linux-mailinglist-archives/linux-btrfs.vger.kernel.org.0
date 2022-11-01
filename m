Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EBB6152D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKAUMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiKAUMa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50801E3D4
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8876F1F8C2;
        Tue,  1 Nov 2022 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6eMxFkuakxSKG0hE26EYOWX40LgVWLxuYweQg4cfcds=;
        b=Aydz4wL5mqOu1L1EIArs74GWB2mfjxLgifntRvvp2Vm1/ByXelwuvPrF7760PMYUW1udX8
        vVC6Q7YGEjJ/nb73yEkLQkAzHhUTblae2GF9x2uGKZo/jfOQbDMQwZaV10LzY5I/Cgy73y
        hIu0S/I4h8ODcxto8CHILerDy1hHhLU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 80DF52C141;
        Tue,  1 Nov 2022 20:12:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CAF5CDA79D; Tue,  1 Nov 2022 21:12:10 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 14/40] btrfs: pass btrfs_inode to btrfs_repair_one_sector
Date:   Tue,  1 Nov 2022 21:12:10 +0100
Message-Id: <c306a4a35bab03018b412d72bdc7bf36d46b420e.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is for internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/extent_io.c   | 17 ++++++++---------
 fs/btrfs/extent_io.h   |  2 +-
 fs/btrfs/inode.c       |  2 +-
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e84764ef250b..7e9135ddaebb 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -194,7 +194,7 @@ static void end_compressed_bio_read(struct btrfs_bio *bbio)
 			int ret;
 
 			refcount_inc(&cb->pending_ios);
-			ret = btrfs_repair_one_sector(inode, bbio, offset,
+			ret = btrfs_repair_one_sector(BTRFS_I(inode), bbio, offset,
 						      bv.bv_page, bv.bv_offset,
 						      true);
 			if (ret) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 192f604ac7ea..05768f7f7872 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -795,13 +795,13 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	return failrec;
 }
 
-int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
+int btrfs_repair_one_sector(struct btrfs_inode *inode, struct btrfs_bio *failed_bbio,
 			    u32 bio_offset, struct page *page, unsigned int pgoff,
 			    bool submit_buffered)
 {
 	u64 start = failed_bbio->file_offset + bio_offset;
 	struct io_failure_record *failrec;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *failed_bio = &failed_bbio->bio;
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
 	struct bio *repair_bio;
@@ -812,7 +812,7 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
-	failrec = btrfs_get_io_failure_record(inode, failed_bbio, bio_offset);
+	failrec = btrfs_get_io_failure_record(&inode->vfs_inode, failed_bbio, bio_offset);
 	if (IS_ERR(failrec))
 		return PTR_ERR(failrec);
 
@@ -830,7 +830,7 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 		btrfs_debug(fs_info,
 			"failed to repair num_copies %d this_mirror %d failed_mirror %d",
 			failrec->num_copies, failrec->this_mirror, failrec->failed_mirror);
-		free_io_failure(BTRFS_I(inode), failrec);
+		free_io_failure(inode, failrec);
 		return -EIO;
 	}
 
@@ -851,7 +851,7 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 	bio_add_page(repair_bio, page, failrec->len, pgoff);
 	repair_bbio->iter = repair_bio->bi_iter;
 
-	btrfs_debug(btrfs_sb(inode->i_sb),
+	btrfs_debug(fs_info,
 		    "repair read error: submitting new read to mirror %d",
 		    failrec->this_mirror);
 
@@ -861,11 +861,10 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 	 * error here.
 	 */
 	if (submit_buffered)
-		btrfs_submit_data_read_bio(BTRFS_I(inode), repair_bio,
+		btrfs_submit_data_read_bio(inode, repair_bio,
 					   failrec->this_mirror, 0);
 	else
-		btrfs_submit_dio_repair_bio(BTRFS_I(inode), repair_bio,
-					    failrec->this_mirror);
+		btrfs_submit_dio_repair_bio(inode, repair_bio, failrec->this_mirror);
 
 	return BLK_STS_OK;
 }
@@ -955,7 +954,7 @@ static void submit_data_read_repair(struct inode *inode,
 			goto next;
 		}
 
-		ret = btrfs_repair_one_sector(inode, failed_bbio,
+		ret = btrfs_repair_one_sector(BTRFS_I(inode), failed_bbio,
 				bio_offset + offset, page, pgoff + offset,
 				true);
 		if (!ret) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index b3d4b568fe33..805e262811b4 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -268,7 +268,7 @@ struct io_failure_record {
 	int num_copies;
 };
 
-int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
+int btrfs_repair_one_sector(struct btrfs_inode *inode, struct btrfs_bio *failed_bbio,
 			    u32 bio_offset, struct page *page, unsigned int pgoff,
 			    bool submit_buffered);
 void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 477d4db2d14e..594fade31002 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7952,7 +7952,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 		} else {
 			int ret;
 
-			ret = btrfs_repair_one_sector(inode, bbio, offset,
+			ret = btrfs_repair_one_sector(BTRFS_I(inode), bbio, offset,
 					bv.bv_page, bv.bv_offset, false);
 			if (ret)
 				err = errno_to_blk_status(ret);
-- 
2.37.3

