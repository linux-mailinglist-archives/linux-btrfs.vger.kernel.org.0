Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6BBCB57B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 09:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfJDHu0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 03:50:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48604 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfJDHuZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 03:50:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x947mw8x064696
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=UlEibvlL+hYxC4JkZ1O5aoY9yqFjOnJzgBn1idJdj1k=;
 b=sHUGt3UzdfgGTzT++V6KCmas93cWOi6evWNrEHc6f18OvEzfQ1oLN0ZA+4MWPguwgz3w
 aptkN8fENjzPdx6hBVAnFxdVjhoEwQqt5fgtRWd2/u92bZ1CTNB0qzZqCXqwvt8HAPR3
 QMNFJOayZaY9rLOJSPV9P+cg2R9QemydhWLDqtoF6DVipXqujnZEKam9ccT7VlaWm+4I
 9ysrkvMaj2ldYJzUQdJYAK2BQ0jp34AavZCU58PDgW5JrgNGKGTZsdGhf/m/UcfkTChD
 b8LEF0IjUDOgJE4qw0PweCIscJVtpdDT0Nq+oe31S+im5t1A77jxXzd9M1O3zb9tTpWp jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v9yfqshnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:50:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x947mJ8b006021
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vdxu89mad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:50:24 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x947oNJ6002979
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:23 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 00:50:22 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: free alien device due to device add
Date:   Fri,  4 Oct 2019 15:50:03 +0800
Message-Id: <1570175403-4073-5-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
References: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910040072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910040072
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
index 6c42048ec099..f8b21e82df2a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2736,6 +2736,19 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
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

