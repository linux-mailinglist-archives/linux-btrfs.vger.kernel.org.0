Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD069461D4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 19:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346946AbhK2SIs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 13:08:48 -0500
Received: from foss.arm.com ([217.140.110.172]:44222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242332AbhK2SGq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 13:06:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 153461063;
        Mon, 29 Nov 2021 10:03:28 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E4E43F5A1;
        Mon, 29 Nov 2021 10:03:27 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance patch
In-Reply-To: <YaUH5GFFoLiS4/3/@localhost.localdomain>
References: <YaUH5GFFoLiS4/3/@localhost.localdomain>
Date:   Mon, 29 Nov 2021 18:03:24 +0000
Message-ID: <87ee6yc00j.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi Josef,

On 29/11/21 12:03, Josef Bacik wrote:
> Hello,
>
> Our nightly performance testing found a performance regression when we rebased
> our devel tree onto v5.16-rc.  This took me a few days to bisect down, but this
> patch
>
> 7fd7a9e0caba ("sched/fair: Trigger nohz.next_balance updates when a CPU goes NOHZ-idle")
>
> is the one that introduces the regression.  My performance testing box is a 2
> socket, with a model name "Intel(R) Xeon(R) Bronze 3204 CPU @ 1.90GHz", for a
> total of 12 cpu's reported in cpuinfo.  It has 128gib of RAM, and these perf
> tests are being run against a SSD and spinning rust device, but the regression
> is consistent across both configurations.  You can see the historical graph of
> the completion latencies for this specific run
>
> http://toxicpanda.com/performance/emptyfiles500k_write_clat_ns_p99.png
>
> Or for something a little more braindead (untar firefox) you can see a increase
> in the runtime
>
> http://toxicpanda.com/performance/untarfirefox_elapsed.png
>
> These two tests are single threaded, the regression doesn't appear to affect
> multi-threaded tests.  For a simple reproducer you can simply download a tarball
> of the firefox sources and untar it onto a clean btrfs file system.  The time
> before and after this commit goes up ~1-2 seconds on my machine.  For a less
> simple test you can create a clean btrfs file system and run
>
> fio --name emptyfiles500k --create_on_open=1 --nrfiles=31250 --readwrite=write \
>       --readwrite=write --ioengine=filecreate --fallocate=none --filesize=4k \
>       --openfiles=1 --alloc-size 98304 --allrandrepeat=1 --randseed=12345 \
>       --directory <mount point>
>
> And you are looking for the "Write clat ns p99" metric.  You'll see a 5-10%
> increase in the latency time.  If you want to run our tests directly it's
> relatively easy to setup, you can clone the fsperf repo
>
> https://github.com/josefbacik/fsperf
>
> Then in the fsperf directory edit the local.cfg and add
>
> [main]
> directory=/mnt/test
>
> [btrfs]
> device=/dev/sdc
> iosched=none
> mkfs=mkfs.btrfs -f
> mount=mount -o noatime
>
> And then run the following on the baseline kernel
>
> ./fsperf -p regression -c btrfs -n 10 emptyfiles500k
>
> This will run the test 10 times and save the results to the database.  Then you
> can boot into your changed kernel and runn
>
> ./fsperf -p regrssion -c btrfs -n 10 -t emptyfiles500k
>
> This will run the test 10 times and take the average and compare it to the
> baseline and print out the values, you'll see the increase latency values there.
>
> I can reproduce this at will, if you want to just throw patches at me I'm happy
> to run it and let you know what happens.  I'm attaching my .config as well in
> case that is needed, but the HZ and PREEMPT settings are
>
> CONFIG_NO_HZ_COMMON=y
> CONFIG_NO_HZ_FULL=y
> CONFIG_NO_HZ=y
> CONFIG_HZ_1000=y
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_DEBUG_PREEMPT=y

Thanks for the report!

That patch you bisected does add more NOHZ kicks that aren't time-gated
like nohz.next_blocked / nohz.next_balance, so I'm thinking that a
pathological scenario would be a low-period bursty task which keeps
flicking a CPU idle/!idle. SCHED_SOFTIRQ running the NOHZ work on the
task's previous CPU would then repeatedly delay / force the task to be
placed on another CPU.

Would you happen to have execution traces by any chance? If not I should be
able to get one out of that fsperf thingie.

Now, races between nohz_balance_enter_idle() and nohz_idle_balance() make
it tricky to compare rq.next_balance vs nohz.next_balance to figure out
whether to do an update or not so I did the "stupid" thing of delegating
that to the ILB. Let me scratch my head some more and see if I can end up
with something less trigger-happy wrt NOHZ kicks.

Thanks,
Valentin
