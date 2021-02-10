Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC53B31675E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 14:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhBJNBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 08:01:42 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:36286 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231668AbhBJM7d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 07:59:33 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4DbKZX4sYxz6r;
        Wed, 10 Feb 2021 13:58:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1612961924; bh=CrEz6PwI0HJJcQyRSYFbySp7b7sxuUv30wgP5keoK7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbOP0DorpbnwPhgeBg/RJ85LhzJMZjIzOwzLX6BEOmMr+SdD2QxSkVs+Rg7M4lHXD
         +gSh1npIbqE6EyTcBaG+xPgtA8hh9pFaCfI2ONWG5Pl64/ihIxzPMsS1/rc+uH7RmG
         SNDqx6sOOQySG0A5ohwXVLb90fz5QsydW8BiE+pwAdt0Th7J1hEMlK/Q0oIb1/9Mj2
         vqEC/mKH7DKR3+XdSClBvs0AlaCZEMrrIqb4ugLBIzdU1fjATYC+wwukDx94CxaNeB
         VKz3c8VxsFypEA9MF0FFS4zzd4NLwt971THkLPAJ1dgOnXUJc0yFsI/mhFWcu5nZX5
         RPqUgDFgdG6bQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 10 Feb 2021 13:58:15 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 6/6] btrfs: Add roundrobin raid1 read policy
Message-ID: <20210210125815.GA20903@qmqm.qmqm.pl>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-7-mrostecki@suse.de>
 <20210210042428.GC12086@qmqm.qmqm.pl>
 <20210210122925.GB23499@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210122925.GB23499@wotan.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 12:29:25PM +0000, Michal Rostecki wrote:
> On Wed, Feb 10, 2021 at 05:24:28AM +0100, Micha³ Miros³aw wrote:
> > On Tue, Feb 09, 2021 at 09:30:40PM +0100, Michal Rostecki wrote:
> > [...]
> > > For the array with 3 HDDs, not adding any penalty resulted in 409MiB/s
> > > (429MB/s) performance. Adding the penalty value 1 resulted in a
> > > performance drop to 404MiB/s (424MB/s). Increasing the value towards 10
> > > was making the performance even worse.
> > > 
> > > For the array with 2 HDDs and 1 SSD, adding penalty value 1 to
> > > rotational disks resulted in the best performance - 541MiB/s (567MB/s).
> > > Not adding any value and increasing the value was making the performance
> > > worse.
> > > 
> > > Adding penalty value to non-rotational disks was always decreasing the
> > > performance, which motivated setting it as 0 by default. For the purpose
> > > of testing, it's still configurable.
> > [...]
> > > +	bdev = map->stripes[mirror_index].dev->bdev;
> > > +	inflight = mirror_load(fs_info, map, mirror_index, stripe_offset,
> > > +			       stripe_nr);
> > > +	queue_depth = blk_queue_depth(bdev->bd_disk->queue);
> > > +
> > > +	return inflight < queue_depth;
> > [...]
> > > +	last_mirror = this_cpu_read(*fs_info->last_mirror);
> > [...]
> > > +	for (i = last_mirror; i < first + num_stripes; i++) {
> > > +		if (mirror_queue_not_filled(fs_info, map, i, stripe_offset,
> > > +					    stripe_nr)) {
> > > +			preferred_mirror = i;
> > > +			goto out;
> > > +		}
> > > +	}
> > > +
> > > +	for (i = first; i < last_mirror; i++) {
> > > +		if (mirror_queue_not_filled(fs_info, map, i, stripe_offset,
> > > +					    stripe_nr)) {
> > > +			preferred_mirror = i;
> > > +			goto out;
> > > +		}
> > > +	}
> > > +
> > > +	preferred_mirror = last_mirror;
> > > +
> > > +out:
> > > +	this_cpu_write(*fs_info->last_mirror, preferred_mirror);
> > 
> > This looks like it effectively decreases queue depth for non-last
> > device. After all devices are filled to queue_depth-penalty, only
> > a single mirror will be selected for next reads (until a read on
> > some other one completes).
> > 
> 
> Good point. And if all devices are going to be filled for longer time,
> this function will keep selecting the last one. Maybe I should select
> last+1 in that case. Would that address your concern or did you have any
> other solution in mind?

The best would be to postpone the selection until one device becomes free
again. But if that's not doable, then yes, you could make sure it stays
round-robin after filling the queues (the scheduling will loose the
"penalty"-driven adjustment though).

Best Reagrds,
Micha³ Miros³aw
