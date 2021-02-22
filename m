Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9DA321D4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 17:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBVQnO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 11:43:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:46610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230428AbhBVQmo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 11:42:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614012050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CITt25C08MNaOgfAw+/Of9AlDBf3dTljnFmj0LMiRPc=;
        b=tT07E5KNF4a69OaIJycmoPj2oEjJ9SrnwSib/GCueWWl21Kkjt+oScvcqsBKuiBdqiC35B
        ByJSIMMLgtWiH1tKa+lIrj0RluoNKpleGezoXcyC6r/2hXrb3L5sHD0e1nzVKIePzuFFsx
        cdo3funZkNSvDLTBS/cZ8rlFUyxVPtA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 462B2B121;
        Mon, 22 Feb 2021 16:40:50 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/6] btrfs: Remove btrfs_inode from btrfs_delayed_inode_reserve_metadata
Date:   Mon, 22 Feb 2021 18:40:46 +0200
Message-Id: <20210222164047.978768-6-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222164047.978768-1-nborisov@suse.com>
References: <20210222164047.978768-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's only used for tracepoint to obtain the ino, but we already have
the ino from btrfs_delayed_node::inode_id.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delayed-inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6dcf2cd1b39e..875daca63d5d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -602,7 +602,6 @@ static void btrfs_delayed_item_release_metadata(struct btrfs_root *root,
 static int btrfs_delayed_inode_reserve_metadata(
 					struct btrfs_trans_handle *trans,
 					struct btrfs_root *root,
-					struct btrfs_inode *inode,
 					struct btrfs_delayed_node *node)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -647,7 +646,7 @@ static int btrfs_delayed_inode_reserve_metadata(
 			node->bytes_reserved = num_bytes;
 			trace_btrfs_space_reservation(fs_info,
 						      "delayed_inode",
-						      btrfs_ino(inode),
+						      node->inode_id,
 						      num_bytes, 1);
 		} else {
 			btrfs_qgroup_free_meta_prealloc(root, num_bytes);
@@ -658,7 +657,7 @@ static int btrfs_delayed_inode_reserve_metadata(
 	ret = btrfs_block_rsv_migrate(src_rsv, dst_rsv, num_bytes, true);
 	if (!ret) {
 		trace_btrfs_space_reservation(fs_info, "delayed_inode",
-					      btrfs_ino(inode), num_bytes, 1);
+					      node->inode_id, num_bytes, 1);
 		node->bytes_reserved = num_bytes;
 	}
 
@@ -1833,8 +1832,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 		goto release_node;
 	}
 
-	ret = btrfs_delayed_inode_reserve_metadata(trans, root, inode,
-						   delayed_node);
+	ret = btrfs_delayed_inode_reserve_metadata(trans, root, delayed_node);
 	if (ret)
 		goto release_node;
 
-- 
2.25.1

