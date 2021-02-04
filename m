Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E2C31008F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 00:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBDXW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 18:22:59 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60127 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhBDXW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 18:22:58 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 90B0C5C00C3;
        Thu,  4 Feb 2021 18:21:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Feb 2021 18:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=fm3; bh=4SLAmn5htKo0Evn7FdMJHrnsjx
        OF5zuYJnK2ynnYI9E=; b=hn/R5poSnUpH2d5C1dLm+O54UvJnswE7GoWkEfIAxB
        X1s+oFMPg3bGNsCUJ4wbhOm5d5HeAB2kdQDIoczQhGXqF9RPyXHcFZzCtquEAAEL
        CC/MbDojmbdHWm9AlMKkYWMsW6w2KPt0isauzkEjbLZ5bSkb4Ma0kll0RZRhIyrG
        Rhb3nFyjeSapk3EmR3l18lugf9ukSge5UMVOARg6YswxllCTCkeWuIIZJ+tpP7t3
        zAn9guz5qd86jgs3Q+QnkMWRsfCTDJ4mT5EbnmZjP1kxGiWK0FIGO4DDRXAvjmBF
        98FBLI+xJAW6/01b17PljGzOduJAbTnL9csK2gPIgc9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4SLAmn5htKo0Evn7FdMJHrnsjxOF5zuYJnK2ynnYI9E=; b=dDfc/+8n
        5knZKvgeAh5dQ9EHqwQVPoH9lrZOhF3h/KfjO+jyw13JdnXZBI2OYFwAj7xpDJHt
        A2JJvViiYY4+WF65UAh7G1Ilez8ouYo0LZ6lEokdITLjBN3AKMA1zZYfOSntUHft
        qI53o7X3f8Fb2eIqh/S/Af5xcY/dImnO/YJ6ta1FCJ3he3bShjCUQOngMbyOTILV
        cGapux4sYedGQgzyfdPJ5Hw+N/JU/Ed+Tf6NNQn0R3qwPx/+grTXgJJtgBdc1KRw
        gXDxabZUHKDc9Mi+qcC4C4o3QgMqiuDpT6pG/iee1SNkyYyM9FSC4RIkORx0x7kx
        XAQl/x6kDcRi8w==
X-ME-Sender: <xms:j4EcYI8uh7TYZBHKssD7c1VRtuDBRCBfdagbNmcii-Jp4cDuRRXjkQ>
    <xme:j4EcYAtpLYfVt2Vc714hkGXOxtQZOhLINKaps8f2hZd1ib7JFiwrHoimDMeDWPzLn
    7v-_qLJIGnmdLFDxls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiue
    ffuedvieeujefhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucfkphep
    udeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:j4EcYODzObLCSc7JeXzhsumQXCfeIF9J5zFOi8zg52SnREkcfTAwjA>
    <xmx:j4EcYIeCK0ujdVFhRqsO4gLzQv6JZm9TVgfu5lLvdMZmDKmo1b-xnQ>
    <xmx:j4EcYNOhg7uIdXqrQx3UZrYmnJQyB1fXKRn5j9H62g5wbM5DC0IZRw>
    <xmx:j4EcYPWsnX-0roiQmHXxVQKlIIqBwUpL5YYLbqPTfWGfuXezyZ1cKA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 998C0108005B;
        Thu,  4 Feb 2021 18:21:50 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 2/5] btrfs: initial fsverity support
Date:   Thu,  4 Feb 2021 15:21:38 -0800
Message-Id: <88389022bd9f264f215c9d85fe48214190402fd6.1612475783.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1612475783.git.boris@bur.io>
References: <cover.1612475783.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chris Mason <clm@fb.com>

Add support for fsverity in btrfs. To support the generic interface in
fs/verity, we add two new item types in the fs tree for inodes with
verity enabled. One stores the per-file verity descriptor and the other
stores the Merkle tree data itself.

Verity checking is done at the end of IOs to ensure each page is checked
before it is marked uptodate.

Verity relies on PageChecked for the Merkle tree data itself to avoid
re-walking up shared paths in the tree. For this reason, we need to
cache the Merkle tree data. Since the file is immutable after verity is
turned on, we can cache it at an index past EOF.

Use the new inode compat_flags to store verity on the inode item, so
that we can enable verity on a file, then rollback to an older kernel
and still mount the file system and read the file.

Signed-off-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/Makefile               |   1 +
 fs/btrfs/btrfs_inode.h          |   1 +
 fs/btrfs/ctree.h                |  12 +-
 fs/btrfs/extent_io.c            |   5 +-
 fs/btrfs/file.c                 |   6 +
 fs/btrfs/inode.c                |  28 +-
 fs/btrfs/ioctl.c                |  14 +-
 fs/btrfs/super.c                |   1 +
 fs/btrfs/verity.c               | 527 ++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs_tree.h |   8 +
 10 files changed, 587 insertions(+), 16 deletions(-)
 create mode 100644 fs/btrfs/verity.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index e45957319424..1d77ebe1836b 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -33,6 +33,7 @@ btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
 btrfs-$(CONFIG_BLK_DEV_ZONED) += zoned.o
+btrfs-$(CONFIG_FS_VERITY) += verity.o
 
 btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/extent-buffer-tests.o tests/btrfs-tests.o \
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 8b95932f25a8..c0b0537bd50e 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -51,6 +51,7 @@ enum {
 	 * the file range, inode's io_tree).
 	 */
 	BTRFS_INODE_NO_DELALLOC_FLUSH,
+	BTRFS_INODE_VERITY_IN_PROGRESS,
 };
 
 /* in memory btrfs inode */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2f233591c3e3..7c3a4c10c426 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1471,6 +1471,11 @@ do {                                                                   \
 	 BTRFS_INODE_COMPRESS |						\
 	 BTRFS_INODE_ROOT_ITEM_INIT)
 
+/*
+ * Inode compat flags
+ */
+#define BTRFS_INODE_VERITY		(1 << 0)
+
 struct btrfs_map_token {
 	struct extent_buffer *eb;
 	char *kaddr;
@@ -3076,8 +3081,8 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
-int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
-			   struct page *page, u64 start, u64 end, int mirror);
+int btrfs_verify_data(struct btrfs_io_bio *io_bio, u32 bio_offset,
+		      struct page *page, u64 start, u64 end, int mirror);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
 					   u64 start, u64 len);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
@@ -3724,6 +3729,9 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
 
 #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
 
+/* verity.c */
+extern const struct fsverity_operations btrfs_verityops;
+
 /* Sanity test specific functions */
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 void btrfs_test_destroy_inode(struct inode *inode);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index edcdbd739a1e..7254387200a2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2918,9 +2918,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 		mirror = io_bio->mirror_num;
 		if (likely(uptodate)) {
 			if (is_data_inode(inode))
-				ret = btrfs_verify_data_csum(io_bio,
-						bio_offset, page, start, end,
-						mirror);
+				ret = btrfs_verify_data(io_bio, bio_offset,
+					page, start, end, mirror);
 			else
 				ret = btrfs_validate_metadata_buffer(io_bio,
 					page, start, end, mirror);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d81ae1f518f2..6c08bca09d62 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -16,6 +16,7 @@
 #include <linux/btrfs.h>
 #include <linux/uio.h>
 #include <linux/iversion.h>
+#include <linux/fsverity.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -3586,7 +3587,12 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
+	int ret;
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
+
+	ret = fsverity_file_open(inode, filp);
+	if (ret)
+		return ret;
 	return generic_file_open(inode, filp);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f97d4d5c03d8..a6bfe29449cc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -32,6 +32,7 @@
 #include <linux/sched/mm.h>
 #include <linux/iomap.h>
 #include <asm/unaligned.h>
+#include <linux/fsverity.h>
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
@@ -2996,31 +2997,32 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 }
 
 /*
- * When reads are done, we need to check csums to verify the data is correct.
- * if there's a match, we allow the bio to finish.  If not, the code in
- * extent_io.c will try to find good copies for us.
+ * When reads are done, we need to check csums and verity to verify the
+ * data is correct.  If there's a match, we allow the bio to finish.
+ * If not, the code in extent_io.c will try to find good copies for us.
  *
  * @bio_offset:	offset to the beginning of the bio (in bytes)
  * @start:	file offset of the range start
  * @end:	file offset of the range end (inclusive)
  * @mirror:	mirror number
  */
-int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
-			   struct page *page, u64 start, u64 end, int mirror)
+int btrfs_verify_data(struct btrfs_io_bio *io_bio, u32 bio_offset,
+		      struct page *page, u64 start, u64 end, int mirror)
 {
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	const u32 sectorsize = root->fs_info->sectorsize;
 	u32 pg_off;
+	int ret = 0;
 
 	if (PageChecked(page)) {
 		ClearPageChecked(page);
-		return 0;
+		goto check_verity;
 	}
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
-		return 0;
+		goto check_verity;
 
 	if (!root->fs_info->csum_root)
 		return 0;
@@ -3036,13 +3038,15 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 	for (pg_off = offset_in_page(start);
 	     pg_off < offset_in_page(end);
 	     pg_off += sectorsize, bio_offset += sectorsize) {
-		int ret;
 
 		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off);
 		if (ret < 0)
 			return -EIO;
 	}
-	return 0;
+check_verity:
+	if (!ret && fsverity_active(inode) && fsverity_verify_page(page) != true)
+		ret = -EIO;
+	return ret;
 }
 
 /*
@@ -5242,7 +5246,9 @@ void btrfs_evict_inode(struct inode *inode)
 
 	trace_btrfs_inode_evict(inode);
 
+
 	if (!root) {
+		fsverity_cleanup_inode(inode);
 		clear_inode(inode);
 		return;
 	}
@@ -5325,6 +5331,7 @@ void btrfs_evict_inode(struct inode *inode)
 	 * to retry these periodically in the future.
 	 */
 	btrfs_remove_delayed_node(BTRFS_I(inode));
+	fsverity_cleanup_inode(inode);
 	clear_inode(inode);
 }
 
@@ -8845,6 +8852,7 @@ static int btrfs_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_inode(path->dentry);
 	u32 blocksize = inode->i_sb->s_blocksize;
 	u32 bi_flags = BTRFS_I(inode)->flags;
+	u32 bi_compat_flags = BTRFS_I(inode)->compat_flags;
 
 	stat->result_mask |= STATX_BTIME;
 	stat->btime.tv_sec = BTRFS_I(inode)->i_otime.tv_sec;
@@ -8857,6 +8865,8 @@ static int btrfs_getattr(const struct path *path, struct kstat *stat,
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
 	if (bi_flags & BTRFS_INODE_NODUMP)
 		stat->attributes |= STATX_ATTR_NODUMP;
+	if (bi_compat_flags & BTRFS_INODE_VERITY)
+		stat->attributes |= STATX_ATTR_VERITY;
 
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 				  STATX_ATTR_COMPRESSED |
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c5e21e564921..80541951aa3e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -26,6 +26,7 @@
 #include <linux/btrfs.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
+#include <linux/fsverity.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "export.h"
@@ -105,6 +106,7 @@ static unsigned int btrfs_mask_fsflags_for_type(struct inode *inode,
 static unsigned int btrfs_inode_flags_to_fsflags(struct btrfs_inode *binode)
 {
 	unsigned int flags = binode->flags;
+	unsigned int compat_flags = binode->flags;
 	unsigned int iflags = 0;
 
 	if (flags & BTRFS_INODE_SYNC)
@@ -121,6 +123,8 @@ static unsigned int btrfs_inode_flags_to_fsflags(struct btrfs_inode *binode)
 		iflags |= FS_DIRSYNC_FL;
 	if (flags & BTRFS_INODE_NODATACOW)
 		iflags |= FS_NOCOW_FL;
+	if (compat_flags & BTRFS_INODE_VERITY)
+		iflags |= FS_VERITY_FL;
 
 	if (flags & BTRFS_INODE_NOCOMPRESS)
 		iflags |= FS_NOCOMP_FL;
@@ -148,10 +152,12 @@ void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
 		new_fl |= S_NOATIME;
 	if (binode->flags & BTRFS_INODE_DIRSYNC)
 		new_fl |= S_DIRSYNC;
+	if (binode->compat_flags & BTRFS_INODE_VERITY)
+		new_fl |= S_VERITY;
 
 	set_mask_bits(&inode->i_flags,
-		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC,
-		      new_fl);
+		      S_SYNC | S_APPEND | S_IMMUTABLE | S_NOATIME | S_DIRSYNC |
+		      S_VERITY, new_fl);
 }
 
 static int btrfs_ioctl_getflags(struct file *file, void __user *arg)
@@ -5021,6 +5027,10 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_subvol_rootref(file, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
+	case FS_IOC_ENABLE_VERITY:
+		return fsverity_ioctl_enable(file, (const void __user *)argp);
+	case FS_IOC_MEASURE_VERITY:
+		return fsverity_ioctl_measure(file, argp);
 	}
 
 	return -ENOTTY;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 12d7d3be7cd4..77fefff5eff1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1340,6 +1340,7 @@ static int btrfs_fill_super(struct super_block *sb,
 	sb->s_op = &btrfs_super_ops;
 	sb->s_d_op = &btrfs_dentry_operations;
 	sb->s_export_op = &btrfs_export_ops;
+	sb->s_vop = &btrfs_verityops;
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
new file mode 100644
index 000000000000..6f3dbaee81b7
--- /dev/null
+++ b/fs/btrfs/verity.c
@@ -0,0 +1,527 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Facebook.  All rights reserved.
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/xattr.h>
+#include <linux/security.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/iversion.h>
+#include <linux/fsverity.h>
+#include <linux/sched/mm.h>
+#include "ctree.h"
+#include "btrfs_inode.h"
+#include "transaction.h"
+#include "disk-io.h"
+#include "locking.h"
+
+/*
+ * Just like ext4, we cache the merkle tree in pages after EOF in the page
+ * cache.  Unlike ext4, we're storing these in dedicated btree items and
+ * not just shoving them after EOF in the file.  This means we'll need to
+ * do extra work to encrypt them once encryption is supported in btrfs,
+ * but btrfs has a lot of careful code around i_size and it seems better
+ * to make a new key type than try and adjust all of our expectations
+ * for i_size.
+ *
+ * fs verity items are stored under two different key types on disk.
+ *
+ * The descriptor items:
+ * [ inode objectid, BTRFS_VERITY_DESC_ITEM_KEY, offset ]
+ *
+ * These start at offset 0 and hold the fs verity descriptor.  They are opaque
+ * to btrfs, we just read and write them as a blob for the higher level
+ * verity code.  The most common size for this is 256 bytes.
+ *
+ * The merkle tree items:
+ * [ inode objectid, BTRFS_VERITY_MERKLE_ITEM_KEY, offset ]
+ *
+ * These also start at offset 0, and correspond to the merkle tree bytes.
+ * So when fsverity asks for page 0 of the merkle tree, we pull up one page
+ * starting at offset 0 for this key type.  These are also opaque to btrfs,
+ * we're blindly storing whatever fsverity sends down.
+ *
+ * This file is just reading and writing the various items whenever
+ * fsverity needs us to.
+ */
+
+/*
+ * drop all the items for this inode with this key_type.  Before
+ * doing a verity enable we cleanup any existing verity items.
+ *
+ * This is also used to clean up if a verity enable failed half way
+ * through
+ */
+static int drop_verity_items(struct btrfs_inode *inode, u8 key_type)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *root = inode->root;
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	int ret;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	while (1) {
+		trans = btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			goto out;
+		}
+
+		/*
+		 * walk backwards through all the items until we find one
+		 * that isn't from our key type or objectid
+		 */
+		key.objectid = btrfs_ino(inode);
+		key.offset = (u64)-1;
+		key.type = key_type;
+
+		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+		if (ret > 0) {
+			ret = 0;
+			/* no more keys of this type, we're done */
+			if (path->slots[0] == 0)
+				break;
+			path->slots[0]--;
+		} else if (ret < 0) {
+			break;
+		}
+
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+		/* no more keys of this type, we're done */
+		if (key.objectid != btrfs_ino(inode) || key.type != key_type)
+			break;
+
+		/*
+		 * this shouldn't be a performance sensitive function because
+		 * it's not used as part of truncate.  If it ever becomes
+		 * perf sensitive, change this to walk forward and bulk delete
+		 * items
+		 */
+		ret = btrfs_del_items(trans, root, path,
+				      path->slots[0], 1);
+		btrfs_release_path(path);
+		btrfs_end_transaction(trans);
+
+		if (ret)
+			goto out;
+	}
+
+	btrfs_end_transaction(trans);
+out:
+	btrfs_free_path(path);
+	return ret;
+
+}
+
+/*
+ * helper function to insert a single item.  Returns zero if all went
+ * well
+ */
+static int write_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
+			   const char *src, u64 len)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path *path;
+	struct btrfs_root *root = inode->root;
+	struct extent_buffer *leaf;
+	struct btrfs_key key;
+	u64 orig_len = len;
+	u64 copied = 0;
+	unsigned long copy_bytes;
+	unsigned long src_offset = 0;
+	void *data;
+	int ret;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	while (len > 0) {
+		trans = btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			break;
+		}
+
+		key.objectid = btrfs_ino(inode);
+		key.offset = offset;
+		key.type = key_type;
+
+		/*
+		 * insert 1K at a time mostly to be friendly for smaller
+		 * leaf size filesystems
+		 */
+		copy_bytes = min_t(u64, len, 1024);
+
+		ret = btrfs_insert_empty_item(trans, root, path, &key, copy_bytes);
+		if (ret) {
+			btrfs_end_transaction(trans);
+			break;
+		}
+
+		leaf = path->nodes[0];
+
+		data = btrfs_item_ptr(leaf, path->slots[0], void);
+		write_extent_buffer(leaf, src + src_offset,
+				    (unsigned long)data, copy_bytes);
+		offset += copy_bytes;
+		src_offset += copy_bytes;
+		len -= copy_bytes;
+		copied += copy_bytes;
+
+		btrfs_release_path(path);
+		btrfs_end_transaction(trans);
+	}
+
+	btrfs_free_path(path);
+
+	if (!ret && copied != orig_len)
+		ret = -EIO;
+	return ret;
+}
+
+/*
+ * helper function to read items from the btree.  This returns the number
+ * of bytes read or < 0 for errors.  We can return short reads if the
+ * items don't exist on disk or aren't big enough to fill the desired length
+ *
+ * Since we're potentially copying into page cache, passing dest_page
+ * will make us kmap_atomic that page and then use the kmap address instead
+ * of dest.
+ *
+ * pass dest == NULL to find out the size of all the items up to len bytes
+ * we'll just do the tree walk without copying anything
+ */
+static ssize_t read_key_bytes(struct btrfs_inode *inode, u8 key_type, u64 offset,
+			  char *dest, u64 len, struct page *dest_page)
+{
+	struct btrfs_path *path;
+	struct btrfs_root *root = inode->root;
+	struct extent_buffer *leaf;
+	struct btrfs_key key;
+	u64 item_end;
+	u64 copy_end;
+	u64 copied = 0;
+	u32 copy_offset;
+	unsigned long copy_bytes;
+	unsigned long dest_offset = 0;
+	void *data;
+	char *kaddr = dest;
+	int ret;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	if (dest_page)
+		path->reada = READA_FORWARD;
+
+	key.objectid = btrfs_ino(inode);
+	key.offset = offset;
+	key.type = key_type;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0) {
+		goto out;
+	} else if (ret > 0) {
+		ret = 0;
+		if (path->slots[0] == 0)
+			goto out;
+		path->slots[0]--;
+	}
+
+	while (len > 0) {
+		leaf = path->nodes[0];
+		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+
+		if (key.objectid != btrfs_ino(inode) ||
+		    key.type != key_type)
+			break;
+
+		item_end = btrfs_item_size_nr(leaf, path->slots[0]) + key.offset;
+
+		if (copied > 0) {
+			/*
+			 * once we've copied something, we want all of the items
+			 * to be sequential
+			 */
+			if (key.offset != offset)
+				break;
+		} else {
+			/*
+			 * our initial offset might be in the middle of an
+			 * item.  Make sure it all makes sense
+			 */
+			if (key.offset > offset)
+				break;
+			if (item_end <= offset)
+				break;
+		}
+
+		/* desc = NULL to just sum all the item lengths */
+		if (!dest)
+			copy_end = item_end;
+		else
+			copy_end = min(offset + len, item_end);
+
+		/* number of bytes in this item we want to copy */
+		copy_bytes = copy_end - offset;
+
+		/* offset from the start of item for copying */
+		copy_offset = offset - key.offset;
+
+		if (dest) {
+			if (dest_page)
+				kaddr = kmap_atomic(dest_page);
+
+			data = btrfs_item_ptr(leaf, path->slots[0], void);
+			read_extent_buffer(leaf, kaddr + dest_offset,
+					   (unsigned long)data + copy_offset,
+					   copy_bytes);
+
+			if (dest_page)
+				kunmap_atomic(kaddr);
+		}
+
+		offset += copy_bytes;
+		dest_offset += copy_bytes;
+		len -= copy_bytes;
+		copied += copy_bytes;
+
+		path->slots[0]++;
+		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
+			/*
+			 * we've reached the last slot in this leaf and we need
+			 * to go to the next leaf.
+			 */
+			ret = btrfs_next_leaf(root, path);
+			if (ret < 0) {
+				break;
+			} else if (ret > 0) {
+				ret = 0;
+				break;
+			}
+		}
+	}
+out:
+	btrfs_free_path(path);
+	if (!ret)
+		ret = copied;
+	return ret;
+}
+
+/*
+ * fsverity calls this to ask us to setup the inode for enabling.  We
+ * drop any existing verity items and set the in progress bit
+ */
+static int btrfs_begin_enable_verity(struct file *filp)
+{
+	struct inode *inode = file_inode(filp);
+	int ret;
+
+	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags))
+		return -EBUSY;
+
+	/*
+	 * ext4 adds the inode to the orphan list here, presumably because the
+	 * truncate done at orphan processing time will delete partial
+	 * measurements.  TODO: setup orphans
+	 */
+	set_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags);
+	ret = drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_DESC_ITEM_KEY);
+	if (ret)
+		goto err;
+
+	ret = drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags);
+	return ret;
+
+}
+
+/*
+ * fsverity calls this when it's done with all of the pages in the file
+ * and all of the merkle items have been inserted.  We write the
+ * descriptor and update the inode in the btree to reflect it's new life
+ * as a verity file
+ */
+static int btrfs_end_enable_verity(struct file *filp, const void *desc,
+				  size_t desc_size, u64 merkle_tree_size)
+{
+	struct btrfs_trans_handle *trans;
+	struct inode *inode = file_inode(filp);
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+	int ret;
+
+	if (desc != NULL) {
+		/* write out the descriptor */
+		ret = write_key_bytes(BTRFS_I(inode),
+				      BTRFS_VERITY_DESC_ITEM_KEY, 0,
+				      desc, desc_size);
+		if (ret)
+			goto out;
+
+		/* update our inode flags to include fs verity */
+		trans = btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			goto out;
+		}
+		BTRFS_I(inode)->compat_flags |= BTRFS_INODE_VERITY;
+		btrfs_sync_inode_flags_to_i_flags(inode);
+		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		btrfs_end_transaction(trans);
+	}
+
+out:
+	if (desc == NULL || ret) {
+		/* If we failed, drop all the verity items */
+		drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_DESC_ITEM_KEY);
+		drop_verity_items(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY);
+	}
+	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &BTRFS_I(inode)->runtime_flags);
+	return ret;
+}
+
+/*
+ * fsverity does a two pass setup for reading the descriptor, in the first pass
+ * it calls with buf_size = 0 to query the size of the descriptor,
+ * and then in the second pass it actually reads the descriptor off
+ * disk.
+ */
+static int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
+				       size_t buf_size)
+{
+	ssize_t ret = 0;
+
+	if (!buf_size) {
+		return read_key_bytes(BTRFS_I(inode),
+				     BTRFS_VERITY_DESC_ITEM_KEY,
+				     0, NULL, (u64)-1, NULL);
+	}
+
+	ret = read_key_bytes(BTRFS_I(inode),
+			     BTRFS_VERITY_DESC_ITEM_KEY, 0,
+			     buf, buf_size, NULL);
+	if (ret < 0)
+		return ret;
+
+	if (ret != buf_size)
+		return -EIO;
+
+	return buf_size;
+}
+
+/*
+ * reads and caches a merkle tree page.  These are stored in the btree,
+ * but we cache them in the inode's address space after EOF.
+ */
+static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
+					       pgoff_t index,
+					       unsigned long num_ra_pages)
+{
+	struct page *p;
+	u64 start = index << PAGE_SHIFT;
+	unsigned long mapping_index;
+	ssize_t ret;
+	int err;
+
+	/*
+	 * the file is readonly, so i_size can't change here.  We jump
+	 * some pages past the last page to cache our merkles.  The goal
+	 * is just to jump past any hugepages that might be mapped in.
+	 */
+	mapping_index = (i_size_read(inode) >> PAGE_SHIFT) + 2048 + index;
+again:
+	p = find_get_page_flags(inode->i_mapping, mapping_index, FGP_ACCESSED);
+	if (p) {
+		if (PageUptodate(p))
+			return p;
+
+		lock_page(p);
+		/*
+		 * we only insert uptodate pages, so !Uptodate has to be
+		 * an error
+		 */
+		if (!PageUptodate(p)) {
+			unlock_page(p);
+			put_page(p);
+			return ERR_PTR(-EIO);
+		}
+		unlock_page(p);
+		return p;
+	}
+
+	p = page_cache_alloc(inode->i_mapping);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * merkle item keys are indexed from byte 0 in the merkle tree.
+	 * they have the form:
+	 *
+	 * [ inode objectid, BTRFS_MERKLE_ITEM_KEY, offset in bytes ]
+	 */
+	ret = read_key_bytes(BTRFS_I(inode),
+			     BTRFS_VERITY_MERKLE_ITEM_KEY, start,
+			     page_address(p), PAGE_SIZE, p);
+	if (ret < 0) {
+		put_page(p);
+		return ERR_PTR(ret);
+	}
+
+	/* zero fill any bytes we didn't write into the page */
+	if (ret < PAGE_SIZE) {
+		char *kaddr = kmap_atomic(p);
+
+		memset(kaddr + ret, 0, PAGE_SIZE - ret);
+		kunmap_atomic(kaddr);
+	}
+	SetPageUptodate(p);
+	err = add_to_page_cache_lru(p, inode->i_mapping, mapping_index,
+				    mapping_gfp_mask(inode->i_mapping));
+
+	if (!err) {
+		/* inserted and ready for fsverity */
+		unlock_page(p);
+	} else {
+		put_page(p);
+		/* did someone race us into inserting this page? */
+		if (err == -EEXIST)
+			goto again;
+		p = ERR_PTR(err);
+	}
+	return p;
+}
+
+static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
+					u64 index, int log_blocksize)
+{
+	u64 start = index << log_blocksize;
+	u64 len = 1 << log_blocksize;
+
+	return write_key_bytes(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY,
+			       start, buf, len);
+}
+
+const struct fsverity_operations btrfs_verityops = {
+	.begin_enable_verity	= btrfs_begin_enable_verity,
+	.end_enable_verity	= btrfs_end_enable_verity,
+	.get_verity_descriptor	= btrfs_get_verity_descriptor,
+	.read_merkle_tree_page	= btrfs_read_merkle_tree_page,
+	.write_merkle_tree_block = btrfs_write_merkle_tree_block,
+};
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index ae25280316bd..e0071327a7d0 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -118,6 +118,14 @@
 #define BTRFS_INODE_REF_KEY		12
 #define BTRFS_INODE_EXTREF_KEY		13
 #define BTRFS_XATTR_ITEM_KEY		24
+
+/*
+ * fsverity has a descriptor per file, and then
+ * a number of sha or csum items indexed by offset in to the file.
+ */
+#define BTRFS_VERITY_DESC_ITEM_KEY	36
+#define BTRFS_VERITY_MERKLE_ITEM_KEY	37
+
 #define BTRFS_ORPHAN_ITEM_KEY		48
 /* reserve 2-15 close to the inode for later flexibility */
 
-- 
2.24.1

