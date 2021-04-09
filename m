Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9C35A71A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 21:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhDIT0y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 15:26:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:60038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235007AbhDIT0w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Apr 2021 15:26:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00E8AAD8E;
        Fri,  9 Apr 2021 19:26:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7B721DA732; Fri,  9 Apr 2021 21:24:24 +0200 (CEST)
Date:   Fri, 9 Apr 2021 21:24:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 03/38] btrfs: handle errors from select_reloc_root()
Message-ID: <20210409192424.GT7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608135849.git.josef@toxicpanda.com>
 <aa44497f5c2b8c96ca1229daa4dfdb6503971f31.1608135849.git.josef@toxicpanda.com>
 <20210226183059.GP7604@twin.jikos.cz>
 <e0865e88-903c-e9b5-7ebb-daeca69fcac9@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0865e88-903c-e9b5-7ebb-daeca69fcac9@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 01:10:03PM -0500, Josef Bacik wrote:
> On 2/26/21 1:30 PM, David Sterba wrote:
> > On Wed, Dec 16, 2020 at 11:26:19AM -0500, Josef Bacik wrote:
> >> Currently select_reloc_root() doesn't return an error, but followup
> >> patches will make it possible for it to return an error.  We do have
> >> proper error recovery in do_relocation however, so handle the
> >> possibility of select_reloc_root() having an error properly instead of
> >> BUG_ON(!root).  I've also adjusted select_reloc_root() to return
> >> ERR_PTR(-ENOENT) if we don't find a root, instead of NULL, to make the
> >> error case easier to deal with.  I've replaced the BUG_ON(!root) with an
> >> ASSERT(0) for this case as it indicates we messed up the backref walking
> >> code, but it could also indicate corruption.
> >>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> ---
> >>   fs/btrfs/relocation.c | 15 ++++++++++++---
> >>   1 file changed, 12 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> >> index 08ffaa93b78f..741068580455 100644
> >> --- a/fs/btrfs/relocation.c
> >> +++ b/fs/btrfs/relocation.c
> >> @@ -2024,8 +2024,14 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
> >>   		if (!next || next->level <= node->level)
> >>   			break;
> >>   	}
> >> -	if (!root)
> >> -		return NULL;
> >> +	if (!root) {
> >> +		/*
> >> +		 * This can happen if there's fs corruption or if there's a bug
> >> +		 * in the backref lookup code.
> >> +		 */
> >> +		ASSERT(0);
> > 
> > You've added these assert(0) to several patches and I think it's wrong.
> > The asserts are supposed to verify invariants, you can hardly say that
> > we're expecting 0 to be true, so the construct serves as "please crash
> > here", which is no better than BUG().  It's been spreading, there are
> > like 25 now.
> 
> They are much better than a BUG_ON(), as they won't trip in production, they'll 
> only trip for developers.

I'm not suggesting to use BUG_ON, only in rare cases (ideally). For
developers what should blow up are conditions that validate the
invariants, either in advance or after some action.

> And we need them in many of these cases, and this 
> example you've called out is a clear example of where we absolutely want to 
> differentiate, because we have 3 different failure modes that will return 
> -EUCLEAN.  If I add a ASSERT(ret != -EUCLEAN) to all of the callers then when 
> the developer hits a logic bug they'll have to go and manually add in their own 
> assert to figure out which error condition failed.

The idea is to add more conditions to differentiate if it's corrupted fs
or if it's a development bug. But for testing I'd rather see a way we
can exercise the corruption path, eg. fuzzing or crafted images, up to
the point where EUCLEAN is encountered by some transaction abort or
normal error.

> Instead I've added 
> explanations in the comments for each assert and then have an assert for every 
> error condition so that it's clear where things went wrong.

There can be exceptional cases where distinguishing can't be done easily
or at all so the comments are fine but I'd rather not encourage the
ASSERT(0) pattern instead of thinking hard if it's really the right way
to handle the errors. It too much resembles the BUG_ON() anti-pattern.
