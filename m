Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB0970F5D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 14:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjEXMDU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 08:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEXMDS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 08:03:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD67130
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 05:03:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OBxUUA029336
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=bybIQWoO8Oz2Q5c99gRBqSHugQ0oOHipxRuQmQyK7Pw=;
 b=Hm6LOiwtXoxfLSQ8vBWjU0/6zYAL2n/FJOPREXuYZiMV0EDdvUt4Ll4mxFuoKXQ/mBZM
 l0yl0C+E+vvYdv6JUryQ9bQKcRUnLoDRrHIzYIY9dMo2Z7iC/aCqY2ozzlEH64izy4A3
 Ioikt73aV5IWj+gevhLDB4u4G7NA/PIHHi2K9S5IPsCFqOoi3nKB3N8EaY8uABmvd3/g
 rRs5SPl6mGw9tRxuic4+zAcTgEUOkdp0ktwMUgY19T1NG1JHSeXS93oQqlaiiAyQyKMm
 mXdFH1+QjohqsL9xLJ/BhSIuFt5caYLkAi7pJ0AOs4ursEPVy5iCVmobO828pnGs1p4+ Ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsj27r0nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OBCIb3029007
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2c5gt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqprIWkZGD+HVf/xlhDUi2pPv03avaUK9wFQB2QV4yZb1O/jPvUTV1dyccPy5aH14CdM5RTE/vBExsJs+sElkV2rWqJt4ci47F6m+qkwa/a1Ekj7PZYwwjr9FJB8fsolBAToz97o4VvI4k/IhQH0VfUMGFZ5F+Q5XkVCRmNZ2yP8h2Qz9Q0WDtFxS0pQYHzTtaCkDQQ+NrIk826AMBYoLCQIZ37tEiHe5mFospCKRkobC1Dk3DYwBbgck3RMi/MrQYgV6kHBejoegLlZWjZm6vsERGvEy5fI5yjqFa8ndtW88zXln7mub3YB/sEEGWjTBO6YHIwdD33WBX+fCW9xjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bybIQWoO8Oz2Q5c99gRBqSHugQ0oOHipxRuQmQyK7Pw=;
 b=PL4HhDroHSLPzoqnd92AjRu1A8t0Rns+f7DaRMu12M5tUrFN6961W8mRtjRE7NiGtaaCJ6nYgsVm7zbfjCYpkcGpK5FmObxL4OV//nQHkbcIRSLJ9NqWR/AmVzGuCLPpEPqTHZp41E75k7X6Mtn0zxfg2NAbVnYXslUsuVu8KbM1c7PqJ8aAJggrBwXmt9QNFETPkx4ii067EQfBBDzm81N7UR5hqJiPX05IvkvdZOkCCr+71R29GsWMdwN7ufCoUb+Qy03lWX3m76dMlU1bjd4pbw7OPY4zUiBYVKbR4Z3cz+eT3Q1Mti7SLcCgXNYgXRYE+IlE1NI4jVQb1a2MLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bybIQWoO8Oz2Q5c99gRBqSHugQ0oOHipxRuQmQyK7Pw=;
 b=NfvWoI3dp6O/uiytYYGdKQzInL9d3bVrPBDEA7STT4N3dpLYAf/+Vg9RwRVJan+zJY59vPd60ULdxyc1e8TasHL/lms2T6lhy5CgQIeuAwQj8wtH8bwmDxKYnDD/s2fwKaZrb3OlQHkVLm1EbvnF9c0R0EWtwRCGQwQX9k5tQ6Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 12:03:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 12:03:12 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 1/9] btrfs: reduce struct btrfs_fs_devices size relocate fsid_change
Date:   Wed, 24 May 2023 20:02:35 +0800
Message-Id: <7587a86c31528295d77a707f5c1d795eaec4fe06.1684928629.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
References: <cover.1684928629.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c03875-2b45-4029-2650-08db5c4ed8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbiUPb5WIxwRrMFNRSF3clFGDiZKQW/lU6knpgCY6Epuc/NvB47If1sJpl2aQu7WrQL78Q7EVtd26i63HiBANo01uTq2GINUglq1II4Dkb+evCe7WvCXW1gI868CTCcAtCnc0lOZGVaAGDirB2RK9z4HGpc6WOglNXPzKYHo5H1CXNHr5SxdHtHyP0guoQR+lcRoVzBV/qc/wCjM2NXcQtPiV1msH7HrYrJuXIjnR3ByJqE3rulndtChPvDD2O/2al+IjlCosXUBfe1m3lxeAFbVO1t8PTRlxgeLn6E7oBiB9Ta/sYxiIljSybfU4KKIZYhT2dy2gfDxWfeDkCZJJMXj5LioJ5Lctxd8BiSb0PmSX8TKH7tt70J4mVMbAZRqUEnSSE4DJ7s3lnTaSrlhUjFw4iTAdUZtSzSu+z/sAXMOv1qv2O1Y4BU9poVvd9Jj8lan0DaVsw8StTVrxx922w62K5f0b2iMyc4ZuaQ9DBq0HL8OuKS8xmGyY96hsIvFWCI4VwXERQ+2WFDafDdWn3FLDexmNADJNFmiIgcp6msmYi8D8qXvMbxcGx2SIp1b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(41300700001)(6486002)(6666004)(316002)(8676002)(8936002)(186003)(36756003)(38100700002)(26005)(6506007)(6512007)(107886003)(44832011)(5660300002)(2906002)(2616005)(66476007)(66946007)(66556008)(6916009)(478600001)(4326008)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fhi13wLd9mJeWTrII91uhwQUCoPEVgffvmPX4BmzrhkWR6hYJ/8DQKuxn3v2?=
 =?us-ascii?Q?YumKLyztQ78QQmRRgOfe3twEB2wzLJk3UBHjj/c8/BY66oKiXB8MgEnCvrY8?=
 =?us-ascii?Q?5XDVIckTdFX2ZauJEzRlso6LxiweebRxEPxSGg3U4l1cyDvHB+7KyTxYubbU?=
 =?us-ascii?Q?qMlY4bZBLraEJ+c4qDd7br3ijOU54N9aLZEbxNRz3j5JtXdWYuLr8To9L0Mj?=
 =?us-ascii?Q?bWpD70S1Vo6ik1rt7mwQ5Zm3LNNbRlidf1VZVdkozRZdsSxSXb2IjQAsFYXt?=
 =?us-ascii?Q?EZiNx+agqTXViq1bkwKvipfj8gHZgdNfosBuSkGLLH9wbgvq3uxvB7yosqkS?=
 =?us-ascii?Q?5kvVC1y9HDqhGzi3MFJX4YBD9j4UHSQPfopPbviW/W2Y5m6N1vqhKOf6ZLAJ?=
 =?us-ascii?Q?phuTceXZ6P6pK2sRRZmX7mrKh4cHqtPYDvcGsSdhBo6D7NdxdYVR5fmzk0GN?=
 =?us-ascii?Q?Mqi3QwhvbtLEWn6/Rq4y9bY9eEzRuOakkQzlQO/Uytp7PAlvk5hqVOGETZth?=
 =?us-ascii?Q?nbeCctoNJ6aWM2tjpEfQqpEhSNQuhkH7DMS5m+NUzHgc2UB/DadHTcI7Rpn/?=
 =?us-ascii?Q?rbXx78XmhbIpx1T3l8pnEXrm1prFfytJlewg9K87LQJCNgWJxOf67eW64Sw0?=
 =?us-ascii?Q?y7cSJfFZgxpYKp3XuY2ypq3JfUBNIrSg22vi61CtT6VZOSE3j+QDf0zbrHt7?=
 =?us-ascii?Q?VfSvjUG5Uny88ruQdxnpbNIoVxRasug8T1D/fW8LRF7GZtzWwg9AEuI0LHE3?=
 =?us-ascii?Q?kOzEIaewcpFCuua7YVQ0ReUKcKrRsTgW5BV3hjSyAcNTHhT4M5n5PRjjQyJv?=
 =?us-ascii?Q?AjQwBr1tB1JFBNRJ1rch/HXPWvMJ8NT/FaLxlKGPcXXK5YqFMXaAnZaDxgZQ?=
 =?us-ascii?Q?aWlFNanPgxNGTKd7gibd8kfEru+Bg+Hxp+Hi5uC5G60j/oae+UeSw3NgkLWI?=
 =?us-ascii?Q?Fm0VDJjHN6zXyPBSRL2ZMHvA3t/O8MfFAnwnA0eiHsGsYBjqGdPpewG+wQuD?=
 =?us-ascii?Q?I8ZRF4waPCHnAHIipQolyMDPcC0MsgpuqLKR2WhJ3oTHJj8kzLgi6/kDScWl?=
 =?us-ascii?Q?fy6RTZ/0d9ytyTeMaiiMRNuBPRoKGIDhD67Z8nGtTx6SmIOyIuXEPlsN0vwo?=
 =?us-ascii?Q?PqkSAvpKPRR+O2/uw/la6sB2pGhQRmld3gX/UZovMos/gelB7L5tuqB+vWsn?=
 =?us-ascii?Q?n9NF5PyKFZod2wfsAYnLMaGAgprkzJN9q08LGd+AswZN8FpMpFwKWmme+rFy?=
 =?us-ascii?Q?6s6VxoOZlZ0oFxL46UjXsuBF8mdE2yz5uvXiZ8rO4RbmPBZeVb8Wbw+SCqBB?=
 =?us-ascii?Q?dLKGZPbsSI6cv2yd08w3cX4WA6ldgE3X7B682kol8XvbvaC/dpbp/BsCCdMw?=
 =?us-ascii?Q?NJlfr775l0Wxw/gP6oVuYxyVTy1hplHQ77cD3I6sYUdliVRQqe/xYlwQif78?=
 =?us-ascii?Q?3sEkga2BmGuSQ3yUO2Awlhof2pYjmCzyCssDbfCK8XKMGtRPyYr8N30E2zF0?=
 =?us-ascii?Q?Q3GrRmGfOpnF88Upre8m1W/ulHeilm+QqIFhdze9iv/xqWc10ie6ilPR2oLG?=
 =?us-ascii?Q?59wsQ6/FkwzV0fu1E05QyFdPn4EVtYb7nMSWIxuh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oNuIEfCP7th844k03+1fKw4jTZQer6vvWALxuMM+CxNgGXgMuDbkcbcKfpRdQEpnOLfuvhWyhIgNw5MF22tY3BlPvsicQb+yBV5ttJ4YUq20gvMfEKMpaRdfhv2pYAebEI4cSJ/3r8FKd+BODWX1Kg/wZ23KGUpX1RrINEjUtfIkMH46pPGimb+JT9fp9EOewf6hjr1UnYLik8MPFQr28Lmc3fM9YcjBjYPo/c0RYkc1Eei27EW1+gFcvThUGF+3uLIA4rk7kHyp//T55g2cpWKahYjmpLCRA4jF/R3vgD7+/8GsmoBffYItLCIVTLJnoZkog17Nhz/hMp4eCeD+2+2Q3uc7UStmn2yucSQIQ+yUkavFfAA5is8ZfPQ2oSVwHQri4180GZc40l8Qsh0FG/otjw5EjCKkWrco7i3lGEjwX4GYvPvjCQLvVFO0c+keq5cGddWD3ZxmDUVg9iNFHvgI1yWJmWZNBLeAxP+Bz9VM+0THbQsVns9ChMfwbyl8UQtaKEIB2b6IUva4QhHT/Web62e2bDG7zIUDuDftVINGSlZFQ6kv3Nplh+cOm/Sk6IRHuvXWEH69Ud6PxNMmBfCMzkvI+y0pEiEoD113sYKwVy8UPXFWYlht2xShffejiubHmPyRkgbHDya0I+VENwLgd9BYIzLzl2J8c1AtvF0+1immoyd5FPPNYnJdBLbxM05EdRFoD/zYCaE5ajJUMYy6/wTRBbjlQLmpiG2SXXBXdiS7WG0YIjhh15EhfCO4bk2nF0XT2enAVPX4ruqIUQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c03875-2b45-4029-2650-08db5c4ed8f5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:03:12.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgEATMhZeUiKo7Xu5SCLjMAYpcV1dzoEjW7BzMq0JZsPKflZaOFmypL6MXRNOtBhasPdp6V/ZgpBSJfiwO2+vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240101
X-Proofpoint-GUID: eojR2QK-pRnnygSS2JuNW2PP61WCNKoQ
X-Proofpoint-ORIG-GUID: eojR2QK-pRnnygSS2JuNW2PP61WCNKoQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pack bool fsid_change and bool seeding with other bool declarations in the
struct btrfs_fs_devices, approximately 6 bytes is saved.

   before: 512 bytes
   after: 496 bytes

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Removed added code comments in v1.

 fs/btrfs/volumes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5cbbee32748c..236ae696c984 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -281,7 +281,6 @@ enum btrfs_read_policy {
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
-	bool fsid_change;
 	struct list_head fs_list;
 
 	/*
@@ -337,7 +336,6 @@ struct btrfs_fs_devices {
 	struct list_head alloc_list;
 
 	struct list_head seed_list;
-	bool seeding;
 
 	int opened;
 
@@ -347,6 +345,8 @@ struct btrfs_fs_devices {
 	bool rotating;
 	/* Devices support TRIM/discard commands */
 	bool discardable;
+	bool fsid_change;
+	bool seeding;
 
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
-- 
2.38.1

