Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38FD94C148
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfFSTMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 15:12:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36606 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFSTMI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 15:12:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id p15so372308qtl.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=acfZyFl/At+pyh/XazQjoRmWT7VIhAp+0IecJn8BGfY=;
        b=1zC3yUoGmH7SvjJjSozBU4hudf+ZyrVv4bDW0acmo+GyAmbV2IsnI5FngC3x3RYer9
         hvmZLdup+0Q9upoFM3A8+9P1XafTYJy9YUIUa1ZBoLD6v3wo+Y5X+xky3KAdA9pD5O5r
         mLmLLI08FgGgx1SRFbKkNcBcOxAhP3c7ITzrmN2/p+hM+8nQ+bBVGK37XuB2ZqT1jEle
         7grNlVa5s6aafszETPTI9J/LlMCzgz/KzSBvRBp0+pvYEzk8JmTHEaYVFwn8AGso07yy
         K1XbNRN6rMbaFhL+iKOciSEKedsbOw8i8UYESboKQRqL4OM9jpXIapmRulwhKxroJbkd
         16WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=acfZyFl/At+pyh/XazQjoRmWT7VIhAp+0IecJn8BGfY=;
        b=kFg8J5ya2mV9vGhclZAhPFeQ62qAh+KZ1gTQYtQ8V52hum28CeBy8KHP9e3DTtun+F
         8FmGJYYgypqEi/N+3UYunt/VQJ4beOVsgveO8FvVS6bj+e4ZW+B68yYc1sg8ps3JVQGq
         xARqTgdNiWkVbmEstN1ojxjGkdAPG28NL7KqUvSE1z5NKArXxetO066NS7qzGggvb8Xu
         /iqLeZ8tcOGD4vm4kfedzT0qP0Beh2NJv4kcrgQYPxn9JCAuUvQIduccG7sDVPQMxBmv
         9J84l0fifS+Fm8fj5TIc/LUEFlSK+6Ed5o08fv9M0o1GLznl957At4w7g/+el65rEW07
         xbZA==
X-Gm-Message-State: APjAAAXCQWgUGiDPnbAe5+ZSasp+S122MP8jnJmOdSd2JSqgGCk9AHio
        BD7BaCOGiMLcb4fauF/RCL4ThoQsXLEliw==
X-Google-Smtp-Source: APXvYqwDPw1byLYSm40jg3Ga9XShsoo0RC6AFUffZI/ngbrXT238MNd+fhxMSBy+s2F9XQ49pd5b7A==
X-Received: by 2002:a0c:d604:: with SMTP id c4mr1709292qvj.27.1560971527090;
        Wed, 19 Jun 2019 12:12:07 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o54sm12807363qtb.63.2019.06.19.12.12.06
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 12:12:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: migrate btrfs_trans_release_chunk_metadata
Date:   Wed, 19 Jun 2019 15:11:59 -0400
Message-Id: <20190619191201.16689-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619191201.16689-1-josef@toxicpanda.com>
References: <20190619191201.16689-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move this into transaction.c with the rest of the transaction related
code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/extent-tree.c | 18 ------------------
 fs/btrfs/transaction.c | 18 ++++++++++++++++++
 fs/btrfs/transaction.h |  1 +
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f6ba024cd273..afd329184e36 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2752,7 +2752,6 @@ void btrfs_delalloc_release_space(struct inode *inode,
 				  u64 start, u64 len, bool qgroup_free);
 void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
 					    u64 len);
-void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans);
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0b94f17fa751..20b9b3284af2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4341,24 +4341,6 @@ static void btrfs_inode_rsv_release(struct btrfs_inode *inode, bool qgroup_free)
 						   qgroup_to_release);
 }
 
-/*
- * To be called after all the new block groups attached to the transaction
- * handle have been created (btrfs_create_pending_block_groups()).
- */
-void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-
-	if (!trans->chunk_bytes_reserved)
-		return;
-
-	WARN_ON_ONCE(!list_empty(&trans->new_bgs));
-
-	btrfs_block_rsv_release(fs_info, &fs_info->chunk_block_rsv,
-				trans->chunk_bytes_reserved);
-	trans->chunk_bytes_reserved = 0;
-}
-
 /*
  * btrfs_subvolume_reserve_metadata() - reserve space for subvolume operation
  * root: the root of the parent directory
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3f6811cdf803..3b8ae1a8f02d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -128,6 +128,24 @@ static inline int extwriter_counter_read(struct btrfs_transaction *trans)
 	return atomic_read(&trans->num_extwriters);
 }
 
+/*
+ * To be called after all the new block groups attached to the transaction
+ * handle have been created (btrfs_create_pending_block_groups()).
+ */
+void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+
+	if (!trans->chunk_bytes_reserved)
+		return;
+
+	WARN_ON_ONCE(!list_empty(&trans->new_bgs));
+
+	btrfs_block_rsv_release(fs_info, &fs_info->chunk_block_rsv,
+				trans->chunk_bytes_reserved);
+	trans->chunk_bytes_reserved = 0;
+}
+
 /*
  * either allocate a new transaction or hop into the existing one
  */
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 78c446c222b7..527ea94b57d9 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -224,5 +224,6 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction);
 void btrfs_apply_pending_changes(struct btrfs_fs_info *fs_info);
 void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
+void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans);
 
 #endif
-- 
2.14.3

