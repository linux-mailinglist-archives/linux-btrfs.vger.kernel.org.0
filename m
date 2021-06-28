Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A9C3B5D4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 13:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhF1Lrs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 07:47:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4672 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232894AbhF1Lrp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 07:47:45 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SBgY6t017440;
        Mon, 28 Jun 2021 11:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Estgze5mpYPudWOKDW44k/2sXH8MVmEt7Z1lV3HQTHI=;
 b=Xdn4zbXhqmohda/V25DEooZXnoiqzakxpL8e6aaWBPyZ9/BpcEZX8nHUmc5yD3FncyL3
 kjy0ZEHigOuo3Yxj5mNm2ssJT+IwlbM+BpPcajqua3reCieg0lRGXHI5KZzO2ssGu85e
 L33ZznX98i5MiOqOl7FD67zR77UYMTuw1e7TO8IgOLv8RkRWPv31npxY3VZcxyumbCq/
 G+BJODWKkA9EPcdZ1L8kyx4FqLQ82Tc0Hih4vwhRlHPioC+8YonhdTlr64Tc6AVtFn5j
 shlyfcZKSxfuyLi5WfbnOoDRl3LOxROct3F9LjlHzpJ6cNH2NgZFmaRNArzpWj0rh4Pg Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f174h2un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 11:45:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15SBdxlQ107525;
        Mon, 28 Jun 2021 11:45:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 39dt9cmpax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 11:45:19 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15SBjH0Z029496;
        Mon, 28 Jun 2021 11:45:17 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jun 2021 04:45:17 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com
Subject: [PATCH RFC] btrfs: drop check for lowest max_zone_append_size in btrfs_check_zoned_mode
Date:   Mon, 28 Jun 2021 19:45:08 +0800
Message-Id: <930bc4470fafc02a3b8888fdc24f929977f7df24.1624880252.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <fb36e9a074e51af822fe97f2759e62394ec17eaf.1624871611.git.johannes.thumshirn@wdc.com>
References: <fb36e9a074e51af822fe97f2759e62394ec17eaf.1624871611.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10028 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280082
X-Proofpoint-GUID: VW2EkraAUqZoET5q-XXnXXpcWEQu6LQa
X-Proofpoint-ORIG-GUID: VW2EkraAUqZoET5q-XXnXXpcWEQu6LQa
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 862931c76327 (btrfs: introduce max_zone_append_size) add it.
btrfs_check_zoned_mode() found the lowest of these per device
max_zone_append_size but it does not use it. So drop such a check.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC because I am not sure if this check is preparatory for something
WIP.


 fs/btrfs/zoned.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fa481d1ce524..76754e441e20 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -529,7 +529,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	u64 zoned_devices = 0;
 	u64 nr_devices = 0;
 	u64 zone_size = 0;
-	u64 max_zone_append_size = 0;
 	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
 	int ret = 0;
 
@@ -565,11 +564,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 				ret = -EINVAL;
 				goto out;
 			}
-			if (!max_zone_append_size ||
-			    (zone_info->max_zone_append_size &&
-			     zone_info->max_zone_append_size < max_zone_append_size))
-				max_zone_append_size =
-					zone_info->max_zone_append_size;
 		}
 		nr_devices++;
 	}
-- 
2.31.1

