Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0279D462D63
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 08:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbhK3HUD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Nov 2021 02:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhK3HUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Nov 2021 02:20:03 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1D4C061574;
        Mon, 29 Nov 2021 23:16:44 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mrxNZ-0004mq-9M; Tue, 30 Nov 2021 08:16:41 +0100
Message-ID: <a61df03d-2e36-9e91-ff02-2f48eb660181@leemhuis.info>
Date:   Tue, 30 Nov 2021 08:16:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [REGRESSION] 5-10% increase in IO latencies with nohz balance
 patch
Content-Language: en-BS
To:     Josef Bacik <josef@toxicpanda.com>, valentin.schneider@arm.com,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <YaUH5GFFoLiS4/3/@localhost.localdomain>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YaUH5GFFoLiS4/3/@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1638256604;c928f8be;
X-HE-SMSGID: 1mrxNZ-0004mq-9M
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

Top-posting for once, to make this easy accessible to everyone.

Adding the regression mailing list to the list of recipients, as it
should be in the loop for all regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 7fd7a9e0caba
#regzbot ignore-activity

Reminder: when fixing the issue, please add a 'Link:' tag with the URL
to the report (the parent of this mail), then regzbot will automatically
mark the regression as resolved once the fix lands in the appropriate
tree. For more details about regzbot see footer.

Sending this to everyone that got the initial report, to make all aware
of the tracking. I also hope that messages like this motivate people to
directly get at least the regression mailing list and ideally even
regzbot involved when dealing with regressions, as messages like this
wouldn't be needed then.

Don't worry, I'll send further messages wrt to this regression just to
the lists (with a tag in the subject so people can filter them away), as
long as they are intended just for regzbot. With a bit of luck no such
messages will be needed anyway.

Ciao, Thorsten, your Linux kernel regression tracker.

---
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
tell #regzbot about it in the report, as that will ensure the regression
gets on the radar of regzbot and the regression tracker. That's in your
interest, as they will make sure the report won't fall through the
cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include a 'Link:' tag to the report in the commit message, as explained
in Documentation/process/submitting-patches.rst
That aspect was recently was made more explicit in commit 1f57bd42b77c:
https://git.kernel.org/linus/1f57bd42b77c


On 29.11.21 18:03, Josef Bacik wrote:
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
> 	--readwrite=write --ioengine=filecreate --fallocate=none --filesize=4k \
> 	--openfiles=1 --alloc-size 98304 --allrandrepeat=1 --randseed=12345 \
> 	--directory <mount point>
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
> 
> Thanks,
> 
> Josef
> 

