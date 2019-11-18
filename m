Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52A1000AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKRIr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48350 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfKRIr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i5Qn105350
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=oyXnyz77rILHIZkDhbeyaLarc3ZrBapV9QTxpPLnIOY=;
 b=d+XYN33ULobIhsGK1uAjNKl8KfH9RLTiPa9pmrhC6iaZc33Ms3RjDSH7hV2t0gt6al3F
 2Ilubxwi8DEQmGLKqdYyCj8JAIu+Hz0+ExaOFZaOxJ9PgIWBNkczm/c2fhTdY5tz7mXp
 ANtlfTKKcAdZrURNcnz0y+mS0kx7W7qZE0t+Q8vQOxvVK49YVFU4NkZkuhFKAUspqudy
 shJx6IV3aUNl6H3MjqfoGx5/8Vn6fjIln/ZI29fUQx7rnNt32xF6fSRf8gDWnzINZzyU
 nHbVFSwqaNyRFcEaqKo8CxyTdZAPFB/zaxL7+3GmHo1/htABdYXStmjdVOWpkQnzl9xO Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htens3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8hxaA021342
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wau8mtasw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAI8lP1q010851
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:25 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:24 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/15] btrfs: sysfs, migrate fs_decvices::fsid_kobject to struct btrfs_fs_info
Date:   Mon, 18 Nov 2019 16:46:52 +0800
Message-Id: <20191118084656.3089-12-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118084656.3089-1-anand.jain@oracle.com>
References: <20191118084656.3089-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In an idea that at some point we would have to create sysfs kobjects to
show the scanned devices, so we tried to maintain the fsid_kobject in
the struct btrfs_fs_devices instead of in the struct btrfs_fs_info.
Its been without it for a long time and if it has to be done at some point
it can be done using ioctl as well. For now cleanup sysfs and migrate the
top most kobject in the mounted context to btrfs_fs_info.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
PS: There are patches in the ML [1], which shows scanned devices
in the sysfs, if at all need there is a choice of doing the same using
ioctl as well. So that we dont' have to stress already overloaded sysfs.
  [1] [PATCH] btrfs: Introduce device pool sysfs attributes

 fs/btrfs/ctree.h   |  2 +
 fs/btrfs/disk-io.c |  8 ++--
 fs/btrfs/sysfs.c   | 94 ++++++++++++++++++++++------------------------
 fs/btrfs/sysfs.h   |  4 +-
 fs/btrfs/volumes.h |  3 +-
 5 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b2e8fd8a8e59..94446ed7a872 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -739,6 +739,8 @@ struct btrfs_fs_info {
 	struct task_struct *cleaner_kthread;
 	u32 thread_pool_size;
 
+	/* sysfs kobjects */
+	struct kobject fsid_kobj;
 	struct kobject *space_info_kobj;
 
 	u64 total_pinned;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ab888d89d844..85ec0a3d2019 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3082,10 +3082,10 @@ int __cold open_ctree(struct super_block *sb,
 
 	btrfs_free_extra_devids(fs_devices, 1);
 
-	ret = btrfs_sysfs_add_fsid(fs_devices);
+	ret = btrfs_sysfs_add_fsid(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init sysfs fsid interface: %d",
-				ret);
+			  ret);
 		goto fail_block_groups;
 	}
 
@@ -3308,7 +3308,7 @@ int __cold open_ctree(struct super_block *sb,
 	btrfs_sysfs_remove_mounted(fs_info);
 
 fail_fsdev_sysfs:
-	btrfs_sysfs_remove_fsid(fs_info->fs_devices);
+	btrfs_sysfs_remove_fsid(fs_info);
 
 fail_block_groups:
 	btrfs_put_block_group_cache(fs_info);
@@ -4006,7 +4006,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 			   percpu_counter_sum(&fs_info->dio_bytes));
 
 	btrfs_sysfs_remove_mounted(fs_info);
-	btrfs_sysfs_remove_fsid(fs_info->fs_devices);
+	btrfs_sysfs_remove_fsid(fs_info);
 
 	btrfs_free_fs_roots(fs_info);
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b42245104bc9..806676ef008a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -62,7 +62,6 @@ static struct btrfs_feature_attr btrfs_attr_features_##_name = {	     \
 	BTRFS_FEAT_ATTR(name, FEAT_INCOMPAT, BTRFS_FEATURE_INCOMPAT, feature)
 
 static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
-static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
 
 static struct btrfs_feature_attr *to_btrfs_feature_attr(struct kobj_attribute *a)
 {
@@ -655,10 +654,10 @@ static const struct attribute *btrfs_attrs[] = {
 
 static void btrfs_release_fsid_kobj(struct kobject *kobj)
 {
-	struct btrfs_fs_devices *fs_devs = to_fs_devs(kobj);
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	memset(&fs_devs->fsid_kobj, 0, sizeof(struct kobject));
-	complete(&fs_devs->kobj_unregister);
+	memset(&fs_info->fsid_kobj, 0, sizeof(struct kobject));
+	complete(&fs_info->fs_devices->kobj_unregister);
 }
 
 static struct kobj_type btrfs_ktype = {
@@ -666,18 +665,11 @@ static struct kobj_type btrfs_ktype = {
 	.release	= btrfs_release_fsid_kobj,
 };
 
-static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj)
-{
-	if (kobj->ktype != &btrfs_ktype)
-		return NULL;
-	return container_of(kobj, struct btrfs_fs_devices, fsid_kobj);
-}
-
 static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj)
 {
 	if (kobj->ktype != &btrfs_ktype)
 		return NULL;
-	return to_fs_devs(kobj)->fs_info;
+	return container_of(kobj, struct btrfs_fs_info, fsid_kobj);
 }
 
 #define NUM_FEATURE_BITS 64
@@ -719,12 +711,12 @@ static int addrm_unknown_feature_attrs(struct btrfs_fs_info *fs_info, bool add)
 			attrs[0] = &fa->kobj_attr.attr;
 			if (add) {
 				int ret;
-				ret = sysfs_merge_group(&fs_info->fs_devices->fsid_kobj,
+				ret = sysfs_merge_group(&fs_info->fsid_kobj,
 							&agroup);
 				if (ret)
 					return ret;
 			} else
-				sysfs_unmerge_group(&fs_info->fs_devices->fsid_kobj,
+				sysfs_unmerge_group(&fs_info->fsid_kobj,
 						    &agroup);
 		}
 
@@ -1001,8 +993,8 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 		kobject_put(fs_info->space_info_kobj);
 	}
 	addrm_unknown_feature_attrs(fs_info, false);
-	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
-	sysfs_remove_files(&fs_info->fs_devices->fsid_kobj, btrfs_attrs);
+	sysfs_remove_group(&fs_info->fsid_kobj, &btrfs_feature_attr_group);
+	sysfs_remove_files(&fs_info->fsid_kobj, btrfs_attrs);
 	btrfs_sysfs_remove_device_info(fs_info->fs_devices, NULL);
 }
 
@@ -1010,7 +1002,7 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 {
 	int error;
 	struct btrfs_fs_devices *fs_devs = fs_info->fs_devices;
-	struct kobject *fsid_kobj = &fs_devs->fsid_kobj;
+	struct kobject *fsid_kobj = &fs_info->fsid_kobj;
 
 	btrfs_set_fs_info_ptr(fs_info);
 
@@ -1067,41 +1059,47 @@ void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 	 * directory
 	 */
 	snprintf(fsid_buf, BTRFS_UUID_UNPARSED_SIZE, "%pU", fsid);
-	if (kobject_rename(&fs_devices->fsid_kobj, fsid_buf))
+	if (kobject_rename(&fs_devices->fs_info->fsid_kobj, fsid_buf))
 		btrfs_warn(fs_devices->fs_info,
-				"sysfs: failed to create fsid for sprout");
+			   "sysfs: failed to create fsid for sprout");
 }
 
 /* /sys/fs/btrfs/ entry */
 static struct kset *btrfs_kset;
 
-static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
+/*
+ * Remove /sys/fs/btrfs/UUID/devices and /sysfs/btrfs/UUID
+ */
+static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_info *fs_info)
 {
-	if (fs_devs->devices_dir_kobj) {
-		kobject_del(fs_devs->devices_dir_kobj);
-		kobject_put(fs_devs->devices_dir_kobj);
-		fs_devs->devices_dir_kobj = NULL;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+
+	if (fs_devices->devices_dir_kobj) {
+		kobject_del(fs_devices->devices_dir_kobj);
+		kobject_put(fs_devices->devices_dir_kobj);
+		fs_devices->devices_dir_kobj = NULL;
 	}
 
-	if (fs_devs->fsid_kobj.state_initialized) {
-		kobject_del(&fs_devs->fsid_kobj);
-		kobject_put(&fs_devs->fsid_kobj);
-		wait_for_completion(&fs_devs->kobj_unregister);
+	if (fs_info->fsid_kobj.state_initialized) {
+		kobject_del(&fs_info->fsid_kobj);
+		kobject_put(&fs_info->fsid_kobj);
+		wait_for_completion(&fs_devices->kobj_unregister);
 	}
 }
 
-/* when fs_devs is NULL it will remove all fsid kobject */
-void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
+/* when fs_info is NULL it will remove all fs_info::fsid kobject */
+void btrfs_sysfs_remove_fsid(struct btrfs_fs_info *fs_info)
 {
 	struct list_head *fs_uuids = btrfs_get_fs_uuids();
+	struct btrfs_fs_devices *fs_devices;
 
-	if (fs_devs) {
-		__btrfs_sysfs_remove_fsid(fs_devs);
+	if (fs_info) {
+		__btrfs_sysfs_remove_fsid(fs_info);
 		return;
 	}
 
-	list_for_each_entry(fs_devs, fs_uuids, fs_list) {
-		__btrfs_sysfs_remove_fsid(fs_devs);
+	list_for_each_entry(fs_devices, fs_uuids, fs_list) {
+		__btrfs_sysfs_remove_fsid(fs_devices->fs_info);
 	}
 }
 
@@ -1109,25 +1107,25 @@ void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs)
  * Creates:
  * 	/sys/fs/btrfs/UUID
  */
-int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
+int btrfs_sysfs_add_fsid(struct btrfs_fs_info *fs_info)
 {
 	int error;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
-	init_completion(&fs_devs->kobj_unregister);
-	fs_devs->fsid_kobj.kset = btrfs_kset;
-	error = kobject_init_and_add(&fs_devs->fsid_kobj, &btrfs_ktype, NULL,
-				     "%pU", fs_devs->fsid);
+	init_completion(&fs_devices->kobj_unregister);
+	fs_info->fsid_kobj.kset = btrfs_kset;
+	error = kobject_init_and_add(&fs_info->fsid_kobj, &btrfs_ktype, NULL,
+				     "%pU", fs_devices->fsid);
 	if (error) {
-		kobject_put(&fs_devs->fsid_kobj);
+		kobject_put(&fs_info->fsid_kobj);
 		return error;
 	}
 
-	fs_devs->devices_dir_kobj = kobject_create_and_add("devices",
-							&fs_devs->fsid_kobj);
-	if (!fs_devs->devices_dir_kobj) {
-		btrfs_err(fs_devs->fs_info,
-			  "failed to init sysfs device interface");
-		kobject_put(&fs_devs->fsid_kobj);
+	fs_devices->devices_dir_kobj = kobject_create_and_add("devices",
+							&fs_info->fsid_kobj);
+	if (!fs_devices->devices_dir_kobj) {
+		btrfs_err(fs_info, "failed to init sysfs device interface");
+		kobject_put(&fs_info->fsid_kobj);
 		return -ENOMEM;
 	}
 
@@ -1141,7 +1139,6 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
 void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 		u64 bit, enum btrfs_feature_set set)
 {
-	struct btrfs_fs_devices *fs_devs;
 	struct kobject *fsid_kobj;
 	u64 features;
 	int ret;
@@ -1152,8 +1149,7 @@ void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 	features = get_features(fs_info, set);
 	ASSERT(bit & supported_feature_masks[set]);
 
-	fs_devs = fs_info->fs_devices;
-	fsid_kobj = &fs_devs->fsid_kobj;
+	fsid_kobj = &fs_info->fsid_kobj;
 
 	if (!fsid_kobj->state_initialized)
 		return;
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index e7ae91f68e36..0648afbb40ca 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -18,8 +18,8 @@ int btrfs_sysfs_add_device_info(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device);
 int btrfs_sysfs_remove_device_info(struct btrfs_fs_devices *fs_devices,
                 struct btrfs_device *one_device);
-int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
-void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
+int btrfs_sysfs_add_fsid(struct btrfs_fs_info *fs_info);
+void btrfs_sysfs_remove_fsid(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 				    const u8 *fsid);
 void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 012e75f29fe0..3fd7f2b348b0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -254,9 +254,8 @@ struct btrfs_fs_devices {
 
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
-	struct kobject fsid_kobj;
-	struct kobject *devices_dir_kobj;
 	struct completion kobj_unregister;
+	struct kobject *devices_dir_kobj;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.23.0

