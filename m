Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1804115390
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLFOqw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:52 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43607 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfLFOqw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:52 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so2719248qvo.10
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BNEOYl0NHYkyE02GwcbxQAyBPTQ+49Ktcl+xwDOY8ho=;
        b=QGPmu85z6K2vhBHL7xt+UY/NSjgfyip0Mzb/mkOBJX7nDYUfeuOUCCBGM0uqddBhg7
         xcHkPDHwHNSe3w0C86hpVmRwf2Tme/i3PswMDISQz3oT2bA/AQrefXETxgL6L45+BasO
         B3s+5wVGfpovJv1F6TvGecU9Qgm5np+a6jaL4IEq3EvS3YTEL4IyyI0jF+d1s84uDa3h
         COA092fiKJAIYTCw20t2G9LFPii8/gjw3j06G6NTqJMvTqO6/ODJqKjCI4Nz4xVZvutR
         JPzaNuA+h+DOnCmXspZ0aPTv8HvGYP1MdmPEzo0Rx8Ospame6vS3v5QMQDxXIZh76YK6
         qIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNEOYl0NHYkyE02GwcbxQAyBPTQ+49Ktcl+xwDOY8ho=;
        b=dbW9Rdt3SevbZMM/sf0/+fHSQA+Ru4/lxUFU+JCmLb7WNns14uXd2F4+odlGjPVN9D
         saKEHuHyNFvIUTXaraRTCD1LzPCEXSR2OGQ0zWWnSG5EQ8zKWQuZEPvrPiEPTbH74OkV
         P1cjRq35Hfq6I5FjSLnl3UBJdeV2urcSREm5FQsBQI+l4fKUWp8dSxKxKY4YovAeTpLY
         lxYQ///kbJZWK6MidSIRgs2DYRCBsUB6lx3vBo1ep86dxyx9Hh4lMM4YJdym7XnXPGpk
         W4tA2Sb8+mTjK9uidTxUP03vPM3TXT/CoY/HTnK8notgQ2W0o+YQFMqnxFuXEvAHYeVQ
         VTUg==
X-Gm-Message-State: APjAAAWS55QmcESO0ICSBiI9T669tGd0dwUDSluWZ+i39bTiFJXKYDy4
        KhmbIp5YjSnEkncnPs29/V6qVXUsVTFlyw==
X-Google-Smtp-Source: APXvYqzOmNpqrL7GLaD2CCR3BGhBxtFJhUupqVCGNRdzlDKHXjUWm0Cf4Np3X6+9yyZpBSPUOPLWRQ==
X-Received: by 2002:a05:6214:1804:: with SMTP id o4mr12577626qvw.3.1575643610718;
        Fri, 06 Dec 2019 06:46:50 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r37sm6428323qtj.44.2019.12.06.06.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 40/44] btrfs: push btrfs_grab_fs_root into btrfs_get_fs_root
Date:   Fri,  6 Dec 2019 09:45:34 -0500
Message-Id: <20191206144538.168112-41-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that all callers of btrfs_get_fs_root are subsequently calling
btrfs_grab_fs_root and handling dropping the ref when they are done
appropriately, go ahead and push btrfs_grab_fs_root up into
btrfs_get_fs_root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c     |  6 ------
 fs/btrfs/disk-io.c     | 48 +++++++++++++++++++++++++-----------------
 fs/btrfs/export.c      |  4 ----
 fs/btrfs/file.c        |  4 ----
 fs/btrfs/inode.c       |  9 --------
 fs/btrfs/ioctl.c       | 26 -----------------------
 fs/btrfs/relocation.c  |  8 +------
 fs/btrfs/root-tree.c   |  2 --
 fs/btrfs/scrub.c       |  4 ----
 fs/btrfs/send.c        | 11 ----------
 fs/btrfs/super.c       |  4 ----
 fs/btrfs/transaction.c |  6 ------
 fs/btrfs/tree-log.c    |  4 ----
 fs/btrfs/volumes.c     |  4 ----
 14 files changed, 30 insertions(+), 110 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 193747b6e1f9..b69154d72529 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -527,12 +527,6 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 		goto out_free;
 	}
 
-	if (!btrfs_grab_fs_root(root)) {
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
-		ret = -ENOENT;
-		goto out_free;
-	}
-
 	if (btrfs_is_testing(fs_info)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		ret = -ENOENT;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b7a2c570c438..adcabd6d3a92 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1498,6 +1498,8 @@ static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	root = radix_tree_lookup(&fs_info->fs_roots_radix,
 				 (unsigned long)root_id);
+	if (root)
+		root = btrfs_grab_fs_root(root);
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 	return root;
 }
@@ -1554,29 +1556,34 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	int ret;
 
 	if (location->objectid == BTRFS_ROOT_TREE_OBJECTID)
-		return fs_info->tree_root;
+		return btrfs_grab_fs_root(fs_info->tree_root);
 	if (location->objectid == BTRFS_EXTENT_TREE_OBJECTID)
-		return fs_info->extent_root;
+		return btrfs_grab_fs_root(fs_info->extent_root);
 	if (location->objectid == BTRFS_CHUNK_TREE_OBJECTID)
-		return fs_info->chunk_root;
+		return btrfs_grab_fs_root(fs_info->chunk_root);
 	if (location->objectid == BTRFS_DEV_TREE_OBJECTID)
-		return fs_info->dev_root;
+		return btrfs_grab_fs_root(fs_info->dev_root);
 	if (location->objectid == BTRFS_CSUM_TREE_OBJECTID)
-		return fs_info->csum_root;
+		return btrfs_grab_fs_root(fs_info->csum_root);
 	if (location->objectid == BTRFS_QUOTA_TREE_OBJECTID)
-		return fs_info->quota_root ? fs_info->quota_root :
-					     ERR_PTR(-ENOENT);
+		return fs_info->quota_root ?
+			btrfs_grab_fs_root(fs_info->quota_root) :
+			ERR_PTR(-ENOENT);
 	if (location->objectid == BTRFS_UUID_TREE_OBJECTID)
-		return fs_info->uuid_root ? fs_info->uuid_root :
-					    ERR_PTR(-ENOENT);
+		return fs_info->uuid_root ?
+			btrfs_grab_fs_root(fs_info->uuid_root) :
+			ERR_PTR(-ENOENT);
 	if (location->objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
-		return fs_info->free_space_root ? fs_info->free_space_root :
-						  ERR_PTR(-ENOENT);
+		return fs_info->free_space_root ?
+			btrfs_grab_fs_root(fs_info->free_space_root) :
+			ERR_PTR(-ENOENT);
 again:
 	root = btrfs_lookup_fs_root(fs_info, location->objectid);
 	if (root) {
-		if (check_ref && btrfs_root_refs(&root->root_item) == 0)
+		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
+			btrfs_put_fs_root(root);
 			return ERR_PTR(-ENOENT);
+		}
 		return root;
 	}
 
@@ -1609,8 +1616,18 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	if (ret == 0)
 		set_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state);
 
+	/*
+	 * All roots have two refs on them at all times, one for the mounted fs,
+	 * and one for being in the radix tree.  This way we only free the root
+	 * when we are unmounting or deleting the subvolume.  We get one ref
+	 * from __setup_root, one for inserting it into the radix tree, and then
+	 * we have the third for returning it, and the caller will put it when
+	 * it's done with the root.
+	 */
+	btrfs_grab_fs_root(root);
 	ret = btrfs_insert_fs_root(fs_info, root);
 	if (ret) {
+		btrfs_put_fs_root(root);
 		if (ret == -EEXIST) {
 			btrfs_free_fs_root(root);
 			goto again;
@@ -3207,13 +3224,6 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_qgroup;
 	}
 
-	if (!btrfs_grab_fs_root(fs_info->fs_root)) {
-		fs_info->fs_root = NULL;
-		err = -ENOENT;
-		btrfs_warn(fs_info, "failed to grab a ref on the fs tree");
-		goto fail_qgroup;
-	}
-
 	if (sb_rdonly(sb))
 		return 0;
 
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index eba6c6d27bad..f07c2300ade2 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -82,10 +82,6 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 		err = PTR_ERR(root);
 		goto fail;
 	}
-	if (!btrfs_grab_fs_root(root)) {
-		err = -ENOENT;
-		goto fail;
-	}
 
 	key.objectid = objectid;
 	key.type = BTRFS_INODE_ITEM_KEY;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f8e16f44a970..062580a1721f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -292,10 +292,6 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		ret = PTR_ERR(inode_root);
 		goto cleanup;
 	}
-	if (!btrfs_grab_fs_root(inode_root)) {
-		ret = -ENOENT;
-		goto cleanup;
-	}
 
 	key.objectid = defrag->ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5fa39ac23472..bc961ca6995f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2523,8 +2523,6 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 			 inum, offset, root_id);
 		return PTR_ERR(root);
 	}
-	if (!btrfs_grab_fs_root(root))
-		return 0;
 
 	key.objectid = inum;
 	key.type = BTRFS_EXTENT_DATA_KEY;
@@ -2711,9 +2709,6 @@ static noinline int relink_extent_backref(struct btrfs_path *path,
 		return PTR_ERR(root);
 	}
 
-	if (!btrfs_grab_fs_root(root))
-		return 0;
-
 	if (btrfs_root_readonly(root)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		return 0;
@@ -5689,10 +5684,6 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 		err = PTR_ERR(new_root);
 		goto out;
 	}
-	if (!btrfs_grab_fs_root(new_root)) {
-		err = -ENOENT;
-		goto out;
-	}
 
 	*sub_root = new_root;
 	location->objectid = btrfs_root_dirid(&new_root->root_item);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d5a994ab9602..7df2576aa2e3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -672,11 +672,6 @@ static noinline int create_subvol(struct inode *dir,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
-	if (!btrfs_grab_fs_root(new_root)) {
-		ret = -ENOENT;
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
 
 	btrfs_record_root_in_trans(trans, new_root);
 
@@ -2191,10 +2186,6 @@ static noinline int search_ioctl(struct inode *inode,
 			btrfs_free_path(path);
 			return PTR_ERR(root);
 		}
-		if (!btrfs_grab_fs_root(root)) {
-			btrfs_free_path(path);
-			return -ENOENT;
-		}
 	}
 
 	key.objectid = sk->min_objectid;
@@ -2332,11 +2323,6 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 		root = NULL;
 		goto out;
 	}
-	if (!btrfs_grab_fs_root(root)) {
-		ret = -ENOENT;
-		root = NULL;
-		goto out;
-	}
 
 	key.objectid = dirid;
 	key.type = BTRFS_INODE_REF_KEY;
@@ -2433,10 +2419,6 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 			ret = PTR_ERR(root);
 			goto out;
 		}
-		if (!btrfs_grab_fs_root(root)) {
-			ret = -ENOENT;
-			goto out;
-		}
 
 		key.objectid = dirid;
 		key.type = BTRFS_INODE_REF_KEY;
@@ -2686,10 +2668,6 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 		ret = PTR_ERR(root);
 		goto out_free;
 	}
-	if (!btrfs_grab_fs_root(root)) {
-		ret = -ENOENT;
-		goto out;
-	}
 	root_item = &root->root_item;
 
 	subvol_info->treeid = key.objectid;
@@ -4025,10 +4003,6 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 		ret = PTR_ERR(new_root);
 		goto out;
 	}
-	if (!btrfs_grab_fs_root(root)) {
-		ret = -ENOENT;
-		goto out;
-	}
 	if (!is_fstree(new_root->root_key.objectid)) {
 		ret = -ENOENT;
 		goto out_free;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 086c8126ebf2..f6d63d6cf22d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -581,7 +581,6 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 					u64 root_objectid)
 {
 	struct btrfs_key key;
-	struct btrfs_root *root;
 
 	key.objectid = root_objectid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
@@ -590,12 +589,7 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 	else
 		key.offset = (u64)-1;
 
-	root = btrfs_get_fs_root(fs_info, &key, false);
-	if (IS_ERR(root))
-		return root;
-	if (!btrfs_grab_fs_root(root))
-		return ERR_PTR(-ENOENT);
-	return root;
+	return btrfs_get_fs_root(fs_info, &key, false);
 }
 
 static noinline_for_stack
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index cac2407cc003..2c94b5318b40 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -257,8 +257,6 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 
 		root = btrfs_get_fs_root(fs_info, &root_key, false);
 		err = PTR_ERR_OR_ZERO(root);
-		if (!err && !btrfs_grab_fs_root(root))
-			err = -ENOENT;
 		if (err && err != -ENOENT) {
 			break;
 		} else if (err == -ENOENT) {
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 904e860c509c..0c8b60055c2e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -657,10 +657,6 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 		ret = PTR_ERR(local_root);
 		goto err;
 	}
-	if (!btrfs_grab_fs_root(local_root)) {
-		ret = -ENOENT;
-		goto err;
-	}
 
 	/*
 	 * this makes the path point to (inum INODE_ITEM ioff)
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index a82201e6979e..6520ad8f4e81 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7206,11 +7206,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 				ret = PTR_ERR(clone_root);
 				goto out;
 			}
-			if (!btrfs_grab_fs_root(clone_root)) {
-				srcu_read_unlock(&fs_info->subvol_srcu, index);
-				ret = -ENOENT;
-				goto out;
-			}
 			spin_lock(&clone_root->root_item_lock);
 			if (!btrfs_root_readonly(clone_root) ||
 			    btrfs_root_dead(clone_root)) {
@@ -7252,12 +7247,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 			ret = PTR_ERR(sctx->parent_root);
 			goto out;
 		}
-		if (!btrfs_grab_fs_root(sctx->parent_root)) {
-			srcu_read_unlock(&fs_info->subvol_srcu, index);
-			ret = -ENOENT;
-			sctx->parent_root = ERR_PTR(ret);
-			goto out;
-		}
 
 		spin_lock(&sctx->parent_root->root_item_lock);
 		sctx->parent_root->send_in_progress++;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index cc411304e2c9..80fea16cf34c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1082,10 +1082,6 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ret = PTR_ERR(fs_root);
 			goto err;
 		}
-		if (!btrfs_grab_fs_root(fs_root)) {
-			ret = -ENOENT;
-			goto err;
-		}
 
 		/*
 		 * Walk up the filesystem tree by inode refs until we hit the
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 7008def3391b..e194d3e4e3a9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1637,12 +1637,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
-	if (!btrfs_grab_fs_root(pending->snap)) {
-		ret = -ENOENT;
-		pending->snap = NULL;
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
 
 	ret = btrfs_reloc_post_snapshot(trans, pending);
 	if (ret) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f2c26e07eedb..32ee8698a87f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6292,10 +6292,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		tmp_key.offset = (u64)-1;
 
 		wc.replay_dest = btrfs_get_fs_root(fs_info, &tmp_key, true);
-		if (!IS_ERR(wc.replay_dest)) {
-			if (!btrfs_grab_fs_root(wc.replay_dest))
-				wc.replay_dest = ERR_PTR(-ENOENT);
-		}
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 47ac3277ee08..d261a39b7aa6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4379,10 +4379,6 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 			ret = 1;
 		goto out;
 	}
-	if (!btrfs_grab_fs_root(subvol_root)) {
-		ret = 1;
-		goto out;
-	}
 
 	switch (type) {
 	case BTRFS_UUID_KEY_SUBVOL:
-- 
2.23.0

