Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BAC46BFA6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 16:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhLGPof (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 10:44:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51234 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhLGPof (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 10:44:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F180721B3A;
        Tue,  7 Dec 2021 15:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638891663;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7ZvPt7TaVUFBL/hDiYU0Gq4o3sVqbCzTssYApICMEg=;
        b=BYdEDe2oZrq/YoXHCIluMuD3em5/rJ+mqb+yG/6DjsQ0hjpn+eZIrvqxk8HEioBNLLyxRS
        JZjbm83VonziRW4syDPU4VHPam6++872jriSrb1ZjXDmkLjmRYCEgnGFNT5YQ1gJwZ4rAB
        tsEfamyrOqPAbCPR2k3Y9BDFxp8DAUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638891663;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7ZvPt7TaVUFBL/hDiYU0Gq4o3sVqbCzTssYApICMEg=;
        b=NylRgH7FgsfJ8MkvDHnBgB5qEGBy3/IkVR9+OwAbx2iC+DseCPSoW33O0MBzX2Qw6gSFsa
        lqvrl/WJWREe3eAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E669DA3B83;
        Tue,  7 Dec 2021 15:41:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49C21DA799; Tue,  7 Dec 2021 16:40:49 +0100 (CET)
Date:   Tue, 7 Dec 2021 16:40:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
Message-ID: <20211207154048.GX28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20211207074400.63352-1-wqu@suse.com>
 <Ya8/NpvxmCCouKqg@debian9.Home>
 <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com>
 <Ya9L2qSe+XKgtesq@debian9.Home>
 <a91e60a4-7f5a-43eb-3c10-af2416aade9f@suse.com>
 <20211207145329.GW28560@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207145329.GW28560@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 07, 2021 at 03:53:29PM +0100, David Sterba wrote:
> On Tue, Dec 07, 2021 at 08:01:04PM +0800, Qu Wenruo wrote:
> > On 2021/12/7 19:56, Filipe Manana wrote:
> > > On Tue, Dec 07, 2021 at 07:43:49PM +0800, Qu Wenruo wrote:
> > >> On 2021/12/7 19:02, Filipe Manana wrote:
> > >>> On Tue, Dec 07, 2021 at 03:43:58PM +0800, Qu Wenruo wrote:
> > >>>> This is originally just my preparation for scrub refactors, but when the
> > >>>> readahead is involved, it won't just be a small cleanup.
> > >>>>
> > >>>> The metadata readahead code is introduced in 2011 (surprisingly, the
> > >>>> commit message even contains changelog), but now only one user for it,
> > >>>> and even for the only one user, the readahead mechanism can't provide
> > >>>> much help in fact.
> > >>>>
> > >>>> Scrub needs readahead for commit root, but the existing one can only do
> > >>>> current root readahead.
> > >>>
> > >>> If support for the commit root is added, is there a noticeable speedup?
> > >>> Have you tested that?
> > >>
> > >> Will craft a benchmark for that.
> > >>
> > >> Although I don't have any HDD available for benchmark, thus would only
> > >> have result from SATA SSD.
> 
> I'm doing some tests, in a VM on a dedicated HDD.

There's some measurable difference:

With readahead:

Duration:         0:00:20
Total to scrub:   7.02GiB
Rate:             236.92MiB/s

Duration:         0:00:48
Total to scrub:   12.02GiB
Rate:             198.02MiB/s

Without readahead:

Duration:         0:00:22
Total to scrub:   7.02GiB
Rate:             215.10MiB/s

Duration:         0:00:50
Total to scrub:   12.02GiB
Rate:             190.66MiB/s

The setup is: data/single, metadata/dup, no-holes, free-space-tree,
there are 8 backing devices but all reside on one HDD.

Data generated by fio like

fio --rw=randrw --randrepeat=1 --size=3000m \
	 --bsrange=512b-64k --bs_unaligned \
	 --ioengine=libaio --fsync=1024 \
	 --name=job0 --name=job1 \

and scrub starts right away this. VM has 4G or memory and 4 CPUs.

The difference is 2 seconds, roughly 4% but the sample is not large
enough to be conclusive.
