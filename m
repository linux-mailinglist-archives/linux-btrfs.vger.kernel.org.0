Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5796E19F52B
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 13:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgDFLvj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 07:51:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60732 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgDFLvj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 07:51:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BlgAG078970
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=EcATJ5oaElG740C/SLF1CHMX2B7HfhpTjWfGX7OL3vw=;
 b=RV3omNjqeM+5D4OrIyyDTNu5lmpEIvGpKWfJHmtwcVSyAQN7VavOXI97xvb2yVpJ2vsF
 QVO/PL4sv52da0bJ+rREimsZGhXhOqQ+MWrt0tedrMlfC7uhGNjtLhhT1NvzEZBrXZWq
 rpnW+yx2br409Z3PUlyNcyLIXFdmNMlvvUK/9yXOM2NUlHLFdLbmD9RSFaQjTC4ANP9h
 hrcI2D53AcOVpC4dNjccD0v9Xwv5pDZXE6vwEeAABIbxrL63gztiuHcN/ifIMc1ZVDjT
 npeA4fLlbxtA7WSIiKqD23U2EMELRw5hkj0G2nGBxupV59G63mG/bq1a7wmDIugocOqT /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 306j6m6arn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 11:51:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BmPro007355
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30839ptwaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 11:51:36 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036BpZZT025403
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:35 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 04:51:35 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 3/5] btrfs: create read policy sysfs attribute, pid
Date:   Mon,  6 Apr 2020 19:51:09 +0800
Message-Id: <1586173871-5559-4-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=1 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060104
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add

 /sys/fs/btrfs/UUID/read_policy

attribute so that the read policy for the raid1 and raid10 chunks can be
tuned.

When this attribute is read, it shall show all available policies, with
active policy being with in [ ]. The read_policy attribute can be written
using one of the items listed in there.

For example:
  $cat /sys/fs/btrfs/UUID/read_policy
  [pid]
  $echo pid > /sys/fs/btrfs/UUID/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v5: 
  Title rename: old: btrfs: sysfs, add read_policy attribute
  Uses the btrfs_strmatch() helper (BTRFS_READ_POLICY_NAME_MAX dropped).
  Use the table for the policy names.
  Rename len to ret.
  Use a simple logic to prefix space in btrfs_read_policy_show()
  Reviewed-by: Josef Bacik <josef@toxicpanda.com> dropped.

v4:-
v3: rename [by_pid] to [pid]
v2: v2: check input len before strip and kstrdup

 fs/btrfs/sysfs.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 7bb68cef98ab..c9a8850b186a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -832,6 +832,54 @@ static int btrfs_strmatch(const char *given, const char *golden)
 	return -EINVAL;
 }
 
+static const char* const btrfs_read_policy_name[] = { "pid" };
+
+static ssize_t btrfs_read_policy_show(struct kobject *kobj,
+				      struct kobj_attribute *a, char *buf)
+{
+	int i;
+	ssize_t ret = 0;
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+
+	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
+		if (fs_devices->read_policy == i)
+			ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",
+					(ret == 0 ? "" : " "),
+					btrfs_read_policy_name[i]);
+		else
+			ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+					(ret == 0 ? "" : " "),
+					btrfs_read_policy_name[i]);
+	}
+
+	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
+
+	return ret;
+}
+
+static ssize_t btrfs_read_policy_store(struct kobject *kobj,
+				       struct kobj_attribute *a,
+				       const char *buf, size_t len)
+{
+	int i;
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+
+	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
+		if (btrfs_strmatch(buf, btrfs_read_policy_name[i]) == 0) {
+			if (i != fs_devices->read_policy) {
+				fs_devices->read_policy = i;
+				btrfs_info(fs_devices->fs_info,
+					   "read policy set to '%s'",
+					   btrfs_read_policy_name[i]);
+			}
+			return len;
+		}
+	}
+
+	return -EINVAL;
+}
+BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
@@ -840,6 +888,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, quota_override),
 	BTRFS_ATTR_PTR(, metadata_uuid),
 	BTRFS_ATTR_PTR(, checksum),
+	BTRFS_ATTR_PTR(, read_policy),
 	NULL,
 };
 
-- 
2.23.0

