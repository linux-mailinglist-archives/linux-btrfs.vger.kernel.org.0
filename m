Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94B123098
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfLQPhs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45070 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfLQPhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so8563782qkl.12
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hVCdsgY0axs5iY5Kl0JKoFtdChssjram5zLjOOhpqoA=;
        b=N7sT5idBA6vBlRTbzGVk65eKWT4O+TcsUkjstVMc01vN5Yv77qk6C2wqIMnB3RBmNE
         Co1q5UIvs64he5SfBJOYshCzKyLwxiupuUmEWMvzVHpto7DY0iBA2FbSqYOSv5KsVRs7
         YYJcz/VQ1uU9MgQpMQYujUJhJ5GvxuaSGdsPfjzizjoOeWBGfRnBm4X3ljyzIr1REhtP
         6Z47TCfa018vJIh6vEndNwJptgX8X4byNM86zMJ5DLZ87KNkNAjB6WvCoJsZGzaImp/3
         Expg+hgTD6FpC1Y8/oVSlo5re+4ZR9JkcQJGXmWoyC7uetd/+zTvvZ/tDCrWoDbvhyJM
         6qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVCdsgY0axs5iY5Kl0JKoFtdChssjram5zLjOOhpqoA=;
        b=jk4RkzqYF/ba3ZKHDSCQ57ZHpCnzdLRTwNJDuBeGvmXXeJjTDFFijxHuvQtL8aZOBl
         wrKArnBukzawZvZK6DZX4fNt+M8N0sOeVKpT4MULa1dn6wi9eQSE7bhYgip973tv8gL3
         zCAaiJWNnkVcSs01aFputmdd+eXWvDlzEtAsVMd8GLxfRikxmtA8aSUyfx3GjkLnf9LN
         pZheFCNBH4fORl1RFreTZBwz5+gRNEMOnS+NIRYzffekpFR9cZQBLTafaRUnfZNAX3lX
         MaLLiy3jluChal/2A8M27pDDl3xoT/QMifJ3j6/i3I3z/lJ6rPTnQFi023ztIRJpoqv4
         F+Lw==
X-Gm-Message-State: APjAAAXdqo0iyGsirrA3KAtxDtzf3/Ux6mYc5eTub8cBkt0hxJ18XSAS
        t5YJ8pjxKYP374rvAnmCXX2uwynTWIi0cw==
X-Google-Smtp-Source: APXvYqwq6l3azX9R3InwaRtPFFZw9e3FC2KXbNmPNN4pJpwiEzptqvQCmgGB5WvQmhqIX8gezr4yWw==
X-Received: by 2002:a37:b602:: with SMTP id g2mr5786026qkf.174.1576597066685;
        Tue, 17 Dec 2019 07:37:46 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n19sm7158341qkn.52.2019.12.17.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 38/45] btrfs: hold a ref on the root in open_ctree
Date:   Tue, 17 Dec 2019 10:36:28 -0500
Message-Id: <20191217153635.44733-39-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup the fs_root and put it in our fs_info directly, we should hold
a ref on this root for the lifetime of the fs_info.  Rework the free'ing
function so that it calls btrfs_put_fs_root() on the root at free time
with all of the other global trees.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   | 17 -----------------
 fs/btrfs/disk-io.c | 26 ++++++++++++++++++++++++++
 fs/btrfs/disk-io.h |  1 +
 fs/btrfs/super.c   |  6 +++---
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b2e8fd8a8e59..8578c65890b2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2648,23 +2648,6 @@ static inline int btrfs_need_cleaner_sleep(struct btrfs_fs_info *fs_info)
 	return fs_info->sb->s_flags & SB_RDONLY || btrfs_fs_closing(fs_info);
 }
 
-static inline void free_fs_info(struct btrfs_fs_info *fs_info)
-{
-	kfree(fs_info->balance_ctl);
-	kfree(fs_info->delayed_root);
-	kfree(fs_info->extent_root);
-	kfree(fs_info->tree_root);
-	kfree(fs_info->chunk_root);
-	kfree(fs_info->dev_root);
-	kfree(fs_info->csum_root);
-	kfree(fs_info->quota_root);
-	kfree(fs_info->uuid_root);
-	kfree(fs_info->free_space_root);
-	kfree(fs_info->super_copy);
-	kfree(fs_info->super_for_commit);
-	kvfree(fs_info);
-}
-
 /* tree mod log functions from ctree.c */
 u64 btrfs_get_tree_mod_seq(struct btrfs_fs_info *fs_info,
 			   struct seq_list *elem);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dfeeabfc341b..9435d4aa1668 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1525,6 +1525,25 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
+{
+	kfree(fs_info->balance_ctl);
+	kfree(fs_info->delayed_root);
+	kfree(fs_info->extent_root);
+	kfree(fs_info->tree_root);
+	kfree(fs_info->chunk_root);
+	kfree(fs_info->dev_root);
+	kfree(fs_info->csum_root);
+	kfree(fs_info->quota_root);
+	kfree(fs_info->uuid_root);
+	kfree(fs_info->free_space_root);
+	kfree(fs_info->super_copy);
+	kfree(fs_info->super_for_commit);
+	btrfs_put_fs_root(fs_info->fs_root);
+	kvfree(fs_info);
+}
+
+
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *location,
 				     bool check_ref)
@@ -3188,6 +3207,13 @@ int __cold open_ctree(struct super_block *sb,
 		goto fail_qgroup;
 	}
 
+	if (!btrfs_grab_fs_root(fs_info->fs_root)) {
+		fs_info->fs_root = NULL;
+		err = -ENOENT;
+		btrfs_warn(fs_info, "failed to grab a ref on the fs tree");
+		goto fail_qgroup;
+	}
+
 	if (sb_rdonly(sb))
 		return 0;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 7e53da374715..80a65a0d9d33 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -68,6 +68,7 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     struct btrfs_key *key,
 				     bool check_ref);
 
+void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 9c50bee71de9..cc411304e2c9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1559,7 +1559,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 
 	if (s->s_root) {
 		btrfs_close_devices(fs_devices);
-		free_fs_info(fs_info);
+		btrfs_free_fs_info(fs_info);
 		if ((flags ^ s->s_flags) & SB_RDONLY)
 			error = -EBUSY;
 	} else {
@@ -1582,7 +1582,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 error_close_devices:
 	btrfs_close_devices(fs_devices);
 error_fs_info:
-	free_fs_info(fs_info);
+	btrfs_free_fs_info(fs_info);
 error_sec_opts:
 	security_free_mnt_opts(&new_sec_opts);
 	return ERR_PTR(error);
@@ -2138,7 +2138,7 @@ static void btrfs_kill_super(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	kill_anon_super(sb);
-	free_fs_info(fs_info);
+	btrfs_free_fs_info(fs_info);
 }
 
 static struct file_system_type btrfs_fs_type = {
-- 
2.23.0

