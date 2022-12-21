Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A165309A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 13:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiLUMMk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 07:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLUMMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 07:12:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5146543
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 04:12:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C54BB81AF5
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 12:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00163C433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671624755;
        bh=MFYkMwNA/jrx/caCyVQVN8hRn90jOawwsYr4ZFf0KgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ltogJ2J0iV/IimJROdyql7wBb4l9P99aDSm4TLDeBhZ9yJD4SdsKKG45HwgNwUg7S
         q3HpXVOqgxuebTGhHvIC+giMdJWdzJTCiW5YlGuDyixyGqaAccJA3cHFWqJOmaz9Tp
         03ryugjSVsKRA0h82baRkfjq8AfSXI5k+rFWDFMNWLdECTVIrfoOt/DV055NPmSgj1
         l4BI7OQbVPLORt1LNLVBEqluLC7UVwCnnrPyLtaIPSnMY7zkRCZsQCVjo3y9azTwZ9
         tQEjkBsChNiWEYcquUj9+8uBSppX6zBfG5z5stgDcHMbALdRyFIFmC3UAXwMqg7k8a
         rV29JJb6I8ePg==
Received: by mail-oi1-f180.google.com with SMTP id o66so11701363oia.6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 04:12:34 -0800 (PST)
X-Gm-Message-State: ANoB5pm72srF/YRGZT0D46hOaaVcycoEe6+/m01vfmBLxX+mfTsoyZUc
        bqfg7c8dVPiMY7k0Xhoz12PYE2Gu2VlHKtxGzAM=
X-Google-Smtp-Source: AA0mqf50mXm2nG+NNEzwI+tQplJzHqerL8I7QdxdEZzdY2Zcsces2hrLRsaoQcOWOJQxiu49aIRZyVq7Ax6FKGpZm4A=
X-Received: by 2002:aca:38c4:0:b0:35e:ac60:2452 with SMTP id
 f187-20020aca38c4000000b0035eac602452mr1023554oia.92.1671624754150; Wed, 21
 Dec 2022 04:12:34 -0800 (PST)
MIME-Version: 1.0
References: <82e9c6f8afe4a58e3df60cf601530e14d42264a6.1671613891.git.wqu@suse.com>
 <CAL3q7H6Kg90MA_m1M60kTFd7GUZCx8qfr8kRiPh+66VgQAGuSA@mail.gmail.com>
In-Reply-To: <CAL3q7H6Kg90MA_m1M60kTFd7GUZCx8qfr8kRiPh+66VgQAGuSA@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 21 Dec 2022 12:11:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7GihcV4_Fv-yi2QTLx7MydBVfr8xrxX++wMcseUnVfTQ@mail.gmail.com>
Message-ID: <CAL3q7H7GihcV4_Fv-yi2QTLx7MydBVfr8xrxX++wMcseUnVfTQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix compat_ro checks against remount
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Chung-Chiang Cheng <shepjeng@gmail.com>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 21, 2022 at 11:57 AM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Wed, Dec 21, 2022 at 9:26 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> > [BUG]
> > Even with commit 81d5d61454c3 ("btrfs: enhance unsupported compat RO
> > flags handling"), btrfs can still mount a fs with unsupported compat_ro
> > flags read-only, then remount it RW:
> >
> >   # btrfs ins dump-super /dev/loop0 | grep compat_ro_flags -A 3
> >   compat_ro_flags               0x403
> >                         ( FREE_SPACE_TREE |
> >                           FREE_SPACE_TREE_VALID |
> >                           unknown flag: 0x400 )
> >
> >   # mount /dev/loop0 /mnt/btrfs
> >   mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
> >          dmesg(1) may have more information after failed mount system call.
> >   ^^^ RW mount failed as expected ^^^
> >
> >   # dmesg -t | tail -n5
> >   loop0: detected capacity change from 0 to 1048576
> >   BTRFS: device fsid cb5b82f5-0fdd-4d81-9b4b-78533c324afa devid 1 transid 7 /dev/loop0 scanned by mount (1146)
> >   BTRFS info (device loop0): using crc32c (crc32c-intel) checksum algorithm
> >   BTRFS info (device loop0): using free space tree
> >   BTRFS error (device loop0): cannot mount read-write because of unknown compat_ro features (0x403)
> >   BTRFS error (device loop0): open_ctree failed
> >
> >   # mount /dev/loop0 -o ro /mnt/btrfs
> >   # mount -o remount,rw /mnt/btrfs
> >   ^^^ RW remount succeeded unexpectedly ^^^
> >
> > [CAUSE]
> > Currently we use btrfs_check_features() to check compat_ro flags against
> > our current moount flags.
> >
> > That function get reused between open_ctree() and btrfs_remount().
> >
> > But for btrfs_remount(), the super block we passed in still has the old
> > mount flags, thus btrfs_check_features() still believes we're mounting
> > read-only.
> >
> > [FIX]
> > Introduce a new argument, *new_flags, to indicate the new mount flags.
> > That argument can be NULL for the open_ctree() call site.
> >
> > With that new argument, call site at btrfs_remount() can properly pass
> > the new super flags, and we can reject the RW remount correctly.
> >
> > Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
> > Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags handling")
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > Reviewed-by: Anand Jain <anand.jain@oracle.com>
> > ---
> > Changelog:
> > v2:
> > - Add a comment on why @rw_mount is calculated this way
> >   This will cover RW->RW and RW->RO remount cases, but since the
> >   fs is already RW, we should not has any unsupported compat_ro flags
> >   anyway.
> > ---
> >  fs/btrfs/disk-io.c | 16 +++++++++++++---
> >  fs/btrfs/disk-io.h |  3 ++-
> >  fs/btrfs/super.c   |  2 +-
> >  3 files changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 0888d484df80..973c2e41e132 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3391,12 +3391,22 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
> >   * (space cache related) can modify on-disk format like free space tree and
> >   * screw up certain feature dependencies.
> >   */
> > -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
> > +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb,
> > +                        int *new_flags)
>
> Can we please pass new_flags by value instead?
> It does not make any sense to pass by pointer - we don't want to
> change its value...

Or just make it a:   bool rw_switch

>
> >  {
> >         struct btrfs_super_block *disk_super = fs_info->super_copy;
> >         u64 incompat = btrfs_super_incompat_flags(disk_super);
> >         const u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
> >         const u64 compat_ro_unsupp = (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP);
> > +       /*
> > +        * For RW mount or remount to RW, we shouldn't allow any unsupported
> > +        * compat_ro flags. Here we just check if any of our sb or new flag
> > +        * is RW.
> > +        * This will cover cases like RW->RW and RW->RO, but since it's
> > +        * already RW, we shouldn't have any unsupported compat_ro flags anyway.
> > +        */
> > +       bool rw_mount = (!sb_rdonly(sb) ||
> > +                        (new_flags && !(*new_flags & SB_RDONLY)));
>
> It also would make this expression shorter and easier to read...
>
> >
> >         if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
> >                 btrfs_err(fs_info,
> > @@ -3430,7 +3440,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
> >         if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
> >                 incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> >
> > -       if (compat_ro_unsupp && !sb_rdonly(sb)) {
> > +       if (compat_ro_unsupp && rw_mount) {
> >                 btrfs_err(fs_info,
> >         "cannot mount read-write because of unknown compat_ro features (0x%llx)",
> >                        compat_ro);
> > @@ -3633,7 +3643,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >                 goto fail_alloc;
> >         }
> >
> > -       ret = btrfs_check_features(fs_info, sb);
> > +       ret = btrfs_check_features(fs_info, sb, NULL);
>
> Here just pass 0 for flags.

Here pass a false value.

>
> >         if (ret < 0) {
> >                 err = ret;
> >                 goto fail_alloc;
> > diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> > index 363935cfc084..e83453c7c429 100644
> > --- a/fs/btrfs/disk-io.h
> > +++ b/fs/btrfs/disk-io.h
> > @@ -50,7 +50,8 @@ int __cold open_ctree(struct super_block *sb,
> >  void __cold close_ctree(struct btrfs_fs_info *fs_info);
> >  int btrfs_validate_super(struct btrfs_fs_info *fs_info,
> >                          struct btrfs_super_block *sb, int mirror_num);
> > -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb);
> > +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb,
> > +                        int *new_flags);
> >  int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
> >  struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
> >  struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index d5de18d6517e..bc2094aa9a40 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -1705,7 +1705,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> >         if (ret)
> >                 goto restore;
> >
> > -       ret = btrfs_check_features(fs_info, sb);
> > +       ret = btrfs_check_features(fs_info, sb, flags);
>
> And here pass *flags.

And here pass:  !(*flags & SB_RDONLY)

Makes the whole thing easier to read and shorter.

Thanks.


>
> Thanks.
>
> >         if (ret < 0)
> >                 goto restore;
> >
> > --
> > 2.39.0
> >
