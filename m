Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D672A74ECF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGKLeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 07:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKLeB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 07:34:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99841121
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689075234; x=1689680034; i=quwenruo.btrfs@gmx.com;
 bh=MBTSXg+p6QJdQyPI4P3DPe9wTV9mN3eOZZhc3I+gr6Q=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=p2YAWd/WF0LhIcuGe7bMwo7+1aBg3BaDxpBHoMExGVIbpEH8PRJ+LYGxFiXdPGASMV0yQkF
 xbYishS66Q+JcNB19H0f4H/Qv06JNB9brZhdeN7alt7/naVj95t/RcQ5qe+kZEtXg4VlWcvOL
 LuRukZeExIY1LRLH0MT0r11RuA3oXiJ9OntzfuzuYd8Q+bHEmXMXjoy/xohijj9hTAZb4Fxor
 cbJSz92bdnvmwm25l5NwPH0wzdbjVEAcT1PlVGR4LXHov7FhR9aiNruENPuWDkaSuGzfLD74n
 +vlUeIlw4fOop38nnNvKysxGH/rsjla7cCvajqYJuHBVC6T4oCKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHQX-1pYoJc30FV-00kg9R; Tue, 11
 Jul 2023 13:33:54 +0200
Message-ID: <9e05c3b9-301c-84c5-385d-6ca4bfa179f4@gmx.com>
Date:   Tue, 11 Jul 2023 19:33:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Content-Language: en-US
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, Tim Cuthbertson <ratcheer@gmail.com>,
        Qu Wenruo <wqu@suse.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <2311414.ElGaqSPkdT@lichtvoll.de>
 <151906c5-6b6f-bb57-ab68-f8bb2edad1a0@suse.com>
 <5977988.lOV4Wx5bFT@lichtvoll.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <5977988.lOV4Wx5bFT@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EbdUO09Hhc09oLHHyYP86p/R+LHYj+5dWpBSZZrxEKwQRGSJb13
 60pm7ggBk3OrKtzzh63JEzfV6Ha5OIkcEGvXEfE//TUiTES/FGApydnraePVCqVyPqliGGj
 t3ANJvtX9LS6nC4RNHJc43sMCVEnATJpVikQ0ygCSSI6+/CRgRAJOc2g+3mbZv3NvTzeAnt
 o5cX0q55j9MbeSSfpsnfw==
UI-OutboundReport: notjunk:1;M01:P0:G0MScaH+p4c=;3N84mF9ynGE5qsFqwRIKq4xkh3n
 vzHk039PGFZAKpYr9jIHAa21N6/jLbK8aYbPsnZeaKMfYNRKiU1R1fsEQzmS+WGEhNJ2C+rQN
 HK+4EWYZR4Km3vJwOPuKllk3CwIfs1fGw9sPlmDCOn6eAeLwbSwu/7Lrd8HbxuMVzvTtK+8DD
 eZlADwFCoMjHbxll6lhFFaaF/uCsuqAlBK1AKXAVriesG4OZ7uIIGoK0P8qNsI1y3y52hvgIs
 33jTYXYPUB3D47VbG87yY8Z218ghH1GaVWHDpBLBxWcJJMCX4Jn3gsS2IBkIjV03cPp67zL4j
 XC6qWiff7nWdejQUzYEcsbR/HRyEE77pazoAdKM+JB1kCw5UpnSjkG+tBRPJUVRMFmqpBoKmI
 +wLgwqOBPmICeccVSytcB9t1fZXdD48ecc2t1Kjp1F37rtQ+4f9CROHOMbScaceS6WLHN7P+Q
 8rPgdqlnBZrA/QdngvEF+yPxoXklcItCi067XkXlI9Z7VYDseOrYXYHFXyfLWwSM6531B2aGg
 7Wbck0EQvapS8T3b0MStUIqLBzgUMDPCAspuxFrSGo/QZEWh2W0NgosUk8qHeUsaMmsWUe5kr
 VIFWdfbwTmTA5uV5lg3P6lNxeMSIOiyUM3dG7t3ThKyG8XjubnrYV/AodQOOGWh2vqQtRZGqI
 QFGz2gcFExhSmwUhF3yhUs9plk+ahfMemfuiK6EZOXuAc1XDVpMnUYnPqXTBfKITpvPcVw0rF
 nJCSBYNkt+5q+5fpmPK39H4OM+Jwtr5s1/yuHH5d8uLqyjgYZ3w903riziJRR3vny9rS6rt5J
 BriKWwGJGT4DOIPwZBfalrTgTcbUwZxfyaMA5AdEqnd3IQ1siBAObLB/aUID//xKJAxHgG9Gd
 mYcRszLpBCf203CZWl8CE+rXrpmlSTYQg6wEBFuUgY7QBN2JLPk9pKc0hYHL+mqiWyKCgRj5P
 sApaW7KBlhOiiUWe86UvcBIBrRU=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/11 19:26, Martin Steigerwald wrote:
> Qu Wenruo - 11.07.23, 13:05:42 CEST:
>> On 2023/7/11 18:56, Martin Steigerwald wrote:
>>> Qu Wenruo - 11.07.23, 11:57:52 CEST:
>>>> On 2023/7/11 17:25, Martin Steigerwald wrote:
>>>>> Qu Wenruo - 11.07.23, 10:59:55 CEST:
>>>>>> On 2023/7/11 13:52, Martin Steigerwald wrote:
>>>>>>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
>>>>>>>> I see about 180000 reads in 10 seconds in atop. I have seen
>>>>>>>> latency
>>>>>>>> values from 55 to 85 =C2=B5s which is highly unusual for NVME SSD
>>>>>>>> ("avio"
>>>>>>>> in atop=C2=B9).
> [=E2=80=A6]
>>>>>> Mind to try the following branch?
>>>>>>
>>>>>> https://github.com/adam900710/linux/tree/scrub_multi_thread
>>>>>>
>>>>>> Or you can grab the commit on top and backport to any kernel >=3D
>>>>>> 6.4.
>>>>>
>>>>> Cherry picking the commit on top of v6.4.3 lead to a merge
>>>>> conflict.
> [=E2=80=A6]
>>>> Well, I have only tested that patch on that development branch,
>>>> thus I can not ensure the result of the backport.
>>>>
>>>> But still, here you go the backported patch.
>>>>
>>>> I'd recommend to test the functionality of scrub on some less
>>>> important machine first then on your production latptop though.
>>>
>>> I took this calculated risk.
>>>
>>> However, while with the patch applied there seem to be more kworker
>>> threads doing work using 500-600% of CPU time in system (8 cores
>>> with
>>> hyper threading, so 16 logical cores) the result is even less
>>> performance. Latency values got even worse going up to 0,2 ms. An
>>> unrelated BTRFS filesystem in another logical volume is even stalled
>>> to almost a second for (mostly) write accesses.
>>>
>>> Scrubbing about 650 to 750 MiB/s for a volume with about 1,2 TiB of
>>> data, mostly in larger files. Now on second attempt even only 620
>>> MiB/s. Which is less than before. Before it reaches about 1 GiB/s.
>>> I made sure that no desktop search indexing was interfering.
>>>
>>> Oh, I forgot to mention, BTRFS uses xxhash here. However it was
>>> easily scrubbing at 1,5 to 2,5 GiB/s with 5.3. The filesystem uses
>>> zstd compression and free space tree (free space cache v2).
>>>
>>> So from what I can see here, your patch made it worse.
>>
>> Thanks for the confirming, this at least prove it's not the hashing
>> threads limit causing the regression.
>>
>> Which is pretty weird, the read pattern is in fact better than the
>> original behavior, all read are in 64K (even if there are some holes,
>> we are fine reading the garbage, this should reduce IOPS workload),
>> and we submit a batch of 8 of such read in one go.
>>
>> BTW, what's the CPU usage of v6.3 kernel? Is it higher or lower?
>> And what about the latency?
>
> CPU usage is between 600-700% on 6.3.9, Latency between 50-70 =C2=B5s. A=
nd
> scrubbing speed is above 2 GiB/s, peaking at 2,27 GiB/s. Later it went
> down a bit to 1,7 GiB/s, maybe due to background activity.

That 600~700% means btrfs is taking all its available thread_pool
(min(nr_cpu + 2, 8)).

So although the patch doesn't work as expected, we're still limited by
the csum verification part.

At least I have some clue now.
>
> I'd say the CPU usage to result (=3Dscrubbing speed) ratio is much, much
> better with 6.3. However the latencies during scrubbing are pretty much
> the same. I even seen up to 0.2 ms.
>
>> Currently I'm out of ideas, for now you can revert that testing patch.
>>
>> If you're interested in more testing, you can apply the following
>> small diff, which changed the batch number of scrub.
>>
>> You can try either double or half the number to see which change helps
>> more.
>
> No time for further testing at the moment. Maybe at a later time.
>
> It might be good you put together a test setup yourself. Any computer
> with NVME SSD should do I think. Unless there is something very special
> about my laptop, but I doubt this. This reduces greatly on the turn-
> around time.

Sure, I'll prepare a dedicated machine for this.

Thanks for all your effort!
Qu

>
> I think for now I am back at 6.3. It works. :)
>
