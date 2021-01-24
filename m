Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C887D301BDF
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 13:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbhAXMcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 07:32:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:52284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbhAXMb7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 07:31:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B960ACF4;
        Sun, 24 Jan 2021 12:31:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8B894DA7D7; Sun, 24 Jan 2021 13:29:31 +0100 (CET)
Date:   Sun, 24 Jan 2021 13:29:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/18] btrfs: add read-only support for subpage sector
 size
Message-ID: <20210124122931.GF1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210118231744.GN6430@twin.jikos.cz>
 <9193d7a7-500a-044c-5964-593d93aa25b2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9193d7a7-500a-044c-5964-593d93aa25b2@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 19, 2021 at 07:26:17AM +0800, Qu Wenruo wrote:
> On 2021/1/19 上午7:17, David Sterba wrote:
> > On Sat, Jan 16, 2021 at 03:15:15PM +0800, Qu Wenruo wrote:
> > As the subpage support is
> > sort of an isolated feature we could afford to get the first batch of
> > code in and continue polishing. Read-only suppot with 64k/4k is a good
> > milestone so I'm not worried too much about some smaller things left
> > behind, as long as the default case page size == sectorsize works.
> 
> Yeah, that's the core design of current subpage support, all subpage
> will be handled in a different routine, leaving minimal impact to
> existing code.
> 
> >
> > Tests of this branch are still running but so far so good. I'll add it
> > as a topic branch to for-next for testing and my current plan is to push
> > it to misc-next soon, targeting 5.12.
> 
> That's great to hear.
> >
> >> In the subpage branch
> >> - Metadata read write and balance
> >>    Not yet full tested due to data write still has bugs need to be
> >>    solved.
> >>    But considering that metadata operations from previous iteration
> >>    is mostly untouched, metadata read write should be pretty stable.
> >
> > I assume the bugs are for the 64k/4k usecase.
> 
> Yes, at least the 4K case passes fstests in my local env.

I'd done a pre-merge pass last week with fixups in changlogs, subjects
and some coding style fixes but that was before Josef's comments. Some
of them still need updates but I also don't want to throw away my
changes.  (Ideally I don't have to do them at all, you can get the gist
of what are the most common things I'm fixing by comparing both versions.)

Please have a look at the branch ext/qu/subpage-v4 in my github repo,
the patches are in the same order as in this posted patchset. If the
patch does not change you can keep it as is, I'll reuse what I have.

For the final merge of the read-only support, patch 1 could be dropped
as discussed. The rest is hopefully ok to go, please resend, thanks.
