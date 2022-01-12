Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B260248BE05
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 06:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiALFG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 00:06:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29220 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231239AbiALFG0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 00:06:26 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20C3j9es019186;
        Wed, 12 Jan 2022 05:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=9+Md1eTgcCSGl9RZ7MDLILY0U2JyEJCl0c4JJvvBxtA=;
 b=oQWo1N4K+oW7mqlQQ7qNi01zQHChu1F/pTerjHHXMtxfp7oWoyBvfigxzwX3TmeHLWsA
 9Pc+GnS6v6e2c1bORytPAZ9+LuGMvimnaohptjiZVMVFWRkQReMWtQasmaxIFp9+98Cb
 0bM+Y4BfsI4qT8cVJHjyQKnTjVykLtC4yrXR82NfW+zI5ccdHUD0AJOfOuoutL5nqaGR
 wBhjFG4YFg0eGjbEkgC1khCpbHa+rWpurdiDjIRZHbDbqRuWatxkqymstPd+a/L8nc3A
 D/daQ1/FS3LCJGqPEazMgJ4aa7S1w6P5M6WE6NS65DEoRtaaRPA/Y19yhTNdpSn3pvW0 rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nmy3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:06:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20C50VWs155969;
        Wed, 12 Jan 2022 05:06:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3030.oracle.com with ESMTP id 3df0neyncp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 05:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsOq9NAGhYIHLFkaxFnksyJMZEuLJKHm10fgWu1KmxF9NiVIIuFeadxY0BFDovJxQHxqjr7cDiOdQ4U3FBQa/M9Mpmdw+A+XDrUoWxO5Q+3/xFDJ44/qnLYRTdnbfPDSL9nl5r/BEYPUFWnuxKuevEOGAALr5EnjbHD4sx6LKMzdWKDXQra83emw39mbfu0KwsuGNdjC15A+F9Zm2KYi4tzTfkvQfgTkp11Y+hs1Wmc5dAXV++2uUkfyvglNHcn1zNXrwGTGbFVw2/GEGiU9cqJ6+/YQgakkNDYXGoEsgr4SEZG/4CEx8br4njOJJi+dRwhpdkNy6w5WxkfnbWwTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+Md1eTgcCSGl9RZ7MDLILY0U2JyEJCl0c4JJvvBxtA=;
 b=ex2eC+YNgDc3vBAT/GfFLF/qxbUGmA8MJOhnu8711UdoUS0wW4EhSOYieq8BLZ7cDcH7rntZCAtHabhlRpc5nKAa9jdfshrAUbEXYqOjUH96D26Hu2/jvSl+0+rZT97D4VASNI6BUeYiya5xe5TiireeMwjznngfZXBRR36BbRZoMTlA6NBZIrHGH+wkE9HExMbjtizb3CX21YYj3hoXPIvDoxrQjT0YpXlPsWMyZZXaPW8rf/q0OQzT48EssFopH7BpsOrPNWSsteSoN+Nh2iphyg8f+CMTyqj6hEYjCGC1m/Pf+G1Qj0MvTkPJ0D6Iq+Z190YoA61uDExhwl8Otw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+Md1eTgcCSGl9RZ7MDLILY0U2JyEJCl0c4JJvvBxtA=;
 b=IYg72NzDrfyrTtB2c4cAptQntMlo6qhdEYhuM02YtH/SOWyq/bsa6sIimj0iCxUkFWNVALVrmEMPmf3Y2IzO0/km7nfKdeJ+5D/VFSv3hKERBUvM9mP757hTuLqsYvITyq9pi2OxoKBOgapjrlocwSdO3nxWzVC2VeueU20ycBw=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3904.namprd10.prod.outlook.com (2603:10b6:208:1bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 05:06:13 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 05:06:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su, kreijack@libero.it
Subject: [PATCH v5 0/4] btrfs: match device by dev_t
Date:   Wed, 12 Jan 2022 13:05:58 +0800
Message-Id: <cover.1641963296.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0160.apcprd06.prod.outlook.com
 (2603:1096:1:1e::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 022ec332-ac87-4670-c079-08d9d589411f
X-MS-TrafficTypeDiagnostic: MN2PR10MB3904:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB390452DBE64748AC48A5888AE5529@MN2PR10MB3904.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPex0WGB2BQ3U16zzGBxFc8Rc2yKQ5q0CP+SL9xcN2RC/PXDAVb460vdahopoY4DOD77VhlHC2tvZrDBYrUb/G8B1Lsl2NUJQtR9NqTdcaozef+6DJ2+h20Gz5eXDsn/FmTu5lgvjdDVKE8ej01kZTHAhAfQE1OPGBWKrpY+4SA6mp0k4mmkcWv9rOUgMIjHjDv7NdFchupt+tHOrDpPe8Q+6cngM/HTlAjlo6dB3oUeDBlyZwaJvGVH22vNx9N8wP7SDKRN4k25Z5ICpVirqwWHgP9XR4hZZmtQMSPmEKDbCIkMd5aR231VwcGXpANaQp8VpUOXm30IV6dkc80KS4kC0Q66fFr8tK4q4BMh3q/9J9l3aIihr+61ZjNpe7tclWK7ozutUdE1yyUFRvyQ9MkYGe+sKxJMU/QTieskGFucoz6Q/Bk24x/Ubawo4ILqYqy8LZsu+M64je3enK9tvGZkjBfdukwzlfb1ov19103dqhzsigcBhosTos4Cm9f2yy/BFvGujSL2r53EI9pOSV2MgZlAnQPxn0eSdagScC9QwREmFIeUycpb0GXncLjUhJZEe33NzO5A9YpPR0LRDcHXljryRdcKkx6Eq4ZwCQ/mLYSm5D+n4J3bGAnPYO3VGkkWXYU/yuYyye0eXLFBVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(44832011)(86362001)(83380400001)(36756003)(6506007)(5660300002)(508600001)(4326008)(6916009)(8676002)(316002)(6666004)(2616005)(6486002)(66556008)(66476007)(186003)(6512007)(8936002)(2906002)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0B8Y4BF1+k/ktniTE5qZq+ZeD/yteyiQsudYkCG61PBzz3tHrec7ZjLOYRx?=
 =?us-ascii?Q?XZvpKFkN8g9GegfbRdw7CTWRiR0lTGfptgUb8ydr+lHIY45gDP1gwszSKKf0?=
 =?us-ascii?Q?BtNiQSUTHNmJuSb5O/BKLpYURiDGVZNSnLB915P/Nm37cfLzveOusSCPfg91?=
 =?us-ascii?Q?ZW8pvwZQmxwmmUli2Q1fcNPBQ168TkxI1NudTJl/94llAmOHXzp0cV8a+s3i?=
 =?us-ascii?Q?0l1xouZgF63LZ4eSLm7Bo0iuJ7lVdB0rW2SfQGvCdpljS3qpvTEm7v7Npqjg?=
 =?us-ascii?Q?MG/OD6pwKPTY5MN3wzxRngz7lcLiy3GC+0iRXsGhxLrs9kJ38gBtDAiKiYU+?=
 =?us-ascii?Q?SABy6+2RGH1GXNFVlx3QHy30BGu2ODSdo7vcujGX0eSsV6ju/U55SXOULlyv?=
 =?us-ascii?Q?wxzzonedEwTw5VcgZL/2QhQYzr/eRAUsGL1zH9DtRlG1ZHVxdMMGuoORO8vn?=
 =?us-ascii?Q?Ao+/yQxHBb4BNsgfqRj5LY6Ni9rNd2JgJZQ/FpZZgOVXiho0Eq+ui1Ms+sjr?=
 =?us-ascii?Q?9ioa+/aFtuGxFKslIrcwIAZxX2tVs4Jt153bdgPQTTnfami8z3HEoC41pP0A?=
 =?us-ascii?Q?nPsMnwAtnmj156y0TAjtJUJLvxvqVW+xFD5+rmG4OZ7WsKA63TSTXNqsun8E?=
 =?us-ascii?Q?Kj/27puOGv+EnMBzvl0L9ym1EfDxj87SS2HVJ1jrk9LY0znehPlaLBKV2kcn?=
 =?us-ascii?Q?LBbw1CWd3rRLXqtfAOOm6M4XMI1EGYtwePABRJJgecF2qzPl2rLkul1dGxB2?=
 =?us-ascii?Q?YCe7M/SymI55J8pTflHTlq+ogplymYZf5ty68JViP0clF6AXWTUErbt+jvG8?=
 =?us-ascii?Q?brR7JiHvg0CGu7IR5PzQJAvP75iBCyNAIjf27IiNtSttJqVOiJmjn1nS9sks?=
 =?us-ascii?Q?lEVruHlbgCPxnlwiK5S/S0aOTzTcKGRTQrnnP9DMFjpnhMYdADrVnuff7fcA?=
 =?us-ascii?Q?gm3rwrP7ajimSTD6EDX1hbj6hmuSohngj9K1fCMV5Gxd5CxUgsH6Xur/VQ5l?=
 =?us-ascii?Q?0vSSx0qCrm8I/XOCPQZ0LUKnW0p3ULArOP+6rfgTAVsB0MFpDlMqlHJiGKCy?=
 =?us-ascii?Q?8Dc9oDH2mkXNP9OPCMo3B+zkXNZUfULQ8jR8/i0lYpeNcKBPzaB0O0rBNA4v?=
 =?us-ascii?Q?OWN77Jjq38tFGvdFhiSxjcfXKVtCzNWuRGEzVw8/pJXe8EA3zVeLBuyvNZsw?=
 =?us-ascii?Q?XjHhGKVfB4XZ+/m8C171O58wjqEw8/FCqXupzdIt1Sn99N761RkhXBpQTMJj?=
 =?us-ascii?Q?GlyLIGneJEsGjloFdOynnc38BkDDjGmNGcLkAtPACIkezSuBf0vqTHjUaseg?=
 =?us-ascii?Q?N8LfSmdEG868y/A+c1za/dDGcNwSyWihkedy7etD3PluvkSROVWF5hTMdNw8?=
 =?us-ascii?Q?4umHVxR1nYMJ8mTUM/dEW18y8PAFfx2HFrY9guY2eXpTEeMOo6M75fIng8IE?=
 =?us-ascii?Q?1GE4V1MVhhTC+6qjV0vNoiHpzx4suJy42i55fhhxnq+mYs6ZMiYpEQqfgom1?=
 =?us-ascii?Q?GjHYIeEoMfSNAe6cF1SIvojNwsz++6Af6D2dyw2Rwt2QOHaFYIcDN2Vpjaqy?=
 =?us-ascii?Q?B92tyxSjlqpw4rXMH//G/tUxzglTb6h2Fe6GTeH6hI+2aWpm7wbHXHGVPy6T?=
 =?us-ascii?Q?tUfJNLnGhxgvB8PfHwiWgjg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022ec332-ac87-4670-c079-08d9d589411f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 05:06:13.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnVtPIeJ1S1zdmMkg4B4pX5oaOpWzYEHXe4+AVBvnXgPCIAqdCa+OLDbya4uQ05P7g4NyBTCLdr8uCv53YK1WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3904
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120028
X-Proofpoint-GUID: fqb4esf_cQyy8GZTi4mrFBcBGYKU3Gr7
X-Proofpoint-ORIG-GUID: fqb4esf_cQyy8GZTi4mrFBcBGYKU3Gr7
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v5: Patch 1/4 device_matched() to return bool; absorb errors in it to false.
     Move if (!device->name) into device_matched().
    Patch 2/4 fix the commit title and add a comment.
    Patch 3/4 add more comment about btrfs_device::devt.
    
v4: Return 1 for device matched in device_matched()
    Use scnprintf() instead of sprintf() in device_matched()
    Change log updated drop commit id
    Use str[0] instead of strlen()
    Change logic from !lookup_bdev() to lookup_bdev == 0

v3: Added patch 3/4 saves and uses dev_t in btrfs_device and
    thus patch 4/4 removes the function device_matched().
    fstests btrfs passed with no new regressions.

v2: Fix 
     sparse: warning: incorrect type in argument 1 (different address spaces)
     For using device->name->str

    Fix Josef suggestion to pass dev_t instead of device-path in the
     patch 2/2.

--- original cover letter -----
Patch 1 is the actual bug fix and should go to stable 5.4 as well.
On 5.4 patch1 conflicts (outside of the changes in the patch),
so not yet marked for the stable.

Patch 2 simplifies calling lookup_bdev() in the device_matched()
by moving the same to the parent function two levels up.

Patch 2 is not merged with 1 because to keep the patch 1 changes local
to a function so that it can be easily backported to 5.4 and 5.10.

We should save the dev_t in struct btrfs_device with that may be
we could clean up a few more things, including fixing the below sparse
warning.

  sparse: sparse: incorrect type in argument 1 (different address spaces)

For using without rcu:

  error = lookup_bdev(device->name->str, &dev_old); 


Anand Jain (4):
  btrfs: harden identification of the stale device
  btrfs: redeclare btrfs_free_stale_devices arg1 to dev_t
  btrfs: add device major-minor info in the struct btrfs_device
  btrfs: use dev_t to match device in device_matched

 fs/btrfs/dev-replace.c |  3 ++
 fs/btrfs/super.c       |  8 ++++-
 fs/btrfs/volumes.c     | 67 +++++++++++++++++-------------------------
 fs/btrfs/volumes.h     |  7 ++++-
 4 files changed, 43 insertions(+), 42 deletions(-)

-- 
2.33.1

