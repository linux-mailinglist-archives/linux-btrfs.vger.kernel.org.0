Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89BCE110580
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 20:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLCTuz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 14:50:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:43732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbfLCTuz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 14:50:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94C51B2E02;
        Tue,  3 Dec 2019 19:50:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 255E9DA7D9; Tue,  3 Dec 2019 20:50:46 +0100 (CET)
Date:   Tue, 3 Dec 2019 20:50:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 3/4] btrfs: fix force usage in inc_block_group_ro
Message-ID: <20191203195045.GB2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com,
        Nikolay Borisov <nborisov@suse.com>
References: <20191126162556.150483-1-josef@toxicpanda.com>
 <20191126162556.150483-4-josef@toxicpanda.com>
 <8f77c09f-2b54-5252-cb49-2cf8dda2fb8a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f77c09f-2b54-5252-cb49-2cf8dda2fb8a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 27, 2019 at 06:45:25PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/11/27 上午12:25, Josef Bacik wrote:
> > For some reason we've translated the do_chunk_alloc that goes into
> > btrfs_inc_block_group_ro to force in inc_block_group_ro, but these are
> > two different things.
> >
> > force for inc_block_group_ro is used when we are forcing the block group
> > read only no matter what, for example when the underlying chunk is
> > marked read only.  We need to not do the space check here as this block
> > group needs to be read only.
> >
> > btrfs_inc_block_group_ro() has a do_chunk_alloc flag that indicates that
> > we need to pre-allocate a chunk before marking the block group read
> > only.  This has nothing to do with forcing, and in fact we _always_ want
> > to do the space check in this case, so unconditionally pass false for
> > force in this case.
> >
> > Then fixup inc_block_group_ro to honor force as it's expected and
> > documented to do.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >  fs/btrfs/block-group.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 66fa39632cde..5961411500ed 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1190,8 +1190,15 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
> >  	spin_lock(&sinfo->lock);
> >  	spin_lock(&cache->lock);
> >
> > -	if (cache->ro) {
> > +	if (cache->ro || force) {
> >  		cache->ro++;
> > +
> > +		/*
> > +		 * We should only be empty if we did force here and haven't
> > +		 * already marked ourselves read only.
> > +		 */
> > +		if (force && list_empty(&cache->ro_list))
> > +			list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
> >  		ret = 0;
> >  		goto out;
> >  	}
> > @@ -2063,7 +2070,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
> >  		}
> >  	}
> >
> > -	ret = inc_block_group_ro(cache, !do_chunk_alloc);
> > +	ret = inc_block_group_ro(cache, false);
> 
> This is going to make scrub return false ENOSPC.
> 
> Since commit b12de52896c0 ("btrfs: scrub: Don't check free space before
> marking a block group RO"), scrub doesn't do the pre-alloc check at all.
> 
> If there is only one single data chunk, and has some reserved data
> space, we will hit ENOSPC at scrub time.
> 
> 
> That commit is only to prevent unnecessary system chunk preallocation,
> since your next patch is going to make inc_block_group_ro() follow
> metadata over-commit, there is no need for b12de52896c0 anymore.
> 
> You can just revert that commit after your next patch. Or fold the
> revert with next patch, to make bisect easier.

A revert could be problematic in case there are commits that change the
logic (and code), so it would be IMHO better to replace the logic and
then remove the obsoleted code. Bisection should not be intentionally
broken, unless it becomes infeasible to make the code changes
reasonable. IOW if it gets broken, a notice in changelog should do, as
this will be fixed by the commit and the ENOSPC during scrub is only a
transient problem.
