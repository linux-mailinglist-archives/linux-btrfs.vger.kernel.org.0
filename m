Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D50164361
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 12:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgBSL3v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 06:29:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54354 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgBSL3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 06:29:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBSHFe130093;
        Wed, 19 Feb 2020 11:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=i0SBPItGaL02zBwid9Gbt6POtjvCioOE6E+MFKzYoPA=;
 b=MCl9DquRYhOFoKuZ++qqTR/EDUGp7n3HzQ5lNZK/ZiMsnRnArP4+wBP5E5GUxrfWeyiK
 BFBfuQITVzEevp+BLmsXcNs67qEYlqYzaa3ll2Uzgwhy9MVoYYQikCpglry5ZTtoGK3g
 ZINa9nsPL8T1IZAxj/aRgt6L/z7mPpdXuNPdyTCMCacNWXKkmfYRn7LDw5Oal6wJaRz+
 QhvO48XYY10L7zB0rp0ZWtKbLszB6HAkdbkAso7LAMfbgUrOmnY8CfsmG1DdtRdmUz0X
 iuVo5IEY6fKU7eus5M19Hhtw49PWBW09nsU6Fn6TlsO6kGfnDliFzw/zPS0VM6NM8fvW IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y8ud12c74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:29:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JBRiE7051480;
        Wed, 19 Feb 2020 11:29:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2y8ud0xrrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 11:29:46 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JBTjmd027315;
        Wed, 19 Feb 2020 11:29:46 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 03:29:45 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.cz
Subject: [PATCH v6 4/5] btrfs: introduce new device-state read_preferred
Date:   Wed, 19 Feb 2020 19:29:25 +0800
Message-Id: <1582111766-8372-5-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582111766-8372-1-git-send-email-anand.jain@oracle.com>
References: <1582111766-8372-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=1 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=1 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Provides a sysfs interface to set the device state as read_preferred.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v6: If there is no change in device's read prefer then don't log.
    Add pid to the logs.
v5: born

 fs/btrfs/sysfs.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c9a8850b186a..72daaedb7b04 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1317,11 +1317,66 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
 
+static ssize_t btrfs_devinfo_read_pref_show(struct kobject *kobj,
+					    struct kobj_attribute *a, char *buf)
+{
+	int val;
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	val = !!test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t btrfs_devinfo_read_pref_store(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     const char *buf, size_t len)
+{
+	int ret;
+	unsigned long val;
+	struct btrfs_device *device;
+
+	ret = kstrtoul(skip_spaces(buf), 0, &val);
+	if (ret)
+		return ret;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	/*
+	 * lock is not required, the btrfs_device struct can't be freed while
+	 * its kobject btrfs_device::devid_kobj is still open.
+	 */
+	device = container_of(kobj, struct btrfs_device, devid_kobj);
+
+	if (val &&
+	    ! test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state)) {
+
+		set_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
+		btrfs_info(device->fs_devices->fs_info,
+			   "set read preferred on devid %llu (%d)",
+			   device->devid, task_pid_nr(current));
+	} else if (!val &&
+		   test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state)) {
+
+		clear_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
+		btrfs_info(device->fs_devices->fs_info,
+			   "reset read preferred on devid %llu (%d)",
+			   device->devid, task_pid_nr(current));
+	}
+
+	return len;
+}
+BTRFS_ATTR_RW(devid, read_preferred, btrfs_devinfo_read_pref_show,
+	      btrfs_devinfo_read_pref_store);
+
 static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, in_fs_metadata),
 	BTRFS_ATTR_PTR(devid, missing),
 	BTRFS_ATTR_PTR(devid, replace_target),
 	BTRFS_ATTR_PTR(devid, writeable),
+	BTRFS_ATTR_PTR(devid, read_preferred),
 	NULL
 };
 ATTRIBUTE_GROUPS(devid);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index ed2bba741b6e..07962a0ce898 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -52,6 +52,7 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_MISSING		(2)
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
+#define BTRFS_DEV_STATE_READ_PREFERRED	(5)
 
 struct btrfs_device {
 	struct list_head dev_list; /* device_list_mutex */
-- 
1.8.3.1

