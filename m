Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2505F74FBDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 01:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjGKX3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 19:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKX3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 19:29:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E6CE74
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 16:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cK6KIiRhJODevkkdPxHqQDyVygl22XdonOCBTkBtcYyhqEyrS+MFQIQ9YUk6X3HR0PIKjPsLC3uTeuYolnutVlkPpH2nhcdwnsIRAunQ4/2zkAfyMuw+yMmFuZUEyrphkGDF61xo3yOjCzipvOowElnVHxJOThOyH15CH7q1tUiptnQWhuuIykIUaIZoaZ0sy8RULLEK+Uhwt0ChiHtuCW7q9N2brBl18SWQvCDPv+TDHxmSsUe0FonB4IIoy5eTtV/pUnFS6NoPGQQJHFGJQJTe+edDzp8KI0/VFphei1uAVb2A2b4xwYjYH0GPUZmBA0IekIM9EDJ6UGYctdIbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPqEjueApYrK0LvTkksrLs+QgBbjEEBpnJCB/L9UsTQ=;
 b=i16vVMJC6jgrTw2tDC4Kc8AfzozujrDyPumez1NDZjtvuZ4FtqkhLfwyPgGcS/yd+8QgeNoRo9KNNUDOFtNvicjwa9Of/Xm2Dx9gE8wTuzPROFflcmXvVM2k9sLZj/KO48d9GBAIaAfqlh2wlITjLdkd7rGVBDGIFn9m68BtBmQkF0s3mIb+FPG4wCptSB6XFKJa5q4YD2KKVHBIHsUMk+myw0m+gdcOAV2RvZctzPM9iBE0osXmO4kPz3UpBsti/RdtqS4Rj1jreryDQZyTjUX/4EuJlAv0aC/EVjZGMBq9oVCm3z/rYVxEKZteK4LRpCPRlZ5jh7yzQ7ThZVrdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPqEjueApYrK0LvTkksrLs+QgBbjEEBpnJCB/L9UsTQ=;
 b=qlV3LdPC+aysH4xbQCOv79g3o+jlXpA4F/m4Xeejju3452y7f1z/8Z1Rs/fRnC1KP8P4+t3CPj6qrfbZskbqRsD8ch5EzV8HDq5IR7aLo/GutkI6JZow+o7r3WUdYKO+qK1dzcrVxU9SEi94xVfTqjpyjaKLreA3l8st9/gyUgMqAoyzP6LH+Iv0TdoEGvA691X0Hu8Yu/pt2KKhgOzRAA8t9tfACJX3kwlOvG89IXfI5D9PYPd6fbwhv8xPnkEuhNNXTN3mYOS9ujJUK02PCBLn7m2s97SSxc9XG33Qb8X9bIxabu0qHqM6UukMvc5wsMq2R/z17Ei8juy0ySejjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7696.eurprd04.prod.outlook.com (2603:10a6:102:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 23:29:07 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 23:29:06 +0000
Message-ID: <c5b78a62-0691-191c-c196-1a46a1cbc4c4@suse.com>
Date:   Wed, 12 Jul 2023 07:28:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org,
        Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
References: <6c1ffe48e93fee9aa975ecc22dc2e7a1f3d7a0de.1688539673.git.wqu@suse.com>
 <20230711210153.GG30916@twin.jikos.cz>
 <f3cd2a35-04a3-d5d7-d8ae-c967617b64dd@gmx.com>
 <20230711225752.GI30916@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: speedup scrub csum verification
In-Reply-To: <20230711225752.GI30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d835e5a-e8f7-4c65-2b06-08db82669ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbiwWLyaNXlhaDYUXbY3V4bqazp5RUNOxRWDBsnqzGoepf0NpZU3nVN4T3WXVVUwpNoSaftbl3yb+htq62A38qHZ+edQjyTRnPKMU2ObkeM9roObvCSHbBpd7rFBh/Ntuuam2GJZ1wdku7w8jCVaneBHUa2Vz4E1AnC6XDVNHu8R1FrZw/dDKXeSFMrgPpFFOjlgRmM320zbsXLhD7J6nlIQsV1IFUm4dB7Tv66guiKJ6fbQF+NP14Ws7qRgshcjILOhH8D7KCIBqcvToKMXtIIMPBt3+/m1QMyqIOYLoI5NJ8M6kPE7X4W/acq+t9Q1cnoo9LBu476V77pLMJX1D5qmaggY6oNxzFA9tGAEBP6XXZcHPQT080FYkT0nqcBGybCLbsYIrBuPxivV8VjkEZTnTYdB48AijeoPbmaHLDHv1N0pcp0g6O/YU3voJIc0bH7PcUwkqghpuT40CF+aUeIsb8qf3mpvytKlBnihdiKqT0txT4+nNuauTJhP45UwQVMw7A0Tp14Wr1qlZ1chPCwKZiUvR2G8Fa5RR877ZkvoTHJXaOTWo+W877Au6GRnV1caEKWsZKMljXGdb+KHDptn/eaHNnFK4j92yMA04AisQL7mYjY3BRj0F9ec0gHP1fwdGwQc3Np6LHiZbCTJbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(38100700002)(2616005)(15650500001)(41300700001)(316002)(2906002)(31686004)(8936002)(8676002)(5660300002)(66476007)(6916009)(4326008)(66556008)(66946007)(6666004)(6486002)(6512007)(966005)(83380400001)(36756003)(478600001)(86362001)(186003)(6506007)(53546011)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFpSNlJ3ZVU2WXc5OXJqd2hCbU51RjNGUU5TZGpDT3kvaUNSSTA1SFpwd0lt?=
 =?utf-8?B?dzF5Q01PbzEvbWkxcFNRSnF1MnZYdGxEQXdDdUxweXUrVktYOFk0cGhGT3Bs?=
 =?utf-8?B?RWhLMVJUWnkxM3RRU0t0YUNPMDNoakVuN280dkZkQjRwV3ZFOElSTy9relNt?=
 =?utf-8?B?eU9wcXlVL1lZaTh5TXVKZ0xDeTZ3UlZBVUpyaS9wc2N4STR4akFiQkgzOVhF?=
 =?utf-8?B?dTlZUWtKa2RoTEFaQTFKV0tFeGJkRWNWZmtCY3ZmRmFtMDFPbU1oRjBad25j?=
 =?utf-8?B?Q1h6UEd4VzAyVCtKcEhDR3J5QzJqcWxBT1Z6aGo4ZEl4aXYrTVNpVkx3eVQv?=
 =?utf-8?B?cXY3SmJlWVdqTDlsL2xMNGxYTitCdGl0MVVXZ2FXNU9JSnFtVlZjcUhCMGhu?=
 =?utf-8?B?aUhNUkkycVk5NWdBVXVSY0ZCQ2FqdVFrY1hEU25HM25pSW9ueHRPMWFOR0I0?=
 =?utf-8?B?UVA5WUVUQzlaaVhzaGxGV0V4SVZORGdBbFJIWDZSbE04SGZwMklSWWJGZlpv?=
 =?utf-8?B?b0IrSDR0V1FKVW5GcXNGN0hSWmRheEtnWlFXV1JScVczbUxzNjdpT0dwbHY1?=
 =?utf-8?B?QjRMNWlpRUJJMWdVazdsWkxCTWc4RG8yNnVDeWlKZ1lETkV0WVlqNFpFOUhU?=
 =?utf-8?B?d3BMSDh2UDZNZnhwNDFOeHlHM3lzM25YUVU2TTZXT3hJdlJEa0xTZUpERDBR?=
 =?utf-8?B?cUFGcm05Qnp3ZFlkM21MUVo2YW41eDMxSC9YYUxMZURaQU5KbE1VUmVHMUp0?=
 =?utf-8?B?UlU0MnQ2U0p4NFlIdjF2eEJFMU8wTm9Mem9qZklRcUlLRTlBbnN0dUsvT0M5?=
 =?utf-8?B?cWJkOXh2TnpaVCsvZnJ3T2dLSGs3V3lXa3NuL28yeUNlcWEvR0dJU0EvZ0J6?=
 =?utf-8?B?Z2Rhd3cwV3ZQQkx2aWkyTGdxR1QrUmlmaklyNFJFU0dYMHpJelNqNUdlNHNn?=
 =?utf-8?B?eXFyMDJSUTN2b1hkOWhjdFNVeGdDc1dHTzQ3MlprR0NVQVNUdUY5b1M1YXNT?=
 =?utf-8?B?RENpOHYvQU9VS1p4OGgzeGk4VkdmL0Y0cFFlcGhpcVUxbjh0bnlsVGV2UEJH?=
 =?utf-8?B?bUhIdENmalRFYVdMUWVVbUpOaDVDYzFVNFVGQ2p5dEN1a012ektKZFVoMVMv?=
 =?utf-8?B?azZJVVZoZDAzNnhQTk1ibkphWVdoM2hFcjF6MmFoaU9XRU1MZFpDQ0o4QlQ1?=
 =?utf-8?B?WHY1MXB0ZXZyUUtlbHYwcjBmWnVwMWtvY1lsTG1rQ0Y4VzFOT25Zbm9aQ3VP?=
 =?utf-8?B?ZGdTbzNkTXBET1JrV0F4dk5zYXZSZmdXYmJHeVhzeVFaRDBDQ241TWx2ZE5v?=
 =?utf-8?B?VFNXQ2NVanRmTjRtUnNhRHArT0lNTzhCSE5XUytPUkp1UHF4eW9DWWZHQ3Ew?=
 =?utf-8?B?bnZsOHo3czBkTU5VZkxIN0ZSbysvZklOdDl3YWpEVUkvNndzd2hMbmFCMVJm?=
 =?utf-8?B?WkQxQkgrNVdNTzhKWk4yVThxVGFiSzZTakt3NHBvVXhoclRyUWZ5THZLS2hL?=
 =?utf-8?B?Nkxnd2R5RE1MS3pxYmN2cnp2dHo1UFZ1SzlWWHRQYUViSHdDUGZERy9uTlZ0?=
 =?utf-8?B?S25aZHcxenlCUU1KZmYvcWozQkY4Mnd6RnJHVzZidnJCczU3Q0hwclRVY1hs?=
 =?utf-8?B?c0M0UGpEUTlDbUlUNWZYZnZKZzNhQjV2QUlKWFphK3M2U3ZqNkhGZWh0dGxF?=
 =?utf-8?B?VHlaSTQ1NTRwRUlJc0lTakh2SWVWakFVVjZRakRTcU9SUHY1YTdBL0ltRW4x?=
 =?utf-8?B?S29HdW8vTWhKbW5rN1VISlpLb0VxTWRtTEdGcXNxMGNNOTA5U0dlOVB6OGIr?=
 =?utf-8?B?MUF4NFlKM09wbGZORm5KRUllcndlTlRSdXZTRmlRRThJWkhKTVNVbTU2WjJY?=
 =?utf-8?B?cFlTNXJtL05yamNhRVQ0ZnNubmpQV0NiZjNhamd5S2p0OUJwL0toU25NRThw?=
 =?utf-8?B?V29qQTQ4TkJLdmVBM2lXeDBWU3ptdmQ4dTJ0d3oyYnJ5RnpkcnptZjlWRXlx?=
 =?utf-8?B?TEUwTm5mYThTbmQ1djlLcnAwbkdyTDljTThWYmpIc2ZxeXRGc0dnYm94ZWNS?=
 =?utf-8?B?cWlmWTkvUWhPS2xrS3BVdVFBTjBZdmVWRytzbFFiQWdkRkhxaW1QWnl2VGMw?=
 =?utf-8?Q?2S3N68egQiMuJNIA4nqKiNq60?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d835e5a-e8f7-4c65-2b06-08db82669ea9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 23:29:06.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3W7PbAq47K5N7zGGxBI+6qi0ps/K4Rxougrg322VbOqUKBx6esyhiHnTypxNK7v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7696
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/12 06:57, David Sterba wrote:
> On Wed, Jul 12, 2023 at 06:24:41AM +0800, Qu Wenruo wrote:
>> On 2023/7/12 05:01, David Sterba wrote:
>>> On Wed, Jul 05, 2023 at 02:48:48PM +0800, Qu Wenruo wrote:
>>>> - Queue sector verification work into scrub_csum_worker
>>>>     This allows multiple threads to handle the csum verification workload.
>>>>
>>>> - Do not reset stripe->sectors during scrub_find_fill_first_stripe()
>>>>     Since sectors now contain extra info, we should not touch those
>>>>     members.
>>>>
>>>> Reported-by: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
>>>> Link: https://lore.kernel.org/linux-btrfs/CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/
>>>> Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Added to misc-next, thanks.
>>
>> Please drop this, I got feedback from some real world tester, and it
>> doesn't help at all.
>> (Although it shows that the CPU usage is indeed lower than previous)
> 
> Ok, no problem. Paralelizing the checksums is likely the way to go but
> I don't see how it could be made faster.

The problem of the patch is, it looks like the way csum verification is 
distributing is bad.

It really distributes csum verification in a per-sector basis, which 
seems to damage the CPU cache line a lot.

Another thing is, for the reported regression, the tester reported that 
the situation has a lot of large files, and I'm assuming the block size 
of the old scrub can grow much larger than the new 8 * 64K.

I'll got a physical machine to do more testing and hopefully we can got 
a better solution to this performance regression.

Thanks,
Qu
