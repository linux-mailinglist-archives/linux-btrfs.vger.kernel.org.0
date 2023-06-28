Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B97374108A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjF1L4o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:56:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16062 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231743AbjF1L43 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:56:29 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTIHs000329
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=h/3HEakBzR70sryMW7AeFxAQbOP0v9OkGG9Wo0pJLB4=;
 b=yiTQiGSdCMPGlr7RbPYHeOu11gMAknCH0bDj5oxF/nP82gbUjOa+LXbuW2law6evO2od
 TJdW4FkXiPKQHW9HncS+i37gNagDsOTgBVUBuJWfJj5pGbCFVCQk/qp9jcEBM7PnPJqi
 /+1HcC6XsF73OLPofK029tyDJnZQG8hEmhNh2QE6lIjXK68Y7txsRXWZx7UlMugKAjIW
 3bl6Xvy/Ed6clFOfQGkmCjjXOr1a4JkN6Oc0NWyAwf1i5sHzHtsoVqeHggLAL3W/GvfM
 gv79DLYkjhDtMCQoijHK5xdyVE4MRBdz9fmTuppUumE16P+T1CqyODpP0ScpjBOMjmKV Zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30ydrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SB4NXA038183
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxcdmth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRrucL9VwtGmo/YpLCe7GnPplry7qBv1VF2jOcXaLWlA5l8dUIbB+UNsopsCy/kypshCmDbHiciHtZ65agFRNxiPYLLu7iriEq0D6o2EV3MLIpJU0nIrJYHN+Zu9gAhzr+pgjRxWmOMmmYgmQ442pxOgAp66ItuzCtkjnu+Zwtjm2WsSvu0RvhSJR1A9kKp8UbpCsGh/j5mboNxJNISNBnhPT/O5P5M/WdI5ZrgN0MSDW2jyMQGOgHQ0B68zG6VlqViK0qNoyQRbbWAm0pmw475DM/J0TB8xVy8FS4jXlx+KExhxxyLXp4bsRsZeYjX5+Y4QdJRGCwCL9ZoNzeosaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/3HEakBzR70sryMW7AeFxAQbOP0v9OkGG9Wo0pJLB4=;
 b=Aybhny7iG23VJ0lZy8HlfZSCAJg6UPt9tnoiYgVG03pR03MEixIU5S1UFweuwpvcP+rL/QKHdqVLsKbWnyOF/UyAN2lM9SYdXG/6B73NakV8TxOS6yS4ftUDoO7UlVdyIRyZyDX87oSdhIhv9p/El5KmmevlQxSa6W9s4J8bHaIOnUI2AUSkB+On84NCgdjfQiJbWRk0BCihZSm1KKrwSIx7gyJY5ZbyhhcSKFKB40O/XM+BclbtLOIsGvG3WJPZKzGOuKcCpspalNy486gDZuimFtCSSKbkXvA6dbaE+UHscYIewhED80yuiSqTcYFkFdPqQvnoC0r6HLqIudnSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/3HEakBzR70sryMW7AeFxAQbOP0v9OkGG9Wo0pJLB4=;
 b=fDQlSiFwUYp92Uk+4UOJnyvproqBqn7ZG2d+R3D/c/kO2QRnqFrgKN1C1Ztpf0PFr7gb7HYaG7REr7fz2wcg063zz08mZBCYY+04Ea4WMonWmcr1O0z/aFHw7H+LPN050f6P+9WRmtTXiMAGBYZAnmwBYaMdRaCbS/tdFYx/LT0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:56:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:56:25 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/10] btrfs-progs: check and tune: add device and noscan options
Date:   Wed, 28 Jun 2023 19:56:07 +0800
Message-Id: <cover.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6bb010-18b4-4b21-6f39-08db77ceb2e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lg33nHCBhf9wUp9swM8GMRaXYEfQZByYDOlcOarPUgkfGDUWKynY50KlDkuuC443vAptDdT4LoBAv5VBYwxtjF3aAKY2eE4BmSNKbeAiWh8JunXZn2DcZ1JNwH0ShFMDuuXUrZQ5cgmRJ6UKxSenTQr5NgR/04VyCyW3adTZIh5RddRppbWkNqKusSupN7H9LSO4o+97OuRWaboY7/lN3UcCxlZorzzpz4hmukBVygPnzdV9cJgUM9hU2O0AfNRVmQjFUWIqFp63saW9+WKoy+H81wPWLNJw1fQiu9aNZ/TnM72tAm7BzGW8VLnPv1vyFhXCE6Py2NijzkgtlLlQ+TWJwPZlrUVlkYipcEBf+mON55Q8w33i7RcJK3LvQLP23gfs/OrpYHsmDTWkqphP+4ptDnXhqNCn3YQFCeiZ0cbTfBoNAFrmaNNFtuyNGtUmVvVa1NaMi8yKxM580M3OTsSowqUW4StlS/fkR4BZmkSCTEhqKMtD8Pc5zkolDdP9Kha8Y7MypyvOdx0QOiEeGIe3hv/69Ky66O9ftFIVv32O0KYY3BT6y0O1XZ7zf2Nz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(6916009)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(6512007)(26005)(2906002)(83380400001)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d0bPxFrhoiUTeGuv89zO9q3v/1nPmlbsD3/4yLbGoPXRde4DjmZ77+T/1RnK?=
 =?us-ascii?Q?nrbUTeLa+Zy5/SGYBvfTjsnZR6Zc6nhGuSamP0t3YwyShcdaxDQKBFeRZ1iW?=
 =?us-ascii?Q?T6TnQPpM4KQgDgpQB+z7mYBeZsCK4DXbxU0IlMRxgMbhe2KkWcK8VorNfQkk?=
 =?us-ascii?Q?ssS4J0dgghO4h3Y8O5eGb/mt0pNNIraUR2xmA1Hq5DsF20A6+LvmrirhMO54?=
 =?us-ascii?Q?N3frfL+KmeXi4ZPHjSiFl6wj2DpFVYd6hl+JsIHdLCzRjY3JbyCVe1x7FTuI?=
 =?us-ascii?Q?vjQ68omH6uw1JTn9cOG4sgXBVLam67Wjy2pkqWZ6mEMAirfDS5qL3blL+gK2?=
 =?us-ascii?Q?bwBb6tBYwuqcF9Xm3r2FbjZi5pPxaHSfjVv86PtXxR4Boc3rEALBQvEbVxGS?=
 =?us-ascii?Q?W8wP+eMzPAAfEGtI/jdzMe373N/bFdMIM/X3yzW3D4e2FF4BEEvH0rdDKHZD?=
 =?us-ascii?Q?fcYU0JQzmO97tAHQPYAM3gA+TjmRlvzniTjdCFA/jTjIMdwsPDhBDCJigwzR?=
 =?us-ascii?Q?e0fhiVJhMRka2i7E3TQQH1HEs3BDwvUeIjOFkrn3X7wpda3Y8BoCrvOEevbk?=
 =?us-ascii?Q?E47qb5Nzo9qC50QiXpO/bRbspB2k9g1GHcTizn0JigDv0Lpk1jVwE9qlNXqW?=
 =?us-ascii?Q?l44WQAxDDwy2pMKKBcEsBmW1mRBNdMJoPj1s18/XBFfOVtmIiwobctP7ZlKH?=
 =?us-ascii?Q?v/FQxs417z3Y3L5tZJSPFJwh0rhvuYHFjwKS4pQgwK9mcr+gM36xhlbjwcJp?=
 =?us-ascii?Q?4lXhwPhwNOYewr8CEeYPttcivAfWblqDdmu9Ji4nE3VVi9V0W0ByL/itEsHp?=
 =?us-ascii?Q?bXA4BRro+jurI2PH2jFh6XVsovzuN9f1c1xM9oobjZsAEkSo5PfDyacYDOD4?=
 =?us-ascii?Q?gUKrN/kV5nQdlMQsg/Rf5eFs397oXtm5Iqr79EgKFO8xx9vES8VaDAQa1knN?=
 =?us-ascii?Q?suiyJl129QJp+wg6Aw64NBXcUUv9buOnyd8wejkeB/05R3lFNHwTMLeWPpvW?=
 =?us-ascii?Q?ynGLhOJ8CWkK7hK7JGySeI2uBZ6gMtmrIrRyoGauirpdg/prJZtWYO1KAC5A?=
 =?us-ascii?Q?zABHVoZRvQ259pLC1Hr477pNBon2mUBeu7SgdCrspXTxa6mY+M9raytbViy1?=
 =?us-ascii?Q?B8j+ZWcAabMQtPMUVtYlDuPppBDCoicrnkd9N94YYPo7K4waGL6ilFWtbpFO?=
 =?us-ascii?Q?uRMyTjnpCieaTKAbPoDFY1tC5kqfmkxpShBG44nQOuVGRCqK+vMdouO+IJKZ?=
 =?us-ascii?Q?sPVCQM4Ty8b7On2aBU4Z6Q/lDIlh45agqLofuboEKH106jorTHUV6s+JewrR?=
 =?us-ascii?Q?tEljZpBb4SCWOHp0+zGOHsQwkykXVcSrKner445fuVstm2TUACxJ5qCeITap?=
 =?us-ascii?Q?ZwIeXGM3vgkLbMTWmqUn+e45abdG3KoJ5wy2ppLYpwbwlzSGfHzc1vkr0IUh?=
 =?us-ascii?Q?7pOU3A49KeNCupEOoX6+6Mq+MkL9dkUUESXRdzC+B2ksZDirlJHVBoy+ayJz?=
 =?us-ascii?Q?kXQ/nohX7rjWBH0tnDksSQnmAjy1Z5fQ/cgctc8vA3NLSc4UBUL86rysNIik?=
 =?us-ascii?Q?XoZSZKNTzXk7tAukh6K3mP7omMImhUCT2KUbndkp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7RTDFP8uTmiF1nDWm1slBmDNgiwZDM8E3rxMPdmFTUdT+CAgD2SG0vy2sqLVPqvgJUiDyuSCCKVZOaO4GVWtFsffGdfbr2Xb/dNEf+mYh2yjDLrr5paN4tcNPlvSH2HY0nSL2krA20l2yfSIpAhlFiC7ljVS/GNDioG0k04XJ7J+n0E0CFtNp/o/ocbVrtoyNJ7AuONUU2v2ao3rYB3t7xCyCkCqHYxLUc03K3ygYMJKBLQLT8FDpXQAmsbxBv3ONe6zWh+sfgz92l8BhesxGYHKB2j0fWhuXnIZrbnEtR/wEzXYH6A8XbAvx1htSunGI7jQOHFyBWo+GuvMwnu8qaAc8UAzTVnkt0wQzb9WW3ySyAj66TKIwvJFBPU22xkVWTh/VDxCnIJRtRfYKN3KUCftOadqsgVaPQDKBhdHGpQxOPJAv2XGrgA2mKj1NV+X4eFMrxlDqwngrfwziEVUOsODPNOtXIXotdbfQkCeks9E0zEr6xqj8K3K2cz9hEq5e9YbwZGPyjJtkxnyJBJbgiFm2fY6pUcuJPgNsh0ISuqPRkAXhgi4Sj3/sVFMBWj7vYJ2ftVovsic8u1Pd3KHWj9vjkMllt9g3ug3IQzy7QMR+FBMtJNu/5I9ItL7Bp4PaQE0wn0fncfKv74SS/u4xXdeyVIKpV/OIlA2qJQf0Sh912wySzeLIhFiH5dcJ0MQfQ8+TPolJiHSwgw+/xIdE2AYiHADiRueLzf+SxazuKxrvFKEIlOdA7yHy2t9PUCTwyRvvCbX/0Dt0unmSCdxPw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6bb010-18b4-4b21-6f39-08db77ceb2e3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:56:25.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzZvsJOhvk/VNiFfOOhky5wxigdbN4ZRzPCkt69v+Zv5JWV92zHNZY37lqcsyoe1a29T5Grh5HOqGWWZefpkwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=551 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280105
X-Proofpoint-ORIG-GUID: m4AsGWGFj0ARpcfAchN87Y9Sv2KIrA_z
X-Proofpoint-GUID: m4AsGWGFj0ARpcfAchN87Y9Sv2KIrA_z
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

By default, btrfstune and btrfs check scans all and only the block devices
in the system.

To scan regular files without mapping them to a loop device, adds the
--device option.

To indicate not to scan the system for other devices, adds the --noscan
option.

For example:

  The command below will scan both regular files and the devices
  provided in the --device option, along with the system block devices.

        btrfstune -m --device /tdev/td1,/tdev/td2 /tdev/td3
  or
        btrfs check --device /tdev/td1 --device /tdev/td2 /tdev/td3

  In some cases, if you need to avoid the default system scan for the
  block device, you can use the --noscan option.

        btrfstune -m --noscan --device /tdev/td1,/tdev/td2 /tdev/td3

        btrfs check --noscan --device /tdev/td1,/tdev/td2 /tdev/td3

 This patch bundle depends on the preparatory patch bundle sent before:
    [PATCH 0/6 v3] btrfs-progs: cleanup and preparatory around device scan

 And, replaces [1] in the mailing list, as the --device option helper
 function is peeled and transformed into a common helper function
 in a separate patch.
    [1] [PATCH 0/4] btrfs-progs: tune: add --device and --noscan option

Anand Jain (10):
  btrfs-progs: common: add --device option helpers
  btrfs-progs: tune: consolidate return goto free-out
  btrfs-progs: tune: introduce --device option
  btrfs-progs: docs: update btrfstune --device option
  btrfs-progs: tune: introduce --noscan option
  btrfs-progs: docs: update btrfstune --noscan option
  btrfs-progs: check: introduce --device option
  btrfs-progs: docs: update btrfs check --device option
  btrfs-progs: check: introduce --noscan option
  btrfs-progs: docs: update btrfs check --noscan option

 Documentation/btrfs-check.rst |  6 +++
 Documentation/btrfstune.rst   |  7 ++++
 check/main.c                  | 45 +++++++++++++++++++++-
 common/device-scan.c          | 32 ++++++++++++++++
 common/device-scan.h          |  2 +
 tune/main.c                   | 71 ++++++++++++++++++++++++++++-------
 6 files changed, 148 insertions(+), 15 deletions(-)

-- 
2.31.1

