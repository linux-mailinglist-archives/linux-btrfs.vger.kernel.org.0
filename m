Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3F06A0B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 05:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfGPDFV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 23:05:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54698 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfGPDFV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 23:05:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6G34Jr6149501
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 03:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Bl3ZMHMRyAzgTiXvNqg84V4teB2cumu/+wKl8BlvlbE=;
 b=q95rF0daR59GDQVRppS2rqNYD5Sl3nfkoEY4AQIa+WteYufaVNP272C8SEzEYfWJWQeP
 /F5BU0GUHQniN+OyINI4Sq5Nai3n3caQu9CwwX8pvK0Mxau4MCqhr291dYZ9afXqIU+D
 6+LNkFhM2s3RH5ZMNPecRqcnBtJAj4Z3qZ+siL0jDaUQtn27NjjelZysKB++UVlO7V+c
 2oEIc5DMN1IKtJUqLzfxQgJQDGqSGmqIqPqDgfrIDPFoVBQKmpWSgic924i++lOiJTRp
 EFhO5sosB0qQxPgdXLzgH7qvbsV9JgV4jKSp3wrPJ1Jsk96D5GEoTZ4vUipQWupuySjs 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tq7xqsrb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 03:05:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6G32SWp193825
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 03:05:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tq742whnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 03:05:18 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6G35I09019881
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 03:05:18 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 20:05:17 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: add verbose option to btrfs device scan
Date:   Tue, 16 Jul 2019 11:05:14 +0800
Message-Id: <20190716030514.1152-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190715144241.1077-1-anand.jain@oracle.com>
References: <20190715144241.1077-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160038
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
index 2c5ae225f710..71c91dee6a86 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -351,7 +351,7 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
 	}
 }
 
-int btrfs_scan_devices(void)
+int btrfs_scan_devices(bool verbose)
 {
 	int fd = -1;
 	int ret;
@@ -380,6 +380,8 @@ int btrfs_scan_devices(void)
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
index ad938409a94f..07648f07fbd4 100644
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
index be44eead5cef..71ed78b671da 100644
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

