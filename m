Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82475AB4B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGTJs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjGTJrx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 05:47:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC1430FA
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 02:45:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K8pfWY013399
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=hMU55l4NWqOa/I/9JS2t2xTJlmX/6PRPJarAMJkOK8k=;
 b=l2p2OLzwOR86RBI40sVE2zTMt1OhMeP548t1KsKd7Cao/2lYB8my2uVPkZR1yaUIcVZD
 rKhcUjKeN2EgkLYD89RT9whQx9j8/CBo8B+D0D4u7ATQe+mxsOGLtEKa62kPVn/ssaSq
 V2p0gjegcCmhNpFu5+RqQWAsv6AmaoXEiiG0gWHpG2qeKCV7w4ZWgShrA9Otog0NHb5f
 Jvj5Z6RDMxwE2Wwtjc3WgqRcpm/kDA5VcZad+V+UtXrqtr1GHqs1JCXXbhhGlBJyfFvc
 zT7o/Vc2xfoYU+Y/p/Mi6Bkhmlmwky1+0MdH3tvzDafETjq8LRtExV1i+zG1Du93ZBhi 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run771c81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7RYHF023850
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8kp3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:04:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu/QjEtXQRntB5prK1IfeKnLUOfBFk2KatTr7rWZh66aH3egCmOYf7DJm8Rprbwo8xQM/wxfIk/CdA4e2UXnULgPxu8UtI3QoM5OVnK7+ujeTUwFc3fH7blVPAOVVtu4Tv23W0rWjajRYk60VJ1E8rExFzZtjSgMHbYt+4jhODuyJXbfkBcQe7YU3bR+RYvgqEGnelS7QJBorVZ0cIOKgrfG9qnnaf5gahlu71j2J79I2X5fYiBFo00HpIZB0QwVYCh/CkS+TgIEJX1NHzZhmCvVHX1PoKKP8XullZ142BJ63Jq5BG5oe5wxaYLGQtly+lKgYKL5vhhQ0Y00qtBhgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMU55l4NWqOa/I/9JS2t2xTJlmX/6PRPJarAMJkOK8k=;
 b=hiIJwE90RiGfTJP3RvdfecDxfe0wuQJbGTx1aIjFXExinYud1qGTBl23biDr4ogULyAOiY7YkSPcaMXyqukYoNNU44hmo6PcUi9ydOmdOi0osKFk+GpcEpRr4A3H1gA1QvQMummR0RT6ZccqV0FWYK5+05VNpZDn/n2WK5MmTKRNunAG9zd7VGtah/tbhoEXu+sEG7A63b+9eSjRnUiDCzw9JhK3dB8xEnFShytxrj0GVtjYxVmw2vZ9h9/xM/8ufGRvX/CEqOqsaYYw/jsdSd/FDb+Tj/hNn3qqZTO66LUgqdG9xbP/7VTgh9uNmw5iOW69uzGIJygLA6LBJ9i9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMU55l4NWqOa/I/9JS2t2xTJlmX/6PRPJarAMJkOK8k=;
 b=ZAj/i7wwecgi2BqCYmwAOE6Klq6oZC3JgE41uCVhkhbjs6dMtb7nuYLxMitow5V5moNJf8uuMeyriBqLT+PUGwzqjQKTyd2s/sCZd1O6YCw1bBHDLFS8yYCsqfcHIxEAhjpbrQkOyxKPJM0cv+HYJ1H6kNtLIwZO4PhsgaL1fn8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5181.namprd10.prod.outlook.com (2603:10b6:5:3a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.27; Thu, 20 Jul
 2023 09:04:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:04:14 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: dump-super print actual metadata_uuid value
Date:   Thu, 20 Jul 2023 17:03:56 +0800
Message-Id: <fb866ae05c7694093f3ba60e7aee39779cd3630a.1689841911.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1689841911.git.anand.jain@oracle.com>
References: <cover.1689841911.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 1993dadb-bac1-4ff7-b256-08db890049fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rtj3x74J1a5JzMSAtZtwKFTXtees2oW1AOEef1EdWsCCCG0Y3GolFemWjrUSpUrrws6/AfftnTyKyMCt9jR953xmtpJ1mVQmBaaWYofn2DaL9gzjHzsiMDTWC6IRQrvoo14fXRBGCmyzpx32zlbnSv6dyOtAcOI7Y5AenCOQrSDv+e5Pkw6/CJzax3gtFrbmIseslDTMfKwrTLk9fnCjIoOjBhoGVzcy/bHJ2VKoyUshwZP6ArTaaHv8aAn4HD6vrgC6SDoGVA7uuZJ2ILKHLd+S6m/9tqZLHIn/b2xvTnPFyMwwDpBY6ySzigzuPeo9c/kGcaAGy5qqcUL+w/ju4DBwNv4P/mF3KD1oHaJz9qfbnDLzKBRH1AoGvIvtMFxBOfqo5L9dVHb11BosR0Kz/3+4EtxB3Hymga6GG4YInNDXrQvWI4OYNdbwu88siDAghNcJ0VZzmi+Aw4crMhPaVlAf0jWyUQpYMt8P0gCylr+mRlJCLBfGGVazriAXdunTMr9rBybhPENcHW92M1xa1yOMHj2yehHAZ3bl32McKg0gxiqJtMdjrLLw1/pdwVHQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(6666004)(6916009)(316002)(6486002)(6512007)(26005)(186003)(41300700001)(6506007)(478600001)(5660300002)(8936002)(66556008)(66476007)(66946007)(8676002)(44832011)(2616005)(83380400001)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mVd7OG7rZ+3YGdEsr7rMNG2E/l8UjKDUqr+AFqyb2lvP1Ny8rMeeIWMDdell?=
 =?us-ascii?Q?GnfJRrboAP0H3XPggnYN92keRl6R/5kASbJjP5GGHcOdpV9tQoIsUaM80iXH?=
 =?us-ascii?Q?zkrcINGCNQpvy+F8/oobqoG5mWeHLlK+V6aEUOtpZ7gHL7d27na/ijABsRGl?=
 =?us-ascii?Q?tfqhtJ+9kL0RJ2dtigaXEwmk0EggYtoEfrU+vVQ4wMaPDMbmbP6nBcwv5qMr?=
 =?us-ascii?Q?BtklC+48vU/4jpNASq2Ps7fMn5/GkS+psgZXx69RwuzvQf9cGpX5LLEbMdaT?=
 =?us-ascii?Q?/M/jFvyt3hNAxTf+92HQi08BJVOrYkvcQ18g/7gg0306A7KJZL+/2VtCzwMp?=
 =?us-ascii?Q?6MDHcodp0HSu758JnVyYM0b7B9J62TPJKN03I2SxYr7Mr7ADU+WAhY8vVcgy?=
 =?us-ascii?Q?rgitRzfoSOjqC4m5mBvAV1J9iLWdOiYHN7Qtqvqnd3WDnnSn+5xwhkd3HWsU?=
 =?us-ascii?Q?hpngaphCg8tKyfHdvetNNU+sS8ra2BSPdPiOx5g3bJLf79y9dtEXmmM456JE?=
 =?us-ascii?Q?mo/+yZBIK8/XQ5Ck2KjqrfZRj9fdsL/LLpfvuzpM2aaVGmSWqN01srXZmBsw?=
 =?us-ascii?Q?i+6z8j1fEeldwV7PAbZhUl6ViTmf8Lp17qGUVWvCL4vX6rNZw8qC56TfTAUQ?=
 =?us-ascii?Q?k7lq6UnsfmLMZYTCv1TUgPjAY3FCQYzWU5IHHj4rHgHAuHkmwRKmGf7Y43TI?=
 =?us-ascii?Q?q/XP3vkJD1LQR7uM7lUIlKeaLP/oS19+Tsnday45fkEt5HrajgBf7fSacpdK?=
 =?us-ascii?Q?/L+xNog0sLgcQtA7MA8PLGyHfmalOsvHxXJx7KgUSMw9Omz1JMZ5id+4ZpO9?=
 =?us-ascii?Q?Pz3qO8d0pCdZMZ4IBsri3u0UDb5N7o9gR7oRHnkgemKEEP8R2vClJu/fqfNY?=
 =?us-ascii?Q?0WKRQX1u/J8N2UN/T6SqWXUNuiO6LCKu0iIBzODjVc58HyZq7MjlFp6tyyuL?=
 =?us-ascii?Q?n3QMDK14fsiKaXXfBGx99+66y4QrMWPA2mmtRLFPydYiNWo+QU901DzTHiM9?=
 =?us-ascii?Q?syptxqBTdlBxXowkBTgGi1MlnG6p7mmyPlShuwjXzn6dP3YkD2NQstzqf7oq?=
 =?us-ascii?Q?HrOps1Lv0ulOGuxVKd0niaZZJsHBgCQybc1GYt2kfkznjcYk/HBW/MCobp62?=
 =?us-ascii?Q?A34pW/7wxF2CrV5kk3F2urzB7Z7hqRw1AyInSj+WXgMKdpjpMvs1EbY5DWln?=
 =?us-ascii?Q?7KIfrcnZGN51o3BHwOv41HIS3y1rzesoMqSxYiRrE9BPlPmcNV6Uf2v1w1eT?=
 =?us-ascii?Q?PyymYV42TiY0HrjcgswmX/u73RzTrg2CIHC/q+ssh33rZUwUNPfhyrjxOvO2?=
 =?us-ascii?Q?WVzzJ2Z/9FxOcHfVt8PkvV+4xStjTJH4GCKOcDytcoYapjj2/vvA6iGNwyM7?=
 =?us-ascii?Q?UrHqUCc3z9CA7sp9CdOp8KLXx6KJXCPKGQpmRm8kTZ4mnq4YasGpzxP3Cj3f?=
 =?us-ascii?Q?7NSGvSe/lxFImq8Yz+YMWd2kGi2VLTWTpz/xroDde0ULevnvzhTnK8Sk3hko?=
 =?us-ascii?Q?NxHfe2SEQB6NznmVmcwK+NO5Qwalkr7P+VK1/71gcK99AZvy6hy1dG9DX+9G?=
 =?us-ascii?Q?Pn+h6KntHwo44rynVJgoSjLqaJ5m5/ggDcbd+tEG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6LWuBspPcY7lLHKOm5dIxzO2dkAxdl4I9MsYlZSmpPW6c0USp3AkK7v0n3RiXM13DDn4wKdNqNx5rzne0+CtLAg2gbHexHYiRh0N93Pq31fWQpf77LuIUjbn2RsSK3qLwhIqUFDggcj8zTjuw2aoScoQhHLpinHF6DOBgmGySHiIODlrunF4HGcDJXXtPbgMIUn4dfSNIjd2/PY2uwHIPDpTDr/HvP0wTFnYhwu+C0m3IOB87e2T0V7Ul394cwdhdotHda2/On90PFsfAYhpe2LE3fm6GUpbeH10/n3Q7BzcDYR0/08NMu3/xk49WHLKCtt9zBX06pWWI5IK+2PekQ947iCJMyW7cDL+FR+L9zWGpSZgLkIqDqvWj4H2RAdfifawG+T4fvd9oTcq8VH5HHpRkqh42sgLIP3KOV77LRBRYD/ZN0XnTkYFgk1GsOiemK3ho+kKitLNcgf2iGrP+x0XVZtXBIwFNppWG7ph3pek82LU3aH6Xg7Ruql824hQO0YeNG/do6zX5Afvowcxqy66d0jasjoSIiyUJKKcgd/4oJvURK9jdhQOLIOmYwgML/UHd4WjZmlsPoVQzh4QqOZqaDezJgWAywpSuX9V3ctR97Km9KlUPLfCNP1ac9EGlvI312hzRhH6AEHShRZp95bCF6ypRX/t0WXWBYkZBvu6eZVwgahLxerOkxujEixXHY0NUYIWVLnlvtbqtGJE0Q20WYWnEyot74cOw6QlI6K44NtSG9Eu+MP9DSQJDcTR3EQV/vkWLzWSHz7/+g098w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1993dadb-bac1-4ff7-b256-08db890049fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:04:14.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTWf3i0pzAB1GVSW3+KqIYxxC+JHN2llpRRDK2gMLiYi7iwozyWkxhaQbR8hku8U/R3ReWRT99zHn3+MnPg+UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_03,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200075
X-Proofpoint-GUID: -6e4MlpVf31BlQB9KFglFup41-AZ6-Sg
X-Proofpoint-ORIG-GUID: -6e4MlpVf31BlQB9KFglFup41-AZ6-Sg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_print_superblock() prints all members of the
superblock as they are, except for the superblock::metadata_uuid.
If the METADATA_UUID flag is unset, it prints the fsid instead of
zero as in the superblock::metadata_uuid.

Perhaps this was done because to match with the kernel
btrfs_fs_devices::metadata_uuid value as it also sets fsid if
METADATA_UUID flag is unset.

However, the actual superblock::metadata_uuid is always zero if the
METADATA_UUID flag is unset. Just to mention the kernel does not alter
the superblock::metadata_uuid value any time.

The dump-super printing fsid instead of zero, is confusing because we
generally expect dump_super to print the superblock value in the raw
formet without modification.

Fix this by printing the actual metadata_uuid value instead of fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/print-tree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 0f7f7b72f96a..d7ffeccd1e89 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -2005,12 +2005,8 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 
 	uuid_unparse(sb->fsid, buf);
 	printf("fsid\t\t\t%s\n", buf);
-	if (metadata_uuid_present) {
-		uuid_unparse(sb->metadata_uuid, buf);
-		printf("metadata_uuid\t\t%s\n", buf);
-	} else {
-		printf("metadata_uuid\t\t%s\n", buf);
-	}
+	uuid_unparse(sb->metadata_uuid, buf);
+	printf("metadata_uuid\t\t%s\n", buf);
 
 	printf("label\t\t\t");
 	s = sb->label;
-- 
2.39.3

