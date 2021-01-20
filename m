Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9DB2FCC21
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 08:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbhATHys (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 02:54:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59546 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbhATHxW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 02:53:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K7oEJW163359;
        Wed, 20 Jan 2021 07:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=887Vbwhm+l8xNebwBNlrCEzwQMlkYzZS39Ff8VN9p8c=;
 b=ZwM0hXv0Djw+HOMt1by+aMaTkjwyTWDyRN8Yp3fGtZD7pdC4WY+OiwSub6gGhssp9DmD
 VMFLanzgQW7lLE9aw6lyDv6QQtTalNmfg+CWeTS+N7bGjX754QglznPM1n+Tan8x9sU1
 RmSrrdGyRqtX8Kx1TFSVwCLFrRLiU0jOcZZn5N+fSiyhGFj8xvHNHfvLg6554BrhUBWu
 cUjmWanxaal1QGxlS2/9xVvvBTqlde1iMJgCtIunQs2GbkJNGJkX3CsIMk00maiLqkiw
 ojaXvBeI6mu9FoQbf6dLM7+9lqhN6Wze7quaMhtOq0fuuvsx0zO20qJz1/qgSxAyEWix mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3668qms503-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 07:52:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K7ocHf122865;
        Wed, 20 Jan 2021 07:52:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3668qvnkkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 07:52:16 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10K7qFSE010050;
        Wed, 20 Jan 2021 07:52:15 GMT
Received: from ca-dev104.us.oracle.com (/10.129.135.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 23:52:15 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH v4 3/3] btrfs: introduce new read_policy device
Date:   Tue, 19 Jan 2021 23:52:07 -0800
Message-Id: <227061e4c1d8c5a9465f6bd1ab15873a64de1c4f.1611114341.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611114341.git.anand.jain@oracle.com>
References: <cover.1611114341.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200043
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Read-policy type 'device' and device flag 'read-preferred':

The read-policy type device picks the device(s) flagged as
read-preferred for reading stripes of type raid1, raid10,
raid1c3 and raid1c4.

A system might contain SSD, nvme, iscsi, or san lun, and which are all
a non-rotational device, so it is not a good idea to set the read-preferred
automatically. Instead, device read-policy along with the read-preferred
flag provides an ability to do it manually. This advanced tuning is useful
in more than one situation, for example,
 - In heterogeneous-disk volume, it provides an ability to manually choose
    the low latency disks for reading.
 - Useful for more accurate testing.
 - Avoid known problematic device from reading the chunk until it is
   replaced (by marking the other good devices as read-preferred).

Note:

If the read-policy type is set to 'device', but there isn't any device
which is flagged as read-preferred, then stripe 0 is used for reading.

The device replacement won't migrate the read-preferred flag to the new
replace the target device.

As of now, this is an in-memory only feature.

It's pointless to set the read-preferred flag on the missing device, as
IOs aren't submitted to the missing device.

If there is more than one read-preferred device in a chunk, the read IO
shall go to the stripe 0 as of now.

Usage example:

Consider a typical two disks raid1.

Configure devid1 for reading.

$ echo 1 > devinfo/1/read_preferred
$ cat devinfo/1/read_preferred
1
$ cat devinfo/2/read_preferred
0

$ pwd
/sys/fs/btrfs/12345678-1234-1234-1234-123456789abc

$ cat read_policy
[pid] device
$ echo device > ./read_policy
$ cat read_policy
pid [device]

Now read IOs are sent to devid 1 (sdb).

$ echo 3 > /proc/sys/vm/drop_caches
$ md5sum /btrfs/YkZI

$ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
sdb              50.00     40048.00         0.00      40048          0

Change the read-preferred device from devid 1 to devid 2 (sdc).

$ echo 0 > ./devinfo/1/read_preferred

[ 3343.918658] BTRFS info (device sdb): reset read preferred on devid 1 (1334)

$ echo 1 > ./devinfo/2/read_preferred

[ 3343.919876] BTRFS info (device sdb): set read preferred on devid 2 (1334)

$ echo 3 > /proc/sys/vm/drop_caches
$ md5sum /btrfs/YkZI

Further read ios are sent to devid 2 (sdc).

$ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
sdc              49.00     40048.00         0.00      40048          0

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v4: add Josef rb.
v3: update the change log.
v2: -
rfc->v1: -

 fs/btrfs/sysfs.c   |  3 ++-
 fs/btrfs/volumes.c | 22 ++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5888e15e3d14..dd1835a2a7ab 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -916,7 +916,8 @@ static bool strmatch(const char *buffer, const char *string)
 }
 
 /* Must follow the order as in enum btrfs_read_policy */
-static const char * const btrfs_read_policy_name[] = { "pid", "latency" };
+static const char * const btrfs_read_policy_name[] = { "pid", "latency",
+						       "device" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f361f1c87eb6..d942260f8d2c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5524,6 +5524,25 @@ static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
 	return best_stripe;
 }
 
+static int btrfs_find_read_preferred(struct map_lookup *map, int first, int num_stripe)
+{
+	int stripe_index;
+	int last = first + num_stripe;
+
+	/*
+	 * If there are more than one read preferred devices, then just pick the
+	 * first found read preferred device as of now.
+	 */
+	for (stripe_index = first; stripe_index < last; stripe_index++) {
+		if (test_bit(BTRFS_DEV_STATE_READ_PREFERRED,
+			     &map->stripes[stripe_index].dev->dev_state))
+			return stripe_index;
+	}
+
+	/* If there is no read preferred device then just use the first stripe */
+	return first;
+}
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct map_lookup *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5557,6 +5576,9 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 		preferred_mirror = btrfs_find_best_stripe(fs_info, map, first,
 							  num_stripes);
 		break;
+	case BTRFS_READ_POLICY_DEVICE:
+		preferred_mirror = btrfs_find_read_preferred(map, first, num_stripes);
+		break;
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index ea786864b903..8d5a2cddc0ab 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -225,6 +225,8 @@ enum btrfs_read_policy {
 	BTRFS_READ_POLICY_PID,
 	/* Find and use device with the lowest latency */
 	BTRFS_READ_POLICY_LATENCY,
+	/* Use the device marked with READ_PREFERRED state */
+	BTRFS_READ_POLICY_DEVICE,
 	BTRFS_NR_READ_POLICY,
 };
 
-- 
2.28.0

