Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB92FF2BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 19:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbhAUSAp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 13:00:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:40916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389054AbhAURzV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 12:55:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 506B8ABD6;
        Thu, 21 Jan 2021 17:54:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85123DA6E3; Thu, 21 Jan 2021 18:52:43 +0100 (CET)
Date:   Thu, 21 Jan 2021 18:52:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com
Subject: Re: [PATCH v4 1/3] btrfs: add read_policy latency
Message-ID: <20210121175243.GF6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
References: <cover.1611114341.git.anand.jain@oracle.com>
 <63f6f00e2ecc741efd2200c3c87b5db52c6be2fd.1611114341.git.anand.jain@oracle.com>
 <20210120121416.GX6430@twin.jikos.cz>
 <e46000d9-c2e1-ec7c-d6b1-a3bd16aa05f4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e46000d9-c2e1-ec7c-d6b1-a3bd16aa05f4@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 21, 2021 at 06:10:36PM +0800, Anand Jain wrote:
> 
> 
> On 20/1/21 8:14 pm, David Sterba wrote:
> > On Tue, Jan 19, 2021 at 11:52:05PM -0800, Anand Jain wrote:
> >> The read policy type latency routes the read IO based on the historical
> >> average wait-time experienced by the read IOs through the individual
> >> device. This patch obtains the historical read IO stats from the kernel
> >> block layer and calculates its average.
> > 
> > This does not say how the stripe is selected using the gathered numbers.
> > Ie. what is the criteria like minimum average time, "based on" is too
> > vague.
> > 
> 
> 
> Could you please add the following in the change log. Hope this will 
> suffice.
> 
> ----------
> This patch adds new read policy Latency. This policy routes the read
> I/Os based on the device's average wait time for read requests.

'wait time' means the time from io submission to completion

> The average is calculated by dividing the total wait time for read
> requests by the total read I/Os processed by the device.

So this is based on numbers from the entire lifetime of the device?  The
numbers are IMHO not a reliable source. If unrelated writes increase the
read wait time then the device will not be selected until the average
is lower than of the other devices.

The average can only decrease after there are some fast reads, which is
not guaranted to happen and there's no good estimate how long it could
take to happen.

The tests we all probably do are on a fresh mkfs and with a small
workload but the mirror selection logic must work long term.

The part_stat numbers could be used but must reflect the time factor,
ie. it needs to be some a rolling average or collecting a sample for
last N seconds.

Bear in mind that this is only a heuristic and we don't need perfect
results nor we want to replace io scheduling, so the amont of collected
data or the logic should be straightforward.

> This policy uses kernel disk stat to calculate the average, so it needs
> the kernel stat to be enabled.

What is needed to enable it? I see it's always compiled in in
block/blk-core.c.

> If in case the kernel stat is disabled
> the policy uses the stripe 0.
> This policy can be set through the read_policy sysfs interface as shown
> below.
> 
>      $ echo latency > /sys/fs/btrfs/<uuid>/read_policy
>      $ cat /sys/fs/btrfs/<uuid>/read_policy
>           pid [latency] device roundrobin
> 
> This policy won't persist across reboot or mount unmount recycle as of
> now.
> 
> Here below are few performance test results with latency compared with 
> pid policy.
> 
> raid1 fio read 500m

500m is really small data size for such measurement

> -----------------------------------------------------
> dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
> read type   | random    sequential random    sequential
> ------------+------------------------------------------
> pid         | 744MiB/s  809MiB/s  2225MiB/s 2155MiB/s
> latency     | 2072MiB/s 2008MiB/s  1999MiB/s 1961MiB/s

Namely when the device bandwidth is 4x higher. The data size should be
scaled up so the whole run takes at least 30 seconds if not a few
minutes.

Other missing information about the load is the number of threads and if
it's buffered or direct io.

> raid10 fio read 500m
> -----------------------------------------------------
> dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
> read type   | random    sequential random    sequential
> ------------+------------------------------------------
> pid         | 1282MiB/s 1427MiB/s 2152MiB/s 1969MiB/s
> latency     | 2073MiB/s 1871MiB/s 1975MiB/s 1984MiB/s
> 
> 
> raid1c3 fio read 500m
> -----------------------------------------------------
> dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
> read type   | random    sequential random    sequential
> ------------+------------------------------------------
> pid         |  973MiB/s  955MiB/s 2144MiB/s 1962MiB/s
> latency     | 2005MiB/s 1924MiB/s 2083MiB/s 1980MiB/s
> 
> 
> raid1c4 fio read 500m
> -----------------------------------------------------
> dev types   | nvme+ssd  nvme+ssd   all-nvme  all-nvme
> read type   | random    sequential random    sequential
> ------------+------------------------------------------
> pid         | 1204MiB/s 1221MiB/s 2065MiB/s 1878MiB/s
> latency     | 1990MiB/s 1920MiB/s 1945MiB/s 1865MiB/s
> 
> 
> In the given fio I/O workload above, it is found that there are fewer 
> I/O merges in case of latency as compared to pid. So in the case of all 
> homogeneous devices pid performance little better.

Yeah switching the device in the middle of a contiguous range could slow
it down but as long as it's not "too much", then it's ok.

The pid selection is good for multiple threads workload but we also want
to make it work with single thread reads, like a simple 'cp'.

I tested this policy and with 2G file 'cat file' utilizes only one
device, so this is no improvement to the pid policy.

A policy based on read latency makes sense but the current
implementation does not cover enough workloads.
