Return-Path: <linux-btrfs+bounces-7516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D995F843
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 19:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D4F1C22181
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD97198E88;
	Mon, 26 Aug 2024 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VByE0FTy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48705184525;
	Mon, 26 Aug 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693913; cv=none; b=cHvQPizOuqtGbpjrydlZIbPRDjch8HfyLsiBYPo67fi04tRsq0i2Y5hBkukqCjSsHjRqEF9azX0izDoL7ap+/iEQkyb9ufx6DD9mCZncQoJSOmISY64KAWXMw8IahPy4LmbAiCwC2cBOuNJ1HR/luvy7HBxRuRpLvfqEOE3hv38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693913; c=relaxed/simple;
	bh=F+H5FTYeSNVfv0zKzC3k0UrT+M7zEM7OQ+VwpJ7oNqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okqqjktNW5kTNFr9VNnlrxpwnwbbeldktF9DKCytflhhRn5tpMit/BXor8SXo8H86EsUoNFb2jIFNQiNAGSCcBKm/xM5QidwwexO5VOSbH+GaPPGuAn5wDLA1cIvAYAo8XVhY3+/5brQP7UEhyzbLVW1JTgtOD2sJgE8E2BFDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VByE0FTy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=c0a9yXoYMZRPSdb82OW+51SC4gEQOgkG7w9Uj6dBOaQ=; b=VByE0FTyTDYd6ZMCrzNorC7eN1
	beg4KuMqy+xLs2+34NpQ1gdMiCh89BpNAXGeIMqIKcMpr6mVc0uMq+4bfUAt+nzTZJPQrYfkrlqRa
	l5r6VHRoapJ4LNtMl7Nr8QjK4Hx7sKpnlH8BBpf1ENy3MdU9L5VBBHkHBNdCrQHwP5GaLue3aiBHS
	mJs7qYDEs12ukikKTyFNn7peCEUO3kPlOAxRguKY85mC+CYC+9YVOpzqTwZJSdC+4eSb4xe+p3JUv
	yNhOc8ljwXJNQAdGwivEfTs5Mbhc6NejhQXdS0C/bi3UyX5zc/XcRxzP0XqSbg9XC9GX0grTIw+kX
	+bMY143A==;
Received: from 2a02-8389-2341-5b80-a8a7-5c16-efec-d7f9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a8a7:5c16:efec:d7f9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sidfg-00000008Fw9-3oFG;
	Mon, 26 Aug 2024 17:38:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] block: rework bio splitting
Date: Mon, 26 Aug 2024 19:37:54 +0200
Message-ID: <20240826173820.1690925-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826173820.1690925-1-hch@lst.de>
References: <20240826173820.1690925-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The current setup with bio_may_exceed_limit and __bio_split_to_limits
is a bit of a mess.

Change it so that __bio_split_to_limits does all the work and is just
a variant of bio_split_to_limits that returns nr_segs.  This is done
by inlining it and instead have the various bio_split_* helpers directly
submit the potentially split bios.

To support btrfs, the rw version has a lower level helper split out
that just returns the offset to split.  This turns out to nicely clean
up the btrfs flow as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c   | 146 +++++++++++++++++---------------------------
 block/blk-mq.c      |  11 ++--
 block/blk.h         |  63 +++++++++++++------
 fs/btrfs/bio.c      |  30 +++++----
 include/linux/bio.h |   4 +-
 5 files changed, 125 insertions(+), 129 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index de5281bcadc538..c7222c4685e060 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -105,9 +105,33 @@ static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
 	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
 }
 
-static struct bio *bio_split_discard(struct bio *bio,
-				     const struct queue_limits *lim,
-				     unsigned *nsegs, struct bio_set *bs)
+static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
+{
+	if (unlikely(split_sectors < 0)) {
+		bio->bi_status = errno_to_blk_status(split_sectors);
+		bio_endio(bio);
+		return NULL;
+	}
+
+	if (split_sectors) {
+		struct bio *split;
+
+		split = bio_split(bio, split_sectors, GFP_NOIO,
+				&bio->bi_bdev->bd_disk->bio_split);
+		split->bi_opf |= REQ_NOMERGE;
+		blkcg_bio_issue_init(split);
+		bio_chain(split, bio);
+		trace_block_split(split, bio->bi_iter.bi_sector);
+		WARN_ON_ONCE(bio_zone_write_plugging(bio));
+		submit_bio_noacct(bio);
+		return split;
+	}
+
+	return bio;
+}
+
+struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
+		unsigned *nsegs)
 {
 	unsigned int max_discard_sectors, granularity;
 	sector_t tmp;
@@ -121,10 +145,10 @@ static struct bio *bio_split_discard(struct bio *bio,
 		min(lim->max_discard_sectors, bio_allowed_max_sectors(lim));
 	max_discard_sectors -= max_discard_sectors % granularity;
 	if (unlikely(!max_discard_sectors))
-		return NULL;
+		return bio;
 
 	if (bio_sectors(bio) <= max_discard_sectors)
-		return NULL;
+		return bio;
 
 	split_sectors = max_discard_sectors;
 
@@ -139,19 +163,18 @@ static struct bio *bio_split_discard(struct bio *bio,
 	if (split_sectors > tmp)
 		split_sectors -= tmp;
 
-	return bio_split(bio, split_sectors, GFP_NOIO, bs);
+	return bio_submit_split(bio, split_sectors);
 }
 
-static struct bio *bio_split_write_zeroes(struct bio *bio,
-					  const struct queue_limits *lim,
-					  unsigned *nsegs, struct bio_set *bs)
+struct bio *bio_split_write_zeroes(struct bio *bio,
+		const struct queue_limits *lim, unsigned *nsegs)
 {
 	*nsegs = 0;
 	if (!lim->max_write_zeroes_sectors)
-		return NULL;
+		return bio;
 	if (bio_sectors(bio) <= lim->max_write_zeroes_sectors)
-		return NULL;
-	return bio_split(bio, lim->max_write_zeroes_sectors, GFP_NOIO, bs);
+		return bio;
+	return bio_submit_split(bio, lim->max_write_zeroes_sectors);
 }
 
 static inline unsigned int blk_boundary_sectors(const struct queue_limits *lim,
@@ -274,27 +297,19 @@ static bool bvec_split_segs(const struct queue_limits *lim,
 }
 
 /**
- * bio_split_rw - split a bio in two bios
+ * bio_split_rw_at - check if and where to split a read/write bio
  * @bio:  [in] bio to be split
  * @lim:  [in] queue limits to split based on
  * @segs: [out] number of segments in the bio with the first half of the sectors
- * @bs:	  [in] bio set to allocate the clone from
  * @max_bytes: [in] maximum number of bytes per bio
  *
- * Clone @bio, update the bi_iter of the clone to represent the first sectors
- * of @bio and update @bio->bi_iter to represent the remaining sectors. The
- * following is guaranteed for the cloned bio:
- * - That it has at most @max_bytes worth of data
- * - That it has at most queue_max_segments(@q) segments.
- *
- * Except for discard requests the cloned bio will point at the bi_io_vec of
- * the original bio. It is the responsibility of the caller to ensure that the
- * original bio is not freed before the cloned bio. The caller is also
- * responsible for ensuring that @bs is only destroyed after processing of the
- * split bio has finished.
+ * Find out if @bio needs to be split to fit the queue limits in @lim and a
+ * maximum size of @max_bytes.  Returns a negative error number if @bio can't be
+ * split, 0 if the bio doesn't have to be split, or a positive sector offset if
+ * @bio needs to be split.
  */
-struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
-		unsigned *segs, struct bio_set *bs, unsigned max_bytes)
+int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
+		unsigned *segs, unsigned max_bytes)
 {
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	struct bvec_iter iter;
@@ -324,22 +339,17 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 	}
 
 	*segs = nsegs;
-	return NULL;
+	return 0;
 split:
-	if (bio->bi_opf & REQ_ATOMIC) {
-		bio->bi_status = BLK_STS_INVAL;
-		bio_endio(bio);
-		return ERR_PTR(-EINVAL);
-	}
+	if (bio->bi_opf & REQ_ATOMIC)
+		return -EINVAL;
+
 	/*
 	 * We can't sanely support splitting for a REQ_NOWAIT bio. End it
 	 * with EAGAIN if splitting is required and return an error pointer.
 	 */
-	if (bio->bi_opf & REQ_NOWAIT) {
-		bio->bi_status = BLK_STS_AGAIN;
-		bio_endio(bio);
-		return ERR_PTR(-EAGAIN);
-	}
+	if (bio->bi_opf & REQ_NOWAIT)
+		return -EAGAIN;
 
 	*segs = nsegs;
 
@@ -356,58 +366,16 @@ struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
 	bio_clear_polled(bio);
-	return bio_split(bio, bytes >> SECTOR_SHIFT, GFP_NOIO, bs);
+	return bytes >> SECTOR_SHIFT;
 }
-EXPORT_SYMBOL_GPL(bio_split_rw);
+EXPORT_SYMBOL_GPL(bio_split_rw_at);
 
-/**
- * __bio_split_to_limits - split a bio to fit the queue limits
- * @bio:     bio to be split
- * @lim:     queue limits to split based on
- * @nr_segs: returns the number of segments in the returned bio
- *
- * Check if @bio needs splitting based on the queue limits, and if so split off
- * a bio fitting the limits from the beginning of @bio and return it.  @bio is
- * shortened to the remainder and re-submitted.
- *
- * The split bio is allocated from @q->bio_split, which is provided by the
- * block layer.
- */
-struct bio *__bio_split_to_limits(struct bio *bio,
-				  const struct queue_limits *lim,
-				  unsigned int *nr_segs)
+struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
+		unsigned *nr_segs)
 {
-	struct bio_set *bs = &bio->bi_bdev->bd_disk->bio_split;
-	struct bio *split;
-
-	switch (bio_op(bio)) {
-	case REQ_OP_DISCARD:
-	case REQ_OP_SECURE_ERASE:
-		split = bio_split_discard(bio, lim, nr_segs, bs);
-		break;
-	case REQ_OP_WRITE_ZEROES:
-		split = bio_split_write_zeroes(bio, lim, nr_segs, bs);
-		break;
-	default:
-		split = bio_split_rw(bio, lim, nr_segs, bs,
-				get_max_io_size(bio, lim) << SECTOR_SHIFT);
-		if (IS_ERR(split))
-			return NULL;
-		break;
-	}
-
-	if (split) {
-		/* there isn't chance to merge the split bio */
-		split->bi_opf |= REQ_NOMERGE;
-
-		blkcg_bio_issue_init(split);
-		bio_chain(split, bio);
-		trace_block_split(split, bio->bi_iter.bi_sector);
-		WARN_ON_ONCE(bio_zone_write_plugging(bio));
-		submit_bio_noacct(bio);
-		return split;
-	}
-	return bio;
+	return bio_submit_split(bio,
+		bio_split_rw_at(bio, lim, nr_segs,
+			get_max_io_size(bio, lim) << SECTOR_SHIFT));
 }
 
 /**
@@ -426,9 +394,7 @@ struct bio *bio_split_to_limits(struct bio *bio)
 	const struct queue_limits *lim = &bdev_get_queue(bio->bi_bdev)->limits;
 	unsigned int nr_segs;
 
-	if (bio_may_exceed_limits(bio, lim))
-		return __bio_split_to_limits(bio, lim, &nr_segs);
-	return bio;
+	return __bio_split_to_limits(bio, lim, &nr_segs);
 }
 EXPORT_SYMBOL(bio_split_to_limits);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b5536..36abbaefe38749 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2939,7 +2939,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct blk_plug *plug = current->plug;
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct blk_mq_hw_ctx *hctx;
-	unsigned int nr_segs = 1;
+	unsigned int nr_segs;
 	struct request *rq;
 	blk_status_t ret;
 
@@ -2981,11 +2981,10 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
-	if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
-		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
-		if (!bio)
-			goto queue_exit;
-	}
+	bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
+	if (!bio)
+		goto queue_exit;
+
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
 
diff --git a/block/blk.h b/block/blk.h
index e180863f918b15..0d8cd64c126064 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -331,33 +331,58 @@ ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
 
-static inline bool bio_may_exceed_limits(struct bio *bio,
-					 const struct queue_limits *lim)
+struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
+		unsigned *nsegs);
+struct bio *bio_split_write_zeroes(struct bio *bio,
+		const struct queue_limits *lim, unsigned *nsegs);
+struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
+		unsigned *nr_segs);
+
+/*
+ * All drivers must accept single-segments bios that are smaller than PAGE_SIZE.
+ *
+ * This is a quick and dirty check that relies on the fact that bi_io_vec[0] is
+ * always valid if a bio has data.  The check might lead to occasional false
+ * positives when bios are cloned, but compared to the performance impact of
+ * cloned bios themselves the loop below doesn't matter anyway.
+ */
+static inline bool bio_may_need_split(struct bio *bio,
+		const struct queue_limits *lim)
+{
+	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
+		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
+}
+
+/**
+ * __bio_split_to_limits - split a bio to fit the queue limits
+ * @bio:     bio to be split
+ * @lim:     queue limits to split based on
+ * @nr_segs: returns the number of segments in the returned bio
+ *
+ * Check if @bio needs splitting based on the queue limits, and if so split off
+ * a bio fitting the limits from the beginning of @bio and return it.  @bio is
+ * shortened to the remainder and re-submitted.
+ *
+ * The split bio is allocated from @q->bio_split, which is provided by the
+ * block layer.
+ */
+static inline struct bio *__bio_split_to_limits(struct bio *bio,
+		const struct queue_limits *lim, unsigned int *nr_segs)
 {
 	switch (bio_op(bio)) {
+	default:
+		if (bio_may_need_split(bio, lim))
+			return bio_split_rw(bio, lim, nr_segs);
+		*nr_segs = 1;
+		return bio;
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
+		return bio_split_discard(bio, lim, nr_segs);
 	case REQ_OP_WRITE_ZEROES:
-		return true; /* non-trivial splitting decisions */
-	default:
-		break;
+		return bio_split_write_zeroes(bio, lim, nr_segs);
 	}
-
-	/*
-	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
-	 * This is a quick and dirty check that relies on the fact that
-	 * bi_io_vec[0] is always valid if a bio has data.  The check might
-	 * lead to occasional false negatives when bios are cloned, but compared
-	 * to the performance impact of cloned bios themselves the loop below
-	 * doesn't matter anyway.
-	 */
-	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
-		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
 }
 
-struct bio *__bio_split_to_limits(struct bio *bio,
-				  const struct queue_limits *lim,
-				  unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index f04d931099601a..5ae7691849072b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -73,20 +73,13 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 
 static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_bio *orig_bbio,
-					 u64 map_length, bool use_append)
+					 u64 map_length)
 {
 	struct btrfs_bio *bbio;
 	struct bio *bio;
 
-	if (use_append) {
-		unsigned int nr_segs;
-
-		bio = bio_split_rw(&orig_bbio->bio, &fs_info->limits, &nr_segs,
-				   &btrfs_clone_bioset, map_length);
-	} else {
-		bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT,
-				GFP_NOFS, &btrfs_clone_bioset);
-	}
+	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
+			&btrfs_clone_bioset);
 	bbio = btrfs_bio(bio);
 	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
 	bbio->inode = orig_bbio->inode;
@@ -664,6 +657,19 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 	return true;
 }
 
+static u64 btrfs_append_map_length(struct btrfs_bio *bbio, u64 map_length)
+{
+	unsigned int nr_segs;
+	int sector_offset;
+
+	map_length = min(map_length, bbio->fs_info->max_zone_append_size);
+	sector_offset = bio_split_rw_at(&bbio->bio, &bbio->fs_info->limits,
+					&nr_segs, map_length);
+	if (sector_offset)
+		return sector_offset << SECTOR_SHIFT;
+	return map_length;
+}
+
 static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 {
 	struct btrfs_inode *inode = bbio->inode;
@@ -691,10 +697,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 	map_length = min(map_length, length);
 	if (use_append)
-		map_length = min(map_length, fs_info->max_zone_append_size);
+		map_length = btrfs_append_map_length(bbio, map_length);
 
 	if (map_length < length) {
-		bbio = btrfs_split_bio(fs_info, bbio, map_length, use_append);
+		bbio = btrfs_split_bio(fs_info, bbio, map_length);
 		bio = &bbio->bio;
 	}
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a46e2047bea4d2..faceadb040f9ac 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -324,8 +324,8 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
 void bio_trim(struct bio *bio, sector_t offset, sector_t size);
 extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
-struct bio *bio_split_rw(struct bio *bio, const struct queue_limits *lim,
-		unsigned *segs, struct bio_set *bs, unsigned max_bytes);
+int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
+		unsigned *segs, unsigned max_bytes);
 
 /**
  * bio_next_split - get next @sectors from a bio, splitting if necessary
-- 
2.43.0


