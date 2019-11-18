Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9BB1000B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfKRIrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48450 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfKRIrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:33 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iGUv105447
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=lhGzhJpKFiMGH1TtdpqMX4b0d8tZVYlYleese42ssG0=;
 b=R39ldsz+u7dO45TgVTJTUiYE+pVe05ieP5On1u9kN9H8tX2lRkj575uEQaIUeIPFL9e/
 0Vkq000XvkzXC92EdyJHDjVlF1N7XKZhArf/GJZpkfn7EBT1ZfKbYlKScKA/4pcAgJOL
 p2tAylNPqZibE3FBN3Uy6C4kzEEY/j6M/NonkOmYQukpjGZC0LY8NnUP4OE0EYM5Z7eg
 JwfDMwEnUjg45j0q62GnGiTNpRhKgPiHZdMq3kuEGjxhCENdriV1cbdH6Ri/mImdOUjV
 ulWM9M++LnUKlWvft8MYhNtqK12aBPPD8Hmo6kcWv3YlGvqwZ5SwRkMN3irjn/WKGWAu dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wa8htenss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iLgU090883
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2watjx343f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:31 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAI8lVO4010877
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:31 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:30 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/15] btrfs: sysfs, merge btrfs_sysfs_remove_fsid() helper function
Date:   Mon, 18 Nov 2019 16:46:55 +0800
Message-Id: <20191118084656.3089-15-anand.jain@oracle.com>
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

Merge __btrfs_sysfs_remove_fsid() into its only caller
btrfs_sysfs_remove_fsid().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 34bf080ea530..74210ef59641 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1070,7 +1070,7 @@ static struct kset *btrfs_kset;
 /*
  * Remove /sys/fs/btrfs/UUID/devices and /sysfs/btrfs/UUID
  */
-static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_info *fs_info)
+void btrfs_sysfs_remove_fsid(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
@@ -1087,11 +1087,6 @@ static void __btrfs_sysfs_remove_fsid(struct btrfs_fs_info *fs_info)
 	}
 }
 
-void btrfs_sysfs_remove_fsid(struct btrfs_fs_info *fs_info)
-{
-	__btrfs_sysfs_remove_fsid(fs_info);
-}
-
 /*
  * Creates:
  * 	/sys/fs/btrfs/UUID
-- 
2.23.0

