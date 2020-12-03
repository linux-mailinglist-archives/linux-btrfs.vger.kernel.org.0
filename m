Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56AC2CD0D4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbgLCIKh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:10:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:58218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387625AbgLCIKh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 03:10:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606982991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t7hFX2s8rHxKDvSMGRmhJzQH6G0chTaIP3Hpb21pRfo=;
        b=qlpRHiK36I1DpBAHzHYxN06OWgYV37cMRxKz6e0WSlH9OTpipeqAlVuDujLTPI5OKwBDCe
        SmSZpDoAUW9wcI1oNCaAExcsmMhfyRSCKernGH1P/lOfKhJ6mSD64fM+swLodEuZAJ92Xj
        dBTEvGFdIeHWRzuFbFB1mdOGXNsIc7o=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45A8DAE38;
        Thu,  3 Dec 2020 08:09:51 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] btrfs: Always set NODATASUM/NODATACOW in __create_free_space_inode
Date:   Thu,  3 Dec 2020 10:09:49 +0200
Message-Id: <20201203080949.3759006-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203080949.3759006-1-nborisov@suse.com>
References: <20201203080949.3759006-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since it's being used solely for the freespace cache unconditionally
set the flags required for it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/free-space-cache.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index e83b3bdc4e46..18112a63ea57 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -142,17 +142,15 @@ static int __create_free_space_inode(struct btrfs_root *root,
 	struct btrfs_free_space_header *header;
 	struct btrfs_inode_item *inode_item;
 	struct extent_buffer *leaf;
-	u64 flags = BTRFS_INODE_NOCOMPRESS | BTRFS_INODE_PREALLOC;
+	/* We inline crc's for the free disk space cache */
+	u64 flags = BTRFS_INODE_NOCOMPRESS | BTRFS_INODE_PREALLOC |
+		BTRFS_INODE_NODATASUM | BTRFS_INODE_NODATACOW;
 	int ret;
 
 	ret = btrfs_insert_empty_inode(trans, root, path, ino);
 	if (ret)
 		return ret;
 
-	/* We inline crc's for the free disk space cache */
-	if (ino != BTRFS_FREE_INO_OBJECTID)
-		flags |= BTRFS_INODE_NODATASUM | BTRFS_INODE_NODATACOW;
-
 	leaf = path->nodes[0];
 	inode_item = btrfs_item_ptr(leaf, path->slots[0],
 				    struct btrfs_inode_item);
-- 
2.25.1

