Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A0775AA1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 10:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGTI6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGTIvD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 04:51:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513F2686
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 01:51:02 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K3P392027473
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 08:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=hMU55l4NWqOa/I/9JS2t2xTJlmX/6PRPJarAMJkOK8k=;
 b=M+8rU7JcBN7Mx9Xkj/4YTz1JWCy8qWczZp1pmfEYXLY6NWie+u1OIr5xbHwbjM7MxRt+
 itzMOm3G32pGbxmslst0H6MDkw2IRgWchYD9QG9aB6CMNR902suerlWv4qQJQM134Zp6
 EIGcMbx1JspXSobJB6XPZ5ScVwbYDl5YhlCQC7LrFjA3iBldZSTndAQkqhbzbiLum3/t
 b4yneNt+8xRad+vXg6gPgsBWuGvagIp5djLh8qNIcCqnmhTeQaZNUNNtaA9V8tDw2A/q
 PW3rpT6Bt0LIJDDFKV5rrmUf0l98QwgRVXqwYZwUPOsE+Zm5cHXgA6afa4HA61mMMWbl YA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a1cpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 08:51:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7EiFo023821
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 08:51:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8k7xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 08:51:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZTiW8b2hMqV7BMK74pOZVU4rX/JbuQ6WqK7DRSSFdZGHNTnwQYML5dK3coxd9ENXrBZMtjFTfqIUL1NKgQhVatBkK4ytVX844OEa42EDh1om1zrNfnDrqVyrJoYHb81XHR/s7BqJ7PpIlLdCsx9SXk+PAD3BLF/ICmEAkuz3ZjVTlJW4maMYzGQu33zzVhy00X24xUucyzlSCX0ULtzkl/1Rc5KOsfpAZwsmsrGBGpC8vtSE9zEfV6PIcPduotPE2zL8sVtk9RIVUMjCRn9HrRys9wwQzmC303hIGEfxCoOGCYX3vERUxtlspKnxmVTQPBLTHuWHUciR+mzNnc/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMU55l4NWqOa/I/9JS2t2xTJlmX/6PRPJarAMJkOK8k=;
 b=LERe7rc1G6ZNe2QI7QywPCaPkDgcX8wgw9TaLlLMC5Z2sqLUKosXPE9VcVfMIsk08QeIuMaB709JqQrLcFb4sSZOuvEmjYtB0/ZIy+CitJUBQDoZ2tXcLNX0v0Ksg1CAhvHpC3D6tlV54V4sIWURCBDrjEOb0kT0aIuy3Q3QAZW+mlBuIWCFH/hiuj4ryWKeyixMjJezBFRU4ijTYCNpxXDqe3xihhVk8pRpblWEfw7+uZK1gmiJKBpQze/CoVRHkMUVT+/SuQworWr46NCQR95Q/FOKi8aMt2Lv/9eS3C8fhcMIjSrhM5timBBs2Qu7v693igf4Sos6Z9wElrTn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMU55l4NWqOa/I/9JS2t2xTJlmX/6PRPJarAMJkOK8k=;
 b=lUPVTkVoOqktRPle4X5hH51B67H7FJkTgod6p7ZAyJXQmxhMlNeaqtyjZ0BhiklsRm5NQlDdeD9AVrvWZq9301TrusnPSTWtC7NOVbrAYiejQvyL8zu0LWiccxuw8jbUQuu1zpA//S3s4mLei+HOa1lcrI71ZntVKAoj9zswP/I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6823.namprd10.prod.outlook.com (2603:10b6:8:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 08:50:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 08:50:59 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: dump-super print actual metadata_uuid value
Date:   Thu, 20 Jul 2023 16:50:44 +0800
Message-Id: <fb866ae05c7694093f3ba60e7aee39779cd3630a.1689841911.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1689841911.git.anand.jain@oracle.com>
References: <cover.1689841911.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: f75e883e-8cd8-4248-afdb-08db88fe7029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3H4DsJgZWgnC6+Ij/Hpxjan7oLCzECqhCY9Ad+89mY8nWcYxWJfwiIUFNlvGQ02lUTaKh4pZ5ff8bZkGZoVDzMUrIGiCZfAEFYtU2Ti9L24Z/G6BFmXvgD8t7UM3ZtwM47U6hbjDHxASMns6MH3D83+dviOujGztvE+BDNZpxNskscVAUnwKiCF8o8tvKkjJSHS5EbSkdkk+5NoNvWmCOItnpSlbg7JXXpVv0JfGTdAVgZ6LIwEVwTEEbhGGRx/flSFvRLpSmd6RGaltrHWBm+9fLWzjjAnriXJKYYiFKM32Ax3KRHaqOtWciDs5rM+Xgfz6Q8CoPSFe3IhIv107dk/7j1AD4YWaVaLB0bbpgoV+Ce4rG/7NnfKbAFdJD7qj39aBwuzWBcI2qGwD0nRiGUi9qUgqCvi38TLbuKG5nocuiIU/rK/aaXFuxxyZAe2a5yJqLGp3Y6A4KbMdpi7KaNZfS0bV9l5W/UhSHzYtSzZ3Zq3raR6QbdGAAbzZW1cLijwWoOHCRCb2u/FlQCBxRXZEMiEMga0NBorqhJqvt21CcN/3Kur36Ha60viZzNxL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199021)(2906002)(478600001)(41300700001)(44832011)(8936002)(8676002)(5660300002)(66556008)(66476007)(66946007)(6916009)(316002)(2616005)(86362001)(36756003)(26005)(186003)(6506007)(6486002)(83380400001)(6512007)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZ4Wyv6RZ/L0UjBiZjR+ASYSKPHb08pJrwCe64mvCvchCL+94KgcKiMuKRyv?=
 =?us-ascii?Q?tdhIZVRfH9uZbRyU0YG5BAKFGcQ7J+9m1DU5XgiWbR7IotTT70opTTNgGziN?=
 =?us-ascii?Q?Vpljg85HlDGZ+W/pEsOshxtD3yJiLEbyldfMB5G0iSx9Sii5cpwZbNkZwDtV?=
 =?us-ascii?Q?B15HRXT0nJfs8hTTrEZfCZv+4sArpdxpRK4pQLzVwN4ldoP5EBWmIXUC1odz?=
 =?us-ascii?Q?uNWQzuSHzvgqVh0J1jJHJC9XVAmhLH5/r9zNwVF4qd37ZMn93D9Uj4KvNQf7?=
 =?us-ascii?Q?1lHxFb/yR2MCJSMU0QhjDO25jL7gZImem/2gEHGMK/zihIBYTklqBRJbIUhj?=
 =?us-ascii?Q?/2U/YGXPKss02SgtAnjwEivqHv0XDnWb8uaWZpStVzvBg1YQdFVhin1j2Tk7?=
 =?us-ascii?Q?fBFQdf4TW7Xoj8XRUyUFBiEUcrqpUeuY11612Wss091Edgsm0F11Cm1hViDp?=
 =?us-ascii?Q?r0PZNxi6n+9GnvpX7V3omYsazmDw62EMCZ8u3R789doUy6tLbMqOP5b5LWrX?=
 =?us-ascii?Q?V5E3vZoD+wAfzcd+3mMhQb4gF/dMFhO924/02RN2H6+YvV23fyzGyjLawK8P?=
 =?us-ascii?Q?BSzJPd2pRDOd0lAncNTfQH9m6a60qXPMrx9gANy3IK9V/vwJoqyeaRDGiZl+?=
 =?us-ascii?Q?2Rqjm5baRAAZLticNq74UKFegqnZp5ZDgpRb9ty3pGQjtWD3j2/P2NzMaspC?=
 =?us-ascii?Q?HrFd0IIBUUYryluNL5DL5DzNOudy5onHjfhfWI5CwhG6kj0bCkcmq7G9bEpY?=
 =?us-ascii?Q?dXE8K49KX6zYABKCGPrsg2fvRCjjf3U3Ihg/fj0J+67crzgHZlw+PDKsNp4c?=
 =?us-ascii?Q?0bG6iRyFFAS7MsS8FtxGLqeoK0uJLFfkYL3bYPyXDKKrHJK8keXK8+BQ1kZr?=
 =?us-ascii?Q?8Nj9E35VAC5NAP7GD8V9+u52az+WXBDNpVCpA3tOKHWzNqvhpkfC6SK7RdsF?=
 =?us-ascii?Q?kdVxSqDwn1Kyma0DELFE2H/XPeCZoUiy8VmjhSy7symvbYw0vwqfftar5qDr?=
 =?us-ascii?Q?5k+fPdmZb/6xeeXnI65oRd6TTr/8UOsJy/DrZnbCFZ2OXgSjNNm4aFmsfot7?=
 =?us-ascii?Q?RwtSGmBzLDF7La1FavGDtHN1mKgQc2YuDIcEeuzOmxL9ooeyEb6O7uFpeLOL?=
 =?us-ascii?Q?p6sX7SA8LuoAO8X21BcH/bvU8QpqPv3YKOMfW5Q0cJQ6+0YQXJ2iS1G7Tzk7?=
 =?us-ascii?Q?1dPK/3tma2t2Btp3j8h2mAHZZ6T1gmUQv3YAVoaiB3jWCMTUbjQc4TYrCcb0?=
 =?us-ascii?Q?8F3lK/6f2NG9zLAyMnbosFCfyelkbYTZLPbkn7QWyWmZWJBLQ+UxvHHNVHek?=
 =?us-ascii?Q?oa8kMNFfBeTPvgljxD4bgDsFJFcz9xI/sghtVOZeDwDOdlWorSET1e4dpCm9?=
 =?us-ascii?Q?3D0yNs4XW19gqb1cP49UWzYqZjsdDpohx+kNgiiQRDSWkHtu9XpYW8uCuLva?=
 =?us-ascii?Q?X1lyXFbRSucTUfIijqfnBkP9TvGY8WzPBecYhgMeqzu31kR+7JNZXxyxOR5b?=
 =?us-ascii?Q?KmM74Zn2r3JJbdLrM7Zp278Ag0YwmUT+LUK5UP1SlVtW/lyoX46qgx1J9s2g?=
 =?us-ascii?Q?FOKmCacmeTT2Z1+3r95KGiljn+tS6GHAhzT7GFy3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uY2nf6GerKk4kRhO6zq94DTsEONLXIoJSUM1AGFvADy6RrZjPywczTX4xB9yI2GPouc/zinCZZZc7Bq29jS9k9lAO7encM6SWZn3/dASeBBoW8fFZr8EBH6vddT60HQPH5/ypupgAgYZ8RZyUuPpcQDVUHfZLvLLD+ZdMFxbj4u6g4FDYOXpPcNllpJHJMnSGeMqVxSlsEu4c+W+sO0jBsaEY+NHA+6bFhydCnKaEsQeYoa63g65j1Hipgxj1YzWPf8rgPQNuXVPQifpMvMI4QkeH+dm4jTf35gFAvVohuHWZIaD+cW9S8uDmHJr1Ii+dCxDzouz0EgCYqBs0cOrSgQDC5uhHh0j3pZoKX7Q5XjG0XH6DOm92OedJt0q2pG9Xr1CSD6W82yy4U9Qr4tlqKThIOvJkeWpc3AMzCGWgo22VjTWcYXXieFJGkkoqZtk3/v8kmZtWZP49Dt3uh+pAWF3dqKpZ4KoC8k384HeZ5UxIPMqwGLQrERjgi+AUoT0NKdXY/z/R5uh3oFm5iaxBDdmo/2pVBIuX1JyjUUl6BLy3PyywNoCydywZI49Ysz3sJK6g+R2Qi8A0vxJLvqF+vH2LLANgVj19mEiplQY/kLOCpHq4H6MrFn3KYMDELCnCrp/X5aS8BZVgIdJ57nt99ST3TCOaSXcHJiI+YeYCZcn9eMemMkNG9kYEeyjcTHYRLIjUNN/CRq3VODcnvTHxqLFI/E+0FYLyZmn8tRa63iicepiFLilYY+Bs1IM4+RNKNicmxY5fae6rz+VWV3hlw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75e883e-8cd8-4248-afdb-08db88fe7029
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 08:50:59.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7iEdaYQ/O+2XbPl9S2FNVGhoy7sb6trwRx9d9Im50FPQJ9yravKEpESa+1FYjmihQuLgK6ma/RgJrfDmQXLiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_02,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200073
X-Proofpoint-ORIG-GUID: bQkcG6sn8_6RXB9jtbrKjZCcF1tQHgqj
X-Proofpoint-GUID: bQkcG6sn8_6RXB9jtbrKjZCcF1tQHgqj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_print_superblock() prints all members of the
superblock as they are, except for the superblock::metadata_uuid.
If the METADATA_UUID flag is unset, it prints the fsid instead of
zero as in the superblock::metadata_uuid.

Perhaps this was done because to match with the kernel
btrfs_fs_devices::metadata_uuid value as it also sets fsid if
METADATA_UUID flag is unset.

However, the actual superblock::metadata_uuid is always zero if the
METADATA_UUID flag is unset. Just to mention the kernel does not alter
the superblock::metadata_uuid value any time.

The dump-super printing fsid instead of zero, is confusing because we
generally expect dump_super to print the superblock value in the raw
formet without modification.

Fix this by printing the actual metadata_uuid value instead of fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/print-tree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 0f7f7b72f96a..d7ffeccd1e89 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -2005,12 +2005,8 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 
 	uuid_unparse(sb->fsid, buf);
 	printf("fsid\t\t\t%s\n", buf);
-	if (metadata_uuid_present) {
-		uuid_unparse(sb->metadata_uuid, buf);
-		printf("metadata_uuid\t\t%s\n", buf);
-	} else {
-		printf("metadata_uuid\t\t%s\n", buf);
-	}
+	uuid_unparse(sb->metadata_uuid, buf);
+	printf("metadata_uuid\t\t%s\n", buf);
 
 	printf("label\t\t\t");
 	s = sb->label;
-- 
2.39.3

