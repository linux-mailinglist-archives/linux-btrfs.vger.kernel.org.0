Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F620C636
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jun 2020 07:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgF1FH2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jun 2020 01:07:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:50866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgF1FH2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jun 2020 01:07:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16686AE55
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jun 2020 05:07:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
Date:   Sun, 28 Jun 2020 13:07:15 +0800
Message-Id: <20200628050715.60961-3-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628050715.60961-1-wqu@suse.com>
References: <20200628050715.60961-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will add the following sysfs interface:
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/reference
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/exclusive
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_reference
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_exclusive
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/limit_flags
 ^^^ Above are already in "btrfs qgroup show" command output ^^^

/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_data
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_pertrans
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_prealloc

The last 3 rsv related members are not visible to users, but can be very
useful to debug qgroup limit related bugs.

Also, to avoid '/' used in <qgroup_id>, the separator between qgroup
level and qgroup id is changed to '_'.

The interface is not hidden behind 'debug' as I want this interface to
be included into production build so we could have an easier life to
debug qgroup rsv related bugs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h  |   1 +
 fs/btrfs/qgroup.c |  44 +++++++++++---
 fs/btrfs/qgroup.h |  11 ++++
 fs/btrfs/sysfs.c  | 151 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/sysfs.h  |   6 ++
 5 files changed, 204 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d8301bf240e0..9c0394893e8e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -779,6 +779,7 @@ struct btrfs_fs_info {
 	u32 thread_pool_size;
 
 	struct kobject *space_info_kobj;
+	struct kobject *qgroups_kobj;
 
 	u64 total_pinned;
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 014d32429165..fc90ec0a86f1 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -22,6 +22,7 @@
 #include "extent_io.h"
 #include "qgroup.h"
 #include "block-group.h"
+#include "sysfs.h"
 
 /* TODO XXX FIXME
  *  - subvol delete -> delete when ref goes to 0? delete limits also?
@@ -220,10 +221,12 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 	return qgroup;
 }
 
-static void __del_qgroup_rb(struct btrfs_qgroup *qgroup)
+static void __del_qgroup_rb(struct btrfs_fs_info *fs_info,
+			    struct btrfs_qgroup *qgroup)
 {
 	struct btrfs_qgroup_list *list;
 
+	btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
 	list_del(&qgroup->dirty);
 	while (!list_empty(&qgroup->groups)) {
 		list = list_first_entry(&qgroup->groups,
@@ -252,7 +255,7 @@ static int del_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
 		return -ENOENT;
 
 	rb_erase(&qgroup->node, &fs_info->qgroup_tree);
-	__del_qgroup_rb(qgroup);
+	__del_qgroup_rb(fs_info, qgroup);
 	return 0;
 }
 
@@ -351,6 +354,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	ret = btrfs_sysfs_add_qgroups(fs_info);
+	if (ret < 0)
+		goto out;
 	/* default this to quota off, in case no status key is found */
 	fs_info->qgroup_flags = 0;
 
@@ -412,6 +418,10 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 				goto out;
 			}
 		}
+		ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
+		if (ret < 0)
+			goto out;
+
 		switch (found_key.type) {
 		case BTRFS_QGROUP_INFO_KEY: {
 			struct btrfs_qgroup_info_item *ptr;
@@ -500,16 +510,12 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 		ulist_free(fs_info->qgroup_ulist);
 		fs_info->qgroup_ulist = NULL;
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+		btrfs_sysfs_del_qgroups(fs_info);
 	}
 
 	return ret < 0 ? ret : 0;
 }
 
-static u64 btrfs_qgroup_subvolid(u64 qgroupid)
-{
-	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
-}
-
 /*
  * Called in close_ctree() when quota is still enabled.  This verifies we don't
  * leak some reserved space.
@@ -562,7 +568,7 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 	while ((n = rb_first(&fs_info->qgroup_tree))) {
 		qgroup = rb_entry(n, struct btrfs_qgroup, node);
 		rb_erase(n, &fs_info->qgroup_tree);
-		__del_qgroup_rb(qgroup);
+		__del_qgroup_rb(fs_info, qgroup);
 	}
 	/*
 	 * We call btrfs_free_qgroup_config() when unmounting
@@ -571,6 +577,7 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 	 */
 	ulist_free(fs_info->qgroup_ulist);
 	fs_info->qgroup_ulist = NULL;
+	btrfs_sysfs_del_qgroups(fs_info);
 }
 
 static int add_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
@@ -943,6 +950,9 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	ret = btrfs_sysfs_add_qgroups(fs_info);
+	if (ret < 0)
+		goto out;
 	/*
 	 * 1 for quota root item
 	 * 1 for BTRFS_QGROUP_STATUS item
@@ -1030,6 +1040,11 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 				btrfs_abort_transaction(trans, ret);
 				goto out_free_path;
 			}
+			ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				goto out_free_path;
+			}
 		}
 		ret = btrfs_next_item(tree_root, path);
 		if (ret < 0) {
@@ -1054,6 +1069,11 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 		btrfs_abort_transaction(trans, ret);
 		goto out_free_path;
 	}
+	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		goto out_free_path;
+	}
 
 	ret = btrfs_commit_transaction(trans);
 	trans = NULL;
@@ -1089,6 +1109,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 		fs_info->qgroup_ulist = NULL;
 		if (trans)
 			btrfs_end_transaction(trans);
+		btrfs_sysfs_del_qgroups(fs_info);
 	}
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	return ret;
@@ -1441,8 +1462,11 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	qgroup = add_qgroup_rb(fs_info, qgroupid);
 	spin_unlock(&fs_info->qgroup_lock);
 
-	if (IS_ERR(qgroup))
+	if (IS_ERR(qgroup)) {
 		ret = PTR_ERR(qgroup);
+		goto out;
+	}
+	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	return ret;
@@ -2861,6 +2885,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 unlock:
 	spin_unlock(&fs_info->qgroup_lock);
+	if (!ret)
+		ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
 out:
 	if (!committing)
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 3be5198a3719..0116779d34e5 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -8,6 +8,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/kobject.h>
 #include "ulist.h"
 #include "delayed-ref.h"
 
@@ -223,8 +224,18 @@ struct btrfs_qgroup {
 	 */
 	u64 old_refcnt;
 	u64 new_refcnt;
+
+	/*
+	 * Sysfs kobjectid
+	 */
+	struct kobject kobj;
 };
 
+static inline u64 btrfs_qgroup_subvolid(u64 qgroupid)
+{
+	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
+}
+
 /*
  * For qgroup event trace points only
  */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index a39bff64ff24..3d7a939601a9 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -19,6 +19,7 @@
 #include "volumes.h"
 #include "space-info.h"
 #include "block-group.h"
+#include "qgroup.h"
 
 struct btrfs_feature_attr {
 	struct kobj_attribute kobj_attr;
@@ -1455,6 +1456,156 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	return error;
 }
 
+static struct btrfs_fs_info *qgroup_kobj_to_fs_info(struct kobject *kobj)
+{
+	return to_fs_info(kobj->parent->parent);
+}
+
+#define QGROUP_ATTR(_member, _show_name)				\
+static ssize_t btrfs_qgroup_show_##_member(struct kobject *qgroup_kobj,	\
+					struct kobj_attribute *a,	\
+					char *buf)			\
+{									\
+	struct btrfs_fs_info *fs_info = qgroup_kobj_to_fs_info(		\
+			qgroup_kobj);					\
+	struct btrfs_qgroup *qgroup = container_of(qgroup_kobj,		\
+			struct btrfs_qgroup, kobj);			\
+									\
+	return btrfs_show_u64(&qgroup->_member, &fs_info->qgroup_lock,	\
+			buf);						\
+}									\
+BTRFS_ATTR(qgroup, _show_name, btrfs_qgroup_show_##_member)
+
+#define QGROUP_RSV_ATTR(_name, _type)					\
+static ssize_t btrfs_qgroup_rsv_show_##_name(struct kobject *qgroup_kobj, \
+					struct kobj_attribute *a,	\
+					char *buf)			\
+{									\
+	struct btrfs_fs_info *fs_info = qgroup_kobj_to_fs_info(		\
+			qgroup_kobj);					\
+	struct btrfs_qgroup *qgroup = container_of(qgroup_kobj,		\
+			struct btrfs_qgroup, kobj);			\
+									\
+	return btrfs_show_u64(&qgroup->rsv.values[_type],		\
+			&fs_info->qgroup_lock, buf);			\
+}									\
+BTRFS_ATTR(qgroup, rsv_##_name, btrfs_qgroup_rsv_show_##_name)
+
+QGROUP_ATTR(rfer, reference);
+QGROUP_ATTR(excl, exclusive);
+QGROUP_ATTR(max_rfer, max_reference);
+QGROUP_ATTR(max_excl, max_exclusive);
+QGROUP_ATTR(lim_flags, limit_flags);
+QGROUP_RSV_ATTR(data, BTRFS_QGROUP_RSV_DATA);
+QGROUP_RSV_ATTR(meta_pertrans, BTRFS_QGROUP_RSV_META_PERTRANS);
+QGROUP_RSV_ATTR(meta_prealloc, BTRFS_QGROUP_RSV_META_PREALLOC);
+
+static struct attribute *qgroup_attrs[] = {
+	BTRFS_ATTR_PTR(qgroup, reference),
+	BTRFS_ATTR_PTR(qgroup, exclusive),
+	BTRFS_ATTR_PTR(qgroup, max_reference),
+	BTRFS_ATTR_PTR(qgroup, max_exclusive),
+	BTRFS_ATTR_PTR(qgroup, limit_flags),
+	BTRFS_ATTR_PTR(qgroup, rsv_data),
+	BTRFS_ATTR_PTR(qgroup, rsv_meta_pertrans),
+	BTRFS_ATTR_PTR(qgroup, rsv_meta_prealloc),
+	NULL
+};
+ATTRIBUTE_GROUPS(qgroup);
+
+static void qgroup_release(struct kobject *kobj)
+{
+	struct btrfs_qgroup *qgroup = container_of(kobj, struct btrfs_qgroup,
+			kobj);
+
+	memset(&qgroup->kobj, 0, sizeof(*kobj));
+}
+
+static struct kobj_type qgroup_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = qgroup_release,
+	.default_groups = qgroup_groups,
+};
+
+int btrfs_sysfs_add_one_qgroup(struct btrfs_fs_info *fs_info,
+				struct btrfs_qgroup *qgroup)
+{
+	struct kobject *qgroups_kobj = fs_info->qgroups_kobj;
+	int ret;
+
+	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
+		return 0;
+	if (qgroup->kobj.state_initialized)
+		return 0;
+	if (!qgroups_kobj)
+		return -EINVAL;
+
+	ret = kobject_init_and_add(&qgroup->kobj, &qgroup_ktype, qgroups_kobj,
+			"%hu_%llu", btrfs_qgroup_level(qgroup->qgroupid),
+			btrfs_qgroup_subvolid(qgroup->qgroupid));
+	if (ret < 0)
+		kobject_put(&qgroup->kobj);
+
+	return ret;
+}
+
+void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_qgroup *qgroup;
+	struct btrfs_qgroup *next;
+
+	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
+		return;
+	rbtree_postorder_for_each_entry_safe(qgroup, next,
+			&fs_info->qgroup_tree, node)
+		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
+	kobject_del(fs_info->qgroups_kobj);
+	kobject_put(fs_info->qgroups_kobj);
+	fs_info->qgroups_kobj = NULL;
+}
+
+/* Called when qgroup get initialized, thus there is no need for extra lock. */
+int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info)
+{
+	struct kobject *fsid_kobj = &fs_info->fs_devices->fsid_kobj;
+	struct btrfs_qgroup *qgroup;
+	struct btrfs_qgroup *next;
+	int ret = 0;
+
+	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
+		return 0;
+	ASSERT(fsid_kobj);
+	if (fs_info->qgroups_kobj)
+		return 0;
+
+	fs_info->qgroups_kobj = kobject_create_and_add("qgroups", fsid_kobj);
+	if (!fs_info->qgroups_kobj) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	rbtree_postorder_for_each_entry_safe(qgroup, next,
+			&fs_info->qgroup_tree, node) {
+		ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	if (ret < 0)
+		btrfs_sysfs_del_qgroups(fs_info);
+	return ret;
+}
+
+void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
+				struct btrfs_qgroup *qgroup)
+{
+	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
+		return;
+	if (qgroup->kobj.state_initialized) {
+		kobject_del(&qgroup->kobj);
+		kobject_put(&qgroup->kobj);
+	}
+}
 
 /*
  * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index 718a26c97833..1e27a9c94c84 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -36,4 +36,10 @@ int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
 void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info);
 void btrfs_sysfs_update_devid(struct btrfs_device *device);
 
+int btrfs_sysfs_add_one_qgroup(struct btrfs_fs_info *fs_info,
+				struct btrfs_qgroup *qgroup);
+void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info);
+int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info);
+void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
+				struct btrfs_qgroup *qgroup);
 #endif
-- 
2.27.0

