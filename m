Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35851B37E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 08:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgDVGvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 02:51:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:51562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgDVGvR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 02:51:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4AC7AA4F;
        Wed, 22 Apr 2020 06:51:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT 17/26] fs: btrfs: Use btrfs_readlink() to implement __btrfs_readlink()
Date:   Wed, 22 Apr 2020 14:50:00 +0800
Message-Id: <20200422065009.69392-18-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The existing __btrfs_readlink() can be easily re-implemented using the
extent buffer based btrfs_readlink().

This should be the first step to re-implement u-boot btrfs code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.h |   1 +
 fs/btrfs/inode.c | 100 +++++++++++++++++++++++++++++------------------
 2 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index e561d27944fc..9057f2476526 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -60,6 +60,7 @@ u64 __btrfs_lookup_inode_ref(struct __btrfs_root *, u64, struct btrfs_inode_ref
 int __btrfs_lookup_inode(const struct __btrfs_root *, struct btrfs_key *,
 		        struct btrfs_inode_item *, struct __btrfs_root *);
 int __btrfs_readlink(const struct __btrfs_root *, u64, char *);
+int btrfs_readlink(struct btrfs_root *root, u64 ino, char *target);
 u64 __btrfs_lookup_path(struct __btrfs_root *, u64, const char *, u8 *,
 		       struct btrfs_inode_item *, int);
 u64 btrfs_file_read(const struct __btrfs_root *, u64, u64, u64, char *);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eb34f546b57f..df2f6590bb40 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5,8 +5,9 @@
  * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
  */
 
-#include "btrfs.h"
 #include <malloc.h>
+#include "btrfs.h"
+#include "disk-io.h"
 
 u64 __btrfs_lookup_inode_ref(struct __btrfs_root *root, u64 inr,
 			   struct btrfs_inode_ref *refp, char *name)
@@ -83,56 +84,81 @@ out:
 	return res;
 }
 
-int __btrfs_readlink(const struct __btrfs_root *root, u64 inr, char *target)
+/*
+ * Read the content of symlink inode @ino of @root, into @target.
+ *
+ * Return the number of read data.
+ * Return <0 for error.
+ */
+int btrfs_readlink(struct btrfs_root *root, u64 ino, char *target)
 {
-	struct __btrfs_path path;
+	struct btrfs_path path;
 	struct btrfs_key key;
-	struct btrfs_file_extent_item *extent;
-	const char *data_ptr;
-	int res = -1;
+	struct btrfs_file_extent_item *fi;
+	int ret;
 
-	key.objectid = inr;
+	key.objectid = ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = 0;
+	btrfs_init_path(&path);
 
-	if (btrfs_search_tree(root, &key, &path))
-		return -1;
-
-	if (__btrfs_comp_keys(&key, btrfs_path_leaf_key(&path)))
-		goto out;
-
-	extent = btrfs_path_item_ptr(&path, struct btrfs_file_extent_item);
-	if (extent->type != BTRFS_FILE_EXTENT_INLINE) {
-		printf("%s: Extent for symlink %llu not of INLINE type\n",
-		       __func__, inr);
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret > 0) {
+		ret = -ENOENT;
 		goto out;
 	}
-
-	btrfs_file_extent_item_to_cpu_inl(extent);
-
-	if (extent->compression != BTRFS_COMPRESS_NONE) {
-		printf("%s: Symlink %llu extent data compressed!\n", __func__,
-		       inr);
+	fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			    struct btrfs_file_extent_item);
+	if (btrfs_file_extent_type(path.nodes[0], fi) !=
+	    BTRFS_FILE_EXTENT_INLINE) {
+		ret = -EUCLEAN;
+		printf("Extent for symlink %llu must be INLINE type\n", ino);
 		goto out;
-	} else if (extent->encryption != 0) {
-		printf("%s: Symlink %llu extent data encrypted!\n", __func__,
-		       inr);
+	}
+	if (btrfs_file_extent_compression(path.nodes[0], fi) !=
+	    BTRFS_COMPRESS_NONE) {
+		ret = -EUCLEAN;
+		printf("Symlink %llu extent data compressed!\n", ino);
 		goto out;
-	} else if (extent->ram_bytes >= btrfs_info.sb.sectorsize) {
-		printf("%s: Symlink %llu extent data too long (%llu)!\n",
-		       __func__, inr, extent->ram_bytes);
+	}
+	if (btrfs_file_extent_ram_bytes(path.nodes[0], fi) >=
+	    root->fs_info->sectorsize) {
+		ret = -EUCLEAN;
+		printf("Symlink %llu extent data too large (%llu)!\n",
+			ino, btrfs_file_extent_ram_bytes(path.nodes[0], fi));
 		goto out;
 	}
+	read_extent_buffer(path.nodes[0], target,
+			btrfs_file_extent_inline_start(fi),
+			btrfs_file_extent_ram_bytes(path.nodes[0], fi));
+	ret = btrfs_file_extent_ram_bytes(path.nodes[0], fi);
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
 
-	data_ptr = (const char *) extent
-		   + offsetof(struct btrfs_file_extent_item, disk_bytenr);
+int __btrfs_readlink(const struct __btrfs_root *root, u64 inr, char *target)
+{
+	struct btrfs_root *subvolume;
+	struct btrfs_fs_info *fs_info = current_fs_info;
+	struct btrfs_key key;
+	int ret;
+
+	ASSERT(fs_info);
+	key.objectid = root->objectid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+	subvolume = btrfs_read_fs_root(fs_info, &key);
+	if (IS_ERR(subvolume))
+		return -1;
 
-	memcpy(target, data_ptr, extent->ram_bytes);
-	target[extent->ram_bytes] = '\0';
-	res = 0;
-out:
-	__btrfs_free_path(&path);
-	return res;
+	ret = btrfs_readlink(subvolume, inr, target);
+	if (ret < 0)
+		return -1;
+	target[ret] = '\0';
+	return 0;
 }
 
 /* inr must be a directory (for regular files with multiple hard links this
-- 
2.26.0

