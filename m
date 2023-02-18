Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615BF69B794
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 02:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBRBu3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 20:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBRBuY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 20:50:24 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5516BDDC
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 17:50:22 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9B9473200893;
        Fri, 17 Feb 2023 20:50:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 17 Feb 2023 20:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1676685019; x=1676771419; bh=3TTsGx90k9FLD5dh42aOyscvG
        Dd/zrvPO/yEyv5Jpbc=; b=j/V6WTUHY5iy7toIx8twp/KaSGi2mggYgGJP9AGT8
        WPJ8edLQuGH4SSO5RdzpcrShQkqJjv22UShnelWcM6fCmndZvFN6eSQKZ9iBCQmw
        1SxvPDhKKuSjDKdWSEjxCeri8yy3Y/hLkiDwvGCY17V8vxaB6YEN9gCP0O10zv4p
        7TBREaaDuUhT6uUuPycSHFbM/k8glmAC9B13BnBid0IU1UlWz0RP1anY0Kdw9Zvo
        I3K1weEWkVTCZ6JUlDCJhdQa2V4cKfiM0oqRWx5gVLJE3YbW7EIO8kVrOOa6kGmq
        RtwwTCTk6MOdQSVgQE4rtiT9BF62y3mioVwNRdx2iWM0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1676685019; x=1676771419; bh=3TTsGx90k9FLD5dh42aOyscvGDd/zrvPO/y
        Eyv5Jpbc=; b=moRKuiIuQDboQW2kmP5yOM+6pcrGY+AwBMl93iNKrBoxhSDX4Tx
        RUHmap/ElDjrC70Oc0r725HjsxK0fdTHhB3WejEBDFVw4tdhqVj4YOVIitBG38Jc
        hlcp5OiHacEGPzs32fpXVgqdhI/SZDEuCXO4hJ6IrxwjGzSokyIGY6AVWdCuy5i2
        r28Ad+bZS9hAzkWzYTLPtJgnShB4Sw7RAsyCE71fnmJNIqPMZj3xyYWYwat5vVFU
        mTyeMSaix5RNuoJ4ml0CUv+aTcfxY/Hu3yltc3J6Dtc7cf/EkDMXi6fvix7wE2fG
        4Jbznij1BrOSGcW79V0BD4gpIwH3baoDRUA==
X-ME-Sender: <xms:2y7wY1ZY8FUT_3woF1HqjSO2HCfzkfq94_xgKbmqmYe1_8JH08fqng>
    <xme:2y7wY8b88NEwWK7eFUw-imy2pJmPZKzhM2t6XHOXTiS4HFCBLh_RwGWZFnnf9zggb
    6tQsTrnWcy_owwH4AY>
X-ME-Received: <xmr:2y7wY3_cnZg1V4LZibNaqkA-VAUDDxyxWqkhyUMfalGK2VqlyPKQuox1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejtddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeejjefgffelffetiedtvdeuueelleelgeefteevgeevte
    ffudetudduudeglefgheenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihho
X-ME-Proxy: <xmx:2y7wYzpoSHtBZ4XNy7UZzJnY4_YO5yICB8obNmZnqRtrOsvLA8CX-g>
    <xmx:2y7wYwpBNCkj3FGOwctY4zCLgm3kXqbvbapl17S9ls-zn2pHvX047w>
    <xmx:2y7wY5RJzZ8sev4rcIy-ixVg6WlMM3KIAa1C3hZxhKFPgt8ynYrRAQ>
    <xmx:2y7wY3Rq9J_GyQdRZLpcpiCVw_K5TNh3iVlpoJao5EnSWrr_YzeF2g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Feb 2023 20:50:18 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix dio continue after short write due to source fault
Date:   Fri, 17 Feb 2023 17:50:17 -0800
Message-Id: <ae81e48b0e954bae1c3451c0da1a24ae7146606c.1676684984.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Downstream bug report:
https://bugzilla.redhat.com/show_bug.cgi?id=2169947

If an application is doing direct io to a btrfs file and experiences a
page fault reading from the source, iomap will issue a partial bio, and
allow the fs to keep going. However, there was a subtle bug in this
codepath in the btrfs dio iomap implementation that led to the partial
write ending up as a gap in the file's extents and to be read back as
zeros.

In this case, iomap_dio_iter will submit a partial bio, then iomap_iter
calls iomap_end (btrfs_dio_iomap_end) and then __iomap_dio_rw will
return back to btrfs_direct_write to try again, which it does.

However, btrfs_dio_iomap_end detects this short write condition and
marks the whole ordered extent finished, but not uptodate, which results
in essentially discarding it as unfinished. Further, when the partial
bio completes, it does not trigger finishing the ordered extent, because
bytes_left > 0, and we need the rest of the (nonexistent) bios to finish.

btrfs_direct_write picks it up there and writes out the rest of the file
just fine, but nothing goes back for that lost partial write, which
results in the observed, buggy behavior.

We considered a few options for fixing the bug (apologies for any
incorrect summary of a proposal which I didn't implement and fully
understand):
1. treat the partial bio as if we had truncated the file, which would
   result in properly finishing it.
2. split the ordered extent when submitting a partial bio.
3. cache the ordered extent across calls to __iomap_dio_rw in
   iter->private, so that we could reuse it and correctly apply several
   bios to it.

I had trouble with 1, and it felt the most like a hack, so I tried 2
and 3. Since 3 has the benefit of also not creating an extra file
extent, and avoids an ordered extent lookup during bio submission, it
felt like the best option.

A quick summary of the changes necessary to implement this cached
behavior:
- modify add_ordered_extent to create an __add_ordered_extent variant
  which refcounts and returns the ordered extent, to save a lookup
  during caching.
- store the ordered_extent on btrfs_dio_data (which had to move to
  fs/btrfs/file.h where fs/btrfs/file.c could see it)
- zero the btrfs_dio_data before using it, since its fields constitute
  state now.
- on the re-loop case in btrfs_direct_write, pull out the
  ordered_extent, zero the rest of the fields, and put the ordered
  extent back in.
- when the write is done, put the ordered_extent.
- if the short write happens to be length 0, then we _don't_ get an
  extra bio, so we do need to cancel the ordered_extent like we used
  to (and ditch the cached ordered extent)
- in btrfs_dio_iomap_begin, if the cached ordered extent is present,
  skip all the work of creating it, just look up the extent mapping and
  jump to setting up the iomap. (This part could likely be more
  elegant..)

Thanks to Josef, Christoph, and Filipe with their help figuring out the
bug and the fix.

Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/btrfs_inode.h  |  4 ++-
 fs/btrfs/file.c         | 19 ++++++++++-
 fs/btrfs/file.h         |  8 +++++
 fs/btrfs/inode.c        | 75 ++++++++++++++++++++++++++---------------
 fs/btrfs/ordered-data.c | 45 ++++++++++++++++++++-----
 fs/btrfs/ordered-data.h |  7 +++-
 fs/iomap/direct-io.c    |  1 -
 7 files changed, 119 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 49a92aa65de1..977b7aaa3db3 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -515,8 +515,10 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
 		       size_t done_before);
+
+struct btrfs_dio_data;
 struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
-				  size_t done_before);
+				  struct btrfs_dio_data *data, size_t done_before);
 
 extern const struct dentry_operations btrfs_dentry_operations;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5cc5a1faaef5..60a6711e25fa 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1464,7 +1464,11 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	loff_t endbyte;
 	ssize_t err;
 	unsigned int ilock_flags = 0;
+	struct btrfs_dio_data dio_data;
 	struct iomap_dio *dio;
+	struct btrfs_ordered_extent *tmp;
+
+	memset(&dio_data, 0, sizeof(dio_data));
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1526,7 +1530,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * got -EFAULT, faulting in the pages before the retry.
 	 */
 	from->nofault = true;
-	dio = btrfs_dio_write(iocb, from, written);
+	dio = btrfs_dio_write(iocb, from, &dio_data, written);
 	from->nofault = false;
 
 	/*
@@ -1564,11 +1568,24 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		if (left == prev_left) {
 			err = -ENOTBLK;
 		} else {
+			tmp = dio_data.ordered;
+			memset(&dio_data, 0, sizeof(dio_data));
+			dio_data.ordered = tmp;
 			fault_in_iov_iter_readable(from, left);
 			prev_left = left;
 			goto relock;
 		}
 	}
+	/*
+	 * We can't loop back to btrfs_dio_write, so we can drop the cached
+	 * ordered extent. Typically btrfs_dio_iomap_end will run and put the
+	 * ordered_extent, but this is needed to clean up in case of an error
+	 * path breaking out of iomap_iter before the final iomap_end call.
+	 */
+	if (dio_data.ordered) {
+		btrfs_put_ordered_extent(dio_data.ordered);
+		dio_data.ordered = NULL;
+	}
 
 	/*
 	 * If 'err' is -ENOTBLK or we have not written all data, then it means
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index 82b34fbb295f..3d4427881eb6 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -5,6 +5,14 @@
 
 extern const struct file_operations btrfs_file_operations;
 
+struct btrfs_dio_data {
+	ssize_t submitted;
+	struct extent_changeset *data_reserved;
+	bool data_space_reserved;
+	bool nocow_done;
+	struct btrfs_ordered_extent *ordered;
+};
+
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root, struct btrfs_inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 44e9acc77a74..b95dbd611261 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -76,13 +76,6 @@ struct btrfs_iget_args {
 	struct btrfs_root *root;
 };
 
-struct btrfs_dio_data {
-	ssize_t submitted;
-	struct extent_changeset *data_reserved;
-	bool data_space_reserved;
-	bool nocow_done;
-};
-
 struct btrfs_dio_private {
 	/* Range of I/O */
 	u64 file_offset;
@@ -6976,6 +6969,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 }
 
 static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
+						  struct btrfs_dio_data *dio_data,
 						  const u64 start,
 						  const u64 len,
 						  const u64 orig_start,
@@ -6986,7 +6980,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const int type)
 {
 	struct extent_map *em = NULL;
-	int ret;
+	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
 		em = create_io_em(inode, start, len, orig_start, block_start,
@@ -6996,25 +6990,27 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		if (IS_ERR(em))
 			goto out;
 	}
-	ret = btrfs_add_ordered_extent(inode, start, len, len, block_start,
-				       block_len, 0,
-				       (1 << type) |
-				       (1 << BTRFS_ORDERED_DIRECT),
-				       BTRFS_COMPRESS_NONE);
-	if (ret) {
+	ordered = __btrfs_add_ordered_extent(inode, start, len, len, block_start,
+					     block_len, 0,
+					     (1 << type) |
+					     (1 << BTRFS_ORDERED_DIRECT),
+					     BTRFS_COMPRESS_NONE);
+	if (IS_ERR(ordered)) {
 		if (em) {
 			free_extent_map(em);
 			btrfs_drop_extent_map_range(inode, start,
 						    start + len - 1, false);
 		}
-		em = ERR_PTR(ret);
+		em = ERR_PTR(PTR_ERR(ordered));
+	} else {
+		dio_data->ordered = ordered;
 	}
  out:
-
 	return em;
 }
 
 static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
+						  struct btrfs_dio_data *dio_data,
 						  u64 start, u64 len)
 {
 	struct btrfs_root *root = inode->root;
@@ -7030,7 +7026,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	if (ret)
 		return ERR_PTR(ret);
 
-	em = btrfs_create_dio_extent(inode, start, ins.offset, start,
+	em = btrfs_create_dio_extent(inode, dio_data,
+				     start, ins.offset, start,
 				     ins.objectid, ins.offset, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -7375,7 +7372,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 		space_reserved = true;
 
-		em2 = btrfs_create_dio_extent(BTRFS_I(inode), start, len,
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data,
+					      start, len,
 					      orig_start, block_start,
 					      len, orig_block_len,
 					      ram_bytes, type);
@@ -7417,7 +7415,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			goto out;
 		space_reserved = true;
 
-		em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
+		em = btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
@@ -7521,6 +7519,16 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		}
 	}
 
+	if (dio_data->ordered && write) {
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
+				      dio_data->ordered->file_offset,
+				      dio_data->ordered->bytes_left);
+		if (IS_ERR(em)) {
+			ret = PTR_ERR(em);
+			goto err;
+		}
+		goto out;
+	}
 	memset(dio_data, 0, sizeof(*dio_data));
 
 	/*
@@ -7543,6 +7551,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 			goto err;
 	}
 
+
 	/*
 	 * If this errors out it's because we couldn't invalidate pagecache for
 	 * this range and we need to fallback to buffered IO, or we are doing a
@@ -7662,6 +7671,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	else
 		free_extent_state(cached_state);
 
+out:
 	/*
 	 * Translate extent map information to iomap.
 	 * We trim the extents (and move the addr) even though iomap code does
@@ -7715,13 +7725,25 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	if (submitted < length) {
 		pos += submitted;
 		length -= submitted;
-		if (write)
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
-						       pos, length, false);
-		else
+		if (!write)
 			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
 				      pos + length - 1, NULL);
+		else {
+			if (submitted == 0) {
+				btrfs_mark_ordered_io_finished(BTRFS_I(inode),
+							       NULL, pos,
+							       length, false);
+				btrfs_put_ordered_extent(dio_data->ordered);
+				dio_data->ordered = NULL;
+			}
+		}
 		ret = -ENOTBLK;
+	} else {
+		/* On the last bio, release our cached ordered_extent */
+		if (write) {
+			btrfs_put_ordered_extent(dio_data->ordered);
+			dio_data->ordered = NULL;
+		}
 	}
 
 	if (write)
@@ -7785,18 +7807,17 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
 ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
 {
 	struct btrfs_dio_data data;
+	memset(&data, 0, sizeof(data));
 
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
 			    IOMAP_DIO_PARTIAL, &data, done_before);
 }
 
 struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
-				  size_t done_before)
+				  struct btrfs_dio_data *data, size_t done_before)
 {
-	struct btrfs_dio_data data;
-
 	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, &data, done_before);
+			    IOMAP_DIO_PARTIAL, data, done_before);
 }
 
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6c24b69e2d0a..a4c7eed811eb 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -160,14 +160,16 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
  * @compress_type:   Compression algorithm used for data.
  *
  * Most of these parameters correspond to &struct btrfs_file_extent_item. The
- * tree is given a single reference on the ordered extent that was inserted.
+ * tree is given a single reference on the ordered extent that was inserted, and
+ * the returned pointer is given a second reference.
  *
- * Return: 0 or -ENOMEM.
+ * Return: the new ordered_extent or ERR_PTR(-ENOMEM).
  */
-int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
-			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			     u64 disk_num_bytes, u64 offset, unsigned flags,
-			     int compress_type)
+struct btrfs_ordered_extent *__btrfs_add_ordered_extent(
+			struct btrfs_inode *inode, u64 file_offset,
+			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			u64 disk_num_bytes, u64 offset, unsigned long flags,
+			int compress_type)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -181,7 +183,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
 		if (ret < 0)
-			return ret;
+			return ERR_PTR(ret);
 		ret = 0;
 	} else {
 		/*
@@ -190,11 +192,11 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 		 */
 		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
 		if (ret < 0)
-			return ret;
+			return ERR_PTR(ret);
 	}
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
 	if (!entry)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	entry->file_offset = file_offset;
 	entry->num_bytes = num_bytes;
@@ -256,6 +258,31 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 	btrfs_mod_outstanding_extents(inode, 1);
 	spin_unlock(&inode->lock);
 
+	/* one ref for the returned entry to match semantics of lookup */
+	refcount_inc(&entry->refs);
+	return entry;
+}
+
+
+/*
+ * Add a new btrfs_ordered_extent for the range, but drop the reference
+ * instead of returning it to the caller.
+ */
+int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
+			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			     u64 disk_num_bytes, u64 offset, unsigned long flags,
+			     int compress_type)
+{
+	struct btrfs_ordered_extent *ordered;
+
+	ordered = __btrfs_add_ordered_extent(inode, file_offset, num_bytes,
+					     ram_bytes, disk_bytenr,
+					     disk_num_bytes, offset, flags,
+					     compress_type);
+
+	if (IS_ERR(ordered))
+		return PTR_ERR(ordered);
+	btrfs_put_ordered_extent(ordered);
 	return 0;
 }
 
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index eb40cb39f842..d09048655dfb 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -178,9 +178,14 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 				    struct btrfs_ordered_extent **cached,
 				    u64 file_offset, u64 io_size);
+struct btrfs_ordered_extent *__btrfs_add_ordered_extent(
+			struct btrfs_inode *inode, u64 file_offset,
+			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
+			u64 disk_num_bytes, u64 offset, unsigned long flags,
+			int compress_type);
 int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
-			     u64 disk_num_bytes, u64 offset, unsigned flags,
+			     u64 disk_num_bytes, u64 offset, unsigned long flags,
 			     int compress_type);
 void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 			   struct btrfs_ordered_sum *sum);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f771001574d0..b1277e615478 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -131,7 +131,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 		ret += dio->done_before;
 
 	kfree(dio);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_complete);
-- 
2.38.1

