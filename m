Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8699535BC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349814AbiE0Ino (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349807AbiE0Inm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:43:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A542AC53
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 01:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8yjf+T+H978dkR6H1s5RjqZsxsoHY9pvIhFsqRmgP8Q=; b=hUiNsVJlWxaLrGOU4shwE9eEo5
        yJlANk2Y8F52KbG95wmAudb9+yf912Uqf3Q2PQL07qgk4kjdyu9zvTwNomLwe4ct3mQdAvz0Mt4kx
        CLLSotM3RXOrL6VXIsYGvSMBRBjPdmt2YX360QCiWYa9i+CeEAjcZBLUDXwylW2otOtvWOgRolKvn
        JUwCBJF9ZpI5USzraLQtW43C4l9UGL5kzPXQo2SP1UiXmgCBTfnXg/Jb8vNWX3njJt+g8C5+FIRWR
        KqtTTMZdm/4tfPhKQ7GwgdL9m+ufqfVeAARiS7z7Q2NIt1oHJosNLSomECFlV4Q/BdjfdKMsdW/cf
        o6l8QIHg==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVZJ-00H3YA-NC; Fri, 27 May 2022 08:43:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 6/9] btrfs: use the new read repair code for direct I/O
Date:   Fri, 27 May 2022 10:43:17 +0200
Message-Id: <20220527084320.2130831-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220527084320.2130831-1-hch@lst.de>
References: <20220527084320.2130831-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rewrite btrfs_check_read_dio_bio to use btrfs_bio_for_each_sector and
start/end a repair session as needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e6195b9490b6b..76575b1bf30ad 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,6 +55,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "read-repair.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -7853,55 +7854,34 @@ static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
 	bio_endio(&dip->bio);
 }
 
-static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
-				  int mirror_num,
-				  enum btrfs_compression_type compress_type)
-{
-	struct btrfs_dio_private *dip = bio->bi_private;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-
-	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
-
-	refcount_inc(&dip->refs);
-	if (btrfs_map_bio(fs_info, bio, mirror_num))
-		refcount_dec(&dip->refs);
-}
-
 static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 					     struct btrfs_bio *bbio,
 					     const bool uptodate)
 {
 	struct inode *inode = dip->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
+	struct btrfs_read_repair rr = { };
 	blk_status_t err = BLK_STS_OK;
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	u32 offset;
 
 	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
-		u64 start = bbio->file_offset + offset;
-
 		if (uptodate &&
 		    (!csum || !check_data_csum(inode, bbio, offset, bv.bv_page,
-					       bv.bv_offset, start))) {
-			clean_io_failure(fs_info, failure_tree, io_tree, start,
-					 bv.bv_page, btrfs_ino(BTRFS_I(inode)),
-					 bv.bv_offset);
+				bv.bv_offset, bbio->file_offset + offset))) {
+			if (!btrfs_read_repair_finish(&rr, bbio, inode, offset,
+					NULL))
+				err = BLK_STS_IOERR;
 		} else {
-			int ret;
-
-			ret = btrfs_repair_one_sector(inode, &bbio->bio, offset,
-					bv.bv_page, bv.bv_offset, start,
-					bbio->mirror_num,
-					submit_dio_repair_bio);
-			if (ret)
-				err = errno_to_blk_status(ret);
+			if (!btrfs_read_repair_add(&rr, bbio, inode, offset))
+				err = BLK_STS_IOERR;
 		}
 	}
 
+	if (!btrfs_read_repair_finish(&rr, bbio, inode, offset, NULL))
+		err = BLK_STS_IOERR;
 	return err;
 }
 
-- 
2.30.2

