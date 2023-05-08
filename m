Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E4C6FB4CD
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjEHQJI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjEHQIy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71896A68
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oaeZPj/1qmhsBjaeSKdSnbSSioncgOKkmXVvgOzHqVs=; b=UMpYIXpZiO/xVyWQn+VZMWo0R8
        e/fb95ivRnqOfxTsVTc065VJv6FdYJd1RTMLn0S5nYdYdMTXBQQs/6yZj30LTANRSuRGcWTUI3OP3
        98e2eLnzMzfOSDebCmkw6i6q/98WGwqYZxVMsc/RiFemTGLYL8WvksEd51mtcZacLcuL6upx2Jl59
        B6XlXrDPAB30Y17sULnEPKYTkbvGDSkx+dI3FrznNIg1/EDUUZLCKAR/E4BlkDB4RSvrGLbjV8YNN
        fs9h2wfQc3cp8ZTChhwfsZmHLiqfurebsWlEz3GiG+NFdAApZoMCMKqP1T2GV2Gsu+ILw+uE9N33c
        F7EtswOA==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pw-000w2n-10;
        Mon, 08 May 2023 16:08:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/21] btrfs: use bbio->ordered in btrfs_csum_one_bio
Date:   Mon,  8 May 2023 09:08:35 -0700
Message-Id: <20230508160843.133013-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
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

Use the ordered_extent pointer in the btrfs_bio instead of looking it
up manually.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/file-item.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1c1cb6373f2c30..1832bf95d33e82 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -721,13 +721,12 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
  */
 blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 {
+	struct btrfs_ordered_extent *ordered = bbio->ordered;
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct bio *bio = &bbio->bio;
-	u64 offset = bbio->file_offset;
 	struct btrfs_ordered_sum *sums;
-	struct btrfs_ordered_extent *ordered = NULL;
 	char *data;
 	struct bvec_iter iter;
 	struct bio_vec bvec;
@@ -753,22 +752,6 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	shash->tfm = fs_info->csum_shash;
 
 	bio_for_each_segment(bvec, bio, iter) {
-		if (!ordered) {
-			ordered = btrfs_lookup_ordered_extent(inode, offset);
-			/*
-			 * The bio range is not covered by any ordered extent,
-			 * must be a code logic error.
-			 */
-			if (unlikely(!ordered)) {
-				WARN(1, KERN_WARNING
-			"no ordered extent for root %llu ino %llu offset %llu\n",
-				     inode->root->root_key.objectid,
-				     btrfs_ino(inode), offset);
-				kvfree(sums);
-				return BLK_STS_IOERR;
-			}
-		}
-
 		blockcount = BTRFS_BYTES_TO_BLKS(fs_info,
 						 bvec.bv_len + fs_info->sectorsize
 						 - 1);
@@ -781,12 +764,10 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 					    sums->sums + index);
 			kunmap_local(data);
 			index += fs_info->csum_size;
-			offset += fs_info->sectorsize;
 		}
 
 	}
 	btrfs_add_ordered_sum(ordered, sums);
-	btrfs_put_ordered_extent(ordered);
 	return 0;
 }
 
-- 
2.39.2

