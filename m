Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B492A2D4E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgKBOtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:39878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgKBOtM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1w6+8iWdBRcHwOpO+dUTW7FeB9Dlf4afugrJh4Qsxo=;
        b=kt+3/GW10m/bsjvLTqwLsZUhE3SUuIBo7q37WqA7OrY1uZ/ggLWX2H/AuTMF+DpyGhxJ33
        KnOJoTkZdfqk/OuGMvmRlT9T4wruShiWw05CRNbgiQILXT/uRTxJr1ApDcpqwSxV5FI/g7
        DRU12c98WBG+51TYcUennXHlobMXjdE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48479B232;
        Mon,  2 Nov 2020 14:49:10 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/14] btrfs: Make maybe_insert_hole take btrfs_inode
Date:   Mon,  2 Nov 2020 16:49:00 +0200
Message-Id: <20201102144906.3767963-9-nborisov@suse.com>
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
 fs/btrfs/inode.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a82dbc683a43..6264777474ad 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4624,10 +4624,10 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	return ret;
 }
 
-static int maybe_insert_hole(struct btrfs_root *root, struct inode *inode,
+static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
 			     u64 offset, u64 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
 	int ret;
 
@@ -4636,9 +4636,9 @@ static int maybe_insert_hole(struct btrfs_root *root, struct inode *inode,
 	 * that any holes get logged if we fsync.
 	 */
 	if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
-		BTRFS_I(inode)->last_trans = fs_info->generation;
-		BTRFS_I(inode)->last_sub_trans = root->log_transid;
-		BTRFS_I(inode)->last_log_commit = root->last_log_commit;
+		inode->last_trans = fs_info->generation;
+		inode->last_sub_trans = root->log_transid;
+		inode->last_log_commit = root->last_log_commit;
 		return 0;
 	}
 
@@ -4651,19 +4651,20 @@ static int maybe_insert_hole(struct btrfs_root *root, struct inode *inode,
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	ret = btrfs_drop_extents(trans, root, inode, offset, offset + len, 1);
+	ret = btrfs_drop_extents(trans, root, &inode->vfs_inode, offset,
+				 offset + len, 1);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
 		return ret;
 	}
 
-	ret = btrfs_insert_file_extent(trans, root, btrfs_ino(BTRFS_I(inode)),
-			offset, 0, 0, len, 0, len, 0, 0, 0);
+	ret = btrfs_insert_file_extent(trans, root, btrfs_ino(inode), offset,
+				       0, 0, len, 0, len, 0, 0, 0);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 	else
-		btrfs_update_inode(trans, root, BTRFS_I(inode));
+		btrfs_update_inode(trans, root, inode);
 	btrfs_end_transaction(trans);
 	return ret;
 }
@@ -4719,8 +4720,8 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 		if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
 			struct extent_map *hole_em;
 
-			err = maybe_insert_hole(root, inode, cur_offset,
-						hole_size);
+			err = maybe_insert_hole(root, BTRFS_I(inode),
+						cur_offset, hole_size);
 			if (err)
 				break;
 
-- 
2.25.1

