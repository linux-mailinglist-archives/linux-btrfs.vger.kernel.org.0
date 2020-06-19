Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3651FFFFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 04:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgFSB7z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 21:59:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:36966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730896AbgFSB7z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 21:59:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB175AC7F
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jun 2020 01:59:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: add sysfs interface for debug
Date:   Fri, 19 Jun 2020 09:59:46 +0800
Message-Id: <20200619015946.65638-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will add the following sysfs interface:
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rfer
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/excl
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_rfer
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_excl
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/lim_flags
 ^^^ Above are already in "btrfs qgroup show" command output ^^^

/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_data
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_pertrans
/sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_prealloc

The last 3 rsv related members are not visible to users, but can be very
useful to debug qgroup limit related bugs.

Also, to avoid '/' used in <qgroup_id>, the seperator between qgroup
level and qgroup id is changed to '_'.

The interface is not hidden behind 'debug' as I want this interface to
be included into production build so we could have an easier life to
debug qgroup rsv related bugs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h  |   1 +
 fs/btrfs/qgroup.c |  38 ++++++++----
 fs/btrfs/qgroup.h |  12 ++++
 fs/btrfs/sysfs.c  | 149 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/sysfs.h  |   6 ++
 5 files changed, 194 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d8301bf240e0..7576dfe39841 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -779,6 +779,7 @@ struct btrfs_fs_info {
 	u32 thread_pool_size;
 
 	struct kobject *space_info_kobj;
+	struct kobject *qgroup_kobj;
 
 	u64 total_pinned;
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 74eb98479109..04fdd42f0eb5 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -22,6 +22,7 @@
 #include "extent_io.h"
 #include "qgroup.h"
 #include "block-group.h"
+#include "sysfs.h"
 
 /* TODO XXX FIXME
  *  - subvol delete -> delete when ref goes to 0? delete limits also?
@@ -192,38 +193,47 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 	struct rb_node **p = &fs_info->qgroup_tree.rb_node;
 	struct rb_node *parent = NULL;
 	struct btrfs_qgroup *qgroup;
+	int ret;
 
 	while (*p) {
 		parent = *p;
 		qgroup = rb_entry(parent, struct btrfs_qgroup, node);
 
-		if (qgroup->qgroupid < qgroupid)
+		if (qgroup->qgroupid < qgroupid) {
 			p = &(*p)->rb_left;
-		else if (qgroup->qgroupid > qgroupid)
+		} else if (qgroup->qgroupid > qgroupid) {
 			p = &(*p)->rb_right;
-		else
+		} else {
 			return qgroup;
+		}
 	}
 
 	qgroup = kzalloc(sizeof(*qgroup), GFP_ATOMIC);
 	if (!qgroup)
 		return ERR_PTR(-ENOMEM);
-
 	qgroup->qgroupid = qgroupid;
 	INIT_LIST_HEAD(&qgroup->groups);
 	INIT_LIST_HEAD(&qgroup->members);
 	INIT_LIST_HEAD(&qgroup->dirty);
 
+	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
+	if (ret < 0) {
+		kfree(qgroup);
+		return ERR_PTR(ret);
+	}
+
 	rb_link_node(&qgroup->node, parent, p);
 	rb_insert_color(&qgroup->node, &fs_info->qgroup_tree);
 
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
@@ -252,7 +262,7 @@ static int del_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
 		return -ENOENT;
 
 	rb_erase(&qgroup->node, &fs_info->qgroup_tree);
-	__del_qgroup_rb(qgroup);
+	__del_qgroup_rb(fs_info, qgroup);
 	return 0;
 }
 
@@ -351,6 +361,9 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	ret = btrfs_sysfs_add_qgroups(fs_info);
+	if (ret < 0)
+		goto out;
 	/* default this to quota off, in case no status key is found */
 	fs_info->qgroup_flags = 0;
 
@@ -500,16 +513,12 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
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
@@ -562,7 +571,7 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 	while ((n = rb_first(&fs_info->qgroup_tree))) {
 		qgroup = rb_entry(n, struct btrfs_qgroup, node);
 		rb_erase(n, &fs_info->qgroup_tree);
-		__del_qgroup_rb(qgroup);
+		__del_qgroup_rb(fs_info, qgroup);
 	}
 	/*
 	 * We call btrfs_free_qgroup_config() when unmounting
@@ -571,6 +580,7 @@ void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 	 */
 	ulist_free(fs_info->qgroup_ulist);
 	fs_info->qgroup_ulist = NULL;
+	btrfs_sysfs_del_qgroups(fs_info);
 }
 
 static int add_qgroup_relation_item(struct btrfs_trans_handle *trans, u64 src,
@@ -943,6 +953,9 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	ret = btrfs_sysfs_add_qgroups(fs_info);
+	if (ret < 0)
+		goto out;
 	/*
 	 * 1 for quota root item
 	 * 1 for BTRFS_QGROUP_STATUS item
@@ -1089,6 +1102,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 		fs_info->qgroup_ulist = NULL;
 		if (trans)
 			btrfs_end_transaction(trans);
+		btrfs_sysfs_del_qgroups(fs_info);
 	}
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	return ret;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 3be5198a3719..728ffea7de48 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -8,6 +8,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/kobject.h>
 #include "ulist.h"
 #include "delayed-ref.h"
 
@@ -223,8 +224,19 @@ struct btrfs_qgroup {
 	 */
 	u64 old_refcnt;
 	u64 new_refcnt;
+
+	/*
+	 * Sysfs kobjectid
+	 */
+	struct kobject kobj;
+	struct completion kobj_unregister;
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
index a39bff64ff24..8468c0a22695 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -19,6 +19,7 @@
 #include "volumes.h"
 #include "space-info.h"
 #include "block-group.h"
+#include "qgroup.h"
 
 struct btrfs_feature_attr {
 	struct kobj_attribute kobj_attr;
@@ -1455,6 +1456,154 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	return error;
 }
 
+#define QGROUP_ATTR(_member)						\
+static ssize_t btrfs_qgroup_show_##_member(struct kobject *qgroup_kobj,	\
+				      struct kobj_attribute *a, char *buf) \
+{									\
+	struct kobject *fsid_kobj = qgroup_kobj->parent->parent;	\
+	struct btrfs_fs_info *fs_info = to_fs_info(fsid_kobj);		\
+	struct btrfs_qgroup *qgroup = container_of(qgroup_kobj,		\
+			struct btrfs_qgroup, kobj);			\
+	u64 val;							\
+									\
+	spin_lock(&fs_info->qgroup_lock);				\
+	val = qgroup->_member;						\
+	spin_unlock(&fs_info->qgroup_lock);				\
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);		\
+}									\
+BTRFS_ATTR(qgroup, _member, btrfs_qgroup_show_##_member)
+
+#define QGROUP_RSV_ATTR(_name, _type)					\
+static ssize_t btrfs_qgroup_rsv_show_##_name(struct kobject *qgroup_kobj,\
+				      struct kobj_attribute *a, char *buf) \
+{									\
+	struct kobject *fsid_kobj = qgroup_kobj->parent->parent;	\
+	struct btrfs_fs_info *fs_info = to_fs_info(fsid_kobj);		\
+	struct btrfs_qgroup *qgroup = container_of(qgroup_kobj,		\
+			struct btrfs_qgroup, kobj);			\
+	u64 val;							\
+									\
+	spin_lock(&fs_info->qgroup_lock);				\
+	val = qgroup->rsv.values[_type];					\
+	spin_unlock(&fs_info->qgroup_lock);				\
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);		\
+}									\
+BTRFS_ATTR(qgroup, rsv_##_name, btrfs_qgroup_rsv_show_##_name)
+
+QGROUP_ATTR(rfer);
+QGROUP_ATTR(excl);
+QGROUP_ATTR(max_rfer);
+QGROUP_ATTR(max_excl);
+QGROUP_ATTR(lim_flags);
+QGROUP_RSV_ATTR(data, BTRFS_QGROUP_RSV_DATA);
+QGROUP_RSV_ATTR(meta_pertrans, BTRFS_QGROUP_RSV_META_PERTRANS);
+QGROUP_RSV_ATTR(meta_prealloc, BTRFS_QGROUP_RSV_META_PREALLOC);
+
+static struct attribute *qgroup_attrs[] = {
+	BTRFS_ATTR_PTR(qgroup, rfer),
+	BTRFS_ATTR_PTR(qgroup, excl),
+	BTRFS_ATTR_PTR(qgroup, max_rfer),
+	BTRFS_ATTR_PTR(qgroup, max_excl),
+	BTRFS_ATTR_PTR(qgroup, lim_flags),
+	BTRFS_ATTR_PTR(qgroup, rsv_data),
+	BTRFS_ATTR_PTR(qgroup, rsv_meta_pertrans),
+	BTRFS_ATTR_PTR(qgroup, rsv_meta_prealloc),
+	NULL
+};
+ATTRIBUTE_GROUPS(qgroup);
+static void qgroup_release(struct kobject *kobj)
+{
+	struct btrfs_qgroup *qgroup = container_of(kobj, struct btrfs_qgroup,
+			kobj);
+	memset(&qgroup->kobj, 0, sizeof(*kobj));
+	complete(&qgroup->kobj_unregister);
+}
+
+static struct kobj_type qgroup_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = qgroup_release,
+	.default_groups = qgroup_groups,
+};
+
+/*
+ * Needed string buffer size for qgroup, including tailing \0
+ *
+ * This includes U48_MAX + 1 + U16_MAX + 1.
+ * U48_MAX in dec can be 15 digits at, and U16_MAX can be 6 digits.
+ * Rounded up to 32 to provide some buffer.
+ */
+#define QGROUP_STR_LEN	32
+int btrfs_sysfs_add_one_qgroup(struct btrfs_fs_info *fs_info,
+				struct btrfs_qgroup *qgroup)
+{
+	struct kobject *qgroups_kobj = fs_info->qgroup_kobj;
+	int ret;
+
+	init_completion(&qgroup->kobj_unregister);
+	ret = kobject_init_and_add(&qgroup->kobj, &qgroup_ktype, qgroups_kobj,
+			"%u_%llu", (u16)btrfs_qgroup_level(qgroup->qgroupid),
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
+	rbtree_postorder_for_each_entry_safe(qgroup, next,
+			&fs_info->qgroup_tree, node) {
+		if (qgroup->kobj.state_initialized) {
+			kobject_del(&qgroup->kobj);
+			kobject_put(&qgroup->kobj);
+			wait_for_completion(&qgroup->kobj_unregister);
+		}
+	}
+	kobject_del(fs_info->qgroup_kobj);
+	kobject_put(fs_info->qgroup_kobj);
+	fs_info->qgroup_kobj = NULL;
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
+	ASSERT(fsid_kobj);
+	if (fs_info->qgroup_kobj)
+		return 0;
+
+	fs_info->qgroup_kobj = kobject_create_and_add("qgroups", fsid_kobj);
+	if (!fs_info->qgroup_kobj) {
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
+	kobject_del(&qgroup->kobj);
+	kobject_put(&qgroup->kobj);
+	wait_for_completion(&qgroup->kobj_unregister);
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

