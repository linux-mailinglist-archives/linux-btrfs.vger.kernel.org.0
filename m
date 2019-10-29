Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06DE918F
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 22:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfJ2VO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 17:14:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:35876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726747AbfJ2VO6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 17:14:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34D32ABC4;
        Tue, 29 Oct 2019 21:14:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 07D83DA734; Tue, 29 Oct 2019 22:15:05 +0100 (CET)
Date:   Tue, 29 Oct 2019 22:15:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: serialize blocking_writers updates
Message-ID: <20191029211505.GB3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <2a310858bfa3754f6f7a4d4b7693959b0fdd7005.1571340084.git.dsterba@suse.com>
 <be519bc7-c541-34ee-80b9-57fe63135f06@suse.com>
 <20191029175059.GA3001@twin.jikos.cz>
 <1bff6395-5f2e-f11b-55ba-01a4f59b4881@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bff6395-5f2e-f11b-55ba-01a4f59b4881@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 29, 2019 at 08:48:15PM +0200, Nikolay Borisov wrote:
> On 29.10.19 г. 19:51 ч., David Sterba wrote:
> > On Wed, Oct 23, 2019 at 12:57:00PM +0300, Nikolay Borisov wrote:
> >> On 17.10.19 г. 22:39 ч., David Sterba wrote:
> >>> There's one potential memory ordering problem regarding
> >>> eb::blocking_writers, although this hasn't been hit in practice. On TSO
> >>> (total store ordering) architectures, the writes will always be seen in
> >>> right order.
> >>>
> >>> In case the calls in btrfs_set_lock_blocking_write are seen in this
> >>> (wrong) order on another CPU:
> >>>
> >>> 0:  /* blocking_writers == 0 */
> >>> 1:  write_unlock()
> >>> 2:  blocking_writers = 1
> >>>
> >>> btrfs_try_tree_read_lock, btrfs_tree_read_lock_atomic or
> >>> btrfs_try_tree_write_lock would have to squeeze all of this between 1:
> >>> and 2:
> >>
> >> This is only a problem for unlocked (optimistic) accesses in those
> >> functions. Simply because from its POV the eb->lock doesn't play any
> >> role e.g. they don't know about it at all.
> > 
> > No the lock is important here. Let's take btrfs_try_tree_read_lock as
> > example for 2nd thread:
> > 
> > T1:                            T2:
> > write_unlock
> >                                blocking_writers == 0
> > 			       try_readlock (success, locked)
> > 			       if (blocking_writers) return -> not taken
> > blocking_writers = 1

Ok, follows from what you write below and I got it wrong as the above
can't happen because of the simple unlock/lock sequence. I don't know
why I missed that, the original changelog has enough clues to see that
too.

> > Same for btrfs_tree_read_lock_atomic (with read_lock) and
> > btrfs_try_tree_write_lock (with write_lock)
> > 
> > IMO it's the other way around than you say, the optimistic lock is
> > irrelevant. We need the blocking_writers update sneak into a locked
> > section.
> 
> But write_unlock is a release operation, as per memory-barriers.txt:
> 
> (6) RELEASE operations.
> 
>      This also acts as a one-way permeable barrier.  It guarantees that
> all  memory operations before the RELEASE operation will appear to
> happen  before the RELEASE operation with respect to the other
> components of the  system. RELEASE operations include UNLOCK operations
> and smp_store_release() operations.
> 
> ...
> 
> The use of ACQUIRE and RELEASE operations generally precludes the need
> for other sorts of memory barrier (but note the exceptions mentioned in
>  the subsection "MMIO write barrier").  In addition, a RELEASE+ACQUIRE
> pair is -not- guaranteed to act as a full memory barrier.  However,
> after  an ACQUIRE on a given variable, all memory accesses preceding any
> prior RELEASE on that same variable are guaranteed to be visible.
> 
> try_readlock is an ACQUIRE operation w.r.t the lock. So if it succeeds
> then all previous accesses e.g. blocking_writer = 1 are guaranteed to be
> visible because we have RELEASE (write_unlock ) + ACQUIRE (try_readlock
> in case of success).
> 
> So the blocking_write check AFTER try_readlock has succeeded is
> guaranteed to see the update to blocking_writers in
> btrfs_set_lock_blocking_write.

Yeah. As long as the slow paths check the value inside locks, we're
safe. And this is done in all the functions AFAICS.

So far we haven't found a problem with the locks on TSO and non-TSO
arches. Thanks for the barrier reasoning exercise, I'll drop the patch.
