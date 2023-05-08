Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA26FB4D2
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjEHQJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjEHQI6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8BD7285
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FUmqKjQu4j2xpRHkwiDzI4uiKM0qMYUcWSvP6zY/Igc=; b=XX00TAQS3x81nnAAYKiIS5QPhZ
        CY6DsHQaMU+L2pUhRLSgVUYgQgvLyA8lzk0vRaCsqH9g0hafzfw/kn8aikJi0PpFzW8bfC0H0l3ww
        N84uZbnxwp0BW7Ujt+MA4fOwLncwkbTZMl/FBFhlxlF36XkCHvQADzzB5H0Z42vkMEQgbzO6kHdiH
        zAciBeWVM6ZZQOahR5o0u7xXXCY2ozlJ6Ikwf/nQ1FBDJvlZrWn/TWQp1alelhmqz7CrzcpXtdKqg
        Ma72cLcdMzGIMYhYNbXjMUHZebq4/8EgUeV9kHDh30RoNN4EBm+Pe3W7SEsNGRtsKyzhwzCpgtN8o
        ZIC3yC3g==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Q0-000w4S-0k;
        Mon, 08 May 2023 16:08:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/21] btrfs: use btrfs_finish_ordered_extent to complete direct writes
Date:   Mon,  8 May 2023 09:08:41 -0700
Message-Id: <20230508160843.133013-20-hch@lst.de>
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

Use the btrfs_finish_ordered_extent helper to complete compressed writes
using the bbio->ordered pointer instead of requiring an rbtree lookup
in the otherwise equivalent btrfs_mark_ordered_io_finished called from
btrfs_writepage_endio_finish_ordered.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ff1f5014156390..3b55b7cd7ebf19 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7856,8 +7856,8 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
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
@@ -7887,12 +7887,14 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
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

