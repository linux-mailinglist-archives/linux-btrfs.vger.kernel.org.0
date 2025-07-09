Return-Path: <linux-btrfs+bounces-15382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D95AFE604
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 12:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EB53AD762
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C96C28F926;
	Wed,  9 Jul 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5YGAfpx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505112586EA
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057617; cv=none; b=uZqHIL+uxV3ifiRjOWfZh0aS7rxWgzX7Rt5xOcQYBIIfMqDg6PQtRiU9g+6nNhpcNl3MGlrpBhn44yPvSqFdRBUDYTh1cNkxoNQ2mD9Y6/GG7rH0PP9vAUR0ZXHQVZlCsrqvpCYiqHWHrekbrfzbEvVPRbohvbIwMP/iJbq5yaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057617; c=relaxed/simple;
	bh=zUJV8y3Q8UmDycaPrpHfeQVdj6Qd818R2fdKKZjVzZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxIXJlvoaxqImFcQa9T2i0ae/oijQbR07yGaw7NSxP1GYjPwZWrpjyNTmOAXqeYSDlE3d7gkCwaxkQFY/KDbOzzkE6ewjc9Ayv1bAzeK7BC5D8pl7PLrzpNuXqavFI9XAWutPEdKgcyPnZZw5oyNeQXf8nSAeLkuftWorUILBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5YGAfpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80B0C4CEF4
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057613;
	bh=zUJV8y3Q8UmDycaPrpHfeQVdj6Qd818R2fdKKZjVzZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F5YGAfpxaDzLfIYa+HDBzu9Z+gkpK0KW5j0amHlNUkv/u60G47b/WXaSkMO42mRbg
	 wmtPTJA83QLPKtUdtSHKA5t7PSBN7h1gqASUj+q7G0JLkIoGGnYern5ULRPYMNdg4d
	 FrZhdREgG+i+CGXVfIyEW4u6ydbQU0Aaa5S4XVEK7G7dflN0axz1NlMFPPYT+8132f
	 J81dQc9ocXDzHo2rkuYT3wQrwpvVEZCHBDOU/SNHKWtd4YYhhthf28TnCIyMDCD0Ri
	 N+1aqlnE55qCS5ZRima9Ss6SpDRziWZwist2Mz3Y5kix5OfgsZnf+4UDeBzPi9eT7w
	 /W9ybRce9UNOA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so1804074a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Jul 2025 03:40:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YzeNez299t995wkMDczKDoBwq3gq6gksBU8R8w894tl48lpWg0U
	va7rTGDlPaIyGVLLZvmI9Rf4Ns25cXZTL0x929k0BZivD3CqrVbb/ca8cY6w8XA8QG5Kyf/CIbq
	igsle/LgafRm8nwo/ixv+bicdb8iK+jA=
X-Google-Smtp-Source: AGHT+IH38R2MSSvZH7F0ZETX5A7Xc2n+z9M5Zye+W1beZdD+r1k2P+flzryOovN2Gp+/6ye5jEnvvNstI1xovrpRQpU=
X-Received: by 2002:a17:907:c27:b0:acb:37ae:619c with SMTP id
 a640c23a62f3a-ae6d1400663mr220988866b.15.1752057612322; Wed, 09 Jul 2025
 03:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752050704.git.fdmanana@suse.com> <6aefca8792028e0544de96b2d7f5b34ea836d1c7.1752050704.git.fdmanana@suse.com>
 <c10339a8-cb80-4fba-803d-797f51d9313d@gmx.com>
In-Reply-To: <c10339a8-cb80-4fba-803d-797f51d9313d@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 9 Jul 2025 11:39:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7gJG0hrg1ELCiwX4vk0kOHPy2=9cN9jfVkbcEGUL=uOw@mail.gmail.com>
X-Gm-Features: Ac12FXw1lSr0TNP-DtwCkmSYeQ1Rk6OmJuFzEfaicwCrqq8h7--FCBmTWQf8vhs
Message-ID: <CAL3q7H7gJG0hrg1ELCiwX4vk0kOHPy2=9cN9jfVkbcEGUL=uOw@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: use btrfs_inode local variable at btrfs_page_mkwrite()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 11:05=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/7/9 18:23, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Most of the time we want to use the btrfs_inode, so change the local in=
ode
> > variable to be a btrfs_inode instead of a vfs inode, reducing verbosity
> > by eleminating a lot of BTRFS_I() calls.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> [...]
> > -             if (btrfs_check_nocow_lock(BTRFS_I(inode), page_start,
> > -                                        &write_bytes, false) <=3D 0)
> > +             if (btrfs_check_nocow_lock(inode, page_start, &write_byte=
s, false) <=3D 0)
>
> I guess we are no longer limited by 80 chars line limit anymore?

No we aren't, and it shouldn't be news to anyone anymore, it's been
well over a year, maybe two.
I've commented in reviews several times to avoid line splits when the
total length doesn't exceed 80 characters by too much.

>
> What would be the new limit? 100 from checkpatch or something slightly
> lower like 90?

Within reasonability, in this case it's 88 characters and it makes the
code more readable.

Thanks.

>
> Thanks,
> Qu
>
> >                       goto out_noreserve;
> >
> >               if (write_bytes < reserved_space)
> > @@ -1876,11 +1875,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_=
fault *vmf)
> >
> >               only_release_metadata =3D true;
> >       }
> > -     ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), reserved_=
space,
> > +     ret =3D btrfs_delalloc_reserve_metadata(inode, reserved_space,
> >                                             reserved_space, false);
> >       if (ret < 0) {
> >               if (!only_release_metadata)
> > -                     btrfs_free_reserved_data_space(BTRFS_I(inode), da=
ta_reserved,
> > +                     btrfs_free_reserved_data_space(inode, data_reserv=
ed,
> >                                                      page_start, reserv=
ed_space);
> >               goto out_noreserve;
> >       }
> > @@ -1889,11 +1888,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_=
fault *vmf)
> >       if (ret < 0)
> >               goto out;
> >   again:
> > -     down_read(&BTRFS_I(inode)->i_mmap_lock);
> > +     down_read(&inode->i_mmap_lock);
> >       folio_lock(folio);
> > -     size =3D i_size_read(inode);
> > +     size =3D i_size_read(&inode->vfs_inode);
> >
> > -     if ((folio->mapping !=3D inode->i_mapping) ||
> > +     if ((folio->mapping !=3D inode->vfs_inode.i_mapping) ||
> >           (page_start >=3D size)) {
> >               /* Page got truncated out from underneath us. */
> >               goto out_unlock;
> > @@ -1911,11 +1910,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_=
fault *vmf)
> >        * We can't set the delalloc bits if there are pending ordered
> >        * extents.  Drop our locks and wait for them to finish.
> >        */
> > -     ordered =3D btrfs_lookup_ordered_range(BTRFS_I(inode), page_start=
, fsize);
> > +     ordered =3D btrfs_lookup_ordered_range(inode, page_start, fsize);
> >       if (ordered) {
> >               btrfs_unlock_extent(io_tree, page_start, page_end, &cache=
d_state);
> >               folio_unlock(folio);
> > -             up_read(&BTRFS_I(inode)->i_mmap_lock);
> > +             up_read(&inode->i_mmap_lock);
> >               btrfs_start_ordered_extent(ordered);
> >               btrfs_put_ordered_extent(ordered);
> >               goto again;
> > @@ -1926,7 +1925,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fa=
ult *vmf)
> >               if (reserved_space < fsize) {
> >                       end =3D page_start + reserved_space - 1;
> >                       if (!only_release_metadata)
> > -                             btrfs_delalloc_release_space(BTRFS_I(inod=
e),
> > +                             btrfs_delalloc_release_space(inode,
> >                                                            data_reserve=
d, end + 1,
> >                                                            fsize - rese=
rved_space,
> >                                                            true);
> > @@ -1944,8 +1943,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fa=
ult *vmf)
> >                              EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
> >                              EXTENT_DEFRAG, &cached_state);
> >
> > -     ret =3D btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end=
, 0,
> > -                                     &cached_state);
> > +     ret =3D btrfs_set_extent_delalloc(inode, page_start, end, 0, &cac=
hed_state);
> >       if (ret < 0) {
> >               btrfs_unlock_extent(io_tree, page_start, page_end, &cache=
d_state);
> >               goto out_unlock;
> > @@ -1964,38 +1962,38 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_=
fault *vmf)
> >       btrfs_folio_set_dirty(fs_info, folio, page_start, end + 1 - page_=
start);
> >       btrfs_folio_set_uptodate(fs_info, folio, page_start, end + 1 - pa=
ge_start);
> >
> > -     btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
> > +     btrfs_set_inode_last_sub_trans(inode);
> >
> >       if (only_release_metadata)
> >               btrfs_set_extent_bit(io_tree, page_start, end, EXTENT_NOR=
ESERVE,
> >                                    &cached_state);
> >
> >       btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state)=
;
> > -     up_read(&BTRFS_I(inode)->i_mmap_lock);
> > +     up_read(&inode->i_mmap_lock);
> >
> > -     btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
> > +     btrfs_delalloc_release_extents(inode, fsize);
> >       if (only_release_metadata)
> > -             btrfs_check_nocow_unlock(BTRFS_I(inode));
> > -     sb_end_pagefault(inode->i_sb);
> > +             btrfs_check_nocow_unlock(inode);
> > +     sb_end_pagefault(inode->vfs_inode.i_sb);
> >       extent_changeset_free(data_reserved);
> >       return VM_FAULT_LOCKED;
> >
> >   out_unlock:
> >       folio_unlock(folio);
> > -     up_read(&BTRFS_I(inode)->i_mmap_lock);
> > +     up_read(&inode->i_mmap_lock);
> >   out:
> > -     btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
> > +     btrfs_delalloc_release_extents(inode, fsize);
> >       if (only_release_metadata)
> > -             btrfs_delalloc_release_metadata(BTRFS_I(inode), reserved_=
space, true);
> > +             btrfs_delalloc_release_metadata(inode, reserved_space, tr=
ue);
> >       else
> > -             btrfs_delalloc_release_space(BTRFS_I(inode), data_reserve=
d,
> > -                                          page_start, reserved_space, =
true);
> > +             btrfs_delalloc_release_space(inode, data_reserved, page_s=
tart,
> > +                                          reserved_space, true);
> >       extent_changeset_free(data_reserved);
> >   out_noreserve:
> >       if (only_release_metadata)
> > -             btrfs_check_nocow_unlock(BTRFS_I(inode));
> > +             btrfs_check_nocow_unlock(inode);
> >
> > -     sb_end_pagefault(inode->i_sb);
> > +     sb_end_pagefault(inode->vfs_inode.i_sb);
> >
> >       if (ret < 0)
> >               return vmf_error(ret);
>

