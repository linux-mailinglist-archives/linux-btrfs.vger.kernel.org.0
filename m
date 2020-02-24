Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4342A16AA49
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBXPiA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 10:38:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:19218 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgBXPh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 10:37:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 07:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="260374555"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 24 Feb 2020 07:37:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CAB223C0; Mon, 24 Feb 2020 17:37:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/4] Btrfs: Switch to use new generic UUID API
Date:   Mon, 24 Feb 2020 17:37:51 +0200
Message-Id: <20200224153752.35063-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224153752.35063-1-andriy.shevchenko@linux.intel.com>
References: <20200224153752.35063-1-andriy.shevchenko@linux.intel.com>
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
index 1a552391344e..a1801a8923af 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1220,7 +1220,6 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	unsigned int nofs_flag;
 	int ret = 0;
-	uuid_le uuid = NULL_UUID_LE;
 
 	/*
 	 * We're holding a transaction handle, so use a NOFS memory allocation
@@ -1259,8 +1258,9 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
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
index 54168a7ede00..1d314b94fd93 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -574,7 +574,6 @@ static noinline int create_subvol(struct inode *dir,
 	u64 objectid;
 	u64 new_dirid = BTRFS_FIRST_FREE_OBJECTID;
 	u64 index = 0;
-	uuid_le new_uuid;
 
 	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
 	if (!root_item)
@@ -644,8 +643,7 @@ static noinline int create_subvol(struct inode *dir,
 
 	btrfs_set_root_generation_v2(root_item,
 			btrfs_root_generation(root_item));
-	uuid_le_gen(&new_uuid);
-	memcpy(root_item->uuid, new_uuid.b, BTRFS_UUID_SIZE);
+	generate_random_guid(root_item->uuid);
 	btrfs_set_stack_timespec_sec(&root_item->otime, cur_time.tv_sec);
 	btrfs_set_stack_timespec_nsec(&root_item->otime, cur_time.tv_nsec);
 	root_item->ctime = root_item->otime;
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index b37904327c9e..98b6e0d980f9 100644
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
index d00af9c13c40..56db59ea9d93 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1478,7 +1478,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	u64 index = 0;
 	u64 objectid;
 	u64 root_flags;
-	uuid_le new_uuid;
 
 	ASSERT(pending->path);
 	path = pending->path;
@@ -1571,8 +1570,7 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 
 	btrfs_set_root_generation_v2(new_root_item,
 			trans->transid);
-	uuid_le_gen(&new_uuid);
-	memcpy(new_root_item->uuid, new_uuid.b, BTRFS_UUID_SIZE);
+	generate_random_guid(new_root_item->uuid);
 	memcpy(new_root_item->parent_uuid, root->root_item.uuid,
 			BTRFS_UUID_SIZE);
 	if (!(root_flags & BTRFS_ROOT_SUBVOL_RDONLY)) {
@@ -1683,7 +1681,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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
2.25.0

