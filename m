Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5721825E0E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgIDRfR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgIDRfO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HXiD2037345;
        Fri, 4 Sep 2020 17:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=WVnZnlfZyuMpdtzoxHcjv2xYP6PqPxHJHaCXP/uIwCw=;
 b=0Q+ejECf3SpMs2MvaVK9QaFEYDptGJAS43G65Cxc+dMotI0vRUiV0jN4Sda062/A2JTJ
 81AWH4NYeK+ohDVTp0BdRTptcmAnMgJ4R1TaC4QACyaa1NdAWu4KONt0eXWS0xyypF0O
 r+hDN/cm0gUpdS5C+z58Ey/pRo2TPVuwlxQCPx1ItRtUkQBHzTDn0LZX41qkmJ9ofvdZ
 lndtwqNmHs81OlJaGhIR6W3ommWmG+ucxkhBt0ioXiVcapb8RbIAFHjLeWDeF55cy9/1
 T2uyCFtKnOH0Yxc/wT0KpDHp8Z2yKx3bsi9WbvJWS+qs6UmxDAnx8L3UHtSYLD/qkdR+ Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 339dmne39k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HTrsY187012;
        Fri, 4 Sep 2020 17:35:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33b7v30ub8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:09 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HZ8ZR008877;
        Fri, 4 Sep 2020 17:35:08 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:08 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 09/16] btrfs: handle fail path for btrfs_sysfs_add_fs_devices
Date:   Sat,  5 Sep 2020 01:34:29 +0800
Message-Id: <286835580c7b761d249702ee01f0922f7ae07362.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=1 adultscore=0
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

btrfs_sysfs_add_fs_devices() is called by btrfs_sysfs_add_mounted().
btrfs_sysfs_add_mounted() assumes that btrfs_sysfs_add_fs_devices() will
either add sysfs entries for all the devices or none. So this patch keeps up
to its caller expecatation and cleans up the created sysfs entries if it
has to fail at some device in the list.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
v3: fix the goto fail
 fs/btrfs/sysfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5b81bb60c86e..71c3a98b799f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1326,18 +1326,22 @@ int btrfs_sysfs_add_fs_devices(struct btrfs_fs_devices *fs_devices)
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		ret = btrfs_sysfs_add_device(device);
 		if (ret)
-			return ret;
+			goto fail;
 	}
 
 	list_for_each_entry(seed, &fs_devices->seed_list, seed_list) {
 		list_for_each_entry(device, &seed->devices, dev_list) {
 			ret = btrfs_sysfs_add_device(device);
 			if (ret)
-				return ret;
+				goto fail;
 		}
 	}
 
 	return 0;
+
+fail:
+	btrfs_sysfs_remove_fs_devices(fs_devices);
+	return ret;
 }
 
 void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
-- 
2.25.1

