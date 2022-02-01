Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8E4A5E7F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 15:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiBAOmz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 09:42:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45912 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiBAOmy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 09:42:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3E0541F37E;
        Tue,  1 Feb 2022 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643726573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=e6W+4SxrN7ihOpG758EFrLmYiRpwZg4z9B7QN6DGo4M=;
        b=tKsxOpa0YCO5Ux4xduxKZhHJgFMsu2n+it8rJdwj+i//q8HeGpu0feWC3nGh/eChw0CEdc
        3kQ1Jb3OnKz9BkPxifw/3NC51U1k+MbXko/YHcA8sLUVjxwUsblUJsR6hUzoOuHp78WgC3
        hu2l/x3AsRtsjmTkg8tQO3LxkcH88Pg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 36394A3B81;
        Tue,  1 Feb 2022 14:42:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32BC4DA7A9; Tue,  1 Feb 2022 15:42:09 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: replace BUILD_BUG_ON by static_assert
Date:   Tue,  1 Feb 2022 15:42:07 +0100
Message-Id: <20220201144207.11721-1-dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The static_assert introduced in 6bab69c65013 ("build_bug.h: add wrapper
for _Static_assert") has been supported by compilers for a long time
(gcc 4.6, clang 3.0) and can be used in header files. We don't need to
put BUILD_BUG_ON to random functions but rather keep it next to the
definition.

The exception here is the UAPI header btrfs_tree.h that could be
potentially included by userspace code and the static assert is not
defined (nor used in any other header).

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.h |  2 ++
 fs/btrfs/ctree.h       | 16 ++++++++--------
 fs/btrfs/inode.c       | 23 +++++++++--------------
 fs/btrfs/ioctl.c       |  5 +----
 fs/btrfs/sysfs.c       | 10 +++++-----
 5 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 56eef0821e3e..7dbd14caab01 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -22,6 +22,8 @@ struct btrfs_inode;
 
 /* Maximum length of compressed data stored on disk */
 #define BTRFS_MAX_COMPRESSED		(SZ_128K)
+static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) == 0);
+
 /* Maximum size of data before compression */
 #define BTRFS_MAX_UNCOMPRESSED		(SZ_128K)
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 80eb08f0a1cb..9f7a950b8a69 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1629,25 +1629,25 @@ DECLARE_BTRFS_SETGET_BITS(64)
 static inline u##bits btrfs_##name(const struct extent_buffer *eb,	\
 				   const type *s)			\
 {									\
-	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
+	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	return btrfs_get_##bits(eb, s, offsetof(type, member));		\
 }									\
 static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
 				    u##bits val)			\
 {									\
-	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
+	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
 }									\
 static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
 					 const type *s)			\
 {									\
-	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
+	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
 }									\
 static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
 					  type *s, u##bits val)		\
 {									\
-	BUILD_BUG_ON(sizeof(u##bits) != sizeof(((type *)0))->member);	\
+	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
 }
 
@@ -1678,8 +1678,8 @@ static inline void btrfs_set_##name(type *s, u##bits val)		\
 static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
 					   struct btrfs_dev_item *s)
 {
-	BUILD_BUG_ON(sizeof(u64) !=
-		     sizeof(((struct btrfs_dev_item *)0))->total_bytes);
+	static_assert(sizeof(u64) ==
+		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
 	return btrfs_get_64(eb, s, offsetof(struct btrfs_dev_item,
 					    total_bytes));
 }
@@ -1687,8 +1687,8 @@ static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 						struct btrfs_dev_item *s,
 						u64 val)
 {
-	BUILD_BUG_ON(sizeof(u64) !=
-		     sizeof(((struct btrfs_dev_item *)0))->total_bytes);
+	static_assert(sizeof(u64) ==
+		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
 	WARN_ON(!IS_ALIGNED(val, eb->fs_info->sectorsize));
 	btrfs_set_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes), val);
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0e04624e557d..94342ad74171 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -629,7 +629,6 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 again:
 	will_compress = 0;
 	nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
-	BUILD_BUG_ON((BTRFS_MAX_COMPRESSED % PAGE_SIZE) != 0);
 	nr_pages = min_t(unsigned long, nr_pages,
 			BTRFS_MAX_COMPRESSED / PAGE_SIZE);
 
@@ -5609,21 +5608,17 @@ static struct inode *new_simple_dir(struct super_block *s,
 	return inode;
 }
 
+static_assert(BTRFS_FT_UNKNOWN == FT_UNKNOWN);
+static_assert(BTRFS_FT_REG_FILE == FT_REG_FILE);
+static_assert(BTRFS_FT_DIR == FT_DIR);
+static_assert(BTRFS_FT_CHRDEV == FT_CHRDEV);
+static_assert(BTRFS_FT_BLKDEV == FT_BLKDEV);
+static_assert(BTRFS_FT_FIFO == FT_FIFO);
+static_assert(BTRFS_FT_SOCK == FT_SOCK);
+static_assert(BTRFS_FT_SYMLINK == FT_SYMLINK);
+
 static inline u8 btrfs_inode_type(struct inode *inode)
 {
-	/*
-	 * Compile-time asserts that generic FT_* types still match
-	 * BTRFS_FT_* types
-	 */
-	BUILD_BUG_ON(BTRFS_FT_UNKNOWN != FT_UNKNOWN);
-	BUILD_BUG_ON(BTRFS_FT_REG_FILE != FT_REG_FILE);
-	BUILD_BUG_ON(BTRFS_FT_DIR != FT_DIR);
-	BUILD_BUG_ON(BTRFS_FT_CHRDEV != FT_CHRDEV);
-	BUILD_BUG_ON(BTRFS_FT_BLKDEV != FT_BLKDEV);
-	BUILD_BUG_ON(BTRFS_FT_FIFO != FT_FIFO);
-	BUILD_BUG_ON(BTRFS_FT_SOCK != FT_SOCK);
-	BUILD_BUG_ON(BTRFS_FT_SYMLINK != FT_SYMLINK);
-
 	return fs_umode_to_ftype(inode->i_mode);
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d427140280aa..d5ad71975f1e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1320,6 +1320,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 }
 
 #define CLUSTER_SIZE	(SZ_256K)
+static_assert(IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
 
 /*
  * Defrag one contiguous target range.
@@ -1463,7 +1464,6 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 	LIST_HEAD(target_list);
 	int ret;
 
-	BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
 	ret = defrag_collect_targets(inode, start, len, extent_thresh,
 				     newer_than, do_compress, false,
 				     &target_list);
@@ -1593,9 +1593,6 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		const unsigned long prev_sectors_defragged = sectors_defragged;
 		u64 cluster_end;
 
-		/* The cluster size 256K should always be page aligned */
-		BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
-
 		if (btrfs_defrag_cancelled(fs_info)) {
 			ret = -EAGAIN;
 			break;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5f4812fd8b50..17389a42a3ab 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1107,6 +1107,11 @@ static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj)
 static char btrfs_unknown_feature_names[FEAT_MAX][NUM_FEATURE_BITS][BTRFS_FEATURE_NAME_MAX];
 static struct btrfs_feature_attr btrfs_feature_attrs[FEAT_MAX][NUM_FEATURE_BITS];
 
+static_assert(ARRAY_SIZE(btrfs_unknown_feature_names) ==
+	      ARRAY_SIZE(btrfs_feature_attrs));
+static_assert(ARRAY_SIZE(btrfs_unknown_feature_names[0]) ==
+	      ARRAY_SIZE(btrfs_feature_attrs[0]));
+
 static const u64 supported_feature_masks[FEAT_MAX] = {
 	[FEAT_COMPAT]    = BTRFS_FEATURE_COMPAT_SUPP,
 	[FEAT_COMPAT_RO] = BTRFS_FEATURE_COMPAT_RO_SUPP,
@@ -1275,11 +1280,6 @@ static void init_feature_attrs(void)
 	struct btrfs_feature_attr *fa;
 	int set, i;
 
-	BUILD_BUG_ON(ARRAY_SIZE(btrfs_unknown_feature_names) !=
-		     ARRAY_SIZE(btrfs_feature_attrs));
-	BUILD_BUG_ON(ARRAY_SIZE(btrfs_unknown_feature_names[0]) !=
-		     ARRAY_SIZE(btrfs_feature_attrs[0]));
-
 	memset(btrfs_feature_attrs, 0, sizeof(btrfs_feature_attrs));
 	memset(btrfs_unknown_feature_names, 0,
 	       sizeof(btrfs_unknown_feature_names));
-- 
2.34.1

