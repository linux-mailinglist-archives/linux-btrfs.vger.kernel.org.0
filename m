Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BFB19F52C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 13:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgDFLvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 07:51:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40696 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgDFLvj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 07:51:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BmsVE027369
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=667cYBjl1Ex8+r7OzuZZfGNo9GXxKqYez6IrgT8bItY=;
 b=gyvKjkoRPUShGzml12mfegD3Stij0dmvp6fgAeANEKTMtSkR2gxFNuT/NVC253ymh0Ai
 5mOC2OsxrGL/XaKUfbd3if6nA6akRNyMVVO6Kh7OunOSRiM7cUZilWu4lHG8BsWEXvA3
 oLk0+09lcqeMzrRQyA3ytJtgiBGPQRpHRbi2gC/UkBlr80lRScM4P8t5HuVW+CUsLKkX
 VjCV0Gn9T9q0dVkd2dOWwg09LBx00ynr9I+tSo3fGAw/dr0YC89dLk55XZ871rgaPBUe
 jkt1MYQAvgbWAGDBU4HLeRX1DoZzT1QG2IaV05RLHhRGJfjzCGx3YEQvru5rrdytEEkS Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 306jvmx8ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 11:51:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036BlOvq044059
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30741a96qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 11:51:38 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036Bpb5R025445
        for <linux-btrfs@vger.kernel.org>; Mon, 6 Apr 2020 11:51:37 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 04:51:37 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 4/5] btrfs: introduce new device-state read_preferred
Date:   Mon,  6 Apr 2020 19:51:10 +0800
Message-Id: <1586173871-5559-5-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=1
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060104
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a preparatory patch and introduces a new device flag
'read_preferred', and is a generic flag which along with the read_policy
'device' in the following patch the user can route the read IO to the
device of choice.

This also provides a sysfs interface to set the device state as
read_preferred.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v7: Change log updated.
v6: If there is no change in device's read prefer then don't log. 
    Add pid to the logs.
v5: born

 fs/btrfs/sysfs.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++++
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
index 1775d35706ab..487a54c3140e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -50,6 +50,7 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_MISSING		(2)
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
+#define BTRFS_DEV_STATE_READ_PREFERRED	(5)
 
 struct btrfs_device {
 	struct list_head dev_list; /* device_list_mutex */
-- 
2.23.0

