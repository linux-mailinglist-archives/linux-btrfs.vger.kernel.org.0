Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA721412CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgAQV0T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35185 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so24163758qka.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sVt0nCNKEv1NJNGOm0ra3sTJABGTyJ6sKlWaxzI7XDc=;
        b=Z2N3IQ47LNrYZmvesI4oHSha8HmAW9i5TBlBQ2M7s2hlB9jJhONWd7nCagVCRzyMA2
         +M9FHQlVq8Qi3aZFShDbkm+Ds57txF6JNsTPs8UEd0CZSB0B9gE8lB5APoQ3PLUFcB0b
         w7p8GxI8JZo2Kdamdqk6OUnXUuv5c2CRZz7W2Wh8mEmxsuYzZn++kyYevX6fqxcr/+ii
         Oa8V6b+Zt47KnMdQ3v+cTddKzxz8R2A2s8y5FhMi4t89JGyPYxjdHHj1vNZL11Xa8Hrs
         V/Y62JJIM7lLR252uyudI0x7XrrGckrv93fQkLdLR/1jd6amaGgvjtoIkHOb4WQ66SKE
         JmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVt0nCNKEv1NJNGOm0ra3sTJABGTyJ6sKlWaxzI7XDc=;
        b=A1S6pVfGB283MwkgBIs1h9dFaEuVkvYPKSIhXLFKsKOVeVIX5Zo6M94sLeObfONoW9
         WGcPkSq+vx683aR4YVnyT+oAjeqQJnwEKVLTUawLXqT8teub1dcSnZtN63GK6o7dCSt3
         YY7ilXa9D1kO3KUcuApD4ZtDvaSHZXgJSNqM59lxzFG+DRgDIIG4/RRMrO1hb3aOmnDq
         XrB4dJ/pExV/gxtzm1BaHbCkurBOd435uRg9A+UP1h4K4CgLidceUY7vEuUfVpx3ES4S
         zTB6qRaAva/m23vlgFjqp+FBZgAShBldVu1sH+wVhSJmn5EPcy88nxTvK948gzOmHQ/D
         mzPQ==
X-Gm-Message-State: APjAAAUeJTuUEDMeZRc3Fs5TPuY10ZlgQx2IQJp+p3dd84iZUF8NVroD
        S+vitnNj3V0LSvcO+oSltYocNtNhgDFM0A==
X-Google-Smtp-Source: APXvYqwv1z0660S+p4dDjgihZNDGAbcSrVlolUV0BqyUsEtzaa0S+7wvY3QYqvTTNfEtMAaarBQHVw==
X-Received: by 2002:a37:6d47:: with SMTP id i68mr6760659qkc.228.1579296377594;
        Fri, 17 Jan 2020 13:26:17 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q35sm13785735qta.19.2020.01.17.13.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/43] btrfs: kill the btrfs_read_fs_root_no_name helper
Date:   Fri, 17 Jan 2020 16:25:26 -0500
Message-Id: <20200117212602.6737-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/ioctl.c       | 12 ++++++------
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/send.c        |  4 ++--
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/transaction.c |  2 +-
 fs/btrfs/tree-log.c    |  2 +-
 fs/btrfs/volumes.c     |  2 +-
 12 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 99755d013dab..d13791ccb4f6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3176,7 +3176,7 @@ int __cold open_ctree(struct super_block *sb,
 	location.type = BTRFS_ROOT_ITEM_KEY;
 	location.offset = 0;
 
-	fs_info->fs_root = btrfs_read_fs_root_no_name(fs_info, &location);
+	fs_info->fs_root = btrfs_get_fs_root(fs_info, &location, true);
 	if (IS_ERR(fs_info->fs_root)) {
 		err = PTR_ERR(fs_info->fs_root);
 		btrfs_warn(fs_info, "failed to read fs tree: %d", err);
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 4e43bd37f9c5..c2e765edf034 100644
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
index a16da274c9aa..565ae8404e1c 100644
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
index 6d2bb58d277a..8cd1b11c3151 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5021,7 +5021,7 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 
 	btrfs_release_path(path);
 
-	new_root = btrfs_read_fs_root_no_name(fs_info, location);
+	new_root = btrfs_get_fs_root(fs_info, location, true);
 	if (IS_ERR(new_root)) {
 		err = PTR_ERR(new_root);
 		goto out;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0fa1c386d020..958c0245c363 100644
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
@@ -3980,7 +3980,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	location.type = BTRFS_ROOT_ITEM_KEY;
 	location.offset = (u64)-1;
 
-	new_root = btrfs_read_fs_root_no_name(fs_info, &location);
+	new_root = btrfs_get_fs_root(fs_info, &location, true);
 	if (IS_ERR(new_root)) {
 		ret = PTR_ERR(new_root);
 		goto out;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 22cf69e6e5bc..b5f420456439 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -653,7 +653,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	root_key.objectid = root;
 	root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root_key.offset = (u64)-1;
-	local_root = btrfs_read_fs_root_no_name(fs_info, &root_key);
+	local_root = btrfs_get_fs_root(fs_info, &root_key, true);
 	if (IS_ERR(local_root)) {
 		ret = PTR_ERR(local_root);
 		goto err;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 091e5bc8c7ea..57eae56dd743 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7194,7 +7194,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 			index = srcu_read_lock(&fs_info->subvol_srcu);
 
-			clone_root = btrfs_read_fs_root_no_name(fs_info, &key);
+			clone_root = btrfs_get_fs_root(fs_info, &key, true);
 			if (IS_ERR(clone_root)) {
 				srcu_read_unlock(&fs_info->subvol_srcu, index);
 				ret = PTR_ERR(clone_root);
@@ -7233,7 +7233,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 		index = srcu_read_lock(&fs_info->subvol_srcu);
 
-		sctx->parent_root = btrfs_read_fs_root_no_name(fs_info, &key);
+		sctx->parent_root = btrfs_get_fs_root(fs_info, &key, true);
 		if (IS_ERR(sctx->parent_root)) {
 			srcu_read_unlock(&fs_info->subvol_srcu, index);
 			ret = PTR_ERR(sctx->parent_root);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a906315efd19..3118bc01321e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1096,7 +1096,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
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
index e6e4b00cb46c..db803765b500 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6113,7 +6113,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		tmp_key.type = BTRFS_ROOT_ITEM_KEY;
 		tmp_key.offset = (u64)-1;
 
-		wc.replay_dest = btrfs_read_fs_root_no_name(fs_info, &tmp_key);
+		wc.replay_dest = btrfs_get_fs_root(fs_info, &tmp_key, true);
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3d5714bf2e32..ce3eff93c366 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4375,7 +4375,7 @@ static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
 	key.objectid = subid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 	key.offset = (u64)-1;
-	subvol_root = btrfs_read_fs_root_no_name(fs_info, &key);
+	subvol_root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(subvol_root)) {
 		ret = PTR_ERR(subvol_root);
 		if (ret == -ENOENT)
-- 
2.24.1

