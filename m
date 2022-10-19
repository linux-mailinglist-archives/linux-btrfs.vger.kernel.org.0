Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8AC604D14
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJSQV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJSQVy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 12:21:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0861C19D6
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 09:21:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JFOI4V000824
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 16:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=V77/dzaBly8aeQ2SJlWQSIcpCRd7GGoESGqGhqGBtDw=;
 b=giUGZtblEzCHN9V4HkUNylhDcj2Cn9QVzEWV0GqoujsWu4dSh/AkYv4ef4k8gxuLDQlb
 s49ab8ym0fKgPQdlLVPVJbYRZ49cz5rG/96bzOHrhnYH4lYZiiIUGEBc4iVXMNFcMbhp
 PcRY0pUJScij9oXa+2wtIREcu2F/1RspnbT5mZPUcSA7z2WKww+muGsvZikqTmCCRTYc
 50K/RpY9p8k7UF9UwcfaFCwfOp7TrDXMBVvqxiPfnw4gO47+ychqI6dVJiN4bArVQZpT
 Jbeh+OnJQ9rFIJxO2z+G2bHo+0MKiZNEKeuHQJroYVQI5XQSIJU6m0AoB5x7W5YoOmuu NQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7snwxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 16:21:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JGAJpc017946
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 16:21:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hthnrwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 16:21:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFH2u0aVutibSnlEN7sllqRomMu8JBUGyN/JV+v+4WtY++aAzQP5wUULOMrdRrivDkwg2hPIfV55derAZKLzffRZVMYOYaqIfipCXTabj8RfeF522FDeIn1q660UFuUF7Bg/MtRXLKTF+5hrtEI1YAn1DZahehORqsuaQJt0R9hWFR0DO86fRgoW0PK6HnHy4Kh5trSvB5etRip5hZ0uQwxIZLlnmkd7VzVPQE935ON2p5gN2EQ6qLLSdp91YUVx42D8dIonsAwc3I+TXx5GGeMOKHeVRu67s4DOpJpZyjShtee3OmwOL6mNJWp4bK8sJZFIfnMvcg7XmMwWUhkqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V77/dzaBly8aeQ2SJlWQSIcpCRd7GGoESGqGhqGBtDw=;
 b=CzTLAvldP4lhoAnl7Rz9+Qw6z6Z2B82Nw5pqXHTXcixQpnPGIEvrNuANvDIgwfEfdjOBdpx8fmaiRYphP6D4To9w5rX4pDvqsyKVnxBD04tyh3zFpuWaJZoOqLrauGJtm9U71WKqMISHN3syplwlbY+c5nluGlB6LjvvOX80TE7rcQzO0I79pFvjK6JhRL3CZZutHTBNmmzyR/XZ2Z/vWIpNW3QuqzbXTxLmNmZ+4Ka8D9iwby7utqhrSADBHxyOYWh14C/+UVJJj1Nw7TxXlHgDgyDAqdvEVZrfkNlR9udQsO+a7JZlWDSfEhTFnvUUecliQQCJAbnfrlYZWuWbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V77/dzaBly8aeQ2SJlWQSIcpCRd7GGoESGqGhqGBtDw=;
 b=amFNNkpkjZoT6DxfWoprfO8F8CP/+udGmkqxJXaZjuhh7NjAXqOX+ZFqfM70YAQ6DOIvg0ITv52GU680ExCJcAIovV4N6eJSnVMZBcuJrTcNKB/wjBQfnocpnkGufLT1gdYL1jgGc62JIz8wfGEEk4WPSZf9s0SLT3HbWCRliik=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 16:21:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 16:21:48 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: add helper to exit_btrfs_fs
Date:   Wed, 19 Oct 2022 21:51:42 +0530
Message-Id: <fb7c86d19039270ace7c3ecb6d2cb96cf0406808.1666191132.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: 912af0db-42ed-4f8c-1b68-08dab1ee05d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UY0CoPBtvfz7/BSkkL/aUmQ7fdcRfDrJZYsW9WSIJDhsLMMykm8B80IBPINoD41iyCcJv/+OX0owQvASIvpBlsmznDS7MNtkLln8GHfDi7gd6U695SU2ZuyBuGMvBGtOCSSvusiZ3yfV8xcQOdR///6rDXcj5vPE/9Soq7dnsYvlhiBcAdGJ192j9uPO04odUs6M7vFZr+5QqctAFNF2tFjrgP49p1zILBORy5iPYH0rE14LqIgvYDRGca6KBviFUI0EE9+qbKeqJ5OfgzCUuUTY0LxYV6Ic3c+t1NcugYT78T8hZkB0PHP977j64vWJleF0nyXO+lJE/VyjXe/mDfe8/cRkYdMUXgdPiiaa/5qu8ECIpUM0/WZPZ36L0Pp1EDeJU0p4DAbS1VuL7QPOW6ju9aStFn7eT4MKBixRfOYSFJzqgNetuwbV14GKgkaeMTKW7kG1zlUkTxVUDtWwSACOdqhkBwtdVjZhveXYCDjtZSsZMjsyeER2aERmZb9zVEH98MeKXKAFlhmgaD5/C/gjHvaF/PceiOv+sTn8Qz68ggp1oWq+j8VwdfNLoLVr2NI8rGRO7tjmfnVKxaDThoTrduo0UeFzYLxD7dDyqs+0GrLf4EKrStmHJ7+TW6TBlmlAkMzTbyuTIbjGdeXWSBcF7xpkMh+eBToqAkLEfBNMfrP03UYwdAeXdQ98m1hDO0KJ0WpoJ86tk+qvqpk+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(66476007)(8676002)(6486002)(66556008)(26005)(6512007)(6666004)(41300700001)(38100700002)(6506007)(6916009)(478600001)(8936002)(86362001)(83380400001)(5660300002)(66946007)(2906002)(36756003)(186003)(44832011)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sp3lVAHo0FbaTszwSXSKFDGtPejTmyFQNQDclttH2+LqmkUcMCEPfoTKy/0G?=
 =?us-ascii?Q?yU5S/h1J0odl4/cEbCfbPdFUOaqfLsCCJNWI/Ltxyapx/8QrJNYsFxKwE7rU?=
 =?us-ascii?Q?k1zFci1uayoAm29jdhk1eYezQSIpDAFBa4S0wDeDWPVtHxfHGlyaB1gr0wY7?=
 =?us-ascii?Q?cRwna4iazSdnyFeg0FRCbo1oCEyS0WuAXA20C9u58ibxccSnxbL0UmYkBnGY?=
 =?us-ascii?Q?Yo8a0uLt4/y0INwgzLXUrTEsN3DhIE5X2QGbOAL1SzZIL8Fo9lNan6L8HO7a?=
 =?us-ascii?Q?6QAFXObY70t85nfDvZcnm7a9T1nH/0M0477YvXJ1q7UCupH2Qh3FA9RWdHER?=
 =?us-ascii?Q?IiHmBw4dwNVIHBTW4fd2u+ZQ1ABFtCbhJ8SBoH1VkeuwCa2RV+bID0RklryO?=
 =?us-ascii?Q?agJoqm+7Boq17XGaMiQ0R8H08MsocTiJZ9whbecjhwJkR+QVbx3DVHzJY/k3?=
 =?us-ascii?Q?YgVAgOfpEBoabJXVo6MjSLJU4FW2Rka8UcSDy1NTJkXUO/li/br8A/5cNlUV?=
 =?us-ascii?Q?vO/n8T+GVj7xcjGp1+YUgEwN8kUc5AVwKduvDkBSlj+wf82z2aXajGqX9/lk?=
 =?us-ascii?Q?jCSrotTKQrEzP1/jqcNN60FxIR/0ol/gsKIvGrjGc+andm5WsSD22A9r8Gzl?=
 =?us-ascii?Q?jRrh8TqwaRYJGM+Pm2OHf0MyyDJd6zM3DsEgBIycwUMDfnDCBLnW8KJ9qTTT?=
 =?us-ascii?Q?hFvOEOXcRN3igZuuzV1jSPjppfPD4E8x7qpAjydCvvogqVS7s9SYUYTr/Z+w?=
 =?us-ascii?Q?FuNhTiY5QJOsNPnexMzor35yt1/TahSbFq2ZUan/CWebUXquuy9HJknPMbz0?=
 =?us-ascii?Q?BvmB64u5BY7sMutYv3/m3mDMiFHAdbXB+O74C38bfwUD5jOzKEra4CcbddnU?=
 =?us-ascii?Q?A7EvkhHiknRGhRJbjRxpcGQKgJ8PAyOZhZ8srTe49DEk/i+32vxz4a4YZcXw?=
 =?us-ascii?Q?1sVIIeuEgsvDd98I2WNAqrSZTnlbQsuQW5I5v5EVt2Us4isFLgsiW11ZAYMc?=
 =?us-ascii?Q?6B0uUFoHq1y3pSe4vDpRVTweamfuKMPeM9ZXRmOW7jwLSykOaY/k+Pet2d2v?=
 =?us-ascii?Q?1nrjmePjqIrQ74Kt7YNTKf+6A/Q2EkUzYbohKM7D+lj5lSn+qW+3wb86vlfr?=
 =?us-ascii?Q?RkCfvFDsNmfeZYPLNHoctduSZl4MkWHesGvNMpTxy3ySoCeuyRWSM7oT9m6i?=
 =?us-ascii?Q?EeUKHUh2r1wa/qBVsqgT9LSpoUuDV/2ZQnJP2Cp7BVKyPP+7J1CUhEZZlUH/?=
 =?us-ascii?Q?YTLPETazCZn+0N3fxRPRj8NCbUqZ+WbR6RTyB0aCT2eGh04UJTV+ErAi+xOH?=
 =?us-ascii?Q?T6Q6komsVRZsBrPKRGpU9O7wiKL8DRNX+jPMnuF/H7Ju0v1wzFmWWaOw1Km0?=
 =?us-ascii?Q?G1b5c9Mbk63lEWDouC9wldVWtGm6vwKTc3YzyVNiLNGS/mO0m+EuphiH/Tjz?=
 =?us-ascii?Q?iyiPGEltgPY+bHao6WIDxs0oAjXa2tK/mmvJFpHX+aBhBVJWElw+7bKmv6PO?=
 =?us-ascii?Q?rmpQ4A39JlkBzTvS4mwiAUjreUG24JMgFGN3thn79srfTRrXvcRLppPK3FFo?=
 =?us-ascii?Q?eov3NHrq34Br/AqzoYJUPQrXBPp5MNwKcEGvqmvS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912af0db-42ed-4f8c-1b68-08dab1ee05d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:21:48.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwXQergWLVpac2TS2uDcdMUytytNjXptLSpdYcgPOvYVD2TYYwdthDQk6bzy66u+AEFweEo9q9aCT5Cb/+PpTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190092
X-Proofpoint-GUID: hQcHzY6w6EFfzFueyRMtfZPg81Rnxqsf
X-Proofpoint-ORIG-GUID: hQcHzY6w6EFfzFueyRMtfZPg81Rnxqsf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The module exit function exit_btrfs_fs() is duplicating a section of code
in init_btrfs_fs(). So add a helper function to remove the duplicate code.
Also, remove the comment about the function's .text section, which
doesn't make sense.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
Use __always_inline in the helper function, inline regardless, helps ensure
same sections as the parent function.

David,
 This patch is on top of Qu's patch on the mailing list.
   btrfs: make btrfs module init/exit match their sequence

 This patch passed, make mrproper, compile with defconfig and Oracle Linux config.
 and, Module load/unload.
 I suggested this change in the review comment, but it wasn't going anywhere.
 Instead, I found sending a patch is more productive. Please, keep my SOB.

 fs/btrfs/super.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 42e0d2fcc407..96456ad51eab 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2809,7 +2809,7 @@ static const struct init_sequence mod_init_seq[] = {
 
 static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
 
-static void __exit exit_btrfs_fs(void)
+static __always_inline void btrfs_exit_btrfs_fs(void)
 {
 	int i;
 
@@ -2822,6 +2822,11 @@ static void __exit exit_btrfs_fs(void)
 	}
 }
 
+static void __exit exit_btrfs_fs(void)
+{
+	btrfs_exit_btrfs_fs();
+}
+
 static int __init init_btrfs_fs(void)
 {
 	int ret;
@@ -2830,26 +2835,13 @@ static int __init init_btrfs_fs(void)
 	for (i = 0; i < ARRAY_SIZE(mod_init_seq); i++) {
 		ASSERT(!mod_init_result[i]);
 		ret = mod_init_seq[i].init_func();
-		if (ret < 0)
-			goto error;
+		if (ret < 0) {
+			btrfs_exit_btrfs_fs();
+			return ret;
+		}
 		mod_init_result[i] = true;
 	}
 	return 0;
-
-error:
-	/*
-	 * If we call exit_btrfs_fs() it would cause section mismatch.
-	 * As init_btrfs_fs() belongs to .init.text, while exit_btrfs_fs()
-	 * belongs to .exit.text.
-	 */
-	for (i = ARRAY_SIZE(mod_init_seq) - 1; i >= 0; i--) {
-		if (!mod_init_result[i])
-			continue;
-		if (mod_init_seq[i].exit_func)
-			mod_init_seq[i].exit_func();
-		mod_init_result[i] = false;
-	}
-	return ret;
 }
 
 late_initcall(init_btrfs_fs);
-- 
2.31.1

