Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB147D23E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Dec 2021 13:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245164AbhLVMmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Dec 2021 07:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240781AbhLVMmW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Dec 2021 07:42:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A68C06179E;
        Wed, 22 Dec 2021 04:42:21 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n00wj-0001eL-1H; Wed, 22 Dec 2021 13:42:17 +0100
Message-ID: <99452126-661e-9a0c-6b51-d345ed0f76ee@leemhuis.info>
Date:   Wed, 22 Dec 2021 13:42:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance
 patch
Content-Language: en-BS
To:     Josef Bacik <josef@toxicpanda.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, guro@fb.com, clm@fb.com
References: <YaUH5GFFoLiS4/3/@localhost.localdomain>
 <87ee6yc00j.mognet@arm.com> <YaUYsUHSKI5P2ulk@localhost.localdomain>
 <87bl22byq2.mognet@arm.com> <YaUuyN3h07xlEx8j@localhost.localdomain>
 <878rx6bia5.mognet@arm.com> <87wnklaoa8.mognet@arm.com>
 <YappSLDS2EvRJmr9@localhost.localdomain> <87lf0y9i8x.mognet@arm.com>
 <87v8zx8zia.mognet@arm.com> <YbJWBGaGAW/MenOn@localhost.localdomain>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YbJWBGaGAW/MenOn@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1640176941;5ea55b55;
X-HE-SMSGID: 1n00wj-0001eL-1H
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

On 09.12.21 20:16, Josef Bacik wrote:
> On Thu, Dec 09, 2021 at 05:22:05PM +0000, Valentin Schneider wrote:
>> On 06/12/21 09:48, Valentin Schneider wrote:
>>> On 03/12/21 14:00, Josef Bacik wrote:
>>>> On Fri, Dec 03, 2021 at 12:03:27PM +0000, Valentin Schneider wrote:
>>>>> Could you give the 4 top patches, i.e. those above
>>>>> 8c92606ab810 ("sched/cpuacct: Make user/system times in cpuacct.stat more precise")
>>>>> a try?
>>>>>
>>>>> https://git.gitlab.arm.com/linux-arm/linux-vs.git -b mainline/sched/nohz-next-update-regression
>>>>>
>>>>> I gave that a quick test on the platform that caused me to write the patch
>>>>> you bisected and looks like it didn't break the original fix. If the above
>>>>> counter-measures aren't sufficient, I'll have to go poke at your
>>>>> reproducers...
>>>>>
>>>>
>>>> It's better but still around 6% regression.  If I compare these patches to the
>>>> average of the last few days worth of runs you're 5% better than before, so
>>>> progress but not completely erased.
>>>>
>>>
>>> Hmph, time for me to reproduce this locally then. Thanks!
>>
>> I carved out a partition out of an Ampere eMAG's HDD to play with BTRFS
>> via fsperf; this is what I get for the bisected commit (baseline is
>> bisected patchset's immediate parent, aka v5.15-rc4) via a handful of
>> ./fsperf -p before-regression -c btrfs -n 100 -t emptyfiles500k
>>
>>   write_clat_ns_p99     195395.92     198790.46      4797.01    1.74%
>>   write_iops             17305.79      17471.57       250.66    0.96%
>>
>>   write_clat_ns_p99     195395.92     197694.06      4797.01    1.18%
>>   write_iops             17305.79      17533.62       250.66    1.32%
>>
>>   write_clat_ns_p99     195395.92     197903.67      4797.01    1.28%
>>   write_iops             17305.79      17519.71       250.66    1.24%
>>
>> If I compare against tip/sched/core however:
>>
>>   write_clat_ns_p99     195395.92     202936.32      4797.01    3.86%
>>   write_iops             17305.79      17065.46       250.66   -1.39%
>>
>>   write_clat_ns_p99     195395.92     204349.44      4797.01    4.58%
>>   write_iops             17305.79      17097.79       250.66   -1.20%
>>
>>   write_clat_ns_p99     195395.92     204169.05      4797.01    4.49%
>>   write_iops             17305.79      17112.29       250.66   -1.12%
>>
>> tip/sched/core + my patches:
>>
>>   write_clat_ns_p99     195395.92     205721.60      4797.01    5.28%
>>   write_iops             17305.79      16947.59       250.66   -2.07%
>>
>>   write_clat_ns_p99     195395.92     203358.04      4797.01    4.07%
>>   write_iops             17305.79      16953.24       250.66   -2.04%
>>
>>   write_clat_ns_p99     195395.92     201830.40      4797.01    3.29%
>>   write_iops             17305.79      17041.18       250.66   -1.53%
>>
>> So tip/sched/core seems to have a much worse regression, and my patches
>> are making things worse on that system...
>>
>> I've started a bisection to see where the above leads me, unfortunately
>> this machine needs more babysitting than I thought so it's gonna take a
>> while.
>>
>> @Josef any chance you could see if the above also applies to you? tip lives
>> at https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git, though from
>> where my bisection is taking me it looks like you should see that against
>> Linus' tree as well.
>>
> 
> This has made us all curious, so we're all fucking around with schbench to see
> if we can make it show up without needing to use fsperf.  Maybe that'll help
> with the bisect, because I had to bisect twice to land on your patches, and I
> only emailed when I could see the change right before and right after your
> patch.  It would not surprise me at all if there's something else here that's
> causing us pain.

What's the status here? Just wondering, because there hasn't been any
activity in this thread since 11 days and the festive season is upon us.

Was the discussion moved elsewhere? Or is this still a mystery? And if
it is: how bad is it, does it need to be fixed before Linus releases 5.16?

Ciao, Thorsten

#regzbot poke

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply. That's in everyone's interest, as
what I wrote above might be misleading to everyone reading this; any
suggestion I gave thus might sent someone reading this down the wrong
rabbit hole, which none of us wants.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

