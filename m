Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C317767871
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jul 2023 00:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjG1WYI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 18:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjG1WYH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 18:24:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5173448C
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 15:24:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SLiPOA025465;
        Fri, 28 Jul 2023 22:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ztHD+/+jRxj8468t/NYWE72fHPCZF4WKiJL36nqR2HI=;
 b=MUwe4Tyipsq9W2pc6QXCUB/CSkQpfkSJ4n6cG5MmGw/yBZVJCuwDoOQW0Ylz9OjMCuV0
 jlZq9krHklYjwByqw02U2g0Ixb6mTf9aS48cZi/Ay5Ex9B3TrEWqTSNgLrEyvtHXlhij
 UxBwkhVTZh1FfdEHcjFPclnfpU+y4e6bRw9yzF42lRIEc5FxWqkgcj3WxRQrBBV1A5qW
 3xvE2VjYczKxPzzEkEo799g3gR/IQ/jQgNscYn2oGmWO/aSXsw7AqiiGm82bKo+3j6ch
 +/lAGBPMInX8CNYURM5hNdyQZ/LgFdcuukd3n0I726iWN2ld42yjYTN1gDxnlaXIx1+v 9g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05he4s03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 22:24:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SLqTAu011796;
        Fri, 28 Jul 2023 22:23:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9xqvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 22:23:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azlo1Pi9Q+CbGiQOVUDgs6dOPQy/TmkkPAhDLZyWnHfQlmE2yfvoCnsQHqL7E3T9G26n4bniaLjLmt3O5QPVFyusMENWXEKKuqXYj6CT1IC4LTNuR57XdqVHAiQX05eNqHNvqt8mBL6SGdvq7NJH4XuAorhlIGwIBWJJoKxEd9zDqIyRpPJPum/EN/y8xl6plEzViXcqmHtub+n4Xa0n1/uZk7mDkTojeMiW57LPPcEAKEtrUicG/W6OeM6UAVKkNSIRLX4VCVvtOxhje6PFNpIwD8omb3PttQoL3CqNvLK/CvoQTTY6NvWAosrTvlmjuLWLDj59xEBEkoVmoJy2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztHD+/+jRxj8468t/NYWE72fHPCZF4WKiJL36nqR2HI=;
 b=ARoyuxtCJElOgA3WXxsK4N8B5VkXvmVCqVdRVyNOMkfw4Jfm6IRxF1Yg7yRjuEflUUQi9Xhe5+SimfkK0ABEE62bmEeMD87eaoC6zYq4+Ayzxy+C1EkhT9R/XfGDPiO1P4KyRx4mNhuoPV2NdtmhfpY2qXhUMzl/tofywcFamBHNmrM6tCEMV38NsN3AZ6L7BdNFMfkHVJMkaOWi5/A7KqGa2m6MASlBjNc0fCIZ5W2iAA5MlY8C2Z9sxwqQ6aVHCV8QZgIAWjTl/nr3yWR3tXFb6JBuguh0wiE1pjz2rl38IE+dEbdZ234GonCg8+doMx3so5F15Byt4v9ZKpJJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztHD+/+jRxj8468t/NYWE72fHPCZF4WKiJL36nqR2HI=;
 b=WSJRQoonxD+IlzgIpQaJzj+f2NFm99/RM/422dSFrL1DnQpL8hNOG0Xstw3Bg0jXbuu7ddRVkAs3lq+90+9mLjeW9ugGHwWc4R+t2NWDip8vaHWX1pxm+LeHQUdHRX/2h1cBfX6fXiuJF3UndzN8vNEOZ+Lk5oKIFUnjUzydJhM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5672.namprd10.prod.outlook.com (2603:10b6:a03:3ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 22:23:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 22:23:46 +0000
Message-ID: <8507d459-ecbd-b123-d8ae-233d2efa3ccc@oracle.com>
Date:   Sat, 29 Jul 2023 06:23:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] btrfs: simplify memcpy for either metadata_uuid or
 fsid.
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690541079.git.anand.jain@oracle.com>
 <ae10e7c26537465368445d379c660fc8be62ad8b.1690541079.git.anand.jain@oracle.com>
 <CAL3q7H6nGQWdvpNr6GUC_4eGpveH5ttdqn78XXFw0Ux-A+7MLg@mail.gmail.com>
 <20230728183907.GK17922@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230728183907.GK17922@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c349653-07ee-4016-c4d3-08db8fb94ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lk48nkw4/8gKNhMKz3lVCn4XJp3eaBLyscOcXEtc9k/nhTl4P0e+k5AjBdAhyDN3kh6DzFbi8rLTDDgHMCIdGKTNJApFfDnP6K420wOE6m5Lzw1p5qRqgos3Y284rJXjlxJz4ofUtHIKOZ1aOUAchLFTTsK9qZbbz5E2B9h2/q4/SX1H5+ctU9juTGivyEOxB0pq5tmcHvOMijc0vPAdVozTeIl5d9lhx7eXNS8BdLwmkkmdaQEsnBunqeAfymsYoTnpZa4vHQFEP6y8SdWz4M2k1LvmnWgVefrKNjn2k1PPRcC7XAKxhfJR2GN6Xc4B/PruMyw+N7yskbZ0hNPn9hlId5RWqgDBmPlqNz/05ZS4KBh+AR/6qc/L25hfZcZzaQLPQO9dgXIiVgiJRele4vfjtaA5atCYePT1dPR7rk2YdCnwFrTGMj+jf9q2XsacxOON2q213RkQy5vISPJeaasjl7XS9kHLCT0pWoUSA6DiKUpvlZvMH8AieJwJ3CPSgji0XBKwOG7im40oRmvTAbsWvCs34xZVJPIUObTwbcWYlUwoJaL+y50pFnlpiSWKYZZyLFZrDfMBNbYIkzUrcAxHVBC4MEux/CRCZZN6uy/a9rzEuJ+3gReZ1xm8lF1OzB3LL0MuMeCKHfGWtPRyAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199021)(83380400001)(31686004)(31696002)(2616005)(5660300002)(6506007)(53546011)(8936002)(86362001)(44832011)(478600001)(6512007)(6666004)(6486002)(6916009)(316002)(8676002)(66556008)(66946007)(66476007)(4326008)(41300700001)(186003)(2906002)(26005)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2R2VmxOalBzSHRBLzNqbVdpUU5QZGlhWi9xZVgyaFJBMlFid1ZsVkRJaHJP?=
 =?utf-8?B?OUdVWnMwYTRsZ2s2QW0wSGZkdWhqRXBBMUJrS1lITVo1MFBQVExDNjJDUnJm?=
 =?utf-8?B?Nkp6QTdmNXRmV0picWcySUUvR2p5WkNFZlZha0ZFSkRXOWlOY0R6bXp3WXNj?=
 =?utf-8?B?MlIrMUlnaHBvZkpHaURicjBXencxTlU4a041ZUIrajVsSWFoejFPZkhGaFdv?=
 =?utf-8?B?c296OThYV0MvVlJ4MGhxM0hCU01LM0hDOWVyOUhlbzlZT1JkNWNkdmFvaU8r?=
 =?utf-8?B?Q1VvTXZCM1Y4SGFEemZYL0NiMCsvOHluMUdwLzFSQXJOMXJOYlArNFVabDFv?=
 =?utf-8?B?TlZ2MS8zYUZXMzhUZ0pZMUVpcDIzQlBlKzYvSFEreTE1ZEdzRmlQa3NYMnZ2?=
 =?utf-8?B?N2p2T3NQay8yUDVxeTJCRVJXVGYxZ2RtRTlNaXJWQzZRcFhoMi9VZkdWZi9l?=
 =?utf-8?B?ZkxtNDBOOFp4bmVqbVJJdmo4d1l0N3pTQVJMa3JtelVORjUxOTJVT0IxMVgv?=
 =?utf-8?B?WG5WK1VqY3ZnTjM0Z3p4OVFXSlBHK2lKbHBzazAvajlCb3c2TWZiMU9wVnhU?=
 =?utf-8?B?YU9PRVl3K0UrcHFzNjJMZHE0M2Y5V1h5QnlINGc4SG1TRnRKSTV2cXIzclR2?=
 =?utf-8?B?L0x2dWMzOG9pMTJhaU9RdHBVVVM3TUNDYkR2d0tJWk9FelN4SmxoWldjNDJY?=
 =?utf-8?B?NTFiUGpGV3pCWmp2MnpyRGpoK21TOTY1ZFBlakpRWGpuYTloVWJGclJGcUVt?=
 =?utf-8?B?U1RzY0xkKy9sU3hVWXQzdXAyUG51RUNBRHZVdi8zR2JYZnZJd0wrWHpVRDZC?=
 =?utf-8?B?ekpmVyswcHBFNXovUTYwUm5YcjNIT1hwMHJFRE1xU3p2dms2d3htdlJwSlBr?=
 =?utf-8?B?TWFZME53VzA4ZVcrWGxVZS8vOTJ6OWM1K0dqaytyWnI4NERxajhsZ2pKK1Nj?=
 =?utf-8?B?MlJaMVUwMUh1alBWaWVZL3diMlVUQ1ZQSm5qQUx3dVg3a2lJc1VwTnBPRHIy?=
 =?utf-8?B?YjVWTVd3SDIrWWRFTkxCMUZoK3ZQSWcvZW9UU053RkdKWGVuQU9YYVJsU0hi?=
 =?utf-8?B?b3JZc3E3N1JDVDRDVHBWV3R5eXVxUlJpUVFpOTVPMUxDQVhURXFBcWE0Uzl4?=
 =?utf-8?B?aGhFY0JrUDRiaHluTTZ2SzVLb0UwRktUaXVRY1p2Z1dqUTVzY2ZvUHZaOFk5?=
 =?utf-8?B?NW9wSC94K1J6UU9sdWx4VEM4ZG9GQmNIRm5kYjVkL1dMdEZJMkRIc0YrRGZz?=
 =?utf-8?B?ZkdScmROeGtLcHNqVlJ3cXNSNEcyaHUyam5LSkNMelRxUHpsOW5wYU8yaERD?=
 =?utf-8?B?NE92dXZRVC92OWdWZU1VaVYzRmFPUHhpMVNFMi9YRkxHZC9hMGZiUFpXdzBP?=
 =?utf-8?B?YnBNYXYvbmQ2RUdJeXJFM3RRaTNlTlRMWkQvTDVqell6M201UDNIaTVIeEYz?=
 =?utf-8?B?bGZSTVl2NTJxU0pOWUlsV284R3FOajlqdWNFU0RhVURnZzVnam00dllOckxD?=
 =?utf-8?B?ZXlMK25pak1ycW94RGZ3aFBQeXN5VDVFV1UzY0VET2wrc2JIYWsvaVFCeGZ0?=
 =?utf-8?B?VUdMTEV2UDU3dStPYmxQTlFzdEV3eEc5d0RidUdNbUdSUW8wenlUTE45N3VJ?=
 =?utf-8?B?SzJncnA4V3JiZDNJbFBoRVVDcWlGaktrcnZWL0YvT21yZ1RwNzc3TWJ5bk1s?=
 =?utf-8?B?NnIxSGlXYXhhalduNnBPQW9qSmovUU43L0RSZnlzZUhwKytXcnVYQWtibDRW?=
 =?utf-8?B?M0dvaW0vYUwzZEJXaGhHRm5NdDVsMWxzVi9SZXhWcWZFeGZEZHd1T0I4RTVD?=
 =?utf-8?B?MS9JZXFYenpQMjVTNjVMZ0Y2MXcwdi85UGhSS3pCOVBkYzZIQ0FhdUl2VFRN?=
 =?utf-8?B?RVBLaEZUYlpxVDdCdXJHMEN6a0sybEJia1hxOWFydUVuZCtCbWZDOGZXQnJF?=
 =?utf-8?B?cGJvUTJ1L0lNWkFVRUZyanNPMllhTmUzMlgvaXBLV2I1T051bmFUbFVSSmtv?=
 =?utf-8?B?cFZ0Q1ljT1JPYXh4TDIxdmthNWJSWm5JZ0pOY3NpanpoS3VTVHoweC9mMzVm?=
 =?utf-8?B?S1pJR3YxTENtdlRwejI1K2NRUVUrVG9SZ1J0N1lZY1k0bHJ3SXI1Y3B1MVFR?=
 =?utf-8?Q?gvk5RS6BzmkX2NMlxuUP02qbS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wZr9XfiEEFw2qWA1YydA6+Zk1a6YIGR6+wfmcW1nODvj2rK7ZPqDkoocuDAgS7uSVyxMPsqflUJtnfawrbiaYkJJ04BPn5JRUuCotNZ2EcWC8RiMdaFsvlUTXuiKfiNtX/hKreSvv4db55UgmfETB0dQgOOAvhzgZzMHA+Iu8+htfrnH6aM3kVL6QitNICJkXdS8tLPudyK4fo7x64OkuH3hAUr5kB660m2+jlgrTL/Qtn1b0TbKloXjFV8X7+KZm90Nss+TkuU/XRWfLwC2iTB2Lf8PhavUJieDWXpXMUMNiTZ97Zqg2eXwUrr6GoWoGeVSmsIRQQQKWF5EUgGThE0VU6xXYucvxZOllF0tKGfEHemlnrSeXrwDomF7dWt8w9uAsEIpRaG9zG4OzWCjcW6j+mA4w8cE3s522Nq/NzBO0TUMuzWEuJWhRhx4ecmgGazZcQVz3NROutXqNHGHtEfa93O+tJUbSFPeG/unapV1+4ALKRTWAmB4mB2J+myjJaK/Rn+hnnevzIAcCN4D5arqTsJFPJ0EU698C+vR0cXh7yy/9p/LkSy8XS61GkEqVWpJWC9DfmF7bP6jtkg/UpeYOeece/vLeofAWokuWe2rfgtIvV/LQnGpsoRz53IZGk4uSW5QHeH06gLdUL9YZCXFy1n8U5Ahylh1hGIYHnovsgRS82ym1avp4ru9NvdNOTyik7TsFVnglnjROyIojOPTHNCCqxFkI8F3wVTKp2kZZpeKfcI3QDeE/1QBnWKfv4oGN07lPNPKydlcnooTvyKmcgPCVhK+1dU8XCE7TKO3xomRwUrcfasRl5jpkNJK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c349653-07ee-4016-c4d3-08db8fb94ee8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 22:23:45.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRW2xKD6svxNIRFkOde+Czfi9tHr5lv8EBcXkkBVQ5g0zqW2sLtxAvWNZ+RPHpr/HTWrKGNcCQ5lB9J5QXFqGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280205
X-Proofpoint-ORIG-GUID: RD_v8XKz4YZgUtvNE_tXYMhqnB8kAHhs
X-Proofpoint-GUID: RD_v8XKz4YZgUtvNE_tXYMhqnB8kAHhs
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29/07/2023 02:39, David Sterba wrote:
> On Fri, Jul 28, 2023 at 06:40:39PM +0100, Filipe Manana wrote:
>> On Fri, Jul 28, 2023 at 5:43 PM Anand Jain <anand.jain@oracle.com> wrote:
>>>
>>> This change makes the code more readable.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/volumes.c | 12 ++++--------
>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 5678ca9b6281..4ce6c63ab868 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -833,14 +833,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>>                      found_transid > fs_devices->latest_generation) {
>>>                          memcpy(fs_devices->fsid, disk_super->fsid,
>>>                                          BTRFS_FSID_SIZE);
>>> -
>>> -                       if (has_metadata_uuid)
>>> -                               memcpy(fs_devices->metadata_uuid,
>>> -                                      disk_super->metadata_uuid,
>>> -                                      BTRFS_FSID_SIZE);
>>> -                       else
>>> -                               memcpy(fs_devices->metadata_uuid,
>>> -                                      disk_super->fsid, BTRFS_FSID_SIZE);
>>> +                       memcpy(fs_devices->metadata_uuid,
>>> +                              has_metadata_uuid ?
>>> +                               disk_super->metadata_uuid : disk_super->fsid,
>>> +                              BTRFS_FSID_SIZE);
>>
>> While there's less lines of code, I don't find having a long ternary
>> operation in the middle of a function call, split in two lines, more
>> readable than the existing if-else statement, quite the contrary.
> 
> Agreed, one line of code doing one thing is readable.

My POV was one memcpy() per destination argument makes it better
summarized at the function level. Anyway, I am okay with dropping
this patch.

Thanks.
