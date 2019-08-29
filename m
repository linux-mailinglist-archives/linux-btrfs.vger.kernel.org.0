Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE18A0FF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 05:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfH2Djf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 23:39:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59082 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfH2Dje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 23:39:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7T3dGqU148866
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 03:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=7HfYRkT1TvUH5natkp/Mq/ZLaUfLQ6aT6Sv+6wuTqHw=;
 b=HPpgeMAvvNQ9XDnQ7VYtZQGueshcr3gATLYXToEacYQX60uv0xBoPXcztalUnncSDFCJ
 OEPm4bW5JUWLE6gxJe8hgzBPM3oDOOP7bmPBFNFHx+MKvCrGJarNsBYWnrmTD31MlCqF
 Hbw8GV8HAEtNTW/BsZKuMtaWoivjsZDraAufJULKJ5+fQ+coDIe/zNx4vI3hCIItHDHp
 KKzWbwPoKNfdQq8IJf5NKGlAzj/AoY0yCfX4NrXeqmcL5gNAOC4t11vFGXlk6LNzNtmE
 3JVprXt+9iYAXLi7D8JvY7t7pHYDSuMp95pKxkFSn+2JTwhBFodWVWwN5RLwidp0QcM5 aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2up6ueg13a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 03:39:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7T3dF9N075346
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 03:39:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2undw8529t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 03:39:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7T3dVIi010136
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 03:39:31 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 20:39:30 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2.1] btrfs-progs: add readmirror property and ioctl to set get
Date:   Thu, 29 Aug 2019 11:39:26 +0800
Message-Id: <20190829033926.5334-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190826090438.7044-3-anand.jain@oracle.com>
References: <20190826090438.7044-3-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290038
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch adds readmirror property to be applied at the filesystem object.
And uses ioctl BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR to get
and set the property respectively.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC v2->RFC v2.1:
  add dump-tree support, depends on the patch
     [PATCH] btrfs-progs: print-tree add missing DEV_STATS
v1->RFC v2:
  Changed format specifier from devid1,2,3.. to devid:1,2,3..

 ctree.h                   | 14 ++++++
 ioctl.h                   | 14 ++++++
 libbtrfsutil/btrfs_tree.h | 11 +++++
 print-tree.c              | 15 ++++++
 props.c                   | 98 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+)

diff --git a/ctree.h b/ctree.h
index 0d12563b7261..f9523ea4cea6 100644
--- a/ctree.h
+++ b/ctree.h
@@ -92,6 +92,9 @@ struct btrfs_free_space_ctl;
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
+/* store readmirror policy inforamtion in the device tree */
+#define BTRFS_READMIRROR_OBJECTID -3ULL
+
 /* for storing balance parameters in the root tree */
 #define BTRFS_BALANCE_OBJECTID -4ULL
 
@@ -879,6 +882,14 @@ struct btrfs_balance_item {
 	__le64 unused[4];
 } __attribute__ ((__packed__));
 
+/*
+ * readmirror's persistent storage format
+ */
+struct btrfs_readmirror_item {
+       __le64 type;
+       __le64 unused[3];
+} __attribute__ ((__packed__));
+
 #define BTRFS_FILE_EXTENT_INLINE 0
 #define BTRFS_FILE_EXTENT_REG 1
 #define BTRFS_FILE_EXTENT_PREALLOC 2
@@ -2389,6 +2400,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_qgroup_limit_rsv_exclusive,
 /* btrfs_balance_item */
 BTRFS_SETGET_FUNCS(balance_item_flags, struct btrfs_balance_item, flags, 64);
 
+/* btrfs_readmirror_item */
+BTRFS_SETGET_FUNCS(readmirror_type, struct btrfs_readmirror_item, type, 64);
+
 static inline struct btrfs_disk_balance_args* btrfs_balance_item_data(
 		struct extent_buffer *eb, struct btrfs_balance_item *bi)
 {
diff --git a/ioctl.h b/ioctl.h
index 66ee599f7a82..ccdf600bae77 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -765,6 +765,16 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 };
 BUILD_ASSERT(sizeof(struct btrfs_ioctl_get_subvol_rootref_args) == 4096);
 
+enum btrfs_readmirror_policy {
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
 	notused,
@@ -929,6 +939,10 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
 				struct btrfs_ioctl_get_subvol_rootref_args)
 #define BTRFS_IOC_INO_LOOKUP_USER _IOWR(BTRFS_IOCTL_MAGIC, 62, \
 				struct btrfs_ioctl_ino_lookup_user_args)
+#define BTRFS_IOC_GET_READMIRROR _IOWR(BTRFS_IOCTL_MAGIC, 63, \
+				struct btrfs_ioctl_readmirror_args)
+#define BTRFS_IOC_SET_READMIRROR _IOWR(BTRFS_IOCTL_MAGIC, 64, \
+				struct btrfs_ioctl_readmirror_args)
 #ifdef __cplusplus
 }
 #endif
diff --git a/libbtrfsutil/btrfs_tree.h b/libbtrfsutil/btrfs_tree.h
index 8ea3e31d9b96..b6785fef4a8d 100644
--- a/libbtrfsutil/btrfs_tree.h
+++ b/libbtrfsutil/btrfs_tree.h
@@ -51,6 +51,9 @@
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
+/* store readmirror policy inforamtion in the device tree */
+#define BTRFS_READMIRROR_OBJECTID -3ULL
+
 /* for storing balance parameters in the root tree */
 #define BTRFS_BALANCE_OBJECTID -4ULL
 
@@ -962,4 +965,12 @@ struct btrfs_qgroup_limit_item {
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
diff --git a/print-tree.c b/print-tree.c
index 15d8806b6f28..4ed698ee3a62 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -692,6 +692,8 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 	case BTRFS_PERSISTENT_ITEM_KEY:
 		if (objectid == BTRFS_DEV_STATS_OBJECTID)
 			fprintf(stream, "DEV_STATS");
+		else if (objectid == BTRFS_READMIRROR_OBJECTID)
+			fprintf(stream, "READMIRROR");
 		else
 			fprintf(stream, "%llu", (unsigned long long)objectid);
 		return;
@@ -960,6 +962,16 @@ static void print_balance_item(struct extent_buffer *eb,
 	print_disk_balance_args(btrfs_balance_item_sys(eb, bi));
 }
 
+static void print_readmirror(struct extent_buffer *eb,
+			     struct btrfs_readmirror_item *rm, u32 size)
+{
+	if (btrfs_readmirror_type(eb, rm) == 1)
+		printf("\t\treadmirror.type devid\n");
+	else
+		printf("\t\treadmirror.type 0x%llx\n",
+			btrfs_readmirror_type(eb, rm));
+}
+
 static void print_dev_stats(struct extent_buffer *eb,
 		struct btrfs_dev_stats_item *stats, u32 size)
 {
@@ -1109,6 +1121,9 @@ static void print_persistent_item(struct extent_buffer *eb, void *ptr,
 	print_objectid(stdout, objectid, BTRFS_PERSISTENT_ITEM_KEY);
 	printf(" offset %llu\n", (unsigned long long)offset);
 	switch (objectid) {
+	case BTRFS_READMIRROR_OBJECTID:
+		print_readmirror(eb, ptr, item_size);
+		break;
 	case BTRFS_DEV_STATS_OBJECTID:
 		print_dev_stats(eb, ptr, item_size);
 		break;
diff --git a/props.c b/props.c
index 004022600d51..f077e55e2274 100644
--- a/props.c
+++ b/props.c
@@ -166,6 +166,98 @@ out:
 	return ret;
 }
 
+static int prop_readmirror(enum prop_object_type type, const char *object,
+			   const char *name, const char *value)
+{
+	int fd;
+	int ret;
+	DIR *dirstream = NULL;
+
+	fd = open_file_or_dir3(object, &dirstream, value ? O_RDWR : O_RDONLY);
+	if (fd < 0) {
+		ret = -errno;
+		error("failed to open %s: %m", object);
+		return ret;
+	}
+
+	if (value) {
+		int ret;
+		int final_ret;
+		size_t len = strlen(value);
+		char *value_dup;
+		char *devid_str;
+		struct btrfs_ioctl_readmirror_args readmirror;
+
+		if (len > 0 && (len <= 6 || strncmp("devid:", value, 6)))
+			return -EINVAL;
+
+		/* value format - an example: readmirror devid:1,2,3,.. */
+		value_dup = strndup(value + 6, len - 6);
+		if (!value_dup)
+			return -ENOMEM;
+
+		final_ret = 0;
+		if (len == 0) {
+			readmirror.type = BTRFS_READMIRROR_DEFAULT;
+			final_ret = ioctl(fd, BTRFS_IOC_SET_READMIRROR, &readmirror);
+			if (final_ret < 0)
+				error("failed to reset readmirror: (%m)");
+		} else {
+			__u64 device_bitmap = 0;
+
+			while ((devid_str = strsep(&value_dup, ",")) != NULL)
+				device_bitmap = device_bitmap |
+						(1ULL << arg_strtou64(devid_str));
+
+			readmirror.type = BTRFS_READMIRROR_DEVID;
+			readmirror.device_bitmap = device_bitmap;
+			ret = ioctl(fd, BTRFS_IOC_SET_READMIRROR, &readmirror);
+			if (ret < 0) {
+				error("failed to set readmirror: (%m)");
+				final_ret = ret;
+			}
+		}
+		return final_ret;
+	} else {
+		struct btrfs_ioctl_readmirror_args readmirror;
+		struct btrfs_ioctl_dev_info_args *device;
+		struct btrfs_ioctl_fs_info_args fs_devices;
+
+		ret = get_fs_info(object, &fs_devices, &device);
+		if (ret)
+			return ret;
+
+		free(device);
+		if (fs_devices.num_devices > 63) {
+			error("can't set readmirror for device id more than 63");
+			return -EOPNOTSUPP;
+		}
+
+		ret = ioctl(fd, BTRFS_IOC_GET_READMIRROR, &readmirror);
+		if (ret) {
+			error("readmirror ioctl failed: %m");
+			return ret;
+		}
+		if (readmirror.type == BTRFS_READMIRROR_DEFAULT) {
+			printf("readmirror default\n");
+		} else if (readmirror.type == BTRFS_READMIRROR_DEVID) {
+			u64 cnt;
+
+			printf("readmirror devid:");
+			for (cnt = 0; cnt < 64; cnt++) {
+				if ((1ULL << cnt) & readmirror.device_bitmap)
+					printf("%llu ", cnt);
+			}
+			printf("\n");
+		}
+		return 0;
+	}
+
+	close_file_or_dir(fd, dirstream);
+
+	return ret;
+}
+
 const struct prop_handler prop_handlers[] = {
 	{
 		.name ="ro",
@@ -187,5 +279,11 @@ const struct prop_handler prop_handlers[] = {
 		.read_only = 0,
 	 	.types = prop_object_inode, prop_compression
 	},
+	{
+		.name = "readmirror",
+		.desc = "specify the device to be used for read",
+		.read_only = 0,
+		.types = prop_object_root, prop_readmirror
+	},
 	{NULL, NULL, 0, 0, NULL}
 };
-- 
2.21.0 (Apple Git-120)

