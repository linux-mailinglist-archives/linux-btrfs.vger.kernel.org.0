Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2830069195C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 08:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjBJHtR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 02:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBJHtQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 02:49:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D2A5ACF9
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 23:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YdAGiOJKOA8oHl+YugO6oSLRD5hOtw65qDrmcNl+t1w=; b=uRGov6SYSUNdaNfrzQRZot90lu
        xLCfQ2a6JL7nVtM+i1+m8ffhr2BkKOHoVnqMmGU4nOkoPVYFA9MliSM69INC8dvK3At5lYSlQq8Vg
        rkswj9bsRIqMG7pzyZxGZVwQ7fL9eADXb2NQusH8cDQa+IlCHVCCl1/4mBi4vhkKtQZsHg6lWOdFI
        zADkHDND9vA64L2eF1F80aOQ5lPGvk5k3S8FHTe5SZ625hz5IHRTph5AmK7hhSSSXbNyj+4jRO1Ql
        xtSHlVtlYaVah3Y/Y8We9oDaQGYjttxZhXjTJeiIFQzy7tyqkBtver9qt0XAaS6J1F2m6JddETVIG
        OCOKI+Dg==;
Received: from 213-147-164-133.nat.highway.webapn.at ([213.147.164.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQO9g-004fiG-7M; Fri, 10 Feb 2023 07:49:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: factor out a btrfs_free_compressed_pages helper
Date:   Fri, 10 Feb 2023 08:48:39 +0100
Message-Id: <20230210074841.628201-7-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210074841.628201-1-hch@lst.de>
References: <20230210074841.628201-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Share the code to free the compressed pages and the array to hold them
into a common helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 43 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index d68b45fc340f37..ac9ffec5fc925d 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -159,30 +159,31 @@ static int compression_decompress(int type, struct list_head *ws,
 	}
 }
 
+static void btrfs_free_compressed_pages(struct compressed_bio *cb)
+{
+	unsigned int i;
+
+	for (i = 0; i < cb->nr_pages; i++) {
+		struct page *page = cb->compressed_pages[i];
+
+		page->mapping = NULL;
+		put_page(page);
+	}
+	kfree(cb->compressed_pages);
+}
+
 static int btrfs_decompress_bio(struct compressed_bio *cb);
 
 static void end_compressed_bio_read(struct btrfs_bio *bbio)
 {
 	struct compressed_bio *cb = to_compressed_bio(bbio);
 	blk_status_t status = bbio->bio.bi_status;
-	unsigned int index;
-	struct page *page;
 
 	if (!status)
 		status = errno_to_blk_status(btrfs_decompress_bio(cb));
 
-	/* Release the compressed pages */
-	for (index = 0; index < cb->nr_pages; index++) {
-		page = cb->compressed_pages[index];
-		page->mapping = NULL;
-		put_page(page);
-	}
-
-	/* Do io completion on the original bio */
+	btrfs_free_compressed_pages(cb);
 	btrfs_bio_end_io(btrfs_bio(cb->orig_bio), status);
-
-	/* Finally free the cb struct */
-	kfree(cb->compressed_pages);
 	bio_put(&bbio->bio);
 }
 
@@ -227,8 +228,6 @@ static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 
 static void finish_compressed_bio_write(struct compressed_bio *cb)
 {
-	unsigned int index;
-
 	/*
 	 * Ok, we're the last bio for this extent, step one is to call back
 	 * into the FS and do all the end_io operations.
@@ -241,19 +240,7 @@ static void finish_compressed_bio_write(struct compressed_bio *cb)
 		end_compressed_writeback(cb);
 	/* Note, our inode could be gone now */
 
-	/*
-	 * Release the compressed pages, these came from alloc_page and
-	 * are not attached to the inode at all
-	 */
-	for (index = 0; index < cb->nr_pages; index++) {
-		struct page *page = cb->compressed_pages[index];
-
-		page->mapping = NULL;
-		put_page(page);
-	}
-
-	/* Finally free the cb struct */
-	kfree(cb->compressed_pages);
+	btrfs_free_compressed_pages(cb);
 	bio_put(&cb->bbio.bio);
 }
 
-- 
2.39.1

