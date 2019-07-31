Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A97BE4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfGaKYB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 06:24:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:32908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728243AbfGaKYB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 06:24:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 998BEAE6D
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2019 10:23:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/3] btrfs: qgroup: Introduce quota pause infrastrucutre
Date:   Wed, 31 Jul 2019 18:23:51 +0800
Message-Id: <20190731102352.6028-3-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731102352.6028-1-wqu@suse.com>
References: <20190731102352.6028-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will introduce the following functions to provide a way to
pause/resume quota:
- btrfs_quota_pause()
- btrfs_quota_is_paused()
- btrfs_quota_resume()

btrfs_quota_pause() will pause qgroup and mark qgroup status to
inconsistent, while still keep the on-disk status as qgroup enabled.

In paused status, newer delayed refs will not be accounted for qgroup,
thus no qgroup overhead at commit transaction time.

While in paused status, btrfs qgroup status item and qgroup root is
still kept as it, the status item still has STATUS_FLAG_ON, so next
mount will still enable qgroup (although with STATUS_FLAG_INCONSIST
flag)

The main purpose is to allow btrfs to skip certain qgroup heavy workload
and trigger a rescan later.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 79 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/qgroup.h |  3 ++
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3e6ffbbd8b0a..be51ccb8a1b4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -22,6 +22,8 @@
 #include "extent_io.h"
 #include "qgroup.h"
 
+/* In-memory only flag for paused qgroup */
+#define BTRFS_QGROUP_STATUS_FLAG_PAUSED		(1 << 31)
 
 /* TODO XXX FIXME
  *  - subvol delete -> delete when ref goes to 0? delete limits also?
@@ -795,12 +797,16 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 	struct btrfs_key key;
 	struct extent_buffer *l;
 	struct btrfs_qgroup_status_item *ptr;
+	u64 on_disk_flag_mask;
 	int ret;
 	int slot;
 
 	key.objectid = 0;
 	key.type = BTRFS_QGROUP_STATUS_KEY;
 	key.offset = 0;
+	on_disk_flag_mask = BTRFS_QGROUP_STATUS_FLAG_ON |
+			    BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
+			    BTRFS_QGROUP_STATUS_FLAG_RESCAN;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -816,7 +822,8 @@ static int update_qgroup_status_item(struct btrfs_trans_handle *trans)
 	l = path->nodes[0];
 	slot = path->slots[0];
 	ptr = btrfs_item_ptr(l, slot, struct btrfs_qgroup_status_item);
-	btrfs_set_qgroup_status_flags(l, ptr, fs_info->qgroup_flags);
+	btrfs_set_qgroup_status_flags(l, ptr, fs_info->qgroup_flags &
+					      on_disk_flag_mask);
 	btrfs_set_qgroup_status_generation(l, ptr, trans->transid);
 	btrfs_set_qgroup_status_rescan(l, ptr,
 				fs_info->qgroup_rescan_progress.objectid);
@@ -1115,6 +1122,72 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+/*
+ * Pause qgroup temporarily.
+ *
+ * Will mark qgroup inconsistent and update qgroup tree to reflect it.
+ * Then clear BTRFS_FS_QUOTA_ENABLED flag of fs_info, and cleanup any existing
+ * qgroup structures.
+ * But still leave on-disk qgroup status as quota enabled, so when user
+ * mount such qgroup paused fs, it still shows qgroup enabled.
+ */
+int btrfs_quota_pause(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_delayed_ref_root *delayed_refs;
+	int ret = 0;
+
+	delayed_refs = &trans->transaction->delayed_refs;
+	if (test_and_clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+		if (!fs_info->quota_root)
+			return 0;
+
+		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT |
+					 BTRFS_QGROUP_STATUS_FLAG_PAUSED;
+		ret = update_qgroup_status_item(trans);
+
+		/* Clean up dirty qgroups */
+		spin_lock(&fs_info->qgroup_lock);
+		while (!list_empty(&fs_info->dirty_qgroups))
+			list_del_init(fs_info->dirty_qgroups.next);
+		spin_unlock(&fs_info->qgroup_lock);
+
+		/* Cleanup qgroup traced extents by running accounting now */
+		spin_lock(&delayed_refs->lock);
+		btrfs_qgroup_account_extents(trans);
+		spin_unlock(&delayed_refs->lock);
+
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
+bool btrfs_quota_is_paused(struct btrfs_fs_info *fs_info)
+{
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
+	    fs_info->quota_root && fs_info->qgroup_flags &
+	    BTRFS_QGROUP_STATUS_FLAG_PAUSED)
+		return true;
+	return false;
+}
+
+/*
+ * Resume previously paused quota
+ *
+ * This function will re-set BTRFS_FS_QUOTA_ENABLED bit, and queue
+ * qgroup rescan work
+ */
+int btrfs_quota_resume(struct btrfs_fs_info *fs_info)
+{
+	if (!fs_info->quota_root)
+		return 0;
+	if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_PAUSED))
+		return 0;
+	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
+	return btrfs_qgroup_rescan(fs_info);
+}
+
 static void qgroup_dirty(struct btrfs_fs_info *fs_info,
 			 struct btrfs_qgroup *qgroup)
 {
@@ -2497,7 +2570,9 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	u64 num_dirty_extents = 0;
 	u64 qgroup_to_skip;
 	int ret = 0;
+	bool need_search_roots;
 
+	need_search_roots = test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
 	delayed_refs = &trans->transaction->delayed_refs;
 	qgroup_to_skip = delayed_refs->qgroup_to_skip;
 	while ((node = rb_first(&delayed_refs->dirty_extent_root))) {
@@ -2507,7 +2582,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		num_dirty_extents++;
 		trace_btrfs_qgroup_account_extents(fs_info, record);
 
-		if (!ret) {
+		if (!ret && need_search_roots) {
 			/*
 			 * Old roots should be searched when inserting qgroup
 			 * extent record
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 46ba7bd2961c..334941146a2e 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -234,6 +234,9 @@ struct btrfs_qgroup {
 
 int btrfs_quota_enable(struct btrfs_fs_info *fs_info);
 int btrfs_quota_disable(struct btrfs_fs_info *fs_info);
+int btrfs_quota_pause(struct btrfs_trans_handle *trans);
+bool btrfs_quota_is_paused(struct btrfs_fs_info *fs_info);
+int btrfs_quota_resume(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info);
 void btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info);
 int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
-- 
2.22.0

