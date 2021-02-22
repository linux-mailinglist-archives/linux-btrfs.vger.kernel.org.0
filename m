Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E47321D4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 17:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhBVQnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 11:43:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:46608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhBVQmn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 11:42:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614012050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTXcve60y3fSPhWK/hE62p7kXKhFZf/E2dnF1g1RPuI=;
        b=EXiEuTxoXLVAbcigVw0vIEWpygilnTnjuJtybDV+fy0y034XQ5E13r8zwRVwIoJviE1mrP
        gWGXK7aUcdJsWxbGIJ8L/wBJtJ5H+vmkaElLWRvHTxGE/tPVsU02+43OHKq7ULZuxwmmov
        X6mbKUzT9BvmiTiqTtwuJ/Mh7nFD4ck=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 823BCB11F;
        Mon, 22 Feb 2021 16:40:50 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 6/6] btrfs: Simplify code flow in btrfs_delayed_inode_reserve_metadata
Date:   Mon, 22 Feb 2021 18:40:47 +0200
Message-Id: <20210222164047.978768-7-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222164047.978768-1-nborisov@suse.com>
References: <20210222164047.978768-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_block_rsv_add can return only ENOSPC since it's called with
NO_FLUSH modifier. This so simplify the logic in
btrfs_delayed_inode_reserve_metadata to exploit this invariant.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delayed-inode.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 875daca63d5d..92843105ebd8 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -632,29 +632,12 @@ static int btrfs_delayed_inode_reserve_metadata(
 			return ret;
 		ret = btrfs_block_rsv_add(root, dst_rsv, num_bytes,
 					  BTRFS_RESERVE_NO_FLUSH);
-		/*
-		 * Since we're under a transaction reserve_metadata_bytes could
-		 * try to commit the transaction which will make it return
-		 * EAGAIN to make us stop the transaction we have, so return
-		 * ENOSPC instead so that btrfs_dirty_inode knows what to do.
-		 */
-		if (ret == -EAGAIN) {
-			ret = -ENOSPC;
-			btrfs_qgroup_free_meta_prealloc(root, num_bytes);
-		}
-		if (!ret) {
-			node->bytes_reserved = num_bytes;
-			trace_btrfs_space_reservation(fs_info,
-						      "delayed_inode",
-						      node->inode_id,
-						      num_bytes, 1);
-		} else {
+		if (ret)
 			btrfs_qgroup_free_meta_prealloc(root, num_bytes);
-		}
-		return ret;
+	} else {
+		ret = btrfs_block_rsv_migrate(src_rsv, dst_rsv, num_bytes, true);
 	}
 
-	ret = btrfs_block_rsv_migrate(src_rsv, dst_rsv, num_bytes, true);
 	if (!ret) {
 		trace_btrfs_space_reservation(fs_info, "delayed_inode",
 					      node->inode_id, num_bytes, 1);
-- 
2.25.1

