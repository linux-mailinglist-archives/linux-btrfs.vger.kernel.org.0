Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667D82EEAAE
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 02:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbhAHBF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jan 2021 20:05:57 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47284 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbhAHBF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jan 2021 20:05:57 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 254E892D022; Thu,  7 Jan 2021 20:05:15 -0500 (EST)
Date:   Thu, 7 Jan 2021 20:05:14 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [RFC][PATCH V4] btrfs: preferred_metadata: preferred device for
 metadata
Message-ID: <20210108010511.GZ31381@hungrycats.org>
References: <20200528183451.16654-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528183451.16654-1-kreijack@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 28, 2020 at 08:34:47PM +0200, Goffredo Baroncelli wrote:
> 
> [the previous patches sets called this mode ssd_metadata]
> 
> Hi all,
> 
> This is an RFC; I wrote this patch because I find the idea interesting
> even though it adds more complication to the chunk allocator.
> 
> The initial idea was to store the metadata on the ssd and to leave the data
> on the rotational disks. The kind of disk was determined from the rotational
> flag. However looking only at the rotational flags is not flexible enough. So
> I added a device property called "preferred_metadata" to mark a device
> as preferred for metadata.
> 
> A separate patches set is sent to extend the "btrfs property" command
> for supporting the preferred_metadata device flag. The basic usage is:
> 
>     $ # set a new value
>     $ sudo btrfs property set /dev/vde preferred_metadata 1
>     
>     $ # get the current value
>     $ sudo btrfs property get /dev/vde preferred_metadata
>     devid=4, path=/dev/vde: dedicated_metadata=1
> 
> This new mode is enabled passing the option "preferred_metadata" at mount time.
> This policy of allocation is the default one. However if this doesn't permit
> a chunk allocation, the "classic" one is used.
> 
> Some examples: (/dev/sd[abc] are marked as preferred_metadata,
> and /dev/sd[ef] are not)
> 
> Non striped profile: metadata->raid1, data->raid1
> The data is stored on /dev/sd[ef], metadata is stored on /dev/sd[abc].
> When /dev/sd[ef] are full, then the data chunk is allocated also on
> /dev/sd[abc].
> 
> Striped profile: metadata->raid6, data->raid6
> raid6 requires 3 disks at minimum, so /dev/sd[ef] are not enough for a
> data profile raid6. To allow a data chunk allocation, the data profile raid6
> will be stored on all the disks /dev/sd[abcdef].
> Instead the metadata profile raid6 will be allocated on /dev/sd[abc],
> because these are enough to host this chunk.
> 
> The patches set is composed by four patches:
> 
> - The first patch adds the ioctl to update the btrfs_dev_item.type field.
> The ioctl is generic to handle more fields, however now only the "type"
> field is supported.
> 
> - The second patch adds the flag BTRFS_DEV_PREFERRED_METADATA which is
> used to mark a device as "preferred_metadata"
> 
> - The third patch exports the btrfs_dev_item.type field via sysfs files
> /sys/fs/btrfs/<UUID>/devinfo/<devid>/type
> 
> It is possible only to read the value. It is not implemented the updated
> of the value because in btrfs/stsfs.c there is a comment that states:
> "We don't want to do full transaction commit from inside sysfs".
> 
> - The fourth patch implements this new mode
> 
> Changelog:
> v4: - renamed ssd_metadata to preferred_metadata
>     - add the device property "preferred_metadata"
>     - add the ioctl BTRFS_IOC_DEV_PROPERTIES
>     - export the btrfs_dev_item.type values via sysfs
> v3: - correct the collision between BTRFS_MOUNT_DISCARD_ASYNC and
>       BTRFS_MOUNT_SSD_METADATA.
> v2: - rebased to v5.6.2
>     - correct the comparison about the rotational disks (>= instead of >)
>     - add the flag rotational to the struct btrfs_device_info to
>       simplify the comparison function (btrfs_cmp_device_info*() )
> v1: - first issue

I've been testing these patches for a while now.  They enable an
interesting use case that can't otherwise be done safely, sanely or
cheaply with btrfs.

Normally if we have an array of, say, 10 spinning disks, and we want to
implement a writeback cache layer with SSD, we would need 10 distinct SSD
devices to avoid reducing btrfs's ability to recover from drive failures.
The writeback cache will be modified on both reads and writes, data and
metadata, so we need high endurance SSDs if we want them to make it to
the end of their warranty.  The SSD firmware has to not have crippling
performance bugs while under heavy write load, which means we are now
restricted to an expensive subset of high endurance SSDs targeted at
the enterprise/NAS/video production markets...and we need 10 of them!

NVME has fairly draconian restrictions on drive count, and getting
anything close to 10 of them into a btrfs filesystem can be an expensive
challenge.  (I'm not counting solutions that use USB-to-NVME bridges
because those don't count as "sane" or "safe").

We can share the cache between disks, but not safely in writeback mode,
because a failure in one SSD could affect multiple logical btrfs disks.
Strictly speaking we can't do it safely in any cache mode, but at least
with a writethrough cache we can recover the btrfs by throwing the SSDs
away.

In the current btrfs raid5 and dm-cache implementations, a scrub through a
SSD/HDD cache pair triggers an _astronomical_ number of SSD cache writes
(enough to burn through a low-end SSD's TBW in a weekend).  That can
presumably be fixed one day, but it's definitely unusable today.

If we have only 2 NVME drives, with this patch, we can put them to work
storing metadata, leave the data on the spinning rust, and keep all
the btrfs self-repair features working, and get most of the performance
gain of SSD caching at significantly lower cost.  The write loads are
reasonable (metadata only, no data, no reads) so we don't need a high
endurance SSD.  With raid1/10/c3/c4 redundancy, btrfs can fix silent
metadata corruption, so we can even use cheap SSDs as long as they
don't hang when they fail.  We can use btrfs raid5/6 for data since
preferred_metadata avoids the bugs that kill the SSD when we run a scrub.

Now all we have to do is keep porting these patches to new kernels until
some equivalent feature lands in mainline.  :-P

I do have some comments about these particular patches:

I dropped the "preferred_metadata" mount option very early in testing.
Apart from the merge conflicts with later kernels, the option is
redundant, since we could just as easily change all the drive type
properties back to 0 to get the same effect.  Adding an incompatible
mount option (and potentially removing it again after a failed test)
was a comparatively onerous requirement.

The fallback to the other allocation mode when all disks of one type
are full is not always a feature.  When an array gets full, sometimes
data gets on SSDs, or metadata gets on spinners, and we quickly lose
the benefit of separating them.  Balances in either direction to fix
this after it happens are time-consuming and waste SSD lifetime TBW.

I'd like an easy way to make the preference strict, i.e. if there are
two types of disks in the filesystem, and one type fills up, and we're
not in a weird state like degraded mode or deleting the last drive of
one type, then go directly to ENOSPC.  That requires a more complex
patch since we'd have to change the way free space is calculated for
'df' to exclude the metadata devices, and track whether there are two
types of device present or just one.

> Below I collected some data to highlight the performance increment.
> 
> Test setup:
> I performed as test a "dist-upgrade" of a Debian from stretch to buster.
> The test consisted in an image of a Debian stretch[1]  with the packages
> needed under /var/cache/apt/archives/ (so no networking was involved).
> For each test I formatted the filesystem from scratch, un-tar-red the
> image and the ran "apt-get dist-upgrade" [2]. For each disk(s)/filesystem
> combination I measured the time of apt dist-upgrade with and
> without the flag "force-unsafe-io" which reduce the using of sync(2) and
> flush(2). The ssd was 20GB big, the hdd was 230GB big,
> 
> I considered the following scenarios:
> - btrfs over ssd
> - btrfs over ssd + hdd with my patch enabled
> - btrfs over bcache over hdd+ssd
> - btrfs over hdd (very, very slow....)
> - ext4 over ssd
> - ext4 over hdd
> 
> The test machine was an "AMD A6-6400K" with 4GB of ram, where 3GB was used
> as cache/buff.
> 
> Data analysis:
> 
> Of course btrfs is slower than ext4 when a lot of sync/flush are involved. Using
> apt on a rotational was a dramatic experience. And IMHO  this should be replaced
> by using the btrfs snapshot capabilities. But this is another (not easy) story.
> 
> Unsurprising bcache performs better than my patch. But this is an expected
> result because it can cache also the data chunk (the read can goes directly to
> the ssd). bcache perform about +60% slower when there are a lot of sync/flush
> and only +20% in the other case.
> 
> Regarding the test with force-unsafe-io (fewer sync/flush), my patch reduce the
> time from +256% to +113%  than the hdd-only . Which I consider a good
> results considering how small is the patch.
> 
> 
> Raw data:
> The data below is the "real" time (as return by the time command) consumed by
> apt
> 
> 
> Test description         real (mmm:ss)	Delta %
> --------------------     -------------  -------
> btrfs hdd w/sync	   142:38	+533%
> btrfs ssd+hdd w/sync        81:04	+260%
> ext4 hdd w/sync	            52:39	+134%
> btrfs bcache w/sync	    35:59	 +60%
> btrfs ssd w/sync	    22:31	reference
> ext4 ssd w/sync	            12:19	 -45%
> 
> 
> 
> Test description         real (mmm:ss)	Delta %
> --------------------     -------------  -------
> btrfs hdd	             56:2	+256%
> ext4 hdd	            51:32	+228%
> btrfs ssd+hdd	            33:30	+113%
> btrfs bcache	            18:57	 +20%
> btrfs ssd	            15:44	reference
> ext4 ssd	            11:49	 -25%
> 
> 
> [1] I created the image, using "debootrap stretch", then I installed a set
> of packages using the commands:
> 
>   # debootstrap stretch test/
>   # chroot test/
>   # mount -t proc proc proc
>   # mount -t sysfs sys sys
>   # apt --option=Dpkg::Options::=--force-confold \
>         --option=Dpkg::options::=--force-unsafe-io \
> 	install mate-desktop-environment* xserver-xorg vim \
>         task-kde-desktop task-gnome-desktop
> 
> Then updated the release from stretch to buster changing the file /etc/apt/source.list
> Then I download the packages for the dist upgrade:
> 
>   # apt-get update
>   # apt-get --download-only dist-upgrade
> 
> Then I create a tar of this image.
> Before the dist upgrading the space used was about 7GB of space with 2281
> packages. After the dist-upgrade, the space used was 9GB with 2870 packages.
> The upgrade installed/updated about 2251 packages.
> 
> 
> [2] The command was a bit more complex, to avoid an interactive session
> 
>   # mkfs.btrfs -m single -d single /dev/sdX
>   # mount /dev/sdX test/
>   # cd test
>   # time tar xzf ../image.tgz
>   # chroot .
>   # mount -t proc proc proc
>   # mount -t sysfs sys sys
>   # export DEBIAN_FRONTEND=noninteractive
>   # time apt-get -y --option=Dpkg::Options::=--force-confold \
> 	--option=Dpkg::options::=--force-unsafe-io dist-upgrade
> 
> 
> BR
> G.Baroncelli
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> 
> 
> 
> 
> 
