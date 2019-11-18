Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7831000B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfKRIrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47930 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfKRIrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i4cW093613
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=/nDjPX4hZwrKij0QTicl8iyGUL4yhoc8M2n3sDI8Zic=;
 b=L84lV98FECR9/1+RvX3LJr4CUUCa8ZXnHulXHSoLfC9OQtLhzDbNVtYg6BRj8fujFhT8
 EDqcNf8Tvmm1u1FDjMPuMMoHxMeGruiTbjRi4nJwJzLhCPQkeZvU+RGChWOHAuoabNfn
 cj0hQt21P9loK8nW3qwd+dbGFOLhRS44GcfO6F5aOnvIXb82AV2VrOmQDRx/R9wb6IbY
 uvGtM5tEJQFobIvMXoQGnZCJjniVt5NL+Zn0+eRimTBFvFQwIqJHZ1NF3lwkwlqG4+xa
 TQeQvabgvTnPZ14bXQQTahEU44A5zJW7cGGTRQ3H8qA1JHDKCNNvAKKXFsSNYmVuVnGK MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wa92pekay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8hvKT021063
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wau8mtaw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAI8lTO6003264
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:30 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:28 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/15] btrfs: sysfs, cleanup btrfs_sysfs_remove_fsid()
Date:   Mon, 18 Nov 2019 16:46:54 +0800
Message-Id: <20191118084656.3089-14-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118084656.3089-1-anand.jain@oracle.com>
References: <20191118084656.3089-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_sysfs_remove_fsid() when called with NULL argument then it shall
cleanup all kobjects belonging to btrfs. However no function is using
btrfs_sysfs_remove_fsid() with NULL argument.

This happened in the commit 2e3e1281 (Btrfs: sysfs: provide framework to
remove all fsid sysfs kobject) which is a helper commit to the proposed
patch [1], which proposed to show /sys/fs/btrfs/UUID in the unmounted but
scanned context as well, so that there is a way to know fsid and devices which
are scanned. As of now there isn't anyway that the user/script can figure
out all the scanned fsids/devices in the system, but its been long time,
probably there isn't such a need at all. For developers to debug the
struct fs_devices list there is procfs boiler-plate patch in the mailing
list which comes handy.
 [1] [PATCH] btrfs: Introduce device pool sysfs attributes

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 2ea27c2d9ef1..34bf080ea530 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1087,20 +1087,9 @@ static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_info *fs_info)
 	}
 }
 
-/* when fs_info is NULL it will remove all fs_info::fsid kobject */
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_info *fs_info)
 {
-	struct list_head *fs_uuids = btrfs_get_fs_uuids();
-	struct btrfs_fs_devices *fs_devices;
-
-	if (fs_info) {
-		__btrfs_sysfs_remove_fsid(fs_info);
-		return;
-	}
-
-	list_for_each_entry(fs_devices, fs_uuids, fs_list) {
-		__btrfs_sysfs_remove_fsid(fs_devices->fs_info);
-	}
+	__btrfs_sysfs_remove_fsid(fs_info);
 }
 
 /*
-- 
2.23.0

