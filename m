Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602F06AF6EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 21:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCGUtj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 15:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjCGUti (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 15:49:38 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD32AA736
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 12:49:35 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CFD8E3200AA2;
        Tue,  7 Mar 2023 15:49:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 07 Mar 2023 15:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1678222172; x=1678308572; bh=lnhmeUhyV5
        v6hDi9p3UnIurbsJ14bFrUbLU263GhI1Q=; b=iNh5fUO0REwJ5DhgkSnt/UUnwY
        hYuKpwE5VNRgYXeXcHtgkKJoXqwvlzzwgHOnybyyDA9e/naeEkEFcPReW+ke1vAS
        a2UcJoksTzyMykxT0+b8qyGqf8iWpsR576A6Y8zFvl01/W+ymefTlRiXreWZj/2a
        TCj7L/M0BO1D4T72XCs6/jgQ1NG/4xlFQGiKYT+U3KqMO8tj6SSbicHY5hVbI1G2
        Wm60qCFRwkf2eAHTPZPvsFrktENWGWCPhw/nYME0Je/wqnPCTFFkKBJGFBQ3JRGc
        Bp7J4tz0uFwLcTzoZqpIqX+ahLZ0dfWu5sJGKNtfJQ6sspsdvY7ajudr9FTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1678222172; x=1678308572; bh=lnhmeUhyV5v6hDi9p3UnIurbsJ14
        bFrUbLU263GhI1Q=; b=rm9ojHwzfwPLWnut3jepLcEbtyLPaZ3rPdriXS7T7KF1
        Wmga7XtwfDgIlm1vCFWJeHNPTh7MTYHe8anS1QTHzcD3Lpz95aSRrvZrj2+w1Rka
        3cVg/F4ZdT0+6YVlkgiSA5HDttK9yNoURd6R7Z91IV5bUdlKs+DjNFbQBqdqXXZc
        rxnxkvdmukq/NN065FF7AgDzNPW3kMbshxd8dd2ZmDHYlBDmQLvkjoToFQ6cuHDp
        CUgA0UplLlUt4k+0VNhj9tTuQKbxQ1zX7JY6XCYFzJNI6O8KZMXZkTJvCT9JKycR
        tDijo5/xpL9j9LVbNMMfsOkFJr9WmrGOdqI7duqhrQ==
X-ME-Sender: <xms:XKMHZHE3fTG14YiZcSwoZD4wkYsdrrA6ZHexycj2vEqtbSIi7FstHQ>
    <xme:XKMHZEU9QvSIkZ76Xy1F75K5wiR4f37EUBBUjg4qLrgLqGTuAe54vEAnPiiVC-6Ym
    kdHvQ9gorfSYR2By34>
X-ME-Received: <xmr:XKMHZJJsPMzbrtVl-o5-e99bn-hGllSzvvI0SZLJwsRvzFHuOCanZbaG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddutddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepjeeltefgkefhgedtveduueffudejtdektefhjeeghe
    ffkeffvdejvedvudeuhfetnecuffhomhgrihhnpehrvgguhhgrthdrtghomhdpkhgvrhhn
    vghlrdhorhhgpdhprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:XKMHZFHSwDarflK55dvqvFncmzHp3EHIOycYI3yXnfy_xTw6yYg9Cg>
    <xmx:XKMHZNUW_unSfq8ERJGa1kkFVkBLZ7Hf6ZOCAqbF_ScQZU1gMaHJQA>
    <xmx:XKMHZAOz9Sy92ziOjI95FbeplB2Zs_4cWwzqRpJxwcu2GpBvt66rqQ>
    <xmx:XKMHZOfJn2L4SUmzAQk7NCaSOotc56rFrGM_i6CgeuaSc-kg-0yUcQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Mar 2023 15:49:31 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3] btrfs: fix dio continue after short write due to buffer page fault
Date:   Tue,  7 Mar 2023 12:49:30 -0800
Message-Id: <6733f2fac24b674d9f60dc1093de30513c099629.1678212067.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If an application is doing direct io to a btrfs file and experiences a
page fault reading from the write buffer, iomap will issue a partial
bio, and allow the fs to keep going. However, there was a subtle bug in
this code path in the btrfs dio iomap implementation that led to the
partial write ending up as a gap in the file's extents and to be read
back as zeros.

The sequence of events in a partial write, lightly summarized and
trimmed down for brevity is as follows:

  ====WRITING TASK====
  btrfs_direct_write
  __iomap_dio_write
  iomap_iter
    btrfs_dio_iomap_begin # create full ordered extent
  iomap_dio_bio_iter
    bio_iov_iter_get_pages # page fault; partial read
    submit_bio # partial bio
  iomap_iter
    btrfs_dio_iomap_end
      btrfs_mark_ordered_io_finished # sets BTRFS_ORDERED_IOERR;
				     # submit to finish_ordered_fn wq
  fault_in_iov_iter_readable # btrfs_direct_write detects partial write
  __iomap_dio_write
  iomap_iter
    btrfs_dio_iomap_begin # create second partial ordered extent
  iomap_dio_bio_iter
    bio_iov_iter_get_pages # read all of remainder
    submit_bio # partial bio with all of remainder
  iomap_iter
    btrfs_dio_iomap_end # nothing exciting to do with ordered io

  ====DIO ENDIO====
  ==FIRST PARTIAL BIO==
  btrfs_dio_end_io
    btrfs_mark_ordered_io_finished # bytes_left > 0
				   # don't submit to finish_ordered_fn wq
  ==SECOND PARTIAL BIO==
  btrfs_dio_end_io
    btrfs_mark_ordered_io_finished # bytes_left == 0
				   # submit to finish_ordered_fn wq

  ====BTRFS FINISH ORDERED WQ====
  ==FIRST PARTIAL BIO==
  btrfs_finish_ordered_io # called by dio_iomap_end_io, sees
			  # BTRFS_ORDERED_IOERR, just drops the
			  # ordered_extent
  ==SECOND PARTIAL BIO==
  btrfs_finish_ordered_io # called by btrfs_dio_end_io, writes out file
			  # extents, csums, etc...

The essence of the problem is that while btrfs_direct_write and iomap
properly interact to submit all the correct bios, there is insufficient
logic in the btrfs dio functions (btrfs_dio_iomap_begin,
btrfs_dio_submit_io, btrfs_dio_end_io, and btrfs_dio_iomap_end) to
ensure that every bio is at least a part of a completed ordered_extent.
And it is completing an ordered_extent that results in crucial
functionality like inserting a file extent item for the range in the
subvolume/fs tree.

More specifically, btrfs_dio_end_io treats the ordered extent as
unfinished but btrfs_dio_iomap_end sets BTRFS_ORDERED_IOERR on it.
Thus, the finish io work doesn't result in file extents, csums, etc...
In the aftermath, such a file behaves as though it has a hole in it,
instead of the purportedly written data.

We considered a few options for fixing the bug:

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
ordered_extent behavior:

- btrfs_direct_write keeps track of an ordered_extent for the duration
  of a call, possible across several __iomap_dio_rws.
- zero the btrfs_dio_data before using it, since its fields constitute
  state now.
- btrfs_dio_write uses dio_data to pass this ordered extent into and out
  of __iomap_dio_rw.
- when the write is done, put the ordered_extent.
- if the short write happens to be length 0, then we _don't_ get an
  extra bio, so we do need to cancel the ordered_extent like we used
  to (and ditch the cached ordered extent)
- if the short write ordered_extent has an error on it, drop the cached
  ordered extent, as before.
- in btrfs_dio_iomap_begin, if the cached ordered extent is present,
  skip all the work of creating it, just look up the extent mapping and
  jump to setting up the iomap. (This part could likely be more
  elegant..)

Thanks to Josef, Christoph, and Filipe with their help figuring out the
bug and the fix.

Fixes: 51bd9563b678 ("btrfs: fix deadlock due to page faults during direct IO reads and writes")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2169947
Link: https://lore.kernel.org/linux-btrfs/aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com/
Link: https://pastebin.com/3SDaH8C6
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
---
Changelog:
v3:
- handle BTRFS_IOERR set on the ordered_extent in btrfs_dio_iomap_end.
  If the bio fails before we loop in the submission loop and exit from
  the loop early, we never submit a second bio covering the rest of the
  extent range, resulting in leaking the ordered_extent, which hangs umount.
  We can distinguish this from a short write in btrfs_dio_iomap_end by
  checking the ordered_extent.
v2:
- rename new ordered extent function
- pull the new function into a prep patch
- reorganize how the ordered_extent is stored/passed around to avoid so
many annoying memsets and exposing it to fs/btrfs/file.c
- lots of small code style improvements
- remove unintentional whitespace changes
- commit message improvements
- various ASSERTs for clarity/debugging

 fs/btrfs/btrfs_inode.h |  1 +
 fs/btrfs/file.c        | 11 +++++-
 fs/btrfs/inode.c       | 76 +++++++++++++++++++++++++++++++-----------
 3 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 49a92aa65de1..87020aa58121 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -516,6 +516,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
 		       size_t done_before);
 struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
+				  struct btrfs_ordered_extent **ordered_extent,
 				  size_t done_before);
 
 extern const struct dentry_operations btrfs_dentry_operations;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5cc5a1faaef5..ec5c5355906b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1465,6 +1465,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err;
 	unsigned int ilock_flags = 0;
 	struct iomap_dio *dio;
+	struct btrfs_ordered_extent *ordered_extent = NULL;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1526,7 +1527,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * got -EFAULT, faulting in the pages before the retry.
 	 */
 	from->nofault = true;
-	dio = btrfs_dio_write(iocb, from, written);
+	dio = btrfs_dio_write(iocb, from, &ordered_extent, written);
 	from->nofault = false;
 
 	/*
@@ -1569,6 +1570,14 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 			goto relock;
 		}
 	}
+	/*
+	 * We can't loop back to btrfs_dio_write, so we can drop the cached
+	 * ordered extent. Typically btrfs_dio_iomap_end will run and put the
+	 * ordered_extent, but this is needed to clean up in case of an error
+	 * path breaking out of iomap_iter before the final iomap_end call.
+	 */
+	if (ordered_extent)
+		btrfs_put_ordered_extent(ordered_extent);
 
 	/*
 	 * If 'err' is -ENOTBLK or we have not written all data, then it means
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f07d59e8193..94f31697a278 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -81,6 +81,7 @@ struct btrfs_dio_data {
 	struct extent_changeset *data_reserved;
 	bool data_space_reserved;
 	bool nocow_done;
+	struct btrfs_ordered_extent *ordered;
 };
 
 struct btrfs_dio_private {
@@ -6963,6 +6964,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 }
 
 static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
+						  struct btrfs_dio_data *dio_data,
 						  const u64 start,
 						  const u64 len,
 						  const u64 orig_start,
@@ -6973,7 +6975,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  const int type)
 {
 	struct extent_map *em = NULL;
-	int ret;
+	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
 		em = create_io_em(inode, start, len, orig_start, block_start,
@@ -6983,18 +6985,21 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 		if (IS_ERR(em))
 			goto out;
 	}
-	ret = btrfs_add_ordered_extent(inode, start, len, len, block_start,
-				       block_len, 0,
-				       (1 << type) |
-				       (1 << BTRFS_ORDERED_DIRECT),
-				       BTRFS_COMPRESS_NONE);
-	if (ret) {
+	ordered = btrfs_alloc_ordered_extent(inode, start, len, len,
+					     block_start, block_len, 0,
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
+		ASSERT(!dio_data->ordered);
+		dio_data->ordered = ordered;
 	}
  out:
 
@@ -7002,6 +7007,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 }
 
 static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
+						  struct btrfs_dio_data *dio_data,
 						  u64 start, u64 len)
 {
 	struct btrfs_root *root = inode->root;
@@ -7017,7 +7023,8 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	if (ret)
 		return ERR_PTR(ret);
 
-	em = btrfs_create_dio_extent(inode, start, ins.offset, start,
+	em = btrfs_create_dio_extent(inode, dio_data,
+				     start, ins.offset, start,
 				     ins.objectid, ins.offset, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -7362,7 +7369,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		}
 		space_reserved = true;
 
-		em2 = btrfs_create_dio_extent(BTRFS_I(inode), start, len,
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
 					      orig_start, block_start,
 					      len, orig_block_len,
 					      ram_bytes, type);
@@ -7404,7 +7411,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			goto out;
 		space_reserved = true;
 
-		em = btrfs_new_extent_direct(BTRFS_I(inode), start, len);
+		em = btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
@@ -7508,6 +7515,17 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		}
 	}
 
+	if (dio_data->ordered) {
+		ASSERT(write);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0,
+				      dio_data->ordered->file_offset,
+				      dio_data->ordered->bytes_left);
+		if (IS_ERR(em)) {
+			ret = PTR_ERR(em);
+			goto err;
+		}
+		goto map_iomap;
+	}
 	memset(dio_data, 0, sizeof(*dio_data));
 
 	/*
@@ -7649,6 +7667,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	else
 		free_extent_state(cached_state);
 
+map_iomap:
 	/*
 	 * Translate extent map information to iomap.
 	 * We trim the extents (and move the addr) even though iomap code does
@@ -7702,13 +7721,27 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	if (submitted < length) {
 		pos += submitted;
 		length -= submitted;
-		if (write)
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
-						       pos, length, false);
-		else
+		if (write) {
+			struct btrfs_ordered_extent *ordered = dio_data->ordered;
+			if (submitted == 0 || 
+			    test_bit(BTRFS_ORDERED_IOERR, &ordered->flags)) {
+				btrfs_mark_ordered_io_finished(BTRFS_I(inode),
+							       NULL, pos,
+							       length, false);
+				btrfs_put_ordered_extent(ordered);
+				dio_data->ordered = NULL;
+			}
+		} else {
 			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
 				      pos + length - 1, NULL);
+		}
 		ret = -ENOTBLK;
+	} else {
+		/* On the last bio, release our cached ordered_extent. */
+		if (write) {
+			btrfs_put_ordered_extent(dio_data->ordered);
+			dio_data->ordered = NULL;
+		}
 	}
 
 	if (write)
@@ -7771,19 +7804,24 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
 
 ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
 {
-	struct btrfs_dio_data data;
+	struct btrfs_dio_data data = { 0 };
 
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
 			    IOMAP_DIO_PARTIAL, &data, done_before);
 }
 
 struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
+				  struct btrfs_ordered_extent **ordered_extent,
 				  size_t done_before)
 {
-	struct btrfs_dio_data data;
+	struct btrfs_dio_data dio_data = { .ordered = *ordered_extent };
+	struct iomap_dio *dio;
 
-	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, &data, done_before);
+	dio =  __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
+			      IOMAP_DIO_PARTIAL, &dio_data, done_before);
+	if (!IS_ERR_OR_NULL(dio))
+		*ordered_extent = dio_data.ordered;
+	return dio;
 }
 
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-- 
2.38.1

