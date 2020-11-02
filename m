Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADE92A2D4D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgKBOtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:39848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKBOtL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DgCWAlWtRZagQqemw0/QbbjY7yPmJ/aRMH+D1Hh2Q8=;
        b=CmtStxDMZ9Uzx8OseSJ2fQVi7DkGZJwpfVqackHRxemulH4KXnh1Vyfg38UqFNAKPATWmK
        3KU0O2NaJTuS8QqOs71Wv3mPLmm/Hg3E9cq2Nh7R7fRTajtyi2jVdRGAEcoreLhAmgj8/f
        4VWP62H8iR1TGWVeec6eHUcwPcMxXoM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CFB34B90F;
        Mon,  2 Nov 2020 14:49:09 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/14] btrfs: Make btrfs_update_inode_item take btrfs_inode
Date:   Mon,  2 Nov 2020 16:48:58 +0200
Message-Id: <20201102144906.3767963-7-nborisov@suse.com>
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
 fs/btrfs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e4993706a7fa..4165eb322c11 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3450,7 +3450,8 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
  * copy everything in the in-memory inode into the btree.
  */
 static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root, struct inode *inode)
+				struct btrfs_root *root,
+				struct btrfs_inode *inode)
 {
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_path *path;
@@ -3462,8 +3463,7 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	path->leave_spinning = 1;
-	ret = btrfs_lookup_inode(trans, root, path, &BTRFS_I(inode)->location,
-				 1);
+	ret = btrfs_lookup_inode(trans, root, path, &inode->location, 1);
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
@@ -3474,9 +3474,9 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 	inode_item = btrfs_item_ptr(leaf, path->slots[0],
 				    struct btrfs_inode_item);
 
-	fill_inode_item(trans, leaf, inode_item, inode);
+	fill_inode_item(trans, leaf, inode_item, &inode->vfs_inode);
 	btrfs_mark_buffer_dirty(leaf);
-	btrfs_set_inode_last_trans(trans, BTRFS_I(inode));
+	btrfs_set_inode_last_trans(trans, inode);
 	ret = 0;
 failed:
 	btrfs_free_path(path);
@@ -3510,7 +3510,7 @@ noinline int btrfs_update_inode(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	return btrfs_update_inode_item(trans, root, inode);
+	return btrfs_update_inode_item(trans, root, BTRFS_I(inode));
 }
 
 noinline int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
@@ -3521,7 +3521,7 @@ noinline int btrfs_update_inode_fallback(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret == -ENOSPC)
-		return btrfs_update_inode_item(trans, root, inode);
+		return btrfs_update_inode_item(trans, root, BTRFS_I(inode));
 	return ret;
 }
 
-- 
2.25.1

