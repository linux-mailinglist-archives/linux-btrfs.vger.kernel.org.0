Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9327767055
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjG1PRE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbjG1PRB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 11:17:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA9E187
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 08:17:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF4OgL021201
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=B7HtQjEwOn5/0KurabXItXa2dhqCN968zO322fUu32A=;
 b=lK4lQHSIqtV02M2gmJerKB97OqcaCOddynOynETM86v0Cglxf7QS1HJ4F9ys4zDHw3xz
 AXSekAkkDQCRSyTrFKMpoc/rpS4U69nHPigXI9jumxSkJA2+gBBcDAz0MsXZmknhx6nF
 3F02FiebQSBmBmwzz82/AIoKcNZx9cMirKwFW2wpB9X1Gqogblg/TsDn+DVl/vEsUMtR
 0acRyzAqqlwuUPPh5sHhKZb/rGnvxs/Idlj6mgCyFtvWGAESMuYIAgqMyGco7Pkdprbe
 77rLk0niejHc1s/ybkb0sGqqoJFKWrokaHfgQAKV8hXW8mvWpM9hlptZMuSlewaYWUsU aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qu439c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SE5ZfM011704
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9ec50-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKXBG0OaCCmXQs8/Kb7YEuJJtX/IGs/OAMbyINGGaFYflOM+bknBk/5kGcuTo62iKTs98nGtp2gQDiQlMK/K9j7awSs95xDapmW+hjOcFkxlQppM09K3EABJwnH/u1czM4d+a32kS0RoPlTVz9zV1HcFjkE9SmQWb7x6y4jkfY5NQZlqc1ypPs1t2v7/9dt8VPBvsYYB6I0HFWefH0smF1Y62yvlmHOAy2Foo5KrGDf1kfZRjps+In6JvhVciGhPC7K3kHF0jK57fgQA8JvJA7oOpRZsGA0QjiUf8N0S37ZbLwwPYbmvfl6glZH67gzWltmetlploQHVNkYehyNnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7HtQjEwOn5/0KurabXItXa2dhqCN968zO322fUu32A=;
 b=RMTW5iFNMnwvxnc3EEfLMsPIdcb89OJC2XVAvWrudyJbsYkKYYm03Kpm5HFjG96d7vpBkt0cj/ZCkA879vXRVJdUySi/Jxx/kFfrEwZXIAjVjLduqyEpRr2kDB9VYD4wOfHH2K00sKiK9ECeLYfAVDMn7LANY0OQ8TjbXdWeEjb6b9h/dv1fSZSwT6XJxXw/OGcV3bwE3kbocWJc4JX9TeiCsovYz5ymHLWTRM32RvFSZ/rmP0cbS6lyp2SDvIuA2N52xKeFSZaXy4tka97vs3GV0br92qCRf0i9cC5zfQG+9FyqsPmAIb8Bqs3dUEsBteOGpnJSXzNqMpXWoW0LCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7HtQjEwOn5/0KurabXItXa2dhqCN968zO322fUu32A=;
 b=CPfWYQT3mbaFe9bLwtnqN5t3PfB+dXCLQK59EEYh74hGHPtjdV7BYgIkxXEioKWl0J0c4gKj4Z74ZWOLg6/uxBgBbNM8TUInVPYY53pBngeKJJssovILmCKOu6ltgMWkgy6oinlGhIHSnLEu8BsiAAHZ6+zVV9iwyovopiAcrAY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ1PR10MB5930.namprd10.prod.outlook.com (2603:10b6:a03:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:16:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 15:16:56 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 4/4] btrfs: drop redundant check to use fs_devices::metadata_uuid
Date:   Fri, 28 Jul 2023 23:16:17 +0800
Message-Id: <2f9c32327b7ae064656675459ba656719411928e.1690541079.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690541079.git.anand.jain@oracle.com>
References: <cover.1690541079.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ1PR10MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 14be4b34-335f-4304-4cb7-08db8f7dae8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CFT75V9TlAEvv7NahAa04/nYHYOkrS4ynqDektnfY7MwG6AR4utX9M/vE0fftuMSUBl4vioYc/ij4oyEqstpB7hV9jKaKfnc7QlCQBnDGCG2EJ4pcT1one54GPFWeS4t5OzN4uTI17wHLqagmldDzVJXPoTbtWPHiNaGpOZ0fqqQILi7eQWaZyIpRh7KzI1t7ZqC8gIkd8nKq3QbvBBspTL3pfLJWMDQ9fRVvg1r5yY24U8k5ZbH7hb9h82S5BkVnoAE84LZ+oHyrTjQyxCYVuJj50sKwFdA09QIHAI1UZ/5xdrH0Tnjfwaqx0WWkzDBPNNp9qUpR9b3caRvQrDm9w2wbJkBUIqIYSra8JzE0ElyXBzLEOZIdeIHb9V6GmQtDGtYR0pi5D3vF96xxGLO2wAVXgFoYkbTz9RpfUuBpKRiMtvkonHJMKRpiSGmvOlLFQD3MIfDFxRNZdd/ltfc/R02IaX7bX8InwEe6pO2Td7nDZ/+QW9DrPGRcEzINSq235yf4gvZHG2A0/FjVG3eysgZ+hLUSs0c6ZiuXLoUraANk88Z2+I6muuMyiz+JdJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(83380400001)(26005)(2616005)(8936002)(8676002)(186003)(5660300002)(86362001)(6506007)(107886003)(41300700001)(6512007)(6666004)(478600001)(2906002)(66946007)(6486002)(36756003)(38100700002)(316002)(66556008)(6916009)(4326008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W2fU1qcHJiHn5wycQXTeLt0Yk5Rrv0imNYoyPXYB67iwJHlr7MtoCw40AG0y?=
 =?us-ascii?Q?OR1dKmsoyX2LLKVFK81nmUJWYO3DbLWa2XfCIiLUgL8mWMSvBFLO/IBzbISi?=
 =?us-ascii?Q?MXPynH4neQluvEUoPnpI4vLWVf1Lb8S74NdGpyzrSwXrsmFWabqvWh0jYs5U?=
 =?us-ascii?Q?pOUzMgTTtZWrHU4siEEwGlYd5LOwBacVkFQXq7jBwhp8OMqqH5OMcWh5RuHk?=
 =?us-ascii?Q?eBT3BVRdBXboYBsX5Cn+YvmqfNQ5dN/Wrx2wr1Dj3Wqu0XR0/eA4d+K/Aqpl?=
 =?us-ascii?Q?OcndgbsCn6MnQ8fG849ZbaFvK1FuEBUBzqOUZlHC8FVfxTW+L/QASvsWY+Wz?=
 =?us-ascii?Q?ZWhHkYZ131lPLKYLxtK5NUG6ZCgdbsRtkRBD5GnKe3XSGPXfIAZFda7r0kk9?=
 =?us-ascii?Q?KUXDKtaogLNnG62YKPVrlduh6i0v4plDUkzKz4jRP0qurQbr/qvH0eWW1UKs?=
 =?us-ascii?Q?awDEcvG4zsO9LvEvtd9AftEabSo2m9fzNsDDcLA0NJtE11mj1P4YNLSHAEkp?=
 =?us-ascii?Q?eainBChbTE76cTU2Jt4FLNEOReRHRyAOpmQjysDxk4mS4wbdGfP+V5lZSbw+?=
 =?us-ascii?Q?7hw6158SSJcU1pTFaCfGsXjvUK24Ltk/6eZgamFtMwmnpE7qImm3/pZ9trkX?=
 =?us-ascii?Q?dlibQeUUfIUt9TNhxRucVnxw1wUS2jtrpyx2GiKJo4341Euj2EiaTGuj1Jwj?=
 =?us-ascii?Q?Q2yNilTHyrz8yrxu9t+grRgobgHFWMH6vDRAmxCPfeR/Co5j/jO7dK9T+3UB?=
 =?us-ascii?Q?6QaftKo+RThxsiLZB9f8i2tFtlKT2JNF1SaEJeXEZSxzWl36MZ05LW2l0QlW?=
 =?us-ascii?Q?iSimm0wRKaceY2HxPNaxTVWz9eamX0bTmg2ztWUewa1qOIsbnRDqGNZFXOnf?=
 =?us-ascii?Q?IMbnnB/sEp26p9e/DGOzmvBCwU29V3ahrff67IlzkRG+6vIPDAeiOPP8sJWl?=
 =?us-ascii?Q?Z4fU8R5FCv5aEUE/sB46DmxVvDI+vexfistJOOOCzyR7l2k0CsYoyThaUFeA?=
 =?us-ascii?Q?/rJobQ1jcRYUZOGM2yICwIc26P3ZcIHMUsSCYQRMZNNDtO13rM0rcuTZRRWV?=
 =?us-ascii?Q?FmfSQ+Zj7Zs5S5eAI26rSyR3GESGcEMvIiXaDlzRJVpE5Y01XQfJnq74pYSu?=
 =?us-ascii?Q?wqSowEmZUdN5k8W9Kk6rZe/o+RLAfqrN5lYCVa4ZRUekj0TwjYrsGnZlDP9g?=
 =?us-ascii?Q?EO674y+IxlwKjAUKbbwCEXwCDCv89JWTs04JTVwlmXliZZzHd3wMORjWln6u?=
 =?us-ascii?Q?xs9yyptfSzad7/4xjkOOX3YBaYzDMNfaikyVN6824BUsjyle38q0Uab7Jodw?=
 =?us-ascii?Q?7xaCqX2xuv63ENkouzs4Cy2s5N6rMsuIpwzJT/a/lKz19zB1UvDKBG6+qMPs?=
 =?us-ascii?Q?ktx64STmvu7rNO0RdjQyU1fKWgwuGiP0uFjcjpJYA+f4gheAEnam3Ba4KPgv?=
 =?us-ascii?Q?aaq4sfTHj7itWzDJEczjZJHLp2HJAdP7Wn14atjuUWOqvsulZdjaKbtqnyaF?=
 =?us-ascii?Q?GIdB779hCy8M1HF+su9XMhn3/9UnY4TWedx9RA+MEQFk1nIxm20RHBSfpJxD?=
 =?us-ascii?Q?TO0SFiI4EOdBCvQX8ybO0Rmpfm5X8ZcFHByYJpOY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5G1zmAaIT5weWiPAA76emaPVI0t4rIFTxTr7lFHXhLMrgImkzbUzRY8IVoJgr1hw6/RzM0OhvTM6NaZhVZhC65hUiI0A5UDOIxKy2j1YRj2DwBps+a7VW6+ZuUofjSCmv9eQYUjHQcJl3iP0vF5fDjCccGVdnSu4ChuNfqwqhQL8OB2j6ITM3Ad7Ld2bVOh3NNk27QB6qT++3C16z2TySc4BfeVrYPZ1Q1vrRsomEMkJoqM8oDdZNskMmPWPFlGjjZvVLN1kNczq//5/d6Q0TTcfoVN2NOcvOa2g7lwJ6U6sjEPhOAqAhY2py4eFwMZ8EG7qu1pj7wpHT/jKW9RRfDdOXTu01iXrjNHPto0SCY35RLknNhqOfP+oCe5A9C843PKPT17RGGmhrXX0b0jViU5Uk5TfMnGLB+veId5grA5n6sCw1meD2HWeUCYuSD516iSW8QoJ7UYXLpQaRjtisvcqQlXxfNlnq+T1M36rkl3vykhzAd73afJaRelkjsNnIf7dRCIRreVl/75YfgOiTg/8NAM5IHMY2Ywy/+rU21Ii77Lb/RaDNNzNvQP31UW6vKAfJKhzpd/JXBXHfFWmq7dOc94T2Dl/x2IUJb5E65gEddPk0/5k0alyf+I7guhJ/Wyat+Jko/hv3g9nW4QHtKgJEUDkNpSHCSsOKWzDg3kR5F6JqyygtmGy6WzU0wW+eG9wlBZ38QQbSPRdBIu4xiNQ5adydMJoZvhcvOPUsbEfWzNV8Rv8AbpwFU411VvzaoOkYXbhE9HSd7H+Z7EJWA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14be4b34-335f-4304-4cb7-08db8f7dae8c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 15:16:56.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUHdrxl/oFeirr6MgZTHmChBNWVPCAh9qqMbBn8gRTgy72JCDfTzUdeGHmiUAQTbnMk1ydw690l3cv381lF0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280140
X-Proofpoint-ORIG-GUID: lRCb5jh-XlDoIw7HC9PeNrTJzdu3cWhx
X-Proofpoint-GUID: lRCb5jh-XlDoIw7HC9PeNrTJzdu3cWhx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs_devices::metadata_uuid value is already updated based on the
super_block::METADATA_UUID flag for either fsid or metadata_uuid as
appropriate. So, fs_devices::metadata_uuid can be used directly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8d6d7c23d37d..b42de42bafb2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -313,21 +313,16 @@ static bool check_tree_block_fsid(struct extent_buffer *eb)
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
 	u8 fsid[BTRFS_FSID_SIZE];
-	u8 *metadata_uuid;
 
 	read_extent_buffer(eb, fsid, offsetof(struct btrfs_header, fsid),
 			   BTRFS_FSID_SIZE);
+
 	/*
-	 * Checking the incompat flag is only valid for the current fs. For
-	 * seed devices it's forbidden to have their uuid changed so reading
-	 * ->fsid in this case is fine
+	 * alloc_fs_devices() copies the fsid into metadata_uuid if the
+	 * metadata_uuid is unset in the superblock, including for a seed device.
+	 * So, we can use fs_devices->metadata_uuid.
 	 */
-	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
-		metadata_uuid = fs_devices->metadata_uuid;
-	else
-		metadata_uuid = fs_devices->fsid;
-
-	if (!memcmp(fsid, metadata_uuid, BTRFS_FSID_SIZE))
+	if (!memcmp(fsid, fs_info->fs_devices->metadata_uuid, BTRFS_FSID_SIZE))
 		return false;
 
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list)
-- 
2.38.1

