Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8030B21C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 22:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhBAV33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 16:29:29 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:47606 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229680AbhBAV3G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 16:29:06 -0500
Received: from venice.bhome ([84.220.24.72])
        by smtp-36.iol.local with ESMTPA
        id 6gkAlJHqMi3tS6gkBlGswl; Mon, 01 Feb 2021 22:28:23 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1612214903; bh=dHpDrAyHYkS2kZf5+eTtb2K4W+ZIMRhrVfPzuguh8vo=;
        h=From;
        b=DnR5/u/CTSCAuxRlcngBSFEVBKzB6P32Nbs1ji2iZoskWOJDzzpAeQpXKRnr5vRQ0
         eUc/LYM2VXiShd/5PQAC8gkKQJ1kS0Hhqgd5SxvTqL8E3QH/dgiqyw8IfSgjBOAvzy
         xdZ8itKsM0vsBduZI7UnmnhiNgAjyQaV2i9vOrhercdw7GLlpda2vvJ7TYaAKtQrY6
         KjJpuL0W2U4kudxuWdgX70J/DiKbsJb7v2WVzqgBpYprqXGO1JR3MmGj4kKbILWvgo
         BvQPNsk9PllMOpFcZf7Lp2a3HgdQxJsIHMZXtK8Gh6et82xornGWw2ICaj7QC5A2kq
         WKRij2aE+hI+A==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=60187277 cx=a_exe
 a=tAq5w2qrEf5dL+VNPEPBHQ==:117 a=tAq5w2qrEf5dL+VNPEPBHQ==:17
 a=tAp6EsRIHxeSHigjOvkA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/5] btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
Date:   Mon,  1 Feb 2021 22:28:16 +0100
Message-Id: <20210201212820.64381-2-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201212820.64381-1-kreijack@libero.it>
References: <20210201212820.64381-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFYKrWBstadXte6rQg6x4TKquP1wXXhoyYYM2AI7cSRXuTIpKOEM6dMF0M35KslNX9CHRb27wdGuhAxg+LNzrGNazimiOamvgWENsGVQQxRnL7gBwVNZ
 mPd9T6PL6syZ26czSUmE+T0PdkmjK5PJtc1TQYNESgEmNTrtOfJ5wYOC2gSYK9chIu500oHYpQp58mLev5aFUl6udwR85k/UJtYCYVQPKp036VUnibjNYwiM
 ZV+3dgkoAa5mYtxIakOAOHFMX/SQivx+qxj05ZFbefe9Q6hSeOJXG2uFImzCZTzT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This ioctl is a base for returning / setting information from / to  the
fields of the btrfs_dev_item object.

For now only the "type" field is returned / set.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/ioctl.c           | 67 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c         |  2 +-
 fs/btrfs/volumes.h         |  2 ++
 include/uapi/linux/btrfs.h | 40 +++++++++++++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 703212ff50a5..9e67741fa966 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4842,6 +4842,71 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
 	return ret;
 }
 
+static long btrfs_ioctl_dev_properties(struct file *file,
+						void __user *argp)
+{
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_ioctl_dev_properties dev_props;
+	struct btrfs_device	*device;
+        struct btrfs_root *root = fs_info->chunk_root;
+        struct btrfs_trans_handle *trans;
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
+		memset(&dev_props, 0, sizeof(dev_props));
+		if (props & BTRFS_DEV_PROPERTY_TYPE) {
+			dev_props.properties = BTRFS_DEV_PROPERTY_TYPE;
+			dev_props.type = device->type;
+		}
+		if(copy_to_user(argp, &dev_props, sizeof(dev_props)))
+			return -EFAULT;
+		return 0;
+	}
+
+	/* it is possible to set only BTRFS_DEV_PROPERTY_TYPE for now */
+	if (dev_props.properties & ~(BTRFS_DEV_PROPERTY_TYPE))
+		return -EPERM;
+
+	trans = btrfs_start_transaction(root, 0);
+        if (IS_ERR(trans))
+                return PTR_ERR(trans);
+
+	prev_type = device->type;
+	device->type = dev_props.type;
+	ret = btrfs_update_device(trans, device);
+
+        if (ret < 0) {
+                btrfs_abort_transaction(trans, ret);
+                btrfs_end_transaction(trans);
+		device->type = prev_type;
+		return  ret;
+        }
+
+        ret = btrfs_commit_transaction(trans);
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
@@ -5025,6 +5090,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_subvol_rootref(file, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
+	case BTRFS_IOC_DEV_PROPERTIES:
+		return btrfs_ioctl_dev_properties(file, argp);
 	}
 
 	return -ENOTTY;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ee086fc56c30..68b346c5465d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2744,7 +2744,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 }
 
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
+int btrfs_update_device(struct btrfs_trans_handle *trans,
 					struct btrfs_device *device)
 {
 	int ret;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 1997a4649a66..d776b7f55d56 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -595,5 +595,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+                                        struct btrfs_device *device);
 
 #endif
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 5df73001aad4..e6caef42837a 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -860,6 +860,44 @@ struct btrfs_ioctl_get_subvol_rootref_args {
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
+	 * for future expansion
+	 */
+	__u8	unused1[2];
+	__u64	unused2[4];
+};
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
@@ -988,5 +1026,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_DEV_PROPERTIES _IOW(BTRFS_IOCTL_MAGIC, 64, \
+				struct btrfs_ioctl_dev_properties)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.30.0

