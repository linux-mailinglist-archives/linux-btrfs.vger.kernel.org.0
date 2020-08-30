Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1523E256EB3
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgH3OmP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:42:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58624 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgH3Olp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZclP032554;
        Sun, 30 Aug 2020 14:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=l6UxZSJvKECCmX54g1F8ML+I/XoOeJeWjh5WRTWa3iI=;
 b=KH45NPCM2ZmSnNCK0outcg2bifhHKTJ8RmjkK7HKOAqdNrZuHsC6ru0glNXnNuOosrXl
 I7w408XXku9252WPaIL4f8QUVXvbe7wKsxRHfszPSft31U8P0uw9FMN/wH+FM788dIA0
 s9pC8Im1Bc7RJfwrvo6AJb3+i0aHRfS63AsgWmonCoTdSn/aYahTjJsC9ucw3E4KAiXT
 Eb/+yhayvC78Rm5BZgH+vg1Ku4pD/idH58h4FL0XLMCdtHvQwByCXogl5In2C+OouErw
 i7nJE/N/h5jeaZzId+JMO6HjTDY1f9z1kruSku7wr3kt1xPNEUXpxsrjcmavfs02X5Tk CQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eeqk0qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZYI6153294;
        Sun, 30 Aug 2020 14:41:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3380xtr3w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07UEfRLs002592;
        Sun, 30 Aug 2020 14:41:27 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:26 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 04/11] btrfs: reada: use sprout device_list_mutex
Date:   Sun, 30 Aug 2020 22:40:59 +0800
Message-Id: <b5ad15e6583f4e61cfd44344ef17ea7a93f6bb57.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
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
---
 fs/btrfs/reada.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index c0035fc0ec67..9b54a51ba860 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -776,13 +776,11 @@ static int __reada_start_for_fsdevs(struct btrfs_fs_devices *fs_devices)
 
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
 	enqueued += __reada_start_for_fsdevs(fs_devices);
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list)
 		enqueued += __reada_start_for_fsdevs(seed_devs);
 
+	mutex_unlock(&fs_devices->device_list_mutex);
 	if (enqueued == 0)
 		return;
 
-- 
2.25.1

