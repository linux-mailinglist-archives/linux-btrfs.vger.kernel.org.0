Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59353BACFC
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Jul 2021 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhGDMHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 08:07:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5540 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229569AbhGDMHy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 08:07:54 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 164BtvKV008002
        for <linux-btrfs@vger.kernel.org>; Sun, 4 Jul 2021 12:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2020-01-29;
 bh=65jQMmaqZhtOFFxFQ/g8LbH780WHCrHuQnDr+lda0iw=;
 b=GzXnRSTvhU6VtdNzc3u4nCg1BlXVO4xVlQWeEzgWE+QNhiC5wMMFS4Th5w5Q89ZZTGpB
 PFazmj70r2jZGVeZ+fPc6wCQpoqV5EB7SbieJMOAgMnXcaw7u+z/7Q/ew8+dNOWik9B2
 kAKTnpVpXlLzoTNX/NkoC2HE/TCUpXTey2LwSsExMgIprs0bfXUUlqjNB+5bmm3oX7B2
 v69PWIhpgXwVFKmDuKJr0bYmBNmRAB+OSv0lYojwshRiXNtzDrr06jSNwwaSSHw3JCwT
 xlOg5oJVobZbHQTMHoaVAmIym4k70R8X3qmwpd5qXVi3jabHaDq4/glDSUMUM4hm6FSy 1w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jeach76y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Jul 2021 12:05:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 164BxvWq193393
        for <linux-btrfs@vger.kernel.org>; Sun, 4 Jul 2021 12:05:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3030.oracle.com with ESMTP id 39jd0w5w9j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Jul 2021 12:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAZJwwVk4zI5M/sym0yTL7aFqjN3FRwO3dF475vMAgtgFoOYNIt1qZNXM5gfNhfaSVpbqWrWCMU6rb/t36Luq0iaNEXyGFOhcDTku/0YHDc3TEgqdUk96zb5cnr7hN8rcQl16jN9irz7BEDwtGDTXnGiCj5RFAlVgoywLYr7smQgbtfMJJqGecHvW31HeGeqa9wmPbdvXdBB9Si6kiXPFK3d3cZ6UXVdblWG5pV2hKL2WxIyScDeYZ7AB/dpYwgJ4w8uq3oniJwea6GclsYFP7AK9xiG4IguJ05xfX4TaIZXMRB3NLfYrmVUoosZblPVQOkLNuxpKazwbFYrpj23eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65jQMmaqZhtOFFxFQ/g8LbH780WHCrHuQnDr+lda0iw=;
 b=FkAVrEZRnbHSPxajDD5zXhBhqCU79/LQJwCwz8qG87mBHjjh/PmB4UOzunSS7beJzURja+gmQyEtwMcseQojonPPuttom9tSlIFwLOMZv0XvfpD0Eg9051b0jkb/IKCjghdEvS7+YfLHkkXr6CoRPxc70ph6CcroUNMaE5kPR/ker++i6zNZV2dBl1p08Pi2Ob+jLwFHMdaSkdsc+cn83sRImbLEAj5iL42PV6hiSXFKStYKG1BrqWKrt9aKKn546oG83cSmh3MpEjIzzG1Ak1pAdeojx5QBObo8vbeLytMXLpht3YVcLhAjfsRcy/ZJ56PqWLSso5+pijCo8Le1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65jQMmaqZhtOFFxFQ/g8LbH780WHCrHuQnDr+lda0iw=;
 b=P4YCin9b4eS6R8Pt2WqjLTWo2xPJ861SJmezQ4qQz/tfoDug8oA06GTC/BA97rWepj8fqm+bdeFCLuHwBxgzbBn70R9falVQO6Hx6yfC5xEd9wfg6kzKatk/BwTBHCcOeZ8MHkd7teaA0Ri/wXB19D8gHd2oTRuYYTT/u/IrE3s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3901.namprd10.prod.outlook.com (2603:10b6:208:1b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Sun, 4 Jul
 2021 12:05:16 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Sun, 4 Jul 2021
 12:05:16 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: cleanup fs_devices pointer usage in btrfs_trim_fs
Date:   Sun,  4 Jul 2021 20:04:57 +0800
Message-Id: <f2c9215ef5edac3b142c78043249e69600f2c557.1625237377.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625237377.git.anand.jain@oracle.com>
References: <cover.1625237377.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:54::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0050.apcprd02.prod.outlook.com (2603:1096:4:54::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Sun, 4 Jul 2021 12:05:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc3118f4-302e-47c5-762e-08d93ee3fbee
X-MS-TrafficTypeDiagnostic: MN2PR10MB3901:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3901288A8ABA41FA79F2F229E51D9@MN2PR10MB3901.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txl1FPb/UbD4I4rSCy1eF2EEl7JOhWw23c9hMftpAtJVyi2b6NAwt2ljVpg9vN0dh7//vdOMU+kqBplQfb9K5ZXwjtktj9NGer18gmCAOJkWSZo/kWky/I1BsKkrplidKTH8qFGLJ+CatISoeMghOdJpwf6Zu7q/iAurHZ5g5s+h/ZohoZqT+TIthn2m7AToebCOkrOFuq8LirDpQ8/3WWVie5aXP7AZgPoWvLm7VFG2FKGBc6L7ik5/jbST0SJjpuO6p3EzjDc6DelC6ouRLiU+UYX5jaxerq99StM8EmjcjeB42lzKnAUykjlTjAy4Px1aLCkWbTO+Sy87V9TEGZjWmscHYiOacqdUlEGZ9GXnhdzEwIsvKcgvkDexz+bEMx/3HLmLNE7WuJZxItSsjm3GgwWYuoHyEJ+r5ZYAa/I1UOKVWeQA7eSWavLInRmpt5gnL3iWUPn9AXVRjlrdBuqZ0lHCXqlqHmEzOID5RNNfi1YpN9N8rMGbLY2ogB0VRLhOHQv6YlDPEE4WUAgi+ALjSekgYLndkFR7eNs7sL6AUXmQpxYdUA/1ofhPq2L9PHN2GlUNN4LxDKE9EDq7LxHNDDuhNSAMFCzgRHlvPD19SvcY0cjbYR+oNWt8o6ENdgE34JJQiK2d5fyrHNZ5bwI7iwVRslZowE5pKOJYbpH4uAlBcN/ub2LX0IJ9hI3O0NXZXbjc4m44LB4pftkvm3RLCyAR7RETZFP/QQi1J33ayIIsyP6diITFVdi/ZLyT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39860400002)(6486002)(6666004)(83380400001)(44832011)(38100700002)(52116002)(316002)(8936002)(5660300002)(26005)(38350700002)(6916009)(86362001)(2616005)(8676002)(478600001)(66946007)(6512007)(186003)(16526019)(66556008)(36756003)(2906002)(66476007)(6506007)(956004)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sp0l2VF7hL+Gvvo8gKxqpnSZrkI9Ko3k+FrHyA7oxuvjMb+uOwcn7foLXFIF?=
 =?us-ascii?Q?g7h4vlNJi5pYdNLAz5pwvyq1hI5PTjZHtHfqvqgpfDF44v0xc6G6aneCQsQ3?=
 =?us-ascii?Q?6AG3M7qio8rloBbpB3bXYXe/aJ3uygazoUuk5//EyB8jjwSvyGxZTYynRYWM?=
 =?us-ascii?Q?1P2beRTTN3QK7T56IjY4mkKExbpVlVU2OR7tonKF4n/RHIsuGrKsUFJqKofP?=
 =?us-ascii?Q?zH359lhjkDykaOGievXx05y4gBY+n3PayxCYBgLjBav6lPKqtMOPbzmpzDSJ?=
 =?us-ascii?Q?ZLM/XgPHuD0s3pwhQtvb/it31o89DswjTMqC9vunW4m/I3tFNOPwN1xvZA2N?=
 =?us-ascii?Q?H7B7MKi2YCw5Ofu2NTGr5AgqGKfJXocG+m12bCeaRBOk8OV2MDyFM9HDW0ZO?=
 =?us-ascii?Q?aV/CNAFIoLeRggj87gce3B0gCK+Af4/GRTf1xKPHNt0OaMIFEu1riS2gqtGx?=
 =?us-ascii?Q?padSrLMeK0cU3v/NekSCyiKANSA4TX+IsXBiLqfR++LCqrQ49i4EHRTaJMr6?=
 =?us-ascii?Q?cXAbGDS6YJxTtfhKp4PjJFJ475qgSp9iAyp+CsmBsrA0R0Uaovc15L0IWwQp?=
 =?us-ascii?Q?vs2Kdg7/YJkC4BA3gR0lqv7mfysAbrn3jXHLWkZ1Td60ojum3WwS/I8bhiYV?=
 =?us-ascii?Q?XnAY+2x8ER83EPi20pm8d6A3Pg0KK9kqAVaiJSX/tuU8OEh9iubvumihFqJN?=
 =?us-ascii?Q?JrkgX4WEX8jIScbYJbiU4/Q7v42c4D28AO9cs1X+FJO7Jh4s5SBytg/LJIY+?=
 =?us-ascii?Q?XwOGI8o08RTgRPVeKyKY2W6hF3Pv6QzesKmj90f/emI9ZWO5+xq5CRp2o4mF?=
 =?us-ascii?Q?8XaUMKVT8fWv70z9tALB8XXHVtQGoFCrZKHXoHNCIGn+lQheMbmoP1yVWmXm?=
 =?us-ascii?Q?CE7lFmlGpprGEhofHAj1Wu/n7iIgG4SoY7u7wooby4IERR4bYTTqM2GfZQrE?=
 =?us-ascii?Q?sjM6WE4M5jGUafAMUq6Qodrap/JMQ3dx8ACwhGXM1CvTHWLI3g6aXzr2FR+Y?=
 =?us-ascii?Q?y0+UOGpaeoggSMbRTW1HdbVEeJlmCwtpci3AB6p2K42eXVxX5+Pyygco/bld?=
 =?us-ascii?Q?wIrz0fJBI2Hax4NbbILHwUsNjWu8gc8DWtkM2vUNvcKhUaGXOPeUkdHoor88?=
 =?us-ascii?Q?fKBfXho4cwWu5lWWpCou1Z+c0wqqPzulgTvsRp1H98QiQIXHquWYNskJt+YP?=
 =?us-ascii?Q?MCOpH+B+ONwkTDnY7D9lOfx+9sY1L9IIbPTIwLkPUQWToCk+ifOi4YgxQNRC?=
 =?us-ascii?Q?6+Iuke2ilht4SAa/bn4Up9YWoNKQDYnr25BSONKbFPtrOHrl6OUqUUExt6m7?=
 =?us-ascii?Q?HLanpftPZtnOPBJvxV4vtjCk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3118f4-302e-47c5-762e-08d93ee3fbee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2021 12:05:15.9831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kiwOxx3e8FXuyOJWCiLDBN6WgowXz2Asq9+nGILMaxBd8zgHBUweZTdFAAMnIRuJTqCNRH7bcHi8CQ010uejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3901
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10034 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107040075
X-Proofpoint-GUID: GqpgFlYi2DM5Rki6ECRXOn_9t-hs5mLR
X-Proofpoint-ORIG-GUID: GqpgFlYi2DM5Rki6ECRXOn_9t-hs5mLR
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Drop variable
  struct list_head *devices
and add new variable
  struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;

so that fs_devices is used at two locations within btrfs_trim_fs() function
and also helps to access fs_devices->devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/extent-tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 268ce58d4569..d5925bebd379 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5950,9 +5950,9 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
  */
 int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 {
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_block_group *cache = NULL;
 	struct btrfs_device *device;
-	struct list_head *devices;
 	u64 group_trimmed;
 	u64 range_end = U64_MAX;
 	u64 start;
@@ -6016,9 +6016,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		btrfs_warn(fs_info,
 			"failed to trim %llu block group(s), last error %d",
 			bg_failed, bg_ret);
-	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	devices = &fs_info->fs_devices->devices;
-	list_for_each_entry(device, devices, dev_list) {
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
 			continue;
 
@@ -6031,7 +6031,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 
 		trimmed += group_trimmed;
 	}
-	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	mutex_unlock(&fs_devices->device_list_mutex);
 
 	if (dev_failed)
 		btrfs_warn(fs_info,
-- 
2.31.1

