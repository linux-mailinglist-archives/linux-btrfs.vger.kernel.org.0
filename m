Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A169CC1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 11:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfHZJEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 05:04:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfHZJEt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 05:04:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7Q93uxG102143
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=2LZHMnv2t3+KhWeTj59mgyjvDdnDVKHPgLwe+she7uk=;
 b=RyKLn4tP4A9uLh7gXjdfRuAeHytiXNLsE2b5lT82YFctsCD6ry5RGLl1BlMjs8QgTKEC
 aFC8sJEiFExypEFG5zEB+ZkjPruP5jT4ucvYamApMTwNm2ImwiaU++wbCZa2NiMbvT6z
 E2I5j09T6VxDp5avUDzzVfNJIc8+gMABnC8lIO2AKluYUx8x+DL3WqUzqnsIV/ntiTlu
 siqUS3HiKOOTFMYMCDn+58WC/COgyvwst65pmgjftr623fKeS/gG3VsdH/hxdz+WUy3C
 XrHLat5BBjjos1DdqGUOM4a/UimGX1JmtkpPt8UW5vQ3wc8M3y6CLvRaeuhUjB60plk1 hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ujw6yymp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7Q93rdB103067
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ujw6hj373-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:45 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7Q94ips002223
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:44 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 02:04:44 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2] btrfs: add readmirror framework and policy devid
Date:   Mon, 26 Aug 2019 17:04:37 +0800
Message-Id: <20190826090438.7044-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190826090438.7044-1-anand.jain@oracle.com>
References: <20190826090438.7044-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908260101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908260102
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduces devid readmirror property, to direct read IO to the specified
device(s).

The readmirror property is stored as an item in the dev-tree. The readmirror
input format is devid:1,2,3.. etc. And for the each devid provided, a new
flag BTRFS_DEV_STATE_READ_PREFERRED is set.

As of now readmirror by devid supports only raid1s. Raid10 support has
to leverage device grouping feature, which is yet to be implemented.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1->RFC v2:
  . Property is stored as a dev-tree item instead of root inode extended
    attribute.
  . Rename BTRFS_DEV_STATE_READ_OPRIMIZED to BTRFS_DEV_STATE_READ_PREFERRED.

 fs/btrfs/ctree.h                |   3 +
 fs/btrfs/disk-io.c              |   9 ++
 fs/btrfs/ioctl.c                | 108 +++++++++++++++++++++++
 fs/btrfs/transaction.c          |   3 +
 fs/btrfs/volumes.c              | 149 +++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h              |   9 +-
 include/uapi/linux/btrfs.h      |  15 +++-
 include/uapi/linux/btrfs_tree.h |  11 +++
 8 files changed, 304 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 357316173d84..a41b081846e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2394,6 +2394,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_left,
 BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_right,
 			 struct btrfs_dev_replace_item, cursor_right, 64);
 
+/* btrfs_readmirror_item */
+BTRFS_SETGET_FUNCS(readmirror_type, struct btrfs_readmirror_item, type, 64);
+
 /* helper function to cast into the data area of the leaf. */
 #define btrfs_item_ptr(leaf, slot, type) \
 	((type *)(BTRFS_LEAF_DATA_OFFSET + \
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d59b79ee4f9b..80e13b088634 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3086,6 +3086,15 @@ int open_ctree(struct super_block *sb,
 			  ret);
 		goto fail_block_groups;
 	}
+
+	ret = btrfs_init_readmirror(fs_info);
+	if (ret)
+		/*
+		 * failed to init means we will use default readmirror policy, so
+		 * warning is fine
+		 */
+		btrfs_warn(fs_info, "failed to init readmirror policy: %d", ret);
+
 	ret = btrfs_recover_balance(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to recover balance: %d", ret);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5ad41d4e113c..07aa47f70b55 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5421,6 +5421,110 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
 	return ret;
 }
 
+static int btrfs_ioctl_get_readmirror(struct btrfs_root *root,
+				      void __user *argp)
+{
+	struct btrfs_fs_devices *fs_devices = root->fs_info->fs_devices;
+	struct btrfs_ioctl_readmirror_args readmirror;
+	u64 device_bitmap = 0;
+
+	if (copy_from_user(&readmirror, argp, sizeof(readmirror)))
+		return -EFAULT;
+
+	readmirror.type = BTRFS_READMIRROR_DEFAULT;
+	readmirror.device_bitmap = 0;
+
+	if (fs_devices->readmirror_type == BTRFS_READMIRROR_DEVID) {
+		struct btrfs_device *device;
+
+		/*
+		 * No need to hold device_list_mutext for a read especially from
+		 * the user, user can read again to see the transient change.
+		 */
+		list_for_each_entry(device, &fs_devices->devices, dev_list) {
+			if (device && test_bit(BTRFS_DEV_STATE_READ_PREFERRED,
+					       &device->dev_state))
+				device_bitmap = device_bitmap |
+						(1ULL << device->devid);
+		}
+		readmirror.type = fs_devices->readmirror_type;
+		readmirror.device_bitmap = device_bitmap;
+	}
+
+	if (copy_to_user(argp, &readmirror, sizeof(readmirror)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int btrfs_ioctl_set_readmirror(struct btrfs_root *root, void __user *argp)
+{
+	int ret;
+	u64 devid;
+	struct btrfs_ioctl_readmirror_args readmirror;
+	struct btrfs_device *device;
+	struct btrfs_fs_devices *fs_devices = root->fs_info->fs_devices;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&readmirror, argp, sizeof(readmirror)))
+		return -EFAULT;
+
+	if (readmirror.type != BTRFS_READMIRROR_DEFAULT &&
+	    readmirror.type != BTRFS_READMIRROR_DEVID)
+		return -EINVAL;
+
+	ret = 0;
+	mutex_lock(&fs_devices->device_list_mutex);
+	if (readmirror.type == BTRFS_READMIRROR_DEVID) {
+		int nr_devices = 0;
+
+		for (devid = 0; devid < 64; devid++) {
+			if (!((1ULL << devid) & readmirror.device_bitmap))
+				continue;
+
+			device = btrfs_find_device(fs_devices, devid, NULL, NULL,
+						   false);
+			if (!device) {
+				ret = -EINVAL;
+				goto unlock_out;
+			}
+			nr_devices++;
+		}
+		if (nr_devices == 0) {
+			ret = -EINVAL;
+			goto unlock_out;
+		}
+	}
+
+	/* First reset and then set */
+	fs_devices->readmirror_type = BTRFS_READMIRROR_DEFAULT;
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		clear_bit(BTRFS_DEV_STATE_READ_PREFERRED,
+			  &device->dev_state);
+	}
+
+	if (readmirror.type == BTRFS_READMIRROR_DEVID) {
+		for (devid = 0; devid < 64; devid++) {
+			if (!((1ULL << devid) & readmirror.device_bitmap))
+				continue;
+
+			device = btrfs_find_device(fs_devices, devid, NULL, NULL,
+						   false);
+			if (device)
+				set_bit(BTRFS_DEV_STATE_READ_PREFERRED,
+					&device->dev_state);
+		}
+		fs_devices->readmirror_type = BTRFS_READMIRROR_DEVID;
+	}
+	atomic_inc(&device->update_readmirror);
+
+unlock_out:
+	mutex_unlock(&fs_devices->device_list_mutex);
+	return ret;
+}
+
 long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
@@ -5567,6 +5671,10 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_subvol_rootref(file, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
+	case BTRFS_IOC_GET_READMIRROR:
+		return btrfs_ioctl_get_readmirror(root, argp);
+	case BTRFS_IOC_SET_READMIRROR:
+		return btrfs_ioctl_set_readmirror(root, argp);
 	}
 
 	return -ENOTTY;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 2e3f6778bfa3..212cd0aec2cf 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1127,6 +1127,9 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 		return ret;
 
 	ret = btrfs_run_dev_stats(trans);
+	if (ret)
+		return ret;
+	ret = btrfs_run_readmirror(trans);
 	if (ret)
 		return ret;
 	ret = btrfs_run_dev_replace(trans);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e3460b47283e..94215f5ae0f9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -402,6 +402,7 @@ static struct btrfs_device *__alloc_device(void)
 
 	atomic_set(&dev->reada_in_flight, 0);
 	atomic_set(&dev->dev_stats_ccnt, 0);
+	atomic_set(&dev->update_readmirror, 0);
 	btrfs_device_data_ordered_init(dev);
 	INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
 	INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
@@ -5267,7 +5268,28 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	else
 		num_stripes = map->num_stripes;
 
-	preferred_mirror = first + current->pid % num_stripes;
+	switch(fs_info->fs_devices->readmirror_type) {
+	case BTRFS_READMIRROR_DEVID:
+		/*
+		 * choice of read a specific mirror is only for RAID1 as of now
+		 */
+		if (map->type & BTRFS_BLOCK_GROUP_RAID1) {
+			for (i = first; i < first + num_stripes; i++) {
+				if (test_bit(BTRFS_DEV_STATE_READ_PREFERRED,
+					     &map->stripes[i].dev->dev_state)) {
+					preferred_mirror = i;
+					break;
+				}
+			}
+		}
+		/* fall through */
+	case BTRFS_READMIRROR_DEFAULT:
+		/* fall through */
+	default:
+		/* readmirror as per thread pid */
+		preferred_mirror = first + current->pid % num_stripes;
+		break;
+	}
 
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
@@ -7604,3 +7626,128 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
 	spin_unlock(&fs_info->swapfile_pins_lock);
 	return node != NULL;
 }
+
+int btrfs_init_readmirror(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+	int slot;
+	struct btrfs_key key;
+	struct extent_buffer *eb;
+	struct btrfs_device *device;
+	struct btrfs_path *path = NULL;
+	struct btrfs_readmirror_item *ptr;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+
+		key.objectid = BTRFS_READMIRROR_OBJECTID;
+		key.type = BTRFS_PERSISTENT_ITEM_KEY;
+		key.offset = device->devid;
+
+		ret = btrfs_search_slot(NULL, fs_info->dev_root, &key, path, 0, 0);
+		if (ret) {
+			btrfs_release_path(path);
+			continue;
+		}
+		slot = path->slots[0];
+		eb = path->nodes[0];
+
+		ptr = btrfs_item_ptr(eb, slot, struct btrfs_readmirror_item);
+
+		if (btrfs_readmirror_type(eb, ptr) == BTRFS_READMIRROR_DEVID) {
+			device->fs_devices->readmirror_type = BTRFS_READMIRROR_DEVID;
+			set_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
+		} else {
+			clear_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
+		}
+
+		btrfs_release_path(path);
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	btrfs_free_path(path);
+	return ret < 0 ? ret : 0;
+}
+
+static int update_readmirror_item(struct btrfs_trans_handle *trans,
+				  struct btrfs_device *device)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *dev_root = fs_info->dev_root;
+	struct btrfs_readmirror_item *ptr;
+	struct extent_buffer *eb;
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	u64 type;
+	int ret;
+
+	key.objectid = BTRFS_READMIRROR_OBJECTID;
+	key.type = BTRFS_PERSISTENT_ITEM_KEY;
+	key.offset = device->devid;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(trans, dev_root, &key, path, 0, 1);
+	if (ret < 0) {
+		btrfs_warn_in_rcu(fs_info,
+			"error %d while searching for readmirror item for device %s",
+				  ret, rcu_str_deref(device->name));
+		goto out;
+	}
+
+	if (ret == 1) {
+		btrfs_release_path(path);
+		ret = btrfs_insert_empty_item(trans, dev_root, path,
+					      &key, sizeof(*ptr));
+		if (ret < 0) {
+			btrfs_warn_in_rcu(fs_info,
+				"insert readmirror item for device %s failed %d",
+				rcu_str_deref(device->name), ret);
+			goto out;
+		}
+	}
+
+	eb = path->nodes[0];
+	ptr = btrfs_item_ptr(eb, path->slots[0], struct btrfs_readmirror_item);
+	if (test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state))
+		type = BTRFS_READMIRROR_DEVID;
+	else
+		type = BTRFS_READMIRROR_DEFAULT;
+
+	btrfs_set_readmirror_type(eb, ptr, type);
+	btrfs_mark_buffer_dirty(eb);
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+int btrfs_run_readmirror(struct btrfs_trans_handle *trans)
+{
+	int update;
+	int ret = 0;
+	struct btrfs_device *device;
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		update = atomic_read(&device->update_readmirror);
+		if (update == 0)
+			continue;
+
+		ret = update_readmirror_item(trans, device);
+		if (!ret)
+			atomic_sub(update, &device->update_readmirror);
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+
+	return ret;
+}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7be62728812d..aff48f130e1a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -52,6 +52,7 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_MISSING		(2)
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
+#define BTRFS_DEV_STATE_READ_PREFERRED	(5)
 
 struct btrfs_device {
 	struct list_head dev_list; /* device_list_mutex */
@@ -141,6 +142,8 @@ struct btrfs_device {
 	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
 
 	struct extent_io_tree alloc_state;
+
+	atomic_t update_readmirror;
 };
 
 /*
@@ -260,6 +263,8 @@ struct btrfs_fs_devices {
 	struct kobject fsid_kobj;
 	struct kobject *device_dir_kobj;
 	struct completion kobj_unregister;
+
+	int readmirror_type;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
@@ -474,6 +479,7 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 void btrfs_init_devices_late(struct btrfs_fs_info *fs_info);
 int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info);
 int btrfs_run_dev_stats(struct btrfs_trans_handle *trans);
+int btrfs_run_readmirror(struct btrfs_trans_handle *trans);
 void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev);
 void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev);
 void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev);
@@ -578,5 +584,6 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
-
+int btrfs_run_readmirror(struct btrfs_trans_handle *trans);
+int btrfs_init_readmirror(struct btrfs_fs_info *fs_info);
 #endif
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 3ee0678c0a83..7d6d0ebb612c 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -822,6 +822,16 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 		__u8 align[7];
 };
 
+enum btrfs_readmirror_types {
+	BTRFS_READMIRROR_DEFAULT = 0,
+	BTRFS_READMIRROR_DEVID,
+};
+
+struct btrfs_ioctl_readmirror_args {
+	__u64 type; /* RW */
+	__u64 device_bitmap; /* RW */
+};
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
@@ -946,5 +956,8 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
-
+#define BTRFS_IOC_GET_READMIRROR _IOWR(BTRFS_IOCTL_MAGIC, 63, \
+				struct btrfs_ioctl_readmirror_args)
+#define BTRFS_IOC_SET_READMIRROR _IOWR(BTRFS_IOCTL_MAGIC, 64, \
+				struct btrfs_ioctl_readmirror_args)
 #endif /* _UAPI_LINUX_BTRFS_H */
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 97846fb57028..64cf120ac0f4 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -51,6 +51,9 @@
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
+/* store readmirror policy inforamtion in the device tree */
+#define BTRFS_READMIRROR_OBJECTID -3ULL
+
 /* for storing balance parameters in the root tree */
 #define BTRFS_BALANCE_OBJECTID -4ULL
 
@@ -977,4 +980,12 @@ struct btrfs_qgroup_limit_item {
 	__le64 rsv_excl;
 } __attribute__ ((__packed__));
 
+/*
+ * readmirror's persistent storage format
+ */
+struct btrfs_readmirror_item {
+	__le64 type;
+	__le64 unused[3];
+} __attribute__ ((__packed__));
+
 #endif /* _BTRFS_CTREE_H_ */
-- 
2.21.0 (Apple Git-120)

