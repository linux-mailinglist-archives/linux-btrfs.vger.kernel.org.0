Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE11E2915F7
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Oct 2020 06:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgJRE5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Oct 2020 00:57:18 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47096 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgJRE5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Oct 2020 00:57:18 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A617785BCE1; Sun, 18 Oct 2020 00:57:14 -0400 (EDT)
Date:   Sun, 18 Oct 2020 00:57:14 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Badi Morris <badi95@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [support] RAID 5: tried to replace failing disk, failed, now
 unable to mount
Message-ID: <20201018045713.GS5890@hungrycats.org>
References: <CADsxMh-5_BvN+__Q1qvn340V9w6f+T4xJG-ujkh5gTrkdskzOA@mail.gmail.com>
 <20201017225204.GR5890@hungrycats.org>
 <CADsxMh98k1m96wJa8o1eN3zB75h=_9=Dafs8Bh5aJ3pDNko3gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADsxMh98k1m96wJa8o1eN3zB75h=_9=Dafs8Bh5aJ3pDNko3gQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 17, 2020 at 11:36:23PM -0400, Badi Morris wrote:
> So it looks like I'm finally getting somewhere.
> 
> After disconnecting the failing drive and running the code from here
> http://dave.jikos.cz/fix-dev-count.c . mount -o degraded /dev/sda
> /home actually worked!
> I was able to see the files in my array and am going to try to backup
> whatever I can to an external drive.
> I tried to run btrfs replace start 2 /dev/sdb /home, but that failed
> after 1%. I've attached the dmesg from the attempted replace.
> What should be my next steps?

Unfortunately there was a dropped write on metadata at some point:

	[ 1761.203387] BTRFS error (device sda): parent transid verify failed on 889193234432 wanted 108346 found 106169
	[ 1761.573320] BTRFS error (device sda): btrfs_scrub_dev(<missing disk>, 2, /dev/sdb) failed -5

This isn't recoverable, so the next steps are:

	- figure out how the dropped write happened (usually bad drive
	firmware, but can also be caused by unstable power supply or
	simultaneous failures on multiple disks).  If it was bad drive
	firmware, you can use this udev rule to turn off write caching
	on all drives (requires hdparm):

	ACTION=="add|change", SUBSYSTEM=="block", DRIVERS=="sd", KERNEL=="sd*[!0-9]", RUN+="/sbin/hdparm -W 0 $devnode"

	- copy off any data you don't already have backed up,

	- mkfs (with raid1 metadata!), and

	- restore backups to the new filesystem.

> Thanks so much for your help, I had given up hope for over a year, but
> decided to finally try the mailing list.
> 
> On Sat, Oct 17, 2020 at 6:52 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Sat, Oct 17, 2020 at 12:56:50AM -0400, Badi Morris wrote:
> > > My btrfs raid 5 array that contains my /home directory is in bad shape
> > > and I would appreciate any help getting it back up and running.
> > >
> > > My setup is with 4 1TB disks in a RAID 5 configuration. 1 failing, so
> > > I tried to replace it with a new one, and messed that up.
> > >
> > > Back in Feb 2019 I had a hard disk failing in my btrfs RAID 5 array so
> > > I tried to replace it and messed that process up real bad. Here are
> > > the steps I took:
> > > - physically disconnected the old hard drive and connected the new drive
> > > - system booted into maintenance mode
> > > - mounted degraded,
> > > - btrfs added the new drive,
> > > - tried to btrfs delete the missing drive
> >
> > Only 'btrfs replace' works with btrfs raid5.  Delete will eventually
> > fail with an error due to various known raid5 bugs.  See:
> >
> >         https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/
> >
> > for a current list and some recommendations for raid5 array setup.
> >
> > > - wouldn't let me since system was read only,
> >
> > You didn't post logs from this event, so we have to guess what happened
> > here.  Some possible hypothetical scenarios:
> >
> >         - the "parent transid verify failed" errors happened here.
> >         This would mean the filesystem was already unrecoverable,
> >         possibly due to an event that occurred before the disk failure
> >         (e.g.  disk firmware bugs + write caching enabled + media or
> >         power failure).
> >
> >         - the "spurious-degraded-read-failure" bug in btrfs raid5
> >         occurred while reading metadata for the device remove.
> >         This is why 'btrfs replace' is the only way to replace a
> >         raid5 drive on btrfs.  The good news is that this bug is
> >         mostly harmless, only a umount/mount is required to recover.
> >
> > If you do get this filesystem back up and out of degraded mode, be
> > sure to convert the metadata to raid1 as soon as possible.  One of the
> > ways raid5 metadata can fail will force the filesystem read-only while
> > trying to replace failed disks.  In the worst case, this makes the array
> > unrecoverable until the kernel bugs are fixed (this is the case when the
> > metadata for the chunk/device tree blocks are precisely the blocks that
> > can't be read in degraded mode due to current bugs).
> >
> > > - couldn't remount as rw,
> >
> > I presume "mounted again with -o degraded,rw" is missing here; otherwise,
> > the dev delete that follows wouldn't happen.
> >
> > > - btrfs deleted the new drive
> > > - plugged back in the old drive,
> > > - old drive didn't work
> > > - plugged back in new drive
> > > - can't even mount degraded now
> >
> > > When issue occurred I was running: Arch linux with 4.20.5 kernel, and
> > > btrfs-progs v4.19.1.
> > > I recently updated to my whole arch install so now I'm running
> > > 5.8.14-arch1-1, btrfs-progs v5.7
> > >
> > > btrfs fi show
> > > parent transid verify failed on 1344962560 wanted 108468 found 108458
> > > parent transid verify failed on 1344962560 wanted 108468 found 108458
> > > Ignoring transid failure
> > > parent transid verify failed on 1345224704 wanted 108458 found 108468
> > > parent transid verify failed on 1345224704 wanted 108458 found 108468
> > > Ignoring transid failure
> > > ERROR: child eb corrupted: parent bytenr=1344962560 item=0 parent
> > > level=2 child level=0
> > > WARNING: could not setup extent tree, skipping it
> > > parent transid verify failed on 1345224704 wanted 108458 found 108468
> > > Ignoring transid failure
> > > ERROR: child eb corrupted: parent bytenr=1344962560 item=0 parent
> > > level=2 child level=0
> > > Couldn't setup device tree
> > > Label: 'home'  uuid: 4ed784e3-2497-42d8-ae11-b541bacb927e
> > > Total devices 5 FS bytes used 976.84GiB
> > > devid    1 size 931.51GiB used 335.40GiB path /dev/sda
> > > devid    2 size 931.51GiB used 335.38GiB path /dev/sdb
> > > devid    3 size 931.51GiB used 335.38GiB path /dev/sdc
> > > devid    4 size 931.51GiB used 335.38GiB path /dev/sdd
> > > *** Some devices missing
> >
> > You should disconnect the old drive at this point, and leave it
> > disconnected.  Its portion of the btrfs metadata is out of date and
> > it doesn't contain an independent mirror copy (only parity blocks,
> > which are dependent on other drives and have not been kept up to date
> > with changes on those drives), so the old drive is somewhere between
> > "no longer useful" and "actively hostile" for recovery purposes.
> > The tools will get confused by its presence.  The kernel will try to
> > repair it in place or (due to a kernel bug) treat its out-of-date data
> > as authoritative, which can make data unrecoverable in the future if
> > you have to scrape data off of an unrecoverable filesystem.
> >
> > Hopefully those "parent transid verify failed" errors are an artifact
> > of confusion with the old drive, because if they are not, the filesystem
> > would be unrecoverable.
> >
> > > attached btrfs inspect-internal dump-super results for each disk
> > >
> > > btrfs inspect-internal dump-super -f /dev/sde
> > > ERROR: bad magic on superblock on /dev/sde at 65536
> > > superblock: bytenr=65536, device=/dev/sde
> > > ---------------------------------------------------------
> > >
> > > dmesg | grep BTRFS
> > > [    3.573822] Btrfs loaded, crc32c=crc32c-intel
> > > [    3.574373] BTRFS: device label home devid 4 transid 108468
> > > /dev/sdd scanned by btrfs (189)
> > > [    3.574574] BTRFS: device label home devid 3 transid 108468
> > > /dev/sdc scanned by btrfs (189)
> > > [    3.574774] BTRFS: device label home devid 2 transid 108460
> > > /dev/sdb scanned by btrfs (189)
> > > [    3.574906] BTRFS: device label home devid 1 transid 108468
> > > /dev/sda scanned by btrfs (189)
> > > [  409.173299] BTRFS warning (device sda): 'recovery' is deprecated,
> > > use 'usebackuproot' instead
> >
> > The proper way to use 'usebackuproot' is to mount read-only with -o
> > 'ro,usebackuproot', check that everything seems OK (e.g. run a scrub),
> > then remount or mount again read-write.  Do this only for one mount,
> > then remove it from the mount options.  The last transaction commit will
> > be erased every time you mount with this option.
> >
> > In the worst case, usebackuproot could use a partially overwritten
> > older tree instead of an up-to-date intact tree, then start writing
> > further new tree pages over the intact tree until it too is destroyed.
> > When this happens, the filesystem is no longer recoverable.
> >
> > > [  409.173301] BTRFS info (device sda): trying to use backup root at mount time
> > > [  409.173303] BTRFS info (device sda): disk space caching is enabled
> > > [  409.177376] BTRFS error (device sda): super_num_devices 5 mismatch
> > > with num_devices 4 found here
> > > [  409.177378] BTRFS error (device sda): failed to read chunk tree: -22
> > > [  409.206367] BTRFS error (device sda): open_ctree failed
> >
> > Hopefully the above is an artifact of usebackuproot, but it might not be.
> >
> > There are a couple of fixes for super_num_devices mismatch.  One is a
> > standalone utility:
> >
> >         http://dave.jikos.cz/fix-dev-count.c
> >
> > Another way to fix it is with a kernel patch to treat the chunk tree
> > as authoritative:
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 1997a7d67f22..4213f6e6b84c 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -7164,8 +7164,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
> >            "super_num_devices %llu mismatch with num_devices %llu found here",
> >                           btrfs_super_num_devices(fs_info->super_copy),
> >                           total_dev);
> > -               ret = -EINVAL;
> > -               goto error;
> > +               btrfs_set_super_num_devices(fs_info->super_copy, total_dev);
> >         }
> >         if (btrfs_super_total_bytes(fs_info->super_copy) <
> >             fs_info->fs_devices->total_rw_bytes) {
> >
> > It looks like the 'btrfs dev remove' failed part way through for sde,
> > so you might hit another error (too many failed devices) when trying to
> > mount in degraded mode.  We'll have to see what that error is and assess
> > the situation then.
> >
> > > dmesg.log attached
> >
> > > superblock: bytenr=65536, device=/dev/sdc
> > > ---------------------------------------------------------
> > > csum_type             0 (crc32c)
> > > csum_size             4
> > > csum                  0x8bd30951 [match]
> > > bytenr                        65536
> > > flags                 0x1
> > >                       ( WRITTEN )
> > > magic                 _BHRfS_M [match]
> > > fsid                  4ed784e3-2497-42d8-ae11-b541bacb927e
> > > metadata_uuid         4ed784e3-2497-42d8-ae11-b541bacb927e
> > > label                 home
> > > generation            108468
> > > root                  1344962560
> > > sys_array_size                483
> > > chunk_root_generation 108468
> > > root_level            1
> > > chunk_root            21004288
> > > chunk_root_level      1
> > > log_root              0
> > > log_root_transid      0
> > > log_root_level                0
> > > total_bytes           4000819544064
> > > bytes_used            1048873672704
> > > sectorsize            4096
> > > nodesize              16384
> > > leafsize (deprecated) 16384
> > > stripesize            4096
> > > root_dir              6
> > > num_devices           5
> > > compat_flags          0x0
> > > compat_ro_flags               0x0
> > > incompat_flags                0xe1
> > >                       ( MIXED_BACKREF |
> > >                         BIG_METADATA |
> > >                         EXTENDED_IREF |
> > >                         RAID56 )
> > > cache_generation      108468
> > > uuid_tree_generation  108468
> > > dev_item.uuid         770084ed-7274-4799-8a8e-4999f2b9efe5
> > > dev_item.fsid         4ed784e3-2497-42d8-ae11-b541bacb927e [match]
> > > dev_item.type         0
> > > dev_item.total_bytes  1000204886016
> > > dev_item.bytes_used   360110358528
> > > dev_item.io_align     4096
> > > dev_item.io_width     4096
> > > dev_item.sector_size  4096
> > > dev_item.devid                3
> > > dev_item.dev_group    0
> > > dev_item.seek_speed   0
> > > dev_item.bandwidth    0
> > > dev_item.generation   0
> > > sys_chunk_array[2048]:
> > >       item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 0)
> > >               length 4194304 owner 2 stripe_len 65536 type SYSTEM
> > >               io_align 4096 io_width 4096 sector_size 4096
> > >               num_stripes 1 sub_stripes 0
> > >                       stripe 0 devid 1 offset 0
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > >       item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 20971520)
> > >               length 12582912 owner 2 stripe_len 65536 type SYSTEM|RAID5
> > >               io_align 65536 io_width 65536 sector_size 4096
> > >               num_stripes 4 sub_stripes 0
> > >                       stripe 0 devid 4 offset 1048576
> > >                       dev_uuid f14f298c-a18e-45f1-bb24-7b68dfc340d1
> > >                       stripe 1 devid 3 offset 1048576
> > >                       dev_uuid 770084ed-7274-4799-8a8e-4999f2b9efe5
> > >                       stripe 2 devid 2 offset 1048576
> > >                       dev_uuid 8c902bf9-3193-42bb-a31f-57ed55285239
> > >                       stripe 3 devid 1 offset 20971520
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > >       item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 1090116386816)
> > >               length 100663296 owner 2 stripe_len 65536 type SYSTEM|RAID5
> > >               io_align 65536 io_width 65536 sector_size 4096
> > >               num_stripes 4 sub_stripes 1
> > >                       stripe 0 devid 2 offset 295284244480
> > >                       dev_uuid 8c902bf9-3193-42bb-a31f-57ed55285239
> > >                       stripe 1 devid 3 offset 295284244480
> > >                       dev_uuid 770084ed-7274-4799-8a8e-4999f2b9efe5
> > >                       stripe 2 devid 4 offset 295284244480
> > >                       dev_uuid f14f298c-a18e-45f1-bb24-7b68dfc340d1
> > >                       stripe 3 devid 1 offset 295304167424
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > > backup_roots[4]:
> > >       backup 0:
> > >               backup_tree_root:       1344438272      gen: 108465     level: 1
> > >               backup_chunk_root:      20971520        gen: 108465     level: 1
> > >               backup_extent_root:     1344192512      gen: 108465     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1344339968      gen: 108464     level: 1
> > >               backup_csum_root:       1344847872      gen: 108465     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >       backup 1:
> > >               backup_tree_root:       1345519616      gen: 108466     level: 1
> > >               backup_chunk_root:      21004288        gen: 108466     level: 1
> > >               backup_extent_root:     1344962560      gen: 108466     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1344339968      gen: 108464     level: 1
> > >               backup_csum_root:       1345699840      gen: 108466     level: 2
> > >               backup_total_bytes:     5001024430080
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >       backup 2:
> > >               backup_tree_root:       1344405504      gen: 108467     level: 1
> > >               backup_chunk_root:      20971520        gen: 108467     level: 1
> > >               backup_extent_root:     1344192512      gen: 108467     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1345077248      gen: 108467     level: 1
> > >               backup_csum_root:       1344716800      gen: 108467     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >       backup 3:
> > >               backup_tree_root:       1344962560      gen: 108468     level: 1
> > >               backup_chunk_root:      21004288        gen: 108468     level: 1
> > >               backup_extent_root:     1344290816      gen: 108468     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1345077248      gen: 108467     level: 1
> > >               backup_csum_root:       1345519616      gen: 108468     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >
> >
> >
> > > superblock: bytenr=65536, device=/dev/sdd
> > > ---------------------------------------------------------
> > > csum_type             0 (crc32c)
> > > csum_size             4
> > > csum                  0xab23c128 [match]
> > > bytenr                        65536
> > > flags                 0x1
> > >                       ( WRITTEN )
> > > magic                 _BHRfS_M [match]
> > > fsid                  4ed784e3-2497-42d8-ae11-b541bacb927e
> > > metadata_uuid         4ed784e3-2497-42d8-ae11-b541bacb927e
> > > label                 home
> > > generation            108468
> > > root                  1344962560
> > > sys_array_size                483
> > > chunk_root_generation 108468
> > > root_level            1
> > > chunk_root            21004288
> > > chunk_root_level      1
> > > log_root              0
> > > log_root_transid      0
> > > log_root_level                0
> > > total_bytes           4000819544064
> > > bytes_used            1048873672704
> > > sectorsize            4096
> > > nodesize              16384
> > > leafsize (deprecated) 16384
> > > stripesize            4096
> > > root_dir              6
> > > num_devices           5
> > > compat_flags          0x0
> > > compat_ro_flags               0x0
> > > incompat_flags                0xe1
> > >                       ( MIXED_BACKREF |
> > >                         BIG_METADATA |
> > >                         EXTENDED_IREF |
> > >                         RAID56 )
> > > cache_generation      108468
> > > uuid_tree_generation  108468
> > > dev_item.uuid         f14f298c-a18e-45f1-bb24-7b68dfc340d1
> > > dev_item.fsid         4ed784e3-2497-42d8-ae11-b541bacb927e [match]
> > > dev_item.type         0
> > > dev_item.total_bytes  1000204886016
> > > dev_item.bytes_used   360110358528
> > > dev_item.io_align     4096
> > > dev_item.io_width     4096
> > > dev_item.sector_size  4096
> > > dev_item.devid                4
> > > dev_item.dev_group    0
> > > dev_item.seek_speed   0
> > > dev_item.bandwidth    0
> > > dev_item.generation   0
> > > sys_chunk_array[2048]:
> > >       item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 0)
> > >               length 4194304 owner 2 stripe_len 65536 type SYSTEM
> > >               io_align 4096 io_width 4096 sector_size 4096
> > >               num_stripes 1 sub_stripes 0
> > >                       stripe 0 devid 1 offset 0
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > >       item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 20971520)
> > >               length 12582912 owner 2 stripe_len 65536 type SYSTEM|RAID5
> > >               io_align 65536 io_width 65536 sector_size 4096
> > >               num_stripes 4 sub_stripes 0
> > >                       stripe 0 devid 4 offset 1048576
> > >                       dev_uuid f14f298c-a18e-45f1-bb24-7b68dfc340d1
> > >                       stripe 1 devid 3 offset 1048576
> > >                       dev_uuid 770084ed-7274-4799-8a8e-4999f2b9efe5
> > >                       stripe 2 devid 2 offset 1048576
> > >                       dev_uuid 8c902bf9-3193-42bb-a31f-57ed55285239
> > >                       stripe 3 devid 1 offset 20971520
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > >       item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 1090116386816)
> > >               length 100663296 owner 2 stripe_len 65536 type SYSTEM|RAID5
> > >               io_align 65536 io_width 65536 sector_size 4096
> > >               num_stripes 4 sub_stripes 1
> > >                       stripe 0 devid 2 offset 295284244480
> > >                       dev_uuid 8c902bf9-3193-42bb-a31f-57ed55285239
> > >                       stripe 1 devid 3 offset 295284244480
> > >                       dev_uuid 770084ed-7274-4799-8a8e-4999f2b9efe5
> > >                       stripe 2 devid 4 offset 295284244480
> > >                       dev_uuid f14f298c-a18e-45f1-bb24-7b68dfc340d1
> > >                       stripe 3 devid 1 offset 295304167424
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > > backup_roots[4]:
> > >       backup 0:
> > >               backup_tree_root:       1344438272      gen: 108465     level: 1
> > >               backup_chunk_root:      20971520        gen: 108465     level: 1
> > >               backup_extent_root:     1344192512      gen: 108465     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1344339968      gen: 108464     level: 1
> > >               backup_csum_root:       1344847872      gen: 108465     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >       backup 1:
> > >               backup_tree_root:       1345519616      gen: 108466     level: 1
> > >               backup_chunk_root:      21004288        gen: 108466     level: 1
> > >               backup_extent_root:     1344962560      gen: 108466     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1344339968      gen: 108464     level: 1
> > >               backup_csum_root:       1345699840      gen: 108466     level: 2
> > >               backup_total_bytes:     5001024430080
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >       backup 2:
> > >               backup_tree_root:       1344405504      gen: 108467     level: 1
> > >               backup_chunk_root:      20971520        gen: 108467     level: 1
> > >               backup_extent_root:     1344192512      gen: 108467     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1345077248      gen: 108467     level: 1
> > >               backup_csum_root:       1344716800      gen: 108467     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >       backup 3:
> > >               backup_tree_root:       1344962560      gen: 108468     level: 1
> > >               backup_chunk_root:      21004288        gen: 108468     level: 1
> > >               backup_extent_root:     1344290816      gen: 108468     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1345077248      gen: 108467     level: 1
> > >               backup_csum_root:       1345519616      gen: 108468     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >
> >
> > > superblock: bytenr=65536, device=/dev/sdb
> > > ---------------------------------------------------------
> > > csum_type             0 (crc32c)
> > > csum_size             4
> > > csum                  0x5ffcc3b4 [match]
> > > bytenr                        65536
> > > flags                 0x1
> > >                       ( WRITTEN )
> > > magic                 _BHRfS_M [match]
> > > fsid                  4ed784e3-2497-42d8-ae11-b541bacb927e
> > > metadata_uuid         4ed784e3-2497-42d8-ae11-b541bacb927e
> > > label                 home
> > > generation            108460
> > > root                  1345224704
> > > sys_array_size                483
> > > chunk_root_generation 108346
> > > root_level            1
> > > chunk_root            1090116386816
> > > chunk_root_level      1
> > > log_root              0
> > > log_root_transid      0
> > > log_root_level                0
> > > total_bytes           4000819544064
> > > bytes_used            1048873672704
> > > sectorsize            4096
> > > nodesize              16384
> > > leafsize (deprecated) 16384
> > > stripesize            4096
> > > root_dir              6
> > > num_devices           4
> > > compat_flags          0x0
> > > compat_ro_flags               0x0
> > > incompat_flags                0xe1
> > >                       ( MIXED_BACKREF |
> > >                         BIG_METADATA |
> > >                         EXTENDED_IREF |
> > >                         RAID56 )
> > > cache_generation      108460
> > > uuid_tree_generation  108460
> > > dev_item.uuid         8c902bf9-3193-42bb-a31f-57ed55285239
> > > dev_item.fsid         4ed784e3-2497-42d8-ae11-b541bacb927e [match]
> > > dev_item.type         0
> > > dev_item.total_bytes  1000204886016
> > > dev_item.bytes_used   360110358528
> > > dev_item.io_align     4096
> > > dev_item.io_width     4096
> > > dev_item.sector_size  4096
> > > dev_item.devid                2
> > > dev_item.dev_group    0
> > > dev_item.seek_speed   0
> > > dev_item.bandwidth    0
> > > dev_item.generation   0
> > > sys_chunk_array[2048]:
> > >       item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 0)
> > >               length 4194304 owner 2 stripe_len 65536 type SYSTEM
> > >               io_align 4096 io_width 4096 sector_size 4096
> > >               num_stripes 1 sub_stripes 0
> > >                       stripe 0 devid 1 offset 0
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > >       item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 20971520)
> > >               length 12582912 owner 2 stripe_len 65536 type SYSTEM|RAID5
> > >               io_align 65536 io_width 65536 sector_size 4096
> > >               num_stripes 4 sub_stripes 0
> > >                       stripe 0 devid 4 offset 1048576
> > >                       dev_uuid f14f298c-a18e-45f1-bb24-7b68dfc340d1
> > >                       stripe 1 devid 3 offset 1048576
> > >                       dev_uuid 770084ed-7274-4799-8a8e-4999f2b9efe5
> > >                       stripe 2 devid 2 offset 1048576
> > >                       dev_uuid 8c902bf9-3193-42bb-a31f-57ed55285239
> > >                       stripe 3 devid 1 offset 20971520
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > >       item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 1090116386816)
> > >               length 100663296 owner 2 stripe_len 65536 type SYSTEM|RAID5
> > >               io_align 65536 io_width 65536 sector_size 4096
> > >               num_stripes 4 sub_stripes 1
> > >                       stripe 0 devid 2 offset 295284244480
> > >                       dev_uuid 8c902bf9-3193-42bb-a31f-57ed55285239
> > >                       stripe 1 devid 3 offset 295284244480
> > >                       dev_uuid 770084ed-7274-4799-8a8e-4999f2b9efe5
> > >                       stripe 2 devid 4 offset 295284244480
> > >                       dev_uuid f14f298c-a18e-45f1-bb24-7b68dfc340d1
> > >                       stripe 3 devid 1 offset 295304167424
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > > backup_roots[4]:
> > >       backup 0:
> > >               backup_tree_root:       1344454656      gen: 108457     level: 1
> > >               backup_chunk_root:      1090116386816   gen: 108346     level: 1
> > >               backup_extent_root:     1344405504      gen: 108457     level: 2
> > >               backup_fs_root:         1344012288      gen: 108457     level: 2
> > >               backup_dev_root:        1338392576      gen: 108446     level: 1
> > >               backup_csum_root:       1344847872      gen: 108457     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     4
> > >
> > >       backup 1:
> > >               backup_tree_root:       1345716224      gen: 108458     level: 1
> > >               backup_chunk_root:      1090116386816   gen: 108346     level: 1
> > >               backup_extent_root:     1345519616      gen: 108458     level: 2
> > >               backup_fs_root:         1344962560      gen: 108458     level: 2
> > >               backup_dev_root:        1338392576      gen: 108446     level: 1
> > >               backup_csum_root:       1345093632      gen: 108458     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     4
> > >
> > >       backup 2:
> > >               backup_tree_root:       1346076672      gen: 108459     level: 1
> > >               backup_chunk_root:      1090116386816   gen: 108346     level: 1
> > >               backup_extent_root:     1345945600      gen: 108459     level: 2
> > >               backup_fs_root:         1344946176      gen: 108459     level: 2
> > >               backup_dev_root:        1338392576      gen: 108446     level: 1
> > >               backup_csum_root:       1346027520      gen: 108459     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     4
> > >
> > >       backup 3:
> > >               backup_tree_root:       1345224704      gen: 108460     level: 1
> > >               backup_chunk_root:      1090116386816   gen: 108346     level: 1
> > >               backup_extent_root:     1345241088      gen: 108460     level: 2
> > >               backup_fs_root:         1344946176      gen: 108459     level: 2
> > >               backup_dev_root:        1338392576      gen: 108446     level: 1
> > >               backup_csum_root:       1345716224      gen: 108460     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     4
> > >
> > >
> >
> > > ERROR: bad magic on superblock on /dev/sde at 65536
> > > superblock: bytenr=65536, device=/dev/sde
> > > ---------------------------------------------------------
> > >
> >
> > > superblock: bytenr=65536, device=/dev/sda
> > > ---------------------------------------------------------
> > > csum_type             0 (crc32c)
> > > csum_size             4
> > > csum                  0xee197cbf [match]
> > > bytenr                        65536
> > > flags                 0x1
> > >                       ( WRITTEN )
> > > magic                 _BHRfS_M [match]
> > > fsid                  4ed784e3-2497-42d8-ae11-b541bacb927e
> > > metadata_uuid         4ed784e3-2497-42d8-ae11-b541bacb927e
> > > label                 home
> > > generation            108468
> > > root                  1344962560
> > > sys_array_size                483
> > > chunk_root_generation 108468
> > > root_level            1
> > > chunk_root            21004288
> > > chunk_root_level      1
> > > log_root              0
> > > log_root_transid      0
> > > log_root_level                0
> > > total_bytes           4000819544064
> > > bytes_used            1048873672704
> > > sectorsize            4096
> > > nodesize              16384
> > > leafsize (deprecated) 16384
> > > stripesize            4096
> > > root_dir              6
> > > num_devices           5
> > > compat_flags          0x0
> > > compat_ro_flags               0x0
> > > incompat_flags                0xe1
> > >                       ( MIXED_BACKREF |
> > >                         BIG_METADATA |
> > >                         EXTENDED_IREF |
> > >                         RAID56 )
> > > cache_generation      108468
> > > uuid_tree_generation  108468
> > > dev_item.uuid         546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > > dev_item.fsid         4ed784e3-2497-42d8-ae11-b541bacb927e [match]
> > > dev_item.type         0
> > > dev_item.total_bytes  1000204886016
> > > dev_item.bytes_used   360131330048
> > > dev_item.io_align     4096
> > > dev_item.io_width     4096
> > > dev_item.sector_size  4096
> > > dev_item.devid                1
> > > dev_item.dev_group    0
> > > dev_item.seek_speed   0
> > > dev_item.bandwidth    0
> > > dev_item.generation   0
> > > sys_chunk_array[2048]:
> > >       item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 0)
> > >               length 4194304 owner 2 stripe_len 65536 type SYSTEM
> > >               io_align 4096 io_width 4096 sector_size 4096
> > >               num_stripes 1 sub_stripes 0
> > >                       stripe 0 devid 1 offset 0
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > >       item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 20971520)
> > >               length 12582912 owner 2 stripe_len 65536 type SYSTEM|RAID5
> > >               io_align 65536 io_width 65536 sector_size 4096
> > >               num_stripes 4 sub_stripes 0
> > >                       stripe 0 devid 4 offset 1048576
> > >                       dev_uuid f14f298c-a18e-45f1-bb24-7b68dfc340d1
> > >                       stripe 1 devid 3 offset 1048576
> > >                       dev_uuid 770084ed-7274-4799-8a8e-4999f2b9efe5
> > >                       stripe 2 devid 2 offset 1048576
> > >                       dev_uuid 8c902bf9-3193-42bb-a31f-57ed55285239
> > >                       stripe 3 devid 1 offset 20971520
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > >       item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 1090116386816)
> > >               length 100663296 owner 2 stripe_len 65536 type SYSTEM|RAID5
> > >               io_align 65536 io_width 65536 sector_size 4096
> > >               num_stripes 4 sub_stripes 1
> > >                       stripe 0 devid 2 offset 295284244480
> > >                       dev_uuid 8c902bf9-3193-42bb-a31f-57ed55285239
> > >                       stripe 1 devid 3 offset 295284244480
> > >                       dev_uuid 770084ed-7274-4799-8a8e-4999f2b9efe5
> > >                       stripe 2 devid 4 offset 295284244480
> > >                       dev_uuid f14f298c-a18e-45f1-bb24-7b68dfc340d1
> > >                       stripe 3 devid 1 offset 295304167424
> > >                       dev_uuid 546ad1f2-bde9-46dc-ae5a-7b6b0c394032
> > > backup_roots[4]:
> > >       backup 0:
> > >               backup_tree_root:       1344438272      gen: 108465     level: 1
> > >               backup_chunk_root:      20971520        gen: 108465     level: 1
> > >               backup_extent_root:     1344192512      gen: 108465     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1344339968      gen: 108464     level: 1
> > >               backup_csum_root:       1344847872      gen: 108465     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >       backup 1:
> > >               backup_tree_root:       1345519616      gen: 108466     level: 1
> > >               backup_chunk_root:      21004288        gen: 108466     level: 1
> > >               backup_extent_root:     1344962560      gen: 108466     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1344339968      gen: 108464     level: 1
> > >               backup_csum_root:       1345699840      gen: 108466     level: 2
> > >               backup_total_bytes:     5001024430080
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >       backup 2:
> > >               backup_tree_root:       1344405504      gen: 108467     level: 1
> > >               backup_chunk_root:      20971520        gen: 108467     level: 1
> > >               backup_extent_root:     1344192512      gen: 108467     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1345077248      gen: 108467     level: 1
> > >               backup_csum_root:       1344716800      gen: 108467     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >       backup 3:
> > >               backup_tree_root:       1344962560      gen: 108468     level: 1
> > >               backup_chunk_root:      21004288        gen: 108468     level: 1
> > >               backup_extent_root:     1344290816      gen: 108468     level: 2
> > >               backup_fs_root:         1343799296      gen: 108462     level: 2
> > >               backup_dev_root:        1345077248      gen: 108467     level: 1
> > >               backup_csum_root:       1345519616      gen: 108468     level: 2
> > >               backup_total_bytes:     4000819544064
> > >               backup_bytes_used:      1048873672704
> > >               backup_num_devices:     5
> > >
> > >
> >


