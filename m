Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24752FF3C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 20:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbhAUTGW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 14:06:22 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36158 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbhAUTFG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 14:05:06 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id CA08B94D2F9; Thu, 21 Jan 2021 13:54:00 -0500 (EST)
Date:   Thu, 21 Jan 2021 13:54:00 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     kreijack@inwind.it
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Message-ID: <20210121185400.GH28049@hungrycats.org>
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
 <765cec4e-b989-081b-2ad7-e2d1c9cf7f55@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <765cec4e-b989-081b-2ad7-e2d1c9cf7f55@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 21, 2021 at 07:16:05PM +0100, Goffredo Baroncelli wrote:
> On 1/20/21 5:02 PM, Josef Bacik wrote:
> > On 1/17/21 1:54 PM, Goffredo Baroncelli wrote:
> > > 
> > > Hi all,
> > > 
> > > This is an RFC; I wrote this patch because I find the idea interesting
> > > even though it adds more complication to the chunk allocator.
> > > 
> > > The basic idea is to store the metadata chunk in the fasters disks.
> > > The fasters disk are marked by the "preferred_metadata" flag.
> > > 
> > > BTRFS when allocate a new metadata/system chunk, selects the
> > > "preferred_metadata" disks, otherwise it selectes the non
> > > "preferred_metadata" disks. The intial patch allowed to use the other
> > > kind of disk in case a set is full.
> > > 
> > > This patches set is based on v5.11-rc2.
> > > 
> > > For now, the only user of this patch that I am aware is Zygo.
> > > However he asked to further constraint the allocation: i.e. avoid to
> > > allocated metadata on a not "preferred_metadata"
> > > disk. So I extended the patch adding 4 modes to operate.
> > > 
> > > This is enabled passing the option "preferred_metadata=<mode>" at
> > > mount time.
> > > 
> > 
> > I'll echo Zygo's hatred for mount options.  The more complicated policy decisions belong in properties and sysfs knobs, not mount options.
> > 
> I tend to agree. However adding a filesystem property can be done in a second time. I don't think that this a problem. However I prefer to make the patch smaller.
> 
> Anyway I have to point out that we need a way to change the allocation
> policy without changing the metadata otherwise we risk to be in the
> loop of exhausting metadata space: - how we can increase the space for
> metadata if we don't have space for metadata but I need to allocate
> few block of metadata....
> 
> What I mean is that even if we store the setting as filesystem
> properties (and definitely we have to do), we need a way to override
> in an emergency scenario.

There are no new issues introduced by this change, thus no requirement
for a mount option to deal with new issues.

The same issue comes up when changing RAID profile, or removing devices,
or when existing devices simply fill up.  Part of the solution is the
global reserve, which ensures we can always create a transaction to modify
a few metadata pages.

Part of the solution is a run-time check to ensure we have min_devs for
active RAID profiles whenever we change a device policy to reject data
or metadata (see btrfs_check_raid_min_devices).  This is currently
implemented for the device remove ioctl, and a similar check will
be needed for the device property set ioctl for preferred_metadata.
That part is missing in v5 of this patch and will have to be added,
though even now it works most of the time without.

v5 is also missing changes to the df statvfs code to deal with metadata
only devices.  At this stage it's an RFC patch, so that's OK, but it
will also need to be fixed.  We presume these will be addressed in future
versions.  Again, it works now, but 'df' will give the wrong number.

None of the above requirements is addressed by a mount option, and
the mount option adds new requirements that we don't want.

> > And then for the properties themselves, presumably we'll want to
> add other FS wide properties in the future.  I'm not against adding
> new actual keys and items to the tree itself, but is there a way
> we could use our existing property infrastructure that we use for
> compression, and simply store the xattrs in the tree root?  It looks
> like we're just toggling a policy decision, and we don't actually
> need the other properties in the item you've created, so why not
> just a btrfs.preferred_metadata property with the value stored in it,
> dropped into the tree_root so it can be read on mount?  Thanks,
> 
> What if the root subvolume is not mounted ? 

Same as device add or remove--if the filesystem isn't mounted, you can't
make any changes.

Note that all the required properties are per-device, so really you just
need any open FD on the filesystem.  (I think Josef didn't read that far
down).

The per-device policy storage can go in dev_root (tree 4) along with the
device stats data, if we don't want to use btrfs_device::type.  You'd still
need an ioctl to get to it.

Or maybe I'm misreading Josef here, and his idea is to make the per-device
configuration a string blob that can be set by putting an xattr on the
root subvol?  I'm not sure that's better, but it'll work.

> Yes we can create a further
> api to store/retrive this kind of metadata without mounting the root
> subvolume, but doing so in what it would be different than adding a
> key to the root fs like the default subvolume ioctl does ?

> > 
> > Josef
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
