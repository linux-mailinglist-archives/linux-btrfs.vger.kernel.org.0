Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1340D2441D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHNAEF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:04:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33606 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHNAEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:04:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07E02vxo173497
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=NX/CzDOjvGWLwUFGIl0Dd4EHgiH6QFNLhTRxz+TOKwU=;
 b=WAmKQIChVQhSSGwUcBAAfYP4uka/kX9BmK2mc923qNyM0zuf93fP3brpBNmS+7iX8sNR
 nUSqz8cLbPhzaKSSuWFN3CbhQ4zsvz+vD/j2iube3XOrwDFtcxwjkegYYWN5pfoHB4bz
 Q97cyrt/LLW/Pd95t9XKQKAOufgOHnjADUU/WgsW/b8vxu0InMrZvI188X9kWDmrc6a/
 fzEf0DPtQcAaPEs63MvWj71U6eULTJP3egNQA4xbnpIpZsbIRKZw1SkfsN4NTsJYTY7o
 uJ11NREysMppOi4/s7BNDaBG3xxnU5LuxuCQQHpHvRpg/7XYIcJGG+M3/hAroUnsM8Yj 9g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32w73capmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DNwcG0046881
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32t6046av2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:03 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07E042nV030061
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:02 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 00:04:01 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: reada: use sprout device_list_mutex
Date:   Fri, 14 Aug 2020 08:03:46 +0800
Message-Id: <20200814000352.124179-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814000352.124179-1-anand.jain@oracle.com>
References: <20200814000352.124179-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 suspectscore=1 mlxscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
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
 fs/btrfs/reada.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 243a2e44526e..c4667410b3fa 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -775,22 +775,22 @@ static void __reada_start_machine(struct btrfs_fs_info *fs_info)
 	u64 total = 0;
 	int i;
 
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 again:
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
 	if (fs_devices->seed) {
 		fs_devices = fs_devices->seed;
 		goto again;
 	}
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 
 	if (enqueued == 0)
 		return;
-- 
2.18.2

