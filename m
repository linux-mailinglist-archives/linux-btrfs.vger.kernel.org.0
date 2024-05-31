Return-Path: <linux-btrfs+bounces-5377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2B58D61C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3411B1F281D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C915886A;
	Fri, 31 May 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYXJjDM3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1218158859
	for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158722; cv=none; b=q9rCDItrEwjrW9JGIr3w6op5Jrm9hk/vRLorBKkfF5cnv3EcxRp8LPAckRr7GqUSpnbfuFZH34eleROicTpQbHkN/JyCFO9GM8XOAE67jO1e6osEcx+DZeLckuvzd8JvEmg9E0Rcyw/ebEnSadc85DANpWQnPdT62OMdR1MI0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158722; c=relaxed/simple;
	bh=4ito5rsdl/uQjs9uSctfEoNaW/LM+DtIzTQScKh41d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvfKNW4ODZwSz9pSmwLhpEQzlOOQ5Fhz7kwu4Q3qufMEVY8IUGrfTvciXlICZqMxD1P8Y+c41X2H7gc4uBGZ5+1UlMJZ+K0A3Ryw6LhIpL+Tfb7IVUBIh74ivElzwXiXa81vPiPsLTIlB29jznP2tRKuJpAA+THBdb9QvGl9BKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYXJjDM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C689C32781
	for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158721;
	bh=4ito5rsdl/uQjs9uSctfEoNaW/LM+DtIzTQScKh41d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iYXJjDM3pvHf4CNh/SlwRRKrT5+Xs5EBJHNa32gT2D6LjpKRc1e/7qxRxSM8Pz5ni
	 6FWv09DlBcOg5yi+SoNSnWQ59ggChiHdFmzp0f4XsziypRmCQ30kzEllCcjQ7SznKZ
	 FOUE1kK8ujM8vDCGY60bUoqYLCS+xnJKE5lgObUnnRpKtoHlST7FmxSLkJH6MgC25S
	 Qvnj+asNZRW0nBixk9iGhfUE65FfsV4ngTUPUOWs7IyYNW7rnQu6wnIlHF92BMrvVX
	 oFpCCnQZLgTDuoPfUlW1htXR4K71Q8C6rvJlyTkg8BfFw+sYhu4XkqzB0hoQXcwYhs
	 Jza+CvLfSDxfQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a352bbd9so318203166b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 05:32:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YxdCtOovfhVXgWNI2RrQjpq+sJMsO5WTalADlsUSoXwjD0kxZcL
	V6DMzyb/8jWfmsGTCTYJQdR0UzUqK95JchZ3pHr1QnQLdi8QObZIHDYrzaHKaIgzo3rpqPZVfVh
	oFPS7imcpceUO3if5SzPGI/s5B/g=
X-Google-Smtp-Source: AGHT+IEWHfL0wuMEkR4CV+hxTz7Tw+mZFZlLMmJ0TBM+eQWOqjPV0AH3WvPxFrdKpzGZEuRDAJMELWMLjBGEvfR4MSE=
X-Received: by 2002:a17:906:4313:b0:a61:7f85:e31c with SMTP id
 a640c23a62f3a-a6818c46ef7mr151888166b.12.1717158720060; Fri, 31 May 2024
 05:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b2192936067ea7e82e7d5958c0aa6baf8c29b5d9.1717130599.git.wqu@suse.com>
 <CAL3q7H6BBU9s40MwhrVtJt-=XJHceKMS0vrh6Hey3Nre15ONNA@mail.gmail.com>
In-Reply-To: <CAL3q7H6BBU9s40MwhrVtJt-=XJHceKMS0vrh6Hey3Nre15ONNA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 31 May 2024 13:31:23 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4m8carjoZ9zw9N_XUD=sQbW293prokno4nebP4hnX_dw@mail.gmail.com>
Message-ID: <CAL3q7H4m8carjoZ9zw9N_XUD=sQbW293prokno4nebP4hnX_dw@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: fix a possible race window when allocating new
 extent buffers
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:44=E2=80=AFAM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Fri, May 31, 2024 at 5:44=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >
> > [POSSIBLE RACE]
> > Commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
> > allocate-then-attach method") changes the sequence when allocating a ne=
w
> > extent buffer.
> >
> > Previously we always call grab_extent_buffer() under
> > mapping->i_private_lock, thus there is no chance for race to happen
> > between extent buffer releasing and allocating.
> >
> > However that commit changed the behavior to call grab_extent_buffer()
> > without holding that lock, making the following race possible:
> >
> >             Thread A            |          Thread B
> >  -------------------------------+----------------------------------
> >                                 | btree_release_folio()
> >                                 | |- btrfs_release_extent_buffer_pages(=
)
> >  attach_eb_folio_to_filemap()   | |  |- detach_extent_buffer_folio()
> >  |                              | \- return 1 so that this folio would =
be
> >  |                              |    released from page cache
> >  |-grab_extent_buffer()         |
> >  | Now it returns no eb, we can |
> >  | reuse the folio              |
>
> So I don't understand this, there's something missing.
>
> btrfs_release_extent_buffer_pages(), when called in the
> btree_release_folio() path (by release_extent_buffer()), is only
> called under an:
>
> if (atomic_dec_and_test(&eb->refs)) {
>
> So the extent buffer's ref count is 0 when
> btrfs_release_extent_buffer_pages() is called.
>
> And then at grab_extent_buffer() we have:
>
> if (atomic_inc_not_zero(&exists->refs)) {
>
> So we can never pick up an extent buffer with a ref count of 0.
>
> Did I miss something?

Oh never mind, the problem is not getting the extent buffer but a
folio used by the extent buffer being freed.

And with this change doing the locking of i_private_lock at
attach_eb_folio_to_filemap() serializes with
detach_extent_buffer_folio().
That makes sense and it's indeed a valid race, that leaves the eb
pointing to a folio for which we didn't bump the reference count
appropriately.

So:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Thanks.
>
>
> >
> > This would make the newly allocated extent buffer to point to a soon to
> > be freed folio.
> > The problem is not immediately triggered, as the we still hold one extr=
a
> > folio refcount from thread A.
> >
> > But later mostly at extent buffer release, if we put the last refcount
> > of the folio (only hold by ourselves), then we can hit various problems=
.
> >
> > The most common one is the bad folio status:
> >
> >  BUG: Bad page state in process kswapd0  pfn:d6e840
> >  page: refcount:0 mapcount:0 mapping:000000007512f4f2 index:0x2796c2c7c
> >  pfn:0xd6e840
> >  aops:btree_aops ino:1
> >  flags: 0x17ffffe0000008(uptodate|node=3D0|zone=3D2|lastcpupid=3D0x3fff=
ff)
> >  page_type: 0xffffffff()
> >  raw: 0017ffffe0000008 dead000000000100 dead000000000122 ffff88826d0be4=
c0
> >  raw: 00000002796c2c7c 0000000000000000 00000000ffffffff 00000000000000=
00
> >  page dumped because: non-NULL mapping
> >
> > [FIX]
> > Move all the code requiring i_private_lock into
> > attach_eb_folio_to_filemap(), so that everything is done with proper
> > lock protection.
> >
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Link: https://lore.kernel.org/linux-btrfs/CAHk-=3Dwgt362nGfScVOOii8cgKn=
2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com/
> > Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> > Link: https://lore.kernel.org/lkml/CABXGCsPktcHQOvKTbPaTwegMExije=3DGpg=
ci5NW=3DhqORo-s7diA@mail.gmail.com/
> > Fixes: 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate=
-then-attach method")
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > Reason for RFC:
> >
> > I do not have a reliable enough way to reproduce the bug, nor enough
> > confidence on the btree_release_folio() race.
> >
> > But so far this is the most sounding possibility, any extra testing
> > would be appreciated.
> > ---
> >  fs/btrfs/extent_io.c | 53 ++++++++++++++++++++++----------------------
> >  1 file changed, 27 insertions(+), 26 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 0c74f7df2e8b..86d2714018a4 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2980,13 +2980,14 @@ static int check_eb_alignment(struct btrfs_fs_i=
nfo *fs_info, u64 start)
> >   * The caller needs to free the existing folios and retry using the sa=
me order.
> >   */
> >  static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
> > +                                     struct btrfs_subpage *prealloc,
> >                                       struct extent_buffer **found_eb_r=
et)
> >  {
> >
> >         struct btrfs_fs_info *fs_info =3D eb->fs_info;
> >         struct address_space *mapping =3D fs_info->btree_inode->i_mappi=
ng;
> >         const unsigned long index =3D eb->start >> PAGE_SHIFT;
> > -       struct folio *existing_folio;
> > +       struct folio *existing_folio =3D NULL;
> >         int ret;
> >
> >         ASSERT(found_eb_ret);
> > @@ -2998,7 +2999,7 @@ static int attach_eb_folio_to_filemap(struct exte=
nt_buffer *eb, int i,
> >         ret =3D filemap_add_folio(mapping, eb->folios[i], index + i,
> >                                 GFP_NOFS | __GFP_NOFAIL);
> >         if (!ret)
> > -               return 0;
> > +               goto finish;
> >
> >         existing_folio =3D filemap_lock_folio(mapping, index + i);
> >         /* The page cache only exists for a very short time, just retry=
. */
> > @@ -3014,14 +3015,16 @@ static int attach_eb_folio_to_filemap(struct ex=
tent_buffer *eb, int i,
> >                 return -EAGAIN;
> >         }
> >
> > -       if (fs_info->nodesize < PAGE_SIZE) {
> > +finish:
> > +       spin_lock(&mapping->i_private_lock);
> > +       if (existing_folio && fs_info->nodesize < PAGE_SIZE) {
> >                 /*
> > -                * We're going to reuse the existing page, can drop our=
 page
> > -                * and subpage structure now.
> > +                * We're going to reuse the existing page, can drop our=
 folio
> > +                * now.
> >                  */
> >                 __free_page(folio_page(eb->folios[i], 0));
> >                 eb->folios[i] =3D existing_folio;
> > -       } else {
> > +       } else if (existing_folio) {
> >                 struct extent_buffer *existing_eb;
> >
> >                 existing_eb =3D grab_extent_buffer(fs_info,
> > @@ -3029,6 +3032,7 @@ static int attach_eb_folio_to_filemap(struct exte=
nt_buffer *eb, int i,
> >                 if (existing_eb) {
> >                         /* The extent buffer still exists, we can use i=
t directly. */
> >                         *found_eb_ret =3D existing_eb;
> > +                       spin_unlock(&mapping->i_private_lock);
> >                         folio_unlock(existing_folio);
> >                         folio_put(existing_folio);
> >                         return 1;
> > @@ -3037,6 +3041,22 @@ static int attach_eb_folio_to_filemap(struct ext=
ent_buffer *eb, int i,
> >                 __free_page(folio_page(eb->folios[i], 0));
> >                 eb->folios[i] =3D existing_folio;
> >         }
> > +       eb->folio_size =3D folio_size(eb->folios[i]);
> > +       eb->folio_shift =3D folio_shift(eb->folios[i]);
> > +       /* Should not fail, as we have preallocated the memory */
> > +       ret =3D attach_extent_buffer_folio(eb, eb->folios[i], prealloc)=
;
> > +       ASSERT(!ret);
> > +       /*
> > +        * To inform we have extra eb under allocation, so that
> > +        * detach_extent_buffer_page() won't release the folio private
> > +        * when the eb hasn't yet been inserted into radix tree.
> > +        *
> > +        * The ref will be decreased when the eb released the page, in
> > +        * detach_extent_buffer_page().
> > +        * Thus needs no special handling in error path.
> > +        */
> > +       btrfs_folio_inc_eb_refs(fs_info, eb->folios[i]);
> > +       spin_unlock(&mapping->i_private_lock);
> >         return 0;
> >  }
> >
> > @@ -3048,7 +3068,6 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
> >         int attached =3D 0;
> >         struct extent_buffer *eb;
> >         struct extent_buffer *existing_eb =3D NULL;
> > -       struct address_space *mapping =3D fs_info->btree_inode->i_mappi=
ng;
> >         struct btrfs_subpage *prealloc =3D NULL;
> >         u64 lockdep_owner =3D owner_root;
> >         bool page_contig =3D true;
> > @@ -3114,7 +3133,7 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
> >         for (int i =3D 0; i < num_folios; i++) {
> >                 struct folio *folio;
> >
> > -               ret =3D attach_eb_folio_to_filemap(eb, i, &existing_eb)=
;
> > +               ret =3D attach_eb_folio_to_filemap(eb, i, prealloc, &ex=
isting_eb);
> >                 if (ret > 0) {
> >                         ASSERT(existing_eb);
> >                         goto out;
> > @@ -3151,24 +3170,6 @@ struct extent_buffer *alloc_extent_buffer(struct=
 btrfs_fs_info *fs_info,
> >                  * and free the allocated page.
> >                  */
> >                 folio =3D eb->folios[i];
> > -               eb->folio_size =3D folio_size(folio);
> > -               eb->folio_shift =3D folio_shift(folio);
> > -               spin_lock(&mapping->i_private_lock);
> > -               /* Should not fail, as we have preallocated the memory =
*/
> > -               ret =3D attach_extent_buffer_folio(eb, folio, prealloc)=
;
> > -               ASSERT(!ret);
> > -               /*
> > -                * To inform we have extra eb under allocation, so that
> > -                * detach_extent_buffer_page() won't release the folio =
private
> > -                * when the eb hasn't yet been inserted into radix tree=
.
> > -                *
> > -                * The ref will be decreased when the eb released the p=
age, in
> > -                * detach_extent_buffer_page().
> > -                * Thus needs no special handling in error path.
> > -                */
> > -               btrfs_folio_inc_eb_refs(fs_info, folio);
> > -               spin_unlock(&mapping->i_private_lock);
> > -
> >                 WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->star=
t, eb->len));
> >
> >                 /*
> > --
> > 2.45.1
> >
> >

