Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83A05D19F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfGBOXO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jul 2019 10:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfGBOXN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 10:23:13 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842EB2089C
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2019 14:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562077392;
        bh=dXWxnnhhaI8cWSA5SSS8fBCdHOLxhVc3W2eiy+Pc/N0=;
        h=From:To:Subject:Date:From;
        b=ifKpk2pmpxSC5Pp9bwJ9GJsA3w452uhbE3bnQUyjr8Vv7spJqRYVCQ4PqS38ZQvp5
         WwtErB6KQ572amk8FrrnAYlRbVOrL8DrMwLQx/BslFtBNssi6JwA/taPjTrBGmusI0
         FMKJ47CRfKemKG9yIsj6XdyxXUJVM2OSuUVk+yvU=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: remove unnecessary condition in btrfs_clone() to avoid too much nesting
Date:   Tue,  2 Jul 2019 15:23:07 +0100
Message-Id: <20190702142307.3334-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The bulk of the work done when cloning extents, at ioctl.c:btrfs_clone(),
is done inside an if statement that checks if the found key has the type
BTRFS_EXTENT_DATA_KEY. That if statement is redundant however, because
btrfs_search_slot() always leaves us in a leaf slot that points to a key
that is always greater then or equals to the search key, and our search
key here has that type, and because we bail out before that if statement
if the key at the given leaf slot is greater then BTRFS_EXTENT_DATA_KEY.

Therefore just remove that if statement, not only because it is useless
but mostly because it increases the nesting/indentation level in this
function which is quite big and makes things a bit awkward whenever I need
to fix something that requires changing btrfs_clone() (and it has been
like that for many years already).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 276 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 131 insertions(+), 145 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 318dd64d9a4e..85498ca1de53 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3520,6 +3520,14 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 
 	while (1) {
 		u64 next_key_min_offset = key.offset + 1;
+		struct btrfs_file_extent_item *extent;
+		int type;
+		u32 size;
+		struct btrfs_key new_key;
+		u64 disko = 0, diskl = 0;
+		u64 datao = 0, datal = 0;
+		u8 comp;
+		u64 drop_start;
 
 		/*
 		 * note the key will change type as we walk through the
@@ -3560,169 +3568,147 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		    key.objectid != btrfs_ino(BTRFS_I(src)))
 			break;
 
-		if (key.type == BTRFS_EXTENT_DATA_KEY) {
-			struct btrfs_file_extent_item *extent;
-			int type;
-			u32 size;
-			struct btrfs_key new_key;
-			u64 disko = 0, diskl = 0;
-			u64 datao = 0, datal = 0;
-			u8 comp;
-			u64 drop_start;
-
-			extent = btrfs_item_ptr(leaf, slot,
-						struct btrfs_file_extent_item);
-			comp = btrfs_file_extent_compression(leaf, extent);
-			type = btrfs_file_extent_type(leaf, extent);
-			if (type == BTRFS_FILE_EXTENT_REG ||
-			    type == BTRFS_FILE_EXTENT_PREALLOC) {
-				disko = btrfs_file_extent_disk_bytenr(leaf,
-								      extent);
-				diskl = btrfs_file_extent_disk_num_bytes(leaf,
-								 extent);
-				datao = btrfs_file_extent_offset(leaf, extent);
-				datal = btrfs_file_extent_num_bytes(leaf,
-								    extent);
-			} else if (type == BTRFS_FILE_EXTENT_INLINE) {
-				/* take upper bound, may be compressed */
-				datal = btrfs_file_extent_ram_bytes(leaf,
-								    extent);
-			}
+		ASSERT(key.type == BTRFS_EXTENT_DATA_KEY);
 
-			/*
-			 * The first search might have left us at an extent
-			 * item that ends before our target range's start, can
-			 * happen if we have holes and NO_HOLES feature enabled.
-			 */
-			if (key.offset + datal <= off) {
-				path->slots[0]++;
-				goto process_slot;
-			} else if (key.offset >= off + len) {
-				break;
-			}
-			next_key_min_offset = key.offset + datal;
-			size = btrfs_item_size_nr(leaf, slot);
-			read_extent_buffer(leaf, buf,
-					   btrfs_item_ptr_offset(leaf, slot),
-					   size);
+		extent = btrfs_item_ptr(leaf, slot,
+					struct btrfs_file_extent_item);
+		comp = btrfs_file_extent_compression(leaf, extent);
+		type = btrfs_file_extent_type(leaf, extent);
+		if (type == BTRFS_FILE_EXTENT_REG ||
+		    type == BTRFS_FILE_EXTENT_PREALLOC) {
+			disko = btrfs_file_extent_disk_bytenr(leaf, extent);
+			diskl = btrfs_file_extent_disk_num_bytes(leaf, extent);
+			datao = btrfs_file_extent_offset(leaf, extent);
+			datal = btrfs_file_extent_num_bytes(leaf, extent);
+		} else if (type == BTRFS_FILE_EXTENT_INLINE) {
+			/* take upper bound, may be compressed */
+			datal = btrfs_file_extent_ram_bytes(leaf, extent);
+		}
 
-			btrfs_release_path(path);
-			path->leave_spinning = 0;
+		/*
+		 * The first search might have left us at an extent item that
+		 * ends before our target range's start, can happen if we have
+		 * holes and NO_HOLES feature enabled.
+		 */
+		if (key.offset + datal <= off) {
+			path->slots[0]++;
+			goto process_slot;
+		} else if (key.offset >= off + len) {
+			break;
+		}
+		next_key_min_offset = key.offset + datal;
+		size = btrfs_item_size_nr(leaf, slot);
+		read_extent_buffer(leaf, buf, btrfs_item_ptr_offset(leaf, slot),
+				   size);
 
-			memcpy(&new_key, &key, sizeof(new_key));
-			new_key.objectid = btrfs_ino(BTRFS_I(inode));
-			if (off <= key.offset)
-				new_key.offset = key.offset + destoff - off;
-			else
-				new_key.offset = destoff;
+		btrfs_release_path(path);
+		path->leave_spinning = 0;
+
+		memcpy(&new_key, &key, sizeof(new_key));
+		new_key.objectid = btrfs_ino(BTRFS_I(inode));
+		if (off <= key.offset)
+			new_key.offset = key.offset + destoff - off;
+		else
+			new_key.offset = destoff;
+
+		/*
+		 * Deal with a hole that doesn't have an extent item that
+		 * represents it (NO_HOLES feature enabled).
+		 * This hole is either in the middle of the cloning range or at
+		 * the beginning (fully overlaps it or partially overlaps it).
+		 */
+		if (new_key.offset != last_dest_end)
+			drop_start = last_dest_end;
+		else
+			drop_start = new_key.offset;
+
+		if (type == BTRFS_FILE_EXTENT_REG ||
+		    type == BTRFS_FILE_EXTENT_PREALLOC) {
+			struct btrfs_clone_extent_info clone_info;
 
 			/*
-			 * Deal with a hole that doesn't have an extent item
-			 * that represents it (NO_HOLES feature enabled).
-			 * This hole is either in the middle of the cloning
-			 * range or at the beginning (fully overlaps it or
-			 * partially overlaps it).
+			 *    a  | --- range to clone ---|  b
+			 * | ------------- extent ------------- |
 			 */
-			if (new_key.offset != last_dest_end)
-				drop_start = last_dest_end;
-			else
-				drop_start = new_key.offset;
-
-			if (type == BTRFS_FILE_EXTENT_REG ||
-			    type == BTRFS_FILE_EXTENT_PREALLOC) {
-				struct btrfs_clone_extent_info clone_info;
-
-				/*
-				 *    a  | --- range to clone ---|  b
-				 * | ------------- extent ------------- |
-				 */
-
-				/* subtract range b */
-				if (key.offset + datal > off + len)
-					datal = off + len - key.offset;
-
-				/* subtract range a */
-				if (off > key.offset) {
-					datao += off - key.offset;
-					datal -= off - key.offset;
-				}
 
-				clone_info.disk_offset = disko;
-				clone_info.disk_len = diskl;
-				clone_info.data_offset = datao;
-				clone_info.data_len = datal;
-				clone_info.file_offset = new_key.offset;
-				clone_info.extent_buf = buf;
-				clone_info.item_size = size;
-				ret = btrfs_punch_hole_range(inode, path,
+			/* subtract range b */
+			if (key.offset + datal > off + len)
+				datal = off + len - key.offset;
+
+			/* subtract range a */
+			if (off > key.offset) {
+				datao += off - key.offset;
+				datal -= off - key.offset;
+			}
+
+			clone_info.disk_offset = disko;
+			clone_info.disk_len = diskl;
+			clone_info.data_offset = datao;
+			clone_info.data_len = datal;
+			clone_info.file_offset = new_key.offset;
+			clone_info.extent_buf = buf;
+			clone_info.item_size = size;
+			ret = btrfs_punch_hole_range(inode, path,
 						     drop_start,
 						     new_key.offset + datal - 1,
 						     &clone_info, &trans);
-				if (ret)
-					goto out;
-			} else if (type == BTRFS_FILE_EXTENT_INLINE) {
-				u64 skip = 0;
-				u64 trim = 0;
-
-				if (off > key.offset) {
-					skip = off - key.offset;
-					new_key.offset += skip;
-				}
+			if (ret)
+				goto out;
+		} else if (type == BTRFS_FILE_EXTENT_INLINE) {
+			u64 skip = 0;
+			u64 trim = 0;
 
-				if (key.offset + datal > off + len)
-					trim = key.offset + datal - (off + len);
+			if (off > key.offset) {
+				skip = off - key.offset;
+				new_key.offset += skip;
+			}
 
-				if (comp && (skip || trim)) {
-					ret = -EINVAL;
-					goto out;
-				}
-				size -= skip + trim;
-				datal -= skip + trim;
-
-				/*
-				 * If our extent is inline, we know we will drop
-				 * or adjust at most 1 extent item in the
-				 * destination root.
-				 *
-				 * 1 - adjusting old extent (we may have to
-				 *     split it)
-				 * 1 - add new extent
-				 * 1 - inode update
-				 */
-				trans = btrfs_start_transaction(root, 3);
-				if (IS_ERR(trans)) {
-					ret = PTR_ERR(trans);
-					goto out;
-				}
+			if (key.offset + datal > off + len)
+				trim = key.offset + datal - (off + len);
 
-				ret = clone_copy_inline_extent(inode,
-							       trans, path,
-							       &new_key,
-							       drop_start,
-							       datal,
-							       skip, size, buf);
-				if (ret) {
-					if (ret != -EOPNOTSUPP)
-						btrfs_abort_transaction(trans,
-									ret);
-					btrfs_end_transaction(trans);
-					goto out;
-				}
+			if (comp && (skip || trim)) {
+				ret = -EINVAL;
+				goto out;
 			}
+			size -= skip + trim;
+			datal -= skip + trim;
 
-			btrfs_release_path(path);
+			/*
+			 * If our extent is inline, we know we will drop or
+			 * adjust at most 1 extent item in the destination root.
+			 *
+			 * 1 - adjusting old extent (we may have to split it)
+			 * 1 - add new extent
+			 * 1 - inode update
+			 */
+			trans = btrfs_start_transaction(root, 3);
+			if (IS_ERR(trans)) {
+				ret = PTR_ERR(trans);
+				goto out;
+			}
 
-			last_dest_end = ALIGN(new_key.offset + datal,
-					      fs_info->sectorsize);
-			ret = clone_finish_inode_update(trans, inode,
-							last_dest_end,
-							destoff, olen,
-							no_time_update);
-			if (ret)
+			ret = clone_copy_inline_extent(inode, trans, path,
+						       &new_key, drop_start,
+						       datal, skip, size, buf);
+			if (ret) {
+				if (ret != -EOPNOTSUPP)
+					btrfs_abort_transaction(trans, ret);
+				btrfs_end_transaction(trans);
 				goto out;
-			if (new_key.offset + datal >= destoff + len)
-				break;
+			}
 		}
+
+		btrfs_release_path(path);
+
+		last_dest_end = ALIGN(new_key.offset + datal,
+				      fs_info->sectorsize);
+		ret = clone_finish_inode_update(trans, inode, last_dest_end,
+						destoff, olen, no_time_update);
+		if (ret)
+			goto out;
+		if (new_key.offset + datal >= destoff + len)
+			break;
+
 		btrfs_release_path(path);
 		key.offset = next_key_min_offset;
 
-- 
2.11.0

