Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269093E7CBE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 17:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhHJPtG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 11:49:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18804 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236950AbhHJPtF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 11:49:05 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AFgRFi026598
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 15:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=a1hySE7xmeb5Moye8XU8D8wRWBGuytD+510vYTrw8R8=;
 b=Vz/MjjsWoTXUZ/4skIY0HT4zBC6Piy43D7UTcMkBHis93fJO0F7KsxaDtf4GIXDJ78rW
 8GtHFPcFctGcUx54K9WxFaGK+tF/hzY3YgL64obQchFHbCRq4G7fiXaLQhRQJa24Zhos
 GTP5oXZBlZk3GAgfD4k650U0ga9tO+R2w5rolmItds2HIeAoao5/93bEhWXaJz+hGWpk
 sZSz2zDFqGa2ZrqvSxk4EOJi25NYpWFRZH87duC6Hhx4RzYRv4kKxa7vTfg7SoSuR3os
 hR+Q8uAEIHl720w+fRtAehCL/3TE5LN2NxvsdnluA2ZtwLLzPm98a9ewlMI4T2uNTpec 6g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=a1hySE7xmeb5Moye8XU8D8wRWBGuytD+510vYTrw8R8=;
 b=x6HtJaahqY0y3P9Vtkp/jUbDl2zCAjxDOo/Qf8h6ldULWQck7hSL4rvyS0Jpf6eSM6aV
 SHYhbQEg2zA1Vu90/c8b2M66lW/tUvuHyqO4Kxt41Qsj1OP8QvAKYQV0q7NOXaEXsil7
 2GMxLwXk9sCGUiMyJR9hI7h7nDBY3BDxACsvSX/gYrIbx6sMrtM/TcVILi2QukD90gsf
 7oVeZGk3gZU0ne77U1CRs5WYR8zVkZHLmQsSFOx75VPLaJgd/nvKiHjS6K1VPRQEOLrE
 L5VJ8KfLtRqds6s8LS9ouuqGgEcDaOobuWCTgutBz4ZHSExr5GMgenLBhNoWzDLKC6h4 rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt448e75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 15:48:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17AFe8Ow130305
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 15:48:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3020.oracle.com with ESMTP id 3aa3xtb6yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 15:48:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgYMDr27MXROLcFL6wZa4KNJbe0x/AUJNuDQCMdrgpPaT7poswE/jVKtOyQqTLlihiIxo3LvW36gN8rLakB92zVA+hyt4gevkXZqLEu6FZQbzwKbxe++b3xjmZQiQyYeRc+QYSmPvi6SKQTFfYGVQQoygiduATJn2czbo/Kl77roR8DaxrYoB1xBinuwla1lt92/X8XgxqQQIUBkDpfO/N/vuwne6HYMRQD+LX+NTLP7lcwKMHKebwriz85N9ZWj3XV0kQoEZUkpt41p1kKBZTZkOUH+CZl9CT20NJgGA7YxOxLIjftnjjXbFqP59/4dSM+ylCkKh0OG1uO2uEW3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1hySE7xmeb5Moye8XU8D8wRWBGuytD+510vYTrw8R8=;
 b=Mg79Ibt5z/4yZuJPAPBmUcmbUkyx6Mqv/xy2kB8VowQ1W4JoV3LPqzB2dWreBDfcnMOnA8CGw0zfEEdKvP1s89bVxud+rNY8uwDfgGQlXlzNLVxRxpXWcDZ1S1u9WXzuks5+cRzSB4DQC53Kks0yPoVYdeVzLndQO6hmQxUR1Cp0WuonHSVVVuo2rZX85yOkVj34F/XNtkjHL2ZlCcXJWFOxcnNKK8p34NHylSwSOIehNNzWbbTVGw3EMh64eKuYnH2TcQxHhGpL88mbTruyG3gSJF1xTLS3kfCu9Rq6ESucs9HSb0ksTLNpR6x3c3VbH+Bao+hhcH3Y9hl+NYDU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1hySE7xmeb5Moye8XU8D8wRWBGuytD+510vYTrw8R8=;
 b=Jl0bEoP+BtV8sy/40z6mDtk/c31C5dnGLUxCRC7+n/Kh/jnPpY0rFCgbADC04D6ouch+Sn8EOVCoPlMGx1gnKYSVzg9STSWTDjTnapcAYor2MtYnHxOvBnqRHwBIOgTcCzo0DPJOhhEZ31Cu3kbPrmhBV11Gn8FKLMTrUxBznjg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5281.namprd10.prod.outlook.com (2603:10b6:208:30f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 15:48:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.019; Tue, 10 Aug 2021
 15:48:39 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reduce return argument of btrfs_chunk_readonly
Date:   Tue, 10 Aug 2021 23:48:27 +0800
Message-Id: <32a8d585312548c69ca242c6fd671755f78ddace.1628609924.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dev.sg.oracle.com (39.109.186.25) by SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 15:48:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bbaa0d0-c4b9-438b-58b1-08d95c16524e
X-MS-TrafficTypeDiagnostic: BLAPR10MB5281:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5281C48044AFAAAE42D47278E5F79@BLAPR10MB5281.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbyu6e/t4XAFWVj03Ulz0ikcN9Zy5N4Ax19LYpge8j9fi7OgAyTPSrNrulWXslJzLPbctQ5xe/p+ZsT90wZM5GQBWUCBAe1ys7CDGiwoC78Dfwbp89duKTmUM/GWw3Ivu/wNa20ZVgHulYj8839v4pvWNBgi0pk0vH5J2xNPKf3SFW+1bhWNP7KZEfctlj/B1uMUavnNpx5oCRucbLthhfhzLEuuR3suXsUal+oM06sgxUSAWceXBq44UMAMGICcAn7/4BHRq1Cl1Udqea6TtA4HQKOUbKEnwVDY5kqFxX4O0dIanfEOklHCJ4X1ZWBE/1bD2GEspHPxP/jFFp6LgcSqLTtUNp3bJ8RHMLs/N6yxynVCHIbTZohSkmuGXY9930DWn5fYX6nKizM7SCXTcwQc0Tm7NQslni0p202YqLzgv0d4SFFqny9X7VBBDwtxjowLoWTV4uvsSvm7ry0jtXqDXtaPcHUMfijqqlDBtK5Mm4pnLez+LdoMs8R8eJhZTvEK75BO5QtB+HHICpDm+cv1VUMo/U9X39t2EwTcD5kHdFrekf+myFAz0BLmoI+m9MA9p/XeXR9Eju0n9L0nhq+VjVu2LR+oC9KWihMmcVX95eSu8/Vph8T6lCiLEtUS8iY66HtBIYal25MQHU+ciHenYTl7GJL6iAdmz+2ZFtrtxp8y4GTMacRDrjGsKhrabmrjgDRvXRYZjYqIUmxxkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39860400002)(376002)(346002)(83380400001)(8936002)(8676002)(7696005)(38350700002)(2906002)(66476007)(66556008)(36756003)(26005)(186003)(86362001)(66946007)(6666004)(52116002)(38100700002)(956004)(5660300002)(316002)(2616005)(44832011)(6916009)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tCHyxjWwdRwPA2SNqD8U9df+ptdN3+o1/TcOlwe9Zn8ZnPrGuq+AD6nfjROR?=
 =?us-ascii?Q?AyYhdNIU3yygxIa0fFfX9IOjNASh5LZfLhtzdgO/PJDv2zWM5TTE1bduuDQW?=
 =?us-ascii?Q?KutkS2TJdOiWMUSSILgu0FLG9bsu5MMf9F5PYx+bvBVya+n+MDLzg3vKhz/x?=
 =?us-ascii?Q?+AnpwESc2ZBIBW+921T0/vqYEklPo9VZFiQgxXlwmSp3G5Sx/oJ8/WzBa66c?=
 =?us-ascii?Q?poXc+VQou7t32dY80RXzGb10KNrKGJRnN2E40XvXNW3UQa8resYKBy4cxbCU?=
 =?us-ascii?Q?ugMQtqBU8p+/Pabw1fRZ0w1icLvI1tbmBZ47/ZCJXitWqnzpEJ+Iy+QsOoMd?=
 =?us-ascii?Q?nO58c4FYd9ukChyltq1aO8xP8/oQ5RDNJOSeBG+dlPAW3epkeroIiM6Gxdjb?=
 =?us-ascii?Q?J4mxWiuKnEdCvHwIJhZJyD+c3QFD75Nz8plzqYfmYTPJhzw1+zVGPGhDUAt8?=
 =?us-ascii?Q?llM7y+wHnbu5TyIRG7ly+PdZrizsQbdyKANU6sfK5IGMF0yKg5kCAoaFiMbQ?=
 =?us-ascii?Q?RXAx5fY3kH8xRNB4raBQq6SB2XSbklt0QjiOvRjUqIQ81EK1wlfIqQy4LJl8?=
 =?us-ascii?Q?iDmyD9sgpUC8zFstl8uajlj8k56LQOD8NT0IjZS3LVORqOKkfpFMRt9B9Frb?=
 =?us-ascii?Q?RmKc2DA6xcVpVNaShNmc9Gf2gzcWye1auftd9T8KCEcn+drO8W5KDKl6Cmlu?=
 =?us-ascii?Q?kni+c9J4mQ+nipDFX7ARGW/y5eiKtA5ceXI2BAehXeDes+otZcCTP75pdLno?=
 =?us-ascii?Q?sWvthZ32nC9a2lcj0K65IgdW1Zo7V2Qx5Q4KYWDCyLaKkjr3pVNX4lsdpskm?=
 =?us-ascii?Q?BTghAb2vGVhOmRz2HJ2tYBlJ8ItXlJ4GY5Qxd6UL1TZQ9ZPLY/tWFXQRWaqX?=
 =?us-ascii?Q?hBQgvO+NVfvugKrwr+XgZZ7vrN0nmYePzc/MuWhsM73jY2GS4kbh27zmnx5R?=
 =?us-ascii?Q?oe3Oog815DX7+yRp3b7bZYJ7+HlT0j70GxIq/2VLf4iR3314r6GtYHOWdyHj?=
 =?us-ascii?Q?HIjk+SJfmvPYgWdlKgb30oBXlQH/5ZcaqTcEApOFEzps4owURDcMNWoF1V+h?=
 =?us-ascii?Q?wwQi83nHnUIf97vyeoeg7ceMH0/tE28ZClHsV3SMpGLQ3PawRDvgmFvFC+1Y?=
 =?us-ascii?Q?6LwZ9EH6dL78MPjZ8wjkSd3Z3dYg1GIfGKsU+cHzG35uMMtMyAQQOJ1nWJm/?=
 =?us-ascii?Q?on/aX3RF11SJ73u4L2yQ2EVJvckj7/Y3A8O+3w2ktt9BR5PbzMEVAoHICWIx?=
 =?us-ascii?Q?vDsHcQigdZodvmjETmZLjvXMWF0Oi5wXsEo4TTBmhazLKkGBFTiPSP1fdo86?=
 =?us-ascii?Q?LfnfMJ4jKcbuosrdOVKCyUEK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbaa0d0-c4b9-438b-58b1-08d95c16524e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 15:48:39.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUROQuVFzoFhFhsRoI/x9o9yI7+ADDhqGIkT5jdYnTdL2x5LYigybm7doHxhgVnCPLc5BTo0W6pR4+WjZmAzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5281
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100100
X-Proofpoint-ORIG-GUID: 2yihn_VkNNgqytkBgJ1HKdQPhMsKISO0
X-Proofpoint-GUID: 2yihn_VkNNgqytkBgJ1HKdQPhMsKISO0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_chunk_readonly() checks if the given chunk is writeable. It returns
1 for readonly, and 0 for writeable. So the return argument type bool
shall suffice instead of the current type int.

Also, rename btrfs_chunk_readonly() to btrfs_chunk_writeable() as we check
if the bg is writeable, and helps to keep the logic at the parent function
simpler.

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

