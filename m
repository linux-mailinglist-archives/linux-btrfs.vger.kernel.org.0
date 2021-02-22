Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2737C322141
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 22:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhBVVUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 16:20:10 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:41453 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231345AbhBVVUG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 16:20:06 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-34.iol.local with ESMTPA
        id EIbml5cmb5WrZEIbvlGloQ; Mon, 22 Feb 2021 22:19:19 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1614028759; bh=HfRz5BWgfq24oZe35jPs+VhOkl3Ochn7e6dpTsb7sVk=;
        h=From;
        b=psyN4IUytW9ExblFulsgdZDvgEq7L7jLgrB5JfC4+j3EIZ5XOUGbkkJcyWqGf4lHo
         EltSReie4IcnJvBJDlEVfaD7le7q+GfvaPs0R/4EAy9dGCchsFf1LOlW/yBVft/mrz
         zjzuPqVpklDyrxMkPvw5zcJ5MCljfKIpUikXjn7l+AkoENQ8i9GEaSSyQTQwMktALq
         C+jkuH84NiVJg37eBVjTl4jpgOdtXw3QEPIvgJ8Jbg8/BPqZL7gsfqne6rEfdK+CVA
         QPVELVcL4/h7Rj5bKZAWxJGqTlBqykN9mw7s7uOCWwwxN02kr0ksiFyXz/sLurEN+c
         JXiSNzjRsg/DA==
X-CNFS-Analysis: v=2.4 cv=W4/96Tak c=1 sm=1 tr=0 ts=60341fd7 cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=tAp6EsRIHxeSHigjOvkA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/4] btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
Date:   Mon, 22 Feb 2021 22:19:06 +0100
Message-Id: <d48a0e28d4ba516602297437b1f132f2a8efd5d2.1614028083.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1614028083.git.kreijack@inwind.it>
References: <cover.1614028083.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJ24O8zby3qTr5SSwbmex8Py1BEMtoyG06qWLfzwn3BbMd6aAcgByx/s7zCHAyyJylJ+uVljxtAQQUCyeUYl/B2Dv56P+jry+Zfj/859fUd/l3LwcZIC
 LuoGh/7Noh75ZEkl/JPpQc8AUtglOMuE6s68Z5hmtnnQ/j6N2LHu0V2gZGxevYLzld4EKCc3YOuiS/DDs+PZ7mrgTDJAXAR41Fv0mRSOVHrMKxSX77G1V1tx
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This ioctl is a base for returning / setting information from / to  the
fields of the btrfs_dev_item object.

For now only the "type" field is returned / set.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/ioctl.c           | 68 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c         |  2 +-
 fs/btrfs/volumes.h         |  2 ++
 include/uapi/linux/btrfs.h | 39 ++++++++++++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a8c60d46d19c..07898ee3a08d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4851,6 +4851,72 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
 	return ret;
 }
 
+static long btrfs_ioctl_dev_properties(struct file *file,
+						void __user *argp)
+{
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_ioctl_dev_properties dev_props;
+	struct btrfs_device	*device;
+	struct btrfs_root *root = fs_info->chunk_root;
+	struct btrfs_trans_handle *trans;
+	int ret;
+	u64 prev_type;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&dev_props, argp, sizeof(dev_props)))
+		return -EFAULT;
+
+	device = btrfs_find_device(fs_info->fs_devices, dev_props.devid,
+				NULL, NULL);
+	if (!device) {
+		btrfs_info(fs_info, "change_dev_properties: unable to find device %llu",
+			   dev_props.devid);
+		return -ENODEV;
+	}
+
+	if (dev_props.properties & BTRFS_DEV_PROPERTY_READ) {
+		u64 props = dev_props.properties;
+
+		memset(&dev_props, 0, sizeof(dev_props));
+		if (props & BTRFS_DEV_PROPERTY_TYPE) {
+			dev_props.properties = BTRFS_DEV_PROPERTY_TYPE;
+			dev_props.type = device->type;
+		}
+		if (copy_to_user(argp, &dev_props, sizeof(dev_props)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* it is possible to set only BTRFS_DEV_PROPERTY_TYPE for now */
+	if (dev_props.properties & ~(BTRFS_DEV_PROPERTY_TYPE))
+		return -EPERM;
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	prev_type = device->type;
+	device->type = dev_props.type;
+	ret = btrfs_update_device(trans, device);
+
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		device->type = prev_type;
+		return  ret;
+	}
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret < 0)
+		device->type = prev_type;
+
+	return ret;
+
+}
+
 static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
 {
 	struct btrfs_ioctl_send_args *arg;
@@ -5034,6 +5100,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_subvol_rootref(file, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
+	case BTRFS_IOC_DEV_PROPERTIES:
+		return btrfs_ioctl_dev_properties(file, argp);
 	}
 
 	return -ENOTTY;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b8fab44394f5..0c649b444dcd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2809,7 +2809,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 }
 
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
+int btrfs_update_device(struct btrfs_trans_handle *trans,
 					struct btrfs_device *device)
 {
 	int ret;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index d4c3e0dd32b8..0c07b8deecab 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -600,5 +600,7 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+					struct btrfs_device *device);
 
 #endif
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 5df73001aad4..bab35d3f819c 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -860,6 +860,43 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 		__u8 align[7];
 };
 
+#define BTRFS_DEV_PROPERTY_TYPE		(1ULL << 0)
+#define BTRFS_DEV_PROPERTY_DEV_GROUP	(1ULL << 1)
+#define BTRFS_DEV_PROPERTY_SEEK_SPEED	(1ULL << 2)
+#define BTRFS_DEV_PROPERTY_BANDWIDTH	(1ULL << 3)
+#define BTRFS_DEV_PROPERTY_READ		(1ULL << 60)
+
+/*
+ * The ioctl BTRFS_IOC_DEV_PROPERTIES can read and write the device properties.
+ *
+ * The properties that the user want to write have to be set
+ * in the 'properties' field using the BTRFS_DEV_PROPERTY_xxxx constants.
+ *
+ * If the ioctl is used to read the device properties, the bit
+ * BTRFS_DEV_PROPERTY_READ has to be set in the 'properties' field.
+ * In this case the properties that the user want have to be set in the
+ * 'properties' field. The kernel doesn't return a property that was not
+ * required, however it may return a subset of the requested properties.
+ * The returned properties have the corrispondent BTRFS_DEV_PROPERTY_xxxx
+ * flag set in the 'properties' field.
+ *
+ * Up to 2020/05/11 the only properties that can be read/write is the 'type'
+ * one.
+ */
+struct btrfs_ioctl_dev_properties {
+	__u64	devid;
+	__u64	properties;
+	__u64	type;
+	__u32	dev_group;
+	__u8	seek_speed;
+	__u8	bandwidth;
+
+	/*
+	 * for future expansion, pad up to 1k
+	 */
+	__u8	reserved[1024-30];
+};
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
@@ -988,5 +1025,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_DEV_PROPERTIES _IOW(BTRFS_IOCTL_MAGIC, 64, \
+				struct btrfs_ioctl_dev_properties)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.30.0

