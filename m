Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADF547849B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 06:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhLQFk5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 00:40:57 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:40686 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230052AbhLQFk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 00:40:56 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 6B7B0F9260; Fri, 17 Dec 2021 00:40:55 -0500 (EST)
Date:   Fri, 17 Dec 2021 00:40:55 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kreijack@inwind.it, David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Message-ID: <Ybwi58Uivf29oGhw@hungrycats.org>
References: <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain>
 <YbfN8gXHsZ6KZuil@hungrycats.org>
 <71e523dc-2854-ca9b-9eee-e36b0bd5c2cb@libero.it>
 <Ybj40IuxdaAy75Ue@hungrycats.org>
 <Ybj/0ITsCQTBLkQF@localhost.localdomain>
 <be4e6028-7d1d-6ba9-d16f-f5f38a79866f@libero.it>
 <Ybn0aq548kQsQu+z@localhost.localdomain>
 <633ccf8f-3118-1dda-69d2-0398ef3ffdb7@libero.it>
 <YbqOwN7SW7NWm5/S@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbqOwN7SW7NWm5/S@localhost.localdomain>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 15, 2021 at 07:56:32PM -0500, Josef Bacik wrote:
> On Wed, Dec 15, 2021 at 07:53:40PM +0100, Goffredo Baroncelli wrote:
> > On 12/15/21 14:58, Josef Bacik wrote:
> > > On Tue, Dec 14, 2021 at 09:41:21PM +0100, Goffredo Baroncelli wrote:
> > > > On 12/14/21 21:34, Josef Bacik wrote:
> > > > > On Tue, Dec 14, 2021 at 03:04:32PM -0500, Zygo Blaxell wrote:
> > > > > > On Tue, Dec 14, 2021 at 08:03:45PM +0100, Goffredo Baroncelli wrote:
> > > > 
> > > > > > 
> > > > > > I don't have a strong preference for either sysfs or ioctl, nor am I
> > > > > > opposed to simply implementing both.  I'll let someone who does have
> > > > > > such a preference make their case.
> > > > > 
> > > > > I think echo'ing a name into sysfs is better than bits for sure.  However I want
> > > > > the ability to set the device properties via a btrfs-progs command offline so I
> > > > > can setup the storage and then mount the file system.  I want
> > > > > 
> > > > > 1) The sysfs interface so you can change things on the fly.  This stays
> > > > >      persistent of course, so the way it works is perfect.
> > > > > 
> > > > > 2) The btrfs-progs command sets it on offline devices.  If you point it at a
> > > > >      live mounted fs it can simply use the sysfs thing to do it live.
> > > > 
> > > > #2 is currently not implemented. However I think that we should do.
> > > > 
> > > > The problem is that we need to update both:
> > > > 
> > > > - the superblock		(simple)
> > > > - the dev_item item		(not so simple...)
> > > > 
> > > > What about using only bits from the superblock to store this property ?
> > > 
> > > I'm looking at the patches and you only are updating the dev_item, am I missing
> > > something for the super block?
> > 
> > When btrfs write the superblocks (see write_all_supers() in disk-io.c), it copies
> > the dev_item fields (contained in fs_info->fs_devices->devices lists) in each
> > superblock before updating it.
> > 
> 
> Oh right.  Still, I hope we're doing this correctly in btrfs-progs, if not
> that's a problem.
> 
> > > 
> > > For offline all you would need to do is do the normal open_ctree,
> > > btrfs_search_slot to the item and update the device item type, that's
> > > straightforward.
> > > 
> > > For online if you use btrfs prop you can see if the fs is mounted and just find
> > > the sysfs file to modify and do it that way.
> > > 
> > > But this also brings up another point, we're going to want a compat bit for
> > > this.  It doesn't make the fs unusable for old kernels, so just a normal
> > > BTRFS_FS_COMPAT_<whatever> flag is fine.  If the setting gets set you set the
> > > compat flag.
> > 
> > Why we need a "compact" bit ? The new kernels know how treat the dev_item_type field.
> > The old kernels ignore it. The worst thing is that a filesystem may require a balance
> > before reaching a good shape (i.e. the metadata on ssd and the data on a spinning disk)
> 
> So you can do the validation below, tho I'm thinking I care about it less, if we
> just make sure that type is correct regardless of the compat bit then that's
> fine.  Thanks,

In theory if you get stuck in an impossible allocation situation (like all
your disks are data-only and you run out of metadata space) then one way
to recover from it is to mount with an old kernel which doesn't respect
the type bits.  Another way to recover would be to flip the type bits
while the filesystem is offline with btrfs-progs.  A third way would be to
have a mount option for newer kernels to ignore the allocation bits like
old kernels do (yes I know I already said I didn't like that idea).

If we have a bit that says "old kernels don't mount this filesystem any
more" then we lose one of those recovery options, and the other options
aren't implemented yet.

While I think of it, the metadata reservation system eventually needs
to know that it can't use data-only devices for metadata, the same way
that df eventually needs to know about metadata-only devices.


> Josef
> 
