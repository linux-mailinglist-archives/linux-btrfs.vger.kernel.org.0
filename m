Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2513E275987
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgIWOL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 10:11:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:37494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgIWOL0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 10:11:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C012B1D0;
        Wed, 23 Sep 2020 14:12:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 569B9DA6E3; Wed, 23 Sep 2020 16:10:09 +0200 (CEST)
Date:   Wed, 23 Sep 2020 16:10:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: Don't call readpage_end_io_hook for the btree
 inode
Message-ID: <20200923141009.GN6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200918133439.23187-1-nborisov@suse.com>
 <20200918133439.23187-2-nborisov@suse.com>
 <20200921174509.GN6756@twin.jikos.cz>
 <f874055e-34d7-f972-9cfc-551dbbd023a8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f874055e-34d7-f972-9cfc-551dbbd023a8@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 23, 2020 at 09:29:00AM +0300, Nikolay Borisov wrote:
> 
> 
> On 21.09.20 г. 20:45 ч., David Sterba wrote:
> > On Fri, Sep 18, 2020 at 04:34:33PM +0300, Nikolay Borisov wrote:
> >> Instead of relying on indirect calls to implement metadata buffer
> >> validation simply check if the inode whose page we are processing equals
> >> the btree inode. If it does call the necessary function.
> >>
> >> This is an improvement in 2 directions:
> >> 1. We aren't paying the penalty of indirect calls in a post-speculation
> >>    attacks world.
> >>
> >> 2. The function is now named more explicitly so it's obvious what's
> >>    going on
> > 
> > The new naming is not making things clear, btrfs_check_csum sounds very
> > generic while it does a very specific thing just by the number and type
> > of the parameters. Similar for btrfs_validate_metadata_buffer.
> > 
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -2851,9 +2851,12 @@ static void end_bio_extent_readpage(struct bio *bio)
> >>  
> >>  		mirror = io_bio->mirror_num;
> >>  		if (likely(uptodate)) {
> >> -			ret = tree->ops->readpage_end_io_hook(io_bio, offset,
> >> -							      page, start, end,
> >> -							      mirror);
> >> +			if (data_inode)
> >> +				ret = btrfs_check_csum(io_bio, offset, page,
> >> +						       start, end, mirror);
> >> +			else
> >> +				ret = btrfs_validate_metadata_buffer(io_bio,
> >> +					offset, page, start, end, mirror);
> > 
> > In the context where the functions are used I'd expect some symmetry,
> > data/metadata. Something like btrfs_validate_data_bio.
> > 
> 
> The reason for this naming is that btrfs_vlidate_metadata_buffer
> actually validates as in "tree-checker style validation" of the extent
> buffer not simply calculating the checksum. So to me it feels like a
> more complete,heavyweight operations hence "validating", whlist
> btrfs_check_csum just checks the csum of a single sector/blocksize in
> the bio. I think the metadata function's name conveys what it's doing in
> full:
> 
> 1. It's doing validation as per aforementioned explanation
> 2. It's doing it for a whole extent buffer and not just a chunk of it.

No problem with the metadata function name, I agree with the reasoning
above.

> I agree that the data function's name is somewhat generic, perhahps it
> could be renamed so that it points to the fact it's validating a single
> sector/blocksize? I.e btrfs_check_ blocksize_csum or something like that ?

Yeah, that the data have a simpler validation maybe does not deserve to
be called like that. We should not use 'sector' here as bios use that
too. So btrfs_check_data_block_csum or btrfs_check_block_csum?
