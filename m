Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584A916436B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 12:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBSLbz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 06:31:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41402 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSLbz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 06:31:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBVJUo171562;
        Wed, 19 Feb 2020 11:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=iroMqUhxHcWSFu0Bvcvi0Ft28sxBT3waSRPPAU8or+Y=;
 b=Y+64INUocmZo2i64/FlTeqc4rehJu1H2nIHTWoKzvaRNVzqF6b4Lh8nkMKgzqbqJ0Dp9
 LXsj+vNyyvXYL8Z75tqxI7FZfozB0QiYv2OXRGb2CGy2ANAlp9BAlrc4w4Yc1xKqVJP+
 GzIi+nUIYyq2y5RaBy7iPT6CzXvjezwEeP+4waXmSOlnxXhTQh3/GrYA0KE5iUW3h0tt
 VYBUnKi+5cASzOv58cmnYI37vbWnWdiYuERZQ7zi7iCxlOIm8FoedKWSSjx6HHM7slfo
 vmcIyxuaSWU+OM56fGPujdQ9SU+r2wWPSMLpbJl7QqgcYpOPGhfhMdYCKGvfCcRXAWnE Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2y8udkac1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:31:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBRxNU052579;
        Wed, 19 Feb 2020 11:29:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2y8ud0xrun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:29:48 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JBTmJO006549;
        Wed, 19 Feb 2020 11:29:48 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 03:29:47 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.cz
Subject: [PATCH v6 5/5] btrfs: introduce new read_policy device
Date:   Wed, 19 Feb 2020 19:29:26 +0800
Message-Id: <1582111766-8372-6-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582111766-8372-1-git-send-email-anand.jain@oracle.com>
References: <1582111766-8372-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=1 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=1
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A new read policy 'device' is introduced with this patch, which when set
can pick only the device flagged as read_preferred for reading. This
tunable is for the advance users and the testers, which can make sure that
reads are read from the device they prefer for chunks of type raid1,
raid10, raid1c3 and raid1c4.

The default read policy is pid which can be changed to device as below.

$ pwd
/sys/fs/btrfs/12345678-1234-1234-1234-123456789abc

$ cat read_policy; echo device > ./read_policy; cat read_policy
[pid] device
pid [device]

One or more devices which are favored for reading should set the flag
read-preferred. In an example below a typical two disk raid1, devid1 is
configured as read preferred.

$ echo 1 > devinfo/1/read_preferred
$ cat devinfo/1/read_preferred; cat devinfo/2/read_preffered
1
0

So now when the file is read, the read IO would prefer device(s) with
read_preferred flags for reading.

$ echo 3 > /proc/sys/vm/drop_caches; md5sum /btrfs/YkZI

Since the devid 1 (sdb) is our read preferred device, the reads are set
to sdb only.
$ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
sdb              50.00     40048.00         0.00      40048          0

$ echo 0 > ./devinfo/1/read_preferred; echo 1 >
./devinfo/2/read_preferred;

[ 3343.918658] BTRFS info (device sdb): reset read preferred on devid 1
(1334)
[ 3343.919876] BTRFS info (device sdb): set read preferred on devid 2
(1334)

$ echo 3 > /proc/sys/vm/drop_caches; md5sum /btrfs/YkZI

Since now we changed the read preferred from devid 1 (sdb) to 2 (sdc),
now all the read IO goes to sdc.

$ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
sdc              49.00     40048.00         0.00      40048          0

Whenever there isn't any read preferred device(s) or if more than one
stripe is marked as read preferred device then this read policy shall
use the stripe 0 for reading.

The command
 $ echo pid > ./read_policy
goes back to the pid read policy type.

As of now this is in memory only feature which means after a unmount
mount cycle the configuration will be lost and has to be configured
again.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
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
index b6efb87bb0ae..43c09ec0bf86 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5341,6 +5341,26 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
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
@@ -5360,6 +5380,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
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

