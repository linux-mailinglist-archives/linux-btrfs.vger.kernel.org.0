Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3226256EBA
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgH3Omi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:42:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59158 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgH3Olp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZ5gm087948;
        Sun, 30 Aug 2020 14:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=+WVaYgRoxP0jt5qAyy/dn2WCTdvFIpE5A6qElxhGBCA=;
 b=0hCfeKsVqFGaHgV3U9ux6Jt57c89x8GILMqvyaWUa0jilw9vzVL9Fr3vEz74O+RcOFWw
 08su3LEgMDa5Yw7HA8J7Vqo10X3s6Z0b3q2Ol/8FfMEyMtcFNGqCpTYvZ370GQDjMXOp
 87HrQc+82YEuRMZ9mxH93l03JPK/fhIdO1pC0q54CuJZ0O2S+sl1K+v14qYBWo9/U9i1
 /SNHmJqx9ObQ5m/65eoMiDRqbrv1WFLwoJHrSL05sT/VPpkz0TESDcjew3xshoTMsvRL
 oXEIQPsDZ7oKTH+DTDe48GC9W/SqacQPSmHnOje6G57fxteWaoDXOyZi4ZKHDBFmLjyZ 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 337eyktyck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZl9x153801;
        Sun, 30 Aug 2020 14:41:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3380xtr3wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07UEfTLO024912;
        Sun, 30 Aug 2020 14:41:29 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:28 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 05/11] btrfs: btrfs_init_devices_late: use sprout device_list_mutex
Date:   Sun, 30 Aug 2020 22:41:00 +0800
Message-Id: <f9d69d94feeab53df416837d5e8bcc85da4df394.1598792561.git.anand.jain@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
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

