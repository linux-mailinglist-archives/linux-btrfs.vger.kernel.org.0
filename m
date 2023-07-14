Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01F752E47
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 02:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjGNA23 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 20:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjGNA22 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 20:28:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0F2D4B
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 17:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1689294500; x=1689899300; i=quwenruo.btrfs@gmx.com;
 bh=z2HplkV/HfY3FXpS3b+nTx96ozy0dtVoGBjU3Khj1yA=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=F+OGj/DO02GyPlbJwF8dmcLHPP8U6teZKt62lGORJ68IxISBLtQWH7rsNtlsDXfxNZXGbLm
 ROKyffFi6HU5d3TkH8xLDBbWozz+DlohHi/78ivxRbDDKpUNKYo50bnhyuzen1SteFMsyFBuM
 /oRx2TsxXO9vhVOtpjJKEhYqhAfd1H/8QKGByfNYb+NSydsHEUFzENS/1+PN+WfEA9lwnt229
 zK1ykr1mTXXCcoSlVyC5sk7vLKH0+xBAemWDAsgiC3t/rZicAxrcRXGAziXPu3f6y0sFlUGtf
 ptY/o/kSzHebLKoPef1efqEbEyQw66o4zkEgLXVvJL6hx4U+ddXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwfac-1q0mIz1yGI-00yCJo; Fri, 14
 Jul 2023 02:28:20 +0200
Message-ID: <3d9af05d-af51-22a4-3dee-2fa9e743ce68@gmx.com>
Date:   Fri, 14 Jul 2023 08:28:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, Tim Cuthbertson <ratcheer@gmail.com>,
        Qu Wenruo <wqu@suse.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <2311414.ElGaqSPkdT@lichtvoll.de>
 <151906c5-6b6f-bb57-ab68-f8bb2edad1a0@suse.com>
 <5977988.lOV4Wx5bFT@lichtvoll.de>
 <9e05c3b9-301c-84c5-385d-6ca4bfa179f4@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
In-Reply-To: <9e05c3b9-301c-84c5-385d-6ca4bfa179f4@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:edyHNrc712ds1M/bur24GngeXEz09R6eNE3VCGW5WPEagr+tZl9
 u78ybv46lB47kfumihkiTEIIukJgkwWeRfVPyKYgD3/omw8PuNv46yRsyVrqg9QkaLW9m5s
 664cymF3bbjAVbvAn78xAIPzK4lPbkBUn7DFibK8GctwwCE+qzlWjePR9FkRAQHAg8XYqpb
 NtVboCCTaSJW4IVn4Mniw==
UI-OutboundReport: notjunk:1;M01:P0:aSk/3c+ecNM=;0FisGn/6it8iFd3cjE0Fq59t5sC
 TaFubSaihQljSkLjw9DQdWB9tIKYEoC84iq/dd6FmUMLnUJ+Q/pJYp18J+y+fpba6aiz46hLE
 KHqoN+UgDy6nrXRljDrwmXeKQvic8cvAV9MPzXFU+iBoFWAtnynzT11o3ma2Fb/HCy8HO+Upm
 ued7lxrVnrTBwN51QpZyGlw0wf/PNkMDxH8+ZPgR/0oRPT/J/wB1G0VCYaMeoNnWioENKBsYc
 YgDzpOYl6r+MqCG4DKMrmbfqSM32BoBUrL9pQUskztoQu0YWugsHSIRUFxmuRrLSeARzl9yMr
 F2WWimtVjOCZTX+pQfjYZFZL5wPwK/kZDQWFW0WG6Ectivitc24JPNahjaFss/BEjEbMSK7FQ
 1i5dPnk5x1VjlHykIXEt2LDiJ8q0/F5y54jxlkJJaicTRrfyNPpaYss4UMJm+517LvqZ7p9LA
 eQwHj5thWiYXgUfu/lD2mVqWEzBZFGoJAIDpc8NmJSVpukZ2Bk0d1MKc30gAItuYbol1sfVGO
 Ae9jUmh6hu+qft9CjFVYIg7CgeOD34mnKjgTt42bjUDvyrlbW8feg/2CSrnoRne+7NwO07i/p
 cnfVff4fjn516hR84SVrfidFvfttj/NxjpKQul24TuFwjBBzmmasV5ws9+6oXvvFkzPyyesUK
 EA2+7GYMoLnSz8wLBFF5mEV3e2kr8SHDFHgxKb1iaICBP55AZCZYIC2esWWjBWQRn38EZjvKe
 5DR8axfc3lM5A9U4NTeG6W+4vO8rEiiSuBGAPdWARuT4y6UK8howQkgKsh068/PWwIAz3S4tB
 9pk98bVNVCWhh4G212/sjl5HUO4XJIeqq02URd4db55KxIuakex6hh+9gbdpQDsTqegFxXgxn
 0YgC1bLYy3DBSK82WPf7sN273EtjbPpfBlFvLIi5VXMXKtJsI5fIlnda0Ch4/DTo5bEAE7taj
 7LyKzTP1rKZaoh8Vl/IoqJxC1tQ=
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

Just a quick update on the situation.

I got a dedicated VM with a PCIE3.0 NVME passed to it without any host
cache.

With v6.3 the scrub speed can reach 3GB/s while the v6.4 (misc-next) can
only go around 1GB/s.

With dedicated VM and more comprehensive telemetry, it shows there are
two major problems:

- Lack of block layer merging
   All 64K stripes are just submitted as is, while the old code can
   merge its read requests to around 512K.

   The cause is the removal of block layer plug/unplug.

   A quick 4 lines fix can improve the performance to around 1.5GB/s.

- Bad csum distribution
   With above problem fixed, I observed that the csum verification seems
   to have only one worker.

   Still investigating the cause.

Thanks,
Qu

On 2023/7/11 19:33, Qu Wenruo wrote:
>
>
> On 2023/7/11 19:26, Martin Steigerwald wrote:
>> Qu Wenruo - 11.07.23, 13:05:42 CEST:
>>> On 2023/7/11 18:56, Martin Steigerwald wrote:
>>>> Qu Wenruo - 11.07.23, 11:57:52 CEST:
>>>>> On 2023/7/11 17:25, Martin Steigerwald wrote:
>>>>>> Qu Wenruo - 11.07.23, 10:59:55 CEST:
>>>>>>> On 2023/7/11 13:52, Martin Steigerwald wrote:
>>>>>>>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
>>>>>>>>> I see about 180000 reads in 10 seconds in atop. I have seen
>>>>>>>>> latency
>>>>>>>>> values from 55 to 85 =C2=B5s which is highly unusual for NVME SS=
D
>>>>>>>>> ("avio"
>>>>>>>>> in atop=C2=B9).
>> [=E2=80=A6]
>>>>>>> Mind to try the following branch?
>>>>>>>
>>>>>>> https://github.com/adam900710/linux/tree/scrub_multi_thread
>>>>>>>
>>>>>>> Or you can grab the commit on top and backport to any kernel >=3D
>>>>>>> 6.4.
>>>>>>
>>>>>> Cherry picking the commit on top of v6.4.3 lead to a merge
>>>>>> conflict.
>> [=E2=80=A6]
>>>>> Well, I have only tested that patch on that development branch,
>>>>> thus I can not ensure the result of the backport.
>>>>>
>>>>> But still, here you go the backported patch.
>>>>>
>>>>> I'd recommend to test the functionality of scrub on some less
>>>>> important machine first then on your production latptop though.
>>>>
>>>> I took this calculated risk.
>>>>
>>>> However, while with the patch applied there seem to be more kworker
>>>> threads doing work using 500-600% of CPU time in system (8 cores
>>>> with
>>>> hyper threading, so 16 logical cores) the result is even less
>>>> performance. Latency values got even worse going up to 0,2 ms. An
>>>> unrelated BTRFS filesystem in another logical volume is even stalled
>>>> to almost a second for (mostly) write accesses.
>>>>
>>>> Scrubbing about 650 to 750 MiB/s for a volume with about 1,2 TiB of
>>>> data, mostly in larger files. Now on second attempt even only 620
>>>> MiB/s. Which is less than before. Before it reaches about 1 GiB/s.
>>>> I made sure that no desktop search indexing was interfering.
>>>>
>>>> Oh, I forgot to mention, BTRFS uses xxhash here. However it was
>>>> easily scrubbing at 1,5 to 2,5 GiB/s with 5.3. The filesystem uses
>>>> zstd compression and free space tree (free space cache v2).
>>>>
>>>> So from what I can see here, your patch made it worse.
>>>
>>> Thanks for the confirming, this at least prove it's not the hashing
>>> threads limit causing the regression.
>>>
>>> Which is pretty weird, the read pattern is in fact better than the
>>> original behavior, all read are in 64K (even if there are some holes,
>>> we are fine reading the garbage, this should reduce IOPS workload),
>>> and we submit a batch of 8 of such read in one go.
>>>
>>> BTW, what's the CPU usage of v6.3 kernel? Is it higher or lower?
>>> And what about the latency?
>>
>> CPU usage is between 600-700% on 6.3.9, Latency between 50-70 =C2=B5s. =
And
>> scrubbing speed is above 2 GiB/s, peaking at 2,27 GiB/s. Later it went
>> down a bit to 1,7 GiB/s, maybe due to background activity.
>
> That 600~700% means btrfs is taking all its available thread_pool
> (min(nr_cpu + 2, 8)).
>
> So although the patch doesn't work as expected, we're still limited by
> the csum verification part.
>
> At least I have some clue now.
>>
>> I'd say the CPU usage to result (=3Dscrubbing speed) ratio is much, muc=
h
>> better with 6.3. However the latencies during scrubbing are pretty much
>> the same. I even seen up to 0.2 ms.
>>
>>> Currently I'm out of ideas, for now you can revert that testing patch.
>>>
>>> If you're interested in more testing, you can apply the following
>>> small diff, which changed the batch number of scrub.
>>>
>>> You can try either double or half the number to see which change helps
>>> more.
>>
>> No time for further testing at the moment. Maybe at a later time.
>>
>> It might be good you put together a test setup yourself. Any computer
>> with NVME SSD should do I think. Unless there is something very special
>> about my laptop, but I doubt this. This reduces greatly on the turn-
>> around time.
>
> Sure, I'll prepare a dedicated machine for this.
>
> Thanks for all your effort!
> Qu
>
>>
>> I think for now I am back at 6.3. It works. :)
>>
