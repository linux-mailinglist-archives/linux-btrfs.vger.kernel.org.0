Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A9170D9DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjEWKEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjEWKED (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:04:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA01BB
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:04:00 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EqFp032516
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=axCAgLHvn9sOYnh0UKOYDPSfat6hLHRl+pAWTrx+9gE=;
 b=1kv2vZpk+BcEL95Mn4CVApjPW1mw3YE+3AUqwvs2Sd+4eDr4qHvKG5XtZOi67C4+8Jhi
 MqUlpN4bKOGhVFGTYfUj1NkdIwcngVBhWqYIG4YEzg/S6sKrC+IfBPjpM6hfyes4llJS
 c6aycVn2W4r297w+qu52VFK3Ct8M5Ev+Aiu8MnhxjyEP0NSfTTp2LxdeKfmJujtafFX6
 rGG11pucC7ZDOwUnkchf0X01JypCefRRVfveVfo4ZMW5z4USp39VBM9MYUxKKD/4A1H7
 iUxI7U70zNHSvq/16/Li1ldOi6FB6JmfGuy1L1fZ2uvyEHW1RDyCOIAW9NBxd7KOGTXg VA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bmrg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N9IURi028664
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:03:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2quhav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:03:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzRqf0Q79Mh9W+X2QzPo1zfFHed7EcW8RBgOy0WNAqV6BjYt/1ywC9dR2Tq6XPcGs5zI3MdGk02jeN+fAq8zxuCxCYyXyzqZTOAS6MaaKD76KQgZD4aJyUnMuE2qKVPVBe4cjW+lJ46cU2ACp5EuIOeJs/z8MZ634STrmVIzNZ7pc6X/19m1R4XxbefZQrwW0LHgOyiOsUdqdstEUc2ymEeWCgKoD0V2MVgepMsKvxfmiOT8OstkfMmVxzZRTU83d5PY8dffKkeD5FlelKvRB/FW0hlGcxQ+6l6MbK1Muu8WHQggV6fQV8S4seCfEawmxNCDi5qwgzaxa+UOVJtlUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axCAgLHvn9sOYnh0UKOYDPSfat6hLHRl+pAWTrx+9gE=;
 b=db/ErHFOdxPEAlI54brnaqql9eo4b/BH37ZCJf5kcS2hv7AXZXJnDBZkt+hyVvf5yzlyU/qy0LeXc1BhC88IHxhv0V9vkwGH096itaz4M/cxEV+ZFxCXK/8BfbkDBFx896lM2PIHVflxH0bsviX/Dv72pwmzs3Rabn5s3nP1LC9+F+G8l7GGEwKPaxARw+ZwJUDD8DeNmZR/yPGZmMTfm1+YyoikLL7MaVSmzukiy2osfP3Hi5YlP9xvGpti4VMvFj/8noSzeuzoWCsNUKJuM9p82E2C1bGyWVOpSCy9QLRk+hrWRB7eI/vtSHXSxEbOnuQXIv1EBulS4JCzwQ8Yvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axCAgLHvn9sOYnh0UKOYDPSfat6hLHRl+pAWTrx+9gE=;
 b=TmGVd1/3vvTyJigh2X9ZUJ9o3e/32PDZf9vls5GzWIe1SUcDIHEMxPjuuw9WgqzmnEW56Sn51mzh0o+sNfmuO7kRS8Q5k5BNG6E33S1nTtJ+h4nDxI2r/ncXOAjieJp5Pa72sMZs1m0CXbENnVBPuTHXOeB4Xhotaf6yM88DRSY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:03:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:03:57 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/9] btrfs: reduce struct btrfs_fs_devices size relocate fsid_change
Date:   Tue, 23 May 2023 18:03:15 +0800
Message-Id: <844fa765ab173b8dd24549f145534f41d412d3ea.1684826247.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684826246.git.anand.jain@oracle.com>
References: <cover.1684826246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c4c6c9-0e58-4177-4dd3-08db5b750613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzy/zIYfnORFMixOPyPpCwgLj5AYcAYx45zbz/Y1pV8LFLxfXqpD5+xqeKNj7XjM8DHWAG+rkxkIFzlD/w/vJA4pTQXsUwNANRnrI6yA3V4+5LvqC84l7j6ukNrhAKgMgLRlBWNbuL6o5dICbLcsJk2CGaWZXmWDhowZpa3DRHEPQiIVDmfss2E+wd7gACxkJqTxzCq6TtG+mMP9Jm56+Rd8Zi5fDFnAUURncRbjyJ+o72Z2iylF67HR3XGofKl6beFy2yhBrvFVSLPeI1VyWdnJG3tAJARV7gc2TWhdkFIldHThLzLpNEagNVIuYSW44MD7UG+uWe6vqznq2iqNkMuoPQ4gDYpCacy2/kwqQobld8clR0cOcnsZvXpA+nFPGCP+I5+Ny0rVOvxd4hOMkR1Fxz169LNvEi9jp7Am06auS8LiLyEKe8lZMHBrNHMtCInncduahPIPjaOM0m6GhXZlZL7gRifDGHnF5m34jb0zEuNms883uwyXt+gSN/Cq5BXiO6rf3vXZyEmygn8tLRHbaDhyfSSvGkGyt6OdyLqwjzZ/aCqcJGDmlXQUchWR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(8936002)(8676002)(5660300002)(186003)(26005)(6512007)(6506007)(41300700001)(44832011)(107886003)(83380400001)(38100700002)(478600001)(86362001)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(2616005)(6666004)(36756003)(2906002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fLOqZMdyZXV6/KPAXgKPwYGHi+FbfMVmHEVDTLNiMbgdoNmJK3Qc5zvgbEgK?=
 =?us-ascii?Q?Zj1bhQ6UilkKxHS5UtoQgS+240TfPAo4SMGag+6Ql/q2dyrS5CO2kYSGEskj?=
 =?us-ascii?Q?dPrcbzgu51+c6wKQXCtppnAnVZbS2vbWGPofZ5PJAYfcori6CzDx22RIrkbC?=
 =?us-ascii?Q?jcQowMXJWc6pyW1OVrBu15A/U42MnWtKqL52uNrjRouZs8NrmzxK0zDsxQu/?=
 =?us-ascii?Q?vwTEoZjZpizoonnJoe5HzQZoAVZjgwrZCD/aqj+yCXXqFWoXbn/vsOsJzQm6?=
 =?us-ascii?Q?DjEFcJiiJG8EkaNEeTnXrQvA86kuSgC75qX3AgzRe2IRGspxa0SY3kMpju7s?=
 =?us-ascii?Q?a2p2exhgoxOK4RR9KbQWh8r3xy+rpwadRCoRI6EvewKqg8yf9dbp+xMS0JrL?=
 =?us-ascii?Q?H6QpzSMz+cic2PrAnWSwU1R77C9Gu3mzjhYIu9rMmHZLTY0Mx0517fgNkn0L?=
 =?us-ascii?Q?4+pWcdDwo154R1bFI8/sfdJI2ZKki/jJOtVaX3aU4wh+NTMJQZ1g4TbTe4d+?=
 =?us-ascii?Q?BDs+Q9hwpNCk8aUCelcYOCeKstCjdjWCYkuV263pX2nUhlzAhSC9WqbHcqeT?=
 =?us-ascii?Q?HGprvPpsJG15aQ0+oMqndJ6I7lU4IDpJLO3kHweAZcT76SihYdbJO3YTEEzb?=
 =?us-ascii?Q?qwL0n8YfIrx4nXSBG9SyYL6YibF4z4uSZgPSClBT3r9xXcHzycq23/WLQ988?=
 =?us-ascii?Q?LaPLbT8tmU1FTF7QNnf1/AWGdNI8SDFJGpC9g3OoMNQnKtVbCs2LpI8iDswM?=
 =?us-ascii?Q?k3MD1AnEZszUd/EtC4Q/V3P7PL/qbP5GDvKDRT6vGjvNhuvQYsJiumyX+/Dp?=
 =?us-ascii?Q?m1b4m+3U+Mx1uLeVREDlXMJ2NzGl8QUZRosH9PqtyiqPZGHhRSTL6TEomNwx?=
 =?us-ascii?Q?XbDJqhngHTwyGSm04f+4GvbrdAbHv7bbjlS1UgvcQqQ//AQZK8wjr1ZRnwdd?=
 =?us-ascii?Q?hNn+ctOW8BhsPkwoaztolMYx2kBwB25hRzUJhVPajivYfzbRulKh4KYHrf2j?=
 =?us-ascii?Q?wezySRZ0gNAPBfaGCd7xeFVNmyz5wwohnrQDh1+v08bJ7frU5wk74YL7oRZX?=
 =?us-ascii?Q?/a3ee8qtkfRzWpgU+p/MTDovn2XObfbCli7E38vRpk9wVrUGd4+9UAO9E2Ly?=
 =?us-ascii?Q?9fPdQPaVEITgLcEWpusKFXG5WFaVN6eM0mCeZ1wq+H0yxjmPWlQ3dwV2Ovy7?=
 =?us-ascii?Q?l7ypyjpCuZsHKvzp/oWyJbW1pN1sFdWWMuRe3wL/7uIAbRifIV/GUEAi4H2O?=
 =?us-ascii?Q?1oaDdKS8KHeeFeRMJRGxke+W9mRWWp/C5mCI+6FkztLKVlMXVI9mzFx/7S2k?=
 =?us-ascii?Q?8WVgDEBgKw9rJmKJB+je3rNUOn6ixyYTpWGksskQRpcjHtLkZKElpreFkcCV?=
 =?us-ascii?Q?iTklvpM+yidI7Y3udbJKcQokEl4vZf56jMgkfIQRPAHb6xm4qE6bnzK/Lnbe?=
 =?us-ascii?Q?stJlSw12gHFgaXCOQybUiK6MeT3R9Hbs7Vatnd3XTJzV2Q8geHX1y6q7XGQX?=
 =?us-ascii?Q?EI/Unft1E8W1HKGc8pyauWyA58GKap9zK5Zzv2Qk0JOt0+YQVv+Z3byV+EEb?=
 =?us-ascii?Q?N7hhagV7JmQkqdALaXYKrqBNXBA8+uao7y7URsdp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zUbOaQ5H91/ORwWuaIN/mlCOHoxwjO0lutaJNoqY1HFqt1alTEpl+jpsEuvQyFHc8EpxPR8fKWE858FXQHci1+4xuVht4dVEzYVO1RdNt76uz8ZSAlKaUaUKBvHEFM4OwqR2GleOfIsKeaDrQ3+4qC9XCKyPzdwPqCVrKejIUicXcLNaopFksaL7VHJ60LsHpXWbJBwwjp2YfLK9G76U1aaOWBSGxvadZXPtC1Ago0JfsxrnLF85yCSJe6mMtt1wOYfeMflvq6CNUedVOzMKh/MN7wPR/0kUS+31RBGFl2V6e7dpRq0GRZwqcEjceMtTy5xs/CHuOx5P8p+a5QBBhCTvBvvP80wh2LKPk4DEN9HTD9cLtN6T+K0eonnWAVIVF9GooFpJ58P/nWrNvbVxlwGaXgwjrGQEpGA/jFXRN7jKRPID8kDSiRJlvojXVTWPuNbBv3IZvc6oEnBgUK/GZJ5RX69VaICoui/6SFjQp/7hQSK8X9B0s6sl8YGeb3398RXx/tIPrK0uGrVGZReqT0/4hyqYWsKBxO2irNg93XeChOlyhtypFgmyXQH84bAq6iCmVOvrBF+T5xZrmyVYdZTxx7PdmWwyXbV+au98PTK/46dIfInCgLdQ6SOrgHhb/aq/Vzw/jIoHsDz3CrbqXxY5miztTkfjWpKsvFOTvB+l8mkkvFgM26ffl5ydrh2w6F28Y5H3Jm+6VGd8DmYZUIDcmV3j870uiWbZhUn5E0x9htGjkxg3JmXbJAZFW80ANHv27B9G6XxBN3GZiV+0iQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c4c6c9-0e58-4177-4dd3-08db5b750613
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:03:57.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfojEyapMwfstl+xsVdPb51NVGGn897D5j5wP8wBFuNPEboJIpQsFHiDs7D3nLRNtKV+FAW2OaM12ot1UyKdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-GUID: 0cKMb7sbShH1_rQqRxSfvLYUVx8vGTuO
X-Proofpoint-ORIG-GUID: 0cKMb7sbShH1_rQqRxSfvLYUVx8vGTuO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

By relocating the bool fsid_change near other bool declarations in the
struct btrfs_fs_devices, approximately 6 bytes is saved.

   before: 512 bytes
   after: 496 bytes

Furthermore, adding comments.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5cbbee32748c..a9a86c9220b3 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -281,7 +281,6 @@ enum btrfs_read_policy {
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
-	bool fsid_change;
 	struct list_head fs_list;
 
 	/*
@@ -337,17 +336,24 @@ struct btrfs_fs_devices {
 	struct list_head alloc_list;
 
 	struct list_head seed_list;
-	bool seeding;
 
+	/* count fs-devices opened */
 	int opened;
 
-	/* set when we find or add a device that doesn't have the
+	/*
+	 * set when we find or add a device that doesn't have the
 	 * nonrot flag set
 	 */
 	bool rotating;
+
 	/* Devices support TRIM/discard commands */
 	bool discardable;
 
+	bool fsid_change;
+
+	/* fsid is a seed filesystem */
+	bool seeding;
+
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
 	struct kobject fsid_kobj;
-- 
2.39.2

