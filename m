Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8FBD84A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 08:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404775AbfIYG3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 02:29:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48124 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391660AbfIYG3n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 02:29:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8P6SxCO015167
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 06:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=0N2iJY318956nGzeOKQwN5DZvyPDdbhSLjFnu4p8xes=;
 b=LrxcurjALH2Gqossc6OYDGuWnTfzCwl6sM2lQwdR1AnFyEAnthYMk8RXqqMnPCg/r7W+
 aVepYQElTBnCIfJRQcSWL5SJx6qFdtfg7+fGr3+uW7gx1uo93e6mf1MHdoHnO2TvZZjp
 oCqHhXQReBZRCrwYGStOc+MgCdZtpDMN9E87Nl9WpjybNZnprrFkQ0vJZvYwVAFKjQ+3
 I3O9uzSk2PulonXD41uCIfP0RB03ifg3RMM5ruyXxJUxXOYspZtrEnkf0J3QR46cVOoz
 sjo0oDjyfPwcQfpCbrm/hqsql3XwDutwqvisbooBqE2JCHjv3bST9oTHmy9aclZ1xeTA Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v5btq2h4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 06:29:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8P6Shf6132287
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 06:29:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2v7vnxb5q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 06:29:41 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8P6TeMx008438
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 06:29:40 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Sep 2019 23:29:40 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: balance: use redundancy instead of integrity
Date:   Wed, 25 Sep 2019 14:29:28 +0800
Message-Id: <1569392968-21340-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=962
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909250065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909250065
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When balance reduces the number of copies of data it reduces the
redundancy, use the term redundancy instead of integrity.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5d35f3f34bd2..9ce975f1ddee 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4032,7 +4032,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	int ret;
 	u64 num_devices;
 	unsigned seq;
-	bool reducing_integrity;
+	bool reducing_redundancy;
 	int i;
 
 	if (btrfs_fs_closing(fs_info) ||
@@ -4109,9 +4109,9 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 		    ((bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) &&
 		     (fs_info->avail_metadata_alloc_bits & allowed) &&
 		     !(bctl->meta.target & allowed)))
-			reducing_integrity = true;
+			reducing_redundancy = true;
 		else
-			reducing_integrity = false;
+			reducing_redundancy = false;
 
 		/* if we're not converting, the target field is uninitialized */
 		meta_target = (bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) ?
@@ -4120,13 +4120,13 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 			bctl->data.target : fs_info->avail_data_alloc_bits;
 	} while (read_seqretry(&fs_info->profiles_lock, seq));
 
-	if (reducing_integrity) {
+	if (reducing_redundancy) {
 		if (bctl->flags & BTRFS_BALANCE_FORCE) {
 			btrfs_info(fs_info,
-				   "balance: force reducing metadata integrity");
+			   "balance: force reducing metadata redundancy");
 		} else {
 			btrfs_err(fs_info,
-	  "balance: reduces metadata integrity, use --force if you want this");
+	"balance: reduces metadata redundancy, use --force if you want this");
 			ret = -EINVAL;
 			goto out;
 		}
-- 
1.8.3.1

