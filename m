Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9BB645352
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 06:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLGFOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 00:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLGFOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 00:14:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B35F54B1D
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 21:14:14 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2382521C8C
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 05:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670390053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zhqlrdmkVo1y8XSaWXXO3edtqG7gnZYnhIVFEessJL4=;
        b=aM9E234MK+o0rvKBcVQBCA3pc1j/yLeRswq5UDhAwGP7rLghxgz/8X9mbcsjDNfMJO0fZi
        FGaIk2zG8xoIlQScVgCR6g21lmG+bpB63LsWOVLY3Z/V8MdKmUOQqLg3h482/KHI0YTtli
        vUEDjfcO9Vut3wGjTf444EP05fQSrwk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7B17A132F3
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 05:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yNybESQhkGNOAwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 05:14:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make btrfs_get_io_geometry() to return void
Date:   Wed,  7 Dec 2022 13:13:54 +0800
Message-Id: <b3d2350ae3920a475a43dba6f979731420859dc8.1670390031.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit 420343131970 ("btrfs: let callers of btrfs_get_io_geometry
pass the em"), btrfs_get_io_geometry() no longer calls
btrfs_get_chunk_map(), thus there is no more source of errors.
(The remaining ASSERT()s are really for careless developers)

So we can change btrfs_get_io_geometry() to return void and cleanup the
error handlings.

For most cases, the cleanup is pretty straight-forward, just remove the
error handling of btrfs_get_io_geometry().

But there is a small expcetion in
btrfs_encoded_read_regular_fill_pages(), which is already not that
straightforward:

		em = btrfs_get_chunk_map();
		if (IS_ERR(em)) {
			ret = PTR_ERR(em);
		} else {
			ret = btrfs_get_io_geometry(fs_info, em, BTRFS_MAP_READ,
						    disk_bytenr + cur, &geom);
			free_extent_map(em);
		}
		if (ret) {
			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
			break;
		}

Now it's much simpler for error handling:

		em = btrfs_get_chunk_map();
		if (IS_ERR(em)) {
			ret = PTR_ERR(em);
			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
			break;
		}
		btrfs_get_io_geometry(fs_info, em, BTRFS_MAP_READ,
				      disk_bytenr + cur, &geom);
		free_extent_map(em);

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  7 +------
 fs/btrfs/extent_io.c   |  6 +-----
 fs/btrfs/inode.c       | 20 +++++++-------------
 fs/btrfs/volumes.c     | 16 +++++-----------
 fs/btrfs/volumes.h     |  7 ++++---
 5 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 5122ca79f7ea..af1dc12df127 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -342,7 +342,6 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	struct btrfs_io_geometry geom;
 	struct extent_map *em;
 	struct bio *bio;
-	int ret;
 
 	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf, endio_func, cb);
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
@@ -356,12 +355,8 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND)
 		bio_set_dev(bio, em->map_lookup->stripes[0].dev->bdev);
 
-	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), disk_bytenr, &geom);
+	btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), disk_bytenr, &geom);
 	free_extent_map(em);
-	if (ret < 0) {
-		bio_put(bio);
-		return ERR_PTR(ret);
-	}
 	*next_stripe_start = disk_bytenr + geom.len;
 	refcount_inc(&cb->pending_ios);
 	return bio;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 83dd3aa59663..97f87e379ea5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1317,7 +1317,6 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	struct btrfs_ordered_extent *ordered;
 	struct extent_map *em;
 	u64 logical = (bio_ctrl->bio->bi_iter.bi_sector << SECTOR_SHIFT);
-	int ret;
 
 	/*
 	 * Pages for compressed extent are never submitted to disk directly,
@@ -1334,12 +1333,9 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	em = btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);
 	if (IS_ERR(em))
 		return PTR_ERR(em);
-	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),
+	btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),
 				    logical, &geom);
 	free_extent_map(em);
-	if (ret < 0) {
-		return ret;
-	}
 	if (geom.len > U32_MAX)
 		bio_ctrl->len_to_stripe_boundary = U32_MAX;
 	else
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 905ea19df125..490db7db1806 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8041,7 +8041,6 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 	u64 clone_offset = 0;
 	u64 clone_len;
 	u64 logical;
-	int ret;
 	blk_status_t status;
 	struct btrfs_io_geometry geom;
 	struct btrfs_dio_data *dio_data = iter->private;
@@ -8082,12 +8081,8 @@ static void btrfs_submit_direct(const struct iomap_iter *iter,
 			em = NULL;
 			goto out_err_em;
 		}
-		ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
-					    logical, &geom);
-		if (ret) {
-			status = errno_to_blk_status(ret);
-			goto out_err_em;
-		}
+		btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio), logical,
+				      &geom);
 
 		clone_len = min(submit_len, geom.len);
 		ASSERT(clone_len <= UINT_MAX);
@@ -10392,15 +10387,14 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					 disk_io_size - cur);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
-		} else {
-			ret = btrfs_get_io_geometry(fs_info, em, BTRFS_MAP_READ,
-						    disk_bytenr + cur, &geom);
-			free_extent_map(em);
-		}
-		if (ret) {
 			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
 			break;
 		}
+
+		btrfs_get_io_geometry(fs_info, em, BTRFS_MAP_READ,
+				      disk_bytenr + cur, &geom);
+		free_extent_map(em);
+
 		remaining = min(geom.len, disk_io_size - cur);
 		while (bio || remaining) {
 			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f69475fb1bc1..8edd4069b2df 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6269,13 +6269,11 @@ static bool need_full_stripe(enum btrfs_map_op op)
  * @op:      type of operation - write or read
  * @logical: address that we want to figure out the geometry of
  * @io_geom: pointer used to return values
- *
- * Returns < 0 in case a chunk for the given logical address cannot be found,
- * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
  */
-int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
-			  enum btrfs_map_op op, u64 logical,
-			  struct btrfs_io_geometry *io_geom)
+void btrfs_get_io_geometry(struct btrfs_fs_info *fs_info,
+			   struct extent_map *em,
+			   enum btrfs_map_op op, u64 logical,
+			   struct btrfs_io_geometry *io_geom)
 {
 	struct map_lookup *map;
 	u64 len;
@@ -6342,8 +6340,6 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	io_geom->stripe_nr = stripe_nr;
 	io_geom->stripe_offset = stripe_offset;
 	io_geom->raid56_stripe_offset = raid56_full_stripe_start;
-
-	return 0;
 }
 
 static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *map,
@@ -6389,9 +6385,7 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 
-	ret = btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
-	if (ret < 0)
-		return ret;
+	btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
 
 	map = em->map_lookup;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6b7a05f6cf82..b10f20612916 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -545,9 +545,10 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 					       u64 logical, u64 *length_ret,
 					       u32 *num_stripes);
-int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
-			  enum btrfs_map_op op, u64 logical,
-			  struct btrfs_io_geometry *io_geom);
+void btrfs_get_io_geometry(struct btrfs_fs_info *fs_info,
+			   struct extent_map *map,
+			   enum btrfs_map_op op, u64 logical,
+			   struct btrfs_io_geometry *io_geom);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-- 
2.38.1

