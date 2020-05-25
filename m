Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528871E0716
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbgEYGe1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:34:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:33598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388487AbgEYGe1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:34:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2FFACAB87;
        Mon, 25 May 2020 06:34:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 25/30] fs: btrfs: Implement btrfs_file_read()
Date:   Mon, 25 May 2020 14:32:52 +0800
Message-Id: <20200525063257.46757-26-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This version of btrfs_file_read() will have the following new features:
- Try all mirrors
- More hanlding on unaligned size
- Better compressed extent handling
  The old implementation doesn't handle compressed extent with offset
  properly.
  As we need to read out the whole compressed extent, then decompress
  the whole extent, then only copy the referred part.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.c |  48 +++++++++-------
 fs/btrfs/btrfs.h |   2 +
 fs/btrfs/inode.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 7eb01c4ff9b5..ffd96427ccdc 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -253,37 +253,45 @@ out:
 int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 	       loff_t *actread)
 {
-	struct __btrfs_root root = btrfs_info.fs_root;
-	struct btrfs_inode_item inode;
-	u64 inr, rd;
+	struct btrfs_fs_info *fs_info = current_fs_info;
+	struct btrfs_root *root;
+	loff_t real_size;
+	u64 ino;
 	u8 type;
+	int ret;
 
-	inr = __btrfs_lookup_path(&root, root.root_dirid, file, &type, &inode,
-				40);
-
-	if (inr == -1ULL) {
-		printf("Cannot lookup file %s\n", file);
-		return -1;
+	ASSERT(fs_info);
+	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
+				file, &root, &ino, &type, 40);
+	if (ret < 0) {
+		error("Cannot lookup file %s", file);
+		return ret;
 	}
 
 	if (type != BTRFS_FT_REG_FILE) {
-		printf("Not a regular file: %s\n", file);
-		return -1;
+		error("Not a regular file: %s", file);
+		return -EINVAL;
 	}
 
-	if (!len)
-		len = inode.size;
+	if (!len) {
+		ret = btrfs_size(file, &real_size);
+		if (ret < 0) {
+			error("Failed to get inode size: %s", file);
+			return ret;
+		}
+		len = real_size;
+	}
 
-	if (len > inode.size - offset)
-		len = inode.size - offset;
+	if (len > real_size - offset)
+		len = real_size - offset;
 
-	rd = __btrfs_file_read(&root, inr, offset, len, buf);
-	if (rd == -1ULL) {
-		printf("An error occured while reading file %s\n", file);
-		return -1;
+	ret = btrfs_file_read(root, ino, offset, len, buf);
+	if (ret < 0) {
+		error("An error occured while reading file %s", file);
+		return ret;
 	}
 
-	*actread = rd;
+	*actread = len;
 	return 0;
 }
 
diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index 32ea2fc53aa5..268ca077d96a 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -59,6 +59,8 @@ int btrfs_readlink(struct btrfs_root *root, u64 ino, char *target);
 u64 __btrfs_lookup_path(struct __btrfs_root *, u64, const char *, u8 *,
 		       struct btrfs_inode_item *, int);
 u64 __btrfs_file_read(const struct __btrfs_root *, u64, u64, u64, char *);
+int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
+		    char *dest);
 
 /* subvolume.c */
 u64 btrfs_get_default_subvol_objectid(void);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9a1b1d265bdd..f671e86c1f91 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -920,3 +920,149 @@ check_next:
 	*next_offset = key.offset;
 	return 1;
 }
+
+static int read_and_truncate_page(struct btrfs_path *path,
+				  struct btrfs_file_extent_item *fi,
+				  int start, int len, char *dest)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	u64 aligned_start = round_down(start, fs_info->sectorsize);
+	u8 extent_type;
+	char *buf;
+	int page_off = start - aligned_start;
+	int page_len = fs_info->sectorsize - page_off;
+	int ret;
+
+	ASSERT(start + len <= aligned_start + fs_info->sectorsize);
+	buf = malloc_cache_aligned(fs_info->sectorsize);
+	if (!buf)
+		return -ENOMEM;
+
+	extent_type = btrfs_file_extent_type(leaf, fi);
+	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
+		ret = btrfs_read_extent_inline(path, fi, buf);
+		memcpy(dest, buf + page_off, min(page_len, ret));
+		free(buf);
+		return len;
+	}
+
+	ret = btrfs_read_extent_reg(path, fi,
+			round_down(start, fs_info->sectorsize),
+			fs_info->sectorsize, buf);
+	if (ret < 0) {
+		free(buf);
+		return ret;
+	}
+	memcpy(dest, buf + page_off, page_len);
+	free(buf);
+	return len;
+}
+
+int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
+		    char *dest)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_file_extent_item *fi;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	u64 aligned_start = round_down(file_offset, fs_info->sectorsize);
+	u64 aligned_end = round_down(file_offset + len, fs_info->sectorsize);
+	u64 next_offset;
+	u64 cur = aligned_start;
+	int ret = 0;
+
+	btrfs_init_path(&path);
+
+	/* Set the whole dest all zero, so we won't need to bother holes */
+	memset(dest, 0, len);
+
+	/* Read out the leading unaligned part */
+	if (aligned_start != file_offset) {
+		ret = lookup_data_extent(root, &path, ino, aligned_start,
+					 &next_offset); 
+		if (ret < 0)
+			goto out;
+		if (ret == 0) {
+			/* Read the unaligned part out*/
+			fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
+					struct btrfs_file_extent_item);
+			ret = read_and_truncate_page(&path, fi, file_offset,
+					round_up(file_offset, fs_info->sectorsize) -
+					file_offset, dest);
+			if (ret < 0)
+				goto out;
+			cur += fs_info->sectorsize;
+		} else {
+			/* The whole file is a hole */
+			if (!next_offset) {
+				memset(dest, 0, len);
+				return len;
+			}
+			cur = next_offset;
+		}
+	}
+
+	/* Read the aligned part */
+	while (cur < aligned_end) {
+		u64 extent_num_bytes;
+		u8 type;
+
+		btrfs_release_path(&path);
+		ret = lookup_data_extent(root, &path, ino, cur, &next_offset);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			/* No next, direct exit */
+			if (!next_offset) {
+				ret = 0;
+				goto out;
+			}
+		}
+		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				    struct btrfs_file_extent_item);
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		type = btrfs_file_extent_type(path.nodes[0], fi);
+		if (type == BTRFS_FILE_EXTENT_INLINE) {
+			ret = btrfs_read_extent_inline(&path, fi, dest);
+			goto out;
+		}
+		/* Skip holes, as we have zeroed the dest */
+		if (type == BTRFS_FILE_EXTENT_PREALLOC ||
+		    btrfs_file_extent_disk_bytenr(path.nodes[0], fi) == 0) {
+			cur = key.offset + btrfs_file_extent_num_bytes(
+					path.nodes[0], fi);
+			continue;
+		}
+
+		/* Read the remaining part of the extent */
+		extent_num_bytes = btrfs_file_extent_num_bytes(path.nodes[0],
+							       fi);
+		ret = btrfs_read_extent_reg(&path, fi, cur,
+				min(extent_num_bytes, aligned_end - cur),
+				dest + cur - file_offset);
+		if (ret < 0)
+			goto out;
+		cur += min(extent_num_bytes, aligned_end - cur);
+	}
+
+	/* Read the tailing unaligned part*/
+	if (file_offset + len != aligned_end) {
+		btrfs_release_path(&path);
+		ret = lookup_data_extent(root, &path, ino, aligned_end,
+					 &next_offset);
+		/* <0 is error, >0 means no extent */
+		if (ret)
+			goto out;
+		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				    struct btrfs_file_extent_item);
+		ret = read_and_truncate_page(&path, fi, aligned_end,
+				file_offset + len - aligned_end,
+				dest + aligned_end - file_offset);
+	}
+out:
+	btrfs_release_path(&path);
+	if (ret < 0)
+		return ret;
+	return len;
+}
-- 
2.26.2

