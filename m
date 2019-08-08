Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F885952
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 06:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfHHEcw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 00:32:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56512 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfHHEcw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Aug 2019 00:32:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x784TVPZ056208
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Aug 2019 04:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=NL6sJyLg229X3XRj68ijBds/EtQ+HzOWRbQX2mTGx3I=;
 b=Up3ZwsBIzC8PVg1c1EFXVBzU9RSneU9sFOUqNGRcre+J6USW0CdtzaPExPvf/TysS/s3
 UWkOwWyR3+SvaHcS3kbeHwrP7/HzdQU4aBDfh4sbt34kuwSXrJsgvqBv44OObysULwuJ
 EsyKyv0T6jVZRP7pQrLHXIeTRuOZ6Wob0SWgieZQO/VMs8ZDWMXyIpchLTiqRywoqgqC
 Lt6zjop+bOXSYd677Lx+mCg6zXTSkS0fUkO3RGwwdEAO3Ah/rXvNmmxmz1ufOJC3aGxI
 XknDqonBnJM4pfdQz9IqHG8wGYTCRlGOdPHi3p0x/QfaSw+mT91cDmIa9CPDfd2NxDJJ Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u527q00u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2019 04:32:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x784S5xa080265
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Aug 2019 04:32:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u763jpd1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2019 04:32:49 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x784WnBe030626
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Aug 2019 04:32:49 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 21:32:48 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: replace: BTRFS_DEV_REPLACE_ITEM_STATE_x defines should go
Date:   Thu,  8 Aug 2019 12:32:43 +0800
Message-Id: <20190808043244.1256-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=887
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=934 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080048
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The BTRFS_DEV_REPLACE_ITEM_STATE_x series defines as shown in [1] are
unused in both kernel and btrfs-progs.

[1]
btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED        2
btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED        3
btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED       4

Further the BTRFS_DEV_REPLACE_ITEM_STATE_x values are different form its
counterpart BTRFS_IOCTL_DEV_REPLACE_STATE_x series as shown in [2].

[2]
btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_SUSPENDED   2
btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_FINISHED    3
btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_CANCELED    4

So this patch deletes the BTRFS_DEV_REPLACE_ITEM_STATE_x altogether.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 libbtrfsutil/btrfs_tree.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/libbtrfsutil/btrfs_tree.h b/libbtrfsutil/btrfs_tree.h
index 2af7205cc645..8ea3e31d9b96 100644
--- a/libbtrfsutil/btrfs_tree.h
+++ b/libbtrfsutil/btrfs_tree.h
@@ -800,11 +800,6 @@ struct btrfs_dev_stats_item {
 
 #define BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_ALWAYS	0
 #define BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID	1
-#define BTRFS_DEV_REPLACE_ITEM_STATE_NEVER_STARTED	0
-#define BTRFS_DEV_REPLACE_ITEM_STATE_STARTED		1
-#define BTRFS_DEV_REPLACE_ITEM_STATE_SUSPENDED		2
-#define BTRFS_DEV_REPLACE_ITEM_STATE_FINISHED		3
-#define BTRFS_DEV_REPLACE_ITEM_STATE_CANCELED		4
 
 struct btrfs_dev_replace_item {
 	/*
-- 
2.21.0 (Apple Git-120)

