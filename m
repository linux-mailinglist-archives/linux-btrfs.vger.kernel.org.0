Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E1F1316E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 18:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAFRhh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 12:37:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:40530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFRhh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 12:37:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6BEFB150;
        Mon,  6 Jan 2020 17:37:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E51BBDA78B; Mon,  6 Jan 2020 18:37:23 +0100 (CET)
Date:   Mon, 6 Jan 2020 18:37:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: async discard follow up
Message-ID: <20200106173723.GO3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1577999991.git.dennis@kernel.org>
 <20200106152542.GI3929@twin.jikos.cz>
 <20200106171450.GA16428@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106171450.GA16428@dennisz-mbp>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 06, 2020 at 12:14:50PM -0500, Dennis Zhou wrote:
> On Mon, Jan 06, 2020 at 04:25:42PM +0100, David Sterba wrote:
> > On Thu, Jan 02, 2020 at 04:26:34PM -0500, Dennis Zhou wrote:
> > > Dave applied 1-12 from v6 [1]. This is a follow up cleaning up the
> > > remaining 10 patches adding 2 more to deal with a rare -1 [2] that I
> > > haven't quite figured out how to repro. This is also available at [3].
> > > 
> > > This series is on top of btrfs-devel#misc-next-with-discard-v6 0c7be920bd7d.
> > > 
> > > [1] https://lore.kernel.org/linux-btrfs/cover.1576195673.git.dennis@kernel.org/
> > > [2] https://lore.kernel.org/linux-btrfs/20191217145541.GE3929@suse.cz/
> > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/misc.git/log/?h=async-discard
> > > 
> > > Dennis Zhou (12):
> > >   btrfs: calculate discard delay based on number of extents
> > >   btrfs: add bps discard rate limit for async discard
> > >   btrfs: limit max discard size for async discard
> > >   btrfs: make max async discard size tunable
> > >   btrfs: have multiple discard lists
> > >   btrfs: only keep track of data extents for async discard
> > >   btrfs: keep track of discard reuse stats
> > >   btrfs: add async discard header
> > >   btrfs: increase the metadata allowance for the free_space_cache
> > >   btrfs: make smaller extents more likely to go into bitmaps
> > >   btrfs: ensure removal of discardable_* in free_bitmap()
> > >   btrfs: add correction to handle -1 edge case in async discard
> > 
> > I found this lockdep warning on the machine but can't tell what was the
> > exact load at the time. I did a few copy/delete/balance and git checkout
> > rounds, similar to the first testing loads. The branch tested was
> > basically current misc-next:
> 
> I've definitely ran into an mmap_sem circular lockdep warning before,
> but I believe at the time I was able to repro it without my patches on
> top.
> 
> Besides that, I'm not sure how my series would be the trigger for this.
> I'll take a closer look today.

Thanks, I don't remember the exact lockdep report, though I've seen some
transient mmap_sem warnings but nothing recent. What's weird is the
sr_mutex, that's from scsi cdrom. There is one on the machine so I guess
this is machine-specific and not related to the patchset.
