Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF77366AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjFTIu7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjFTIu5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:50:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D5810D2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:50:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JNLk0I004972
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VCQc9oDZ3E1+2FkyQ9khjbXTvxhJY44TUe4pdlmNBdY=;
 b=bru8E6cZyxoJVTFsjVLMdAcFOoYGZHCr7ogHOyUaROuLRod+51/YLTt+H5PpcFlr3ugd
 wQliwGJOKw/JnEj94krMC2TVjsYJo1HtTRMi/57fRcqS/DG0Nt/WlCDD2+5syPoeMLhM
 wNvQKxiCmU60GfNva8DaXWJdct/ch189WWSdXsof/ejnrtausE0XUEqQGLPthdyVE+wh
 osK4tGsi2AAGxOdXejozl4RgR9MzftWk2ExEa68Uz195zuvbvYrv5djf2Y32EnwBpN4G
 Vy2rEGeQ+v1i6pWhLeiGvoItc96Q16a8SZeUg0lzxbLQ8UEaFzl/kJ+g4TDGPzxFVlQJ fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94etm5q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8bUTD028854
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939aaa94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ52bq5d4s4uJZSBuZe9K52h2MVMfctRrSM1lVOHtniq/1evsKX89UovlZqNcxo10tAqYJSh2GZ9A3RhRoeUdPG8sUqabvfcdTBnYtzNfMfmXwwdZ9XgdTSyFPIc6wsDLgt0L2nMYnhZu6I8K8Js0E95vh0JMFVCjoaGhhNPgfp1Ny1CS6LahwI2FNP3NcK+Rn9RLme+DKyJ0Z2bu/F1IdJ4BYTIhU0rpi/bhwhkq+SIGHGF2y4YiY4GhJLFOiLSYeIKwzO3S/waC4EU6ESp30zNNdv1fFkoL9DaFLRyQb9neiAh5keVB4N4mW/OfGGocxc/ZOgGUlAv4lrsOeANGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCQc9oDZ3E1+2FkyQ9khjbXTvxhJY44TUe4pdlmNBdY=;
 b=kCCez20TBvmgfA9M//7aL8EGCjFANZlxTHoYyQsnC7V7GpecXQjAws+AOhgY0dWxlaP0izQ09UIxmXHo1STfolPEIarDn1nNSD9/Ebbw61QvYsuxa3AgTudVLh+HgSf0TnKyV5oS8KxMU2nZM47Vzs6l6Dbyf8ht7i5zCX5kFmbIt+T3Ch424U2FuaJtzDUos9XHeG1YGsqvd0VuMjS34a7yd6pF9470g8/Ka/3mq+1p1tAybUWuUYoIukUL1GGW3dXcpTiubCkVNq1JV1hrQxhJLYXYfGO5f8ynEr7+vJDXquB2CW0mEsm8Jh93C5Mfd25E4bDFxCOhrXF1D+T5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCQc9oDZ3E1+2FkyQ9khjbXTvxhJY44TUe4pdlmNBdY=;
 b=jJ/MBvHmtdObMYS6ZAkuNBCfLt3VTf8xIQgc3KBhmONNZa/R7ltnzBF7MWaTfe5kq4bubD2oO3EKiyhgEedgeh6zEfApy5pAdy2nTyDZF2qLB20gYk6KglBXKmXTpXPaiD6Y7/to8sERrnnWDmv1Nd8OK+35y+aNINixHQO1PPw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 08:50:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:50:52 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 5/6] btrfs-progs: tests: convert/005-delete-all-rollback check for btrfs acl support
Date:   Tue, 20 Jun 2023 16:50:01 +0800
Message-Id: <eb137d0a1986cfbc1b480f2a5d224954790f068a.1687242517.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687242517.git.anand.jain@oracle.com>
References: <cover.1687242517.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 401d37ad-e991-403c-552d-08db716b740c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QAZ3LUGkQKBNHYcAsf3V+KAJ85VQc8MLs+N0D/34FxrHTt7OrE/LL48t7xjwnmmH66lbTcPjo38qG0kymifpzEu+jym1Ddajoc6KOXRNyXwoW0QJIp5pjnOZ9u6xrdn6gMRNTTrbMJxYI+fhUoWYBQHSNieAaR3eun7WeNKsKbCYq5mnkdsb51zPzUTaxGeNWxhBu2945evl7ExhR3IQxwfplcNuVWidsaEfk9woeZWih2mx3kxSLFXH2c3odnn1Mj5AGzUptLfxRUDZUysT/RlQ4UuWWx1K9Yndf3RDQJccMv5ybJI+ZOWUuUj4KU1OlS0cOpZ5OvWTZ4OWpzeK+2WmrL8vpwdsbekz5n5q/YZweuVFgcXW479CQLQwWU5B5mOnHG1yUMvLLWZ43dloILPaLZbmKcceqH+aJHQlYFx1R7iU96l+rQPuOkYH3sclK5aDaZHbYBD/aAa9eeP5zcPvjN6+Or2+pc4nLx+l3qs1qWrIgnqIEZ5zsN4KuHKIPnNV0XwiUVT1ugA1XC6u8yINPh1bggXP6t37RBv17vKXzD6AKwzQrQUdnFpWgHh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(6666004)(6486002)(478600001)(186003)(6512007)(6506007)(26005)(83380400001)(36756003)(2616005)(86362001)(38100700002)(107886003)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRRU3ix5u50Bm6mUuQd/o7jwp42caAdUG/9lNMtAldLs4ASm7UUZQzZcvM3w?=
 =?us-ascii?Q?Xb2M5QVx8rv+2+cn4c9ZzA8O0//LVW1ly6J8ca4oD05BYD/y18rXAkdusysd?=
 =?us-ascii?Q?h25QF5qXo723T81D6bFsLPvwInPkeMVBFFhPCREsd4UXzfkJ3+ZKfK6azQBB?=
 =?us-ascii?Q?mOkr85Qw/U4H3lvxpBJ73+bxznmLjheepcIwAsRIrlUOLQ5YJH/VY4syf3P7?=
 =?us-ascii?Q?ZWZsF6IM1vHCZjLTu4A3tdaW7hCcoyokpWzPNda79UGoLzWsZylmQvIh/Jup?=
 =?us-ascii?Q?NJ4UvoVRO8qCu8iNlTUa9o6GvubRABlFMBMMddVewtBV6cnc+zIvl5fUN98D?=
 =?us-ascii?Q?OB3/aUW6t9NTYL42iPdkts9n6SLptL1SqbSCpuXbvBPrZh9iP7z7TxZxVdrF?=
 =?us-ascii?Q?EKMBPIQXFiznQgJr+iTK1YL6Xq7nujx+3WQBCb+kocfafuQVuPByNUD1K5MF?=
 =?us-ascii?Q?LgPl3vYEE9AETBPN+iZA6jbliBVX6boq6UUDCFAMcoT9xJBKnMavvKJUknYX?=
 =?us-ascii?Q?5EVn9/C4MBxYbkyNa9Ozm6HVtsXXZq29z30zijqa/4CNQ3Jcd9QuWi8QzLLP?=
 =?us-ascii?Q?+Vyd5xYpTo67iH+PLTr8RnGqf0NsO1xCZmUywTW5lCu7RREtATxmZNOi6AdJ?=
 =?us-ascii?Q?YcXnLWFr7v4751n+/jO0gBL50/f/mEzapp660h9Bz520Ip9M1rS7YQe/wxrJ?=
 =?us-ascii?Q?2PwHsxnhiS3IiRjTgLHtzoedjq3eDpo+wTB7IoXhzpeDvtWptyKY/mmjfi0t?=
 =?us-ascii?Q?jKKAkBYwzgfAHlHGcZvqyWFYsJDPzLyGOpTQHhmiCE/QffaaOqQ+TeHxsCY2?=
 =?us-ascii?Q?q1yKGkAMdLcAIRxWNLmdEbbiHlhuMVGL0YII3wDkfq+fyiJD60oLI7HDC8DH?=
 =?us-ascii?Q?mC9Nh7DIn/Rf/JrRgJKvqJULq6VYZ+aXW+M0Le9I81hjHM4U4tzm5TzjarqZ?=
 =?us-ascii?Q?aMFPuG33OMx5/kggCPQVJ8IHQXuBhFJM86NvM8i3S9LvmImSYrK3gPBN0MAq?=
 =?us-ascii?Q?Jpk34RKEjcERitWLxYP2Zjhos8ceciGHzHv71WgN8lby7veUDpcb29cwXCUk?=
 =?us-ascii?Q?VQCbzwk4VJOrMoSt8vnw9VuFiybmGvVvm5AB42TuA20ZkVsG1MDNeust/a3+?=
 =?us-ascii?Q?hoJDt0r3TsLc21OvP+TgwSdZnITyuqhlW0kxt2JvG/lX4b2/GENYbvst7sOi?=
 =?us-ascii?Q?wZG/bZG7+5/ghCrYgjk+GW2Pbh8vieYP4XUPRFhwHQ7Kr3xTpE7jY1Ss7raN?=
 =?us-ascii?Q?3GdJFIXx3vJgkp+OYbaxBTG7FyVXIUCNzVA9evZ9zXJRA6EaG0Ddmx36HL/C?=
 =?us-ascii?Q?5W6mlrXy1n8Q/aN4O6MkhUQ+HpYELkYQrU8dUSRNbAjIZoIR0Z/RRGhtPDmP?=
 =?us-ascii?Q?78VLihhBtfzXRcmezECHbcoUXGLYQMtS3dj7pJ2LlDrwOCOw54ziHvx/wUcz?=
 =?us-ascii?Q?SGutzAmh3SHAj+uT7ZCCPC3mxKYpr+7E4xLIvw59O/EokAHCOIkZ71TBmubx?=
 =?us-ascii?Q?CuXeo3SdU4/zgE0kJCKLNP87ddmalr0Qmn5z1DPigMKg2tnCbVDFaq3zJVyU?=
 =?us-ascii?Q?wgF8vOH1ClK8F3uC1tGCT6rVXF8PzcrgG7PDapcT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wGFPb2XNPB3gvJ/stFg1RTf4YzUp+yYTF2stAoIFWEqIqQ7YCDaVMyCVmwpK36+2snkkvDfEarkNcCmynbZBEJ9llubXReBYood21btnfqbLQB81b0oVlBLf0WYn7RBIMkjwjjqVl2LzBD2JRwvntABJtyZ0ZgB4YEkEkxBZ4pwBB/Wpi7qTC9p9Uwc90ED1tQ7ulZwCSy8KZqrT8vvgHPDWs4I3fhLzHJrtSc1a8EpnVCV8vb2zSuVWsgHP3esYVNMQ5CP/SWCfE7A7ttSYJ55OlHZ6QXuixexDzbwUFBw3bQoM1TcRKzWost0DgXwbEnui8uO70oIff163dfhwWj0nRVSMICXgj3p71SdNJPFvkrnZU0lVkeg2FBfkO/Jx5W+9G1+ypLNW/0guYCmh330u1O5TY2BLYEibr62vyZoW3RTli0iJ8xxkxIrP1VDs+ljeRsTGdQ4kRWgBNsfdpMCLpefFDNauD3DAnf1kH05noOAEHzmJVwtJKcz6j9RiibNDtWFxNBVgNHbL+CEPL4+vxbCBEsc4Jf+4bK2d8LzkztDtNdGjhPIkIjowUEXLNOKbEXaH9vOwDLjE8BmnnrzsqhvUw+nOYKXppeb5gRratdPaKfdB6k4oK6NZ1ir621HKJpch3mqo3zNShSjt/l96X0oMDnrkKeIQkqKUzxe7o09zpXA+Ape0gyupoc8F5xR6cFsxYaFEYgLwhLlphaY/mxnZ7tiVWyf2zKX6sTJbyYoItA2KINg7gb3Ces3xJbG4IiWEqBDcwj3RvPj91w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401d37ad-e991-403c-552d-08db716b740c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:50:52.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSy+qeoBZtHzh//rsC6XQtSj3aZnpvFAnivBUDnDoPK4se6FjnhjPDwN2AufhSfQyuwVJC1uZaYM3Qx9smYYWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200078
X-Proofpoint-GUID: R02rvDDGrJ5UFmRsdIJ9NDmFlqZ2LdK1
X-Proofpoint-ORIG-GUID: R02rvDDGrJ5UFmRsdIJ9NDmFlqZ2LdK1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix failure due to no acl support in btrfs.

  $ make test
  ::
  [TEST/conv]   005-delete-all-rollback
  [TEST/conv]     ext4 4k nodesize, btrfs defaults
  failed: /Volumes/ws/btrfs-progs/btrfs inspect-internal dump-super -Ffa /Volumes/ws/btrfs-progs/tests/test.img
  test failed for case 005-delete-all-rollback
  make: *** [Makefile:477: test-convert] Error 1

Instead, use check_prereq_btrfsacl() to call _not_run().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/convert-tests/005-delete-all-rollback/test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/convert-tests/005-delete-all-rollback/test.sh b/tests/convert-tests/005-delete-all-rollback/test.sh
index 0b668a6fc1de..02b53bac58a6 100755
--- a/tests/convert-tests/005-delete-all-rollback/test.sh
+++ b/tests/convert-tests/005-delete-all-rollback/test.sh
@@ -10,6 +10,7 @@ check_global_prereq mke2fs
 
 setup_root_helper
 prepare_test_dev
+check_prereq_btrfsacl
 
 # simple wrapper for a convert test
 # $1: btrfs features, argument to -O
-- 
2.31.1

