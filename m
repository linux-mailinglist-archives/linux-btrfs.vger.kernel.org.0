Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE337A5C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhEKLbD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 07:31:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:46728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhEKLbD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 07:31:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6047EADCE;
        Tue, 11 May 2021 11:29:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 26B1EDA96D; Tue, 11 May 2021 13:27:27 +0200 (CEST)
Date:   Tue, 11 May 2021 13:27:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/4] btrfs: remove the dead branch in
 btrfs_io_needs_validation()
Message-ID: <20210511112727.GF7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210503020856.93333-1-wqu@suse.com>
 <20210503020856.93333-2-wqu@suse.com>
 <20210510201431.GC7604@twin.jikos.cz>
 <07444aed-81a3-4f1a-aaf4-e3462167383f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07444aed-81a3-4f1a-aaf4-e3462167383f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 11, 2021 at 07:56:42AM +0800, Qu Wenruo wrote:
> >> -	if (bio_flagged(bio, BIO_CLONED)) {
> >> -		if (btrfs_io_bio(bio)->iter.bi_size > blocksize)
> >> +	bio_for_each_bvec_all(bvec, bio, i) {
> >> +		len += bvec->bv_len;
> >> +		if (len > blocksize)
> >>   			return true;
> > 
> > I've looked if the bio cloning is used at all so we could potentially
> > get rid of all the BIO_CLONED assertions. There are still two cases:
> > 
> > * btrfs_submit_direct calling btrfs_bio_clone_partial
> 
> This is what I missed.
> 
> In fact for DIO read repair we can still hit a cloned bio.
> 
> But in that case, we still don't need any validation since the DIO read 
> repair is ensured to only submit sector sized repair.
> So the patchset is still fine, but will break the bisect.
> 
> > * btrfs_map_bio calling btrfs_bio_clone
> 
> This is not a problem, as the generated bio are for real device, not for 
> the inode pages, and read repair only happens for inode pages, we're 
> completely fine.
> 
> > So in this case I'd rather add an assertion before
> > bio_for_each_bvec_all, as this fits the usecase "this never happens".
> > The original assertions were added everywhere once the bio iteration
> > behaviour changed without much notice, so we need to be cautious.
> > 
> > Applied with the following fixup
> 
> Then bisect will be broken.
> 
> If one is testing just this patch, DIO read repair will trigger the 
> ASSERT().
> 
> Is it possible to discard this patch and completely rely on the last 
> patch to remove btrfs_io_needs_validation()?

Yeah, we want to keep it bisectable.
