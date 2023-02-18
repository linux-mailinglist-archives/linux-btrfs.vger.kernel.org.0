Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5574269B847
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 07:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBRGL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Feb 2023 01:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRGLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Feb 2023 01:11:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58A21114E
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 22:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lAC2iHpn7o3DQ4URnLm5ZAZyWnMhUOMTm5Z72JfUiHo=; b=yPYoynyWdY4EM9SyfjPxd9yh3K
        teEuHeK63YysbUU+It9sNTE1N+W6NFZ4uUo6wUGtizYrApobmk1M2dxaZV6TPkwo01P8gVX0AoMHY
        vvvg6SCoA7NqvTwSf8u76yKfzj7v3nMJfVaOBGU5SqCaFoh935ecd09+kzT7idlAmWSLbM4PbUpt7
        6s0Xe/unkpf11SazLyq8FR5uMMsrSGhKsO8TUD4R6JAswuNK3m7GggP7lOWvYOUKXlIWQFyswaRhm
        Eqf0l5RN/0nNMdxXT8FZkfN2JhwTvwso7pFTbup7hKbANJKXBgSfUbgpAA8HS/dYYsxQcKPTqGMkc
        8ik18dgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTGRN-00GTkl-QB; Sat, 18 Feb 2023 06:11:21 +0000
Date:   Fri, 17 Feb 2023 22:11:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix dio continue after short write due to source
 fault
Message-ID: <Y/BsCVfm05OxR+dk@infradead.org>
References: <ae81e48b0e954bae1c3451c0da1a24ae7146606c.1676684984.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae81e48b0e954bae1c3451c0da1a24ae7146606c.1676684984.git.boris@bur.io>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 17, 2023 at 05:50:17PM -0800, Boris Burkov wrote:
> Downstream bug report:
> https://bugzilla.redhat.com/show_bug.cgi?id=2169947

Any chance we could wire this or a simplified version up in xfstests?
This seems important enough to have a regression test.

The fix looks technically good (but others might know the ordered
extent semantics better than me).  I have a whole bunch of superficial
comments, though.

> +struct btrfs_dio_data;
>  struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
> -				  size_t done_before);
> +				  struct btrfs_dio_data *data, size_t done_before);

I'd much prefer not exposing btrfs_dio_data outside of inode.c, and
I think we can just do this with an in/out ordered_extent pointer.
See my incremental patch at the end.

> @@ -7543,6 +7551,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>  			goto err;
>  	}
>  
> +

unrelated whitespace changes.

>  	/*
>  	 * If this errors out it's because we couldn't invalidate pagecache for
>  	 * this range and we need to fallback to buffered IO, or we are doing a
> @@ -7662,6 +7671,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>  	else
>  		free_extent_state(cached_state);
>  
> +out:
>  	/*
>  	 * Translate extent map information to iomap.
>  	 * We trim the extents (and move the addr) even though iomap code does

Naming this label out seems a bit confusing.  What about something
like map_iomap?

> @@ -7785,18 +7807,17 @@ static const struct iomap_dio_ops btrfs_dio_ops = {
>  ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
>  {
>  	struct btrfs_dio_data data;
> +	memset(&data, 0, sizeof(data));

This looks unrelated.  I'd also do a simple compile initialization if
we'd want to do it:

	struct btrfs_dio_data data = { };

> +struct btrfs_ordered_extent *__btrfs_add_ordered_extent(
> +			struct btrfs_inode *inode, u64 file_offset,
> +			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> +			u64 disk_num_bytes, u64 offset, unsigned long flags,
> +			int compress_type)

I have a similar change in a development tree and a lot more caller, and
I ended up naming this helper btrfs_alloc_ordered_extent as that seems
more descriptive.  This also probably warrants being split into a prep
patch.

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index f771001574d0..b1277e615478 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -131,7 +131,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  		ret += dio->done_before;
>  
>  	kfree(dio);
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_complete);

Unrelated whitespace change.

And here is the incremental patch for the btrfs_dio_write prototype:

---
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 2092348b6f7d7c..1367bbc6c0ae46 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -531,10 +531,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
 		       size_t done_before);
-
-struct btrfs_dio_data;
 struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
-				  struct btrfs_dio_data *data, size_t done_before);
+				  struct btrfs_ordered_extent **ordered_extent,
+				  size_t done_before);
 
 extern const struct dentry_operations btrfs_dentry_operations;
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9a6938917b0dc6..7b5dd01772ad3a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1464,11 +1464,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	loff_t endbyte;
 	ssize_t err;
 	unsigned int ilock_flags = 0;
-	struct btrfs_dio_data dio_data;
 	struct iomap_dio *dio;
-	struct btrfs_ordered_extent *tmp;
-
-	memset(&dio_data, 0, sizeof(dio_data));
+	struct btrfs_ordered_extent *ordered_extent = NULL;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1530,7 +1527,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * got -EFAULT, faulting in the pages before the retry.
 	 */
 	from->nofault = true;
-	dio = btrfs_dio_write(iocb, from, &dio_data, written);
+	dio = btrfs_dio_write(iocb, from, &ordered_extent, written);
 	from->nofault = false;
 
 	/*
@@ -1568,9 +1565,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		if (left == prev_left) {
 			err = -ENOTBLK;
 		} else {
-			tmp = dio_data.ordered;
-			memset(&dio_data, 0, sizeof(dio_data));
-			dio_data.ordered = tmp;
 			fault_in_iov_iter_readable(from, left);
 			prev_left = left;
 			goto relock;
@@ -1582,10 +1576,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * ordered_extent, but this is needed to clean up in case of an error
 	 * path breaking out of iomap_iter before the final iomap_end call.
 	 */
-	if (dio_data.ordered) {
-		btrfs_put_ordered_extent(dio_data.ordered);
-		dio_data.ordered = NULL;
-	}
+	if (ordered_extent)
+		btrfs_put_ordered_extent(ordered_extent);
 
 	/*
 	 * If 'err' is -ENOTBLK or we have not written all data, then it means
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index 3d4427881eb654..82b34fbb295f27 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -5,14 +5,6 @@
 
 extern const struct file_operations btrfs_file_operations;
 
-struct btrfs_dio_data {
-	ssize_t submitted;
-	struct extent_changeset *data_reserved;
-	bool data_space_reserved;
-	bool nocow_done;
-	struct btrfs_ordered_extent *ordered;
-};
-
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root, struct btrfs_inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 93499f15b8f3e2..8c73d2a8346f05 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -76,6 +76,14 @@ struct btrfs_iget_args {
 	struct btrfs_root *root;
 };
 
+struct btrfs_dio_data {
+	ssize_t submitted;
+	struct extent_changeset *data_reserved;
+	bool data_space_reserved;
+	bool nocow_done;
+	struct btrfs_ordered_extent *ordered;
+};
+
 struct btrfs_dio_private {
 	struct btrfs_inode *inode;
 
@@ -8193,10 +8201,17 @@ ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_be
 }
 
 struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
-				  struct btrfs_dio_data *data, size_t done_before)
+				  struct btrfs_ordered_extent **ordered_extent,
+				  size_t done_before)
 {
-	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, data, done_before);
+	struct btrfs_dio_data dio_data = { .ordered = *ordered_extent };
+	struct iomap_dio *dio;
+
+	dio = __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
+			     IOMAP_DIO_PARTIAL, &dio_data, done_before);
+	if (!IS_ERR_OR_NULL(dio))
+		*ordered_extent = dio_data.ordered;
+	return dio;
 }
 
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
