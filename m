Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADBD2A2D52
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKBOtU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:39848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgKBOtN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFMTBNUaST2PJu9B+HgYmBCkhn4XQ5VbeDSMoxWBQbY=;
        b=bfLjtWHs2HcZ0pMTWSCaqfxBh9JFb3L6egG+iO+rg0mcYiBuMZYGJRR7okMhhzXF0F5R9R
        nwg5ScAsu2ZoLzwJmrtAQ+lBi4DAYo9I/yQLglNm9TUZ1hmiEOeim9IGehu/qfKxbsz4Qt
        o1xEXSt8u2oMOZxB4L3gZKfuFiTO2fA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD80BB906;
        Mon,  2 Nov 2020 14:49:11 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 14/14] btrfs: Make btrfs_update_inode_fallback take btrfs_inode
Date:   Mon,  2 Nov 2020 16:49:06 +0200
Message-Id: <20201102144906.3767963-15-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102144906.3767963-1-nborisov@suse.com>
References: <20201102144906.3767963-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h       |  3 ++-
 fs/btrfs/inode.c       | 15 +++++++--------
 fs/btrfs/transaction.c |  3 ++-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8bf6d655f06b..a61f01d3d5d1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3040,7 +3040,8 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 int btrfs_update_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root, struct btrfs_inode *inode);
 int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root, struct inode *inode);
+				struct btrfs_root *root,
+				struct btrfs_inode *inode);
 int btrfs_orphan_add(struct btrfs_trans_handle *trans,
 		struct btrfs_inode *inode);
 int btrfs_orphan_cleanup(struct btrfs_root *root);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e620c278984c..869fdfc93d69 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2617,7 +2617,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 			goto out;
 		}
 		trans->block_rsv = &inode->block_rsv;
-		ret = btrfs_update_inode_fallback(trans, root, &inode->vfs_inode);
+		ret = btrfs_update_inode_fallback(trans, root, inode);
 		if (ret) /* -ENOMEM or corruption */
 			btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -2670,7 +2670,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 	}
 
 	btrfs_inode_safe_disk_i_size_write(inode, 0);
-	ret = btrfs_update_inode_fallback(trans, root, &inode->vfs_inode);
+	ret = btrfs_update_inode_fallback(trans, root, inode);
 	if (ret) { /* -ENOMEM or corruption */
 		btrfs_abort_transaction(trans, ret);
 		goto out;
@@ -3514,15 +3514,14 @@ noinline int btrfs_update_inode(struct btrfs_trans_handle *trans,
 	return btrfs_update_inode_item(trans, root, inode);
 }
 
-noinline int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
-					 struct btrfs_root *root,
-					 struct inode *inode)
+int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
+			    struct btrfs_root *root, struct btrfs_inode *inode)
 {
 	int ret;
 
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+	ret = btrfs_update_inode(trans, root, inode);
 	if (ret == -ENOSPC)
-		return btrfs_update_inode_item(trans, root, BTRFS_I(inode));
+		return btrfs_update_inode_item(trans, root, inode);
 	return ret;
 }
 
@@ -3794,7 +3793,7 @@ static int btrfs_unlink_subvol(struct btrfs_trans_handle *trans,
 	btrfs_i_size_write(BTRFS_I(dir), dir->i_size - name_len * 2);
 	inode_inc_iversion(dir);
 	dir->i_mtime = dir->i_ctime = current_time(dir);
-	ret = btrfs_update_inode_fallback(trans, root, dir);
+	ret = btrfs_update_inode_fallback(trans, root, BTRFS_I(dir));
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 out:
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3a7d26ba2da2..5c9de63ad166 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1679,7 +1679,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 					 dentry->d_name.len * 2);
 	parent_inode->i_mtime = parent_inode->i_ctime =
 		current_time(parent_inode);
-	ret = btrfs_update_inode_fallback(trans, parent_root, parent_inode);
+	ret = btrfs_update_inode_fallback(trans, parent_root,
+					  BTRFS_I(parent_inode));
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
-- 
2.25.1

