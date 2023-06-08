Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44CE7276FC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjFHGBv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHGBu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:01:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD81707
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:01:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Mv4DI026210
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+Hm6odQIKDYBtP1VMvY7VPZVH8gAr89gKvEjwz6myPI=;
 b=U12G+6/0akSF7bxSpXX1M6i81D6dZBIg1EtCZpyB5ve2UnY3Pwlt35k+bph1SiiLxwyT
 cDjZk4ycV/760p0xDugHBarcCzj3MkB5oaVOx2HnF8MQQ46TW5g5XsIO75VMllkmqE1M
 9NXDzTYGPn0UYz6NnM6KB71rfgQFwYWggAqsSJMwBd+NnqKVxh6UjktePFDfZs7C/6BX
 EvUfD9QWf3Q/MPNNVXBqD6vWwl7DKRIoNng1rN97uf3whflqvtAqRoyKpU2A58MLBD39
 fzN9Nde5SLCAUJHO0OGO2tkI5nb96KSLB/cSnE88sPgfvfw9ir54cU7/WUMggGB+mdMZ uA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6rbdxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3584fAYj037347
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6j5p32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtvcSium503quSkmcAQJVrfaEczCo7fCaSi2MubjQ8LHFxkmUzQbb3fORIhwILy0+1VapHOFI9ToIDQ4ru13+fGOCfBnMyPt9Yig2FBfUXyYBlSs1C9zP9+4pu7y0CtuaSM9lbl/o6SeeGoF5LIStab4rgciexmoS7OeGuO/jy5EAvw+F6CP1QW6iIF2UpOagiinS8sCTPaIczLwBZyEi2bGUtdEimXP6sv6/POI2aD9mDRa6jDBn/Y7LjmKQ0EVsTwvIZuU2Og7O5/6/1ooJT+nk0f6koK1+QeDVEOCNaLs2nbNQhnpgLLBEjmkiQhF15gnfaRFRmj+Z+Atnp94sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Hm6odQIKDYBtP1VMvY7VPZVH8gAr89gKvEjwz6myPI=;
 b=mt/UyCo0T/QGJeWUepw8HLxXX6HtQ2wBG7bgDf/L7lFjTwawGfGrpKmvpBxKtN08+Hg7147k7TUL3lSQoh1SIhIEHs6k71Kj5FPS41rJAdlPVmGQNmiWNh07CeAIy4U5qUKuh6hZaE6qoAoDeICiwOQ3SBuE3Mtqn9UKkHjrTp2nRjPiy66mfCSVk7vLBR15Vv6foIeVdEDkUk0lxCO3EkOyNDjZlffSjshPNNPnwNprUsE1CVQHpWhsFMee0ALkmi/CA3UNqyKVKVI59wUOnV9bvx4ERXX2SB58TDS0QCBkQDqir0hSULjz4G+ZF4jhd0CnQ5iMBQ7fqhF3MUQnyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Hm6odQIKDYBtP1VMvY7VPZVH8gAr89gKvEjwz6myPI=;
 b=Snd7Th3WIdWY0BuA8KrbU0SrJnVzEavy8NCaxb9PSM0MOUdCWr/cXqkaMZiMo3FfjuN3aBaVYENR8cfUjFzPeqlCX6X2dCZPS9J7uFUILYsd8Lq9fkGH0E3+MsVD2gzA2REAzz3m7VDR8KniW+9UTEWT1bGNley7hAk7PWgsXY8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 06:01:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:01:44 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 3/7] btrfs-progs: rename struct open_ctree_flags to open_ctree_args
Date:   Thu,  8 Jun 2023 14:01:00 +0800
Message-Id: <d6b012af9307b8ff71a3715e2e3d5cc58fafbee4.1686202417.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686202417.git.anand.jain@oracle.com>
References: <cover.1686202417.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: a8373f5f-3997-4f98-1d37-08db67e5d63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+Nw+mdu7pTDK1F0zxfXkRyMUgmIBIzJ0UGCL+ljTN8SUBNOF1Ujd/xh2E1W+Wq73yquZR4IqnzArJ4akf/m4NoQrWDFCi4GndTkpovOUOvTeCH2CGozgJj+HHuBZ80Wn9zqhcE1rPOqdf7+lgwdxYlUiTJx9/BTCy6i8QnpGAyOCQx0mnI/EK7f+RHuNM6ZEsJ+NNKOZzySIojEivuvYvKJqvlYusPCrSAH96n7CeTv9LO8a2XBXUNBsZuOVh1l2RvvW1bhz7zr/jVZPJx9DgacnRcEs0G5uNX2qt1hVn5wiqDDPz3LphY8UIKHOO+6/YOKkX4DEHXM2FYsWwoh5VJK2Knss12VkYxYvmczsRZSsSQE6TgWe0sgmWH0AcychB7tYQDZisOH+J5MYKNX70ej595srv7WEewi9i522qep8VxGgcRw5rV+PWFFMKXPgRKrew9oAQDKc9qQ2vZyUp0k4J0X+BT/D3lpxPohxDmLA0mOTPuW0tHS1MKB0ZyTYhtG0vwcQBPmxaPuHHq8omeuuKo174H43RESb2fYMDM8u1/ixh7EA1Kc6ffZzOHx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(8676002)(8936002)(107886003)(478600001)(41300700001)(316002)(5660300002)(6666004)(6486002)(26005)(6916009)(44832011)(186003)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(83380400001)(2616005)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q1uo5ZBvxCQ49wvpX03W0bZllgMhCNpyhli9Hd7x10gK4GKHrASRX2+RqaCH?=
 =?us-ascii?Q?iO9CIh3S7mAStPgOF0gmpwknu4gUv1pM4qVFUCb203wBzkmM083/5taU9DbX?=
 =?us-ascii?Q?cFrJ7GpYmoAsgVCgBnx31sBydUyT4JE4KUQyp1MGwKEpiqEwDi9zK3KxVc29?=
 =?us-ascii?Q?oe/fDfsDGU0AsFOU4KWDse34qddHEI9sRtKQYvZbW6W3nbqjhnw2Qf8Vzsue?=
 =?us-ascii?Q?lT8PoGACdUmXQzkSkhUy6N45aqbUGn764JfEfvW6gFc/xV6Ik8M3roJlvGfo?=
 =?us-ascii?Q?72iu993HjFYh/RmIO8R4ceWidNFv/MSI1RkzJr9G8hFmEmY+V34C8pufTYfr?=
 =?us-ascii?Q?al6Bx1BIvsl72tRsvGUm4+Ow5sfdAtFzox21GN63OWg1u+Xg8rMsSvn2iSHO?=
 =?us-ascii?Q?pKxEO+J7BlwIgU2PohHT6qzGXJ49Hb3VnAb5FAIHyuoeurCnXuO2x7S6+L1f?=
 =?us-ascii?Q?pSMf5MJfKgZUCpCJai9lo0U99tJpLOdjLvHkY+t2QSpEVP6mTty0TLi5sXs1?=
 =?us-ascii?Q?0u/y0HbUwFIxkZEi9RiX0h3bfHYfbNug0ZuQYJSvgq5fBZ/BMO+VWLoaX8H0?=
 =?us-ascii?Q?2DBdVdslUmF1Yn9m5VfeGtXrbmLtNgRR2ubri2KENaIql9klm3yoqbkkunU0?=
 =?us-ascii?Q?fxx+fRm4XV6YrsZ+TwJcDRlgI09CNwujGuQ6I8NTzIabejEagBVaVDQT3rpr?=
 =?us-ascii?Q?t0MNQoNjAliOAnkBZ8k6OZwuIL+NZpnSWPOmfC2GvXJKRZ/YJ4iw4PcuyYVe?=
 =?us-ascii?Q?WFDxvTB2JFfJ6mKxm3WV/xo4xK/BtphMZjivqA7atc2lbqK/lmaCQNl0Rgwp?=
 =?us-ascii?Q?JYzp1JlFLLqzM33/INFeSKTcQZtXLRUBDfWETmCB091KSG8xIn+Fkhcdb8bi?=
 =?us-ascii?Q?PP+iov2e1Idlw91E9Np9I8SOfpplQjtoK0b6WSS/6HjZOf3AMI0niCUzjXCJ?=
 =?us-ascii?Q?iPgW7Isdhnq7Jwuhcc/J0eCp0TbYHW3LxyzSm2RB/oMaIfv1aG1iN+6+De3E?=
 =?us-ascii?Q?rET5fakPEOhYUm8CQSfMmI+turLKmGw/bw8VBZiBIMVG9xtVIZkax/HDb1vK?=
 =?us-ascii?Q?fhwA0OQ3Gjyi+YbXrSCRYBIuUzM8wMif+7xyNFWuJPHTWLgbBPF30Cxpo+Cz?=
 =?us-ascii?Q?1/glaRvFox8/3074CWrFRUUQZ5pC7JE7JsjuLI6RPTeJ/TpZEUKLxdszqwiN?=
 =?us-ascii?Q?8H4cecV4/MaUdGha9Z6zvSHVii56T8+tvOIq5U9lQX8/F25jgJYWLPISSPUd?=
 =?us-ascii?Q?1vyE2wp5DwlW4fOhpFPAMjtgUvlUUTqkj9mh1sBKcCx5nQikyyYipa9Z4Ier?=
 =?us-ascii?Q?jfjhlbEex7ewD3w9ACQC+FVnvAnOVQl3+DsHmooytDU3l5hD4grV0adnVifG?=
 =?us-ascii?Q?JqzVGgC9VSaCl4+5pfbXiSeaei7UuI2QhWiZ53Ye8zE/ILPHT2LUoZbHQgHM?=
 =?us-ascii?Q?22nr0iailgo9KhrD9+q9/bx/m1ket/+BvuJt57LbPxv8rDF9Ie812T0UQmTH?=
 =?us-ascii?Q?A21XA83FZoqOXVLc79fz83uTR3nHIlVo4jJ/gy8+KeAZO84qQEkUWiqCOSah?=
 =?us-ascii?Q?ARGcmcQc9AW6ekWeuEIS0sMCr9X8ECGR/XJSbFIz/O0nTkiMsrn+99LaGB2o?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QhE/dK8xcS4Ho7rLhBiYd7ln0qjQjlUqvoPGI6mjx4BSKpVUcJn9aVgPHRsxWfFiaSe5JcVIeHqlzKhYci3H7dov7+GcB2U8DIuE1PjsW0he/UpLAx5XYtwJzjCHmGHTeG4jW6JwC/HPeibDszs/BOdT3IBYp1PPtVGkddY0bpLPgZIHQvEpE4mbToMAwnrJWcHNRSQmq6iIGCj0LRjBn6G5eKeYmLPZI4OHDmnOcTGOcCj8koqOm0hiFKajGY9RmI9AHPnP1jcx6ONwIT9JIxO6cUbi8eiDJAN3Jg+Qj30JMwwT7BBz7MFLiszDfHaj0xBVJkGg2P+tAqCxpzYhDRLh7Vcrtw5VjTZzyCofhOla16xnR25fKW+7wK8zJNXOLGOvTyyB0iy9/o3lwe+C10O3nqy1e/Smm2Azllcbc+tz1GsK3BB8Ze6P5eJnR4lOGF5nHkh69ycz7vayOM/eiLemgncrLE4JA6YVwltfqRPGh78oesCVMKzAfSvYdEIoUNX2cGJNFuFuleETrMiakn9ap8cV97ln+B1aBOnqKSwgtYK9Muyhb7HX2t377Xl8iNzYVT/FDjg82/KsRLwLk65ZvfJ+Y0sa8lokmgT3YhRmHwspPBWurzuxpW8dn4fbkvEIxbnuN7YuynXCut1TJ1qR4crxEvymKyjjJUWQ/BZvYEHHV1WSBIK6XnqsGxdD/jG0Guo2IjPQDoVZemKzMhrihBN3kvDUii1OdqlL4l0Zdi1uP4RmVtovaYgwAedh
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8373f5f-3997-4f98-1d37-08db67e5d63c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:01:44.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1N0JCy5qOhl+sAFQvIKK1f9NQgL2Y07dyCrh3J3SNQMBQzuwHDBoN94SCJlX3gOF2NpmFA0vxF8cfNfPj35jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080049
X-Proofpoint-ORIG-GUID: 3KVwXNBKMhnf9wcKMhQdRFjEHKr4FNQs
X-Proofpoint-GUID: 3KVwXNBKMhnf9wcKMhQdRFjEHKr4FNQs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The struct open_ctree_flags currently holds arguments for
open_ctree_fs_info(), it can be confusing when mixed with a local variable
named open_ctree_flags as below in the function cmd_inspect_dump_tree().

	cmd_inspect_dump_tree()
	::
	struct open_ctree_flags ocf = { 0 };
	::
	unsigned open_ctree_flags;

So rename struct open_ctree_flags to struct open_ctree_args.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 btrfs-find-root.c        | 2 +-
 check/main.c             | 2 +-
 cmds/filesystem.c        | 2 +-
 cmds/inspect-dump-tree.c | 2 +-
 cmds/rescue.c            | 4 ++--
 cmds/restore.c           | 2 +-
 image/main.c             | 4 ++--
 kernel-shared/disk-io.c  | 8 ++++----
 kernel-shared/disk-io.h  | 4 ++--
 mkfs/main.c              | 2 +-
 10 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/btrfs-find-root.c b/btrfs-find-root.c
index 398d7f216ee7..52041d82c182 100644
--- a/btrfs-find-root.c
+++ b/btrfs-find-root.c
@@ -335,7 +335,7 @@ int main(int argc, char **argv)
 	struct btrfs_find_root_filter filter = {0};
 	struct cache_tree result;
 	struct cache_extent *found;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	int ret;
 
 	/* Default to search root tree */
diff --git a/check/main.c b/check/main.c
index 7542b49f44f5..f7a2d446370a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9983,7 +9983,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 {
 	struct cache_tree root_cache;
 	struct btrfs_root *root;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	u64 bytenr = 0;
 	u64 subvolid = 0;
 	u64 tree_root_bytenr = 0;
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 47fd2377f5f4..c9e641b2fa9a 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -636,7 +636,7 @@ static int map_seed_devices(struct list_head *all_uuids)
 	fs_uuids = btrfs_scanned_uuids();
 
 	list_for_each_entry(cur_fs, all_uuids, list) {
-		struct open_ctree_flags ocf = { 0 };
+		struct open_ctree_args ocf = { 0 };
 
 		device = list_first_entry(&cur_fs->devices,
 						struct btrfs_device, dev_list);
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index bfc0fff148dd..35920d14b7e9 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -317,7 +317,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	struct btrfs_disk_key disk_key;
 	struct btrfs_key found_key;
 	struct cache_tree block_root;	/* for multiple --block parameters */
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
 	int ret = 0;
 	int slot;
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 5551374d4b75..aee5446e66d0 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -233,7 +233,7 @@ static int cmd_rescue_fix_device_size(const struct cmd_struct *cmd,
 				      int argc, char **argv)
 {
 	struct btrfs_fs_info *fs_info;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	char *devname;
 	int ret;
 
@@ -368,7 +368,7 @@ static int cmd_rescue_clear_uuid_tree(const struct cmd_struct *cmd,
 				      int argc, char **argv)
 {
 	struct btrfs_fs_info *fs_info;
-	struct open_ctree_flags ocf = {};
+	struct open_ctree_args ocf = {};
 	char *devname;
 	int ret;
 
diff --git a/cmds/restore.c b/cmds/restore.c
index 9fe7b4d2d07d..aa78d0799c4a 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1216,7 +1216,7 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct btrfs_root *root = NULL;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	u64 bytenr;
 	int i;
 
diff --git a/image/main.c b/image/main.c
index 50c3f2ca7db5..9e460e7076e7 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2795,7 +2795,7 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 
 	/* NOTE: open with write mode */
 	if (fixup_offset) {
-		struct open_ctree_flags ocf = { 0 };
+		struct open_ctree_args ocf = { 0 };
 
 		ocf.filename = target;
 		ocf.flags = OPEN_CTREE_WRITES | OPEN_CTREE_RESTORE |
@@ -3223,7 +3223,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 
 	 /* extended support for multiple devices */
 	if (!create && multi_devices) {
-		struct open_ctree_flags ocf = { 0 };
+		struct open_ctree_args ocf = { 0 };
 		struct btrfs_fs_info *info;
 		u64 total_devs;
 		int i;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 442d3af8bc01..3b709b2c0f7f 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1437,7 +1437,7 @@ int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *ocf)
+static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_args *ocf)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_super_block *disk_super;
@@ -1608,7 +1608,7 @@ out:
 	return NULL;
 }
 
-struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_flags *ocf)
+struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *ocf)
 {
 	int fp;
 	int ret;
@@ -1646,7 +1646,7 @@ struct btrfs_root *open_ctree(const char *filename, u64 sb_bytenr,
 			      unsigned flags)
 {
 	struct btrfs_fs_info *info;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 
 	/* This flags may not return fs_info with any valid root */
 	BUG_ON(flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR);
@@ -1665,7 +1665,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 				 unsigned flags)
 {
 	struct btrfs_fs_info *info;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 
 	/* This flags may not return fs_info with any valid root */
 	if (flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR) {
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 3a31667967cc..93572c4297ad 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -175,7 +175,7 @@ struct btrfs_root *open_ctree(const char *filename, u64 sb_bytenr,
 			      unsigned flags);
 struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 				 unsigned flags);
-struct open_ctree_flags {
+struct open_ctree_args {
 	const char *filename;
 	u64 sb_bytenr;
 	u64 root_tree_bytenr;
@@ -183,7 +183,7 @@ struct open_ctree_flags {
 	unsigned flags;
 };
 
-struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_flags *ocf);
+struct btrfs_fs_info *open_ctree_fs_info(struct open_ctree_args *ctree_args);
 int close_ctree_fs_info(struct btrfs_fs_info *fs_info);
 static inline int close_ctree(struct btrfs_root *root)
 {
diff --git a/mkfs/main.c b/mkfs/main.c
index a31b32c644c9..23db58b7186d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -990,7 +990,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct btrfs_root *root;
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_trans_handle *trans;
-	struct open_ctree_flags ocf = { 0 };
+	struct open_ctree_args ocf = { 0 };
 	int ret = 0;
 	int close_ret;
 	int i;
-- 
2.38.1

