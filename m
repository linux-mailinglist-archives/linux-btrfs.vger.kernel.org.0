Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A111C3763
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 12:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEDK6x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 06:58:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52748 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgEDK6x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 May 2020 06:58:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044AvdfG042882
        for <linux-btrfs@vger.kernel.org>; Mon, 4 May 2020 10:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=c1KtcoMlsTGaTPpm2/1VJX530+arEWtG2zIU+EwBEHI=;
 b=Ium6GaOLEKYfVGqRvz5ZT+ZgOgCunFHkvPuFi/WakQOVyR5YrkZ52re36AEkCUJiLKpo
 2wQVbrmWv8we3gH0mL6YL84BFwpdXGH+Wu7MjWqWf6/IfSEp6fRgzVuPLrss2BvcTLR7
 e2/49dHmswNwkROxuZKWaPNLdkENs8n9Apsb8stVfMK3ud5yp1YhWS3gn63nfsQXfPGl
 7OkJs1rPJ28Dcxs4FHxE7bUHxFKJ5CgHpN2K+A7T7yxtLsA1ejUMBirIrPMmcN5R4keP
 1Ovohm50yevF43Bz1vaQci2o/uysUqi6l4zvk+ac6B3YlwgDvfN6Xwqnrs4TSZp3x2in Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30s1gmwypv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 10:58:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Aue9X008515
        for <linux-btrfs@vger.kernel.org>; Mon, 4 May 2020 10:58:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30sjdqa6f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 10:58:50 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044Awois006448
        for <linux-btrfs@vger.kernel.org>; Mon, 4 May 2020 10:58:50 GMT
Received: from localhost.localdomain (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 03:58:49 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 3/3] btrfs: free alien device due to device add
Date:   Tue,  5 May 2020 02:58:26 +0800
Message-Id: <20200504185826.9954-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200428152227.8331-4-anand.jain@oracle.com>
References: <20200428152227.8331-4-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=3 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040094
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

The trigger for both of this issue is that there is an alien (does not
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
v4: use the helper btrfs_forget_devices().

 fs/btrfs/volumes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f93739afe681..8e6f110b375d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2664,6 +2664,15 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	/* Update ctime/mtime for libblkid */
 	update_dev_time(device_path);
+
+	/*
+	 * Now that we have written a new sb into this device, check all other
+	 * fs_devices list if device_path alienates any other scanned device.
+	 * Ignore the return as we are successfull in the core task - add
+	 * the device.
+	 */
+	btrfs_forget_devices(device_path);
+
 	return ret;
 
 error_sysfs:
-- 
2.25.1

