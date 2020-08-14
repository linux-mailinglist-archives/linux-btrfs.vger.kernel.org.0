Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A852441D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHNAEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:04:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32798 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHNAEG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:04:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07E02ZXi185044
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=68o2JJAaqGiOvOJVHOH/HDWr3K/vbYLM9suRrZh9amQ=;
 b=rFujD9f2Ntd0Z0/TuqNHMgJ4JkV2ZVJwMqRhOAXkwhzPKjyDRk/f0ho0KGf9Dw5Cclyj
 K5vIqSN9Xw1fQ6GMuWuhej2fCtz3klEDXJZPMZ+LLiZcLN2rmrjNEWttzKdWBOEIyDoM
 /6VuOq5GDV1SzeoPXgywQLuotKZEeKsYzZlzmoM852dSxJ5HxtDnvFDVgQ3+jjeb24/m
 PiX7e0UAASAsrLSf8M5aYMLgYldTppgqLq8KCZeNED9iebLgcMu/AS6dFFtim++4pESk
 3XtfXM0zldJxc7sPGKyh90LW0htKALxN19yc4H/ABBCqzjxpZKx4xXKbhnj+B0uUhBcb gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32t2ye1yd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DNvU64092069
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 32t5yb2gk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:04 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07E043tJ003094
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:03 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 00:04:03 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: btrfs_init_devices_late: use sprout device_list_mutex
Date:   Fri, 14 Aug 2020 08:03:47 +0800
Message-Id: <20200814000352.124179-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814000352.124179-1-anand.jain@oracle.com>
References: <20200814000352.124179-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=1 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=1 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In a mounted sprout FS, all threads now are using the
sprout::device_list_mutex, and this is the only piece of code using
the seed::device_list_mutex. This patch converts to use the sprouts
fs_info->fs_devices->device_list_mutex.

The same reasoning holds true here, that device delete is holding
the sprout::device_list_mutex.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ee96c5869f57..66691416ca8f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7181,14 +7181,14 @@ void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
 
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	while (fs_devices) {
-		mutex_lock(&fs_devices->device_list_mutex);
 		list_for_each_entry(device, &fs_devices->devices, dev_list)
 			device->fs_info = fs_info;
-		mutex_unlock(&fs_devices->device_list_mutex);
 
 		fs_devices = fs_devices->seed;
 	}
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 }
 
 static u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
-- 
2.18.2

