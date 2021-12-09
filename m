Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD7B46F189
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 18:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbhLIRZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 12:25:48 -0500
Received: from foss.arm.com ([217.140.110.172]:59974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhLIRZs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Dec 2021 12:25:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 430F5ED1;
        Thu,  9 Dec 2021 09:22:14 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BB803F5A1;
        Thu,  9 Dec 2021 09:22:13 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance patch
In-Reply-To: <87lf0y9i8x.mognet@arm.com>
References: <YaUH5GFFoLiS4/3/@localhost.localdomain> <87ee6yc00j.mognet@arm.com> <YaUYsUHSKI5P2ulk@localhost.localdomain> <87bl22byq2.mognet@arm.com> <YaUuyN3h07xlEx8j@localhost.localdomain> <878rx6bia5.mognet@arm.com> <87wnklaoa8.mognet@arm.com> <YappSLDS2EvRJmr9@localhost.localdomain> <87lf0y9i8x.mognet@arm.com>
Date:   Thu, 09 Dec 2021 17:22:05 +0000
Message-ID: <87v8zx8zia.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/12/21 09:48, Valentin Schneider wrote:
> On 03/12/21 14:00, Josef Bacik wrote:
>> On Fri, Dec 03, 2021 at 12:03:27PM +0000, Valentin Schneider wrote:
>>> Could you give the 4 top patches, i.e. those above
>>> 8c92606ab810 ("sched/cpuacct: Make user/system times in cpuacct.stat more precise")
>>> a try?
>>>
>>> https://git.gitlab.arm.com/linux-arm/linux-vs.git -b mainline/sched/nohz-next-update-regression
>>>
>>> I gave that a quick test on the platform that caused me to write the patch
>>> you bisected and looks like it didn't break the original fix. If the above
>>> counter-measures aren't sufficient, I'll have to go poke at your
>>> reproducers...
>>>
>>
>> It's better but still around 6% regression.  If I compare these patches to the
>> average of the last few days worth of runs you're 5% better than before, so
>> progress but not completely erased.
>>
>
> Hmph, time for me to reproduce this locally then. Thanks!

I carved out a partition out of an Ampere eMAG's HDD to play with BTRFS
via fsperf; this is what I get for the bisected commit (baseline is
bisected patchset's immediate parent, aka v5.15-rc4) via a handful of
./fsperf -p before-regression -c btrfs -n 100 -t emptyfiles500k

  write_clat_ns_p99     195395.92     198790.46      4797.01    1.74%
  write_iops             17305.79      17471.57       250.66    0.96%

  write_clat_ns_p99     195395.92     197694.06      4797.01    1.18%
  write_iops             17305.79      17533.62       250.66    1.32%

  write_clat_ns_p99     195395.92     197903.67      4797.01    1.28%
  write_iops             17305.79      17519.71       250.66    1.24%

If I compare against tip/sched/core however:

  write_clat_ns_p99     195395.92     202936.32      4797.01    3.86%
  write_iops             17305.79      17065.46       250.66   -1.39%

  write_clat_ns_p99     195395.92     204349.44      4797.01    4.58%
  write_iops             17305.79      17097.79       250.66   -1.20%

  write_clat_ns_p99     195395.92     204169.05      4797.01    4.49%
  write_iops             17305.79      17112.29       250.66   -1.12%

tip/sched/core + my patches:

  write_clat_ns_p99     195395.92     205721.60      4797.01    5.28%
  write_iops             17305.79      16947.59       250.66   -2.07%

  write_clat_ns_p99     195395.92     203358.04      4797.01    4.07%
  write_iops             17305.79      16953.24       250.66   -2.04%

  write_clat_ns_p99     195395.92     201830.40      4797.01    3.29%
  write_iops             17305.79      17041.18       250.66   -1.53%

So tip/sched/core seems to have a much worse regression, and my patches
are making things worse on that system...

I've started a bisection to see where the above leads me, unfortunately
this machine needs more babysitting than I thought so it's gonna take a
while.

@Josef any chance you could see if the above also applies to you? tip lives
at https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git, though from
where my bisection is taking me it looks like you should see that against
Linus' tree as well.

Thanks,
Valentin
