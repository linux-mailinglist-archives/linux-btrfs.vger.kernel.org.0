Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7B9C46AF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 06:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfJBEpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 00:45:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54864 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfJBEpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 00:45:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x924j3jI019883
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Oct 2019 04:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=+xlcL8MlMztX1wQsChkc6E1Xr8HPpkCUrRGlEbmUGwg=;
 b=UyzVSAV0YBaIZx5xVX8FAUHT0YSNKo0ataSPpFhpwBcpmpWo+nBfQt7aP2DH0BKFJ+5W
 naRXTwtNcawIsHkpBQVJoNrbxPLupbSLp6ykAP3OCtROXuTF17Y5ZmpQ4Y5L5u5UL9Ti
 84ap1Yjn0aONDYJCuuHL24f3oC4c3vAYxcz/MYc0jKPWjxaJJ0a+yVEPWNyvCJXABUcP
 AIV1lDBFbC4XFE9nfVxOxWAUbjrePAhsJ1xazPZEG7Rgx/mu9y5xof6JH7gc26APVGMN
 djnspEgtgDtPMpiAvfnVYo9zdn+GrSgnBMSb0nBgd9CADMADYtdE3ZNxQq1VLZddLjf5 fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2v9xxutknt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2019 04:45:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x924h8DT135049
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Oct 2019 04:45:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vcg60gtd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2019 04:45:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x924j2Rh020272
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Oct 2019 04:45:02 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 21:45:02 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3.1] btrfs-progs: add verbose option to btrfs device scan
Date:   Wed,  2 Oct 2019 12:44:48 +0800
Message-Id: <1569991488-6578-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569989512-5594-1-git-send-email-anand.jain@oracle.com>
References: <1569989512-5594-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020042
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To help debug device scan issues, add verbose option to btrfs device scan.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Tested-by: Graham Cobb <g.btrfs@cobb.uk.net>
---
v3.1: Add --help as well. And update the wordings in Documentation.
v3: Add --verbose long option and update documentation. Thanks Graham.A
    Add Tested-by.
v2: Use bool instead of int as a btrfs_scan_device() argument.

 Documentation/btrfs-device.asciidoc |  2 ++
 cmds/device.c                       | 11 +++++++++--
 cmds/filesystem.c                   |  2 +-
 common/device-scan.c                |  4 +++-
 common/device-scan.h                |  3 ++-
 common/utils.c                      |  2 +-
 disk-io.c                           |  2 +-
 7 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/btrfs-device.asciidoc b/Documentation/btrfs-device.asciidoc
index 70ce6c5a97f8..cca853e4ea8f 100644
--- a/Documentation/btrfs-device.asciidoc
+++ b/Documentation/btrfs-device.asciidoc
@@ -120,6 +120,8 @@ available.
 -u|--forget::::
 Unregister a given device or all stale devices if no path is given, the device
 must be unmounted otherwise it's an error.
+-v|--verbose::::
+List the devices scanned in the current scan and be verbose where needed
 
 *stats* [options] <path>|<device>::
 Read and print the device IO error statistics for all devices of the given
diff --git a/cmds/device.c b/cmds/device.c
index 24158308a41b..8bb44bae7946 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -303,6 +303,8 @@ static const char * const cmd_device_scan_usage[] = {
 	" -d|--all-devices            enumerate and register all devices, use as a fallback",
 	"                             if blkid is not available",
 	" -u|--forget [<device>...]   unregister a given device or all stale devices if no path ",
+	" -v|--verbose [<device>...]  stdout the devices that are scanned in the current scan",
+
 	NULL
 };
 
@@ -313,6 +315,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 	int all = 0;
 	int ret = 0;
 	int forget = 0;
+	bool verbose = false;
 
 	optind = 0;
 	while (1) {
@@ -320,10 +323,11 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 		static const struct option long_options[] = {
 			{ "all-devices", no_argument, NULL, 'd'},
 			{ "forget", no_argument, NULL, 'u'},
+			{ "verbose", no_argument, NULL, 'v'},
 			{ NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "du", long_options, NULL);
+		c = getopt_long(argc, argv, "duv", long_options, NULL);
 		if (c < 0)
 			break;
 		switch (c) {
@@ -333,6 +337,9 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 		case 'u':
 			forget = 1;
 			break;
+		case 'v':
+			verbose = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -354,7 +361,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
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
index 6617b3ef38b1..9027de596f5d 100644
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
index fa679133e171..58861ccfb4ec 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1096,7 +1096,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
 	}
 
 	if (!skip_devices && total_devs != 1) {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(false);
 		if (ret)
 			return ret;
 	}
-- 
1.8.3.1

