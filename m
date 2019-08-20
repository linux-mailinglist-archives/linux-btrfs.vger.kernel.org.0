Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80FD1967B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfHTRjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 13:39:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728277AbfHTRjn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 13:39:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B08DAEE0;
        Tue, 20 Aug 2019 17:39:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52F94DA7DA; Tue, 20 Aug 2019 19:40:08 +0200 (CEST)
Date:   Tue, 20 Aug 2019 19:40:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: rename the btrfs_calc_*_metadata_size helpers
Message-ID: <20190820174008.GU24086@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20190816150600.9188-1-josef@toxicpanda.com>
 <20190816150600.9188-2-josef@toxicpanda.com>
 <54a313a2-8355-66cd-74a1-a267bd65cccd@suse.com>
 <20190819124727.t5xhqyntq72cagav@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819124727.t5xhqyntq72cagav@MacBook-Pro-91.local>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 19, 2019 at 08:47:28AM -0400, Josef Bacik wrote:
> > > +static inline u64 btrfs_calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
> > > +						  unsigned num_items)
> > >  {
> > >  	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 2 * num_items;
> > >  }
> > 
> > Isn't assuming that we are going to split on every level of the cow
> > rather pessimistic, bordering on impossible. Isn't it realistically
> > possible that we will only ever split up until root->level.

This is a natural idea, I had it as well long time ago, and your
argument why this does not work is that the level can increase between
the time of reservatino and time of commit. So this would lead to ENOSPC
where not expected and then abort.

> I had this discussion with Chris when I messed with this.  We do pass in the
> root we intend on messing with so we could very well do this, but it sort of
> scares me because maybe we've been using more of our worst case reservations
> than I expected.
> 
> My plan is to get these last corners worked out, get a few more months of
> production testing, and then start experimenting with using the root->level + 1
> for the maximum level and see how that goes.  The ramp up from 1 level to 3
> level roots happens pretty fast, so I suspect there'll be weird corner cases
> going from empty->not empty, but I _think_ we should be fine to make this change
> further down the road?

I had a patch for that and tried to do worst case calculations for each
level, ie. what's the number minimum number of items that would require
splitting and increasing the level.

Starting with level 4, the +1 should be safe, for 5+ safe unless eg. the
commit period is so long that the number of dirty metadata is out of
scale (the period affected by commit=, so not a typical usecase).

So the whole idea should work. The formula I used was

  level = max(4, root->level + 1)

instead of BTRFS_MAX_LEVEL.

For start, setting the minimum to 5 would be IMHO safe enough, the
savings in the over-reservations would be 3*nodesize in most cases, or
~38%. This could help to avoid early ENOSPC.
