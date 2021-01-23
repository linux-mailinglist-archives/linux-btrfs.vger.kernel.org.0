Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F09301861
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 21:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbhAWUjT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 15:39:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:35776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbhAWUjR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 15:39:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6A88AC8F;
        Sat, 23 Jan 2021 20:38:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0A6EADA823; Sat, 23 Jan 2021 21:36:50 +0100 (CET)
Date:   Sat, 23 Jan 2021 21:36:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 12/18] btrfs: implement try_release_extent_buffer()
 for subpage metadata support
Message-ID: <20210123203650.GC1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-13-wqu@suse.com>
 <4732f7cb-8d1c-6af2-0ec4-9b9cf5a47c3e@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4732f7cb-8d1c-6af2-0ec4-9b9cf5a47c3e@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 20, 2021 at 10:05:56AM -0500, Josef Bacik wrote:
> On 1/16/21 2:15 AM, Qu Wenruo wrote:
> >   int try_release_extent_buffer(struct page *page)
> >   {
> >   	struct extent_buffer *eb;
> >   
> > +	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> > +		return try_release_subpage_extent_buffer(page);
> 
> You're using sectorsize again here.  I realize the problem is sectorsize != 
> PAGE_SIZE, but sectorsize != nodesize all the time, so please change all of the 
> patches to check the actual relevant size for the data/metadata type.  Thanks,

We had a long discussion with Qu about that on slack some time ago.
Right now we have sectorsize defining the data block size and also the
metadata unit size and check that as a constraint.

This is not perfect and does not cover all possible page/data/metadata
block size combinations and in the code looks odd, like in
scrub_checksum_tree_block, see the comment.

Adding the subpage support is quite intrusive and we can't cover all
size combinations at the same time so we agreed on first iteration where
sectorsize is still used as the nodesize constraint. This allows to test
the new code and the whole subpage infrastructure on real hw like arm64
or ppc64.

That we'll need to decouple sectorsize from the metadata won't be
forgotten, I've agreed with that conditionally and given how many
patches are floating around it'll become even harder to move forward
with the patches.
