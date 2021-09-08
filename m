Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802AD403B7C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351916AbhIHO2l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 10:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351910AbhIHO2k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 10:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8CA061154
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631111252;
        bh=23alc4dJ1UQguufrYUJgbBGwSUkCee9JCTxCqUHlfDo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DlYUI4KKdAFTcy/3zBFKpkOEQLINORM4ZggGLDUCVrQzjvAlXGWL5cwyh/z8G9oiP
         DtxSBDe+xpsTAT6cv/Ycr9qT+8XT/nUc06XKoMc56R4iBC8p7ChorcVtomnvZXvFdN
         EoB5fwxUcGlnOc8lSg+gFav90AqKaQ17f5UKHYoOdR6b7YifIl8l4/4Dn7TpKeD/AY
         EGhf03HjZ3/bC4bCATZj53uYHN/vmG7F/fXtdZgxx0HJFXchipMslpyn9Ff5jwM8aj
         ajLyOi9vTb15hzAbkT0zGYIeQADwSeYQi7O/IOqfWlNKFRlN76PbflPE82o3zfoGBO
         rKaX2tx0hYrHw==
Received: by mail-qk1-f180.google.com with SMTP id y144so2694720qkb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Sep 2021 07:27:32 -0700 (PDT)
X-Gm-Message-State: AOAM531R4Ch8OdOAossjHHQ4nDx+3uT0UPQrcIOknLAVYDOLHpJ+UAEJ
        Dc2vQwfp1vGA46FHGo2qs28iJ8sPwvxEpl2FBgg=
X-Google-Smtp-Source: ABdhPJzZCUF1JxLeWPmFl8R6FjfU3MqnzM+/w6C4G+9vh88/bLyO4d8QYHtjwAHsCFY6TDeT79yV86i/7ByBOxNtV0M=
X-Received: by 2002:a05:620a:5a7:: with SMTP id q7mr3670308qkq.163.1631111251773;
 Wed, 08 Sep 2021 07:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631026981.git.fdmanana@suse.com> <dcf9de78faa6ec5cef443d031a987c87301805b1.1631026981.git.fdmanana@suse.com>
 <89c736d1-2e8c-b9ef-40a0-298b94fcebde@oracle.com>
In-Reply-To: <89c736d1-2e8c-b9ef-40a0-298b94fcebde@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 8 Sep 2021 15:26:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4B76EqcUY2Ynb1T4d16LqRvyS-41tf8Ze=gfg6ZqGdFg@mail.gmail.com>
Message-ID: <CAL3q7H4B76EqcUY2Ynb1T4d16LqRvyS-41tf8Ze=gfg6ZqGdFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix mount failure due to past and transient
 device flush error
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 8, 2021 at 3:20 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> On 07/09/2021 23:15, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When we get an error flushing one device, during a super block commit, we
> > record the error in the device structure, in the field 'last_flush_error'.
> > This is used to later check if we should error out the super block commit,
> > depending on whether the number of flush errors is greater than or equals
> > to the maximum tolerated device failures for a raid profile.
>
>
> > However if we get a transient device flush error, unmount the filesystem
> > and later try to mount it, we can fail the mount because we treat that
> > past error as critical and consider the device is missing.
>
> > Even if it's
> > very likely that the error will happen again, as it's probably due to a
> > hardware related problem, there may be cases where the error might not
> > happen again.
>
>   But is there an impact due to flush error, like storage cache lost few
> block? If so, then the current design is correct. No?

If there was a flush error, then we aborted the current transaction
and set the filesystem to error state.
We only write the super block if we are able to do the device flushes.

>
> Thanks, Anand
>
> > One example is during testing, and a test case like the
> > new generic/648 from fstests always triggers this. The test cases
> > generic/019 and generic/475 also trigger this scenario, but very
> > sporadically.
> >
> > When this happens we get an error like this:
> >
> >    $ mount /dev/sdc /mnt
> >    mount: /mnt wrong fs type, bad option, bad superblock on /dev/sdc, missing codepage or helper program, or other error.
> >
> >    $ dmesg
> >    (...)
> >    [12918.886926] BTRFS warning (device sdc): chunk 13631488 missing 1 devices, max tolerance is 0 for writable mount
> >    [12918.888293] BTRFS warning (device sdc): writable mount is not allowed due to too many missing devices
> >    [12918.890853] BTRFS error (device sdc): open_ctree failed
> >
> > So fix this by making sure btrfs_check_rw_degradable() does not consider
> > flush errors from past mounts when it's being called either on a mount
> > context or on a RO to RW remount context, and clears the flush errors
> > from the devices. Any path that triggers a super block commit during
> > mount/remount must still check for any flush errors and lead to a
> > mount/remount failure if any are found - all these paths (replaying log
> > trees, convert space cache v1 to v2, etc) all happen after the first
> > call to btrfs_check_rw_degradable(), which is the only call that should
> > ignore and reset past flush errors from the devices.
> >
>
> What if the flush error is real that the storage cache dropped few
> blocks and, did not make it to the permanent storage.

The previous comment answers this as well.

The comment in the comment also says the same.

Thanks.

>
> Thanks, Anand
>
>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/disk-io.c |  4 ++--
> >   fs/btrfs/super.c   |  2 +-
> >   fs/btrfs/volumes.c | 26 +++++++++++++++++++++-----
> >   fs/btrfs/volumes.h |  3 ++-
> >   4 files changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 7d80e5b22d32..6d7d6288f80a 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3564,7 +3564,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >               goto fail_sysfs;
> >       }
> >
> > -     if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {
> > +     if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL, true)) {
> >               btrfs_warn(fs_info,
> >               "writable mount is not allowed due to too many missing devices");
> >               goto fail_sysfs;
> > @@ -4013,7 +4013,7 @@ static blk_status_t wait_dev_flush(struct btrfs_device *device)
> >
> >   static int check_barrier_error(struct btrfs_fs_info *fs_info)
> >   {
> > -     if (!btrfs_check_rw_degradable(fs_info, NULL))
> > +     if (!btrfs_check_rw_degradable(fs_info, NULL, false))
> >               return -EIO;
> >       return 0;
> >   }
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index a927009f02a2..51519141b12f 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -2017,7 +2017,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> >                       goto restore;
> >               }
> >
> > -             if (!btrfs_check_rw_degradable(fs_info, NULL)) {
> > +             if (!btrfs_check_rw_degradable(fs_info, NULL, true)) {
> >                       btrfs_warn(fs_info,
> >               "too many missing devices, writable remount is not allowed");
> >                       ret = -EACCES;
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index b81f25eed298..2a5beba98273 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -7367,7 +7367,7 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
> >    * Return false if any chunk doesn't meet the minimal RW mount requirements.
> >    */
> >   bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
> > -                                     struct btrfs_device *failing_dev)
> > +                            struct btrfs_device *failing_dev, bool mounting_fs)
> >   {
> >       struct extent_map_tree *map_tree = &fs_info->mapping_tree;
> >       struct extent_map *em;
> > @@ -7395,12 +7395,28 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
> >               for (i = 0; i < map->num_stripes; i++) {
> >                       struct btrfs_device *dev = map->stripes[i].dev;
> >
> > -                     if (!dev || !dev->bdev ||
> > -                         test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> > -                         dev->last_flush_error)
> > +                     if (dev && dev->last_flush_error) {
> > +                             /*
> > +                              * If we had a flush error from a previous mount,
> > +                              * don't treat it as an error and clear the error
> > +                              * status. Such an error may be transient, and
> > +                              * just because it happened in a previous mount,
> > +                              * it does not mean it will happen again if we
> > +                              * mount the fs again. If it turns out the error
> > +                              * happens again after mounting, then we will
> > +                              * deal with it, abort the running transaction
> > +                              * and set the fs state to BTRFS_FS_STATE_ERROR.
> > +                              */
> > +                             if (mounting_fs)
> > +                                     dev->last_flush_error = 0;
> > +                             else
> > +                                     missing++;
> > +                     } else if (!dev || !dev->bdev ||
> > +                         test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state)) {
> >                               missing++;
> > -                     else if (failing_dev && failing_dev == dev)
> > +                     } else if (failing_dev && failing_dev == dev) {
> >                               missing++;
> > +                     }
> >               }
> >               if (missing > max_tolerated) {
> >                       if (!failing_dev)
> > diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> > index 7e8f205978d9..7299aa36f41f 100644
> > --- a/fs/btrfs/volumes.h
> > +++ b/fs/btrfs/volumes.h
> > @@ -575,7 +575,8 @@ void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
> >
> >   struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
> >   bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
> > -                                     struct btrfs_device *failing_dev);
> > +                            struct btrfs_device *failing_dev,
> > +                            bool mounting_fs);
> >   void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
> >                              struct block_device *bdev,
> >                              const char *device_path);
> >
>
