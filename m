Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E312B2F0F51
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbhAKJmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 04:42:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59862 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbhAKJmm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 04:42:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9XegR004674;
        Mon, 11 Jan 2021 09:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=RDkL9EpZH4LbwuprYK0nHrT1bWYkIKXiAnAc0dAMpoQ=;
 b=we6rL8yi8Wt6zaxfHWUnf8YhbqDdKW2WEfxc9m6Vb0cQzwVSMLhcCqU+5pPrmmbSZ199
 DyzIMeNXpzVIIFKKN/VakuioeTBvEV0m2c4XyBqvcire9I6opFpCcbwzwuVcLZ4o6BU8
 CrSo39HSEq4cLbyWgDt2vjKvhZLAlalzfHVI8f9/qyhaY0dnLE14uRcrzwgOSnNNIw2K
 6f/MbsDzvg3SsIMugB5tvkBGTEHzATFfzYuvxBUWfZZ8egnZ4f5tzIAwKsxzu5fWDEts
 GviU7KZq5Lc0i8xrRsouN3PbeyS6VqBOT21AoViFwJSCZSRq1PiRvo5IkmngrWfJymss FA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kcyg9a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 09:41:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9VLoL107892;
        Mon, 11 Jan 2021 09:41:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 360ke4t0ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 09:41:57 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10B9fuxE010885;
        Mon, 11 Jan 2021 09:41:56 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 01:41:55 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 3/4] btrfs: introduce new read_policy device
Date:   Mon, 11 Jan 2021 17:41:36 +0800
Message-Id: <3c90d2b8e03dcd9ba9db00c4283a5e73f543a13f.1610324448.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610324448.git.anand.jain@oracle.com>
References: <cover.1610324448.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110057
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
---
v1:-
v2:-
v3: update the change log

 fs/btrfs/sysfs.c   |  3 ++-
 fs/btrfs/volumes.c | 22 ++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b5d6499fbad0..899b66c83db1 100644
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
index f7a0a83d2cd4..50d4d54f7abd 100644
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
2.30.0

