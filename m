Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DEC29CCF9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 02:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgJ1Bib (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 21:38:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1833014AbgJ0Xdd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 19:33:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6661AEDE;
        Tue, 27 Oct 2020 23:33:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7EF8ADAF58; Wed, 28 Oct 2020 00:31:57 +0100 (CET)
Date:   Wed, 28 Oct 2020 00:31:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 13/68] btrfs: extent_io: remove the
 extent_start/extent_len for end_bio_extent_readpage()
Message-ID: <20201027233157.GI6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-14-wqu@suse.com>
 <20201027102944.GZ6756@twin.jikos.cz>
 <f5f222af-8eb9-3a64-7b72-2c61e289eb33@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5f222af-8eb9-3a64-7b72-2c61e289eb33@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 27, 2020 at 08:15:58PM +0800, Qu Wenruo wrote:
> On 2020/10/27 下午6:29, David Sterba wrote:
> > On Wed, Oct 21, 2020 at 02:24:59PM +0800, Qu Wenruo wrote:
> >> In end_bio_extent_readpage() we had a strange dance around
> >> extent_start/extent_len.
> >>
> >> The truth is, no matter what we're doing using those two variable, the
> >> end result is just the same, clear the EXTENT_LOCKED bit and if needed
> >> set the EXTENT_UPTODATE bit for the io_tree.
> >>
> >> This doesn't need the complex dance, we can do it pretty easily by just
> >> calling endio_readpage_release_extent() for each bvec.
> >>
> >> This greatly streamlines the code.
> > 
> > Yes it does, the old code is a series of conditions and new code is just
> > one call but it's hard to see why this is correct. Can you please write
> > some guidance, what are the invariants or how does the logic simplify?
> > What you write above is a summary but for review I'd need something to
> > follow so I don't have to spend too much time reading just this patch.
> > Thanks.
> > 
> Sorry, I should add more explanation on that, would add that in next update.

Most of the patches 1-20 are ok so I've picked them to a branch and will
move to misc-next once the comments are answered. I've fixed what I
though does not need a resend but for this patch is probably something
that you should send and I try to understand.

What I have right now is in my github repo in branch
ext/qu/subpage-1-prep so you can have a look but you don't need to
resend the whole series, if you have updates to any of the patches reply
to it and I'll fold it in.
