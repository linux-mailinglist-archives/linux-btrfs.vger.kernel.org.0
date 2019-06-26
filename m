Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF84564AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 10:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFZIeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 04:34:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33482 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZIeO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 04:34:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8XXJr094696
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=TieGbJPaRuPjrFdrvq/XP2Fzg4W1ta8P6t290Vv9cRI=;
 b=z0Qe8mMJJNX7Km4F/1OpQqm1tbwna+G7/7+kq0gAUA/ApjCTNOtR8wF3PFrMBZWiV1Cu
 2AmMv771JdYy721CVXDMgPV2sgnqwgegDMXugr6xLvXizhNrIMcJK4oZ08Tl7l17Z7ie
 PPNHL7GUtyx17eLfucEYBXq9MirVJXk+ZrHUPAeNBvU+CsqDgcwR8mQJvs24ocTg+eW8
 RviKUnuMPli7MLtFKMSVpktAKGGpXNbF0KPR2uJ0oN6GTAf3dFojLV9/EADPhzck4WRM
 YMbKMvVIk3pG5GP06DnreqN3Y9FLgnAtB8grlAOMkCIFGkGhffNsR6d9t2iTjV1aXR7V xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9prtvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8XTcg083933
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7cq5n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:11 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5Q8YB9F013208
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:34:11 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 01:34:10 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3 RESEND Rebased] btrfs: add readmirror devid property
Date:   Wed, 26 Jun 2019 16:34:02 +0800
Message-Id: <20190626083402.1895-4-anand.jain@oracle.com>
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

Introduces devid readmirror property, to direct read IO to the specified
device(s).

The readmirror property is stored as extended attribute on the root
inode. The readmirror input format is devid1,2,3.. etc. And for the
each devid provided, a new flag BTRFS_DEV_STATE_READ_OPTIMISED is set.

As of now readmirror by devid supports only raid1s. Raid10 support has
to leverage device grouping feature, which is yet to be implemented.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/props.c   | 69 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c | 16 +++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 0dc26a154a98..6a789e1c150c 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -316,7 +316,10 @@ static const char *prop_compression_extract(struct inode *inode)
 static int prop_readmirror_validate(struct inode *inode, const char *value,
 				    size_t len)
 {
+	char *value_dup;
+	char *devid_str;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_fs_devices *fs_devices = root->fs_info->fs_devices;
 
 	if (root->root_key.objectid != BTRFS_FS_TREE_OBJECTID)
 		return -EINVAL;
@@ -324,16 +327,80 @@ static int prop_readmirror_validate(struct inode *inode, const char *value,
 	if (!len)
 		return 0;
 
-	return -EINVAL;
+	if (len <= 5 || strncmp("devid", value, 5))
+		return -EINVAL;
+
+	value_dup = kstrndup(value + 5, len - 5, GFP_KERNEL);
+	if (!value_dup)
+		return -ENOMEM;
+
+	while ((devid_str = strsep(&value_dup, ",")) != NULL) {
+		u64 devid;
+		struct btrfs_device *device;
+
+		if (kstrtoull(devid_str, 10, &devid)) {
+			kfree(value_dup);
+			return -EINVAL;
+		}
+
+		device = btrfs_find_device(fs_devices, devid, NULL, NULL, false);
+		if (!device) {
+			kfree(value_dup);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
 }
 
 static int prop_readmirror_apply(struct inode *inode, const char *value,
 				 size_t len)
 {
+	char *value_dup;
+	char *devid_str;
+	struct btrfs_device *device;
 	struct btrfs_fs_devices *fs_devices = btrfs_sb(inode->i_sb)->fs_devices;
 
+	if (value) {
+		value_dup = kstrndup(value + 5, len - 5, GFP_KERNEL);
+		if (!value_dup)
+			return -ENOMEM;
+	}
+
+	/* Both set and reset has to clear the exisiting values */
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (test_bit(BTRFS_DEV_STATE_READ_OPTIMISED,
+			     &device->dev_state)) {
+			clear_bit(BTRFS_DEV_STATE_READ_OPTIMISED,
+				  &device->dev_state);
+		}
+	}
 	fs_devices->readmirror_policy = BTRFS_READMIRROR_DEFAULT;
 
+	/* Its only reset so just return */
+	if (!value)
+		return 0;
+
+	while ((devid_str = strsep(&value_dup, ",")) != NULL) {
+		u64 devid;
+
+		/* Has been verified in validate() this will not fail */
+		if (kstrtoull(devid_str, 10, &devid)) {
+			kfree(value_dup);
+			return -EINVAL;
+		}
+
+		device = btrfs_find_device(fs_devices, devid, NULL, NULL, false);
+		if (!device) {
+			kfree(value_dup);
+			return -EINVAL;
+		}
+
+		set_bit(BTRFS_DEV_STATE_READ_OPTIMISED, &device->dev_state);
+		fs_devices->readmirror_policy = BTRFS_READMIRROR_DEVID;
+	}
+
+	kfree(value_dup);
 	return 0;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d72850ed4f88..993645f4b5f6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5481,6 +5481,7 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	int preferred_mirror;
 	int tolerance;
 	struct btrfs_device *srcdev;
+	bool found = false;
 
 	ASSERT((map->type &
 		 (BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10)));
@@ -5491,6 +5492,21 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 		num_stripes = map->num_stripes;
 
 	switch(fs_info->fs_devices->readmirror_policy) {
+	case BTRFS_READMIRROR_DEVID:
+		/* skip raid10 for now */
+		if (map->type & BTRFS_BLOCK_GROUP_RAID1) {
+			for (i = first; i < first + num_stripes; i++) {
+				if (test_bit(BTRFS_DEV_STATE_READ_OPTIMISED,
+					     &map->stripes[i].dev->dev_state)) {
+					preferred_mirror = i;
+					found = true;
+					break;
+				}
+			}
+			if (found)
+				break;
+		}
+		/* fall through */
 	case BTRFS_READMIRROR_DEFAULT:
 		/* fall through */
 	default:
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index e985d2133c0a..55b0f3b28595 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -56,6 +56,7 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_MISSING		(2)
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
+#define BTRFS_DEV_STATE_READ_OPTIMISED	(5)
 
 struct btrfs_device {
 	struct list_head dev_list; /* device_list_mutex */
@@ -221,6 +222,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
 enum btrfs_readmirror_policy {
 	BTRFS_READMIRROR_DEFAULT,
+	BTRFS_READMIRROR_DEVID,
 };
 
 struct btrfs_fs_devices {
-- 
2.20.1 (Apple Git-117)

