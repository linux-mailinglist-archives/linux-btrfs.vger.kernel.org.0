Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B69CC30
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 11:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfHZJGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 05:06:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41616 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfHZJGt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 05:06:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7Q93o0l069605
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=REKsCJI+crOO3/6UmhXlGz2Sk15VjRtYH9jEDYhVqjw=;
 b=fXA+dU10O3HbgjSjVEKaObelWhLWbVSH23/oYWO95027dICb+xW0Mddpub6AuOOj8p+L
 lIxn9bZmIG0UdrCWl0r27hZ9LU9YSV37uRctgvFjmFpN4bl6BujnxYqr5OkjxgX0Ku6J
 7qDgeEsAoJjJ2vq3Fl5J8pVyV7NxqIMX5mT7PMoFxEWqYGHql3JHZML4Y5x6n1RUGLCu
 xhWfgX3Li3LhHpmsu8jOp0zZeitUywevIiDNkoWzC+D5Um0xu3WtIwsCzWzj92S8w0lh
 pszt+BHo4Ar2VlPPrBA0xGSP+AvaP0yNToYt7Gp3WymXGil0LOel08lnKMK79xwUJHdq TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ujw717km0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:06:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7Q93l1j158948
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ujw6umbjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:47 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7Q94kKG023149
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:46 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 02:04:45 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2] btrfs-progs: add readmirror property and ioctl to set get readmirror
Date:   Mon, 26 Aug 2019 17:04:38 +0800
Message-Id: <20190826090438.7044-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190826090438.7044-1-anand.jain@oracle.com>
References: <20190826090438.7044-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=946
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

This patch adds readmirror property to be applied at the filesystem object.
And uses ioctl BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR to get
and set the property respectively.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1->RFC v2:
  . Changed format specifier from devid1,2,3.. to devid:1,2,3..

 ioctl.h | 14 +++++++++
 props.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

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

