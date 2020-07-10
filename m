Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A20921AF89
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 08:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGJGhv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 02:37:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41356 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgGJGhu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 02:37:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06A6ae2m132807
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 06:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=C68xlbqzsLFzYd/PeqmquhpFSRR5Jtax4xpKXNU1PKg=;
 b=zdmNf6xXFrYbcoTZDP3bWaX7FnNVjjo0lx+vq+JRzVCaHyHs049pjmUfFPa4OcOR1C8m
 zC0tczCkCy9tv55iNOudGu7UiSDpSjjsf/J6UG+upVpgB6MTu7ELfZRaELKxQPJ+Kh1L
 HGRfuVIh3G7BpnwmLzzL9HUEe6fzSwptVmRERMwvVpKczN0t0bKlrIqMGj6JxtZQAw+S
 MTEnUCP926A6gIYbt5UoMNwrrjpNjUX9JzqnbaAMs+wMW3UD5BO2zu+c0PCDjHfTMXdK
 ukR+ThKD4KfPq9xCJsLva7cq1flkNTPwJzQMXz9B8Ct1ngE8ADLSt2l8l4D19navAqxq TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 325y0ank6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 06:37:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06A6INC1140868
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 06:37:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 325k41t87g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 06:37:47 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06A6blT2023371
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 06:37:47 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 23:37:46 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs_show_devname don't traverse into the seed fsid
Date:   Fri, 10 Jul 2020 14:37:38 +0800
Message-Id: <20200710063738.28368-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9677 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=1
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100043
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

->show_devname currently shows the lowest devid in the list. As the seed
devices have the lowest devid in the sprouted filesystem, the userland
tool such as findmnt end up seeing seed device instead of the device from
the read-writable sprouted filesystem. As shown below.

 mount /dev/sda /btrfs
 mount: /btrfs: WARNING: device write-protected, mounted read-only.

 findmnt --output SOURCE,TARGET,UUID /btrfs
 SOURCE   TARGET UUID
 /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111

 btrfs dev add -f /dev/sdb /btrfs

 umount /btrfs
 mount /dev/sdb /btrfs

 findmnt --output SOURCE,TARGET,UUID /btrfs
 SOURCE   TARGET UUID
 /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111


All sprouts from a single seed will show the same seed device and the
same fsid. That's messy.
This is causing problems in our prototype as there isn't any reference
to the sprout file-system(s) which is being used for actual read and
write.

This was added in the patch which implemented the show_devname in btrfs
commit 9c5085c14798 (Btrfs: implement ->show_devname).
I tried to look for any particular reason that we need to show the seed
device, there isn't any.

So instead, do not traverse through the seed devices, just show the
lowest devid in the sprouted fsid.

After the patch:

 mount /dev/sda /btrfs
 mount: /btrfs: WARNING: device write-protected, mounted read-only.

 findmnt --output SOURCE,TARGET,UUID /btrfs
 SOURCE   TARGET UUID
 /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111

 btrfs dev add -f /dev/sdb /btrfs
 mount -o rw,remount /dev/sdb /btrfs

 findmnt --output SOURCE,TARGET,UUID /btrfs
 SOURCE   TARGET UUID
 /dev/sdb /btrfs 595ca0e6-b82e-46b5-b9e2-c72a6928be48

 mount /dev/sda /btrfs1
 mount: /btrfs1: WARNING: device write-protected, mounted read-only.

 btrfs dev add -f /dev/sdc /btrfs1

 findmnt --output SOURCE,TARGET,UUID /btrfs1
 SOURCE   TARGET  UUID
 /dev/sdc /btrfs1 ca1dbb7a-8446-4f95-853c-a20f3f82bdbb

 cat /proc/self/mounts | grep btrfs
 /dev/sdb /btrfs btrfs rw,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0
 /dev/sdc /btrfs1 btrfs ro,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
This has passed the xfstests/btrfs sucessfully with no new
regressions. Thanks.

 fs/btrfs/super.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c7ee119cffa1..1e2a36f5c792 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2377,9 +2377,7 @@ static int btrfs_unfreeze(struct super_block *sb)
 static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
-	struct btrfs_fs_devices *cur_devices;
 	struct btrfs_device *dev, *first_dev = NULL;
-	struct list_head *head;
 
 	/*
 	 * Lightweight locking of the devices. We should not need
@@ -2389,18 +2387,13 @@ static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
 	 * least until the rcu_read_unlock.
 	 */
 	rcu_read_lock();
-	cur_devices = fs_info->fs_devices;
-	while (cur_devices) {
-		head = &cur_devices->devices;
-		list_for_each_entry_rcu(dev, head, dev_list) {
-			if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
-				continue;
-			if (!dev->name)
-				continue;
-			if (!first_dev || dev->devid < first_dev->devid)
-				first_dev = dev;
-		}
-		cur_devices = cur_devices->seed;
+	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
+		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
+			continue;
+		if (!dev->name)
+			continue;
+		if (!first_dev || dev->devid < first_dev->devid)
+			first_dev = dev;
 	}
 
 	if (first_dev)
-- 
2.25.1

