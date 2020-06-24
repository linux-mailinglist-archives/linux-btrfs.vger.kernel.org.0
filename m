Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC7207852
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404766AbgFXQD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404764AbgFXQD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:27 -0400
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC83C061795
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:25 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 4EB991409D1;
        Wed, 24 Jun 2020 18:03:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014603; bh=Tirt13ygOMCD7zdXoE1W489AWXLMMw52tieo6q8kWxM=;
        h=From:To:Date;
        b=E4jz4n3vYvU0bckcUJ578ESuiiFeSmfBg1TqQuxXbnA02Bm6fM8rB/OFvclqq+CzP
         C/7XtxFCyMjrw4VoSU6Ppk2osdzUcJrQKseLuHGiOgBkcqwjkKmNF4KBCdZPND8ymy
         oGHY0KawQGLNQghh17xBaFNMOKf06AzqW+b/71T8=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 11/30] fs: btrfs: Rename btrfs_root to __btrfs_root
Date:   Wed, 24 Jun 2020 18:02:57 +0200
Message-Id: <20200624160316.5001-12-marek.behun@nic.cz>
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

This is to avoid naming conflicts between extent buffer based
btrfs_root.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/btrfs.c     | 10 +++++-----
 fs/btrfs/btrfs.h     | 26 +++++++++++++-------------
 fs/btrfs/ctree.c     |  2 +-
 fs/btrfs/ctree.h     |  6 +++---
 fs/btrfs/dir-item.c  |  4 ++--
 fs/btrfs/inode.c     | 16 ++++++++--------
 fs/btrfs/root.c      |  2 +-
 fs/btrfs/subvolume.c |  2 +-
 8 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 78a32497b5..b4535c9551 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -15,7 +15,7 @@
 
 struct btrfs_info btrfs_info;
 
-static int readdir_callback(const struct btrfs_root *root,
+static int readdir_callback(const struct __btrfs_root *root,
 			    struct btrfs_dir_item *item)
 {
 	static const char typestr[BTRFS_FT_MAX][4] = {
@@ -116,7 +116,7 @@ int btrfs_probe(struct blk_desc *fs_dev_desc,
 
 int btrfs_ls(const char *path)
 {
-	struct btrfs_root root = btrfs_info.fs_root;
+	struct __btrfs_root root = btrfs_info.fs_root;
 	u64 inr;
 	u8 type;
 
@@ -142,7 +142,7 @@ int btrfs_ls(const char *path)
 
 int btrfs_exists(const char *file)
 {
-	struct btrfs_root root = btrfs_info.fs_root;
+	struct __btrfs_root root = btrfs_info.fs_root;
 	u64 inr;
 	u8 type;
 
@@ -153,7 +153,7 @@ int btrfs_exists(const char *file)
 
 int btrfs_size(const char *file, loff_t *size)
 {
-	struct btrfs_root root = btrfs_info.fs_root;
+	struct __btrfs_root root = btrfs_info.fs_root;
 	struct btrfs_inode_item inode;
 	u64 inr;
 	u8 type;
@@ -178,7 +178,7 @@ int btrfs_size(const char *file, loff_t *size)
 int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 	       loff_t *actread)
 {
-	struct btrfs_root root = btrfs_info.fs_root;
+	struct __btrfs_root root = btrfs_info.fs_root;
 	struct btrfs_inode_item inode;
 	u64 inr, rd;
 	u8 type;
diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index a52fd34489..ae29226e9a 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -14,9 +14,9 @@
 struct btrfs_info {
 	struct btrfs_super_block sb;
 
-	struct btrfs_root tree_root;
-	struct btrfs_root fs_root;
-	struct btrfs_root chunk_root;
+	struct __btrfs_root tree_root;
+	struct __btrfs_root fs_root;
+	struct __btrfs_root chunk_root;
 
 	struct rb_root chunks_root;
 };
@@ -42,26 +42,26 @@ u32 btrfs_decompress(u8 type, const char *, u32, char *, u32);
 int btrfs_read_superblock(void);
 
 /* dir-item.c */
-typedef int (*btrfs_readdir_callback_t)(const struct btrfs_root *,
+typedef int (*btrfs_readdir_callback_t)(const struct __btrfs_root *,
 					struct btrfs_dir_item *);
 
-int btrfs_lookup_dir_item(const struct btrfs_root *, u64, const char *, int,
+int btrfs_lookup_dir_item(const struct __btrfs_root *, u64, const char *, int,
 			   struct btrfs_dir_item *);
-int btrfs_readdir(const struct btrfs_root *, u64, btrfs_readdir_callback_t);
+int btrfs_readdir(const struct __btrfs_root *, u64, btrfs_readdir_callback_t);
 
 /* root.c */
-int btrfs_find_root(u64, struct btrfs_root *, struct btrfs_root_item *);
+int btrfs_find_root(u64, struct __btrfs_root *, struct btrfs_root_item *);
 u64 btrfs_lookup_root_ref(u64, struct btrfs_root_ref *, char *);
 
 /* inode.c */
-u64 btrfs_lookup_inode_ref(struct btrfs_root *, u64, struct btrfs_inode_ref *,
+u64 btrfs_lookup_inode_ref(struct __btrfs_root *, u64, struct btrfs_inode_ref *,
 			    char *);
-int btrfs_lookup_inode(const struct btrfs_root *, struct btrfs_key *,
-		        struct btrfs_inode_item *, struct btrfs_root *);
-int btrfs_readlink(const struct btrfs_root *, u64, char *);
-u64 btrfs_lookup_path(struct btrfs_root *, u64, const char *, u8 *,
+int btrfs_lookup_inode(const struct __btrfs_root *, struct btrfs_key *,
+		        struct btrfs_inode_item *, struct __btrfs_root *);
+int btrfs_readlink(const struct __btrfs_root *, u64, char *);
+u64 btrfs_lookup_path(struct __btrfs_root *, u64, const char *, u8 *,
 		       struct btrfs_inode_item *, int);
-u64 btrfs_file_read(const struct btrfs_root *, u64, u64, u64, char *);
+u64 btrfs_file_read(const struct __btrfs_root *, u64, u64, u64, char *);
 
 /* subvolume.c */
 u64 btrfs_get_default_subvol_objectid(void);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7bd12c2a1b..2956fe2cea 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -181,7 +181,7 @@ static int read_tree_node(u64 physical, union btrfs_tree_node **buf)
 	return 0;
 }
 
-int btrfs_search_tree(const struct btrfs_root *root, struct btrfs_key *key,
+int btrfs_search_tree(const struct __btrfs_root *root, struct btrfs_key *key,
 		      struct __btrfs_path *p)
 {
 	u8 lvl, prev_lvl;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4562be9381..0aa6b49a65 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1182,7 +1182,7 @@ struct __btrfs_path {
 	u32 slots[BTRFS_MAX_LEVEL];
 };
 
-struct btrfs_root {
+struct __btrfs_root {
 	u64 objectid;
 	u64 bytenr;
 	u64 root_dirid;
@@ -1192,7 +1192,7 @@ int __btrfs_comp_keys(struct btrfs_key *, struct btrfs_key *);
 int btrfs_comp_keys_type(struct btrfs_key *, struct btrfs_key *);
 int btrfs_bin_search(union btrfs_tree_node *, struct btrfs_key *, int *);
 void __btrfs_free_path(struct __btrfs_path *);
-int btrfs_search_tree(const struct btrfs_root *, struct btrfs_key *,
+int btrfs_search_tree(const struct __btrfs_root *, struct btrfs_key *,
 		      struct __btrfs_path *);
 int btrfs_prev_slot(struct __btrfs_path *);
 int btrfs_next_slot(struct __btrfs_path *);
@@ -1203,7 +1203,7 @@ static inline struct btrfs_key *btrfs_path_leaf_key(struct __btrfs_path *p) {
 }
 
 static inline struct btrfs_key *
-btrfs_search_tree_key_type(const struct btrfs_root *root, u64 objectid,
+btrfs_search_tree_key_type(const struct __btrfs_root *root, u64 objectid,
 			   u8 type, struct __btrfs_path *path)
 {
 	struct btrfs_key key, *res;
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 5595542dab..756918df2e 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -61,7 +61,7 @@ btrfs_match_dir_item_name(struct __btrfs_path *path, const char *name,
 	return NULL;
 }
 
-int btrfs_lookup_dir_item(const struct btrfs_root *root, u64 dir,
+int btrfs_lookup_dir_item(const struct __btrfs_root *root, u64 dir,
 			  const char *name, int name_len,
 			  struct btrfs_dir_item *item)
 {
@@ -87,7 +87,7 @@ out:
 	return res ? 0 : -1;
 }
 
-int btrfs_readdir(const struct btrfs_root *root, u64 dir,
+int btrfs_readdir(const struct __btrfs_root *root, u64 dir,
 		  btrfs_readdir_callback_t callback)
 {
 	struct __btrfs_path path;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c0778726a0..be385d8a3f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8,7 +8,7 @@
 #include "btrfs.h"
 #include <malloc.h>
 
-u64 btrfs_lookup_inode_ref(struct btrfs_root *root, u64 inr,
+u64 btrfs_lookup_inode_ref(struct __btrfs_root *root, u64 inr,
 			   struct btrfs_inode_ref *refp, char *name)
 {
 	struct __btrfs_path path;
@@ -44,12 +44,12 @@ out:
 	return res;
 }
 
-int btrfs_lookup_inode(const struct btrfs_root *root,
+int btrfs_lookup_inode(const struct __btrfs_root *root,
 		       struct btrfs_key *location,
 		       struct btrfs_inode_item *item,
-		       struct btrfs_root *new_root)
+		       struct __btrfs_root *new_root)
 {
-	struct btrfs_root tmp_root = *root;
+	struct __btrfs_root tmp_root = *root;
 	struct __btrfs_path path;
 	int res = -1;
 
@@ -83,7 +83,7 @@ out:
 	return res;
 }
 
-int btrfs_readlink(const struct btrfs_root *root, u64 inr, char *target)
+int btrfs_readlink(const struct __btrfs_root *root, u64 inr, char *target)
 {
 	struct __btrfs_path path;
 	struct btrfs_key key;
@@ -137,7 +137,7 @@ out:
 
 /* inr must be a directory (for regular files with multiple hard links this
    function returns only one of the parents of the file) */
-static u64 get_parent_inode(struct btrfs_root *root, u64 inr,
+static u64 get_parent_inode(struct __btrfs_root *root, u64 inr,
 			    struct btrfs_inode_item *inode_item)
 {
 	struct btrfs_key key;
@@ -209,7 +209,7 @@ static inline const char *skip_current_directories(const char *cur)
 	return cur;
 }
 
-u64 btrfs_lookup_path(struct btrfs_root *root, u64 inr, const char *path,
+u64 btrfs_lookup_path(struct __btrfs_root *root, u64 inr, const char *path,
 		      u8 *type_p, struct btrfs_inode_item *inode_item_p,
 		      int symlink_limit)
 {
@@ -317,7 +317,7 @@ u64 btrfs_lookup_path(struct btrfs_root *root, u64 inr, const char *path,
 	return inr;
 }
 
-u64 btrfs_file_read(const struct btrfs_root *root, u64 inr, u64 offset,
+u64 btrfs_file_read(const struct __btrfs_root *root, u64 inr, u64 offset,
 		    u64 size, char *buf)
 {
 	struct __btrfs_path path;
diff --git a/fs/btrfs/root.c b/fs/btrfs/root.c
index 9b5f645015..a424966df6 100644
--- a/fs/btrfs/root.c
+++ b/fs/btrfs/root.c
@@ -31,7 +31,7 @@ static void read_root_item(struct __btrfs_path *p, struct btrfs_root_item *item)
 	}
 }
 
-int btrfs_find_root(u64 objectid, struct btrfs_root *root,
+int btrfs_find_root(u64 objectid, struct __btrfs_root *root,
 		    struct btrfs_root_item *root_item)
 {
 	struct __btrfs_path path;
diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
index fa5ef1e0ac..72b847b940 100644
--- a/fs/btrfs/subvolume.c
+++ b/fs/btrfs/subvolume.c
@@ -12,7 +12,7 @@ static int get_subvol_name(u64 subvolid, char *name, int max_len)
 {
 	struct btrfs_root_ref rref;
 	struct btrfs_inode_ref iref;
-	struct btrfs_root root;
+	struct __btrfs_root root;
 	u64 dir;
 	char tmp[BTRFS_NAME_LEN];
 	char *ptr;
-- 
2.26.2

