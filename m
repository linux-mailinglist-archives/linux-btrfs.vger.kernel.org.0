Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06945229D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 04:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiEKCrT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 22:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241769AbiEKCd4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 22:33:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93467220B
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 19:33:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AKsKqP017478;
        Wed, 11 May 2022 02:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eDdkgsDiJUMT2Z0TDHuz8YR7DDULmweU1Y/VUGqmz4k=;
 b=0FMOZnjDJ2+CKJMSxKtpcZprMm/LubF7AKMulK2/u0pC9xb6cg5MS+bu4WNOncWOYLZd
 tcJgoT5/9S6AnmxBsDUHVHjAh5vrHa/L4YjwquvDc+psKjTS/HiMwdRxLi641RaVjaUb
 VlmDc8g2CvUmnOAD8s9liT0kB5rBdnoZFu0d6fkaa7MeW8EOHdeQN0w9VeWqgsRGLfpE
 4krn7Mcc1doTyw6+vYdIvdQd3aHtezFpkoo3R8Ybpm/nHxNFoqFSOoI77/2iwCbt5sku
 zEE7OuYSNHf+4wyVkauZ3ewCsq9F12QytMxhIQU2UdTGeT1FTBMWV/MQKazWcnF6Vse7 5A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9r38y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 02:33:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B2LeDZ015394;
        Wed, 11 May 2022 02:33:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73sann-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 02:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioYg7I7SZSQiIvmI/tyc2lRymB62bt8OuYNbPVvzCC+ap5YhpLwquThzWPg6GRlT+hsH4fUI6Hvcnt1bjcZhD47DCdjnb+VOFNdm3BP7TkebeOlWoCRh2r41rvKT2KDf/wMchbie7ZcfVu9j9ulWZ5iHxoKY/+PoS5kR2Vy6FzgiqUxdoQvCeMeF3j1+ggKenvq2KhPxlLbLFvs8GmtRqC4kLV3myY7nFSK3MCQN6A6qUwplPA12EpF1bzT/bbPTDcrYWCJhU8AoeESFUiw84gxOv/MGeV3qrQOhyqZY9QjoYVuHmB8pqzTZsUgmtaYl5FNHIYSqdpwPoGEcrTas/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDdkgsDiJUMT2Z0TDHuz8YR7DDULmweU1Y/VUGqmz4k=;
 b=mMzp04Zrr0LaIDKblBmmLMNUfYF8sg/oc5ayaZ7EtcCZ/SCqM3iULpRGaPiucCBzvxv4mI31bts5gq1dlUgFLp/G8Y9InAwQdlKJRkFf5HNiOa5/z0r0lauhTdol5d9LHHJHeCcznXLUOhdF9yQFRuAWIkWoTSRE4kHXyc5maIPMiXybd8dbC2vIZtdoNzZJODhy5KCjNA0CvRdaiTm7k5c8ioulC0lZv1TYLFC6PRg+4OlLubbhDTEp6t6pOdSBWneP8Tg6RY+IU8fg1qkqd/qZzWB+eegEQN1TbsrOgYsnq47rM8SPblSt6WprTGAD+LYhWRv9Jbms5+QWepyHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDdkgsDiJUMT2Z0TDHuz8YR7DDULmweU1Y/VUGqmz4k=;
 b=eYXSHdeD47Q1Z1lv0ctvirRLmznG1iBOWxahfsUWHLXPTVVWyWFXk/vO7aa+gZuvU9Mleym7YSMEW6xvKdBCfzylWJo6fkCnj54mVCHxkEDlt1HY1Bc7dTcYHiwfOE0uimWpAIzGZkMdo61rp7cu2zMK7rWpnjcyNNKqlofxrIU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 02:33:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%8]) with mapi id 15.20.5227.018; Wed, 11 May 2022
 02:33:45 +0000
Message-ID: <8e71e6f7-406a-12d5-a927-0eb8c96d0b82@oracle.com>
Date:   Wed, 11 May 2022 08:03:34 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: sysfs: export the balance paused state of
 exclusive operation
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220503153525.22045-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220503153525.22045-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4956cfeb-6717-4722-544e-08da32f6aaf1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5719:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5719F8A6347A4B6DF5734744E5C89@SJ0PR10MB5719.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bE92BjLill65kS1NEpdJ6L68Fu8LLfj8qTWYW8zVJTONbTjP/drItCKU9NJ5rfv1svgsRD69iMxad9LIXNKSpKZDC2Vo9/n2kRuHxITgtQItN/WbOv55JxW04FLhWuXt4ctAi9OmzHuzH6Vx2s0Vxy10tB0LWaUyY+7Zlp4XhfbNbBcK3A5tgls/btXufUJshOuU3wb/UCnlAhK1ndznAAwI/vMDIPh92zrS3lEzbCPl/3OCfsgRxcDt+XMWwUXtptw03Xf0em7qjC+U4WQc304/iC51NtlSW8s1aTiD1IJfUEGGdPqeP01VDUP9PeGXi23Por/gv5BFfMbe11v6p04Jftkw4FBCs9r9jRa4h26pRPgYFlYHtOxLkgqcA4h1K0pQ+eCyCECUb1QIUu6KDewgF9LAx0Jyb3rAE2w4sk91Yj8eKqR5f3MLWeU+iscv6uGjlUMlvWwxyNqXNIyj2lQHq1nHzGQ3bU6npj7IJ6wO9DtnnL6B+nwmohgmt8yF0KloT0B5uVwc8lY9LuAeLd4XfR+64wEoEA9nPvuRvByIt62+6+et/zkJAIymoVO84Zq3pSn3eLy8bnHgWeIb62V8A2NQlYJq5fCOhwRG5jJSdy6h0I9PywuQEp8fhRz38PBDgq+ZecEddU9wl4kQxivLOxMhRWTgNNtukJVKF13pCmdzpK8DrAh9nqeiGXWDG2Si3nJ/+IXsYO09bRk/gHtMeNBFJeEgnPq5bnauNzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(36756003)(4744005)(44832011)(31686004)(66556008)(8676002)(66476007)(316002)(8936002)(6486002)(5660300002)(2906002)(508600001)(6506007)(6666004)(38100700002)(53546011)(86362001)(31696002)(2616005)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUc3T1JxTS9GcFdBU2NxQ3k2ckJ1UUhHR1hZZlFoQTdkc3pQVzE0aGQ0YkVa?=
 =?utf-8?B?dm9hSXVWYWpJb2ZpOVhSdzVtVVN4Ykk0RHpETU9YczdjMy9IM1BsdnBDMUN0?=
 =?utf-8?B?NEdLdUNIUnA1RHNVVG5KL3hiQTh5cVJBajVtcDh3amhIMitDM0VUMVZCZGUx?=
 =?utf-8?B?R09LdC9zYWlnUzNUZ2M2T3pGNzhWY1NZemdIQnlzSUNzdVUzR1dGSDFxMkdi?=
 =?utf-8?B?dFFJWXRMVkFlclRRQ3gvN29QdFNDZDlqZlpxb25VdDZxTiswd09CdFFSUm41?=
 =?utf-8?B?YTNjYlQ3Y245L2lxOFllR3BIa3ZyVDlFSUUwdDlCbWlETE5tZW1tb0hjOThT?=
 =?utf-8?B?SG5BYWg4VWlBZVlQTUNxZkRiNXdQQ0oycGxJZG9SWGJjVnA4NnhmTGpmek1P?=
 =?utf-8?B?K1N4T2paMDFOQjlUYjdzelFsY2tVS0lFUzBlWk5PWS84R0VLb1JEc1BxK25P?=
 =?utf-8?B?eGlZUG44NDVuK0djWUlrWHBSbVc5WDl5UFAyTmhwa3hlSUVTeUlLOTVGTyti?=
 =?utf-8?B?S3k1TGZETmptaWIyaWkyV2dQMzBJWFRKSTY3SlUwb3dMaFJ3bTM2SjZZZlRG?=
 =?utf-8?B?L0tObG5BakZhOTRoS2hoWXYrVlU5ZC9MRVE0dDV5aWVkUEVuYVJtS0RDTHJS?=
 =?utf-8?B?eXJuRUJ6T3QyZ2VUU1kxNWUxRmJCZEZFNk1mNGcrcEdISDNwTGoyRUxOVGVB?=
 =?utf-8?B?M2g5c0tjZmZ2VkFYNmdRSWVnZkMzTkNFUUlZVmVDVU1qWmRSNEkwQTdIR2Yr?=
 =?utf-8?B?ZlhPdkpmKzFzQmN5clZtd0hiVGlSSU56M2c5aU9TUEw0VnZ0N0FEVncyNE9X?=
 =?utf-8?B?QTBEK1ZiUURZK3NkL2RjYkF4akVXVmQxNk5YTW5QdlFwakxHZHlJOUlvcFR0?=
 =?utf-8?B?azZBYlhRaWFrMXNZSEpNYkxqcDV2SU9vcUtvYmJ0TGc5RmVjWkZlSHFSc1pl?=
 =?utf-8?B?eU84MWV1dUtwR0x5a2hVb2VtQVNJQVFBYi9pNlNlMkRxWlN1OGVWTEhhd1hQ?=
 =?utf-8?B?WmQvMXQ1eURJRHdCMDMrQjVnL2oxOXdJRjYxeU1wOVZnaTZkUm8waDBFamZi?=
 =?utf-8?B?WE91U0dYRFF6V094RTJLclN3K0w1Z0greXUySjY5UW5TL2hGNWF3WTNsL3Ur?=
 =?utf-8?B?L2dOQ1hPSHBwRWFVaEdVdWFIRXpDMk15dXZNTXNjQXdDRVpmMllqUDlNWDVP?=
 =?utf-8?B?NkY4WXVrSlBTMGhUZGJvWnZSUE9Db2pYLytwUjRrMFBUWHJUZ2NTVkk3UGI4?=
 =?utf-8?B?dzZSNHFFaVlKOGdRdGxOdkV6clpvRnM5UFN5MUtlS2J2aGRpUEcvRHZEYnJ2?=
 =?utf-8?B?V1hjNWxpMEhMY2hJbmRSYUhtazIwQSthMlB4N21hN1J0R0htYmFRenB2RVJ3?=
 =?utf-8?B?d1MrVWZZQ0dBUlB6ZHZ6alI3enRaSlI1Y21RVUNQbWxuSC9KQWppTTUvMlla?=
 =?utf-8?B?dE9rUDNWaHBTa0VxM2QwRG1waDZ1SmdRSm9ZNjBBOGdWL3FNQk1ZSk10TGNQ?=
 =?utf-8?B?b2xGYkdGODVkYU1oN29IekIvK0QrWk5jWEI1YVA1cll5UzMyc1h2aEgrWDNG?=
 =?utf-8?B?VFBvMHFSSlhrNDg5ZHZGSFl4ZDV2N3VxTzRwQ0J2UlRjSWR4TkF0bFFib3JO?=
 =?utf-8?B?VktWZHJ6VWVZQW4vQ042WTEwQ3haaG4vNm03aTMxSW9nT1M1Y0d4SmM2QjJl?=
 =?utf-8?B?VzRVdS9vTkVmc0d3NDVucWpJd2xObklyWVVkblRzYkx5dy9aOWlVcWxIUzZl?=
 =?utf-8?B?SldtTG5QSXpsOE9yWTdZVjJoeVlmSDhUSlR6VnE0SDNhNnFRVDNFZDFmZ1ZX?=
 =?utf-8?B?QUJCR2oyeFA3ZmJQb1hBZnF5R0wwRExoWTN3amhFdzdtRzc1VElidkhUVTUw?=
 =?utf-8?B?R01MNEV0YmhrbUQxS2pRK1E0Q0IrdW1LOTFyRUZ0QzFwVStNaUpsWUcyNkJE?=
 =?utf-8?B?UXZiVlhjN1NYWHhxb29FYnIxS1ZNNFZZNlNZRDRpSE44QXYrV2F4YUhCaEhC?=
 =?utf-8?B?NUl6Nzd5bzh1SjFwVDdVdWtyK0lZZmFVSjArQ1ZiYjEwN2NGQTIyYlZzamZn?=
 =?utf-8?B?MFZtN010NStxc1A0ZDhYdlZORjU0aWtOUUpIU0wxdFJFRmpjMEhCSUVPQ2N3?=
 =?utf-8?B?dHBCWFZpSmZpUSs2R1d6dFlyL29uSHJlVUpFN3EvakF5cmZTOE5LU2FzeGlK?=
 =?utf-8?B?STlUaXFqQTlhWm1zZnRWY0VrODFnZ0xTTnRpTUFDNnFueldraDRTNHBaWVVi?=
 =?utf-8?B?SXA0bG81V1RkSVRWcElDanZOUFd6bVVtWjhNQlo2Y09oZS80Wk9tVGVBQXlT?=
 =?utf-8?B?c21ORjdlMVQreXFLS2FxTkxpU2FqSjdYR2hPS0hoSkNqYllCUkF4RnliYWJF?=
 =?utf-8?Q?nXRAODWC1QWXz1iXCb1haOpMgMHrg2YFSLaNMFW9vXAg+?=
X-MS-Exchange-AntiSpam-MessageData-1: 0yku1qZNAJSFoA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4956cfeb-6717-4722-544e-08da32f6aaf1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 02:33:45.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6X/EmAOrfNeMjItH6pjqRS9b71UQfYFg9+bmHgSvgV7de/KkyOqR2b+LJLNLBvGeYaPIG/sV8xK1uBxVWse6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-10_07:2022-05-09,2022-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110010
X-Proofpoint-GUID: N1Mf8R8wHF5plm2tW-tdZtuP8lmKg0_D
X-Proofpoint-ORIG-GUID: N1Mf8R8wHF5plm2tW-tdZtuP8lmKg0_D
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/3/22 21:05, David Sterba wrote:
> The new state allowing device addition with paused balance is not
> exported to user space so it can't recognize it and actually start the
> operation.
> 
> Fixes: efc0e69c2fea ("btrfs: introduce exclusive operation BALANCE_PAUSED state")
> CC: stable@vger.kernel.org # 5.17
> Signed-off-by: David Sterba <dsterba@suse.com>

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/sysfs.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 366424222b4f..92a1fa8e3da6 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -957,6 +957,9 @@ static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
>   		case BTRFS_EXCLOP_BALANCE:
>   			str = "balance\n";
>   			break;
> +		case BTRFS_EXCLOP_BALANCE_PAUSED:
> +			str = "balance paused\n";
> +			break;
>   		case BTRFS_EXCLOP_DEV_ADD:
>   			str = "device add\n";
>   			break;

