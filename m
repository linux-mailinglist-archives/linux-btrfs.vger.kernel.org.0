Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0FB592E58
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiHOLp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiHOLp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 07:45:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10490BC24
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 04:45:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A99F2352B4;
        Mon, 15 Aug 2022 11:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660563953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtsbuhFwz7WFmf8gcu+PGCBqvgCXA/IgHM6zeZu4TYE=;
        b=VrJ2MaG7knqSJ/YPZSP9XFlumQo31Gs4bMFO1er5qkIZfQR42iPA1Qfe2sdscIHwkX29mE
        ilM3rDQMm4Q9/tW+gHDLvBEOsGkYucIpdrort6PKEDIxR+Mi6P2m2nJ/RVQ0hBKvhvhqCL
        DmofbFNMXvyyTUvWFcU2mmecR3g4WGs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 192F813A93;
        Mon, 15 Aug 2022 11:45:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KFk2NO4x+mLsGAAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 15 Aug 2022 11:45:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH v3 4/8] fs: btrfs: move the unaligned read code to _fs_read() for btrfs
Date:   Mon, 15 Aug 2022 19:45:15 +0800
Message-Id: <8b83e5e0f1d2bd7c02714de4cd26dc24327604c6.1660563403.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660563403.git.wqu@suse.com>
References: <cover.1660563403.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike FUSE or kernel, U-boot filesystem code makes the underly fs code
to handle the unaligned read (aka, read range is not aligned to fs block
size).

This makes underlying fs code harder to implement, as  they have to handle
unaligned read all by themselves.

This patch will change the behavior, starting from btrfs, by moving the
unaligned read code into _fs_read().

The idea is pretty simple, if we have an unaligned read request, we
handle it in the following steps:

1. Grab the blocksize of the fs

2. Read the leading unaligned range
   We will read the block that @offset is in, and copy the
   requested part into buf.

   The the block we read covers the whole range, we just call it a day.

3. Read the remaining part
   The tailing part may be unaligned, but all fses handles the tailing
   part much easier than the leading unaligned part.

   As they just need to do a min(extent_size, start + len - cur) to
   calculate the real read size.

   In fact, for most file reading, the file size is not aligned and we
   need to handle the tailing part anyway.

There is a btrfs specific cleanup involved:

- In btrfs_file_read(), merge the tailing unaligned read into the main
  loop.
  Just reuse the existing read length calculation is enough.

- Remove read_and_truncate_page() call
  Since there is no explicit leading/tailing unaligned read anymore.

This has been tested with a proper randomly populated btrfs file, then
tried in sandbox mode with different aligned and unaligned range and
compare the output with md5sum.

Cc: Marek Behun <marek.behun@nic.cz>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.c |  10 ++++
 fs/btrfs/inode.c |  89 +++-----------------------------
 fs/fs.c          | 130 ++++++++++++++++++++++++++++++++++++++++++++---
 include/btrfs.h  |   1 +
 4 files changed, 141 insertions(+), 89 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 74a992fa012d..ac0e972d0249 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -234,6 +234,10 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 	int ret;
 
 	ASSERT(fs_info);
+
+	/* Higher layer has ensures it never pass unaligned offset in. */
+	ASSERT(IS_ALIGNED(offset, fs_info->sectorsize));
+
 	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
 				file, &root, &ino, &type, 40);
 	if (ret < 0) {
@@ -275,6 +279,12 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 	return 0;
 }
 
+int btrfs_get_blocksize(const char *filename)
+{
+	ASSERT(current_fs_info);
+	return current_fs_info->sectorsize;
+}
+
 void btrfs_close(void)
 {
 	if (current_fs_info) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 40025662f250..f12be46f6262 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -617,44 +617,6 @@ check_next:
 	return 1;
 }
 
-static int read_and_truncate_page(struct btrfs_path *path,
-				  struct btrfs_file_extent_item *fi,
-				  int start, int len, char *dest)
-{
-	struct extent_buffer *leaf = path->nodes[0];
-	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	u64 aligned_start = round_down(start, fs_info->sectorsize);
-	u8 extent_type;
-	char *buf;
-	int page_off = start - aligned_start;
-	int page_len = fs_info->sectorsize - page_off;
-	int ret;
-
-	ASSERT(start + len <= aligned_start + fs_info->sectorsize);
-	buf = malloc_cache_aligned(fs_info->sectorsize);
-	if (!buf)
-		return -ENOMEM;
-
-	extent_type = btrfs_file_extent_type(leaf, fi);
-	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-		ret = btrfs_read_extent_inline(path, fi, buf);
-		memcpy(dest, buf + page_off, min(page_len, ret));
-		free(buf);
-		return len;
-	}
-
-	ret = btrfs_read_extent_reg(path, fi,
-			round_down(start, fs_info->sectorsize),
-			fs_info->sectorsize, buf);
-	if (ret < 0) {
-		free(buf);
-		return ret;
-	}
-	memcpy(dest, buf + page_off, page_len);
-	free(buf);
-	return len;
-}
-
 int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
 		    char *dest)
 {
@@ -663,7 +625,6 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
 	struct btrfs_path path;
 	struct btrfs_key key;
 	u64 aligned_start = round_down(file_offset, fs_info->sectorsize);
-	u64 aligned_end = round_down(file_offset + len, fs_info->sectorsize);
 	u64 next_offset;
 	u64 cur = aligned_start;
 	int ret = 0;
@@ -673,34 +634,14 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
 	/* Set the whole dest all zero, so we won't need to bother holes */
 	memset(dest, 0, len);
 
-	/* Read out the leading unaligned part */
-	if (aligned_start != file_offset) {
-		ret = lookup_data_extent(root, &path, ino, aligned_start,
-					 &next_offset);
-		if (ret < 0)
-			goto out;
-		if (ret == 0) {
-			/* Read the unaligned part out*/
-			fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
-					struct btrfs_file_extent_item);
-			ret = read_and_truncate_page(&path, fi, file_offset,
-					round_up(file_offset, fs_info->sectorsize) -
-					file_offset, dest);
-			if (ret < 0)
-				goto out;
-			cur += fs_info->sectorsize;
-		} else {
-			/* The whole file is a hole */
-			if (!next_offset) {
-				memset(dest, 0, len);
-				return len;
-			}
-			cur = next_offset;
-		}
-	}
+	/*
+	 * Ensured by higher layer, which should have already handled the
+	 * first unaligned sector.
+	 */
+	ASSERT(aligned_start == file_offset);
 
 	/* Read the aligned part */
-	while (cur < aligned_end) {
+	while (cur < file_offset + len) {
 		u64 extent_num_bytes;
 		u8 type;
 
@@ -743,27 +684,13 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
 		extent_num_bytes = btrfs_file_extent_num_bytes(path.nodes[0],
 							       fi);
 		ret = btrfs_read_extent_reg(&path, fi, cur,
-				min(extent_num_bytes, aligned_end - cur),
+				min(extent_num_bytes, file_offset + len - cur),
 				dest + cur - file_offset);
 		if (ret < 0)
 			goto out;
-		cur += min(extent_num_bytes, aligned_end - cur);
+		cur += min(extent_num_bytes, file_offset + len - cur);
 	}
 
-	/* Read the tailing unaligned part*/
-	if (file_offset + len != aligned_end) {
-		btrfs_release_path(&path);
-		ret = lookup_data_extent(root, &path, ino, aligned_end,
-					 &next_offset);
-		/* <0 is error, >0 means no extent */
-		if (ret)
-			goto out;
-		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
-				    struct btrfs_file_extent_item);
-		ret = read_and_truncate_page(&path, fi, aligned_end,
-				file_offset + len - aligned_end,
-				dest + aligned_end - file_offset);
-	}
 out:
 	btrfs_release_path(&path);
 	if (ret < 0)
diff --git a/fs/fs.c b/fs/fs.c
index 8324b4a22f20..6d43d616de4b 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -29,6 +29,7 @@
 #include <efi_loader.h>
 #include <squashfs.h>
 #include <erofs.h>
+#include <memalign.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -140,6 +141,11 @@ static inline int fs_mkdir_unsupported(const char *dirname)
 	return -1;
 }
 
+static inline int fs_get_blocksize_unsupported(const char *filename)
+{
+	return -1;
+}
+
 struct fstype_info {
 	int fstype;
 	char *name;
@@ -159,6 +165,14 @@ struct fstype_info {
 	int (*size)(const char *filename, loff_t *size);
 	int (*read)(const char *filename, void *buf, loff_t offset,
 		    loff_t len, loff_t *actread);
+	/*
+	 * Report the minimal data blocksize the fs supprts.
+	 *
+	 * This is used to handle unaligned read offset.
+	 * If not supported, read() will handle the unaligned offset all by
+	 * itself.
+	 */
+	int (*get_blocksize)(const char *filename);
 	int (*write)(const char *filename, void *buf, loff_t offset,
 		     loff_t len, loff_t *actwrite);
 	void (*close)(void);
@@ -194,6 +208,7 @@ static struct fstype_info fstypes[] = {
 		.exists = fat_exists,
 		.size = fat_size,
 		.read = fat_read_file,
+		.get_blocksize = fs_get_blocksize_unsupported,
 #if CONFIG_IS_ENABLED(FAT_WRITE)
 		.write = file_fat_write,
 		.unlink = fat_unlink,
@@ -222,6 +237,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ext4fs_exists,
 		.size = ext4fs_size,
 		.read = ext4_read_file,
+		.get_blocksize = fs_get_blocksize_unsupported,
 #ifdef CONFIG_CMD_EXT4_WRITE
 		.write = ext4_write_file,
 		.ln = ext4fs_create_link,
@@ -246,6 +262,11 @@ static struct fstype_info fstypes[] = {
 		.exists = sandbox_fs_exists,
 		.size = sandbox_fs_size,
 		.read = fs_read_sandbox,
+		/*
+		 * Sandbox doesn't need to bother blocksize, as its
+		 * os_read() can handle unaligned range without any problem.
+		 */
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.write = fs_write_sandbox,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
@@ -265,6 +286,12 @@ static struct fstype_info fstypes[] = {
 		.exists = fs_exists_unsupported,
 		.size = smh_fs_size,
 		.read = smh_fs_read,
+		/*
+		 * Semihost doesn't need to bother blocksize, as it is using
+		 * read() system calls, and can handle unaligned range without
+		 * any problem.
+		 */
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.write = smh_fs_write,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
@@ -285,6 +312,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ubifs_exists,
 		.size = ubifs_size,
 		.read = ubifs_read,
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.write = fs_write_unsupported,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
@@ -306,6 +334,7 @@ static struct fstype_info fstypes[] = {
 		.exists = btrfs_exists,
 		.size = btrfs_size,
 		.read = btrfs_read,
+		.get_blocksize = btrfs_get_blocksize,
 		.write = fs_write_unsupported,
 		.uuid = btrfs_uuid,
 		.opendir = fs_opendir_unsupported,
@@ -325,6 +354,7 @@ static struct fstype_info fstypes[] = {
 		.readdir = sqfs_readdir,
 		.ls = fs_ls_generic,
 		.read = sqfs_read,
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.size = sqfs_size,
 		.close = sqfs_close,
 		.closedir = sqfs_closedir,
@@ -346,6 +376,7 @@ static struct fstype_info fstypes[] = {
 		.readdir = erofs_readdir,
 		.ls = fs_ls_generic,
 		.read = erofs_read,
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.size = erofs_size,
 		.close = erofs_close,
 		.closedir = erofs_closedir,
@@ -367,6 +398,7 @@ static struct fstype_info fstypes[] = {
 		.exists = fs_exists_unsupported,
 		.size = fs_size_unsupported,
 		.read = fs_read_unsupported,
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.write = fs_write_unsupported,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
@@ -580,7 +612,11 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 {
 	struct fstype_info *info = fs_get_info(fs_type);
 	void *buf;
+	int blocksize;
 	int ret;
+	loff_t cur = offset;
+	loff_t bytes_read = 0;
+	loff_t total_read = 0;
 
 #ifdef CONFIG_LMB
 	if (do_lmb_check) {
@@ -590,19 +626,97 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 	}
 #endif
 
+	blocksize = info->get_blocksize(filename);
 	/*
-	 * We don't actually know how many bytes are being read, since len==0
-	 * means read the whole file.
+	 * The fs doesn't report its blocksize, let its read() to handle
+	 * the unaligned read.
+	 */
+	if (blocksize < 0) {
+		buf = map_sysmem(addr, len);
+		ret = info->read(filename, buf, offset, len, &total_read);
+
+		/* If we requested a specific number of bytes, check we got it */
+		if (ret == 0 && len && total_read != len)
+			log_debug("** %s shorter than offset + len **\n", filename);
+		goto out;
+	}
+
+	if (unlikely(blocksize == 0)) {
+		log_err("invalid blocksize 0 found\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * @len can be 0, meaning read the whole file.
+	 * And we can not rely on info->size(), as some fses doesn't resolve
+	 * softlinks to their final destinations.
 	 */
 	buf = map_sysmem(addr, len);
-	ret = info->read(filename, buf, offset, len, actread);
-	unmap_sysmem(buf);
 
-	/* If we requested a specific number of bytes, check we got it */
-	if (ret == 0 && len && *actread != len)
-		log_debug("** %s shorter than offset + len **\n", filename);
-	fs_close();
+	/* Unaligned read offset, handle the unaligned read here. */
+	if (!IS_ALIGNED(offset, blocksize)) {
+		void *block_buf;
+		const int offset_in_block = offset & (blocksize - 1);
+		int copy_len;
+
+		block_buf = malloc_cache_aligned(blocksize);
+		if (!block_buf) {
+			log_err("** Unable to alloc memory for one block **\n");
+			return -ENOMEM;
+		}
+		memset(block_buf, 0, blocksize);
+
+		cur = round_down(offset, blocksize);
+		ret = info->read(filename, block_buf, cur, blocksize,
+				 &bytes_read);
+		if (ret < 0) {
+			log_err("** Failed to read %s at offset %llu, %d **\n",
+				filename, cur, ret);
+			free(block_buf);
+			goto out;
+		}
+		if (bytes_read <= offset_in_block) {
+			log_err("** Offset %llu is beyond file size of %s **\n",
+				offset, filename);
+			free(block_buf);
+			ret = -EIO;
+			goto out;
+		}
+
+		copy_len = min_t(int, blocksize, bytes_read) - offset_in_block;
+		memcpy(buf, block_buf + offset_in_block, copy_len);
+		free(block_buf);
+		total_read += copy_len;
+
+		/*
+		 * A short read on the block, or we have already covered the
+		 * whole read range, just call it a day.
+		 */
+		if (bytes_read < blocksize ||
+		    (len && offset + len <= cur + blocksize))
+			goto out;
+
+		cur += blocksize;
+		if (len)
+			len -= copy_len;
+	}
+
+	ret = info->read(filename, buf + total_read, cur, len, &bytes_read);
+	if (ret < 0) {
+		log_err("** failed to read %s off %llu len %llu, %d **\n",
+			filename, cur, len, ret);
+		goto out;
+	}
+	if (len && bytes_read < len)
+		log_debug("** %s short read, off %llu len %llu actual read %llu **\n",
+			  filename, cur, len, bytes_read);
+	total_read += bytes_read;
 
+out:
+	unmap_sysmem(buf);
+	fs_close();
+	if (!ret)
+		*actread = total_read;
 	return ret;
 }
 
diff --git a/include/btrfs.h b/include/btrfs.h
index 2d73add18e09..a2d709273b53 100644
--- a/include/btrfs.h
+++ b/include/btrfs.h
@@ -17,6 +17,7 @@ int btrfs_ls(const char *);
 int btrfs_exists(const char *);
 int btrfs_size(const char *, loff_t *);
 int btrfs_read(const char *, void *, loff_t, loff_t, loff_t *);
+int btrfs_get_blocksize(const char *);
 void btrfs_close(void);
 int btrfs_uuid(char *);
 void btrfs_list_subvols(void);
-- 
2.37.1

