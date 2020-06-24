Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D454C207847
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404827AbgFXQDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:43 -0400
Received: from lists.nic.cz ([217.31.204.67]:48138 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404757AbgFXQD3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:29 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 536671409E8;
        Wed, 24 Jun 2020 18:03:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014605; bh=DNyuLdqLlxDwPiOJnpqSx/dV+iLiLSR9PKYUEbGExCc=;
        h=From:To:Date;
        b=gL22A25UWWtmLGdBmmb/1MqQ7lGrKRztPmUxZQ8Zepue6Bc6aufBeSxvtbI+tibO9
         MDq4GVyZbHqw92yywtiKitIPupZ3Fzlom06EkSAE+dx+lhOQ9gdjJXQNsgB/TeyFFr
         RRX5DjYcXMqO4fw56M1CPWMCiLFwCEa1nGwvbeTE=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 23/30] fs: btrfs: Introduce btrfs_read_extent_inline() and btrfs_read_extent_reg()
Date:   Wed, 24 Jun 2020 18:03:09 +0200
Message-Id: <20200624160316.5001-24-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624160316.5001-1-marek.behun@nic.cz>
References: <20200624160316.5001-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

These two functions are used to do sector aligned read, which will be
later used to implement btrfs_file_read().

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/ctree.h   |   5 ++
 fs/btrfs/disk-io.c |  36 ++++++++++
 fs/btrfs/disk-io.h |   2 +
 fs/btrfs/inode.c   | 162 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0cf5e63451..c4b25189dc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1294,6 +1294,11 @@ int btrfs_iter_dir(struct btrfs_root *root, u64 ino,
 int btrfs_lookup_path(struct btrfs_root *root, u64 ino, const char *filename,
 			struct btrfs_root **root_ret, u64 *ino_ret,
 			u8 *type_ret, int symlink_limit);
+int btrfs_read_extent_inline(struct btrfs_path *path,
+			     struct btrfs_file_extent_item *fi, char *dest);
+int btrfs_read_extent_reg(struct btrfs_path *path,
+			  struct btrfs_file_extent_item *fi, u64 offset,
+			  int len, char *dest);
 
 /* ctree.c */
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4d08b0204a..4da1b80038 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -565,6 +565,42 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	return ERR_PTR(ret);
 }
 
+int read_extent_data(struct btrfs_fs_info *fs_info, char *data, u64 logical,
+		     u64 *len, int mirror)
+{
+	u64 offset = 0;
+	struct btrfs_multi_bio *multi = NULL;
+	struct btrfs_device *device;
+	int ret = 0;
+	u64 max_len = *len;
+
+	ret = btrfs_map_block(fs_info, READ, logical, len, &multi, mirror,
+			      NULL);
+	if (ret) {
+		fprintf(stderr, "Couldn't map the block %llu\n",
+				logical + offset);
+		goto err;
+	}
+	device = multi->stripes[0].dev;
+
+	if (*len > max_len)
+		*len = max_len;
+	if (!device->desc || !device->part) {
+		ret = -EIO;
+		goto err;
+	}
+
+	ret = __btrfs_devread(device->desc, device->part, data, *len,
+			      multi->stripes[0].physical);
+	if (ret != *len)
+		ret = -EIO;
+	else
+		ret = 0;
+err:
+	kfree(multi);
+	return ret;
+}
+
 void btrfs_setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 		      u64 objectid)
 {
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 9daf959c57..424bb01dcd 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -18,6 +18,8 @@ int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirr
 struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 		u64 parent_transid);
 
+int read_extent_data(struct btrfs_fs_info *fs_info, char *data, u64 logical,
+		     u64 *len, int mirror);
 struct extent_buffer* btrfs_find_create_tree_block(
 		struct btrfs_fs_info *fs_info, u64 bytenr);
 struct extent_buffer *btrfs_find_tree_block(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 83d21467d9..ab45db87a6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5,9 +5,12 @@
  * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
  */
 
+#include <linux/kernel.h>
 #include <malloc.h>
+#include <memalign.h>
 #include "btrfs.h"
 #include "disk-io.h"
+#include "volumes.h"
 
 u64 __btrfs_lookup_inode_ref(struct __btrfs_root *root, u64 inr,
 			   struct btrfs_inode_ref *refp, char *name)
@@ -663,3 +666,162 @@ out:
 	__btrfs_free_path(&path);
 	return rd_all;
 }
+
+/*
+ * Read out inline extent.
+ *
+ * Since inline extent should only exist for offset 0, no need for extra
+ * parameters.
+ * Truncating should be handled by the caller.
+ *
+ * Return the number of bytes read.
+ * Return <0 for error.
+ */
+int btrfs_read_extent_inline(struct btrfs_path *path,
+			     struct btrfs_file_extent_item *fi, char *dest)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	int slot = path->slots[0];
+	char *cbuf = NULL;
+	char *dbuf = NULL;
+	u32 csize;
+	u32 dsize;
+	int ret;
+
+	csize = btrfs_file_extent_inline_item_len(leaf, btrfs_item_nr(slot));
+	if (btrfs_file_extent_compression(leaf, fi) == BTRFS_COMPRESS_NONE) {
+		/* Uncompressed, just read it out */
+		read_extent_buffer(leaf, dest,
+				btrfs_file_extent_inline_start(fi),
+				csize);
+		return csize;
+	}
+
+	/* Compressed extent, prepare the compressed and data buffer */
+	dsize = btrfs_file_extent_ram_bytes(leaf, fi);
+	cbuf = malloc(csize);
+	dbuf = malloc(dsize);
+	if (!cbuf || !dbuf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	read_extent_buffer(leaf, cbuf, btrfs_file_extent_inline_start(fi),
+			   csize);
+	ret = btrfs_decompress(btrfs_file_extent_compression(leaf, fi),
+			       cbuf, csize, dbuf, dsize);
+	if (ret < 0 || ret != dsize) {
+		ret = -EIO;
+		goto out;
+	}
+	memcpy(dest, dbuf, dsize);
+	ret = dsize;
+out:
+	free(cbuf);
+	free(dbuf);
+	return ret;
+}
+
+/*
+ * Read out regular extent.
+ *
+ * Truncating should be handled by the caller.
+ *
+ * @offset and @len should not cross the extent boundary.
+ * Return the number of bytes read.
+ * Return <0 for error.
+ */
+int btrfs_read_extent_reg(struct btrfs_path *path,
+			  struct btrfs_file_extent_item *fi, u64 offset,
+			  int len, char *dest)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_fs_info *fs_info = leaf->fs_info;
+	struct btrfs_key key;
+	u64 extent_num_bytes;
+	u64 disk_bytenr;
+	u64 read;
+	char *cbuf = NULL;
+	char *dbuf = NULL;
+	u32 csize;
+	u32 dsize;
+	bool finished = false;
+	int num_copies;
+	int i;
+	int slot = path->slots[0];
+	int ret;
+
+	btrfs_item_key_to_cpu(leaf, &key, slot);
+	extent_num_bytes = btrfs_file_extent_num_bytes(leaf, fi);
+	ASSERT(IS_ALIGNED(offset, fs_info->sectorsize) &&
+	       IS_ALIGNED(len, fs_info->sectorsize));
+	ASSERT(offset >= key.offset &&
+	       offset + len <= key.offset + extent_num_bytes);
+
+	/* Preallocated or hole , fill @dest with zero */
+	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_PREALLOC ||
+	    btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
+		memset(dest, 0, len);
+		return len;
+	}
+
+	if (btrfs_file_extent_compression(leaf, fi) == BTRFS_COMPRESS_NONE) {
+		u64 logical;
+
+		logical = btrfs_file_extent_disk_bytenr(leaf, fi) +
+			  btrfs_file_extent_offset(leaf, fi) +
+			  offset - key.offset;
+		read = len;
+
+		num_copies = btrfs_num_copies(fs_info, logical, len);
+		for (i = 1; i <= num_copies; i++) {
+			ret = read_extent_data(fs_info, dest, logical, &read, i);
+			if (ret < 0 || read != len)
+				continue;
+			finished = true;
+			break;
+		}
+		if (!finished)
+			return -EIO;
+		return len;
+	}
+
+	csize = btrfs_file_extent_disk_num_bytes(leaf, fi);
+	dsize = btrfs_file_extent_ram_bytes(leaf, fi);
+	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
+	num_copies = btrfs_num_copies(fs_info, disk_bytenr, csize);
+
+	cbuf = malloc_cache_aligned(csize);
+	dbuf = malloc_cache_aligned(dsize);
+	if (!cbuf || !dbuf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	/* For compressed extent, we must read the whole on-disk extent */
+	for (i = 1; i <= num_copies; i++) {
+		read = csize;
+		ret = read_extent_data(fs_info, cbuf, disk_bytenr,
+				       &read, i);
+		if (ret < 0 || read != csize)
+			continue;
+		finished = true;
+		break;
+	}
+	if (!finished) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = btrfs_decompress(btrfs_file_extent_compression(leaf, fi), cbuf,
+			       csize, dbuf, dsize);
+	if (ret != dsize) {
+		ret = -EIO;
+		goto out;
+	}
+	/* Then copy the needed part */
+	memcpy(dest, dbuf + btrfs_file_extent_offset(leaf, fi), len);
+	ret = len;
+out:
+	free(cbuf);
+	free(dbuf);
+	return ret;
+}
-- 
2.26.2

