Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB513BB5B3
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 05:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhGEDoO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 23:44:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44246 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhGEDoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 23:44:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1653c4Oo011003;
        Mon, 5 Jul 2021 03:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=jWkHodMgA7ndXyRCRZUcZc/G+zAvML8priGEuDC6c7A=;
 b=j9Hw4xey/W8LoZidMe2g6vy276RjzHhUUH+VYMl1KhY5jWOkuUqTPKQalG+5mF1hOJkW
 HxCe4+7qLGj+GjU+5dN//F5yU7K2s75UAwnLDZpD9AB6Inm7/NJx+Lb/MGMJus2+kB46
 upgD5gPdFsDJUt8bc5/pkfTLrepka80Ihp2ZpD8JZ72Mwft2oUM9SXc0NW7TylyfBbR5
 BeSNFTry7FeM+1WDhjU8eZKrh9AZQ5qFEPT1mwMcmmqXCifk1Fkc84+BrgUc4a5HshNs
 nGSZylHRBqpN4hO87OXBhxOGOb/DAb+GCZBiBusAOLf0t9vnjS8esRMv7St9fcytSWXG Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jeg1hm9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 03:41:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1653aOLS196237;
        Mon, 5 Jul 2021 03:41:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by aserp3030.oracle.com with ESMTP id 39jdxeg7un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 03:41:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6Izk99GVeIJoIWk6KxbT8HhQbRIEn0R0Dk7pQQ6pNlcjDSBGpOaczpBpAZXIVnv8uB5l5EvzRO39FCb2r0YEtn19baUeWXpFTiYUHlc9g6y2lZ8CwayTfBHUsNjFKBs00cxehFOwK+cqKTSqmgI5LPzuYGkOXdLLxJ9uDnfbCgMXCKsKV7vBhKinMUFy+HPaAju9BLzkm92u2nFrZUgX29b/ygirfywybvPzU78aTEMcibJ16W6ryAB2fQwBtAuOCfOK3Qb7w8sGt+tPbZhYjuN03MPabXsQa0DNGj5ak+V/940ceLM59DAr6uY+ybsBFvlZ5n/fit1CijB6aKvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWkHodMgA7ndXyRCRZUcZc/G+zAvML8priGEuDC6c7A=;
 b=atOTgGSVogx/EOuNyPOnaZ6p/Y9JGsITWQwkanFEQWzCl0B0lx8q3x0Hc9sLkXVR9WywQ5zb3uFM9DPTGxW2A9/x97av6Qo7ybtUKYmVlMl0P1z6RSjekqb9URj7/e2/GPe7v849ltCFRT6YrJrJXUAqLv9PLXIc2FzYxU13P/r/2B11QP1vJFsyVP35iYhDQqfehfJB3JYF/3W/tEzcYPvr0TW5gHKibung08ewOP3E2dBph54VzbNKXL7LWQjqFagmBGqRNHjli13WR2d9bQJS/SkyQXU2AuvR92SwuLSr+NhJtnmEoVzNFXwWj6DWx5VIFSZTRA8w6Sx/ibIlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWkHodMgA7ndXyRCRZUcZc/G+zAvML8priGEuDC6c7A=;
 b=F7rMm3iBK5ijJ0Gs7phKQrqJ7Ds0tJpk0n0/wresEwwT4dTRNgWi/NriLCuQ/wiEHH/Z6fAwDBXb9+pPlGAi5aavAnUVwHfTtH9zU3x/XCx2rlgRMFysFfPhoHGoj6De8HLM+5QzkTYgoYQKgea6i7dWWusZpDe0QBb2UzyRoP0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3025.namprd10.prod.outlook.com (2603:10b6:208:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 03:41:31 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 03:41:31 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com
Subject: [PATCH v2] btrfs/242: test case to fstrim on a degraded filesystem
Date:   Mon,  5 Jul 2021 11:41:15 +0800
Message-Id: <9de7d17d8bdf0bee98fd7b9ac2961da12664b7a9.1625456115.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
References: <a70c9f6b4e45d9bcdc5c2f19182f89ef8e22c074.1625237782.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR06CA0243.apcprd06.prod.outlook.com (2603:1096:4:ac::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 03:41:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7eadb34-d4f3-4b62-dd1d-08d93f66c730
X-MS-TrafficTypeDiagnostic: BL0PR10MB3025:
X-Microsoft-Antispam-PRVS: <BL0PR10MB302566FB8AF2DCCD6C003872E51C9@BL0PR10MB3025.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5o6Asc5iVCIwIvdKMXz2ey5h14UBYIU5bQgTENQ+XF/jXGmb5yEGfX7ik/kej+FSykroTKbyLbI2cUHkveOQt67fquVCMmbdCV5i+kC7VUy9hcdUBdleKiSKf2XgOGxpeywQEv98dRKmLEkVVxOs8TF2/5L6EtvqidwqU55JjwWR+kLGIF+LxhnL8rT+GM9TPQYHWpIhso5S24TmCBPFnsqmZyGCcGfvuXT2mElvu/1Xg+oqjx3rAJZ3Vr4amZJbyJTF7J1a1Z/2ANlbzYGaM6x/QVB5OOwvf2u+ideNuMstoDYWVRCrasjQAvODlx7dfGk8OtJpKflDxaBxfUADuXJgyZWFs6e3cwzbUrS2WN16sMRmPBCL6EhBYym12RACa85+ynxGXTJLWXUIZJUvb7WvZ9U5kl2f1Fh/ZayzgP4o0JEoTDvjh124FOhYVXOcg0SbVQg5hiNRJQEM9b8t2wLuYIG4mdsDHeiavE9Z3CnJHVWa3wW1jSy9PzwzuOFR4q95ewTFCpfxIGFw/I+m6HpRULHrAz21S+GiKlwxKPqXTWYIgFJWUdq7zk0pE2gDeNR2usg6mf1o+UKpu8f0CIy8L3OXpk/9vbAR4b/vxPKpPvlh3+i+GKUoXo/aImCOyNznhhcf61IwfSPSp4vIOezy3BZe/OlLOe2lLsUVCA3G1Xv5aPKPqsJJNnxYnAhrT5pkdpIYHvcD37EIRMTPhpd2ZZslnTTMabWez+i++ao=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(366004)(136003)(396003)(6916009)(8936002)(36756003)(316002)(16526019)(186003)(5660300002)(478600001)(38100700002)(38350700002)(86362001)(6486002)(66476007)(66556008)(66946007)(6506007)(6666004)(2616005)(956004)(52116002)(2906002)(44832011)(6512007)(26005)(8676002)(4326008)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1dUHHPx8rAImBWVeh8BDOZQ4DlrGwFwVztxA3ty0oeXC4NWDvHfAPUCrw/zH?=
 =?us-ascii?Q?jVXLDgvpqt0J+yX56XuUrWEOgHSefe5giQHpjzpIa4NYKchwmCF5i5qSp8Bh?=
 =?us-ascii?Q?v6jBh3gMBcZOwX+hf5Uj0/nS0tlSTLca7nVfI5wzlmOey5i53584ycWWv7Xn?=
 =?us-ascii?Q?e2ajHF3k4SHSBYiVwDRrbxxdOG3pL6tCtSisoqZLsEoHFVqVh2JTcAAjYtQt?=
 =?us-ascii?Q?y0NehZeDDEcarUIHVRESMybCttEEW4QDadocZS/EAwmhZ953nnNxoyLYJbDF?=
 =?us-ascii?Q?RwlyZDaQJp8OyfRhFcrB6u59weCtXLnMgyO45bXXezR1knSRKEoZ/24k00Qu?=
 =?us-ascii?Q?pgqNqONRY9QvQKs/y8AZUOPGc1VdwDwJH0Vyi4FE9fk5bQ+rYdT41MxxbneC?=
 =?us-ascii?Q?EsxcMvq9BFq2xP+1ULN5pldyp4Xve56VNkF3y4cj9Y5Vf5bgcsEMoYV5/K1/?=
 =?us-ascii?Q?t5vn3wL8Fwy9xxUO5+9I0WJThhEtQ9VDyAx8Hlu7IyltwJIb5DNtcAIQ3OsK?=
 =?us-ascii?Q?AFAcLfrAjdAT1yqvYUA8eXXjB3Tec6mNBPQCcl/uddjHfzwAtJY9C/hbhezD?=
 =?us-ascii?Q?Si0diJMC7SoiIh1bRl5+M7LrggYmtb18AZlJlt0lSS9XJtKQS8k5Tp62gK+p?=
 =?us-ascii?Q?ipbmUmGPwzmKrUKPU0S7y3DVtpiz6M8HF1Ph5+hEbGc97L3teJhP1fjFeTKg?=
 =?us-ascii?Q?iquxaHx9FQeJ03bn5Z2qRJPAVS6GEpDqPviJ0XvZzL1mDYGqsG22ctysuszE?=
 =?us-ascii?Q?f+UcAI9HWYGeyhDGpIMZ8jkRGOBfXzkvX7AYFis2IB4yhtjAJNmkzSAzmOlR?=
 =?us-ascii?Q?Qp+aGBZcuEirtAP4pCFzPnpCaPS5I7MSZAgnNh6KRN0jkKX0NdzjPswNgulb?=
 =?us-ascii?Q?ks6ZruFQXc0OOXjiDE9/0dGuiMfxUSpyIK3CnRDScsViTGQpcql5xQ0NJP7d?=
 =?us-ascii?Q?FZpSPTn2IavvHn9s0zcFzdcbnm2v2M+lepf//0L8P4MNRuPrzca1+dz7C+RU?=
 =?us-ascii?Q?zVfcmcSdfbZ9CTj8lyoHzBqfP/Xbl7cpUO+wT0+MHXAyQ7ZxPeWMJcmLBp7p?=
 =?us-ascii?Q?npt2lSaaSMk3WGFRqp/C/2KNIQgqzyFzIaZJgAeT2Fe8SeNQ4MJkvGSGrVO6?=
 =?us-ascii?Q?KfnlJu23IofKXTiKpZXrcJfIxpO85u/8zGSd23AWHEfTBKAH+ER+X+SqX+h/?=
 =?us-ascii?Q?TeUVR5iEAF4CU0jEb0iPvsXpZUIE+Kk5zfg3ysgjcqAFUPvZ7rracjI0LTEx?=
 =?us-ascii?Q?UxlBS/GydnmLTd8pxmogecp8W7iCxCWBLzdmwyH5qXcxJbqaKfJ8qtT0OwNT?=
 =?us-ascii?Q?DSz6g0E9wwSoiCXZZOPs/gt9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7eadb34-d4f3-4b62-dd1d-08d93f66c730
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 03:41:31.4043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pj/1ccEowzv12UirPEcWMY/dxKtD2rGrZ50m8IfZfGIZNT/TUtGDDfTIHpyAMZyKNttuxdJZuaC6RJMtKo1dzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3025
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050017
X-Proofpoint-GUID: tEd4PEOcNmhAb_MuhMr_I-9WarUuYL3n
X-Proofpoint-ORIG-GUID: tEd4PEOcNmhAb_MuhMr_I-9WarUuYL3n
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Create a degraded btrfs filesystem and run fstrim on it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Remove the commented #_require_command "$WIPEFS_PROG" wipefs 
    which I forgot to remove earlier.

 tests/btrfs/242     | 48 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/242.out |  2 ++
 2 files changed, 50 insertions(+)
 create mode 100755 tests/btrfs/242
 create mode 100644 tests/btrfs/242.out

diff --git a/tests/btrfs/242 b/tests/btrfs/242
new file mode 100755
index 000000000000..6b632e4abada
--- /dev/null
+++ b/tests/btrfs/242
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 Oracle. All Rights Reserved.
+#
+# FS QA Test 242
+#
+# Test that fstrim can run on the degraded filesystem
+#   Kernel requires fix for the null pointer deref in btrfs_trim_fs()
+#     [patch] btrfs: check for missing device in btrfs_trim_fs
+
+
+. ./common/preamble
+_begin_fstest auto quick replace trim
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs btrfs
+_require_btrfs_forget_or_module_loadable
+_require_scratch_dev_pool 2
+
+_scratch_dev_pool_get 2
+dev1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
+
+_scratch_pool_mkfs "-m raid1 -d raid1"
+_scratch_mount
+_require_batched_discard $SCRATCH_MNT
+
+# Add a test file with some data.
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo > /dev/null
+
+# Unmount the filesystem.
+_scratch_unmount
+
+# Mount the filesystem in degraded mode 
+_btrfs_forget_or_module_reload
+_mount -o degraded $dev1 $SCRATCH_MNT
+
+# Run fstrim
+$FSTRIM_PROG $SCRATCH_MNT
+
+_scratch_dev_pool_put
+
+echo Silence is golden
+
+status=0
+exit
diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
new file mode 100644
index 000000000000..a46d77702f23
--- /dev/null
+++ b/tests/btrfs/242.out
@@ -0,0 +1,2 @@
+QA output created by 242
+Silence is golden
-- 
2.27.0

