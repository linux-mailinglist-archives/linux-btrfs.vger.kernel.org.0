Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5DE4676F8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 13:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380669AbhLCMHE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 3 Dec 2021 07:07:04 -0500
Received: from foss.arm.com ([217.140.110.172]:48330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhLCMHA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Dec 2021 07:07:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19D381396;
        Fri,  3 Dec 2021 04:03:36 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 325A23F5A1;
        Fri,  3 Dec 2021 04:03:35 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance patch
In-Reply-To: <878rx6bia5.mognet@arm.com>
References: <YaUH5GFFoLiS4/3/@localhost.localdomain> <87ee6yc00j.mognet@arm.com> <YaUYsUHSKI5P2ulk@localhost.localdomain> <87bl22byq2.mognet@arm.com> <YaUuyN3h07xlEx8j@localhost.localdomain> <878rx6bia5.mognet@arm.com>
Date:   Fri, 03 Dec 2021 12:03:27 +0000
Message-ID: <87wnklaoa8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/11/21 00:26, Valentin Schneider wrote:
> On 29/11/21 14:49, Josef Bacik wrote:
>> On Mon, Nov 29, 2021 at 06:31:17PM +0000, Valentin Schneider wrote:
>>> On 29/11/21 13:15, Josef Bacik wrote:
>>> > On Mon, Nov 29, 2021 at 06:03:24PM +0000, Valentin Schneider wrote:
>>> >> Would you happen to have execution traces by any chance? If not I should be
>>> >> able to get one out of that fsperf thingie.
>>> >>
>>> >
>>> > I don't, if you want to tell me how I can do it right now.  I've disabled
>>> > everything on this box for now so it's literally just sitting there waiting to
>>> > have things done to it.  Thanks,
>>> >
>>>
>>> I see you have Ftrace enabled in your config, so that ought to do it:
>>>
>>>   trace-cmd record -e 'sched:*' -e 'cpu_idle' $your_test_cmd
>>>
>>
>> http://toxicpanda.com/performance/trace.dat
>>
>> it's like 16mib.  Enjoy,
>>
>
> Neat, thanks!
>
> Runqueue depth seems to be very rarely greater than 1, tasks with ~1ms
> runtime and lots of sleeping (also bursty kworker activity with activations
> of tens of µs), and some cores (Internet tells me that Xeon Bronze 3204
> doesn't have SMT) spend most of their time idling. Not the most apocalyptic
> task placement vs ILB selection, but the task activation patterns roughly
> look like what I was thinking of - there might be hope for me yet.
>
> I'll continue the headscratching after tomorrow's round of thinking juice.
>

Could you give the 4 top patches, i.e. those above
8c92606ab810 ("sched/cpuacct: Make user/system times in cpuacct.stat more precise")
a try?

https://git.gitlab.arm.com/linux-arm/linux-vs.git -b mainline/sched/nohz-next-update-regression

I gave that a quick test on the platform that caused me to write the patch
you bisected and looks like it didn't break the original fix. If the above
counter-measures aren't sufficient, I'll have to go poke at your
reproducers...

>> Josef
