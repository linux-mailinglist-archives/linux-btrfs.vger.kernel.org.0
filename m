Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2498954F4CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381505AbiFQKEr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbiFQKEq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:04:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2506769738
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Tw/qaoAo1DloOIER5MoRusYgmzquzukgQUlugBsVi54=; b=agAQCuSzYJ41fgpNy/q9jUo3qH
        dChdunFhQci4IyxWg9QVeDk1tBdrAAH3EmM8A+4u10yMWm9OXOJmosnnLQygv0MR0wd+DiGf3gl70
        gQtao50O3ab5fkxkxjY+vbZbXhpFmWUAlfZ1hZWiWhAf/T4FuuNxmwL0tOZ7Z4C3y7FK/P47yWl50
        im4R/O4XK1AzLiQcqlR1GtVAICFVXCwonL9q05wvRXA/skhdmiiLf0gTRQSHLc1I/ziIacUOO5QG8
        1CAUnPiZC4hvukvTfwV03wh22RTVZ8rMkIQbHUJC7tFmbUjWBrCW2gHSZqAhce0EzyvKOY7RUMGQX
        AAj0u7Iw==;
Received: from [2001:4bb8:180:36f6:9c91:42c8:8d10:d7ed] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o28qK-006smz-DS; Fri, 17 Jun 2022 10:04:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs: remove the btrfs_submit_dio_bio return value
Date:   Fri, 17 Jun 2022 12:04:13 +0200
Message-Id: <20220617100414.1159680-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220617100414.1159680-1-hch@lst.de>
References: <20220617100414.1159680-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Always consume the bio and call the end_io handler on error instead of
returning an error and letting the caller handle it.  This matches what
the block layer submission and the other btrfs bio submission handlers do
and avoids any confusion on who needs to handle errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 38af980d1cf1f..0c2ef87af302f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7940,8 +7940,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	btrfs_dio_private_put(dip);
 }
 
-static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
-		struct inode *inode, u64 file_offset, int async_submit)
+static inline void btrfs_submit_dio_bio(struct bio *bio, struct inode *inode,
+		u64 file_offset, int async_submit)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip = bio->bi_private;
@@ -7955,22 +7955,24 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers) &&
 		    btrfs_wq_submit_bio(inode, bio, 0, file_offset,
 					btrfs_submit_bio_start_direct_io))
-			return BLK_STS_OK;
+			return;
 
 		/*
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
 		 */
 		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, file_offset, false);
-		if (ret)
-			return ret;
+		if (ret) {
+			bio->bi_status = ret;
+			bio_endio(bio);
+			return;
+		}
 	} else {
 		btrfs_bio(bio)->csum = btrfs_csum_ptr(fs_info, dip->csums,
 						      file_offset - dip->file_offset);
 	}
 map:
 	btrfs_submit_bio(fs_info, bio, 0);
-	return BLK_STS_OK;
 }
 
 static void btrfs_submit_direct(const struct iomap_iter *iter,
@@ -8083,14 +8085,7 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 				async_submit = 1;
 		}
 
-		status = btrfs_submit_dio_bio(bio, inode, file_offset,
-						async_submit);
-		if (status) {
-			bio_put(bio);
-			if (submit_len > 0)
-				refcount_dec(&dip->refs);
-			goto out_err_em;
-		}
+		btrfs_submit_dio_bio(bio, inode, file_offset, async_submit);
 
 		dio_data->submitted += clone_len;
 		clone_offset += clone_len;
-- 
2.30.2

