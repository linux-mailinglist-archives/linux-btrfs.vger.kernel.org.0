Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685656F0403
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 12:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbjD0KQW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbjD0KQU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 06:16:20 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF21BC
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 03:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6rN9nHURS/brkvEmJKtXeFuHGXMtZi5ABIxiWsPxIOHmd2VpluUPYP8I7w28Ng7Ix55OFi7KT16LC/3I0w4ZQkgcvUHTZpZdHDenxIClFexGCB+AlyZksbX6NA1ahumeksNnXb7kM/+J8TL5bvUst1XyOAD/jPrz3VbtEVPjr89c+ZSaWNUj97tle5BI/5Q9t8vaDu4XG2HL10gCsemceXQICdu9mjV0XvEaiRv0UOzb0kGSSb+N5EubMI+l54XbeMXsftUoDXayEjrKLe0B6819dVJUzEmNa2+BhqbHiL7kJCgl0oydze7GU4GoPX+z4APlQtT/sv7z7jlIBBPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1PNI3k8/Z+nJcXhYb4m+97ecxHGnH/F+0fgBvtJ3uw=;
 b=maB+qsi1iecgsathR3Tyx0pjIYaRvmdvgh7RZ8R+xE1srjpgA6Ly4+DEQQlHIUZbzbsnfX9h+gOyjDnsvKhc6K5GT8OZc6s+t1Q9yVBnxX/XwNUEYEqGY99EnT0UBFZj+Q2R2lQCeYKVEwty+LCC7Uf8kLeeMQEKbfV71cZOWk+Yvn5nn+34IDTyPZFyMEECfrNnrWC3eNy8pfWl3qFsWZowxR+oF6BXNjIYLfTOWRCDGdxy08Sm8PtKu1gL+YfBkRi9UOlk5/U3v+A+GBOJ1/OXN2fPL0S3ZgAxbBqoM6szJnXwUQ+iBrjMtU3f7Kfcb7bDbsDa7K7b2jpIdTGsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1PNI3k8/Z+nJcXhYb4m+97ecxHGnH/F+0fgBvtJ3uw=;
 b=b7u3Oe29jAk5+faW4JrJ90kHIeoYZHJlM4jU3LaIryu7+g5IPkHUan8wGGF7pI2Lay/IOIEt6VUDdCDKv0JfH0AWMlEOQZNNYul17hGBW0iKKRpofPxU+kHKmHdAbZlznSx/LtZzNnm/OhbKOg/m+eeRx2BAAyL+MF/TxM+U8CoDoe4wtbmFOPfw9bJqaBs0fZqSX0FfRBhdWhwGbBbfn4rYINnHW0mwGwaZH3rC2EY62y9XuSqphULurgVM28pDTcPhoXS0xCQ920HKvF8zdJAwSyF1+nSrG/q+0B6A6zh4rNdXC6nSRB2GhzYyKWxFOGGF+qoYnaQy6cwr31Zs1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS4PR04MB9363.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 10:16:12 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 10:16:12 +0000
Message-ID: <2507f5ad-a7a9-afc6-4589-d1cbf1aabb2f@suse.com>
Date:   Thu, 27 Apr 2023 18:15:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Failed to recover log tree
Content-Language: en-US
To:     Igor Raits <igor.raits@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>
References: <CAH2U3KrVYroUyJi-xBTmtEm+bnkz4DjEzdcZqG-=X=333b3HHA@mail.gmail.com>
 <89a6ede0-a043-ed11-016f-37f866f17e1c@suse.com>
 <CAH2U3KrN4Dhm7QTxfCXA=P1B59kDduYcDH8wK7HRrwdAqb_x9Q@mail.gmail.com>
 <6d7e779d-64e4-cbfc-ecb7-cc73399accf4@suse.com>
 <CAH2U3KptfLvWpKTwBdCXETmbXne60+x6s7kY+Y6269i_55kOYQ@mail.gmail.com>
 <d3bb4999-ae66-cbae-fead-91b4639b4c26@suse.com>
 <CAH2U3KoAQw9uunDTtR726PS=RzKHz33yC1V2x7wJJrUSdxnz1g@mail.gmail.com>
 <b7e18c8a-7b74-2164-75bf-fbb8fee4b1e9@suse.com>
 <CAH2U3KphF+yNA56Y-HG+ML09RLnin_+B0txPJbb8S2BzWMA4bQ@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAH2U3KphF+yNA56Y-HG+ML09RLnin_+B0txPJbb8S2BzWMA4bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::47) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS4PR04MB9363:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a864ba-a40d-4bcc-d8bf-08db47086d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tqx3DvWc4HOex8vfOL9M1FgtgTjhmZAT2q2BPdOmk8k07f7H6pBaPhPmFT1YY9jv3lIWlT+mEIm8DOcgYf/kpaj8GLK9IWlNySAE+vB2IazUfA8/QsWAhlj24TMb1hmOPqm5elD0HtKwjHd5kDX0wEbrOYngG5xPP5tFMjb1q735tAv7R+BjFUDDLXP03rZtCMiXfPqNLpQfjR71Nezn8lXbrOvIdT7ls2maYJlwPmc8JkhKzzeYGsRyw87VlqQ4iR4XT/fCFoL6Z6KTC1JIDaGxqmlHQwqqMNSzrYnzK4cdBfE//C1patXoSeHvpzXbER3xMhtCoXCOwk3GoHFQwyG1SwwFNFCdlccUEmP2Uhz3F8SdeCkTOvotkb89873y4l/bsTgPxWs/gvWmSQn11Qy+0yVXOXuxntmB99KitfCAyHB5PDY8skyr8vlNSTg0p/Y6GwEa95J2hatkvreti04IywfrSK72Z3Sn1SOipY45dPcAMH7rCjIF7xFhM6WLT3kEkdYbRhHNp2Bv+jmTUO3VSRUlhrEcuvVznGgPWdxCJasS22QhJXFHydLOdPDNJnvTlGomaRujsQtHBhGcp7zmxHqbM9xHcXoH56YP+WvoRMepavlyCqnEykzXbKcHBcybWUN1aIAB67tkB6M2QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(186003)(4326008)(2906002)(6916009)(41300700001)(30864003)(53546011)(6506007)(6512007)(86362001)(31696002)(8676002)(2616005)(478600001)(83380400001)(38100700002)(8936002)(5660300002)(66476007)(36756003)(66556008)(66946007)(6666004)(316002)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFpXN3FuNS9kazlFdzY0MEZoRHduSHZEQTVJQnlWeStZSi9sM0p2bTFlV2dX?=
 =?utf-8?B?TVFrZTB0ZjMzMWQ4MURMSDNLOEw4TWVGQ3lGWVlNcnYvaUs0enQ2MFYxQkpC?=
 =?utf-8?B?TWRNWlE5QTFmQkV2MER2cys2ckkwZnplR0dhZU13aGJGUEYvc0hFejl1ZDU4?=
 =?utf-8?B?ci8vY2hkc1FLTmJMVy9MMHFkWGlEUDNobDFrRmcyOFFuMy9wbUoydG9wQUZD?=
 =?utf-8?B?cjBkNVh4ait2akpLT2xINlh2aHR4clVNK1FpWm5VS3pMdFkrb0JMTC80WUs1?=
 =?utf-8?B?NnlMZ3JPMy9INExrdzBZRklUUmZHWXVqZVVscGxka1M0bmlDWXRaeE1sc1Y3?=
 =?utf-8?B?VzB1VW9EWlRER3V6OHFKKzRKY2Nrb1RtcTdEYUNXeUJzc0F1OVNrVTZ1eUxq?=
 =?utf-8?B?WWM1Q0pKMFJ4V1Z1THdRNEZCQnUzd0cxYkFjWUtiSFArRlkrTkljQm9OU3Zr?=
 =?utf-8?B?RFdJdzc0WUU2L1dlTk9DZjdvMjBIWEIrVXR5emlnRC9zUDdYdHZwRlY4VFpk?=
 =?utf-8?B?OFE3MjRZLzNZUXNqMWtjek5LbDd6WUhDSUwxdUx0b2t1T09VNjAzK1pXNDhS?=
 =?utf-8?B?MnllVlJqVHpjamllaHc3cndTR2R6VkVtTHVzWFpTZUpBbGFIWWYzT1hkRi9I?=
 =?utf-8?B?anREMFpIeHFkcDR4NGY5eHNGdEQ5NE9rcElDNjA5VmFiL2VkbHVncWhCbUIv?=
 =?utf-8?B?WnlhWm4vdjMxOGxGa1RsNlVpVjNXVUw1RjdydTUyZ2Fnd2VoY0JNQVA1aitz?=
 =?utf-8?B?b1lqQnArUk1FakduZnFEWTFEWnZqSUtoZXFDY1J2NFZKUExJZFJ6cWFKTDB5?=
 =?utf-8?B?SklVSlYyaEVJQng3NGxvUjV1VlB6bGpWQ3NYam1JS1R1Q0p1aEhZNXFlc0V5?=
 =?utf-8?B?c2FHUmNuZGs0N3pzWlRobzRCZ0VUN2ZnSVcvTlpCWmFXS3BlQThKTDc3aEI0?=
 =?utf-8?B?QUFROCtvWGNNSTZMTWpKWDVuWUJ2b0JMaVRJRlcwOVN0RnIwZ0YrZjJVUlRU?=
 =?utf-8?B?VlIzeWZZNzh5M3pvcjZObHVDNGtOUzBGREdKbFB2VE9GNzZtZnRsSXVldzZL?=
 =?utf-8?B?bzFrS0g2YzhMU3dvOEJSZnUzYWhyR1lzRENRWDBocnNRZTc3eGdTWlFsWmZr?=
 =?utf-8?B?WVR5MlM3SDdJTzZROEQ3RUtSdmNOU0NHQUdhV3lqRkQwWHdyQlNoeC9IOFRX?=
 =?utf-8?B?N0tpeks3RGVBcnR2U2t2THRQZzRpTnJYU0grWjRGNjZpdG9QakNkMDBtZ3Qx?=
 =?utf-8?B?ZU8yY3IrdW56eFhQdWR6cTg1bDZHSmRsWUFXTEsvYjMyeG9TTjNUbEw5NFlr?=
 =?utf-8?B?Z0NBVUhSVTE3OVcyaHR2SmptWU4zZ1BFOEtPcFBadll4Q2Z3bnlpZG55c2Yv?=
 =?utf-8?B?dzI4bEI1Ni8zWDczajVIc2VGNmlyaEtoOXdTTE8wTGw5WXpiT2luOGh2bFRX?=
 =?utf-8?B?VUtVQ1pPQWwzck0ybjVwTlRYSHp0VGg0U0x6eUI3TXVqVDVIV0dRMnZTSHZP?=
 =?utf-8?B?VWhxZkVobjVYVWdYSEhlcUR3VEZ3eWlKOEJRclNidTdDY21sanNoWS9acG1j?=
 =?utf-8?B?UTJOQzNlMjZhK1o2V0FZWlkxdEwwdEphTFJqeVVnN0FWUWhmN0RPVkFTcE1i?=
 =?utf-8?B?UVRRMmlhNHl1ZVdqS2xjRTVDVERWL0V1MHR0a0c0VU9NNU1TaTFuc2FaMUt0?=
 =?utf-8?B?Tm1xOTRsbG9waitGdHJtbEdvYWd5eE5KSU14akN2R3dZc2EyNzRnSzBLZ2d4?=
 =?utf-8?B?UmNDNEJjVll3a2dXSS92enZBQmdZRERhNVUzVHFObklFb041d3BQV3c2Unhz?=
 =?utf-8?B?SlhZMFhoMHJJdFpRTDV3cmYrbXFxN2xZYklEQUFKaFJtYXZLTzVjcG1BSFFH?=
 =?utf-8?B?WHdCQXNYTEFtM0dMOXg3UGY2WjJha0dpRG9JVW8rdU5xaVB2ZTdSSnhUeHVn?=
 =?utf-8?B?SmhSU1VPWkxQNy9nK0tjZUJqSlE5Y1JBaUErNmZrcGtDVUI4QmRZOGdaQlRI?=
 =?utf-8?B?aEEvVS9aRk5qOXJaVzI3Q0tRYUVOcktqNHJoZENHVEVEcS81WXhuTkpkb3Bl?=
 =?utf-8?B?QTF0YjVzdHVUTjgwZllNZTNLeHoyM1dCTHFab1ZRVUtNSWd0OW9TN0hyTnRl?=
 =?utf-8?B?Z1J5dHk2OEpneTlMTWRZbzVQTFBzTXVmenZyV3RBQ3lvK1VBYmQ4ZVZvMmwy?=
 =?utf-8?Q?N6Oe3psgTOrST0FKrGrrXGE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a864ba-a40d-4bcc-d8bf-08db47086d35
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 10:16:12.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1MJ8Fr49SxpEOuB+zvSwLUdqR2gDhNgLKGvNKlo0wdrXOfOnebRqqHaPPN2RIgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9363
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/27 17:46, Igor Raits wrote:
> On Thu, Apr 27, 2023 at 11:28 AM Qu Wenruo <wqu@suse.com> wrote:
[...]
>> Weird, didn't the previous call (without --follow) just succeed?
> 
> Oh my! I'm checking it on the wrong server :/
> Attached now. (tree.txt.zst)
[...]
>> I don't understand why it suddenly failed with transid now....
> 
> This is empty now.

I believe the dumpped data should be enough.

If you want to be extra safe, you can dump the the first command without 
"--hide-names" option and save it safely just in case Filipe needs it.

Otherwise I believe you can go zero-log for the fs, and enjoy a working fs.

Thanks,
Qu
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>>
>>>>>> The first one is to dump the content of that log tree.
>>>>>>
>>>>>> The second one is to dump the original tree of that offending directory
>>>>>> inode.
>>>>>>
>>>>>> With those two (and hopefully the only needed dumps), we should be able
>>>>>> to pin down the cause.
>>>>>>
>>>>>> But it's better to let Filipe to determine if extra info is needed.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>       kernel:BTRFS: error (device vdf: state EA) in btrfs_replay_log:2395:
>>>>>>>>> errno=-5 IO failure (Failed to recover log tree)
>>>>>>>>>       kernel:BTRFS error (device vdf: state EA): open_ctree failed
>>>>>>>>
>>>>>>>> Although the workaround should be pretty simple, "btrfs rescue zero-log
>>>>>>>> /dev/vdf" should fix it.
>>>>>>>>
>>>>>>>> But please consider not to zero the log until we have collected enough info.
>>>>>>>>
>>>>>>>> We may still need extra info even after the above dump-tree output.
>>>>>>>
>>>>>>> No worries, I'll let it in the state and follow your guidance.
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>> # btrfs rescue super-recover -v /dev/vdf
>>>>>>>>> All Devices:
>>>>>>>>>          Device: id = 1, name = /dev/vdf
>>>>>>>>>
>>>>>>>>> Before Recovering:
>>>>>>>>>          [All good supers]:
>>>>>>>>>              device name = /dev/vdf
>>>>>>>>>              superblock bytenr = 65536
>>>>>>>>>
>>>>>>>>>              device name = /dev/vdf
>>>>>>>>>              superblock bytenr = 67108864
>>>>>>>>>
>>>>>>>>>              device name = /dev/vdf
>>>>>>>>>              superblock bytenr = 274877906944
>>>>>>>>>
>>>>>>>>>          [All bad supers]:
>>>>>>>>>
>>>>>>>>> All supers are valid, no need to recover
>>>>>>>>>
>>>>>>>>> # btrfs-find-root /dev/vdf
>>>>>>>>> Superblock thinks the generation is 3595442
>>>>>>>>> Superblock thinks the level is 0
>>>>>>>>> Found tree root at 3424157040640 gen 3595442 level 0
>>>>>>>>> Well block 3424059916288(gen: 3595435 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3424054345728(gen: 3595434 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3423941132288(gen: 3595431 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3423913361408(gen: 3595430 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3423724224512(gen: 3595429 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3423618924544(gen: 3595428 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3423522717696(gen: 3595419 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3423509741568(gen: 3595418 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3423381946368(gen: 3595417 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3423254937600(gen: 3595411 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3423190253568(gen: 3595410 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3257715638272(gen: 3595407 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3257566904320(gen: 3595404 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3257494061056(gen: 3595402 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3257426460672(gen: 3595401 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3257354846208(gen: 3595400 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3257189138432(gen: 3595398 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3257066291200(gen: 3595397 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3257054314496(gen: 3595395 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3256925880320(gen: 3595390 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3256790237184(gen: 3595384 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3256747343872(gen: 3595379 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3256734842880(gen: 3595378 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3256726290432(gen: 3595377 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3070848090112(gen: 3595376 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3070762254336(gen: 3595369 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3070533402624(gen: 3595366 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3070520950784(gen: 3595365 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3070319542272(gen: 3595364 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3070275878912(gen: 3595355 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3070224957440(gen: 3595354 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3070133649408(gen: 3595348 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3070109827072(gen: 3595347 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2889425747968(gen: 3595340 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2889301147648(gen: 3595339 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2889314811904(gen: 3595337 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2889158066176(gen: 3595332 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2889076523008(gen: 3595330 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2889007906816(gen: 3595329 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2888883896320(gen: 3595328 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2888770060288(gen: 3595326 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2888474230784(gen: 3595325 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2888414789632(gen: 3595324 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2654316625920(gen: 3595323 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2654292000768(gen: 3595322 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2654178476032(gen: 3595321 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2654046437376(gen: 3595317 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2653815832576(gen: 3595312 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2653688217600(gen: 3595311 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2653640425472(gen: 3595310 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2503985594368(gen: 3595309 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2503770832896(gen: 3595305 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2503679131648(gen: 3595304 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2503542685696(gen: 3595300 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2503440711680(gen: 3595297 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2503322124288(gen: 3595294 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2503168000000(gen: 3595289 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2503054426112(gen: 3595288 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2503041384448(gen: 3595287 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2503445053440(gen: 3595285 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2412690669568(gen: 3595284 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2412570755072(gen: 3595281 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2221267697664(gen: 3595278 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2221141753856(gen: 3595275 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2221038993408(gen: 3595270 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220922290176(gen: 3595269 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220743933952(gen: 3595266 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220618924032(gen: 3595264 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220595019776(gen: 3595263 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220507889664(gen: 3595262 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220364578816(gen: 3595258 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220268486656(gen: 3595257 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220199788544(gen: 3595256 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220125945856(gen: 3595253 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220104859648(gen: 3595252 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2219941019648(gen: 3595246 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2219772805120(gen: 3595245 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2219676188672(gen: 3595243 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2219385782272(gen: 3595242 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2219322032128(gen: 3595239 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2219298471936(gen: 3595238 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2219189157888(gen: 3595234 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2219168301056(gen: 3595233 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1725089398784(gen: 3595229 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1724993929216(gen: 3595224 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1724703211520(gen: 3595223 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1724590768128(gen: 3595214 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1124192288768(gen: 3595206 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1124086104064(gen: 3595204 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1123955785728(gen: 3595198 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1123796860928(gen: 3595188 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1123702702080(gen: 3595181 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1123696197632(gen: 3595180 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1123421716480(gen: 3595178 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 1123298459648(gen: 3595171 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 409090146304(gen: 3595168 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 408798691328(gen: 3595166 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 408693866496(gen: 3595163 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 408471683072(gen: 3595160 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 768655360(gen: 3595159 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 508542976(gen: 3595157 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 426082304(gen: 3595153 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 275447808(gen: 3595143 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 158154752(gen: 3595138 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 3069995843584(gen: 3594572 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>> Well block 2220640256000(gen: 3594469 level: 0) seems good, but
>>>>>>>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>>>>>>>
>>>>>>>>> # btrfs inspect-internal dump-super /dev/vdf
>>>>>>>>> superblock: bytenr=65536, device=/dev/vdf
>>>>>>>>> ---------------------------------------------------------
>>>>>>>>> csum_type        0 (crc32c)
>>>>>>>>> csum_size        4
>>>>>>>>> csum            0x50cf7576 [match]
>>>>>>>>> bytenr            65536
>>>>>>>>> flags            0x1
>>>>>>>>>                  ( WRITTEN )
>>>>>>>>> magic            _BHRfS_M [match]
>>>>>>>>> fsid            261534ef-b111-4056-8124-6dd207030548
>>>>>>>>> metadata_uuid        261534ef-b111-4056-8124-6dd207030548
>>>>>>>>> label            minio2
>>>>>>>>> generation        3595442
>>>>>>>>> root            3424157040640
>>>>>>>>> sys_array_size        129
>>>>>>>>> chunk_root_generation    3581791
>>>>>>>>> root_level        0
>>>>>>>>> chunk_root        25460736
>>>>>>>>> chunk_root_level    1
>>>>>>>>> log_root        3766932537344
>>>>>>>>> log_root_transid (deprecated)    0
>>>>>>>>> log_root_level        0
>>>>>>>>> total_bytes        5498631880704
>>>>>>>>> bytes_used        4346997747712
>>>>>>>>> sectorsize        4096
>>>>>>>>> nodesize        16384
>>>>>>>>> leafsize (deprecated)    16384
>>>>>>>>> stripesize        4096
>>>>>>>>> root_dir        6
>>>>>>>>> num_devices        1
>>>>>>>>> compat_flags        0x0
>>>>>>>>> compat_ro_flags        0xb
>>>>>>>>>                  ( FREE_SPACE_TREE |
>>>>>>>>>                    FREE_SPACE_TREE_VALID |
>>>>>>>>>                    BLOCK_GROUP_TREE )
>>>>>>>>> incompat_flags        0x371
>>>>>>>>>                  ( MIXED_BACKREF |
>>>>>>>>>                    COMPRESS_ZSTD |
>>>>>>>>>                    BIG_METADATA |
>>>>>>>>>                    EXTENDED_IREF |
>>>>>>>>>                    SKINNY_METADATA |
>>>>>>>>>                    NO_HOLES )
>>>>>>>>> cache_generation    0
>>>>>>>>> uuid_tree_generation    3595442
>>>>>>>>> dev_item.uuid        1d32f1a0-6988-4ed4-b3cd-24d243baf975
>>>>>>>>> dev_item.fsid        261534ef-b111-4056-8124-6dd207030548 [match]
>>>>>>>>> dev_item.type        0
>>>>>>>>> dev_item.total_bytes    5498631880704
>>>>>>>>> dev_item.bytes_used    4820052213760
>>>>>>>>> dev_item.io_align    4096
>>>>>>>>> dev_item.io_width    4096
>>>>>>>>> dev_item.sector_size    4096
>>>>>>>>> dev_item.devid        1
>>>>>>>>> dev_item.dev_group    0
>>>>>>>>> dev_item.seek_speed    0
>>>>>>>>> dev_item.bandwidth    0
>>>>>>>>> dev_item.generation    0
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>
>>>>>
>>>>>
>>>
>>>
>>>
> 
> 
> 
