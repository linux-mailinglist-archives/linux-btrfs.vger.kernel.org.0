Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3726E29D3AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 22:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgJ1Vns (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 17:43:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51352 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgJ1Vnn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDJ55A078304;
        Wed, 28 Oct 2020 13:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=A4j2LTHQYjpKYEz75qWBnYxlzDcqfgWUyWdQOGX2MkI=;
 b=Zpv6SEN5RyG+CLgO040kEIeGO6OV4AaMqQVpoptbM9YRHb0puqIFsdN0bQrwHy1wEFnc
 ay966txN5j4AEEwz1UFe+bCPT9dJK1zjPk+S8gjGSVZlflfXZMLT7cN+dddBX5xSXvMn
 fFA9vPYFmqT9mYhm7iBRNe2JLHSQS2KjWsw9CYUx1dGe5BKDrWw5cz2CSJOrtJdq6kt0
 AlFSGpw2+5S5KfV8H7D0TmdH721udoP6XzfjsY6T5crsjUOIMmeEG1xAG1peg7mP/VIy
 7pbbcvxDQX+EebW6nQptC+lULB8tk4X9Fj+sayXaX+6bpwO5SFHKtwd+aYF4BvmHhbbU qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34cc7kychu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 13:26:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDPMFZ031117;
        Wed, 28 Oct 2020 13:26:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34cx6x7t3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:26:31 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SDQUeS011709;
        Wed, 28 Oct 2020 13:26:30 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 06:26:30 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 3/4] btrfs: introduce new read_policy device
Date:   Wed, 28 Oct 2020 21:26:02 +0800
Message-Id: <858d5cb67f299fbdd7a8e7bfab66b426bbe54e0c.1603884539.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603884539.git.anand.jain@oracle.com>
References: <cover.1603884539.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280090
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Read-policy type 'device' and device flag 'read-preferred':

The read-policy type device picks the device(s) flagged as
read-preferred for reading chunks of type raid1, raid10,
raid1c3 and raid1c4.

A system might contain SSD, nvme, iscsi or san lun, and which are all
a non-rotational device, so it is not a good idea to set the read-preferred
automatically. Instead device read-policy along with the read-preferred
flag provides an ability to do it manually. This advance tuning is
useful in more than one situation, for example,
 - In heterogeneous-disk volume, it provides an ability to manually choose
    the low latency disks for reading.
 - Useful for more accurate testing.
 - Avoid known problematic device from reading the chunk until it is
   replaced (by marking the other good devices as read-preferred).

Note:

If the read-policy type is set to 'device', but there isn't any device
which is flagged as read-preferred, then stripe 0 is used for reading.

The device replace won't migrate the read-preferred flag to the new
replace the target device.

As of now, this is an in-memory only feature.

It's pointless to set the read-preferred flag on the missing device,
as IOs aren't submitted to the missing device.

If there is more than one read-preferred device in a chunk, the read IO
shall go to the stripe 0 (as of now, when depth patches are integrated
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
 fs/btrfs/sysfs.c   |  3 ++-
 fs/btrfs/volumes.c | 22 ++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 52b4c9bef673..d2a974e1a1c4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -907,7 +907,8 @@ static bool btrfs_strmatch(const char *given, const char *golden)
 }
 
 /* Must follow the order as in enum btrfs_read_policy */
-static const char * const btrfs_read_policy_name[] = { "pid", "latency" };
+static const char * const btrfs_read_policy_name[] = { "pid", "latency",
+						       "device" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 48587009b656..7ac675504051 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5502,6 +5502,25 @@ static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
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
+        }
+
+	/* If there is no read preferred device then just use the first stripe */
+	return first;
+}
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct map_lookup *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5536,6 +5555,9 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 		preferred_mirror = btrfs_find_best_stripe(fs_info, map, first,
 							  num_stripes);
 		break;
+	case BTRFS_READ_POLICY_DEVICE:
+		preferred_mirror = btrfs_find_read_preferred(map, first, num_stripes);
+		break;
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f1cbbb18f5ef..1448adb8993d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -219,6 +219,7 @@ enum btrfs_chunk_allocation_policy {
 enum btrfs_read_policy {
 	BTRFS_READ_POLICY_PID,
 	BTRFS_READ_POLICY_LATENCY,
+	BTRFS_READ_POLICY_DEVICE,
 	BTRFS_NR_READ_POLICY,
 };
 
-- 
2.25.1

