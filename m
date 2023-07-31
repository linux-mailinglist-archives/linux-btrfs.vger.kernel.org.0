Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A0A76947B
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 13:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjGaLRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 07:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGaLRe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 07:17:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B2610C7
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 04:17:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VAiuvj031838
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=6cxiyly0CC8d+Otq155lBHz5SxIQO6+K0+pjthAcxvk=;
 b=YzKh/C9ZVuFgzKNuPSeeNOARgrTTsQY1aAngjv5MG9MDI2IOwR0CZ/4KdlDgizshloL9
 zWZnylkAxIWEmzt5XsxdnceXvqqf2nOQ+Vj28q/ZrONrm/exfsaXJ6DWK848RYuRnyVR
 91deCLVQZqGqa+SRJoZA0/5AG1xRkQHzxdtLu7N8DMtVuSeWy2BwywvNiCL6kZfEIURS
 TTyghT8PpnrCpauw6bjaB7dCNfQnuaCOZFY01odQ5TiM4KZJBL+d1zl9yV7ytxws9gmY
 1OGEViEE49UaDV1neRiXwOnHlJKyGDwdIlABFjgtBe6fspDt53Y2xGsux/rKDvQCMiJp tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc2bw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36V9NBnq033590
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74n1s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPR/sxDXmlEXn0yqTykA2veVnjsHiPCh0GamJlI48gNRxuDhe+vOzqyMKQveyucg96cpPhzgO7bil8XgNVzW8D3LV9ugKbvUFEXXWbnJWO48eshTqrNfjvDcbiJK/NAJaR6AC6twv2s44t/UysKI0gGmZg4jcLDJ1glfK/N3/lprA+XkbWTWp0zpDs2O3c/gKXZbJBPgxqhF8TGR7oFwatJ6IhOka/lhr1z0XMa8LyWtOfojMIRaUP1E1VIsrdJXlCCnUFQLj473ax9cFvcx/Lf6Mtil3S/urqPpHk1b7giJQJf6xy1kkYTfVVgEkyRtc+M1AQsNv3zfOYs7B7gtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cxiyly0CC8d+Otq155lBHz5SxIQO6+K0+pjthAcxvk=;
 b=F4eWFC3iScNsnQA0VLAV8Mxe7MUz1iHROz04Wk/3Z+wLPVAy53wVnnu/XTU7BpcXtT3iPGgfaaJ5iOb3H54+iuEfmgo3+zPDAdz2Hti0NJ6BzVP3rOT+TF0TmC2uNbxFYE8ZQ/sBvKTBRFc52CMibcspT6FVUix+aKyMeKCkwVy19rE9me0zZrNR4Vh2loYLdUEkMnKsQ2DtgvLDwA/H9lXa7R6oRCIcLGeDDFKQSZjFjXbs5KYJxBQ+xWUySHyEQijbI9ZoyzHxPVZU5axIsfqI3P+tWyFBtjgenKycf5S4GPBVdpQWwb0HrrHknn2vQQ+JRo1M/jnOH0g4xhh08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cxiyly0CC8d+Otq155lBHz5SxIQO6+K0+pjthAcxvk=;
 b=h4xaMkvFZd1n3y+5n/eaayKNCPD2+eZ4YBhEcmpmZLie0CPnoycE2FsdpSjEX7iG8jR9Ri1D1kryZknHNNumHB3y/qJl0zhuz7EQr6ecnFwEa/M2EIzV7gnZhf00xzTrum/3GtdI+76XjZuJXwHMKXPG+ZNvuxpFu4VsGHQ9atM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 11:17:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:17:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/7 v2]  metadata_uuid misc cleanup and fixes part2
Date:   Mon, 31 Jul 2023 19:16:31 +0800
Message-Id: <cover.1690792823.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a275756-7b98-49ca-273d-08db91b7ba68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROq4QJn0JzDeJqBYq+w4svfopkTVnqOF8hxAuh3v856OuXC3tBF6StVUm2Rrce+0jP+NIX+nkeksMeOoxxDwzJhT2CaOl/C0MaKyYPBav6kMDhCkbGNbhqxHVbUPKPGH19NO6IISf/jQUCwQHfR8VrGOA1Hx10nkGtXds28hdLNjbQmKx/ovfFZvrAnsRl1VNZOJ5KBD8fGolkvcmMNIm7iayQZgP/xUXk4NRaew/Fc5v5i/9Sp38PEnH2d+152kWTTvYPqcIab5gsgmMc4l2gimbOpmetT8E4OZR65r7GVhVaamQlpkMMjTDyp9j3cOy6XQBF+p9LyCUZi/VYNEXSWUwYKzmxEqX3fzWtfiV64anT3Wzjb1jj4CzVOCDd1cvr7DQwH9hg2HDbtMJStHmHsjnMCqmhy9ofFlSdaGf1wObUUgULPO4hnxALhK1JYna2aQ5qxbd0zrgZjTs0ka2YKDAwR6L9NIC2aa30sTuykLkQbEmZYHnntR7QXwG7eBhsR0pv1MaBbRaHGV0Expip8MfeW+DqFZQyryjUkWSzgeUB0FcHIrnlPxaruH8lZA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(107886003)(186003)(44832011)(66946007)(66556008)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TOwPG76ckpIjxN3+NvAQK3ry5TeDbTS+cO7U/lKoIhbLpQttriYAWTVBK42c?=
 =?us-ascii?Q?airXAmFDLULu+mmg+tN5Z7bMYSy1hNWcoHEK9ON6lQo7Qo7WM6ebEHIjBHmR?=
 =?us-ascii?Q?NTQ1r6nB5DWxY0pcrmgyB8mEEfMkhjfPyCOm4BPitJC2DQbyUct2uoQZwF7M?=
 =?us-ascii?Q?BUsYfSWR/LqP3ArSAOIoRoxEZBjusBm8aIJ9BlPPPSO16IZPOlbD6KSCqVLS?=
 =?us-ascii?Q?507wWPTJU9wdf8ywn2F56TUAutAdfpBMr5a+IxzemcydlvEpmdT3ohLxXeF9?=
 =?us-ascii?Q?gx7xbaPRxwBUE0RWkfK4kYLQVGvuoFp6F9Q882XbH8GdKpvjS/jCCUxl83EU?=
 =?us-ascii?Q?Clg0E80GYRP/2qFJJqlgy8XtIU2YjN6bY3kubgQRyPAOliyH5wK5rK1i4See?=
 =?us-ascii?Q?4moeYpmYIfJTwZRW3AxxcV4DG9z3y3GutT28/3vSz+41d0eGg/dSykHGCQV0?=
 =?us-ascii?Q?iP3jDm0BI7+rmRTG/PEOyvkyeB/HfIdCTUHWFyZpTAeEhZKswYVBtwaynecR?=
 =?us-ascii?Q?TLCN4JqOSDOC4xvMHa51k5BibUquMapQXCDEzFhTy1iAQ30BP9G4xhhW1YgM?=
 =?us-ascii?Q?PuFYnlT2/Jb7jSUTbuRIgtjzpO9pk1QOHp2t0CS1DkX90JYF5kDYbFly1WsV?=
 =?us-ascii?Q?TjXyFWwK/CA1E2nXsFuwbxQzAmcwPKSVOKpukF0sZPjWGxc5m3o80B8skaJM?=
 =?us-ascii?Q?+JcFqRBTDdxu132IvbluodkgVz7cK5/QgqVtcz2tS6D0hiL09+GypY8ThO9N?=
 =?us-ascii?Q?cZA7fpOtIU5dbFvc3Iud9k7AZKiEcDs8mRw2coicR3pE1yc5ylKS37HnmK3x?=
 =?us-ascii?Q?3FWcqMpJ2cE64Cbf0OQgqxD6EB+RFeNH0Zw0J3sUR5yZ96xDo2bzuhZarMJA?=
 =?us-ascii?Q?jEVOn8RwcehD6NfisFplg1VLDNwzQBUY02b7vmvhzFlcCsmPIykOAOcW0LnO?=
 =?us-ascii?Q?7TzCD1WMI4qt6ppgKhaZeN0SHEzGarPtL/j4hfts67IQHG7ZuPHdYNDERB1J?=
 =?us-ascii?Q?mAsAQEUIA0wvW9N1qCeNdGNaU12DOFEDGwx6ZoMQY6UkdiVwpEuBHdusapGz?=
 =?us-ascii?Q?3n+F/kMhtBQiu0iRaH9S4mthQTF56i/wZPpblun9JfcUag6c/R3eHJdw9G4Q?=
 =?us-ascii?Q?lWYlau9J8ZNRDh0oT6e3z/RRjueZJO7OXqR4XX/MKc8zvMzjznamU6vOqvEg?=
 =?us-ascii?Q?UMcxRLpj9oO5/1R42ACP+NIz+reMLwFzNSpSiiF4/ADFXeph4Spe1YIhaRGg?=
 =?us-ascii?Q?TO6xMbbqh9sfKPvuDBeDgwcVMVRZDb6rf/5WHMHxk8pRasqK5KlIY8sN0YBc?=
 =?us-ascii?Q?19uCdsiltBgGx322SsJX85e+RmY3dxNLq6NBYnAod9oAxJcD3BHQCefMdfti?=
 =?us-ascii?Q?nEsvkgXR99amfWZSRhd08DyVKeY6t7kNRX0p6EBD0SV1QGae0VGgWqu9zK4P?=
 =?us-ascii?Q?tZ4Jmm4W9jtGTN+65/j1r9gh5NGJJFMCGFGEhk88WPT7Pt8KzEcNL1q84kSO?=
 =?us-ascii?Q?DD16b6AcIkxZbdfkYapLykTIFxfdN7kZUk2fLak9FXAFLijBAgGFrBviK5Xn?=
 =?us-ascii?Q?n7g8B0pCEUJCzav5ELFinLmBSQH5QGE1lCKszbq+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OqPL2XmJ4junIS/r+jQYp3tjjGrzXYXwdWyLZIlYFf/q1aBJreV1fNgMJE1sY7mKzDacZ1rRW4yzZI8jMS5RfPsx/6v8/r6QEfsW4iGh05JrKSxThgS8Z+IMt/kv8StkD5NDn+LpHYAwjvQCK4yUEYEoDxCes3CMbZbOm6Yt+7P+cz9JE7LBlqNk7DlXRgFuUa7TukJIoeyyG45IXCkEmvqbz1YiEgdMLGMpzf7/t3ktAsybNLm+ISZ+9o3u4Xk9ly/k/+O1jDE+h5nOPOIHkRwUlphvqFQfZlzcdiFtUNWrj3h2fadtmLoevjqoAng34RYZaIvCpBi2Ao3R502gUYozdQ9nGTCgQWMtwMFTuYC6XUKj1qCsF5zG5h3lKDewAxle6zs1ABbsNw8rNoCThEBGyYaqpMGPoYm2sUGhLGXxalPXhHSsnUMIyixUGh4DqjK0P1CI/fZSKrCFV3rTiXmGY5msz3m9ndOE/I5jR3zlsEO/4qw4P/L6aLSKNkNm4GBi2f2AdVKMEy3qqOMME8jkzVuiurQ9Tg9dluUPBZQQmRyzKtxkQdUxCXb3hXBWbdQcRvki7HyUJB+C+r1gm2aBWt7Y6W7lTJuI9AtvFn/Ovc2Hnwh+KTihXeAdETp5eIFly5UH2GWknAXhbqre9mbdWLJtoRmq6hTpruVKZtHYwsw3YREjKEHQIj2VGkDrI7OrCuIMu1bXCaHTPepE8MzKLZssgK3CLbM5JYUc0oNlMHunDZPXCzl6WsZ2MvjKxAujJClJTjVEUQW/yTrDQg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a275756-7b98-49ca-273d-08db91b7ba68
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:17:29.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk3WYOU25XTYq3jPbQ/cLu0STMAp4vUYkjtXNs3QXMkWb0QKvPqEAisdA4pd1wAEidpiRN4poPu0g7w2zjL94A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_04,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=964 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310101
X-Proofpoint-ORIG-GUID: HPGuTJ0652SxwIwQK98F2dsHxiOnddBM
X-Proofpoint-GUID: HPGuTJ0652SxwIwQK98F2dsHxiOnddBM
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
The new patch 1/7 peels btrfs_sb_fsid_prt() helper function from 1/4 in v1,
This function is used in patch 2/7 and patch 4/7 in v2.

Patch 6/7, adds btrfs_sb_metadata_uuid_or_null() another helper func, used
in 7/7 in volumes.c. Further, used in the upcoming fsid_changing patch.
Pushing this set now which are ready. This has passed fstests -g quick.

----- original -----
These patches are cleanups related to metadata_uuid. Please ref to the
patch for details.

Anand Jain (7):
  btrfs: add a helper to read the superblock metadata_uuid
  btrfs: simplify memcpy either of metadata_uuid or fsid
  btrfs: fix fsid in btrfs_validate_super
  btrfs: fix metadata_uuid in btrfs_validate_super
  btrfs: drop redundant check to use fs_devices::metadata_uuid
  btrfs: add a superblock helper to read metadata_uuid or NULL
  btrfs: use btrfs_sb_metadata_uuid_or_null

 fs/btrfs/disk-io.c | 28 ++++++++++------------------
 fs/btrfs/volumes.c | 29 +++++++++++++++++++----------
 fs/btrfs/volumes.h |  1 +
 3 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.39.2

