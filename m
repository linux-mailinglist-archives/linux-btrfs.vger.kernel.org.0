Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA52C42C2DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 16:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhJMOY2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 10:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231664AbhJMOY2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:24:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCB5860E96
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634134944;
        bh=FaAlQbjkdHfVnSfYVNKHvJ51YTyzmmcd90g876GRnG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eSg+4UXUM7qOoMM1t702czazuAXbOqGUXyC+XPLUaI6Bl66P1lBZlgNH+oxVb8lYo
         2VxwhO2W483/un9TjnidvqDUoEND5DF2/v5o3JISPDVzqYm7lYaMX/D3NYOPibCxmW
         jamv/tAwcWxxAmDWT0UKFDhY7u7WWaldiiTbAmVuuCI03eHMp2ojGLF1MTTb1uZ9kl
         lojiIC58zIDQWuTp0nQ656nyqlmVwX5klvKLcjnX/T9It81PDfXS8iX1ZVw3M/eS/F
         Hrp7AGRX2QLKw5CFKaKT8FxdMJTYFA5urju16Covm3IhwXIK+llizCRMjero1+7ABE
         DYLPSkdjcsfyg==
Received: by mail-qt1-f179.google.com with SMTP id w2so2720833qtn.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 07:22:24 -0700 (PDT)
X-Gm-Message-State: AOAM530g2VwIzLZ4+MP+OOOyCieF2amymGow0vK4FF+VGhFELGNkFuzh
        Uy+fArykiMFWYe5M4gjN7ZwQJhYw0aA8q3k9nhY=
X-Google-Smtp-Source: ABdhPJzvK7xeRsFAsC5/WzYydjKEg6GJ0haQ/p3uzgSY062C61NsF1LiF+H2z2PqO5jBvaArzZQGlIWloLfS3GsceRw=
X-Received: by 2002:ac8:58d3:: with SMTP id u19mr17310647qta.29.1634134943798;
 Wed, 13 Oct 2021 07:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634115580.git.fdmanana@suse.com> <0747812264412ce1a8474ff2ec223010a6dce3a0.1634115580.git.fdmanana@suse.com>
 <f281ca42-cd64-7978-b4c0-17756dd7689c@suse.com>
In-Reply-To: <f281ca42-cd64-7978-b4c0-17756dd7689c@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 13 Oct 2021 15:21:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H62eWcTZWCkN8ZMDEOjgjJBXYgESSdhcdWHxzfVzUBUqA@mail.gmail.com>
Message-ID: <CAL3q7H62eWcTZWCkN8ZMDEOjgjJBXYgESSdhcdWHxzfVzUBUqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: fix deadlock between chunk allocation and
 chunk btree modifications
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 3:10 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 13.10.21 =D0=B3. 12:12, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
>
> <snip>
>
> >
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/CACkBjsax51i4mu6C0C3vJqQN3NR_=
iVuucoeG3U1HXjrgzn5FFQ@mail.gmail.com/
> > Fixes: 79bd37120b1495 ("btrfs: rework chunk allocation to avoid exhaust=
ion of the system chunk array")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/block-group.c | 145 +++++++++++++++++++++++++----------------
> >  fs/btrfs/block-group.h |   2 +
> >  fs/btrfs/relocation.c  |   4 ++
> >  fs/btrfs/volumes.c     |  15 ++++-
> >  4 files changed, 110 insertions(+), 56 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 46fdef7bbe20..e790ea0798c7 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -3403,25 +3403,6 @@ static int do_chunk_alloc(struct btrfs_trans_han=
dle *trans, u64 flags)
> >               goto out;
> >       }
> >
> > -     /*
> > -      * If this is a system chunk allocation then stop right here and =
do not
> > -      * add the chunk item to the chunk btree. This is to prevent a de=
adlock
> > -      * because this system chunk allocation can be triggered while CO=
Wing
> > -      * some extent buffer of the chunk btree and while holding a lock=
 on a
> > -      * parent extent buffer, in which case attempting to insert the c=
hunk
> > -      * item (or update the device item) would result in a deadlock on=
 that
> > -      * parent extent buffer. In this case defer the chunk btree updat=
es to
> > -      * the second phase of chunk allocation and keep our reservation =
until
> > -      * the second phase completes.
> > -      *
> > -      * This is a rare case and can only be triggered by the very few =
cases
> > -      * we have where we need to touch the chunk btree outside chunk a=
llocation
> > -      * and chunk removal. These cases are basically adding a device, =
removing
> > -      * a device or resizing a device.
> > -      */
> > -     if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
> > -             return 0;
> > -
> >       ret =3D btrfs_chunk_alloc_add_chunk_item(trans, bg);
> >       /*
> >        * Normally we are not expected to fail with -ENOSPC here, since =
we have
> > @@ -3554,14 +3535,14 @@ static int do_chunk_alloc(struct btrfs_trans_ha=
ndle *trans, u64 flags)
> >   * This has happened before and commit eafa4fd0ad0607 ("btrfs: fix exh=
austion of
> >   * the system chunk array due to concurrent allocations") provides mor=
e details.
> >   *
> > - * For allocation of system chunks, we defer the updates and insertion=
s into the
> > - * chunk btree to phase 2. This is to prevent deadlocks on extent buff=
ers because
> > - * if the chunk allocation is triggered while COWing an extent buffer =
of the
> > - * chunk btree, we are holding a lock on the parent of that extent buf=
fer and
> > - * doing the chunk btree updates and insertions can require locking th=
at parent.
> > - * This is for the very few and rare cases where we update the chunk b=
tree that
> > - * are not chunk allocation or chunk removal: adding a device, removin=
g a device
> > - * or resizing a device.
> > + * Allocation of system chunks does not happen through this function. =
A task that
> > + * needs to update the chunk btree (the only btree that uses system ch=
unks), must
> > + * preallocate chunk space by calling either check_system_chunk() or
> > + * btrfs_reserve_chunk_metadata() - the former is used when allocating=
 a data or
> > + * metadata chunk or when removing a chunk, while the later is used be=
fore doing
> > + * a modification to the chunk btree - use cases for the later are add=
ing,
> > + * removing and resizing a device as well as relocation of a system ch=
unk.
> > + * See the comment below for more details.
> >   *
> >   * The reservation of system space, done through check_system_chunk(),=
 as well
> >   * as all the updates and insertions into the chunk btree must be done=
 while
> > @@ -3598,11 +3579,27 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle=
 *trans, u64 flags,
> >       if (trans->allocating_chunk)
> >               return -ENOSPC;
> >       /*
> > -      * If we are removing a chunk, don't re-enter or we would deadloc=
k.
> > -      * System space reservation and system chunk allocation is done b=
y the
> > -      * chunk remove operation (btrfs_remove_chunk()).
> > +      * Allocation of system chunks can not happen through this path, =
as we
> > +      * could end up in a deadlock if we are allocating a data or meta=
data
> > +      * chunk and there is another task modifying the chunk btree.
> > +      *
> > +      * This is because while we are holding the chunk mutex, we will =
attempt
> > +      * to add the new chunk item to the chunk btree or update an exis=
ting
> > +      * device item in the chunk btree, while the other task that is m=
odifying
> > +      * the chunk btree is attempting to COW an extent buffer while ho=
lding a
> > +      * lock on it and on its parent - if the COW operation triggers a=
 system
> > +      * chunk allocation, then we can deadlock because we are holding =
the
> > +      * chunk mutex and we may need to access that extent buffer or it=
s parent
> > +      * in order to add the chunk item or update a device item.
> > +      *
> > +      * Tasks that want to modify the chunk tree should reserve system=
 space
> > +      * before updating the chunk btree, by calling either
> > +      * btrfs_reserve_chunk_metadata() or check_system_chunk().
> > +      * It's possible that after a task reserves the space, it still e=
nds up
> > +      * here - this happens in the cases described above at do_chunk_a=
lloc().
> > +      * The task will have to either retry or fail.
> >        */
> > -     if (trans->removing_chunk)
> > +     if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
> >               return -ENOSPC;
> >
> >       space_info =3D btrfs_find_space_info(fs_info, flags);
> > @@ -3701,17 +3698,14 @@ static u64 get_profile_num_devs(struct btrfs_fs=
_info *fs_info, u64 type)
> >       return num_dev;
> >  }
> >
> > -/*
> > - * Reserve space in the system space for allocating or removing a chun=
k
> > - */
> > -void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
> > +static void reserve_chunk_space(struct btrfs_trans_handle *trans,
> > +                             u64 bytes,
> > +                             u64 type)
> >  {
> >       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> >       struct btrfs_space_info *info;
> >       u64 left;
> > -     u64 thresh;
> >       int ret =3D 0;
> > -     u64 num_devs;
> >
> >       /*
> >        * Needed because we can end up allocating a system chunk and for=
 an
> > @@ -3724,19 +3718,13 @@ void check_system_chunk(struct btrfs_trans_hand=
le *trans, u64 type)
> >       left =3D info->total_bytes - btrfs_space_info_used(info, true);
> >       spin_unlock(&info->lock);
> >
> > -     num_devs =3D get_profile_num_devs(fs_info, type);
> > -
> > -     /* num_devs device items to update and 1 chunk item to add or rem=
ove */
> > -     thresh =3D btrfs_calc_metadata_size(fs_info, num_devs) +
> > -             btrfs_calc_insert_metadata_size(fs_info, 1);
> > -
> > -     if (left < thresh && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
> > +     if (left < bytes && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
> >               btrfs_info(fs_info, "left=3D%llu, need=3D%llu, flags=3D%l=
lu",
> > -                        left, thresh, type);
> > +                        left, bytes, type);
> >               btrfs_dump_space_info(fs_info, info, 0, 0);
> >       }
>
> This can be simplified to if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
> and nested inside the next if (left < bytes). I checked
> and even with the extra nesting the code doesn't break the 76 char limit.

This is a bug fix only, I'm not reformatting code blocks I'm not
really changing.

>
> >
> > -     if (left < thresh) {
> > +     if (left < bytes) {
> >               u64 flags =3D btrfs_system_alloc_profile(fs_info);
> >               struct btrfs_block_group *bg;
> >
> > @@ -3745,21 +3733,20 @@ void check_system_chunk(struct btrfs_trans_hand=
le *trans, u64 type)
> >                * needing it, as we might not need to COW all nodes/leaf=
s from
> >                * the paths we visit in the chunk tree (they were alread=
y COWed
> >                * or created in the current transaction for example).
> > -              *
> > -              * Also, if our caller is allocating a system chunk, do n=
ot
> > -              * attempt to insert the chunk item in the chunk btree, a=
s we
> > -              * could deadlock on an extent buffer since our caller ma=
y be
> > -              * COWing an extent buffer from the chunk btree.
> >                */
> >               bg =3D btrfs_create_chunk(trans, flags);
> >               if (IS_ERR(bg)) {
> >                       ret =3D PTR_ERR(bg);
> > -             } else if (!(type & BTRFS_BLOCK_GROUP_SYSTEM)) {
> > +             } else {
>
> This can be turned into a simple if (!IS_ERR(bg)) {}

Same type of comment as before.

>
>
> >                       /*
> >                        * If we fail to add the chunk item here, we end =
up
> >                        * trying again at phase 2 of chunk allocation, a=
t
> >                        * btrfs_create_pending_block_groups(). So ignore
> > -                      * any error here.
> > +                      * any error here. An ENOSPC here could happen, d=
ue to
> > +                      * the cases described at do_chunk_alloc() - the =
system
> > +                      * block group we just created was just turned in=
to RO
> > +                      * mode by a scrub for example, or a running disc=
ard
> > +                      * temporarily removed its free space entries, et=
c.
> >                        */
> >                       btrfs_chunk_alloc_add_chunk_item(trans, bg);
> >               }
> > @@ -3768,12 +3755,60 @@ void check_system_chunk(struct btrfs_trans_hand=
le *trans, u64 type)
> >       if (!ret) {
> >               ret =3D btrfs_block_rsv_add(fs_info->chunk_root,
> >                                         &fs_info->chunk_block_rsv,
> > -                                       thresh, BTRFS_RESERVE_NO_FLUSH)=
;
> > +                                       bytes, BTRFS_RESERVE_NO_FLUSH);
> >               if (!ret)
> > -                     trans->chunk_bytes_reserved +=3D thresh;
> > +                     trans->chunk_bytes_reserved +=3D bytes;
> >       }
>
> The single btrfs_block_rsv_add call and the addition of bytes to chunk_by=
tes_reserved
> can be collapsed into the above branch. The end result looks like: https:=
//pastebin.com/F09TjVWp
>
> This is results in slightly shorter and more linear code =3D> easy to rea=
d.

Same as before, I'm not reformatting or changing the style of the code
that is not being changed here for fixing a bug.

Plus it's highly subjective if that is more readable - I don't like it
more because it adds 1 more indentation level.

>
>
> >  }
> >
> > +/*
> > + * Reserve space in the system space for allocating or removing a chun=
k.
> > + * The caller must be holding fs_info->chunk_mutex.
>
> Better to use lockdep_assert_held.

reserve_chunk_space() does that, that's why I didn't add it here again.

Thanks.

>
> > + */
> > +void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
> > +{
> > +     struct btrfs_fs_info *fs_info =3D trans->fs_info;
> > +     const u64 num_devs =3D get_profile_num_devs(fs_info, type);
> > +     u64 bytes;
> > +
> > +     /* num_devs device items to update and 1 chunk item to add or rem=
ove. */
> > +     bytes =3D btrfs_calc_metadata_size(fs_info, num_devs) +
> > +             btrfs_calc_insert_metadata_size(fs_info, 1);
> > +
> > +     reserve_chunk_space(trans, bytes, type);
> > +}
> > +
>
> <snip>
