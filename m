Return-Path: <linux-btrfs+bounces-15381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E27DAFE5ED
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 12:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EC73AC15F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B8F28CF67;
	Wed,  9 Jul 2025 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnIF5nBe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8340288C0A
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057454; cv=none; b=MQSClqt0hM68P+Klpe5/O/6GSlM3KnxNO9+WM7xst8Rml3y99JyB4sTHpQ3B5YabMbTjjmFphbnCEIBreGJ3GTIdrQCbh7chLl9bSbo1S9wK66fyWHY+tdO0jYAYlhS12FA30mrA5KwYncYMDguOase6hXP0gWT1YVqD7kL58gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057454; c=relaxed/simple;
	bh=IKqI+/RR4I4IYUmkpuhKkZk5EIAZL6u0xKJR1XQqRa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oINFqyXY2qo7cmbkXPM+BDGIcMivcdzb/WFrAylN7YU3Gnh6Xq5cnlsgcja69mrHJAohKnnvtx5ySmNFY1jfwFPEkIxGCaaXj0UI01zVIjtRRAuenmGatwjR7moh9qjyScCsSrwbhY5GhvmpLhXEp7ld0QcYbW5e2PW2pCyu9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnIF5nBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0DCC4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 10:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057454;
	bh=IKqI+/RR4I4IYUmkpuhKkZk5EIAZL6u0xKJR1XQqRa0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cnIF5nBe14NAXS1QYGbpR4qpHCoUdZQn/7HwHthWYvs8FdFUg/T1///SoZ2op8GXB
	 Mqw8W8AraYsUQ2lq5iKQbyvu7vSSyitt9IfCPOW60KLgPiWnPKxmSXnyj71wwHEd9e
	 arzZ2/KUfNcTDW4XyRfyt7LxiFcR3b16NmhMS7ez4wXFtU2l2K4aY7LiqIafSjCUAk
	 B5BLxQ5w8m38+Aj9WZe075JM+TKU3jz68KGp6CrRSyZIB4I9nXk6ulth7sP/nq4WNt
	 HQuQDb8VQBVwYWJf/Ho8ggPYF+sZqfweGFigcOTFzvzY8xeRNMyMBKhotEMuLE3BZO
	 omPRpAhjr564Q==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae361e8ec32so1063747366b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Jul 2025 03:37:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YxrSu/Dy8LayFTwcvlzXsccWOkjOWaPgSu/vp0uX3kIQsrUrGv+
	H/fGq9/HqzOvwYbztkva71Ka5zejbj9iSJRGfY+vUTIbAFpHWTnSyA7qXnOErkYAU5HWIOX1zPh
	gN1ZpGFNZtI1LSoO9sq7Ik6WBuat3qEA=
X-Google-Smtp-Source: AGHT+IG+Fnl4b12vglvUgN0EOEwzYIHl+SZcEVQyValSValQl+u636k12XDAy2TBseEO3Ymc6JysEFXQgcZZ1VuCG+0=
X-Received: by 2002:a17:907:608d:b0:ae3:6d27:5246 with SMTP id
 a640c23a62f3a-ae6cf7a9c33mr210825666b.48.1752057452873; Wed, 09 Jul 2025
 03:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752050704.git.fdmanana@suse.com> <91b4d80da9b7938b6f7b0c628a6c0cf896f97061.1752050704.git.fdmanana@suse.com>
 <bb1cb822-39fc-4fe9-83b3-25d44eafbc50@gmx.com>
In-Reply-To: <bb1cb822-39fc-4fe9-83b3-25d44eafbc50@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 9 Jul 2025 11:36:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4+w0TqPLfnmj4v21oMaqaxXwdkrL0qNsYSHdR5J3Wj8Q@mail.gmail.com>
X-Gm-Features: Ac12FXxv7KFZQz65bvYuqz1qiQ58BTSVYzjbGXkJiTqFPfBtqSBo2QXCAPo_o6I
Message-ID: <CAL3q7H4+w0TqPLfnmj4v21oMaqaxXwdkrL0qNsYSHdR5J3Wj8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 11:02=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/7/9 18:23, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we attempt a mmap write into a NOCOW file or a prealloc extent when
> > there is no more available data space (or unallocated space to allocate=
 a
> > new data block group) and we can do a NOCOW write (there are no reflink=
s
> > for the target extent or snapshots), we always fail due to -ENOSPC, unl=
ike
> > for the regular buffered write and direct IO paths where we check that =
we
> > can do a NOCOW write in case we can't reserve data space.
> >
> > Simple reproducer:
> >
> >    $ cat test.sh
> >    #!/bin/bash
> >
> >    DEV=3D/dev/sdi
> >    MNT=3D/mnt/sdi
> >
> >    umount $DEV &> /dev/null
> >    mkfs.btrfs -f -b $((512 * 1024 * 1024)) $DEV
> >    mount $DEV $MNT
> >
> >    touch $MNT/foobar
> >    # Make it a NOCOW file.
> >    chattr +C $MNT/foobar
> >
> >    # Add initial data to file.
> >    xfs_io -c "pwrite -S 0xab 0 1M" $MNT/foobar
> >
> >    # Fill all the remaining data space and unallocated space with data.
> >    dd if=3D/dev/zero of=3D$MNT/filler bs=3D4K &> /dev/null
> >
> >    # Overwrite the file with a mmap write. Should succeed.
> >    xfs_io -c "mmap -w 0 1M"        \
> >           -c "mwrite -S 0xcd 0 1M" \
> >           -c "munmap"              \
> >           $MNT/foobar
> >
> >    # Unmount, mount again and verify the new data was persisted.
> >    umount $MNT
> >    mount $DEV $MNT
> >
> >    od -A d -t x1 $MNT/foobar
> >
> >    umount $MNT
> >
> > Running this:
> >
> >    $ ./test.sh
> >    (...)
> >    wrote 1048576/1048576 bytes at offset 0
> >    1 MiB, 256 ops; 0.0008 sec (1.188 GiB/sec and 311435.5231 ops/sec)
> >    ./test.sh: line 24: 234865 Bus error               xfs_io -c "mmap -=
w 0 1M" -c "mwrite -S 0xcd 0 1M" -c "munmap" $MNT/foobar
> >    0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> >    *
> >    1048576
> >
> > Fix this by not failing in case we can't allocate data space and we can
> > NOCOW into the target extent - reserving only metadata space in this ca=
se.
> >
> > After this change the test passes:
> >
> >    $ ./test.sh
> >    (...)
> >    wrote 1048576/1048576 bytes at offset 0
> >    1 MiB, 256 ops; 0.0007 sec (1.262 GiB/sec and 330749.3540 ops/sec)
> >    0000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> >    *
> >    1048576
> >
> > A test case for fstests will be added soon.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> With large data folios, I'm afraid we may fail the nocow check more
> frequently than the regular page sized folios.

Why?
For a NOCOW file, assuming there are no reflinks or snapshots, it
doesn't matter how big the folio is or how many extents it spans.

> But that's unavoidable, we have to ensure the whole folio can be written
> back NOCOW.
>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/file.c | 49 +++++++++++++++++++++++++++++++++++++++++-------=
-
> >   1 file changed, 41 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 05b046c6806f..f08c72dbb530 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1841,6 +1841,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fa=
ult *vmf)
> >       loff_t size;
> >       size_t fsize =3D folio_size(folio);
> >       int ret;
> > +     bool only_release_metadata =3D false;
> >       u64 reserved_space;
> >       u64 page_start;
> >       u64 page_end;
> > @@ -1861,10 +1862,28 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_=
fault *vmf)
> >        * end up waiting indefinitely to get a lock on the page currentl=
y
> >        * being processed by btrfs_page_mkwrite() function.
> >        */
> > -     ret =3D btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserv=
ed,
> > -                                        page_start, reserved_space);
> > -     if (ret < 0)
> > +     ret =3D btrfs_check_data_free_space(BTRFS_I(inode), &data_reserve=
d,
> > +                                       page_start, reserved_space, fal=
se);
> > +     if (ret < 0) {
> > +             size_t write_bytes =3D reserved_space;
> > +
> > +             if (btrfs_check_nocow_lock(BTRFS_I(inode), page_start,
> > +                                        &write_bytes, false) <=3D 0)
> > +                     goto out_noreserve;
> > +
> > +             if (write_bytes < reserved_space)
> > +                     goto out_noreserve;
> > +
> > +             only_release_metadata =3D true;
> > +     }
> > +     ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), reserved_=
space,
> > +                                           reserved_space, false);
> > +     if (ret < 0) {
> > +             if (!only_release_metadata)
> > +                     btrfs_free_reserved_data_space(BTRFS_I(inode), da=
ta_reserved,
> > +                                                    page_start, reserv=
ed_space);
> >               goto out_noreserve;
> > +     }
> >
> >       ret =3D file_update_time(vmf->vma->vm_file);
> >       if (ret < 0)
> > @@ -1906,9 +1925,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_f=
ault *vmf)
> >               reserved_space =3D round_up(size - page_start, fs_info->s=
ectorsize);
> >               if (reserved_space < fsize) {
> >                       end =3D page_start + reserved_space - 1;
> > -                     btrfs_delalloc_release_space(BTRFS_I(inode),
> > -                                     data_reserved, end + 1,
> > -                                     fsize - reserved_space, true);
> > +                     if (!only_release_metadata)
> > +                             btrfs_delalloc_release_space(BTRFS_I(inod=
e),
> > +                                                          data_reserve=
d, end + 1,
> > +                                                          fsize - rese=
rved_space,
> > +                                                          true);
> >               }
> >       }
> >
> > @@ -1945,10 +1966,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_=
fault *vmf)
> >
> >       btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
> >
> > +     if (only_release_metadata)
> > +             btrfs_set_extent_bit(io_tree, page_start, end, EXTENT_NOR=
ESERVE,
> > +                                  &cached_state);
> > +
> >       btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state)=
;
> >       up_read(&BTRFS_I(inode)->i_mmap_lock);
> >
> >       btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
> > +     if (only_release_metadata)
> > +             btrfs_check_nocow_unlock(BTRFS_I(inode));
> >       sb_end_pagefault(inode->i_sb);
> >       extent_changeset_free(data_reserved);
> >       return VM_FAULT_LOCKED;
> > @@ -1958,10 +1985,16 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_=
fault *vmf)
> >       up_read(&BTRFS_I(inode)->i_mmap_lock);
> >   out:
> >       btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
> > -     btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_=
start,
> > -                                  reserved_space, true);
> > +     if (only_release_metadata)
> > +             btrfs_delalloc_release_metadata(BTRFS_I(inode), reserved_=
space, true);
> > +     else
> > +             btrfs_delalloc_release_space(BTRFS_I(inode), data_reserve=
d,
> > +                                          page_start, reserved_space, =
true);
> >       extent_changeset_free(data_reserved);
> >   out_noreserve:
> > +     if (only_release_metadata)
> > +             btrfs_check_nocow_unlock(BTRFS_I(inode));
> > +
> >       sb_end_pagefault(inode->i_sb);
> >
> >       if (ret < 0)
>

