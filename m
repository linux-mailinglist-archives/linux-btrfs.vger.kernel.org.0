Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B92D14C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 16:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgLGPd2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 10:33:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:45640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGPd1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Dec 2020 10:33:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607355162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8C66cPouJPdNw3A7iST5MI0BBdCD536h+sdqmzvRipM=;
        b=IxN6mVq7cddqqyG+P5aO8LPN6CU8ZqyAZaGQBkMobbb4f17vYBb733U794tbXaocb7NNho
        BatMNgOnXerv2vLyBcfRxPmFHpRdcHbo0H7LLm42sHWAXPKoDmNoylU+t3+0WY/L5D1yra
        Z1Br8QY8ITT2SNKU7/JJvYuCCrcgBwE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E77E1ABE9;
        Mon,  7 Dec 2020 15:32:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/6] btrfs: Rename highest_objectid to free_objectid
Date:   Mon,  7 Dec 2020 17:32:35 +0200
Message-Id: <20201207153237.1073887-5-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207153237.1073887-1-nborisov@suse.com>
References: <20201207153237.1073887-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This reflects the true purpose of the member as it's being used solely
in context where a new objectid is being allocated. Future changes will
also change the way it's being used to closely follow this semantics.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h   |  2 +-
 fs/btrfs/disk-io.c | 10 +++++-----
 fs/btrfs/ioctl.c   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dac0f7b70a68..e8652c73c189 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1101,7 +1101,7 @@ struct btrfs_root {
 
 	u32 type;
 
-	u64 highest_objectid;
+	u64 free_objectid;
 
 	struct btrfs_key defrag_progress;
 	struct btrfs_key defrag_max;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eaaece2bf0c8..e96103b1c5db 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1016,7 +1016,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->orphan_cleanup_state = 0;
 
 	root->last_trans = 0;
-	root->highest_objectid = 0;
+	root->free_objectid = 0;
 	root->nr_delalloc_inodes = 0;
 	root->nr_ordered_extents = 0;
 	root->inode_tree = RB_ROOT;
@@ -4762,10 +4762,10 @@ int btrfs_init_root_free_objectid(struct btrfs_root *root)
 		slot = path->slots[0] - 1;
 		l = path->nodes[0];
 		btrfs_item_key_to_cpu(l, &found_key, slot);
-		root->highest_objectid = max_t(u64, found_key.objectid,
+		root->free_objectid = max_t(u64, found_key.objectid,
 				  BTRFS_FIRST_FREE_OBJECTID - 1);
 	} else {
-		root->highest_objectid = BTRFS_FIRST_FREE_OBJECTID - 1;
+		root->free_objectid = BTRFS_FIRST_FREE_OBJECTID - 1;
 	}
 	ret = 0;
 error:
@@ -4778,7 +4778,7 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 	int ret;
 	mutex_lock(&root->objectid_mutex);
 
-	if (unlikely(root->highest_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
+	if (unlikely(root->free_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
 		btrfs_warn(root->fs_info,
 			   "the objectid of root %llu reaches its highest value",
 			   root->root_key.objectid);
@@ -4786,7 +4786,7 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 		goto out;
 	}
 
-	*objectid = ++root->highest_objectid;
+	*objectid = ++root->free_objectid;
 	ret = 0;
 out:
 	mutex_unlock(&root->objectid_mutex);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8ae38806211c..21c0215a0fd0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -725,7 +725,7 @@ static noinline int create_subvol(struct inode *dir,
 	}
 
 	mutex_lock(&new_root->objectid_mutex);
-	new_root->highest_objectid = new_dirid;
+	new_root->free_objectid = new_dirid;
 	mutex_unlock(&new_root->objectid_mutex);
 
 	/*
-- 
2.25.1

