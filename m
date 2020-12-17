Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7B2DD4FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 17:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgLQQNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 11:13:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:39222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgLQQNB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 11:13:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84207AC79;
        Thu, 17 Dec 2020 16:12:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8772BDA83A; Thu, 17 Dec 2020 17:10:39 +0100 (CET)
Date:   Thu, 17 Dec 2020 17:10:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/2] btrfs: fix races between clone, fallocate and memory
 mapped writes
Message-ID: <20201217161039.GQ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1607939569.git.fdmanana@suse.com>
 <20201217150203.GP6430@twin.jikos.cz>
 <CAL3q7H4ZacbJg_UL6RXv-j+RG4E6csQxW4M=Ea7_QchT4PcU-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4ZacbJg_UL6RXv-j+RG4E6csQxW4M=Ea7_QchT4PcU-Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 17, 2020 at 03:11:46PM +0000, Filipe Manana wrote:
> On Thu, Dec 17, 2020 at 3:03 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, Dec 14, 2020 at 09:56:40AM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > For a very long time there's been a race between clone/dedupe and memory
> > > mapped writes as well as between fallocate and memory mapped writes. For
> > > both cases the consequence of the race is that it can makes us deadlock
> > > when we are low on available metadata space, since clone/dedupe/fallocate
> > > start a transaction while holding file ranges locked, and allocating the
> > > metadata can result in the async reclaim task to flush the inodes being
> > > used by clone/dedupe/fallocate, if a memory mapped write happened before
> > > we locked the file ranges.
> > >
> > > For the dedupe case, Josef's recent fix [1] ("btrfs: fix race between dedupe
> > > and mmap") happens to fix this deadlock problem as well. The first patch
> > > in this patchset fixes the issue for both clone and dedupe, as it's centered
> > > on the shared extent locking function, and it is independent of Josef's fix
> > > (works both with and without that fix).
> >
> > Thanks, I was wondering how all the patches are related.
> > >
> > > [1] https://lore.kernel.org/linux-btrfs/afdc2109f83fff1a925d7a66a6a047d4400721d4.1607724668.git.josef@toxicpanda.com/
> > >
> > > Filipe Manana (2):
> > >   btrfs: fix race between cloning and memory mapped writes leading to
> > >     deadlock
> > >   btrfs: fix race between fallocate and memory mapped writes leading to
> > >     deadlock
> >
> > Added to misc-next, thanks.
> 
> Something I haven't mentioned afterwards, as I have been waiting for
> vger to deliver me the mails for another patchset from Josef (have
> been having 2 to 4 days delays) is that that patchset from Josef:
> 
> https://lore.kernel.org/linux-btrfs/cover.1607969636.git.josef@toxicpanda.com/
> 
> replaces this patchset and the following RFC patch:
> 
> https://lore.kernel.org/linux-btrfs/afdc2109f83fff1a925d7a66a6a047d4400721d4.1607724668.git.josef@toxicpanda.com/
> 
> We agreed on Slack that a more generic solution was better, even
> because the RFC patch above from Josef ended up being racy and didn't
> fully fix the problem.
> It doesn't help either that the cover letter for the above patchset
> from Josef did not mention this, nor was it discussed in the thread
> for the RFC patch.
> 
> So please drop this one and replace it with Josef's patchset. I had
> just given the review on github:
> https://github.com/btrfs/linux/issues/163

I see, thanks. Patches removed from misc-next.
