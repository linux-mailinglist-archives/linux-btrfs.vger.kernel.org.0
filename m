Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62B94D245
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfFTPhe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 11:37:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbfFTPhe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 11:37:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 519C0AE46;
        Thu, 20 Jun 2019 15:37:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 12BC11E434F; Thu, 20 Jun 2019 17:37:33 +0200 (CEST)
Date:   Thu, 20 Jun 2019 17:37:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/9] blkcg: implement REQ_CGROUP_PUNT
Message-ID: <20190620153733.GM30243@quack2.suse.cz>
References: <20190615182453.843275-1-tj@kernel.org>
 <20190615182453.843275-5-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615182453.843275-5-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat 15-06-19 11:24:48, Tejun Heo wrote:
> When a shared kthread needs to issue a bio for a cgroup, doing so
> synchronously can lead to priority inversions as the kthread can be
> trapped waiting for that cgroup.  This patch implements
> REQ_CGROUP_PUNT flag which makes submit_bio() punt the actual issuing
> to a dedicated per-blkcg work item to avoid such priority inversions.
> 
> This will be used to fix priority inversions in btrfs compression and
> should be generally useful as we grow filesystem support for
> comprehensive IO control.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Cc: Chris Mason <clm@fb.com>

...

> +bool __blkcg_punt_bio_submit(struct bio *bio)
> +{
> +	struct blkcg_gq *blkg = bio->bi_blkg;
> +
> +	/* consume the flag first */
> +	bio->bi_opf &= ~REQ_CGROUP_PUNT;
> +
> +	/* never bounce for the root cgroup */
> +	if (!blkg->parent)
> +		return false;
> +
> +	spin_lock_bh(&blkg->async_bio_lock);
> +	bio_list_add(&blkg->async_bios, bio);
> +	spin_unlock_bh(&blkg->async_bio_lock);
> +
> +	queue_work(blkcg_punt_bio_wq, &blkg->async_bio_work);
> +	return true;
> +}
> +

So does this mean that if there is some inode with lots of dirty data for a
blkcg that is heavily throttled, that blkcg can occupy a ton of workers all
being throttled in submit_bio()? Or what is constraining a number of
workers one blkcg can consume?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
