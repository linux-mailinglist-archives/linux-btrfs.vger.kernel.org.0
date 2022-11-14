Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E7627463
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 03:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiKNCAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 21:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNCAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 21:00:02 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC36588
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 18:00:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7H9WYpnW0pGfoxrJ88yoBH3aH6h8m9KS0ji9QRIM2KueXqFgs3kWkbojqhnUkCnzQLMMCDuenV93dBms1RM+mAyuL4WwOZOxusdd2izUOWzMbnSLkowNXTD1KAbnNIMcDe84OkJdPeY8VTWiraYNH+tfZ0f0XTM6BchrK0DemrRRVBDvGy/wsjJMpD3shwn6FL8izrbtB0HSTfElR/vLm+P52xea0oB23HlLibKF+JTTjP+HZeXwrQFBMlvUl6/hPc96tLnSTwjLyKRt8synIeckAdgesWYq8GVk+7bOE+rlXpAsG+QovHjUhaUptuE4to0P9BWZu7VjH8Hdc29YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHEdvWnwKDGM1GG3be1qrMl2bixYDS21zkM9HjRpwjc=;
 b=YD0rk5rRYhlXHGFR7itwZH0OiS284T/8rOIp8Cct+oaG7zwd4m+qWQ1LGBW3SQ+2Xf0r25+igM2MJFqEV0QiSmPUHrSrdjFEc2YRtzTYhNROMkVjX8cIzwlp0lQ1nSM7t9VHukA8EvPMC4rDRYP2tJCZOB2RX3ANYLXDCoU6xBV13CdyQ5YoSBFeq83+jGKbV5Cj8cw1nBGIvVp3k43thJe1t7jiJspmNGhiAEobU2o65UolI8piT5DhZQksXQXGxbTdyVMzWLMZP/d7gQM2tEM0wdYnKroF7Y/StDJcB1wlIxKKGJ4hfOncwbiqHhyfu3b3qMZUk1NKd7qXIgLpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHEdvWnwKDGM1GG3be1qrMl2bixYDS21zkM9HjRpwjc=;
 b=nWDyFIAjPV+kfPbWTHqhzoRO5OuHoCMOhbIH2eghsJFqTYfduu+K4crtPyEqhEbauvz0PTDoQMCnA0W5VUrrXtQ0/188WvfUgw+5GHa3vVsPt7LOHcWi31Ny0fP7pVvfMsFNJzyqno9dL4vQZ3PSePezaAO62ajzSSYEChxiSbycRkLEwwegSH7VeKw5n8DFzRXOqCNDmBwA8uZmjLzJT3IW0NiT58ks2tNrI7hjNnUyrTowt7bWbfuqI+ogKJnMxtBKVaP7AUADaXMmjYFgCVAchebVAPfjTN3W797aSaNAsHHcm71NiTrcm3WRRUN2Ql7rrsyKfhTbvNXeCK2xhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM9PR04MB8400.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Mon, 14 Nov
 2022 01:59:58 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 01:59:58 +0000
Message-ID: <5fe30279-3816-ecfb-25e2-188ba49e6cec@suse.com>
Date:   Mon, 14 Nov 2022 09:59:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/5] btrfs: raid56: destructive RMW fix for RAID5 data
 profiles
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1668384746.git.wqu@suse.com>
In-Reply-To: <cover.1668384746.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM9PR04MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: 845e8eca-0be5-426a-e033-08dac5e3ed75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDfUee7GAZJtE9oXGDM4TbnrY6P/CJFKqSkAnhyMbsuyUnhNLq/WTlFC1uMnGkc5hLatIYWqjudbHUJaHcvqZahKuMuG41deVIe9Zyg2PRMC53YHyt0mBYtkergxX1RaQ/Mds00nKmpfanwHN0cPW6et9iOQ9ONTZhDGai06vXSM/1kcW3qa8YqKP1ASRjFmL6dC2GyovojsjtZSlQcAA/t73V1BTWmR0n4JHRdSlAZVFXLY/s2iW6b288Rz8yMRE+67fhwaCFscljuB0h0rWg3HgcGNxAypKMs/nChDyxpuiq4Ur5CviAIKopClgo+4NFER/6ZtFRZvK4mDeyt7UNHHiWdTgUPyJCR3MQxXBsDOTm6Y6Mprvqsjkq1Z1aO3RJLDMdLEEN0AzT+ZFwhi20PZeTo/ZNwDo5n4e3oDCCeT7cZZ9Sw2NbhaWK61wFMfkEmqQwo3nL37IEZFL0B5OYsRKYe8cqNlnsigtiqiT8CQimXUV9FOLVFELwC2lnbI9DL2cX1GWI76Hnt4WOsRXmIZj5ATC+LLRWbLkZEKNetfHsAnqDFU0Nt40v1vJ2cbB/Jldhat4nYlX0X6IpJIaLdOtPFE7syW/3uTPJ5VgSc02LnRAU3SdnGEYZBJ4zU3CXdqx+Hn0nIwfZ+/O4KTq+jKGv20xy1hgumG+jBPgeQ/qtLeJjqbFGGSQiLRwDG1jFn7u9BFRMRUkbhn0BH5hYo0b36UghN1eETzOiqq9/Fwdg1gvhCWND93nvHKIzDG+4MKkMIe5KjOZ3mMdjK+IxstcchMwOA5QWV+guTu0Wk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(8676002)(316002)(66946007)(6512007)(66476007)(66556008)(41300700001)(5660300002)(2616005)(186003)(53546011)(36756003)(8936002)(31696002)(86362001)(38100700002)(83380400001)(2906002)(6666004)(6486002)(478600001)(31686004)(6916009)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUcyZnY4d2xoZjNZLzMwWWVUejdpSFZkMHlxSXB1OXc4Vmo5Y1k5Z2pKUlAz?=
 =?utf-8?B?UG1EME5xQWQvYWN2UUxoclVuSXp1dldCaVdjVlh2QnFHQzEydEZpak1GRlVh?=
 =?utf-8?B?c1RqYTkrbEp4NERHc1I5Y1dNak1vc3NQK252UWRZVzJBRjRmRnUrK2FtK0Uv?=
 =?utf-8?B?cHhvMk9ldXRlZGd3bmhjVEdTM25RMUVTYkc4bzhlRndQMVdUVU81QmxpTEpN?=
 =?utf-8?B?Q3VVWUoyR2cwejliNWltbTdCMkdxZXYrUGVwV1dYaFN4VlE4WHU1dE1IUlVi?=
 =?utf-8?B?N21ITkRuTll6aCtQdDcxUmdQRWsycStuMXQxd05HZThTbXcvcVNTTjE3bmpL?=
 =?utf-8?B?NGFrNENySCtWdUxvai9zWUhmSVNIYm10cXJMNVQ0VnN3OG52YVM4VmtIb1FP?=
 =?utf-8?B?V21nYzRyTlByZnhlaVZQVWhIcUtMNHRaYTRwcU1lcFRjUHhRczVsQWxjejBP?=
 =?utf-8?B?TFVLa1k1c2o2RGE0WFp3eWhmQVMrSmdGbGwyZllkdW9xT3Q0ejdWc01jTTdB?=
 =?utf-8?B?Vzk1OXNXV2xXZENiVjRFTnRnMFFOemc4SSt3aEdMZktmMGxHc1Z6UzlDMy9E?=
 =?utf-8?B?YzFpWHB4R0pRUTU2WVdOellmUkl4aXc1RHJYK1FGUmlPODd1elloUzNyNldY?=
 =?utf-8?B?b2MvK0FkYU9uVXlaamlsVXlKSzlqTlgyZDZ1bGg1OEpONW1vVlZOTzlvaVFJ?=
 =?utf-8?B?QzZuU1VKcm9vZmltdU9XOEJRR0R3TEtRbytRNmg0UkpzS1FGRDRqa3AvN2Qv?=
 =?utf-8?B?eGtSL2h4cEx2Q1F3L3dSRGo3YnBTdTQ4ZGlmbmY3VDNCU1VZbUVaUDdwcjNY?=
 =?utf-8?B?NVBBMk1ZeE5palBERmZCa05oeEpkNVBnVThzQVYrNmEzZnk5YnVpSXE4bFph?=
 =?utf-8?B?SC9ZWitrMmphdjB1Z2tnWHZseXdIb0ZFNHdlVVlnRWxUK2tiS1FjQTJRSjBz?=
 =?utf-8?B?NTgwZWJKM1huRXdDOWhEbHVVd25EeWVtem1Vd0hnWjZaeVBJQXZUZjJLbEVq?=
 =?utf-8?B?MUNSYmhXWXhTSWsxbDhFUGcrNUF2M3ZVRmhzRXZLa1psVklKSk0yTGJIai9J?=
 =?utf-8?B?U3pmSEFvYVlsL3hzTys1WUlaYTUwdVNTRG1lWUh2bDFqUk9SYmIrdWNOdGRl?=
 =?utf-8?B?UHI4ckhoaGdXcURLUHNIaklETXRXZzJrRVJremR4Ry8rSjFzdTdyUUNCZFdq?=
 =?utf-8?B?eStJQjJYbHhQc3M0enBXVWxDS3BSOHZ6SHBtSXNYWnBFV0hkOVl4L2docUJD?=
 =?utf-8?B?MWc1WnBpK3F1S3hvWlowNVV2Z3NrUk5jeVBIV1MxZXVObHhWZS9WTVkzYU01?=
 =?utf-8?B?bG5jaFE1bEJWKzRLN3NnNSsyMUdSN01YeS9vTkhGQk10QUc2OG5FTWFlTkQ3?=
 =?utf-8?B?QkoyNUZoOUF2U0NGQ1Rxb1B6Y3JJTks4OU80bzA1MlNEMXIyaTV0WWhxN0x1?=
 =?utf-8?B?VTJ2R2kwY0tIRnhZQ0ZBQTBDRUl1Q0YvMjduUWViWXVOT3NwbTlUbCtjbUR4?=
 =?utf-8?B?VEhwaHNnSm1rd1VNU1B5U2hySlBOb3k0TVZjQStGSU5mQTY2RXI0Zm04Q0Zx?=
 =?utf-8?B?ekN1WjYwNWxEbWE1RHl0cHdpbmRLSkRrMXlVWnNmckV3L2NWZkF6dmwyOHFV?=
 =?utf-8?B?SG50NHFiOUhRZm9UZWV6MHNpTFNHWitwOEoyOGVjSzh3Vitud3c0UDRhU2M1?=
 =?utf-8?B?NnBPV1VEejBjZHErczZ1cytWeEdyUGtTY0FBdGl5dFhsRGYvSEZ1OHIxT29r?=
 =?utf-8?B?bkE5eU5jYXdoRHJwZjhhdWl3aDJDQ01VZGovWWcxbTVrb3J0NXJ6OVAwWDhW?=
 =?utf-8?B?bVdiVkw5Ujg4TWdtUUplcE95MjdlWXpIN0QvbHZJYks1N1J1bkF3R2w3S0Z3?=
 =?utf-8?B?WXVselBsdDRkZWpXaGpPWG1rdWJXVDlZbDJNODh4QmdQb0xlQm05V3dYTUVm?=
 =?utf-8?B?b0lnNG8xUDBQd2t5SlNxcDV0WjNwWU10TTJITHU2MTV6ejc3ZThXaGNacUxl?=
 =?utf-8?B?R0gzR3lpaG1hSU5uY21sc3JBeTB0Tml1VFc4SFhPZk9heFZkY0JrSDlZRGpC?=
 =?utf-8?B?UDRIYTA1Y3Q4OTVXNmh6eXNPMVhKTWExUkh1MHpDb0l4cFZYMEJuZmNBa0Ni?=
 =?utf-8?B?dm9CdmNtM0dRamo5V0U1M2MrekJNcEw4UnlRSENkZXdHSTdWMDUzZHZiZlNs?=
 =?utf-8?Q?j+KluwgqsUPSj6PuIk/jrlU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845e8eca-0be5-426a-e033-08dac5e3ed75
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 01:59:57.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+HwMZOLHlnCEf+V0uJRK5sUEyG8/l84kOQSqmpxj7KSrmfzpIo9sl65hv4O3pHW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/14 08:26, Qu Wenruo wrote:
> [DESTRUCTIVE RMW]
> Btrfs (and generic) RAID56 is always vulnerable against destructive RMW.
> 
> Such destructive RMW can happen when one of the data stripe is
> corrupted, then a sub-stripe write into other data stripes happens, like
> the following:
> 
> 
>    Disk 1: data 1 |0x000000000000| <- Corrupted
>    Disk 2: data 2 |0x000000000000|
>    Disk 2: parity |0xffffffffffff|
> 
> In above case, if we write data into disk 2, we will got something like
> this:
> 
>    Disk 1: data 1 |0x000000000000| <- Corrupted
>    Disk 2: data 2 |0x000000000000| <- New '0x00' writes
>    Disk 2: parity |0x000000000000| <- New Parity.
> 
> Since the new parity is calculated using the new writes and the
> corrupted data, we lost the chance to recovery data stripe 1, and that
> corruption will forever be there.
> 
> [SOLUTION]
> This series will close the destructive RMW problem for RAID5 data
> profiles by:
> 
> - Read the full stripe before doing sub-stripe writes.
> 
> - Also fetch the data csum for the data stripes:
> 
> - Verify every data sector against their data checksum
> 
>    Now even with above corrupted data, we know there are some data csum
>    mismatch, we will have an error bitmap to record such mismatches.
>    We treat read error (like missing device) and data csum mismatch the
>    same.
> 
>    If there is no csum (NODATASUM or metadata), we just trust the data
>    unconditionally.
> 
>    So we will have an error bitmap for above corrupted case like this:
> 
>    Disk 1: data 1: |XXXXXXX|
>    Disk 2: data 2: |       |
> 
> - Rebuild just as usual
>    Since data 1 has all its sectors marked error in the error bitmap,
>    we rebuild the sectors of data stripe 1.
> 
> - Verify the repaired sectors against their csum
>    If csum matches, we can continue.
>    Or we error out.
> 
> - Continue the RMW cycle using the repaired sectors
>    Now we have correct data and will re-calculate the correct parity.
> 
> [TODO]
> - Iterate all RAID6 combinations
>    Currently we don't try all combinations of RAID6 during the repair.
>    Thus for RAID6 we treat it just like RAID5 in RMW.
> 
>    Currently the RAID6 recovery combination is only exhausted during
>    recovery path, relying on the caller the increase the mirror number.
> 
>    Can be implemented later for RMW path.
> 
> - Write back the repaired sectors
>    Currently we don't write back the repaired sectors, thus if we read
>    the corrupted sectors, we rely on the recover path, and since the new
>    parity is calculated using the recovered sectors, we can get the
>    correct data without any problem.
> 
>    But if we write back the repaired sectors during RMW, we can save the
>    reader some time without going into recovery path at all.
> 
>    This is just a performance optimization, thus I believe it can be
>    implemented later.
> 
> Qu Wenruo (5):
>    btrfs: use btrfs_dev_name() helper to handle missing devices better

Please ignore this one, this patch has already been sent as an 
independent patch.

The remaining 4 are the main patches.

Thanks,
Qu

>    btrfs: refactor btrfs_lookup_csums_range()
>    btrfs: introduce a bitmap based csum range search function
>    btrfs: raid56: prepare data checksums for later RMW data csum
>      verification
>    btrfs: raid56: do data csum verification during RMW cycle
> 
>   fs/btrfs/check-integrity.c |   2 +-
>   fs/btrfs/dev-replace.c     |  15 +--
>   fs/btrfs/disk-io.c         |   2 +-
>   fs/btrfs/extent-tree.c     |   2 +-
>   fs/btrfs/extent_io.c       |   3 +-
>   fs/btrfs/file-item.c       | 196 ++++++++++++++++++++++++++----
>   fs/btrfs/file-item.h       |   8 +-
>   fs/btrfs/inode.c           |   5 +-
>   fs/btrfs/ioctl.c           |   4 +-
>   fs/btrfs/raid56.c          | 243 ++++++++++++++++++++++++++++++++-----
>   fs/btrfs/raid56.h          |  12 ++
>   fs/btrfs/relocation.c      |   4 +-
>   fs/btrfs/scrub.c           |  28 ++---
>   fs/btrfs/super.c           |   2 +-
>   fs/btrfs/tree-log.c        |  15 ++-
>   fs/btrfs/volumes.c         |  16 +--
>   fs/btrfs/volumes.h         |   9 ++
>   17 files changed, 451 insertions(+), 115 deletions(-)
> 
