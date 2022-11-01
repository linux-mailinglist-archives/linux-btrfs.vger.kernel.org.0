Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1086152D4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKAUMY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiKAUMV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573A01E3F9
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1282D1F38A;
        Tue,  1 Nov 2022 20:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8T6BfnlelydhuVLc5O4xg3+3Ix9azbbpYEJegwgFzaM=;
        b=fm0RZ/dyMshb24FINiM/VNWo3cSq10qRfOnKuiruKJENQF5f8bYcBL+HBJV9XmjlfXD8Xc
        DUGe23gbkL8PFGabGBdeP57hgrLk3ihFL4Djzp4zYGdmTCQwCltDxU52Q0uGCuqRpY8yVc
        ZML72nmn+AW6rj8SxYAvcO18IoYU5os=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 025312C141;
        Tue,  1 Nov 2022 20:12:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F866DA79D; Tue,  1 Nov 2022 21:12:02 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 10/40] btrfs: pass btrfs_inode to btrfs_submit_data_write_bio
Date:   Tue,  1 Nov 2022 21:12:02 +0100
Message-Id: <d9f7a8f3d4c7d9b41a62c1db88b281f509c3e54a.1667331828.git.dsterba@suse.com>
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

The function is for internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/inode.c       | 17 ++++++++---------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a41d4f953bfa..01fc62d39ed2 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -411,7 +411,7 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
 
-void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirror_num);
+void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num);
 void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 			int mirror_num, enum btrfs_compression_type compress_type);
 void btrfs_submit_dio_repair_bio(struct inode *inode, struct bio *bio, int mirror_num);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e770cbc5cb6a..13fba51be32d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -136,7 +136,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	if (!is_data_inode(inode))
 		btrfs_submit_metadata_bio(BTRFS_I(inode), bio, mirror_num);
 	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-		btrfs_submit_data_write_bio(inode, bio, mirror_num);
+		btrfs_submit_data_write_bio(BTRFS_I(inode), bio, mirror_num);
 	else
 		btrfs_submit_data_read_bio(inode, bio, mirror_num,
 					   bio_ctrl->compress_type);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c05b5639337a..f10eb3430756 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2730,14 +2730,13 @@ static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
 	return errno_to_blk_status(ret);
 }
 
-void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirror_num)
+void btrfs_submit_data_write_bio(struct btrfs_inode *inode, struct bio *bio, int mirror_num)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_inode *bi = BTRFS_I(inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	blk_status_t ret;
 
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		ret = extract_ordered_extent(bi, bio,
+		ret = extract_ordered_extent(inode, bio,
 				page_offset(bio_first_bvec_all(bio)->bv_page));
 		if (ret) {
 			btrfs_bio_end_io(btrfs_bio(bio), ret);
@@ -2753,14 +2752,14 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 	 * Csum items for reloc roots have already been cloned at this point,
 	 * so they are handled as part of the no-checksum case.
 	 */
-	if (!(bi->flags & BTRFS_INODE_NODATASUM) &&
+	if (!(inode->flags & BTRFS_INODE_NODATASUM) &&
 	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
-	    !btrfs_is_data_reloc_root(bi->root)) {
-		if (!atomic_read(&bi->sync_writers) &&
-		    btrfs_wq_submit_bio(bi, bio, mirror_num, 0, WQ_SUBMIT_DATA))
+	    !btrfs_is_data_reloc_root(inode->root)) {
+		if (!atomic_read(&inode->sync_writers) &&
+		    btrfs_wq_submit_bio(inode, bio, mirror_num, 0, WQ_SUBMIT_DATA))
 			return;
 
-		ret = btrfs_csum_one_bio(bi, bio, (u64)-1, false);
+		ret = btrfs_csum_one_bio(inode, bio, (u64)-1, false);
 		if (ret) {
 			btrfs_bio_end_io(btrfs_bio(bio), ret);
 			return;
-- 
2.37.3

