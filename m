Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7BBD2EB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 18:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfJJQiP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 12:38:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:59430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfJJQiP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 12:38:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24F2EAF73;
        Thu, 10 Oct 2019 16:38:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4240ADA7E3; Thu, 10 Oct 2019 18:38:28 +0200 (CEST)
Date:   Thu, 10 Oct 2019 18:38:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: add missing extents release on file extent
 cluster relocation error
Message-ID: <20191010163828.GY2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20191009164345.23713-1-fdmanana@kernel.org>
 <467212df-c87e-6b71-30cb-3a1e2b0293d1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <467212df-c87e-6b71-30cb-3a1e2b0293d1@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 09:13:43AM +0200, Johannes Thumshirn wrote:
> On 09/10/2019 18:43, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > If we error out when finding a page at relocate_file_extent_cluster(), we
> > need to release the outstanding extents counter on the relocation inode,
> > set by the previous call to btrfs_delalloc_reserve_metadata(), otherwise
> > the inode's block reserve size can never decrease to zero and metadata
> > space is leaked. Therefore add a call to btrfs_delalloc_release_extents()
> > in case we can't find the target page.
> > 
> > Fixes: 8b62f87bad9cf0 ("Btrfs: rework outstanding_extents")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/relocation.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index 00504657b602..88dbc0127793 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -3277,6 +3277,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
> >  			if (!page) {
> >  				btrfs_delalloc_release_metadata(BTRFS_I(inode),
> >  							PAGE_SIZE, true);
> > +				btrfs_delalloc_release_extents(BTRFS_I(inode),
> > +							       PAGE_SIZE, true);
> 
> Hmm how about adding a wrapper to combine these two calls similar to
> what btrfs_delalloc_release_space() is doing for
> btrfs_delalloc_release_metadata() and btrfs_free_reserved_data_space()?
> 
> I count at least 3 other occurences of this pattern with a simple
> git grep -C 4 btrfs_delalloc_release_metadata fs/btrfs/ | \
>    grep btrfs_delalloc_release_extents
> 
> One of them being in the same function.

I'm not sure another wrapper would be a significant improvement. The two
functions are called separatelly in many places so it has to be decided
case by case anyway.

Reading relocate_file_extent_cluster, there are places that call only
one of the functions (due to partial initialization) and that need both,
so that it's explicitly visible can be matched agains the context. Eg.
hilighting the function in the editor is a visual clue that I'm using
often so the extra wrapper would slightly obscure that.
