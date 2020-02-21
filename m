Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAFC166F98
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 07:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgBUGRw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 01:17:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgBUGRw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 01:17:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01L6EMGi188106
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 06:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=667cYBjl1Ex8+r7OzuZZfGNo9GXxKqYez6IrgT8bItY=;
 b=jpfUQO7Z7M6MQ4+x+vMZaiMHQd7lpRH7TGvaS48nY6olf+8/o+3EEAc7h41L30VwBEFr
 jGR7gUPUeIJy+RnErCZiHlCyu9tflqyZo+QqM9V5wray1lhociDiGgsdszcqmGxVzpzp
 O+0ors59YL2Z/tAb5gBpZr3YgieKx19GcAPagup6wzMhcpPikygwtbupq0bzfHNvpG0z
 SHhDCALBDvz5/4wqGAe6rypIN8kzljMzlouhPgVu2FhvMRsZ7OJ77wPbt3Wtl87+g63+
 5V8awC8mTmBF8HQbH8omLGpta+S9PNqfG4Pmj3+fe92rd4h54ePjqdEBHrzAZSMNPVpj aA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y8ud1emxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 06:17:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01L6COxK046917
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 06:15:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y8udefnd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 06:15:49 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01L6FmfR025669
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 06:15:48 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 22:15:48 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 4/5] btrfs: introduce new device-state read_preferred
Date:   Fri, 21 Feb 2020 14:15:37 +0800
Message-Id: <20200221061538.4508-5-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200221061538.4508-1-anand.jain@oracle.com>
References: <20200221061538.4508-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=1 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=1 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002210043
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

