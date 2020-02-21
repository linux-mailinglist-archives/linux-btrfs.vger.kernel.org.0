Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4E166F8B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 07:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgBUGPt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 01:15:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40058 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgBUGPs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 01:15:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01L6EFQm188060
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 06:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=EcATJ5oaElG740C/SLF1CHMX2B7HfhpTjWfGX7OL3vw=;
 b=TM5OXCA8+dpExRkkGl6sc/pYg2/G5iUQe3GlAgARRDLj8ybyT9w577uMOOdBpGo6aqPH
 95/wVjaT0/zNVFAboDd+j8t/wrSMyE0LppggH7iykEnA3b6P1IVfQ9/4fnbFYm1RRuVc
 FVOCwctEjPCnhX/cCndopRKegnqIoQtfomK6CuA8CWNyTgVv5FfqxWG7qUUaQnsHhLAp
 zEy88iel2aq+4kuNqECc5zf0Y2o5xNZiYaBH8JIYa+9Bo4BTH1XgS1DcMoqZRbbM6bKQ
 OMjbtc+5jlRV17G+NzMctUoq+23KRtKZWweUodhgJyIukYK8jq2yB9/fEYlTto9q5wmK /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y8ud1emps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 06:15:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01L6Bi3i077451
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 06:15:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2y8ud5r49g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 06:15:47 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01L6FlIt006988
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 06:15:47 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 22:15:46 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 3/5] btrfs: create read policy sysfs attribute, pid
Date:   Fri, 21 Feb 2020 14:15:36 +0800
Message-Id: <20200221061538.4508-4-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200221061538.4508-1-anand.jain@oracle.com>
References: <20200221061538.4508-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=1 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=1 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210043
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

