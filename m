Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFBC25B81C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 03:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgICBA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 21:00:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40018 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgICBAY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 21:00:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08310NrY141575
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 01:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=+WVaYgRoxP0jt5qAyy/dn2WCTdvFIpE5A6qElxhGBCA=;
 b=jp2I9vdOFl+eOzf2YCZhqnpBZpUXxJgVDwMjwt2AD8+gfpkdOBfCjPytpYq53mJsOFZZ
 qYBeplkBdY+glssqexXlYxzbpyUrO+YkKY4iZ0PvnAah0vc4K7nRJg6n39SFilQkmiHR
 pxKLMKai9wZss/5OAIUW75IhU0zzNqqfqJEcaqE/H9vxDvGu9GeUFNCOhK5c698+z5SQ
 iTuvGFepBzb81pWTtMh8cO50m/chhbev9+qVu2EXJ+eF/SpdbI6CheY5SqwP+jIX3eks
 5jZC6JM0RrKbR2LyP0hKYyHnKCbrbNleTX7aQRpQodr8yPvN7T2IXxbjAGgbtk98kvGU TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eymdu70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 01:00:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830t6xM179484
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3380sv16d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0830wMmf020215
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:22 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:21 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/15] btrfs: btrfs_init_devices_late: use sprout device_list_mutex
Date:   Thu,  3 Sep 2020 08:57:45 +0800
Message-Id: <21d594f31a8d674a12af309ca051b0eedf973b1e.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030005
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
 fs/btrfs/volumes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9921b43ef839..7639a048c6cf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7184,16 +7184,14 @@ void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list)
 		device->fs_info = fs_info;
-	mutex_unlock(&fs_devices->device_list_mutex);
 
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
-		mutex_lock(&seed_devs->device_list_mutex);
 		list_for_each_entry(device, &seed_devs->devices, dev_list)
 			device->fs_info = fs_info;
-		mutex_unlock(&seed_devs->device_list_mutex);
 
 		seed_devs->fs_info = fs_info;
 	}
+	mutex_unlock(&fs_devices->device_list_mutex);
 }
 
 static u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
-- 
2.25.1

