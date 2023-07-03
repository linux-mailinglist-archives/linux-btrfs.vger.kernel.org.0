Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8440A74568B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGCH4D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGCH4C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:56:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA73FA6
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:56:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3637ihHq026548
        for <linux-btrfs@vger.kernel.org>; Mon, 3 Jul 2023 07:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=ht+Ju1NUbENnyx/B4QCw31Qk7Iqy9SZySJvcT3jwGsE=;
 b=YHu7uS/WhbScIQQnqQQbW0NiSTmy0QhLGHr5oi1Y/m+5xQ+zasac7edLjdR1xlFj2DJs
 kf3lWpQ/q8OkrTDPr5TYGYsoZiv1GFi/atjyrvBDkceTYdpNFdLZPsVNHvLkw9ClUyLr
 0M20PHFFKlnDIc6MLiFpY8fzqoF4Mw4658edWpmaaXxkK+4SbGGEw7o8TgZiBSAa/mld
 niOK/KaciBR9ftXpPjtewFX87/mposVgTa2EWlJ1e6lBqcOHUfz+9K5YPCouDtjEfS3d
 +OnTp+90bRDj06+Wh5WfkIW/CVWWlXsjyFvU1gI/D5Hli1e3MKiZRal7nsX6cWP0dH34 Sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjar1a3f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:56:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3636KKJg040544
        for <linux-btrfs@vger.kernel.org>; Mon, 3 Jul 2023 07:56:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8r49q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMTjmSSHhAqKF2hclnv71CecnlWgBVSeRf981aCLiU/Pb/DTYQOlkhjyM5RaVyyqA4uQ78mhoe5R3k+gcFjCNCicsgITAhi8R11JbLkYZbdj6Zo73Td4vZrfGAMZT/CMj8PhkuxfVhUVm0ytY3epXBHE/vxx4cZhm/ZSLF5ZhptqDdma6BkTftWe2ej5YJZXQHU3rkjCwxXHdz73V2j9Yhg3ZvmVHd7cNNSUW0SCDGpXvas0PDil6TKL6GBvf03NbmHO73o68Sch7Db553gbHpXhMqDg+Tlt0TEBy5oyyxFU2P/Q8XxTzVPCzQMc+F3ZB6Dku2nlXjfT04dd4yBHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ht+Ju1NUbENnyx/B4QCw31Qk7Iqy9SZySJvcT3jwGsE=;
 b=bAEL8qNYC+ymDSUr5GH7y4F4mF6CG052/pImF1NflVunKzEo67Y/TXS0QTLsnPDA6jpXqpOXZVp4mcfrEI+NxuWDKSa4U5lqQot0TKz5nmDfcWmIbAEFFUWUJWFe/+9RNbRHcsnqQwvO0DlSZeLTRXww6+BtWWHTgcEx1uKQ/o8127kqIGYJHy/NO/AherLtBM0+ug67EuzfKQ+GrnZmD8Ud/XGX6O+pVeZEZCjIH257VQlVtTHLhqit6nSqcsdEfnUoH5CGyLcYZZpuU7t6bWO923Ozdh72XwHXfbQTIm54Rxn95kn+qX0YFDudZlvMmX9O3jh9EDZYBcvb4ojgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ht+Ju1NUbENnyx/B4QCw31Qk7Iqy9SZySJvcT3jwGsE=;
 b=w9QGFlxjgVRhNGjBVYlePgQtD2O9amOzZlYqZe4aN7+qSOe9AqJxrhH7QEarQWCZKRw05DlbODaYWAqHgiByv5ZUfMAGGtqh1FdYo6nG+OK0pcZFCFKHZM+QZlSqP+gTUXDFa9GqXb7ObzOTrAVOOucIwH8QBBIX/na0joaTnlY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5243.namprd10.prod.outlook.com (2603:10b6:610:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 07:55:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 07:55:58 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/2] btrfs-progs: print device list volumes-c api
Date:   Mon,  3 Jul 2023 15:55:42 +0800
Message-Id: <45dde58845e0e034ba0fed5ab84c4aae8b7a84f0.1688367941.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1688367941.git.anand.jain@oracle.com>
References: <cover.1688367941.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: b203470e-8731-47c2-4ef1-08db7b9aef8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qErTVgutPxPYXhE1dT+MI8rHnzXHTesLvwjWq9N0Cod3ZFDoKvgDz2SyRCqh9qIZr9M1tn5XLgQUD42KUB4BXYUXID5DTkGPSrlJp34bi2oOnBbbnAFq4DmXuOHbXZX1J5c+vyMbpchP3o6QCLuJ1mgEeA/WfbEYaDZrgHd0WncY2se0pIPohUQhn5BDQ5fHOYqgZ+ZHaP6VlBHTRuFGZLX/U4TOUx7GESj8QgC0h5sqbhXpJfMK/0KL6/+UCZyQ8hCV/v1Ns1aiSwW5mkRd/ktoCVdeVJlBruAC0BkKXZUDoGK+8NVlKWiBfMRN7SOgSOPqfYn9/AGtKuroUHALSalNMhCpHn2Q7S6bFmQrLxpCZXZjv5Ve4lxoZ6e7w6S+lBjbLgQglZeOuT4wpWjU/IPRTyIaco/qqn/mLCnyE8+z2Fftf5M0z8h6HJw2ycNyJmrmhM4b3edVmKqAJZ9+HCpn4PGCGfVEBAlnRFN6//jM/DWSQ5ABK7MrdP7t2bpOFGvWxnRnJ0RRRXvmwRc//C4SOLlmRXmSKfRDkyTOY8nRH+Zr3VABGCrf4cN8fY4t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(26005)(478600001)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38100700002)(6916009)(66556008)(66946007)(66476007)(83380400001)(6486002)(316002)(5660300002)(8936002)(8676002)(44832011)(4744005)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r/3wW4QdB0up6truCeMD3KuDIUfMvBB6BoJbWD3TofKGSivyZVPKxnaKwRDD?=
 =?us-ascii?Q?P8qv5VXg2jTjvUd7vqQQTw3dzaBqxrnQSv3Zz9FqcSJgbw4UmWeGD80C3hKr?=
 =?us-ascii?Q?AZZe1ve6NewUnDcnANen/LJoqouBkzDAQrRnoBcRkdZfkr9tVJJ8t7iOXOVx?=
 =?us-ascii?Q?p0Zh75216ZQlhQmuPVRLVymivmRLvuhfPJJ6dfXpvrhWEFO0C5hCUN7K9uyB?=
 =?us-ascii?Q?v6j5Lbr14M5uEHcYoXQ5N7vikF+6LzntqKXg+Y6AhxbYus53Hi8GFcErzO8F?=
 =?us-ascii?Q?SSSS9Rj78j2i9e0kSdqa0GJpDMOJv0hxaYLtMETsJKuDuKdSruxx5naa7nsY?=
 =?us-ascii?Q?ByE4jWq/th0gD7FzqMXJrRQ2JDonm182IkO+UCku368Yr2lOti4uq+dypZrI?=
 =?us-ascii?Q?Z/ovqpl4VbhDmx1/PoSYD75Mnl5PEK632mx8t6GtcQxohx50HrUjWu0GoiSY?=
 =?us-ascii?Q?yx8sZiJy09gd9GzQQX5HAa9LcS8OYA05JYl3XMSzQ7Nx849Rh6U+UbZW5W0p?=
 =?us-ascii?Q?PZPPZqu0HzyzVwkkKBABrXp0PbkSWZ0Vbvpdpwjt3GtDB8y7uOA86vfygV7S?=
 =?us-ascii?Q?qX542dKS5tShHzk0vqRGyRbH1tIqlZSKHTi9A/wlyGDGGaAsMzvmPLEtv8wq?=
 =?us-ascii?Q?2u/nRFtSyZMhD/t3Q0CjHlogT4pPh+vRsC1Ubz8MYfrtnTWuBi46A3jZSrdr?=
 =?us-ascii?Q?gVGwUxWTnFj1toy9O4GTiLGNxP1+iywJWaEoDto/XBxnBquA32gTyTHAkHv3?=
 =?us-ascii?Q?f1x8hus8zhrZflVtlhJgdHH+OEfTMCKpSZrKk6Rynaj3vQKLp6Rvrj6xUczK?=
 =?us-ascii?Q?Tpdl41sAxDiPAGLhcgHwnKyplpJ2AlMxGq7gfKyIpNDFMYkYScatUNp+6wUQ?=
 =?us-ascii?Q?K2nbjsFeBLxXhPTXPP2oNPYHBwG4Xuw600m8U2oWYbjyLKybPCUj25VvClkH?=
 =?us-ascii?Q?dNu5YPPp0FPeY+xvO9USCLbvpOIYPjEbgd5j77YHKxscYiRxCQIUhliD13Ro?=
 =?us-ascii?Q?mBIQ9OWfoHf86ySqjqH/8QZIAtQFND32wYksECbecxBwttmajd7OEd2bHliC?=
 =?us-ascii?Q?a+ANV5hGahKI+fVfh1wq1Uq4CKk1UNyqCPZkbM4lxFXrE821PpHabkrrFhL9?=
 =?us-ascii?Q?SRLFwaA3M6Vj/mKi9O4zn35m6Q4ivEqNguQckkqbL1e9O59PlvYj7kmLPtvc?=
 =?us-ascii?Q?jVJmDSbDPzf6t599OJhjSTPRGoIxn5bXytakRQUQ/uorp9PwTM4+S/B+ojT0?=
 =?us-ascii?Q?A29y5QJy028+jTWWS+1shWYhCd1oWL0DDo9L5rD2KfFvufKe3QMvUKFvboTM?=
 =?us-ascii?Q?Ob9tXymppJFDDZFdhGJoWO0j10axyE84mN+4Kn7iCc/FwMh/eTkih2sQhMkL?=
 =?us-ascii?Q?RtdGQD/N+Nv5QXr2HZxZHkh1PJ8Fk/zuynE7yYZNyVkDuL0ETYAOmK5KqgWf?=
 =?us-ascii?Q?/vu6/X5KZ6XMCxI21tAyXzAiTwByK52s2R78qcYZCdtNUuV4uSg5NSPu+xQd?=
 =?us-ascii?Q?3R4rkc1NKTWGKdCgnHNRQ9K/pylSGBnvltGwa4gLNynlffgIIlBTQp+YCJ9M?=
 =?us-ascii?Q?ECeYt+qgdjtHOBNs3NgJYpuCNWO+h4yFPt68xNYM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EbqZPoW/1YQ2/j9Ku9qfPOHuRLjx6hmM7veHEFNuFFCEcjIwEMCaM2E2wdYB8YFErC8xmBVmuO1etRKm+2SOILyg9hBYA1G4ZWK3IcRpi1JRhF8u6S9rzdSFBhn793bvnvIbxKj7A8efiKekO1BYyZI13qBmpVJLvpokQc7LtmH8+gGQ2H/yKL1ZYR5Wj/ETh9Lu5i+fGf/V+GBFawE1FvJ+WgcwIWla5VNZvVZnq8ZCTseViW+SHYjbiUaO4USP0tXmFgd5IkcE6QdsvFxPvdQaivCFl6bEZdAJVrwFFjZpOIMr54VJSAliue91VHPItxXKhCznGMZmvPBd755ngwTJ9gIHXlEo/V5ZlRqNrRNoVWjeIgW8bVy5I+z9R68eFvU0ZilDJCmpA7qW0i6qo2sljZkIXlkBH6jlG20yKc4CY8r99a/SmcKl9o0apuaYMSUllcvnTR/MVHQ/mPEkZ5uiG/7XrLOD/j7mlHYhP+oTBGLKR2SOimpezwSU9iAZkBR69AxFZvVtvn5Q9ifv4LId24plxu0OG/3IOGhTrMzJmTVwpShIv8ZG01ZEcUTutmkL9AnNNZxFW+g0uEtq9KDrON/d+IR3gFJ7PR4MCcEs0O6vAgn6v1uVk7GBHLUIXQIvhBhI+YvoO/HQfHUPFOA/ta0E4VFoscQN57xas1opfgw4IY7uAm4eal1C9otG3xaEuRS9EYu7rxPR4ZL4bkpZ3+CEZSFySNX+pt0aLq6HmV11B8HpiJgydEKGpk+H
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b203470e-8731-47c2-4ef1-08db7b9aef8b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 07:55:58.0059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLJPNdcFatWA14O/Oz6vEUUqB/+ZPISwv+La3q3Q+OQlFD+FyHfMnd8lxJx9fuasTHKZw1HaTrAscOWmSqNEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030072
X-Proofpoint-ORIG-GUID: YxP7Td3cpWuuHvI1ztscrwm1OdKRQCkE
X-Proofpoint-GUID: YxP7Td3cpWuuHvI1ztscrwm1OdKRQCkE
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need fs_uuid to print the device list. Export it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 5 +++++
 kernel-shared/volumes.h | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 92282524867d..c6c71fd29215 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2939,3 +2939,8 @@ int btrfs_fix_device_and_super_size(struct btrfs_fs_info *fs_info)
 	}
 	return ret;
 }
+
+struct list_head * btrfs_get_fs_uuids(void)
+{
+	return &fs_uuids;
+}
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index ab5ac40269bb..2022ce37cf09 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -312,5 +312,5 @@ int btrfs_bg_type_to_nparity(u64 flags);
 int btrfs_bg_type_to_sub_stripes(u64 flags);
 u64 btrfs_bg_flags_for_device_num(int number);
 bool btrfs_bg_type_is_stripey(u64 flags);
-
+struct list_head * btrfs_get_fs_uuids(void);
 #endif
-- 
2.31.1

