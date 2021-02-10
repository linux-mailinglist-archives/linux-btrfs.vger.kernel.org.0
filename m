Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4433166B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 13:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhBJMbk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 07:31:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:34672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231855AbhBJMaI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 07:30:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6ABD7AC43;
        Wed, 10 Feb 2021 12:29:26 +0000 (UTC)
Date:   Wed, 10 Feb 2021 12:29:25 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 6/6] btrfs: Add roundrobin raid1 read policy
Message-ID: <20210210122925.GB23499@wotan.suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-7-mrostecki@suse.de>
 <20210210042428.GC12086@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210042428.GC12086@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 05:24:28AM +0100, Michał Mirosław wrote:
> On Tue, Feb 09, 2021 at 09:30:40PM +0100, Michal Rostecki wrote:
> [...]
> > For the array with 3 HDDs, not adding any penalty resulted in 409MiB/s
> > (429MB/s) performance. Adding the penalty value 1 resulted in a
> > performance drop to 404MiB/s (424MB/s). Increasing the value towards 10
> > was making the performance even worse.
> > 
> > For the array with 2 HDDs and 1 SSD, adding penalty value 1 to
> > rotational disks resulted in the best performance - 541MiB/s (567MB/s).
> > Not adding any value and increasing the value was making the performance
> > worse.
> > 
> > Adding penalty value to non-rotational disks was always decreasing the
> > performance, which motivated setting it as 0 by default. For the purpose
> > of testing, it's still configurable.
> [...]
> > +	bdev = map->stripes[mirror_index].dev->bdev;
> > +	inflight = mirror_load(fs_info, map, mirror_index, stripe_offset,
> > +			       stripe_nr);
> > +	queue_depth = blk_queue_depth(bdev->bd_disk->queue);
> > +
> > +	return inflight < queue_depth;
> [...]
> > +	last_mirror = this_cpu_read(*fs_info->last_mirror);
> [...]
> > +	for (i = last_mirror; i < first + num_stripes; i++) {
> > +		if (mirror_queue_not_filled(fs_info, map, i, stripe_offset,
> > +					    stripe_nr)) {
> > +			preferred_mirror = i;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	for (i = first; i < last_mirror; i++) {
> > +		if (mirror_queue_not_filled(fs_info, map, i, stripe_offset,
> > +					    stripe_nr)) {
> > +			preferred_mirror = i;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	preferred_mirror = last_mirror;
> > +
> > +out:
> > +	this_cpu_write(*fs_info->last_mirror, preferred_mirror);
> 
> This looks like it effectively decreases queue depth for non-last
> device. After all devices are filled to queue_depth-penalty, only
> a single mirror will be selected for next reads (until a read on
> some other one completes).
> 

Good point. And if all devices are going to be filled for longer time,
this function will keep selecting the last one. Maybe I should select
last+1 in that case. Would that address your concern or did you have any
other solution in mind?

Thanks for pointing that out.

> Have you tried testing with much more jobs / non-sequential accesses?
> 

I didn't try with non-sequential accesses. Will do that before
respinning v2.

> Best Reagrds,
> Michał Mirosław

Regards,
Michal
