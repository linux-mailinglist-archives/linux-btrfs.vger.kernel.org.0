Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56763F5797
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 07:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhHXF2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 01:28:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48186 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229937AbhHXF2s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 01:28:48 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O0xBsO014822;
        Tue, 24 Aug 2021 05:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JRwOBavrmnwa0KEjazWUqHweYxpw28L1HZaIIGO/CzA=;
 b=NdjZueOBhMw+PhFbA7YpNpR4gZ07m6zD/0A6ksqo27cmmB8msHjHz9f58QEYOKiyBNvi
 +IRR5sMOet4S0g3NLuYsw+bKXrX1R7ggWrLkhXkFMK9fM99zoa/BEMdVUC7XJQ88HlFG
 gs1uOfE3NUHucFxmALYUWEyz4cXwz6xH9LbI1BtUdqD1A9X9BaQCDcRAG0uACLS6aG+Q
 ACUesiL7lgV6UVOAFOgV2KA/FJpW8OlnucXGPesIzymhDRli3dVwLp4GMQuJsTic43NO
 L5WqxVL8YZIrVAw6vUA/vcmEK4QLgBzfkrYKYwVQs5tPPRCJi0MQ5NQ4354A8pV/r60b yw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=JRwOBavrmnwa0KEjazWUqHweYxpw28L1HZaIIGO/CzA=;
 b=vAALDUtoYYAZTbAmlc3umkqLUmMDWjpQ+4tN9tR4cSYCWeC+vOVyVn0QTuTHJNlh3Iq2
 p+vqqwCnj9u7GTFzmtmLR21EBm41ciuKWIO5LcIBhQI6w1Mtph6qHFTDycaTGIt91wVw
 iIse2hG0Q9vapL1GcLBq3re54ZL2jrrCIbBEY3Oq/CDHK8qgNL0eNaGhacpIFg+x8GRD
 7YCUn0H25STtYCe82NMgQxqfsVFXYRao7ZxK4bx4Se36Jefm/44Xp+0cUxmPRbmd1KEu
 bexJfngfgsyyjMqV4OihzYel/O8cib/rg1+NkmUpiKW5Wo62ETCauhjWRa5MG5q3Cbj7 Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akuswkcxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:28:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O5PJUd181995;
        Tue, 24 Aug 2021 05:28:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3030.oracle.com with ESMTP id 3ajqhdxwqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 05:28:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOcKsOT1DXz/HQAh6LiH6X3Le7wD4tpm6wAvz/hO7NHbOreH6Y4awjgRTaJdAyMLNq8hTv8T50Cq8adlYfPUiWeR0UAESu6OceeX/NUYyynANG0XZQ7hBznoZL1xonnGIjyOzNCmZG2FwNtvRjAfkBXWw3+7Pq/UI03ivvc/FQu1+Ira87fSmXbPxyOLUI3cXgzyE0+P+sTaenTG8EZn5chwctZg+2hlIidh+bRbAoby0g2q4dZciPgs1rT2+DswFdddVZh5vtXDtBzG2qgMzSlN2UHeKgnI0YjfQQN7173x3ZYCLF+ig/PTeuUqUDtaEeogTQNtzmlTHoAsC4uHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRwOBavrmnwa0KEjazWUqHweYxpw28L1HZaIIGO/CzA=;
 b=gmXHIs3cjZZbaw3j+JNjV+4iXl2ScUAvKXhVDiw/P9MObTOPr/laC2QJhJJc3L13Y8TS2OOtBRUJOMQFT9Hvdg6b5K9UGGjG5Qy5vQj3Y3sZhZvhlxnx0HONarfL5BIoq2zGVhNxnDk3WZo6brh4FFd7y6M+/FkY/eWSJXjCQmEnav22G5lvt07sMpuY8OHcwQUQPCDlIEcUbSfZP123TUzAm2bvjgw4V4k0hqCwXS6S9akAcPXioQ6XNd4Nz4K24OQZmGYFRXtIGizrO8lttqOdjR4LXfaB8J+4lKXzg+w4mQ+NOyo2ik3C3IdEZzLf22Z617l+tDwqNIIerkwb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRwOBavrmnwa0KEjazWUqHweYxpw28L1HZaIIGO/CzA=;
 b=XBe/7BHuWwdhuSHbdUrZ0GsFMkQs2eAYm1R92kEtoMRmniZiJGosquLAh7k8+gFRHs+ILp5gYWXASJqALgCGy5J+a58BPn8Y9NtvO/lHSXIct9f+cqZ0B7YVRRptblEmaG8NyKIT3vPhZvtou7kkJ5y9qznWEfMXTg/BP4pRXHw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4046.namprd10.prod.outlook.com (2603:10b6:208:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 05:27:57 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 05:27:57 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH RESEND] btrfs: reduce return argument of btrfs_chunk_readonly
Date:   Tue, 24 Aug 2021 13:27:42 +0800
Message-Id: <32a8d585312548c69ca242c6fd671755f78ddace.1628609924.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0140.apcprd06.prod.outlook.com
 (2603:1096:1:1f::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR06CA0140.apcprd06.prod.outlook.com (2603:1096:1:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 05:27:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 147c3a78-0296-4e27-260e-08d966bfee81
X-MS-TrafficTypeDiagnostic: MN2PR10MB4046:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40463A594C34EE9B05CCDD5FE5C59@MN2PR10MB4046.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvyUb2RyBwMzIBGZSWW9T1gZIOlwS4UieSwm7As6nJLb3b0OiBxtzErUN4bb8rWuPwNzufMDjpAg7oOlKZfK4D/d3g2KImWEeA7Kp0DjogMcAI/ww7y7A5NvprXBQOlFJuCM1DIWbdl/zTIjBwmyd+rjjm7R4Zu71ficLu+X7ixCi9IVr5FRQfWUQnD+k0FgGNZpPixfo3v+8Roji6BpLzjkORJ6AnXWMzaPqW8dwpjhh2FAHENhKDaJ9/LsZMy4gvgy4eSQA9o6Aj7y+fqxAth0NCHcs1pEPBcCSFsdNXVqJaV5DdbIPZXt2XlfqrDGqPMEO0PqeDleMKV3v4xjkWugY3GxWh90SeVi0rF/kk5S8Jbbah8MZ5ee+niBq5VsYdCQ3ESI5V+BzMdK2UTfKxvAcIDFYjyAlx72wlxlyt0VELklKSTxV0nN4PHK6aw69xOGezQkd5MZqqM15hCLre8qOINS2xB4mENG81sDlpFDLfFmIfR3BLERoC/6ONz3xBbxH7ffCtsJB0Y2+zJH/DMOK45xJf19O89F0fUEdPnh5Rrd9MzpEY1ewPJcfq+DaBQrsO2D0PFgccoZpuXOTvROYX+3wyukEcJyzjBapiSHkk594J4j1zfc/w7l64PhurpE1YXz0G9sfEj+CldlBZzrD4S5w1tr5P/RS/QPEmEmE9MWJ45Tjg3OoGKQ2svE5zoMLNV9Of8NcUGM102tLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(346002)(376002)(8676002)(66946007)(8936002)(6512007)(38100700002)(66556008)(6486002)(66476007)(44832011)(956004)(83380400001)(36756003)(26005)(186003)(6666004)(478600001)(52116002)(6916009)(5660300002)(2906002)(4326008)(316002)(86362001)(6506007)(38350700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OviydhxKq+ZgA/8yEpOZcG3TQV2d+Fl5zBFxTynrwZN/r0gC8/0tekILqQtN?=
 =?us-ascii?Q?QiF0ZQKW923yJ+RRfvSDX05jk3F7rkB+Ewha8eSFeahpHanzYdg3m4tnONGD?=
 =?us-ascii?Q?cBALM8Fkat4TvRqH2n+RH1HXbUhI7/lM36J0hgaVviFUmA4KFVR/MHoZzRCG?=
 =?us-ascii?Q?Dfen4HUhd52GU03BayCFa4WME+kov5KdcADTT+nTcOsUckl2PFTx3dQcLIh9?=
 =?us-ascii?Q?B4uVLHVg1chpeEScGgoM0cGUgziIVG2RCNHBV7wc6k5/I9UYMbdtHwJ1sPQf?=
 =?us-ascii?Q?oU9LqH9zSHMJGlBGTbcvTdFwVBUIef7P4zbhnP4Y3TvGdjlaEPyCH2Vb8pIz?=
 =?us-ascii?Q?sIEerk5szkMARuOp/CqvbiDV2y1HAdrD4Q+TIJsugTqSRBLsQuzKKB1BqwqX?=
 =?us-ascii?Q?z+Fv0HlZyBrpkLSpIweIc0ghagp8pTEoOG/81syJ0U1U2HsY7kSzZVc5bHtg?=
 =?us-ascii?Q?flyzsJBbVw+7MJ3x3cBbnFintBjUaB5NSF+f5K7JmWkkkj5A/TDRFTjSS2DD?=
 =?us-ascii?Q?c4UuZ5B0RI8/wqxp6ZcqWquC9KwdhKV8dNawzk9eVczO7/v9EYz+3d25cjwL?=
 =?us-ascii?Q?YGr6R4VeugBMsvvKHrZQr1RBHR3g82c8LeLIGvJFQMXoMLWsd/HLgPZpTbxE?=
 =?us-ascii?Q?mwT82LvfNJvbaVFThmy38Y9Bff83OhRnZyZyvKq+W4BU7dUK9Oh++RHpcIwB?=
 =?us-ascii?Q?yeAZPFz9a9zseKR8wtkJ/F9fOZZO0mU0u2GaX7stnZnuKSdG8uGLdpvUW1y1?=
 =?us-ascii?Q?36zG4gj3KE3vDnKWBDrGSU3EtdB9WYnKqHkQmsjjg1xNBCWL+ejB5WTGBaeU?=
 =?us-ascii?Q?XR2C2tn5CY792HfHyjFNIPR2vTprhEhaGyAi8JdAI/samSHT0oxE74Rw/mFV?=
 =?us-ascii?Q?TjbFiufIxVURsNT5eSv6JUbOMK9NKp2JJ5GxfUNQuxSQ5JVCMjgQQPpAQcmr?=
 =?us-ascii?Q?/pEEAtvd/7tINyStYL5JQ9O1LUOmmWFb+m4OdmJ9bj87B5Y/cgh9R7Jg2lF/?=
 =?us-ascii?Q?Z1r0BV7TeGfi6wQF86ZTuqxtdPQPuo+3WCjgphJK7E42bVr88MDblldRN+jU?=
 =?us-ascii?Q?rFVqteO+yZmZCHV9MNrxL2xsVdViKWnslrxT3O4ZY7gFdaF5r+D9vNYm6RG1?=
 =?us-ascii?Q?w7bah0jEjXpLyCgONAm/7Mhs3RpNmhHq1WbzbWUkINEc5AF2Yp/wrnzzzJ6e?=
 =?us-ascii?Q?W9Qze6EIG85NLur5f58dHeQax6LyzLaW90wMFe+lZ51gou+NhiOHk4KbxE22?=
 =?us-ascii?Q?D5s+k0gnzm/DmlJLQbfIcoeiQqC8KzdLYx6rgH+XpqTPBV1+u5bJ53TC6/iU?=
 =?us-ascii?Q?FXXzO/tBPbBJl7Rt1sfSf09l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147c3a78-0296-4e27-260e-08d966bfee81
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:27:57.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjg0AB1rABqxeqro8Fc50vQmd9OaR+I8C2aDcCum7StBdUtlWzmAUvGWVZ4MXrfHbfsxJsY4Ha8gSsdtpnTc6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4046
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240034
X-Proofpoint-ORIG-GUID: sUvYizjHWJuWnqHd9-fNnIrzbtya5N7S
X-Proofpoint-GUID: sUvYizjHWJuWnqHd9-fNnIrzbtya5N7S
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_chunk_readonly() checks if the given chunk is writeable. It returns
1 for readonly, and 0 for writeable. So the return argument type bool
shall suffice instead of the current type int.

Also, rename btrfs_chunk_readonly() to btrfs_chunk_writeable() as we check
if the bg is writeable, and helps to keep the logic at the parent function
simpler to understand.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c | 17 ++++++++++-------
 fs/btrfs/volumes.c     | 12 ++++++------
 fs/btrfs/volumes.h     |  2 +-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a3b830b8410a..d7e06b4bae26 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2062,15 +2062,18 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	link_block_group(cache);
 
 	set_avail_alloc_bits(info, cache->flags);
-	if (btrfs_chunk_readonly(info, cache->start)) {
+	if (btrfs_chunk_writeable(info, cache->start)) {
+		if (cache->used == 0) {
+			ASSERT(list_empty(&cache->bg_list));
+			if (btrfs_test_opt(info, DISCARD_ASYNC))
+				btrfs_discard_queue_work(&info->discard_ctl, cache);
+			else
+				btrfs_mark_bg_unused(cache);
+		}
+	} else {
 		inc_block_group_ro(cache, 1);
-	} else if (cache->used == 0) {
-		ASSERT(list_empty(&cache->bg_list));
-		if (btrfs_test_opt(info, DISCARD_ASYNC))
-			btrfs_discard_queue_work(&info->discard_ctl, cache);
-		else
-			btrfs_mark_bg_unused(cache);
 	}
+
 	return 0;
 error:
 	btrfs_put_block_group(cache);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 87d4c34ea35b..9cb4ed90888d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5568,17 +5568,17 @@ static inline int btrfs_chunk_max_errors(struct map_lookup *map)
 	return btrfs_raid_array[index].tolerated_failures;
 }
 
-int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
+bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
-	int readonly = 0;
 	int miss_ndevs = 0;
 	int i;
+	bool ret = true;
 
 	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
 	if (IS_ERR(em))
-		return 1;
+		return false;
 
 	map = em->map_lookup;
 	for (i = 0; i < map->num_stripes; i++) {
@@ -5589,7 +5589,7 @@ int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 		}
 		if (!test_bit(BTRFS_DEV_STATE_WRITEABLE,
 					&map->stripes[i].dev->dev_state)) {
-			readonly = 1;
+			ret = false;
 			goto end;
 		}
 	}
@@ -5600,10 +5600,10 @@ int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 * set it readonly.
 	 */
 	if (miss_ndevs > btrfs_chunk_max_errors(map))
-		readonly = 1;
+		ret = false;
 end:
 	free_extent_map(em);
-	return readonly;
+	return ret;
 }
 
 void btrfs_mapping_tree_free(struct extent_map_tree *tree)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b082250b42e0..4e1627b64a84 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -492,7 +492,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
 int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
 int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
 int btrfs_uuid_scan_kthread(void *data);
-int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset);
+bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
 int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 			 u64 *start, u64 *max_avail);
 void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
-- 
2.31.1

