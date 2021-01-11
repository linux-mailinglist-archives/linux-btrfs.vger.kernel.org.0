Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009382F0F4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbhAKJmk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 04:42:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44664 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbhAKJmk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 04:42:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9XTLJ022561;
        Mon, 11 Jan 2021 09:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=VaGjP9TbEWu69VsECBi3QvkJhTVR91T36PO+qUPfczo=;
 b=V+DnlAdmF3I/5BAMaDcKsxyAiZTr106CUbZtSPL+dgwFuSYLAanRpP6aTdi9bbbTViWX
 f9viE3otgGGg2U1EbO0MD3fqDpNIW11FXHRq/j/unkBCB72m2tQbnSEjpABvsZn5xoc4
 c7Rco1jo9IkACiwsQV+AewFc5a6XfcEWaCc44x4ypEsK5ioLS7egYS8Z1ObTFnjXB6K1
 fKEQnBcm//STXd8AJQ+kdpa1QlAG2jKdDnO3c9AFeTh7u05ZvvzCX1wJESveOzEO57a2
 P7B9AE1TJ0KMhtArpOthN5CtviO9+qpaltmfNwu1GCLmeuh1kSnaZzWKv1+9WvhmnUf7 XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 360kg1g8hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 09:41:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9TpNH053725;
        Mon, 11 Jan 2021 09:41:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 360kew1pee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 09:41:54 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10B9frp1029387;
        Mon, 11 Jan 2021 09:41:53 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 01:41:53 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 2/4] btrfs: introduce new device-state read_preferred
Date:   Mon, 11 Jan 2021 17:41:35 +0800
Message-Id: <3f27d3da96accec05273a8ffc2a2d24554c78a1b.1610324448.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610324448.git.anand.jain@oracle.com>
References: <cover.1610324448.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a preparatory patch and introduces a new device flag
'read_preferred', RW-able using sysfs interface.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: C style fixes. Drop space in between '! test_bit' and extra lines
    after it.

 fs/btrfs/sysfs.c   | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  1 +
 2 files changed, 54 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 96ca7bef6357..b5d6499fbad0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1417,11 +1417,64 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
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
+	    !test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state)) {
+		set_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state);
+		btrfs_info(device->fs_devices->fs_info,
+			   "set read preferred on devid %llu (%d)",
+			   device->devid, task_pid_nr(current));
+	} else if (!val &&
+		   test_bit(BTRFS_DEV_STATE_READ_PREFERRED, &device->dev_state)) {
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
index 71ba1f0e93f4..ea786864b903 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -51,6 +51,7 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 #define BTRFS_DEV_STATE_NO_READA	(5)
+#define BTRFS_DEV_STATE_READ_PREFERRED	(6)
 
 struct btrfs_zoned_device_info;
 
-- 
2.30.0

