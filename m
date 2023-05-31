Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4665D717930
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjEaH4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbjEaH4Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:56:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C73610C9
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qex2no4rHB8tdG4a4vKAXZFTSpzIS9X1q4WUvGM8bPQ=; b=NbPXAHR9LKXl+C+eMuFaklkBOx
        L3q23Lezi31eKuT+I9uf3Hlm805sWQjKuDh9BUpDBjgV5ud+0VuXblbb/BA8TYXUdsfUVRijC1Gq9
        VIltXIkyinqOkaY/sdU3CvwbyHQa8zWpO+9S3a0/1VAc+RL1I2aM0iRWh3GWjaoipfYxJsKgNGf+q
        30V66EvIbfdRPYQbeY20+3NEjbvW+03QICAqhJKWgkaeMLrjE48OxBp5s4DUVtOzol+dCv+OQTB1F
        1upj2w+wkEyvtnC74fSH7KWg7ffZzRwIbuQyGe1gANX8XQ/dVM8ERcT5tkH5vp2mqOOANyCpcoG5d
        AdInihzA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Gfb-00GWyM-1G;
        Wed, 31 May 2023 07:54:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 16/17] btrfs: use btrfs_finish_ordered_extent to complete direct writes
Date:   Wed, 31 May 2023 09:54:09 +0200
Message-Id: <20230531075410.480499-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the btrfs_finish_ordered_extent helper to complete compressed writes
using the bbio->ordered pointer instead of requiring an rbtree lookup
in the otherwise equivalent btrfs_mark_ordered_io_finished called from
btrfs_writepage_endio_finish_ordered.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 004b8f77d14d50..3104531891a8b0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7757,8 +7757,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		pos += submitted;
 		length -= submitted;
 		if (write)
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
-						       pos, length, false);
+			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
+						    pos, length, false);
 		else
 			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
 				      pos + length - 1, NULL);
@@ -7788,12 +7788,14 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 			   dip->file_offset, dip->bytes, bio->bi_status);
 	}
 
-	if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-		btrfs_mark_ordered_io_finished(inode, NULL, dip->file_offset,
-					       dip->bytes, !bio->bi_status);
-	else
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
+		btrfs_finish_ordered_extent(bbio->ordered, NULL,
+					    dip->file_offset, dip->bytes,
+					    !bio->bi_status);
+	} else {
 		unlock_extent(&inode->io_tree, dip->file_offset,
 			      dip->file_offset + dip->bytes - 1, NULL);
+	}
 
 	bbio->bio.bi_private = bbio->private;
 	iomap_dio_bio_end_io(bio);
-- 
2.39.2

