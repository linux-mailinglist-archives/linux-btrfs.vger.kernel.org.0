Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8984B7EA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 04:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbiBPDhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 22:37:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344356AbiBPDhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 22:37:39 -0500
X-Greylist: delayed 549 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 19:37:27 PST
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49BA4F9FBB
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 19:37:27 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id AA26D1F0208; Tue, 15 Feb 2022 22:28:16 -0500 (EST)
Date:   Tue, 15 Feb 2022 22:28:16 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     kreijack@inwind.it, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Message-ID: <YgxvUC86zumH3OF1@hungrycats.org>
References: <cover.1643228177.git.kreijack@inwind.it>
 <7e5e75ed-86b4-a629-09c9-29202f93b4b6@inwind.it>
 <c43c5945-3c3a-0dee-a998-9e76c3eb0289@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c43c5945-3c3a-0dee-a998-9e76c3eb0289@gmx.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 16, 2022 at 08:22:55AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/16 02:49, Goffredo Baroncelli wrote:
> > Hi Josef,
> > 
> > gentle ping...
> > 
> > few months ago you showed some interest in this patches set. Few of the
> > cc-ed person use this patch set.
> > 
> > I know that David showed some interest in the Anand approach (i.e. no
> > knobs, but an automatic behavior looking at the speed of the devices).
> > 
> > At the time when I tried this approach in the first attempts, I got the
> > complain that the kernel may not know the performance differences of the
> > disk (HDD vs SSD vs NVME vs ZONED disk...).
> 
> Sorry I didn't check the patches in details.
> 
> But I'm a little concerned about how to accurately determine the
> performance of a device.
> 
> If doing it automatically, there must be some (commonly very short) time
> spent to do the test.
> 
> In the very short time, I doubt we can even accurately got a full
> picture of a device (from sequential read/write speed to IOPS values)
> 
> For spinning disks, the sequential read/write speed even change based on
> their LBA address (as their physical location inside the plate can
> change their linear velocity, since the angular velocity is fixed).
> 
> And even for SSD, IOPS can var dramatically due to cache/controller
> difference.
> 
> 
> For a proper performance aware setup, I guess the only correct way to
> fetch performance characteristics is from the (advanced) user.
> 
> Or we may need to spent at least tens of minutes to do proper tests to
> get the result.
> 
> For regular end users, the difference between SSD and HDD is huge enough
> and simply preferring SSD for metadata is good enough.
> 
> But for more complex setup, like btrfs over LUKS over LVM (even crosses
> several physical devices), I doubt if it's even possible to fetch the
> correct performance characteristics automatically.

I agree with all of the above.

An automatic performance detection/configuration daemon can easily
set the metadata/data preference bits during mkfs, or monitor the
system's iostats and change preferences over time if this is really
useful and desired.  It doesn't have to run in the kernel.

> Thanks,
> Qu
> > 
> > Comments ?
> > 
> > BR
> > Goffredo
> > 
> > 
> > On 26/01/2022 21.32, Goffredo Baroncelli wrote:
> > > From: Goffredo Baroncelli <kreijack@inwind.it>
> > > 
> > > Hi all,
> > > 
> > > This patches set was born after some discussion between me, Zygo and
> > > Josef.
> > > Some details can be found in
> > > https://github.com/btrfs/btrfs-todo/issues/19.
> > > 
> > > Some further information about a real use case can be found in
> > > https://lore.kernel.org/linux-btrfs/20210116002533.GE31381@hungrycats.org/
> > > 
> > > 
> > > Recently Shafeeq told me that he is interested too, due to the
> > > performance gain.
> > > 
> > > In V8, revision I switched away from an ioctl API in favor of a sysfs
> > > API (
> > > see patch #2 and #3).
> > > 
> > > In V9, I renamed the sysfs interface from devinfo/type to
> > > devinfo/allocation_hint.
> > > Moreover I renamed dev_info->type to dev_info->flags.
> > > 
> > > In V10, I renamed the tag 'PREFERRED' from PREFERRED_X to X_PREFERRED;
> > > I added
> > > another devinfo property, called major_minor. For now it is unused;
> > > the plan is to use this in btrfs-progs to go from the block device to
> > > the filesystem.
> > > First client will be "btrfs prop get/set allocation_hint", but I see
> > > others possible
> > > clients.
> > > Finally I made some cleanup, and remove the mount option
> > > 'allocation_hint'
> > > 
> > > In V11 I added a new 'feature' file
> > > /sys/fs/btrfs/features/allocation_hint
> > > to help the detection of the allocation_hint feature.
> > > 
> > > The idea behind this patches set, is to dedicate some disks (the
> > > fastest one)
> > > to the metadata chunk. My initial idea was a "soft" hint. However Zygo
> > > asked an option for a "strong" hint (== mandatory). The result is that
> > > each disk can be "tagged" by one of the following flags:
> > > - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> > > - BTRFS_DEV_ALLOCATION_METADATA_PREFERRED
> > > - BTRFS_DEV_ALLOCATION_DATA_PREFERRED
> > > - BTRFS_DEV_ALLOCATION_DATA_ONLY
> > > 
> > > When the chunk allocator search a disks to allocate a chunk, scans the
> > > disks
> > > in an order decided by these tags. For metadata, the order is:
> > > *_METADATA_ONLY
> > > *_METADATA_PREFERRED
> > > *_DATA_PREFERRED
> > > 
> > > The *_DATA_ONLY are not eligible from metadata chunk allocation.
> > > 
> > > For the data chunk, the order is reversed, and the *_METADATA_ONLY are
> > > excluded.
> > > 
> > > The exact sort logic is to sort first for the "tag", and then for the
> > > space
> > > available. If there is no space available, the next "tag" disks set are
> > > selected.
> > > 
> > > To set these tags, a new property called "allocation_hint" was created.
> > > There is a dedicated btrfs-prog patches set [[PATCH V11] btrfs-progs:
> > > allocation_hint disk property].
> > > 
> > > $ sudo mount /dev/loop0 /mnt/test-btrfs/
> > > $ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i
> > > allocation_hint; done
> > > devid=1, path=/dev/loop0: allocation_hint=METADATA_PREFERRED
> > > devid=2, path=/dev/loop1: allocation_hint=METADATA_PREFERRED
> > > devid=3, path=/dev/loop2: allocation_hint=DATA_PREFERRED
> > > devid=4, path=/dev/loop3: allocation_hint=DATA_PREFERRED
> > > devid=5, path=/dev/loop4: allocation_hint=DATA_PREFERRED
> > > devid=6, path=/dev/loop5: allocation_hint=DATA_ONLY
> > > devid=7, path=/dev/loop6: allocation_hint=METADATA_ONLY
> > > devid=8, path=/dev/loop7: allocation_hint=METADATA_ONLY
> > > 
> > > $ sudo ./btrfs fi us /mnt/test-btrfs/
> > > Overall:
> > >      Device size:           2.75GiB
> > >      Device allocated:           1.34GiB
> > >      Device unallocated:           1.41GiB
> > >      Device missing:             0.00B
> > >      Used:             400.89MiB
> > >      Free (estimated):           1.04GiB    (min: 1.04GiB)
> > >      Data ratio:                  2.00
> > >      Metadata ratio:              1.00
> > >      Global reserve:           3.25MiB    (used: 0.00B)
> > >      Multiple profiles:                no
> > > 
> > > Data,RAID1: Size:542.00MiB, Used:200.25MiB (36.95%)
> > >     /dev/loop0     288.00MiB
> > >     /dev/loop1     288.00MiB
> > >     /dev/loop2     127.00MiB
> > >     /dev/loop3     127.00MiB
> > >     /dev/loop4     127.00MiB
> > >     /dev/loop5     127.00MiB
> > > 
> > > Metadata,single: Size:256.00MiB, Used:384.00KiB (0.15%)
> > >     /dev/loop1     256.00MiB
> > > 
> > > System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
> > >     /dev/loop0      32.00MiB
> > > 
> > > Unallocated:
> > >     /dev/loop0     704.00MiB
> > >     /dev/loop1     480.00MiB
> > >     /dev/loop2       1.00MiB
> > >     /dev/loop3       1.00MiB
> > >     /dev/loop4       1.00MiB
> > >     /dev/loop5       1.00MiB
> > >     /dev/loop6     128.00MiB
> > >     /dev/loop7     128.00MiB
> > > 
> > > # change the tag of some disks
> > > 
> > > $ sudo ./btrfs prop set /dev/loop0 allocation_hint DATA_ONLY
> > > $ sudo ./btrfs prop set /dev/loop1 allocation_hint DATA_ONLY
> > > $ sudo ./btrfs prop set /dev/loop5 allocation_hint METADATA_ONLY
> > > 
> > > $ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i
> > > allocation_hint; done
> > > devid=1, path=/dev/loop0: allocation_hint=DATA_ONLY
> > > devid=2, path=/dev/loop1: allocation_hint=DATA_ONLY
> > > devid=3, path=/dev/loop2: allocation_hint=DATA_PREFERRED
> > > devid=4, path=/dev/loop3: allocation_hint=DATA_PREFERRED
> > > devid=5, path=/dev/loop4: allocation_hint=DATA_PREFERRED
> > > devid=6, path=/dev/loop5: allocation_hint=METADATA_ONLY
> > > devid=7, path=/dev/loop6: allocation_hint=METADATA_ONLY
> > > devid=8, path=/dev/loop7: allocation_hint=METADATA_ONLY
> > > 
> > > $ sudo btrfs bal start --full-balance /mnt/test-btrfs/
> > > $ sudo ./btrfs fi us /mnt/test-btrfs/
> > > Overall:
> > >      Device size:           2.75GiB
> > >      Device allocated:         735.00MiB
> > >      Device unallocated:           2.03GiB
> > >      Device missing:             0.00B
> > >      Used:             400.72MiB
> > >      Free (estimated):           1.10GiB    (min: 1.10GiB)
> > >      Data ratio:                  2.00
> > >      Metadata ratio:              1.00
> > >      Global reserve:           3.25MiB    (used: 0.00B)
> > >      Multiple profiles:                no
> > > 
> > > Data,RAID1: Size:288.00MiB, Used:200.19MiB (69.51%)
> > >     /dev/loop0     288.00MiB
> > >     /dev/loop1     288.00MiB
> > > 
> > > Metadata,single: Size:127.00MiB, Used:336.00KiB (0.26%)
> > >     /dev/loop5     127.00MiB
> > > 
> > > System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
> > >     /dev/loop7      32.00MiB
> > > 
> > > Unallocated:
> > >     /dev/loop0     736.00MiB
> > >     /dev/loop1     736.00MiB
> > >     /dev/loop2     128.00MiB
> > >     /dev/loop3     128.00MiB
> > >     /dev/loop4     128.00MiB
> > >     /dev/loop5       1.00MiB
> > >     /dev/loop6     128.00MiB
> > >     /dev/loop7      96.00MiB
> > > 
> > > 
> > > #As you can see all the metadata were placed on the disk loop5/loop7
> > > even if
> > > #the most empty one are loop0 and loop1.
> > > 
> > > 
> > > 
> > > Furher works:
> > > - the tool which show the space available should consider the tagging (eg
> > >    the disks tagged by _METADATA_ONLY should be excluded from the data
> > >    availability)
> > > - allow btrfs-prog to change the allocation_hint even when the filesystem
> > >    is not mounted.
> > > 
> > > In following emails, there will be the btrfs-progs patches set and the
> > > xfstest
> > > suite patches set.
> > > 
> > > 
> > > Comments are welcome
> > > BR
> > > G.Baroncelli
> > > 
> > > Revision:
> > > V11:
> > > - added the property /sys/fs/btrfs/features/allocation_hint
> > > 
> > > V10:
> > > - renamed two disk tags/constants:
> > >          - *_METADATA_PREFERRED -> *_METADATA_PREFERRED
> > >          - *_DATA_PREFERRED -> *_DATA_EFERRED
> > > - add /sys/fs/btrfs/$UUID/devinfo/$DEVID/major_minor
> > > - revise some commit description
> > > - refactored the code of gather_device_info(): one portion of this code
> > >    is moved in a separate function called sort_and_reduce_device_info()
> > >    for clarity.
> > > - removed the 'allocation_hint' mount option
> > > 
> > > V9:
> > > - rename dev_item->type to dev_item->flags
> > > - rename /sys/fs/btrfs/$UUID/devinfo/type -> allocation_hint
> > > 
> > > V8:
> > > - drop the ioctl API, instead use a sysfs one
> > > 
> > > V7:
> > > - make more room in the struct btrfs_ioctl_dev_properties up to 1K
> > > - leave in btrfs_tree.h only the costants
> > > - removed the mount option (sic)
> > > - correct an 'use before check' in the while loop (signaled
> > >    by Zygo)
> > > - add a 2nd sort to be sure that the device_info array is in the
> > >    expected order
> > > 
> > > V6:
> > > - add further values to the hints: add the possibility to
> > >    exclude a disk for a chunk type
> > > 
> > > 
> > > 
> > > Goffredo Baroncelli (7):
> > >    btrfs: add flags to give an hint to the chunk allocator
> > >    btrfs: export the device allocation_hint property in sysfs
> > >    btrfs: change the device allocation_hint property via sysfs
> > >    btrfs: add allocation_hint mode
> > >    btrfs: rename dev_item->type to dev_item->flags
> > >    btrfs: add major and minor to sysfs
> > >    Add /sys/fs/btrfs/features/allocation_hint
> > > 
> > >   fs/btrfs/ctree.h                |   4 +-
> > >   fs/btrfs/disk-io.c              |   2 +-
> > >   fs/btrfs/sysfs.c                | 105 +++++++++++++++++++++++++++
> > >   fs/btrfs/volumes.c              | 121 ++++++++++++++++++++++++++++++--
> > >   fs/btrfs/volumes.h              |   7 +-
> > >   include/uapi/linux/btrfs_tree.h |  20 +++++-
> > >   6 files changed, 245 insertions(+), 14 deletions(-)
> > > 
> > 
> > 
> 
