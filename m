Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 218266AB4D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 17:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfGPPEW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 11:04:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:50140 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbfGPPEW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 11:04:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 08:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,498,1557212400"; 
   d="scan'208";a="178574962"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Jul 2019 08:04:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F05176; Tue, 16 Jul 2019 18:04:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] Btrfs: Switch to use new generic UUID API
Date:   Tue, 16 Jul 2019 18:04:17 +0300
Message-Id: <20190716150418.84018-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716150418.84018-1-andriy.shevchenko@linux.intel.com>
References: <20190716150418.84018-1-andriy.shevchenko@linux.intel.com>
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
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/disk-io.c     |  6 +++---
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/ioctl.c       | 25 +++++++------------------
 fs/btrfs/root-tree.c   |  4 +---
 fs/btrfs/send.c        |  6 +++---
 fs/btrfs/transaction.c |  9 ++++-----
 fs/btrfs/volumes.c     |  8 ++++----
 8 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 299e11e6c554..1fa396c0478e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3207,7 +3207,6 @@ long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
-int btrfs_is_empty_uuid(u8 *uuid);
 int btrfs_defrag_file(struct inode *inode, struct file *file,
 		      struct btrfs_ioctl_defrag_range_args *range,
 		      u64 newer_than, unsigned long max_pages);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 41a2bd2e0c56..9a3dd918b8dd 100644
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
+		guid_gen_raw(root->root_item.uuid);
+	else
+		guid_copy_to_raw(root->root_item.uuid, &guid_null);
 	root->root_item.drop_level = 0;
 
 	key.objectid = objectid;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1af069a9a0c7..9520d19234ee 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4410,7 +4410,7 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		err = ret;
 		goto out_end_trans;
 	}
-	if (!btrfs_is_empty_uuid(dest->root_item.received_uuid)) {
+	if (!guid_is_null_raw(dest->root_item.received_uuid)) {
 		ret = btrfs_uuid_tree_remove(trans,
 					  dest->root_item.received_uuid,
 					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 818f7ec8bb0e..f9238d213079 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -540,17 +540,6 @@ static noinline int btrfs_ioctl_fitrim(struct file *file, void __user *arg)
 	return 0;
 }
 
-int btrfs_is_empty_uuid(u8 *uuid)
-{
-	int i;
-
-	for (i = 0; i < BTRFS_UUID_SIZE; i++) {
-		if (uuid[i])
-			return 0;
-	}
-	return 1;
-}
-
 static noinline int create_subvol(struct inode *dir,
 				  struct dentry *dentry,
 				  const char *name, int namelen,
@@ -573,7 +562,6 @@ static noinline int create_subvol(struct inode *dir,
 	u64 objectid;
 	u64 new_dirid = BTRFS_FIRST_FREE_OBJECTID;
 	u64 index = 0;
-	uuid_le new_uuid;
 
 	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
 	if (!root_item)
@@ -643,8 +631,7 @@ static noinline int create_subvol(struct inode *dir,
 
 	btrfs_set_root_generation_v2(root_item,
 			btrfs_root_generation(root_item));
-	uuid_le_gen(&new_uuid);
-	memcpy(root_item->uuid, new_uuid.b, BTRFS_UUID_SIZE);
+	guid_gen_raw(root_item->uuid);
 	btrfs_set_stack_timespec_sec(&root_item->otime, cur_time.tv_sec);
 	btrfs_set_stack_timespec_nsec(&root_item->otime, cur_time.tv_nsec);
 	root_item->ctime = root_item->otime;
@@ -3170,14 +3157,16 @@ static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_ioctl_dev_info_args *di_args;
 	struct btrfs_device *dev;
+	u8 *s_uuid;
 	int ret = 0;
-	char *s_uuid = NULL;
 
 	di_args = memdup_user(arg, sizeof(*di_args));
 	if (IS_ERR(di_args))
 		return PTR_ERR(di_args);
 
-	if (!btrfs_is_empty_uuid(di_args->uuid))
+	if (guid_is_null_raw(di_args->uuid))
+		s_uuid = NULL;
+	else
 		s_uuid = di_args->uuid;
 
 	rcu_read_lock();
@@ -5156,7 +5145,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	received_uuid_changed = memcmp(root_item->received_uuid, sa->uuid,
 				       BTRFS_UUID_SIZE);
 	if (received_uuid_changed &&
-	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
+	    !guid_is_null_raw(root_item->received_uuid)) {
 		ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
 					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
 					  root->root_key.objectid);
@@ -5180,7 +5169,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 		btrfs_end_transaction(trans);
 		goto out;
 	}
-	if (received_uuid_changed && !btrfs_is_empty_uuid(sa->uuid)) {
+	if (received_uuid_changed && !guid_is_null_raw(sa->uuid)) {
 		ret = btrfs_uuid_tree_add(trans, sa->uuid,
 					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
 					  root->root_key.objectid);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 47733fb55df7..7bc7a504fdc8 100644
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
+		guid_gen_raw(item->uuid);
 	}
 }
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 69b59bf75882..b681e2d523f0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2361,7 +2361,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 
 	TLV_PUT_STRING(sctx, BTRFS_SEND_A_PATH, name, namelen);
 
-	if (!btrfs_is_empty_uuid(sctx->send_root->root_item.received_uuid))
+	if (!guid_is_null_raw(sctx->send_root->root_item.received_uuid))
 		TLV_PUT_UUID(sctx, BTRFS_SEND_A_UUID,
 			    sctx->send_root->root_item.received_uuid);
 	else
@@ -2371,7 +2371,7 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_CTRANSID,
 		    le64_to_cpu(sctx->send_root->root_item.ctransid));
 	if (parent_root) {
-		if (!btrfs_is_empty_uuid(parent_root->root_item.received_uuid))
+		if (!guid_is_null_raw(parent_root->root_item.received_uuid))
 			TLV_PUT_UUID(sctx, BTRFS_SEND_A_CLONE_UUID,
 				     parent_root->root_item.received_uuid);
 		else
@@ -4930,7 +4930,7 @@ static int send_clone(struct send_ctx *sctx,
 	 * subvolume and then use that as the parent and try to receive on a
 	 * different host.
 	 */
-	if (!btrfs_is_empty_uuid(clone_root->root->root_item.received_uuid))
+	if (!guid_is_null_raw(clone_root->root->root_item.received_uuid))
 		TLV_PUT_UUID(sctx, BTRFS_SEND_A_CLONE_UUID,
 			     clone_root->root->root_item.received_uuid);
 	else
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3b8ae1a8f02d..40313f895ee1 100644
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
+	guid_gen_raw(new_root_item->uuid);
 	memcpy(new_root_item->parent_uuid, root->root_item.uuid,
 			BTRFS_UUID_SIZE);
 	if (!(root_flags & BTRFS_ROOT_SUBVOL_RDONLY)) {
@@ -1600,13 +1598,14 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
-	ret = btrfs_uuid_tree_add(trans, new_uuid.b, BTRFS_UUID_KEY_SUBVOL,
+	ret = btrfs_uuid_tree_add(trans, new_root_item->uuid,
+				  BTRFS_UUID_KEY_SUBVOL,
 				  objectid);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
-	if (!btrfs_is_empty_uuid(new_root_item->received_uuid)) {
+	if (!guid_is_null_raw(new_root_item->received_uuid)) {
 		ret = btrfs_uuid_tree_add(trans, new_root_item->received_uuid,
 					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
 					  objectid);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a13ddba1ebc3..90072f53ad9c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4469,8 +4469,8 @@ static int btrfs_uuid_scan_kthread(void *data)
 		if (btrfs_root_refs(&root_item) == 0)
 			goto skip;
 
-		if (!btrfs_is_empty_uuid(root_item.uuid) ||
-		    !btrfs_is_empty_uuid(root_item.received_uuid)) {
+		if (!guid_is_null_raw(root_item.uuid) ||
+		    !guid_is_null_raw(root_item.received_uuid)) {
 			if (trans)
 				goto update_tree;
 
@@ -4489,7 +4489,7 @@ static int btrfs_uuid_scan_kthread(void *data)
 			goto skip;
 		}
 update_tree:
-		if (!btrfs_is_empty_uuid(root_item.uuid)) {
+		if (!guid_is_null_raw(root_item.uuid)) {
 			ret = btrfs_uuid_tree_add(trans, root_item.uuid,
 						  BTRFS_UUID_KEY_SUBVOL,
 						  key.objectid);
@@ -4500,7 +4500,7 @@ static int btrfs_uuid_scan_kthread(void *data)
 			}
 		}
 
-		if (!btrfs_is_empty_uuid(root_item.received_uuid)) {
+		if (!guid_is_null_raw(root_item.received_uuid)) {
 			ret = btrfs_uuid_tree_add(trans,
 						  root_item.received_uuid,
 						 BTRFS_UUID_KEY_RECEIVED_SUBVOL,
-- 
2.20.1

