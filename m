Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD346FB4CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjEHQJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjEHQIz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC7C65B5
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qCg7c2Xb2HRfS3Nyx33QoFzN05w1CQttxiBpeNvx7DY=; b=AAOqk0DfsydAcgOozJ1bNDmIE9
        GM7cIkMjp3Ku49+ScaBfFweVfxjyU9Se15DDSZX4RWkH7WwOwg+mlAmI+EGUSpgyNQlgAn3S5Zdvg
        IRji266iuttLNkrmZbrTiusPMOKDLDereUAAr936S/DNgwj2rPmjOayDXag0EyWDIeaTlk+gTDah9
        OwmYSjbJaWZ+2D+mls7HdFzwbJATPTMqHdypg4is+c1GQwhCAn8TBfi28PTdkoh4KTeOJGBndbF68
        1Pt0q2xWkeyRzjpkDCoM+rehVGOfRw+zY31L1Ibr3dqL+IyT+Y3MXj4Lct582DwcD2uyznLUt1nO2
        delDTeUQ==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pv-000w2L-20;
        Mon, 08 May 2023 16:08:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/21] btrfs: add an ordered_extent pointer to struct btrfs_bio
Date:   Mon,  8 May 2023 09:08:34 -0700
Message-Id: <20230508160843.133013-13-hch@lst.de>
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

Add a pointer to the ordered_extent to the existing union in struct
btrfs_bio, so all code dealing with data write bios can just use a
pointer dereference to retrieve the ordered_extent instead of doing
multiple rbtree lookups per I/O.

The reference to this ordered_extent is dropped at end I/O time,
which implies that an extra one must be acquired when the bio is split.
This also requires moving the btrfs_extract_ordered_extent call into
btrfs_split_bio so that the invariant of always having a valid
ordered_extent reference for the btrfs_bio is kept.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c         | 65 ++++++++++++++++++++++++++++--------------
 fs/btrfs/bio.h         | 16 +++++------
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/inode.c       |  7 +++--
 5 files changed, 58 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index c38d3597169b5e..a1ad9aba2f7fc2 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -67,26 +67,13 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bbio;
 }
 
-static blk_status_t btrfs_bio_extract_ordered_extent(struct btrfs_bio *bbio)
-{
-	struct btrfs_ordered_extent *ordered;
-	int ret;
-
-	ordered = btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
-	if (WARN_ON_ONCE(!ordered))
-		return BLK_STS_IOERR;
-	ret = btrfs_extract_ordered_extent(bbio, ordered);
-	btrfs_put_ordered_extent(ordered);
-
-	return errno_to_blk_status(ret);
-}
-
 static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_bio *orig_bbio,
 					 u64 map_length, bool use_append)
 {
 	struct btrfs_bio *bbio;
 	struct bio *bio;
+	int ret;
 
 	if (use_append) {
 		unsigned int nr_segs;
@@ -101,12 +88,47 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
 	bbio->inode = orig_bbio->inode;
 	bbio->file_offset = orig_bbio->file_offset;
+	if (use_append) {
+		ret = btrfs_extract_ordered_extent(bbio, orig_bbio->ordered);
+		if (ret) {
+			bio_put(bio);
+			return ERR_PTR(ret);
+		}
+	} else if (is_data_bio(bbio) && btrfs_op(bio) == BTRFS_MAP_WRITE) {
+		refcount_inc(&orig_bbio->ordered->refs);
+		bbio->ordered = orig_bbio->ordered;
+	}
 	orig_bbio->file_offset += map_length;
-
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
 }
 
+/* Free a bio that was never submitted to the underlying device */
+static void btrfs_cleanup_bio(struct btrfs_bio *bbio)
+{
+	if (is_data_bio(bbio) && btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE)
+		btrfs_put_ordered_extent(bbio->ordered);
+	bio_put(&bbio->bio);
+}
+
+static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
+{
+	if (is_data_bio(bbio) && btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE) {
+		struct btrfs_ordered_extent *ordered = bbio->ordered;
+
+		bbio->end_io(bbio);
+		btrfs_put_ordered_extent(ordered);
+	} else {
+		bbio->end_io(bbio);
+	}
+}
+
+void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
+{
+	bbio->bio.bi_status = status;
+	__btrfs_bio_end_io(bbio);
+}
+
 static void btrfs_orig_write_end_io(struct bio *bio);
 
 static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
@@ -135,12 +157,12 @@ static void btrfs_orig_bbio_end_io(struct btrfs_bio *bbio)
 
 		if (bbio->bio.bi_status)
 			btrfs_bbio_propagate_error(bbio, orig_bbio);
-		bio_put(&bbio->bio);
+		btrfs_cleanup_bio(bbio);
 		bbio = orig_bbio;
 	}
 
 	if (atomic_dec_and_test(&bbio->pending_ios))
-		bbio->end_io(bbio);
+		__btrfs_bio_end_io(bbio);
 }
 
 static int next_repair_mirror(struct btrfs_failed_bio *fbio, int cur_mirror)
@@ -649,6 +671,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 	if (map_length < length) {
 		bbio = btrfs_split_bio(fs_info, bbio, map_length, use_append);
+		if (IS_ERR(bbio))  {
+			ret = errno_to_blk_status(PTR_ERR(bbio));
+			goto fail;
+		}
 		bio = &bbio->bio;
 	}
 
@@ -667,9 +693,6 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		if (use_append) {
 			bio->bi_opf &= ~REQ_OP_WRITE;
 			bio->bi_opf |= REQ_OP_ZONE_APPEND;
-			ret = btrfs_bio_extract_ordered_extent(bbio);
-			if (ret)
-				goto fail_put_bio;
 		}
 
 		/*
@@ -695,7 +718,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 fail_put_bio:
 	if (map_length < length)
-		bio_put(bio);
+		btrfs_cleanup_bio(bbio);
 fail:
 	btrfs_bio_counter_dec(fs_info);
 	btrfs_bio_end_io(orig_bbio, ret);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 000e807f785395..8c3bfb7e04cb41 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -39,8 +39,8 @@ struct btrfs_bio {
 
 	union {
 		/*
-		 * Data checksumming and original I/O information for internal
-		 * use in the btrfs_submit_bio machinery.
+		 * For data reads: checksumming and original I/O information.
+		 * (for internal use in the btrfs_submit_bio machinery only)
 		 */
 		struct {
 			u8 *csum;
@@ -48,7 +48,10 @@ struct btrfs_bio {
 			struct bvec_iter saved_iter;
 		};
 
-		/* For metadata parentness verification. */
+		/* For data writes: ordered extent covering the bio */
+		struct btrfs_ordered_extent *ordered;
+
+		/* For metadata: parentness verification. */
 		struct btrfs_tree_parent_check parent_check;
 	};
 
@@ -84,12 +87,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
 struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 				  struct btrfs_fs_info *fs_info,
 				  btrfs_bio_end_io_t end_io, void *private);
-
-static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
-{
-	bbio->bio.bi_status = status;
-	bbio->end_io(bbio);
-}
+void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 
 /* Submit using blkcg_punt_bio_submit. */
 #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a8791781a5d7d2..a3f8416125a8c1 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -305,10 +305,10 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_pages = nr_pages;
 	cb->bbio.bio.bi_iter.bi_sector = ordered->disk_bytenr >> SECTOR_SHIFT;
+	cb->bbio.ordered = ordered;
 	btrfs_add_compressed_bio_pages(cb);
 
 	btrfs_submit_bio(&cb->bbio, 0);
-	btrfs_put_ordered_extent(ordered);
 }
 
 /*
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 92e1edfcfb9cb4..7417ce759f6f48 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -917,7 +917,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
 					ordered->file_offset +
 					ordered->disk_num_bytes - file_offset);
-			btrfs_put_ordered_extent(ordered);
+			bbio->ordered = ordered;
 		}
 
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a425658cfbae0c..ff1f5014156390 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2807,8 +2807,11 @@ int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 		return -EINVAL;
 
 	/* No need to split if the ordered extent covers the entire bio. */
-	if (ordered->disk_num_bytes == len)
+	if (ordered->disk_num_bytes == len) {
+		refcount_inc(&ordered->refs);
+		bbio->ordered = ordered;
 		return 0;
+	}
 
 	/*
 	 * Don't split the extent_map for NOCOW extents, as we're writing into
@@ -2824,7 +2827,7 @@ int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 	new = btrfs_split_ordered_extent(ordered, len);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
-	btrfs_put_ordered_extent(new);
+	bbio->ordered = new;
 	return 0;
 }
 
-- 
2.39.2

