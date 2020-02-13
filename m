Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2215BAE6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 09:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgBMIlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 03:41:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59844 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgBMIlE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 03:41:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01D8cVF1057798
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 08:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=AjgbcgEXP0bTg/gLi+Fx4OpXGtJeQ/ux19WuHZUJp5k=;
 b=O0azVXVlL39CwYL6niTcS0vOi+q0mVF5duR2hT/D7H6u83v67Ta2uqGinYWv2rvtzYAn
 PS/rQCJpS52XY1v+aauIa9H1qTTb01l8md/ZvnIgz2p/ctvuuFXjvL+zevmLxy+UgMi7
 m24kDBF1EpwuhPZEJF8VI4YTLDGRwTeLCiJaxoYe21QF2iTwo4D1TPBkS8QPYZ92Gyvl
 LuKIlNYHC8vATHyREJJHNN05TeQxW5Sl5U5Q3o2oYrtyxcrYt2KkEisDqB/7tm8/U1Cy
 GVaooO6ylw/MuV9vTzMK4kZlrOW/6+unbBe6MqZ1v20skR3iLhz+gXSZQuggpWmdDkzU uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y2k88g763-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 08:41:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01D8bsXK105984
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 08:41:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2y4k7ybuhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 08:41:02 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01D8f11W001629
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 08:41:01 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 00:41:01 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix devid attribute name
Date:   Thu, 13 Feb 2020 16:40:53 +0800
Message-Id: <1581583253-26814-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20200212173523.GO2902@twin.jikos.cz>
References: <20200212173523.GO2902@twin.jikos.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=1 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9529 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=1 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130068
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It looks like one of the attribute was missed out while renaming the
devid attribute. So fix it here.

Fixes: 668e48af7a94 (btrfs: sysfs, add devid/dev_state kobject and device
attributes)
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Hi David, There is one trivial item which also got messed up in this
series, its about function renaming. Can we merge this in misc-next.

 fs/btrfs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 91e2ec393a92..66cfefb03e1f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1272,7 +1272,7 @@ static ssize_t btrfs_devinfo_in_fs_metadata_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, in_fs_metadata, btrfs_devinfo_in_fs_metadata_show);
 
-static ssize_t btrfs_sysfs_missing_show(struct kobject *kobj,
+static ssize_t btrfs_devinfo_missing_show(struct kobject *kobj,
 					struct kobj_attribute *a, char *buf)
 {
 	int val;
@@ -1283,7 +1283,7 @@ static ssize_t btrfs_sysfs_missing_show(struct kobject *kobj,
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
-BTRFS_ATTR(devid, missing, btrfs_sysfs_missing_show);
+BTRFS_ATTR(devid, missing, btrfs_devinfo_missing_show);
 
 static ssize_t btrfs_devinfo_replace_target_show(struct kobject *kobj,
 					         struct kobj_attribute *a,
-- 
1.8.3.1

