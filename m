Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3B7C3F2A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 19:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfJAR5Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 13:57:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:33258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731687AbfJAR5Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 13:57:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21D13AF0B;
        Tue,  1 Oct 2019 17:57:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F2CB3DA88C; Tue,  1 Oct 2019 19:57:39 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: add __pure attribute to functions
Date:   Tue,  1 Oct 2019 19:57:39 +0200
Message-Id: <faadfd67d10404a342d91a910e40fc2d0f5f4e6c.1569587835.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569587835.git.dsterba@suse.com>
References: <cover.1569587835.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The attribute is more relaxed than const and the functions could
dereference pointers, as long as the observable state is not changed. We
do have such functions, based on -Wsuggest-attribute=pure .

The visible effects of this patch are negligible, there are differences
in the assembly but hard to summarize.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/async-thread.c | 6 ++----
 fs/btrfs/async-thread.h | 4 ++--
 fs/btrfs/ctree.c        | 2 +-
 fs/btrfs/ctree.h        | 4 ++--
 fs/btrfs/dev-replace.c  | 2 +-
 fs/btrfs/dev-replace.h  | 2 +-
 fs/btrfs/ioctl.c        | 2 +-
 fs/btrfs/space-info.c   | 2 +-
 fs/btrfs/space-info.h   | 2 +-
 9 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index b97ae1b03417..1d32a07bb2d1 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -53,14 +53,12 @@ struct btrfs_workqueue {
 	struct __btrfs_workqueue *high;
 };
 
-struct btrfs_fs_info *
-btrfs_workqueue_owner(const struct __btrfs_workqueue *wq)
+struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct __btrfs_workqueue *wq)
 {
 	return wq->fs_info;
 }
 
-struct btrfs_fs_info *
-btrfs_work_owner(const struct btrfs_work *work)
+struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work)
 {
 	return work->wq->fs_info;
 }
diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
index c5bf2b117c05..a4434301d84d 100644
--- a/fs/btrfs/async-thread.h
+++ b/fs/btrfs/async-thread.h
@@ -41,8 +41,8 @@ void btrfs_queue_work(struct btrfs_workqueue *wq,
 void btrfs_destroy_workqueue(struct btrfs_workqueue *wq);
 void btrfs_workqueue_set_max(struct btrfs_workqueue *wq, int max);
 void btrfs_set_work_high_priority(struct btrfs_work *work);
-struct btrfs_fs_info *btrfs_work_owner(const struct btrfs_work *work);
-struct btrfs_fs_info *btrfs_workqueue_owner(const struct __btrfs_workqueue *wq);
+struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work);
+struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct __btrfs_workqueue *wq);
 bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq);
 
 #endif
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f2f9cf1149a4..3a4d8e27e565 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1538,7 +1538,7 @@ static int comp_keys(const struct btrfs_disk_key *disk,
 /*
  * same as comp_keys only with two btrfs_key's
  */
-int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2)
+int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2)
 {
 	if (k1->objectid > k2->objectid)
 		return 1;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 793085770c84..df0f2de69991 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2511,7 +2511,7 @@ void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
 /* ctree.c */
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
 		     int level, int *slot);
-int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
+int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
 int btrfs_previous_item(struct btrfs_root *root,
 			struct btrfs_path *path, u64 min_objectid,
 			int type);
@@ -2912,7 +2912,7 @@ long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
-int btrfs_is_empty_uuid(u8 *uuid);
+int __pure btrfs_is_empty_uuid(u8 *uuid);
 int btrfs_defrag_file(struct inode *inode, struct file *file,
 		      struct btrfs_ioctl_defrag_range_args *range,
 		      u64 newer_than, unsigned long max_pages);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 48890826b5e6..f639dde2a679 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -986,7 +986,7 @@ static int btrfs_dev_replace_kthread(void *data)
 	return 0;
 }
 
-int btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
+int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace)
 {
 	if (!dev_replace->is_valid)
 		return 0;
diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
index 78c5d8f1adda..60b70dacc299 100644
--- a/fs/btrfs/dev-replace.h
+++ b/fs/btrfs/dev-replace.h
@@ -17,6 +17,6 @@ void btrfs_dev_replace_status(struct btrfs_fs_info *fs_info,
 int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info);
 void btrfs_dev_replace_suspend_for_unmount(struct btrfs_fs_info *fs_info);
 int btrfs_resume_dev_replace_async(struct btrfs_fs_info *fs_info);
-int btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
+int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
 
 #endif
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index de730e56d3f5..55b41d5e7ea9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -541,7 +541,7 @@ static noinline int btrfs_ioctl_fitrim(struct file *file, void __user *arg)
 	return 0;
 }
 
-int btrfs_is_empty_uuid(u8 *uuid)
+int __pure btrfs_is_empty_uuid(u8 *uuid)
 {
 	int i;
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 98dc092a905e..f32993efbf61 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -10,7 +10,7 @@
 #include "transaction.h"
 #include "block-group.h"
 
-u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
+u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
 			  bool may_use_included)
 {
 	ASSERT(s_info);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 8867e84aa33d..2d8c811a9792 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -116,7 +116,7 @@ void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
 			     struct btrfs_space_info **space_info);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 					       u64 flags);
-u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
+u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
 			  bool may_use_included);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
-- 
2.23.0

