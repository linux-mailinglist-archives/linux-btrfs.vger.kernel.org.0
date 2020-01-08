Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10D8133A0D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 05:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgAHEQz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 23:16:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48686 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAHEQz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 23:16:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0084ERBJ032595
        for <linux-btrfs@vger.kernel.org>; Wed, 8 Jan 2020 04:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=5agn8WfnVBlnEfR1QHiwB4b8SrSvWaFAJoWRlE+jLcQ=;
 b=GrgmuzMDLKWRnwRMm0Gl9gusFsR96vi50ixAhje7p7ALoLcRIckEHoSLPbZMg6Tt5SI+
 vkyCpsO4MJVfG6jbBbE8BzabY5JK1fGgQmjVm9MAC2D/aL+FQy4IpuGSyFoTGmkmnnWl
 oOj8RgsI9AZz1U6txHpi96Uz5GrqV6OBQwz+Vy8Jb5bnieCojES3q5fb9fK4PP54Vfex
 Pq1hlApxZlUL4HhgpPZAePj2b1HJ1Jku7hklDDSbJyj21i0idJsJWgTTkSunZ223DaHf
 IbOfP0rsn6M3LNu+1kKvVrsl6eCibaGcuQFeze757LSHrYjMcv2CP2TnbSzDBVosLzsR Mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xakbqscam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jan 2020 04:16:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0084EEQu127808
        for <linux-btrfs@vger.kernel.org>; Wed, 8 Jan 2020 04:16:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xcpanytbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jan 2020 04:16:52 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0084Gpqn017832
        for <linux-btrfs@vger.kernel.org>; Wed, 8 Jan 2020 04:16:51 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 20:16:51 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: sysfs, add read_policy attribute
Date:   Wed,  8 Jan 2020 12:16:47 +0800
Message-Id: <20200108041647.2330-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <b39e2e18-4116-f77b-df59-d39aa006ea93@applied-asynchrony.com>
References: <b39e2e18-4116-f77b-df59-d39aa006ea93@applied-asynchrony.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080036
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v3: rename [by_pid] to [pid]
v2: v2: check input len before strip and kstrdup

 fs/btrfs/sysfs.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 2 files changed, 67 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 104a97586744..cc4a642878a1 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -809,6 +809,71 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 
 BTRFS_ATTR(, checksum, btrfs_checksum_show);
 
+static const inline char *btrfs_read_policy_name(enum btrfs_read_policy_type type)
+{
+	switch (type) {
+	case BTRFS_READ_BY_PID:
+		return "pid";
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
@@ -817,6 +882,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, quota_override),
 	BTRFS_ATTR_PTR(, metadata_uuid),
 	BTRFS_ATTR_PTR(, checksum),
+	BTRFS_ATTR_PTR(, read_policy),
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 46f4e2258203..fe1494d95893 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -209,6 +209,7 @@ BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
 /* read_policy types */
+#define BTRFS_READ_POLICY_NAME_MAX	12
 #define BTRFS_READ_POLICY_DEFAULT	BTRFS_READ_BY_PID
 enum btrfs_read_policy_type {
 	BTRFS_READ_BY_PID,
-- 
2.23.0

