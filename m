Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9815A4C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 10:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgBLJ21 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 04:28:27 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34404 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgBLJ21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 04:28:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9MRnQ177280
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=mCkatWBl/6IZsIYKUpZqtHbDtkSW55WyDKxkqcY0BBg=;
 b=i1UOiOX0BcxatR+E/SPL5YRRC9NCs1QSE9HTHqwOjMAuitO+NlBHS7220X8kcqDVqtko
 l7t/uXBaG8ZnkGX1ek+0Cz7bOqf8IEXD3wu1o+st/qbfBXsmhlb12Lev4TPoJxzou0P1
 HsFddhbMV2Q/005BANxPp4SFfHJvX1P4RICjSi4OxLllOMd/Fwn6nf8uyp8QLKAC9vpA
 9Yr9rxyNsXCFsdn7RBg8DEkYTk7YRNEclEkEzeLqnd3SMqIAQtyAjFP6t3SjqbRDnRuA
 fFoergq2O0TFZEvm8/FtHtZdiQnEJt433YCvn8GAXnJdcnbHQTMl3KQp4uDr4js4OQb4 Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y2k888ycq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9MCS6115139
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y26hwkfrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:25 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01C9SOpi008796
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 09:28:24 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 01:28:23 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: sysfs, move dev_state kobject under UUID/devinfo
Date:   Wed, 12 Feb 2020 17:28:11 +0800
Message-Id: <1581499693-22407-3-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581499693-22407-1-git-send-email-anand.jain@oracle.com>
References: <1581499693-22407-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
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

Originally it was planned to create dev_state under UUID/devinfo,
something got messed up, and ended up under UUID/devices instead.
If it should be ok to relocate, bring it back under UUID/devinfo.

Fixes: 668e48af7a94 (btrfs: sysfs, add devid/dev_state kobject and device
attributes)
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 6bac61c42c05..3c10e78924d0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1295,7 +1295,7 @@ int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
 
 		init_completion(&dev->kobj_unregister);
 		error = kobject_init_and_add(&dev->devid_kobj, &devid_ktype,
-					     fs_devices->devices_kobj, "%llu",
+					     fs_devices->devinfo_kobj, "%llu",
 					     dev->devid);
 		if (error) {
 			kobject_put(&dev->devid_kobj);
-- 
1.8.3.1

