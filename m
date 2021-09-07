Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C164024A2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbhIGHoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 03:44:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55932 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbhIGHn4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 03:43:56 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 291CB22034
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 07:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631000570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dFzuPzx33F+sOC+4ifJouKorBKCff+eZWdvMFDBS48=;
        b=UgvGXQpUqtFhXQsgMFC3qal6wSdpq1ODuRi/xcU5N7B3VHYIMbFi1NrZ3RgXG8QdcX3D3/
        86PRboyiPE/6KtcmkFIfNGmHzpoYDme9HgyQTmP3zcii4uZVX+l5drRHTAQjVa/QLpwNUE
        24xgeVEWM9UEIqZDZy0k9VD5Fc+G1uM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4E18E132FD
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 07:42:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yMZ8A/kXN2GTFQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 07:42:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: rename btrfs_io_bio_alloc() to btrfs_bio_alloc_iovecs()
Date:   Tue,  7 Sep 2021 15:42:40 +0800
Message-Id: <20210907074242.103438-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210907074242.103438-1-wqu@suse.com>
References: <20210907074242.103438-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function btrfs_io_bio_alloc() is pretty similar to btrfs_bio_alloc(),
the only major difference is the number of iovecs, and whether bi_sector
is initialized.

Thus there is no need to add the extra "_io", which is only going to
cause confusion.

Rename it to btrfs_bio_alloc_iovecs() to be easier to read.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/check-integrity.c |  2 +-
 fs/btrfs/extent_io.c       |  6 +++---
 fs/btrfs/extent_io.h       |  2 +-
 fs/btrfs/raid56.c          |  2 +-
 fs/btrfs/scrub.c           | 14 +++++++-------
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 86816088927f..06a9b1875bec 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1561,7 +1561,7 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 		struct bio *bio;
 		unsigned int j;
 
-		bio = btrfs_io_bio_alloc(num_pages - i);
+		bio = btrfs_bio_alloc_iovecs(num_pages - i);
 		bio_set_dev(bio, block_ctx->dev->bdev);
 		bio->bi_iter.bi_sector = dev_bytenr >> 9;
 		bio->bi_opf = REQ_OP_READ;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5ad749e19ff3..37ff4a4df94b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2299,7 +2299,7 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	if (btrfs_is_zoned(fs_info))
 		return btrfs_repair_one_zone(fs_info, logical);
 
-	bio = btrfs_io_bio_alloc(1);
+	bio = btrfs_bio_alloc_iovecs(1);
 	bio->bi_iter.bi_size = 0;
 	map_length = length;
 
@@ -2639,7 +2639,7 @@ int btrfs_repair_one_sector(struct inode *inode,
 		return -EIO;
 	}
 
-	repair_bio = btrfs_io_bio_alloc(1);
+	repair_bio = btrfs_bio_alloc_iovecs(1);
 	repair_io_bio = btrfs_io_bio(repair_bio);
 	repair_bio->bi_opf = REQ_OP_READ;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
@@ -3148,7 +3148,7 @@ struct bio *btrfs_bio_clone(struct bio *bio)
 	return new;
 }
 
-struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
+struct bio *btrfs_bio_alloc_iovecs(unsigned int nr_iovecs)
 {
 	struct bio *bio;
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 9f3e0a45a5e4..dbc197ba57ce 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -279,7 +279,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
 struct bio *btrfs_bio_alloc(u64 first_byte);
-struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
+struct bio *btrfs_bio_alloc_iovecs(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index d8d268ca8aa7..581472d314bb 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1105,7 +1105,7 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 	}
 
 	/* put a new bio on the list */
-	bio = btrfs_io_bio_alloc(bio_max_len >> PAGE_SHIFT ?: 1);
+	bio = btrfs_bio_alloc_iovecs(bio_max_len >> PAGE_SHIFT ?: 1);
 	btrfs_io_bio(bio)->device = stripe->dev;
 	bio->bi_iter.bi_size = 0;
 	bio_set_dev(bio, stripe->dev->bdev);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 088641ba7a8e..0159fe00f348 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1423,7 +1423,7 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	if (!first_page->dev->bdev)
 		goto out;
 
-	bio = btrfs_io_bio_alloc(BIO_MAX_VECS);
+	bio = btrfs_bio_alloc_iovecs(BIO_MAX_VECS);
 	bio_set_dev(bio, first_page->dev->bdev);
 
 	for (page_num = 0; page_num < sblock->page_count; page_num++) {
@@ -1480,7 +1480,7 @@ static void scrub_recheck_block(struct btrfs_fs_info *fs_info,
 		}
 
 		WARN_ON(!spage->page);
-		bio = btrfs_io_bio_alloc(1);
+		bio = btrfs_bio_alloc_iovecs(1);
 		bio_set_dev(bio, spage->dev->bdev);
 
 		bio_add_page(bio, spage->page, fs_info->sectorsize, 0);
@@ -1562,7 +1562,7 @@ static int scrub_repair_page_from_good_copy(struct scrub_block *sblock_bad,
 			return -EIO;
 		}
 
-		bio = btrfs_io_bio_alloc(1);
+		bio = btrfs_bio_alloc_iovecs(1);
 		bio_set_dev(bio, spage_bad->dev->bdev);
 		bio->bi_iter.bi_sector = spage_bad->physical >> 9;
 		bio->bi_opf = REQ_OP_WRITE;
@@ -1676,7 +1676,7 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 		sbio->dev = sctx->wr_tgtdev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_io_bio_alloc(sctx->pages_per_wr_bio);
+			bio = btrfs_bio_alloc_iovecs(sctx->pages_per_wr_bio);
 			sbio->bio = bio;
 		}
 
@@ -2102,7 +2102,7 @@ static int scrub_add_page_to_rd_bio(struct scrub_ctx *sctx,
 		sbio->dev = spage->dev;
 		bio = sbio->bio;
 		if (!bio) {
-			bio = btrfs_io_bio_alloc(sctx->pages_per_rd_bio);
+			bio = btrfs_bio_alloc_iovecs(sctx->pages_per_rd_bio);
 			sbio->bio = bio;
 		}
 
@@ -2226,7 +2226,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 		goto bbio_out;
 	}
 
-	bio = btrfs_io_bio_alloc(0);
+	bio = btrfs_bio_alloc_iovecs(0);
 	bio->bi_iter.bi_sector = logical >> 9;
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
@@ -2842,7 +2842,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	if (ret || !bbio || !bbio->raid_map)
 		goto bbio_out;
 
-	bio = btrfs_io_bio_alloc(0);
+	bio = btrfs_bio_alloc_iovecs(0);
 	bio->bi_iter.bi_sector = sparity->logic_start >> 9;
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
-- 
2.33.0

