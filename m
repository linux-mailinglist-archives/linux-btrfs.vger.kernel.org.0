Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0944B023
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 16:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhKIPP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 10:15:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37402 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbhKIPPz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 10:15:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 123331FD58;
        Tue,  9 Nov 2021 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636470788;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mSYknEsrR5oOrhsqncxVG3rLLxOk4wxWjDP62CYjA1E=;
        b=Gw7C9YpLm1H41C1M47pQVOgEBI2IfuvvtGVWpyzaujmZgV2JYMT7d0mE2fTAyKdNpo/coc
        WEnLpOKiakEhpRPHLh9GRtAxXmuY6PtGjegbqrVJhC1WUITGBcn9p/dUT+p7TfYnhhCqbf
        b7DcgLy9xyq5xlZDfWLXOSbdMBq+T5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636470788;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mSYknEsrR5oOrhsqncxVG3rLLxOk4wxWjDP62CYjA1E=;
        b=C1DGf4qFVo1GP03/iRBB1wi8pmJnRcEMKbaU+V2tRcrRpPfN/cWyJ/h7YZlxJ9/y0ll7Rp
        FMdLyQb3/aFIa+BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 04904A3B84;
        Tue,  9 Nov 2021 15:13:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6713DDA799; Tue,  9 Nov 2021 16:12:28 +0100 (CET)
Date:   Tue, 9 Nov 2021 16:12:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 07/20] btrfs-progs: stop accessing ->csum_root directly
Message-ID: <20211109151226.GS28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <9785c0745f91699cb45ab398d6a32b44645ace39.1636143924.git.josef@toxicpanda.com>
 <8a4a9842-fbc4-f652-d4ca-842ff63b571f@gmx.com>
 <YYl4SrAlHE44Os7h@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYl4SrAlHE44Os7h@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 08, 2021 at 02:19:38PM -0500, Josef Bacik wrote:
> On Sat, Nov 06, 2021 at 08:23:46AM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2021/11/6 04:28, Josef Bacik wrote:
> > > With extent tree v2 we will have per-block group checksums,
> > 
> > I guess you mean per block group checksum tree?
> > 
> > > so add a
> > > helper to access the csum root and rename the fs_info csum_root to
> > > _csum_root to catch all the places that are accessing it directly.
> > > Convert everybody to use the helper except for internal things.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > Currently a lot of locations are still passing 0 to btrfs_csum_root(),
> > which would need to be converted later.
> > 
> > Thus it doesn't look correct to be in the preparation patchset.
> > 
> > Mind to move this patch into the real extent-tree-v2 patchset?
> > 
> 
> I explained this in another reply, but I wanted to talk about this specific
> style of request here as well.
> 
> I did it this way because it's changing a lot of callsites to use a helper.
> This is kind of a complex change as a whole, because I'm taking us from having a
> fs_info->extent_root to having a rb tree with the extent root, csum root, and
> free space tree root.
> 
> Once I get to the actual extent tree v2 stuff there's going to be a whole host
> of more complicated changes.
> 
> So, in order to make it easier to review, I've put this relatively large concept
> in the prep patches.  It's easier to look at because its a clear
> s/->whatever_root/btrfs_whatever_root/ change.  It's easy to spot check and wrap
> your head around.
> 
> Then I do the work to actually load it into the rb-tree, and then change the
> helpers to access the rb-tree.  Those two changes are contained and easy to wrap
> your head around.
> 
> Then in the extent-tree-v2 series I actually change the helpers to do the new
> crazy stuff, and then go through the places where we do
> btrfs_whatever_root(fs_info, 0) and convert those to be compatible with the new
> world order.  I do that because each of those spots is it's own deal to convert,
> so they need to be reasoned within their context.
> 
> I could probably move this around, but we're at like 20 patches per groups of
> series, so I did it this way to keep the logical separation as clean as
> possible, and drastically reduce the amount of complex things you guys are
> needing to look at individually.  Thanks,

This approach works for me.
