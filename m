Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903AB74EC3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjGKLF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGKLF4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 07:05:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073CF97
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 04:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV2u02UULlr8tqmjVlU+wwCGn6zPKWpLI3kYEfOaEoPocB5mmxOjq6ZpLKZxI7BCGnIB9/d12n31Us9jKV1uUG06NHWgRABWzqL91ItqYTO6DEzy0Ytlq4N0D62BsHI1r+vBB7IQ7gw7xqr/1tzKuqVDXlxxQW30GNgPBzZfECqxURyBeu3PRY93O96sL6LTCkMUTxZf9DN2L66H2TekFD30zX9Mknc9bFqGSqgukLuMBSf0O1ypOfYAiG2vQ7t1YPEL4QTLwg87hqzLCNvaGLFqJh8pfg/GMIjIIOxcGIsyp7aIj5Y1mf7hgYzYtQc/tkiZAT93OLgrRmWaHhMsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rARxPRy2RYkaqTbG9RBf+BK3aO1JLR8t/HvwVgyLA5w=;
 b=WYrvRTHng7OHD3xj8VTZEU54ELwwhtInj+dOUNzj4yu28fTwMmJj7tnpj6DOyBOwslR+DruuqDhqGxx/X7IQzOPx0hiAvuY4t96IFxrgMfyIsDiGNh7iWi6+tnw6guIl1+ZTJsApkrTLCC3nvNW1OpI6reQhAu4aleGuZdnRFXoonjjySFK1oFhmyQ9mX5Gchf0dvuEPMV94aUbFoAeKsvxCk6yHAJXujD7+xdRnRGhMKzuD93guQpqhU3qmfEJJa8AqeLXHD5C8lyb4mNaNlD6bFmiWDWnSwhPhKQVrTrOO0hjpCw+TczVC+FBC6pBJ2fe7hRwhbNY1ugoX5xdKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rARxPRy2RYkaqTbG9RBf+BK3aO1JLR8t/HvwVgyLA5w=;
 b=MMPkr3fxaPPnxt2JeEwE/nJAII/+1n1mCVG4LtCTh0tERpG37xT242OO1v/y9afwVkuvDtBqMs7bObG6k0vN+nWDyZbPikCAIhkx5bYh+5IyflMom95g9VrFqxx7IXozpKW1rSdOqmLayx4460OyWrOVSerT6h5B9zpZPeSZkVbqFHU3Bbbgb0tp3kwHcfwG3N1My0gYMUcOHubeyvfAot0nKT27i5S7xeFF06ywmIXAkIY3YsDzcXPqHn+BtEe7p+hG2oLcIy3OW8JYjvwb7rTgjGVMIM8hrY9ejS3r+5cC/8a2Bu6LgRHg7iLOZn2Q/1sRvpjmqSCHGvid7zTFfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB9685.eurprd04.prod.outlook.com (2603:10a6:102:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 11:05:52 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 11:05:52 +0000
Message-ID: <151906c5-6b6f-bb57-ab68-f8bb2edad1a0@suse.com>
Date:   Tue, 11 Jul 2023 19:05:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, Tim Cuthbertson <ratcheer@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <1956200.usQuhbGJ8B@lichtvoll.de>
 <3ff556b9-2450-e5d3-2ad3-34a52e723f27@suse.com>
 <2311414.ElGaqSPkdT@lichtvoll.de>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
In-Reply-To: <2311414.ElGaqSPkdT@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: 01411a45-7214-4ad1-13de-08db81fecab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vABeNtcLtqMgTvGuSQ1poL++a+rQ6TNGNAWa+GKdcVryvlDZYxlNZfGKBCD7PWwdAV4PEOtjzZeV+rxDzd7Y6DS/8wm6qXQqLIEzoA9ffoWcOR97gpgLPRyJHgIEL6k3aBB8uMXfVOOw1MGIb8tEbcF7lClRS6sCd1lpwKHLig1JUDzYzYktEtjghEBZ8hKbu6uQRBsYeReCJQONBOuvd7C0MI8Zjs74z3GJx69uPKs3OnCUYh+24nw86qrFNsBCN0VV5OXQ/MEhfwdzYeOEc/f185TTwc9G1j34Odxo5R5mkw8uVdmQyWF7qud4nshafw+E0cxNWGvfd5M9wggknS8roEGwl45/2hsbXpCjjIYsrZbHFPpTP89UsUhQrQelpXGyFmN0XT5fg0wQkWPfafWga8nG0O7hz5zxK3krk9H2LjAZryCZRhseRY2y5hHUlxpyTAiT0flp+u+Wk1UI1bnBnQTP/pazbhB0g2uMTQwj5IrNumqsWOL5TLotJGuWDfYucuiaoXR4xjjsOfE2YyPEXluK0exWvNlUagJbMF/CcpQEztMU5K+sbxAZwSOzGs8S5DbIut33twBui4EuGgjPpac+n440656+U6scrRxpKWyB+QgotyJMZcp4ZPn82mivOVvorFBEuIYMNRxzVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(966005)(6512007)(316002)(6666004)(6486002)(110136005)(38100700002)(478600001)(2906002)(36756003)(66476007)(66556008)(66946007)(2616005)(83380400001)(186003)(5660300002)(8676002)(8936002)(31686004)(31696002)(41300700001)(86362001)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blA4d25hcytoNmRyMUUwUU0rYWpnejNKU09hYWM1c1RWVHB4T2NkWmdsNjVh?=
 =?utf-8?B?TTJUbmF6SzRaYmw4Mmh5c0hzbUFNTVlBYWZtWHVmYVFoWmpDZ3hxa2hTck05?=
 =?utf-8?B?TlBONmFIMFcwcVJjUVU2UHVJQ1owYlI2NjkyaG9VQ2tncGJITGIrTmczT0RF?=
 =?utf-8?B?amo1QmU5d01sbHU1VWRwNXRPMTljWm8wYzBZZ2VPSmlrZUxCdW9ZQ1JXSlRB?=
 =?utf-8?B?U1ZDZHlZRzVEYWJyNEhoRnltS2xqOG4vUlprRFMwczFGdW1RTzdYRVEybTlO?=
 =?utf-8?B?Vlg4ZkwvSDBKczQ4VDFMWkVmUHFSbWU3dnFNTExtNzdtZ1FOcllIYnFnbnBx?=
 =?utf-8?B?U0sxMGw5eTI3a0drV1BHNFgra1lCSXN6NGMzelN4YzgwQXozcGcvRmt0d3lB?=
 =?utf-8?B?OEQxeVIrb3RCNlJsNFhmNFJFZjMwandtalFlWFIrR2Jyd2NkZklDSUoxN2NY?=
 =?utf-8?B?S1JzV0QwcDNKMWxNRW5EM1oxWkx3NmN0RVh4L2xZbmlXL1VXbkxGSVpJeW03?=
 =?utf-8?B?T3B3OVZGRjRRUERIRGVIKzVqcEdkdHNON1J3cmVGb3E3SnFpVmxzcXNnQllY?=
 =?utf-8?B?UzBybVhJSU40ZVY0bURLTU4rQjZqOStZdTlDWjZleGttVlQxNlRDK2xPdFVP?=
 =?utf-8?B?REhBRmo3MEpnVFBWUEJrSXR6WjIweEZsQk9uRytJRUp2SVZvNFlncUdFb3Ay?=
 =?utf-8?B?YzVGYmhEZGwxZDZ6dWhhQ1NZM0ZWczdORVlybWVBYXJ1YzhrOERmeDVmR21M?=
 =?utf-8?B?alVTSmZWRjd5RTNGbzdwWEVJKytrK29rM0ZKVGlDbHp0cXQrYnJVbVRmK2la?=
 =?utf-8?B?RUFYNmZNL1ZSQmd2SFdYSDJvK3VrUGZZd2RKdTdzd0J4enRlZXA5RXh4VGVI?=
 =?utf-8?B?UGNXeWZDUWxuUWFXUk5EUnNjVnlDT1BNVzBicnlGYVdITXV5RnpFNzcrSllM?=
 =?utf-8?B?dHJMT3Z6NmZjdkVoMk9UOGJxODZFQ3Fsd3NBS0tKZzdKNDdSa3RYNndFVnBP?=
 =?utf-8?B?anZXZlBlaHYwVGZJRDNjUXZ3bnkyUEJHMm15THhJTHlFZ3VIclhJM0JMWlBa?=
 =?utf-8?B?M2c3QWhMM0I1NkRaTTVIWTY2V2lsSHhqNldkNnY1azZQQ3ZGTGtYTWZFN2hw?=
 =?utf-8?B?TVRuVnZyK0ZqYWFTVjZOeEdlU0lvbUs4dzNpYzdqS2hPR04wUnBiK2JtQlM0?=
 =?utf-8?B?RVE0U1JJUEQzcXBuN2lCZTAvdjk3dyt0NmxOZGF2Tm9yZWpNYzZHUkZFYzgx?=
 =?utf-8?B?Rk1yTXoxSkdmZTFBOFZFTnd6M1h0aFFMU00vaDl4QmdYUGxnNTBoNm1RRGtU?=
 =?utf-8?B?ZGUxc2FRZzBpSW05ZEtiZW91WnZERWU0M0RkMlpENllRRXFaWTBNSUF3K1cx?=
 =?utf-8?B?OW5qZUwzclREVEMvcENrL1FHMFN4N2EyRUg4RFV3NjhiaEdITi9kVW8yTDZG?=
 =?utf-8?B?ckJEOXZDalp2dGNKWnB5UmxjbStFUnVEYkdoVy83c1BjM2xiTFpuTVVBTXZI?=
 =?utf-8?B?b0drazM4NjhSbkNTODlMQVR6eTJYSm9DVTVNZVFGODVKNnE5dDEyZmRWRVV0?=
 =?utf-8?B?UUc5ZUtCeW9CUENxaWtkZ0dYQWoyY2YwbFp5QklNZDRUU0RzMG1NQzVIZUdx?=
 =?utf-8?B?MWYwN0ZmUUIzOVBwZ1FWb25Ob0tnL3J1aDdYeGx1aXFSQmFxTEd1S1I3dnBD?=
 =?utf-8?B?Qnh2Y2Q5citUUDZhSVBhbVg4cUtiVzJyWVNWNW53TndpVTNYMDdYZ2tIV3JU?=
 =?utf-8?B?cGIyZjdoRThndG9IalhzQnUwK3A0eS9IRXZPTE1FWk53dnFWZS8vOVlJMVR3?=
 =?utf-8?B?U2cySDhJMEM4cnQzdnllQ0VvWlluRXJVSkp1MTF2L2tOWE1wdlI4anNnbVQw?=
 =?utf-8?B?ZXFySS9FTm1ZejNzV0VtOWh5ZDFhL0R6eWJwRExPWWR0V1h5N1ZmOGF5eXI1?=
 =?utf-8?B?ci8yQWxhQU9TNjVDTmc5bEdpVitxQm9NWE5hc3hwZ2xHMWRRNXgrODVzQkZn?=
 =?utf-8?B?eWRhOFZNMC8rbnBGdmthZVFOUHNPaTVLVU9oVWkvVzNScGJ6Mmt0WHpjUGRK?=
 =?utf-8?B?c1BpM2UzaTh2UXBoKzhjRGVhTGxlSmlHVnI3WlpUQzZqdEZpdk1PeVR5Wkti?=
 =?utf-8?Q?60lPT1ag3Ah/X5HzWbvorhKqd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01411a45-7214-4ad1-13de-08db81fecab0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 11:05:52.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbgBixvnY/k9WFDazxekzeFdXOrKEmQIsgPnH2hOqPSNkIljYiybO/bpSktnj/VD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9685
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



On 2023/7/11 18:56, Martin Steigerwald wrote:
> Qu Wenruo - 11.07.23, 11:57:52 CEST:
>> On 2023/7/11 17:25, Martin Steigerwald wrote:
>>> Qu Wenruo - 11.07.23, 10:59:55 CEST:
>>>> On 2023/7/11 13:52, Martin Steigerwald wrote:
>>>>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
>>>>>> I see about 180000 reads in 10 seconds in atop. I have seen
>>>>>> latency
>>>>>> values from 55 to 85 µs which is highly unusual for NVME SSD
>>>>>> ("avio"
>>>>>> in atop¹).
>>>>>
>>>>> Well I did not compare to a base line during scrub with 6.3. So
>>>>> not actually sure about the unusual bit. But at least during daily
>>>>> activity I do not see those values.
>>>>>
>>>>> Anyway, I am willing to test a patch.
>>>>
>>>> Mind to try the following branch?
>>>>
>>>> https://github.com/adam900710/linux/tree/scrub_multi_thread
>>>>
>>>> Or you can grab the commit on top and backport to any kernel >=
>>>> 6.4.
>>>
>>> Cherry picking the commit on top of v6.4.3 lead to a merge conflict.
>>> Since this is a production machine and I am no kernel developer with
>>> insight to the inner workings of BTRFS, I'd prefer a patch that
>>> applies cleanly on top of v6.4.3. I'd rather not try out a tree,
>>> unless I know its a stable kernel version or at least rc3/4 or
>>> later. Again this is a production machine.
>>
>> Well, I have only tested that patch on that development branch, thus I
>> can not ensure the result of the backport.
>>
>> But still, here you go the backported patch.
>>
>> I'd recommend to test the functionality of scrub on some less
>> important machine first then on your production latptop though.
> 
> I took this calculated risk.
> 
> However, while with the patch applied there seem to be more kworker
> threads doing work using 500-600% of CPU time in system (8 cores with
> hyper threading, so 16 logical cores) the result is even less
> performance. Latency values got even worse going up to 0,2 ms. An
> unrelated BTRFS filesystem in another logical volume is even stalled to
> almost a second for (mostly) write accesses.
> 
> Scrubbing about 650 to 750 MiB/s for a volume with about 1,2 TiB of
> data, mostly in larger files. Now on second attempt even only 620 MiB/s.
> Which is less than before. Before it reaches about 1 GiB/s. I made sure
> that no desktop search indexing was interfering.
> 
> Oh, I forgot to mention, BTRFS uses xxhash here. However it was easily
> scrubbing at 1,5 to 2,5 GiB/s with 5.3. The filesystem uses zstd
> compression and free space tree (free space cache v2).
> 
> So from what I can see here, your patch made it worse.

Thanks for the confirming, this at least prove it's not the hashing 
threads limit causing the regression.

Which is pretty weird, the read pattern is in fact better than the 
original behavior, all read are in 64K (even if there are some holes, we 
are fine reading the garbage, this should reduce IOPS workload), and we 
submit a batch of 8 of such read in one go.

BTW, what's the CPU usage of v6.3 kernel? Is it higher or lower?
And what about the latency?

Currently I'm out of ideas, for now you can revert that testing patch.

If you're interested in more testing, you can apply the following small 
diff, which changed the batch number of scrub.

You can try either double or half the number to see which change helps more.

Thanks,
Qu

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 16c228344cbb..26689d98c58f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -45,7 +45,7 @@ struct scrub_ctx;
   *
   * This determines the batch size for stripe submitted in one go.
   */
-#define SCRUB_STRIPES_PER_SCTX 8       /* That would be 8 64K stripe 
per-device. */
+#define SCRUB_STRIPES_PER_SCTX 16      /* That would be 8 64K stripe 
per-device. */

  /*
   * The following value times PAGE_SIZE needs to be large enough to 
match the
> 
> Best,
