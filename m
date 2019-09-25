Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15796BD988
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 10:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442699AbfIYIHY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 04:07:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36948 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404849AbfIYIHX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 04:07:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8P84OUW139170
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 08:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=nt/GsGPAb5eLmhsLfXDPAm10jPI57syu4VNKuEHPoSo=;
 b=HbYI+9IWohvDiQT4QHNtUsuOTmyJyR/KbmjaNxJ8sj4ui/dE0zxDvL9jx/1J+IYqBnix
 X1072tDuEyyhOrWjajb0GYsRyi8nWPrCD81wWCSOHty0oua+EKRMnciSfNfsKnHwHGZP
 aBucBK4i8MLjx8rR2XQDXIWAWOeV/JmUh4JoB1r46Pi4HrK9IzUYxKfhqunzU4hvCff5
 gVTqy7f182WgKldJgfmVHQ4XVRDj+jGlF6QO12QsGOQOkGyVw8go0F49w9uw7Dvhp3k7
 jdPTL+d+e2BVHxZwddGraxbkwOqBkTOJlRguX6A8EHh0iE9MwEvoFeX8jx9e0RLmWBCf bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v5b9ttxsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 08:07:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8P7wsG8064848
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 08:07:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2v82tjd9f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 08:07:21 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8P87K0K030259
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 08:07:20 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Sep 2019 01:07:20 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 RESEND] btrfs-progs: add verbose option to btrfs device scan
Date:   Wed, 25 Sep 2019 16:07:12 +0800
Message-Id: <1569398832-16277-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909250082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909250083
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To help debug device scan issues, add verbose option to btrfs device scan.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use bool instead of int as a btrfs_scan_device() argument.

 cmds/device.c        | 8 ++++++--
 cmds/filesystem.c    | 2 +-
 common/device-scan.c | 4 +++-
 common/device-scan.h | 3 ++-
 common/utils.c       | 2 +-
 disk-io.c            | 2 +-
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index 24158308a41b..9b715ffc42a3 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -313,6 +313,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 	int all = 0;
 	int ret = 0;
 	int forget = 0;
+	bool verbose = false;
 
 	optind = 0;
 	while (1) {
@@ -323,7 +324,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 			{ NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "du", long_options, NULL);
+		c = getopt_long(argc, argv, "duv", long_options, NULL);
 		if (c < 0)
 			break;
 		switch (c) {
@@ -333,6 +334,9 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 		case 'u':
 			forget = 1;
 			break;
+		case 'v':
+			verbose = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -354,7 +358,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 			}
 		} else {
 			printf("Scanning for Btrfs filesystems\n");
-			ret = btrfs_scan_devices();
+			ret = btrfs_scan_devices(verbose);
 			error_on(ret, "error %d while scanning", ret);
 			ret = btrfs_register_all_devices();
 			error_on(ret,
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f22089abeaa..02d47a43a792 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -746,7 +746,7 @@ devs_only:
 		else
 			ret = 1;
 	} else {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(false);
 	}
 
 	if (ret) {
diff --git a/common/device-scan.c b/common/device-scan.c
index 48dbd9e19715..a500edf0f7d7 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -360,7 +360,7 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
 	}
 }
 
-int btrfs_scan_devices(void)
+int btrfs_scan_devices(bool verbose)
 {
 	int fd = -1;
 	int ret;
@@ -389,6 +389,8 @@ int btrfs_scan_devices(void)
 			continue;
 		/* if we are here its definitely a btrfs disk*/
 		strncpy_null(path, blkid_dev_devname(dev));
+		if (verbose)
+			printf("blkid: btrfs device: %s\n", path);
 
 		fd = open(path, O_RDONLY);
 		if (fd < 0) {
diff --git a/common/device-scan.h b/common/device-scan.h
index eda2bae5c6c4..3e473c48d1af 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -1,6 +1,7 @@
 #ifndef __DEVICE_SCAN_H__
 #define __DEVICE_SCAN_H__
 
+#include <stdbool.h>
 #include "kerncompat.h"
 #include "ioctl.h"
 
@@ -29,7 +30,7 @@ struct seen_fsid {
 	int fd;
 };
 
-int btrfs_scan_devices(void);
+int btrfs_scan_devices(bool verbose);
 int btrfs_register_one_device(const char *fname);
 int btrfs_register_all_devices(void);
 int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
diff --git a/common/utils.c b/common/utils.c
index f2a10cccca86..9a02a80492cb 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -277,7 +277,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 
 	/* scan other devices */
 	if (is_btrfs && total_devs > 1) {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(false);
 		if (ret)
 			return ret;
 	}
diff --git a/disk-io.c b/disk-io.c
index 01314504a50a..d5b3e4f793e4 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1085,7 +1085,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
 	}
 
 	if (!skip_devices && total_devs != 1) {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(false);
 		if (ret)
 			return ret;
 	}
-- 
2.21.0 (Apple Git-120)

