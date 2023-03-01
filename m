Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18B56A6D43
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 14:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCANmw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 08:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjCANms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 08:42:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705E53B67F
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5Gx6xU/FNgt/KYzDdmFEDsuckLUBgcUJ5adhMOJGj4Y=; b=Ya1sXXsJdUgH6hJsXDiirPbOex
        VBrpi+rAquGVahj0GiioApg8CDFShbx7xGbCR+E3fKL/pFMN//0GwP5RmH/QgNYw+2BTIKIqDAmvm
        nCuSZPRvzFkQ+3GiSXl+Pn4STOG2jh+s9euqGHnwozPuxUd3SGK4WaYHXB5sk/T+vL8xIopLhAQOz
        aUrd+QTqRIozZDnyKbRDHTKN6ShBLfw/o1dtKj6iccxTLdUQm3l9aZtNOj8s4uSjfK7HM8jruz18a
        hxWq0ZsEw7j/bZFRUgSFD9TEldrV/wPUCqBBSYM8TZUPl48vDNTajJMayXIX3anfsiCISSolX9sgV
        GH9/BaAw==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXMjE-00GN7K-BQ; Wed, 01 Mar 2023 13:42:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: pass a btrfs_bio to btrfs_submit_bio
Date:   Wed,  1 Mar 2023 06:42:37 -0700
Message-Id: <20230301134244.1378533-5-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301134244.1378533-1-hch@lst.de>
References: <20230301134244.1378533-1-hch@lst.de>
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

btrfs_submit_bio expects the bio passed to it to be embedded into a
btrfs_bio structure.  Pass the btrfs_bio directly to inrease type
safety and make the code self-documenting.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c         | 14 +++++++-------
 fs/btrfs/bio.h         |  2 +-
 fs/btrfs/compression.c |  4 ++--
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/inode.c       |  6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 726592868e9c5c..c04e103f876853 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -164,7 +164,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 			goto done;
 		}
 
-		btrfs_submit_bio(&repair_bbio->bio, mirror);
+		btrfs_submit_bio(repair_bbio, mirror);
 		return;
 	}
 
@@ -232,7 +232,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 
 	mirror = next_repair_mirror(fbio, failed_bbio->mirror_num);
 	btrfs_debug(fs_info, "submitting repair read to mirror %d", mirror);
-	btrfs_submit_bio(repair_bio, mirror);
+	btrfs_submit_bio(repair_bbio, mirror);
 	return fbio;
 }
 
@@ -603,12 +603,12 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 	return true;
 }
 
-static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
+static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 {
-	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_bio *orig_bbio = bbio;
+	struct bio *bio = &bbio->bio;
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
 	u64 map_length = length;
@@ -650,7 +650,7 @@ static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
 		if (use_append) {
 			bio->bi_opf &= ~REQ_OP_WRITE;
 			bio->bi_opf |= REQ_OP_ZONE_APPEND;
-			ret = btrfs_extract_ordered_extent(btrfs_bio(bio));
+			ret = btrfs_extract_ordered_extent(bbio);
 			if (ret)
 				goto fail_put_bio;
 		}
@@ -686,9 +686,9 @@ static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
 	return true;
 }
 
-void btrfs_submit_bio(struct bio *bio, int mirror_num)
+void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num)
 {
-	while (!btrfs_submit_chunk(bio, mirror_num))
+	while (!btrfs_submit_chunk(bbio, mirror_num))
 		;
 }
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 873ff85817f0b2..b4e7d5ab7d236d 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -88,7 +88,7 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 /* Bio only refers to one ordered extent. */
 #define REQ_BTRFS_ONE_ORDERED			REQ_DRV
 
-void btrfs_submit_bio(struct bio *bio, int mirror_num);
+void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num);
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 64c804dc3962f6..27bea05cab1a1b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -333,7 +333,7 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->nr_pages = nr_pages;
 
 	btrfs_add_compressed_bio_pages(cb, disk_start);
-	btrfs_submit_bio(&cb->bbio.bio, 0);
+	btrfs_submit_bio(&cb->bbio, 0);
 
 	if (blkcg_css)
 		kthread_associate_blkcg(NULL);
@@ -565,7 +565,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 	if (memstall)
 		psi_memstall_leave(&pflags);
 
-	btrfs_submit_bio(&cb->bbio.bio, mirror_num);
+	btrfs_submit_bio(&cb->bbio, mirror_num);
 	return;
 
 out_free_compressed_pages:
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d53bd452b9ec30..77de129db364c9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -157,7 +157,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
 		btrfs_submit_compressed_read(bio, mirror_num);
 	else
-		btrfs_submit_bio(bio, mirror_num);
+		btrfs_submit_bio(btrfs_bio(bio), mirror_num);
 
 	/* The bio is owned by the end_io handler now */
 	bio_ctrl->bio = NULL;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 431b6082ab3d83..ed96c84f5be71d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7787,7 +7787,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	dip->bytes = bio->bi_iter.bi_size;
 
 	dio_data->submitted += bio->bi_iter.bi_size;
-	btrfs_submit_bio(bio, 0);
+	btrfs_submit_bio(bbio, 0);
 }
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
@@ -9972,7 +9972,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
 		if (bio_add_page(bio, pages[i], bytes, 0) < bytes) {
 			atomic_inc(&priv.pending);
-			btrfs_submit_bio(bio, 0);
+			btrfs_submit_bio(btrfs_bio(bio), 0);
 
 			bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
 					      btrfs_encoded_read_endio, &priv);
@@ -9986,7 +9986,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	} while (disk_io_size);
 
 	atomic_inc(&priv.pending);
-	btrfs_submit_bio(bio, 0);
+	btrfs_submit_bio(btrfs_bio(bio), 0);
 
 	if (atomic_dec_return(&priv.pending))
 		io_wait_event(priv.wait, !atomic_read(&priv.pending));
-- 
2.39.1

