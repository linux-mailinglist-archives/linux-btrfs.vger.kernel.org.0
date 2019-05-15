Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A6C1F593
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfEONaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 09:30:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:37982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfEONaI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 09:30:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B885AF93
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 13:30:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ADDFFDA866; Wed, 15 May 2019 15:31:06 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     fdmanana@suse.com, David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: fiemap: preallocate ulists for btrfs_check_shared
Date:   Wed, 15 May 2019 15:31:04 +0200
Message-Id: <20190515133104.1364-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_check_shared looks up parents of a given extent and uses ulists
for that. These are allocated and freed repeatedly. Preallocation in the
caller will avoid the overhead and also allow us to use the GFP_KERNEL
as it is happens before the extent locks are taken.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c   | 17 ++++++-----------
 fs/btrfs/backref.h   |  3 ++-
 fs/btrfs/extent_io.c | 15 +++++++++++++--
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 982152d3f920..89116afda7a2 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1465,12 +1465,11 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
  *
  * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
  */
-int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr)
+int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
+		struct ulist *roots, struct ulist *tmp)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
-	struct ulist *tmp = NULL;
-	struct ulist *roots = NULL;
 	struct ulist_iterator uiter;
 	struct ulist_node *node;
 	struct seq_list elem = SEQ_LIST_INIT(elem);
@@ -1481,12 +1480,8 @@ int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr)
 		.share_count = 0,
 	};
 
-	tmp = ulist_alloc(GFP_NOFS);
-	roots = ulist_alloc(GFP_NOFS);
-	if (!tmp || !roots) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	ulist_init(roots);
+	ulist_init(tmp);
 
 	trans = btrfs_attach_transaction(root);
 	if (IS_ERR(trans)) {
@@ -1527,8 +1522,8 @@ int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr)
 		up_read(&fs_info->commit_root_sem);
 	}
 out:
-	ulist_free(tmp);
-	ulist_free(roots);
+	ulist_release(roots);
+	ulist_release(tmp);
 	return ret;
 }
 
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 54d58988483a..777f61dc081e 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -57,7 +57,8 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 			  u64 start_off, struct btrfs_path *path,
 			  struct btrfs_inode_extref **ret_extref,
 			  u64 *found_off);
-int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr);
+int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
+		struct ulist *roots, struct ulist *tmp_ulist);
 
 int __init btrfs_prelim_ref_init(void);
 void __cold btrfs_prelim_ref_exit(void);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 13fca7bfc1f2..d70a602a5d48 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4557,6 +4557,13 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		return -ENOMEM;
 	path->leave_spinning = 1;
 
+	roots = ulist_alloc(GFP_KERNEL);
+	tmp_ulist = ulist_alloc(GFP_KERNEL);
+	if (!roots || !tmp_ulist) {
+		ret = -ENOMEM;
+		goto out_free_ulist;
+	}
+
 	start = round_down(start, btrfs_inode_sectorsize(inode));
 	len = round_up(max, btrfs_inode_sectorsize(inode)) - start;
 
@@ -4568,7 +4575,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			btrfs_ino(BTRFS_I(inode)), -1, 0);
 	if (ret < 0) {
 		btrfs_free_path(path);
-		return ret;
+		goto out_free_ulist;
 	} else {
 		WARN_ON(!ret);
 		if (ret == 1)
@@ -4677,7 +4684,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			 */
 			ret = btrfs_check_shared(root,
 						 btrfs_ino(BTRFS_I(inode)),
-						 bytenr);
+						 bytenr, roots, tmp_ulist);
 			if (ret < 0)
 				goto out_free;
 			if (ret)
@@ -4723,6 +4730,10 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	btrfs_free_path(path);
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, start + len - 1,
 			     &cached_state);
+
+out_free_ulist:
+	ulist_free(roots);
+	ulist_free(tmp_ulist);
 	return ret;
 }
 
-- 
2.21.0

