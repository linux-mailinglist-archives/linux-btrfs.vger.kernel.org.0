Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5167A70F5DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 14:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjEXMEA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjEXMD7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 08:03:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE7139
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 05:03:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OBxUlt017804
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3DW2E7Ky7iw834kM5+TtO8NvalbppMF3Pg+kV6vuACQ=;
 b=cq6tZyCpldFsyaT2XLzNlUzbzh1+BOYUB/YzdwXApo+wzdbYzp3NOZGSmdCDhll9mnRA
 /tLGv2qk6L+Jrd3LWLDMMtXBFmh11335edkF6JDWf9f3UN0h6O1o18RlrTGluEXlhiqi
 jYlS+49EhHsvcHxheTlmZi249Ni4dsRFmICvYc6ZlUJxyAKaucMx8OE76t2s9zfTOUt2
 fdu7FD3S5brhbi+uZiqhPOcZYB35wSRH9xq4EXi1u6sKEwl8m12qDIX22L/ftlDVKBKj
 DfPnxWtMQiYQV3ViUDh4yGwhcu6EzldPNd3Tki88uJo8fIDVv5dg6Gg9eS9jqdO7s3LE sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsj2980qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OAFh1L013193
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7g5unt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMT5j6CtNIvvghlFfUyrjWYzsNzLzMAILV/YBzuVXXBJi8GIB5Wb69bHgz4/kbPBFhEywY3mmntmbxfmcShmbIm2d5O55TN4GbZX3+E8BCYyLcPPbQtMy9TgUfJJAt/00IhS4SbYxmt4PYlnGXOMlSkL8CmcgA4DabIrctjjDL3NCnmndJdj/VXszz+wfGdCs0Xv23fsrx6OwMKpcoEOgNuo6KwdE4B0ny83krOo8T4tzLLzz2juAHE/yrsPdNNr8IeBgMFOKhWDErxzlBzE64tILplZ5zlxWICF8ECsNwQhKcJDlThF34fAzPYkLoY7o5SD4Z9ZlFUo68Yam3YeUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DW2E7Ky7iw834kM5+TtO8NvalbppMF3Pg+kV6vuACQ=;
 b=Q9h+rY7r8o4AZMrFDR9YESVzqErmsFnyKBN3lIknxEOtaiADxRTJkcDx5VM4evKKX34odKnTUa1x7pIFtCpAI0DPZtTfNnrCG0ybYLowp0kJfTeQv3BThAE+S1CRNW7uG1L3OpW8bE42GFy9nob9C+DXQb8ODPLTM30CBgN5vGt1LdBbKcAcSnmuaeumuDGMGn0S98ypdrritTGntNbX9FgOM2LQJQnvEasrGxSGGh+yyUTIwL8PswGfAY8hy3sxG1N5/WuKdG6D3rZ4lzG5VxenfEmmWHU7E/WsfN7Aw281XY37i5k1L00PsnwgGLXtBljhrSFgzZ2xLRLs2AKIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DW2E7Ky7iw834kM5+TtO8NvalbppMF3Pg+kV6vuACQ=;
 b=pk3RESZv63K2EPYN1ZHsrGs5TwzUqS6W4O9t04B1mgRj9czdmHvR//+5LK6PnnKGztdf+CfkYrmOBgCM5L+vDnlKe//nE3lpDc6TZiSpQYJgI1p2Py4efMJ2+TxBk1zfejD9mdRbI1r10Qz9ezruCxZxciRzzUPVb/eWigsdFsU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5098.namprd10.prod.outlook.com (2603:10b6:610:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 12:03:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 12:03:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 7/9] btrfs: refactor with match_fsid_changed helper
Date:   Wed, 24 May 2023 20:02:41 +0800
Message-Id: <f7ecb8bdf8870988b239f0df65c026c642c26218.1684928629.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
References: <cover.1684928629.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f754c9-0c66-4d85-80d0-08db5c4ef1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btBILOuVeFh5LDewHjmE3Gt5ukBBEmXGYDfDpe5XsvD4cf+JKIL3Lu7S+3F+u/bjUajQ+mUO/knCCWJCLUO96LVCu2jygoxxC+qcFpIeyAcdaDEczBkIOwPOLAEGVaDS8jpJwF3u3b/i03ZF8NvzzDgIgVbU64HkBg1UsQbG/H6WpdGj1hlboAUvI1WDaBwQhvachgic51r7BcX6oY7VB/ZygE7pwOkPHrPpkoCE4p3ADldVABTHN0tJ9wmQWptUtcZhf6UaOesDvFR7iA0O7DF4C3Jz2DmuXeS8Vy4bNSOHDPpbRAXO9ZPWBIxkCanBRV+TSuvyqLUAbiNXXCfbCK5kLY4KQzAroKcA3J+BgUNFIYVM2znwJ5DSodO/fC6kwNokC3VcRwbi1nrbgHJwkodBzr0SkkwwIUcHCabFUbUbBtLR5H5pijzZp4IR7Mc9pW3AOiHv8UDO/IT5zOzxnadD6C7hhZyeo8Ld5Jf3uHdPJPUfxQ0kPi4ftRyQYgJL4uNV74s8xXqBRQcxyw/fRrN3J1/FdXQtsUETETpqhFFnTzB7IxK/mVtr67G7jsxg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(8936002)(8676002)(44832011)(5660300002)(83380400001)(107886003)(6512007)(6506007)(2616005)(186003)(26005)(86362001)(38100700002)(41300700001)(6486002)(6916009)(6666004)(66946007)(66556008)(66476007)(316002)(4326008)(36756003)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b3fuOuWsYCIR2HbRTT+u3yLdpx09X+K6soPICOi5OHz48VKZsZ+oFISPXY9l?=
 =?us-ascii?Q?Ry3hf/tC5Q5GTL6fNmVsJ39sZhej6llPAliOJG8YOfc/QJKLTBtzeVpk1jO+?=
 =?us-ascii?Q?/24IYqnaNrQkyKFcPe6cNmM0JFnznpV4QRTZewYt9UqyKu5cX2UgkaeLtrOg?=
 =?us-ascii?Q?7BCgfRI6hsP1IQlPvU1L1sONyJF8vhiuD32+zvvrcWdmgpAhkR5dqxclZt3D?=
 =?us-ascii?Q?UuaP3JOuOos8X+lLT+8dS0o3FYMgFi6PBYVKlBXibAd30HGIffU5kbC402B8?=
 =?us-ascii?Q?4aI7FQKPvgWnys2c3K72v7PPYdPp9cQ3veEK17Erle8tt4vfyVuBrm8W/uMt?=
 =?us-ascii?Q?G06bZ3HxOFP6kW5UbNZ+mf3+CKL/VkL13FjEXxclGSyTdtm7dgRsW8nrQSqq?=
 =?us-ascii?Q?8R2hBOrJCh4kXG+tqNKSkRhtILoSTF/PcHsivKtXxT3VRSUx1GyS+wS21GDJ?=
 =?us-ascii?Q?Yk4DR+iuMxwok2+/D4GXkhOyDYFTWCFyn8mCaFzy0Pgx9YVG4iSNlT2cjULs?=
 =?us-ascii?Q?bgQGkb2BTW2giN2IfOMbKyZEDOWfHfP/TdvUuZq4tCrVg6oFKHGxLKJgl6ga?=
 =?us-ascii?Q?BZIsdhaPbvGtRLJ01c8nLfIBnnuBNB8HDXDrdLz4wwSMvjvfy9ZZYL/XpkDm?=
 =?us-ascii?Q?xTRqhfJnmzS/W4FWNRpRPlXWO3h1bql+uqw0sYcVQxCOO9ydb1h9YNbInKhq?=
 =?us-ascii?Q?oqNJJaPAb2uLSMT/8fvXZD+ylnIm+VLz3yj14b2hkMOj4pA+swf0t9D5o8G0?=
 =?us-ascii?Q?xH0dWID6BrgDYx9jv6kIPvR/I7QPIggT5kR+P1RxH0kSKS8y/tcTIykpSz1a?=
 =?us-ascii?Q?I8UNkLVY95AOUQbD5XfZIYfuuBVHvEwytKAzBCn5fc1uImXnk6qC1v8Vgtei?=
 =?us-ascii?Q?8itCNxWW+GduzR1aB3uMB17FBxz+WlqU1jHP0+9vZmYeAfZtlNcXXCnwdk1B?=
 =?us-ascii?Q?YQj9dxhcYoYtvZU/sgNJdZ/C2bx9szZ+OIgGSosfP6zWcJaYnVclUjKw1ttJ?=
 =?us-ascii?Q?9GeppjewjqNABgyZUDxOFLRDj2TizIICHPgkk4o5/lncXbV4/l/0aLg7P/Qh?=
 =?us-ascii?Q?pQo+3gCAWHF+60DyuiC+SzIW0BtDFcbDmwMh8ndjjEnjncSu1tT7tVfAo5oN?=
 =?us-ascii?Q?fTt7HhgZu06TYFombPjKX0Iby8NsMCRIKWqFKdgB7Y055rcuyEedInzlLNKy?=
 =?us-ascii?Q?6RHN/Nkjv8aH7OP1VoryxlxUa1QmWoBe1YcM0isTHWdrHFOoVj1CwWSNo3kC?=
 =?us-ascii?Q?bu4Ia4NL/luuBBYRTItRWLJTtwJth+h7S5FC1WY+D8tcpVRVM62xRce//3h5?=
 =?us-ascii?Q?0esc2RBL2CuQOqeNpbj8tHsGTBlP6ohfCZTOEewCD82cQrUDJiPSa5dXM+wM?=
 =?us-ascii?Q?iASOa9hi8T5/jdOZitKoLensB+xx9WUeYElvwf+YYVJFGg7P//dzm3FwlOdK?=
 =?us-ascii?Q?+N6SuCgc5bO4kRfAPumOUMEPgWpzYD82mTp42YTK9ua4xUvOEc1zwObhJLFc?=
 =?us-ascii?Q?JiQLsij0oKuXH8spxAL7Sfu8XdmjuwPg8SZvvCJyOEChhJdVM26Ygf0go1Fx?=
 =?us-ascii?Q?PObNyYj0UV810feGaEC6QLyIAVk39XwyZTs0bcAE3WtunnP+yEB3xSSaiz0Z?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 42ujNJJvgM5++h72Ze3InZbQ4MYXYBxUGMMVlQ+bbq9l/P6Eom763ijQLDtrVnHD/hco4/t4mVc250rCMjWCC55ITb1MjIyyGPzOsKZcjqLBEl1puDKiOgvaX6ECis0HCKywdftM+Q1BMN1Iygr/pYH5619bgmkvLmDTPmd/ZMnStuhJ1tS/WJg6jMgtVELkS8NRglKU0CEFMsDpVxRzqYbDzG7LOap26rLPrGyurzCbXR3h/+ilq2B7iukalb5w6YU3rud9UPECLZiLfUp2O4eoCHShDUqwlEayVUGNAcY3mr572j8w9n/NNDNd45xjB8mUXwStyBpDRYeMmQEF2+VydwSeS2zeLfPr6LUWNVGImbQFjQHaMi5vsexgF97tP0x0VkX5+YBNMBfHyj7dTzjLqvu0+D96vioiAn257ViZRWTumFWdC4d2YJDa8ifjOekqYRvu0GLynECXFxD/G4uRUqISQzZdbDylh1jzeZZPb9lzwhdRaK5kBcl25IOfwvzx/3dOfIVmuv160Mtik7KWFLNgzOyXsJmP5j18vlTjWwWEclkP8qq2U7u55YviMAVQ6OLmt5i2U3NAgVQWjq31Qmnk7fhFG/V01JXmj8vMv03SdM9+j+pq6EkazRTZiVSZGeXmClg3GHCsRfHlhhsnvOM3AOEtfNvpl+46voc6nxK0o+90RM5DxGbgCwi/E5aVXlPooA0Q1oWzv8sgb1EFYR4MBRbsJX1/Fwbz7qpKbpC04iYo7YZnhVLivH0mRtiNtsOa7aY0B/N/fznUnw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f754c9-0c66-4d85-80d0-08db5c4ef1ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:03:53.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAZo4j5QyNao6OBPDf9zgjykgGP6tDTcG4WB6GSxybK+ruF124zed+NeC7m++/Fdi3wT1ZZEud5W6hX2pbDSSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240101
X-Proofpoint-GUID: SiinyD-SuUvyvveCEtmuEsjE63tyH990
X-Proofpoint-ORIG-GUID: SiinyD-SuUvyvveCEtmuEsjE63tyH990
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We often check if the metadata_uuid is not the same as fsid, and then we
check if the given fsid matches the metadata_uuid. This patch refactors
this logic into function match_fsid_changed and utilize it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Rename helper function.

 fs/btrfs/volumes.c | 48 ++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3d426dbd1199..4ef2a8713628 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -458,6 +458,20 @@ static noinline struct btrfs_fs_devices *find_fsid(
 	return NULL;
 }
 
+/*
+ * First, checks if the metadata_uuid is different from the fsid in the
+ * given fs_devices. Then, checks if the given fsid is the same as the
+ * metadata_uuid in the fs_devices. If it is, returns true; otherwise,
+ * returns false.
+ */
+static inline bool match_fsid_changed(struct btrfs_fs_devices *fs_devices,
+				       u8 *fsid)
+{
+	return memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
+		       BTRFS_FSID_SIZE) != 0 &&
+		memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE) == 0;
+}
+
 static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 				struct btrfs_super_block *disk_super)
 {
@@ -487,13 +501,11 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 	 * CHANGING_FSID_V2 flag set.
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (fs_devices->fsid_change &&
-		    memcmp(fs_devices->metadata_uuid,
-			   fs_devices->fsid, BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(disk_super->metadata_uuid, fs_devices->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0) {
+		if (!fs_devices->fsid_change)
+			continue;
+
+		if (match_fsid_changed(fs_devices, disk_super->metadata_uuid))
 			return fs_devices;
-		}
 	}
 
 	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
@@ -684,18 +696,16 @@ static struct btrfs_fs_devices *find_fsid_inprogress(
 	struct btrfs_fs_devices *fs_devices;
 
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(fs_devices->metadata_uuid, disk_super->fsid,
-			   BTRFS_FSID_SIZE) == 0 && !fs_devices->fsid_change) {
+		if (fs_devices->fsid_change)
+			continue;
+
+		if (match_fsid_changed(fs_devices,  disk_super->fsid))
 			return fs_devices;
-		}
 	}
 
 	return find_fsid(disk_super->fsid, NULL);
 }
 
-
 static struct btrfs_fs_devices *find_fsid_changed(
 					struct btrfs_super_block *disk_super)
 {
@@ -712,10 +722,7 @@ static struct btrfs_fs_devices *find_fsid_changed(
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
 		/* Changed UUIDs */
-		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(fs_devices->metadata_uuid, disk_super->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0 &&
+		if (match_fsid_changed(fs_devices, disk_super->metadata_uuid) &&
 		    memcmp(fs_devices->fsid, disk_super->fsid,
 			   BTRFS_FSID_SIZE) != 0)
 			return fs_devices;
@@ -746,11 +753,10 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
 	 * fs_devices equal to the FSID of the disk.
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
-			   BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(fs_devices->metadata_uuid, disk_super->fsid,
-			   BTRFS_FSID_SIZE) == 0 &&
-		    fs_devices->fsid_change)
+		if (!fs_devices->fsid_change)
+			continue;
+
+		if (match_fsid_changed(fs_devices, disk_super->fsid))
 			return fs_devices;
 	}
 
-- 
2.38.1

