Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA1564FF2
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiGDIoU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 04:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGDIoT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 04:44:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DCD958B
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4jEwmpPhUc4V5fb9PTmXCXvggOA0v8yUQV3LvqTkOtY=; b=eqnxBvrh05LUpb09wzfhGXItqY
        eT6n34IXu2yvXngxqRw1PZu4f/DR/P7mqYojR+/1yEMLL2aoHzSMvVO8Xvx15HBK8eEhdPD7Iyz/b
        VOy7zAbQvUBmmANZhvx2jPx6w4x+Zbq2ePThd9Phmc0Y8/FYvIuiZKIwcCjavYsnRz1msweyM5sq/
        HaO+3Y13hqyhFMspqnjyCBQPydEqtf4/RDe0eH5YZKO698MLRpOGay97lJJV7zBAhB2KDu1AQwDEA
        GbEHT3lD2B07za3Ji3uwWLMNEozoqosYOk9zlai5hKEMXPt4cuWD4akEw5qGrMRu5BoFTi2KfAzCj
        DaMZ2ZYA==;
Received: from [2001:4bb8:189:3c4a:9cc7:69df:e5dc:ef11] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Hgm-0068Ji-90; Mon, 04 Jul 2022 08:44:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: pass the operation to btrfs_bio_alloc
Date:   Mon,  4 Jul 2022 10:44:02 +0200
Message-Id: <20220704084406.106929-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704084406.106929-1-hch@lst.de>
References: <20220704084406.106929-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pass the operation to btrfs_bio_alloc, matching what bio_alloc_bioset
set does.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 3 +--
 fs/btrfs/extent_io.c   | 6 ++----
 fs/btrfs/inode.c       | 3 +--
 fs/btrfs/volumes.c     | 4 ++--
 fs/btrfs/volumes.h     | 2 +-
 5 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c8b14a5bd89be..d4045cc7071ad 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -364,10 +364,9 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf);
 
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
-	bio->bi_opf = opf;
 	bio->bi_private = cb;
 	bio->bi_end_io = endio_func;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7235f28f53bbc..974880e5a8f1c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2627,10 +2627,9 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 		return -EIO;
 	}
 
-	repair_bio = btrfs_bio_alloc(1);
+	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ);
 	repair_bbio = btrfs_bio(repair_bio);
 	repair_bbio->file_offset = start;
-	repair_bio->bi_opf = REQ_OP_READ;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
 	repair_bio->bi_private = failed_bio->bi_private;
@@ -3265,7 +3264,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
@@ -3277,7 +3276,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	bio_ctrl->bio = bio;
 	bio_ctrl->compress_type = compress_type;
 	bio->bi_end_io = end_io_func;
-	bio->bi_opf = opf;
 	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
 	if (ret < 0)
 		goto error;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eea351216db33..28649e0853d91 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10419,12 +10419,11 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
 
 			if (!bio) {
-				bio = btrfs_bio_alloc(BIO_MAX_VECS);
+				bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ);
 				bio->bi_iter.bi_sector =
 					(disk_bytenr + cur) >> SECTOR_SHIFT;
 				bio->bi_end_io = btrfs_encoded_read_endio;
 				bio->bi_private = &priv;
-				bio->bi_opf = REQ_OP_READ;
 			}
 
 			if (!bytes ||
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 35ccd49940b94..7689c7cdb1859 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6626,11 +6626,11 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio)
  * Just like the underlying bio_alloc_bioset it will no fail as it is backed by
  * a mempool.
  */
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs)
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf)
 {
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(NULL, nr_vecs, 0, GFP_NOFS, &btrfs_bioset);
+	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
 	btrfs_bio_init(btrfs_bio(bio));
 	return bio;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 0acdc8863c970..48bed92b96159 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -391,7 +391,7 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 	return container_of(bio, struct btrfs_bio, bio);
 }
 
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs);
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
 static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
-- 
2.30.2

