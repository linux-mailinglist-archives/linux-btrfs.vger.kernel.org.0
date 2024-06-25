Return-Path: <linux-btrfs+bounces-5960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34DE916CD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E96289125
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3387016F91B;
	Tue, 25 Jun 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCvWMW2i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86616F0EA
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328615; cv=none; b=kLF0CvUfliV9WvGqwNtdIuGM7kKlMJjTaJIWfOu2IQp30B1PjbrHA8bAch4U8w463BKZd8FTnTb/zJLZSd7HvrQAWqnsK3zNcsceKtrc1dXhmzqk+hOL34zBURrOZuNY4kfcrNlpd1RFKeskcd5X1qM9oYETj+oPbw+kZZzpKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328615; c=relaxed/simple;
	bh=7yhftcAMTPr4/v21uNaVMEHn97qKwloj8qjQ2ECUw2o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=AzpWT4EI8JieofQw2cMGjmVAXxLTZcnXWTrx4OY7VPuS77MHM24Tb18+3eXe0Lx31x4ICyAcyQSyZ0yThFsv9pJ6RC9qiZMHwQTupPRLhqqTiuLLYlYCYhqyyq8Hfns2fzpJgRzOvlGLGMD6/a5CmVIRltSgA0WoNv3cml3LaOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCvWMW2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65F8C32781
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719328614;
	bh=7yhftcAMTPr4/v21uNaVMEHn97qKwloj8qjQ2ECUw2o=;
	h=From:To:Subject:Date:From;
	b=MCvWMW2ibSDfQE87WO6C81oeXbKxttHBBaJdMklJWwcjB7w8fOt+QnBwvr8AqCnQm
	 Kjw+luR8Lz466U4K+cI9/ZX/IWH9PxZwn3ePszgNvegnMcLqQJmHqpoMZpAz4PJW3D
	 gsD2dkeZeUVgJGS/d8ZkYjRE0cyInngX2BW1Q1DBUXsoQ1GBM+wGFSNBmjg49dt4cC
	 VEOCuWq2izyaJdf0sxYv2LLnxMdfUMHmxRbdRK2Er743CdcUAGMxxbmmYlL/9Srjps
	 qHvCH4PVeoqAZ6Cuo7vRIsaC+1BT5f51VTVYaNk4rqUCXTLLI7o19gaK3B+fsPD/eg
	 ma5eCu50gJ1Xg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: move the direct IO code into its own file
Date: Tue, 25 Jun 2024 16:16:50 +0100
Message-Id: <107dc9437ffcbf6751d018209d037c851a890f4d.1719328515.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The direct IO code is over a thousand lines and it's currently spread
between file.c and inode.c, which makes it not easy to locate some parts
of it sometimes. Also inode.c is about 11 thousand lines and file.c about
4 thousand lines, both too big. So move all the direct IO code into a
dedicated file, so that it's easy to locate all its code and reduce the
sizes of inode.c and file.c.

This is a pure move of code without any other changes except export a
a couple functions from inode.c (get_extent_allocation_hint() and
create_io_em()) because they are used in inode.c and the new direct-io.c
file, and a couple functions from file.c (btrfs_buffered_write() and
btrfs_write_check()) because they are used both in file.c and in the new
direct-io.c file.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/Makefile      |    2 +-
 fs/btrfs/btrfs_inode.h |    9 +-
 fs/btrfs/direct-io.c   | 1052 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/direct-io.h   |   14 +
 fs/btrfs/file.c        |  287 +----------
 fs/btrfs/file.h        |    2 +
 fs/btrfs/inode.c       |  784 +-----------------------------
 fs/btrfs/super.c       |    4 +
 8 files changed, 1095 insertions(+), 1059 deletions(-)
 create mode 100644 fs/btrfs/direct-io.c
 create mode 100644 fs/btrfs/direct-io.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 50b19d15e956..87617f2968bc 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -33,7 +33,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
 	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
-	   lru_cache.o raid-stripe-tree.o fiemap.o
+	   lru_cache.o raid-stripe-tree.o fiemap.o direct-io.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b0fe610d5940..b33f147f2780 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -610,10 +610,6 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 			       const struct btrfs_ioctl_encoded_io_args *encoded);
 
-ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
-		       size_t done_before);
-struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
-				  size_t done_before);
 struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64 min_ino);
 
 extern const struct dentry_operations btrfs_dentry_operations;
@@ -630,5 +626,10 @@ void btrfs_inode_unlock(struct btrfs_inode *inode, unsigned int ilock_flags);
 void btrfs_update_inode_bytes(struct btrfs_inode *inode, const u64 add_bytes,
 			      const u64 del_bytes);
 void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 start, u64 end);
+u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
+				     u64 num_bytes);
+struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
+				      const struct btrfs_file_extent *file_extent,
+				      int type);
 
 #endif
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
new file mode 100644
index 000000000000..f9fb2db6a1e4
--- /dev/null
+++ b/fs/btrfs/direct-io.c
@@ -0,0 +1,1052 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/fsverity.h>
+#include <linux/iomap.h>
+#include "ctree.h"
+#include "delalloc-space.h"
+#include "direct-io.h"
+#include "extent-tree.h"
+#include "file.h"
+#include "fs.h"
+#include "transaction.h"
+#include "volumes.h"
+
+struct btrfs_dio_data {
+	ssize_t submitted;
+	struct extent_changeset *data_reserved;
+	struct btrfs_ordered_extent *ordered;
+	bool data_space_reserved;
+	bool nocow_done;
+};
+
+struct btrfs_dio_private {
+	/* Range of I/O */
+	u64 file_offset;
+	u32 bytes;
+
+	/* This must be last */
+	struct btrfs_bio bbio;
+};
+
+static struct bio_set btrfs_dio_bioset;
+
+static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
+			      struct extent_state **cached_state,
+			      unsigned int iomap_flags)
+{
+	const bool writing = (iomap_flags & IOMAP_WRITE);
+	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_ordered_extent *ordered;
+	int ret = 0;
+
+	while (1) {
+		if (nowait) {
+			if (!try_lock_extent(io_tree, lockstart, lockend,
+					     cached_state))
+				return -EAGAIN;
+		} else {
+			lock_extent(io_tree, lockstart, lockend, cached_state);
+		}
+		/*
+		 * We're concerned with the entire range that we're going to be
+		 * doing DIO to, so we need to make sure there's no ordered
+		 * extents in this range.
+		 */
+		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), lockstart,
+						     lockend - lockstart + 1);
+
+		/*
+		 * We need to make sure there are no buffered pages in this
+		 * range either, we could have raced between the invalidate in
+		 * generic_file_direct_write and locking the extent.  The
+		 * invalidate needs to happen so that reads after a write do not
+		 * get stale data.
+		 */
+		if (!ordered &&
+		    (!writing || !filemap_range_has_page(inode->i_mapping,
+							 lockstart, lockend)))
+			break;
+
+		unlock_extent(io_tree, lockstart, lockend, cached_state);
+
+		if (ordered) {
+			if (nowait) {
+				btrfs_put_ordered_extent(ordered);
+				ret = -EAGAIN;
+				break;
+			}
+			/*
+			 * If we are doing a DIO read and the ordered extent we
+			 * found is for a buffered write, we can not wait for it
+			 * to complete and retry, because if we do so we can
+			 * deadlock with concurrent buffered writes on page
+			 * locks. This happens only if our DIO read covers more
+			 * than one extent map, if at this point has already
+			 * created an ordered extent for a previous extent map
+			 * and locked its range in the inode's io tree, and a
+			 * concurrent write against that previous extent map's
+			 * range and this range started (we unlock the ranges
+			 * in the io tree only when the bios complete and
+			 * buffered writes always lock pages before attempting
+			 * to lock range in the io tree).
+			 */
+			if (writing ||
+			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
+				btrfs_start_ordered_extent(ordered);
+			else
+				ret = nowait ? -EAGAIN : -ENOTBLK;
+			btrfs_put_ordered_extent(ordered);
+		} else {
+			/*
+			 * We could trigger writeback for this range (and wait
+			 * for it to complete) and then invalidate the pages for
+			 * this range (through invalidate_inode_pages2_range()),
+			 * but that can lead us to a deadlock with a concurrent
+			 * call to readahead (a buffered read or a defrag call
+			 * triggered a readahead) on a page lock due to an
+			 * ordered dio extent we created before but did not have
+			 * yet a corresponding bio submitted (whence it can not
+			 * complete), which makes readahead wait for that
+			 * ordered extent to complete while holding a lock on
+			 * that page.
+			 */
+			ret = nowait ? -EAGAIN : -ENOTBLK;
+		}
+
+		if (ret)
+			break;
+
+		cond_resched();
+	}
+
+	return ret;
+}
+
+static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
+						  struct btrfs_dio_data *dio_data,
+						  const u64 start,
+						  const struct btrfs_file_extent *file_extent,
+						  const int type)
+{
+	struct extent_map *em = NULL;
+	struct btrfs_ordered_extent *ordered;
+
+	if (type != BTRFS_ORDERED_NOCOW) {
+		em = btrfs_create_io_em(inode, start, file_extent, type);
+		if (IS_ERR(em))
+			goto out;
+	}
+
+	ordered = btrfs_alloc_ordered_extent(inode, start, file_extent,
+					     (1 << type) |
+					     (1 << BTRFS_ORDERED_DIRECT));
+	if (IS_ERR(ordered)) {
+		if (em) {
+			free_extent_map(em);
+			btrfs_drop_extent_map_range(inode, start,
+					start + file_extent->num_bytes - 1, false);
+		}
+		em = ERR_CAST(ordered);
+	} else {
+		ASSERT(!dio_data->ordered);
+		dio_data->ordered = ordered;
+	}
+ out:
+
+	return em;
+}
+
+static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
+						  struct btrfs_dio_data *dio_data,
+						  u64 start, u64 len)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_file_extent file_extent;
+	struct extent_map *em;
+	struct btrfs_key ins;
+	u64 alloc_hint;
+	int ret;
+
+	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, len);
+again:
+	ret = btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
+				   0, alloc_hint, &ins, 1, 1);
+	if (ret == -EAGAIN) {
+		ASSERT(btrfs_is_zoned(fs_info));
+		wait_on_bit_io(&inode->root->fs_info->flags, BTRFS_FS_NEED_ZONE_FINISH,
+			       TASK_UNINTERRUPTIBLE);
+		goto again;
+	}
+	if (ret)
+		return ERR_PTR(ret);
+
+	file_extent.disk_bytenr = ins.objectid;
+	file_extent.disk_num_bytes = ins.offset;
+	file_extent.num_bytes = ins.offset;
+	file_extent.ram_bytes = ins.offset;
+	file_extent.offset = 0;
+	file_extent.compression = BTRFS_COMPRESS_NONE;
+	em = btrfs_create_dio_extent(inode, dio_data, start, &file_extent,
+				     BTRFS_ORDERED_REGULAR);
+	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
+	if (IS_ERR(em))
+		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
+					   1);
+
+	return em;
+}
+
+static int btrfs_get_blocks_direct_write(struct extent_map **map,
+					 struct inode *inode,
+					 struct btrfs_dio_data *dio_data,
+					 u64 start, u64 *lenp,
+					 unsigned int iomap_flags)
+{
+	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_file_extent file_extent;
+	struct extent_map *em = *map;
+	int type;
+	u64 block_start;
+	struct btrfs_block_group *bg;
+	bool can_nocow = false;
+	bool space_reserved = false;
+	u64 len = *lenp;
+	u64 prev_len;
+	int ret = 0;
+
+	/*
+	 * We don't allocate a new extent in the following cases
+	 *
+	 * 1) The inode is marked as NODATACOW. In this case we'll just use the
+	 * existing extent.
+	 * 2) The extent is marked as PREALLOC. We're good to go here and can
+	 * just use the extent.
+	 *
+	 */
+	if ((em->flags & EXTENT_FLAG_PREALLOC) ||
+	    ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
+	     em->disk_bytenr != EXTENT_MAP_HOLE)) {
+		if (em->flags & EXTENT_FLAG_PREALLOC)
+			type = BTRFS_ORDERED_PREALLOC;
+		else
+			type = BTRFS_ORDERED_NOCOW;
+		len = min(len, em->len - (start - em->start));
+		block_start = extent_map_block_start(em) + (start - em->start);
+
+		if (can_nocow_extent(inode, start, &len,
+				     &file_extent, false, false) == 1) {
+			bg = btrfs_inc_nocow_writers(fs_info, block_start);
+			if (bg)
+				can_nocow = true;
+		}
+	}
+
+	prev_len = len;
+	if (can_nocow) {
+		struct extent_map *em2;
+
+		/* We can NOCOW, so only need to reserve metadata space. */
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
+						      nowait);
+		if (ret < 0) {
+			/* Our caller expects us to free the input extent map. */
+			free_extent_map(em);
+			*map = NULL;
+			btrfs_dec_nocow_writers(bg);
+			if (nowait && (ret == -ENOSPC || ret == -EDQUOT))
+				ret = -EAGAIN;
+			goto out;
+		}
+		space_reserved = true;
+
+		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start,
+					      &file_extent, type);
+		btrfs_dec_nocow_writers(bg);
+		if (type == BTRFS_ORDERED_PREALLOC) {
+			free_extent_map(em);
+			*map = em2;
+			em = em2;
+		}
+
+		if (IS_ERR(em2)) {
+			ret = PTR_ERR(em2);
+			goto out;
+		}
+
+		dio_data->nocow_done = true;
+	} else {
+		/* Our caller expects us to free the input extent map. */
+		free_extent_map(em);
+		*map = NULL;
+
+		if (nowait) {
+			ret = -EAGAIN;
+			goto out;
+		}
+
+		/*
+		 * If we could not allocate data space before locking the file
+		 * range and we can't do a NOCOW write, then we have to fail.
+		 */
+		if (!dio_data->data_space_reserved) {
+			ret = -ENOSPC;
+			goto out;
+		}
+
+		/*
+		 * We have to COW and we have already reserved data space before,
+		 * so now we reserve only metadata.
+		 */
+		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
+						      false);
+		if (ret < 0)
+			goto out;
+		space_reserved = true;
+
+		em = btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
+		if (IS_ERR(em)) {
+			ret = PTR_ERR(em);
+			goto out;
+		}
+		*map = em;
+		len = min(len, em->len - (start - em->start));
+		if (len < prev_len)
+			btrfs_delalloc_release_metadata(BTRFS_I(inode),
+							prev_len - len, true);
+	}
+
+	/*
+	 * We have created our ordered extent, so we can now release our reservation
+	 * for an outstanding extent.
+	 */
+	btrfs_delalloc_release_extents(BTRFS_I(inode), prev_len);
+
+	/*
+	 * Need to update the i_size under the extent lock so buffered
+	 * readers will get the updated i_size when we unlock.
+	 */
+	if (start + len > i_size_read(inode))
+		i_size_write(inode, start + len);
+out:
+	if (ret && space_reserved) {
+		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
+		btrfs_delalloc_release_metadata(BTRFS_I(inode), len, true);
+	}
+	*lenp = len;
+	return ret;
+}
+
+static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
+		loff_t length, unsigned int flags, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct extent_map *em;
+	struct extent_state *cached_state = NULL;
+	struct btrfs_dio_data *dio_data = iter->private;
+	u64 lockstart, lockend;
+	const bool write = !!(flags & IOMAP_WRITE);
+	int ret = 0;
+	u64 len = length;
+	const u64 data_alloc_len = length;
+	bool unlock_extents = false;
+
+	/*
+	 * We could potentially fault if we have a buffer > PAGE_SIZE, and if
+	 * we're NOWAIT we may submit a bio for a partial range and return
+	 * EIOCBQUEUED, which would result in an errant short read.
+	 *
+	 * The best way to handle this would be to allow for partial completions
+	 * of iocb's, so we could submit the partial bio, return and fault in
+	 * the rest of the pages, and then submit the io for the rest of the
+	 * range.  However we don't have that currently, so simply return
+	 * -EAGAIN at this point so that the normal path is used.
+	 */
+	if (!write && (flags & IOMAP_NOWAIT) && length > PAGE_SIZE)
+		return -EAGAIN;
+
+	/*
+	 * Cap the size of reads to that usually seen in buffered I/O as we need
+	 * to allocate a contiguous array for the checksums.
+	 */
+	if (!write)
+		len = min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_BIO_SECTORS);
+
+	lockstart = start;
+	lockend = start + len - 1;
+
+	/*
+	 * iomap_dio_rw() only does filemap_write_and_wait_range(), which isn't
+	 * enough if we've written compressed pages to this area, so we need to
+	 * flush the dirty pages again to make absolutely sure that any
+	 * outstanding dirty pages are on disk - the first flush only starts
+	 * compression on the data, while keeping the pages locked, so by the
+	 * time the second flush returns we know bios for the compressed pages
+	 * were submitted and finished, and the pages no longer under writeback.
+	 *
+	 * If we have a NOWAIT request and we have any pages in the range that
+	 * are locked, likely due to compression still in progress, we don't want
+	 * to block on page locks. We also don't want to block on pages marked as
+	 * dirty or under writeback (same as for the non-compression case).
+	 * iomap_dio_rw() did the same check, but after that and before we got
+	 * here, mmap'ed writes may have happened or buffered reads started
+	 * (readpage() and readahead(), which lock pages), as we haven't locked
+	 * the file range yet.
+	 */
+	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
+		     &BTRFS_I(inode)->runtime_flags)) {
+		if (flags & IOMAP_NOWAIT) {
+			if (filemap_range_needs_writeback(inode->i_mapping,
+							  lockstart, lockend))
+				return -EAGAIN;
+		} else {
+			ret = filemap_fdatawrite_range(inode->i_mapping, start,
+						       start + length - 1);
+			if (ret)
+				return ret;
+		}
+	}
+
+	memset(dio_data, 0, sizeof(*dio_data));
+
+	/*
+	 * We always try to allocate data space and must do it before locking
+	 * the file range, to avoid deadlocks with concurrent writes to the same
+	 * range if the range has several extents and the writes don't expand the
+	 * current i_size (the inode lock is taken in shared mode). If we fail to
+	 * allocate data space here we continue and later, after locking the
+	 * file range, we fail with ENOSPC only if we figure out we can not do a
+	 * NOCOW write.
+	 */
+	if (write && !(flags & IOMAP_NOWAIT)) {
+		ret = btrfs_check_data_free_space(BTRFS_I(inode),
+						  &dio_data->data_reserved,
+						  start, data_alloc_len, false);
+		if (!ret)
+			dio_data->data_space_reserved = true;
+		else if (ret && !(BTRFS_I(inode)->flags &
+				  (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
+			goto err;
+	}
+
+	/*
+	 * If this errors out it's because we couldn't invalidate pagecache for
+	 * this range and we need to fallback to buffered IO, or we are doing a
+	 * NOWAIT read/write and we need to block.
+	 */
+	ret = lock_extent_direct(inode, lockstart, lockend, &cached_state, flags);
+	if (ret < 0)
+		goto err;
+
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto unlock_err;
+	}
+
+	/*
+	 * Ok for INLINE and COMPRESSED extents we need to fallback on buffered
+	 * io.  INLINE is special, and we could probably kludge it in here, but
+	 * it's still buffered so for safety lets just fall back to the generic
+	 * buffered path.
+	 *
+	 * For COMPRESSED we _have_ to read the entire extent in so we can
+	 * decompress it, so there will be buffering required no matter what we
+	 * do, so go ahead and fallback to buffered.
+	 *
+	 * We return -ENOTBLK because that's what makes DIO go ahead and go back
+	 * to buffered IO.  Don't blame me, this is the price we pay for using
+	 * the generic code.
+	 */
+	if (extent_map_is_compressed(em) || em->disk_bytenr == EXTENT_MAP_INLINE) {
+		free_extent_map(em);
+		/*
+		 * If we are in a NOWAIT context, return -EAGAIN in order to
+		 * fallback to buffered IO. This is not only because we can
+		 * block with buffered IO (no support for NOWAIT semantics at
+		 * the moment) but also to avoid returning short reads to user
+		 * space - this happens if we were able to read some data from
+		 * previous non-compressed extents and then when we fallback to
+		 * buffered IO, at btrfs_file_read_iter() by calling
+		 * filemap_read(), we fail to fault in pages for the read buffer,
+		 * in which case filemap_read() returns a short read (the number
+		 * of bytes previously read is > 0, so it does not return -EFAULT).
+		 */
+		ret = (flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOTBLK;
+		goto unlock_err;
+	}
+
+	len = min(len, em->len - (start - em->start));
+
+	/*
+	 * If we have a NOWAIT request and the range contains multiple extents
+	 * (or a mix of extents and holes), then we return -EAGAIN to make the
+	 * caller fallback to a context where it can do a blocking (without
+	 * NOWAIT) request. This way we avoid doing partial IO and returning
+	 * success to the caller, which is not optimal for writes and for reads
+	 * it can result in unexpected behaviour for an application.
+	 *
+	 * When doing a read, because we use IOMAP_DIO_PARTIAL when calling
+	 * iomap_dio_rw(), we can end up returning less data then what the caller
+	 * asked for, resulting in an unexpected, and incorrect, short read.
+	 * That is, the caller asked to read N bytes and we return less than that,
+	 * which is wrong unless we are crossing EOF. This happens if we get a
+	 * page fault error when trying to fault in pages for the buffer that is
+	 * associated to the struct iov_iter passed to iomap_dio_rw(), and we
+	 * have previously submitted bios for other extents in the range, in
+	 * which case iomap_dio_rw() may return us EIOCBQUEUED if not all of
+	 * those bios have completed by the time we get the page fault error,
+	 * which we return back to our caller - we should only return EIOCBQUEUED
+	 * after we have submitted bios for all the extents in the range.
+	 */
+	if ((flags & IOMAP_NOWAIT) && len < length) {
+		free_extent_map(em);
+		ret = -EAGAIN;
+		goto unlock_err;
+	}
+
+	if (write) {
+		ret = btrfs_get_blocks_direct_write(&em, inode, dio_data,
+						    start, &len, flags);
+		if (ret < 0)
+			goto unlock_err;
+		unlock_extents = true;
+		/* Recalc len in case the new em is smaller than requested */
+		len = min(len, em->len - (start - em->start));
+		if (dio_data->data_space_reserved) {
+			u64 release_offset;
+			u64 release_len = 0;
+
+			if (dio_data->nocow_done) {
+				release_offset = start;
+				release_len = data_alloc_len;
+			} else if (len < data_alloc_len) {
+				release_offset = start + len;
+				release_len = data_alloc_len - len;
+			}
+
+			if (release_len > 0)
+				btrfs_free_reserved_data_space(BTRFS_I(inode),
+							       dio_data->data_reserved,
+							       release_offset,
+							       release_len);
+		}
+	} else {
+		/*
+		 * We need to unlock only the end area that we aren't using.
+		 * The rest is going to be unlocked by the endio routine.
+		 */
+		lockstart = start + len;
+		if (lockstart < lockend)
+			unlock_extents = true;
+	}
+
+	if (unlock_extents)
+		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+			      &cached_state);
+	else
+		free_extent_state(cached_state);
+
+	/*
+	 * Translate extent map information to iomap.
+	 * We trim the extents (and move the addr) even though iomap code does
+	 * that, since we have locked only the parts we are performing I/O in.
+	 */
+	if ((em->disk_bytenr == EXTENT_MAP_HOLE) ||
+	    ((em->flags & EXTENT_FLAG_PREALLOC) && !write)) {
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->type = IOMAP_HOLE;
+	} else {
+		iomap->addr = extent_map_block_start(em) + (start - em->start);
+		iomap->type = IOMAP_MAPPED;
+	}
+	iomap->offset = start;
+	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
+	iomap->length = len;
+	free_extent_map(em);
+
+	return 0;
+
+unlock_err:
+	unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
+		      &cached_state);
+err:
+	if (dio_data->data_space_reserved) {
+		btrfs_free_reserved_data_space(BTRFS_I(inode),
+					       dio_data->data_reserved,
+					       start, data_alloc_len);
+		extent_changeset_free(dio_data->data_reserved);
+	}
+
+	return ret;
+}
+
+static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+		ssize_t written, unsigned int flags, struct iomap *iomap)
+{
+	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
+	struct btrfs_dio_data *dio_data = iter->private;
+	size_t submitted = dio_data->submitted;
+	const bool write = !!(flags & IOMAP_WRITE);
+	int ret = 0;
+
+	if (!write && (iomap->type == IOMAP_HOLE)) {
+		/* If reading from a hole, unlock and return */
+		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1,
+			      NULL);
+		return 0;
+	}
+
+	if (submitted < length) {
+		pos += submitted;
+		length -= submitted;
+		if (write)
+			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
+						    pos, length, false);
+		else
+			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
+				      pos + length - 1, NULL);
+		ret = -ENOTBLK;
+	}
+	if (write) {
+		btrfs_put_ordered_extent(dio_data->ordered);
+		dio_data->ordered = NULL;
+	}
+
+	if (write)
+		extent_changeset_free(dio_data->data_reserved);
+	return ret;
+}
+
+static void btrfs_dio_end_io(struct btrfs_bio *bbio)
+{
+	struct btrfs_dio_private *dip =
+		container_of(bbio, struct btrfs_dio_private, bbio);
+	struct btrfs_inode *inode = bbio->inode;
+	struct bio *bio = &bbio->bio;
+
+	if (bio->bi_status) {
+		btrfs_warn(inode->root->fs_info,
+		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
+			   btrfs_ino(inode), bio->bi_opf,
+			   dip->file_offset, dip->bytes, bio->bi_status);
+	}
+
+	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
+		btrfs_finish_ordered_extent(bbio->ordered, NULL,
+					    dip->file_offset, dip->bytes,
+					    !bio->bi_status);
+	} else {
+		unlock_extent(&inode->io_tree, dip->file_offset,
+			      dip->file_offset + dip->bytes - 1, NULL);
+	}
+
+	bbio->bio.bi_private = bbio->private;
+	iomap_dio_bio_end_io(bio);
+}
+
+static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
+					struct btrfs_ordered_extent *ordered)
+{
+	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 len = bbio->bio.bi_iter.bi_size;
+	struct btrfs_ordered_extent *new;
+	int ret;
+
+	/* Must always be called for the beginning of an ordered extent. */
+	if (WARN_ON_ONCE(start != ordered->disk_bytenr))
+		return -EINVAL;
+
+	/* No need to split if the ordered extent covers the entire bio. */
+	if (ordered->disk_num_bytes == len) {
+		refcount_inc(&ordered->refs);
+		bbio->ordered = ordered;
+		return 0;
+	}
+
+	/*
+	 * Don't split the extent_map for NOCOW extents, as we're writing into
+	 * a pre-existing one.
+	 */
+	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags)) {
+		ret = split_extent_map(bbio->inode, bbio->file_offset,
+				       ordered->num_bytes, len,
+				       ordered->disk_bytenr);
+		if (ret)
+			return ret;
+	}
+
+	new = btrfs_split_ordered_extent(ordered, len);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+	bbio->ordered = new;
+	return 0;
+}
+
+static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
+				loff_t file_offset)
+{
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct btrfs_dio_private *dip =
+		container_of(bbio, struct btrfs_dio_private, bbio);
+	struct btrfs_dio_data *dio_data = iter->private;
+
+	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
+		       btrfs_dio_end_io, bio->bi_private);
+	bbio->inode = BTRFS_I(iter->inode);
+	bbio->file_offset = file_offset;
+
+	dip->file_offset = file_offset;
+	dip->bytes = bio->bi_iter.bi_size;
+
+	dio_data->submitted += bio->bi_iter.bi_size;
+
+	/*
+	 * Check if we are doing a partial write.  If we are, we need to split
+	 * the ordered extent to match the submitted bio.  Hang on to the
+	 * remaining unfinishable ordered_extent in dio_data so that it can be
+	 * cancelled in iomap_end to avoid a deadlock wherein faulting the
+	 * remaining pages is blocked on the outstanding ordered extent.
+	 */
+	if (iter->flags & IOMAP_WRITE) {
+		int ret;
+
+		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
+		if (ret) {
+			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
+						    file_offset, dip->bytes,
+						    !ret);
+			bio->bi_status = errno_to_blk_status(ret);
+			iomap_dio_bio_end_io(bio);
+			return;
+		}
+	}
+
+	btrfs_submit_bio(bbio, 0);
+}
+
+static const struct iomap_ops btrfs_dio_iomap_ops = {
+	.iomap_begin            = btrfs_dio_iomap_begin,
+	.iomap_end              = btrfs_dio_iomap_end,
+};
+
+static const struct iomap_dio_ops btrfs_dio_ops = {
+	.submit_io		= btrfs_dio_submit_io,
+	.bio_set		= &btrfs_dio_bioset,
+};
+
+static ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
+			      size_t done_before)
+{
+	struct btrfs_dio_data data = { 0 };
+
+	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
+			    IOMAP_DIO_PARTIAL, &data, done_before);
+}
+
+static struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
+					 size_t done_before)
+{
+	struct btrfs_dio_data data = { 0 };
+
+	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
+			    IOMAP_DIO_PARTIAL, &data, done_before);
+}
+
+static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
+			       const struct iov_iter *iter, loff_t offset)
+{
+	const u32 blocksize_mask = fs_info->sectorsize - 1;
+
+	if (offset & blocksize_mask)
+		return -EINVAL;
+
+	if (iov_iter_alignment(iter) & blocksize_mask)
+		return -EINVAL;
+
+	return 0;
+}
+
+ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	loff_t pos;
+	ssize_t written = 0;
+	ssize_t written_buffered;
+	size_t prev_left = 0;
+	loff_t endbyte;
+	ssize_t ret;
+	unsigned int ilock_flags = 0;
+	struct iomap_dio *dio;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		ilock_flags |= BTRFS_ILOCK_TRY;
+
+	/*
+	 * If the write DIO is within EOF, use a shared lock and also only if
+	 * security bits will likely not be dropped by file_remove_privs() called
+	 * from btrfs_write_check(). Either will need to be rechecked after the
+	 * lock was acquired.
+	 */
+	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode) && IS_NOSEC(inode))
+		ilock_flags |= BTRFS_ILOCK_SHARED;
+
+relock:
+	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
+	if (ret < 0)
+		return ret;
+
+	/* Shared lock cannot be used with security bits set. */
+	if ((ilock_flags & BTRFS_ILOCK_SHARED) && !IS_NOSEC(inode)) {
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+		ilock_flags &= ~BTRFS_ILOCK_SHARED;
+		goto relock;
+	}
+
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0) {
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+		return ret;
+	}
+
+	ret = btrfs_write_check(iocb, from, ret);
+	if (ret < 0) {
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+		goto out;
+	}
+
+	pos = iocb->ki_pos;
+	/*
+	 * Re-check since file size may have changed just before taking the
+	 * lock or pos may have changed because of O_APPEND in generic_write_check()
+	 */
+	if ((ilock_flags & BTRFS_ILOCK_SHARED) &&
+	    pos + iov_iter_count(from) > i_size_read(inode)) {
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+		ilock_flags &= ~BTRFS_ILOCK_SHARED;
+		goto relock;
+	}
+
+	if (check_direct_IO(fs_info, from, pos)) {
+		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+		goto buffered;
+	}
+
+	/*
+	 * The iov_iter can be mapped to the same file range we are writing to.
+	 * If that's the case, then we will deadlock in the iomap code, because
+	 * it first calls our callback btrfs_dio_iomap_begin(), which will create
+	 * an ordered extent, and after that it will fault in the pages that the
+	 * iov_iter refers to. During the fault in we end up in the readahead
+	 * pages code (starting at btrfs_readahead()), which will lock the range,
+	 * find that ordered extent and then wait for it to complete (at
+	 * btrfs_lock_and_flush_ordered_range()), resulting in a deadlock since
+	 * obviously the ordered extent can never complete as we didn't submit
+	 * yet the respective bio(s). This always happens when the buffer is
+	 * memory mapped to the same file range, since the iomap DIO code always
+	 * invalidates pages in the target file range (after starting and waiting
+	 * for any writeback).
+	 *
+	 * So here we disable page faults in the iov_iter and then retry if we
+	 * got -EFAULT, faulting in the pages before the retry.
+	 */
+	from->nofault = true;
+	dio = btrfs_dio_write(iocb, from, written);
+	from->nofault = false;
+
+	/*
+	 * iomap_dio_complete() will call btrfs_sync_file() if we have a dsync
+	 * iocb, and that needs to lock the inode. So unlock it before calling
+	 * iomap_dio_complete() to avoid a deadlock.
+	 */
+	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+
+	if (IS_ERR_OR_NULL(dio))
+		ret = PTR_ERR_OR_ZERO(dio);
+	else
+		ret = iomap_dio_complete(dio);
+
+	/* No increment (+=) because iomap returns a cumulative value. */
+	if (ret > 0)
+		written = ret;
+
+	if (iov_iter_count(from) > 0 && (ret == -EFAULT || ret > 0)) {
+		const size_t left = iov_iter_count(from);
+		/*
+		 * We have more data left to write. Try to fault in as many as
+		 * possible of the remainder pages and retry. We do this without
+		 * releasing and locking again the inode, to prevent races with
+		 * truncate.
+		 *
+		 * Also, in case the iov refers to pages in the file range of the
+		 * file we want to write to (due to a mmap), we could enter an
+		 * infinite loop if we retry after faulting the pages in, since
+		 * iomap will invalidate any pages in the range early on, before
+		 * it tries to fault in the pages of the iov. So we keep track of
+		 * how much was left of iov in the previous EFAULT and fallback
+		 * to buffered IO in case we haven't made any progress.
+		 */
+		if (left == prev_left) {
+			ret = -ENOTBLK;
+		} else {
+			fault_in_iov_iter_readable(from, left);
+			prev_left = left;
+			goto relock;
+		}
+	}
+
+	/*
+	 * If 'ret' is -ENOTBLK or we have not written all data, then it means
+	 * we must fallback to buffered IO.
+	 */
+	if ((ret < 0 && ret != -ENOTBLK) || !iov_iter_count(from))
+		goto out;
+
+buffered:
+	/*
+	 * If we are in a NOWAIT context, then return -EAGAIN to signal the caller
+	 * it must retry the operation in a context where blocking is acceptable,
+	 * because even if we end up not blocking during the buffered IO attempt
+	 * below, we will block when flushing and waiting for the IO.
+	 */
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	pos = iocb->ki_pos;
+	written_buffered = btrfs_buffered_write(iocb, from);
+	if (written_buffered < 0) {
+		ret = written_buffered;
+		goto out;
+	}
+	/*
+	 * Ensure all data is persisted. We want the next direct IO read to be
+	 * able to read what was just written.
+	 */
+	endbyte = pos + written_buffered - 1;
+	ret = btrfs_fdatawrite_range(BTRFS_I(inode), pos, endbyte);
+	if (ret)
+		goto out;
+	ret = filemap_fdatawait_range(inode->i_mapping, pos, endbyte);
+	if (ret)
+		goto out;
+	written += written_buffered;
+	iocb->ki_pos = pos + written_buffered;
+	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
+				 endbyte >> PAGE_SHIFT);
+out:
+	return ret < 0 ? ret : written;
+}
+
+static int check_direct_read(struct btrfs_fs_info *fs_info,
+			     const struct iov_iter *iter, loff_t offset)
+{
+	int ret;
+	int i, seg;
+
+	ret = check_direct_IO(fs_info, iter, offset);
+	if (ret < 0)
+		return ret;
+
+	if (!iter_is_iovec(iter))
+		return 0;
+
+	for (seg = 0; seg < iter->nr_segs; seg++) {
+		for (i = seg + 1; i < iter->nr_segs; i++) {
+			const struct iovec *iov1 = iter_iov(iter) + seg;
+			const struct iovec *iov2 = iter_iov(iter) + i;
+
+			if (iov1->iov_base == iov2->iov_base)
+				return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t prev_left = 0;
+	ssize_t read = 0;
+	ssize_t ret;
+
+	if (fsverity_active(inode))
+		return 0;
+
+	if (check_direct_read(inode_to_fs_info(inode), to, iocb->ki_pos))
+		return 0;
+
+	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
+again:
+	/*
+	 * This is similar to what we do for direct IO writes, see the comment
+	 * at btrfs_direct_write(), but we also disable page faults in addition
+	 * to disabling them only at the iov_iter level. This is because when
+	 * reading from a hole or prealloc extent, iomap calls iov_iter_zero(),
+	 * which can still trigger page fault ins despite having set ->nofault
+	 * to true of our 'to' iov_iter.
+	 *
+	 * The difference to direct IO writes is that we deadlock when trying
+	 * to lock the extent range in the inode's tree during he page reads
+	 * triggered by the fault in (while for writes it is due to waiting for
+	 * our own ordered extent). This is because for direct IO reads,
+	 * btrfs_dio_iomap_begin() returns with the extent range locked, which
+	 * is only unlocked in the endio callback (end_bio_extent_readpage()).
+	 */
+	pagefault_disable();
+	to->nofault = true;
+	ret = btrfs_dio_read(iocb, to, read);
+	to->nofault = false;
+	pagefault_enable();
+
+	/* No increment (+=) because iomap returns a cumulative value. */
+	if (ret > 0)
+		read = ret;
+
+	if (iov_iter_count(to) > 0 && (ret == -EFAULT || ret > 0)) {
+		const size_t left = iov_iter_count(to);
+
+		if (left == prev_left) {
+			/*
+			 * We didn't make any progress since the last attempt,
+			 * fallback to a buffered read for the remainder of the
+			 * range. This is just to avoid any possibility of looping
+			 * for too long.
+			 */
+			ret = read;
+		} else {
+			/*
+			 * We made some progress since the last retry or this is
+			 * the first time we are retrying. Fault in as many pages
+			 * as possible and retry.
+			 */
+			fault_in_iov_iter_writeable(to, left);
+			prev_left = left;
+			goto again;
+		}
+	}
+	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
+	return ret < 0 ? ret : read;
+}
+
+int __init btrfs_init_dio(void)
+{
+	if (bioset_init(&btrfs_dio_bioset, BIO_POOL_SIZE,
+			offsetof(struct btrfs_dio_private, bbio.bio),
+			BIOSET_NEED_BVECS))
+		return -ENOMEM;
+
+	return 0;
+}
+
+void __cold btrfs_destroy_dio(void)
+{
+	bioset_exit(&btrfs_dio_bioset);
+}
diff --git a/fs/btrfs/direct-io.h b/fs/btrfs/direct-io.h
new file mode 100644
index 000000000000..3dc3ea926afe
--- /dev/null
+++ b/fs/btrfs/direct-io.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_DIRECT_IO_H
+#define BTRFS_DIRECT_IO_H
+
+#include <linux/types.h>
+
+int __init btrfs_init_dio(void);
+void __cold btrfs_destroy_dio(void);
+
+ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from);
+ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to);
+
+#endif /* BTRFS_DIRECT_IO_H */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5834d452677f..21381de906f6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -17,8 +17,8 @@
 #include <linux/uio.h>
 #include <linux/iversion.h>
 #include <linux/fsverity.h>
-#include <linux/iomap.h>
 #include "ctree.h"
+#include "direct-io.h"
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
@@ -1140,8 +1140,7 @@ static void update_time_for_write(struct inode *inode)
 		inode_inc_iversion(inode);
 }
 
-static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
-			     size_t count)
+int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from, size_t count)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
@@ -1187,8 +1186,7 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	return 0;
 }
 
-static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
-					       struct iov_iter *i)
+ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
 	loff_t pos;
@@ -1451,194 +1449,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	return num_written ? num_written : ret;
 }
 
-static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
-			       const struct iov_iter *iter, loff_t offset)
-{
-	const u32 blocksize_mask = fs_info->sectorsize - 1;
-
-	if (offset & blocksize_mask)
-		return -EINVAL;
-
-	if (iov_iter_alignment(iter) & blocksize_mask)
-		return -EINVAL;
-
-	return 0;
-}
-
-static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	loff_t pos;
-	ssize_t written = 0;
-	ssize_t written_buffered;
-	size_t prev_left = 0;
-	loff_t endbyte;
-	ssize_t ret;
-	unsigned int ilock_flags = 0;
-	struct iomap_dio *dio;
-
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		ilock_flags |= BTRFS_ILOCK_TRY;
-
-	/*
-	 * If the write DIO is within EOF, use a shared lock and also only if
-	 * security bits will likely not be dropped by file_remove_privs() called
-	 * from btrfs_write_check(). Either will need to be rechecked after the
-	 * lock was acquired.
-	 */
-	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode) && IS_NOSEC(inode))
-		ilock_flags |= BTRFS_ILOCK_SHARED;
-
-relock:
-	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
-	if (ret < 0)
-		return ret;
-
-	/* Shared lock cannot be used with security bits set. */
-	if ((ilock_flags & BTRFS_ILOCK_SHARED) && !IS_NOSEC(inode)) {
-		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
-		ilock_flags &= ~BTRFS_ILOCK_SHARED;
-		goto relock;
-	}
-
-	ret = generic_write_checks(iocb, from);
-	if (ret <= 0) {
-		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
-		return ret;
-	}
-
-	ret = btrfs_write_check(iocb, from, ret);
-	if (ret < 0) {
-		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
-		goto out;
-	}
-
-	pos = iocb->ki_pos;
-	/*
-	 * Re-check since file size may have changed just before taking the
-	 * lock or pos may have changed because of O_APPEND in generic_write_check()
-	 */
-	if ((ilock_flags & BTRFS_ILOCK_SHARED) &&
-	    pos + iov_iter_count(from) > i_size_read(inode)) {
-		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
-		ilock_flags &= ~BTRFS_ILOCK_SHARED;
-		goto relock;
-	}
-
-	if (check_direct_IO(fs_info, from, pos)) {
-		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
-		goto buffered;
-	}
-
-	/*
-	 * The iov_iter can be mapped to the same file range we are writing to.
-	 * If that's the case, then we will deadlock in the iomap code, because
-	 * it first calls our callback btrfs_dio_iomap_begin(), which will create
-	 * an ordered extent, and after that it will fault in the pages that the
-	 * iov_iter refers to. During the fault in we end up in the readahead
-	 * pages code (starting at btrfs_readahead()), which will lock the range,
-	 * find that ordered extent and then wait for it to complete (at
-	 * btrfs_lock_and_flush_ordered_range()), resulting in a deadlock since
-	 * obviously the ordered extent can never complete as we didn't submit
-	 * yet the respective bio(s). This always happens when the buffer is
-	 * memory mapped to the same file range, since the iomap DIO code always
-	 * invalidates pages in the target file range (after starting and waiting
-	 * for any writeback).
-	 *
-	 * So here we disable page faults in the iov_iter and then retry if we
-	 * got -EFAULT, faulting in the pages before the retry.
-	 */
-	from->nofault = true;
-	dio = btrfs_dio_write(iocb, from, written);
-	from->nofault = false;
-
-	/*
-	 * iomap_dio_complete() will call btrfs_sync_file() if we have a dsync
-	 * iocb, and that needs to lock the inode. So unlock it before calling
-	 * iomap_dio_complete() to avoid a deadlock.
-	 */
-	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
-
-	if (IS_ERR_OR_NULL(dio))
-		ret = PTR_ERR_OR_ZERO(dio);
-	else
-		ret = iomap_dio_complete(dio);
-
-	/* No increment (+=) because iomap returns a cumulative value. */
-	if (ret > 0)
-		written = ret;
-
-	if (iov_iter_count(from) > 0 && (ret == -EFAULT || ret > 0)) {
-		const size_t left = iov_iter_count(from);
-		/*
-		 * We have more data left to write. Try to fault in as many as
-		 * possible of the remainder pages and retry. We do this without
-		 * releasing and locking again the inode, to prevent races with
-		 * truncate.
-		 *
-		 * Also, in case the iov refers to pages in the file range of the
-		 * file we want to write to (due to a mmap), we could enter an
-		 * infinite loop if we retry after faulting the pages in, since
-		 * iomap will invalidate any pages in the range early on, before
-		 * it tries to fault in the pages of the iov. So we keep track of
-		 * how much was left of iov in the previous EFAULT and fallback
-		 * to buffered IO in case we haven't made any progress.
-		 */
-		if (left == prev_left) {
-			ret = -ENOTBLK;
-		} else {
-			fault_in_iov_iter_readable(from, left);
-			prev_left = left;
-			goto relock;
-		}
-	}
-
-	/*
-	 * If 'ret' is -ENOTBLK or we have not written all data, then it means
-	 * we must fallback to buffered IO.
-	 */
-	if ((ret < 0 && ret != -ENOTBLK) || !iov_iter_count(from))
-		goto out;
-
-buffered:
-	/*
-	 * If we are in a NOWAIT context, then return -EAGAIN to signal the caller
-	 * it must retry the operation in a context where blocking is acceptable,
-	 * because even if we end up not blocking during the buffered IO attempt
-	 * below, we will block when flushing and waiting for the IO.
-	 */
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		ret = -EAGAIN;
-		goto out;
-	}
-
-	pos = iocb->ki_pos;
-	written_buffered = btrfs_buffered_write(iocb, from);
-	if (written_buffered < 0) {
-		ret = written_buffered;
-		goto out;
-	}
-	/*
-	 * Ensure all data is persisted. We want the next direct IO read to be
-	 * able to read what was just written.
-	 */
-	endbyte = pos + written_buffered - 1;
-	ret = btrfs_fdatawrite_range(BTRFS_I(inode), pos, endbyte);
-	if (ret)
-		goto out;
-	ret = filemap_fdatawait_range(inode->i_mapping, pos, endbyte);
-	if (ret)
-		goto out;
-	written += written_buffered;
-	iocb->ki_pos = pos + written_buffered;
-	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
-				 endbyte >> PAGE_SHIFT);
-out:
-	return ret < 0 ? ret : written;
-}
-
 static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 			const struct btrfs_ioctl_encoded_io_args *encoded)
 {
@@ -3914,97 +3724,6 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
-static int check_direct_read(struct btrfs_fs_info *fs_info,
-			     const struct iov_iter *iter, loff_t offset)
-{
-	int ret;
-	int i, seg;
-
-	ret = check_direct_IO(fs_info, iter, offset);
-	if (ret < 0)
-		return ret;
-
-	if (!iter_is_iovec(iter))
-		return 0;
-
-	for (seg = 0; seg < iter->nr_segs; seg++) {
-		for (i = seg + 1; i < iter->nr_segs; i++) {
-			const struct iovec *iov1 = iter_iov(iter) + seg;
-			const struct iovec *iov2 = iter_iov(iter) + i;
-
-			if (iov1->iov_base == iov2->iov_base)
-				return -EINVAL;
-		}
-	}
-	return 0;
-}
-
-static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
-{
-	struct inode *inode = file_inode(iocb->ki_filp);
-	size_t prev_left = 0;
-	ssize_t read = 0;
-	ssize_t ret;
-
-	if (fsverity_active(inode))
-		return 0;
-
-	if (check_direct_read(inode_to_fs_info(inode), to, iocb->ki_pos))
-		return 0;
-
-	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
-again:
-	/*
-	 * This is similar to what we do for direct IO writes, see the comment
-	 * at btrfs_direct_write(), but we also disable page faults in addition
-	 * to disabling them only at the iov_iter level. This is because when
-	 * reading from a hole or prealloc extent, iomap calls iov_iter_zero(),
-	 * which can still trigger page fault ins despite having set ->nofault
-	 * to true of our 'to' iov_iter.
-	 *
-	 * The difference to direct IO writes is that we deadlock when trying
-	 * to lock the extent range in the inode's tree during he page reads
-	 * triggered by the fault in (while for writes it is due to waiting for
-	 * our own ordered extent). This is because for direct IO reads,
-	 * btrfs_dio_iomap_begin() returns with the extent range locked, which
-	 * is only unlocked in the endio callback (end_bio_extent_readpage()).
-	 */
-	pagefault_disable();
-	to->nofault = true;
-	ret = btrfs_dio_read(iocb, to, read);
-	to->nofault = false;
-	pagefault_enable();
-
-	/* No increment (+=) because iomap returns a cumulative value. */
-	if (ret > 0)
-		read = ret;
-
-	if (iov_iter_count(to) > 0 && (ret == -EFAULT || ret > 0)) {
-		const size_t left = iov_iter_count(to);
-
-		if (left == prev_left) {
-			/*
-			 * We didn't make any progress since the last attempt,
-			 * fallback to a buffered read for the remainder of the
-			 * range. This is just to avoid any possibility of looping
-			 * for too long.
-			 */
-			ret = read;
-		} else {
-			/*
-			 * We made some progress since the last retry or this is
-			 * the first time we are retrying. Fault in as many pages
-			 * as possible and retry.
-			 */
-			fault_in_iov_iter_writeable(to, left);
-			prev_left = left;
-			goto again;
-		}
-	}
-	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
-	return ret < 0 ? ret : read;
-}
-
 static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret = 0;
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index ce93ed7083ab..912254e653cf 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -44,5 +44,7 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
 bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct extent_state **cached_state,
 				  u64 *delalloc_start_ret, u64 *delalloc_end_ret);
+int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from, size_t count);
+ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i);
 
 #endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d6c43120c5d3..41a3e3e73623 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -77,25 +77,6 @@ struct btrfs_iget_args {
 	struct btrfs_root *root;
 };
 
-struct btrfs_dio_data {
-	ssize_t submitted;
-	struct extent_changeset *data_reserved;
-	struct btrfs_ordered_extent *ordered;
-	bool data_space_reserved;
-	bool nocow_done;
-};
-
-struct btrfs_dio_private {
-	/* Range of I/O */
-	u64 file_offset;
-	u32 bytes;
-
-	/* This must be last */
-	struct btrfs_bio bbio;
-};
-
-static struct bio_set btrfs_dio_bioset;
-
 struct btrfs_rename_ctx {
 	/* Output field. Stores the index number of the old directory entry. */
 	u64 index;
@@ -138,9 +119,6 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     struct page *locked_page, u64 start,
 				     u64 end, struct writeback_control *wbc,
 				     bool pages_dirty);
-static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       const struct btrfs_file_extent *file_extent,
-				       int type);
 
 static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 					  u64 root, void *warn_ctx)
@@ -1205,7 +1183,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	file_extent.offset = 0;
 	file_extent.compression = async_extent->compress_type;
 
-	em = create_io_em(inode, start, &file_extent, BTRFS_ORDERED_COMPRESSED);
+	em = btrfs_create_io_em(inode, start, &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_free_reserve;
@@ -1257,8 +1235,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	kfree(async_extent);
 }
 
-static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
-				      u64 num_bytes)
+u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
+				     u64 num_bytes)
 {
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
@@ -1368,7 +1346,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 	}
 
-	alloc_hint = get_extent_allocation_hint(inode, start, num_bytes);
+	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, num_bytes);
 
 	/*
 	 * Relocation relies on the relocated extents to have exactly the same
@@ -1435,7 +1413,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		lock_extent(&inode->io_tree, start, start + ram_size - 1,
 			    &cached);
 
-		em = create_io_em(inode, start, &file_extent, BTRFS_ORDERED_REGULAR);
+		em = btrfs_create_io_em(inode, start, &file_extent,
+					BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(em)) {
 			unlock_extent(&inode->io_tree, start,
 				      start + ram_size - 1, &cached);
@@ -2152,8 +2131,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		if (is_prealloc) {
 			struct extent_map *em;
 
-			em = create_io_em(inode, cur_offset, &nocow_args.file_extent,
-					  BTRFS_ORDERED_PREALLOC);
+			em = btrfs_create_io_em(inode, cur_offset,
+						&nocow_args.file_extent,
+						BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
 				unlock_extent(&inode->io_tree, cur_offset,
 					      nocow_end, &cached_state);
@@ -2582,44 +2562,6 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 	}
 }
 
-static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
-					struct btrfs_ordered_extent *ordered)
-{
-	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
-	u64 len = bbio->bio.bi_iter.bi_size;
-	struct btrfs_ordered_extent *new;
-	int ret;
-
-	/* Must always be called for the beginning of an ordered extent. */
-	if (WARN_ON_ONCE(start != ordered->disk_bytenr))
-		return -EINVAL;
-
-	/* No need to split if the ordered extent covers the entire bio. */
-	if (ordered->disk_num_bytes == len) {
-		refcount_inc(&ordered->refs);
-		bbio->ordered = ordered;
-		return 0;
-	}
-
-	/*
-	 * Don't split the extent_map for NOCOW extents, as we're writing into
-	 * a pre-existing one.
-	 */
-	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags)) {
-		ret = split_extent_map(bbio->inode, bbio->file_offset,
-				       ordered->num_bytes, len,
-				       ordered->disk_bytenr);
-		if (ret)
-			return ret;
-	}
-
-	new = btrfs_split_ordered_extent(ordered, len);
-	if (IS_ERR(new))
-		return PTR_ERR(new);
-	bbio->ordered = new;
-	return 0;
-}
-
 /*
  * given a list of ordered sums record them in the inode.  This happens
  * at IO completion time based on sums calculated at bio submission time.
@@ -6995,81 +6937,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	return em;
 }
 
-static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
-						  struct btrfs_dio_data *dio_data,
-						  const u64 start,
-						  const struct btrfs_file_extent *file_extent,
-						  const int type)
-{
-	struct extent_map *em = NULL;
-	struct btrfs_ordered_extent *ordered;
-
-	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, start, file_extent, type);
-		if (IS_ERR(em))
-			goto out;
-	}
-
-	ordered = btrfs_alloc_ordered_extent(inode, start, file_extent,
-					     (1 << type) |
-					     (1 << BTRFS_ORDERED_DIRECT));
-	if (IS_ERR(ordered)) {
-		if (em) {
-			free_extent_map(em);
-			btrfs_drop_extent_map_range(inode, start,
-					start + file_extent->num_bytes - 1, false);
-		}
-		em = ERR_CAST(ordered);
-	} else {
-		ASSERT(!dio_data->ordered);
-		dio_data->ordered = ordered;
-	}
- out:
-
-	return em;
-}
-
-static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
-						  struct btrfs_dio_data *dio_data,
-						  u64 start, u64 len)
-{
-	struct btrfs_root *root = inode->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_file_extent file_extent;
-	struct extent_map *em;
-	struct btrfs_key ins;
-	u64 alloc_hint;
-	int ret;
-
-	alloc_hint = get_extent_allocation_hint(inode, start, len);
-again:
-	ret = btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
-				   0, alloc_hint, &ins, 1, 1);
-	if (ret == -EAGAIN) {
-		ASSERT(btrfs_is_zoned(fs_info));
-		wait_on_bit_io(&inode->root->fs_info->flags, BTRFS_FS_NEED_ZONE_FINISH,
-			       TASK_UNINTERRUPTIBLE);
-		goto again;
-	}
-	if (ret)
-		return ERR_PTR(ret);
-
-	file_extent.disk_bytenr = ins.objectid;
-	file_extent.disk_num_bytes = ins.offset;
-	file_extent.num_bytes = ins.offset;
-	file_extent.ram_bytes = ins.offset;
-	file_extent.offset = 0;
-	file_extent.compression = BTRFS_COMPRESS_NONE;
-	em = btrfs_create_dio_extent(inode, dio_data, start, &file_extent,
-				     BTRFS_ORDERED_REGULAR);
-	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
-	if (IS_ERR(em))
-		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
-					   1);
-
-	return em;
-}
-
 static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
 {
 	struct btrfs_block_group *block_group;
@@ -7200,103 +7067,10 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	return ret;
 }
 
-static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
-			      struct extent_state **cached_state,
-			      unsigned int iomap_flags)
-{
-	const bool writing = (iomap_flags & IOMAP_WRITE);
-	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-	struct btrfs_ordered_extent *ordered;
-	int ret = 0;
-
-	while (1) {
-		if (nowait) {
-			if (!try_lock_extent(io_tree, lockstart, lockend,
-					     cached_state))
-				return -EAGAIN;
-		} else {
-			lock_extent(io_tree, lockstart, lockend, cached_state);
-		}
-		/*
-		 * We're concerned with the entire range that we're going to be
-		 * doing DIO to, so we need to make sure there's no ordered
-		 * extents in this range.
-		 */
-		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), lockstart,
-						     lockend - lockstart + 1);
-
-		/*
-		 * We need to make sure there are no buffered pages in this
-		 * range either, we could have raced between the invalidate in
-		 * generic_file_direct_write and locking the extent.  The
-		 * invalidate needs to happen so that reads after a write do not
-		 * get stale data.
-		 */
-		if (!ordered &&
-		    (!writing || !filemap_range_has_page(inode->i_mapping,
-							 lockstart, lockend)))
-			break;
-
-		unlock_extent(io_tree, lockstart, lockend, cached_state);
-
-		if (ordered) {
-			if (nowait) {
-				btrfs_put_ordered_extent(ordered);
-				ret = -EAGAIN;
-				break;
-			}
-			/*
-			 * If we are doing a DIO read and the ordered extent we
-			 * found is for a buffered write, we can not wait for it
-			 * to complete and retry, because if we do so we can
-			 * deadlock with concurrent buffered writes on page
-			 * locks. This happens only if our DIO read covers more
-			 * than one extent map, if at this point has already
-			 * created an ordered extent for a previous extent map
-			 * and locked its range in the inode's io tree, and a
-			 * concurrent write against that previous extent map's
-			 * range and this range started (we unlock the ranges
-			 * in the io tree only when the bios complete and
-			 * buffered writes always lock pages before attempting
-			 * to lock range in the io tree).
-			 */
-			if (writing ||
-			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
-				btrfs_start_ordered_extent(ordered);
-			else
-				ret = nowait ? -EAGAIN : -ENOTBLK;
-			btrfs_put_ordered_extent(ordered);
-		} else {
-			/*
-			 * We could trigger writeback for this range (and wait
-			 * for it to complete) and then invalidate the pages for
-			 * this range (through invalidate_inode_pages2_range()),
-			 * but that can lead us to a deadlock with a concurrent
-			 * call to readahead (a buffered read or a defrag call
-			 * triggered a readahead) on a page lock due to an
-			 * ordered dio extent we created before but did not have
-			 * yet a corresponding bio submitted (whence it can not
-			 * complete), which makes readahead wait for that
-			 * ordered extent to complete while holding a lock on
-			 * that page.
-			 */
-			ret = nowait ? -EAGAIN : -ENOTBLK;
-		}
-
-		if (ret)
-			break;
-
-		cond_resched();
-	}
-
-	return ret;
-}
-
 /* The callers of this must take lock_extent() */
-static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       const struct btrfs_file_extent *file_extent,
-				       int type)
+struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
+				      const struct btrfs_file_extent *file_extent,
+				      int type)
 {
 	struct extent_map *em;
 	int ret;
@@ -7363,527 +7137,6 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	return em;
 }
 
-
-static int btrfs_get_blocks_direct_write(struct extent_map **map,
-					 struct inode *inode,
-					 struct btrfs_dio_data *dio_data,
-					 u64 start, u64 *lenp,
-					 unsigned int iomap_flags)
-{
-	const bool nowait = (iomap_flags & IOMAP_NOWAIT);
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct btrfs_file_extent file_extent;
-	struct extent_map *em = *map;
-	int type;
-	u64 block_start;
-	struct btrfs_block_group *bg;
-	bool can_nocow = false;
-	bool space_reserved = false;
-	u64 len = *lenp;
-	u64 prev_len;
-	int ret = 0;
-
-	/*
-	 * We don't allocate a new extent in the following cases
-	 *
-	 * 1) The inode is marked as NODATACOW. In this case we'll just use the
-	 * existing extent.
-	 * 2) The extent is marked as PREALLOC. We're good to go here and can
-	 * just use the extent.
-	 *
-	 */
-	if ((em->flags & EXTENT_FLAG_PREALLOC) ||
-	    ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
-	     em->disk_bytenr != EXTENT_MAP_HOLE)) {
-		if (em->flags & EXTENT_FLAG_PREALLOC)
-			type = BTRFS_ORDERED_PREALLOC;
-		else
-			type = BTRFS_ORDERED_NOCOW;
-		len = min(len, em->len - (start - em->start));
-		block_start = extent_map_block_start(em) + (start - em->start);
-
-		if (can_nocow_extent(inode, start, &len,
-				     &file_extent, false, false) == 1) {
-			bg = btrfs_inc_nocow_writers(fs_info, block_start);
-			if (bg)
-				can_nocow = true;
-		}
-	}
-
-	prev_len = len;
-	if (can_nocow) {
-		struct extent_map *em2;
-
-		/* We can NOCOW, so only need to reserve metadata space. */
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
-						      nowait);
-		if (ret < 0) {
-			/* Our caller expects us to free the input extent map. */
-			free_extent_map(em);
-			*map = NULL;
-			btrfs_dec_nocow_writers(bg);
-			if (nowait && (ret == -ENOSPC || ret == -EDQUOT))
-				ret = -EAGAIN;
-			goto out;
-		}
-		space_reserved = true;
-
-		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start,
-					      &file_extent, type);
-		btrfs_dec_nocow_writers(bg);
-		if (type == BTRFS_ORDERED_PREALLOC) {
-			free_extent_map(em);
-			*map = em2;
-			em = em2;
-		}
-
-		if (IS_ERR(em2)) {
-			ret = PTR_ERR(em2);
-			goto out;
-		}
-
-		dio_data->nocow_done = true;
-	} else {
-		/* Our caller expects us to free the input extent map. */
-		free_extent_map(em);
-		*map = NULL;
-
-		if (nowait) {
-			ret = -EAGAIN;
-			goto out;
-		}
-
-		/*
-		 * If we could not allocate data space before locking the file
-		 * range and we can't do a NOCOW write, then we have to fail.
-		 */
-		if (!dio_data->data_space_reserved) {
-			ret = -ENOSPC;
-			goto out;
-		}
-
-		/*
-		 * We have to COW and we have already reserved data space before,
-		 * so now we reserve only metadata.
-		 */
-		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
-						      false);
-		if (ret < 0)
-			goto out;
-		space_reserved = true;
-
-		em = btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
-		if (IS_ERR(em)) {
-			ret = PTR_ERR(em);
-			goto out;
-		}
-		*map = em;
-		len = min(len, em->len - (start - em->start));
-		if (len < prev_len)
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							prev_len - len, true);
-	}
-
-	/*
-	 * We have created our ordered extent, so we can now release our reservation
-	 * for an outstanding extent.
-	 */
-	btrfs_delalloc_release_extents(BTRFS_I(inode), prev_len);
-
-	/*
-	 * Need to update the i_size under the extent lock so buffered
-	 * readers will get the updated i_size when we unlock.
-	 */
-	if (start + len > i_size_read(inode))
-		i_size_write(inode, start + len);
-out:
-	if (ret && space_reserved) {
-		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
-		btrfs_delalloc_release_metadata(BTRFS_I(inode), len, true);
-	}
-	*lenp = len;
-	return ret;
-}
-
-static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
-		loff_t length, unsigned int flags, struct iomap *iomap,
-		struct iomap *srcmap)
-{
-	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	struct extent_map *em;
-	struct extent_state *cached_state = NULL;
-	struct btrfs_dio_data *dio_data = iter->private;
-	u64 lockstart, lockend;
-	const bool write = !!(flags & IOMAP_WRITE);
-	int ret = 0;
-	u64 len = length;
-	const u64 data_alloc_len = length;
-	bool unlock_extents = false;
-
-	/*
-	 * We could potentially fault if we have a buffer > PAGE_SIZE, and if
-	 * we're NOWAIT we may submit a bio for a partial range and return
-	 * EIOCBQUEUED, which would result in an errant short read.
-	 *
-	 * The best way to handle this would be to allow for partial completions
-	 * of iocb's, so we could submit the partial bio, return and fault in
-	 * the rest of the pages, and then submit the io for the rest of the
-	 * range.  However we don't have that currently, so simply return
-	 * -EAGAIN at this point so that the normal path is used.
-	 */
-	if (!write && (flags & IOMAP_NOWAIT) && length > PAGE_SIZE)
-		return -EAGAIN;
-
-	/*
-	 * Cap the size of reads to that usually seen in buffered I/O as we need
-	 * to allocate a contiguous array for the checksums.
-	 */
-	if (!write)
-		len = min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_BIO_SECTORS);
-
-	lockstart = start;
-	lockend = start + len - 1;
-
-	/*
-	 * iomap_dio_rw() only does filemap_write_and_wait_range(), which isn't
-	 * enough if we've written compressed pages to this area, so we need to
-	 * flush the dirty pages again to make absolutely sure that any
-	 * outstanding dirty pages are on disk - the first flush only starts
-	 * compression on the data, while keeping the pages locked, so by the
-	 * time the second flush returns we know bios for the compressed pages
-	 * were submitted and finished, and the pages no longer under writeback.
-	 *
-	 * If we have a NOWAIT request and we have any pages in the range that
-	 * are locked, likely due to compression still in progress, we don't want
-	 * to block on page locks. We also don't want to block on pages marked as
-	 * dirty or under writeback (same as for the non-compression case).
-	 * iomap_dio_rw() did the same check, but after that and before we got
-	 * here, mmap'ed writes may have happened or buffered reads started
-	 * (readpage() and readahead(), which lock pages), as we haven't locked
-	 * the file range yet.
-	 */
-	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-		     &BTRFS_I(inode)->runtime_flags)) {
-		if (flags & IOMAP_NOWAIT) {
-			if (filemap_range_needs_writeback(inode->i_mapping,
-							  lockstart, lockend))
-				return -EAGAIN;
-		} else {
-			ret = filemap_fdatawrite_range(inode->i_mapping, start,
-						       start + length - 1);
-			if (ret)
-				return ret;
-		}
-	}
-
-	memset(dio_data, 0, sizeof(*dio_data));
-
-	/*
-	 * We always try to allocate data space and must do it before locking
-	 * the file range, to avoid deadlocks with concurrent writes to the same
-	 * range if the range has several extents and the writes don't expand the
-	 * current i_size (the inode lock is taken in shared mode). If we fail to
-	 * allocate data space here we continue and later, after locking the
-	 * file range, we fail with ENOSPC only if we figure out we can not do a
-	 * NOCOW write.
-	 */
-	if (write && !(flags & IOMAP_NOWAIT)) {
-		ret = btrfs_check_data_free_space(BTRFS_I(inode),
-						  &dio_data->data_reserved,
-						  start, data_alloc_len, false);
-		if (!ret)
-			dio_data->data_space_reserved = true;
-		else if (ret && !(BTRFS_I(inode)->flags &
-				  (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
-			goto err;
-	}
-
-	/*
-	 * If this errors out it's because we couldn't invalidate pagecache for
-	 * this range and we need to fallback to buffered IO, or we are doing a
-	 * NOWAIT read/write and we need to block.
-	 */
-	ret = lock_extent_direct(inode, lockstart, lockend, &cached_state, flags);
-	if (ret < 0)
-		goto err;
-
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
-	if (IS_ERR(em)) {
-		ret = PTR_ERR(em);
-		goto unlock_err;
-	}
-
-	/*
-	 * Ok for INLINE and COMPRESSED extents we need to fallback on buffered
-	 * io.  INLINE is special, and we could probably kludge it in here, but
-	 * it's still buffered so for safety lets just fall back to the generic
-	 * buffered path.
-	 *
-	 * For COMPRESSED we _have_ to read the entire extent in so we can
-	 * decompress it, so there will be buffering required no matter what we
-	 * do, so go ahead and fallback to buffered.
-	 *
-	 * We return -ENOTBLK because that's what makes DIO go ahead and go back
-	 * to buffered IO.  Don't blame me, this is the price we pay for using
-	 * the generic code.
-	 */
-	if (extent_map_is_compressed(em) || em->disk_bytenr == EXTENT_MAP_INLINE) {
-		free_extent_map(em);
-		/*
-		 * If we are in a NOWAIT context, return -EAGAIN in order to
-		 * fallback to buffered IO. This is not only because we can
-		 * block with buffered IO (no support for NOWAIT semantics at
-		 * the moment) but also to avoid returning short reads to user
-		 * space - this happens if we were able to read some data from
-		 * previous non-compressed extents and then when we fallback to
-		 * buffered IO, at btrfs_file_read_iter() by calling
-		 * filemap_read(), we fail to fault in pages for the read buffer,
-		 * in which case filemap_read() returns a short read (the number
-		 * of bytes previously read is > 0, so it does not return -EFAULT).
-		 */
-		ret = (flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOTBLK;
-		goto unlock_err;
-	}
-
-	len = min(len, em->len - (start - em->start));
-
-	/*
-	 * If we have a NOWAIT request and the range contains multiple extents
-	 * (or a mix of extents and holes), then we return -EAGAIN to make the
-	 * caller fallback to a context where it can do a blocking (without
-	 * NOWAIT) request. This way we avoid doing partial IO and returning
-	 * success to the caller, which is not optimal for writes and for reads
-	 * it can result in unexpected behaviour for an application.
-	 *
-	 * When doing a read, because we use IOMAP_DIO_PARTIAL when calling
-	 * iomap_dio_rw(), we can end up returning less data then what the caller
-	 * asked for, resulting in an unexpected, and incorrect, short read.
-	 * That is, the caller asked to read N bytes and we return less than that,
-	 * which is wrong unless we are crossing EOF. This happens if we get a
-	 * page fault error when trying to fault in pages for the buffer that is
-	 * associated to the struct iov_iter passed to iomap_dio_rw(), and we
-	 * have previously submitted bios for other extents in the range, in
-	 * which case iomap_dio_rw() may return us EIOCBQUEUED if not all of
-	 * those bios have completed by the time we get the page fault error,
-	 * which we return back to our caller - we should only return EIOCBQUEUED
-	 * after we have submitted bios for all the extents in the range.
-	 */
-	if ((flags & IOMAP_NOWAIT) && len < length) {
-		free_extent_map(em);
-		ret = -EAGAIN;
-		goto unlock_err;
-	}
-
-	if (write) {
-		ret = btrfs_get_blocks_direct_write(&em, inode, dio_data,
-						    start, &len, flags);
-		if (ret < 0)
-			goto unlock_err;
-		unlock_extents = true;
-		/* Recalc len in case the new em is smaller than requested */
-		len = min(len, em->len - (start - em->start));
-		if (dio_data->data_space_reserved) {
-			u64 release_offset;
-			u64 release_len = 0;
-
-			if (dio_data->nocow_done) {
-				release_offset = start;
-				release_len = data_alloc_len;
-			} else if (len < data_alloc_len) {
-				release_offset = start + len;
-				release_len = data_alloc_len - len;
-			}
-
-			if (release_len > 0)
-				btrfs_free_reserved_data_space(BTRFS_I(inode),
-							       dio_data->data_reserved,
-							       release_offset,
-							       release_len);
-		}
-	} else {
-		/*
-		 * We need to unlock only the end area that we aren't using.
-		 * The rest is going to be unlocked by the endio routine.
-		 */
-		lockstart = start + len;
-		if (lockstart < lockend)
-			unlock_extents = true;
-	}
-
-	if (unlock_extents)
-		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-			      &cached_state);
-	else
-		free_extent_state(cached_state);
-
-	/*
-	 * Translate extent map information to iomap.
-	 * We trim the extents (and move the addr) even though iomap code does
-	 * that, since we have locked only the parts we are performing I/O in.
-	 */
-	if ((em->disk_bytenr == EXTENT_MAP_HOLE) ||
-	    ((em->flags & EXTENT_FLAG_PREALLOC) && !write)) {
-		iomap->addr = IOMAP_NULL_ADDR;
-		iomap->type = IOMAP_HOLE;
-	} else {
-		iomap->addr = extent_map_block_start(em) + (start - em->start);
-		iomap->type = IOMAP_MAPPED;
-	}
-	iomap->offset = start;
-	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
-	iomap->length = len;
-	free_extent_map(em);
-
-	return 0;
-
-unlock_err:
-	unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-		      &cached_state);
-err:
-	if (dio_data->data_space_reserved) {
-		btrfs_free_reserved_data_space(BTRFS_I(inode),
-					       dio_data->data_reserved,
-					       start, data_alloc_len);
-		extent_changeset_free(dio_data->data_reserved);
-	}
-
-	return ret;
-}
-
-static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
-		ssize_t written, unsigned int flags, struct iomap *iomap)
-{
-	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
-	struct btrfs_dio_data *dio_data = iter->private;
-	size_t submitted = dio_data->submitted;
-	const bool write = !!(flags & IOMAP_WRITE);
-	int ret = 0;
-
-	if (!write && (iomap->type == IOMAP_HOLE)) {
-		/* If reading from a hole, unlock and return */
-		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1,
-			      NULL);
-		return 0;
-	}
-
-	if (submitted < length) {
-		pos += submitted;
-		length -= submitted;
-		if (write)
-			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
-						    pos, length, false);
-		else
-			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
-				      pos + length - 1, NULL);
-		ret = -ENOTBLK;
-	}
-	if (write) {
-		btrfs_put_ordered_extent(dio_data->ordered);
-		dio_data->ordered = NULL;
-	}
-
-	if (write)
-		extent_changeset_free(dio_data->data_reserved);
-	return ret;
-}
-
-static void btrfs_dio_end_io(struct btrfs_bio *bbio)
-{
-	struct btrfs_dio_private *dip =
-		container_of(bbio, struct btrfs_dio_private, bbio);
-	struct btrfs_inode *inode = bbio->inode;
-	struct bio *bio = &bbio->bio;
-
-	if (bio->bi_status) {
-		btrfs_warn(inode->root->fs_info,
-		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
-			   btrfs_ino(inode), bio->bi_opf,
-			   dip->file_offset, dip->bytes, bio->bi_status);
-	}
-
-	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		btrfs_finish_ordered_extent(bbio->ordered, NULL,
-					    dip->file_offset, dip->bytes,
-					    !bio->bi_status);
-	} else {
-		unlock_extent(&inode->io_tree, dip->file_offset,
-			      dip->file_offset + dip->bytes - 1, NULL);
-	}
-
-	bbio->bio.bi_private = bbio->private;
-	iomap_dio_bio_end_io(bio);
-}
-
-static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
-				loff_t file_offset)
-{
-	struct btrfs_bio *bbio = btrfs_bio(bio);
-	struct btrfs_dio_private *dip =
-		container_of(bbio, struct btrfs_dio_private, bbio);
-	struct btrfs_dio_data *dio_data = iter->private;
-
-	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
-		       btrfs_dio_end_io, bio->bi_private);
-	bbio->inode = BTRFS_I(iter->inode);
-	bbio->file_offset = file_offset;
-
-	dip->file_offset = file_offset;
-	dip->bytes = bio->bi_iter.bi_size;
-
-	dio_data->submitted += bio->bi_iter.bi_size;
-
-	/*
-	 * Check if we are doing a partial write.  If we are, we need to split
-	 * the ordered extent to match the submitted bio.  Hang on to the
-	 * remaining unfinishable ordered_extent in dio_data so that it can be
-	 * cancelled in iomap_end to avoid a deadlock wherein faulting the
-	 * remaining pages is blocked on the outstanding ordered extent.
-	 */
-	if (iter->flags & IOMAP_WRITE) {
-		int ret;
-
-		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
-		if (ret) {
-			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
-						    file_offset, dip->bytes,
-						    !ret);
-			bio->bi_status = errno_to_blk_status(ret);
-			iomap_dio_bio_end_io(bio);
-			return;
-		}
-	}
-
-	btrfs_submit_bio(bbio, 0);
-}
-
-static const struct iomap_ops btrfs_dio_iomap_ops = {
-	.iomap_begin            = btrfs_dio_iomap_begin,
-	.iomap_end              = btrfs_dio_iomap_end,
-};
-
-static const struct iomap_dio_ops btrfs_dio_ops = {
-	.submit_io		= btrfs_dio_submit_io,
-	.bio_set		= &btrfs_dio_bioset,
-};
-
-ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
-{
-	struct btrfs_dio_data data = { 0 };
-
-	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, &data, done_before);
-}
-
-struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
-				  size_t done_before)
-{
-	struct btrfs_dio_data data = { 0 };
-
-	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
-			    IOMAP_DIO_PARTIAL, &data, done_before);
-}
-
 /*
  * For release_folio() and invalidate_folio() we have a race window where
  * folio_end_writeback() is called but the subpage spinlock is not yet released.
@@ -8503,7 +7756,6 @@ void __cold btrfs_destroy_cachep(void)
 	 * destroy cache.
 	 */
 	rcu_barrier();
-	bioset_exit(&btrfs_dio_bioset);
 	kmem_cache_destroy(btrfs_inode_cachep);
 }
 
@@ -8514,17 +7766,9 @@ int __init btrfs_init_cachep(void)
 			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
 			init_once);
 	if (!btrfs_inode_cachep)
-		goto fail;
-
-	if (bioset_init(&btrfs_dio_bioset, BIO_POOL_SIZE,
-			offsetof(struct btrfs_dio_private, bbio.bio),
-			BIOSET_NEED_BVECS))
-		goto fail;
+		return -ENOMEM;
 
 	return 0;
-fail:
-	btrfs_destroy_cachep();
-	return -ENOMEM;
 }
 
 static int btrfs_getattr(struct mnt_idmap *idmap,
@@ -10267,7 +9511,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	file_extent.ram_bytes = ram_bytes;
 	file_extent.offset = encoded->unencoded_offset;
 	file_extent.compression = compression;
-	em = create_io_em(inode, start, &file_extent, BTRFS_ORDERED_COMPRESSED);
+	em = btrfs_create_io_em(inode, start, &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 715686e8d4cb..5450a01cb69c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -34,6 +34,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
+#include "direct-io.h"
 #include "props.h"
 #include "xattr.h"
 #include "bio.h"
@@ -2489,6 +2490,9 @@ static const struct init_sequence mod_init_seq[] = {
 	}, {
 		.init_func = btrfs_init_cachep,
 		.exit_func = btrfs_destroy_cachep,
+	}, {
+		.init_func = btrfs_init_dio,
+		.exit_func = btrfs_destroy_dio,
 	}, {
 		.init_func = btrfs_transaction_init,
 		.exit_func = btrfs_transaction_exit,
-- 
2.43.0


