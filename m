Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AFC76DB8E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjHBXan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHBXal (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:30:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929252695
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:30:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiGDm010854
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=ItkSvp7JVJ+uAdvNvF0f/SMbKoUJjoC9sUI/0UoCXQQ=;
 b=ywo1JhLOolFyptgKTxXXT3z210LWbgWa11HKq/f7AZICgP/loKFpZPzq0lrUz5zjqeh2
 v2Hx8Tncm4ZSuyy6eRJ8BX0VTUtAGM441up10EN8EGYN/pNYThnbR9rLc+eIDv5lc9DP
 eR1bGCfp6yF/8OS5i+2aLQfqOL80UzVqt45mK48Bu93z7dRAIYOT9QNOzCTZmyG+no/V
 mR9tG5XwIqOPa3ZfcAUto62p3bQHpbbWMdcQwQ/4ZVASWyDbuRTjQmq/hdHBoggR9v8Y
 ECvEacmTUCgKN6cd3XMF83wDDY/7j9SPYVvTyVcEc3D/PzWBJ8s7LJyrCzD8dj+CZY7z hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcu0ct1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372Mt1nB006697
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78kyru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxK+BHAzb9ah3AOD9DlpXx3VST5+nxKEXcOzDayyviXhx+DvCnmhNkXCGFupFd7siCfd9lvNdwxuelWaefFIIbZ/X0gtxp9nCdRfBdvLpm+epHkBpo5Q1hNDwNn0MTyLUduA6//xYemqXXuXnhNz9ZgQa/fxnJ4ycyhhhaa/9tNPxxZHgEEvG/w7DMwHiTC5iVuHMyiNj6EmfpSACKqocDE8MhBnVs/9PJkq2NclUfFVf//mQM3TtgNgOk2hqIODHoLcKM8/3PDA8+6TuC/J3H6/NRLF2hcCa9pvHJ05NJtPDpniBUGP3FRcZxtJ5DDuChzZl5KvA1Rk2cNQnVsbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItkSvp7JVJ+uAdvNvF0f/SMbKoUJjoC9sUI/0UoCXQQ=;
 b=KXucOcW5W9QR4gxwk9wy0/inQYeMXreeXe7upWH8lpjzh8Z99eF7UvfVIJZJyxO+8CHbONjxdRdl792GwZ8sSronu+mTnswo//RpSJhlUrVePPT/2LnkgZ+rrAICwdpCl9xfGQL0q1M/fWZHAvM9Qqy9AsMaoCZA9WPlY5FqRuieZRekFhd4J96IrQiVZJ02okCNGEHJVFZ1Nj1yrPAa0VHopRWda4rFY72rdoiDQ2PxkvI9n/V/PSzkGM/pfVwsMjcUAkkj96VgbSTXr9W3ABBtMPFUmafjmFyQsOnoKxf12T64ebYnBzB2rkG6raINZIyJIsfTw0R34HDEUTIBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItkSvp7JVJ+uAdvNvF0f/SMbKoUJjoC9sUI/0UoCXQQ=;
 b=cCXmKvCvDU51XsMySNdGzsDJAX0UY4p/FXojxGDP7DyKo4leHY1YsraMybDhO5wrQqhXMcfDVmWzM2Me/7XKsTp2RD6gWbdZTvuceq0DfUHPFLp9GvRd3P2r/xRg9ln44SMIjg1kU8JI31L4vZgSJ7QGt3BxfTI9hWS79X1g3/M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:30:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:30:35 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs-progs: track changing_fsid flag in fs_devices
Date:   Thu,  3 Aug 2023 07:29:42 +0800
Message-Id: <3bc9ce3332f6e69abfd73a89384400196c995da2.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
References: <cover.1690985783.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: e77a781d-65b5-4eea-1562-08db93b078dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDTsBD/aMiaBeQLyfKDniznuJX7LguDYS6+KzRpcuO+QiHa70vKS1gjW6MlMBdkM8/zRl5aekuJXhiksb7Va3GEbuoG5Sfk8yq54HpsvCdIg9XlZe2tidEqLspKEbW61Vh7/BOap8+4dVgXuMSUM7bobNWTYhqu1//pEccP/mNvGKfSwhLe9QCvliPdp6Z+DBfBlpMnvY0NFHDKVtUTe+hodeZyPdDq1DI7jEECR3rCAr1uiM1iXdv4ma4BYorP5D4g25Igzc9oShbVVD7bBk05adJGhPSJteUhnsxw1lpmzDDUTMAK8Dcae1P1bdS9cx+vAN7DEsPRkawAsZBB0B89nsXLKmCMpwzn9vhP72dRDoHiGibbKm/JCbOqPLlWAEBAuTU7eMcyBwkyfZmivq8Z0WVG0eEdbGe9Wr/lYXuCBSHa8HvcSBMPxVoOyJjBMKdWlF9RJ5JwLSbbkx/kM3TUo4EW2HDvvn8f3k1NYrkzEiX3jaXlkKmpDaUbHDUr2VpVAk39gL/WrKSeZEwJEHy2dfijfgFiBviVqZpzgjvMGP9k3vODIgnGDQgcr4Y/H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ImSTb8e22hDcPnjCxTto6n11Qx5yHGhJVtrDqw4XBCwi1rjZ9uEOfLR8EQG9?=
 =?us-ascii?Q?bp2G2B2fk69OaUP7f1sJz0vcI0aS3anqpIviuTEz4s2cN5zN0fiJMmAIPYU7?=
 =?us-ascii?Q?x0l3CSPZp7nCUORkgCi8QHvtUWcQT+BXc/+UX96tcfsQMlOIKRBmh/zdoI6Y?=
 =?us-ascii?Q?XiiG/LehZVli6TLWLFr4TigU5u8fP3vgMp8GPgmmdcwbjb9RO0U8coe81jEf?=
 =?us-ascii?Q?TtXlGoBhh6eV8iwqPHz2Vi075lJWdPThlBdYLIqw36AOxsbm7t3TX7Faii5P?=
 =?us-ascii?Q?GL3re6w4VTskB16GvtZbuaxaAPDU44lygWkSbI+cNw1arpEs+k+T+EbBInAh?=
 =?us-ascii?Q?RFAPKujvZZD0aUVsk8KBXnzyJWZCOsFWoBc1gba0GHu1xyWhCYHJBqW5NUvE?=
 =?us-ascii?Q?UpZZph7t92gqu5Qt66koQGx3/kbOR5HMBOGDLOkQCVZ/l/O/uThg1i87Jg08?=
 =?us-ascii?Q?FBxi01l1nSOTPQ2hUv/9ry7l9gx4lzEZiJrS5QrWEyNugIB7c/XFiLxZusa9?=
 =?us-ascii?Q?agm5T+gyn19uSB/ixw5tGh/Fin1tvC2s5vEKo+lxo+IX4ZOZTob5+SVUac9T?=
 =?us-ascii?Q?AF5ZmYKb5GDjaEftWbHXejvde7ZH3A7r6ifXDx2cl7M6DE3Y2IxpuRitRV2E?=
 =?us-ascii?Q?tPZdEIGR/e14joy3HqttBTOKHschewuLwn2wVepEJojggB28caVkEoLqTmvM?=
 =?us-ascii?Q?cwTjbq9NTtCTLsTXTfY2lUf+YleV0V67v0SFMpYe7lwQcFQBKbWMuUPSkuP9?=
 =?us-ascii?Q?Ctss1vYM3SN8i/Hr7ITmZdLk7mnIwTerNwnSysJEca9xRznHuggiPEbApDwg?=
 =?us-ascii?Q?5EgR3zm7Wmv1IcJylFI1u/eYE1uyzIOBcIXpxy5siaBwsYfGcwlt36guAjaQ?=
 =?us-ascii?Q?/G27M1vbojCewcTkD58nmZp6iU/kGUWd5qb6iEBYn1CouKBzx39snw1SuS8K?=
 =?us-ascii?Q?AvoYFI5nxPI6D478Z9aO2rlV0nRPn4sMOfKLwJwVgm6fOf7Xki/d5ypOWBKj?=
 =?us-ascii?Q?Qk+5iiug+bS1epB0rwyE+bxMIAiV9qRIHTEkFQl9jJ5P7xIVUPz/s0u5K2p/?=
 =?us-ascii?Q?0d/hiGYw1fqPTxiSrdsjAgvfF+lD27lSiFLlMZcAhCYeu2dE0CLegkdRscUA?=
 =?us-ascii?Q?/29mK0vVSiBB8OJTabstMiZF7EFDnbbCU6DAo9cSV5C8Sh/XPD9QeYxe1xPk?=
 =?us-ascii?Q?vQmQ7MgL8WCJBB6LN1luGBP+W0HTa0Wl3lCaiClGabPCmHNkoYLOJWWXc9mU?=
 =?us-ascii?Q?VSnqyFHZe385Ol6+YTSzQcZkt3oIgInlwM9JgyGIywUnOnVaSOmSoy6Nu38x?=
 =?us-ascii?Q?itojaHBnHh+FoZNmkZPLNBIn9TJXcddF9rTQOHDCjVbDSJ8uou8Ksd14TUtW?=
 =?us-ascii?Q?Jw63BeYoaSkmcTTE5SHHGq0EVkBQVcqX/SQSQCCRn0g90/fGQ1xT+ezhB8eI?=
 =?us-ascii?Q?kFGWrC/5WsEKE6t2b5RLFctK7ESCu9y9S8dAaecrXg9IY6NdHy7HDU7Vu6LG?=
 =?us-ascii?Q?WCTO7qBvxb78PXoNxnh57CpspVCP2XGSGAEN75qKAl+D3Jp4fziUpZBPSn/W?=
 =?us-ascii?Q?Zl8vpxsFTuPxc6Ck1AM4ZIuYPkiUVW+sosdQUaZP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UfHQ5cEj+CYOMrvTMNqwTzjJfozg9Xb4PCBDKmLMuWf4VnKvvLzBx6pQ2MkrI8ADciEw0XwVlx1qc4RuVELw6heHZo5s9NGMzkWNxO3a6w0Yp7mYLUtVJ3mVb9nuFcu7u59McSaxx3jYgsd53Z8rMiDSrcK769jxBM+gR3lH7REY/X1M6tSZAPOmxvz6YXCQMUhRoh1yXfRrrsNrksnRtdnHKfK0ivfsL/JevS58GinjXAFwwVfI9Eh4VArS+J8ni6AeiD4/Cx/6+fduQmec5tCqxs6ZIVX0NbzmxPL4K+YMFfnWtjYZ2NdAECLC2jXhktq16mfMvZYzn6Adu0fGyZy7Jy6BYk93tWZl6uMWMYSsfN+NZ7kuFKpRZ+s6KpgV6MWK7ZxUucMiHXEOBtifl9UXsIsmb4FvuZ4nk7RyuHBZ9em2OkJKZmCLbNW8ApLLuZSU7Fo8ZLToM9u0w7F/oYA5pGStRtjL8vHMY5NLVtIpKULxAD7Biz1iRUHNBnGXowf7mCyrNmuh6OaUZazp8mKRv2x+uOBNVIw76wFrUD7giEMM61yCZ9ZtZ3ofK3vESNRHs38feJeUSEZG2uZXWmBJtJsW5KV81AWUoUSJfoWdb6gC0S3KHxpZTiVICAhl47dp4tLzR+04JyqmsNptI8/Mgsa1W+SuBQNRvZ9GgXgRRrFyNQZJIrEck8a9MUfLdsn1vtxp8Ghe/GLMGf+Rdz41pNpKXCAdxQ5ZbbQQkEKQH/LihaneNQQcj/pHwTCjj1Li15Qj2tWXJ8xrJ/+6DQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77a781d-65b5-4eea-1562-08db93b078dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:30:35.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DU/Oj5y9YIaYdM6I+n7xKfi5iw2+ms9FVIxLOFqJF5JXmC7Vk0RlRrfr9imz5QDC61XGfjcR+VQdmi8B/5V93A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020208
X-Proofpoint-GUID: 3WFHmvkj8xnFDUnNV7ea3mSgr7t7dh_m
X-Proofpoint-ORIG-GUID: 3WFHmvkj8xnFDUnNV7ea3mSgr7t7dh_m
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To prepare for reuniting separated devices due to an incomplete
fsid change task, consolidate and monitor the per device's
changing_fsid flag in the struct btrfs_fs_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 9 +++++++++
 kernel-shared/volumes.h | 2 ++
 tune/change-uuid.c      | 4 +---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 54ef553e8230..375ceaa93de4 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -342,6 +342,9 @@ static int device_list_add(const char *path,
 	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
 	bool metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+	bool changing_fsid = (btrfs_super_flags(disk_super) &
+			      (BTRFS_SUPER_FLAG_CHANGING_FSID |
+			       BTRFS_SUPER_FLAG_CHANGING_FSID_V2));
 
 	if (metadata_uuid)
 		fs_devices = find_fsid(disk_super->fsid,
@@ -424,6 +427,12 @@ static int device_list_add(const char *path,
                 device->name = name;
         }
 
+	/*
+	 * If changing_fsid the fs_devices will still hold the status from
+	 * the other devices.
+	 */
+	if (changing_fsid)
+		fs_devices->changing_fsid = true;
 
 	if (found_transid > fs_devices->latest_trans) {
 		fs_devices->latest_devid = devid;
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 24b52c86562d..786add2c879d 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -99,6 +99,8 @@ struct btrfs_fs_devices {
 	struct btrfs_fs_devices *seed;
 
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
+
+	bool changing_fsid;
 };
 
 struct btrfs_bio_stripe {
diff --git a/tune/change-uuid.c b/tune/change-uuid.c
index cbfc8634168b..30cfb145459f 100644
--- a/tune/change-uuid.c
+++ b/tune/change-uuid.c
@@ -214,10 +214,8 @@ int check_unfinished_fsid_change(struct btrfs_fs_info *fs_info,
 				 uuid_t fsid_ret, uuid_t chunk_id_ret)
 {
 	struct btrfs_root *tree_root = fs_info->tree_root;
-	u64 flags = btrfs_super_flags(fs_info->super_copy);
 
-	if (flags & (BTRFS_SUPER_FLAG_CHANGING_FSID |
-		     BTRFS_SUPER_FLAG_CHANGING_FSID_V2)) {
+	if (fs_info->fs_devices->changing_fsid) {
 		memcpy(fsid_ret, fs_info->super_copy->fsid, BTRFS_FSID_SIZE);
 		read_extent_buffer(tree_root->node, chunk_id_ret,
 				btrfs_header_chunk_tree_uuid(tree_root->node),
-- 
2.38.1

