Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9091000A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfKRIrV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48184 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfKRIrU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iEpT105438
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=yosvWSsN4KUauNOOigqSL5aQ0ReuLJMzzkiLsbi5IQg=;
 b=ROHggtSkdP5PqXorOM3/3P53MndyaN4iJ1GPAByrfSUbqCnpYcTA9eoXMlVWton3NCrS
 P1M93HEAFrJF1UagSp/t4jaDzUt6I25YJOYe5SNHLzeDbRFc3KTs3SFGrPVr0PmSKb4i
 ImvwC/eV90YjKKnuf49OVHdM9Q/SprQocomxDjq25G6RZnLZVCsLQpkohHwxzWalJyZo
 xUWkWefYuhTgZlK/yRBzLrvccRHTg0V86t7JmWP8i+ruMpU25afSwxOcSb/8s3tKuysf
 8HK13zzsgIhipw3E4OgeG9dnv1c20uVXlSamDQfHOmtdahZ91GJdCcb8Naa6zUfnAVKj lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8htenr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iKFP152757
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2watmr3gu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:18 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAI8lHd6010786
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:17 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:17 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/15] btrfs: sysfs, delete code in a comment
Date:   Mon, 18 Nov 2019 16:46:48 +0800
Message-Id: <20191118084656.3089-8-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118084656.3089-1-anand.jain@oracle.com>
References: <20191118084656.3089-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

commit 3ebb2ada (btrfs: sysfs: export supported checksums), added some unwanted
commented-code, delete it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 724af1322dce..9494ccace624 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -255,16 +255,6 @@ BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
 
-/*
-static struct btrfs_feature_attr btrfs_attr_features_checksums_name = {
-	.kobj_attr = __INIT_KOBJ_ATTR(supported_checksums, S_IRUGO,
-				      btrfs_supported_checksums_show,
-				      NULL),
-	.feature_set	= FEAT_INCOMPAT,
-	.feature_bit	= 0,
-};
-*/
-
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
 	BTRFS_FEAT_ATTR_PTR(default_subvol),
-- 
2.23.0

