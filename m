Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC338F633
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 23:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbfHOVEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 17:04:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38561 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733107AbfHOVEZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 17:04:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id e11so1830198pga.5
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQMBwcjDQ8X2m0tfFenFQWXn8bt8wkTENACslMpuR40=;
        b=pTuCnkFZcdmGy+0lKxBGHKLL8v96U7lxQiCuM9Y2XN5rScCjCGSz8CBNGLgy/cNcG7
         pnEo99v+z9q4fGkzXXAqGcmxXGAhvE76Zy3169/MGnHvMCnWHc5gYshQkVy3UAxbU4pm
         4PvXYImwmGyaMSEjA1EXE1YO+mw/b9hiB4Zb1QlG6Op4Cw7Z2LtHNMrcQEbH1k5z0UbS
         UuAwKMEm06pn/lLPPrmt9CLpt1tPkRWxtMNXcvdO2JW/LmCnaVLQBuqs8ZGc5400m+sJ
         Ib7meAqgVXMzyZ81rWiXC3z0ICclGJiJFqR5XGCyhjlTfeu1l6zAZUULxMTzDCxgIUI8
         /w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQMBwcjDQ8X2m0tfFenFQWXn8bt8wkTENACslMpuR40=;
        b=E7hd4V5c3RrKDK45VA0zFHqVSSMkMyeH8WWaOvQ1idh8bNq/mysSwkqwUmwQACUI7U
         is/w5dqMrgOluw9MX+vqeFnr0+OdsevT2eTu4h/QyP35g5b3LyY4T17xVc0dNeiie+HH
         UgMLKyT8fKg6nKeOlFhxzU6fqLzWk55Ydkb6fH2pcRFyxcc4mV0h4+8TDS+keqd/0jY6
         LdQQC0isE9HJL9y5U+IwvW8N/taGvh0a6Z6604R2Trs08AAWyDjmg5+rqcY6wGgxj0P7
         kl+KFF2Tkh2NLEXM8MgiqUc24k58xilsDRxOaYFMkQ88JYRb/i3ltS8MA5+LZewC2g/4
         Mlog==
X-Gm-Message-State: APjAAAW11zn+CVWtZX4JTbbAufglNwZqCO3hU8hcDe83+pQJjebfAk/x
        ivozjCen/EUQaeylh1EJaoQxJygL0g8=
X-Google-Smtp-Source: APXvYqwrriVC6Ksmdu70S+3BxPRKGbt9gUpKd50WHlSqeX9sBLXceY2Rr+bIz1GBjS/0ElXvC1dgSQ==
X-Received: by 2002:a63:fe15:: with SMTP id p21mr4978752pgh.149.1565903063783;
        Thu, 15 Aug 2019 14:04:23 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:2aa9])
        by smtp.gmail.com with ESMTPSA id i124sm4073230pfe.61.2019.08.15.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:04:22 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [RFC PATCH 5/5] Btrfs: add ioctl for directly writing compressed data
Date:   Thu, 15 Aug 2019 14:04:06 -0700
Message-Id: <78747c3028ce91db9856e7fbd98ccbb2609acdc6.1565900769.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <cover.1565900769.git.osandov@fb.com>
References: <cover.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This adds an API for writing compressed data directly to the filesystem.
The use case that I have in mind is send/receive: currently, when
sending data from one compressed filesystem to another, the sending side
decompresses the data and the receiving side recompresses it before
writing it out. This is wasteful and can be avoided if we can just send
and write compressed extents. The send part will be implemented in a
separate series, as this ioctl can stand alone.

The interface is essentially pwrite(2) with some extra information:

- The input buffer contains the compressed data.
- Both the compressed and decompressed sizes of the data are given.
- The compression type (zlib, lzo, or zstd) is given.

A more detailed description of the interface, including restrictions and
edge cases, is included in include/uapi/linux/btrfs.h.

The implementation is similar to direct I/O: we have to flush any
ordered extents, invalidate the page cache, and do the io
tree/delalloc/extent map/ordered extent dance. From there, we can reuse
the compression code with a minor modification to distinguish the new
ioctl from writeback.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/compression.c     |   6 +-
 fs/btrfs/compression.h     |  14 +--
 fs/btrfs/ctree.h           |  12 +++
 fs/btrfs/file.c            |  13 ++-
 fs/btrfs/inode.c           | 191 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ioctl.c           |  96 +++++++++++++++++++
 include/uapi/linux/btrfs.h |  63 ++++++++++++
 7 files changed, 380 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 60c47b417a4b..50e3a9a7e829 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -275,7 +275,8 @@ static void end_compressed_bio_write(struct bio *bio)
 			bio->bi_status == BLK_STS_OK);
 	cb->compressed_pages[0]->mapping = NULL;
 
-	end_compressed_writeback(inode, cb);
+	if (cb->writeback)
+		end_compressed_writeback(inode, cb);
 	/* note, our inode could be gone now */
 
 	/*
@@ -310,7 +311,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				 unsigned long compressed_len,
 				 struct page **compressed_pages,
 				 unsigned long nr_pages,
-				 unsigned int write_flags)
+				 unsigned int write_flags, bool writeback)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct bio *bio = NULL;
@@ -335,6 +336,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 	cb->mirror_num = 0;
 	cb->compressed_pages = compressed_pages;
 	cb->compressed_len = compressed_len;
+	cb->writeback = writeback;
 	cb->orig_bio = NULL;
 	cb->nr_pages = nr_pages;
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 2035b8eb1290..f39b69e8fbd7 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -6,6 +6,7 @@
 #ifndef BTRFS_COMPRESSION_H
 #define BTRFS_COMPRESSION_H
 
+#include <linux/btrfs.h>
 #include <linux/sizes.h>
 
 /*
@@ -47,6 +48,9 @@ struct compressed_bio {
 	/* the compression algorithm for this bio */
 	int compress_type;
 
+	/* Whether this is a write for writeback. */
+	bool writeback;
+
 	/* number of compressed pages in the array */
 	unsigned long nr_pages;
 
@@ -93,20 +97,12 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				  unsigned long compressed_len,
 				  struct page **compressed_pages,
 				  unsigned long nr_pages,
-				  unsigned int write_flags);
+				  unsigned int write_flags, bool writeback);
 blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
-enum btrfs_compression_type {
-	BTRFS_COMPRESS_NONE  = 0,
-	BTRFS_COMPRESS_ZLIB  = 1,
-	BTRFS_COMPRESS_LZO   = 2,
-	BTRFS_COMPRESS_ZSTD  = 3,
-	BTRFS_COMPRESS_TYPES = 3,
-};
-
 struct workspace_manager {
 	const struct btrfs_compress_op *ops;
 	struct list_head idle_ws;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 85b808e3ea42..e2854345a3a6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2985,6 +2985,16 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
+
+struct btrfs_compressed_write {
+	void __user *buf;
+	unsigned long compressed_len;
+	unsigned long orig_len;
+	int compress_type;
+};
+ssize_t btrfs_compressed_write(struct kiocb *iocb, struct iov_iter *from,
+			       struct btrfs_compressed_write *compressed);
+
 extern const struct dentry_operations btrfs_dentry_operations;
 
 /* ioctl.c */
@@ -3008,6 +3018,8 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 			   struct btrfs_inode *inode);
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
+ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
+			    struct btrfs_compressed_write *compressed);
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
 void btrfs_drop_extent_cache(struct btrfs_inode *inode, u64 start, u64 end,
 			     int skip_pinned);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c080fbcbda11..1fcaa338baf5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1872,8 +1872,8 @@ static void update_time_for_write(struct inode *inode)
 		inode_inc_iversion(inode);
 }
 
-static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
-				    struct iov_iter *from)
+ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
+			    struct btrfs_compressed_write *compressed)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
@@ -1965,7 +1965,9 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	if (sync)
 		atomic_inc(&BTRFS_I(inode)->sync_writers);
 
-	if (iocb->ki_flags & IOCB_DIRECT) {
+	if (compressed) {
+		num_written = btrfs_compressed_write(iocb, from, compressed);
+	} else if (iocb->ki_flags & IOCB_DIRECT) {
 		num_written = __btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
@@ -1996,6 +1998,11 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	return num_written ? num_written : err;
 }
 
+static ssize_t btrfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return btrfs_do_write_iter(iocb, from, NULL);
+}
+
 int btrfs_release_file(struct inode *inode, struct file *filp)
 {
 	struct btrfs_file_private *private = filp->private_data;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 491755921c4b..4ed8ba97b7d4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -863,7 +863,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				    ins.objectid,
 				    ins.offset, async_extent->pages,
 				    async_extent->nr_pages,
-				    async_chunk->write_flags)) {
+				    async_chunk->write_flags, true)) {
 			struct page *p = async_extent->pages[0];
 			const u64 start = async_extent->start;
 			const u64 end = start + async_extent->ram_size - 1;
@@ -10541,6 +10541,195 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
 	}
 }
 
+ssize_t btrfs_compressed_write(struct kiocb *iocb, struct iov_iter *from,
+			       struct btrfs_compressed_write *compressed)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct extent_changeset *data_reserved = NULL;
+	struct extent_state *cached_state = NULL;
+	unsigned long nr_pages, i;
+	struct page **pages;
+	unsigned long disk_num_bytes, ram_bytes;
+	u64 start, end;
+	struct btrfs_key ins;
+	struct extent_map *em;
+	ssize_t ret;
+
+	if (iov_iter_count(from) != compressed->orig_len) {
+		/*
+		 * The write got truncated by generic_write_checks(). We can't
+		 * do a partial compressed write.
+		 */
+		return -EFBIG;
+	}
+
+	/* This should be handled higher up. */
+	ASSERT(compressed->orig_len != 0);
+
+	/* The extent size must be sane. */
+	if (compressed->compressed_len > BTRFS_MAX_COMPRESSED ||
+	    compressed->orig_len > BTRFS_MAX_UNCOMPRESSED ||
+	    compressed->compressed_len == 0)
+		return -EINVAL;
+
+	/*
+	 * The compressed data on disk must be sector-aligned. For convenience,
+	 * we extend the compressed data with zeroes if it isn't.
+	 */
+	disk_num_bytes = ALIGN(compressed->compressed_len, fs_info->sectorsize);
+	/*
+	 * The extent in the file must also be sector-aligned. However, we allow
+	 * a write which ends at or extends i_size to have an unaligned length;
+	 * we round up the extent size and set i_size to the given length.
+	 */
+	start = iocb->ki_pos;
+	if ((start & (fs_info->sectorsize - 1)))
+		return -EINVAL;
+	if (start + compressed->orig_len >= inode->i_size) {
+		ram_bytes = ALIGN(compressed->orig_len, fs_info->sectorsize);
+	} else {
+		ram_bytes = compressed->orig_len;
+		if ((ram_bytes & (fs_info->sectorsize - 1)))
+			return -EINVAL;
+	}
+	end = start + ram_bytes - 1;
+
+	/*
+	 * It's valid for compressed data to be larger than or the same size as
+	 * the decompressed data. However, for buffered I/O, we never write out
+	 * a compressed extent unless it's smaller than the decompressed data,
+	 * so for now, let's not allow creating such extents with the ioctl,
+	 * either.
+	 */
+	if (disk_num_bytes >= ram_bytes)
+		return -EINVAL;
+
+	nr_pages = DIV_ROUND_UP(disk_num_bytes, PAGE_SIZE);
+	pages = kcalloc(nr_pages, sizeof(struct page *),
+			GFP_USER | __GFP_NOWARN);
+	if (!pages)
+		return -ENOMEM;
+	for (i = 0; i < nr_pages; i++) {
+		unsigned long offset = i << PAGE_SHIFT, n;
+		char *kaddr;
+
+		pages[i] = alloc_page(GFP_USER | __GFP_NOWARN);
+		if (!pages[i]) {
+			ret = -ENOMEM;
+			goto out_pages;
+		}
+		kaddr = kmap(pages[i]);
+		if (offset < compressed->compressed_len) {
+			n = min(PAGE_SIZE, compressed->compressed_len - offset);
+			if (copy_from_user(kaddr, compressed->buf + offset,
+					   n)) {
+				kunmap(pages[i]);
+				ret = -EFAULT;
+				goto out_pages;
+			}
+		} else {
+			n = 0;
+		}
+		if (n < PAGE_SIZE)
+			memset(kaddr + n, 0, PAGE_SIZE - n);
+		kunmap(pages[i]);
+	}
+
+	for (;;) {
+		struct btrfs_ordered_extent *ordered;
+
+		lock_extent_bits(io_tree, start, end, &cached_state);
+		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
+						     end - start + 1);
+		if (!ordered &&
+		    !filemap_range_has_page(inode->i_mapping, start, end))
+			break;
+		if (ordered)
+			btrfs_put_ordered_extent(ordered);
+		unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, end,
+				     &cached_state);
+		cond_resched();
+		ret = btrfs_wait_ordered_range(inode, start, end);
+		if (ret)
+			goto out_pages;
+		ret = invalidate_inode_pages2_range(inode->i_mapping,
+						    start >> PAGE_SHIFT,
+						    end >> PAGE_SHIFT);
+		if (ret)
+			goto out_pages;
+	}
+
+	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start,
+					   ram_bytes);
+	if (ret)
+		goto out_unlock;
+
+	ret = btrfs_reserve_extent(root, ram_bytes, disk_num_bytes,
+				   disk_num_bytes, 0, 0, &ins, 1, 1);
+	if (ret)
+		goto out_delalloc_release;
+
+	em = create_io_em(inode, start, ram_bytes, start, ins.objectid,
+			  ins.offset, ins.offset, ram_bytes,
+			  compressed->compress_type, BTRFS_ORDERED_COMPRESSED);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto out_free_reserve;
+	}
+	free_extent_map(em);
+
+	ret = btrfs_add_ordered_extent_compress(inode, start, ins.objectid,
+						ram_bytes, ins.offset,
+						BTRFS_ORDERED_COMPRESSED,
+						compressed->compress_type);
+	if (ret) {
+		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
+		goto out_free_reserve;
+	}
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+
+	if (start + compressed->orig_len > inode->i_size)
+		i_size_write(inode, start + compressed->orig_len);
+
+	unlock_extent_cached(io_tree, start, end, &cached_state);
+
+	btrfs_delalloc_release_extents(BTRFS_I(inode), ram_bytes, false);
+
+	if (btrfs_submit_compressed_write(inode, start, ram_bytes, ins.objectid,
+					  ins.offset, pages, nr_pages, 0,
+					  false)) {
+		struct page *page = pages[0];
+
+		page->mapping = inode->i_mapping;
+		btrfs_writepage_endio_finish_ordered(page, start, end, 0);
+		page->mapping = NULL;
+		ret = -EIO;
+		goto out_pages;
+	}
+	iocb->ki_pos += compressed->orig_len;
+	return compressed->orig_len;
+
+out_free_reserve:
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
+out_delalloc_release:
+	btrfs_delalloc_release_space(inode, data_reserved, start, ram_bytes,
+				     true);
+out_unlock:
+	unlock_extent_cached(io_tree, start, end, &cached_state);
+out_pages:
+	for (i = 0; i < nr_pages; i++) {
+		if (pages[i])
+			put_page(pages[i]);
+	}
+	kfree(pages);
+	return ret;
+}
+
 #ifdef CONFIG_SWAP
 /*
  * Add an entry indicating a block group or device which is pinned by a
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4b383811a7d2..7c829cd21d8e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -26,6 +26,7 @@
 #include <linux/btrfs.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
+#include <linux/sched/xacct.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -84,6 +85,18 @@ struct btrfs_ioctl_send_args_32 {
 
 #define BTRFS_IOC_SEND_32 _IOW(BTRFS_IOCTL_MAGIC, 38, \
 			       struct btrfs_ioctl_send_args_32)
+
+struct btrfs_ioctl_compressed_pwrite_args_32 {
+	__u64 offset;		/* in */
+	__u32 compressed_len;	/* in */
+	__u32 orig_len;		/* in */
+	__u32 compress_type;	/* in */
+	__u32 reserved[9];
+	compat_uptr_t buf;	/* in */
+} __attribute__ ((__packed__));
+
+#define BTRFS_IOC_COMPRESSED_PWRITE_32 _IOW(BTRFS_IOCTL_MAGIC, 63, \
+				 struct btrfs_ioctl_compressed_pwrite_args_32)
 #endif
 
 static int btrfs_clone(struct inode *src, struct inode *inode,
@@ -5424,6 +5437,83 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
 	return ret;
 }
 
+static int btrfs_ioctl_compressed_pwrite(struct file *file, void __user *argp,
+					 bool compat)
+{
+	struct btrfs_ioctl_compressed_pwrite_args args;
+	struct btrfs_compressed_write compressed;
+	struct iov_iter iter;
+	loff_t pos;
+	struct kiocb kiocb;
+	ssize_t ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (compat) {
+#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
+		struct btrfs_ioctl_compressed_pwrite_args_32 args32;
+
+		if (copy_from_user(&args32, argp, sizeof(args32)))
+			return -EFAULT;
+		args.offset = args32.offset;
+		args.buf = compat_ptr(args32.buf);
+		args.compressed_len = args32.compressed_len;
+		args.orig_len = args32.orig_len;
+		args.compress_type = args32.compress_type;
+		memcpy(args.reserved, args32.reserved, sizeof(args.reserved));
+#else
+		return -ENOTTY;
+#endif
+	} else {
+		if (copy_from_user(&args, argp, sizeof(args)))
+			return -EFAULT;
+	}
+
+	/* The compression type must be valid. */
+	if (args.compress_type == BTRFS_COMPRESS_NONE ||
+	    args.compress_type > BTRFS_COMPRESS_TYPES)
+		return -EINVAL;
+	/* Reserved fields must be zero. */
+	if (memchr_inv(args.reserved, 0, sizeof(args.reserved)))
+		return -EINVAL;
+
+	if (unlikely(!access_ok(args.buf, args.compressed_len)))
+		return -EFAULT;
+
+	pos = args.offset;
+	ret = rw_verify_area(WRITE, file, &pos, args.orig_len);
+	if (ret)
+		return ret;
+
+	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = pos;
+	/*
+	 * This iov_iter is a lie; we only construct it so that we can use
+	 * write_iter.
+	 */
+	iov_iter_init(&iter, WRITE, NULL, 0, args.orig_len);
+
+	compressed.buf = args.buf;
+	compressed.compressed_len = args.compressed_len;
+	compressed.orig_len = args.orig_len;
+	compressed.compress_type = args.compress_type;
+
+	file_start_write(file);
+	ret = btrfs_do_write_iter(&kiocb, &iter, &compressed);
+	if (ret > 0) {
+		ASSERT(ret == compressed.orig_len);
+		fsnotify_modify(file);
+		add_wchar(current, ret);
+	}
+	inc_syscw(current);
+	file_end_write(file);
+	return ret < 0 ? ret : 0;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -5570,6 +5660,12 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_subvol_rootref(file, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
+	case BTRFS_IOC_COMPRESSED_PWRITE:
+		return btrfs_ioctl_compressed_pwrite(file, argp, false);
+#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
+	case BTRFS_IOC_COMPRESSED_PWRITE_32:
+		return btrfs_ioctl_compressed_pwrite(file, argp, true);
+#endif
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 3ee0678c0a83..d0c803e3edae 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -822,6 +822,67 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 		__u8 align[7];
 };
 
+enum btrfs_compression_type {
+	BTRFS_COMPRESS_NONE  = 0,
+	BTRFS_COMPRESS_ZLIB  = 1,
+	BTRFS_COMPRESS_LZO   = 2,
+	BTRFS_COMPRESS_ZSTD  = 3,
+	BTRFS_COMPRESS_TYPES = 3,
+};
+
+/*
+ * Write compressed data directly to the filesystem. CAP_SYS_ADMIN is required
+ * and the file descriptor must be open for writing.
+ */
+struct btrfs_ioctl_compressed_pwrite_args {
+	/*
+	 * Offset in file where to write. This must be aligned to the sector
+	 * size of the filesystem.
+	 */
+	__u64 offset;		/* in */
+	/*
+	 * Length of the decompressed data in the file, in bytes. This must be
+	 * aligned to the sector size of the filesystem unless the data ends at
+	 * or beyond the current end of file; this special case is to support
+	 * creating compressed files whose length is not aligned to the sector
+	 * size.
+	 *
+	 * If this length does not match the actual length of the decompressed
+	 * data, then reading may return an error.
+	 *
+	 * This must be less than 128k (BTRFS_MAX_UNCOMPRESSED), although that
+	 * limit may increase in the future.
+	 */
+	__u32 orig_len;		/* in */
+	/*
+	 * Length of compressed data (see buf below) in bytes. This does not
+	 * need to be aligned to a sector.
+	 *
+	 * This must be less than 128k (BTRFS_MAX_COMPRESSED), although that
+	 * limit may increase in the future.
+	 */
+	__u32 compressed_len;	/* in */
+	/*
+	 * The compression type (enum btrfs_compression_type). This must not be
+	 * BTRFS_COMPRESS_NONE.
+	 */
+	__u32 compress_type;	/* in */
+	/* Reserved for future extensions. Must be zero. */
+	__u32 reserved[9];
+	/*
+	 * The compressed data. The format is as follows:
+	 *
+	 * - zlib: The extent is a single zlib stream.
+	 * - lzo: The extent is compressed page by page with LZO1X and wrapped
+	 *   according to the format documented in fs/btrfs/lzo.c.
+	 * - zstd: The extent is a single zstd stream. The windowLog compression
+	 *   parameter must be no more than 17 (ZSTD_BTRFS_MAX_WINDOWLOG).
+	 *
+	 * If the compressed data is invalid, reading will return an error.
+	 */
+	void __user *buf;	/* in */
+} __attribute__ ((__packed__));
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
@@ -946,5 +1007,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_COMPRESSED_PWRITE _IOW(BTRFS_IOCTL_MAGIC, 63, \
+				 struct btrfs_ioctl_compressed_pwrite_args)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.17.1

