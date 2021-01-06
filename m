Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3A2EBA52
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 08:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbhAFHJM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 02:09:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAFHJL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jan 2021 02:09:11 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1066lxXJ052394;
        Wed, 6 Jan 2021 07:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Uqie5oFvjUa/oam3MTlA2JT7nf2zgDix3GnOCCqf2TE=;
 b=V4ygUxnHrh/BK727BZI1r94VSRzdHMfWo0Lq6bhGO3OkSZXmh7E72RTCVM+aUFrqOjP7
 ngbJFS6JaBpji0Czn9TXneF/6dJMTTsnA3fK/XOt6TZROyaKIU6pRJB6xA8nruzNjH/R
 kYBU0Fa3rvgk6PgMlcLh7IU5qlDecN4Yvu5r1Pm6wLByuIdxYLMcjZP2L4HiN41KDp7t
 d2vuNyNNTIMRYemn1CRcWLDhvCA+y/cQYZqjwUc+FPZoqKBnwjhHeHnMffT4RbXeOOxF
 gKBwt27A/Guqf27NsKBLN9hrqb96anEeZEZJ8HznTNLoA34L0Pr2vXs7xJ9g+v9abtrV Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35w53b0hkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 07:08:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1066isbF031439;
        Wed, 6 Jan 2021 07:08:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35v1f9k93s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 07:08:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10678O9C025784;
        Wed, 6 Jan 2021 07:08:24 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Jan 2021 07:08:23 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH] btrfs: fixup read_policy latency
Date:   Wed,  6 Jan 2021 15:08:15 +0800
Message-Id: <e9cd491fb05be97dbba756b7d0b9df3418b02a1d.1609916374.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <df71f31c04177b7f5977944b0f1adcecca13391b.1603950490.git.anand.jain@oracle.com>
References: <df71f31c04177b7f5977944b0f1adcecca13391b.1603950490.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060039
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060039
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the meantime, since I have sent the base patch as below [1], the
block layer commit 0d02129e76ed (block: merge struct block_device and
struct hd_struct) has changed the first argument in the function
part_stat_read_all() to struct block_device in 5.11-rc1. So the
compilation will fail. This patch fixes it.

This fixup patch must be rolled into its base patch [1].
[1] [PATCH v2 1/4] btrfs: add read_policy latency

I will include these changes in the base patch after the review comments.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 381eed52708e..7fc56274f3c1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5550,8 +5550,8 @@ static int btrfs_find_best_stripe(struct btrfs_fs_info *fs_info,
 		unsigned long read_ios;
 		struct btrfs_device *device = map->stripes[index].dev;
 
-		read_wait = part_stat_read(device->bdev->bd_part, nsecs[READ]);
-		read_ios = part_stat_read(device->bdev->bd_part, ios[READ]);
+		read_wait = part_stat_read(device->bdev, nsecs[READ]);
+		read_ios = part_stat_read(device->bdev, ios[READ]);
 
 		if (read_wait && read_ios && read_wait >= read_ios)
 			avg_wait = div_u64(read_wait, read_ios);
-- 
2.25.1

