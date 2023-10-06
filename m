Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8437BBA94
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjJFOnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 10:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjJFOmy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 10:42:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E4E10F
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 07:42:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DA5C433CB
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 14:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696603371;
        bh=COUvKRA+mlphi36VvoqtqbmdNoB3xfCdLIn11HqOnkQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rwFTk23OEkUZkigRDzx3lRnfQKxw5/DCgqPsehkkKWt7qj2P6HhXnxD0wESyZ4WrK
         xrROU/xl0X3DSYvwkJGIPP/EoUsfkarujdWEWHPiAoY5IVFP8nQ/PxisfMWip4AQSz
         FL9WMdV/RcEbKVFKPOFs2r7voaieLMhoWfS6KY6WqIexDmmva/cj/GcX94j6hpAEGX
         oOpAuTctAYQfIN6Ml2dUouAjVMzWQXkdundTgUFxEVeMLYlGzsyquHtGB44zVv9+hz
         ZYSAIucRtO8hIXGLg1pjsUzYHIunmFRK4ksbeL4M24e68SkazOM8Q8R44cSZWLzuaW
         ogwyz4GtYDuyA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1dcfe9cd337so1274008fac.2
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Oct 2023 07:42:51 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyo/NMran3D/0WqfclozGWqkprTK77WxQVQoboK49sq6XVV6e9v
        FUdB8w4MrGObOljZv5oXIy+QfyxnwgMTj3PWADo=
X-Google-Smtp-Source: AGHT+IE0Xg12ewqva01Jh/FVx0luhEGQfBmDTgS8fvZE66wPD2q251LHzIw/AkuAxVXxj+PVg2f/kmw4pWVmaqcD8ro=
X-Received: by 2002:a05:6870:3046:b0:1dd:5857:e28b with SMTP id
 u6-20020a056870304600b001dd5857e28bmr8868771oau.23.1696603370574; Fri, 06 Oct
 2023 07:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696415673.git.fdmanana@suse.com> <2d4e16f4c5ad1f0e6274b4f577b0944546b81517.1696415673.git.fdmanana@suse.com>
 <20231006141645.GC28758@twin.jikos.cz>
In-Reply-To: <20231006141645.GC28758@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 6 Oct 2023 15:42:14 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6T0v_WGEx2T8tsc3NR7jy9RPtqvhmOQ-1NQ_TLzmpmvg@mail.gmail.com>
Message-ID: <CAL3q7H6T0v_WGEx2T8tsc3NR7jy9RPtqvhmOQ-1NQ_TLzmpmvg@mail.gmail.com>
Subject: Re: [PATCH 3/6] btrfs: add and use helpers for reading and writing fs_info->generation
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 6, 2023 at 3:23=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Wed, Oct 04, 2023 at 11:38:50AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently the generation field of struct btrfs_fs_info is always modifi=
ed
> > while holding fs_info->trans_lock locked. Most readers will access this
> > field without taking that lock but while holding a transaction handle,
> > which is safe to do due to the transaction life cycle.
> >
> > However there are other readers that are neither holding the lock nor
> > holding a transaction handle open:
> >
> > 1) When reading an inode from disk, at btrfs_read_locked_inode();
> >
> > 2) When reading the generation to expose it to sysfs, at
> >    btrfs_generation_show();
> >
> > 3) Early in the fsync path, at skip_inode_logging();
> >
> > 4) When creating a hole at btrfs_cont_expand(), during write paths,
> >    truncate and reflinking;
> >
> > 5) In the fs_info ioctl (btrfs_ioctl_fs_info());
> >
> > 6) While mounting the filesystem, in the open_ctree() path. In these
> >    cases it's safe to directly read fs_info->generation as no one
> >    can concurrently start a transaction and update fs_info->generation.
> >
> > In case of the fsync path, races here should be harmless, and in the wo=
rst
> > case they may cause a fsync to log an inode when it's not really needed=
,
> > so nothing bad from a functional perspective. In the other cases it's n=
ot
> > so clear if functional problems may arise, though in case 1 rare things
> > like a load/store tearing [1] may cause the BTRFS_INODE_NEEDS_FULL_SYNC
> > flag not being set on an inode and therefore result in incorrect loggin=
g
> > later on in case a fsync call is made.
> >
> > To avoid data race warnings from tools like KCSAN and other issues such
> > as load and store tearing (amongst others, see [1]), create helpers to
> > access the generation field of struct btrfs_fs_info using READ_ONCE() a=
nd
> > WRITE_ONCE(), and use these helpers where needed.
> >
> > [1] https://lwn.net/Articles/793253/
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/file.c        |  2 +-
> >  fs/btrfs/fs.h          | 16 ++++++++++++++++
> >  fs/btrfs/inode.c       |  4 ++--
> >  fs/btrfs/ioctl.c       |  2 +-
> >  fs/btrfs/sysfs.c       |  2 +-
> >  fs/btrfs/transaction.c |  2 +-
> >  6 files changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 004c53482f05..723f0c70452e 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1749,7 +1749,7 @@ static inline bool skip_inode_logging(const struc=
t btrfs_log_ctx *ctx)
> >       struct btrfs_inode *inode =3D BTRFS_I(ctx->inode);
> >       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >
> > -     if (btrfs_inode_in_log(inode, fs_info->generation) &&
> > +     if (btrfs_inode_in_log(inode, btrfs_get_fs_generation(fs_info)) &=
&
> >           list_empty(&ctx->ordered_extents))
> >               return true;
> >
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index 2bd9bedc7095..d04b729cbdf3 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -416,6 +416,12 @@ struct btrfs_fs_info {
> >
> >       struct btrfs_block_rsv empty_block_rsv;
> >
> > +     /*
> > +      * Updated while holding the lock 'trans_lock'. Due to the life c=
ycle of
> > +      * a transaction, it can be directly read while holding a transac=
tion
> > +      * handle, everywhere else must be read with btrfs_get_fs_generat=
ion().
> > +      * Should always be updated using btrfs_set_fs_generation().
> > +      */
> >       u64 generation;
> >       u64 last_trans_committed;
> >       /*
> > @@ -817,6 +823,16 @@ struct btrfs_fs_info {
> >  #endif
> >  };
> >
> > +static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *=
fs_info)
> > +{
> > +     return READ_ONCE(fs_info->generation);
> > +}
> > +
> > +static inline void btrfs_set_fs_generation(struct btrfs_fs_info *fs_in=
fo, u64 gen)
> > +{
> > +     WRITE_ONCE(fs_info->generation, gen);
> > +}
> > +
> >  static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *=
fs_info,
> >                                               u64 gen)
> >  {
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 3b3aec302c33..c9317c047587 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3800,7 +3800,7 @@ static int btrfs_read_locked_inode(struct inode *=
inode,
> >        * This is required for both inode re-read from disk and delayed =
inode
> >        * in delayed_nodes_tree.
> >        */
> > -     if (BTRFS_I(inode)->last_trans =3D=3D fs_info->generation)
> > +     if (BTRFS_I(inode)->last_trans =3D=3D btrfs_get_fs_generation(fs_=
info))
> >               set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
> >                       &BTRFS_I(inode)->runtime_flags);
> >
> > @@ -4923,7 +4923,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, =
loff_t oldsize, loff_t size)
> >                       hole_em->orig_block_len =3D 0;
> >                       hole_em->ram_bytes =3D hole_size;
> >                       hole_em->compress_type =3D BTRFS_COMPRESS_NONE;
> > -                     hole_em->generation =3D fs_info->generation;
> > +                     hole_em->generation =3D btrfs_get_fs_generation(f=
s_info);
> >
> >                       err =3D btrfs_replace_extent_map_range(inode, hol=
e_em, true);
> >                       free_extent_map(hole_em);
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 848b7e6f6421..7ab21283fae8 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -2822,7 +2822,7 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_i=
nfo *fs_info,
> >       }
> >
> >       if (flags_in & BTRFS_FS_INFO_FLAG_GENERATION) {
> > -             fi_args->generation =3D fs_info->generation;
> > +             fi_args->generation =3D btrfs_get_fs_generation(fs_info);
> >               fi_args->flags |=3D BTRFS_FS_INFO_FLAG_GENERATION;
> >       }
> >
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index e07be193323a..21ab8b9b62ce 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -1201,7 +1201,7 @@ static ssize_t btrfs_generation_show(struct kobje=
ct *kobj,
> >  {
> >       struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
> >
> > -     return sysfs_emit(buf, "%llu\n", fs_info->generation);
> > +     return sysfs_emit(buf, "%llu\n", btrfs_get_fs_generation(fs_info)=
);
> >  }
> >  BTRFS_ATTR(, generation, btrfs_generation_show);
> >
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 3aa59cfa4ab0..f5db3a483f40 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -386,7 +386,7 @@ static noinline int join_transaction(struct btrfs_f=
s_info *fs_info,
> >                       IO_TREE_TRANS_DIRTY_PAGES);
> >       extent_io_tree_init(fs_info, &cur_trans->pinned_extents,
> >                       IO_TREE_FS_PINNED_EXTENTS);
> > -     fs_info->generation++;
> > +     btrfs_set_fs_generation(fs_info, fs_info->generation + 1);
>
> Should this also use the helper for the part where it reads the value?
>
>         btrfs_set_fs_generation(fs_info, btrfs_get_fs_generation(fs_info)=
 + 1);

Nop. As mentioned in the comment added over the field in the struct, the fi=
eld
is only updated while holding fs_info->trans_lock - in fact this is
the only place
we update the field. So it is not necessary to use the helper to read here.

>
> It's a matter of annotation not a functional fix, I don't know if KCSAN
> would warn here. I'd expect that the unprotected access uses the helpers
> consistently, ie. both or none.
