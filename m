Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97D067F2CC
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jan 2023 01:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjA1AL6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 19:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1AL5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 19:11:57 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DBEC4
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 16:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay9DPn3wWSWDvY4KEBVugeBMirrqUZQhwxeYPWee5756R3Ys83vVl93p5Ax8aHslauvOzE1x1U/qoe76PdnE/jgtrVbt/bSY9PUzGhyMKCC8k1oK1Lt2rNprEWlHVTzPOu0oT+zE/uiCiv9K2JGj6wr0qZ/aCJnpaiUy0j3/QANY3MF9ge6DqCTAeCi27DTlr5pGAbi8E1OEJrw7pO8H4mw1VENjU4VkkHe2KXGjegL9uL5Vp4MrH7FBv7uTNRqB5InEpu8gzSJhOan1X8t+S0Qszy8o+EXbaJXz5oVBN3UeO8Y2CD0uP78n93e+Ggzzxm2nh1HBnN8ixbg4x4s0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4LtI79pJp3YwEuZZrLxM0z3NTt+gvbxBjISeG3QsQw=;
 b=MBLMOEDuIrhUIl4UUfS6zeLUar9VP6GNsGAAPcg6zQ2fPzLV1nYO0pCZVg+qULuXEa7ibgxHM2wAqr4BgaiZeDIdyNjQyWI1EjSdLneKmyQwxb+1sdSUeWuSta1cTllk85GFXrWh3yuW4gj+Rj/wvkzGAgBYJO7PyIKSStc8f9AV91RFx1zw0HK0H3cWiQSDmz5VWVnThZIU4N2xB3Z3snTMGK5+FMjmXONEHjtFWbjIqDhXt28HWZxgegR3Ca5RYS7g91Z4ntgPII+Uf1zAywf899S9H/vKnTeep8/QWxYtUhNKXsh1gCqsw+UiSUJWSUj6G/lRk0lJmDiKKjL2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4LtI79pJp3YwEuZZrLxM0z3NTt+gvbxBjISeG3QsQw=;
 b=RYbWGpe+X3pKrz4HUlz4Utjg0WHOFXSbH+HodoZ9U2kFiWBzuw9VDAwP2FuokYqXJBQ3vpgE3pEy8MB9IHtHkl/TV1b67AHnqP50y8IbZlMN9FyH+0hB2JxHofxwCc2mMS3lewMBKfP853/60gUMT7xEPZ3SS3gdnd/KAz0QLxlcIOVlJB0i7utefqilBmBUlkx9KrkSqxil8IMeChDIB8pG9Ksgh6g+8ehYtAQWz7nR3GgWovilnw6g4Lyp2XUKw58uh7U2hAKjuOBA4OkfH/7NXtCt8/Fbf6bw7s83Yjx+NwxaLfnrd6+ZlRt1FWt5TfTtMpgoxEL8zQxaCImTXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7855.eurprd04.prod.outlook.com (2603:10a6:102:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Sat, 28 Jan
 2023 00:11:52 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%7]) with mapi id 15.20.6043.023; Sat, 28 Jan 2023
 00:11:52 +0000
Message-ID: <b8050433-de29-3e5e-88f7-12c3a82fc013@suse.com>
Date:   Sat, 28 Jan 2023 08:11:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] btrfs: scrub: avoid unnecessary extent tree search for
 simple stripes
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org
References: <e8b3a59de5f43c185427a8d87c303ba3e8ff6ff1.1673244671.git.wqu@suse.com>
 <Y9Q6bxJ5g9oF3REv@zen>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <Y9Q6bxJ5g9oF3REv@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d21b4e-62e9-41c6-ca0f-08db00c4419c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3a2XCe1VsiccrlL0d60C80cPTb55/ks491OPmYl0+NEPfR+PVfLbTflsifzTC/TYgrmOkhfHoja5OdgyZ2slAnu8zY4an6wAlCbGtPWuOnURQGjLW/wpROxEuos3R/kk2NCAqzLtDcXInaWKyxBOllNahlTxW/YN0AaFCy4yEqsVV6juFS09ReqGSJeZ5ZbWQNJV6RccUuIKI8k/TYg3EX/AiRRMO0pZsEY9JiCIA6GPkVcJGz0JAztb949P9C3nSEw5Bt08m99Yk+fHHpN/ynFrpYB+Tegb7Pv+bZVshl1kxbqfQg/ERNmJkakLIdrNiODdSw0QYNKqhHhoehaviuLKXlItS1cmdTseszfVte/stkZWY2h+eWJw05okCJ3w9duHF4c9zSBYxjlxsI8Y7KahoxuOx47CudEDhS+JRCag5sPxspJG31CzWiRXSLH229XpAimQX6b+avak1dGIPIz8gqrlAAlwTTfDoIvh/5a7D+4M4qTz4SryhmAwtnt3ZcGL2OG7Y5XihJwrSvAXRMQtu3nDdLmXqklNq+5mPlf2Zbr5QsV+clDXBwmCS2YpgSOQeJTzzt7gFZ9lGm8jO25OeNiCHIbXiiBXSuJFR2K5TAM/QyYBP/IK48sphKxaMIPy1KVUwRwwgodOe7NwrefNI9gCA1H+fm6vBNO87n52gggwBNY1xq1iovBXDOvHy8Fz5tsEDsg3qBNgh681MVI3Lh+fkVxq8pMQ0oYrCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199018)(2906002)(8936002)(41300700001)(5660300002)(6486002)(83380400001)(478600001)(2616005)(6512007)(6666004)(186003)(8676002)(6506007)(31686004)(53546011)(4326008)(86362001)(38100700002)(66556008)(6916009)(66946007)(66476007)(316002)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzgraWVtUmQ5MlJTUmROREpJVXZzclVLYVVWWGpiczFqNTQrUXV5RFh5eWVD?=
 =?utf-8?B?ejRQWDNCL3NxVWhxQVQ4cHdUV2N3amI2c1VrcE05bFNYNGhYVEZMcEdnb1Zx?=
 =?utf-8?B?LzFsdWkzSkR5S2xsNmVUTjZHanVmNElCeGFZcmQybE5TOUxTWmsySjljSFZr?=
 =?utf-8?B?RHZ0Ky9QUnhNaytLb0N2cEJhVDlDUmIwZkRYbERWTjFhS0JCMlpCYTZTNkdM?=
 =?utf-8?B?SnJYY0RwSTBORU02WUIvSE5sbVVBSWdNSVZGUGFUektGSEJHeVdYVCt4WVJp?=
 =?utf-8?B?TVpNWi9RNDExeVVkUE9zbTg4aUx1b3c2a0N3aVI4Wkh5Q3N5bEtHNDMrL0hE?=
 =?utf-8?B?SWNkVWh4d3dhMUxhQTdNM1BhT1p4TE1KUldwU1c4di94QStaT2hkV1lZK1J2?=
 =?utf-8?B?dzk2SGJQK05FcDRzd041RWQ5OEorUllsUG0yQStrMFpVMTMyc0tEY0ZKYUYv?=
 =?utf-8?B?NHk3RFp3OEpkdUg2cllxYkIvU1VaWjlkcW9CdTVUdFMveVByNWtVN2V5dkdI?=
 =?utf-8?B?Rm5seitDUFpsY25wRWllc3BqMUg0THIrcVVyRW83aWlFcUZEeTVKNG9GbWFW?=
 =?utf-8?B?aElmU0xuYXlvVkNGUmVQb3dqWHB0OEwwYVQzbGlzZlJBNTkzczlONUl4a0tD?=
 =?utf-8?B?NSt2V2dMMUZYNjhaR0N1WjJ5R3JHSlgwdm9EOW56clM2SDVIRDNDcW9JeVFD?=
 =?utf-8?B?R1BXT0Q5cVVHakthc1Vnd1JxR082RDlqb2g5WlZISVVpeHBNQ1BqeW1jZnNx?=
 =?utf-8?B?bk9EbmYxNTZpY2FQYWtDa1BvaG9OcG9Ed2g1V1lXZHdmay9tK2p6UGpNbDdQ?=
 =?utf-8?B?NHBydW5EUHFJanlUUExjVjlNMmU2dGJidkhQZHREa0NuN0F0RFY3Y3BkWm1O?=
 =?utf-8?B?dko4Mi9JUjVEV3pibXR1STVWL0UzaVV6WHB3QzdBOS9xSXFWUFhHUC9XRHM1?=
 =?utf-8?B?TEtTbU1HZmtZWVdNRlArQTlQckgzT3hKSGNCdnI5VnIvNktMUWRxQXRIZERG?=
 =?utf-8?B?RXlQTmkwMWVzdXhuL1pwSGVXOUtRdm1vM0RXZTZoQXgydnRpMjNWdS8wT01P?=
 =?utf-8?B?ZnRoOGFzczhhS1JEbUE1QVVlcTZRajF3eW1TZDd5QWZuQ0dJQm5XK3daL3kv?=
 =?utf-8?B?Y3ZxdThKNFdNTjBGZDNlcHgzSjBqOEkrcVZSUy9rVEptWXNlcVpZK213azZP?=
 =?utf-8?B?WDBTNEhzY0NlMDVCeUd6WERWWlZiWlh1SGJPZFV1dnNwWWlrVGpkVzFTUTgr?=
 =?utf-8?B?d21GcHVMN3JWd0lXdENmUkozZnVsOXVudjR4YnRLUU8vREdZbDROTnpxOTdo?=
 =?utf-8?B?aGtxVE1ScGFSaWQwOXVHYlBmNkpnNFEvbFVQemdDQStrV0ozNUV0MmUwaU40?=
 =?utf-8?B?NEtCbit2NzBuZTQvQjdIU0xPQnYzRFVWWTg5UmdpRmdWWEpVSzJXb0YvWTVr?=
 =?utf-8?B?RlRaSUwxS1hzdmdDUUduaG5tNVl0cm9qUEpSZ2RIREZRWVMzTjhpWXNWZVVD?=
 =?utf-8?B?Y1V0cklrdkxuTlFYa3c5VjJvRGxVM2xodHgyWDBFK2p5cm5mS0VzOGtDTVRr?=
 =?utf-8?B?aExJajg3VHRTMXBYeE5YTDFWT3EyaGNvN1NIM2t0QXJsQ2FsNk9UdTBPVGNi?=
 =?utf-8?B?VklTZlBOelhhQWgzSWdIZVdYRTlMQXhvZTk5b0xhdEVJQzdYWDQ4dGxWTjVy?=
 =?utf-8?B?SFpnR2JnWWN6L3RadkxyMjNTdHRQVnFGcG92WHpWYzVVdlRPdDgxSUt6TElK?=
 =?utf-8?B?WXhlY3FxMWthWnVoQk1oR0FyRFFmYnBHNGc0SmtMVTVhUTNCWkg3VnFJZGVu?=
 =?utf-8?B?ZVZDcUl2RnpwbVFiV1VZZ243RVBCbVAzTmVSV2p3NW9oeXllQ2FxRTN5MTRs?=
 =?utf-8?B?ZTU5V1pza2o0djRGYWdmaitHVHlhU2dDSTVFN0xEL1QvUWlhUnVrekJXZS80?=
 =?utf-8?B?SFZTOUZmd3BQaHRzeG9yV3BWcXVVWGo2Yk1idXptd25IaVczZk9aVVZUZ3Z4?=
 =?utf-8?B?dlkzUzkwSkQyUmp1QUpHbnYxSGhYeUwrdENEV1Bjb04xME5rRU90ajRYYnNl?=
 =?utf-8?B?bzY2ZFhkVTd0YVBBNlVBbEgxUUpzRm93M2JHTzN6VjBqUU96SlZxTEdhSUhj?=
 =?utf-8?B?WGthaVM1TWJiMitmZzN2amZtclEzSVQ0enQ1eTNtR3J0ZUxEWU4xeTVHYndu?=
 =?utf-8?Q?ZxORxp2bn71ozuz9XjnC9Bg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d21b4e-62e9-41c6-ca0f-08db00c4419c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 00:11:51.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiNAVEN8K4GHDcVm5NzrJoR/8tF2c3X+BKOY7Yqxi1jHqXWkW3nYeHuhqif7Nj1W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7855
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/28 04:56, Boris Burkov wrote:
> On Mon, Jan 09, 2023 at 02:11:15PM +0800, Qu Wenruo wrote:
>> [BUG]
>> When scrubing an empty fs with RAID0, we will call scrub_simple_mirror()
>> again and again on ranges which has no extent at all.
>>
>> This is especially obvious if we have both RAID0 and SINGLE.
>>
>>   # mkfs.btrfs -f -m single -d raid0 $dev
>>   # mount $dev $mnt
>>   # xfs_io -f -c "pwrite 0 4k" $mnt/file
>>   # sync
>>   # btrfs scrub start -B $mnt
>>
>> With extra call trace on scrub_simple_mirror(), we got the following
>> trace:
>>
>>    256.028473: scrub_simple_mirror: logical=1048576 len=4194304 bg=1048576 bg_len=4194304
>>    256.028930: scrub_simple_mirror: logical=5242880 len=8388608 bg=5242880 bg_len=8388608
>>    256.029891: scrub_simple_mirror: logical=22020096 len=65536 bg=22020096 bg_len=1073741824
>>    256.029892: scrub_simple_mirror: logical=22085632 len=65536 bg=22020096 bg_len=1073741824
>>    256.029893: scrub_simple_mirror: logical=22151168 len=65536 bg=22020096 bg_len=1073741824
>>    ... 16K lines skipped ...
>>    256.048777: scrub_simple_mirror: logical=1095630848 len=65536 bg=22020096 bg_len=1073741824
>>    256.048778: scrub_simple_mirror: logical=1095696384 len=65536 bg=22020096 bg_len=1073741824
>>
>> The first two lines shows we just call scrub_simple_mirror() for the
>> metadata and system chunks once.
>>
>> But later 16K lines are all scrub_simple_mirror() for the almost empty
>> RAID0 data block group.
>>
>> Most of the calls would exit very quickly since there is no extent in
>> that data chunk.
>>
>> [CAUSE]
>> For RAID0/RAID10 we go scrub_simple_stripe() to handle the scrub for the
>> block group. And since inside each stripe it's just plain SINGLE/RAID1,
>> thus we reuse scrub_simple_mirror().
>>
>> But there is a pitfall, that inside scrub_simple_mirror() we will do at
>> least one extent tree search to find the extent in the range.
>>
>> Just like above case, we can have a huge gap which has no extent in them
>> at all.
>> In that case, we will do extent tree search again and again, even we
>> already know there is no more extent in the block group.
>>
>> [FIX]
>> To fix the super inefficient extent tree search, we introduce
>> @found_next parameter for the following functions:
>>
>> - find_first_extent_item()
>> - scrub_simple_mirror()
>>
>> If the function find_first_extent_item() returns 1 and @found_next
>> pointer is provided, it will store the bytenr of the bytenr of the next
>> extent (if at the end of the extent tree, U64_MAX is used).
>>
>> So for scrub_simple_stripe(), after scrubing the current stripe and
>> increased the logical bytenr, we check if our next range reaches
>> @found_next.
>>
>> If not, increase our @cur_logical by our increment until we reached
>> @found_next.
>>
>> By this, even for an almost empty RAID0 block group, we just execute
>> "cur_logical += logical_increment;" 16K times, not doing tree search 16K
>> times.
>>
>> With the optimization, the same trace looks like this now:
>>
>>    1283.376212: scrub_simple_mirror: logical=1048576 len=4194304 bg=1048576 bg_len=4194304
>>    1283.376754: scrub_simple_mirror: logical=5242880 len=8388608 bg=5242880 bg_len=8388608
>>    1283.377623: scrub_simple_mirror: logical=22020096 len=65536 bg=22020096 bg_len=1073741824
>>    1283.377625: scrub_simple_mirror: logical=67108864 len=65536 bg=22020096 bg_len=1073741824
>>    1283.377627: scrub_simple_mirror: logical=67174400 len=65536 bg=22020096 bg_len=1073741824
>>
>> Note the scrub at logical 67108864, that's because the 4K write only
>> lands there, not at the beginning of the data chunk (due to super block
>> reserved space split the 1G chunk into two parts).
>>
>> And the time duration of the chunk 22020096 is much shorter
>> (18887us vs 4us).
> 
> Nice! The optimization makes sense, and LGTM.
> 
>>
>> Unfortunately this optimization only works for RAID0/RAID10 with big
>> holes in the block group.
>>
>> For real world cases it's much harder to find huge gaps (although we can
>> still skip several stripes).
>> And even for the huge gap cases, the optimization itself is hardly
>> observable (less than 1 second even for an almost empty 10G block group).
>>
>> And also unfortunately for RAID5 data stripes, we can not go the similar
>> optimization for RAID0/RAID10 due to the extra rotation.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/scrub.c | 46 +++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 37 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 52b346795f66..c60cd4fd9355 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -3066,7 +3066,8 @@ static int compare_extent_item_range(struct btrfs_path *path,
>>    */
>>   static int find_first_extent_item(struct btrfs_root *extent_root,
>>   				  struct btrfs_path *path,
>> -				  u64 search_start, u64 search_len)
>> +				  u64 search_start, u64 search_len,
>> +				  u64 *found_next)
> 
> I think at the very least, it would be nice to document the found_next
> parameter in the function documentation.
> 
> Going one step further, I think the semantics could probably be
> streamlined as well. I'm thinking something along the lines of always
> using the path parameter to return the extent, and then the caller can
> decide whether to grab the "found_next" from that before releasing the
> path.

That sounds pretty reasonable.

Let me explore this idea more, one less argument is always a good thing.

Thanks,
Qu
> 
> I don't see much harm in always filling in the "next" return, even if
> RAID5 wants to ignore it.
> 
> Thanks,
> Boris
> 
>>   {
>>   	struct btrfs_fs_info *fs_info = extent_root->fs_info;
>>   	struct btrfs_key key;
>> @@ -3102,8 +3103,11 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
>>   search_forward:
>>   	while (true) {
>>   		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>> -		if (key.objectid >= search_start + search_len)
>> +		if (key.objectid >= search_start + search_len) {
>> +			if (found_next)
>> +				*found_next = key.objectid;
>>   			break;
>> +		}
>>   		if (key.type != BTRFS_METADATA_ITEM_KEY &&
>>   		    key.type != BTRFS_EXTENT_ITEM_KEY)
>>   			goto next;
>> @@ -3111,8 +3115,11 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
>>   		ret = compare_extent_item_range(path, search_start, search_len);
>>   		if (ret == 0)
>>   			return ret;
>> -		if (ret > 0)
>> +		if (ret > 0) {
>> +			if (found_next)
>> +				*found_next = key.objectid;
>>   			break;
>> +		}
>>   next:
>>   		path->slots[0]++;
>>   		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
>> @@ -3120,6 +3127,13 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
>>   			if (ret) {
>>   				/* Either no more item or fatal error */
>>   				btrfs_release_path(path);
>> +
>> +				/*
>> +				 * No more extent tree items, set *found_next
>> +				 * directly to U64_MAX.
>> +				 */
>> +				if (ret > 0 && found_next)
>> +					*found_next = U64_MAX;
>>   				return ret;
>>   			}
>>   		}
>> @@ -3186,7 +3200,8 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
>>   		u64 extent_mirror_num;
>>   
>>   		ret = find_first_extent_item(extent_root, path, cur_logical,
>> -					     logical + map->stripe_len - cur_logical);
>> +					     logical + map->stripe_len - cur_logical,
>> +					     NULL);
>>   		/* No more extent item in this data stripe */
>>   		if (ret > 0) {
>>   			ret = 0;
>> @@ -3385,7 +3400,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>>   			       struct map_lookup *map,
>>   			       u64 logical_start, u64 logical_length,
>>   			       struct btrfs_device *device,
>> -			       u64 physical, int mirror_num)
>> +			       u64 physical, int mirror_num,
>> +			       u64 *found_next)
>>   {
>>   	struct btrfs_fs_info *fs_info = sctx->fs_info;
>>   	const u64 logical_end = logical_start + logical_length;
>> @@ -3437,7 +3453,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>>   		spin_unlock(&bg->lock);
>>   
>>   		ret = find_first_extent_item(extent_root, &path, cur_logical,
>> -					     logical_end - cur_logical);
>> +					     logical_end - cur_logical,
>> +					     found_next);
>>   		if (ret > 0) {
>>   			/* No more extent, just update the accounting */
>>   			sctx->stat.last_physical = physical + logical_length;
>> @@ -3552,6 +3569,7 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
>>   	int ret = 0;
>>   
>>   	while (cur_logical < bg->start + bg->length) {
>> +		u64 found_next = 0;
>>   		/*
>>   		 * Inside each stripe, RAID0 is just SINGLE, and RAID10 is
>>   		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
>> @@ -3559,13 +3577,23 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
>>   		 */
>>   		ret = scrub_simple_mirror(sctx, extent_root, csum_root, bg, map,
>>   					  cur_logical, map->stripe_len, device,
>> -					  cur_physical, mirror_num);
>> +					  cur_physical, mirror_num, &found_next);
>>   		if (ret)
>>   			return ret;
>>   		/* Skip to next stripe which belongs to the target device */
>>   		cur_logical += logical_increment;
>>   		/* For physical offset, we just go to next stripe */
>>   		cur_physical += map->stripe_len;
>> +
>> +		/*
>> +		 * If the next extent is still beyond our current range, we
>> +		 * can skip them until the @found_next.
>> +		 */
>> +		while (cur_logical + map->stripe_len < found_next &&
>> +		       cur_logical < bg->start + bg->length) {
>> +			cur_logical += logical_increment;
>> +			cur_physical += map->stripe_len;
>> +		}
>>   	}
>>   	return ret;
>>   }
>> @@ -3652,7 +3680,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>>   		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
>>   				bg->start, bg->length, scrub_dev,
>>   				map->stripes[stripe_index].physical,
>> -				stripe_index + 1);
>> +				stripe_index + 1, NULL);
>>   		offset = 0;
>>   		goto out;
>>   	}
>> @@ -3706,7 +3734,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>>   		 */
>>   		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
>>   					  logical, map->stripe_len,
>> -					  scrub_dev, physical, 1);
>> +					  scrub_dev, physical, 1, NULL);
>>   		if (ret < 0)
>>   			goto out;
>>   next:
>> -- 
>> 2.39.0
>>
