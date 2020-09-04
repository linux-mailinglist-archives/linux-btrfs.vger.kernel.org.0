Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7216B25E0EB
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgIDRfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60400 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgIDRfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HZ2Ph140981;
        Fri, 4 Sep 2020 17:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=faSvXwgH4cv8VS/4iDiVY9ZyEVQIwj6npFU+0q814Tg=;
 b=F/LyvcinZNDH+3GXJ8YLhe6ftTVizyGaz7WenBvcTw04cblGXpi9OztGOwpOpfxogJuQ
 mzUgqoHDgc/FJFIODQZx7pc3QgS+J+CZj6pO17Py4k1SaYTLCDkpCYIfjZ+2FTNH64tb
 Rhzp50ay3ie5F2NbssIHAW3FMHuYWjS7LgbjqA5tqh3cLjPHy8QUfQn+WohCt0ngl+Hx
 dQNm7yn9WXRQYFfLES7m4+KyACE1mLuS8zLO52ZWRy0bfP3+Vo/onndW2CAb7SIeG+DR
 SHmaxwvBjSZqpzUCzBufdQWb+kFy8Ff2q7/uZOpcWLrrLuulXRgz3jynGsBfTspI2IiA EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eerfr9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HVDxW171601;
        Fri, 4 Sep 2020 17:35:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33bhs4tc93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:14 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HZDgd015603;
        Fri, 4 Sep 2020 17:35:13 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:12 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 11/16] btrfs: btrfs_init_devices_late: use sprout device_list_mutex
Date:   Sat,  5 Sep 2020 01:34:31 +0800
Message-Id: <b4caf07e34e14e9d97146c2df1ec02e3761a890f.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
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
index afdde29bce34..f70b79eaa76d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7193,16 +7193,14 @@ void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
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

