Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3213131700B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 20:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhBJTXz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 14:23:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:38962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233781AbhBJTXx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 14:23:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AADE7AC6E;
        Wed, 10 Feb 2021 19:23:09 +0000 (UTC)
Date:   Wed, 10 Feb 2021 19:23:04 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 6/6] btrfs: Add roundrobin raid1 read policy
Message-ID: <20210210192304.GA28777@wotan.suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-7-mrostecki@suse.de>
 <20210210042428.GC12086@qmqm.qmqm.pl>
 <20210210122925.GB23499@wotan.suse.de>
 <20210210125815.GA20903@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210125815.GA20903@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 01:58:15PM +0100, Michał Mirosław wrote:
> On Wed, Feb 10, 2021 at 12:29:25PM +0000, Michal Rostecki wrote:
> > On Wed, Feb 10, 2021 at 05:24:28AM +0100, Michał Mirosław wrote:
> > > This looks like it effectively decreases queue depth for non-last
> > > device. After all devices are filled to queue_depth-penalty, only
> > > a single mirror will be selected for next reads (until a read on
> > > some other one completes).
> > > 
> > 
> > Good point. And if all devices are going to be filled for longer time,
> > this function will keep selecting the last one. Maybe I should select
> > last+1 in that case. Would that address your concern or did you have any
> > other solution in mind?
> 
> The best would be to postpone the selection until one device becomes free
> again. But if that's not doable, then yes, you could make sure it stays
> round-robin after filling the queues (the scheduling will loose the
> "penalty"-driven adjustment though).

Or another idea - when all the queues are filled, return the mirror
which has the lowest load (inflight + penalty), even though it's greater
than queue depth. In that case the scheduling will not lose the penalty
adjustment and the load is going to be spreaded more fair.

I'm not sure if postponing the selection is that good idea. I think it's
better if the request is added to the iosched queue anyway, even if the
disks' queues are filled, and let the I/O scheduler handle that. The
length of the iosched queue (nr_requests, attribute of the iosched) is
usually greater than queue depth (attribute of the devide), which means
that it's fine to schedule more requests for iosched to handle.

IMO btrfs should use the information given by iosched only for heuristic
mirror selection, rather than implement its own throttling logic.

Does it make sense to you?

An another idea could be an additional iteration in regard to
nr_requests, if all load values are greater than queue depths, though it
might be an overkill. I would prefer to stick to my first idea if
everyone agrees.

Regards,
Michal
