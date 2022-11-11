Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF16254E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 09:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiKKIHg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 03:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiKKIHf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 03:07:35 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ED16BDDD
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 00:07:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBCfy+0DuXhyPJhm+EZOWvoq/w6BafERFUW6+s/ZbrBM3+1LCUP0AsnX042OCO07fgI2mqThcPDDniXnpzGQTnqjxI2Y4P9S+lIyW9hB+LV3jHlcpxUkgEYAl4sv2C0+Y7OBElrT/QEfmEzcPpeolHQV4CrJiQIM5cWbyTIT1jPl4m5qECvghehADSG935v8z6Se3ymAna1gNMTjo5IyZbv9wzj1jgIvV87Iiry9lNEA5Asv58wYE+tcq7bI2FadC6ftliCc0tf8S0DAphwgDwmqoK9mmuDjGu68x0OQrsJMnuY+0Wr2TxwYhlUx/PPJoS602k8vs/J0NlMTk29F/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlfl4GZbAv0Dyiy73ZDF+0XijxTXE8PYG6SeszcSt8Q=;
 b=erlFIx8YiHshsZx+B6B03VbwksT3dMyOdsZjp/7InIq0vz8q65hCVtBwGxl6NU01+0u/dzY6N0nUn03vMF3tohuf24aMqL6w6eeEBZX78mFRBbBt3p496mYi3ZKyvlx6WfLecaKVaBoBnLofJSLVp5QsDnYpeC8fK4XVSt0x3+GEMyKm3o9anaLTQYi/n/sX568lnot6OyZbCJDlpSsbyuvNU7niRVJv9Y+byOEm+6VZhqXZQWknzn7/53Blnu4VoumxZ5aC++MTsRP7C6cKn+vGZNkn8XtNBaEnYRoC2S8LSmpqzC8V4EIpNFqGbTo/jMx2v9Y4BUgmxQj8fbfjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlfl4GZbAv0Dyiy73ZDF+0XijxTXE8PYG6SeszcSt8Q=;
 b=0r0jefI7nEw0ucpvEvF+xMIyojzVdK4OhtXzsn52IqJ7ZHo2Qq4P2NKriu4nSbfqXTKC+SJOAOLxOf0kAfDHw6YTH7u2n271Tw8w9GeRwJIRloOIOZT4DtuS6yHOI4hxFehxThzaOp9bnpF9BdBrb9/aHoUz1a7LCBRv9wqT17kfkl+renRR6+FSQGX+p7fTUJhOunonjU1vg7K5NO0hoELD+ijHHO7SjzwCq4OqEIZeYFtW3JeZi0kZGhUbwgISYTlEPjhJMZ/mkZh0pWCDQQGZ7S0CveS+zdCzrea+B/pVr9pCjpxgxfdMpj/jB1TS8H/FVZV8FKxnl7NKwPE7tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 08:07:32 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 08:07:32 +0000
Message-ID: <4a8c1aa8-4710-58c0-b031-72b2a0fface5@suse.com>
Date:   Fri, 11 Nov 2022 16:07:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
References: <20221109233938.9969-1-wqu@suse.com>
Subject: Re: [PATCH] btrfs: raid56: use atomic_dec_and_test() in end io
 functions
In-Reply-To: <20221109233938.9969-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: f16d5869-59e8-4e0d-f822-08dac3bbc755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUDSz0xz5DfbIX92sgut4JirME1lSe9pLigFwwzVGWthMPzAz0ts6+T2F8ZJVbnqVtObsLS3JPvGFrc/nlMppL1vPoEICBhOs5tCO1uTpRNcL3RRX4pAdnOKQ8J2qiss4L23rH7Mx0goJ/80tqbz977c9KAsE7bVnGMGc0hy30rW8a94agRjmYHhsdKqQ1SN3c72Qmqc1TeTjpznAFRgzu/px8JU90TR4mB8RcX5aYLTm2QicNpTVpGsHPfhkTp3SGfIhv8opufpX5fyu/SGTS8M/fu+u58oOqRpZmmV3Lj7ub/cUcMCa5aCoysE2yNjp+YSVwQFdguIuJrmnjAb+HFBDsDor9z6ijzidAWdDoCZGmNC0ueuWZVoLLv4SK5lzOJ56ccDnCyJJrEQ5RqjMAJ+8YwUsGG2dyaYwT2wy+DWhTs4whXsrCyQ6vWECyP4ZSI5ED4uBSqKgojyNWCLw+5WBHBFbPsBVCySeAxEwbMwuvkWtXPWUtzJgvOe3wilIHARaAq39/egDF7toCvCEhrB/3nbLh/eLXoGrxjl44GI4FP3JkNwAcy+XHQZIwY1Dfr6teur5v3pdnhUCS+es/hXXBrZ19rv9NZEa/0FG4e0GShM/L035kw7JDwSWB36lu/Cy8Qz2YuB3i/XCpOGS5dJNDhAzjk1/rqAWgIYoKqVWZhZAH5wQpMZtOWpj/qWQ4hNYIQMrev9A22T0lQzqyHRl/+yPwvKUxp9eETYMITQ+yq/llenXswUCMF5kFKxJh4/LHUqApT5YuwFPzNrVGtTU5QicpAMpA+TouqXtow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(53546011)(36756003)(6512007)(31686004)(41300700001)(31696002)(38100700002)(6666004)(8936002)(8676002)(83380400001)(186003)(6506007)(66556008)(66476007)(5660300002)(2906002)(66946007)(86362001)(2616005)(478600001)(316002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzlIY2NBeEl2cHQ4V1VxRnRPTDVDR1c5bnh6U0xyZmJNTUUwVnNpQTQyWm4y?=
 =?utf-8?B?ZEg1aGZjbTRob2VBMnltamRnWE56R2FpN2NQTUhyeS8rdWFpQUpwdHQwdmpt?=
 =?utf-8?B?UzZXYkdUMXY2QjZiTnk4d3lPR0FXeFlCNnc2T3N1ajBjRG5VLzNDcEV6RnVE?=
 =?utf-8?B?Y1FESGtzNGh1WDVsM3p2Mlk3b2VDWXJzb2NOamJ1R014bWZsS2lvN3B5YjFR?=
 =?utf-8?B?OTZhNU1ZN1BIeHZJNUROZkhXRUd6dXVsUGh3UDUyTm1la2VyT2Y2N3ZNdzNm?=
 =?utf-8?B?TlhCaGdJV295d0xZb0JhTmJKSEo4MlV0dEhJS24yN0ZDZW1HU25OdU9iY1pQ?=
 =?utf-8?B?MkwxQ1RkZ0RjZE1tVHdJWDNQK2wySGlqQVdKTGtobEpadHlQSThNejR2KzRM?=
 =?utf-8?B?dlpWOFVhaC9VVmVPMG9MaXVNcURmaVl3UGMzRXdjQ2dXbXk4TDFnZ1RibTd4?=
 =?utf-8?B?M2tSUGxFL0hPbEtsMHcydW9kV0JiN1FDK2NFQy94WXBUNzdxcDdBNVBDTUZa?=
 =?utf-8?B?cWd5NFJoYmJ1YUtDOU4zbkFoUWtNTFBaZWFuUGg3Tzd2alpaZVZWb3BsSThk?=
 =?utf-8?B?VnlQL2EwNzVTZU50Y01aOVZXNGhuVEVGd3FoNWtuSDUvVkJqcHBIQlZReFdB?=
 =?utf-8?B?ejIvdk1YTi91Q1Q2c1NoUzE4TkVJNG0zVkU0T1NRaXpoVktZTVZ2NFVpSGJu?=
 =?utf-8?B?UWNHMENPQUU2RXNGMCttS1pybk5FZ1l6SEpBTmliZ21IWU5memNGYkZDMlpH?=
 =?utf-8?B?NUFGNUxhZkgzSndCM2tQbHVUQWVWeXJIRVVLS1BHWVJ5MGdpeFlUa0l5M2Rx?=
 =?utf-8?B?T1EvaTY4K2dCV3RvcFZKMlo5K1pVc1ZYKzU5UlNhbXFScGJhemFqU2RhNnBl?=
 =?utf-8?B?VWhuZTQrWWo3OS81c1ZkK0tPRlY1T1A3Vk40R05RQklKTnlSQ0h2aFNvSUZa?=
 =?utf-8?B?dkMvQzZQQTJnYmcxWDJCcExtTk1ZalhZYlcxUU9iNlJYUVlBVkpVVXFsOVRN?=
 =?utf-8?B?REUrVy90eTdCSVVGT0gvYVgzVFhPekRLMjNjd0dLZHJ0bkRySmJ2L1lpYUkr?=
 =?utf-8?B?OXhYc0ROcHF4bEtDN1NjdlVZK1hzMFZjZllZK3N1TkhIN3JJUjhRZTVmcmtp?=
 =?utf-8?B?aHBtZDk4ZCtIcWM4WVh4czREUEltcmUzUTI5bDVWT284WTFFYzMxVXJIQ2s1?=
 =?utf-8?B?YkpjLzFjVytkMzk5a3NtL0RFcEV0OUZ5Q0M3L0NrTVNOS1dtQWNOSmtUV1A3?=
 =?utf-8?B?ZERDL2FCbEpGblJhZHhwSEJWakxhdkVIaWxzSzBVOTNXTldvWmJScndjaGFy?=
 =?utf-8?B?MnY2QTAxblVKNnhQaFF3SnlvRitKNTJHWFU2Wm1jSGJkTWR2OTdlTUZFZ01J?=
 =?utf-8?B?TU9JYUR2dFlUbFNJTHlraUtVSW90OHppT0thdTBHRFZEeDIzUnhtajJTRmlx?=
 =?utf-8?B?QWRPNEtVMW0vQVUxL210N1pWdkg2OXd3Um9GdGo2R09rZkgvODFwTC9KR3Jo?=
 =?utf-8?B?VFlXd3dzZ3ZsUXlZQitRVndEamtnL2VaWmpIUzRzRDRvNEZ5d2EwQnUzeFA4?=
 =?utf-8?B?YVFRakliYktlUG1KU3NsY3FUYmI0cm9LTk50bVJrelltUFA0ODVFY094MWhp?=
 =?utf-8?B?N1p5Ri9FenJMS0pGbzRxazRUTWlsZXlicnVsVkRHMGNyTllRRURvSzVMK2ha?=
 =?utf-8?B?Mm15SVFkMGFnK3JhTzA3OVdPVzM1b0d4ZDQzemNEanIvRVJCVVV4UWVRdnNl?=
 =?utf-8?B?V3NBL0JYN01yYisrMFZEaGdPMzhQdXVZelVkWEtVY09UMGF1QjhwWXE5MkU3?=
 =?utf-8?B?WjZVRXJlNVdtZHFDSTdxcUlxTzA5SThVYTZaNWkyTHBFTnVUamxNeDdac3pa?=
 =?utf-8?B?Zm9RNm1ldW9RU0Z3eTJSNGFyTjkyL21IUXFQVEhDVXdTeVYvQnVhbkxZbWU5?=
 =?utf-8?B?RGpKakFoYVgwem9lR0ZreXYwb3Fza3lWY0hiUTJ5TzcvS0U3aE44cjVrc0RB?=
 =?utf-8?B?ZXlueGFPM1BUZUpDZ3BYRjNVcHdDVHEvVDhsWEhXVW9VQyt5WHNqYWF4NWtH?=
 =?utf-8?B?RERHSjgzVklvSWNIV1FiUG1SWHg5WWFGcTJJZS9wWU8vRW42M1lwdCtWTWpq?=
 =?utf-8?B?dDJvS1hRL25PWVFxZlMvYTJPc1ZqaGZTK2w5ckI3VUNiWmdJNXJMQlFCTVZz?=
 =?utf-8?Q?rEVWjVgIqHw7yLy03HGA/mE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16d5869-59e8-4e0d-f822-08dac3bbc755
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 08:07:32.3664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkLJYUDW7zHhmXZAUDdd/pJ3PKsINB8LBnCx/puePBP6JOt4uPUNvzfBlMrMBW/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/10 07:39, Qu Wenruo wrote:
> !!! DON'T MERGE AS IS !!!
> 
> The latest btrfs raid56 refactor is using atomic_dec() then
> unconditionally call wake_up() to let the main thread to check if all
> the IO is done.
> 
> But atomic_dec() itself is not fully ordered, thus it can have an
> impact on the lifespan of the rbio, which causes use-after-free and
> crash in the raid6 path.
> 
> Unfortunately I don't have a solid environment to reproduce the problem
> (even with KASAN enabled).
> My guess is, since I'm always using the latest hardware (days ago it's
> R9 5900X, now it's i7 13700K) they may have something a little more
> strict on the ordering.
> 
> So this patch is still just for David to verify the behavior, and if
> this one really solved the problem, it's better to be folded into
> "btrfs: raid56: switch recovery path to a single function" and
> "btrfs: raid56: introduce the a main entrance for rmw path".
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Some extra explanation on the possible problem of the old code.

For example, we a 3 disks raid5, and is doing an RMW for partial write.
Here we have submitted 3 bios for the final writes to all disks.

    IO thread 1  |   IO thread 2   |   IO thread 3   |  Main thread
----------------+-----------------+-----------------+--------------
atomic_dec()    |   atomic_dec()  |  atomic_dec()   |
wake_up()       |                 |                 |
                 |                 |                 | wait_event()
                 |                 |                 | returned.
                 |                 |                 | rbio_orig_end_io()
                 |                 |                 | |- free_raid_bio()
                 |                 |  wake_up()      |
                 |   wake_up()

In above case, the atomic_dec() from all IO threads have decreased the
rbio->stripes_pending to zero.

Then the IO thread1 wake up the main thread, and wait_event() returned 
before the other 2 IO threads even called wake_up().

And since the main thread is already near its end of lifespan, it calls
rbio_orig_end_io() and will free the rbio itself.
Such freeing can even happen before IO threads 2 and 3 calling wake_up().

Then in above case, wake_up() call will happen on some memory already 
freed, thus use-after-free.

And the new code will solve it by ensuring there is one and only one IO 
thread to call wake_up():

    IO thread 1  |   IO thread 2   |   IO thread 3   |  Main thread
----------------+-----------------+-----------------+--------------
dec_and_test()  |                 |                 |
                 | dec_and_test()  |                 |
                 |                 |  dec_and_test() |
                 |                 |  wake_up()      |
                 |                 |                 | wait_event()
                 |                 |                 | returned.
                 |                 |                 | rbio_orig_end_io()
                 |                 |                 | |- free_raid_bio()

By this, the first two threads calling atomic_dec_and_test() will only 
decrease the value of stripes_pending atomic, but not call wake_up() as 
the value is not yet 0.

Only the last one calling atomic_dec_and_test() will return true, and 
call wake_up() to wake up the main thread.

By this, we avoided the use-after-free.

Although I can not yet explain the stack dump reported by David yet, as 
according to my analyse, the KASAN should be triggered during wake_up() 
call.
At least this patch should close one race window, and I hope that's the 
only problem.

Thanks,
Qu

> ---
>   fs/btrfs/raid56.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 4a7932240d42..11be5d0a7eab 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1437,8 +1437,8 @@ static void raid_wait_read_end_io(struct bio *bio)
>   		set_bio_pages_uptodate(rbio, bio);
>   
>   	bio_put(bio);
> -	atomic_dec(&rbio->stripes_pending);
> -	wake_up(&rbio->io_wait);
> +	if (atomic_dec_and_test(&rbio->stripes_pending))
> +		wake_up(&rbio->io_wait);
>   }
>   
>   static void submit_read_bios(struct btrfs_raid_bio *rbio,
> @@ -2078,8 +2078,8 @@ static void raid_wait_write_end_io(struct bio *bio)
>   	if (err)
>   		rbio_update_error_bitmap(rbio, bio);
>   	bio_put(bio);
> -	atomic_dec(&rbio->stripes_pending);
> -	wake_up(&rbio->io_wait);
> +	if (atomic_dec_and_test(&rbio->stripes_pending))
> +		wake_up(&rbio->io_wait);
>   }
>   
>   static void submit_write_bios(struct btrfs_raid_bio *rbio,
