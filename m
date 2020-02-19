Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9841816464F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 15:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBSOGA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 09:06:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgBSOGA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 09:06:00 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1E7C2176D
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2020 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582121159;
        bh=bq9OgEV6aivXt5rr7wiEyFeNsgI7KYBhCX0vF13ASSk=;
        h=From:To:Subject:Date:From;
        b=eYY1a6aDjxKMw/X/qc6R/c4E0FKhKhI9WHAJ3epHTmGGd/nSLvufoi+tsbAkLJ1ll
         orXqgQwo8qtojr8giLtdUtBp0FOOgjPch2J66WXgd7E3phKZ5kLqJfJH7Tp1U7kKw4
         2NthbZxwcYVqE5kNvNAY0fXNVEdhpk4Zdejk2TuE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] Btrfs: simplify inline extent handling when doing reflinks
Date:   Wed, 19 Feb 2020 14:05:56 +0000
Message-Id: <20200219140556.1641567-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We can not reflink parts of an inline extent, we must always reflink the
whole inline extent. We know that inline extents always start at file
offset 0 and that can never represent an amount of data larger then the
filesystem's sector size (both compressed and uncompressed). We also have
had the constraints that reflink operations must have a start offset that
is aligned to the sector size and an end offset that is also aligned or
it ends the inode's i_size, so there's no way for user space to be able
to do a reflink operation that will refer to only a part of an inline
extent.

Initially there was a bug in the inlining code that could allow compressed
inline extents that encoded more than 1 page, but that was fixed in 2008
by commit 70b99e6959a4c2 ("Btrfs: Compression corner fixes") since that
was problematic.

So remove all the extent cloning code that deals with the possibility
of cloning only partial inline extents.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reflink.c | 53 ++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f780fb8852ec..7e7f46116db3 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -74,9 +74,8 @@ static int clone_copy_inline_extent(struct inode *dst,
 				    struct btrfs_key *new_key,
 				    const u64 drop_start,
 				    const u64 datal,
-				    const u64 skip,
 				    const u64 size,
-				    char *inline_data)
+				    const char *inline_data)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dst->i_sb);
 	struct btrfs_root *root = BTRFS_I(dst)->root;
@@ -172,12 +171,6 @@ static int clone_copy_inline_extent(struct inode *dst,
 	if (ret)
 		return ret;
 
-	if (skip) {
-		const u32 start = btrfs_file_extent_calc_inline_size(0);
-
-		memmove(inline_data + start, inline_data + start + skip, datal);
-	}
-
 	write_extent_buffer(path->nodes[0], inline_data,
 			    btrfs_item_ptr_offset(path->nodes[0],
 						  path->slots[0]),
@@ -241,7 +234,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		struct btrfs_key new_key;
 		u64 disko = 0, diskl = 0;
 		u64 datao = 0, datal = 0;
-		u8 comp;
 		u64 drop_start;
 
 		/*
@@ -287,7 +279,6 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
 		extent = btrfs_item_ptr(leaf, slot,
 					struct btrfs_file_extent_item);
-		comp = btrfs_file_extent_compression(leaf, extent);
 		type = btrfs_file_extent_type(leaf, extent);
 		if (type == BTRFS_FILE_EXTENT_REG ||
 		    type == BTRFS_FILE_EXTENT_PREALLOC) {
@@ -370,23 +361,18 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			if (ret)
 				goto out;
 		} else if (type == BTRFS_FILE_EXTENT_INLINE) {
-			u64 skip = 0;
-			u64 trim = 0;
-
-			if (off > key.offset) {
-				skip = off - key.offset;
-				new_key.offset += skip;
-			}
-
-			if (key.offset + datal > off + len)
-				trim = key.offset + datal - (off + len);
-
-			if (comp && (skip || trim)) {
-				ret = -EINVAL;
-				goto out;
-			}
-			size -= skip + trim;
-			datal -= skip + trim;
+			/*
+			 * Inline extents always have to start at file offset 0
+			 * and can never be bigger then the sector size. We can
+			 * never clone only parts of an inline extent, since all
+			 * reflink operations must start at a sector size aligned
+			 * offset, and the length must be aligned too or end at
+			 * the i_size (which implies the whole inlined data).
+			 */
+			ASSERT(key.offset == 0);
+			ASSERT(datal <= fs_info->sectorsize);
+			if (key.offset != 0 || datal > fs_info->sectorsize)
+				return -EUCLEAN;
 
 			/*
 			 * If our extent is inline, we know we will drop or
@@ -404,7 +390,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
 			ret = clone_copy_inline_extent(inode, trans, path,
 						       &new_key, drop_start,
-						       datal, skip, size, buf);
+						       datal, size, buf);
 			if (ret) {
 				if (ret != -EOPNOTSUPP)
 					btrfs_abort_transaction(trans, ret);
@@ -550,17 +536,6 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	u64 len = olen;
 	u64 bs = fs_info->sb->s_blocksize;
 
-	/*
-	 * TODO:
-	 * - split compressed inline extents.  annoying: we need to
-	 *   decompress into destination's address_space (the file offset
-	 *   may change, so source mapping won't do), then recompress (or
-	 *   otherwise reinsert) a subrange.
-	 *
-	 * - split destination inode's inline extents.  The inline extents can
-	 *   be either compressed or non-compressed.
-	 */
-
 	/*
 	 * VFS's generic_remap_file_range_prep() protects us from cloning the
 	 * eof block into the middle of a file, which would result in corruption
-- 
2.25.0

