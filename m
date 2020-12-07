Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9857F2D14C9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 16:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgLGPda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 10:33:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:45616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgLGPd1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Dec 2020 10:33:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607355161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w91hYQO26m7F01Z5wAop8ggPgcduATiDzADkVZ1Nf3w=;
        b=qAUs3u0af+D9XWTCORC+jvl6oCZXOEsqm0MKOZZBNUhJipWaZCqyRjgv4IRYHfn2sgd4Wl
        1DfQbrIB+zMCktdraXKk2hks0AT8kmfkHA7xm0uiY3mgHRTmevuRWSZkIK8anq6fPCDc/0
        skdViBE6naT/OOLHNJvWNyYxuK1hihE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 648B0AD3F;
        Mon,  7 Dec 2020 15:32:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/6] btrfs: Rename btrfs_find_free_objectid to btrfs_get_free_objectid
Date:   Mon,  7 Dec 2020 17:32:33 +0200
Message-Id: <20201207153237.1073887-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207153237.1073887-1-nborisov@suse.com>
References: <20201207153237.1073887-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This better reflects the semantics of the function i.e no search is
performed whatsoever.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c          |  2 +-
 fs/btrfs/disk-io.h          |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 12 ++++++------
 fs/btrfs/ioctl.c            |  2 +-
 fs/btrfs/relocation.c       |  2 +-
 fs/btrfs/transaction.c      |  2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c5353767edef..4c3dda0034b5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4776,7 +4776,7 @@ int btrfs_init_root_free_objectid(struct btrfs_root *root)
 	return ret;
 }
 
-int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid)
+int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 {
 	int ret;
 	mutex_lock(&root->objectid_mutex);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 5e5bc603fbdf..9f4a2a1e3d36 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -133,7 +133,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 int btree_lock_page_hook(struct page *page, void *data,
 				void (*flush_fn)(void *));
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
-int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid);
+int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid);
 int btrfs_init_root_free_objectid(struct btrfs_root *root);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index a62fdfa1de39..ebc3f0417f54 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -198,7 +198,7 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
 	int ret;
 	u64 ino;
 
-	ret = btrfs_find_free_objectid(trans->fs_info->tree_root, &ino);
+	ret = btrfs_get_free_objectid(trans->fs_info->tree_root, &ino);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 393c1232d949..0dee1fa29207 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6356,7 +6356,7 @@ static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_objectid(root, &objectid);
+	err = btrfs_get_free_objectid(root, &objectid);
 	if (err)
 		goto out_unlock;
 
@@ -6420,7 +6420,7 @@ static int btrfs_create(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_objectid(root, &objectid);
+	err = btrfs_get_free_objectid(root, &objectid);
 	if (err)
 		goto out_unlock;
 
@@ -6564,7 +6564,7 @@ static int btrfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_objectid(root, &objectid);
+	err = btrfs_get_free_objectid(root, &objectid);
 	if (err)
 		goto out_fail;
 
@@ -9064,7 +9064,7 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	u64 objectid;
 	u64 index;
 
-	ret = btrfs_find_free_objectid(root, &objectid);
+	ret = btrfs_get_free_objectid(root, &objectid);
 	if (ret)
 		return ret;
 
@@ -9534,7 +9534,7 @@ static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	err = btrfs_find_free_objectid(root, &objectid);
+	err = btrfs_get_free_objectid(root, &objectid);
 	if (err)
 		goto out_unlock;
 
@@ -9868,7 +9868,7 @@ static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_find_free_objectid(root, &objectid);
+	ret = btrfs_get_free_objectid(root, &objectid);
 	if (ret)
 		goto out;
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c23243c7800c..8ae38806211c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -613,7 +613,7 @@ static noinline int create_subvol(struct inode *dir,
 	if (!root_item)
 		return -ENOMEM;
 
-	ret = btrfs_find_free_objectid(fs_info->tree_root, &objectid);
+	ret = btrfs_get_free_objectid(fs_info->tree_root, &objectid);
 	if (ret)
 		goto fail_free;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19b7db8b2117..30a80669647f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3429,7 +3429,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 		return ERR_CAST(trans);
 	}
 
-	err = btrfs_find_free_objectid(root, &objectid);
+	err = btrfs_get_free_objectid(root, &objectid);
 	if (err)
 		goto out;
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b08283829abf..85cb619ba7d5 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1526,7 +1526,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	ASSERT(pending->root_item);
 	new_root_item = pending->root_item;
 
-	pending->error = btrfs_find_free_objectid(tree_root, &objectid);
+	pending->error = btrfs_get_free_objectid(tree_root, &objectid);
 	if (pending->error)
 		goto no_free_objectid;
 
-- 
2.25.1

