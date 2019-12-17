Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC4123071
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfLQPgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:36:52 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38728 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPgw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:52 -0500
Received: by mail-qv1-f68.google.com with SMTP id t6so3904459qvs.5
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RlO45UzFmp1e7heFJX4bWcaYC6KEXzixfUKphjQntXw=;
        b=h+GBTrbOKWVhukObu3HBgPI6nx6cs5tM3nXOCz+cR7+ELdHyiA5trqRyHCgH4WEIYU
         9Pg3T/s3ASX34vLFiHKI0PipHRhyB5+oQ9QKFOtE00mUyipPev5t6jdSAJ2eP7eUPBCR
         QZiln+qfFUWVjhRvsGudyMYbu6PyhWGsCexrWoZAoVH6F70v3dLynYybYJdGO3VLhQwZ
         dV4BVS+y/nmTYmBAmiCiLU0REAr4V+fXiEJXuW5Qhrxg16tRz565Py6PkBq1EmgebZC9
         fggw8feGnRZEaaKJF1dnIKAUa/MvtZ10wwdsKE4K+DDigLGTMpj3BiDb8cd9G4C6KdNg
         +Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RlO45UzFmp1e7heFJX4bWcaYC6KEXzixfUKphjQntXw=;
        b=b0UJUFjJDjIwR5KN41uOCGfItIvxhTKxNHSWwDyDghOn1vBtZq9eVT97eRX4QFlevE
         zWdhYo4KR3jCpzWsD0KXFkSgFNJqw/y6Flcvo4sJ0NPG+kplZ/Bidjb7CY9Hz/H8TWGn
         9U3R1d98koLCOeoAJBEbWqxYcbfLHeFWuLCX6OQFUIITl8J9agbLCM1PgdPF/XS2dBxy
         KYN4xpcWr0tkaerGLwhq7YrP16A8yWp0yofk6FeDlCv2tpQFeGuwS2ujnha6Qnq0zXZI
         0yJiUDs09kpm8InLIOYzQAKWlXwiCZxcVVq3MGKilhRKrtdI/zPvF40MDWvOB5mCFs1m
         jdAA==
X-Gm-Message-State: APjAAAW3FgxRPgudWLZibN6XtKTsgANkxK95nhxqkb/z9Kk+5d51nm1y
        pP9CVthJtnR1MYpBD/RwK2nISBmCCVhx1Q==
X-Google-Smtp-Source: APXvYqxdhyQNdAST/nkGmWsbJJ9K6F1ot8Kwgf38ehFuD9gaDiiZprd2U/c2Ty/FAgN6Am4R2hEl+g==
X-Received: by 2002:a0c:ab8f:: with SMTP id j15mr5091289qvb.223.1576597010823;
        Tue, 17 Dec 2019 07:36:50 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r205sm6589311qke.34.2019.12.17.07.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/45] btrfs: kill the btrfs_read_fs_root_no_name helper
Date:   Tue, 17 Dec 2019 10:35:57 -0500
Message-Id: <20191217153635.44733-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All this does is call btrfs_get_fs_root() with check_ref == true.  Just
use btrfs_get_fs_root() so we don't have a bunch of different helpers
that do the same thing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/disk-io.h     |  6 ------
 fs/btrfs/export.c      |  2 +-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       |  6 +++---
 fs/btrfs/ioctl.c       | 12 ++++++------
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/send.c        |  4 ++--
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/transaction.c |  2 +-
 fs/btrfs/tree-log.c    |  2 +-
 fs/btrfs/volumes.c     |  2 +-
 12 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e3957d6b6bab..fba2ca4965c4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3179,7 +3179,7 @@ int __cold open_ctree(struct super_block *sb,
 	location.type = BTRFS_ROOT_ITEM_KEY;
 	location.offset = 0;
 
-	fs_info->fs_root = btrfs_read_fs_root_no_name(fs_info, &location);
+	fs_info->fs_root = btrfs_get_fs_root(fs_info, &location, true);
 	if (IS_ERR(fs_info->fs_root)) {
 		err = PTR_ERR(fs_info->fs_root);
 		btrfs_warn(fs_info, "failed to read fs tree: %d", err);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 614802bd709d..f5ef9ace903a 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -70,12 +70,6 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key,
 				     bool check_ref);
-static inline struct btrfs_root *
-btrfs_read_fs_root_no_name(struct btrfs_fs_info *fs_info,
-			   struct btrfs_key *location)
-{
-	return btrfs_get_fs_root(fs_info, location, true);
-}
 
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 72e312cae69d..08cd8c4a02a5 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -77,7 +77,7 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 
 	index = srcu_read_lock(&fs_info->subvol_srcu);
 
-	root = btrfs_read_fs_root_no_name(fs_info, &key);
+	root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
 		goto fail;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 32e620981485..8baa1b44d514 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -287,7 +287,7 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 
 	index = srcu_read_lock(&fs_info->subvol_srcu);
 
-	inode_root = btrfs_read_fs_root_no_name(fs_info, &key);
+	inode_root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(inode_root)) {
 		ret = PTR_ERR(inode_root);
 		goto cleanup;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fc0624fbe387..138c21f5ed12 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2514,7 +2514,7 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = (u64)-1;
 
-	root = btrfs_read_fs_root_no_name(fs_info, &key);
+	root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(root)) {
 		if (PTR_ERR(root) == -ENOENT)
 			return 0;
@@ -2698,7 +2698,7 @@ static noinline int relink_extent_backref(struct btrfs_path *path,
 
 	index = srcu_read_lock(&fs_info->subvol_srcu);
 
-	root = btrfs_read_fs_root_no_name(fs_info, &key);
+	root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(root)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		if (PTR_ERR(root) == -ENOENT)
@@ -5675,7 +5675,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 
 	btrfs_release_path(path);
 
-	new_root = btrfs_read_fs_root_no_name(fs_info, location);
+	new_root = btrfs_get_fs_root(fs_info, location, true);
 	if (IS_ERR(new_root)) {
 		err = PTR_ERR(new_root);
 		goto out;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 375befdecc19..95b0488b7da6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -666,7 +666,7 @@ static noinline int create_subvol(struct inode *dir,
 		goto fail;
 
 	key.offset = (u64)-1;
-	new_root = btrfs_read_fs_root_no_name(fs_info, &key);
+	new_root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(new_root)) {
 		ret = PTR_ERR(new_root);
 		btrfs_abort_transaction(trans, ret);
@@ -2179,7 +2179,7 @@ static noinline int search_ioctl(struct inode *inode,
 		key.objectid = sk->tree_id;
 		key.type = BTRFS_ROOT_ITEM_KEY;
 		key.offset = (u64)-1;
-		root = btrfs_read_fs_root_no_name(info, &key);
+		root = btrfs_get_fs_root(info, &key, true);
 		if (IS_ERR(root)) {
 			btrfs_free_path(path);
 			return PTR_ERR(root);
@@ -2314,7 +2314,7 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	key.objectid = tree_id;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = (u64)-1;
-	root = btrfs_read_fs_root_no_name(info, &key);
+	root = btrfs_get_fs_root(info, &key, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out;
@@ -2408,7 +2408,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 		key.objectid = treeid;
 		key.type = BTRFS_ROOT_ITEM_KEY;
 		key.offset = (u64)-1;
-		root = btrfs_read_fs_root_no_name(fs_info, &key);
+		root = btrfs_get_fs_root(fs_info, &key, true);
 		if (IS_ERR(root)) {
 			ret = PTR_ERR(root);
 			goto out;
@@ -2653,7 +2653,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	key.objectid = BTRFS_I(inode)->root->root_key.objectid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = (u64)-1;
-	root = btrfs_read_fs_root_no_name(fs_info, &key);
+	root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out;
@@ -3986,7 +3986,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	location.type = BTRFS_ROOT_ITEM_KEY;
 	location.offset = (u64)-1;
 
-	new_root = btrfs_read_fs_root_no_name(fs_info, &location);
+	new_root = btrfs_get_fs_root(fs_info, &location, true);
 	if (IS_ERR(new_root)) {
 		ret = PTR_ERR(new_root);
 		goto out;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e2c87220600f..eed3a8492092 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -652,7 +652,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	root_key.objectid = root;
 	root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root_key.offset = (u64)-1;
-	local_root = btrfs_read_fs_root_no_name(fs_info, &root_key);
+	local_root = btrfs_get_fs_root(fs_info, &root_key, true);
 	if (IS_ERR(local_root)) {
 		ret = PTR_ERR(local_root);
 		goto err;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ae2db5eb1549..73e2e350f4a1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7200,7 +7200,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 			index = srcu_read_lock(&fs_info->subvol_srcu);
 
-			clone_root = btrfs_read_fs_root_no_name(fs_info, &key);
+			clone_root = btrfs_get_fs_root(fs_info, &key, true);
 			if (IS_ERR(clone_root)) {
 				srcu_read_unlock(&fs_info->subvol_srcu, index);
 				ret = PTR_ERR(clone_root);
@@ -7239,7 +7239,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 		index = srcu_read_lock(&fs_info->subvol_srcu);
 
-		sctx->parent_root = btrfs_read_fs_root_no_name(fs_info, &key);
+		sctx->parent_root = btrfs_get_fs_root(fs_info, &key, true);
 		if (IS_ERR(sctx->parent_root)) {
 			srcu_read_unlock(&fs_info->subvol_srcu, index);
 			ret = PTR_ERR(sctx->parent_root);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a98c3c71fc54..e387ca1ac0e5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1077,7 +1077,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 		key.objectid = subvol_objectid;
 		key.type = BTRFS_ROOT_ITEM_KEY;
 		key.offset = (u64)-1;
-		fs_root = btrfs_read_fs_root_no_name(fs_info, &key);
+		fs_root = btrfs_get_fs_root(fs_info, &key, true);
 		if (IS_ERR(fs_root)) {
 			ret = PTR_ERR(fs_root);
 			goto err;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 55d8fd68775a..e194d3e4e3a9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1631,7 +1631,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 
 	key.offset = (u64)-1;
-	pending->snap = btrfs_read_fs_root_no_name(fs_info, &key);
+	pending->snap = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(pending->snap)) {
 		ret = PTR_ERR(pending->snap);
 		btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 881d117a07db..a4321bdcbf3e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6291,7 +6291,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		tmp_key.type = BTRFS_ROOT_ITEM_KEY;
 		tmp_key.offset = (u64)-1;
 
-		wc.replay_dest = btrfs_read_fs_root_no_name(fs_info, &tmp_key);
+		wc.replay_dest = btrfs_get_fs_root(fs_info, &tmp_key, true);
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..904c3e03467f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4372,7 +4372,7 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 	key.objectid = subid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = (u64)-1;
-	subvol_root = btrfs_read_fs_root_no_name(fs_info, &key);
+	subvol_root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(subvol_root)) {
 		ret = PTR_ERR(subvol_root);
 		if (ret == -ENOENT)
-- 
2.23.0

