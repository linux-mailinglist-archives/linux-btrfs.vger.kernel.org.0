Return-Path: <linux-btrfs+bounces-13159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A401A93628
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 12:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE99F8A4828
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 10:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D451270ECF;
	Fri, 18 Apr 2025 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKpiMPzW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708511FC0ED
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744973429; cv=none; b=mxFHoIy/c2Dv5fL9eLsChqTRbEOS8gETstEJZV15VT1Abk9p4/5qriFFZxY1w3ULJBus01suMKQ/BEHsNKv/9K3Xs4sY3dvy67q7HW+Fhjdlc3aCfFJUdRRvH1OIPZTd+YeFN3aZLD5mjSBMDathd8SjZBK2lLVFW3PHjYp4W1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744973429; c=relaxed/simple;
	bh=EAvBV/enYUKARNFu0EcTCvN3wB9OR5j9IffrRxRnhcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdbfYIw4xHeBPNT1Q0yGUbL/A3tiwwPNlS88ik13OIO6wocmxRKW2Q/VQdyF19ShNMRQQXzNvQIm2quaP0dyIJ+RYDDdeJ3e45dMoqli+XWBHoYVz1WKHBVTLcHhNDO77CX47GTbyU/X5Z7xHBWuouD43SRbDd/cg4yckjP3cQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKpiMPzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE58C4CEE7
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744973428;
	bh=EAvBV/enYUKARNFu0EcTCvN3wB9OR5j9IffrRxRnhcw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GKpiMPzWvbPylCAKhrmK1REdaTQKmI5R8onCXbfdMNHYm79oR09kHs2jYTZyQgF7o
	 OCEV0fLfYWvN4I31831RR3OvClKkh6Bs34TVMf/Yl9Y1dFJbdPYmuy78Czde3P4laD
	 iWEM4kZJn3Qzh+kBWKtQC+gG1ymQ+rPJA/soIqFcCBEpapNahqA/ruJ5XV+w4AH5N5
	 7DCXjEU/jkmrf/KxwDBcEP9yGOI7ePVlZdi+vqWFkOyGBoOXZ4xxibI36N62o7XiI0
	 I4kgOSyS0in0rDlmLK8pm+ItJfKzu3SxX6bORAMYyUP26sMB/ACfC0MGOqstnsd+AH
	 l3KX+YAWdRYFQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abbd96bef64so285629266b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 03:50:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMgYlP+zznHGKUjmzCArSQnXC9hgtw5fofCNTG9e5nmh65MEinY6HbG80CGDoabPkshdeoUyT+sMhgrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy18Ofo5B3NJ0ByZVl/f4KjgDVxqj4C/OEwIEqsjBMKyE9AfLeV
	3+QIXfa1r6HsmD1MBqaExtWjusxulUffB4HfDrP/JhJ05Zv15rAcazxosWLHv4Or7ha7vLszfOt
	2MAk8Z7VpNUoxlDdPAedxRdN0Q84=
X-Google-Smtp-Source: AGHT+IG4W88Rhcn3IR1tJc9rS2QNG5YY+jQH/ifX4CJWonZEVNb/B8iFwTXZtdETmQsbxUbjgim6zADp10k8curVK3c=
X-Received: by 2002:a17:906:fe05:b0:ac7:efed:3ab with SMTP id
 a640c23a62f3a-acb74b364e0mr217516066b.21.1744973427364; Fri, 18 Apr 2025
 03:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5a3cbb2f51851dc55ff51647a214f912d6d5043.1744931654.git.boris@bur.io>
 <CAPjX3Fc9YAmfKGdNrQK=Zsv6NVERUnK9Fxg=7Z4vCBrimEjyVg@mail.gmail.com>
In-Reply-To: <CAPjX3Fc9YAmfKGdNrQK=Zsv6NVERUnK9Fxg=7Z4vCBrimEjyVg@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 18 Apr 2025 11:49:50 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7JAeT3C_+SULVRdZA6XsnHpoZD_je6dEKzj+K53KVgWg@mail.gmail.com>
X-Gm-Features: ATxdqUGwUPH31E4ytmdI6NKkISqGZ0gVmvz2z_rPFd8nMyag1rVSe2EmVe1YhCM
Message-ID: <CAL3q7H7JAeT3C_+SULVRdZA6XsnHpoZD_je6dEKzj+K53KVgWg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix broken drop_caches on extent_buffer folios
To: Daniel Vacek <neelx@suse.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 10:24=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrot=
e:
>
> On Fri, 18 Apr 2025 at 01:15, Boris Burkov <boris@bur.io> wrote:
> >
> > The (correct) commit
> > e41c81d0d30e ("mm/truncate: Replace page_mapped() call in invalidate_in=
ode_page()")
> > replaced the page_mapped(page) check with a refcount check. However,
> > this refcount check does not work as expected with drop_caches for
> > btrfs's metadata pages.
> >
> > Btrfs has a per-sb metadata inode with cached pages, and when not in
> > active use by btrfs, they have a refcount of 3. One from the initial
> > call to alloc_pages, one (nr_pages =3D=3D 1) from filemap_add_folio, an=
d one
> > from folio_attach_private. We would expect such pages to get dropped by
> > drop_caches. However, drop_caches calls into mapping_evict_folio via
> > mapping_try_invalidate which gets a reference on the folio with
> > find_lock_entries(). As a result, these pages have a refcount of 4, and
> > fail this check.
> >
> > For what it's worth, such pages do get reclaimed under memory pressure,
> > so I would say that while this behavior is surprising, it is not really
> > dangerously broken.
> >
> > When I asked the mm folks about the expected refcount in this case, I
> > was told that the correct thing to do is to donate the refcount from th=
e
> > original allocation to the page cache after inserting it.
> > https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/
> >
> > Therefore, attempt to fix this by adding a put_folio() to the critical
> > spot in alloc_extent_buffer where we are sure that we have really
> > allocated and attached new pages. We must also adjust
> > folio_detach_private to properly handle being the last reference to the
> > folio and not do a UAF after folio_detach_private().
> >
> > Finally, extent_buffers allocated by clone_extent_buffer() and
> > alloc_dummy_extent_buffer() are unmapped, so this transfer of ownership
> > from allocation to insertion in the mapping does not apply to them.
> > Therefore, they still need a folio_put() as before.
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v2:
> > * Used Filipe's suggestion to simplify detach_extent_buffer_folio and
> >   lose the extra folio_get()/folio_put() pair
> > * Noticed a memory leak causing failures in fstests on smaller vms.
> >   Fixed a bug where I was missing a folio_put() for ebs that never got
> >   their folios added to the mapping.
> >
> >  fs/btrfs/extent_io.c | 28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 5f08615b334f..90499124b8a5 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2752,6 +2752,7 @@ static bool folio_range_has_eb(struct folio *foli=
o)
> >  static void detach_extent_buffer_folio(const struct extent_buffer *eb,=
 struct folio *folio)
> >  {
> >         struct btrfs_fs_info *fs_info =3D eb->fs_info;
> > +       struct address_space *mapping =3D folio->mapping;
> >         const bool mapped =3D !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bf=
lags);
> >
> >         /*
> > @@ -2759,11 +2760,11 @@ static void detach_extent_buffer_folio(const st=
ruct extent_buffer *eb, struct fo
> >          * be done under the i_private_lock.
> >          */
> >         if (mapped)
> > -               spin_lock(&folio->mapping->i_private_lock);
> > +               spin_lock(&mapping->i_private_lock);
> >
> >         if (!folio_test_private(folio)) {
> >                 if (mapped)
> > -                       spin_unlock(&folio->mapping->i_private_lock);
> > +                       spin_unlock(&mapping->i_private_lock);
> >                 return;
> >         }
> >
> > @@ -2783,7 +2784,7 @@ static void detach_extent_buffer_folio(const stru=
ct extent_buffer *eb, struct fo
> >                         folio_detach_private(folio);
> >                 }
> >                 if (mapped)
> > -                       spin_unlock(&folio->mapping->i_private_lock);
> > +                       spin_unlock(&mapping->i_private_lock);
> >                 return;
> >         }
> >
> > @@ -2806,7 +2807,7 @@ static void detach_extent_buffer_folio(const stru=
ct extent_buffer *eb, struct fo
> >         if (!folio_range_has_eb(folio))
> >                 btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_META=
DATA);
> >
> > -       spin_unlock(&folio->mapping->i_private_lock);
> > +       spin_unlock(&mapping->i_private_lock);
> >  }
> >
> >  /* Release all folios attached to the extent buffer */
> > @@ -2821,9 +2822,13 @@ static void btrfs_release_extent_buffer_folios(c=
onst struct extent_buffer *eb)
> >                         continue;
> >
> >                 detach_extent_buffer_folio(eb, folio);
> > -
> > -               /* One for when we allocated the folio. */
> > -               folio_put(folio);
>
> So far so good, but...
>
> > +               /*
> > +                * We only release the allocated refcount for mapped ex=
tent_buffer
> > +                * folios. If the folio is unmapped, we have to release=
 its allocated
> > +                * refcount here.
> > +                */
> > +               if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))
> > +                       folio_put(folio);
>
> ...is this really correct? I'd do rather this instead:

Yes, it is correct. It does deal with cloned extent buffers, where we
need the extra put since we didn't do it after attaching the folio to
it.
Alternatively we could probably do the put after the attach at
btrfs_clone_extent_buffer(), just like for regular extent buffers, and
get rid of this special casing.

>
> @@ -3393,22 +3393,21 @@ struct extent_buffer
> *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>          * case.  If we left eb->folios[i] populated in the subpage case =
we'd
>          * double put our reference and be super sad.
>          */
> -       for (int i =3D 0; i < attached; i++) {
> -               ASSERT(eb->folios[i]);
> -               detach_extent_buffer_folio(eb, eb->folios[i]);
> +       for (int i =3D 0; i < num_extent_folios(eb); i++) {
> +               if (i < attached) {
> +                       ASSERT(eb->folios[i]);
> +                       detach_extent_buffer_folio(eb, eb->folios[i]);
> +               } else if (!eb->folios[i])
> +                       continue;
>                 folio_unlock(eb->folios[i]);
>                 folio_put(eb->folios[i]);
>                 eb->folios[i] =3D NULL;
>
> And perhaps `struct folio *folio =3D eb->folios[i];` first and substitute=
.
>
> Or is this unrelated and we need both?

This is unrelated.
What you're trying to do here is to simplify the error path of the
allocation of a regular extent buffer.
Nothing to do with Boris' fix, and out of the scope of the fix.

>
> And honestly, IMO, there's no reason to set the EXTENT_BUFFER_UNMAPPED
> at all after this loop as it's just going to be freed.
>
>         }
> -       /*
> -        * Now all pages of that extent buffer is unmapped, set UNMAPPED =
flag,
> -        * so it can be cleaned up without utilizing folio->mapping.
> -        */
> -       set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> -
>         btrfs_release_extent_buffer(eb);
> +
>         if (ret < 0)
>                 return ERR_PTR(ret);
> +
>         ASSERT(existing_eb);
>         return existing_eb;
>  }
>
> >         }
> >  }
> >
> > @@ -3365,8 +3370,15 @@ struct extent_buffer *alloc_extent_buffer(struct=
 btrfs_fs_info *fs_info,
> >          * btree_release_folio will correctly detect that a page belong=
s to a
> >          * live buffer and won't free them prematurely.
> >          */
> > -       for (int i =3D 0; i < num_extent_folios(eb); i++)
> > +       for (int i =3D 0; i < num_extent_folios(eb); i++) {
> >                 folio_unlock(eb->folios[i]);
> > +               /*
> > +                * A folio that has been added to an address_space mapp=
ing
> > +                * should not continue holding the refcount from its or=
iginal
> > +                * allocation indefinitely.
> > +                */
> > +               folio_put(eb->folios[i]);
> > +       }
> >         return eb;
> >
> >  out:
> > --
> > 2.49.0
> >
> >
>

