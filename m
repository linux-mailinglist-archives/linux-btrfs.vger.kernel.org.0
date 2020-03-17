Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6508187AFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCQIND (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:13:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:43136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQINC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:13:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62DACADA1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:13:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 33/39] btrfs: qgroup: Introduce qgroup backref cache
Date:   Tue, 17 Mar 2020 16:11:19 +0800
Message-Id: <20200317081125.36289-34-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317081125.36289-1-wqu@suse.com>
References: <20200317081125.36289-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This adds two new members for btrfs_fs_info:
- struct backref_cache *qgroup_backref_cache
  Only get initialized at qgroup enable time.
  This is to avoid further bloating up fs_info structure.

- struct mutex qgroup_backref_lock
  This is initialized at fs_info initial time.

This patch only introduces the skeleton, just initialization and cleanup
for these newly introduced members, no usage of them yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h   |  2 ++
 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/qgroup.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e45aad90b45e..6945754cca2a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -889,6 +889,8 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *qgroup_rescan_workers;
 	struct completion qgroup_rescan_completion;
 	struct btrfs_work qgroup_rescan_work;
+	struct mutex qgroup_backref_lock;
+	struct backref_cache *qgroup_backref_cache;
 	bool qgroup_rescan_running;	/* protected by qgroup_rescan_lock */
 
 	/* filesystem state */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 483b54077d01..67bb6fa5ab04 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2123,6 +2123,7 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 	fs_info->qgroup_ulist = NULL;
 	fs_info->qgroup_rescan_running = false;
 	mutex_init(&fs_info->qgroup_rescan_lock);
+	mutex_init(&fs_info->qgroup_backref_lock);
 }
 
 static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 75bc3b686498..3e628b5f1c39 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -339,6 +339,18 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
 		return 0;
 
+	mutex_lock(&fs_info->qgroup_backref_lock);
+	if (!fs_info->qgroup_backref_cache) {
+		fs_info->qgroup_backref_cache = kzalloc(
+				sizeof(struct backref_cache), GFP_KERNEL);
+		if (!fs_info->qgroup_backref_cache) {
+			mutex_unlock(&fs_info->qgroup_backref_lock);
+			return -ENOMEM;
+		}
+		backref_cache_init(fs_info, fs_info->qgroup_backref_cache, 0);
+	}
+	mutex_unlock(&fs_info->qgroup_backref_lock);
+
 	fs_info->qgroup_ulist = ulist_alloc(GFP_KERNEL);
 	if (!fs_info->qgroup_ulist) {
 		ret = -ENOMEM;
@@ -528,6 +540,14 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 	 */
 	ulist_free(fs_info->qgroup_ulist);
 	fs_info->qgroup_ulist = NULL;
+
+	mutex_lock(&fs_info->qgroup_backref_lock);
+	if (fs_info->qgroup_backref_cache) {
+		backref_cache_release(fs_info->qgroup_backref_cache);
+		kfree(fs_info->qgroup_backref_cache);
+		fs_info->qgroup_backref_cache = NULL;
+	}
+	mutex_unlock(&fs_info->qgroup_backref_lock);
 }
 
 static int add_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
@@ -891,6 +911,19 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 	int slot;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
+	mutex_lock(&fs_info->qgroup_backref_lock);
+	if (!fs_info->qgroup_backref_cache) {
+		fs_info->qgroup_backref_cache = kzalloc(
+				sizeof(struct backref_cache), GFP_KERNEL);
+		if (!fs_info->qgroup_backref_cache) {
+			mutex_unlock(&fs_info->qgroup_backref_lock);
+			ret = -ENOMEM;
+			goto out;
+		}
+		backref_cache_init(fs_info, fs_info->qgroup_backref_cache, 0);
+	}
+	mutex_unlock(&fs_info->qgroup_backref_lock);
+
 	if (fs_info->quota_root)
 		goto out;
 
@@ -1098,6 +1131,14 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 		goto end_trans;
 	}
 
+	mutex_lock(&fs_info->qgroup_backref_lock);
+	if (fs_info->qgroup_backref_cache) {
+		backref_cache_release(fs_info->qgroup_backref_cache);
+		kfree(fs_info->qgroup_backref_cache);
+		fs_info->qgroup_backref_cache = NULL;
+	}
+	mutex_unlock(&fs_info->qgroup_backref_lock);
+
 	list_del(&quota_root->dirty_list);
 
 	btrfs_tree_lock(quota_root->node);
@@ -2566,6 +2607,16 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	}
 	trace_qgroup_num_dirty_extents(fs_info, trans->transid,
 				       num_dirty_extents);
+
+	/*
+	 * Qgroup accounting happens at commit transaction time, thus the
+	 * backref cache will no longer be valid in next trans.
+	 * Free it up.
+	 */
+	mutex_lock(&fs_info->qgroup_backref_lock);
+	if (fs_info->qgroup_backref_cache)
+		backref_cache_release(fs_info->qgroup_backref_cache);
+	mutex_unlock(&fs_info->qgroup_backref_lock);
 	return ret;
 }
 
-- 
2.25.1

