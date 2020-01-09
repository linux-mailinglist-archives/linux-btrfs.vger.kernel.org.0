Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F38135B8A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 15:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbgAIOh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 09:37:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:41942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgAIOh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 09:37:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5561FB0B8;
        Thu,  9 Jan 2020 14:37:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6769BDA7FF; Thu,  9 Jan 2020 15:37:42 +0100 (CET)
Date:   Thu, 9 Jan 2020 15:37:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN reports caused by
 extended reloc tree lifespan
Message-ID: <20200109143742.GN3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200108051200.8909-1-wqu@suse.com>
 <7482d2f3-f3a1-7dd9-6003-9042c1781207@toxicpanda.com>
 <2bfd87cf-2733-af0d-f33f-59e07c25d500@suse.com>
 <20200108150841.GH3929@twin.jikos.cz>
 <20200108151159.GI3929@twin.jikos.cz>
 <85422cb2-e140-563b-fadd-f820354ed156@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85422cb2-e140-563b-fadd-f820354ed156@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 09, 2020 at 01:54:34PM +0800, Qu Wenruo wrote:
> >> The way I read it is more like smp_rmb/smp_wmb, but for bits in this
> >> case, so the smp_mb__before/after_atomic was only a syntactic sugar to
> >> match that it's atomic bitops. I realize this could have caused some
> >> confusion, however I still think that some sort of barrier is needed.
> >
> > There's an existing pattern used for serializing set/clear of
> > BTRFS_ROOT_IN_TRANS_SETUP (record_root_in_trans,
> > btrfs_record_root_in_trans).
> >
> > Once upon a time there were barriers like smp_mb__before_clear_bit but
> > they got unified to just smp_mb__before_atomic for all set/clear
> > operations, so I believe I was not all wrong with using them.
> >
> I used to believe the same fairy tail, that mb() works like a flush(),
> but we're not living in a fairy tail.

This sounds strange, by flush I was refering to internal CPU mechanism
that makes all temporary changes visible to other cpus, so you're saying
that this does not work as everybody expects?

> What mb really does is keep certain ordering from happening.
> And ordering means, we have at least *2* different memory accesses.

Sorry but I think you're missing some pieces here. There are 2 memory
accesses: set_bit/clear_bit (writer) and test_bit (reader).

The same could be achieved by a plain variable, that it's a bit brings
more confusion about what barrier should be really used.

The pattern we want to use here is pretty standard. Read barrier before
read and write barrier that separates the data change from the indicator
of the change. If you line up the barriers, there's a clear line between
the data changes and the indicator value.

reloc_root = NULL
smp_wmb                           smp_rmb()
                                  test_bit()
                                  ... here
set_bit(DEAD)
                                  ... or here, it'll be always
				  reloc_root == NULL, but it still could
				  be before or after set_bit

You should also distinguish between mb() and smp_mb() (and the rmb/wmb).
mb is a unconditional barrier, used to synchronize access to hardware io
ports, suitable in drivers.

We use smp_mb() because this serializes memory among multipe CPUs, when
one changes memory but stores it to some temporary structures, while
other CPUs don't see the effects. I'm sure you've read about that in the
memory barrier docs.

> It's not to ensure every reader get the same result, as there is no way
> to do that. Read can happen whenever they want.

That is true about the 'whenever', but what we need to guarantee here is
that when the read happens the following condition will have view of the
changes implied by the pairing barrier.

> So before we talk about mb, we first need to know which 2 memory
> accesses we're talking about.
> If there is even no 2 memory access, then there is no need for mb().
> 
> E.g. for the mb implied by spinlock(), it's not to ensure the spinlock
> counter reader, but to ensure the memory ordering between the spinlock
> counter itself and the memory it's protecting.
> 
> So for memory barrier around test_bit(), as long as the compiler is not
> doing reordering, we don't need extra mb.

This is not about compiler.

> And if the compiler is really doing re-ordering for the
> have_reloc_root(), then the compiler is doing something wrong, as that
> would makes the test_bit() meaningless.
