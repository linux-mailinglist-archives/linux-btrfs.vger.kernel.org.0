Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E9370F5D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjEXMDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 08:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjEXMDK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 08:03:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A583184
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 05:03:08 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OBx8re011508
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=yypMh8UhEvP1WXS1zrPB3mn6+UsQ9v7be9xO8MxhBGs=;
 b=jLdGR9gHTdTXR5MkVK0oRdHdSWjl5pZHY96QVBNk7JOrim+MnJbMR+hWdGDyrzpfILeT
 2pWmD57s2lkZ5jRe4VurhZRDANr0LUV4pwEIQ3QUAB8PDeZHQLnoPslmxfabbSOlyPkS
 qWSFXoVCqPuFV7DF8iNG42ODiyGkJuuXJQu4Rn5uZSfYsNlbB2tFu13YtFrejyj4dKYU
 KGyhh2t+chlMmQScX08FZoETEZM0aiNnpx0ULPkcXWb8AO5R7tCccvdHeXtdfgLOizvP
 7zNnuctLU87ig2tjENnHb3lzfU37TXKEwZWzdhk30IXOgbWgX9nRksfLrp8MZ+VCxFFv +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsj2bg0mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OA5293028577
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2scyu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz+8APyEGlYwz+0Z5G4yZNWogr4q9jA2CHlNLxX7PMcHQufE8XLr3a2yOBDbOpB9ahHzg58yRsfITiHC8IMVSZQFo3OXqIb2gMgpkvzzSi3tXmxhWv9gEMXRG1jxCBkN5X5bZa0iLwBOoUGvIwFM9LVaxuM6x8E8OG0fNK2uaDvYl/BpOrZPWO4jUOT+i72sb5l6Ocg+9HL+3QDua5Ese+TT3U8JPfOXJqEGwmM2a/PiSlZsUusIPu2OsyKEA/C4sOzrFTQXArPPNv9K4OcaoLBpC66tBCcMrZQVj12I9lKFu0sfqG4Pz37z0S7ul13Ggu6ZDl3qlfSShDQ00Ci/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yypMh8UhEvP1WXS1zrPB3mn6+UsQ9v7be9xO8MxhBGs=;
 b=Na+MLp02Cwq8mGxmlr5HrsqIG3WGk1rJ9lgZmcY0t39T/+UgwDQzUc+ZB503WqeIjb5DvBMDlsjX3fsHTJ7ak2Ey+z3UEXSrTQj9lmwE4o3FUYiLEu4dB+m7PaqaA05qIOv4j8lR3ZopG4AOmadQibeuXW1sXM5RfXkYpa9Rokrai/Ry+GNAVhDMjGsnt2ZuulaCcnaohZ9X8HhO9EtNYz2f7WxFlazxi6N2GfLsMoCwl16R0lI1z1sdA7ZGv3RTJTsgElZQhzq7ryz/3KBOGo4gbAIXnSnzfVBLRcJwbIBpYsT9ghIYwbKwm24mr3me7vdIBfL8tp7xy/YA5Iglnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yypMh8UhEvP1WXS1zrPB3mn6+UsQ9v7be9xO8MxhBGs=;
 b=elI9KHhGIjXCx3Iiha7OU61WUo0PYZLTM+vSsl9EC3gotpdnw6GNfG3COl7ahoKvnw7YLK61ixX50hA5uN5YQpVxsS81Hj8EjrNhE3M4pVF4KmqxNxH8JYRAQ0QR3tnza2rMmOVlUdj+jagaDBcbzlbMrsIvPXQK+pIm6QyxPSY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 12:03:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 12:03:04 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 0/9] btrfs: metadata_uuid refactors part1
Date:   Wed, 24 May 2023 20:02:34 +0800
Message-Id: <cover.1684928629.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b13498-b3a8-49e4-1300-08db5c4ed433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qmh7vRKVw1BS1I3qZIUL8gZ5AKi7QkbmjW2U9/5e09Yk2kakP67XEDmcNDKxL+0dNKueqsTrI9UvDD6fVW52uZjgKBPTkviBU6XBFHWOd6nWVJ/8EI4NtPiNHxsSUPZ6DsXPMrLuPQwY+ekyxxkR/FLGAFHqa+XDH3UEALJ6OVINHvfy2PxcRUq/ok87XaVO5cx/LRP+s+1ebfwUaTJFU+aHUYjJS/UbSYm3zhJXKMO5CkiY/9sUCTN3SiIH3L6TdZQyLsNiKKI8HQ4CUH3WK5p7qgOgLu+86Vqo4fwdnHoq454plGx85Lwg2Eny7KkhI5mb96aMA7dBxJ3nFmVF62zALpJreM0LNYYq+z7Ei08UG9ARkN19d+ZNK4GpcwBVZM1LWr8TEqiMgxKvJp0WPVd3gC0jGQ2ho0LdCrwYEYPgnjzWrEWw9XL48OYD8Ga9MklxuWovlv82r8AHMz8LRRUbPVBYtBRUw7NYldvG9FYu70u+qyfx6Byt6KeYXvItwA9PXIJpzHY32Cp6aKd+5YS76LYMDtv3PVRUc9FZmDEXvCSO0k24YbWeCy3uC2Mb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(41300700001)(6486002)(6666004)(316002)(8676002)(8936002)(186003)(36756003)(38100700002)(26005)(6506007)(6512007)(107886003)(44832011)(5660300002)(2906002)(2616005)(66476007)(66946007)(66556008)(6916009)(478600001)(4326008)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GVMihSYZ6NWUdCoE2WYL8RP8BHSiJBByCZ2J8xV0yuG7SceKukyjkeDsedty?=
 =?us-ascii?Q?muTAXJ05e2p5Ty2f+zBlwPsvDZSFg6Rzu1J1W4vv486PWTSut5lGpAlXWQZH?=
 =?us-ascii?Q?1nM3bDC0GaTaX51kFwmjGpg2dfzPCtT3tjoUa2hBYFUEMO2n9WyXCguay6ha?=
 =?us-ascii?Q?E+ZdNYwtl6LywBi7M2bfUaJiC6LsVAQrB/hNWAD+Ray5F7wQVwS1Omu+Dbr3?=
 =?us-ascii?Q?LEBg7Yrwyiee3GhNCL9pWaFX/PumTqsJ2daPCE3b+AOt76Mek6+eZZERXMtP?=
 =?us-ascii?Q?AyoE2I8g1avqgYCPHY/UZetBUPvj6teBsR3b3yGKXZVO1+/r0FG9AhkOU3n6?=
 =?us-ascii?Q?aZPVGn3LepfHBWGj3QLnJpltNQVovF4tVEOJSU6oU0Si1K/DsUhRIS+TIzn1?=
 =?us-ascii?Q?CRbpHt8VB5D62Uzgo9nKixRW1ObFsoB9xAKVNih98UB+IbXmvMp3zV5ZlqNL?=
 =?us-ascii?Q?kX03wXOf/bfcge18jqXklxTO5thuL7z8IkhV1LU5VU/B0fFCsA+MKvSEIe3G?=
 =?us-ascii?Q?jfS0sZ/agM7+0OIqB8JLiVBDlshvwSGGd7GAggjfDMjQVctB91iMiAaLiZx3?=
 =?us-ascii?Q?mMM4dXZRFJZuO6wz11SOcVluRavKswO0GAgILAd00vLbKbCe7gzmRFDaLcCd?=
 =?us-ascii?Q?KaIcLisTGWGcsPy2Go1SwNOKllrjkw3US/16UXTPwknIoca+MopJjvLm51A1?=
 =?us-ascii?Q?vJfbj2eB3cRfxXtqL2OfC68BwxGPuzCQW6eDQcikr9inBLmtxTnH0+T9ikHP?=
 =?us-ascii?Q?myP+Cd+l58/ZTAp4Ht7P4pUMkE91U8YTwN5brN0fn9SNhQmxvRQ7dh0s/JVy?=
 =?us-ascii?Q?7Jsvy4OA96cV+EaKi3MSRBKqhHSj0syYIX0HzxiNvJWgGtNWo3DC52/sHY3g?=
 =?us-ascii?Q?1auLV0r0oaU8FXW6o3IrDvX5fzHqetmuCcymW1rtYFXPNZEFH5LO+yXXgdXA?=
 =?us-ascii?Q?hb9BoD0bTyfrae/cX/4Lqt02ihOQechmfOSI+UZJYPa6wz9E9gEQ74WJ8t9O?=
 =?us-ascii?Q?xVFz95dDTBkKsu2togxwy0i4ZClxmTnYpOFQGdTh8EtqrTvaqDs+sGRf4KsQ?=
 =?us-ascii?Q?pmByRBRPUHRTAoWv4li1wuwAAcuU4cYVLRW0k0Kr0cCZ7t/npoqi5AtRZcXH?=
 =?us-ascii?Q?XVGHaDpGF/FAz9h/by3zyN1/dOPXs1SchcCAhisV0cb1dJbvMkFa+eVNkf2v?=
 =?us-ascii?Q?+mKTlJ5mzWRW237ilaOyMaxgZzC7f1d9bR0ZhjHJ/PwIuMfB+ENYG6ZZtXpG?=
 =?us-ascii?Q?1j2JN+ISnuP3VQjZb9Eh5WkUPb2Io+phcz57BgcsNP53AYuEFxZZltscBgMQ?=
 =?us-ascii?Q?sTWel5vPeUt28oYPHT8IOsr4FfbTdM/91iG1lsMweH6wIvIaSkoEedAGTIlz?=
 =?us-ascii?Q?Utj35+arXC86E0FtC2FkqcfN42au1nc+exHP1opaRVjXPwRi1TyDnXrzQsUz?=
 =?us-ascii?Q?8U3+qXdArEgos8YoqnP+xrz0debd6s3XJHcKjRT0HcTUC6iDSifQTYwtaN2W?=
 =?us-ascii?Q?J/CiotuGeXW4xdmARbp9vcp4CYH8calP3TovOZv/nRSF74zLFB+JMSNhs5V7?=
 =?us-ascii?Q?0uVtyPc7GQgqUPGoUr+rlfDk6nrPPx/8/nshrTAa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qioZ1IcAfUiTOsyLtGMfLdREO+EoYqogyUDREpAwhj6x3JWmv+1qLWrpUoCUe+cnIaKAanP/XmzE5Kq4NSkiP/9OYaNqLjzYQ9trBa0RPHj2spbbhnCiQNccwDvWPdnUB9K3xHDdR33p1/HZUppo2YP6SPSN1W/mf2Dv+kVZ0lTIh1D2frvBpL2evrOymV3GwRzDsMg8vaIdNLIKRQapr29svfSxsc7hWgSgWPcDFzntWvaMrLMSsxKU0JVavWo++42NMRX5htKtAPnDSn8bCnx6PNw3lrAu5IwMncgTl6AfslLwdO1Pj2CoxjhNz1DFI0grnyd8HFTRiqls0tyzbITj0pEf/+utCEEOYLVFcuNw7jjl1D3kTqaUaZtUfn/LNS4r2FFpe7HNJcdBgyG7hHn2XNPKMdzYqKruBEqDMhbSslmJtfLG+PWTLZCIlDWiSl88LT9SN2kDom1FroqCM24AK4tU/q6d7Tj2xJlPB5kEOTTe/O560LKlgTfa7QNJvg0hzTYmyTqkGjo54nB6yp8bKF2UG24cwAoL55Z5BeTdFMgUGmBSyZdYpYXbTkRM10ot7GemJKhwfR1ug+z9y4O3757uZ1/YdLtitCsqA/C4VKt1RabuBqHyqD2ITvBTdxCSk7w/M0/XQyLvJW5qif4WUapIrEvORW2Srr9u3smcbyFDRg01Pnq/d2om6RsGcQz45kT3K9pVObVbRWCDxq2+K4JnzgzG0zyEteOmMxccvXzyU3ch72bUGofwhAvY0DAz51k9UBgfxgMn+Ux2Xw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b13498-b3a8-49e4-1300-08db5c4ed433
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:03:04.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/M3Sz22YafyOqWPQM4vtlH59kp8Pd8FEdxbCqLyxCluJmaiarWOFfPlpKy4yg+R6IrpXRYnY60CmScDuVC3LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=920 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240101
X-Proofpoint-GUID: VOMRKKOED-njT_eIIg4x04lAkFusz-cR
X-Proofpoint-ORIG-GUID: VOMRKKOED-njT_eIIg4x04lAkFusz-cR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2: Addressed the review comments received on some patches. Please refer
    to the individual patches for more details.

The metadata_uuid feature added later has significantly impacted code
readability due to the numerous conditions that need to be checked.

This patch set aims to improve code organization and prepares for
streamlining of the metadata_uuid checks and some simple fixes.

Anand Jain (9):
  btrfs: reduce struct btrfs_fs_devices size relocate fsid_change
  btrfs: streamline fsid checks in alloc_fs_devices
  btrfs: localise has_metadata_uuid check in alloc_fs_devices args
  btrfs: add comment about metadata_uuid in btrfs_fs_devices
  btrfs: simplify check_tree_block_fsid return arg to bool
  btrfs: refactor with match_fsid_fs_devices helper
  btrfs: refactor with match_fsid_changed helper
  btrfs: consolidate uuid memcmp in btrfs_validate_super
  btrfs: add and fix comments in btrfs_fs_devices

 fs/btrfs/disk-io.c |  24 +++++-----
 fs/btrfs/volumes.c | 110 +++++++++++++++++++++++++--------------------
 fs/btrfs/volumes.h |  37 ++++++++++-----
 3 files changed, 99 insertions(+), 72 deletions(-)

-- 
2.38.1

