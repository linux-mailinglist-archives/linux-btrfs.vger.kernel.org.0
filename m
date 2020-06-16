Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95081FA660
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 04:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFPCR4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 22:17:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:39594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgFPCRz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 22:17:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78D27AE69;
        Tue, 16 Jun 2020 02:17:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Greed Rong <greedrong@gmail.com>
Subject: [PATCH 3/4] btrfs: preallocate anon_dev for subvolume and snapshot creation
Date:   Tue, 16 Jun 2020 10:17:36 +0800
Message-Id: <20200616021737.44617-4-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616021737.44617-1-wqu@suse.com>
References: <20200616021737.44617-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When a lot of subvolumes are created, there is a user report about
transaction aborted:

  ------------[ cut here ]------------
  BTRFS: Transaction aborted (error -24)
  WARNING: CPU: 17 PID: 17041 at fs/btrfs/transaction.c:1576 create_pending_snapshot+0xbc4/0xd10 [btrfs]
  RIP: 0010:create_pending_snapshot+0xbc4/0xd10 [btrfs]
  Call Trace:
   create_pending_snapshots+0x82/0xa0 [btrfs]
   btrfs_commit_transaction+0x275/0x8c0 [btrfs]
   btrfs_mksubvol+0x4b9/0x500 [btrfs]
   btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
   btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
   btrfs_ioctl+0x11a4/0x2da0 [btrfs]
   do_vfs_ioctl+0xa9/0x640
   ksys_ioctl+0x67/0x90
   __x64_sys_ioctl+0x1a/0x20
   do_syscall_64+0x5a/0x110
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  ---[ end trace 33f2f83f3d5250e9 ]---
  BTRFS: error (device sda1) in create_pending_snapshot:1576: errno=-24 unknown
  BTRFS info (device sda1): forced readonly
  BTRFS warning (device sda1): Skipping commit of aborted transaction.
  BTRFS: error (device sda1) in cleanup_transaction:1831: errno=-24 unknown

[CAUSE]
When the global anonymous block device pool is exhausted, the following
call chain will fail, and lead to transaction abort:

 btrfs_ioctl_snap_create_v2()
 |- btrfs_ioctl_snap_create_transid()
    |- btrfs_mksubvol()
       |- btrfs_commit_transaction()
          |- create_pending_snapshot()
             |- btrfs_get_fs_root()
                |- btrfs_init_fs_root()
                   |- get_anon_bdev()

[FIX]
Although we can't enlarge the anonymous block device pool, at least we
can preallocate anon_dev for subvolume/snapshot creation.
So that when the pool is exhausted, user will get an error other than
aborting transaction later.

Reported-by: Greed Rong <greedrong@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c     | 51 ++++++++++++++++++++++++++++++++++++------
 fs/btrfs/disk-io.h     |  2 ++
 fs/btrfs/ioctl.c       | 21 ++++++++++++++++-
 fs/btrfs/transaction.c |  3 ++-
 fs/btrfs/transaction.h |  2 ++
 5 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cfc0ff288238..14fd69b71cb8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1395,7 +1395,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	goto out;
 }
 
-static int btrfs_init_fs_root(struct btrfs_root *root)
+static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 {
 	int ret;
 	unsigned int nofs_flag;
@@ -1435,9 +1435,13 @@ static int btrfs_init_fs_root(struct btrfs_root *root)
 	 */
 	if (is_fstree(root->root_key.objectid) &&
 	    btrfs_root_refs(&root->root_item)) {
-		ret = get_anon_bdev(&root->anon_dev);
-		if (ret)
-			goto fail;
+		if (!anon_dev) {
+			ret = get_anon_bdev(&root->anon_dev);
+			if (ret)
+				goto fail;
+		} else {
+			root->anon_dev = anon_dev;
+		}
 	}
 
 	mutex_lock(&root->objectid_mutex);
@@ -1542,8 +1546,27 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 }
 
 
-struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
-				     u64 objectid, bool check_ref)
+/*
+ * Get a fs root.
+ *
+ * For essential trees like root/extent tree, we grab it from fs_info directly.
+ * For subvolume trees, we check the cached fs roots first. If miss then
+ * read it from disk and add it to cached fs roots.
+ *
+ * Caller should release the root by calling btrfs_put_root() after the usage.
+ *
+ * NOTE: Reloc and log trees can't be read by this function as they share the
+ *	 same root objectid.
+ *
+ * @objectid:	Root (subvolume) id
+ * @anon_dev:	Preallocated anonymous block device number for new roots.
+ * 		Pass 0 for automatic allocation.
+ * @check_ref:	Whether to check root refs. If true, return -ENOENT for orphan
+ * 		roots.
+ */
+static struct btrfs_root *__get_fs_root(struct btrfs_fs_info *fs_info,
+					u64 objectid, dev_t anon_dev,
+					bool check_ref)
 {
 	struct btrfs_root *root;
 	struct btrfs_path *path;
@@ -1572,6 +1595,8 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 again:
 	root = btrfs_lookup_fs_root(fs_info, objectid);
 	if (root) {
+		/* Shouldn't get preallocated anon_dev for cached roots */
+		ASSERT(!anon_dev);
 		if (check_ref && btrfs_root_refs(&root->root_item) == 0) {
 			btrfs_put_root(root);
 			return ERR_PTR(-ENOENT);
@@ -1591,7 +1616,7 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 		goto fail;
 	}
 
-	ret = btrfs_init_fs_root(root);
+	ret = btrfs_init_fs_root(root, anon_dev);
 	if (ret)
 		goto fail;
 
@@ -1624,6 +1649,18 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 	return ERR_PTR(ret);
 }
 
+struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
+				     u64 objectid, bool check_ref)
+{
+	return __get_fs_root(fs_info, objectid, 0, check_ref);
+}
+
+struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
+					 u64 objectid, dev_t anon_dev)
+{
+	return __get_fs_root(fs_info, objectid, anon_dev, true);
+}
+
 static int btrfs_congested_fn(void *congested_data, int bdi_bits)
 {
 	struct btrfs_fs_info *info = (struct btrfs_fs_info *)congested_data;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index bf43245406c4..00dc39d47ed3 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -67,6 +67,8 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
 
 struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 				     u64 objectid, bool check_ref);
+struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
+					 u64 objectid, dev_t anon_dev);
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
 int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 168deb8ef68a..644bfe53ff61 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -566,6 +566,7 @@ static noinline int create_subvol(struct inode *dir,
 	struct inode *inode;
 	int ret;
 	int err;
+	dev_t anon_dev = 0;
 	u64 objectid;
 	u64 new_dirid = BTRFS_FIRST_FREE_OBJECTID;
 	u64 index = 0;
@@ -578,6 +579,10 @@ static noinline int create_subvol(struct inode *dir,
 	if (ret)
 		goto fail_free;
 
+	ret = get_anon_bdev(&anon_dev);
+	if (ret < 0)
+		goto fail_free;
+
 	/*
 	 * Don't create subvolume whose level is not zero. Or qgroup will be
 	 * screwed up since it assumes subvolume qgroup's level to be 0.
@@ -660,12 +665,15 @@ static noinline int create_subvol(struct inode *dir,
 		goto fail;
 
 	key.offset = (u64)-1;
-	new_root = btrfs_get_fs_root(fs_info, objectid, true);
+	new_root = btrfs_get_new_fs_root(fs_info, objectid, anon_dev);
 	if (IS_ERR(new_root)) {
+		free_anon_bdev(anon_dev);
 		ret = PTR_ERR(new_root);
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
+	/* Freeing would be done in btrfs_put_root() of @new_root */
+	anon_dev = 0;
 
 	btrfs_record_root_in_trans(trans, new_root);
 
@@ -735,6 +743,8 @@ static noinline int create_subvol(struct inode *dir,
 	return ret;
 
 fail_free:
+	if (anon_dev)
+		free_anon_bdev(anon_dev);
 	kfree(root_item);
 	return ret;
 }
@@ -762,6 +772,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	if (!pending_snapshot)
 		return -ENOMEM;
 
+	ret = get_anon_bdev(&pending_snapshot->anon_dev);
+	if (ret < 0)
+		goto free_pending;
 	pending_snapshot->root_item = kzalloc(sizeof(struct btrfs_root_item),
 			GFP_KERNEL);
 	pending_snapshot->path = btrfs_alloc_path();
@@ -823,10 +836,16 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 
 	d_instantiate(dentry, inode);
 	ret = 0;
+	pending_snapshot->anon_dev = 0;
 fail:
+	/* Prevent doulbe freeing of anon_dev */
+	if (ret && pending_snapshot->snap)
+		pending_snapshot->snap->anon_dev = 0;
 	btrfs_put_root(pending_snapshot->snap);
 	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
 free_pending:
+	if (pending_snapshot->anon_dev)
+		free_anon_bdev(pending_snapshot->anon_dev);
 	kfree(pending_snapshot->root_item);
 	btrfs_free_path(pending_snapshot->path);
 	kfree(pending_snapshot);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b359d4b17658..48f3db64cd40 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1630,7 +1630,8 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	}
 
 	key.offset = (u64)-1;
-	pending->snap = btrfs_get_fs_root(fs_info, objectid, true);
+	pending->snap = btrfs_get_new_fs_root(fs_info, objectid,
+					      pending->anon_dev);
 	if (IS_ERR(pending->snap)) {
 		ret = PTR_ERR(pending->snap);
 		btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index bf102e64bfb2..a122a712f5cc 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -151,6 +151,8 @@ struct btrfs_pending_snapshot {
 	struct btrfs_block_rsv block_rsv;
 	/* extra metadata reservation for relocation */
 	int error;
+	/* Preallocated anonymous block device number */
+	dev_t anon_dev;
 	bool readonly;
 	struct list_head list;
 };
-- 
2.27.0

