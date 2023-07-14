Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0C7531A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 08:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjGNGCC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 02:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjGNGBq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 02:01:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C442D43
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 23:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689314498; x=1689919298; i=quwenruo.btrfs@gmx.com;
 bh=xoibC5WyBmhU36AK7999JoD8DJe61nPewVoAscOONME=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=FyQOeBm1X1mY9T8qFvMnnwmRHJUTHo1EbQpO/WYxrHSafrxgDk3Q6MfEvCeIuJmRQd7krHr
 TxOWOtrSvNs4gy38Zqk0jxsYc5wD7ifOxMXUdIqBF3ca6yeBMHwJGsCEc8yFRR9q6LYj5zFYO
 3Y/sRKlHIaw4JsZXjkjwesVfD9lxrbpBEjnJjSyMSAY8Glmc7eCkreZpC0mpxhMgRnDGJfB50
 ZLImogD2Tj5DXQFx5Aa6qstcUB5tSXoVI5EuawIdOms3Y9h355Rn6lAGNThw/7Cia1pFFxoRO
 FsfgQ8l0UHMunGpdN5RrRRpBPsuPKL0m3DA6lHo8pabBeCXy8nJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBUm7-1qFUNy2GjP-00CxLQ; Fri, 14
 Jul 2023 08:01:38 +0200
Message-ID: <d235e0f0-3c36-787b-6631-667b2489600e@gmx.com>
Date:   Fri, 14 Jul 2023 14:01:34 +0800
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
 <9e05c3b9-301c-84c5-385d-6ca4bfa179f4@gmx.com>
 <3d9af05d-af51-22a4-3dee-2fa9e743ce68@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <3d9af05d-af51-22a4-3dee-2fa9e743ce68@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qySsbLttC7SA14p+vZiNk0k2CPr4y/98x1GpMlq4HK7k2OmrYsQ
 yu7g5prI/GXNCUEoghjkvhoPaOPXoYe9+UArl3ZRYm+WRPGBCrMvW1svMWKTBTZ7xSEoIre
 vwtnw/6+gqbKox+CL0TABCuQvqhXGPK+uMu7bNSsS8lBZkaprvULGKU08U6VYmCEzIrl9NS
 1nnFI+MN/HeORO+c8JWPQ==
UI-OutboundReport: notjunk:1;M01:P0:ssWrjlEKa24=;zU3oSp2cTwPTZaX9kMt5qZuUEFv
 tdqdvppJrv0z3SVTd9S9NEnLjpQReHXZFXlVa/AfHUOTlqxbGi+k/p628sCNP2mSxekHAQQIf
 gBGBR2cM85CnaZIbPqKZw83atszNk9m05QFNV6RqX3EKWbF8MngsezPlS/wE0Fhma/s24DE03
 TnzltyVf2AqAgZQ9vslj2QM3cOCroMIBW6nesr6oQ5hG1ZeazalkDgnN0fnKD5EIeOoB7XYVf
 0xe38FGMyyKcLhNtMnW5TUBcm0lWUee+0Y0+QwtVq5iVuivtQNBPsyFPxI7PEIsOBi7yLebOd
 wPaFvNj0CEX0Wz7CdCzltNpW+1xLJqacZC5LFetKn18GRXJYlagk4HnSs86k91ybzX44kVYOE
 aAWjzmcFaq7mJ+lscpbmq2kOjd3ngbLlAGxAetoU1xMr15AVbvgltMQ0KONQb0sWdMIREf6D7
 E2/TDp8SX4IfGQu7fNXUy6DaUILkaBSFyzxjIOzMvfk96QfLapufpBH+HkPsAny3Ip0n0JLqc
 awFYgwS24dTF/orbFYoUcTBcHYD5dO5YVoP0dFciUMyiSJiC2uD5ddw5iT3e1Ede8NH5Jtv86
 DkHLrlY7Y5xSTE7i6LWOlXo5klr82+517Ewx0hCs8rKMmjdRq2xbpDYQo/23CE5SzsgwS3Hy0
 ZtPWQVIhG0iwKyujuVwtnswvnZnUv/BJMwl51/3fSeAuvYvcl8w9uBLAqCZMye7Gz4sVq5mp8
 C/rIdzZ+OIcLkByApCGMG6btG5zA/HFg0NpHUPn4mMbLhG/kBsnd9vCsPn9X2aS8dkpvgG1oW
 cyZRnw4Ov4935o+GLrQnEzyKo3thzXzvtiY3yW2fXjlggLAMrYRxykX1f9sibbhXgCDJOx/Oo
 hKDstNhVca6vilLp69wZeC1VEirS1fPH79qwM0lJMMq33ELb1TK0AYGD7Dgv1Rxbi/sPab/P3
 JARQq62MVPb1KTqndCjAEW0S1qI=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/14 08:28, Qu Wenruo wrote:
> Just a quick update on the situation.
>
> I got a dedicated VM with a PCIE3.0 NVME passed to it without any host
> cache.
>
> With v6.3 the scrub speed can reach 3GB/s while the v6.4 (misc-next) can
> only go around 1GB/s.
>
> With dedicated VM and more comprehensive telemetry, it shows there are
> two major problems:
>
> - Lack of block layer merging
>  =C2=A0 All 64K stripes are just submitted as is, while the old code can
>  =C2=A0 merge its read requests to around 512K.
>
>  =C2=A0 The cause is the removal of block layer plug/unplug.
>
>  =C2=A0 A quick 4 lines fix can improve the performance to around 1.5GB/=
s.
>
> - Bad csum distribution
>  =C2=A0 With above problem fixed, I observed that the csum verification =
seems
>  =C2=A0 to have only one worker.
>
>  =C2=A0 Still investigating the cause.

This turns out to be a problem with the read submission queue depth.

New:

Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz
aqu-sz  %util
vda           3982.00 1754704.00 23522.00  85.52    0.71   440.66
2.85 100.00

Old:
Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz
aqu-sz  %util
vda           7640.00 3427420.00 19355.00  71.70    2.17   448.62
16.60 100.00

The queue depth change means we may need a change to the mostly
submit-and-wait behavior of the stripe handling...

Thanks,
Qu

>
> Thanks,
> Qu
>
> On 2023/7/11 19:33, Qu Wenruo wrote:
>>
>>
>> On 2023/7/11 19:26, Martin Steigerwald wrote:
>>> Qu Wenruo - 11.07.23, 13:05:42 CEST:
>>>> On 2023/7/11 18:56, Martin Steigerwald wrote:
>>>>> Qu Wenruo - 11.07.23, 11:57:52 CEST:
>>>>>> On 2023/7/11 17:25, Martin Steigerwald wrote:
>>>>>>> Qu Wenruo - 11.07.23, 10:59:55 CEST:
>>>>>>>> On 2023/7/11 13:52, Martin Steigerwald wrote:
>>>>>>>>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
>>>>>>>>>> I see about 180000 reads in 10 seconds in atop. I have seen
>>>>>>>>>> latency
>>>>>>>>>> values from 55 to 85 =C2=B5s which is highly unusual for NVME S=
SD
>>>>>>>>>> ("avio"
>>>>>>>>>> in atop=C2=B9).
>>> [=E2=80=A6]
>>>>>>>> Mind to try the following branch?
>>>>>>>>
>>>>>>>> https://github.com/adam900710/linux/tree/scrub_multi_thread
>>>>>>>>
>>>>>>>> Or you can grab the commit on top and backport to any kernel >=3D
>>>>>>>> 6.4.
>>>>>>>
>>>>>>> Cherry picking the commit on top of v6.4.3 lead to a merge
>>>>>>> conflict.
>>> [=E2=80=A6]
>>>>>> Well, I have only tested that patch on that development branch,
>>>>>> thus I can not ensure the result of the backport.
>>>>>>
>>>>>> But still, here you go the backported patch.
>>>>>>
>>>>>> I'd recommend to test the functionality of scrub on some less
>>>>>> important machine first then on your production latptop though.
>>>>>
>>>>> I took this calculated risk.
>>>>>
>>>>> However, while with the patch applied there seem to be more kworker
>>>>> threads doing work using 500-600% of CPU time in system (8 cores
>>>>> with
>>>>> hyper threading, so 16 logical cores) the result is even less
>>>>> performance. Latency values got even worse going up to 0,2 ms. An
>>>>> unrelated BTRFS filesystem in another logical volume is even stalled
>>>>> to almost a second for (mostly) write accesses.
>>>>>
>>>>> Scrubbing about 650 to 750 MiB/s for a volume with about 1,2 TiB of
>>>>> data, mostly in larger files. Now on second attempt even only 620
>>>>> MiB/s. Which is less than before. Before it reaches about 1 GiB/s.
>>>>> I made sure that no desktop search indexing was interfering.
>>>>>
>>>>> Oh, I forgot to mention, BTRFS uses xxhash here. However it was
>>>>> easily scrubbing at 1,5 to 2,5 GiB/s with 5.3. The filesystem uses
>>>>> zstd compression and free space tree (free space cache v2).
>>>>>
>>>>> So from what I can see here, your patch made it worse.
>>>>
>>>> Thanks for the confirming, this at least prove it's not the hashing
>>>> threads limit causing the regression.
>>>>
>>>> Which is pretty weird, the read pattern is in fact better than the
>>>> original behavior, all read are in 64K (even if there are some holes,
>>>> we are fine reading the garbage, this should reduce IOPS workload),
>>>> and we submit a batch of 8 of such read in one go.
>>>>
>>>> BTW, what's the CPU usage of v6.3 kernel? Is it higher or lower?
>>>> And what about the latency?
>>>
>>> CPU usage is between 600-700% on 6.3.9, Latency between 50-70 =C2=B5s.=
 And
>>> scrubbing speed is above 2 GiB/s, peaking at 2,27 GiB/s. Later it went
>>> down a bit to 1,7 GiB/s, maybe due to background activity.
>>
>> That 600~700% means btrfs is taking all its available thread_pool
>> (min(nr_cpu + 2, 8)).
>>
>> So although the patch doesn't work as expected, we're still limited by
>> the csum verification part.
>>
>> At least I have some clue now.
>>>
>>> I'd say the CPU usage to result (=3Dscrubbing speed) ratio is much, mu=
ch
>>> better with 6.3. However the latencies during scrubbing are pretty muc=
h
>>> the same. I even seen up to 0.2 ms.
>>>
>>>> Currently I'm out of ideas, for now you can revert that testing patch=
.
>>>>
>>>> If you're interested in more testing, you can apply the following
>>>> small diff, which changed the batch number of scrub.
>>>>
>>>> You can try either double or half the number to see which change help=
s
>>>> more.
>>>
>>> No time for further testing at the moment. Maybe at a later time.
>>>
>>> It might be good you put together a test setup yourself. Any computer
>>> with NVME SSD should do I think. Unless there is something very specia=
l
>>> about my laptop, but I doubt this. This reduces greatly on the turn-
>>> around time.
>>
>> Sure, I'll prepare a dedicated machine for this.
>>
>> Thanks for all your effort!
>> Qu
>>
>>>
>>> I think for now I am back at 6.3. It works. :)
>>>
