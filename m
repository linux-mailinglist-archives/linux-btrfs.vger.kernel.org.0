Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9340C050
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhIOHSo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Sep 2021 03:18:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53846 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhIOHSn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Sep 2021 03:18:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B52E1221B1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Sep 2021 07:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631690244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pgtPfhgAJDwHKVws7/zfOQfFRRaEurA0U5lPZxTWsRc=;
        b=RDr1rC027EF9p4vN6MAMCEHy3QqOovZ9Gc67BOd8v8z83fE5nPveKHveYWORM3Rf0J2pNX
        mmczLOBUuR9y+3JMpaugSeRjPZwr8U/qzE3OvTfUOkyN05PuO6oFRQW8qfu9CoRyslimok
        UkPTDKrip1wuR/LpbuR5pOgYOFT4LD4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC49E13C1A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Sep 2021 07:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WIHnKgOeQWGxEAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Sep 2021 07:17:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/3] btrfs: remove btrfs_bio_alloc() helper
Date:   Wed, 15 Sep 2021 15:17:17 +0800
Message-Id: <20210915071718.59418-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915071718.59418-1-wqu@suse.com>
References: <20210915071718.59418-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper btrfs_bio_alloc() is almost the same as btrfs_io_bio_alloc(),
except it's allocating using BIO_MAX_VECS as @nr_iovecs, and initialize
bio->bi_iter.bi_sector.

However the naming itself is not using "btrfs_io_bio" to indicate its
parameter is "strcut btrfs_io_bio" and can be easily confused with
"struct btrfs_bio".

Considering assigned bio->bi_iter.bi_sector is such a simple work and
there are already tons of call sites doing that manually, there is no
need to do that in a helper.

Remove btrfs_bio_alloc() helper, and enhance btrfs_io_bio_alloc()
function to provide a fail-safe value for its @nr_iovecs.

And then replace all btrfs_bio_alloc() callers with
btrfs_io_bio_alloc().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 12 ++++++++----
 fs/btrfs/extent_io.c   | 33 +++++++++++++++------------------
 fs/btrfs/extent_io.h   |  1 -
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7869ad12bc6e..2475dc0b1c22 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -418,7 +418,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
-	bio = btrfs_bio_alloc(first_byte);
+	bio = btrfs_io_bio_alloc(0);
+	bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
 	bio->bi_opf = bio_op | write_flags;
 	bio->bi_private = cb;
 	bio->bi_end_io = end_compressed_bio_write;
@@ -490,7 +491,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				bio_endio(bio);
 			}
 
-			bio = btrfs_bio_alloc(first_byte);
+			bio = btrfs_io_bio_alloc(0);
+			bio->bi_iter.bi_sector = first_byte >> SECTOR_SHIFT;
 			bio->bi_opf = bio_op | write_flags;
 			bio->bi_private = cb;
 			bio->bi_end_io = end_compressed_bio_write;
@@ -748,7 +750,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
-	comp_bio = btrfs_bio_alloc(cur_disk_byte);
+	comp_bio = btrfs_io_bio_alloc(0);
+	comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
 	comp_bio->bi_opf = REQ_OP_READ;
 	comp_bio->bi_private = cb;
 	comp_bio->bi_end_io = end_compressed_bio_read;
@@ -806,7 +809,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				bio_endio(comp_bio);
 			}
 
-			comp_bio = btrfs_bio_alloc(cur_disk_byte);
+			comp_bio = btrfs_io_bio_alloc(0);
+			comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
 			comp_bio->bi_opf = REQ_OP_READ;
 			comp_bio->bi_private = cb;
 			comp_bio->bi_end_io = end_compressed_bio_read;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1aed03ef5f49..d3fcf7e8dc48 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3121,16 +3121,22 @@ static inline void btrfs_io_bio_init(struct btrfs_io_bio *btrfs_bio)
 }
 
 /*
- * The following helpers allocate a bio. As it's backed by a bioset, it'll
- * never fail.  We're returning a bio right now but you can call btrfs_io_bio
- * for the appropriate container_of magic
+ * Allocate a btrfs_io_bio, with @nr_iovecs as maximum iovecs.
+ *
+ * If @nr_iovecs is 0, it will use BIO_MAX_VECS as @nr_iovces instead.
+ * This behavior is to provide a fail-safe default value.
+ *
+ * This helper uses bioset to allocate the bio, thus it's backed by mempool,
+ * and should not fail from process contexts.
  */
-struct bio *btrfs_bio_alloc(u64 first_byte)
+struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
 {
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &btrfs_bioset);
-	bio->bi_iter.bi_sector = first_byte >> 9;
+	ASSERT(nr_iovecs <= BIO_MAX_VECS);
+	if (nr_iovecs == 0)
+		nr_iovecs = BIO_MAX_VECS;
+	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, &btrfs_bioset);
 	btrfs_io_bio_init(btrfs_io_bio(bio));
 	return bio;
 }
@@ -3148,16 +3154,6 @@ struct bio *btrfs_bio_clone(struct bio *bio)
 	return new;
 }
 
-struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs)
-{
-	struct bio *bio;
-
-	/* Bio allocation backed by a bioset does not fail */
-	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, &btrfs_bioset);
-	btrfs_io_bio_init(btrfs_io_bio(bio));
-	return bio;
-}
-
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 {
 	struct bio *bio;
@@ -3307,14 +3303,15 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
+	bio = btrfs_io_bio_alloc(0);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
 	 */
 	if (bio_flags & EXTENT_BIO_COMPRESSED)
-		bio = btrfs_bio_alloc(disk_bytenr);
+		bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	else
-		bio = btrfs_bio_alloc(disk_bytenr + offset);
+		bio->bi_iter.bi_sector = (disk_bytenr + offset) >> SECTOR_SHIFT;
 	bio_ctrl->bio = bio;
 	bio_ctrl->bio_flags = bio_flags;
 	bio->bi_end_io = end_io_func;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index ba471f2063a7..81fa68eaa699 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -278,7 +278,6 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
-struct bio *btrfs_bio_alloc(u64 first_byte);
 struct bio *btrfs_io_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
-- 
2.33.0

