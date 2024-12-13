Return-Path: <linux-btrfs+bounces-10365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6021B9F1932
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 23:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB73188788F
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 22:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E81A7AC7;
	Fri, 13 Dec 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P29IDB+f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD402199E9A
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129425; cv=none; b=DoI3M2RL40DwJYKpWgglglqtP2XijNP7W3hY8fXr5uMleVW6DJOX2j+sd4d56Sqo6tIOfupKwzd0B9PWgTfMG3QGOr4zfVlcTFMYCPO0X4gusoV/v5ryQUx6AMox3CkKHwJrYn/RN8CCWAgju8XnHYlEHoRNqJW5n/K0WNg61gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129425; c=relaxed/simple;
	bh=fetofFO/N4oeAuTC7V/4qzhTg0F9ZEmcEkbt4Tq8FnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZCogdoNhahqm9lC8jtL81NeL2fSwJERcl+bSLSezF1ORsEWhii3i8SveXLcMzy0QQ4NKMYpa+7lxMl3HvXpOHGnBoZtmpXqenYsHivYI3QCY0OEWDD2ImflQ4hxAug991tcDve90AZFX/uqjctN/1vDH+krl5UlNvWEeZNy+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P29IDB+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C35AC4CED7
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 22:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734129425;
	bh=fetofFO/N4oeAuTC7V/4qzhTg0F9ZEmcEkbt4Tq8FnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P29IDB+f6zKTy5mNoAs/4LAuFeZTXllLVOlr66VGQOH3ODtXvq0z0Cf8n1uxRH1AG
	 gPamxANzSNkXME425tbEBvqmjsMyz0vxiC+z2LtD/TIJJ19XDtL6R40DcAZ9X4czKf
	 yH6RTZjyUPpQu0fRMUPxKAxEeUaTymTgjwWd/WEvKa3uL/xmfBHvHX+rU+HkEiWtba
	 gr+X99L5Kn+pN+qyl8fXvsxjqY9Ywnvx8YAQ9o55vjzjtLznHFxvc42IuwI4U+840t
	 1pm1HRNSB/9zwDk5KXVkzAi20vF7dc49uDY2JDSgaZ5Z03WZqT4wJ1fq4sLPAga/5u
	 Ne47qjhdy+L9g==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso4570069a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 14:37:05 -0800 (PST)
X-Gm-Message-State: AOJu0YxX0tdqt4ti3PmNSgjAx/taIsTZL0g9w0EyiUzcdV52MLeaIiQ2
	coTpDvPLDUomyUXQasW5dfhHvPpvJV/o/+bMlbvl2LCIk4vSLzh2Wu00nAxk2XOkA4NglCb6bXv
	TC7TfMNgT5HGFbggJDmHAzzelq84=
X-Google-Smtp-Source: AGHT+IE5/NSiwl2XE4JK3EEB/08F4cTtXoTNAetFQBEB9jrGXroIFhyGunqWTb0aLd/ZaTZo+ENskIdmEFRSmivJeAY=
X-Received: by 2002:a17:907:3f8d:b0:aa6:a7ef:7f1f with SMTP id
 a640c23a62f3a-aab778c80a7mr443144566b.11.1734129423589; Fri, 13 Dec 2024
 14:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733929327.git.fdmanana@suse.com> <bda8a1de78c3d938a71a816401f96f0e0d6c3f72.1733929328.git.fdmanana@suse.com>
 <c0fe6584-7339-4bc3-8e58-6a33626657b3@gmx.com>
In-Reply-To: <c0fe6584-7339-4bc3-8e58-6a33626657b3@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 13 Dec 2024 22:36:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5yX_K-F7r_WWBE0yJqtSJc7rV=hmnb5b6XKBp=x7rXOw@mail.gmail.com>
Message-ID: <CAL3q7H5yX_K-F7r_WWBE0yJqtSJc7rV=hmnb5b6XKBp=x7rXOw@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] btrfs: fix swap file activation failure due to
 extents that used to be shared
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 8:52=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/12/12 01:34, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When activating a swap file, to determine if an extent is shared we use
> > can_nocow_extent(), which ends up at btrfs_cross_ref_exist(). That help=
er
> > is meant to be quick because it's used in the NOCOW write path, when
> > flushing delalloc and when doing a direct IO write, however it does ret=
urn
> > some false positives, meaning it may indicate that an extent is shared
> > even if it's no longer the case. For the write path this is fine, we ju=
st
> > do a unnecessary COW operation instead of doing a more rigorous check
> > which would be too heavy (calling btrfs_is_data_extent_shared()).
> >
> > However when activating a swap file, the false positives simply result
> > in a failure, which is confusing for users/applications. One particular
> > case where this happens is when a data extent only has 1 reference but
> > that reference is not inlined in the extent item located in the extent
> > tree - this happens when we create more than 33 references for an exten=
t
> > and then delete those 33 references plus every other non-inline referen=
ce
> > except one. The function check_committed_ref() assumes that if the size
> > of an extent item doesn't match the size of struct btrfs_extent_item
> > plus the size of an inline reference (plus an owner reference in case
> > simple quotas are enabled), then the extent is shared - that is not the
> > case however, we can have a single reference but it's not inlined - the
> > reason we do this is to be fast and avoid inspecting non-inline referen=
ces
> > which may be located in another leaf of the extent tree, slowing down
> > write paths.
> >
> > The following test script reproduces the bug:
> >
> >     $ cat test.sh
> >     #!/bin/bash
> >
> >     DEV=3D/dev/sdi
> >     MNT=3D/mnt/sdi
> >     NUM_CLONES=3D50
> >
> >     umount $DEV &> /dev/null
> >
> >     run_test()
> >     {
> >          local sync_after_add_reflinks=3D$1
> >          local sync_after_remove_reflinks=3D$2
> >
> >          mkfs.btrfs -f $DEV > /dev/null
> >          #mkfs.xfs -f $DEV > /dev/null
> >          mount $DEV $MNT
> >
> >          touch $MNT/foo
> >          chmod 0600 $MNT/foo
> >       # On btrfs the file must be NOCOW.
> >          chattr +C $MNT/foo &> /dev/null
> >          xfs_io -s -c "pwrite -b 1M 0 1M" $MNT/foo
> >          mkswap $MNT/foo
> >
> >          for ((i =3D 1; i <=3D $NUM_CLONES; i++)); do
> >              touch $MNT/foo_clone_$i
> >              chmod 0600 $MNT/foo_clone_$i
> >              # On btrfs the file must be NOCOW.
> >              chattr +C $MNT/foo_clone_$i &> /dev/null
> >              cp --reflink=3Dalways $MNT/foo $MNT/foo_clone_$i
> >          done
> >
> >          if [ $sync_after_add_reflinks -ne 0 ]; then
> >              # Flush delayed refs and commit current transaction.
> >              sync -f $MNT
> >          fi
> >
> >          # Remove the original file and all clones except the last.
> >          rm -f $MNT/foo
> >          for ((i =3D 1; i < $NUM_CLONES; i++)); do
> >              rm -f $MNT/foo_clone_$i
> >          done
> >
> >          if [ $sync_after_remove_reflinks -ne 0 ]; then
> >              # Flush delayed refs and commit current transaction.
> >              sync -f $MNT
> >          fi
> >
> >          # Now use the last clone as a swap file. It should work since
> >          # its extent are not shared anymore.
> >          swapon $MNT/foo_clone_${NUM_CLONES}
> >          swapoff $MNT/foo_clone_${NUM_CLONES}
> >
> >          umount $MNT
> >     }
> >
> >     echo -e "\nTest without sync after creating and removing clones"
> >     run_test 0 0
> >
> >     echo -e "\nTest with sync after creating clones"
> >     run_test 1 0
> >
> >     echo -e "\nTest with sync after removing clones"
> >     run_test 0 1
> >
> >     echo -e "\nTest with sync after creating and removing clones"
> >     run_test 1 1
> >
> > Running the test:
> >
> >     $ ./test.sh
> >     Test without sync after creating and removing clones
> >     wrote 1048576/1048576 bytes at offset 0
> >     1 MiB, 1 ops; 0.0017 sec (556.793 MiB/sec and 556.7929 ops/sec)
> >     Setting up swapspace version 1, size =3D 1020 KiB (1044480 bytes)
> >     no label, UUID=3Da6b9c29e-5ef4-4689-a8ac-bc199c750f02
> >     swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
> >     swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
> >
> >     Test with sync after creating clones
> >     wrote 1048576/1048576 bytes at offset 0
> >     1 MiB, 1 ops; 0.0036 sec (271.739 MiB/sec and 271.7391 ops/sec)
> >     Setting up swapspace version 1, size =3D 1020 KiB (1044480 bytes)
> >     no label, UUID=3D5e9008d6-1f7a-4948-a1b4-3f30aba20a33
> >     swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
> >     swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
> >
> >     Test with sync after removing clones
> >     wrote 1048576/1048576 bytes at offset 0
> >     1 MiB, 1 ops; 0.0103 sec (96.665 MiB/sec and 96.6651 ops/sec)
> >     Setting up swapspace version 1, size =3D 1020 KiB (1044480 bytes)
> >     no label, UUID=3D916c2740-fa9f-4385-9f06-29c3f89e4764
> >
> >     Test with sync after creating and removing clones
> >     wrote 1048576/1048576 bytes at offset 0
> >     1 MiB, 1 ops; 0.0031 sec (314.268 MiB/sec and 314.2678 ops/sec)
> >     Setting up swapspace version 1, size =3D 1020 KiB (1044480 bytes)
> >     no label, UUID=3D06aab1dd-4d90-49c0-bd9f-3a8db4e2f912
> >     swapon: /mnt/sdi/foo_clone_50: swapon failed: Invalid argument
> >     swapoff: /mnt/sdi/foo_clone_50: swapoff failed: Invalid argument
> >
> > Fix this by reworking btrfs_swap_activate() to instead of using extent
> > maps and checking for shared extents with can_nocow_extent(), iterate
> > over the inode's file extent items and use the accurate
> > btrfs_is_data_extent_shared().
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> The patch looks good to me.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
>
> Although there is no mention about why we get rid of btrfs_get_extent().
>
> I guess it's to avoid caching those extent maps to save space? Just like
> what we did in fiemap.

It's not so much to avoid loading extent maps unnecessarily but
because of correctness.
Extent maps can be merged, and we need to find out individual extents
because some of the extents that were merged may be shared while others
are not and vice-versa.

Otherwise it would be a bug, similar to what we had with fiemap fixed
in ac3c0d36a2a2f7a8f9778faef3f2639f5bf29d44, for which there's test
case generic/702.

That's why we iterate over extent items and not extent maps.

Thanks.



>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/inode.c | 96 ++++++++++++++++++++++++++++++++++-------------=
-
> >   1 file changed, 69 insertions(+), 27 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 926d82fbdbae..7ddb8a01b60f 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -9799,15 +9799,16 @@ static int btrfs_swap_activate(struct swap_info=
_struct *sis, struct file *file,
> >       struct btrfs_fs_info *fs_info =3D root->fs_info;
> >       struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
> >       struct extent_state *cached_state =3D NULL;
> > -     struct extent_map *em =3D NULL;
> >       struct btrfs_chunk_map *map =3D NULL;
> >       struct btrfs_device *device =3D NULL;
> >       struct btrfs_swap_info bsi =3D {
> >               .lowest_ppage =3D (sector_t)-1ULL,
> >       };
> > +     struct btrfs_backref_share_check_ctx *backref_ctx =3D NULL;
> > +     struct btrfs_path *path =3D NULL;
> >       int ret =3D 0;
> >       u64 isize;
> > -     u64 start;
> > +     u64 prev_extent_end =3D 0;
> >
> >       /*
> >        * Acquire the inode's mmap lock to prevent races with memory map=
ped
> > @@ -9846,6 +9847,13 @@ static int btrfs_swap_activate(struct swap_info_=
struct *sis, struct file *file,
> >               goto out_unlock_mmap;
> >       }
> >
> > +     path =3D btrfs_alloc_path();
> > +     backref_ctx =3D btrfs_alloc_backref_share_check_ctx();
> > +     if (!path || !backref_ctx) {
> > +             ret =3D -ENOMEM;
> > +             goto out_unlock_mmap;
> > +     }
> > +
> >       /*
> >        * Balance or device remove/replace/resize can move stuff around =
from
> >        * under us. The exclop protection makes sure they aren't running=
/won't
> > @@ -9904,24 +9912,39 @@ static int btrfs_swap_activate(struct swap_info=
_struct *sis, struct file *file,
> >       isize =3D ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
> >
> >       lock_extent(io_tree, 0, isize - 1, &cached_state);
> > -     start =3D 0;
> > -     while (start < isize) {
> > -             u64 logical_block_start, physical_block_start;
> > +     while (prev_extent_end < isize) {
> > +             struct btrfs_key key;
> > +             struct extent_buffer *leaf;
> > +             struct btrfs_file_extent_item *ei;
> >               struct btrfs_block_group *bg;
> > -             u64 len =3D isize - start;
> > +             u64 logical_block_start;
> > +             u64 physical_block_start;
> > +             u64 extent_gen;
> > +             u64 disk_bytenr;
> > +             u64 len;
> >
> > -             em =3D btrfs_get_extent(BTRFS_I(inode), NULL, start, len)=
;
> > -             if (IS_ERR(em)) {
> > -                     ret =3D PTR_ERR(em);
> > +             key.objectid =3D btrfs_ino(BTRFS_I(inode));
> > +             key.type =3D BTRFS_EXTENT_DATA_KEY;
> > +             key.offset =3D prev_extent_end;
> > +
> > +             ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> > +             if (ret < 0)
> >                       goto out;
> > -             }
> >
> > -             if (em->disk_bytenr =3D=3D EXTENT_MAP_HOLE) {
> > +             /*
> > +              * If key not found it means we have an implicit hole (NO=
_HOLES
> > +              * is enabled).
> > +              */
> > +             if (ret > 0) {
> >                       btrfs_warn(fs_info, "swapfile must not have holes=
");
> >                       ret =3D -EINVAL;
> >                       goto out;
> >               }
> > -             if (em->disk_bytenr =3D=3D EXTENT_MAP_INLINE) {
> > +
> > +             leaf =3D path->nodes[0];
> > +             ei =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_=
file_extent_item);
> > +
> > +             if (btrfs_file_extent_type(leaf, ei) =3D=3D BTRFS_FILE_EX=
TENT_INLINE) {
> >                       /*
> >                        * It's unlikely we'll ever actually find ourselv=
es
> >                        * here, as a file small enough to fit inline won=
't be
> > @@ -9933,23 +9956,45 @@ static int btrfs_swap_activate(struct swap_info=
_struct *sis, struct file *file,
> >                       ret =3D -EINVAL;
> >                       goto out;
> >               }
> > -             if (extent_map_is_compressed(em)) {
> > +
> > +             if (btrfs_file_extent_compression(leaf, ei) !=3D BTRFS_CO=
MPRESS_NONE) {
> >                       btrfs_warn(fs_info, "swapfile must not be compres=
sed");
> >                       ret =3D -EINVAL;
> >                       goto out;
> >               }
> >
> > -             logical_block_start =3D extent_map_block_start(em) + (sta=
rt - em->start);
> > -             len =3D min(len, em->len - (start - em->start));
> > -             free_extent_map(em);
> > -             em =3D NULL;
> > +             disk_bytenr =3D btrfs_file_extent_disk_bytenr(leaf, ei);
> > +             if (disk_bytenr =3D=3D 0) {
> > +                     btrfs_warn(fs_info, "swapfile must not have holes=
");
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> > +             }
> > +
> > +             logical_block_start =3D disk_bytenr + btrfs_file_extent_o=
ffset(leaf, ei);
> > +             extent_gen =3D btrfs_file_extent_generation(leaf, ei);
> > +             prev_extent_end =3D btrfs_file_extent_end(path);
> > +
> > +             if (prev_extent_end > isize)
> > +                     len =3D isize - key.offset;
> > +             else
> > +                     len =3D btrfs_file_extent_num_bytes(leaf, ei);
> >
> > -             ret =3D can_nocow_extent(inode, start, &len, NULL, false,=
 true);
> > +             backref_ctx->curr_leaf_bytenr =3D leaf->start;
> > +
> > +             /*
> > +              * Don't need the path anymore, release to avoid deadlock=
s when
> > +              * calling btrfs_is_data_extent_shared() because when joi=
ning a
> > +              * transaction it can block waiting for the current one's=
 commit
> > +              * which in turn may be trying to lock the same leaf to f=
lush
> > +              * delayed items for example.
> > +              */
> > +             btrfs_release_path(path);
> > +
> > +             ret =3D btrfs_is_data_extent_shared(BTRFS_I(inode), disk_=
bytenr,
> > +                                               extent_gen, backref_ctx=
);
> >               if (ret < 0) {
> >                       goto out;
> > -             } else if (ret) {
> > -                     ret =3D 0;
> > -             } else {
> > +             } else if (ret > 0) {
> >                       btrfs_warn(fs_info,
> >                                  "swapfile must not be copy-on-write");
> >                       ret =3D -EINVAL;
> > @@ -9984,7 +10029,6 @@ static int btrfs_swap_activate(struct swap_info_=
struct *sis, struct file *file,
> >
> >               physical_block_start =3D (map->stripes[0].physical +
> >                                       (logical_block_start - map->start=
));
> > -             len =3D min(len, map->chunk_len - (logical_block_start - =
map->start));
> >               btrfs_free_chunk_map(map);
> >               map =3D NULL;
> >
> > @@ -10025,20 +10069,16 @@ static int btrfs_swap_activate(struct swap_in=
fo_struct *sis, struct file *file,
> >                               if (ret)
> >                                       goto out;
> >                       }
> > -                     bsi.start =3D start;
> > +                     bsi.start =3D key.offset;
> >                       bsi.block_start =3D physical_block_start;
> >                       bsi.block_len =3D len;
> >               }
> > -
> > -             start +=3D len;
> >       }
> >
> >       if (bsi.block_len)
> >               ret =3D btrfs_add_swap_extent(sis, &bsi);
> >
> >   out:
> > -     if (!IS_ERR_OR_NULL(em))
> > -             free_extent_map(em);
> >       if (!IS_ERR_OR_NULL(map))
> >               btrfs_free_chunk_map(map);
> >
> > @@ -10053,6 +10093,8 @@ static int btrfs_swap_activate(struct swap_info=
_struct *sis, struct file *file,
> >
> >   out_unlock_mmap:
> >       up_write(&BTRFS_I(inode)->i_mmap_lock);
> > +     btrfs_free_backref_share_ctx(backref_ctx);
> > +     btrfs_free_path(path);
> >       if (ret)
> >               return ret;
> >
>

