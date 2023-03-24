Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1B6C7EB0
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 14:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjCXNZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjCXNZY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 09:25:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A3812BD7
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 06:25:22 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32O18Vpk009625;
        Fri, 24 Mar 2023 06:25:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=asg1bGSH7T+QDcrXRogWvYLPdTndW8/WfTtLLSXb9XQ=;
 b=bYT1ztUQ5ZfLJ2e42mMnQLe+YlBGB21ZH2wRVH8TxlWIp/7yuJF2JubgG2jVmYMtkYt0
 3vAw/OhYa5/X5cZNVYl9ysCIxhc8kCAjdgu/atQCLThm7Iv65cF3gZeKgukpkSFMa9tS
 yc9qrpj6rjSB3NCn7meWGoHBtW0XFqDxhdZcZysSNqBS/K2BZISRc9HkMYTm9O039itC
 n7fyP+GQW6pBDy/HRRfDl0dnCbBwOwwHa9GdJXQg1SLdLJxrV+2/rLS344UJwhG0z5Tw
 WQGDUQUfgrJz43j2BnSYA8zvLSzsjemqhw4Lwr4xstwTibbgSAL87xAz9WvsCXffD6jA fw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pgxkrkyy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 06:25:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXXZwbA6o1CW/Iavxm6T0AFbsYa5edlqizwR4o+HFNZ0xKGxW0oHhsU5gy3Op8mmnCVrO9HMb3mOeOhB7tiLZe9lojfMwcL3hdrjcHgcbPY9j2vZvARPbMAg9/jRHlg5Kj9Ed0/Rb4mlPggqC9nW4uTzbyUO+sBnFPGKRaBA/eMRRWwlYfMM/pyixXcKTW85AcaPSoy/6OqGlWTs5/2RLIb2LO+UUtA5PPYeYzAZzvsESe68U7+q4fPcNVX7zmrXA1ZwCZoo5NPTLcHHGVlxaJlRlD3a4aEhY5ZjTwuly7tdeYKTi/sFOJVNZlElxAUu8XzQ/qjievg+EFQzkaV44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asg1bGSH7T+QDcrXRogWvYLPdTndW8/WfTtLLSXb9XQ=;
 b=a5AFocILNGNBM5KGhzjJoHREAusUhO1zJNH7vHEgGUaY1RMhDBf++/AJtlxxd2tOwYN4GYs9gStXy5fcCz8rFifugcE1MSYZtyJ4SV1mfFMBVZLotHVkX2RTUMB8uJJc6bDsjrYsQU8q3y8jFhgonVODkpiEZIr9uAZVPuONbnLFoqN+IaYaFr9WXG+6I9yfZUgBvgw/uy5qISOvLlEcKvo27Kp8JIdYyK38Bp+PPRa3FxKTNLxRpEF1nXib3xLTzzcwIV9dTwq6v63kCQOkLWm1Khi/1R8B5O8wYfupMsXv+RNfMqoq8w01Od4wdeYVV+tch5EDQlTHzpGIGTDIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by BY1PR15MB6104.namprd15.prod.outlook.com (2603:10b6:a03:52e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 13:25:10 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e%6]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 13:25:10 +0000
Message-ID: <14e253bb-8530-af11-7395-9e4148249c54@meta.com>
Date:   Fri, 24 Mar 2023 09:25:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-4-hch@lst.de>
 <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de>
 <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com>
 <20230321125550.GB10470@lst.de>
 <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com>
 <20230322083258.GA23315@lst.de>
 <ff18e85e-061d-084d-d835-aa7b23a54f1a@meta.com>
 <20230324010959.GB12152@lst.de>
Content-Language: en-US
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230324010959.GB12152@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0017.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::30) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|BY1PR15MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 890916d7-548c-4c4a-de9b-08db2c6b3109
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVb0rQT+OjiONqZ1UP48L2ViQdoIlMRjUX9yLHMNM/nxTcz48OFWYMYNa4WOYtI56sqiH6SoXQ4gWxidW35jBsl5/eFmCMr4UPFaSHa8xhZ8En+N1ghQ24g43yaCxXnxwQ1PdCAbRit+SwdmVqzv9bnkWDhG5TpuQuqBLjL5MSPBDaExjdaKtg+5LJShgWKb7J+NMiauoMQidzRRW5o7GnDvgBbEsmWp6Cp+CWe9d7d50hmccSORsHjvQYcQDgNSNhAT3Yl61DoHi549KjNFx9a6t+6GdrmpBwYWnC8sqUA9kgkxEvfRLPeEfSgAol5VT2c8UbFWdvI0Yd6t56Xjbi7jCM6G+jXnLV5JltZmAHAizY+XJY+tRFzOVn5Ddnp8pYpjwdRPwLQom5EMIxmgZzw/1STL5MgAj52Arm/CpKtERv7isfDhaa1kx5bV6xSgrbSH4wPjPadgWjjDSjwyF0cKXklKpeZuQFM2YtqSEf6KxajY0sqpRZx++k2XIVdLGrE67Qra/bOfJ99oq3foy4JxZXHfYsy/ikrMsUnKp4s4MUj9WrebJWJIGgeaSIvdGHeGXCYhyM5QBnxv9LjuO/UklGM233ChJHqMi4sECOYahExBJIS3cWQsWjof1giM1FS0EZaW5jnjraa0fhIv3UTbjTXUoFCE947Ds3m86h5jXAn8+4eEOrSjv4lQxqEB0PvzcGVVTRUr1fF8ctqCgjarzgAoJyYgnjEyF+ZQEus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199018)(8936002)(83380400001)(31686004)(2906002)(41300700001)(6486002)(2616005)(4326008)(38100700002)(316002)(36756003)(6916009)(8676002)(5660300002)(66946007)(86362001)(53546011)(6506007)(6666004)(6512007)(186003)(31696002)(66476007)(66556008)(478600001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amUzaW9KUnVIWHJ1alVudEpIMHIzd2FENURnbisxUmF6M2ZxYys4Wit6WXRx?=
 =?utf-8?B?dTZRamtBM1VDV3RpcTY0S2ZiMzd5c1haM05GZDkxT3JKOFNLZERCNnBmZjgr?=
 =?utf-8?B?d0tVaVppa3ZkOXVqY1IxQUl5U01TQ3dPZDQ2d1dJZjJ2azFEOTF0U0FGVGZV?=
 =?utf-8?B?Yk5tYTJYREpKWnpPRlAvajJvOVBFQzYzRzFMWFgrdzVvZ0ZVRDFaNzZwQnBW?=
 =?utf-8?B?MFAwc0c5UTcwdlRna0lqeUpja3Frc2k3RHVxekgySzFwVDBxd2M4OXl3V2FY?=
 =?utf-8?B?S2VyL2o1MzdsQ0QxMWxOR01MeEMzd01XSENZamtLOXFsR2xKNVlScEUyL3Jk?=
 =?utf-8?B?S0RFYi81RmdQWE04TjZOL1B4dkZLaWFEOWxtUGI3Y3ZFVGJCZU56NzV0YjZS?=
 =?utf-8?B?cUhkenJ4RUt4am9rcm9zWjlabTVubFlDaE5YNW9pbDhHZWh3Nk9yRzNrY1VG?=
 =?utf-8?B?UGpMaHE2ZWQwdXIrY2FOUFFhUEtlWTFhNjVyZzNOaE9MUzgwQ050ZzQzOGl0?=
 =?utf-8?B?cjRSWHZRUU5SL1NBakZyMVhBQlprbGoybUlJbG9UZW85ZVBxTjNLWmFuY2ow?=
 =?utf-8?B?U2hnOVAyRUczZTkxYm1OZ04weTdKamhTeUFxd1k4Vy83Zk1oRllSSm9mM1NR?=
 =?utf-8?B?Z3Yzc09kcEplSVlkRFRoZ0ZFdytjdHJ5cUZEWDRwdzB1Um1ReGJYOHhlN3BS?=
 =?utf-8?B?M3k1QTFhRVZVYk4wVU1mWW1seGtvd1dpbzFkZ1dLUjJ5QmdTeWU5cDc0b0ZI?=
 =?utf-8?B?elE2NDd2Z2lpcHRtS3haemN6bjgzSmFUK1pETmkrQzN2SGxJdGhoSXBHYldn?=
 =?utf-8?B?alhwditSd1FvRG9zS2h4QSt4NHRvQ3FROFdjbU55azkwaGpJTlNJemlxc0dG?=
 =?utf-8?B?MUI4QUZ3Q2VuTmFsUVJYQ1dXeENYeTd1WFpvaEYzWGtaVk54U09vamtRYzl0?=
 =?utf-8?B?d2pPbFBJNzhJUzRVWXNuVjNmaER1d0Z4Yk1BNi9vTzc0K2ExdUc5WTRZQ3Yw?=
 =?utf-8?B?TFMyaGdwNmtud1Z2UHV1d0xiTHErNDFOSElRNTRFK1piRXd0d1lRZTRHdmRQ?=
 =?utf-8?B?N04wQitqcTlZUUw1bFBHT0VVUUNGNDQ5K09HcXp2S2NYS3dSbHR1ckZiSng2?=
 =?utf-8?B?WlhJQWZwVGFYZFFMV2RGVS8zbmF6RlUrcjJjdzFKT2huUVhQcWtLQkFsajVG?=
 =?utf-8?B?Z3pEbHlPL2QxT1djazI1STE5MlpDZ1VKRWFQbHYrK2k1VFBaK0hwakpicTF6?=
 =?utf-8?B?eWVyMGcwUVY3OWk5UFpzTlhNTGNxVm5RamRNWVBFNkg4aUg5cklSVElLNlB2?=
 =?utf-8?B?SEJrT25rZmk5Ym84WXh5OWJNRllWYUxkc254UFRaSnQ1SDRrOHcxcWcza2xs?=
 =?utf-8?B?WFJ3S09aWGdjM0dtRVNIME11Wm5EVzJGMXFEbW1iL3hWdm9ySm5iUno1T2tr?=
 =?utf-8?B?NnBSSmZPYjVHandZdjN3eGJXWjJOcE1waDBRQkdqa1BzOE9na1FtdEt2cWlq?=
 =?utf-8?B?bElFbGV4QWhwY2E4QllmRGNrb2ZJbkJqL0JaRkhaWlQ3RndndFkzbS9pQzR3?=
 =?utf-8?B?ckpLdzNJTFB5c1BLdDZtM294azdrNlFRVEdkVXEwa1g5Q0JmQU1XMUsvcEp1?=
 =?utf-8?B?NkJJYjJkRnduUitUU1hvdzVuWjJNeE9ZVFFKU0loNlQ5NERFUUl0Q09qQWVi?=
 =?utf-8?B?dHFIZ2NvOTh0Uk9HM1FQSktQbW9KYUYvZXQzR29CamozT1hTTXpEdkVvb3lm?=
 =?utf-8?B?SHdlblZSRXJKYldEL05RY3hyallZVEdPcW1CVXpNSW40NEk4Y2pQR0dSS0FF?=
 =?utf-8?B?aGM2YjM1SzRGTTdWeDdDUkw2NXFkNUpHRFFyc2hrVHFvMUtCeUhZWE1MWGhS?=
 =?utf-8?B?V1FTYkFUMnB1Wkk1enNzUDNtTGh1cm9xRmFvV01CMDg0TDBmSVpWNEtVWWVG?=
 =?utf-8?B?dDNZSTgzekRabHcyRXVKcFBjc1lTb1ZUamQ1NWEyN0oweHdkTkw3cE5VZGtp?=
 =?utf-8?B?VE5BMlROaVBSZytwZVZiSkZzNmtQQVRVdmwvZXFtQmF4U3BScEFUaVpsQmhZ?=
 =?utf-8?B?djN0TzNsazlzS3ZHVDZDc3RiMGZ0clN0azZYdk9oa3hHTS9IQnRGRkJGL2lU?=
 =?utf-8?B?ZzJBK0x1MDdwVlh0RFFNM2RaVWVQaks1ajNvZ0RWNy9zZlVsRHRBY2NZTUkr?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890916d7-548c-4c4a-de9b-08db2c6b3109
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 13:25:10.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sd1TmsQU42T1fTpwjrC01JVAcWRsWp67RsuHzk6c23HhziyhLBGI2FCvuMSGKXy6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6104
X-Proofpoint-ORIG-GUID: enfU7mrm8uZh_PM1uiaiWpq-iviNmKqb
X-Proofpoint-GUID: enfU7mrm8uZh_PM1uiaiWpq-iviNmKqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_08,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/23/23 9:09 PM, Christoph Hellwig wrote:
> On Thu, Mar 23, 2023 at 10:53:16AM -0400, Chris Mason wrote:
>> The original reason for limiting the number of workers was that work
>> like crc calculations was causing tons of context switches.  This isn't
>> a surprise, there were a ton of work items, and each one was processed
>> very quickly.
> 
> Yeah.  Although quite a bit of that went away since, by not doing
> the offload for sync I/O, not for metadata when there is a fast crc32
> implementation (we need to do the same for small data I/O and hardware
> accelerated sha256, btw), and by doing these in larger chunks, but ..
> 
>>
>> So the original btrfs thread pools had optimizations meant to limit
>> context switches by preferring to give work to a smaller number of workers.
> 
> .. this is something that the workqueue code already does under the hood
> anyway.

Yeah, between hardware changes and kernel changes, these motivations
don't really apply anymore.  Even if they did, we're probably better off
fixing that in the workqueue code directly now.

> 
>> For compression it's more clear cut.  I wanted the ability to saturate
>> all the CPUs with compression work, but also wanted a default that
>> didn't take over the whole machine.
> 
> And that's actually a very good use case.
> 
> It almost asks for a separate option just for compression, or at least
> for compression and checksumming only.
> 
> Is there consensus that for now we should limit thread_pool for 
> se workqueues that do compression and chekcsumming for now?  Then
> I'll send a series to wire it up for the read completion workqueue
> again that does the checksum verification, the compressed write
> workqueue, but drop it for all others but the write submission
> one?

As you mentioned above, we're currently doing synchronous crcs for
metadata when BTRFS_FS_CSUM_IMPL_FAST, and for synchronous writes.
We've benchmarked this a few times and I think with modern hardware a
better default is just always doing synchronous crcs for data too.

Qu or David have you looked synchronous data crcs recently?

Looking ahead, encryption is going to want similar knobs to compression.

My preference would be:

- crcs are always inline if your hardware is fast
- Compression, encryption, slow hardware crcs use the thread_pool_size knob
- We don't try to limit the other workers

The idea behind the knob is just "how much of your CPU should each btrfs
mount consume?"  Obviously we'll silently judge anyone that chooses less
than 100% but I guess it's good to give people options.

-chris
