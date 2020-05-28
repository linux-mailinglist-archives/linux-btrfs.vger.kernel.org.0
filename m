Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53ED1E696B
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 20:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405870AbgE1SfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 14:35:15 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:42506 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405867AbgE1SfC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 14:35:02 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id eNMjjt6vcLNQWeNMmjtDeB; Thu, 28 May 2020 20:34:57 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590690897; bh=XuTm1g1fT1p8wNALfZN4tosWASd0tlP7Bk5Sc+iz7QQ=;
        h=From;
        b=TumFOWT4bHC2o670mx395fUDDoQ/T9DegeEwaCzQELwFKxzAduMCzyN8XQp2s0XfG
         843koW+4GtONb+QrX/9L1CPMFcmX+Yy+vqKqmPE+8QxDW0Cm1Fsplz9JI9v2NuEZ8P
         NYkpgEgoaHU+O00strWHk91DN+qPbXA7WElOdgjh8mbtAetzIMYqu9GzjjPhd469Qx
         1yGsUwMqU1+jIvRNuZEs2A3lzO4HVnTKLNNhAgW+uDIZSYm4CxwpDT+GarHNIK9tMp
         Mxl0Nfpe2ZJ8BpMCZDgrJJb92tdXbwISx3HlWafAX7GRYxQwuy4J984qeya+hWM2Ap
         pFIAFLT5kOeCg==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=tAp6EsRIHxeSHigjOvkA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/4] Add an ioctl to set/retrive the device properties
Date:   Thu, 28 May 2020 20:34:48 +0200
Message-Id: <20200528183451.16654-2-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <20200528183451.16654-1-kreijack@libero.it>
References: <20200528183451.16654-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDrXuWwqW9ik1CG+woYMSGvNfWh9IhnmcXwPbE8nfDLRf4NfgySGejXwrgFP7yFQQnItySqGDeTWk+6WpDrHqrs7f5/5Q+dXlaH5VbLUDBl3F059ypjE
 X3Xtq4rMt2ZBHXvPUzalvLQ+8Jl9bHdA69EVN399/ZGPOlgSD1658C0hf9mc6TjEErDwSyLmVwkZFwJBEnzaEngys9yzvq7AKE3802VxIxk4UsesQytgqLkO
 zurn1hiwQZ7sRGSWpGD5ol8FlF4Cp82U+gB/NCojpIkXkxlNIxvdxaSrBTxE6+/JlicmdJZuXrSDO/rtxIvqMBDq+NMOIvkb/7gAbIZCiSzHT5fIpX+ODEkd
 vh0ml1XrsIwk0c5Ul7kzpUZ8CN1l4vFWVIeZPsasJCikVh5lg6hPzSa1ocg6K1a6CyJKBrjQi51gH3ZptvB0l3oc8orHCg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>

---
 fs/btrfs/ioctl.c           | 67 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c         |  2 +-
 fs/btrfs/volumes.h         |  2 ++
 include/uapi/linux/btrfs.h | 40 +++++++++++++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 40b729dce91c..cba3fa942e2f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4724,6 +4724,71 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
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
+				NULL, NULL, false);
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
@@ -4907,6 +4972,8 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_subvol_rootref(file, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
+	case BTRFS_IOC_DEV_PROPERTIES:
+		return btrfs_ioctl_dev_properties(file, argp);
 	}
 
 	return -ENOTTY;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index be1e047a489e..5265f54c2931 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2710,7 +2710,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 }
 
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
+int btrfs_update_device(struct btrfs_trans_handle *trans,
 					struct btrfs_device *device)
 {
 	int ret;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f067b5934c46..0ac5bf2b95e6 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -577,5 +577,7 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+                                        struct btrfs_device *device);
 
 #endif
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index e6b6cb0f8bc6..bb096075677d 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -842,6 +842,44 @@ struct btrfs_ioctl_get_subvol_rootref_args {
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
@@ -970,5 +1008,7 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_DEV_PROPERTIES _IOW(BTRFS_IOCTL_MAGIC, 64, \
+				struct btrfs_ioctl_dev_properties)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.27.0.rc2

