Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E1D2A2D59
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKBOt0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:49:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:39792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgKBOtL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:49:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604328549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwaG7G/7GZ5GYDFS7+ziFDoYWG/a9MBvq72dmyGixtA=;
        b=HeRof5cGP2GK+8YjAOPlb3ZC2M5NAF5AQUujQvWq1Z+XNSAhPEyeazVt/8j23vjDVwVFsc
        JZV32jYbtrGtML+nKiWtcVQSyPUY5oQ7K7Us58FLHCco2rl53VctyOdMwLZylDIx8y9NtC
        TivKUWnY4gkMsntGl6Jg2z5mvEHGNbg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79565B906;
        Mon,  2 Nov 2020 14:49:09 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 05/14] btrfs: Make btrfs_delayed_update_inode take btrfs_inode
Date:   Mon,  2 Nov 2020 16:48:57 +0200
Message-Id: <20201102144906.3767963-6-nborisov@suse.com>
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
 fs/btrfs/delayed-inode.c | 13 ++++++++-----
 fs/btrfs/delayed-inode.h |  3 ++-
 fs/btrfs/inode.c         |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 5aba81e16113..6fcc5bd2839a 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1826,27 +1826,30 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 }
 
 int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root, struct inode *inode)
+			       struct btrfs_root *root,
+			       struct btrfs_inode *inode)
 {
 	struct btrfs_delayed_node *delayed_node;
 	int ret = 0;
 
-	delayed_node = btrfs_get_or_create_delayed_node(BTRFS_I(inode));
+	delayed_node = btrfs_get_or_create_delayed_node(inode);
 	if (IS_ERR(delayed_node))
 		return PTR_ERR(delayed_node);
 
 	mutex_lock(&delayed_node->mutex);
 	if (test_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags)) {
-		fill_stack_inode_item(trans, &delayed_node->inode_item, inode);
+		fill_stack_inode_item(trans, &delayed_node->inode_item,
+				      &inode->vfs_inode);
 		goto release_node;
 	}
 
-	ret = btrfs_delayed_inode_reserve_metadata(trans, root, BTRFS_I(inode),
+	ret = btrfs_delayed_inode_reserve_metadata(trans, root, inode,
 						   delayed_node);
 	if (ret)
 		goto release_node;
 
-	fill_stack_inode_item(trans, &delayed_node->inode_item, inode);
+	fill_stack_inode_item(trans, &delayed_node->inode_item,
+			      &inode->vfs_inode);
 	set_bit(BTRFS_DELAYED_NODE_INODE_DIRTY, &delayed_node->flags);
 	delayed_node->count++;
 	atomic_inc(&root->fs_info->delayed_root->items);
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index ca96ef007d8f..b2412160c5bc 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -110,7 +110,8 @@ int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode);
 
 
 int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
-			       struct btrfs_root *root, struct inode *inode);
+			       struct btrfs_root *root,
+			       struct btrfs_inode *inode);
 int btrfs_fill_inode(struct inode *inode, u32 *rdev);
 int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5bcac6f27cf9..e4993706a7fa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3504,7 +3504,7 @@ noinline int btrfs_update_inode(struct btrfs_trans_handle *trans,
 	    && !test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
 		btrfs_update_root_times(trans, root);
 
-		ret = btrfs_delayed_update_inode(trans, root, inode);
+		ret = btrfs_delayed_update_inode(trans, root, BTRFS_I(inode));
 		if (!ret)
 			btrfs_set_inode_last_trans(trans, BTRFS_I(inode));
 		return ret;
-- 
2.25.1

