Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7211E25B80D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgICA60 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38884 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgICA6Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830tcQA125996
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=8VIBReliT6fRFTOu0YrPSLqc/59E8HQdE5cDVDgUKHs=;
 b=RfO6Gxy30LGgEclvcEGtSm6jBJkpt/ZvDXrXQn51RT5iDqXxf2dMjOFy4KMGsg9pFwxl
 HMUsrutF2Y63ERFgI7ZdMfCxW2njRG02160iLdElZGh/4lv7qYzrt9uVlCRI6lYbQxAZ
 MCtSK2dB2BAWvdhgwVYukCJg/SxWnL5F2XSlEoY8eIy/2q2KDjHgUMbFukZU2ZEIwIO3
 uFQtcmXP/GSP4/F5hLkGgjvBKSYcBjo8DUHfDzxyJ0X09HXAEDlkhVnBY546oeADnQ0A
 b8ctghqS0yMuosMmRsz94nfYYUUWwxxUyBHr4zzi4GEGHEw1pfXlQ3XMb041/NR7kkO5 yA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 337eymdu33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830sfb7036876
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3380x8anvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:20 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0830wKXT020211
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:20 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:19 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/15] btrfs: reada: use sprout device_list_mutex
Date:   Thu,  3 Sep 2020 08:57:44 +0800
Message-Id: <fd2815fb4f22a72234d4d0f52b170839a9c2e9df.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On an fs mounted using a sprout-device, the seed fs_devices are maintained
in a linked list under fs_info->fs_devices. Each seed's fs_devices also
have device_list_mutex initialized to protect against the potential race
with delete threads. But the delete thread (at btrfs_rm_device()) is holding
the fs_info::fs_devices::device_list_mutex mutex which is sprout's
device_list_mutex instead of seed's device_list_mutex. Moreover, there
aren't any significient benefits in using the seed::device_list_mutex
instead of sprout::device_list_mutex.

So this patch converts them of using the seed::device_list_mutex to
sprout::device_list_mutex.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/reada.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index e20972230823..9d4f5316a7e8 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -776,13 +776,11 @@ static int reada_start_for_fsdevs(struct btrfs_fs_devices *fs_devices)
 
 	do {
 		enqueued = 0;
-		mutex_lock(&fs_devices->device_list_mutex);
 		list_for_each_entry(device, &fs_devices->devices, dev_list) {
 			if (atomic_read(&device->reada_in_flight) <
 			    MAX_IN_FLIGHT)
 				enqueued += reada_start_machine_dev(device);
 		}
-		mutex_unlock(&fs_devices->device_list_mutex);
 		total += enqueued;
 	} while (enqueued && total < 10000);
 
@@ -795,10 +793,13 @@ static void __reada_start_machine(struct btrfs_fs_info *fs_info)
 	int i;
 	u64 enqueued = 0;
 
+	mutex_lock(&fs_devices->device_list_mutex);
+
 	enqueued += reada_start_for_fsdevs(fs_devices);
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list)
 		enqueued += reada_start_for_fsdevs(seed_devs);
 
+	mutex_unlock(&fs_devices->device_list_mutex);
 	if (enqueued == 0)
 		return;
 
-- 
2.25.1

