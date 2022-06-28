Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9430955E102
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbiF1H2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbiF1H2l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 03:28:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467EB2CDF4
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 00:28:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECB8A1FB43;
        Tue, 28 Jun 2022 07:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656401317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lciM0Uq4yHHDYLbiqI8NtBbhqyJn6XWRVSoApyOMBwI=;
        b=HSK8JFCErNtlvp65reIfXsSx90um0lRoqSm/A9lBza06EpYWsIoJruveNHNpftvaVtZDgp
        yTqIddYAm1ZJqcsJZjntCrIXBSmB5unp6pukfHjApDgzQHllK9CjNpdY9NGE7taK/KxZUH
        VBYtti39jxAM4X5paGIEXzkMaLCO+PY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E0DE139E9;
        Tue, 28 Jun 2022 07:28:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aL4mEqOtumJzFQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     marek.behun@nic.cz, linux-btrfs@vger.kernel.org,
        jnhuang95@gmail.com, linux-erofs@lists.ozlabs.org,
        trini@konsulko.com, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH RFC 3/8] fs: btrfs: move the unaligned read code to _fs_read() for btrfs
Date:   Tue, 28 Jun 2022 15:28:03 +0800
Message-Id: <6457085680bdb180d6d0909d5bc507fa88082421.1656401086.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656401086.git.wqu@suse.com>
References: <cover.1656401086.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike FUSE or kernel, U-boot filesystem code makes the underly fs code
to handle the unaligned read (aka, read range is not aligned to fs block
size).

This makes underlying fs code harder to implement, as unlike FUSE/kernel
code, now they have to handle unaligned read all by themselves.

This patch will change the behavior, starting from btrfs, by moving the
unaligned read code into _fs_read().

The idea is pretty simple, if we have an unaligned read request, we
handle it in the following steps:

1. Grab the blocksize of the fs

2. Read the leading unaligned range
   We will read the block that @offset is in, and copy the
   requested part into buf.

   The the block we read covers the whole range, we just call it a day.

3. Read the aligned part

4. Read the tailing unaligned range
   Pretty much the same as the leading unaligned range, just read the
   whole block where @offset + @len is, then copy the requested range
   in the buffer.

This has been tested with a proper randomly populated btrfs file, then
tried in sandbox mode with different aligned and unaligned range and
compare the output with md5sum.

Cc: Marek Behun <marek.behun@nic.cz>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.c |  24 ++++----
 fs/btrfs/inode.c |  84 ++-------------------------
 fs/fs.c          | 148 +++++++++++++++++++++++++++++++++++++++++++++--
 include/btrfs.h  |   1 +
 4 files changed, 160 insertions(+), 97 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 741c6e20f533..f9a67468d508 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -223,17 +223,27 @@ out:
 	return ret;
 }
 
+int btrfs_get_blocksize(const char *filename)
+{
+	struct btrfs_fs_info *fs_info = current_fs_info;
+
+	return fs_info->sectorsize;
+}
+
 int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 	       loff_t *actread)
 {
 	struct btrfs_fs_info *fs_info = current_fs_info;
 	struct btrfs_root *root;
-	loff_t real_size = 0;
 	u64 ino;
 	u8 type;
 	int ret;
 
 	ASSERT(fs_info);
+
+	/* Higher layer should always pass correct @len in. */
+	ASSERT(len);
+
 	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
 				file, &root, &ino, &type, 40);
 	if (ret < 0) {
@@ -246,18 +256,6 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 		return -EINVAL;
 	}
 
-	if (!len) {
-		ret = btrfs_size(file, &real_size);
-		if (ret < 0) {
-			error("Failed to get inode size: %s", file);
-			return ret;
-		}
-		len = real_size;
-	}
-
-	if (len > real_size - offset)
-		len = real_size - offset;
-
 	ret = btrfs_file_read(root, ino, offset, len, buf);
 	if (ret < 0) {
 		error("An error occurred while reading file %s", file);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d00b5153336d..5615143fab82 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -620,44 +620,6 @@ check_next:
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
@@ -676,31 +638,12 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
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
+	 * Higher layer should ensure the offset/len is already sectorsize
+	 * aligned.
+	 */
+	ASSERT(IS_ALIGNED(file_offset, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(len, fs_info->sectorsize));
 
 	/* Read the aligned part */
 	while (cur < aligned_end) {
@@ -752,21 +695,6 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
 			goto out;
 		cur += min(extent_num_bytes, aligned_end - cur);
 	}
-
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
index d992cdd6d650..30696ac6c1a3 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -25,9 +25,11 @@
 #include <asm/io.h>
 #include <div64.h>
 #include <linux/math64.h>
+#include <linux/kernel.h>
 #include <efi_loader.h>
 #include <squashfs.h>
 #include <erofs.h>
+#include <memalign.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -139,6 +141,11 @@ static inline int fs_mkdir_unsupported(const char *dirname)
 	return -1;
 }
 
+static inline int fs_get_blocksize_unsupported(const char *filename)
+{
+	return 0;
+}
+
 struct fstype_info {
 	int fstype;
 	char *name;
@@ -156,6 +163,13 @@ struct fstype_info {
 	int (*ls)(const char *dirname);
 	int (*exists)(const char *filename);
 	int (*size)(const char *filename, loff_t *size);
+	/*
+	 * Get the minimal unit of data IO.
+	 * If implemented, U-boot generic fs code will handle the unaligned
+	 * read, and the underlying code will only need to bother fully aligned
+	 * read.
+	 */
+	int (*get_blocksize)(const char *filename);
 	int (*read)(const char *filename, void *buf, loff_t offset,
 		    loff_t len, loff_t *actread);
 	int (*write)(const char *filename, void *buf, loff_t offset,
@@ -193,6 +207,7 @@ static struct fstype_info fstypes[] = {
 		.exists = fat_exists,
 		.size = fat_size,
 		.read = fat_read_file,
+		.get_blocksize = fs_get_blocksize_unsupported,
 #if CONFIG_IS_ENABLED(FAT_WRITE)
 		.write = file_fat_write,
 		.unlink = fat_unlink,
@@ -221,6 +236,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ext4fs_exists,
 		.size = ext4fs_size,
 		.read = ext4_read_file,
+		.get_blocksize = fs_get_blocksize_unsupported,
 #ifdef CONFIG_CMD_EXT4_WRITE
 		.write = ext4_write_file,
 		.ln = ext4fs_create_link,
@@ -245,6 +261,7 @@ static struct fstype_info fstypes[] = {
 		.exists = sandbox_fs_exists,
 		.size = sandbox_fs_size,
 		.read = fs_read_sandbox,
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.write = fs_write_sandbox,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
@@ -264,6 +281,7 @@ static struct fstype_info fstypes[] = {
 		.exists = fs_exists_unsupported,
 		.size = smh_fs_size,
 		.read = smh_fs_read,
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.write = smh_fs_write,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
@@ -284,6 +302,7 @@ static struct fstype_info fstypes[] = {
 		.exists = ubifs_exists,
 		.size = ubifs_size,
 		.read = ubifs_read,
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.write = fs_write_unsupported,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
@@ -305,6 +324,7 @@ static struct fstype_info fstypes[] = {
 		.exists = btrfs_exists,
 		.size = btrfs_size,
 		.read = btrfs_read,
+		.get_blocksize = btrfs_get_blocksize,
 		.write = fs_write_unsupported,
 		.uuid = btrfs_uuid,
 		.opendir = fs_opendir_unsupported,
@@ -324,6 +344,7 @@ static struct fstype_info fstypes[] = {
 		.readdir = sqfs_readdir,
 		.ls = fs_ls_generic,
 		.read = sqfs_read,
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.size = sqfs_size,
 		.close = sqfs_close,
 		.closedir = sqfs_closedir,
@@ -345,6 +366,7 @@ static struct fstype_info fstypes[] = {
 		.readdir = erofs_readdir,
 		.ls = fs_ls_generic,
 		.read = erofs_read,
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.size = erofs_size,
 		.close = erofs_close,
 		.closedir = erofs_closedir,
@@ -366,6 +388,7 @@ static struct fstype_info fstypes[] = {
 		.exists = fs_exists_unsupported,
 		.size = fs_size_unsupported,
 		.read = fs_read_unsupported,
+		.get_blocksize = fs_get_blocksize_unsupported,
 		.write = fs_write_unsupported,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
@@ -578,8 +601,15 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 		    int do_lmb_check, loff_t *actread)
 {
 	struct fstype_info *info = fs_get_info(fs_type);
+	/* Buffer for the unalgiend read. */
+	void *block_buffer;
 	void *buf;
 	loff_t file_size;
+	loff_t real_start = offset;
+	loff_t real_len = len;
+	loff_t bytes_read = 0;
+	loff_t total_read = 0;
+	int blocksize;
 	int ret;
 
 #ifdef CONFIG_LMB
@@ -610,15 +640,121 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 				 len, file_size, file_size);
 		len = file_size - offset;
 	}
+	blocksize = info->get_blocksize(filename);
+	if (blocksize < 0) {
+		log_err("** Unable to get blocksize, %d **\n", blocksize);
+		return blocksize;
+	}
+
+	/*
+	 * The fs doesn't yet report its blocksize, then let the read()
+	 * call to handle it
+	 *
+	 * This should be deleted when all fs support blocksize reporting.
+	 */
+	if (blocksize == 0) {
+		buf = map_sysmem(addr, len);
+		ret = info->read(filename, buf, offset, len, actread);
+		unmap_sysmem(buf);
+		if (*actread < len)
+			log_debug(
+		"** %s short read, off %llu len %llu actual read %llu **\n",
+				  filename, real_start, real_len, bytes_read);
+		return ret;
+	}
+
+	block_buffer = malloc_cache_aligned(blocksize);
+	if (!block_buffer) {
+		log_err("** Unable to alloc memory for one block **\n");
+		return -ENOMEM;
+	}
+	memset(block_buffer, 0, blocksize);
+
+	real_start = round_up(offset, blocksize);
+
 	buf = map_sysmem(addr, len);
-	ret = info->read(filename, buf, offset, len, actread);
-	unmap_sysmem(buf);
+	/* Read the leading unaligned part. */
+	if (!IS_ALIGNED(offset, blocksize)) {
+		loff_t read_off = round_down(offset, blocksize);
+
+		ret = info->read(filename, block_buffer, read_off, blocksize,
+				 &bytes_read);
+		if (ret < 0) {
+			log_err("** Failed to read %s at offset %llu, %d **\n",
+				filename, read_off, ret);
+			goto out;
+		}
 
-	/* If we requested a specific number of bytes, check we got it */
-	if (ret == 0 && len && *actread != len)
-		log_debug("** %s shorter than offset + len **\n", filename);
-	fs_close();
+		/*
+		 * Calculate the real lengh we should copy from the block to
+		 * the buffer.
+		 */
+		bytes_read = min(blocksize - offset % blocksize, len);
+
+		memcpy(buf, block_buffer + offset % blocksize, bytes_read);
+		total_read += bytes_read;
+
+		/*
+		 * The whole read range is covered by the one block, we have
+		 * finished the whole read.
+		 */
+		if (round_up(offset, blocksize) >
+		    round_down(offset + len, blocksize))
+			goto out;
+	}
+	/* At this stage, offset + bytes_read should be aligned to blocksize. */
+	assert(IS_ALIGNED(offset + bytes_read, blocksize));
+
+	/* And we should have at least 0 or more aligned bytes to read. */
+	assert(round_down(offset + len, blocksize) >=
+	       round_up(offset, blocksize));
+	real_len = round_down(offset + len, blocksize) - real_start;
+
+	/* Read the aligned part. */
+	if (real_len) {
+		ret = info->read(filename, buf + total_read, real_start, real_len,
+				 &bytes_read);
+		if (ret < 0) {
+			log_err("** failed to read %s off %llu len %llu, %d **\n",
+				filename, real_start, real_len, ret);
+			goto out;
+		}
+		total_read += bytes_read;
+	}
+
+	/* A short read happened. */
+	if (bytes_read < real_len) {
+		log_debug(
+		"** %s short read, off %llu len %llu actual read %llu **\n",
+			  filename, real_start, real_len, bytes_read);
+		goto out;
+	}
 
+	/* Read the tailing unaligned part. */
+	if (!IS_ALIGNED(offset + len, blocksize)) {
+		/*
+		 * Reset the block buffer, as it may contain some data from
+		 * the leading block.
+		 */
+		memset(block_buffer, 0, blocksize);
+		ret = info->read(filename, block_buffer,
+				 round_down(offset + len, blocksize), blocksize,
+				 &bytes_read);
+		if (ret < 0) {
+			log_err("** Failed to read %s at offset %llu, %d **\n",
+				filename, round_down(offset + len, blocksize),
+				ret);
+			goto out;
+		}
+		bytes_read = (offset + len) % blocksize;
+		memcpy(buf + total_read, block_buffer, bytes_read);
+		total_read += bytes_read;
+	}
+out:
+	unmap_sysmem(buf);
+	free(block_buffer);
+	fs_close();
+	*actread = total_read;
 	return ret;
 }
 
diff --git a/include/btrfs.h b/include/btrfs.h
index a7605e158970..bba71ec02893 100644
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
2.36.1

