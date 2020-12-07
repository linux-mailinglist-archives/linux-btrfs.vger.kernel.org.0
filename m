Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D752D14CA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgLGPdb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 10:33:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:45596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgLGPd1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Dec 2020 10:33:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607355161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uraZxqaoPmITRxfmI3hQOTCYWxcUv/ivNEtUbHSyyH0=;
        b=prsa5hV+xBMK3AJY/J4Mj4IHqEGYUj1F+/ETFUUmJEVdYdOWXVvzQGa4rGdumCkikwW8so
        AFc7/wVWTMekg4RK+el+3vQUodpccVRgq6dWDdsCBNBOhbuAJyJqqziWCaOQH9w49QcraD
        i+ppTfnXvVmyTGmHifkCmBq1JjweGaI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26BB7AC2E;
        Mon,  7 Dec 2020 15:32:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/6] btrfs: Rename btrfs_find_highest_objectid to btrfs_init_root_free_objectid
Date:   Mon,  7 Dec 2020 17:32:32 +0200
Message-Id: <20201207153237.1073887-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207153237.1073887-1-nborisov@suse.com>
References: <20201207153237.1073887-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is used to initialize the in-memory
btrfs_root::highest_objectid member, which is used to get an available
objectid. Rename it to better reflect its semantics.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c  | 12 +++++-------
 fs/btrfs/disk-io.h  |  2 +-
 fs/btrfs/tree-log.c |  3 +--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 39458baf8745..c5353767edef 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1367,8 +1367,7 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 	}
 
 	mutex_lock(&root->objectid_mutex);
-	ret = btrfs_find_highest_objectid(root,
-					&root->highest_objectid);
+	ret = btrfs_init_root_free_objectid(root);
 	if (ret) {
 		mutex_unlock(&root->objectid_mutex);
 		goto fail;
@@ -2646,8 +2645,7 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 		 * No need to hold btrfs_root::objectid_mutex since the fs
 		 * hasn't been fully initialised and we are the only user
 		 */
-		ret = btrfs_find_highest_objectid(tree_root,
-						&tree_root->highest_objectid);
+		ret = btrfs_init_root_free_objectid(tree_root);
 		if (ret < 0) {
 			handle_error = true;
 			continue;
@@ -4743,7 +4741,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid)
+int btrfs_init_root_free_objectid(struct btrfs_root *root)
 {
 	struct btrfs_path *path;
 	int ret;
@@ -4767,10 +4765,10 @@ int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid)
 		slot = path->slots[0] - 1;
 		l = path->nodes[0];
 		btrfs_item_key_to_cpu(l, &found_key, slot);
-		*objectid = max_t(u64, found_key.objectid,
+		root->highest_objectid = max_t(u64, found_key.objectid,
 				  BTRFS_FIRST_FREE_OBJECTID - 1);
 	} else {
-		*objectid = BTRFS_FIRST_FREE_OBJECTID - 1;
+		root->highest_objectid = BTRFS_FIRST_FREE_OBJECTID - 1;
 	}
 	ret = 0;
 error:
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index e45057c0c016..5e5bc603fbdf 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -134,7 +134,7 @@ int btree_lock_page_hook(struct page *page, void *data,
 				void (*flush_fn)(void *));
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
 int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid);
-int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid);
+int btrfs_init_root_free_objectid(struct btrfs_root *root);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 254c2ee43aae..8ee0700a980f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6307,8 +6307,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * root->objectid_mutex is not acquired as log replay
 			 * could only happen during mount.
 			 */
-			ret = btrfs_find_highest_objectid(root,
-						  &root->highest_objectid);
+			ret = btrfs_init_root_free_objectid(root);
 		}
 
 		wc.replay_dest->log_root = NULL;
-- 
2.25.1

