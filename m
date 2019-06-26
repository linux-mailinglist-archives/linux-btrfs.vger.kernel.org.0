Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09546564AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 10:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfFZIeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 04:34:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33434 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZIeL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 04:34:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8XTaE094511
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=uqu40duEgYSQTaiWyT5VjkSAlDwGCtz99O26zQFqklw=;
 b=ioyHFkrZXopa/ZgH5LI31YGEixx+9OalmONZW3sAIB1l4CXod3YyeCVfEnGfX4iPrACt
 whN7EAc2UDCezP6rLQSxqLSBUi1OYCKMyZRlgeSEZSk2b8g4d/pIWa2eWNeCLXM4XbC/
 yQ6xt6xaM8gUhhS4V/FQu5x5K6NRtw5PO9Q5aYAB2WZ5fIFiTZSi3RHUmkHGl5/MgKk0
 JNEbdDVZmkWKeoHgFL0S691tE0oXhT5hh/BRK/22cVyf4tWsBRafhChwseYWKeLDpUNM
 UrIZH8Ptc45ybX5vhBx/+lq7KN4+W5JZ+xS11yzZB/0Heh4pHjI4EyExDO0XQXREJ37u 8g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9prtvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8XlXd156385
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t9acck1b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:09 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5Q8Y9NA015517
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:09 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 01:34:09 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3 RESEND Rebased] btrfs: add readmirror property framework
Date:   Wed, 26 Jun 2019 16:34:01 +0800
Message-Id: <20190626083402.1895-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190626083402.1895-1-anand.jain@oracle.com>
References: <20190626083402.1895-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260104
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function call chain  __btrfs_map_block()->find_live_mirror() uses
thread %pid to determine the %mirror_num for the read when mirror_num=0
in the argument.

This patch introduces a framework so that readmirror is a configurable
parameter, with default set to pid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/props.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  9 ++++++++-
 fs/btrfs/volumes.h |  6 ++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index f9143f7c006d..0dc26a154a98 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -10,6 +10,7 @@
 #include "ctree.h"
 #include "xattr.h"
 #include "compression.h"
+#include "volumes.h"
 
 #define BTRFS_PROP_HANDLERS_HT_BITS 8
 static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
@@ -312,6 +313,39 @@ static const char *prop_compression_extract(struct inode *inode)
 	return NULL;
 }
 
+static int prop_readmirror_validate(struct inode *inode, const char *value,
+				    size_t len)
+{
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+
+	if (root->root_key.objectid != BTRFS_FS_TREE_OBJECTID)
+		return -EINVAL;
+
+	if (!len)
+		return 0;
+
+	return -EINVAL;
+}
+
+static int prop_readmirror_apply(struct inode *inode, const char *value,
+				 size_t len)
+{
+	struct btrfs_fs_devices *fs_devices = btrfs_sb(inode->i_sb)->fs_devices;
+
+	fs_devices->readmirror_policy = BTRFS_READMIRROR_DEFAULT;
+
+	return 0;
+}
+
+static const char *prop_readmirror_extract(struct inode *inode)
+{
+	/*
+	 * readmirror policy is applied for the whole FS, inheritance is not
+	 * applicable.
+	 */
+	return NULL;
+}
+
 static struct prop_handler prop_handlers[] = {
 	{
 		.xattr_name = XATTR_BTRFS_PREFIX "compression",
@@ -320,6 +354,13 @@ static struct prop_handler prop_handlers[] = {
 		.extract = prop_compression_extract,
 		.inheritable = 1
 	},
+	{
+		.xattr_name = XATTR_BTRFS_PREFIX "readmirror",
+		.validate = prop_readmirror_validate,
+		.apply = prop_readmirror_apply,
+		.extract = prop_readmirror_extract,
+		.inheritable = 0
+	},
 };
 
 static int inherit_props(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a13ddba1ebc3..d72850ed4f88 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5490,7 +5490,14 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	else
 		num_stripes = map->num_stripes;
 
-	preferred_mirror = first + current->pid % num_stripes;
+	switch(fs_info->fs_devices->readmirror_policy) {
+	case BTRFS_READMIRROR_DEFAULT:
+		/* fall through */
+	default:
+		/* readmirror as per thread pid */
+		preferred_mirror = first + current->pid % num_stripes;
+		break;
+	}
 
 	if (dev_replace_is_ongoing &&
 	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7f6aa1816409..e985d2133c0a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -219,6 +219,10 @@ BTRFS_DEVICE_GETSET_FUNCS(total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
+enum btrfs_readmirror_policy {
+	BTRFS_READMIRROR_DEFAULT,
+};
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
@@ -269,6 +273,8 @@ struct btrfs_fs_devices {
 	struct kobject fsid_kobj;
 	struct kobject *device_dir_kobj;
 	struct completion kobj_unregister;
+
+	int readmirror_policy;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.20.1 (Apple Git-117)

