Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14063DE8EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfJUKB4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfJUKBz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xJRt004749
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=ELjK2CbKdMCfVB/8de4QnYSp4SvyRHtDpuYjaPvUOtY=;
 b=nAcGS/0D+MSYoqPQGreuBbiTTPC+nvelRGvZncUYP8ea1t1K25Fe6Mo+28IgkUSx0qoC
 Ca812LHXwVHNbvywQWGSR0WYL2cVGjE9E0N0qYvfcaUvU9fGD4/NAas7PUmWuNw/a7a6
 M62Rs33UeAKXCaRxzNsMTnzvIJLei7tFBeN61/bToSlla59n8+teehkZ0WLwr8/2RUEL
 43DyBx5OwLuL1MeliyH2DkmysvTRLxyDvoXyf6GGrspD7xGCtCC7Q/kNLrlAhC6hZbRA
 7IyQVobscWzD+nvc0gmmpiPyxqV7hObFebNmoD1CLaQys3Enhu+s5lSZ2VRM+bSFBpWy gA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4qedy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9wB0B055745
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vrcmmqg3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:53 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LA1qlP028767
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:52 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:52 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 13/14] btrfs-progs: refactor btrfs_scan_devices() to accept verbose argument
Date:   Mon, 21 Oct 2019 18:01:21 +0800
Message-Id: <1571652082-25982-14-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
References: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210096
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function btrfs_scan_devices() is being used by commands such as
'btrfs filesystem' and 'btrfs device', by having the verbose argument in
the btrfs_scan_devices() we can control which threads to show the
verbose when verbose is enabled by the global verbose option.

So add an option %verbose to btrfs_scan_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/device.c        | 2 +-
 cmds/filesystem.c    | 2 +-
 common/device-scan.c | 4 +++-
 common/device-scan.h | 2 +-
 common/utils.c       | 2 +-
 disk-io.c            | 2 +-
 6 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index 24158308a41b..b429a169cd5d 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -354,7 +354,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 			}
 		} else {
 			printf("Scanning for Btrfs filesystems\n");
-			ret = btrfs_scan_devices();
+			ret = btrfs_scan_devices(false);
 			error_on(ret, "error %d while scanning", ret);
 			ret = btrfs_register_all_devices();
 			error_on(ret,
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index ee4d366fbf64..fb6e2e998dcf 100644
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
index 48dbd9e19715..a5963d789f49 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -26,6 +26,7 @@
 #include <linux/limits.h>
 #include <blkid/blkid.h>
 #include <uuid/uuid.h>
+#include <stdbool.h>
 #include "kernel-lib/overflow.h"
 #include "common/path-utils.h"
 #include "common/device-scan.h"
@@ -360,7 +361,7 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
 	}
 }
 
-int btrfs_scan_devices(void)
+int btrfs_scan_devices(bool verbose)
 {
 	int fd = -1;
 	int ret;
@@ -404,6 +405,7 @@ int btrfs_scan_devices(void)
 			close (fd);
 			continue;
 		}
+		pr_verbose(verbose, "registered: %s\n", path);
 
 		close(fd);
 	}
diff --git a/common/device-scan.h b/common/device-scan.h
index eda2bae5c6c4..c50fe2fbf91f 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -29,7 +29,7 @@ struct seen_fsid {
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
index a9744af90a43..33bd003167fe 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1100,7 +1100,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
 	}
 
 	if (!skip_devices && total_devs != 1) {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(false);
 		if (ret)
 			return ret;
 	}
-- 
1.8.3.1

