Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA796484C1B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 02:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiAEBcG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 20:32:06 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:35254 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234314AbiAEBcG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 20:32:06 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 6F06913AAF2; Tue,  4 Jan 2022 20:32:05 -0500 (EST)
Date:   Tue, 4 Jan 2022 20:32:05 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: "hardware-assisted zeroing"
Message-ID: <YdT1FQBMzTyIMKjQ@hungrycats.org>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
 <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
 <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
 <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
 <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
 <YdSy09eCHqU5sgez@hungrycats.org>
 <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 04, 2022 at 05:37:05PM -0500, Eric Levy wrote:
> On Tue, 2022-01-04 at 15:49 -0500, Zygo Blaxell wrote:
> 
> > Cheap SSD devices wear out faster when issued a lot of discards mixed
> > with small writes, as they lack the specialized hardware and firmware
> > necessary to make discards low-wear operations.  The same flash
> > component
> > is used for both FTL persistence (where discards cause wear) and user
> > data (where writes cause wear), so interleaved short writes and
> > discards
> > cause double the wear compared to the same short writes without
> > discards.
> > The fstrim man page advises not running trim more than once a week to
> > avoid prematurely aging SSDs in this category, while the discard
> > mount
> > option is equivalent to running fstrim 2000-3000 times a day.
> 
> It seems much of the discussion relates to the design of physical
> hardware. I would need to learn more about SDD to understand why the
> operations are useful on them, as my thought had been that they would
> be helpful for thin-provisioned logical volumes, but not meaningful on
> physical devices.
> 
> I wonder whether the same or a different set of concerns from the ones
> raised would be most helpful when considering management of non-
> physical devices.

You'll still have the locked block groups with the discard mount option,
whether those are good or bad for your workload.

There are two main categories of trim command:  one that guarantees a
particular data value when reading from previously trimmed blocks, and
one that makes no such guarantee (i.e. it may leave the data unchanged,
filled with garbage, or any other contents).

The first kind is usually equivalent to at least one page write,
because it can't be reordered or dropped, and opportunities to merge
are strictly limited, but it must be persisted.

The second kind is much faster since no persistent write is required
to implement the trim itself.  The thin volume can merge the trim with
later writes that update persistent data, or persist the trim in a
background thread without blocking data writes.

This distinction holds for SSDs and also thin volumes (or caching volumes,
or in general any software, including drive firmware, that exists below
the filesystem layer).  The lower layer also usually controls which set
of trim semantics are available to the upper layer.
