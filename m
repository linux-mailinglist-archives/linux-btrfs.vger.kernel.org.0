Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5649615A4C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 10:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgBLJ22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 04:28:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34432 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgBLJ22 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 04:28:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9MSEY177325
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=vu195uc9rgzu/6TIzJRFUn2zkSEL1D1g6JIJs1x+5Fs=;
 b=YKa5muUWPRTdt+0ZQn/WU0QtEKPQdyfgtdDm/URiEdl9dPjWSlks/OKVe8IWgfAH2Xz7
 L+nAEl7t7hb6C+bMHMo2dQsWgwg7LtHVC6tejG86MfXFirrld7y25W9VdbHqrNYHB3AK
 emNy4xsPeYVntED/gFVY1+CwyZZIyduI7pxtocjzmMnHP4cZurllCCDjkz5PdhVKVIRO
 HCBPVf/GmN18KmoPr2VqCQk/wgsoVKLGkVqM9Yfrs7ieYzz3Syc/+NUdB4dkqqNoxyY6
 P771lvh8H0vTR94rMwxjPHkNZgt5tTwCnhaw90OXVgZrXEG8gldLDW4XBc0+r64c3Fy3 tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y2k888ycs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9MCv1115159
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2y26hwkfsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:26 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01C9SPxI016564
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:25 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 01:28:25 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
Date:   Wed, 12 Feb 2020 17:28:12 +0800
Message-Id: <1581499693-22407-4-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581499693-22407-1-git-send-email-anand.jain@oracle.com>
References: <1581499693-22407-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=948 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=1 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=1 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120075
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have one simple function btrfs_sysfs_remove_fsid() to undo
btrfs_sysfs_add_fsid(). Which is also smart enough to check if the kobject
is initialized.

So lets use this function while retreating from the function
btrfs_sysfs_add_fsid().

One difference if btrfs_sysfs_remove_fsid() used is that, now we also call
kobject_del() which was missing before. So tested (with kobject debug
turned on) and find that there isn't any change with or without
kobject_del().

This is a cleanup patch.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: change log updated.

 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 3c10e78924d0..119edd4341d6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1371,7 +1371,7 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
 	if (!fs_devs->devices_kobj) {
 		btrfs_err(fs_devs->fs_info,
 			  "failed to init sysfs device interface");
-		kobject_put(&fs_devs->fsid_kobj);
+		btrfs_sysfs_remove_fsid(fs_devs);
 		return -ENOMEM;
 	}
 
-- 
1.8.3.1

