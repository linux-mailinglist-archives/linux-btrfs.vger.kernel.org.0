Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB991610CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 12:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBQLNO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 06:13:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44724 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgBQLNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 06:13:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HBCimS065758;
        Mon, 17 Feb 2020 11:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=sfM4yRxQV+UarcXhYNPFqqnrjr6q3Vu93VaTwG4aaVU=;
 b=ACldi618mop91bDWRScoJmnT6Fh15VmNlpZCCeTc7JdP6wtundkQAg1c8vPdqzItG+S/
 ahckL1BHpUDQCtfvC1LKwI41VzL3OT0oxd1OSzqN/dcGDJTS5mmDzGF++DGD7hSfmMGX
 i2EHl9uMERle41XXVzUeiejYltoAFQVqWRFbjmqTVaX5mlISgTPWO5e+QzS/vyO0xijs
 S3UAxE+F6aCSqhYUqt1CDrnM+PxCrNuN6LV5V+S8FXNDZ3z8GFi+8s5cNj+z33aAwF7C
 hSYZSqqkDF9EkGiGrcYFxCBKikTJQ0NGZux+lxaxJu1NFR0/GaFT8bU9fm4uU7OrX4Mr Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y7aq5jspe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 11:13:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01HBC6Fm086622;
        Mon, 17 Feb 2020 11:13:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y6t6thm03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 11:13:08 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01HBD724007847;
        Mon, 17 Feb 2020 11:13:07 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 03:13:07 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com
Subject: [PATCH v5 5/5] btrfs: introduce new read_policy device
Date:   Mon, 17 Feb 2020 19:12:45 +0800
Message-Id: <1581937965-16569-6-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
References: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=1 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002170097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9533 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=1 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002170097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A new read policy 'device' is introduced with this patch, which when set
can pick the read_preferred device for reading. This tunable is for
advance users who knows what they are doing so that they have the
flexibility of making sure that reads are read from the device they
prefer.

For example:

$ cat /sys/fs/btrfs/UUID/read_policy
[pid] device

$echo 1 > /sys/fs/btrfs/UUID/devinfo/1/read_preferred

$echo device > /sys/fs/btrfs/UUID/read_policy

$cat /sys/fs/btrfs/UUID/read_policy
pid [device]

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v5: born

 fs/btrfs/sysfs.c   | 26 +++++++++++++++++++++++++-
 fs/btrfs/volumes.c | 36 ++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h |  1 +
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 638ce3f4abe3..e142a31c62e7 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -832,7 +832,8 @@ static int btrfs_strmatch(const char *given, const char *golden)
 	return -EINVAL;
 }
 
-static const char* const btrfs_read_policy_name[] = { "pid" };
+/* Must follow the order as in enum btrfs_read_policy */
+static const char* const btrfs_read_policy_name[] = { "pid", "device" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
@@ -857,6 +858,25 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 	return ret;
 }
 
+static bool btrfs_has_read_pref_device(struct btrfs_fs_devices *fs_devices)
+{
+	struct btrfs_device *device;
+
+	/*
+	 * rcu is good enough. If read preferred device is deleted by another
+	 * thread, the find_live_mirror will reset the policy to default.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
+		if (test_bit(BTRFS_DEV_STATE_READ_PREFERRED,
+			     &device->dev_state))
+			return true;
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
 static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 				       struct kobj_attribute *a,
 				       const char *buf, size_t len)
@@ -866,6 +886,10 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
 		if (btrfs_strmatch(buf, btrfs_read_policy_name[i]) == 0) {
+			if (i == BTRFS_READ_POLICY_DEVICE &&
+			    ! btrfs_has_read_pref_device(fs_devices))
+					return -EINVAL;
+
 			if (i != fs_devices->read_policy) {
 				fs_devices->read_policy = i;
 				btrfs_info(fs_devices->fs_info,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b6efb87bb0ae..53020699c6cc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5341,6 +5341,25 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	return ret;
 }
 
+static int btrfs_find_read_preferred(struct map_lookup *map, int num_stripe)
+{
+	int i;
+
+	/*
+	 * If there are more than one read preferred devices, then just pick the
+	 * first found read preferred device as of now. Once we have the Qdepth
+	 * based device selection, we could pick the least busy device among the
+	 * read preferred devices.
+	 */
+	for (i = 0; i < num_stripe; i++) {
+		if (test_bit(BTRFS_DEV_STATE_READ_PREFERRED,
+			     &map->stripes[i].dev->dev_state))
+			return i;
+        }
+
+	return -EINVAL;
+}
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct map_lookup *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5360,15 +5379,28 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 		num_stripes = map->num_stripes;
 
 	switch (fs_info->fs_devices->read_policy) {
+	case BTRFS_READ_POLICY_DEVICE:
+		preferred_mirror = btrfs_find_read_preferred(map, num_stripes);
+		if (preferred_mirror != -EINVAL) {
+			preferred_mirror = first + preferred_mirror;
+			break;
+		}
+		/* Reset the read_policy to the default */
+		fs_info->fs_devices->read_policy = BTRFS_READ_POLICY_PID;
+		btrfs_warn_rl(fs_info,
+		      "No read preferred device found, fallback to default");
+		/* Fall through if there isn't any read preferred device */
+	case BTRFS_READ_POLICY_PID:
+		preferred_mirror = first + current->pid % num_stripes;
+		break;
 	default:
 		/*
 		 * Shouldn't happen, just warn and use pid instead of failing.
 		 */
+		preferred_mirror = first + current->pid % num_stripes;
 		btrfs_warn_rl(fs_info,
 			      "unknown read_policy type %u, fallback to pid",
 			      fs_info->fs_devices->read_policy);
-	case BTRFS_READ_POLICY_PID:
-		preferred_mirror = first + current->pid % num_stripes;
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 07962a0ce898..9c3c6ba7aad5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -216,6 +216,7 @@ struct btrfs_device {
  */
 enum btrfs_read_policy {
 	BTRFS_READ_POLICY_PID,
+	BTRFS_READ_POLICY_DEVICE,
 	BTRFS_NR_READ_POLICY,
 };
 
-- 
1.8.3.1

