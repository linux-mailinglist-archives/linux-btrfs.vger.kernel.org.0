Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9123A1BC330
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgD1PWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 11:22:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42752 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgD1PWu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 11:22:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFHLAP141323;
        Tue, 28 Apr 2020 15:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=w0dCpJPjYQI7i8qami0ynesPnZqP4dcAFqJ4+H+AeSI=;
 b=sGLGg8p1rz7NGsiYvnme+X6lRQwSNdeZhhzGAtcInr+s7CnoA+tJAu6iyJChBzs4UtEu
 Ty5mUyGpj0q8FhSFJ2ZBaJlk/Dv0oJypsZbRy/EMwG4ivPu1P4KIVwZqo4vy3lXRHJhB
 4+6ko1xTUsULY3GgqsCR8j4GqFEmuVMuX2nrdC1JnsSfcr+VIO24Eu+R8XGGJlrOJ1WZ
 oe71vTkr/J4yuu2RHnvE5twjihYfl3cK9Fyf1dqjZSgo3/UvdpP4pcqAv7d6isVMgM9N
 +Y4CTOgGZ1S9+k1GsMWag96TBIhFQQte1LlkKX4FfQZj6J3DSyJJ+Cgds1ekpOIZxCTW JQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30p2p061f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:22:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFBtnP005500;
        Tue, 28 Apr 2020 15:22:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30mxx01k1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:22:42 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SFMffJ010232;
        Tue, 28 Apr 2020 15:22:42 GMT
Received: from localhost.localdomain (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:22:41 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com, josef@toxicpanda.com
Subject: [PATCH 3/3] btrfs: free alien device due to device add
Date:   Tue, 28 Apr 2020 23:22:27 +0800
Message-Id: <20200428152227.8331-4-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200428152227.8331-1-anand.jain@oracle.com>
References: <20200428152227.8331-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=3 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=3 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the old device has new fsid through btrfs device add -f <dev> our
fs_devices list has an alien device in one of the fs_devices. So this is
a trigger and not the root cause of the issue. This patch fixes the trigger.

By having an alien device in fs_devices, we have two issues so far

1. missing device is not shows as missing in the userland

Which is due to cracks in the function btrfs_open_one_device() and
hardened by the pending patches in the ml.
 btrfs: remove identified alien device in open_fs_devices
 btrfs: remove identified alien btrfs device in open_fs_devices

2. mount of a degraded fs_devices fails

Which is due to cracks in the function btrfs_free_extra_devids() and
hardened by patch (included in the set).
 btrfs: include non-missing as a qualifier for the latest_bdev

Now the trigger for both of this issue is that there is an alien (does not
contain the intended fsid/btrfs_magic) device in the fs_devices.

We know a device can be scanned/added through
btrfs-control::BTRFS_IOC_SCAN_DEV|BTRFS_IOC_DEVICES_READY
or by
ioctl::BTRFS_IOC_ADD_DEV

And device coming through btrfs-control is checked against the all other
devices in btrfs kernel but not coming through BTRFS_IOC_ADD_DEV.

This patch checks if the device add is alienating any other scanned
device and deletes it.

In fact, this patch fixes both the issues 1 and 2 (above) by eliminating
the trigger of the issue, but still they have their own patch as well
because its the right way to harden the functions and fill the cracks.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v3-rebased: change log updated.

 fs/btrfs/volumes.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a67af16d960d..300ee5f0bfa2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2665,6 +2665,19 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	/* Update ctime/mtime for libblkid */
 	update_dev_time(device_path);
+
+	/*
+	 * Now that we have written a new sb into this device, check all other
+	 * fs_devices list if it alienates any scanned device.
+	 */
+	mutex_lock(&uuid_mutex);
+	/*
+	 * Ignore the return as we are successfull in the core task - to added
+	 * the device
+	 */
+	btrfs_free_stale_devices(device_path, NULL);
+	mutex_unlock(&uuid_mutex);
+
 	return ret;
 
 error_sysfs:
-- 
2.23.0

