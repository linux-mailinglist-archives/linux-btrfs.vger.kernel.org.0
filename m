Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB772FC48B
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 00:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbhASXOW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 18:14:22 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40580 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbhASXNj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 18:13:39 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0F7E59488C6; Tue, 19 Jan 2021 18:12:44 -0500 (EST)
Date:   Tue, 19 Jan 2021 18:12:44 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Message-ID: <20210119231244.GM31381@hungrycats.org>
References: <20210117185435.36263-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117185435.36263-1-kreijack@libero.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 17, 2021 at 07:54:30PM +0100, Goffredo Baroncelli wrote:
> 
> Hi all,
> 
> This is an RFC; I wrote this patch because I find the idea interesting
> even though it adds more complication to the chunk allocator.
> 
> The basic idea is to store the metadata chunk in the fasters disks.
> The fasters disk are marked by the "preferred_metadata" flag.
> 
> BTRFS when allocate a new metadata/system chunk, selects the
> "preferred_metadata" disks, otherwise it selectes the non
> "preferred_metadata" disks. The intial patch allowed to use the other
> kind of disk in case a set is full.
> 
> This patches set is based on v5.11-rc2.
> 
> For now, the only user of this patch that I am aware is Zygo. 
> However he asked to further constraint the allocation: i.e. avoid to
> allocated metadata on a not "preferred_metadata"
> disk. So I extended the patch adding 4 modes to operate.
> 
> This is enabled passing the option "preferred_metadata=<mode>" at
> mount time. 
> 
> There are 4 modes:
> - preferred_metadata=disabled
>   The allocator is the standard one.
> 
> - preferred_metadata=soft
>   The metadata chunk are allocated on the disks marked with the
>   "preferred_metadata" flag.
>   The data chunk are allocated on the disks not marked with the
>   "preferred_metadata" flag.
>   If the space isn't enough, then it is possible to use the other kind
>   of disks.
> 
> - preferred_metadata=hard
>   The metadata chunk are allocated on the disks marked with the
>   "preferred_metadata" flag.
>   The data chunk are allocated on the disks not marked with the
>   "preferred_metadata" flag.
>   If the space isn't enough, then "no space left" error is raised. It
>   is not possible to use the other kind of disks.
>         
> - preferred_metadata=metadata
>   The metadata chunk are allocated on the disks marked with the
>   "preferred_metadata" flag.
>   For metadata, if the space isn't enough, then it is possible to use the
>   other kind of disks.
>   The data chunk are allocated on the disks not marked with the
>   "preferred_metadata" flag.
>   For data, if the space isn't enough, then "no space left" error is raised.
>   It is not possible to use the other kind of disks.

I like this form of the preferred_metadata mount option even less than
the last one.  Now we have 4 different mount option cases, and we still
can't specify some things that are possible with 4 device properties.
Ideally there's no mount option at all, and we handle everything with
properties.

e.g. if I had one fast but small NVME, one slow but large SATA SSD, and
one big spinning HDD, I can't set up the following with the mount option:

	- metadata only on NVME (type 3)
	- metadata preferred, data allowed on SSD (type 1)
	- data only on HDD (type 2)

The relationship between NVME and SSD is "metadata" but between NVME and
HDD it is "hard", which are conflicting mount options.  I can't specify
the relationship between SSD and HDD (metadata must not overflow, but
data is allowed to overflow) with any of the mount options, because you
have not provided a mount option where data may overflow onto preferred
(fast) disks while metadata must not use slow disks.

With the 4 device types we can trivially specify this arrangement.

The sorted device lists would be:

        Metadata sort order             Data sort order
        metadata only (3)               data only (2)
        metadata preferred (1)          data preferred (0)
	data preferred (0)		metadata preferred (1)
        other devices (2 or other)      other devices (3 or other)

We keep 3 device counts for the first 3 sort orders.  If the number of all
preferred devices (type != 0) is zero, we just return ndevs; otherwise,
we pick the first device count that is >= mindevs.  If all the device
counts are < mindevs then we return the 3rd count (metadata only +
metadata preferred + data preferred) and the caller will find ENOSPC.

More sophisticated future implementations can alter the sort order, or
operate in entirely separate parts of btrfs, without conflicting with
this scheme.  If there is no mount option, then future implementations
can't conflict with it.

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
> Some examples: (/dev/sd[abc] are marked as preferred_metadata,
> and /dev/sd[ef] are not)
> 
> Non striped profile: metadata->raid1, data->raid1
> The data is stored on /dev/sd[ef], metadata is stored on /dev/sd[abc].
> 
> If mode is one of "soft" or "disabled", when /dev/sd[ef] are full
> the data chunk is allocated also on /dev/sd[abc]. Otherwise -ENOSPACE
> is raised.
> 
> Striped profile: metadata->raid6, data->raid6
> raid6 requires 3 disks at minimum, so /dev/sd[ef] are not enough for a
> data profile raid6. If mode is one of "hard" or "metadata", an error 
> is returned. Otherwise to allow a data chunk allocation, the data profile
> raid6 will be stored on all the disks /dev/sd[abcdef].
> 
> Instead the metadata profile raid6 will be allocated on /dev/sd[abc],
> because these are enough to host this chunk.
> 
> When the disks /dev/sd[abc] are full, if the mode is "hard" an
> error is raised, otherwise the other disks may be used.
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
> - The fourth patch implements the mount options handling
> 
> - The 5th implements the different allocation strategies
> 
> Changelog:
> v5: - add several modes to preferred_metadata mount option
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
> 
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
