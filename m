Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BE25E0EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgIDRf2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60540 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgIDRf1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HZ5gZ141064;
        Fri, 4 Sep 2020 17:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=DLDocbq67auddKzn8DRbAg3TQsOtfLopdxATMDN3j3w=;
 b=gaKX97mhkhrFhQTV8vGqBEWqCztht6v8AWGhlJyw8E7CNTy3QtzKP2AGT6ExDOD6GHqS
 rW/HuWffyMzsz4U32+B33sDfn+Xxh3ZQ7QTQRDvYvO8EcDd7l4rjy6kGCSPl2DGK0/J3
 q+fCMLOlavTpnGMqSMnPgqzNwP2MMi7cddxOhbKcnkOfg3irY9XtJjs5WAJHBVYb2/PF
 bm0M2zjTDy+a3hWBkctFYNOMl3ifu9PpVMcdxdf5/UbxmPh1xyPPSN2oMfPKekXyJ7zf
 Ed6gpsFcQ3Jb5GaJcPRiBfwkkZruAewlx1+ioXYnSLe+M86XLwWNs3w9P4jIqOMOEXKM gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eerfra5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HVDxZ171601;
        Fri, 4 Sep 2020 17:35:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33bhs4tcd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:21 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084HZKLN028375;
        Fri, 4 Sep 2020 17:35:21 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:20 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 14/16] btrfs: cleanup btrfs_assign_next_active_device()
Date:   Sat,  5 Sep 2020 01:34:34 +0800
Message-Id: <7d006c2ef7155b463d7c9f511ee4d631c3ecee92.1599234146.git.anand.jain@oracle.com>
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

Cleanup btrfs_assign_next_active_device(), drop %this_dev.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f16c4a854a6c..f2ade4af33fd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1960,16 +1960,13 @@ static struct btrfs_device * btrfs_find_next_active_device(
  * this_dev) which is active.
  */
 void __cold btrfs_assign_next_active_device(struct btrfs_device *device,
-				     struct btrfs_device *this_dev)
+					    struct btrfs_device *next_device)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct btrfs_device *next_device;
 
-	if (this_dev)
-		next_device = this_dev;
-	else
+	if (!next_device)
 		next_device = btrfs_find_next_active_device(fs_info->fs_devices,
-								device);
+							    device);
 	ASSERT(next_device);
 
 	if (fs_info->sb->s_bdev &&
-- 
2.25.1

