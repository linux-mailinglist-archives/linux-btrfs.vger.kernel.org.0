Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78B7E8EA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 18:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfJ2Ruy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 13:50:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:45048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfJ2Ruy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 13:50:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A88E2AF05;
        Tue, 29 Oct 2019 17:50:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B894BDA734; Tue, 29 Oct 2019 18:51:00 +0100 (CET)
Date:   Tue, 29 Oct 2019 18:51:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: serialize blocking_writers updates
Message-ID: <20191029175059.GA3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <2a310858bfa3754f6f7a4d4b7693959b0fdd7005.1571340084.git.dsterba@suse.com>
 <be519bc7-c541-34ee-80b9-57fe63135f06@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be519bc7-c541-34ee-80b9-57fe63135f06@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 12:57:00PM +0300, Nikolay Borisov wrote:
> 
> 
> On 17.10.19 г. 22:39 ч., David Sterba wrote:
> > There's one potential memory ordering problem regarding
> > eb::blocking_writers, although this hasn't been hit in practice. On TSO
> > (total store ordering) architectures, the writes will always be seen in
> > right order.
> > 
> > In case the calls in btrfs_set_lock_blocking_write are seen in this
> > (wrong) order on another CPU:
> > 
> > 0:  /* blocking_writers == 0 */
> > 1:  write_unlock()
> > 2:  blocking_writers = 1
> > 
> > btrfs_try_tree_read_lock, btrfs_tree_read_lock_atomic or
> > btrfs_try_tree_write_lock would have to squeeze all of this between 1:
> > and 2:
> 
> This is only a problem for unlocked (optimistic) accesses in those
> functions. Simply because from its POV the eb->lock doesn't play any
> role e.g. they don't know about it at all.

No the lock is important here. Let's take btrfs_try_tree_read_lock as
example for 2nd thread:

T1:                            T2:
write_unlock
                               blocking_writers == 0
			       try_readlock (success, locked)
			       if (blocking_writers) return -> not taken
blocking_writers = 1

Same for btrfs_tree_read_lock_atomic (with read_lock) and
btrfs_try_tree_write_lock (with write_lock)

IMO it's the other way around than you say, the optimistic lock is
irrelevant. We need the blocking_writers update sneak into a locked
section.

> This implies there needs to be yet another synchronization/ordering
> mechanism only for blocking_writer. But then further down you say that
> there are no read side barrier because observing the accesses in a
> particular order is not important for correctness.
> 
> Given this I fail to see what this smp_wmb affects ordering.

So in the steps above:

T1:                            T2:
blocking_writers = 1
smp_mb()
write_unlock
                               blocking_writers == 1
			       	-> take the fast path and return

> > +		/*
> > +		 * Writers must be be updated before the lock is released so
> > +		 * that other threads see that in order. Otherwise this could
> > +		 * theoretically lead to blocking_writers be still set to 1 but
> > +		 * this would be unexpected eg. for spinning locks.
> > +		 *
> > +		 * There are no pairing read barriers for unlocked access as we
> > +		 * don't strictly need them for correctness (eg. in
> > +		 * btrfs_try_tree_read_lock), and the unlock/lock is an implied
> > +		 * barrier in other cases.
> > +		 */
> > +		smp_wmb();
> >  		write_unlock(&eb->lock);
> 
> That comment sounds to me as if you only care about the readers of
> blocking_writers _after_ they have acquired the eb::lock for reading. In
> this case this smp_wmb is pointless because write_unlock/write_lock
> imply release/acquire semantics.

The pairing read side barrier would have to be before all reads of
blocking_writers, eg.

180 int btrfs_try_tree_read_lock(struct extent_buffer *eb)
181 {

            smp_rmb();

182         if (eb->blocking_writers)
183                 return 0;

ant it won't be wrong, the value would be most up to date as it could be. And
givent that this is an optimistic shortcut, lack of synchronized read might
pessimize that. Ie. blocking_writers is already 0 but the update is not
propagated and btrfs_try_tree_read_lock returns.

This is in principle indistinguishable from a state where the lock is
still locked. Hence the 'not needed for correctness' part. And then the
barrier can be avoided.

The write side needs the barrier to order write and unlock. The
unlock/lock implied barrier won't help as the read-side check happens in
the middle of that.
