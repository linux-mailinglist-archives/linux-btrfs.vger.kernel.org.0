Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA7D31A35D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Feb 2021 18:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBLRNw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Feb 2021 12:13:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:41236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhBLRNv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Feb 2021 12:13:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 261AAAD29;
        Fri, 12 Feb 2021 17:13:09 +0000 (UTC)
Date:   Fri, 12 Feb 2021 17:12:58 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 6/6] btrfs: Add roundrobin raid1 read policy
Message-ID: <20210212171246.GA20817@wotan.suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-7-mrostecki@suse.de>
 <c2cbf3a7-3db2-afae-4984-450e758f4987@oracle.com>
 <20210211155533.GB1263@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211155533.GB1263@wotan.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Anand,

re: inflight calculation

On Thu, Feb 11, 2021 at 03:55:33PM +0000, Michal Rostecki wrote:
> > It is better to have random workloads in the above three categories
> > of configs.
> > 
> > Apart from the above three configs, there is also
> >  all-non-rotational with hetero
> > For example, ssd and nvme together both are non-rotational.
> > And,
> >  all-rotational with hetero
> > For example, rotational disks with different speeds.
> > 
> > 
> > The inflight calculation is local to btrfs. If the device is busy due to
> > external factors, it would not switch to the better performing device.
> > 
> 
> Good point. Maybe I should try to use the part stats instead of storing
> inflight locally in btrfs.

I tried today to reuse the inflight calculation which is done for
iostat. And I came to conclusion that it's impossible without exporting
some methods from the block/ subsystem.

The thing is that there are two methods of calculating inflight. Which
one of them is used, depends on queue_is_mq():

https://github.com/kdave/btrfs-devel/blob/9d294a685fbcb256ce8c5f7fd88a7596d0f52a8a/block/genhd.c#L1163

And if that condition is true, I noticed that part_stats return 0, even
though there are processed requests (I checked with fio inside VM).

In general, those two methods of checking inflight are:

1) part_stats - which would be trivial to reuse, just a matter of one
   simple for_each_possible_cpu() loop with part_stat_local_read_cpu()

https://github.com/kdave/btrfs-devel/blob/9d294a685fbcb256ce8c5f7fd88a7596d0f52a8a/block/genhd.c#L133-L146

2) blk_mq_in_flight() - which has a lot of code and unexported
   structs inside the block/ directory, double function callback;
   definitely not easy to reimplement easily in btrfs without copying
   dozens of lines

https://github.com/kdave/btrfs-devel/blob/9d294a685fbcb256ce8c5f7fd88a7596d0f52a8a/block/blk-mq.c#L115-L123

Well, I tried copying the whole blk_mq_in_flight() function with all
dependencies anyway, hard to do without causing modpost errors.

So, to sum it up, I think that making 2) possible to reuse in btrfs
would require at lest exporting the blk_mq_in_flight() function,
therefore the change would have to go through linux-block tree. Which
maybe would be a good thing to do in long term, not sure if it should
block my patchset entirely.

The question is if we are fine with inflight stats inside btrfs.
Personally I think we sholdn't be concerned too much about it. The
inflight counter in my patches is a percpu counted, used in places which
already do some atomic operations.

Thanks,
Michal
