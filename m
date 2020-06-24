Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE6207844
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404820AbgFXQDm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:42 -0400
Received: from mail.nic.cz ([217.31.204.67]:48114 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404750AbgFXQD3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:29 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 9666E140669;
        Wed, 24 Jun 2020 18:03:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014604; bh=/l0fv5uN6VQRmkiXjXqOlTFTWqytGxUmN5hq80VOIok=;
        h=From:To:Date;
        b=XDzj4+ygVQnNWb7V/Q2/ce4sJA0BHN6yArCXB5LXTq2qPh7nFGY9FgdhF9HP0dIIU
         MLXHwQyCyH1xmVZniJz17HfJ6QGl9qd9Owc1bUY5E6zIDGSeIUytKZUZPh7AyEYXpo
         j7AOqQ2EX2pKEeErVDBxRhVe32ZQhD5GBogCNueQ=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 19/30] fs: btrfs: Implement btrfs_lookup_path()
Date:   Wed, 24 Jun 2020 18:03:05 +0200
Message-Id: <20200624160316.5001-20-marek.behun@nic.cz>
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

This is the extent buffer based path lookup routine.

To implement this, btrfs_lookup_dir_item() is crossported from
btrfs-progs, and implements btrfs_lookup_path() from scratch.

Unlike the existing __btrfs_lookup_path(), since btrfs_read_fs_root()
will check whether a root is a orphan at read time, there is no need to
check root backref, this makes the code a little easier to read.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/ctree.h    |   4 +
 fs/btrfs/dir-item.c | 106 +++++++++++++++++++
 fs/btrfs/inode.c    | 250 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 360 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d635b0814e..111a5a6a29 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1285,6 +1285,10 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_path *path, u64 dir,
 					     const char *name, int name_len,
 					     int mod);
+/* inode.c */
+int btrfs_lookup_path(struct btrfs_root *root, u64 ino, const char *filename,
+			struct btrfs_root **root_ret, u64 *ino_ret,
+			u8 *type_ret, int symlink_limit);
 
 /* ctree.c */
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index aea621c72b..b49aaacbd8 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -8,6 +8,112 @@
 #include "btrfs.h"
 #include "disk-io.h"
 
+static int verify_dir_item(struct btrfs_root *root,
+		    struct extent_buffer *leaf,
+		    struct btrfs_dir_item *dir_item)
+{
+	u16 namelen = BTRFS_NAME_LEN;
+	u8 type = btrfs_dir_type(leaf, dir_item);
+
+	if (type == BTRFS_FT_XATTR)
+		namelen = XATTR_NAME_MAX;
+
+	if (btrfs_dir_name_len(leaf, dir_item) > namelen) {
+		fprintf(stderr, "invalid dir item name len: %u\n",
+			(unsigned)btrfs_dir_data_len(leaf, dir_item));
+		return 1;
+	}
+
+	/* BTRFS_MAX_XATTR_SIZE is the same for all dir items */
+	if ((btrfs_dir_data_len(leaf, dir_item) +
+	     btrfs_dir_name_len(leaf, dir_item)) >
+			BTRFS_MAX_XATTR_SIZE(root->fs_info)) {
+		fprintf(stderr, "invalid dir item name + data len: %u + %u\n",
+			(unsigned)btrfs_dir_name_len(leaf, dir_item),
+			(unsigned)btrfs_dir_data_len(leaf, dir_item));
+		return 1;
+	}
+
+	return 0;
+}
+
+struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_root *root,
+			      struct btrfs_path *path,
+			      const char *name, int name_len)
+{
+	struct btrfs_dir_item *dir_item;
+	unsigned long name_ptr;
+	u32 total_len;
+	u32 cur = 0;
+	u32 this_len;
+	struct extent_buffer *leaf;
+
+	leaf = path->nodes[0];
+	dir_item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dir_item);
+	total_len = btrfs_item_size_nr(leaf, path->slots[0]);
+	if (verify_dir_item(root, leaf, dir_item))
+		return NULL;
+
+	while(cur < total_len) {
+		this_len = sizeof(*dir_item) +
+			btrfs_dir_name_len(leaf, dir_item) +
+			btrfs_dir_data_len(leaf, dir_item);
+		if (this_len > (total_len - cur)) {
+			fprintf(stderr, "invalid dir item size\n");
+			return NULL;
+		}
+
+		name_ptr = (unsigned long)(dir_item + 1);
+
+		if (btrfs_dir_name_len(leaf, dir_item) == name_len &&
+		    memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0)
+			return dir_item;
+
+		cur += this_len;
+		dir_item = (struct btrfs_dir_item *)((char *)dir_item +
+						     this_len);
+	}
+	return NULL;
+}
+
+struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
+					     struct btrfs_root *root,
+					     struct btrfs_path *path, u64 dir,
+					     const char *name, int name_len,
+					     int mod)
+{
+	int ret;
+	struct btrfs_key key;
+	int ins_len = mod < 0 ? -1 : 0;
+	int cow = mod != 0;
+	struct btrfs_key found_key;
+	struct extent_buffer *leaf;
+
+	key.objectid = dir;
+	key.type = BTRFS_DIR_ITEM_KEY;
+
+	key.offset = btrfs_name_hash(name, name_len);
+
+	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	if (ret > 0) {
+		if (path->slots[0] == 0)
+			return NULL;
+		path->slots[0]--;
+	}
+
+	leaf = path->nodes[0];
+	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+	if (found_key.objectid != dir ||
+	    found_key.type != BTRFS_DIR_ITEM_KEY ||
+	    found_key.offset != key.offset)
+		return NULL;
+
+	return btrfs_match_dir_item_name(root, path, name, name_len);
+}
+
 static int __verify_dir_item(struct btrfs_dir_item *item, u32 start, u32 total)
 {
 	u16 max_len = BTRFS_NAME_LEN;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da2a5e90a1..2e3fcad5a8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -162,6 +162,115 @@ int __btrfs_readlink(const struct __btrfs_root *root, u64 inr, char *target)
 	return 0;
 }
 
+static int lookup_root_ref(struct btrfs_fs_info *fs_info,
+			   u64 rootid, u64 *root_ret, u64 *dir_ret)
+{
+	struct btrfs_root *root = fs_info->tree_root;
+	struct btrfs_root_ref *root_ref;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int ret;
+
+	btrfs_init_path(&path);
+	key.objectid = rootid;
+	key.type = BTRFS_ROOT_BACKREF_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	/* Should not happen */
+	if (ret == 0) {
+		ret = -EUCLEAN;
+		goto out;
+	}
+	ret = btrfs_previous_item(root, &path, rootid, BTRFS_ROOT_BACKREF_KEY);
+	if (ret < 0)
+		goto out;
+	if (ret > 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	root_ref = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				  struct btrfs_root_ref);
+	*root_ret = key.offset;
+	*dir_ret = btrfs_root_ref_dirid(path.nodes[0], root_ref);
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
+/*
+ * To get the parent inode of @ino of @root.
+ *
+ * @root_ret and @ino_ret will be filled.
+ *
+ * NOTE: This function is not reliable. It can only get one parent inode.
+ * The get the proper parent inode, we need a full VFS inodes stack to
+ * resolve properly.
+ */
+static int get_parent_inode(struct btrfs_root *root, u64 ino,
+			    struct btrfs_root **root_ret, u64 *ino_ret)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int ret;
+
+	if (ino == BTRFS_FIRST_FREE_OBJECTID) {
+		u64 parent_root = -1;
+
+		/* It's top level already, no more parent */
+		if (root->root_key.objectid == BTRFS_FS_TREE_OBJECTID) {
+			*root_ret = fs_info->fs_root;
+			*ino_ret = BTRFS_FIRST_FREE_OBJECTID;
+			return 0;
+		}
+
+		ret = lookup_root_ref(fs_info, root->root_key.objectid,
+				      &parent_root, ino_ret);
+		if (ret < 0)
+			return ret;
+
+		key.objectid = parent_root;
+		key.type = BTRFS_ROOT_ITEM_KEY;
+		key.offset = (u64)-1;
+		*root_ret = btrfs_read_fs_root(fs_info, &key);
+		if (IS_ERR(*root_ret))
+			return PTR_ERR(*root_ret);
+
+		return 0;
+	}
+
+	btrfs_init_path(&path);
+	key.objectid = ino;
+	key.type = BTRFS_INODE_REF_KEY;
+	key.offset = (u64)-1;
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+	/* Should not happen */
+	if (ret == 0) {
+		ret = -EUCLEAN;
+		goto out;
+	}
+	ret = btrfs_previous_item(root, &path, ino, BTRFS_INODE_REF_KEY);
+	if (ret < 0)
+		goto out;
+	if (ret > 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	*root_ret = root;
+	*ino_ret = key.offset;
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 /* inr must be a directory (for regular files with multiple hard links this
    function returns only one of the parents of the file) */
 static u64 __get_parent_inode(struct __btrfs_root *root, u64 inr,
@@ -240,6 +349,147 @@ static inline const char *skip_current_directories(const char *cur)
 	return cur;
 }
 
+/*
+ * Resolve one filename of @ino of @root.
+ *
+ * key_ret:	The child key (either INODE_ITEM or ROOT_ITEM type)
+ * type_ret:	BTRFS_FT_* of the child inode.
+ *
+ * Return 0 with above members filled.
+ * Return <0 for error.
+ */
+static int resolve_one_filename(struct btrfs_root *root, u64 ino,
+				const char *name, int namelen,
+				struct btrfs_key *key_ret, u8 *type_ret)
+{
+	struct btrfs_dir_item *dir_item;
+	struct btrfs_path path;
+	int ret = 0;
+
+	btrfs_init_path(&path);
+
+	dir_item = btrfs_lookup_dir_item(NULL, root, &path, ino, name,
+					 namelen, 0);
+	if (IS_ERR(dir_item)) {
+		ret = PTR_ERR(dir_item);
+		goto out;
+	}
+
+	btrfs_dir_item_key_to_cpu(path.nodes[0], dir_item, key_ret);
+	*type_ret = btrfs_dir_type(path.nodes[0], dir_item);
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
+/*
+ * Resolve a full path @filename. The start point is @ino of @root.
+ *
+ * The result will be filled into @root_ret, @ino_ret and @type_ret.
+ */
+int btrfs_lookup_path(struct btrfs_root *root, u64 ino, const char *filename,
+			struct btrfs_root **root_ret, u64 *ino_ret,
+			u8 *type_ret, int symlink_limit)
+{
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_root *next_root;
+	struct btrfs_key key;
+	const char *cur = filename;
+	u64 next_ino;
+	u8 next_type;
+	u8 type;
+	int len;
+	int ret = 0;
+
+	/* If the path is absolute path, also search from fs root */
+	if (*cur == '/') {
+		root = fs_info->fs_root;
+		ino = btrfs_root_dirid(&root->root_item);
+		type = BTRFS_FT_DIR;
+	}
+
+	while (*cur != '\0') {
+		cur = skip_current_directories(cur);
+
+		len = next_length(cur);
+		if (len > BTRFS_NAME_LEN) {
+			error("%s: Name too long at \"%.*s\"", __func__,
+			       BTRFS_NAME_LEN, cur);
+			return -ENAMETOOLONG;
+		}
+
+		if (len == 1 && cur[0] == '.')
+			break;
+
+		if (len == 2 && cur[0] == '.' && cur[1] == '.') {
+			/* Go one level up */
+			ret = get_parent_inode(root, ino, &next_root, &next_ino);
+			if (ret < 0)
+				return ret;
+			root = next_root;
+			ino = next_ino;
+			goto next;
+		}
+
+		if (!*cur)
+			break;
+
+		ret = resolve_one_filename(root, ino, cur, len, &key, &type);
+		if (ret < 0)
+			return ret;
+
+		if (key.type == BTRFS_ROOT_ITEM_KEY) {
+			/* Child inode is a subvolume */
+
+			next_root = btrfs_read_fs_root(fs_info, &key);
+			if (IS_ERR(next_root))
+				return PTR_ERR(next_root);
+			root = next_root;
+			ino = btrfs_root_dirid(&root->root_item);
+		} else if (type == BTRFS_FT_SYMLINK && symlink_limit >= 0) {
+			/* Child inode is a symlink */
+
+			char *target;
+
+			if (symlink_limit == 0) {
+				error("%s: Too much symlinks!", __func__);
+				return -EMLINK;
+			}
+			target = malloc(fs_info->sectorsize);
+			if (!target)
+				return -ENOMEM;
+			ret = btrfs_readlink(root, key.objectid, target);
+			if (ret < 0) {
+				free(target);
+				return ret;
+			}
+			target[ret] = '\0';
+
+			ret = btrfs_lookup_path(root, ino, target, &next_root,
+						&next_ino, &next_type,
+						symlink_limit);
+			if (ret < 0)
+				return ret;
+			root = next_root;
+			ino = next_ino;
+			type = next_type;
+		} else {
+			/* Child inode is an inode */
+			ino = key.objectid;
+		}
+next:
+		cur += len;
+	}
+
+	if (!ret) {
+		*root_ret = root;
+		*ino_ret = ino;
+		*type_ret = type;
+	}
+
+	return ret;
+}
+
 u64 __btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
 		      u8 *type_p, struct btrfs_inode_item *inode_item_p,
 		      int symlink_limit)
-- 
2.26.2

