Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB5419DCA
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 20:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhI0SG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 14:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhI0SG6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 14:06:58 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBB0C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d207so38118499qkg.0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XPAAGt6vzR3g6/CYC2JpBnQJOx1u0gYDwy+73WsVB4o=;
        b=FNg4QsTuhfjdoYR4LhefjuptR6OEHQVf8xeWchyIdWAJh6MxPO/rde9ndAt1y/XrRR
         BB/63qPcxUDMAJR0f6GGsA7BSiLYUw5u1fxiCAtZtdOCcrvcoAdRH8gRnER+oTvVhU4s
         p0BiT+5+5WyzfcYbTrFu6QtBlA/2jnyaKd9r9EIxVqrD7S9+4ONr1o9kQfarJDEDKePT
         f2qteEYe2UGfW2Mcp8T40F5lB+JlB/0LEPs5sbU0x0BV1BZf7n7f1uO+yqfXGLvSYlzh
         3g5d94VGC4/hnHtkEtD1LjsYni+8Te2Relaj5afxVPuHKVY7cm/wkSnaQxckR4hUhCz6
         ZGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPAAGt6vzR3g6/CYC2JpBnQJOx1u0gYDwy+73WsVB4o=;
        b=qFQ8CYqFXuVIE6C6DL/506CauMDPOZvsBiHJ+HSX6RC1AoNOjZeiwioeDNMvttOQQS
         pbNKCRS3rhiRczEt7Q1lMbiSUrCtzUjyVGeuXP1Y4/6P0Kfk0BEWAk1UgqUWw9MWSUDL
         1nV6drQGWAqWPI7iU8tzym6oc6kLAyCf3+uHtoWTCva6Txbjyz/lrq8pvBXP+O9WG0/R
         /IBruBIcWc+AfoSS8dHETb5rf10JvZ59olou5sAduFgQlKwI3+g9XBFjfK16NyZRhNdf
         oR6ByzkXcwNX2a8rCDN4WsNWjU+p/UehZ9H/B3B5JSSuncs75zgqyfyKSxIuQVItM0cf
         RPOA==
X-Gm-Message-State: AOAM531jebyrnJFj3u2gsEzjrKVX1leKx8iRE29Z5GnkShOozjnbhfgc
        TFsP4Bdz8HNHjJt4f4lZZsPluDmMSiQhXw==
X-Google-Smtp-Source: ABdhPJzbux48hRUpgICHYo2EGVEljeURBDb8wmprlGbtjKeRcC7RdUJ0f7p3zzDqb//Yv/r9bfEvkw==
X-Received: by 2002:a05:620a:430c:: with SMTP id u12mr1283087qko.439.1632765918988;
        Mon, 27 Sep 2021 11:05:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u12sm11143446qtw.73.2021.09.27.11.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:05:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/5] btrfs: change error handling for btrfs_delete_*_in_log
Date:   Mon, 27 Sep 2021 14:05:11 -0400
Message-Id: <4df6bd8d64bf81e098101e35a0c7482485ef4e67.1632765815.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1632765815.git.josef@toxicpanda.com>
References: <cover.1632765815.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we will abort the transaction if we get a random error (like
-EIO) while trying to remove the directory entries from the root log
during rename.

However the log sync stuff doesn't actually honor the transaction abort
flag, it'll happily commit the log even if we've aborted the transaction
for reasons related to the log, which is a pretty bad problem.

Fix this by making these functions void, as we don't actually care if
this fails.  Instead mark the log as requiring a full commit on error.
This will keep us from committing this bad log, and if we fsync we'll
force a full transaction commit and have a consistent file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c    | 16 +++-------------
 fs/btrfs/tree-log.c | 41 ++++++++++++++---------------------------
 fs/btrfs/tree-log.h | 16 ++++++++--------
 3 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a643be30c18a..03a843b9659b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4108,19 +4108,9 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		goto err;
 	}
 
-	ret = btrfs_del_inode_ref_in_log(trans, root, name, name_len, inode,
-			dir_ino);
-	if (ret != 0 && ret != -ENOENT) {
-		btrfs_abort_transaction(trans, ret);
-		goto err;
-	}
-
-	ret = btrfs_del_dir_entries_in_log(trans, root, name, name_len, dir,
-			index);
-	if (ret == -ENOENT)
-		ret = 0;
-	else if (ret)
-		btrfs_abort_transaction(trans, ret);
+	btrfs_del_inode_ref_in_log(trans, root, name, name_len, inode,
+				   dir_ino);
+	btrfs_del_dir_entries_in_log(trans, root, name, name_len, dir, index);
 
 	/*
 	 * If we have a pending delayed iput we could end up with the final iput
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e0c2d4c7f939..720723611875 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3500,10 +3500,10 @@ static bool inode_logged(struct btrfs_trans_handle *trans,
  * This optimizations allows us to avoid relogging the entire inode
  * or the entire directory.
  */
-int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
-				 struct btrfs_root *root,
-				 const char *name, int name_len,
-				 struct btrfs_inode *dir, u64 index)
+void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
+				  struct btrfs_root *root,
+				  const char *name, int name_len,
+				  struct btrfs_inode *dir, u64 index)
 {
 	struct btrfs_root *log;
 	struct btrfs_dir_item *di;
@@ -3513,11 +3513,11 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	u64 dir_ino = btrfs_ino(dir);
 
 	if (!inode_logged(trans, dir))
-		return 0;
+		return;
 
 	ret = join_running_log_trans(root);
 	if (ret)
-		return 0;
+		return;
 
 	mutex_lock(&dir->log_mutex);
 
@@ -3565,49 +3565,36 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
 	btrfs_free_path(path);
 out_unlock:
 	mutex_unlock(&dir->log_mutex);
-	if (err == -ENOSPC) {
+	if (err < 0 && err != -ENOENT)
 		btrfs_set_log_full_commit(trans);
-		err = 0;
-	} else if (err < 0 && err != -ENOENT) {
-		/* ENOENT can be returned if the entry hasn't been fsynced yet */
-		btrfs_abort_transaction(trans, err);
-	}
-
 	btrfs_end_log_trans(root);
-
-	return err;
 }
 
 /* see comments for btrfs_del_dir_entries_in_log */
-int btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
-			       const char *name, int name_len,
-			       struct btrfs_inode *inode, u64 dirid)
+void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
+				struct btrfs_root *root,
+				const char *name, int name_len,
+				struct btrfs_inode *inode, u64 dirid)
 {
 	struct btrfs_root *log;
 	u64 index;
 	int ret;
 
 	if (!inode_logged(trans, inode))
-		return 0;
+		return;
 
 	ret = join_running_log_trans(root);
 	if (ret)
-		return 0;
+		return;
 	log = root->log_root;
 	mutex_lock(&inode->log_mutex);
 
 	ret = btrfs_del_inode_ref(trans, log, name, name_len, btrfs_ino(inode),
 				  dirid, &index);
 	mutex_unlock(&inode->log_mutex);
-	if (ret == -ENOSPC) {
+	if (ret < 0 && ret != -ENOENT)
 		btrfs_set_log_full_commit(trans);
-		ret = 0;
-	} else if (ret < 0 && ret != -ENOENT)
-		btrfs_abort_transaction(trans, ret);
 	btrfs_end_log_trans(root);
-
-	return ret;
 }
 
 /*
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 3ce6bdb76009..f6811c3df38a 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -70,14 +70,14 @@ int btrfs_recover_log_trees(struct btrfs_root *tree_root);
 int btrfs_log_dentry_safe(struct btrfs_trans_handle *trans,
 			  struct dentry *dentry,
 			  struct btrfs_log_ctx *ctx);
-int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
-				 struct btrfs_root *root,
-				 const char *name, int name_len,
-				 struct btrfs_inode *dir, u64 index);
-int btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root,
-			       const char *name, int name_len,
-			       struct btrfs_inode *inode, u64 dirid);
+void btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
+				  struct btrfs_root *root,
+				  const char *name, int name_len,
+				  struct btrfs_inode *dir, u64 index);
+void btrfs_del_inode_ref_in_log(struct btrfs_trans_handle *trans,
+				struct btrfs_root *root,
+				const char *name, int name_len,
+				struct btrfs_inode *inode, u64 dirid);
 void btrfs_end_log_trans(struct btrfs_root *root);
 void btrfs_pin_log_trans(struct btrfs_root *root);
 void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
-- 
2.26.3

