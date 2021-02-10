Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9B8316740
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 13:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhBJM5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 07:57:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:55716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhBJM4P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 07:56:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3FDDAEB9;
        Wed, 10 Feb 2021 12:55:31 +0000 (UTC)
Date:   Wed, 10 Feb 2021 12:55:30 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 4/6] btrfs: Check if the filesystem is has mixed type
 of devices
Message-ID: <20210210125530.GD23499@wotan.suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-5-mrostecki@suse.de>
 <CAL3q7H7Y6Mh9L4niCHzUVOfo4_PDK9o6Ho_aZfxENOQsiWwk9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7Y6Mh9L4niCHzUVOfo4_PDK9o6Ho_aZfxENOQsiWwk9g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 10:09:10AM +0000, Filipe Manana wrote:
> On Tue, Feb 9, 2021 at 9:32 PM Michal Rostecki <mrostecki@suse.de> wrote:
> >
> > From: Michal Rostecki <mrostecki@suse.com>
> >
> > Add the btrfs_check_mixed() function which checks if the filesystem has
> > the mixed type of devices (non-rotational and rotational). This
> > information is going to be used in roundrobin raid1 read policy.
> >
> > Signed-off-by: Michal Rostecki <mrostecki@suse.com>
> > ---
> >  fs/btrfs/volumes.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
> >  fs/btrfs/volumes.h |  7 +++++++
> >  2 files changed, 49 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 1ac364a2f105..1ad30a595722 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -617,6 +617,35 @@ static int btrfs_free_stale_devices(const char *path,
> >         return ret;
> >  }
> >
> > +/*
> > + * Checks if after adding the new device the filesystem is going to have mixed
> > + * types of devices (non-rotational and rotational).
> > + *
> > + * @fs_devices:          list of devices
> > + * @new_device_rotating: if the new device is rotational
> > + *
> > + * Returns true if there are mixed types of devices, otherwise returns false.
> > + */
> > +static bool btrfs_check_mixed(struct btrfs_fs_devices *fs_devices,
> > +                             bool new_device_rotating)
> > +{
> > +       struct btrfs_device *device, *prev_device;
> > +
> > +       list_for_each_entry(device, &fs_devices->devices, dev_list) {
> > +               if (prev_device == NULL &&
> 
> Hum, prev_device is not initialized when we enter the first iteration
> of the loop.
> 
> > +                   device->rotating != new_device_rotating)
> > +                       return true;
> > +               if (prev_device != NULL &&
> > +                   (device->rotating != prev_device->rotating ||
> 
> Here it's more dangerous, dereferencing an uninitialized pointer can
> result in a crash.
> 
> With this fixed, it would be better to redo the benchmarks when using
> mixed device types.
> 
> Thanks.
> 

Thanks for pointing that out. Will fix and redo benchmarks for v2.

> > +                    device->rotating != new_device_rotating))
> > +                       return true;
> > +
> > +               prev_device = device;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  /*
> >   * This is only used on mount, and we are protected from competing things
> >   * messing with our fs_devices by the uuid_mutex, thus we do not need the
> > @@ -629,6 +658,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
> >         struct request_queue *q;
> >         struct block_device *bdev;
> >         struct btrfs_super_block *disk_super;
> > +       bool rotating;
> >         u64 devid;
> >         int ret;
> >
> > @@ -669,8 +699,12 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
> >         }
> >
> >         q = bdev_get_queue(bdev);
> > -       if (!blk_queue_nonrot(q))
> > +       rotating = !blk_queue_nonrot(q);
> > +       device->rotating = rotating;
> > +       if (rotating)
> >                 fs_devices->rotating = true;
> > +       if (!fs_devices->mixed)
> > +               fs_devices->mixed = btrfs_check_mixed(fs_devices, rotating);
> >
> >         device->bdev = bdev;
> >         clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
> > @@ -2418,6 +2452,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
> >         fs_devices->open_devices = 0;
> >         fs_devices->missing_devices = 0;
> >         fs_devices->rotating = false;
> > +       fs_devices->mixed = false;
> >         list_add(&seed_devices->seed_list, &fs_devices->seed_list);
> >
> >         generate_random_uuid(fs_devices->fsid);
> > @@ -2522,6 +2557,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> >         int seeding_dev = 0;
> >         int ret = 0;
> >         bool locked = false;
> > +       bool rotating;
> >
> >         if (sb_rdonly(sb) && !fs_devices->seeding)
> >                 return -EROFS;
> > @@ -2621,8 +2657,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
> >
> >         atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
> >
> > -       if (!blk_queue_nonrot(q))
> > +       rotating = !blk_queue_nonrot(q);
> > +       device->rotating = rotating;
> > +       if (rotating)
> >                 fs_devices->rotating = true;
> > +       if (!fs_devices->mixed)
> > +               fs_devices->mixed = btrfs_check_mixed(fs_devices, rotating);
> >
> >         orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
> >         btrfs_set_super_total_bytes(fs_info->super_copy,
> > diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> > index 6e544317a377..594f1207281c 100644
> > --- a/fs/btrfs/volumes.h
> > +++ b/fs/btrfs/volumes.h
> > @@ -147,6 +147,9 @@ struct btrfs_device {
> >         /* I/O stats for raid1 mirror selection */
> >         struct percpu_counter inflight;
> >         atomic_t last_offset;
> > +
> > +       /* If the device is rotational */
> > +       bool rotating;
> >  };
> >
> >  /*
> > @@ -274,6 +277,10 @@ struct btrfs_fs_devices {
> >          * nonrot flag set
> >          */
> >         bool rotating;
> > +       /* Set when we find or add both nonrot and rot disks in the
> > +        * filesystem
> > +        */
> > +       bool mixed;
> >
> >         struct btrfs_fs_info *fs_info;
> >         /* sysfs kobjects */
> > --
> > 2.30.0
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
