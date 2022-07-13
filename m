Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35F5572E04
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiGMGON (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiGMGOL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:14:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F17B9DAF
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dMKpX1dIHlhdNidEEDiGiSfeWH7HONpyz9vbNPFO+N8=; b=tqsndFtkVtUWqSPOq8OAGEsJQU
        BVsyPUcbMOiZwjdBon0/1CipaMs58DeciLxLTv5aSHcpQ1CNhFEwca3NVHspYvDl7p0L2cRmScUWH
        +/WksybRYoRMIAf1kxGDVPv2Jk/n05AqyyciByXSZkOhiJFmvgkrCBGVN+qZHCLLcYQTeEHe0x6dQ
        OAkFdfdTLyrw2VsfNewTCOX9ppf3m84Ej0FzgZXdexcFBrOCfO3+q6GdVhbFq2TK2uyjzABztjxO4
        Up0rVG5/vzmUrExbwQrmynFANxr5Vr3HE2fWORLRq0tFaMC4zWfvORU5ZFjpgwTI285+wOWOJg0RV
        JYkdqCeg==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVdO-000T0x-Ie; Wed, 13 Jul 2022 06:14:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 02/11] btrfs: move btrfs_bio allocation to volumes.c
Date:   Wed, 13 Jul 2022 08:13:50 +0200
Message-Id: <20220713061359.1980118-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713061359.1980118-1-hch@lst.de>
References: <20220713061359.1980118-1-hch@lst.de>
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

volumes.c is the place that implements the storage layer using the
btrfs_bio structure, so move the bio_set and allocation helpers there
as well.

To make up for the new initialization boilerplate, merge the two
init/exit helpers in extent_io.c into a single one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-io-tree.h |  4 +--
 fs/btrfs/extent_io.c      | 74 ++++-----------------------------------
 fs/btrfs/extent_io.h      |  3 --
 fs/btrfs/super.c          |  6 ++--
 fs/btrfs/volumes.c        | 58 ++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h        |  3 ++
 6 files changed, 72 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index c3eb52dbe61cc..819763ace0aca 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -96,8 +96,8 @@ struct extent_state {
 #endif
 };
 
-int __init extent_state_cache_init(void);
-void __cold extent_state_cache_exit(void);
+int __init volumes_init(void);
+void __cold volumes_exit(void);
 
 void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 			 struct extent_io_tree *tree, unsigned int owner,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 35c609aaeda4a..f3a7614333cb7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -33,7 +33,6 @@
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
-static struct bio_set btrfs_bioset;
 
 static inline bool extent_state_in_tree(const struct extent_state *state)
 {
@@ -232,41 +231,23 @@ static void submit_write_bio(struct extent_page_data *epd, int ret)
 	}
 }
 
-int __init extent_state_cache_init(void)
+int __init extent_io_init(void)
 {
 	extent_state_cache = kmem_cache_create("btrfs_extent_state",
 			sizeof(struct extent_state), 0,
 			SLAB_MEM_SPREAD, NULL);
 	if (!extent_state_cache)
 		return -ENOMEM;
-	return 0;
-}
 
-int __init extent_io_init(void)
-{
 	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
 			sizeof(struct extent_buffer), 0,
 			SLAB_MEM_SPREAD, NULL);
-	if (!extent_buffer_cache)
+	if (!extent_buffer_cache) {
+		kmem_cache_destroy(extent_state_cache);
 		return -ENOMEM;
-
-	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
-			offsetof(struct btrfs_bio, bio),
-			BIOSET_NEED_BVECS))
-		goto free_buffer_cache;
+	}
 
 	return 0;
-
-free_buffer_cache:
-	kmem_cache_destroy(extent_buffer_cache);
-	extent_buffer_cache = NULL;
-	return -ENOMEM;
-}
-
-void __cold extent_state_cache_exit(void)
-{
-	btrfs_extent_state_leak_debug_check();
-	kmem_cache_destroy(extent_state_cache);
 }
 
 void __cold extent_io_exit(void)
@@ -277,7 +258,8 @@ void __cold extent_io_exit(void)
 	 */
 	rcu_barrier();
 	kmem_cache_destroy(extent_buffer_cache);
-	bioset_exit(&btrfs_bioset);
+	btrfs_extent_state_leak_debug_check();
+	kmem_cache_destroy(extent_state_cache);
 }
 
 /*
@@ -3157,50 +3139,6 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array)
 	return 0;
 }
 
-/*
- * Initialize the members up to but not including 'bio'. Use after allocating a
- * new bio by bio_alloc_bioset as it does not initialize the bytes outside of
- * 'bio' because use of __GFP_ZERO is not supported.
- */
-static inline void btrfs_bio_init(struct btrfs_bio *bbio)
-{
-	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
-}
-
-/*
- * Allocate a btrfs_io_bio, with @nr_iovecs as maximum number of iovecs.
- *
- * The bio allocation is backed by bioset and does not fail.
- */
-struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
-{
-	struct bio *bio;
-
-	ASSERT(0 < nr_iovecs && nr_iovecs <= BIO_MAX_VECS);
-	bio = bio_alloc_bioset(NULL, nr_iovecs, 0, GFP_NOFS, &btrfs_bioset);
-	btrfs_bio_init(btrfs_bio(bio));
-	return bio;
-}
-
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
-{
-	struct bio *bio;
-	struct btrfs_bio *bbio;
-
-	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
-
-	/* this will never fail when it's backed by a bioset */
-	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
-	ASSERT(bio);
-
-	bbio = btrfs_bio(bio);
-	btrfs_bio_init(bbio);
-
-	bio_trim(bio, offset >> 9, size >> 9);
-	bbio->iter = bio->bi_iter;
-	return bio;
-}
-
 /**
  * Attempt to add a page to bio
  *
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 9dec34c009e91..75194aee6a42e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -60,7 +60,6 @@ enum {
 struct btrfs_bio;
 struct btrfs_root;
 struct btrfs_inode;
-struct btrfs_io_bio;
 struct btrfs_fs_info;
 struct io_failure_record;
 struct extent_io_tree;
@@ -242,8 +241,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  u32 bits_to_clear, unsigned long page_ops);
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
-struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
-struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4c7089b1681b3..96b22ee7b12ce 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2664,7 +2664,7 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_cachep;
 
-	err = extent_state_cache_init();
+	err = volumes_init();
 	if (err)
 		goto free_extent_io;
 
@@ -2723,7 +2723,7 @@ static int __init init_btrfs_fs(void)
 free_extent_map:
 	extent_map_exit();
 free_extent_state_cache:
-	extent_state_cache_exit();
+	volumes_exit();
 free_extent_io:
 	extent_io_exit();
 free_cachep:
@@ -2744,7 +2744,7 @@ static void __exit exit_btrfs_fs(void)
 	btrfs_prelim_ref_exit();
 	ordered_data_exit();
 	extent_map_exit();
-	extent_state_cache_exit();
+	volumes_exit();
 	extent_io_exit();
 	btrfs_interface_exit();
 	unregister_filesystem(&btrfs_fs_type);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bf4e140f6bfc7..6825f62364c29 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -34,6 +34,8 @@
 #include "discard.h"
 #include "zoned.h"
 
+static struct bio_set btrfs_bioset;
+
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
 					 BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -6609,6 +6611,48 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1);
 }
 
+/*
+ * Initialize a btrfs_bio structure.  This skips the embedded bio itself as it
+ * is already initialized by the block layer.
+ */
+static inline void btrfs_bio_init(struct btrfs_bio *bbio)
+{
+	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
+}
+
+/*
+ * Allocate a btrfs_bio structure.  The btrfs_bio is the main I/O container for
+ * btrfs, and is used for all I/O submitted through btrfs_submit_bio.
+ *
+ * Just like the underlying bio_alloc_bioset it will no fail as it is backed by
+ * a mempool.
+ */
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs)
+{
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(NULL, nr_vecs, 0, GFP_NOFS, &btrfs_bioset);
+	btrfs_bio_init(btrfs_bio(bio));
+	return bio;
+}
+
+struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
+{
+	struct bio *bio;
+	struct btrfs_bio *bbio;
+
+	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
+
+	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
+	bbio = btrfs_bio(bio);
+	btrfs_bio_init(bbio);
+
+	bio_trim(bio, offset >> 9, size >> 9);
+	bbio->iter = bio->bi_iter;
+	return bio;
+
+}
+
 static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_io_context *bioc)
 {
 	if (bioc->orig_bio->bi_opf & REQ_META)
@@ -8294,3 +8338,17 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 
 	return true;
 }
+
+int __init volumes_init(void)
+{
+	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
+			offsetof(struct btrfs_bio, bio),
+			BIOSET_NEED_BVECS))
+		return -ENOMEM;
+	return 0;
+}
+
+void __cold volumes_exit(void)
+{
+	bioset_exit(&btrfs_bioset);
+}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5639961b3626f..fb57b50fb60b1 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -393,6 +393,9 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 	return container_of(bio, struct btrfs_bio, bio);
 }
 
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs);
+struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
+
 static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 {
 	if (bbio->csum != bbio->csum_inline) {
-- 
2.30.2

