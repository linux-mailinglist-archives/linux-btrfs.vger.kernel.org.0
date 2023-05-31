Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333CF717929
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjEaH4Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjEaH4G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:56:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC0E1BF4
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9IJJpNl5pEIBhcbC/e2OA404Ji8FxLlNj2j64GmLGds=; b=DSjpUQqs+T2QrV2nPqlWosxR8l
        MyZagBnmgtuweZDOJ61msKP7dD+SOJlIorQz/W8aDXgXKUwJ8CVcOfFe/p/HPF8b2IohsU5rPGY77
        EcMjqtdRn4FjOaE8h/61ia7ve+dbUZV+aAJXsBkvGtusDA4ImOhKzN53bAkliC21Af4AUCQ6aH4qA
        2OnpixmvaFxwvhOvWAZGF1tJg1dApYsibCkOAl15G7tbc0lBHjPutbmYZW6U3ixD+h/CjwQtN1Hxx
        4QBxdLSRPLDaoohMyOrs9d9Vvu+IcODS11swCFmIzen9UubDyxcyQZY67Z+dILkkCUxz18tm9dof8
        TuR5ZHKg==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4GfI-00GWu9-1F;
        Wed, 31 May 2023 07:54:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/17] btrfs: add an ordered_extent pointer to struct btrfs_bio
Date:   Wed, 31 May 2023 09:54:02 +0200
Message-Id: <20230531075410.480499-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c         | 42 ++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/bio.h         |  9 +++------
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/inode.c       |  8 +++++---
 5 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 18afad50a98774..49ab2831483338 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -33,6 +33,11 @@ static inline bool is_data_bbio(struct btrfs_bio *bbio)
 	return bbio->inode && is_data_inode(&bbio->inode->vfs_inode);
 }
 
+static bool bbio_has_ordered_extent(struct btrfs_bio *bbio)
+{
+	return is_data_bbio(bbio) && btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE;
+}
+
 /*
  * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
  * is already initialized by the block layer.
@@ -88,11 +93,40 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	bbio->inode = orig_bbio->inode;
 	bbio->file_offset = orig_bbio->file_offset;
 	orig_bbio->file_offset += map_length;
-
+	if (bbio_has_ordered_extent(bbio)) {
+		refcount_inc(&orig_bbio->ordered->refs);
+		bbio->ordered = orig_bbio->ordered;
+	}
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
 }
 
+/* Free a bio that was never submitted to the underlying device */
+static void btrfs_cleanup_bio(struct btrfs_bio *bbio)
+{
+	if (bbio_has_ordered_extent(bbio))
+		btrfs_put_ordered_extent(bbio->ordered);
+	bio_put(&bbio->bio);
+}
+
+static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
+{
+	if (bbio_has_ordered_extent(bbio)) {
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
@@ -121,12 +155,12 @@ static void btrfs_orig_bbio_end_io(struct btrfs_bio *bbio)
 
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
@@ -679,7 +713,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 fail_put_bio:
 	if (map_length < length)
-		bio_put(bio);
+		btrfs_cleanup_bio(bbio);
 fail:
 	btrfs_bio_counter_dec(fs_info);
 	btrfs_bio_end_io(orig_bbio, ret);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 52e7962103fff2..ca79decee0607f 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -50,11 +50,13 @@ struct btrfs_bio {
 
 		/*
 		 * For data writes:
+		 * - ordered extent covering the bio
 		 * - pointer to the checksums for this bio
 		 * - original physical address from the allocator
 		 *   (for zone append only)
 		 */
 		struct {
+			struct btrfs_ordered_extent *ordered;
 			struct btrfs_ordered_sum *sums;
 			u64 orig_physical;
 		};
@@ -95,12 +97,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
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
index e187ff417370c7..e27f30417cefc8 100644
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
index af58147851d878..645723d16d5979 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -806,7 +806,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
 					ordered->file_offset +
 					ordered->disk_num_bytes - file_offset);
-			btrfs_put_ordered_extent(ordered);
+			bbio->ordered = ordered;
 		}
 
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ba8a61fa3d81fc..004b8f77d14d50 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2704,8 +2704,11 @@ static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
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
@@ -2722,8 +2725,7 @@ static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 	new = btrfs_split_ordered_extent(ordered, len);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
-	btrfs_put_ordered_extent(new);
-
+	bbio->ordered = new;
 	return 0;
 }
 
-- 
2.39.2

