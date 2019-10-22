Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9332DE023F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 12:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbfJVKlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 06:41:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:39652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388032AbfJVKlD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 06:41:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 708ABB3AA;
        Tue, 22 Oct 2019 10:41:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 610C6DA733; Tue, 22 Oct 2019 12:41:14 +0200 (CEST)
Date:   Tue, 22 Oct 2019 12:41:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: document extent buffer locking
Message-ID: <20191022104114.GS3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <ed989ccddbc8822e61df533d861d907ce0a43040.1571340084.git.dsterba@suse.com>
 <42052ba1-8333-b15b-344f-3330041daf52@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42052ba1-8333-b15b-344f-3330041daf52@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 22, 2019 at 12:53:29PM +0300, Nikolay Borisov wrote:
> 
> 
> On 17.10.19 г. 22:39 ч., David Sterba wrote:
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/locking.c | 110 +++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 96 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> > index e0e0430577aa..2a0e828b4470 100644
> > --- a/fs/btrfs/locking.c
> > +++ b/fs/btrfs/locking.c
> > @@ -13,6 +13,48 @@
> >  #include "extent_io.h"
> >  #include "locking.h"
> >  
> > +/*
> > + * Extent buffer locking
> > + * ~~~~~~~~~~~~~~~~~~~~~
> > + *
> > + * The locks use a custom scheme that allows to do more operations than are
> > + * available fromt current locking primitives. The building blocks are still
> > + * rwlock and wait queues.
> > + *
> > + * Required semantics:
> 
> Thinking out loud here..
> 
> > + *
> > + * - reader/writer exclusion
> 
> RWSEM has that
> 
> > + * - writer/writer exclusion
> 
> RWSEM has that
> 
> > + * - reader/reader sharing
> 
> RWSEM has that
> > + * - spinning lock semantics
> 
> RWSEM has that in the form of optimistic spinning which would be shorter
> than what the custom implementation provides.
> 
> > + * - blocking lock semantics
> 
> RWSEM has that

'blocking' in btrfs lock does not hold the rwlock, does rwsem do it the
same? The term might be confusing, a thread that tries to get a lock is
also blocking (and spinning while trying), but the point here is that
the lock is not held so any sleeping operation can happen. And with the
locking status offloaded, we're not nesting the locking primitives, but
only the big tree locks.

> > + * - try-lock semantics for readers and writers
> 
> down_write_trylock, down_read_trylock.
> 
> > + * - one level nesting, allowing read lock to be taken by the same thread that
> > + *   already has write lock
> 
> this might be somewhat problematic but there is downgrade_write which
> could be used, I'll have to check.

The read lock happens transaprently from the POV of the thread that
takes it. As there's only one known context where the write->read
happens, it would be possible to do some magic to convert it, but it's
still problematic.

The read-function is also called without the write lock. So it would
have to atomically check if the lock is held for write AND by the same
task. I don't know if this is feasible.
