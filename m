Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02313089C
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 16:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAEPOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 10:14:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgAEPOf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 10:14:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 005FCf6q071461;
        Sun, 5 Jan 2020 15:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=XWj5CRMbSfqCTc6TTYfXxGozNg39yf0Bb+Ft0YvyrTA=;
 b=SGAEqYH9jovoFZJKfcIxbM4ClsGWbq6+njVSEXyqz5SThoYNsNIwqxLexr9nWhA9prO3
 Kt2TD3pG407zTZCrMiZUkcXZ0XjiBLwxgfByznPIc0ukKCfzEdV4NfgXu/NLkZbcZMkV
 cxnlf3CG0T0hfdoE0UZsreTiD+UNHwoXyoiMkYMfRVW0Fi9VFFTcdyKMimCodoO+nsXf
 5Gfjbe+Nx51jvxxv9F26Nm5jZnTiMR8pw9rrkR0VTTcJMnBj/uvJUkBr7EZdYPgOmHZf
 TXIXTmAm1sYvfS4ozJWBWqYOml6K7/i3UR4l2AsEF2Mh4jhE2aUTL5v52dYM4JI2rF86 Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xaj4tkfbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Jan 2020 15:14:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 005F955I068058;
        Sun, 5 Jan 2020 15:14:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xb46544hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Jan 2020 15:14:29 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 005FETAA004211;
        Sun, 5 Jan 2020 15:14:29 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Jan 2020 07:14:27 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, btrfs-list@steev.me.uk
Subject: [PATCH 2/2] btrfs: sysfs, add read_policy attribute
Date:   Sun,  5 Jan 2020 23:14:02 +0800
Message-Id: <20200105151402.1440-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200105151402.1440-1-anand.jain@oracle.com>
References: <20200105151402.1440-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9490 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001050138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9490 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001050138
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
 fs/btrfs/sysfs.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 2 files changed, 68 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d414b98fb27f..ae2935184d75 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -642,6 +642,72 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 
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
+	policy_name = kstrdup(buf, GFP_KERNEL);
+	if (!policy_name)
+		return -ENOMEM;
+
+	stripped = strstrip(policy_name);
+	if (strlen(stripped) > BTRFS_READ_POLICY_NAME_MAX) {
+		kfree(policy_name);
+		return -EINVAL;
+	}
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
@@ -650,6 +716,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, quota_override),
 	BTRFS_ATTR_PTR(, metadata_uuid),
 	BTRFS_ATTR_PTR(, checksum),
+	BTRFS_ATTR_PTR(, read_policy),
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3bbf0e51433f..dd8a8d2fbbe1 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -210,6 +210,7 @@ BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
 /* read_policy types */
+#define BTRFS_READ_POLICY_NAME_MAX	12
 #define BTRFS_READ_POLICY_DEFAULT	BTRFS_READ_BY_PID
 enum btrfs_read_policy_type {
 	BTRFS_READ_BY_PID,
-- 
2.23.0

