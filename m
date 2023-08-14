Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8077BCFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjHNP3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjHNP27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:28:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322DF10CE
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:28:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiYGb026725
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=T5CmfhFyMVKJeyekulbExe2BpsDbR5d9MpMvyAdYA3Y=;
 b=QITNsX54eQ87TfjcwV/0Lns/Mv8XDU8FAxl2MybTrLRvKjIIsZdZNIcwR3UTkT0eSKq6
 iF0A8/Qo24FOn/n8mgizjUii7Pixb0HE54IQ0Pvns8EmO19xS/QTnTciyuoJCcHAuO5i
 kgtEgJ9+ynYlxBxjsb3NSsFDcDeT74LfuiT5qVDIJc4tgUyt0/INI8j71lIUgkN4SQOs
 cUq8C5XrFXVra8BSJ29lnehWn3qJKWs0x+WlR/p5vV7qB5l5lJDdZzcdubBccyQYrCAn
 A6LlFLhHnuEWu630U0HIjCtEUUxe1wziuOpBmmIxgdQHGIoVPbPcmQYLq+g8wKewiBK2 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwjve4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEqq1u005488
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2c1s15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGb8Salq1t4v2KOSE2PRvDXR46KbEfG4HRDLV68co2LG+woDEaangUFYcMURyYTN3xl87TeJWerIRIlpbPOW+f1mjQj7xIrfkZjUXUI5JJ0dL2YiVzZjJq+etBNwv+DSiYd/yBT7SH34i1JAG53iiUZ1QsiNghZp/Mq57My/MVgUYsMSgjdMFxS1c4VPf83PHkDNmgFjLgCgJ45i2lIJQ8bM3b1uMCEjqPWJSoN8t+LKm6foQ116VyPTy8M6KBsR5itNOwzOULvf5FBXnQHyW9KwI+SXfCk06JmsLlTncnMuG1a3ugNr7dikdyT9253+zN2IytrqrinciVQ7x00bcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5CmfhFyMVKJeyekulbExe2BpsDbR5d9MpMvyAdYA3Y=;
 b=Jxki8YITU+DruoCkSP/WYivdPf5Zcz5KEKnsG0AKNyRkXoMRaC+0DzT8uuEDUUbJhSrwIBd/1I+X7/Fp79FVfbte5yDaBY0YQjhwlhqHr0ixhtl6QNKdwPw/RXQZ1NhwGuk9vTcc4Nbi7/F+hNhT7JMLlhSDBy+jK+sQiBSQo6YOV8g8zNwUWSlXlgLkvz2HGzqWYtDWeLcy1O08Cg81ih9WSLZiDc8vUKuDvUFRwZoKa6gOayNr0DelGBuUr73bCQBEgXgyc6PZgZuAyEBdAHDhZY96FnNj8JG0rYsR0dU4Hl5Za0S8WeJXyf+Uq2tB3d3Uda8KkcySgrI433Nr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5CmfhFyMVKJeyekulbExe2BpsDbR5d9MpMvyAdYA3Y=;
 b=WKMTbMT3FWdAHkm58Vrla4Svp3Owc8Yai7v/BSDhJzn9QcRnnx4GjUNh10/wk6ZtD4WHpgnKs0eMCT4xSAJjk5UEQGrBWYMACZLZPHVpPfH65pCtHw7CwshYJKPEF/YsU5cOhJH4TYFIxEEEM8UW6yxP6ev/8/GIkBBOQhh4pto=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:28:36 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:28:36 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/16] btrfs-progs: tune can use local fs_info variable
Date:   Mon, 14 Aug 2023 23:27:58 +0800
Message-Id: <c604ca9902bc78c9a6db8c1f1d210653511faf44.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: feed1631-3e9d-4ae4-f6f4-08db9cdb2062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auE0zwDoPp/KcrTni8ucsFRptepJWacKk/tU47+XJYfz+VzvhPrX424Ui5VONk5o+uu2A2u/LeulZgs3m35CCb5xh0ExJ/vaZ7TPR1+dvm1h6V4+xyq/1RM5/a/+ZrBS9wk6h3o0Yo62NUXCGl8PaIWmqYeWKVqbdYfFEdEDrJR65RmUVO904LR0QsRt2VCG70FL2Osz3xE9ERe9YycEs+YA/78tqKQTDzgaDeQcFCF0xCD/Yax0cphOKEOicm4OSbqLUESfG0J2v7uaNLcyqaD44P36sMcEq/KVIpJhOcFN/AZOsUjfoAv0oAzD8RGTHhdjoJLhlrJeg3Hb/ST2xFnxfpcQjQPu5n2Zgjx3zHAbLGVjLmLLB9Y9yiNShqp6snnu0sDVNHGp+w+JBtFMBE/9EPEot8cMZ5EbjJJseQGYhuVHaxrTn5XvD1eDc2n8FmZpgKUQHfHz4nhIjBXBQQVv01HaUPxtxoXaJPfwZ3wMUnAWQE+y5e+IK0G9unl3sPlg9g9gsGgEEs5coWuLWRVN/o8pgww2b9HaqRsq5rPJx2j9k8FkE9alAw2ykXms
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gjqK6LR0DBn8VzJ3DYFI4+/bmOcVL3wXdAh2Bds3KST+iVGEVlHRA1IAf1rl?=
 =?us-ascii?Q?SwmKOHxqOE71MhnbuIwG1KTs5qzmRVCQfBXWLeC69iJeZUP1rtYO0FBW9U/G?=
 =?us-ascii?Q?3qe2sSKC/gqegWCau8dZvWrc1rjyPVBliv1vJIZbpJrMVMu0GkKx+17pnyiQ?=
 =?us-ascii?Q?tJg3n4oQ3BbR4PWu+nzfG9sk2pGGDeYN9uaz2h1+YKi2WZTXfRjkqSgktXQZ?=
 =?us-ascii?Q?ER46nGEu1E+18PD3tYwFr1k434tdvmEc88c3oAO7xhzHoBVYX90TONjW41Ni?=
 =?us-ascii?Q?DtmbL2DnFQCrHdJtc3u6DF72lQbN6WjtpdOd5xMO6BpTjOTQUJnR7utesbee?=
 =?us-ascii?Q?F7SNeoS9S4GEnR2SfUpSVpmNs2VvpzB5DJ3pOMEJQvrVdOSfdFG67UU1V2E1?=
 =?us-ascii?Q?HWlNBZk+Bd/rf8fdxC4DCTdWBe0ttq3by2tz3XLU+NSROFS8fy2woovNr7PL?=
 =?us-ascii?Q?cGZNDa8upcWRQDVd6BkgMxMifax+R77QdfpHhP+QPqwRxmAXiCtUUki+aj9/?=
 =?us-ascii?Q?CtTsG9Q75Sg4z2fYw6fPFwS8IYBwUWd5yzQJPa8pLq0JDogemEMbcudYrdpE?=
 =?us-ascii?Q?b2tt4WFCOJ5U8SPHr+GB+3p07qVGZffHn9OrSHQPDJ5mzdqWSW9eleJAq1IZ?=
 =?us-ascii?Q?IOnEhBK1ZDK7SjxZbF2EC9Xb9qXE1ptNy2q75b8bBwCa7/J26c8bl7RiNZZQ?=
 =?us-ascii?Q?pkHU9zD9Alio2pVX/jskZzU3LPOUViybIVge0tXaUJOFCg5H2oRmUFEihBoK?=
 =?us-ascii?Q?mkCTBGOnfmbhqZVIot2WWtFViLEfQFVnnX4SJl8+uEdiomUSGHiN1WLgTQf7?=
 =?us-ascii?Q?XBKDrtJkn0Otl1VJBvrv6z57Dsj0nTaYpok7by+5QYK9/q2mrmVIk2zGG8zt?=
 =?us-ascii?Q?OcMjpNRxzhxLhLPjwC2l9L1BDBXUNW2Fq2RCzdhtJXHW3Zx+qoDsAZQG8FwB?=
 =?us-ascii?Q?dMDugCkQ3d6N8Uct43liFrOPAjdEuskCBrQJX2JkMYhKsda4q4zpWqVZ4bO7?=
 =?us-ascii?Q?86R8ocGIMCWdlI2ttWYI88qhveukUhs7rA0OyoT+v2cBFQm6iZezzzcm6pBz?=
 =?us-ascii?Q?aU9CY0HASOug/L7GM7TAwcYfwNq7XH1kzgB9QM69j23CN258suydDu1oWyee?=
 =?us-ascii?Q?CyRassQC5znSBTvoL9yBs8K3fo8G6wLpkkHrOYnNN7A6PHvH/DNMTh/6BW6R?=
 =?us-ascii?Q?RzgzBXeE0UrxRhnwV6n0dKeMn2EWCMvtfLEPfLsw3cdQfXYwdqmjlmvd8+14?=
 =?us-ascii?Q?KDCFVbZ/iqc46tvZvlwyFas1P1tTLDnswuwwblhe2noCJfcFzyeCw09btwUN?=
 =?us-ascii?Q?rN50PiTIqlgnxg9D1WSk2ZxAJUfKDWLbR8cNpwxn53D9RqfgZCHogl8bE1AE?=
 =?us-ascii?Q?mZl/x6CA/bmH6GYmXB+eNvrRWKAO5CqpPDrxq94xusgvFSP0/KSjU3uH/TlB?=
 =?us-ascii?Q?T/uZwGQmGE8gQR2mYCoIYoFFVk23kFbN2WFZ7YYJqwu/9LxY5peKQapDoZG7?=
 =?us-ascii?Q?P63hk6vB1SqO9iEM1tgGhPuStRGvKm+xaDTWmHC65M8QWHPL1B2K0+pHXMaP?=
 =?us-ascii?Q?sTxc8E2RCPi6o0zcb9oYiTh/qFt4Jjgeb+pnghCx/WT2WQsj94jesUu3g0mm?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dsLtK6csBmaf/0hXqlHwp2E48v/lI7RnoDphbxFTvlMzvG2//eMHMm0QYOBuOCBgBpRxykZtvdEMcuifs5VmkS8SpkFXRLDKxXsWgyP3EPPJt91eUYbMnQStKZZl1ULeEVIFFR/eB6LCrCZUkcIRoMpkEz9iGrHu2RYUADmzD6xp3y1uk+pvPkRA4F/jN7V4s9wQM3KuR/YDqczeO89DyLhz4xkhyUVQxtiuooD+wjWai1Jt50UgtVV+vbUz9FUrqQ+v1PfpuzEakAVhuFQMKKItdg9qjM5MmCBmoHM8qoSXYmLismJ92XyUKVa32fDhoLwFkQtojRpmY8OUhKhWG2o4bSXNpNRf9I5pxAlCFry+NX6YkhpSkdYoLQtvZ4Ee7cHct+o9k8udVXsWaGvFDW0YLIJnI/H25mSHXwYT4A1gbM3TKdAWl8EZ2NajY4gLeittBmzC8mWArG7+8SQLLS2yx0KoIePn+Hqag3PEXFHYG3v3JhV+pPfvSiSkf3yTmSWkYis1zdYvMa7CpoeIWYx9UkpqzrygTVYbJNKKbjEga0C4MCkgs/rjUK8K6DqhYf3ja0/O8+qGDVYrfgWDmQPkDsIiQ/6CZiXzAKRaRvoGqDYZ6s7FiZi4RDrFbpEVrcmPlz+rQ57j2s9YgcDDkdFTo/l79He8+uqDuLPPsctBLhjKS+kKX/uF+rqISVi+6d3hV7nNYklwDv650+CzPDxlOHM5W1MFlNjeVPwE7sm4p93034jMk/wgD1IsBRv//KEVleq2WJAn0+b1tcl6aw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feed1631-3e9d-4ae4-f6f4-08db9cdb2062
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:28:35.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vP6lQ7VIGCCCuzOsNnDgnEd79DXmTclZ6cY8GUuoAmpEX62ADgWN312wG7v1Qy3CflcSCgwWlfZwTpcFPImlaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140144
X-Proofpoint-ORIG-GUID: D4X0GxAKZnK1Zo_0iO2mqpm7t4-TR0v1
X-Proofpoint-GUID: D4X0GxAKZnK1Zo_0iO2mqpm7t4-TR0v1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since the root pointer dereferences for the fs_info several times,
it is rational to save the fs_info.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/tune/main.c b/tune/main.c
index c49c24298187..e3b199c10dad 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -133,6 +133,7 @@ static const struct cmd_struct tune_cmd = {
 int BOX_MAIN(btrfstune)(int argc, char *argv[])
 {
 	struct btrfs_root *root;
+	struct btrfs_fs_info *fs_info;
 	unsigned ctree_flags = OPEN_CTREE_WRITES;
 	int success = 0;
 	int total = 0;
@@ -296,6 +297,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		ret = 1;
 		goto free_out;
 	}
+	fs_info = root->fs_info;
 
 	/*
 	 * As we increment the generation number here, it is unlikely that the
@@ -309,9 +311,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	 * all the partner devices.
 	 */
 	if ((change_metadata_uuid || random_fsid || new_fsid_str) &&
-	     root->fs_info->fs_devices->missing_devices > 0) {
+	     fs_info->fs_devices->missing_devices > 0) {
 		error("missing %lld device(s), failing the command",
-		       root->fs_info->fs_devices->missing_devices);
+		       fs_info->fs_devices->missing_devices);
 		ret = 1;
 		goto out;
 	}
@@ -322,17 +324,17 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			ret = 1;
 			goto out;
 		}
-		if (btrfs_fs_compat_ro(root->fs_info, BLOCK_GROUP_TREE)) {
+		if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
 			error("the filesystem already has block group tree feature");
 			ret = 1;
 			goto out;
 		}
-		if (!btrfs_fs_compat_ro(root->fs_info, FREE_SPACE_TREE_VALID)) {
+		if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
 			error("the filesystem doesn't have space cache v2, needs to be mounted with \"-o space_cache=v2\" first");
 			ret = 1;
 			goto out;
 		}
-		ret = convert_to_bg_tree(root->fs_info);
+		ret = convert_to_bg_tree(fs_info);
 		if (ret < 0) {
 			error("failed to convert the filesystem to block group tree feature");
 			goto out;
@@ -340,12 +342,12 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		goto out;
 	}
 	if (to_fst) {
-		if (btrfs_fs_compat_ro(root->fs_info, FREE_SPACE_TREE_VALID)) {
+		if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {
 			error("filesystem already has free-space-tree feature");
 			ret = 1;
 			goto out;
 		}
-		ret = convert_to_fst(root->fs_info);
+		ret = convert_to_fst(fs_info);
 		if (ret < 0)
 			error("failed to convert the filesystem to free-space-tree feature");
 		goto out;
@@ -356,12 +358,12 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			ret = 1;
 			goto out;
 		}
-		if (!btrfs_fs_compat_ro(root->fs_info, BLOCK_GROUP_TREE)) {
+		if (!btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
 			error("filesystem doesn't have block-group-tree feature");
 			ret = 1;
 			goto out;
 		}
-		ret = convert_to_extent_tree(root->fs_info);
+		ret = convert_to_extent_tree(fs_info);
 		if (ret < 0) {
 			error("failed to convert the filesystem from block group tree feature");
 			goto out;
@@ -369,7 +371,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		goto out;
 	}
 	if (seeding_flag) {
-		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID)) {
+		if (btrfs_fs_incompat(fs_info, METADATA_UUID)) {
 			error("SEED flag cannot be changed on a metadata-uuid changed fs");
 			ret = 1;
 			goto out;
@@ -402,7 +404,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	if (csum_type != -1) {
 		/* TODO: check conflicting flags */
 		pr_verbose(LOG_DEFAULT, "Proceed to switch checksums\n");
-		ret = btrfs_change_csum_type(root->fs_info, csum_type);
+		ret = btrfs_change_csum_type(fs_info, csum_type);
 	}
 
 	if (change_metadata_uuid) {
@@ -424,8 +426,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	if (random_fsid || (new_fsid_str && !change_metadata_uuid)) {
-		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID) ||
-		    root->fs_info->fs_devices->active_metadata_uuid) {
+		if (btrfs_fs_incompat(fs_info, METADATA_UUID) ||
+		    fs_info->fs_devices->active_metadata_uuid) {
 			error(
 		"Cannot rewrite fsid while METADATA_UUID flag is active. \n"
 		"Ensure fsid and metadata_uuid match before retrying.");
@@ -445,7 +447,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 				goto out;
 			}
 		}
-		ret = change_uuid(root->fs_info, new_fsid_str);
+		ret = change_uuid(fs_info, new_fsid_str);
 		if (!ret)
 			success++;
 		total++;
@@ -454,7 +456,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	if (success == total) {
 		ret = 0;
 	} else {
-		root->fs_info->readonly = 1;
+		fs_info->readonly = 1;
 		ret = 1;
 		error("btrfstune failed");
 	}
-- 
2.39.3

