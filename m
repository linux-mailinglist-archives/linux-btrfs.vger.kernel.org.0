Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0D2131EB4
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 05:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgAGEwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 23:52:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59698 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgAGEwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 23:52:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0074nbkX095389
        for <linux-btrfs@vger.kernel.org>; Tue, 7 Jan 2020 04:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=w1X8RFPutC1yO32S2jMGahRFIn9R7UeT241mcrMX1hw=;
 b=f8iKbAwpdF6LqJKvoK2x6ZbNytFI3rwHeTLQUFulmzE87XrIVye9XtTV/3IKrCfs8DFk
 kYEekpPlDlRCU3N7mLbBVbz4JevK1eLh6cNaYOz1IVLpr1qEhvG0N0yLeA5jSJnwD6CU
 Gzgb7uXS6IpLyVqy3BdmXZ41znoU5+PzwpC7ChOrIDH0T1C01sWxHIUwp3DIsC8ZHWG9
 qEj+kB1BGzJy7bVPT7LZRmJ5I3vyXE9qVMsTo77xnWKuCY3C9+0tLGXOj1ANgpeuAAJH
 2E41QdVL+0ZF5WIV21OFh5yI2rCRb6Z3PyawJBrfTSU/p8H9CvPFEMK18sa2Z54tYDIM Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xakbqjwxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 04:52:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0074nL76159036
        for <linux-btrfs@vger.kernel.org>; Tue, 7 Jan 2020 04:52:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xb4uqaps4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 04:52:31 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0074qUZ0021689
        for <linux-btrfs@vger.kernel.org>; Tue, 7 Jan 2020 04:52:30 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 20:52:30 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: sysfs, add read_policy attribute
Date:   Tue,  7 Jan 2020 12:52:21 +0800
Message-Id: <1578372741-21586-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <a3e99d85-80c5-5ad3-cda3-75834e1f7441@toxicpanda.com>
References: <a3e99d85-80c5-5ad3-cda3-75834e1f7441@toxicpanda.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070038
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add

 /sys/fs/btrfs/UUID/read_policy

attribute so that the read policy for the raid1 and raid10 chunks can be
tuned.

When this attribute is read, it shall show all available policies, and
the active policy is with in [ ], read_policy attribute can be written
using one of the items showed in the read.

For example:
cat /sys/fs/btrfs/UUID/read_policy
[by_pid]
echo by_pid > /sys/fs/btrfs/UUID/read_policy
echo -n by_pid > /sys/fs/btrfs/UUID/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: check input len before strip and kstrdup.

 fs/btrfs/sysfs.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 2 files changed, 67 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 18dac99188ce..5092a0a26241 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -642,6 +642,71 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 
 BTRFS_ATTR(, checksum, btrfs_checksum_show);
 
+static const inline char *btrfs_read_policy_name(enum btrfs_read_policy_type type)
+{
+	switch (type) {
+	case BTRFS_READ_BY_PID:
+		return "by_pid";
+	default:
+		return "null";
+	}
+}
+
+static ssize_t btrfs_read_policy_show(struct kobject *kobj,
+				      struct kobj_attribute *a, char *buf)
+{
+	int i;
+	ssize_t len = 0;
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+
+	for (i = 0; i < BTRFS_NR_READ_POLICY_TYPE; i++) {
+		if (len)
+			len += snprintf(buf + len, PAGE_SIZE, " ");
+		if (fs_devices->read_policy == i)
+			len += snprintf(buf + len, PAGE_SIZE, "[%s]",
+					btrfs_read_policy_name(i));
+		else
+			len += snprintf(buf + len, PAGE_SIZE, "%s",
+					btrfs_read_policy_name(i));
+	}
+
+	len += snprintf(buf + len, PAGE_SIZE, "\n");
+
+	return len;
+}
+
+static ssize_t btrfs_read_policy_store(struct kobject *kobj,
+				       struct kobj_attribute *a,
+				       const char *buf, size_t len)
+{
+	int i;
+	char *stripped;
+	char *policy_name;
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+
+	if (len > BTRFS_READ_POLICY_NAME_MAX)
+		return -EINVAL;
+
+	policy_name = kstrdup(buf, GFP_KERNEL);
+	if (!policy_name)
+		return -ENOMEM;
+
+	stripped = strstrip(policy_name);
+
+	for (i = 0; i < BTRFS_NR_READ_POLICY_TYPE; i++) {
+		if (strncmp(stripped, btrfs_read_policy_name(i),
+			    strlen(stripped)) == 0) {
+			fs_devices->read_policy = i;
+			kfree(policy_name);
+			return len;
+		}
+	}
+
+	kfree(policy_name);
+	return -EINVAL;
+}
+BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
+
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
@@ -650,6 +715,7 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 	BTRFS_ATTR_PTR(, quota_override),
 	BTRFS_ATTR_PTR(, metadata_uuid),
 	BTRFS_ATTR_PTR(, checksum),
+	BTRFS_ATTR_PTR(, read_policy),
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 401dc32e0caa..022271898e0f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -211,6 +211,7 @@ struct btrfs_device {
 BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
 /* read_policy types */
+#define BTRFS_READ_POLICY_NAME_MAX	12
 #define BTRFS_READ_POLICY_DEFAULT	BTRFS_READ_BY_PID
 enum btrfs_read_policy_type {
 	BTRFS_READ_BY_PID,
-- 
1.8.3.1

