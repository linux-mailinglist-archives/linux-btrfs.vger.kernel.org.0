Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1FC2A974B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 14:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgKFN6R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 08:58:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:49686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgKFN6R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 08:58:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 591ADABCC;
        Fri,  6 Nov 2020 13:58:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1802ADA6E3; Fri,  6 Nov 2020 14:56:36 +0100 (CET)
Date:   Fri, 6 Nov 2020 14:56:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] fixes for btrfs async discards
Message-ID: <20201106135635.GP6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pavel Begunkov <asml.silence@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1604444952.git.asml.silence@gmail.com>
 <20201105222305.GN6756@twin.jikos.cz>
 <215f6406-fbe2-9eb6-2ac2-7f28b2666789@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215f6406-fbe2-9eb6-2ac2-7f28b2666789@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 06, 2020 at 01:20:25PM +0000, Pavel Begunkov wrote:
> On 05/11/2020 22:23, David Sterba wrote:
> > On Wed, Nov 04, 2020 at 09:45:50AM +0000, Pavel Begunkov wrote:
> >> Several fixes for async discards. The first patch might increase discard
> >> rate, drastically in some cases. That may be a suprise for those
> >> assuming that hitting iops_limit is rare and rarther outliers. Though,
> >> it still stays in allowed range, so should be fine.
> > 
> > I think this highly depends on the workload, if you really need to issue
> > the discards fast because of the rate of the change in the regular data.
> > That was the point of the async discard and the knobs, the defaults
> > should be ok for most users and allow adjusting for specific loads.
> 
> Chris mentioned that _there are_ problems with faster drives though.
> The problem is that this iops_limit knot just clamps the chosen delay.
> Ultimately, I want to find later a better delay function than
> 
> delay = CONSTANT_INTERVAL_MS / nr_extents.
> 
> But that will take some thinking.
> 
> For instance, one of the cases I've seen is recycling large extents
> like deletion of subvolumes. There we have a small number of extents
> but each takes a lot of space, so there are, say, 100+GB queued to be
> discarded. But because there are few extents, delay is calculated
> to >10s that's then clamped to a constant max limit.
> That was taking a long to recycle. Not sure though how many bytes/extents
> are discarded on each iteration of btrfs_discard_workfn().

BTRFS_ASYNC_DISCARD_DEFAULT_MAX_SIZE 64M

So the few large extents do not fit current scheme. I thought some
translation to "logical" units could do the same discard io scheduling.
100G of size would become N times maximum discard extent units
(N = 100G / max) and submitted for discard until N is 0 for a given
input range.

But if you know you'll have ranges that are orders of magnitude larger
than the extent size, then setting the sysfs value accordingly seems
like the right approach. I'm not sure if the freed ranges are coalesced
before adding them to the discard list. If not, then icreasing the max
size should work, otherwise the coalescing could be adjusted.
