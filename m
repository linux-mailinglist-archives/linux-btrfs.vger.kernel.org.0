Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45DBB19F52D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgDFLvm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 07:51:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40718 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgDFLvl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 07:51:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BmsVG027369
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=b8D3KCYlcHlSc8ubkZB8GxPYL1MW6t6EH36FG0m0ifM=;
 b=G/s2qAh+An6B5OvM0+iNFCGJopAMmRQvyol2fhxv9UuJMtXfvDRCcs6pJRQCUdoeRYmY
 ioAAIhvs//676tezxhzIaR69DyBacWQfn8SBlNVDjgh3KsPrvG5VtJB24t4/jLwFG+RA
 l9HSaRgzjtVYMtByYiR+CqdiAR9lqf02tvmpw573AjyoO0gc/mLWVM6/kqY6pT7k+f44
 R92QKmUoIbsU4mpHSU+n3kP7nJee03Ck6E5jkOwKpqFiXH4MvWCYPLu5RP+U3cYC4WGa
 thV0zjf4LFE/OTo/4e63rVDyLrAR1gv3ddA11d8RqgTTNFiu4my3jcqng8BGkjBEPMkY fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 306jvmx8f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 11:51:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BlEJo064751
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3073qcw523-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 11:51:40 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 036BpdnM009335
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:39 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 04:51:39 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 5/5] btrfs: introduce new read_policy device
Date:   Mon,  6 Apr 2020 19:51:11 +0800
Message-Id: <1586173871-5559-6-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=1
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060104
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Read-policy type 'device' and device flag 'read-preferred':

The read-policy type device picks the device(s) flagged as
read-preferred for reading chunks of type raid1, raid10,
raid1c3 and raid1c4.

As system might contain ssd, nvme, iscsi or san lun, and which are all
a non-rotational device its not a good idea to set the read-preferred
automatically. Instead device read-policy along with the read-preferred
flag provides an ability to do it manually. This advance tuning is
useful in more than one situation, like for example,
 - In heterogeneous-disk volume it provides an ability to choose the
   low latency disks for reading.
 - Useful for more accurate testing.
 - Avoid known problematic device from reading the chunk until it is
   replaced (by mark the good devices as read-preferred).

Note:

If the read-policy type is set to 'device', but there isn't any device
which is flagged as read-preferred, then stripe 0 is used for reading.

The device replace won't migrate the read-preferred flag to the new
replace target device.

As of now this is in-memory only feature.

Its point less to set the read-preferred flag on the missing device,
as IOs aren't submitted to the missing device.

If there are more than one read-preferred device in a chunk, the read IO
shall go to the stripe 0 (as of now, when qdepth patches are integrated
we will use the least busy device among the read-preferred devices).

Usage example:

Consider a typical two disks raid1.

Configure devid1 for reading.

$ echo 1 > devinfo/1/read_preferred
$ cat devinfo/1/read_preferred; cat devinfo/2/read_preferred
1
0

$ pwd
/sys/fs/btrfs/12345678-1234-1234-1234-123456789abc

$ cat read_policy; echo device > ./read_policy; cat read_policy
[pid] device
pid [device]

Now read IOs are sent to devid 1 (sdb).

$ echo 3 > /proc/sys/vm/drop_caches; md5sum /btrfs/YkZI

$ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
sdb              50.00     40048.00         0.00      40048          0

Change the read-preferred device from devid 1 to devid 2 (sdc).

$ echo 0 > ./devinfo/1/read_preferred; echo 1 > ./devinfo/2/read_preferred;

[ 3343.918658] BTRFS info (device sdb): reset read preferred on devid 1 (1334)
[ 3343.919876] BTRFS info (device sdb): set read preferred on devid 2 (1334)

Further read ios are sent to devid 2 (sdc).

$ echo 3 > /proc/sys/vm/drop_caches; md5sum /btrfs/YkZI

$ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
sdc              49.00     40048.00         0.00      40048          0

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v7: Change log updated.
v6:
. If there isn't read preferred device in the chunk don't reset
read policy to default, instead just use stripe 0. As this is in
the read path it avoids going through the device list to find
read preferred device. So inline to this drop to check if there
is read preferred device before setting read policy to device.
. Commit log updated. Adds more info about this new feature.
v5: born

 fs/btrfs/sysfs.c   |  3 ++-
 fs/btrfs/volumes.c | 24 ++++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 72daaedb7b04..af53ed879dd6 100644
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
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9dd7e3687463..5e53380e1d8d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5380,6 +5380,26 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
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
+	/* If there is no read preferred device then just use stripe 0 */
+	return 0;
+}
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct map_lookup *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5399,6 +5419,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 		num_stripes = map->num_stripes;
 
 	switch (fs_info->fs_devices->read_policy) {
+	case BTRFS_READ_POLICY_DEVICE:
+		preferred_mirror = btrfs_find_read_preferred(map, num_stripes);
+		preferred_mirror = first + preferred_mirror;
+		break;
 	default:
 		/*
 		 * Shouldn't happen, just warn and use pid instead of failing.
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 487a54c3140e..efa9635a4748 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -214,6 +214,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
  */
 enum btrfs_read_policy {
 	BTRFS_READ_POLICY_PID,
+	BTRFS_READ_POLICY_DEVICE,
 	BTRFS_NR_READ_POLICY,
 };
 
-- 
2.23.0

