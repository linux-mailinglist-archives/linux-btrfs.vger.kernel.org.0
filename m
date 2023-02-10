Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DED69231A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 17:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjBJQRK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 11:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjBJQRI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 11:17:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE62E05D
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 08:17:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFMT2r007466
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2022-7-12;
 bh=w2qHXhReUOqRW8wBVH4zizUAmMVTM1LfkxlatWebWCY=;
 b=vaGoRQO8kpGZ0c6EpNkrOaxzDLP4J3O9fuUU9m9ZFcv0p6CtDHsZYnSGI9CV7qGH/b7i
 RhS3EjztKhSlzpBLP8Vt6Y5jlYrVWSNIFNUBuvpx8vRTq76Ak1RL1hTg50zvfVH+W6HP
 OVYMwjJAVMycbfB5ZgArvu2026taH2ifLzXKXt2lN2kjdmkViOIAMEJQKbu/jxzVO5Do
 Yaqu/TUFloGHnBeJXL9a4Q6tXLlJ3DJaDEcDngGyvfG8BN3f8AXc7qyPkJ/iLhZWs8J2
 k5d2gAO9I7vU2GWeWnc9CxU/V8XTRqAyswBtbsG1/Dni0aOqQ9Qwt7IW8oIsDx+omj9Q sA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdwk0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:17:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AFJbYr002978
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:17:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtaxkf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:17:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdSUOO7kRgIzC4egxsR7JUhRZCuIEPxa9XElhRe9UbuAbQkCa2ccdEZzIyaJavFzlcSvCVZiajfOVuAFwUCtpe4Q+61u2k/jymljBLC0iNwbNg1wsWfRWbdoLfHCbaRCbzVqDYuZ30B+xCwVQeck1ccWpJlZOf940B+QLbIUjt7VbMTDDZxpIUd6/H4AQ6ji88c+GDfg64MQJgQchS1jKoQDAICKjDbZmw4w7M6vsy9DIhMB4bJCKDzLAfleX5FpexRroQtnyfmFmkjKvGt5uYUpY5iVMIoor4+hmbSzf9U02sQI69usscriv9rbvpt2RcMkIv6//oLHyXHcjR4r5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2qHXhReUOqRW8wBVH4zizUAmMVTM1LfkxlatWebWCY=;
 b=S4LoPsPDjj5nS9a7cg9iUHFkdALA6ySn1wKgl5218YkkDLOtWeLnjuHn8kAoUZA/1iqSyJ2TQJ8iatkJa5w06VxVjz21PrRblmOC8mvHthrJmVLuxUAFc2K3lvdDZzPsVZ19+hI/r//KVHgOURfCet2JdmK2n2b2qWBQp6jKm6fet0qVhm84GZslKDqjfQZ4AK6G9D2mMbvnnclAV0wVujpoOT06IvmfqmbhpTE4wIBtCy0FsRMwt+mPWLmWzW3Cw0Yoqd7jOJQMoPVv5L2SA4FQ1RFmVXSfeEFuYAMpDrsS+1tzO69AiKFjVvNUXm6/ZvuXzYgY3xKNVA7dkkvBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2qHXhReUOqRW8wBVH4zizUAmMVTM1LfkxlatWebWCY=;
 b=jf9JlXcrJFaV29rUDRTXZMfWHaSxvqRcoGSOjAQmdAkA/Syibk+HzgVFw/vpaIenn7uuKJK6b9k+ymYNqsBlBHDkc+RcGbkVQ7OMg3Qov1WFRz+aLSFDgarx5BLsE+EFcxHniydX+XDnF9crcrmlvKoYXnsGDDgmj9jDG5XIIag=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.6; Fri, 10 Feb 2023 16:17:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 16:17:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: optimize search_file_offset_in_bio return value to bool
Date:   Sat, 11 Feb 2023 00:15:55 +0800
Message-Id: <5ed6a5476b2be3d9b459db87f8e7d24bfadfe02f.1676041962.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1676041962.git.anand.jain@oracle.com>
References: <cover.1676041962.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c53600b-9a5d-4878-498b-08db0b823d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhNnZZpv4pW4zG1Dyk1RuPm1AAOvi8L5NHfqgPiAghwZom1IsPsm+v7QJV1EKYh6GLzB5PnaPFBhx1ojOKP19+POd7q+UhgDNjz753iJ75LlEBVvGHYNoYFTqP8C5rfPc8TWnaqoSjjdqjxBehUMrEfHH640I99LxcZ2o9ipzSGMLRl1PHUHPU6qouUMMY/PYOTYN7jcEhAAAggPXDE2MiZmnSAuqqzJ4r+67uiD1w2WBBRP3PU1ih8gTuQdLZoR7oVZNY8K59ZxoJ0JCrK97U6odOgFRd6RPGgFsS5yskcECgBpcC+1Vis8on+OozMNVI3ohhUYAIzNgCFt12UKV1BCfuPECbT/RW+9lIJowcqMpISKl80tBJuRtQ8SwsUShfvqNEZVHXFs/I5N4Zap4YP2cb1PILjBaW27nfke49THjf5ZpMVMAoImaMvPzQbTYIra/kZzzxT0MNj6fHq2bQcmJ2S33P8BGxrt4wqPe6LqmHwayFzqQwWXJipRCzqVrdvRCZEWRSWX4VKVT6248EURODk7on5+Fz5cAFYICEzA0PMd/ichFddhJQRn6rG0PGzjjj+ZOe+hiEuss1gAKBNaULyl3B951lcaeNT7yoMQtyv/J5iyomu6A+QCUxlJ7WtiwCQimuBmBWDutwPF7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(478600001)(316002)(6486002)(6512007)(26005)(186003)(5660300002)(8936002)(6506007)(44832011)(2616005)(2906002)(83380400001)(38100700002)(6666004)(36756003)(8676002)(66946007)(66556008)(6916009)(66476007)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2dZGTX0sBk4Lb03c6Ya/f0CC/EEAwxmLtQ+oEDjdIpWHxZsM/2zgo16w1IUN?=
 =?us-ascii?Q?Mpt+hPzFP9pwn2ftVNxoJBgx8i4hZOW9TlxeD3C2FSNt0+gCF1MUXh0m6XlD?=
 =?us-ascii?Q?GASSaX0rpteIAmw7BwZxYxp/c1axGscYMsxZotCxXOZlCjbqJ99VRAV9aAMf?=
 =?us-ascii?Q?3czncY1FBZkvkd7kTh/R/CCSSZn5YrIFJhZwHI78VmuzAtvrYB25xN+03cva?=
 =?us-ascii?Q?kEK9Sg0Kk0xcyTNefNIagZLLSxSUyQ/WU9XV6R5c+Twta5mPLQo1/GYEUvwt?=
 =?us-ascii?Q?4kswctDbi15sqrUIra6LvEZ+1nhE0Fa2awHGg1dAO/AbGROoPARKFn0Pe/3q?=
 =?us-ascii?Q?DlG1+KxvtqL0LkcFE8HHM+IgPbJajuwGODfa2U00XgEIhbUkgJJHCHocn6Lq?=
 =?us-ascii?Q?b6DqX1B4GlCFM3J67btVE7H3sLEdDaStTTu1AAauDZTh2WVubbSTU1sgup4n?=
 =?us-ascii?Q?GJWCjHGAEQhfpdmkQ2fwtxdSbOj90Xld9h2+F7BiMFlJeKJGrS8T5qlI30Xn?=
 =?us-ascii?Q?bE+shcn8Jh7moiqR8c9avr4yS0lhIQibEjohUjBKMGpZlK4cN1VtPlIK0bKb?=
 =?us-ascii?Q?Qq6SHmt+xDtdoXmiJTPbsq2U19hbKprPdLtPFuIMYY1YK3UVS9bwkMmVlxK4?=
 =?us-ascii?Q?VhjhUJuci8I0OUyfurr2foeYjfeajECvwwymbb9EDKOhKIyGe/jtn0p4OEOK?=
 =?us-ascii?Q?HyINEs0NaJY2XFWA+s7491BtZFnq1vmqwGB6OYNDYc3Z94Jt4ELokx9tv8Wb?=
 =?us-ascii?Q?3YRwPpgKJNWs8LPqLVnghNSH6IgAaodxAQJbuwVOW1IZNg8fxRP1Thu3ldzl?=
 =?us-ascii?Q?BZ+uxPxQoVqnT0c7y3ppsf3XLpmvdP7/liCUFX2K5jh//N+R5wE+KXGmX9Zi?=
 =?us-ascii?Q?YD1SV9tmEL3ae4X+VRP2MsTF8O/fuKXKKFdzrjWSRmPbnDqw2SRXbK79eK1n?=
 =?us-ascii?Q?lIIOIBR4HhvPJZLp/qT1pXJCyhd3QwAlyCk7d46RmU18M3aK6Tkz0VMoGCjQ?=
 =?us-ascii?Q?ykcOZ5F7FFyCGOvsY6L5cObRYe57yCqlmDlN5aCH6N3tY9vyDZ0IS5q5e46R?=
 =?us-ascii?Q?InKUHddo/O7a+MVPGipN8eo5QyIuCAnRoQVNpGlH96Ql3zEUbxv7vXrJOcwd?=
 =?us-ascii?Q?+TSws45pQuXVJGklkduk92N2/ttLYwM4uyiL8KNbcjQWPjvr3d9J7e0p0Ta8?=
 =?us-ascii?Q?9gTvGT7ZnnLYPLovWJJm/1R5E7ys+HJr8G7hkMBe//YJpx44SiAvtl7FvqtH?=
 =?us-ascii?Q?413PURDpaxjdSPJWY/vrb3vW1Pgej3Vo0Xn+3xgS29LGDXblckeyYL19WUUO?=
 =?us-ascii?Q?gRKxWziVCXgIiunseyYG2P8AMAOS84Nwm6HL2XYDgdiMfZyQhVtfISlUS6rf?=
 =?us-ascii?Q?sQ5f9UfL9O1Rc155NgelOw1b3i53x0nSrNlbXwpvZLeZymqdUSwq8rjmKhks?=
 =?us-ascii?Q?1MTgXCS5GNQJHDUdEwNeoVWz0k/s/jdZCXxWAhW13om5ti6qB0cKIWmDQiRB?=
 =?us-ascii?Q?1FWEXr4cV1ig0WRH2Fu43ycockYyOPnV7g0UiD4F8cYzEbitbtmnxJ7cD7Pi?=
 =?us-ascii?Q?h3gFmNcTV5Yq/LhJOjANqKoJoKNfJn8PgSX7lbqfjJDB+i23x2FpQMBQ47bu?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G7rbdEASxRcNLH+X82OjmC/a2U/By+cquDbFRrbUZSYtOtnrgWQgknKGi4rUKMHNfQKkYxwsm9fCpj9mW5LF+PdzFdRAGzHuL3vUNdvzsk1pVwcq2Z2eCHSU0W9NJJ7TMhuG5YnhflZFqqY2ApM4Pj6bnRCd1E5s74cDwsC1wD2DmtpzGukax8aT+MqRGOTxQX9nwf1q2nPtVjGpIqTYdBLAmxE+Kd7RuT8MIpklCsKivwl3PCB92zDWz4pWBRi/RkCJxfzhkcewWVJU2lTX138ZosuIEPUv1q+PuN/oxXT98OsyFWHeuXOXdV+FJ0gvmgj0xc2PQxOaImkIeRPXAxf5vJ3UfTm94gML0286RTNw5/qwBr/qbIHRLHipKdPEJb6ckf9sQT9fYP8valcH4EuyUc91whTcuyrZE9H6VaFcslXQDRXdqUsRXhOArdv+mVpWja7WrhX/sbyIhuC/33rrfuv3vPuPUeBfqzAM8uDOQG+2YyYaei1IdlRcN/1Kyp92GnjbAibBFMREA27E6SvYpG/gWPPMzwYbOLAl4iaVDLW0mzZwefBRrvFdGzrqGbNhtfyhyUX+xwYblPuNiQZKOc419MIWuUk4GBTcxduxFGUKQmKXDpjKMLM9wAyQvfURT0jFSK40aZaqbUuE0fjBK1H15P11M/fSPlOj/uHW4afnsFf4YcgLIBU7IEfNGUVnzld7rMgldw7nJDru5m/2LPUI0abqyF2S25uo9X+th2FmuwMA78v30PvNuvKqInpqEnOrjFq+Z3qZ+5QsuQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c53600b-9a5d-4878-498b-08db0b823d23
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 16:17:00.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uWH/uqVRAYK3STrRXt8PPO6Sfw7XtpZ+E8wCuh1z2rh2vIm+AyAi1GYp2OnGILodriC+jCIrerwTAkywrwZ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100136
X-Proofpoint-ORIG-GUID: XQA-2k0T0KvYsD47ODY4Q_NgKKqHYTjn
X-Proofpoint-GUID: XQA-2k0T0KvYsD47ODY4Q_NgKKqHYTjn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function search_file_offset_in_bio() finds the file offset in the
%file_offset_ret, and we use the return value to indicate if it is
successful, so use bool.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/file-item.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 89e9415b8f06..a879210735aa 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -345,8 +345,8 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
  *
  * @inode is used to determine if the bvec page really belongs to @inode.
  *
- * Return 0 if we can't find the file offset
- * Return >0 if we find the file offset and restore it to @file_offset_ret
+ * Return true if we can't find the file offset
+ * Return false if we find the file offset and restore it to @file_offset_ret
  */
 static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
 				     u64 disk_bytenr, u64 *file_offset_ret)
@@ -354,7 +354,7 @@ static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
 	struct bvec_iter iter;
 	struct bio_vec bvec;
 	u64 cur = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-	int ret = 0;
+	bool ret = false;
 
 	bio_for_each_segment(bvec, bio, iter) {
 		struct page *page = bvec.bv_page;
@@ -368,7 +368,7 @@ static int search_file_offset_in_bio(struct bio *bio, struct inode *inode,
 		ASSERT(in_range(disk_bytenr, cur, bvec.bv_len));
 		if (page->mapping && page->mapping->host &&
 		    page->mapping->host == inode) {
-			ret = 1;
+			ret = true;
 			*file_offset_ret = page_offset(page) + bvec.bv_offset +
 					   disk_bytenr - cur;
 			break;
-- 
2.31.1

