Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDA929D5DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 23:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgJ1WJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 18:09:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33274 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgJ1WJW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:09:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDFERB063279;
        Wed, 28 Oct 2020 13:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=TTyUtm+lprmkH6EXEQDjUeh+l8OJGRlaIaQQkzys1EU=;
 b=nSc7hptMicyMzzjlGeDJb+4Uo3mHxzsg+Gx3ONM/UZ3vyMWBnX5ki5lsXyWEp4cyTBFg
 CH/LulTYhCgJ9DLsPwj7FHW7fwpKs/nBcVCGr2E8D5LkHDKNDXy0pYxOqPuhIyioEhIN
 DwSxtKaIHZA1M1Tw1LLY8WySWxjwbytOhLIZqMvmbDOom9fHXEeEUYKY7mVMv5J5ibWR
 0apaagMMN4OZyOBt+ajINLL3liLj7dDhKaRil6mXD8i2a/lUTFheIctrZAy0EucXtfu8
 +Ip5tyB8SU8vrVSqJMGe/LDGW8KDZPewPWlnyY2rDIn885njUo5owamqNjfTdu06aHhg hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34c9sayfg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 13:15:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDBMVL178168;
        Wed, 28 Oct 2020 13:15:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34cx6x7evv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:15:09 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SDF7X1011185;
        Wed, 28 Oct 2020 13:15:08 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 06:15:07 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 3/3] btrfs: create read policy sysfs attribute, pid
Date:   Wed, 28 Oct 2020 21:14:47 +0800
Message-Id: <52a41497534bdaa301adc57d61ea3632ab65f2c6.1603884513.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603884513.git.anand.jain@oracle.com>
References: <cover.1603884513.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280089
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add

 /sys/fs/btrfs/UUID/read_policy

attribute so that the read policy for the raid1, raid1c34 and raid10 can
be tuned.

When this attribute is read, it shall show all available policies, with
active policy being with in [ ]. The read_policy attribute can be written
using one of the items listed in there.

For example:
  $cat /sys/fs/btrfs/UUID/read_policy
  [pid]
  $echo pid > /sys/fs/btrfs/UUID/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v10: use scnprintf instead of snprintf
v9: fix C coding style, static const char*
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
index 5955379d3d9e..4dbf90ff088a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -906,6 +906,54 @@ static bool btrfs_strmatch(const char *given, const char *golden)
 	return false;
 }
 
+static const char * const btrfs_read_policy_name[] = { "pid" };
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
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s[%s]",
+					 (ret == 0 ? "" : " "),
+					 btrfs_read_policy_name[i]);
+		else
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+					 (ret == 0 ? "" : " "),
+					 btrfs_read_policy_name[i]);
+	}
+
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
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
+		if (btrfs_strmatch(buf, btrfs_read_policy_name[i])) {
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
@@ -916,6 +964,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, checksum),
 	BTRFS_ATTR_PTR(, exclusive_operation),
 	BTRFS_ATTR_PTR(, generation),
+	BTRFS_ATTR_PTR(, read_policy),
 	NULL,
 };
 
-- 
2.25.1

