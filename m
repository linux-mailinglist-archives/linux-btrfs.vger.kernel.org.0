Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43734F656F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 18:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiDFQjw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbiDFQjo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 12:39:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82341E4822
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 06:58:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236DROb0000758;
        Wed, 6 Apr 2022 13:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=8oRf1tEneUiu6cER9WaHAcoag3b3q/xF8OB31jwU/Tk=;
 b=tzbB2n3aCktoK+bEmIrVYg+P3yRLaeu2gZNynyR/+7YDekNSwgmqUrWYVvUphcYJkJMq
 jKxEua3bz4D0tZpX9JHaUM93sTmDYi9JxGQ6WbXcilBGxwc6PQ+/g9hXIuQ+hQ5bUkly
 1v9w2mpgygDBWfG+1nrR4EnMKo8b3r5ES0M5mZRUmTbJlbF87KXRS7ZToEvzo0U3HxoN
 AMmPfv266jkrgISzKkSUjehRYlBNx9l5UHWOvIyDFRUs64DO48mxUhlIQ/sDk5YkWB1Z
 zKQH6KmZLx6JAqVhDRsNiI1iai6U517sXENTqgqF3cvAh8sv4YiA0YBt1WV2fDyuip8m wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3srxm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 13:58:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236DuVhM029064;
        Wed, 6 Apr 2022 13:58:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9802tfc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 13:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5YpcHVsCCtttd+6VfoAo/o3fmUu+4F9KLwhbhs7EuCh86rbufhMcBOOuhGdFvfdOqHJvt5+CW74vrWE4P4ufoRqWKAN7WUu4RESMytewmr2EMOWHo42sInswjiIxTxdgbxhr12YLDkCba9a3UvMHDTzRj07Z0nd91mJzIOaBokMH/QWKPhsf2+5QpvJok0QnHhQNesgx5vv+OGKH57dh9X43fRhYtko2G02UQXdUWWNH73zkH+1a1MAXouJn6QXlMijDeiIYvgnXNanaDbqyGiYExXbErlv8MLO/Sop1BIivKWoKpEq4oHifeU+AEvN01xad/ZagW6bnhAmXh7W0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oRf1tEneUiu6cER9WaHAcoag3b3q/xF8OB31jwU/Tk=;
 b=aq6Ua50rCN3cca171gBYKPTipiEtvT9fbSF0ndtPrOFfQ4EH7hdnsxzlBdlpdFgmFwAo5zxOBEAEKv4+YuNRuTGVi5ymxIXH8dwdhyrU9HQmutAEMnFCKsJ8XWQUrZ98z6OC9zS99HiPFKRxqlbDrYRl8qiiBOyzZxZSpsBSCdrhzQE/qyWgfGA5l4ZrEOaBy/vRfoh8vV/uzd/SW+Wop/rgtvSwhAoyzemtPos4agdnJwtEZ4+Qm+Ph2svoOGi/qn1eTkOC26WHY7zuFmTb7WZCM8Bd1JsuEAj8rAPLuXIDagdwdLwYSKYM2VSXX0shDOeskf8wJ4oDtKFsVN3rpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oRf1tEneUiu6cER9WaHAcoag3b3q/xF8OB31jwU/Tk=;
 b=FTet44cte8JP357UHsbtuzfI4G7MYU+jUR9mTgnJtPwLnQsBmL3nrPPjBigjpzjVz+E59V8SDzOuWGsFero8I09l8qJFG8kCHwYGrPQhxKKuzNC8OwT2u47minz+wOnUsl5Qd49U0K+g6KkZeRCi5gUZXbjz19YzrgvZj8GpEXY=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by PH0PR10MB4711.namprd10.prod.outlook.com (2603:10b6:510:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 13:57:59 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::e830:3ab7:8db9:593c]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::e830:3ab7:8db9:593c%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 13:57:59 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 0/3] cleanup rdonly flag and BTRFS_FS_OPEN flag
Date:   Wed,  6 Apr 2022 21:57:45 +0800
Message-Id: <cover.1649252277.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94867f2-66ee-4515-cf49-08da17d5756f
X-MS-TrafficTypeDiagnostic: PH0PR10MB4711:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB471172928001BE9AD6D05B22E5E79@PH0PR10MB4711.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Qtljh0FmKTCuWICUD34isSuBfyGkqbdS6mWqVG0TVa5WrnAqHD2Cy7Kcg2dY6TkGi4BRVWrojIa4MdwUYizNmw31Lm6xXXIlCuP//BL2yofGDllYvvRTr+mfRcWqlBGDfXXTIL6BGRLLcm/18kP4ky08HhwBc28yT72BywlwWYpycEQEqlmj1gj6rzXuP9hjJVn8Ev2jcAEBOWmTjaIkKOw/zAZNyK9c6DEo6cBTPdOw72d403nv3jfEe221ct59pQxgvtulPFhW2oeAIty0rjW6oHMUZ7p1nOB6f7isTSyh7R3UMkFhNTWM+n+B4/N0xhWnMwwKiA8cG9brQnACjwpJom4YU+TgG+9OVFB5Qc4yFSE9O2m0UJY6zmXtALwbPj9K3EcmBIpa/z2Yd78aRvWoWI3d0prk3yMfaCinSFhotnVLrucZLFEiPITeP0bu9wStR4ysLfRzZI0CaJxLWjzW1J4iMC8Mt3eIIDp+SB1i07itB+WokK9aQnyxSKH2rhQy1SUzhajOmE2o0GE7jcyeJ4e+4wyfBm7WvmGSRdDc7qza5C8j1JMpjI1LH+MIsy57g6X7qnS8uKiTC7aOEw25GCZQoMloWsFFRoZzupqEpsV3Y2SvzyOygyFWxGPVX19Mr13cwvINTEL+DDcYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38100700002)(6486002)(83380400001)(6512007)(6506007)(5660300002)(36756003)(44832011)(316002)(8676002)(2616005)(4744005)(8936002)(4326008)(86362001)(66946007)(66556008)(66476007)(6916009)(186003)(6666004)(508600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWPyK7qrXwyB/pL5MX4UgkYgloP9K1PTOkZkzlRJfoA52ChHuNAkWAq4MCxs?=
 =?us-ascii?Q?5NdabZZ9S0DY5kKZL0iHkGPlFauEquDIfCL4TzEVsaUMtoGNjSxp8mNwWJ+Y?=
 =?us-ascii?Q?aWM9M34W8SRNaMKHj3w/IjSn51GbZHcXoUFi8Y/gnVTB7wUc3QzirUnAKV7i?=
 =?us-ascii?Q?hWyfx8USTEpgBG3Sxk8AY97HBHJJ6qL1yeJI4VqGRGzZKfp0J3MN/h9TAKfs?=
 =?us-ascii?Q?sJVFdNZ34bNefU+OrjIn6BG1BDISclWDhCyWTWXZO/hvfApGSGhSsqfU+gDf?=
 =?us-ascii?Q?8hVlPNVR51WS7j6Snbea9JQAyEBlAxAKPQFWyQb53k+zIWX3vSmAPHCggy03?=
 =?us-ascii?Q?BUWPdSmV58TZK/QDnswA2VP/SyyEKCm2QdVmMP0FR6aXayi+vzKEUWBKt0/+?=
 =?us-ascii?Q?H0yCfLVx2BEto4xdvK1QGtOamPDaS6wOmkG6evfgbs/ejQh1APz0P/f9Nh02?=
 =?us-ascii?Q?J2Ns+JDOOc+yM7AQCInTowtqyKBJc9OoXi8RNZzfW2byCJiDTW3DTFQEJ9Dj?=
 =?us-ascii?Q?FAjeHDOjwJQfkDWive1Yv56lBUD5gnzICf8lW36UkRh9e35U3ABA+jWKT2Qe?=
 =?us-ascii?Q?IhdQGhW7y75vSQd1hIPCZo33E0G/jWKBB2MLnLEDhwpzNFgx5q1n1+Uubbz+?=
 =?us-ascii?Q?XjzG7lR15ysm0zTDsLE0e3fVb6cNntb1mEfmO2cSnl5fDc142vjBkvJOkVZO?=
 =?us-ascii?Q?Ff3W0JddLnjsH+cECXlH6xkCkJB2+90XM27pkFDkAYKzS+RVx09iIaThlqmk?=
 =?us-ascii?Q?hPBSjQxxA3Uf0Dbc4o5GKVP1QCko2wFFG/8tQfXHxLQhNuR+kmhj5ROkU967?=
 =?us-ascii?Q?VF7cdNQvmnmXyjKUY4aOtOgjJgPl0NkxIM2EGqdryf9Cg8Sl+YyWA0ZZV4bn?=
 =?us-ascii?Q?bY1ej0r/cn4i/daya1GyiYiReHbiQnK3+Hhb2jlMdhEpxwoHN51hKLhOeE1t?=
 =?us-ascii?Q?xicBspJ38zxuQGsx3NEm5+nVWUkirBedlHm9Wpq0StdDjXcPHZfGn33Kacf6?=
 =?us-ascii?Q?plDSIgEwRDTHm3wj040a0bM3DD2UlAzPBJtHvWW1sKJJjLcgsW6jylLAD1bw?=
 =?us-ascii?Q?zwc06mF77lTJIwMiffJESNWVE9GvzqGsMINphxRpHDAivhC31tszRPGqB/b3?=
 =?us-ascii?Q?ktH2o3WivV6W7MVsSza03JIijhrVG1X80bujmBFzOk39jly090C4hBnnGEeg?=
 =?us-ascii?Q?2k5rZBpLYa9EoYLzFzXNT1kJ9JWl9pK7x7ftGdfiOTBIfSmZd3bpkzDmwve3?=
 =?us-ascii?Q?M7x+FsfkiBrilEci9mdpzWGyndR5kQeyeU6RscuKBU9zZr3suv6KzreRUzLa?=
 =?us-ascii?Q?maWjJuT53Bz+Dt+QzZE0O/EE3G1BcSyRrWFzHfsGkVA+8Dp8JK58SqYTEERj?=
 =?us-ascii?Q?p/sLt85eOYWDffRzX4o57EaxSj562ISbzyPhhZc+ke6ArgNViDHTOtADr4vK?=
 =?us-ascii?Q?GSV+RBho45JhNyioI8VnsWuzG5CtNLsrb8NRculsUZEIiWjWxZtqyY+gtXEL?=
 =?us-ascii?Q?r/7wYIOFVWe8kTaWe2/SyVRFc0RfwxVdX2J/OuauB8jD3Sj7N3fBzKD2ng44?=
 =?us-ascii?Q?G/ZG4uNpjYTdeNsfroHxt7lPmfHIfaMIJdYWkgotnP3PuvuM0DoSNufjx0w4?=
 =?us-ascii?Q?5Mj8MCxtZVviXORGk98ZvVPK640x6svEkxCf+IdqBg+CRmgbSYBP7w66DCEF?=
 =?us-ascii?Q?GzySIwS+cJK0zhKaueUT85G0qDmIhZgsAvi/xyQIuPL2CRuMSwmJDlZupS2q?=
 =?us-ascii?Q?fxjw9SKrKA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94867f2-66ee-4515-cf49-08da17d5756f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 13:57:59.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVWjEF28X0I8z4xaswGvKM6pkICQjDcaVulcGJNUm8m1kMSY/TBEg8EtRcikg37VcfeFdD3py1hvw2BMhXrBEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4711
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_05:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=981 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060068
X-Proofpoint-ORIG-GUID: zMmCuLHrC2ZdYBQtiEC9Np5vOHD4RmCg
X-Proofpoint-GUID: zMmCuLHrC2ZdYBQtiEC9Np5vOHD4RmCg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch 1/3 brings the check for the rdonly to a function
btrfs_fs_is_rdonly().

Patch 2/3 wraps the check for BTRFS_FS_OPEN flag into
btrfs_fs_state_is_open_rw().

Patch 3/3 removes the rdonly part from the BTRFS_FS_OPEN flag is true
for both rdonly and rw.

Anand Jain (3):
  btrfs: wrap rdonly check into btrfs_fs_is_rdonly
  btrfs: wrap BTRFS_FS_OPEN check into btrfs_fs_state_is_open_rw
  btrfs: set BTRFS_FS_OPEN flag for both rdonly and rw

 fs/btrfs/block-group.c  |  6 ++---
 fs/btrfs/ctree.h        | 19 ++++++++++++++--
 fs/btrfs/dev-replace.c  |  2 +-
 fs/btrfs/disk-io.c      | 50 +++++++++++++++++++++--------------------
 fs/btrfs/extent_io.c    |  4 ++--
 fs/btrfs/inode.c        |  2 +-
 fs/btrfs/ioctl.c        |  2 +-
 fs/btrfs/super.c        | 14 +++++-------
 fs/btrfs/sysfs.c        |  4 ++--
 fs/btrfs/tree-checker.c |  2 +-
 fs/btrfs/volumes.c      |  6 ++---
 11 files changed, 63 insertions(+), 48 deletions(-)

-- 
2.33.1

