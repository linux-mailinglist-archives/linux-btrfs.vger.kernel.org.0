Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36CD3CAA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 14:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404493AbfFKMCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 08:02:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404489AbfFKMCU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 08:02:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDBC6AEC3;
        Tue, 11 Jun 2019 12:02:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4EF3DDA8CC; Tue, 11 Jun 2019 14:03:09 +0200 (CEST)
Date:   Tue, 11 Jun 2019 14:03:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hugo Mills <hugo@carfax.org.uk>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] RAID1 with 3- and 4- copies
Message-ID: <20190611120309.GD3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hugo Mills <hugo@carfax.org.uk>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1559917235.git.dsterba@suse.com>
 <20190610124226.GA21016@carfax.org.uk>
 <20190610140235.GF30187@twin.jikos.cz>
 <20190610144806.GB21016@carfax.org.uk>
 <20190611095314.GC24160@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611095314.GC24160@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 11, 2019 at 11:53:15AM +0200, David Sterba wrote:
> On Mon, Jun 10, 2019 at 02:48:06PM +0000, Hugo Mills wrote:
> > On Mon, Jun 10, 2019 at 04:02:36PM +0200, David Sterba wrote:
> > > On Mon, Jun 10, 2019 at 12:42:26PM +0000, Hugo Mills wrote:
> > > >    Hi, David,
> > > > 
> > > > On Mon, Jun 10, 2019 at 02:29:40PM +0200, David Sterba wrote:
> > > > > this patchset brings the RAID1 with 3 and 4 copies as a separate
> > > > > feature as outlined in V1
> > > > > (https://lore.kernel.org/linux-btrfs/cover.1531503452.git.dsterba@suse.com/).
> > > > [...]
> > > > > Compatibility
> > > > > ~~~~~~~~~~~~~
> > > > > 
> > > > > The new block group types cost an incompatibility bit, so old kernel
> > > > > will refuse to mount filesystem with RAID1C3 feature, ie. any chunk on
> > > > > the filesystem with the new type.
> > > > > 
> > > > > To upgrade existing filesystems use the balance filters eg. from RAID6
> > > > > 
> > > > >   $ btrfs balance start -mconvert=raid1c3 /path
> > > > [...]
> > > > 
> > > >    If I do:
> > > > 
> > > > $ btrfs balance start -mprofiles=raid13c,convert=raid1 \
> > > >                       -dprofiles=raid13c,convert=raid6 /path
> > > > 
> > > > will that clear the incompatibility bit?
> > > 
> > > No the bit will stay, even though there are no chunks of the raid1c3
> > > type. Same for raid5/6.
> > > 
> > > Dropping the bit would need an extra pass trough all chunks after
> > > balance, which is feasible and I don't see usability surprises. That you
> > > ask means that the current behaviour is probably opposite to what users
> > > expect.
> > 
> >    We've had a couple of cases in the past where people have tried out
> > a new feature on a new kernel, then turned it off again and not been
> > able to go back to an earlier kernel. Particularly in this case, I can
> > see people being surprised at the trapdoor. "I don't have any RAID13C
> > on this filesystem: why can't I go back to 5.2?"
> 
> Undoing the incompat bit is expensive in some cases, eg. for ZSTD this
> would mean to scan all extents, but in case of the raid profiles it's
> easy to check the list of space infos that are per-profile.
> 
> So, my current idea is to use the sysfs interface. The /features
> directory lists the files representing features and writing 1 to the
> file followed by a sync would trigger the rescan and drop the bit
> eventually.
> 
> The meaning of the /sys/fs/btrfs/features/* is defined for 1, which
> means 'can be set at runtime', so the ability to unset the feature would
> be eg. 3, as a bitmask of possible actions (0b01 set, 0b10 unset).
> 
> We do have infrastructure for changing the state in a safe manner even
> from sysfs, which sets a bit somewhere and commit processes that. That's
> why the sync is required, but I don't think that's harming usability t

Scratch that, there's much simpler way and would work as expected in the
example. Ie. after removing last bg of the given type the incompat bit
will be dropped.
