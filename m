Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9268A5FEDE8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 14:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJNMRj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJNMRi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 08:17:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391D2D772
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 05:17:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ECCdU4028022
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 12:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Wl8HJrGRvioB6snUk02feaYJj/AHqfX1Eq3xhSP4brU=;
 b=V0OCnMRcwBZ6yRnVYkUvmIYtpdoEW3zqYi9Fq2vQNW0VMMwmpVxcdu3E0DdV3cvd7vG3
 QROjiRuFRA1a36tetj5JstCgKh2O17+QqXc4SaSdtMtmd2zTss/5EhgGdcrVr6YU6Dkc
 UaEqJHGw2JYiSoNBRfxgXMFUqR0N7RxPsW4bkmtyiE9DyRJChC2p1MyyxW0ee099eP+a
 dqdzfoOqWI57gxgSFLlYPIuyZCzStJU9BsL/zH+xooSqZUvJ4MILfxRqTIz2L7rdPPEW
 QpFcCilThsdEBQD+3EULeB8QCWIH/i1LorMRRsbpydvH5hRJH4bOVs5fCyl/D2tQxYw2 Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30ttg1b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 12:17:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29EBgDdS034075
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 12:17:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn6y3vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 12:17:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5yUQ2lzVQGXq3TfI5hC2csLzvtR0IE7MrOi96tzSdA1XkY8PrF9BlGaFEOIvrGGBko7lo/n1votryCDwFQJRWKklsFVpbzkSFFSbT/DHRjrbT3OFS9fGXFxJ+DDY+7+TTq9UcTRerxjWszVFmjszSIbok7dw+wXLNz4YGLRuJOdkknW7ruq+IqVtku88oAp4xZkXodQZAhvIkULeD6M6K4FGLo3g+pf+eH7lUc4lmCKe5sVjAsj3IXdUWX+qQciW674a/0hzTBbVwZ4ApIINDcWlXmc5Bt79k0kmGny/F/YMJ/reh2taWXReCiVfc1Zc0OhRL3HKd+DjAR6C0ZwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl8HJrGRvioB6snUk02feaYJj/AHqfX1Eq3xhSP4brU=;
 b=BYIWM2ZDFY1mitwWOPn9CAvTvWIh2Phf9FPOyuNacKQ4x/Y/EeXHK73HXB6eLfTxyGsImXWQoakajwk8a7OoicmcIXPuNYRI7rQoRkYtkHlQowtL5H15hawFx/2H3/Z5R5VtKg/0xq7R1mNZnhS4QFutE8esevQ/+FzgwKCJ1TkuaqDdsM8259DY6P0OoeePRsccU14HrO9MkWOjf1C6yxV9zmsErtTdIQxDARUdyOykVnvCJAby50KKy+EntvC4Sljd352z2gx6b5ADo9tPmi4Of9GYyf2v2nShaTFSraNzp4JoNkwB3qQYs5JBAf+KaCKkdgSQg4YNSELaLizbSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl8HJrGRvioB6snUk02feaYJj/AHqfX1Eq3xhSP4brU=;
 b=MzdA9zGcWpB62ECpOON1gytACCEwszfPlAMYbR+JbPb/T/q06qtzcGQGEbNLYPJ5Bo1fwBzuLOBcgm6HPcrDNRkb3QOnirJh6BbMh1Xpze0h1RRv/ZfvvtBxWO8G5gKcS8YKWsj0NWC2DaaeaQ2uiMWjvzd6TmSpUiXobS0YznQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6599.namprd10.prod.outlook.com (2603:10b6:510:224::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 12:17:33 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 12:17:32 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add helper to exit_btrfs_fs
Date:   Fri, 14 Oct 2022 20:17:26 +0800
Message-Id: <a1e9999846422fc971c5bb5f79d517de6530a55a.1665745675.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b79eadc-609c-4cb3-49cf-08daadde121c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdrlefitwvomptHtmd7Bzczc3aqQSVRwys57sH/OSrw/0Jgib601X05/FzjIvlr+WI5qHNNFTxyLt8IMN0zmsa4ZhzVtdy9EgE0fP3ZlvS+YwMv1jEK0IrWVvgsklVmca+ewZ9533lk4jFOHAz/JbIyStBoM4eiX++wfW3Ifr0lpU3Y/A/mxyzszG4cdt2f94b3REHCx0U3/wat9eNxzRG/0cFBO608qURpkdh8+neWIpd7YcWN3Y32Md39hb2C/AGkVUBw+Gk6zDVz75r8T1Ju2G+uatboVpVQJ4GTTKSLK2i9UY5E0f7xpJrayNHY+BqhJ/md4m5uDsT0Ba/6C5m7x36MFG/o5Jygvr1O1znkdF77XyQ9jd+02xFmqtAeNIHnSG7EriM+FLY6+KHQ1svH+casbXYzjb4N02nD04mqGf6Ro0TxmNhQ+ePINlhl2HLXtTEQCDdswfT+mXQqf5F7qfdO+Jb4y6Jhz/UrIwcU427Xa9juazw1n/ZdccjMJnLbStxMDCvC0ZNdFLO8hesp4iFXuqkopZGIBUMj+bDeHDP4uEs1x04uhMq20jmK0Lsj7BKrb6XyHgjoBqGVWj/s0XMDQ26tgmS7LThkci7keXXaIIW1/3/33HIItbDC5v/NwFKYVsQO2QrIX3+2E/nlFFzJ6edXGC8Wk/yC3TCtT2Qmcc8OGDNFJbbvwrZTNQjlCF9Qb6Gy9rt250/bxwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199015)(2616005)(36756003)(6512007)(86362001)(26005)(41300700001)(316002)(66556008)(66476007)(6916009)(8936002)(8676002)(186003)(66946007)(6666004)(38100700002)(6506007)(478600001)(2906002)(6486002)(44832011)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?01d1i8o2eNfK+qpHds4wmimnI+/N5o/7pqVYP9JPwuMceTy7kj6zFih22gw4?=
 =?us-ascii?Q?7He7BPAZNTjV7dM6S+6y2nOYkYra/VkHN6DT/WwQHtgRuc1YA+yjK60OnUid?=
 =?us-ascii?Q?/KznAiiIXHTbrjkDrtxvfhdw1DsT9vKhf8FgYTkKwprwfLq3kn6d8AdHfD0h?=
 =?us-ascii?Q?J1LVl8Rk71IlZMOYxlfqY1ubz8jrIcqHrAXMzsn+u0AmtEgJanKOBiTCX5IP?=
 =?us-ascii?Q?l+dhzvbxrGpf/h+KCSrF1U48E1oO/04RDPsh/uuoJGRo1LAYsWlt11qJvHUv?=
 =?us-ascii?Q?b3hBK9TYSs7Zf6mhlUQaQvefpVk8ly8M5d5VQ0pxtk3U/UoFflUjjMvl1WWC?=
 =?us-ascii?Q?CX8/7H7FvvociIn2/mlBXmEKbA53JRNI3QvXT4ADXaRVD4p8+5Y07rIFY7eH?=
 =?us-ascii?Q?UKtD+PqeKPcsNh73Afjm8jwWNgSbNqZ6HIwR8XayDghSGPp1MSjm3FfTgXPD?=
 =?us-ascii?Q?BB0FlnMWSevIdhWqW9Q/iCL6DN3/0wTSqMJCY6jClP3h+V2xPBc9v/j6DkM/?=
 =?us-ascii?Q?jEtAUZgjFbk6K9E6v0R+LhD3cqkDjE0DjEcp8P1l36x60jPCmOYIO3B0QldF?=
 =?us-ascii?Q?Dh2T5FRZzr+gms9zIyLrWPjvHzdM0oOsRwqq8ndv6x0h18mvFCTZEUCmnhgT?=
 =?us-ascii?Q?7ba+mPTXM3MYwHlJcm2EnvX+OJtRGQSj09R/Lwr/E8+1LQHEVaae73mBFhMF?=
 =?us-ascii?Q?xsqQRBSHiva4lVaiKovGZQ0Ggj4T+vbrLdoVRCFyVzJ3i7utBhgnwnpumkVj?=
 =?us-ascii?Q?jDsEwD1MxfQrVC6wxvVFJb10YFtc0a21YvNe1bAlej5E7zzTEWp9b4IyMXOM?=
 =?us-ascii?Q?Ahm6gpq769BX4IVEhTkOEO1gL23ncne4nHH0JArLPePNVWoTKYt5pWFxY9lJ?=
 =?us-ascii?Q?k4qYufCxXz8wO8v2ZLj9ADLrQ9UlSXsgtCOj0euu3OPg0dnP0c0kq2veJ4I7?=
 =?us-ascii?Q?7QJYd6ZMaELZAMQBNtNYRROPhcR5We92xf/Duon8g+24Fs8OMGFq6j7aoomh?=
 =?us-ascii?Q?6K4RHVB+e3rq4ihaDPXcoTdUZlC6ZBzyPOVzvumeIzbMtCz1rUmYh6nJPoXt?=
 =?us-ascii?Q?iAFU5qg1b/JeXN0ZBe4yb0O3XjJ42+o2JXrVv2uOo08YV1cW+9/frHnJTTR5?=
 =?us-ascii?Q?wYeq7/5sRh5r9BOYBH6Nrz6E8yfCqHB+TGWnVMTNFrCuZ6bvk+SAbiFwiLqx?=
 =?us-ascii?Q?ZQpOuEnHQzHeQF/MVqbrDZezbaYds3ae66OP9ShyEP7YJgJyBHpz62lDSieV?=
 =?us-ascii?Q?0plnYN5DWu/MbCAx2IiaKogJVpg7444lZFQAAvxkPyv6AA04zV1/Ir44gFEY?=
 =?us-ascii?Q?LTIa/cqlBBwxx7pXbgz3CIcW1Pf7LPnKwUbW6mtMYMjy0CXjquyQJyykKwqI?=
 =?us-ascii?Q?lgEOU5REJdXjWLg0ePpoDW5n2IQbRkjEwo8xI+1gMi9dvvwh9dQ8lKSGxTLZ?=
 =?us-ascii?Q?Qtx1RtGafcyf1ua/pDBPewUHpa50Y9LqJUDa2JFNj7Tud6ANVSNf3jOgdd+x?=
 =?us-ascii?Q?F5B29NdAg70Ubb/gyppY2LAJGNV2STPFUE1KU+Db5qpy6ugpPUiCPVeomqKk?=
 =?us-ascii?Q?Nu9HKFqmtjUzkvh1RnZBTrtfRqV3BIjlX+imAxY5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b79eadc-609c-4cb3-49cf-08daadde121c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 12:17:32.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiKL3s4vLD5z8UMLUmvf/zVtFyHxYJLF+LsG87iLAvD/a4dyfFGWm1V400gZYPSHTFPcyL7ZClQuxeYAwwnh4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_06,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140070
X-Proofpoint-GUID: uED05T7CscU3CTvTN8wTEnPpeK9nDnU4
X-Proofpoint-ORIG-GUID: uED05T7CscU3CTvTN8wTEnPpeK9nDnU4
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
index 2356b744828d..0c48bf562aa8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2791,7 +2791,7 @@ static const struct init_sequence mod_init_seq[] = {
 
 static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
 
-static void __exit exit_btrfs_fs(void)
+static void btrfs_exit_btrfs_fs(void)
 {
 	int i;
 
@@ -2804,6 +2804,11 @@ static void __exit exit_btrfs_fs(void)
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
@@ -2812,26 +2817,13 @@ static int __init init_btrfs_fs(void)
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
2.33.1

