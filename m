Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC58885953
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 06:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfHHEcy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 00:32:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56522 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfHHEcx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Aug 2019 00:32:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x784TUtq056200
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Aug 2019 04:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=3peJlijHME0v+5+Io9mPK6FovO2H4f/5KwE6YcuHU14=;
 b=AEpk3uFZ5cVNsRbCR+3xBP6CzQN0qi26Ux3FgObajnPQypDb2yFRAPdWOicR+xhmCwoY
 rZZ2Aw4PHw7slp6wNGNvHKp+JWxLNh1QznA5CnUsd/ioIR2qE/KYxWuhmYfBedj+ZMpu
 6CrZ+ZPfGXZNu6GHB7KZsVqoSsDrUZi6dPb2ATpF5+ccumaTRgSll4c86cDBlk+6J52i
 izaFW+7fk1x7DMlsrhnTd0u4Lu8pP4KGPsEosZBwoEkfu4bXcOlEiLWetXf00HR6w4Wv
 KYN7VgqXK+XciqyRJCa2FxkkqQFEtA8LFdkQh6Qs7QcBJnvRXn0NHTNIeyZeqKeVioRM iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u527q00u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2019 04:32:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x784S4tS160044
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Aug 2019 04:32:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u7578m1ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2019 04:32:51 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x784WoDa003481
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Aug 2019 04:32:50 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 21:32:50 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: replace: BTRFS_DEV_REPLACE_ITEM_STATE_x defines should go
Date:   Thu,  8 Aug 2019 12:32:44 +0800
Message-Id: <20190808043244.1256-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190808043244.1256-1-anand.jain@oracle.com>
References: <20190808043244.1256-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080048
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The BTRFS_DEV_REPLACE_ITEM_STATE_x defines, as shown in [1], are
unused in both kernel and btrfs-progs (except for one instance of
BTRFS_DEV_REPLACE_ITEM_STATE_NEVER_STARTED in kernel).

[1]
btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED        2
btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED        3
btrfs.h:#define BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED       4

Further these define-values are different form its counterpart
BTRFS_IOCTL_DEV_REPLACE_STATE_x series as shown in [2].

[2]
btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_SUSPENDED   2
btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_FINISHED    3
btrfs_tree.h:#define BTRFS_DEV_REPLACE_ITEM_STATE_CANCELED    4

So this patch deletes the BTRFS_DEV_REPLACE_ITEM_STATE_x altogether, and
one instance of BTRFS_DEV_REPLACE_ITEM_STATE_NEVER_STARTED is replaced
with BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED in the kernel.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c          | 2 +-
 include/uapi/linux/btrfs_tree.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 6b2e9aa83ffa..00ea828beb00 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -56,7 +56,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 no_valid_dev_replace_entry_found:
 		ret = 0;
 		dev_replace->replace_state =
-			BTRFS_DEV_REPLACE_ITEM_STATE_NEVER_STARTED;
+			BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
 		dev_replace->cont_reading_from_srcdev_mode =
 		    BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_ALWAYS;
 		dev_replace->time_started = 0;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 34d5b34286fa..71246c1941aa 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -806,11 +806,6 @@ struct btrfs_dev_stats_item {
 
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

