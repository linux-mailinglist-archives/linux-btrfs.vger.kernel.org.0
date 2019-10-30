Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C556FE985A
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfJ3Il5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60940 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfJ3Il5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cf7l054195;
        Wed, 30 Oct 2019 08:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=UopcGdMwXhalUExdUYyWFnQlgr4SJ8p7x+zjy2IZQw8=;
 b=iQDU27bn4qfEq8saVtaSQOE9lkQGFoW44U1WMJkRCadDoITINB9fX+auEzvWtzKydetL
 WxMn9ar2ugUmR7ycdI9JfcEz4o8OQBIlXYvFq+mOCJxxxY+vAKXY6gXwty51RX/5i3D3
 I0hykiHUGMEBMHec+SsGm9I77lVWotGf0vbe9p/BV4MaZMEwEbE+DTyldMuM9KVEjQXs
 MGablKNEMGq3R0uuSDoUw14U+6yB4PTbcdqswRIiJTHZbZbrG3PU9GBvt4XnSsvVGazh
 GJeZDhkYKGhOlmsXJNGN3+iDz0CBWtTQqP0pktXImiEkeh8QlfgwoHydce0yX/+Ym9wx Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vxwhfje4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8ctZ6071182;
        Wed, 30 Oct 2019 08:41:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vxwj8uuh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:55 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9U8fsZx018740;
        Wed, 30 Oct 2019 08:41:55 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:54 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 16/18] btrfs-progs: refactor btrfs_scan_devices() to accept verbose argument
Date:   Wed, 30 Oct 2019 16:41:20 +0800
Message-Id: <20191030084122.29745-17-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030084122.29745-1-anand.jain@oracle.com>
References: <20191030084122.29745-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300086
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
index 24158308a41b..f96d71e0477a 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -354,7 +354,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 			}
 		} else {
 			printf("Scanning for Btrfs filesystems\n");
-			ret = btrfs_scan_devices();
+			ret = btrfs_scan_devices(0);
 			error_on(ret, "error %d while scanning", ret);
 			ret = btrfs_register_all_devices();
 			error_on(ret,
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 819b9fd1fcc5..c5332335e417 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -746,7 +746,7 @@ devs_only:
 		else
 			ret = 1;
 	} else {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(0);
 	}
 
 	if (ret) {
diff --git a/common/device-scan.c b/common/device-scan.c
index 48dbd9e19715..92997a6f4bc9 100644
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
+int btrfs_scan_devices(int verbose)
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
index eda2bae5c6c4..8017a27511b9 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -29,7 +29,7 @@ struct seen_fsid {
 	int fd;
 };
 
-int btrfs_scan_devices(void);
+int btrfs_scan_devices(int verbose);
 int btrfs_register_one_device(const char *fname);
 int btrfs_register_all_devices(void);
 int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
diff --git a/common/utils.c b/common/utils.c
index c2c6d0af0efc..81c319f8ff52 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -277,7 +277,7 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 
 	/* scan other devices */
 	if (is_btrfs && total_devs > 1) {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(0);
 		if (ret)
 			return ret;
 	}
diff --git a/disk-io.c b/disk-io.c
index c3e85c0ee06e..beec7b162531 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1097,7 +1097,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
 	}
 
 	if (!skip_devices && total_devs != 1) {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(0);
 		if (ret)
 			return ret;
 	}
-- 
2.23.0

