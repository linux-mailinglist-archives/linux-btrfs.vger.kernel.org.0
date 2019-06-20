Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583A64D474
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfFTRBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 13:01:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfFTRBm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 13:01:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83A00AF58;
        Thu, 20 Jun 2019 17:01:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 359951E434F; Thu, 20 Jun 2019 19:01:41 +0200 (CEST)
Date:   Thu, 20 Jun 2019 19:01:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, dsterba@suse.com, clm@fb.com,
        josef@toxicpanda.com, axboe@kernel.dk, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/9] blkcg: implement REQ_CGROUP_PUNT
Message-ID: <20190620170141.GO30243@quack2.suse.cz>
References: <20190615182453.843275-1-tj@kernel.org>
 <20190615182453.843275-5-tj@kernel.org>
 <20190620153733.GM30243@quack2.suse.cz>
 <20190620164229.GK657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620164229.GK657710@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu 20-06-19 09:42:29, Tejun Heo wrote:
> Hello, Jan.
> 
> On Thu, Jun 20, 2019 at 05:37:33PM +0200, Jan Kara wrote:
> > > +bool __blkcg_punt_bio_submit(struct bio *bio)
> > > +{
> > > +	struct blkcg_gq *blkg = bio->bi_blkg;
> > > +
> > > +	/* consume the flag first */
> > > +	bio->bi_opf &= ~REQ_CGROUP_PUNT;
> > > +
> > > +	/* never bounce for the root cgroup */
> > > +	if (!blkg->parent)
> > > +		return false;
> > > +
> > > +	spin_lock_bh(&blkg->async_bio_lock);
> > > +	bio_list_add(&blkg->async_bios, bio);
> > > +	spin_unlock_bh(&blkg->async_bio_lock);
> > > +
> > > +	queue_work(blkcg_punt_bio_wq, &blkg->async_bio_work);
> > > +	return true;
> > > +}
> > > +
> > 
> > So does this mean that if there is some inode with lots of dirty data for a
> > blkcg that is heavily throttled, that blkcg can occupy a ton of workers all
> > being throttled in submit_bio()? Or what is constraining a number of
> > workers one blkcg can consume?
> 
> There's only one work item per blkcg-device pair, so the maximum
> number of kthreads a blkcg can occupy on a filesystem would be one.
> It's the same scheme as writeback work items.

OK, I've missed the fact that although the work item can get queued while
it is still running it cannot get executed more than once at a time (which
is kind of obvious but I got confused). Thanks for explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
