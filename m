Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619076152D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKAUMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiKAUMe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA41E72A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9D4821F38A;
        Tue,  1 Nov 2022 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5cKYeRdlda9hMzZq+Td6k7w2QBTpZuYSpc/jqW/MxI0=;
        b=A+IklsXGxbE0mWAO4Zx79np7yUt3m5OxV/FOqqosbZpWiaPo3DHFG7MKXijYsQz31FOnlz
        Ze5wJkrm0b9FLWaIuSKxB5IdqSlvbGjJngu4qQRX9U4ybbYX4PV4eokktmhcfZSFvpzj5z
        cyPcRDiKgkk1nARfo/fVFHv3AROFIX0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 96D632C141;
        Tue,  1 Nov 2022 20:12:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E761FDA79D; Tue,  1 Nov 2022 21:12:12 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 15/40] btrfs: switch btrfs_dio_private::inode to btrfs_inode
Date:   Tue,  1 Nov 2022 21:12:12 +0100
Message-Id: <9f1388053464c8739ab4e4455ce0e745e6db5b22.1667331828.git.dsterba@suse.com>
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

The btrfs_dio_private structure is for internal interfaces so we should
use the btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 594fade31002..652335c0c930 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -84,7 +84,7 @@ struct btrfs_dio_data {
 };
 
 struct btrfs_dio_private {
-	struct inode *inode;
+	struct btrfs_inode *inode;
 
 	/*
 	 * Since DIO can use anonymous page, we cannot use page_offset() to
@@ -7906,11 +7906,11 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 		return;
 
 	if (btrfs_op(&dip->bio) == BTRFS_MAP_WRITE) {
-		btrfs_mark_ordered_io_finished(BTRFS_I(dip->inode), NULL,
+		btrfs_mark_ordered_io_finished(dip->inode, NULL,
 					       dip->file_offset, dip->bytes,
 					       !dip->bio.bi_status);
 	} else {
-		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
+		unlock_extent(&dip->inode->io_tree,
 			      dip->file_offset,
 			      dip->file_offset + dip->bytes - 1, NULL);
 	}
@@ -7933,7 +7933,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 					     struct btrfs_bio *bbio,
 					     const bool uptodate)
 {
-	struct inode *inode = dip->inode;
+	struct inode *inode = &dip->inode->vfs_inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	blk_status_t err = BLK_STS_OK;
@@ -7976,9 +7976,9 @@ static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 	blk_status_t err = bio->bi_status;
 
 	if (err)
-		btrfs_warn(BTRFS_I(dip->inode)->root->fs_info,
+		btrfs_warn(dip->inode->root->fs_info,
 			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d",
-			   btrfs_ino(BTRFS_I(dip->inode)), bio_op(bio),
+			   btrfs_ino(dip->inode), bio_op(bio),
 			   bio->bi_opf, bio->bi_iter.bi_sector,
 			   bio->bi_iter.bi_size, err);
 
@@ -7988,7 +7988,7 @@ static void btrfs_end_dio_bio(struct btrfs_bio *bbio)
 	if (err)
 		dip->bio.bi_status = err;
 
-	btrfs_record_physical_zoned(dip->inode, bbio->file_offset, bio);
+	btrfs_record_physical_zoned(&dip->inode->vfs_inode, bbio->file_offset, bio);
 
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
@@ -8055,7 +8055,7 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	struct btrfs_dio_data *dio_data = iter->private;
 	struct extent_map *em = NULL;
 
-	dip->inode = inode;
+	dip->inode = BTRFS_I(inode);
 	dip->file_offset = file_offset;
 	dip->bytes = dio_bio->bi_iter.bi_size;
 	refcount_set(&dip->refs, 1);
-- 
2.37.3

