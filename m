Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FBD6AE6EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCGQnZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 11:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCGQmx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 11:42:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9E960BA
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 08:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MdEFuhbrRZ8hE4ftE/QH4OsFneAiycOVg5REx6yKKno=; b=r9MkxrpTtXDVxf7pK+1VO3KgK3
        W9LSNtR4Di3yp3/O8TABXY+upL4B9/mMQ2hWdQaP2IZiRaDxPzif+X2mOwaw+RUb8seKrE4FPyyNG
        GfOivZ3rvB54dCxwtN/NBsAuFIZqDslbisSaMLZdCz3igKuEFQfoDpWyylKDzEyffYb5111/Kyvnl
        bFJ1lavm2AYfhPR4dTFWEbEwyL2e0ocCI+0rbxOG1tcO/VGkovH3mMyMMWO48IGksl1+jY76nYR7A
        0gxn13IFT0JEfPUQg72tafGBJItYYjyMotKBi+wtVtLptv03PXdibMNcDp+uc4CZJFZqQn/lMrW9T
        4ZRsWGAA==;
Received: from [213.208.157.31] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZaML-001bRM-S6; Tue, 07 Mar 2023 16:40:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/10] btrfs: cleanup btrfs_encoded_read_regular_fill_pages
Date:   Tue,  7 Mar 2023 17:39:37 +0100
Message-Id: <20230307163945.31770-3-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307163945.31770-1-hch@lst.de>
References: <20230307163945.31770-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_encoded_read_regular_fill_pages has a pretty odd control flow.
Unwind it so that there is a single loop over the pages array.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 51 ++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cce4729bbca177..bba3013894b76c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9959,39 +9959,34 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		.pending = ATOMIC_INIT(1),
 	};
 	unsigned long i = 0;
-	u64 cur = 0;
+	struct bio *bio;
 
 	init_waitqueue_head(&priv.wait);
-	/* Submit bios for the extent, splitting due to bio limits as necessary. */
-	while (cur < disk_io_size) {
-		struct bio *bio = NULL;
-		u64 remaining = disk_io_size - cur;
-
-		while (bio || remaining) {
-			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
-
-			if (!bio) {
-				bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ,
-						      inode,
-						      btrfs_encoded_read_endio,
-						      &priv);
-				bio->bi_iter.bi_sector =
-					(disk_bytenr + cur) >> SECTOR_SHIFT;
-			}
 
-			if (!bytes ||
-			    bio_add_page(bio, pages[i], bytes, 0) < bytes) {
-				atomic_inc(&priv.pending);
-				btrfs_submit_bio(bio, 0);
-				bio = NULL;
-				continue;
-			}
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
+			      btrfs_encoded_read_endio, &priv);
+	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 
-			i++;
-			cur += bytes;
-			remaining -= bytes;
+	do {
+		size_t bytes = min_t(u64, disk_io_size, PAGE_SIZE);
+
+		if (bio_add_page(bio, pages[i], bytes, 0) < bytes) {
+			atomic_inc(&priv.pending);
+			btrfs_submit_bio(bio, 0);
+
+			bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
+					      btrfs_encoded_read_endio, &priv);
+			bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+			continue;
 		}
-	}
+
+		i++;
+		disk_bytenr += bytes;
+		disk_io_size -= bytes;
+	} while (disk_io_size);
+
+	atomic_inc(&priv.pending);
+	btrfs_submit_bio(bio, 0);
 
 	if (atomic_dec_return(&priv.pending))
 		io_wait_event(priv.wait, !atomic_read(&priv.pending));
-- 
2.39.1

