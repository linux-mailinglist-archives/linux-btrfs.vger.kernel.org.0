Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB0996BB8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 13:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfGQLgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 07:36:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:32653 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730564AbfGQLgi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 07:36:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 04:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,274,1559545200"; 
   d="scan'208";a="251465352"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2019 04:36:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6F59F234; Wed, 17 Jul 2019 14:36:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/4] Btrfs: Switch to use new generic UUID API
Date:   Wed, 17 Jul 2019 14:36:32 +0300
Message-Id: <20190717113633.25922-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717113633.25922-1-andriy.shevchenko@linux.intel.com>
References: <20190717113633.25922-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are new types and helpers that are supposed to be used in new code.

As a preparation to get rid of legacy types and API functions do
the conversion here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/btrfs/disk-io.c     | 6 +++---
 fs/btrfs/ioctl.c       | 4 +---
 fs/btrfs/root-tree.c   | 4 +---
 fs/btrfs/transaction.c | 7 +++----
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 41a2bd2e0c56..6a9f51d86bd1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1259,7 +1259,6 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	unsigned int nofs_flag;
 	int ret = 0;
-	uuid_le uuid = NULL_UUID_LE;
 
 	/*
 	 * We're holding a transaction handle, so use a NOFS memory allocation
@@ -1299,8 +1298,9 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	btrfs_set_root_last_snapshot(&root->root_item, 0);
 	btrfs_set_root_dirid(&root->root_item, 0);
 	if (is_fstree(objectid))
-		uuid_le_gen(&uuid);
-	memcpy(root->root_item.uuid, uuid.b, BTRFS_UUID_SIZE);
+		generate_random_guid(root->root_item.uuid);
+	else
+		export_guid(root->root_item.uuid, &guid_null);
 	root->root_item.drop_level = 0;
 
 	key.objectid = objectid;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 818f7ec8bb0e..88a7579b217b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -573,7 +573,6 @@ static noinline int create_subvol(struct inode *dir,
 	u64 objectid;
 	u64 new_dirid = BTRFS_FIRST_FREE_OBJECTID;
 	u64 index = 0;
-	uuid_le new_uuid;
 
 	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
 	if (!root_item)
@@ -643,8 +642,7 @@ static noinline int create_subvol(struct inode *dir,
 
 	btrfs_set_root_generation_v2(root_item,
 			btrfs_root_generation(root_item));
-	uuid_le_gen(&new_uuid);
-	memcpy(root_item->uuid, new_uuid.b, BTRFS_UUID_SIZE);
+	generate_random_guid(root_item->uuid);
 	btrfs_set_stack_timespec_sec(&root_item->otime, cur_time.tv_sec);
 	btrfs_set_stack_timespec_nsec(&root_item->otime, cur_time.tv_nsec);
 	root_item->ctime = root_item->otime;
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 47733fb55df7..af884338bbb1 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -22,7 +22,6 @@
 static void btrfs_read_root_item(struct extent_buffer *eb, int slot,
 				struct btrfs_root_item *item)
 {
-	uuid_le uuid;
 	u32 len;
 	int need_reset = 0;
 
@@ -44,8 +43,7 @@ static void btrfs_read_root_item(struct extent_buffer *eb, int slot,
 			sizeof(*item) - offsetof(struct btrfs_root_item,
 					generation_v2));
 
-		uuid_le_gen(&uuid);
-		memcpy(item->uuid, uuid.b, BTRFS_UUID_SIZE);
+		generate_random_guid(item->uuid);
 	}
 }
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3b8ae1a8f02d..7aec9389df69 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1395,7 +1395,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	u64 index = 0;
 	u64 objectid;
 	u64 root_flags;
-	uuid_le new_uuid;
 
 	ASSERT(pending->path);
 	path = pending->path;
@@ -1488,8 +1487,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 
 	btrfs_set_root_generation_v2(new_root_item,
 			trans->transid);
-	uuid_le_gen(&new_uuid);
-	memcpy(new_root_item->uuid, new_uuid.b, BTRFS_UUID_SIZE);
+	generate_random_guid(new_root_item->uuid);
 	memcpy(new_root_item->parent_uuid, root->root_item.uuid,
 			BTRFS_UUID_SIZE);
 	if (!(root_flags & BTRFS_ROOT_SUBVOL_RDONLY)) {
@@ -1600,7 +1598,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
-	ret = btrfs_uuid_tree_add(trans, new_uuid.b, BTRFS_UUID_KEY_SUBVOL,
+	ret = btrfs_uuid_tree_add(trans, new_root_item->uuid,
+				  BTRFS_UUID_KEY_SUBVOL,
 				  objectid);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-- 
2.20.1

