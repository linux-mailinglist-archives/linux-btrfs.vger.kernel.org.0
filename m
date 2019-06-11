Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4443C803
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404572AbfFKKCw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jun 2019 06:02:52 -0400
Received: from twin.jikos.cz ([91.219.245.39]:57131 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404406AbfFKKCw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jun 2019 06:02:52 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 06:02:51 EDT
Received: from twin.jikos.cz (dave@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id x5B9rFGb015786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Jun 2019 11:53:16 +0200
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id x5B9rF6Y015785;
        Tue, 11 Jun 2019 11:53:15 +0200
Date:   Tue, 11 Jun 2019 11:53:15 +0200
From:   David Sterba <dave@jikos.cz>
To:     Hugo Mills <hugo@carfax.org.uk>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] RAID1 with 3- and 4- copies
Message-ID: <20190611095314.GC24160@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1559917235.git.dsterba@suse.com>
 <20190610124226.GA21016@carfax.org.uk>
 <20190610140235.GF30187@twin.jikos.cz>
 <20190610144806.GB21016@carfax.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610144806.GB21016@carfax.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 10, 2019 at 02:48:06PM +0000, Hugo Mills wrote:
> On Mon, Jun 10, 2019 at 04:02:36PM +0200, David Sterba wrote:
> > On Mon, Jun 10, 2019 at 12:42:26PM +0000, Hugo Mills wrote:
> > >    Hi, David,
> > > 
> > > On Mon, Jun 10, 2019 at 02:29:40PM +0200, David Sterba wrote:
> > > > this patchset brings the RAID1 with 3 and 4 copies as a separate
> > > > feature as outlined in V1
> > > > (https://lore.kernel.org/linux-btrfs/cover.1531503452.git.dsterba@suse.com/).
> > > [...]
> > > > Compatibility
> > > > ~~~~~~~~~~~~~
> > > > 
> > > > The new block group types cost an incompatibility bit, so old kernel
> > > > will refuse to mount filesystem with RAID1C3 feature, ie. any chunk on
> > > > the filesystem with the new type.
> > > > 
> > > > To upgrade existing filesystems use the balance filters eg. from RAID6
> > > > 
> > > >   $ btrfs balance start -mconvert=raid1c3 /path
> > > [...]
> > > 
> > >    If I do:
> > > 
> > > $ btrfs balance start -mprofiles=raid13c,convert=raid1 \
> > >                       -dprofiles=raid13c,convert=raid6 /path
> > > 
> > > will that clear the incompatibility bit?
> > 
> > No the bit will stay, even though there are no chunks of the raid1c3
> > type. Same for raid5/6.
> > 
> > Dropping the bit would need an extra pass trough all chunks after
> > balance, which is feasible and I don't see usability surprises. That you
> > ask means that the current behaviour is probably opposite to what users
> > expect.
> 
>    We've had a couple of cases in the past where people have tried out
> a new feature on a new kernel, then turned it off again and not been
> able to go back to an earlier kernel. Particularly in this case, I can
> see people being surprised at the trapdoor. "I don't have any RAID13C
> on this filesystem: why can't I go back to 5.2?"

Undoing the incompat bit is expensive in some cases, eg. for ZSTD this
would mean to scan all extents, but in case of the raid profiles it's
easy to check the list of space infos that are per-profile.

So, my current idea is to use the sysfs interface. The /features
directory lists the files representing features and writing 1 to the
file followed by a sync would trigger the rescan and drop the bit
eventually.

The meaning of the /sys/fs/btrfs/features/* is defined for 1, which
means 'can be set at runtime', so the ability to unset the feature would
be eg. 3, as a bitmask of possible actions (0b01 set, 0b10 unset).

We do have infrastructure for changing the state in a safe manner even
from sysfs, which sets a bit somewhere and commit processes that. That's
why the sync is required, but I don't think that's harming usability too
much.
