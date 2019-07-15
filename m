Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B4669348
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2019 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbfGOOmz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 10:42:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40186 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732492AbfGOOmy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 10:42:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FEfO0K049044
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 14:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=9oXgsp0KHbUJVa7isWedOZYxKhmpgR4CxYT+3S9yDGs=;
 b=K6de2GApTfrrADMHuyIEJUMCGwlcTcQ9wrbTa1sPojd3sh9yjPu+s3OzO1AbXguw9s9a
 eO8d8iwa1D9aL9XX2dE12P3pIuMmpzPyS73AeObe+xnUOs+EKZDyfY/BNHPis2ZUqE3B
 EbaLo7mI48W+3LMCBeGyacGWu8M8XOj+J3qZpNNgDyYu6pd1XwrVEVROJMYMQrihdrHq
 YVLUgk30f00KVpqRQI093K+k0Vb0UPR3qMwVdFmphMegeGgWXlqTeo2rr6RxRYSjBip8
 asLztd4Fu06MONia4zuOK3Kif6X1gt6rIrWxN6R7khz6LdgitU8B7YN0aU+V8QfKVpjf KQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2tq78peuvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 14:42:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FEgqVd080572
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 14:42:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tq4dtbpwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 14:42:52 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6FEgjI1002743
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 14:42:45 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 07:42:45 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: add verbose option to btrfs device scan
Date:   Mon, 15 Jul 2019 22:42:41 +0800
Message-Id: <20190715144241.1077-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150175
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To help debug device scan issues, add verbose option to btrfs device scan.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/device.c        | 8 ++++++--
 cmds/filesystem.c    | 2 +-
 common/device-scan.c | 4 +++-
 common/device-scan.h | 2 +-
 common/utils.c       | 2 +-
 disk-io.c            | 2 +-
 6 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index 24158308a41b..2fa13e61f806 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -313,6 +313,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 	int all = 0;
 	int ret = 0;
 	int forget = 0;
+	int verbose = 0;
 
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
+			verbose = 1;
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
index 4f22089abeaa..37b23af36847 100644
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
index 2c5ae225f710..bea201b351f0 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -351,7 +351,7 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
 	}
 }
 
-int btrfs_scan_devices(void)
+int btrfs_scan_devices(int verbose)
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
index ad938409a94f..36ce89a025f1 100644
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
index be44eead5cef..4f52a29700ab 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1085,7 +1085,7 @@ int btrfs_scan_fs_devices(int fd, const char *path,
 	}
 
 	if (!skip_devices && total_devs != 1) {
-		ret = btrfs_scan_devices();
+		ret = btrfs_scan_devices(0);
 		if (ret)
 			return ret;
 	}
-- 
2.21.0 (Apple Git-120)

