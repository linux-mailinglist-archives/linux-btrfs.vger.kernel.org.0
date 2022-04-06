Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F94F6593
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 18:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbiDFQkr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 12:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbiDFQju (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 12:39:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FDA31E7BB
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 06:58:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236Cgabg024447;
        Wed, 6 Apr 2022 13:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=82N2/qrOyVrCBsQZ6zEFri5OwuU6u/uob4NvarrXrFc=;
 b=t3F+O7JaDjXLmy6k7T4kqtZph8gyaM0c9r8IkXedGJVn29Xg3wqcVlydt8A+YfWgd1GG
 eRcKQvp/x+vJMzDV13iWRRB3rpn0Egl/VjorpNKRk21uypJKVI9GOGgoafYYNsozurJG
 Nz48VRUihZR0XBM52q6JVhHD4xRLoRJ2zKGF3KYG5BM8D9UBtsXKWEiRLbUJdbHG2CX4
 Khpu+gNSXalo2prBxCYodCDF9j35Q92WGv2b8iLvxaQ3E3v0zhRmRDq2X5Xs2Bk7WAzs
 IBYX+qVRKcWiBZgegPZy9A+c6+FiivuaT4ZN70YYVWwOJUe6rykUq3nMkOxYPmwDVdGJ RA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t92xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 13:58:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236DuN06004834;
        Wed, 6 Apr 2022 13:58:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97wq2cwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 13:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgixQ88dUo4+/Fn1pvLu9ZgE1FY1H9bqMH+Fy17VzMwuzn1KXh4s6T2/ftrRQ1YPBY3zvcFTZrOJtlrni0gK+qofUeF3Ey4ieH+N4i6BybtvZK0KdN37ZU8XSB1cGraeHp21E40P48LJqRiTOBtxId4fSCedz98VOFpAVX4Yi/2KMjobqx5o+bUnXZq2wSCJ4TyV8aGjiFy0Ek8UZtdYSdOob6hT79+hq7TzPMRW8ela78YPsj2/Iz1YvucEFjBD9ZJqjaIuG2vC2evxVJAXQqPn6xSKozw8mdiYb3bQ9Hd2CkVZi7Yl9oIJJyaDbSOVegyIV9L6TAH84ALMqNbrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82N2/qrOyVrCBsQZ6zEFri5OwuU6u/uob4NvarrXrFc=;
 b=UBuA8GTuBrAPXOcsFZgfc5PWgaoFdxPeo387/Q6utlbZJet6vuCe+Lam4EPD2WQZCoZ1K71KAOS1g/cCLLrd9AYGkcnz5Ky2bVFkJqfwLxh2QG1ryeDmmbR4/mCVcU5KdaEfy/DrDxoreSwWjf+JjJj1R1SjR0R2Py+Wb3/lVqVl0Offr/xuP3UJk/J02wFyZZw+Dt8PoBEcj4fQEzUaE+ImGBcG6wJER6seZKwWnvnITMMDIeXH/+leVFB9Mtm+FSYj6MJaejuq44T4YnEj1rIfY1S0zeDkLsVIQm6Vy6m0R1BeU0NYnZZAYhYZ95qfWW1LHxhAkgcCw7npf5LitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82N2/qrOyVrCBsQZ6zEFri5OwuU6u/uob4NvarrXrFc=;
 b=rLgCeeNNqkbt3trmgdlyMvu+u0iZkQSiM8oD9w9ZquMxR9gwnEU1ALPEYnvHX39/kTADtIZsKTe0WfVtW04N/RTwFNmDGH10rMiyUQUTHRGRxNdAdwPEaa9r3xgoI3lYa/+scqW9uTJGXjx3xcmSfBGH+dk7aHv/Hl0UdOQdAWQ=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by PH0PR10MB4711.namprd10.prod.outlook.com (2603:10b6:510:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 13:58:14 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::e830:3ab7:8db9:593c]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::e830:3ab7:8db9:593c%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 13:58:14 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 2/3] btrfs: wrap check for BTRFS_FS_OPEN flag into function
Date:   Wed,  6 Apr 2022 21:57:47 +0800
Message-Id: <88ea78f50937062df45c40fc8b0d504b83b6f4ee.1649252277.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1649252277.git.anand.jain@oracle.com>
References: <cover.1649252277.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ecdc824-0d28-4b3c-817e-08da17d57e4d
X-MS-TrafficTypeDiagnostic: PH0PR10MB4711:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB471147C24110F5F39FD86E2EE5E79@PH0PR10MB4711.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/Zc/Hq/laN2H0M+oTLZwxS+DH1ohpEteY5DtkGpKdtGkiYKXo4/pSEmIsaiJS3dpmVmCAfl5aODSRA1rjpceKwCDj62dlF5wYErSfq/W9ot4h6fSE17iaEgpS7fO4pjD/Qua7+gFU3yAMEWI8W2Zkr84OBAI3SeAWbJWfpt/cICTvteBt/t7vrBBQsVxiYHDtZF2v1bf9dtgsJ5YCQApA3P3Ij4M3QlNjMCUNRlyhyLGISQxq3vtBVCQujlFSCPh+oQnGmGZ0FxupsSKlDMfn34pZuERlKDZpQRP97CpqOzrkXOpAa8pZsVOv6WTHKy4kOiHuWhY0uWo8lIrlCRYr2atMhcHTvt0T5iP+LJGLntEniVbdYN9WVjsObozA/dSAotkpL6HalQRa5WvgLKBglbzwPNM5RzZbXyoQ3jluB71vyMVCk/kbTPYrQc0MvGOIuz0Vxe91Dv64EubTP3Sjb6Sn/RASwBLOSzmth8s2pwqeqmN9t/ez1V9Tq/rdZA3diKdSMnvBM7P+TY/9SO/9/KuHK+gzoaA4zZ/OvQXmmT+8eqqPuOK7JOTJpMayrSzzR+WSNFvgnEKah2HKFo4loYDx8iKIcSZr5Es0QhYmNSsmSHQI18Yz6XFrN/t96gtnalzGvRFbklnui119rxDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38100700002)(6486002)(83380400001)(6512007)(6506007)(5660300002)(36756003)(44832011)(316002)(8676002)(2616005)(8936002)(4326008)(86362001)(66946007)(66556008)(66476007)(6916009)(186003)(6666004)(508600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HNA4TcKhSjpEyG9FAFp+F4l2+/bhJYZCebglMG9Yb+PUGIDCqQnTwxHiwRlQ?=
 =?us-ascii?Q?Uf4N14rx8v7rUnA4SI1WqAxzJyYxAAFlNzp9rve+cMyjRUT9qdvycoXb+QEP?=
 =?us-ascii?Q?9jFwnTVpZGbo99v7Rf/U+qZggmuMxIdDw3hZanvtlFEMjfbW4BaZodlyWcXY?=
 =?us-ascii?Q?b+gB2vFXUl26YzvqU5yvfwqdN77eeuVLXcgINdl7709Q9iGBQVaYReUBkglX?=
 =?us-ascii?Q?EV54e0OhvTeH825xgzri0QfbYnQWf+H3gcH3Sx87hpozcZZacSIKgEaG7JEV?=
 =?us-ascii?Q?K1tIxrICQRwC1GAWO7lXPCeRYTDEA7ZVYLbh/pfdN7ipUGLD8pa8nDHoA5aB?=
 =?us-ascii?Q?Iv/WSoOCdPeQO5nLC3xQKJRrYhjpdfVMsRRn0TUIOLHNheVKHTqKc+DyavjR?=
 =?us-ascii?Q?gnyGJvucXm21HIEOyBdnExL7DaPyQHya4lpmbnO4J7kmAOWjZa8bVs1NZS+Q?=
 =?us-ascii?Q?rlXMhYregqLsZZQv6u/gSlMW3GwvJYFJeyWJUDp/bbkHfjxleqo5/WNEek8E?=
 =?us-ascii?Q?J8CjrZHuJRNyYWt8DZIx4WPavCgUR87OtiycQzZiK0kjR7Qiupuew9sXoLes?=
 =?us-ascii?Q?KvmL2oSSzVuMdCYYpjNcmBMNEtZYvqnx3GlgNI2Sg9BM0Xopav+MBcQT6m4a?=
 =?us-ascii?Q?d1nkBvgY66RZJSMny9afVdWpiYCi7P/sfJst5lRZekyG0PWqriiUV0yqTN7y?=
 =?us-ascii?Q?+Cd65k+uajrDQsVbop8Z69K3IDl5GEjTfTUyEIEzznYohRmaSQtuhyfmVoFU?=
 =?us-ascii?Q?LzWNA+Ag5fPNlSTCkqH4Voz+tsfvA/xzjZz1+zMv5HAL/toSnvTciHh7GZPU?=
 =?us-ascii?Q?lcCp67w2uy53FMAinkQaClKPvxDGyEPC2uUIu8izqeM+2tACbwJv7dD9wmJ6?=
 =?us-ascii?Q?d7aS/i0nzlK6bcCvoMF61U8vhL0xHyHljQ6VcnEuKf+lG4J3hgKS2snbv75v?=
 =?us-ascii?Q?6HKD/ZSsa9JT05V26eIEIq6FB9wY818T/eluGIisSfNUUAOVuIeiGC1/lDLt?=
 =?us-ascii?Q?+DVfwg8isT03fB0UtCeT0bPWI/081eAeZZnoQeEhyXkuYqfAISjcHjnAzqWh?=
 =?us-ascii?Q?o1ScI+4YDSn4wkb78+I1deHuOsgT03P+ZwrXHd+4EvMU9c0uyq9EP/PCaDoj?=
 =?us-ascii?Q?8QMZpDTnHs6HevaIzfO8fI4JyGs/mYq/Cc+HMJtj8IKsHvNDayJtnmyidaxP?=
 =?us-ascii?Q?yca6VvLpLzrbSzjfy3SUszpkXZ7dMZBxjIHMEK4wB1qDjAicr4d/jJc1iBNN?=
 =?us-ascii?Q?g6KuxkxPn9EdROOwd4rO4DSwQh67TwLsg2WReIYhmaADj6yf//OzN7zGxiIu?=
 =?us-ascii?Q?cH1lzq861Z9qiOCykEoXZF6XkLkS3P12iZyBrbVY/e45RKzDp3sZY0fGt4ba?=
 =?us-ascii?Q?mJgtHkme0iVvlULoZ9MCHTOqXK8OUqmnI54V8gZkqHSHIQ8WPoGYnq3HbPox?=
 =?us-ascii?Q?S+zRDpVv3ksnhyrJG+Tqp03GmYoIzkbyga9spTmPiftGzqR8RckufzWFZ51q?=
 =?us-ascii?Q?DWVqG0kwoWGenBI8Lwrot0G7FgloS0TuzFXdRlrXfeiSe1SX1T0wiBBnN6yo?=
 =?us-ascii?Q?cL4LYWYjVRbdSNAQ8di2k+w0H2L3NuD17rEjEXUUHHw6BlPkDbjZiObvjbTb?=
 =?us-ascii?Q?Rh+DgE6nWvj7KWrYWNTb6xUsLAVQiR717csHKyJQgxy8pbCjimroeZ8m/r24?=
 =?us-ascii?Q?gE2gnuoQinOOApPjmsbOrjcGU7YzzyqxK5iVDGTNohZ44zYYEgjDulAl7O6s?=
 =?us-ascii?Q?jMI/vJUOK4aSbktqVQvkSJfZo8q7m0E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecdc824-0d28-4b3c-817e-08da17d57e4d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 13:58:14.3171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8MiaLRJB9tn9zoPkgL/kqkk7YwgVXUQo417d8RHzDAEzkuvKqacHmGkPCcvJgs6Zn3ufXVMq1rsiELINRM73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4711
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_05:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060068
X-Proofpoint-ORIG-GUID: BT2kCiHlcrIx1pb8AeaP_uThRGBg0SUd
X-Proofpoint-GUID: BT2kCiHlcrIx1pb8AeaP_uThRGBg0SUd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

2nd patch in preparation to make the BTRFS_FS_OPEN flag work irrespective
of the type of mount (rdonly or read-write-able). Bring the check for the
BTRFS_FS_OPEN flag into an inline function btrfs_fs_state_is_open_rw().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c | 4 ++--
 fs/btrfs/ctree.h       | 5 +++++
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/volumes.c     | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 94345316cc92..3b10669b413b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1295,7 +1295,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	const bool async_trim_enabled = btrfs_test_opt(fs_info, DISCARD_ASYNC);
 	int ret = 0;
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+	if (!btrfs_fs_state_is_open_rw(fs_info))
 		return;
 
 	/*
@@ -1526,7 +1526,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_block_group *bg;
 	struct btrfs_space_info *space_info;
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+	if (!btrfs_fs_state_is_open_rw(fs_info))
 		return;
 
 	if (!btrfs_should_reclaim(fs_info))
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 21b1e9698b19..9d21f4b9d3dd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -4026,6 +4026,11 @@ static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 	return root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID;
 }
 
+static inline bool btrfs_fs_state_is_open_rw(const struct btrfs_fs_info *fs_info)
+{
+	return test_bit(BTRFS_FS_OPEN, &fs_info->flags);
+}
+
 /*
  * We use page status Private2 to indicate there is an ordered extent with
  * unfinished IO.
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 552dc49e2948..1f9613d733ab 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2000,7 +2000,7 @@ static int cleaner_kthread(void *arg)
 		 * Do not do anything if we might cause open_ctree() to block
 		 * before we have finished mounting the filesystem.
 		 */
-		if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		if (!btrfs_fs_state_is_open_rw(fs_info))
 			goto sleep;
 
 		if (!mutex_trylock(&fs_info->cleaner_mutex))
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e206cb0df6a1..64ff39274f32 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7589,7 +7589,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
 	 * and at this point there can't be any concurrent task modifying the
 	 * chunk tree, to keep it simple, just skip locking on the chunk tree.
 	 */
-	ASSERT(!test_bit(BTRFS_FS_OPEN, &fs_info->flags));
+	ASSERT(!btrfs_fs_state_is_open_rw(fs_info));
 	path->skip_locking = 1;
 
 	/*
-- 
2.33.1

