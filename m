Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BADCDC438
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633459AbfJRL4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 07:56:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:35600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729946AbfJRL4a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 07:56:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A8DDAD45;
        Fri, 18 Oct 2019 11:56:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7D386DA785; Fri, 18 Oct 2019 13:56:43 +0200 (CEST)
Date:   Fri, 18 Oct 2019 13:56:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: document extent buffer locking
Message-ID: <20191018115643.GA3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <ed989ccddbc8822e61df533d861d907ce0a43040.1571340084.git.dsterba@suse.com>
 <01b47547-44fc-966f-fae2-3b7138f40adc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b47547-44fc-966f-fae2-3b7138f40adc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 18, 2019 at 08:17:44AM +0800, Qu Wenruo wrote:
> > + * Required semantics:
> > + *
> > + * - reader/writer exclusion
> > + * - writer/writer exclusion
> > + * - reader/reader sharing
> > + * - spinning lock semantics
> > + * - blocking lock semantics
> > + * - try-lock semantics for readers and writers
> > + * - one level nesting, allowing read lock to be taken by the same thread that
> > + *   already has write lock
> 
> Any example about this scenario? IIRC there is only one user of nested lock.
> Although we know it exists for a long time, I guess it would be better
> trying to remove such call sites?

It could make a few things easier on the locking side, but I don't know
how much intrusive it would be in the scenario where it happens. The
stacktrace is quite long so some sort of propagation of the locked
context would have to happen.

> 
> > + *
> > + * The extent buffer locks (also called tree locks) manage access to eb data.
> 
> One of my concern related to "access to eb data" is, to access some
> member, we don't really need any lock at all.
> 
> Some members should never change during the lifespan of an eb. E.g.
> bytenr, transid.

Ok, so the paragraph can be more specific that the locking concerns the
b-tree data, ie. item keys and the corresponding item data.

> Some code is already taking advantage of this, like tree-checker
> checking the transid without holding a lock.
> Not sure if we should take use of this.
> 
> > + * We want concurrency of many readers and safe updates. The underlying locking
> > + * is done by read-write spinlock and the blocking part is implemented using
> > + * counters and wait queues.
> > + *
> > + * spinning semantics - the low-level rwlock is held so all other threads that
> > + *                      want to take it are spinning on it.
> > + *
> > + * blocking semantics - the low-level rwlock is not held but the counter
> > + *                      denotes how many times the blocking lock was held;
> > + *                      sleeping is possible
> 
> What about an example/state machine of all read/write and
> spinning/blocking combination?

The sate machine is really trivial, either use just the spinning locks
or at some point do set lock blocking and unblock/unlock at the end. The
main difference is whether the rwlock is held or not.

A few more words about that are in
https://github.com/btrfs/btrfs-dev-docs/blob/master/extent-buffer-locking.txt
