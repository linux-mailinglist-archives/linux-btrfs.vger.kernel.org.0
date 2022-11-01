Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC286152E4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKAUMy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiKAUMx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF5F1E3F9
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D53A6336C4;
        Tue,  1 Nov 2022 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HN2kQr3Vtk2PnegEry9C5CTtnU53bEvbPQVF8L2E/0Y=;
        b=sSKaTRWhqzcdpeR9fZPewZtJahI+ZJtiABtLfW9ZMpq+lETQZp6byhl+gi4lMqFg6VZKDu
        2GNWpRUK3917UbeaTvuQjNOAnqtcYAS3ekgluisson+oJladbmVezBE9Vc42erQhHmqUJD
        DzaQKR+6DST2Ufp/GVVaXM+PWMefHFk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CE4142C141;
        Tue,  1 Nov 2022 20:12:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2A446DA79D; Tue,  1 Nov 2022 21:12:30 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 23/40] btrfs: pass btrfs_inode to btrfs_check_data_csum
Date:   Tue,  1 Nov 2022 21:12:30 +0100
Message-Id: <3c6fbfd362adb7dbac13309de1246b36af6ba240.1667331828.git.dsterba@suse.com>
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
 fs/btrfs/btrfs_inode.h |  4 +---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/inode.c       | 15 +++++++--------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 279bbbc59dc6..ba0dbdc91ec5 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -421,13 +421,11 @@ blk_status_t btrfs_submit_bio_start_direct_io(struct btrfs_inode *inode,
 					      u64 dio_file_offset);
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
-int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
+int btrfs_check_data_csum(struct btrfs_inode *inode, struct btrfs_bio *bbio,
 			  u32 bio_offset, struct page *page, u32 pgoff);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
-int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
-			  u32 bio_offset, struct page *page, u32 pgoff);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
 			      u64 *ram_bytes, bool nowait, bool strict);
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7e9135ddaebb..a58aab446b1f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -186,7 +186,7 @@ static void end_compressed_bio_read(struct btrfs_bio *bbio)
 		u64 start = bbio->file_offset + offset;
 
 		if (!status &&
-		    (!csum || !btrfs_check_data_csum(inode, bbio, offset,
+		    (!csum || !btrfs_check_data_csum(bi, bbio, offset,
 						     bv.bv_page, bv.bv_offset))) {
 			btrfs_clean_io_failure(bi, start, bv.bv_page,
 					       bv.bv_offset);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3e2cb80c6c63..b0504743613c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3490,10 +3490,10 @@ static u8 *btrfs_csum_ptr(const struct btrfs_fs_info *fs_info, u8 *csums, u64 of
  * When csum mismatch is detected, we will also report the error and fill the
  * corrupted range with zero. (Thus it needs the extra parameters)
  */
-int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
+int btrfs_check_data_csum(struct btrfs_inode *inode, struct btrfs_bio *bbio,
 			  u32 bio_offset, struct page *page, u32 pgoff)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u32 len = fs_info->sectorsize;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
@@ -3507,8 +3507,7 @@ int btrfs_check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	return 0;
 
 zeroit:
-	btrfs_print_data_csum_error(BTRFS_I(inode),
-				    bbio->file_offset + bio_offset,
+	btrfs_print_data_csum_error(inode, bbio->file_offset + bio_offset,
 				    csum, csum_expected, bbio->mirror_num);
 	if (bbio->device)
 		btrfs_dev_stat_inc_and_print(bbio->device,
@@ -3573,7 +3572,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 					  EXTENT_NODATASUM);
 			continue;
 		}
-		ret = btrfs_check_data_csum(inode, bbio, bio_offset, page, pg_off);
+		ret = btrfs_check_data_csum(BTRFS_I(inode), bbio, bio_offset, page, pg_off);
 		if (ret < 0) {
 			const int nr_bit = (pg_off - offset_in_page(start)) >>
 				     root->fs_info->sectorsize_bits;
@@ -7942,8 +7941,8 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 		u64 start = bbio->file_offset + offset;
 
 		if (uptodate &&
-		    (!csum || !btrfs_check_data_csum(inode, bbio, offset, bv.bv_page,
-					       bv.bv_offset))) {
+		    (!csum || !btrfs_check_data_csum(BTRFS_I(inode), bbio, offset,
+						     bv.bv_page, bv.bv_offset))) {
 			btrfs_clean_io_failure(BTRFS_I(inode), start,
 					       bv.bv_page, bv.bv_offset);
 		} else {
@@ -10333,7 +10332,7 @@ static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
 		pgoff = bvec->bv_offset;
 		for (i = 0; i < nr_sectors; i++) {
 			ASSERT(pgoff < PAGE_SIZE);
-			if (btrfs_check_data_csum(&inode->vfs_inode, bbio, bio_offset,
+			if (btrfs_check_data_csum(inode, bbio, bio_offset,
 					    bvec->bv_page, pgoff))
 				return BLK_STS_IOERR;
 			bio_offset += sectorsize;
-- 
2.37.3

