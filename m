Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDAD1E0711
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbgEYGeK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:34:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388487AbgEYGeK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:34:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2183AD08;
        Mon, 25 May 2020 06:34:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 20/30] fs: btrfs: Use btrfs_iter_dir() to replace btrfs_readdir()
Date:   Mon, 25 May 2020 14:32:47 +0800
Message-Id: <20200525063257.46757-21-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use extent buffer based infrastructure to re-implement btrfs_readdir().

Along this rework, some small corner cases fixed:
- Subvolume tree mtime
  Mtime of a subvolume tree is recorded in its root item, since there is
  no INODE_ITEM for it.
  This needs extra search from tree root.

- Output the unknown type
  If the DIR_ITEM is corrupted, at least don't try to access the memory
  out of bounday.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.c    | 157 +++++++++++++++++++++++++++-----------------
 fs/btrfs/btrfs.h    |   5 --
 fs/btrfs/ctree.h    |   5 ++
 fs/btrfs/dir-item.c |  68 +++++++++++--------
 4 files changed, 144 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index c967c114ccf5..2278b52e4d0e 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -16,67 +16,102 @@
 struct btrfs_info btrfs_info;
 struct btrfs_fs_info *current_fs_info;
 
-static int readdir_callback(const struct __btrfs_root *root,
-			    struct btrfs_dir_item *item)
+static int show_dir(struct btrfs_root *root, struct extent_buffer *eb,
+		    struct btrfs_dir_item *di)
 {
-	static const char typestr[BTRFS_FT_MAX][4] = {
-		[BTRFS_FT_UNKNOWN]  = " ? ",
-		[BTRFS_FT_REG_FILE] = "   ",
-		[BTRFS_FT_DIR]      = "DIR",
-		[BTRFS_FT_CHRDEV]   = "CHR",
-		[BTRFS_FT_BLKDEV]   = "BLK",
-		[BTRFS_FT_FIFO]     = "FIF",
-		[BTRFS_FT_SOCK]     = "SCK",
-		[BTRFS_FT_SYMLINK]  = "SYM",
-		[BTRFS_FT_XATTR]    = " ? ",
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_inode_item ii;
+	struct btrfs_key key;
+	static const char* dir_item_str[] = {
+		[BTRFS_FT_REG_FILE]	= "FILE",
+		[BTRFS_FT_DIR] 		= "DIR",
+		[BTRFS_FT_CHRDEV]	= "CHRDEV",
+		[BTRFS_FT_BLKDEV]	= "BLKDEV",
+		[BTRFS_FT_FIFO]		= "FIFO",
+		[BTRFS_FT_SOCK]		= "SOCK",
+		[BTRFS_FT_SYMLINK]	= "SYMLINK",
+		[BTRFS_FT_XATTR]	= "XATTR"
 	};
-	struct btrfs_inode_item inode;
-	const char *name = (const char *) (item + 1);
-	char filetime[32], *target = NULL;
+	u8 type = btrfs_dir_type(eb, di);
+	char namebuf[BTRFS_NAME_LEN];
+	char *target = NULL;
+	char filetime[32];
 	time_t mtime;
+	int ret;
 
-	if (__btrfs_lookup_inode(root, (struct btrfs_key *)&item->location,
-			       &inode, NULL)) {
-		printf("%s: Cannot find inode item for directory entry %.*s!\n",
-		       __func__, item->name_len, name);
-		return 0;
-	}
-
-	mtime = inode.mtime.sec;
-	ctime_r(&mtime, filetime);
+	btrfs_dir_item_key_to_cpu(eb, di, &key);
 
-	if (item->type == BTRFS_FT_SYMLINK) {
-		target = malloc(min(inode.size + 1,
-				    (u64) btrfs_info.sb.sectorsize));
+	if (key.type == BTRFS_ROOT_ITEM_KEY) {
+		struct btrfs_root *subvol;
 
-		if (target && __btrfs_readlink(root, item->location.objectid,
-					     target)) {
-			free(target);
-			target = NULL;
+		/* It's a subvolume, get its mtime from root item */
+		subvol = btrfs_read_fs_root(fs_info, &key);
+		if (IS_ERR(subvol)) {
+			ret = PTR_ERR(subvol);
+			error("Can't find root %llu", key.objectid);
+			return ret;
 		}
+		mtime = btrfs_stack_timespec_sec(&subvol->root_item.otime);
+	} else {
+		struct btrfs_path path;
+
+		/* It's regular inode, get its mtime from inode item */
+		btrfs_init_path(&path);
+		ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+		if (ret > 0)
+			ret = -ENOENT;
+		if (ret < 0) {
+			error("Can't find inode %llu", key.objectid);
+			btrfs_release_path(&path);
+			return ret;
+		}
+		read_extent_buffer(path.nodes[0], &ii,
+			btrfs_item_ptr_offset(path.nodes[0], path.slots[0]),
+			sizeof(ii));
+		btrfs_release_path(&path);
+		mtime = btrfs_stack_timespec_sec(&ii.mtime);
+	}
+	ctime_r(&mtime, filetime);
 
-		if (!target)
-			printf("%s: Cannot read symlink target!\n", __func__);
+	if (type == BTRFS_FT_SYMLINK) {
+		target = malloc(fs_info->sectorsize);
+		if (!target) {
+			error("Can't alloc memory for symlink %llu",
+				key.objectid);
+			return -ENOMEM;
+		}
+		ret = btrfs_readlink(root, key.objectid, target);
+		if (ret < 0) {
+			error("Failed to read symlink %llu", key.objectid);
+			goto out;
+		}
+		target[ret] = '\0';
 	}
 
-	printf("<%s> ", typestr[item->type]);
-	if (item->type == BTRFS_FT_CHRDEV || item->type == BTRFS_FT_BLKDEV)
-		printf("%4u,%5u  ", (unsigned int) (inode.rdev >> 20),
-			(unsigned int) (inode.rdev & 0xfffff));
+	if (type < ARRAY_SIZE(dir_item_str) && dir_item_str[type])
+		printf("<%s> ", dir_item_str[type]);
 	else
-		printf("%10llu  ", inode.size);
-
-	printf("%24.24s  %.*s", filetime, item->name_len, name);
-
-	if (item->type == BTRFS_FT_SYMLINK) {
-		printf(" -> %s", target ? target : "?");
-		if (target)
-			free(target);
+		printf("DIR_ITEM.%u", type);
+	if (type == BTRFS_FT_CHRDEV || type == BTRFS_FT_BLKDEV) {
+		ASSERT(key.type == BTRFS_INODE_ITEM_KEY);
+		printf("%4llu,%5llu  ", btrfs_stack_inode_rdev(&ii) >> 20,
+				btrfs_stack_inode_rdev(&ii) & 0xfffff);
+	} else {
+		if (key.type == BTRFS_INODE_ITEM_KEY)
+			printf("%10llu  ", btrfs_stack_inode_size(&ii));
+		else
+			printf("%10llu  ", 0ULL);
 	}
 
+	read_extent_buffer(eb, namebuf, (unsigned long)(di + 1),
+			   btrfs_dir_name_len(eb, di));
+	printf("%24.24s  %.*s", filetime, btrfs_dir_name_len(eb, di), namebuf);
+	if (type == BTRFS_FT_SYMLINK)
+		printf(" -> %s", target ? target : "?");
 	printf("\n");
-
-	return 0;
+out:
+	free(target);
+	return ret;
 }
 
 int btrfs_probe(struct blk_desc *fs_dev_desc,
@@ -125,27 +160,29 @@ int btrfs_probe(struct blk_desc *fs_dev_desc,
 
 int btrfs_ls(const char *path)
 {
-	struct __btrfs_root root = btrfs_info.fs_root;
-	u64 inr;
+	struct btrfs_fs_info *fs_info = current_fs_info;
+	struct btrfs_root *root = fs_info->fs_root;
+	u64 ino = BTRFS_FIRST_FREE_OBJECTID;
 	u8 type;
+	int ret;
 
-	inr = __btrfs_lookup_path(&root, root.root_dirid, path, &type, NULL, 40);
-
-	if (inr == -1ULL) {
+	ASSERT(fs_info);
+	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
+				path, &root, &ino, &type, 40);
+	if (ret < 0) {
 		printf("Cannot lookup path %s\n", path);
-		return -1;
+		return ret;
 	}
 
 	if (type != BTRFS_FT_DIR) {
-		printf("Not a directory: %s\n", path);
-		return -1;
+		error("Not a directory: %s", path);
+		return -ENOENT;
 	}
-
-	if (btrfs_readdir(&root, inr, readdir_callback)) {
-		printf("An error occured while listing directory %s\n", path);
-		return -1;
+	ret = btrfs_iter_dir(root, ino, show_dir);
+	if (ret < 0) {
+		error("An error occured while listing directory %s", path);
+		return ret;
 	}
-
 	return 0;
 }
 
diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index 53d53f310bdc..e36bd8982716 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -43,13 +43,8 @@ u32 btrfs_decompress(u8 type, const char *, u32, char *, u32);
 int btrfs_read_superblock(void);
 
 /* dir-item.c */
-typedef int (*btrfs_readdir_callback_t)(const struct __btrfs_root *,
-					struct btrfs_dir_item *);
-
 int __btrfs_lookup_dir_item(const struct __btrfs_root *, u64, const char *, int,
 			   struct btrfs_dir_item *);
-int btrfs_readdir(const struct __btrfs_root *, u64, btrfs_readdir_callback_t);
-
 /* root.c */
 int btrfs_find_root(u64, struct __btrfs_root *, struct btrfs_root_item *);
 u64 btrfs_lookup_root_ref(u64, struct btrfs_root_ref *, char *);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 992b7187339a..3430659c8874 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1285,6 +1285,11 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_path *path, u64 dir,
 					     const char *name, int name_len,
 					     int mod);
+typedef int (*btrfs_iter_dir_callback_t)(struct btrfs_root *root,
+					 struct extent_buffer *eb,
+					 struct btrfs_dir_item *di);
+int btrfs_iter_dir(struct btrfs_root *root, u64 ino,
+		   btrfs_iter_dir_callback_t callback);
 /* inode.c */
 int btrfs_lookup_path(struct btrfs_root *root, u64 ino, const char *filename,
 			struct btrfs_root **root_ret, u64 *ino_ret,
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 4bf45c2fa925..a6c66a021896 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -193,39 +193,55 @@ out:
 	return res ? 0 : -1;
 }
 
-int btrfs_readdir(const struct __btrfs_root *root, u64 dir,
-		  btrfs_readdir_callback_t callback)
+int btrfs_iter_dir(struct btrfs_root *root, u64 ino,
+		   btrfs_iter_dir_callback_t callback)
 {
-	struct __btrfs_path path;
-	struct btrfs_key key, *found_key;
-	struct btrfs_dir_item *item;
-	int res = 0;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int ret;
 
-	key.objectid = dir;
+	btrfs_init_path(&path);
+	key.objectid = ino;
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = 0;
 
-	if (btrfs_search_tree(root, &key, &path))
-		return -1;
-
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	/* Should not happen */
+	if (ret == 0) {
+		ret = -EUCLEAN;
+		goto out;
+	}
+	if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
+		ret = btrfs_next_leaf(root, &path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			ret = 0;
+			goto out;
+		}
+	}
 	do {
-		found_key = btrfs_path_leaf_key(&path);
-		if (btrfs_comp_keys_type(&key, found_key))
-			break;
-
-		item = btrfs_path_item_ptr(&path, struct btrfs_dir_item);
-		btrfs_dir_item_to_cpu(item);
+		struct btrfs_dir_item *di;
 
-		if (__verify_dir_item(item, 0, sizeof(*item) + item->name_len))
-			continue;
-		if (item->type == BTRFS_FT_XATTR)
-			continue;
-
-		if (callback(root, item))
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.objectid != ino || key.type != BTRFS_DIR_INDEX_KEY)
 			break;
-	} while (!(res = btrfs_next_slot(&path)));
-
-	__btrfs_free_path(&path);
+		di = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				    struct btrfs_dir_item);
+		if (verify_dir_item(root, path.nodes[0], di)) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+		ret = callback(root, path.nodes[0], di);
+		if (ret < 0)
+			goto out;
+	} while (!(ret = btrfs_next_item(root, &path)));
 
-	return res < 0 ? -1 : 0;
+	if (ret > 0)
+		ret = 0;
+out:
+	btrfs_release_path(&path);
+	return ret;
 }
-- 
2.26.2

