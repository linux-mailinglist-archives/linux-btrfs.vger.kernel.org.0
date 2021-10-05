Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51511423220
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhJEUhY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhJEUhY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:37:24 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA1C061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:35:33 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cv2so499670qvb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K5OxH4loe6E1uMkD96Oorus91E8BUjazMLp9ZdRPIUs=;
        b=hcDN3wBJLUwYQ284Ai+RRcYLZls0igll8mjeChlv7VwwGkshDn/9H3aapVzNjFUcj2
         BM8NQdBAvMbp//y+Y28hS6gvRQ+eTN3NNNNIuN6QO3q77zsUY08e0gxPsoc5sl/TC18N
         qrp77Ic54V4POa0hGk8nmB5lieWGEqWBZhpnevqtQ28pKpJYgUuy0cxSV47dsONl7pLJ
         VBzK+jUHijy+okt1KHJ8jeQCLUotJrfQWvDT72Liu9k50JMz/YgqyW4iFsYMoY9+qhEe
         jN0+bLf2CymmI0S4ySbO9yZxFja4FemDXMJ9r/JtqeXLuvI8kELEa2bQVaFaDayD39PN
         uX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5OxH4loe6E1uMkD96Oorus91E8BUjazMLp9ZdRPIUs=;
        b=zN2d6mh2MLLJCce17YzPVTCRFlWm796sa93kER6OqkuL+M5gf1uMAezxvgeM+iRTlo
         8e8KziIyAHQDX15YgnGVknwMtJhbiab78dB2i/nKhQy7iHEnmL3vgMX5u+4ggqaYMZ1l
         3APwRVTVJn6Y7XX5Gzn1nmbHbb7wZUKyWckAY5927+JJiedXf5Ui3ac2s1Amgd8fTvpi
         5iSINoJ5831qxtNM7uc+Gm9ieR0tGDUyWzU6WFWil55bV5XBAUdfG3YnSIJ2SPiwFN8h
         jxGQQRqP3Q3B6lo3ZkhyvCE/jkvw2jiWbDhra8MRfb4aydrMHoN+wNmldX6dM/WszbxI
         31AA==
X-Gm-Message-State: AOAM531rw8CzSDKeu2iJgGXm6YsCn3owD0QcbgRGcMopqO6gWI970xiJ
        5arG0grBFSzoy9udS17J+NY4abvmL0mXhg==
X-Google-Smtp-Source: ABdhPJweSl1S3DgOxdExhKm3ad5t8KMLMyOzgVbT2Fw9go7HU81YfOnTeNmRECWp3J3wsNiBqyZ8EA==
X-Received: by 2002:a05:6214:1046:: with SMTP id l6mr12387815qvr.13.1633466132270;
        Tue, 05 Oct 2021 13:35:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z186sm10126835qke.59.2021.10.05.13.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:35:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 2/5] btrfs: change error handling for btrfs_delete_*_in_log
Date:   Tue,  5 Oct 2021 16:35:24 -0400
Message-Id: <e26773a5be8c7e52b6379343514c0b7eb46deb0e.1633465964.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633465964.git.josef@toxicpanda.com>
References: <cover.1633465964.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we will abort the transaction if we get a random error (like
-EIO) while trying to remove the directory entries from the root log
during rename.

However since these are simply log tree related errors, we can mark the
trans as needing a full commit.  Then if the error was truly
catastrophic we'll hit it during the normal commit and abort as
appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c    | 16 +++-------------
 fs/btrfs/tree-log.c | 41 ++++++++++++++---------------------------
 fs/btrfs/tree-log.h | 16 ++++++++--------
 3 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 11ba673d195e..df716d1bd2f1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4116,19 +4116,9 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
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
index 7a7fe0d74c35..a99aa57b8886 100644
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

