Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CC2754E61
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jul 2023 12:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGPKzf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jul 2023 06:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGPKze (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jul 2023 06:55:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477011706
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jul 2023 03:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689504928; x=1690109728; i=quwenruo.btrfs@gmx.com;
 bh=bzW4WwIHZ1tQTulHc9Em5pcz6XwtziBlzSjer3nQSew=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BgSKvqBx4aZtCL8ofUweFgh16ZZjNREbA9Af3FN9gUGvE/7f/fs6AzogBuDvO7L/wv/nnLh
 ZLevGdYo568kW6AQ9/p5L8bMZFMEDLfoKcQix4I0EwQhQDcR2pgzBvBemsg+f4T0DbpMxGZ22
 6AYLphY8wXuWIgqJwaci78KPJbfZcve89RZp4Cpdu4xgyrvAN4SFe0L9Ern5Nb3zJWuWJBqCX
 7LuE/XhO+jg6Q5/wob2jn2dAdqui3f091/wVkOQAWFK8QF6ErWJQAvlUcYwVGlPgCZGOil3IV
 6yYry+aqKiAeVt44vbt7bDjWpdBjYKp/zzEx3Eyxij3X6hZfthfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Qr-1pkpe01SwF-00aG4l; Sun, 16
 Jul 2023 12:55:27 +0200
Message-ID: <d18c2da7-17f7-4d39-c511-8123484b3c08@gmx.com>
Date:   Sun, 16 Jul 2023 18:55:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
To:     =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <2311414.ElGaqSPkdT@lichtvoll.de>
 <151906c5-6b6f-bb57-ab68-f8bb2edad1a0@suse.com>
 <5977988.lOV4Wx5bFT@lichtvoll.de>
 <9e05c3b9-301c-84c5-385d-6ca4bfa179f4@gmx.com>
 <3d9af05d-af51-22a4-3dee-2fa9e743ce68@gmx.com>
 <CADkZQa=xu7h8jryjUNf_XYh=f88VTU4xNp1c7f=FxVHnmXmYoA@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CADkZQa=xu7h8jryjUNf_XYh=f88VTU4xNp1c7f=FxVHnmXmYoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jLeXnoBLHNcPjEtc2JlZillyej5UxeYlnCa4mxKhtB0gXIPQ6H7
 t6PWKuSmsyd7xtLUvArKmVsLEsOlMMHepHMYLKuCIfm2c04CRXup3rLyqS5s8n7t3x6jOGy
 iK7hYWNhB/bUsvfFM3rpwocqv6s/kpk1pS8LLc5wQ6pZojJGE34zqkXNtemEo0bWg5oWlDY
 qkQg6LDzQUlsTS3BaJ42w==
UI-OutboundReport: notjunk:1;M01:P0:LE2PudBN8YE=;F5A0gzESjoz0zOhLspL3X+lQjFY
 TEBVnDQZTqF95nVyHNSPDn5XzhMYUCtqwN6Lqk7Pjt33bDOEo0KnH2Jz74jnkoo3OeWS8zmn4
 h3C8wWiKRYEd1bw7ONljrY13yRf6mML5CAl3rNz5TL1WE9fUA83QitsY0ZkBYajV7riu3UXiW
 Qiw0J3JHitLGxRJDYbkdErvgsFolzjbKqMx5Wh/UYdeXOz2H0KC4dcMTzw5cmqYdXWwk30kqR
 iAnpWX0iiSW2GctDeakqHNJyhsLUCSSCiCnEnydea9gFMySXFSCc9ep4STSTQA0zLVEQBImHC
 vxYLXnh3dw8KdWZ3Xc9MiOpmEtZ6TpAF0owwhajBfkKFfxBtPDJNy26i1woga/cho9w1dLVmM
 Bzr40goV2MFu8GkR/3QzirTay/8wGgDn2PNh2606sI3XPf0cvJko8hsb5f8NFDy0RihBZMWxU
 TElKKqEl9t+JE6LMPJS6lZ0If0U8d1vecXtKzK7zw579CJLI5kDESY3vTNC1UMAKEMtgq7iUz
 1bFfhcVv7pZ5o6JMMu0+s+5WSaqmo71jTTPGWhD1VUiZcZ+8sUV1M18nFVwZNvPfgVjs2TMAr
 4+Pw+rhWgeVO+kxvIPB7O6rjlN7GywDvSHYDY9WHSrRsb4II9yHWty+P5EbyMR+8iUDurjv58
 T2VUDz/2ZKnxNBBgqtyDnZMbjfwHy2cuAkYdaM0Zo/boJr5eSpBSSmXRc4RFdUcWMDzks0dVT
 u9IlogS7fR8gGopHUpH9yR70ZzJnUweBagVIiqG49SCNkVCvsOidF+Cesb+IW0hfRMAn2qwlo
 xUY6Bf8s46k1Gik9kcxMoo/MCsuLmusq7E991D2M5oZ9SDQMVLrKYWdZHE1FhvoJ8pepeEhWR
 v39wb0OQPBInO6061XdLBdMCoLQDkCwrC+/54h9iVJvx4+l+vZSrsGfvJim0N8fPZbdX94Ln4
 2wMPvVklNKFZ48pd5pJrdXqT9ls=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/16 17:57, Sebastian D=C3=B6ring wrote:
> Hi all,
>
>> I got a dedicated VM with a PCIE3.0 NVME passed to it without any host
> cache.
>
>> With v6.3 the scrub speed can reach 3GB/s while the v6.4 (misc-next) ca=
n
> only go around 1GB/s.
>
> I'm also observing severely degraded scrub performance (~50%) on a
> spinning disk (on top of mdraid and LUKS). Are we sure this regression
> is in any way NVME related?

The regression would happen if the storage devices don't have any
firmware level request merge (SATA NCQ feature).

In that case, the rework scrub block size is way smaller than the old
one (64K vs 512K), which would cause performance regression.

You can try this patch to see if it helps with your setup:

https://patchwork.kernel.org/project/linux-btrfs/patch/ef3951fa130f9b61fe0=
97e8d5f6e425525165a28.1689330324.git.wqu@suse.com/

For NVME, it still doesn't reach the old performance, but for SATA HDDs
even without NCQ, it should more or less reach the old performance.

Thanks,
Qu

>
> Best regards,
> Sebastian
>
> On Fri, Jul 14, 2023 at 3:01=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>> Just a quick update on the situation.
>>
>> I got a dedicated VM with a PCIE3.0 NVME passed to it without any host
>> cache.
>>
>> With v6.3 the scrub speed can reach 3GB/s while the v6.4 (misc-next) ca=
n
>> only go around 1GB/s.
>>
>> With dedicated VM and more comprehensive telemetry, it shows there are
>> two major problems:
>>
>> - Lack of block layer merging
>>     All 64K stripes are just submitted as is, while the old code can
>>     merge its read requests to around 512K.
>>
>>     The cause is the removal of block layer plug/unplug.
>>
>>     A quick 4 lines fix can improve the performance to around 1.5GB/s.
>>
>> - Bad csum distribution
>>     With above problem fixed, I observed that the csum verification see=
ms
>>     to have only one worker.
>>
>>     Still investigating the cause.
>>
>> Thanks,
>> Qu
>>
>> On 2023/7/11 19:33, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/7/11 19:26, Martin Steigerwald wrote:
>>>> Qu Wenruo - 11.07.23, 13:05:42 CEST:
>>>>> On 2023/7/11 18:56, Martin Steigerwald wrote:
>>>>>> Qu Wenruo - 11.07.23, 11:57:52 CEST:
>>>>>>> On 2023/7/11 17:25, Martin Steigerwald wrote:
>>>>>>>> Qu Wenruo - 11.07.23, 10:59:55 CEST:
>>>>>>>>> On 2023/7/11 13:52, Martin Steigerwald wrote:
>>>>>>>>>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
>>>>>>>>>>> I see about 180000 reads in 10 seconds in atop. I have seen
>>>>>>>>>>> latency
>>>>>>>>>>> values from 55 to 85 =C2=B5s which is highly unusual for NVME =
SSD
>>>>>>>>>>> ("avio"
>>>>>>>>>>> in atop=C2=B9).
>>>> [=E2=80=A6]
>>>>>>>>> Mind to try the following branch?
>>>>>>>>>
>>>>>>>>> https://github.com/adam900710/linux/tree/scrub_multi_thread
>>>>>>>>>
>>>>>>>>> Or you can grab the commit on top and backport to any kernel >=
=3D
>>>>>>>>> 6.4.
>>>>>>>>
>>>>>>>> Cherry picking the commit on top of v6.4.3 lead to a merge
>>>>>>>> conflict.
>>>> [=E2=80=A6]
>>>>>>> Well, I have only tested that patch on that development branch,
>>>>>>> thus I can not ensure the result of the backport.
>>>>>>>
>>>>>>> But still, here you go the backported patch.
>>>>>>>
>>>>>>> I'd recommend to test the functionality of scrub on some less
>>>>>>> important machine first then on your production latptop though.
>>>>>>
>>>>>> I took this calculated risk.
>>>>>>
>>>>>> However, while with the patch applied there seem to be more kworker
>>>>>> threads doing work using 500-600% of CPU time in system (8 cores
>>>>>> with
>>>>>> hyper threading, so 16 logical cores) the result is even less
>>>>>> performance. Latency values got even worse going up to 0,2 ms. An
>>>>>> unrelated BTRFS filesystem in another logical volume is even stalle=
d
>>>>>> to almost a second for (mostly) write accesses.
>>>>>>
>>>>>> Scrubbing about 650 to 750 MiB/s for a volume with about 1,2 TiB of
>>>>>> data, mostly in larger files. Now on second attempt even only 620
>>>>>> MiB/s. Which is less than before. Before it reaches about 1 GiB/s.
>>>>>> I made sure that no desktop search indexing was interfering.
>>>>>>
>>>>>> Oh, I forgot to mention, BTRFS uses xxhash here. However it was
>>>>>> easily scrubbing at 1,5 to 2,5 GiB/s with 5.3. The filesystem uses
>>>>>> zstd compression and free space tree (free space cache v2).
>>>>>>
>>>>>> So from what I can see here, your patch made it worse.
>>>>>
>>>>> Thanks for the confirming, this at least prove it's not the hashing
>>>>> threads limit causing the regression.
>>>>>
>>>>> Which is pretty weird, the read pattern is in fact better than the
>>>>> original behavior, all read are in 64K (even if there are some holes=
,
>>>>> we are fine reading the garbage, this should reduce IOPS workload),
>>>>> and we submit a batch of 8 of such read in one go.
>>>>>
>>>>> BTW, what's the CPU usage of v6.3 kernel? Is it higher or lower?
>>>>> And what about the latency?
>>>>
>>>> CPU usage is between 600-700% on 6.3.9, Latency between 50-70 =C2=B5s=
. And
>>>> scrubbing speed is above 2 GiB/s, peaking at 2,27 GiB/s. Later it wen=
t
>>>> down a bit to 1,7 GiB/s, maybe due to background activity.
>>>
>>> That 600~700% means btrfs is taking all its available thread_pool
>>> (min(nr_cpu + 2, 8)).
>>>
>>> So although the patch doesn't work as expected, we're still limited by
>>> the csum verification part.
>>>
>>> At least I have some clue now.
>>>>
>>>> I'd say the CPU usage to result (=3Dscrubbing speed) ratio is much, m=
uch
>>>> better with 6.3. However the latencies during scrubbing are pretty mu=
ch
>>>> the same. I even seen up to 0.2 ms.
>>>>
>>>>> Currently I'm out of ideas, for now you can revert that testing patc=
h.
>>>>>
>>>>> If you're interested in more testing, you can apply the following
>>>>> small diff, which changed the batch number of scrub.
>>>>>
>>>>> You can try either double or half the number to see which change hel=
ps
>>>>> more.
>>>>
>>>> No time for further testing at the moment. Maybe at a later time.
>>>>
>>>> It might be good you put together a test setup yourself. Any computer
>>>> with NVME SSD should do I think. Unless there is something very speci=
al
>>>> about my laptop, but I doubt this. This reduces greatly on the turn-
>>>> around time.
>>>
>>> Sure, I'll prepare a dedicated machine for this.
>>>
>>> Thanks for all your effort!
>>> Qu
>>>
>>>>
>>>> I think for now I am back at 6.3. It works. :)
>>>>
