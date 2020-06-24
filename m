Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873E920783A
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404792AbgFXQDb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404779AbgFXQD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:28 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426FAC0617B9
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:27 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 28F4F1409DC;
        Wed, 24 Jun 2020 18:03:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014604; bh=NWyU1cN2Yilnn7xwI7UWBk8AZvQkRwfGpoTxMofm5bY=;
        h=From:To:Date;
        b=NR1Lkdxy098VvCBmXk2t7+GhBIkKC3vT7P1gXWnW65ji7KVqFklJCR/lMafM0bhue
         4j5/V6fggLclTCZTnkJbrXN1q33UMbuvi/v31FJLhKYbeb6FAj4HG8BGC4H8Ld3Tuv
         tizIYjzrCT6d7+C4rAvz3XjOAFdPkUZH40LaNP+o=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 16/30] fs: btrfs: Rename path resolve related functions to avoid name conflicts
Date:   Wed, 24 Jun 2020 18:03:02 +0200
Message-Id: <20200624160316.5001-17-marek.behun@nic.cz>
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

Since the old code is using __btrfs_path/__btrfs_root which is different
from the regular extent buffer based one, we add "__" prefix for the old
implementation to avoid name conflicts for the incoming crossport.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/btrfs.c     | 12 ++++++------
 fs/btrfs/btrfs.h     | 10 +++++-----
 fs/btrfs/compat.h    |  3 +++
 fs/btrfs/ctree.h     |  7 +++++++
 fs/btrfs/dir-item.c  | 12 ++++++------
 fs/btrfs/inode.c     | 28 ++++++++++++++--------------
 fs/btrfs/subvolume.c |  4 ++--
 7 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 2bd2ec9ed9..c967c114cc 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -35,7 +35,7 @@ static int readdir_callback(const struct __btrfs_root *root,
 	char filetime[32], *target = NULL;
 	time_t mtime;
 
-	if (btrfs_lookup_inode(root, (struct btrfs_key *)&item->location,
+	if (__btrfs_lookup_inode(root, (struct btrfs_key *)&item->location,
 			       &inode, NULL)) {
 		printf("%s: Cannot find inode item for directory entry %.*s!\n",
 		       __func__, item->name_len, name);
@@ -49,7 +49,7 @@ static int readdir_callback(const struct __btrfs_root *root,
 		target = malloc(min(inode.size + 1,
 				    (u64) btrfs_info.sb.sectorsize));
 
-		if (target && btrfs_readlink(root, item->location.objectid,
+		if (target && __btrfs_readlink(root, item->location.objectid,
 					     target)) {
 			free(target);
 			target = NULL;
@@ -129,7 +129,7 @@ int btrfs_ls(const char *path)
 	u64 inr;
 	u8 type;
 
-	inr = btrfs_lookup_path(&root, root.root_dirid, path, &type, NULL, 40);
+	inr = __btrfs_lookup_path(&root, root.root_dirid, path, &type, NULL, 40);
 
 	if (inr == -1ULL) {
 		printf("Cannot lookup path %s\n", path);
@@ -155,7 +155,7 @@ int btrfs_exists(const char *file)
 	u64 inr;
 	u8 type;
 
-	inr = btrfs_lookup_path(&root, root.root_dirid, file, &type, NULL, 40);
+	inr = __btrfs_lookup_path(&root, root.root_dirid, file, &type, NULL, 40);
 
 	return (inr != -1ULL && type == BTRFS_FT_REG_FILE);
 }
@@ -167,7 +167,7 @@ int btrfs_size(const char *file, loff_t *size)
 	u64 inr;
 	u8 type;
 
-	inr = btrfs_lookup_path(&root, root.root_dirid, file, &type, &inode,
+	inr = __btrfs_lookup_path(&root, root.root_dirid, file, &type, &inode,
 				40);
 
 	if (inr == -1ULL) {
@@ -192,7 +192,7 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 	u64 inr, rd;
 	u8 type;
 
-	inr = btrfs_lookup_path(&root, root.root_dirid, file, &type, &inode,
+	inr = __btrfs_lookup_path(&root, root.root_dirid, file, &type, &inode,
 				40);
 
 	if (inr == -1ULL) {
diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index a52ff942f2..e8197391a2 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -46,7 +46,7 @@ int btrfs_read_superblock(void);
 typedef int (*btrfs_readdir_callback_t)(const struct __btrfs_root *,
 					struct btrfs_dir_item *);
 
-int btrfs_lookup_dir_item(const struct __btrfs_root *, u64, const char *, int,
+int __btrfs_lookup_dir_item(const struct __btrfs_root *, u64, const char *, int,
 			   struct btrfs_dir_item *);
 int btrfs_readdir(const struct __btrfs_root *, u64, btrfs_readdir_callback_t);
 
@@ -55,12 +55,12 @@ int btrfs_find_root(u64, struct __btrfs_root *, struct btrfs_root_item *);
 u64 btrfs_lookup_root_ref(u64, struct btrfs_root_ref *, char *);
 
 /* inode.c */
-u64 btrfs_lookup_inode_ref(struct __btrfs_root *, u64, struct btrfs_inode_ref *,
+u64 __btrfs_lookup_inode_ref(struct __btrfs_root *, u64, struct btrfs_inode_ref *,
 			    char *);
-int btrfs_lookup_inode(const struct __btrfs_root *, struct btrfs_key *,
+int __btrfs_lookup_inode(const struct __btrfs_root *, struct btrfs_key *,
 		        struct btrfs_inode_item *, struct __btrfs_root *);
-int btrfs_readlink(const struct __btrfs_root *, u64, char *);
-u64 btrfs_lookup_path(struct __btrfs_root *, u64, const char *, u8 *,
+int __btrfs_readlink(const struct __btrfs_root *, u64, char *);
+u64 __btrfs_lookup_path(struct __btrfs_root *, u64, const char *, u8 *,
 		       struct btrfs_inode_item *, int);
 u64 btrfs_file_read(const struct __btrfs_root *, u64, u64, u64, char *);
 
diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index 4da88fc311..2dbeb90d33 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -22,6 +22,9 @@ static inline void error(const char *fmt, ...)
 
 #define BTRFS_UUID_UNPARSED_SIZE	37
 
+/* No <linux/limits.h> so have to define it here */
+#define XATTR_NAME_MAX		255
+
 /*
  * Macros to generate set/get funcs for the struct fields
  * assume there is a lefoo_to_cpu for every type, so lets make a simple
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b050b5844d..d635b0814e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1279,6 +1279,13 @@ size_t btrfs_super_num_csums(void);
 int btrfs_find_last_root(struct btrfs_root *root, u64 objectid,
 			struct btrfs_root_item *item, struct btrfs_key *key);
 
+/* dir-item.c */
+struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
+					     struct btrfs_root *root,
+					     struct btrfs_path *path, u64 dir,
+					     const char *name, int name_len,
+					     int mod);
+
 /* ctree.c */
 int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 enum btrfs_tree_block_status
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 756918df2e..aea621c72b 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -8,7 +8,7 @@
 #include "btrfs.h"
 #include "disk-io.h"
 
-static int verify_dir_item(struct btrfs_dir_item *item, u32 start, u32 total)
+static int __verify_dir_item(struct btrfs_dir_item *item, u32 start, u32 total)
 {
 	u16 max_len = BTRFS_NAME_LEN;
 	u32 end;
@@ -32,7 +32,7 @@ static int verify_dir_item(struct btrfs_dir_item *item, u32 start, u32 total)
 }
 
 static struct btrfs_dir_item *
-btrfs_match_dir_item_name(struct __btrfs_path *path, const char *name,
+__btrfs_match_dir_item_name(struct __btrfs_path *path, const char *name,
 			  int name_len)
 {
 	struct btrfs_dir_item *item;
@@ -48,7 +48,7 @@ btrfs_match_dir_item_name(struct __btrfs_path *path, const char *name,
 		this_len = sizeof(*item) + item->name_len + item->data_len;
 		name_ptr = (const char *) (item + 1);
 
-		if (verify_dir_item(item, cur, total_len))
+		if (__verify_dir_item(item, cur, total_len))
 			return NULL;
 		if (item->name_len == name_len && !memcmp(name_ptr, name,
 							  name_len))
@@ -61,7 +61,7 @@ btrfs_match_dir_item_name(struct __btrfs_path *path, const char *name,
 	return NULL;
 }
 
-int btrfs_lookup_dir_item(const struct __btrfs_root *root, u64 dir,
+int __btrfs_lookup_dir_item(const struct __btrfs_root *root, u64 dir,
 			  const char *name, int name_len,
 			  struct btrfs_dir_item *item)
 {
@@ -79,7 +79,7 @@ int btrfs_lookup_dir_item(const struct __btrfs_root *root, u64 dir,
 	if (btrfs_comp_keys_type(&key, btrfs_path_leaf_key(&path)))
 		goto out;
 
-	res = btrfs_match_dir_item_name(&path, name, name_len);
+	res = __btrfs_match_dir_item_name(&path, name, name_len);
 	if (res)
 		*item = *res;
 out:
@@ -110,7 +110,7 @@ int btrfs_readdir(const struct __btrfs_root *root, u64 dir,
 		item = btrfs_path_item_ptr(&path, struct btrfs_dir_item);
 		btrfs_dir_item_to_cpu(item);
 
-		if (verify_dir_item(item, 0, sizeof(*item) + item->name_len))
+		if (__verify_dir_item(item, 0, sizeof(*item) + item->name_len))
 			continue;
 		if (item->type == BTRFS_FT_XATTR)
 			continue;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index be385d8a3f..eb34f546b5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8,7 +8,7 @@
 #include "btrfs.h"
 #include <malloc.h>
 
-u64 btrfs_lookup_inode_ref(struct __btrfs_root *root, u64 inr,
+u64 __btrfs_lookup_inode_ref(struct __btrfs_root *root, u64 inr,
 			   struct btrfs_inode_ref *refp, char *name)
 {
 	struct __btrfs_path path;
@@ -44,7 +44,7 @@ out:
 	return res;
 }
 
-int btrfs_lookup_inode(const struct __btrfs_root *root,
+int __btrfs_lookup_inode(const struct __btrfs_root *root,
 		       struct btrfs_key *location,
 		       struct btrfs_inode_item *item,
 		       struct __btrfs_root *new_root)
@@ -83,7 +83,7 @@ out:
 	return res;
 }
 
-int btrfs_readlink(const struct __btrfs_root *root, u64 inr, char *target)
+int __btrfs_readlink(const struct __btrfs_root *root, u64 inr, char *target)
 {
 	struct __btrfs_path path;
 	struct btrfs_key key;
@@ -137,7 +137,7 @@ out:
 
 /* inr must be a directory (for regular files with multiple hard links this
    function returns only one of the parents of the file) */
-static u64 get_parent_inode(struct __btrfs_root *root, u64 inr,
+static u64 __get_parent_inode(struct __btrfs_root *root, u64 inr,
 			    struct btrfs_inode_item *inode_item)
 {
 	struct btrfs_key key;
@@ -164,14 +164,14 @@ static u64 get_parent_inode(struct __btrfs_root *root, u64 inr,
 			key.type = BTRFS_INODE_ITEM_KEY;
 			key.offset = 0;
 
-			if (btrfs_lookup_inode(root, &key, inode_item, NULL))
+			if (__btrfs_lookup_inode(root, &key, inode_item, NULL))
 				return -1ULL;
 		}
 
 		return inr;
 	}
 
-	res = btrfs_lookup_inode_ref(root, inr, NULL, NULL);
+	res = __btrfs_lookup_inode_ref(root, inr, NULL, NULL);
 	if (res == -1ULL)
 		return -1ULL;
 
@@ -180,7 +180,7 @@ static u64 get_parent_inode(struct __btrfs_root *root, u64 inr,
 		key.type = BTRFS_INODE_ITEM_KEY;
 		key.offset = 0;
 
-		if (btrfs_lookup_inode(root, &key, inode_item, NULL))
+		if (__btrfs_lookup_inode(root, &key, inode_item, NULL))
 			return -1ULL;
 	}
 
@@ -209,7 +209,7 @@ static inline const char *skip_current_directories(const char *cur)
 	return cur;
 }
 
-u64 btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
+u64 __btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
 		      u8 *type_p, struct btrfs_inode_item *inode_item_p,
 		      int symlink_limit)
 {
@@ -239,7 +239,7 @@ u64 btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
 
 		if (len == 2 && cur[0] == '.' && cur[1] == '.') {
 			cur += 2;
-			inr = get_parent_inode(root, inr, &inode_item);
+			inr = __get_parent_inode(root, inr, &inode_item);
 			if (inr == -1ULL)
 				return -1ULL;
 
@@ -250,12 +250,12 @@ u64 btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
 		if (!*cur)
 			break;
 		
-		if (btrfs_lookup_dir_item(root, inr, cur, len, &item))
+		if (__btrfs_lookup_dir_item(root, inr, cur, len, &item))
 			return -1ULL;
 
 		type = item.type;
 		have_inode = 1;
-		if (btrfs_lookup_inode(root, (struct btrfs_key *)&item.location,
+		if (__btrfs_lookup_inode(root, (struct btrfs_key *)&item.location,
 					&inode_item, root))
 			return -1ULL;
 
@@ -272,13 +272,13 @@ u64 btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
 			if (!target)
 				return -1ULL;
 
-			if (btrfs_readlink(root, item.location.objectid,
+			if (__btrfs_readlink(root, item.location.objectid,
 					   target)) {
 				free(target);
 				return -1ULL;
 			}
 
-			inr = btrfs_lookup_path(root, inr, target, &type,
+			inr = __btrfs_lookup_path(root, inr, target, &type,
 						&inode_item, symlink_limit - 1);
 
 			free(target);
@@ -307,7 +307,7 @@ u64 btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
 			key.type = BTRFS_INODE_ITEM_KEY;
 			key.offset = 0;
 
-			if (btrfs_lookup_inode(root, &key, &inode_item, NULL))
+			if (__btrfs_lookup_inode(root, &key, &inode_item, NULL))
 				return -1ULL;
 		}
 
diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index 72b847b940..0e72577d0d 100644
--- a/fs/btrfs/subvolume.c
+++ b/fs/btrfs/subvolume.c
@@ -39,7 +39,7 @@ static int get_subvol_name(u64 subvolid, char *name, int max_len)
 		dir = rref.dirid;
 
 		while (dir != BTRFS_FIRST_FREE_OBJECTID) {
-			dir = btrfs_lookup_inode_ref(&root, dir, &iref, tmp);
+			dir = __btrfs_lookup_inode_ref(&root, dir, &iref, tmp);
 
 			if (dir == -1ULL)
 				return -1;
@@ -71,7 +71,7 @@ u64 btrfs_get_default_subvol_objectid(void)
 {
 	struct btrfs_dir_item item;
 
-	if (btrfs_lookup_dir_item(&btrfs_info.tree_root,
+	if (__btrfs_lookup_dir_item(&btrfs_info.tree_root,
 				  btrfs_info.sb.root_dir_objectid, "default", 7,
 				  &item))
 		return BTRFS_FS_TREE_OBJECTID;
-- 
2.26.2

