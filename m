Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C478B5302C6
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 13:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiEVLs1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 07:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245710AbiEVLsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 07:48:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CDF252AA
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 04:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wMF39HLhj9mX4AXdwxgdnGsSkX8YCCLkzJjToheZgMI=; b=DJrtWxmSwODNgXRsRhjiaRJTgl
        H4NlM/FqQ9Cd3tOuYTg+sU8s5SWCxPAMB8YuvJjYjDSdlsxjzzXXTNEtELSZC/+8Ayf1GUEJ7yk42
        cmLSQfJxyuB43j/3LxxS5kkj52/RtwbRor/clBxG+1P8qOdR9oFcxkEjGq/PcB13ciFjqZma3Vpyk
        k8sF2Mfn4ok9O/d//1s4i66s5i3JyZjNc5XcEUNFI75FDlcZV2hd0ksWKw9eoCBmyaBcmokp6V3Gc
        /Lc+l9ieTOF5llHCaeLCkzfY+MJgqDa0L7sHAK99PSnIgaTG4T64QFwl6y1RL7m3K1ZLZ5mG/BfKf
        5ivOyMIA==;
Received: from [2001:4bb8:19a:6dab:76a3:f7ab:4f04:784a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsk4H-001E68-5z; Sun, 22 May 2022 11:48:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in btrfs_check_read_dio_bio
Date:   Sun, 22 May 2022 13:47:54 +0200
Message-Id: <20220522114754.173685-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220522114754.173685-1-hch@lst.de>
References: <20220522114754.173685-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the new btrfs_bio_for_each_sector iterator to simplify
btrfs_check_read_dio_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 56 +++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 095632977a798..34466b543ed97 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7886,47 +7886,35 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 {
 	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	const u32 sectorsize = fs_info->sectorsize;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
-	struct bio_vec bvec;
-	struct bvec_iter iter;
-	u32 bio_offset = 0;
 	blk_status_t err = BLK_STS_OK;
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	u32 offset;
+
+	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
+		u64 start = bbio->file_offset + offset;
+
+		if (uptodate &&
+		    (!csum || !check_data_csum(inode, bbio, offset, bv.bv_page,
+				bv.bv_offset, start))) {
+			clean_io_failure(fs_info, failure_tree, io_tree, start,
+					 bv.bv_page, btrfs_ino(BTRFS_I(inode)),
+					 bv.bv_offset);
+		} else {
+			int ret;
 
-	__bio_for_each_segment(bvec, &bbio->bio, iter, bbio->iter) {
-		unsigned int i, nr_sectors, pgoff;
-
-		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
-		pgoff = bvec.bv_offset;
-		for (i = 0; i < nr_sectors; i++) {
-			u64 start = bbio->file_offset + bio_offset;
-
-			ASSERT(pgoff < PAGE_SIZE);
-			if (uptodate &&
-			    (!csum || !check_data_csum(inode, bbio,
-						       bio_offset, bvec.bv_page,
-						       pgoff, start))) {
-				clean_io_failure(fs_info, failure_tree, io_tree,
-						 start, bvec.bv_page,
-						 btrfs_ino(BTRFS_I(inode)),
-						 pgoff);
-			} else {
-				int ret;
-
-				ret = btrfs_repair_one_sector(inode, &bbio->bio,
-						bio_offset, bvec.bv_page, pgoff,
-						start, bbio->mirror_num,
-						submit_dio_repair_bio);
-				if (ret)
-					err = errno_to_blk_status(ret);
-			}
-			ASSERT(bio_offset + sectorsize > bio_offset);
-			bio_offset += sectorsize;
-			pgoff += sectorsize;
+			ret = btrfs_repair_one_sector(inode, &bbio->bio, offset,
+					bv.bv_page, bv.bv_offset, start,
+					bbio->mirror_num,
+					submit_dio_repair_bio);
+			if (ret)
+				err = errno_to_blk_status(ret);
 		}
 	}
+
 	return err;
 }
 
-- 
2.30.2

