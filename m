Return-Path: <linux-btrfs+bounces-5503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8459C8FF269
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B041C2582F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BED1991C4;
	Thu,  6 Jun 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aka/u0eG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952F198E99
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690984; cv=none; b=NTdpeJICkODMcu07eyUgp4uxlV+8opknn/BPz6DF17Jlf4vxM3H+oOf0MZG0OwlEd8WtXd7DBLCLqLdABnXQGvBwfj1VjFVU9Y1mlattQ/Y8/W01AjjsOLFZ3CaJum0+GEjyWIAbSLSCWJ3X60tBoOsfqjXa9NMbviqD7q9zZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690984; c=relaxed/simple;
	bh=IjmOyGouiQKWSlz7a/yiSEFeSrJMdl8i4oF2FCi58XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHuGre+rtRD2F4Yy937pEAin0wrA3GSMIoctiqRkwI/ayfXE187B+iKyMyDjfwzrDGxQ0dfRJ4sJewID6hjWMTaf/MHVrxqLX1MnJFpqipXdln7K3eF6gl0oLbZ1vP1V1jikVrXcJw34cAQExdWTphNoMya8tI+VeV76D53AMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aka/u0eG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E641C32782
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717690984;
	bh=IjmOyGouiQKWSlz7a/yiSEFeSrJMdl8i4oF2FCi58XU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Aka/u0eGPQq7Qn+IsqUwNJqRfCY3ILxBsg4e0xwpxZJwkg2D2M1T1PXbe2jv29e0L
	 ueOvmMHG+lCGDEPKPZfU0qUvK1tOZpLlFUBFOpOiFd0wh2bcJPgAcO0HoxCxUdFyk7
	 EtF4u7qgX/TxN7CsV0hKyJh97xlA2WgsexOGsdp0O+t9bARWiS/+nruiMgOcPi/aM3
	 alst1+GUWR9oVUncIpjZKisE9FIe5y8xmoCePCMz6owDGIoNVJJP6HukY0fmQqWyVn
	 Km8tpK7g29KC5y7LpXk6nauqWS6GF9LkLyII/fhVLX3WNY7g6ol0kMiXjdj2iPy4l6
	 rZiERArVsOIRw==
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6afc61f9a2eso9250686d6.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 09:23:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YwXVkiuBmu0VpWoIb/lJ0D0RtUiDcrKAPHgZIc/XxLVIamRm/b0
	Lt4BWabTrJiLYKDURGY54Pyxyo10xODGTCAuo8jDJkY5lcB0gAbDlnRalMyp1Q0IBWkcsuE56cz
	UMx7O+wBhYIhrqYjV4zLRjbisIt0=
X-Google-Smtp-Source: AGHT+IGaVTZQSdv01EpD7qrWhGTjYeD0Lnv/G7qOyXKKW4FHtVGhDN03/HPwk6ISg8Hyu7roJKv4YtApTICU8yuqJws=
X-Received: by 2002:a05:6214:3382:b0:6af:4184:c368 with SMTP id
 6a1803df08f44-6b05955b93amr2427356d6.16.1717690983097; Thu, 06 Jun 2024
 09:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f003d96bcb54c9c1afd5512739645bbdddb701b.1717637062.git.wqu@suse.com>
In-Reply-To: <0f003d96bcb54c9c1afd5512739645bbdddb701b.1717637062.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 6 Jun 2024 17:22:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Gd2Uh=0FaWdNt0FgVmm3P99LfG-+Tf_qgCkqgsjjJsA@mail.gmail.com>
Message-ID: <CAL3q7H5Gd2Uh=0FaWdNt0FgVmm3P99LfG-+Tf_qgCkqgsjjJsA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix a possible race window when allocating new
 extent buffers
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Chris Mason <clm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 2:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Since v6.8 there are rare kernel crashes hitting by different reporters,
> and most of them share the same bad page status error messages like
> this:
>
>  BUG: Bad page state in process kswapd0  pfn:d6e840
>  page: refcount:0 mapcount:0 mapping:000000007512f4f2 index:0x2796c2c7c
>  pfn:0xd6e840
>  aops:btree_aops ino:1
>  flags: 0x17ffffe0000008(uptodate|node=3D0|zone=3D2|lastcpupid=3D0x3fffff=
)
>  page_type: 0xffffffff()
>  raw: 0017ffffe0000008 dead000000000100 dead000000000122 ffff88826d0be4c0
>  raw: 00000002796c2c7c 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: non-NULL mapping
>
> [CAUSE]
> Commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method") changes the sequence when allocating a new
> extent buffer.
>
> Previously we always call grab_extent_buffer() under
> mapping->i_private_lock, to ensure the safety on modification on
> folio::private (which is a pointer to extent buffer for regular
> sectorsize)
>
> This can lead to the following race:
>
> Thread A is trying to allocate an extent buffer at bytenr X, with 4
> 4K pages, meanwhile thread B is trying to release the page at X + 4K
> (the second page of the extent buffer at X).
>
>            Thread A                |                 Thread B
> -----------------------------------+-------------------------------------
>                                    | btree_release_folio()
>                                    | | This is for the page at X + 4K,
>                                    | | Not page X.
>                                    | |
> alloc_extent_buffer()              | |- release_extent_buffer()
> |- filemap_add_folio() for the     | |  |- atomic_dec_and_test(eb->refs)
> |  page at bytenr X (the first     | |  |
> |  page).                          | |  |
> |  Which returned -EEXIST.         | |  |
> |                                  | |  |
> |- filemap_lock_folio()            | |  |
> |  Returned the first page locked. | |  |
> |                                  | |  |
> |- grab_extent_buffer()            | |  |
> |  |- atomic_inc_not_zero()        | |  |
> |  |  Returned false               | |  |
> |  |- folio_detach_private()       | |  |- folio_detach_private() for X
> |     |- folio_test_private()      | |     |- folio_test_private()
>       |  Returned true             | |     |  Returned true
>       |- folio_put()               |       |- folio_put()
>
> Now this double puts on the same folio at folio X, leads to the
> refcount underflow of the folio X, and eventually causing the BUG_ON()
> on the page->mapping.
>
> The condition is not that easy to hit:
>
> - The release must be triggered for the middle page of an eb
>   If the release is on the same first page of an eb, page lock would kick
>   in and prevent the race.
>
> - folio_detach_private() has a very small race window
>   It's only between folio_test_private() and folio_clear_private().
>
> That's exactly what mapping->i_private_lock is used to prevent such race,
> and commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method") totally screwed this up.
>
> At that time, I thought the page lock would kick in as
> filemap_release_folio() also requires the page to be locked, but forgot
> the filemap_release_folio() only locks one page, not all pages of an
> extent buffer.
>
> [FIX]
> Move all the code requiring i_private_lock into
> attach_eb_folio_to_filemap(), so that everything is done with proper
> lock protection.
>
> Furthermore to prevent future problems, add an extra
> lockdep_assert_locked() to ensure we're holding the proper lock.
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/linux-btrfs/CAHk-=3Dwgt362nGfScVOOii8cgKn2L=
VVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com/
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Link: https://lore.kernel.org/lkml/CABXGCsPktcHQOvKTbPaTwegMExije=3DGpgci=
5NW=3DhqORo-s7diA@mail.gmail.com/
> Fixes: 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-t=
hen-attach method")
> Cc: Chris Mason <clm@fb.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Changelog:
> v2:
> - With the help of Chris Mason, it's now clear where and how the race
>   happened
>
> - Fix a bug that @existing_folio is not properly cleaned up
>   Which can easily crash the kernel if filemap_lock_folio() returned
>   -EINVAL.
>
> v1:
> - Remove the analyze on the race window
>   It turns out all that the allocation part (filemap_lock_folio() in
>   alloc_extent_buffer()) and the folio release part
>   (filemap_release_folio()) all require the folio to be locked.
>   Thus it's impossible to race between eb allocation and release.
>
> - Add extra lockdep_assert_hold() for grab_extent_buffer()
>
> =E5=85=89=E6=98=AF=E9=95=9C=E7=89=87=E5=B0=B1=E8=A6=81500.=E3=80=82=E3=80=
=82=E3=80=82
> -=E7=9B=B8=E6=AF=94=E4=B9=8B=E4=B8=8B=E9=AA=8C=E5=85=89=E5=92=8C=E7=AD=90=
=E5=AD=90=E7=AE=80=E7=9B=B4=E4=B8=8D=E8=A6=81=E9=92=B1-
> ---
>  fs/btrfs/extent_io.c | 59 ++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 0c74f7df2e8b..af5b7fa7da99 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2913,6 +2913,8 @@ static struct extent_buffer *grab_extent_buffer(
>         struct folio *folio =3D page_folio(page);
>         struct extent_buffer *exists;
>
> +       lockdep_assert_held(&page->mapping->i_private_lock);
> +
>         /*
>          * For subpage case, we completely rely on radix tree to ensure w=
e
>          * don't try to insert two ebs for the same bytenr.  So here we a=
lways
> @@ -2980,13 +2982,14 @@ static int check_eb_alignment(struct btrfs_fs_inf=
o *fs_info, u64 start)
>   * The caller needs to free the existing folios and retry using the same=
 order.
>   */
>  static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
> +                                     struct btrfs_subpage *prealloc,
>                                       struct extent_buffer **found_eb_ret=
)
>  {
>
>         struct btrfs_fs_info *fs_info =3D eb->fs_info;
>         struct address_space *mapping =3D fs_info->btree_inode->i_mapping=
;
>         const unsigned long index =3D eb->start >> PAGE_SHIFT;
> -       struct folio *existing_folio;
> +       struct folio *existing_folio =3D NULL;
>         int ret;
>
>         ASSERT(found_eb_ret);
> @@ -2998,12 +3001,14 @@ static int attach_eb_folio_to_filemap(struct exte=
nt_buffer *eb, int i,
>         ret =3D filemap_add_folio(mapping, eb->folios[i], index + i,
>                                 GFP_NOFS | __GFP_NOFAIL);
>         if (!ret)
> -               return 0;
> +               goto finish;
>
>         existing_folio =3D filemap_lock_folio(mapping, index + i);
>         /* The page cache only exists for a very short time, just retry. =
*/
> -       if (IS_ERR(existing_folio))
> +       if (IS_ERR(existing_folio)) {
> +               existing_folio =3D NULL;
>                 goto retry;
> +       }
>
>         /* For now, we should only have single-page folios for btree inod=
e. */
>         ASSERT(folio_nr_pages(existing_folio) =3D=3D 1);
> @@ -3014,14 +3019,16 @@ static int attach_eb_folio_to_filemap(struct exte=
nt_buffer *eb, int i,
>                 return -EAGAIN;
>         }
>
> -       if (fs_info->nodesize < PAGE_SIZE) {
> +finish:
> +       spin_lock(&mapping->i_private_lock);
> +       if (existing_folio && fs_info->nodesize < PAGE_SIZE) {
>                 /*
> -                * We're going to reuse the existing page, can drop our p=
age
> -                * and subpage structure now.
> +                * We're going to reuse the existing page, can drop our f=
olio
> +                * now.
>                  */
>                 __free_page(folio_page(eb->folios[i], 0));
>                 eb->folios[i] =3D existing_folio;
> -       } else {
> +       } else if (existing_folio) {
>                 struct extent_buffer *existing_eb;
>
>                 existing_eb =3D grab_extent_buffer(fs_info,
> @@ -3029,6 +3036,7 @@ static int attach_eb_folio_to_filemap(struct extent=
_buffer *eb, int i,
>                 if (existing_eb) {
>                         /* The extent buffer still exists, we can use it =
directly. */
>                         *found_eb_ret =3D existing_eb;
> +                       spin_unlock(&mapping->i_private_lock);
>                         folio_unlock(existing_folio);
>                         folio_put(existing_folio);
>                         return 1;
> @@ -3037,6 +3045,22 @@ static int attach_eb_folio_to_filemap(struct exten=
t_buffer *eb, int i,
>                 __free_page(folio_page(eb->folios[i], 0));
>                 eb->folios[i] =3D existing_folio;
>         }
> +       eb->folio_size =3D folio_size(eb->folios[i]);
> +       eb->folio_shift =3D folio_shift(eb->folios[i]);
> +       /* Should not fail, as we have preallocated the memory */
> +       ret =3D attach_extent_buffer_folio(eb, eb->folios[i], prealloc);
> +       ASSERT(!ret);
> +       /*
> +        * To inform we have extra eb under allocation, so that
> +        * detach_extent_buffer_page() won't release the folio private
> +        * when the eb hasn't yet been inserted into radix tree.
> +        *
> +        * The ref will be decreased when the eb released the page, in
> +        * detach_extent_buffer_page().
> +        * Thus needs no special handling in error path.
> +        */
> +       btrfs_folio_inc_eb_refs(fs_info, eb->folios[i]);
> +       spin_unlock(&mapping->i_private_lock);
>         return 0;
>  }
>
> @@ -3048,7 +3072,6 @@ struct extent_buffer *alloc_extent_buffer(struct bt=
rfs_fs_info *fs_info,
>         int attached =3D 0;
>         struct extent_buffer *eb;
>         struct extent_buffer *existing_eb =3D NULL;
> -       struct address_space *mapping =3D fs_info->btree_inode->i_mapping=
;
>         struct btrfs_subpage *prealloc =3D NULL;
>         u64 lockdep_owner =3D owner_root;
>         bool page_contig =3D true;
> @@ -3114,7 +3137,7 @@ struct extent_buffer *alloc_extent_buffer(struct bt=
rfs_fs_info *fs_info,
>         for (int i =3D 0; i < num_folios; i++) {
>                 struct folio *folio;
>
> -               ret =3D attach_eb_folio_to_filemap(eb, i, &existing_eb);
> +               ret =3D attach_eb_folio_to_filemap(eb, i, prealloc, &exis=
ting_eb);
>                 if (ret > 0) {
>                         ASSERT(existing_eb);
>                         goto out;
> @@ -3151,24 +3174,6 @@ struct extent_buffer *alloc_extent_buffer(struct b=
trfs_fs_info *fs_info,
>                  * and free the allocated page.
>                  */
>                 folio =3D eb->folios[i];
> -               eb->folio_size =3D folio_size(folio);
> -               eb->folio_shift =3D folio_shift(folio);
> -               spin_lock(&mapping->i_private_lock);
> -               /* Should not fail, as we have preallocated the memory */
> -               ret =3D attach_extent_buffer_folio(eb, folio, prealloc);
> -               ASSERT(!ret);
> -               /*
> -                * To inform we have extra eb under allocation, so that
> -                * detach_extent_buffer_page() won't release the folio pr=
ivate
> -                * when the eb hasn't yet been inserted into radix tree.
> -                *
> -                * The ref will be decreased when the eb released the pag=
e, in
> -                * detach_extent_buffer_page().
> -                * Thus needs no special handling in error path.
> -                */
> -               btrfs_folio_inc_eb_refs(fs_info, folio);
> -               spin_unlock(&mapping->i_private_lock);
> -
>                 WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->start,=
 eb->len));
>
>                 /*
> --
> 2.45.2
>
>

