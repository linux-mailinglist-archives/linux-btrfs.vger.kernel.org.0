Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91433788BEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343846AbjHYOsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343847AbjHYOsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 10:48:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF242119
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 07:48:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDOUII021574;
        Fri, 25 Aug 2023 14:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VLu1c6xlfkJswHdiGJ2idxnp1jKQ1O+XJLWwUfE7Chw=;
 b=IbBLptHuk9u7R5+Uz70GWPTYetpbmEpaQvqIdOsj7rRS2ZGvmKA2yUbWOBjmy2nHEntO
 rFThr0TLzKVMuBRttB5PKXIX3P2hOCZD6BNzPyMAYVtrkoODEqshqqzr3FmTerWliFuN
 2Aa0o9N4KzN6i+aNKsq7dltdxXDf3r4DmB3M8GcQLpQGZiiBIxAiCNRIfE70ruj777C7
 nXf26vcpuFGkdc1p1yvMVBfX5fIyHD4dA2XQUolhcXBZa/P9v0vldnH1rhSAsy80vKp7
 UYw/FKA3QRp8rbbYP/rv6qqVkTePfemtX8tlP24AB/+bHtp1MVGuA2X7mYvZgGvU/Wqs Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvxjtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PEdplc005772;
        Fri, 25 Aug 2023 14:48:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yup3fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6zeVMpeoDWkiz70qk/vTs2gtdUA8rS+9L6i3f055zFxqhRtGpPFNA0f+5D0eVisWOWn9zl8OZ992nNtk6KBD0Pf8w/DTa3UjCytzhW7Z2TQ+EhrVj5seys9ONRpyTXOchZZVCtbEKE2bSQgij9gwTSiR86dkAYXd1iejGVLU3uHUUyuvzHUEvXYWljL1bO+Rci3ecIRB0ivCowKXc0XxK4MiYiVVLcy0fJK5bh/MUtZ/xD1067f/MMG57h9X9ZiwVt3WhfU3fxpPRk/dAwDQ0PGYR18U4Waod2MZ9zXfCwcNTIGHZfg0yt1wxYembaKz1CypUOxMZd3Jq8x6yMVRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLu1c6xlfkJswHdiGJ2idxnp1jKQ1O+XJLWwUfE7Chw=;
 b=BRPV+JMenKGCkuZmCQC1kuvKPxuGyJdHSq9InXr0jV7tCwK9pMLn98mK7QdmFZjPdH7ujJh60JVMCZckcTOjvQ71I+J/ROiPmtBGp+H4sZfOunPaZdC6ROMclV+GaItaF7yzQEuJeU8WC/b33R2s5E/d6QkFG5h15NMpbxoaxTOgGyZwYo7W1qw/VQ1OX6H46MsOC/WoSLvf/x8zrV8ANzNVB5BIo7LKCE2Dzys6a4IKN+UYkm9SMI7KQZrIUCejMvMbx8ZrDYiCymBMzTBXbBSkRZZM9LFOp+GA3oy9hrPGZquaSvQK4/eCeYCIQK6UezqhvmjVo6buuKqD5TDK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLu1c6xlfkJswHdiGJ2idxnp1jKQ1O+XJLWwUfE7Chw=;
 b=Pmq2UvFhdKv7PF7GQPwHvq1cEAPDRGv9Wb9iYduc8Udg4dC7S6HqLT34J0cSDxeiSA+YB2gVQ2eB3bSrm/Wt6gzFSouHre6QlycDCUf+MHNSPBtleX5l49K7FUe5iWfX7Whgv+NG9L0otJEMvbbCwSJt5wpGlBxRjS6jDf3tgf4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 14:48:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 14:48:16 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 2/5] btrfs-progs: tune use the latest bdev in fs_devices for super_copy
Date:   Fri, 25 Aug 2023 22:47:48 +0800
Message-Id: <c76f142e562f0c337cbd657b07fd9105e5ff34c4.1692963810.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1692963810.git.anand.jain@oracle.com>
References: <cover.1692963810.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: c69f296e-7b2c-4009-54da-08dba57a50cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qk0h66FVlYlUrUNhL50um/2zEbw9ZdHCNupRMHzjSt/5eup2HEAxRGlaKPPbWtf3Grz765NMDxAvDLiFMNL9pxqsVe6eJgaPwr6ENiJCYFMP/bqUy9uyBjCvX7uwDXgl59B/kZkSLk7taWgONQ7evPLlwwH3ZrxQT+/LSTofd/2D+QpXHlkf5cu3jKjngtjGNQq1bkFkujgpIFLTPIESDsNzZiJUOa709WBRZQM4bViruKFc7H2ZR9RIfcCyMTwweo5rjq419MKarXpCyoqJQYovTYqngAhAaQUfKlWqhfdSb5qKfx3/VMesPDy5mkoh+OXx80a7fpchJXxw9JtAA1VGiVrb+Teao9MT+jxff+bpYYLp04tZZnrzaQTetyh7mdlPzXuT8TBbVbuTD66NF2+EQReq9Ocgbm3EBXQzA5Zar9STN2zN/9CR1CkAeetbagpRCv2YVklR0fx2XaDx2zlEx5PuVk3gmTWIgo1V/wzh4wtguvWCn8VbCYQ0QbL4MAK5zZeXavQRMWEYMHhdPo9y7DpiXyFSWmPcMAp+6ebd6RUcE5hg9j8NX183le5n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(186009)(1800799009)(451199024)(6506007)(6486002)(6512007)(6666004)(83380400001)(86362001)(38100700002)(36756003)(26005)(2616005)(2906002)(66556008)(6916009)(66946007)(316002)(41300700001)(4744005)(66476007)(8676002)(4326008)(8936002)(5660300002)(44832011)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PujWctNH8CHD1y7cFCNZTTiBiMwx36991iC4Z9qiIDb4a9m70UWFq4J9X/JR?=
 =?us-ascii?Q?vY9F1MtydMnNcfA9W9LlK0dib3JJQMknmuxRCILMoR6hDgd0uyZrxxxI+BBH?=
 =?us-ascii?Q?wHGucorjjxVQB0uwvHt0t8drpFRLDol+HAt5AJg0RAJM7gcqwMkrTfnvUY5i?=
 =?us-ascii?Q?Y6XRQLvk5mDZ2CwuphJs9fBymxwzE55EYpkBwlL3U+vOHOF4E/NQluTbovOj?=
 =?us-ascii?Q?LupKYWlvTZ/s9BjYTE8wazD/1Z22j1YafBrLgMsxDML/2PRx1GoycFl9JTQc?=
 =?us-ascii?Q?VHmtA+eYGGfAK/h2cGEmLtsIMqzKgpCjfMPl/aqMdNO01cT9yEU1uaTcsF7P?=
 =?us-ascii?Q?mdkoOGh/4LMxGKYY5C+7/GeA2ZSJrB0BXURP1MFAzOvjR1m218Y25XGa31qV?=
 =?us-ascii?Q?XhJZbFnLAep9JIU33RuG8+upRxB6JJaYyTIa4PjqmZW6EaGazHmHl55vz4q4?=
 =?us-ascii?Q?WCK50OcpI7FvdWG+dFh2lgmiI85mySwl1MAbluAhiaW1LFwxDPsGwEzFZM29?=
 =?us-ascii?Q?ZGh4wGUpsfq3l5K6OHwPrJmn9MtcbVv9QrKXqCEykcpFycylGQFaTyA+b+h4?=
 =?us-ascii?Q?bT76nB/JNqZxpDLwXIyYwFb1f7fBB/RUx5tF7YbfcZMPv9roIXSQbNa6wbXK?=
 =?us-ascii?Q?eAxCTgc5aqWpvrzGmQNsfkJGKQuzwHEHaMrl8WFKnKB5OHSWTnRjihu0KGq1?=
 =?us-ascii?Q?1Z94Z380Q1BE5IQe4k7bJpJbfQRV0yQsjqsmgHy2EmdfrU3Gb9yM7TV7xCQZ?=
 =?us-ascii?Q?2t16Xv1LVfNV9PUqaym0Fd70EputXAej7iaHf98p1CiCZfxUH1FJfv+Ah+h2?=
 =?us-ascii?Q?XOTBKE8VAyDxZ4Tle+AGMTnzDcbeQbUndVjcK/4r7MZCme1MFxeolFGfW9jr?=
 =?us-ascii?Q?Ij9dvvqigev8mU7qSvwwgEGUXzxoaa7tV12k7RNyUdy6awnk5FAp1BiaDUgz?=
 =?us-ascii?Q?DUt8YDvbMV8uB8m2Ex2RqBnOsX6e/ZNsr6Quo/tPq0rqvIt7tKz6NKb0yegB?=
 =?us-ascii?Q?w3Bx3sEi23e3aFzJc1/7ikYYrTT7Q8fcz2xJ7hM/pgMHTkCJ7fRxImqE8Wyt?=
 =?us-ascii?Q?nYqkGSTf02fRuxJ/lgVXbx/rBm3HqeMEKD5ruBQuPOO5bYvKUDNmMbwdFb5d?=
 =?us-ascii?Q?+8nzxpmSKMALiIE9Z6JsWIuj5H49iWs7GpM0BWMYmmoq6InsxcxA+40SvdT8?=
 =?us-ascii?Q?ZBNdFb9sY2VlCv3iRbOv1kZbEjmA+XySDnelagkT8eVjDUtCLXVKpd/uJsQ2?=
 =?us-ascii?Q?jMW0mKWps/UyMB4wW8pWKE3Pl9VEuPOnLeqGlLMyKwW0Ud9DmGO4tWC+YLcP?=
 =?us-ascii?Q?qbTVxDTt6fy16bv3Wva1IBB4Kde4pNHfKAPO/aytZkpZDJum2hRj5EgD2XEA?=
 =?us-ascii?Q?dWwLOVmaJs/e0sfK55+qdLmvgJewZREn+mPngYg1Bf5FNFzIBhCOpvUexhN+?=
 =?us-ascii?Q?I20H2/8bx8p6Irzet/Iq+H3GVdTBaY6ap0wV1jIRLYzHZp/iJJRO2/tm0lcX?=
 =?us-ascii?Q?hc1KppHKSL9NgLsLjd0z+IOfuCwE9DIk52iKYisb3T0aFfKtHkecQcTTjlDm?=
 =?us-ascii?Q?j0kQoHUPOcXALezefOKxkV20l0eSkZN8mmJviTwrP3WVtklncFjx7DoykJV/?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Aii8R78ZuB0cveN1ZEw4rezKWG+Y1ofi2Tk8kNGMjDHrOLXfMBUUVZDHVkWMqt9wH7mGvtZrGPdtj7BCBKBaWyVKxN2T5JauvPBw+gqK3QvNG44zS22QJXARvy++7tx6sWrKa5jkKZH76M6FwIV6eM1T5QgHmgmQxGHuNxGkw/fwKoEqeH3q3Yrzn9TxuHjy5HS9aCJTA4N9/wZvMO/SQoRtVHuRHvjZSH0FsjLMtx6dpnl7t2V9sdA5FNuJDNmM+/2ZUgC+tKLP3i1MLkfsQ8ukAlY6BUtPcwYT5/Hfs2dN98xMzLJKxyQb162/ik7liRqtMa+H2zKEHf2FHjBHomjVV1TDeAnsfbmcRVwtFHbZjG1ljxFPXRknenicxOL5RNtqqv7ioYrbmWvbQQqElPp7JGa/QwsO4Rsw1YsYBVi1S7HrXgBXNs1OuJQ/qtcQQodAaITCiXc3xeTJE8GbTvZdYEYGoj21KTivXBP/DNc4TJ7Do81vvQn7tMrGeVqbwOR2sVaRuSqhAWJNtR4REomPck+GzxK7g5Nmqh0qRfUWUgMgqRrnJ9NknOPV5OZcc/HmlPGwPFvVViR9NXtGJWbX+4i7q0+8MiBh2WAIxVeuFDu6QWBmJdtGEIdi5dvcdHyO1svfcNd1/bQooEG4E3ZkEHxou6hL+X+gDMucByQpsRrAH36ZXuW+k0P688fQcNcwmP12P7QsHFMyXxhjrz23ihdjKb9emIC5sT5jtrvlV9O7JwDkA8Qjj9hWVdhhpyM58OWzsfHFvyQp5L6EUf6foliaogM40BYR1f3/75k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69f296e-7b2c-4009-54da-08dba57a50cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:48:16.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQOW8SDDh0swzhiPt+1BbMv1+XIYgwFJxFFzPY7SQH2JnhtSvaGK0BI3TH/+nfbbRJURKDS1yWOx+9GEhfm/rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250131
X-Proofpoint-GUID: 30MVAIyE-BidyS9maj8U8bkiuq2ekfWO
X-Proofpoint-ORIG-GUID: 30MVAIyE-BidyS9maj8U8bkiuq2ekfWO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfstune relies on the superblock of the device specified in the
btrfstune argument for fs_info::super_copy. Instead, should use
fs_devices::latest_bdev.

To support for reuniting devices following past failures of
btrfstune -m|M|u|U as in the following patch, use
fs_devices::latest_bdev.

 btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
 btrfs-progs: recover from the failed btrfstune -m|M

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tune/main.c b/tune/main.c
index d344cdad06e1..7d2e2fb3b97d 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -290,6 +290,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		goto free_out;
 	}
 
+	if (change_metadata_uuid || random_fsid || new_fsid_str)
+		ctree_flags |= OPEN_CTREE_USE_LATEST_BDEV;
+
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
 
 	if (!root) {
-- 
2.31.1

