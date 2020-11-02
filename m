Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182992A2D58
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgKBOtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:39792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgKBOtN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qTKc6CnPS+OSi3FRvDlanpglJ14ZkeBY2qk6MPiiuSY=;
        b=Xa/IltxHXEU84PrV1RcwNhsNvxrNNyrNCQhhZoLeQp5yRtOCO9tp8UvWYuQFmj1X6pWSs/
        7eDNjgDbu5KDhvPUylyxKVqwCAxB0rsA5P3FrMJqtZ9U03xpDLk9kFU+ID8EevvNzvcKit
        v3YcdGrByvyrcICIY8v2IhW5sR2j/RY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92000B905;
        Mon,  2 Nov 2020 14:49:11 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 13/14] btrfs: Make btrfs_drop_extents take btrfs_inode
Date:   Mon,  2 Nov 2020 16:49:05 +0200
Message-Id: <20201102144906.3767963-14-nborisov@suse.com>
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
 fs/btrfs/ctree.h    | 4 ++--
 fs/btrfs/file.c     | 8 ++++----
 fs/btrfs/inode.c    | 3 +--
 fs/btrfs/reflink.c  | 3 ++-
 fs/btrfs/tree-log.c | 6 ++++--
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 879b80ef641e..8bf6d655f06b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3100,8 +3100,8 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			 u32 extent_item_size,
 			 int *key_inserted);
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root, struct inode *inode, u64 start,
-		       u64 end, int drop_cache);
+		       struct btrfs_root *root, struct btrfs_inode *inode,
+		       u64 start, u64 end, int drop_cache);
 int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			   const u64 start, const u64 end,
 			   struct btrfs_replace_extent_info *extent_info,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 05374aa99da8..b993c528f2dd 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1075,8 +1075,8 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
-		       struct btrfs_root *root, struct inode *inode, u64 start,
-		       u64 end, int drop_cache)
+		       struct btrfs_root *root, struct btrfs_inode *inode,
+		       u64 start, u64 end, int drop_cache)
 {
 	struct btrfs_path *path;
 	int ret;
@@ -1084,8 +1084,8 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-	ret = __btrfs_drop_extents(trans, root, BTRFS_I(inode), path, start,
-				   end, NULL, drop_cache, 0, 0, NULL);
+	ret = __btrfs_drop_extents(trans, root, inode, path, start, end, NULL,
+				   drop_cache, 0, 0, NULL);
 	btrfs_free_path(path);
 	return ret;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 23b9a0621be3..e620c278984c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4649,8 +4649,7 @@ static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_drop_extents(trans, root, &inode->vfs_inode, offset,
-				 offset + len, 1);
+	ret = btrfs_drop_extents(trans, root, inode, offset, offset + len, 1);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index be00315995ec..b3cc1fdc6e48 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -252,7 +252,8 @@ static int clone_copy_inline_extent(struct inode *dst,
 		trans = NULL;
 		goto out;
 	}
-	ret = btrfs_drop_extents(trans, root, dst, drop_start, aligned_end, 1);
+	ret = btrfs_drop_extents(trans, root, BTRFS_I(dst), drop_start,
+				 aligned_end, 1);
 	if (ret)
 		goto out;
 	ret = btrfs_insert_empty_item(trans, root, path, new_key, size);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index baa2c4cfd293..71bd0f08543b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -653,7 +653,8 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	/* drop any overlapping extents */
-	ret = btrfs_drop_extents(trans, root, inode, start, extent_end, 1);
+	ret = btrfs_drop_extents(trans, root, BTRFS_I(inode), start, extent_end,
+				 1);
 	if (ret)
 		goto out;
 
@@ -2586,7 +2587,8 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 				}
 				from = ALIGN(i_size_read(inode),
 					     root->fs_info->sectorsize);
-				ret = btrfs_drop_extents(wc->trans, root, inode,
+				ret = btrfs_drop_extents(wc->trans, root,
+							 BTRFS_I(inode),
 							 from, (u64)-1, 1);
 				if (!ret) {
 					/* Update the inode's nbytes. */
-- 
2.25.1

