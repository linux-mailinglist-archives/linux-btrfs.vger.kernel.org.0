Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEF853C28D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 04:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbiFCBmz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240948AbiFCBmy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 21:42:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB5D20F7B
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 18:42:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252Nvi6a015092
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jun 2022 01:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=JakgkEUCt2x53y2XvxejlUQPBlAkGrpnTVsYJ6djliQ=;
 b=Oxd04nYcUyZKmBo/KFDyDx2luwG64FsyjaWN76IF8BbKZMLJvH3P+1MfOvRi0ePu6vPl
 Luk8tBWjF7GBZSMjOuVQsYEtqaBMFGwGWiXaN0hEGjmqZk7SCoEjeM7TzenqgH7b5YG4
 tyIzWAVa7RyyvtuzxVytjlVI3TrA+90dWu7P3F/uJilmLgMJ3i7W2aB9fExXQ/dSXBpw
 TsPE/pi37mJ9afaQQcs2QUfuKML0ug+e/i/NrseR4jqGp2mlIM1XjDCzdDhUKu9oK5mp
 YGdvZjy3pdjBUqnSPBO2vRk20xwjxiffFNXPll3B7FtQfz0yST7i7GJhaV8fqcoaS/U6 kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcauv0u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 01:42:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2531fYSX033767
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jun 2022 01:42:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8k207w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 01:42:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3enu2t995Yr6RaweNbE5bjIAOSS9YjSZ3rgL9bNTJrSB7FyGYn5KjtgxIuvJi0I2QpycNSXAo5CpoVvxFyJlaGscLkE4J+TQMhrKxAzvTRWY4E17+az8J88+d+XdCcEr1ATxbekPDHIH9wiBdJiRc196cFHJV6zVPCMOXCZsfcZauvnPh0LBBJ6LordnBLlNcsfWy5eo/WJf9bYS6yzvrqBP9F92CQuVqLSuUn4oG97546/WfvkdvxKxR2Fx4hvAmy88HthOQ9oxLS/PFnYaaeXS/yH6dVTmTkTHTJc686g5zBC7gDjiVBgWYu/aD92bJi6UeJQ8Mwf8IpLNeLrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JakgkEUCt2x53y2XvxejlUQPBlAkGrpnTVsYJ6djliQ=;
 b=cNtrwsPWBWLKXxGvfhInUd/lowdgxDNOB4jAImliQydSElYpeBhw+XK5K9/6kQZyBc1aBWpbdhKCL14lNRwJH6Ucl62kmIq3QGmCisP63h+yVmhuD10qv9F5lcIjlCFnjGQQ+CjOEfu6hkutbQzsRaSPF8Jfnh0sjQagm88j34qJK4raSYhtc0Sb5iL9qSLx99XFojV7elVDAWo4RrZfkI6GRCFA91HeIJ7AeKDyzN2ItLo3F2WB93T1CW68odYlGZoVTtZRtjOXAgSgobibqS/lzG1r46w1XtQiq+6uRIpNbZzYppMdOvpcA039u9P2uJEcmYYW8BR12pAON7eTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JakgkEUCt2x53y2XvxejlUQPBlAkGrpnTVsYJ6djliQ=;
 b=L4E+He3TGMOg/e+MR8WLfX/vdyeeNOgCyhor8dY35cg31LJnypgO/zxpVzhf9lf898nNriiQghs/SnhJ+ZJeKC4fMDBZLp+APV+Vx6xUgybcm7PXcE9iWF2KWGkI0h05AtP37iNN0YNZ1S1EsS5zwg8HbDjzubvBKPJjmcf/MAM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM5PR10MB1530.namprd10.prod.outlook.com (2603:10b6:3:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 01:42:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf%3]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 01:42:49 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RESEND PATCH 3/3] btrfs: set BTRFS_FS_OPEN flag for both rdonly and rw
Date:   Fri,  3 Jun 2022 07:12:11 +0530
Message-Id: <1f38b2dbb2f3ddd66241f60b658f8b2dceb911e8.1654216941.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1654216941.git.anand.jain@oracle.com>
References: <cover.1654216941.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 686695c7-661e-4f9d-d2af-08da45025cf7
X-MS-TrafficTypeDiagnostic: DM5PR10MB1530:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1530407E0A6999591B3CF400E5A19@DM5PR10MB1530.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7pjMCysC0u1ktbiJvZTbfFNY70HLRD1dpLf8VxI8oGc6pmOUGIFlc5++/m2CVITHdnCa7WGMGbgdBqvuRNet73VHHo3FgdS22ZqAfEX4zVixvCVoUmSfPWqSef0NwofODWAieAicvt6jPDIUpRYB5gPMZjWyowTM+LA8hK/4N7UJoXtI0SrcND08qa2y9n+HfrzMpXT60NET5J7lXs4yRUWF3lfsYiUJFRwgVvwh5x6xXXRZa0/5+M4wk1lweai7nX8G3jpcpkTjHbq6PL91gQRIr62UtVeRhSlBzpJkozzBBrNx4+u0MJiuThWaPdozTxvoAtH8ZzJPPfHjg8CD/V6ZmtdyyGhim1z/vPAzUz9S0yFYbv2avk2OInOpjMvvyvPmivOyShZKhibsJBf6E0BT9pfmQ8Z5NLGOm52hD5YeHqeU0NUN47T9zgUCOYb54TpOnoHdZt0g85Gc9h0YlKKP+0L+8Gzyw5xrQIiBoGvD0qL/zXvBYi90qhqncrJTHUdIwV5yuo2duljO8bwiMdPlJV572xg5YUgqNW0fReTMxhD3ed+xwmx2mg/bUPgzlS+Q1rTV81IX0sIXRRuvhr8yNPm0bk1a+gogZxWseXTa9w1xcoenzZpjycUi0g6+RZgfI8wS78f+0OT4D7gZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(83380400001)(26005)(66946007)(66476007)(36756003)(8676002)(186003)(316002)(66556008)(508600001)(6506007)(2906002)(86362001)(6512007)(44832011)(6666004)(38100700002)(8936002)(6486002)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rzkDKd8vinh8LJR0EG6FT+uR2BhRhpt2EgMT5ej3ztsHlTCTf7PFDrCWL50P?=
 =?us-ascii?Q?Vvr/eAL69/Q/x3eQ8MDLyTPAouSTMkYGYIME0/QpWYgpKuF6jLhG0Fi6kDlX?=
 =?us-ascii?Q?7p3qv355oSSviMGD+gj5bJCP+wDjfbtnEX/HgtYIyEj9HDmA+gvNfX8rTtZs?=
 =?us-ascii?Q?KPwLa4G+SaP5MrIpone6UgjaqGeLVRyYtTRMCx/Um/GrMrOzGyvlrshIbkmU?=
 =?us-ascii?Q?lnDtNS8FRqyjmpf/g3O4rL8oVJmsIVXnDmG94n6RcS5+hWLBtKkl8MS2U82d?=
 =?us-ascii?Q?dTCgbOZUB5EVYLX2sbLnphXY1hZk+NsrZz2wgd+8xbwpPN0WAxW8xa2XAkvo?=
 =?us-ascii?Q?Q5kAqbL/cDRssdDm0Q8gBpIiAomhgg11EfKVEbekKdR2Hw1MlzWLaldcjQ1V?=
 =?us-ascii?Q?e0sdvHsjN5TCHUOSehwyEtO2eJo6CybTiv8oyju4LfBo4ih18KCHSqJtbBtA?=
 =?us-ascii?Q?HfMWtDmCzPKyRQUwt9zFjTKLAv9yIcEulsdNZEWJFXFVsNaRyBGEVZ9DWV4S?=
 =?us-ascii?Q?QSD+jEObmXWKssyDs7Du9yw0Cyv4qDG+Q6KvYG5lix6viE/9ueBnwqsDcNHb?=
 =?us-ascii?Q?OMiI8B+Ml8q2d6rpPIjim8kLzja+ksnvULn+6W9s5L6fw6VXe1X6xxWCObBV?=
 =?us-ascii?Q?lKoiJINTv1+1661YKA0zXJG/zrLF6vGmv1BaADilf01owdR84sODf84mKrft?=
 =?us-ascii?Q?wrN8unu9emI32Oaj4cyFQZrx9+IbRMXIYW1nJdT2G//cCLt5y7dpTRlj7RMl?=
 =?us-ascii?Q?wtbOuZ+RUxpvYH/8u74iXYBeaRjfaXHf2+B7a/cbVGcZDe3q/89b8SJIqITx?=
 =?us-ascii?Q?O5uda58o2k8BYlgyaZalq0HBLxxzAMc1uKIXx45DiM+HIElYqnttY4Xj8jlr?=
 =?us-ascii?Q?oupekeKykSOwwAyotDwJEoAFOt+tJvBWAT9mUj3TJvHt3JDLoErvm1TTNqGy?=
 =?us-ascii?Q?8cd00IMi7HXFlIRWOke418aVXLc4GtWwmWqm2nHYt1VUOpb0qPEMJMc8rv0G?=
 =?us-ascii?Q?oQKmAVPdXdRTq7wA6mTPj4fjvlpc8/W6SVyanhcagM8bpd/Pw4yeR9BLoJ9Q?=
 =?us-ascii?Q?voUYIB4STF2blJopmwJ35t3ltD4uujw0ZBKNFdcjclliVXpDyoICr7K1y4cg?=
 =?us-ascii?Q?huF3k/sI7lJJWqqgXWsnkSyADYYr9VzKDiU68pleTSSC5jv6xHaUgCAmhSx2?=
 =?us-ascii?Q?LaKX2FEstnm5e1vD6Plt+pCosBxtbXIAQXzq0MuoSum1Z46/QAmnpJFQUyXR?=
 =?us-ascii?Q?r2XAfGGhvn6cL463N7vF+UBl1HB7Ko8Zmri4b0fcjJZO6M5W8R2sYgqL7JzR?=
 =?us-ascii?Q?8BIurk5Sg+GlxZT1MhAfuWPMmjnM7TcmX6PXDGjMG0mMRj9GhqMpx8NKEL1V?=
 =?us-ascii?Q?ysMz0g6BJeyEvusC5LCvc5gF2Puer1wWXgGB2AVMPEmDvlccZNKZW3qggxYk?=
 =?us-ascii?Q?ws2xi5XlEt0Q87Wx3QEV838tWd/PJ6EmHCB8k64bwUIxH0UC9yxukTHccj4L?=
 =?us-ascii?Q?LPwCo4I8vFzP60Y1w9sO3LNhwliTjXocFBcwIUDGMfX4qhk6vA7EEkKFIwme?=
 =?us-ascii?Q?yb1/JZtX6G0txS+mCc6iHSkbbYFGlyjplIpUzw/NkZJ076r6UqQ2lcn1WTh/?=
 =?us-ascii?Q?4ZpVXs7QTWwbApwA3fWlAbHUMd5w0su6cs1A+tDEuqZSt8uNZvCRsCMqJ0Oj?=
 =?us-ascii?Q?wRzTIbIiFXI6CT4QvfJYSNDmMD4pC1aqeJzxICwh90FuLgOHWiRiZug7OO79?=
 =?us-ascii?Q?P67stccN9Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686695c7-661e-4f9d-d2af-08da45025cf7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 01:42:49.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFBTQqQbV7kZSJLGmOgbZMVG87P8dX3t1L428P6ODSNdlol4gbel7iLSOG9iJUisuFoy8yNXob9vkVNOmuKI0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1530
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-03_01:2022-06-02,2022-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030006
X-Proofpoint-ORIG-GUID: 7Wv5vpvgyjINWJn3pMS8KvBMtrEk4DxU
X-Proofpoint-GUID: 7Wv5vpvgyjINWJn3pMS8KvBMtrEk4DxU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It is good to have the BTRFS_FS_OPEN flag set irrespective of rdonly or rw
mount. Setting the BTRFS_FS_OPEN  flag only for the rw-mount does not make
sense as it lessens its utility. Besides, we have the BTRFS_FS_STATE_RO
state for mount type rdonly or rw-able.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ctree.h   |  3 ++-
 fs/btrfs/disk-io.c | 39 ++++++++++++++++++++-------------------
 fs/btrfs/super.c   |  2 --
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1a77a0123c44..1b46b197fb61 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -4041,7 +4041,8 @@ static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 
 static inline bool btrfs_fs_state_is_open_rw(const struct btrfs_fs_info *fs_info)
 {
-	return test_bit(BTRFS_FS_OPEN, &fs_info->flags);
+	return test_bit(BTRFS_FS_OPEN, &fs_info->flags) &&
+	       !btrfs_fs_is_rdonly(fs_info);
 }
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e25e0104a9f0..16c66f71a3bc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3891,36 +3891,37 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_qgroup;
 	}
 
-	if (btrfs_fs_is_rdonly(fs_info))
-		goto clear_oneshot;
-
-	ret = btrfs_start_pre_rw_mount(fs_info);
-	if (ret) {
-		close_ctree(fs_info);
-		return ret;
-	}
-	btrfs_discard_resume(fs_info);
-
-	if (fs_info->uuid_root &&
-	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
-	     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
-		btrfs_info(fs_info, "checking UUID tree");
-		ret = btrfs_check_uuid_tree(fs_info);
+	if (!btrfs_fs_is_rdonly(fs_info)) {
+		ret = btrfs_start_pre_rw_mount(fs_info);
 		if (ret) {
-			btrfs_warn(fs_info,
-				"failed to check the UUID tree: %d", ret);
 			close_ctree(fs_info);
 			return ret;
 		}
+		btrfs_discard_resume(fs_info);
+
+		if (fs_info->uuid_root &&
+		    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
+		     fs_info->generation !=
+		     btrfs_super_uuid_tree_generation(disk_super))) {
+			btrfs_info(fs_info, "checking UUID tree");
+			ret = btrfs_check_uuid_tree(fs_info);
+			if (ret) {
+				btrfs_warn(fs_info,
+				"failed to check the UUID tree: %d", ret);
+				close_ctree(fs_info);
+				return ret;
+			}
+		}
 	}
 
+	/* set open-ed flag for both rdonly and rw mounts */
 	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 
 	/* Kick the cleaner thread so it'll start deleting snapshots. */
-	if (test_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags))
+	if (test_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags) &&
+	    !btrfs_fs_is_rdonly(fs_info))
 		wake_up_process(fs_info->cleaner_kthread);
 
-clear_oneshot:
 	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 9ace5ac8a688..96b204bdd49c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2118,8 +2118,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			goto restore;
 
 		btrfs_clear_sb_rdonly(sb);
-
-		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	}
 out:
 	/*
-- 
2.33.1

