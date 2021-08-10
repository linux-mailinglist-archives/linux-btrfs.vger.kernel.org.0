Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113013E5C60
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbhHJN5Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 09:57:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29380 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238296AbhHJN5J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 09:57:09 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ADoLSj004742
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 13:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=kuNIRXZ4L6mlcv2N7zKrPV/1LR2lR9jJfFLYuO0n5xQ=;
 b=L3u1Wqown84cr/RlA7UoAjldX5rgRidqDfDEmNRZXH7Xs2kXH7f9dNN9olCsVMGB0gz4
 +g4RzGvKjUY2mYfhsWY7QO02ngxjap4KW8+wTPCh3VoozepavG/JYQYiMjxxFFdbHlqG
 ryTJHmEcRlKOZYLRSivDvvVM5VOtMZ+Z1rD5KNqsrLWmyH6zrpCS53XZ02eQfVwTIUqy
 +FsZKxQOhcHoc2+Qrz51FrKSdwkVhaUuTiygKR8RP5jdMDddGROxQV0DnrADxKuZ7xUp
 PERXhTOaA7wNMrWGZp/DZtuBkW8CiVZ+h+YAUqQ5BrctNx0PZZfqDWCoNMZ3V0LalHvp OQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=kuNIRXZ4L6mlcv2N7zKrPV/1LR2lR9jJfFLYuO0n5xQ=;
 b=UmOJcJLGaVW9OZ69yMDjLopugOdBA1A2Fx5GKS03AsvA1ZkOLR+Cqb6R2dffs0jySriN
 49RzTY1IDI//4A/LfUsbOjWYaMp4VDFZV2bsf24No5z8xnj355wsAcf1tuNtZaMlL0JS
 JXeyEipM5YTUE+AcKtJ/gGrC1MFoZ4zUi6Gl9m7jl304NsCszsKRgBgnXePbIqPleksu
 hcH9j3MI7PT+iBU4iFgamNN2kftFXNzQQk70Ja+wsn9+NLTXdGnZTDhGU5Rw4Bx+cguG
 soNTOxPrBNngdhYAiPGvCuHop74xo2et2PaUqfVrvhtKqIaJqyw4ClfhlnAOhFwc2G4r /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fuv9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 13:56:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17ADo72d123158
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 13:56:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3030.oracle.com with ESMTP id 3abjw4f0ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Aug 2021 13:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQP1YFCZSbOO7GGrch7JvSTm38mzJ8QJHGC8sIGOrx+S6xwmDz+zaEH88HLhqSmjxMLAOVakuBfUI0qDeEQVCm+cSaOpPGIGRDPLQZMzQKseki6RewDWZOLkJIbMOlsHPlP9IEqUQqWkpn/c0GD4CDw4gq3Ru0C8LuJyJ0vedIdb+leRhfZdw1nTODmm1MlhCmy99aG/2snpShjNG+5qq1OgStA12MJ1xVWr7PyytAX+tFdtDtNdbf4VU/JVZlZM/G4OYwWcQjbYGQQoDoCOzVIxsZf3Z2q0Nn/Q3Z3ZvTNUVueN1QMBeui2k5EkK0hLDhaExzN3A7lErq5GfjuWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuNIRXZ4L6mlcv2N7zKrPV/1LR2lR9jJfFLYuO0n5xQ=;
 b=lalOjovgUf1TTg+UFpZgB7bEhSEOhrM5Bi0fRGLApZew8y9octW0U8uKdvAAokohAcbbPmb1fi6mGxs0gUUCLF4N5ASs45nqTx9HXCJaMsNgj47Hxf/V5hA+aOHZ2lPnMpgk97TDHoJaOSf2kSetNIJ2g6+Z82JC7X0KwuMtA/32SwYjEPI+oF07al/3v2hEvZE+vU8fBuzSiq14BYLHihtvk7+5E2tn163BvCXC9lgb+HzKnzidaPWoC4tSLpHdaJnypY9U5ewGY7d30I7nlYkxzv0PgNE+QHqEgymxhAbqStruR08AGqIsdy069bbK2whpY/0NaS44B4K/lpeSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuNIRXZ4L6mlcv2N7zKrPV/1LR2lR9jJfFLYuO0n5xQ=;
 b=VnVTTe9uFgSAUF0vP2mTwu9YM2HmX6t0pj8pNOEUGC51Bh47QufRRUD4rBMoKjDYN6XMYuz7+cMQoEDqjSNpZdwpS6ZRYfpu9gomXhZrj6Qf9/R4tPlKT5WJhRsz41/v1/aV+kZmopoOpsEzBNV5ri6aisZLgNFWg5bJH39Vc3I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3920.namprd10.prod.outlook.com (2603:10b6:208:1bc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Tue, 10 Aug
 2021 13:56:13 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.019; Tue, 10 Aug 2021
 13:56:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: sysfs: map sysfs files to their path
Date:   Tue, 10 Aug 2021 21:55:59 +0800
Message-Id: <437f0a236348a3376ac2baeab564460491c7fa12.1628603355.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dev.sg.oracle.com (39.109.186.25) by SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 13:56:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f989de3-98be-4b5b-03c2-08d95c069dc4
X-MS-TrafficTypeDiagnostic: MN2PR10MB3920:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3920E5B2BBDE46BA42CB85BCE5F79@MN2PR10MB3920.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPQcdbUeczY+lt3OG49+IgeMVG1Yp/BTKuKqBqFwoPt0ZLnRtcvcu/bztWvzd8gexsj2Zq8KkhBE+T/iAyWN5ms5jr7INqwFE4Jl7S8h7+goPB8DFk3tWWtVyzgNGY2X6mmx5ZlVUz8rn+gaevDWxVeoJinKfuX6vIvSMOUtbwurGUWi4qB5NzI/j5GGMjEk8kGbntzfoH4YQEOuMhXzKfmcZ5a02IWKn/T4TJj7BbWwVD1JO1r5N9ht0NIx/X2lXsHfnsUycNu0oyNXrn23odYnmJ1ATECV7sWngfJUWrzjQqYNLbECnmzZ3wUJJhaMc2O1w+N8ouCSr7nbm2UcyG9Quo0Rv6F9GYgZaI8CmLDf11DIatZvKoprupYQsmM4E75BhYUYjz+RPYAwki/tPLxh6ZH0NlNFnJ2PHlhTHghFcDtS7zDDqo9hJjcbvscYUVQ2/6WW0lnlCXLJUerEfEHiVnRlxuN2wLiRFfNjH4Gq67JzolbS6tQnJZzBKSZnMtWmHfPhEb5SBXdNo1vC89MHlyS/AeVSG8TgBRlkNzo3+hXRGHDC5VYkf+QYtkFNcBT6m1kPEbpqo2agdxwPa/n0+ofQNeJsXRU59wRrBwBBDJjTFu/P7dXhGZwuRz3y7x6vZ4Je3bDcxTs082q+7E8NXBf02A6P7xa/LBC6PXQ7Fde8UiKeE6LYSJQH7uIHMOyNIsCqCg/FEtzQ+kl1PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(39860400002)(376002)(396003)(66476007)(66556008)(66946007)(2906002)(5660300002)(8676002)(186003)(8936002)(6916009)(478600001)(86362001)(316002)(2616005)(38350700002)(7696005)(52116002)(6486002)(6666004)(44832011)(956004)(83380400001)(38100700002)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?20+7oEiQuIMUTDZUDvYjSivgzFmSEluIzPk+aYjQLXkAUwXoMvbhPYvUNAOU?=
 =?us-ascii?Q?ueDBvQRIBYWqUNWTsuf+4vvha1i+4VC0NjkH1iMEbAxR4lqFx14wqbgRSQN0?=
 =?us-ascii?Q?BduPEbQcfjdyhQAcaBIN8bWVsnAi6k/tTdoDGqt0gbnR6hDEqMhZ5cnmBc6N?=
 =?us-ascii?Q?13RFwBpPoYEdgPrKQDwyyr/7cjll4ghb8wQpYtUnP1wXxPvXrtOVHVTsWFoT?=
 =?us-ascii?Q?mziJh9K74lJajfjsf4zO50W+usArmCU++ziXpgj1hm9vFWDRBxMH4/erMDEI?=
 =?us-ascii?Q?A+4A7DjVjTvnUnD5jSW4mqSSTzB3O8DT8rtVMZeJYn0VEEzPUIEjFyfXPFqA?=
 =?us-ascii?Q?lGxic0lTmCbiJYI6Okhp2UaB8yNKVP+GDrVyPtjKmsplNjTsbhO+XpD+3Tgf?=
 =?us-ascii?Q?Np1SD++z5KEIEGlM6fyQfRJnz+hqyawaxaNIoLgN0Qi/ryDwln+en9PwsUFQ?=
 =?us-ascii?Q?yaaRbPF9VAbXxj9qD6DCbZhN56MZOqcFNYwrXnTBZN/HGR3Xr6bTBWqmyBVn?=
 =?us-ascii?Q?VgEqyoC8G0rQn2Hg89lKTO9u1BaRzrl7VoQxcUVRdh3lFMC7Xbt5VkqgkeP7?=
 =?us-ascii?Q?j1R5X1YjqEzlFmUMy99KaihVvecCEZQOsyuaLj2hybx2u3fjf5+shKkBeyA1?=
 =?us-ascii?Q?iNhaATHskH5GiiuPh7RYix1eDvzu5uA0qWpNBbvooVOZM5uo3DBVtQjFZJqh?=
 =?us-ascii?Q?fMpY/6ml3u/NVUK2uALHS5bpvamsrbQLBTotMrN6p0dAL9yF/gF29xukH1XZ?=
 =?us-ascii?Q?X7bS9oV/bukMUzT2aCYRnY1qpvRMo93w0eBag7vkdyhjrfpDHgfxSJ3Gwf/+?=
 =?us-ascii?Q?fGy/fiS1S6TWFK7r8EtwNVFe6TcOYR8Oi6tZjKjcwBQr2IBbwWnamLp5jXaA?=
 =?us-ascii?Q?y6m20L6hiISIr+Q3A2giFyQ/yt6ehRsGASrXnkzNkkYmNXlpXLBBx0b25m0U?=
 =?us-ascii?Q?sfKa3QI8wUaSjq8TIL0gFfo5uL75lUiTTOe//cnCogq5Gn+G+Fca/4dHesWZ?=
 =?us-ascii?Q?qhvBPXFVHV/AP23NJjJQprStyYSmKpuUYa3powSiBppPUL2F5KqT4FnBsV9y?=
 =?us-ascii?Q?JtXl3d1Qi1Xx47rA1/nLnRraJ4S2aQWL8CnEC5jgBQz1LtHe+xXzc6LQVDyY?=
 =?us-ascii?Q?lZoDFX5w0Z/4+32Frmb0eroW/ejDoNpQ96wVrcnoE/nKs5DWUex7PzUy973I?=
 =?us-ascii?Q?eiMJonDQLKXrc9T0FKpdGqzxMmH2m1bGBdIKmZR6nD/S9oxSFVsIsyr2B57f?=
 =?us-ascii?Q?Ce5rZMjFeNB5UILRz0RBLVQ0WlmS7f2D9JrYaT7BclUkEBhVB26ZZO6LoI/z?=
 =?us-ascii?Q?jyNiYaY46PZhJzhCaw/GRdPi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f989de3-98be-4b5b-03c2-08d95c069dc4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 13:56:13.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZMkndhz2Q3dA3BUUINZoyt16NjWqfF9Xw/2FPe3gaoLZUWfZsPfEblh/V7o97JghAn0md6JmLYeGiF1mT+zuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3920
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=83 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100089
X-Proofpoint-ORIG-GUID: noQkwG2rqBY5ZFdqQ2_pewdQvQQZO23R
X-Proofpoint-GUID: noQkwG2rqBY5ZFdqQ2_pewdQvQQZO23R
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sysfs file has grown big. It takes some time to locate the correct
struct attribute to add new files. Create a table and map the
struct attribute to its sysfs path.

Also, fix the comment about the debug sysfs path.
And add the comments to the attributes instead of attribute group,
where sysfs file names are defined.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Add sysfs path in the attribute definitions.

 fs/btrfs/sysfs.c | 87 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index bfe5e27617b0..1ac97250d586 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -22,6 +22,26 @@
 #include "block-group.h"
 #include "qgroup.h"
 
+
+/*
+ * struct attributes (sysfs files)	sysfs path
+ * --------------------------------------------------------------------------
+ * btrfs_supported_static_feature_attrs /sys/fs/btrfs/features
+ * btrfs_supported_feature_attrs        /sys/fs/btrfs/features and
+ *					/sys/fs/btrfs/uuid/features (if visible)
+ * btrfs_debug_feature_attrs		/sys/fs/btrfs/debug
+ * btrfs_debug_mount_attrs		/sys/fs/btrfs/<uuid>/debug
+ * discard_debug_attrs			/sys/fs/btrfs/<uuid>/debug/discard
+ * btrfs_attrs				/sys/fs/btrfs/<uuid>
+ * devid_attrs				/sys/fs/btrfs/<uuid>/devinfo/<devid>
+ * allocation_attrs			/sys/fs/btrfs/<uuid>/allocation
+ * qgroup_attrs				/sys/fs/btrfs/<uuid>/qgroups/<subvol-id>
+ * space_info_attrs		/sys/fs/btrfs/<uuid>/allocation/<bg-type>
+ * raid_attrs		/sys/fs/btrfs/<uuid>/allocation/<bg-type>/<bg-profile>
+ */
+
+
+
 struct btrfs_feature_attr {
 	struct kobj_attribute kobj_attr;
 	enum btrfs_feature_set feature_set;
@@ -271,6 +291,13 @@ BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 BTRFS_FEAT_ATTR_COMPAT_RO(verity, VERITY);
 #endif
 
+/*
+ * Features which depend on feature bits and may differ between each fs.
+ *
+ * /sys/fs/btrfs/features lists all available features of this kernel while
+ * /sys/fs/btrfs/UUID/features shows features of the fs which are enabled or
+ * can be changed online.
+ */
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
 	BTRFS_FEAT_ATTR_PTR(default_subvol),
@@ -294,13 +321,6 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	NULL
 };
 
-/*
- * Features which depend on feature bits and may differ between each fs.
- *
- * /sys/fs/btrfs/features lists all available features of this kernel while
- * /sys/fs/btrfs/UUID/features shows features of the fs which are enabled or
- * can be changed online.
- */
 static const struct attribute_group btrfs_feature_attr_group = {
 	.name = "features",
 	.is_visible = btrfs_feature_visible,
@@ -384,6 +404,12 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 BTRFS_ATTR(static_feature, supported_sectorsizes,
 	   supported_sectorsizes_show);
 
+/*
+ * Features which only depend on kernel version.
+ *
+ * These are listed in /sys/fs/btrfs/features along with
+ * btrfs_supported_feature_attrs.
+ */
 static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
 	BTRFS_ATTR_PTR(static_feature, supported_checksums),
@@ -393,12 +419,6 @@ static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	NULL
 };
 
-/*
- * Features which only depend on kernel version.
- *
- * These are listed in /sys/fs/btrfs/features along with
- * btrfs_feature_attr_group
- */
 static const struct attribute_group btrfs_static_feature_attr_group = {
 	.name = "features",
 	.attrs = btrfs_supported_static_feature_attrs,
@@ -557,6 +577,12 @@ static ssize_t btrfs_discard_max_discard_size_store(struct kobject *kobj,
 BTRFS_ATTR_RW(discard, max_discard_size, btrfs_discard_max_discard_size_show,
 	      btrfs_discard_max_discard_size_store);
 
+/*
+ * Runtime debugging exported via sysfs
+ *
+ * sysfs path:
+ *	/sys/fs/btrfs/<uuid>/debug/discard
+ */
 static const struct attribute *discard_debug_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	BTRFS_ATTR_PTR(discard, discardable_extents),
@@ -572,13 +598,20 @@ static const struct attribute *discard_debug_attrs[] = {
 /*
  * Runtime debugging exported via sysfs
  *
- * /sys/fs/btrfs/debug - applies to module or all filesystems
- * /sys/fs/btrfs/UUID  - applies only to the given filesystem
+ * sysfs path:
+ *	/sys/fs/btrfs/UUID/debug
  */
 static const struct attribute *btrfs_debug_mount_attrs[] = {
 	NULL,
 };
 
+/*
+ * Runtime debugging exported via sysfs
+ *
+ * sysfs path:
+ *	/sys/fs/btrfs/debug
+ * Applies to all btrfs filesystem in the system
+ */
 static struct attribute *btrfs_debug_feature_attrs[] = {
 	NULL
 };
@@ -647,6 +680,10 @@ static ssize_t raid_bytes_show(struct kobject *kobj,
 	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
 }
 
+/*
+ * sysfs path
+ *	/sys/fs/btrfs/<uuid>/allocation/<bg-type>/<bg-profile>
+ */
 static struct attribute *raid_attrs[] = {
 	BTRFS_ATTR_PTR(raid, total_bytes),
 	BTRFS_ATTR_PTR(raid, used_bytes),
@@ -686,6 +723,10 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 
+/*
+ * sysfs path
+ *	/sys/fs/btrfs/<uuid>/allocation/<bg-type>
+ */
 static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, flags),
 	BTRFS_ATTR_PTR(space_info, total_bytes),
@@ -713,6 +754,10 @@ static struct kobj_type space_info_ktype = {
 	.default_groups = space_info_groups,
 };
 
+/*
+ * sysfs path
+ *	sys/fs/btrfs/<uuid>/allocation
+ */
 static const struct attribute *allocation_attrs[] = {
 	BTRFS_ATTR_PTR(allocation, global_rsv_reserved),
 	BTRFS_ATTR_PTR(allocation, global_rsv_size),
@@ -1011,6 +1056,10 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
 	      btrfs_bg_reclaim_threshold_store);
 
+/*
+ * sysfs path
+ *	/sys/fs/btrfs/<uuid>
+ */
 static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, label),
 	BTRFS_ATTR_PTR(, nodesize),
@@ -1520,6 +1569,10 @@ static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, error_stats, btrfs_devinfo_error_stats_show);
 
+/*
+ * sysfs path
+ *	/sys/fs/btrfs/<uuid>/devinfo/<devid>
+ */
 static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, error_stats),
 	BTRFS_ATTR_PTR(devid, in_fs_metadata),
@@ -1809,6 +1862,10 @@ QGROUP_RSV_ATTR(data, BTRFS_QGROUP_RSV_DATA);
 QGROUP_RSV_ATTR(meta_pertrans, BTRFS_QGROUP_RSV_META_PERTRANS);
 QGROUP_RSV_ATTR(meta_prealloc, BTRFS_QGROUP_RSV_META_PREALLOC);
 
+/*
+ * sysfs path
+ *	/sys/fs/btrfs/<uuid>/qgroups/<subvol-id>
+ */
 static struct attribute *qgroup_attrs[] = {
 	BTRFS_ATTR_PTR(qgroup, referenced),
 	BTRFS_ATTR_PTR(qgroup, exclusive),
-- 
2.31.1

