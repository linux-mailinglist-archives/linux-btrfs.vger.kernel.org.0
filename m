Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A624829C5
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 06:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiABF5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jan 2022 00:57:35 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:47058 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbiABF5e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Jan 2022 00:57:34 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id B17401308ED; Sun,  2 Jan 2022 00:57:33 -0500 (EST)
Date:   Sun, 2 Jan 2022 00:57:33 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed
Message-ID: <YdE+zWLrQhAmAX6F@hungrycats.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
 <Yc9Wgsint947Tj59@hungrycats.org>
 <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
 <YdDAGLU7M5mx7rL8@hungrycats.org>
 <59a9506eb880b054f8eff90d5b26ad0c673c7e1f.camel@ericlevy.name>
 <YdDurReZpZQeo+7/@hungrycats.org>
 <109cc618254b1f8d9365bd4ecb7eb435dea91353.camel@ericlevy.name>
 <YdEbsxw7Nk0GKKzN@hungrycats.org>
 <b6f84999f9506ca2e72673d8e94e72a0f29cea11.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f84999f9506ca2e72673d8e94e72a0f29cea11.camel@ericlevy.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 01, 2022 at 11:03:25PM -0500, Eric Levy wrote:
> On Sat, 2022-01-01 at 22:27 -0500, Zygo Blaxell wrote:
> 
> > Yes, that's normal with lazy umounts.  With a lazy umount, the mount
> > point is removed immediately, so you get all the behavior you
> > described,
> > but the filesystem is not actually umounted until after the last open
> > file descriptors referencing the filesystem are closed (that's the
> > "lazy" part).
> 
> All of the explicit umount calls I gave had no lazy flag. I don't
> understand the full details of your comments, as I am only aware of
> lazy umount as a fallback for failing umount calls in synchronous
> operations.
> 
> It seems the way mounts work, especially when interacting with user
> space solutions, such as FUSE and Gvfs, is often burdened by legacy
> design never updated to work properly. I have seen Gvfs pull down an
> entire system from trying to access a file in a user mount, since the
> mount was made before a network connection with the Samba server was
> dropped.
> 
> For laptops these kinds of vulnerability are quite debilitating.

Indeed.  A lot of users get bitten by this.

If there were block device connectivity issues (or udev integration
issues) then systemd or udev seem to "helpfully" lazy-umount filesystems
in some cases.

With other filesystems, multiple instances of the same filesystem uuid
can be mounted on different block devices and mount points, so the
lingering lazy-umounted filesystem can be ignored.  They take up some
kernel memory and make a little noise during writeback events, but they
are otherwise inert as no process can access them and they have no access
to any device they could write to.

With btrfs, this is a disaster, as each btrfs filesystem uuid can be
mounted exactly once in any given kernel, and all following mounts
of the same uuid are converted into bind mounts on subvols.  If the
filesystem gets into a bad state and is lazy-umounted, there's no easy
way to recover.

> > Since you're transitioning from one disk to multiple disks, you
> > should
> > convert metadata to raid1, and ensure there's sufficient unallocated
> > space on the first drive to hold metadata as it grows.  This can be
> > done
> 
> I thought it was the default for disk pools, fully duplicated metadata,
> and JBOD-style for payload data.

If you mkfs and start with a completely empty filesystem, that's true.

If you add a second disk to a previously single-disk filesystem, the
existing data will be in single and dup profiles.  New data will still
be single profile, but new metadata will be raid1, and that imposes the
requirement that there be sufficient space on _both_ disks to allocate
all existing and future metadata in raid1.  If the first disk is near
full when the second disk is added, this requirement is almost certainly
not met.

> > with two balance commands:
> > 
> > 	btrfs balance start -dlimit=16 /fs
> > 
> > 	btrfs balance start -mconvert=raid1,soft /fs
> 
> Does balance manage balanced utilization of disks? For specific
> scenarios, unbalanced disk usage is actually desirable, for example, my
> current one, in which the devices are logical volumes on a redundant
> back end. Using as much of one volume as possible simplifies
> reallocation of back end storage resources.

btrfs balance is a tool for relocating data, converting between RAID
profiles, or changing chunk allocations from data to metadata.  In this
case, we want to move a few GB of data to the second disk so that there
will be room for metadata on both disks.  With the limit filter, this
is only 3% of a full balance for a 500GB filesystem (though if you have
enough IO time to spare for that, you can go ahead and do a full balance
if that's simpler to manage).  This will get the filesystem close enough
to its final state with two disks that normal allocations can proceed
until the disks fill up.

btrfs balance does not manage future disk utilization, other than by
rearranging data and free space to get desirable allocator behavior
in the future.  The allocator algorithms are all fixed, and optimized
for maximum available space usage starting from an empty filesystem.
All use cases that are different from that are a bit of a challenge on
btrfs (e.g. SSD metadata, remote mirror devices, starting from non-initial
conditions after a profile change, adding a device, increasing the size
of a device...the list goes on).

Note that btrfs 'single' profile always fills the disk with the most
free space first ('raid1' profile fills the two disks with the most free
space first).  If you add a new disk to an existing array with single
data, all the new data will typically be allocated on the new disk
(unless the old disk is much larger than the new one).  This makes all
the space usable regardless of which profile is used for metadata.

If this is not what you want, you could use 'btrfs fi resize' to resize
the second device smaller, and resize it larger again over time as it
fills up, but you'll have to monitor that closely and make continuous
adjustments as you're forcing the allocator to do the opposite of its
normal behavior (don't resize the physical device, just the amount of
the device that btrfs will use).

> ---
> 
> I am noticing that the order of devices in now reversed. I am wondering
> whether what happened is that iSCSI, either on the client or server
> side, reversed the order, by some quirk or design flaw. while I had the
> live mount. 

Device order (mapping of /dev/sd? device to underlying storage) usually
isn't guaranteed, but once it's set it tends to be persistent; otherwise,
disastrous problems would occur with every multi-device Linux subsystem:
btrfs, mdadm, lvm, and dm-crypt would all significantly damage their data
if the mapping from subdevice to physical storage changed unexpectedly
while they were active.

In disconnect-reconnect cases, the old device is reconnected only if it
can be reliably identified; otherwise, an entirely new device is created
(as in the case where sdc became sdf after iSCSI logout and reconnect).

> Still, it doesn't explain why I originally was able to see
> the new, unpartitioned device and add it to the pool.

Why would you not be able to see both raw and partition devices?
Normally you can use either, just not both at the same time.

> Another possibility is that the sequence of add/remove/add, which I
> explained earlier, caused some problem, but it also seems not clear
> how, since all of these operations are synchronous.

I don't know the fine details of what the lower storage layers you've
chosen are doing, so I can't comment on specific sequences of operations.

Some interesting things can happen if the last writes before a device is
closed are lost--in the device add and remove cases, the device would
or would not be marked as belonging to the filesystem, with possible
surprising results when the filesystem is reassembled.  On the other
hand, most of the possible results are "the filesystem goes splat and
can't be mounted any more" or "the filesystem permanently adopts a
device that wasn't expected" and it doesn't sound like either of those
events happened.
