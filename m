Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F0F53C1C9
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 04:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbiFCBm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 21:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbiFCBmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 21:42:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F835E0AC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 18:42:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252K6T3o021645
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jun 2022 01:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=IIfvuuyYFdfOyIhpn0SMFP6ysdRcZ+LLUsgpc1snC/k=;
 b=ktFJO4CyrkB2Nhh0QwKa2n/PyFAFFvxI8zkPTUGyPafpz6y6ZCFD9XR8pdRc0QTVqOud
 m2GvMUzB47ECIYJwNDleymPARcFKHtCGfPGylyhIkyLQRqgGnHJu3onLzTNbb/7jU0O/
 H4NxIxlk2Ud8YrEReHy9jHrBFj2vFaxpV1Vike9xXfmupow3QWDzHBfkxYE8hZozs0s8
 QEWk8mRvzDytCVCrtlvPeAq5JepuvmgXsRSyjCxThHyEyIvV3iWl+PB3WzvXZQiCdBbQ
 FAKqG0ljCwmKrgGe1iTh31F8iq0IbTBMKfyEb97awewAt2Jwg6as+nfQ4wG+pkFYdZ3P jA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcauv0tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 01:42:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2531eT9J015960
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Jun 2022 01:42:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8p5g7n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 01:42:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf4K3t/D1RnbCVBZFGBM6Glu71lmoNvT8sspI7ZdP264nvdKNAUdqd6c4XADQrXlpXEEE2kmOJwZC4ITci1V+UCCtfywrteRZFT3TG77sJzALoDztd1bnnRcOYRyPyeTuORh3u1xfXuRzosR6LSS1/mwrIezFz/HdBXieBCr6AB71orzJwg4/J3ljVmnPermjgI8whqHnJFPwz14ndFwcZvIZASlriTbnxMLb8YWdktd3OZ81arVUr4LCDcKNVDgGMGX/nPEyUYOh6PEKDuLRfy1lUGy2xdwhttUIr9aXw+Jz/tEQcqFdyqHWPDR7QT7WyARAV9ltgRybQhTWKyOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIfvuuyYFdfOyIhpn0SMFP6ysdRcZ+LLUsgpc1snC/k=;
 b=kRtF2SKpqxLPs0UTF5Y10izY1L9K5gUS3kOTAXue83JAkuY90cEJf7Y+fjaekROviltqLosMTy7PhC7yEjKS355R3DPVtdWOLlHO3DNUja1sctzkWKPKUitwH+h6ZP6vybsyRnuWR19D2pwWgvhQJSlhnv529o0mIByrT0Ttt40GetOMamRymAucPJeUYRPQg7WFQG982wQ/lJD/zvJGi6jHlZwpRGozMNn0PBig2Yx3NDvPkIjpYeWcJhj/GrdnqbWf4UJ4w25CE01DihU/FtYeDSIrwpqSsaeDf4rC1AcxJV38B5jUeOMmqQJUSbetOG7ZxzT1Td0rKFsiYxl3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIfvuuyYFdfOyIhpn0SMFP6ysdRcZ+LLUsgpc1snC/k=;
 b=QkjkjrcMJEFloLccvCkqmdSPQ49uEDh884bLCTAl8CIYca9UVXVUw2g8+puu4RrEqhz3iagyz3s6tIgMavRgssXyr8qHeik8D56N299Fr0YSdYRY3b49IUU5UvdPA6j76+joO8MDmJ71m9ZAqxHHr64vVwsqiYxdIUz5iMzQcv8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM5PR10MB1530.namprd10.prod.outlook.com (2603:10b6:3:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 01:42:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf%3]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 01:42:20 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RESEND PATCH 0/3] cleanup rdonly flag and BTRFS_FS_OPEN flag
Date:   Fri,  3 Jun 2022 07:12:08 +0530
Message-Id: <cover.1654216941.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37cae548-b31c-428e-b06c-08da45024c52
X-MS-TrafficTypeDiagnostic: DM5PR10MB1530:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1530FA2A3DAF96634E465FBEE5A19@DM5PR10MB1530.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mavp502v/Ot/Wz9x01F1Xj6dv1AdytGaiSbW86UWDcHNXLprNQCTHdqXJfSqjrrNBIEknM3B4/+HliMfD6Gkv6EUnNF/2i1byAQ4TfMX//RLQYydzrSSGkGy6gnLD0ztfgAmcH0LklS/ftSFyOfSEfcvXBnIIOxSSH08CN+/lnrKZq8D1qHzcrypE2tHxnEF0w1NCHXWQ8mi7LeiLNwL6k9gr2LC9/evcw5s6ErzNV8JB0N5r4IKYSJEoPkI/t1wNacv56/YHzY6lbN0D0r97l54B1s2nvu2v5KcL45SLGapxrBuXSOagKEeW4dSJo7N+sNv6jwkZmEWH4rmHQ25LVUQpUEC9zGhMEDNWAL/gtrdbkrm0Oy9k67gJOFsljL0qNx/7OF5UB+mKSEn3Cs1woipX0mJ11OL5aTaj/qwZI8nFPM5+8oPO27qIsinuzsCr8K47PEjoc3S3aj9zRiAoXd8n9EDD6gytk5kn68tJFjeEpMymYFQwGRNSTakEWm7pm9jEV4hWLXvoaCkQ2kuX/ZGPqtzmFTx0vhx6ZfeR89C5xH1tAJ7hJgYRngbF50KxsJKI+xBUMJFAOBHrxwaaC8wX4KXPE/GPl3Fn1rnbBpOZoKZN97FP+6womhPbpSrkKsAomP1NiJ9/vClFdd2mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(83380400001)(26005)(66946007)(66476007)(36756003)(8676002)(186003)(4744005)(316002)(66556008)(508600001)(6506007)(2906002)(86362001)(6512007)(44832011)(6666004)(38100700002)(8936002)(6486002)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iy7XR6Jg+hjTXgBBMyY5jDekND4igjt490+W9hjcJhmhp6mP9BCcI6jYHu7T?=
 =?us-ascii?Q?qkOv1tEcQwZ6WavKLsdc1Zq2byOnOPDxfSjXoJFNgZ+cjailcGBdPArGaV6d?=
 =?us-ascii?Q?bKWM/hXP5O7v7tHGSykPwRCqeGAbQq42b/VH2Ep4O+6IROdN9fiInlIvrj17?=
 =?us-ascii?Q?QO7kuYU8V99cz3xMkhSBh2B2W58a+RvGwbJqq5saoANOvs8mu91HrkkHXML/?=
 =?us-ascii?Q?D2dsJx3hyiBTJSRvN/ueC8YmnPtHhabrgwOyQo2ns+PLDZM5JnpMc+sJjnpr?=
 =?us-ascii?Q?wsU4GAnFkuNZ3vJKyMbgj9gE0ZivLPKgvz9XCeJEuxUgyl+uivF1UFDIGM9V?=
 =?us-ascii?Q?pqwu7miH6NOFj0+nMmTFgWljjkOD0UgSg+RweaqIWU+8BpbRxcKicfj+o9X7?=
 =?us-ascii?Q?WV26D/Og1/Br1qncw5cth8Nmb4EcjoK5v+nhrP64CIM211JnNQn8Vt4sXqU7?=
 =?us-ascii?Q?p+iaJwisNlz9DDvxkEly2MtywkMPP7rwFgnHcYkJNilRA6IANwpFKSTSkmdN?=
 =?us-ascii?Q?Kf35gAlwGw06jprF95hE8ZXB43lJ0nonbYWnvs/FS02mVrKWpQUYbf0t0ceH?=
 =?us-ascii?Q?CjQ41MFw/zCeFv3O/I2iYSWx1QxVTDdAMEM7ScADGbTh2t1OR2ws8Mqgppw8?=
 =?us-ascii?Q?3uR/tQxQpoSsHrHfc5tfvgjSfXyXCOsCi6ZHZYvIP4DLvJzWam24fOQdgG4R?=
 =?us-ascii?Q?m6khl6Cwam0tlvHYTpM8Sg13a8y8U7xOE55Zh/h+QKw1l4lS9zpHWmfrNir7?=
 =?us-ascii?Q?OCfKSTHMuC02CoPSasjlasnBJO/fbitW/8dGg4SDBce0vANgaDIsB9EZcm6c?=
 =?us-ascii?Q?LDFzDIWExg47mif0nINsEm46befV2ao336Lb4AHzcsLwhg5jET2crmeKnh3B?=
 =?us-ascii?Q?5AhsicDmoJ7mx1PjoUXIilM7owykP+CJK6ptq0PlWHtl54AHq1fkpP8wB2n5?=
 =?us-ascii?Q?VK3jm0eeV+A/GRhPP+rUKhF29efVL1r5b8V2XROMzyws/s+Kgq8fut66DWN2?=
 =?us-ascii?Q?ZAYhDb5VGseAXK1MAfVoDO2gd+XWxj3fTCj/cAeTyeVlNQ7sY6puZTt45WSg?=
 =?us-ascii?Q?oeYpp2M8ByvWHpsx12i4gfma+MkzV39mOCsb4mcwlSfwZyX6l8m5C8C6G2rP?=
 =?us-ascii?Q?gO4WsZtkDP8fAkBpv1e1WVHyQX/xp0CfOlB/Nx9PVKS9qbdyAr8xWCdp7CHv?=
 =?us-ascii?Q?qa5XFbtcqYfv47ZIJO4Wg94AmAdc2BZshfB8l1nvj6eMtv+bKwV9xqyCI1+5?=
 =?us-ascii?Q?jO+6OS2aUeebo5UDeV23vWhyhQwKzIaKybfXPNWMlZH+l7wAdXANJPurBYj5?=
 =?us-ascii?Q?Wt/qzwhKQ2mzf4EcM90DAEgKffn0jM5pjfgC21MtCPzt19XfU3TIdou5VB41?=
 =?us-ascii?Q?LUH78Gz/FHhu6iHtzpPnL376MWhmeT5NWoZTtfQxvF15+JyBccsnk5xk2hhN?=
 =?us-ascii?Q?mk2TbcETxAgEeWW2f68Y9vIwhPTsgUJJbzuj2oySFvUf4ffCoakkh1Fq82d3?=
 =?us-ascii?Q?82F8LuWQPVLGlAGQE/b7I74flItbuAiQv4TOti1MrGmmaZxwdgY2bWGOCemz?=
 =?us-ascii?Q?ndgcsKizLO9uiOFIU0kuYXxaP++u0cygjAxmuzjJ+8MwDITpnOt7kZ9dTRTp?=
 =?us-ascii?Q?hlJ2bSCZOUcvg9OGRpxcvROpTRlJvVIKLBV4izQ4MsbEKfKpGDgXiTH8Q8fw?=
 =?us-ascii?Q?+mul84X+bKoGbV2kn+ovI4XnqSAjTiEVLWIFIj77g2w0cmxOIhSCqhz6UDuG?=
 =?us-ascii?Q?65k3vbAxOA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cae548-b31c-428e-b06c-08da45024c52
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 01:42:20.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fA598tK2ceNIuu8fwpX/lyQm5EBbrCbF1aTB3ec73S+rK9Ofln4a3NC/i9lj+VdY+Mz3QPmCs4j+o99Z4DxUDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1530
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-03_01:2022-06-02,2022-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=909
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030006
X-Proofpoint-ORIG-GUID: Xxiy_UhsRucIDV1JYFaYIA2OM5Fk0cd1
X-Proofpoint-GUID: Xxiy_UhsRucIDV1JYFaYIA2OM5Fk0cd1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Patch 1/3 brings the check for the rdonly to a new function
btrfs_fs_is_rdonly().

Patch 2/3 wraps the check for BTRFS_FS_OPEN flag into
btrfs_fs_state_is_open_rw().

Patch 3/3 removes the rdonly part from the BTRFS_FS_OPEN flag is true
for both rdonly and rw.


Anand Jain (3):
  btrfs: wrap rdonly check into btrfs_fs_is_rdonly
  btrfs: wrap check for BTRFS_FS_OPEN flag into function
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

