Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C330825E0EA
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgIDRfU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49950 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgIDRfS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HXi8P037358;
        Fri, 4 Sep 2020 17:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=8VIBReliT6fRFTOu0YrPSLqc/59E8HQdE5cDVDgUKHs=;
 b=t0UFl66CamrfgpiiZMYpPQVxaARSukglTGt8HwIl8f4bz/74plT5Nm9NkVuX1i8eSEk3
 hblEKQTBelKSHrQatirnkABeNluf4dTxkgTtKZB9X75Cv/K2XS1E1alYcrCnnX3mqqUN
 VX68nZYJ8dFcLj9MItazYWaJ9lzEXFojfsqIhlJxET+ndb9zbfLxMjoAdKSaVKr2CtrK
 CeZFLjbPJpT/EZYDkYtY29GV0ygdA4K1dTFUXgaQezMJRaBPlwMdJ2c8gTMF7w4c5yG5
 HAY4zZlGtYvonY+VciW2NajSSAldZGAfcIAyw3cQBdR+LZvGjUip3i+Tyyi1oxLNRewm Aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 339dmne39v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HUm6c090507;
        Fri, 4 Sep 2020 17:35:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3380xds70y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:11 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HZBh0015587;
        Fri, 4 Sep 2020 17:35:11 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:10 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 10/16] btrfs: reada: use sprout device_list_mutex
Date:   Sat,  5 Sep 2020 01:34:30 +0800
Message-Id: <8479e1e6b10b1235d3c685df82426a76ac0b3297.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040152
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

