Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7A516ACA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 18:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgBXRGg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 12:06:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:41692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgBXRGg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 12:06:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1D10FAD45;
        Mon, 24 Feb 2020 17:06:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7321DDA727; Mon, 24 Feb 2020 18:06:15 +0100 (CET)
Date:   Mon, 24 Feb 2020 18:06:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5] btrfs: Don't submit any btree write bio if the fs has
 error
Message-ID: <20200224170615.GZ2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200212061244.26851-1-wqu@suse.com>
 <20200221133559.GG2902@twin.jikos.cz>
 <8e100fed-13ba-febf-14da-452635094aad@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e100fed-13ba-febf-14da-452635094aad@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 09:40:32PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/2/21 下午9:35, David Sterba wrote:
> > On Wed, Feb 12, 2020 at 02:12:44PM +0800, Qu Wenruo wrote:
> >> @@ -4036,7 +4037,39 @@ int btree_write_cache_pages(struct address_space *mapping,
> >>  		end_write_bio(&epd, ret);
> >>  		return ret;
> >>  	}
> >> -	ret = flush_write_bio(&epd);
> >> +	/*
> >> +	 * If something went wrong, don't allow any metadata write bio to be
> >> +	 * submitted.
> >> +	 *
> >> +	 * This would prevent use-after-free if we had dirty pages not
> >> +	 * cleaned up, which can still happen by fuzzed images.
> >> +	 *
> >> +	 * - Bad extent tree
> >> +	 *   Allowing existing tree block to be allocated for other trees.
> >> +	 *
> >> +	 * - Log tree operations
> >> +	 *   Exiting tree blocks get allocated to log tree, bumps its
> >> +	 *   generation, then get cleaned in tree re-balance.
> >> +	 *   Such tree block will not be written back, since it's clean,
> >> +	 *   thus no WRITTEN flag set.
> >> +	 *   And after log writes back, this tree block is not traced by
> >> +	 *   any dirty extent_io_tree.
> >> +	 *
> >> +	 * - Offending tree block gets re-dirtied from its original owner
> >> +	 *   Since it has bumped generation, no WRITTEN flag, it can be
> >> +	 *   reused without COWing. This tree block will not be traced
> >> +	 *   by btrfs_transaction::dirty_pages.
> >> +	 *
> >> +	 *   Now such dirty tree block will not be cleaned by any dirty
> >> +	 *   extent io tree. Thus we don't want to submit such wild eb
> >> +	 *   if the fs already has error.
> >> +	 */
> >> +	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> >> +		ret = flush_write_bio(&epd);
> >> +	} else {
> >> +		ret = -EUCLEAN;
> >> +		end_write_bio(&epd, ret);
> >> +	}
> > 
> > This replaces one instance of flush_write_bio, would it make sense to
> > wrap it to flush_write_bio or some other helper? There might be places
> > where not handling the fs error state would be acceptable, so eg.
> > 
> > flush_write_bio = as it is now
> > 
> > flush_write_bio_or_end = does the above
> > 
> 
> I don't believe there are other call sites needs such special handling,
> thus a wrapper only used once doesn't make much sense.
> 
> Unless we're going to introduce more path for btree writeback, current
> one would be good enough I guess.

I see, thanks. The steps to reproduce are quite complicated already and
expecting crafted data. There's probably more but would need a similarly
convoluted way of hitting a missing error code fixup.

We could add more invariant checks that would catch that something is
done at a wrong time, like here metadata writeback after everything has
been shut down.
