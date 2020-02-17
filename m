Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F86D1610C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 12:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgBQLNI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 06:13:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52510 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBQLNH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 06:13:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HB3nCl016652;
        Mon, 17 Feb 2020 11:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=cFFXCnj1TRI/srMbEsfjx/ptP6483/G2MBBt06FE14c=;
 b=mDStmlSwf3wqrf8M7C6l7t+sJw94r68ieo90DlUuyrCdvenLNjLvayKzhXjthamjZmCY
 S+bVh4dLM4+wpDLDU+CYZe4QWNgxgSKRtaZO9RrhXt3TgAcoT3IcQjg2gBmAI52ULEqI
 uDFM1oAkVKW/Db68OIz4Z1NFhnl5xZDEaclWoohO0pREnuWLs+LXA5rSI8qYgoUgAG1U
 EHHKKRK7eBA5lgBOBMGAKLDeXfHIHcg/QipAzeuzv0xKO8wKEgHQQGZz6PIpNLMx2uTI
 gmCeT5gf2Rv+GdVmvdC6I72oqK660HBJ4jh1aJ3+C8tzIkC8MBYvzgQIUZR5lcsp/7rK ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y699rfhfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 11:13:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HBC43V101911;
        Mon, 17 Feb 2020 11:13:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y6teheyfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 11:13:02 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01HBD1IL027548;
        Mon, 17 Feb 2020 11:13:01 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 03:13:01 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH v5 3/5] btrfs: create read policy sysfs attribute, pid
Date:   Mon, 17 Feb 2020 19:12:43 +0800
Message-Id: <1581937965-16569-4-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
References: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=1 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002170097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=1
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002170096
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v5:
  Title rename: old: btrfs: sysfs, add read_policy attribute
  Uses the btrfs_strmatch() helper (BTRFS_READ_POLICY_NAME_MAX dropped).
  Use the table for the policy names.
  Rename len to ret.
  Use a simple logic to prefix space in btrfs_read_policy_show()
 
v4:-
v3: rename [by_pid] to [pid]
v2: v2: check input len before strip and kstrdup

 fs/btrfs/sysfs.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
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
@@ -840,6 +888,7 @@ static int btrfs_strmatch(const char *given, const char *golden)
 	BTRFS_ATTR_PTR(, quota_override),
 	BTRFS_ATTR_PTR(, metadata_uuid),
 	BTRFS_ATTR_PTR(, checksum),
+	BTRFS_ATTR_PTR(, read_policy),
 	NULL,
 };
 
-- 
1.8.3.1

