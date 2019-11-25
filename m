Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2CB108BE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKYKj4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50572 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfKYKj4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY7ap026850
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=3wS0qq1e+OKAdugZ2dHICQ/1e/HGoO8++rI2UkySYYI=;
 b=HCEEW0NV7BrlJ+VC7JvPnxRpJedGeKj2s4t9Uahj2I//cbyWiozP06/gDv8fcxn8WgFJ
 ItRLBlrtvsg6luQCYuOhoqVDZptpfTEepCTAX+ChliNUBloTKDPwtfWLvlFMnY9N3HdY
 Cd6z/0vcnxoRtsZNsfBXBOn4ScugmhP8vgThoTstF3dgMSwpiu3JtTWWFkNQvDK+ECRo
 Tt0HQshUJXrdxA77ZQtpR9zs5M0j2yvSREMMrws2trYCcJvzQWAED5bLVLX3EYeu0qEK
 9mQMjYoeQe45wQqw3n+PW1T2tw6RIlw/sZiMmm/BKPhE9Luo3zcJq2E5BhfXcseOSvHs dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wev6txru7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAX3Ep169586
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wfewa7ap9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:54 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAPAdrk9017670
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:53 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:52 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/16] btrfs-progs: refactor btrfs_scan_devices() to accept verbose argument
Date:   Mon, 25 Nov 2019 18:39:15 +0800
Message-Id: <1574678357-22222-15-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250098
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
 common/device-scan.c | 3 ++-
 common/device-scan.h | 2 +-
 common/utils.c       | 2 +-
 disk-io.c            | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

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
index fc1736d9fe66..621fecd21dde 100644
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
index 48dbd9e19715..b6b6b30cfb23 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -360,7 +360,7 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
 	}
 }
 
-int btrfs_scan_devices(void)
+int btrfs_scan_devices(int verbose)
 {
 	int fd = -1;
 	int ret;
@@ -404,6 +404,7 @@ int btrfs_scan_devices(void)
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
index 4b5d40b2bc56..fe258eacf655 100644
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
index 659f8b93a7ca..98431e0d2295 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1105,7 +1105,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
 	}
 
 	if (!skip_devices && total_devs != 1) {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(0);
 		if (ret)
 			return ret;
 	}
-- 
1.8.3.1

