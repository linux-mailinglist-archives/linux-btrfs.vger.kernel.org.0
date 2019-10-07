Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F87CDE6F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfJGJpa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:45:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60046 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfJGJp3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 05:45:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cwHl022705
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=S5KxWtjDjZ7DtCoK3FT7D7HXXLW/68gaDJQL+SHzvFM=;
 b=CWDIzH5QqwPsD+iDWKgRGygiGkKNrgFNEvfVPLMd5Eu7DKPVdRSxlziCrQWxdbTzbvuM
 DEQELuKAkXuAALfFJqBsSioVretSb0J3Dm8BExO8JpFs2rBdh5IWgqUoXbv4oLgI1Yay
 M6kRLYeE2h51ndMkKBYcNOTyssDX+b0L3Don0f7mFFk1jsJokhMnjG32qEUVDnOBMQVc
 ZJOTIqa32Z8u4oFqpkiWL+QSolz7E9epFCbe+Flm8PJTcZx4QxFhFEUpEPWtjxS0TlXQ
 1s/t8L1CUr5r0eNlTu+CjMr4mNDDESOZ9bcINd6JiqKbT28eU+zANPI1f0tg6cjBu2Qo 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4q5nd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cT0N094041
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vf4ph7a4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:28 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x979jRd0004004
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:27 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 02:45:26 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: free alien device due to device add
Date:   Mon,  7 Oct 2019 17:45:15 +0800
Message-Id: <20191007094515.925-6-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007094515.925-1-anand.jain@oracle.com>
References: <20191007094515.925-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the old device has new fsid through btrfs device add -f <dev> our
fs_devices list has an alien device in one of the fs_devices.

By having an alien device in fs_devices, we have two issues so far

1. missing device is not shows as missing in the userland

Which is due to cracks in the function btrfs_open_one_device() and
hardened by patch
 btrfs: delete identified alien device in open_fs_devices

2. mount of a degraded fs_devices fails

Which is due to cracks in the function btrfs_free_extra_devids() and
hardened by patch
 btrfs: include non-missing as a qualifier for the latest_bdev

Now the reason for both of this issue is that there is an alien (does not
contain the intended fsid) device in the fs_devices.

We know a device can be scanned/added through
btrfs-control::BTRFS_IOC_SCAN_DEV|BTRFS_IOC_DEVICES_READY
or by
ioctl::BTRFS_IOC_ADD_DEV

And device coming through btrfs-control is checked against the all other
devices in btrfs kernel but not coming through BTRFS_IOC_ADD_DEV.

This patch checks if the device add is alienating any other scanned
device and deletes it.

In fact, this patch fixes both the issues 1 and 2 (above) by eliminating
the source of the issue, but still they have their own patch as well
because its the right way to harden the functions and fill the cracks.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 81097c80ac4a..4c7e37cd2166 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2534,6 +2534,19 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
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
1.8.3.1

