Return-Path: <linux-btrfs+bounces-13217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E828FA965C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 12:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9D07ABDDB
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E3C20D4F6;
	Tue, 22 Apr 2025 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLy90jWf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E5B1F4608
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317345; cv=none; b=f4DX7mdxHZtPSfStaRK9NfgcAkoi8BBJQhfsNEnoxf1oacpE3AhvP3KUsc0U9uUVsyYZBpAUpi34IFpEJxogoGxBtswwTDXCDiIihRwe0l8rVR5Fue9CP74b35QUHWdIeZ5mbJvXe1eYSHC3ToFH/amId7PLcR4vOa6aqfAIOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317345; c=relaxed/simple;
	bh=4TOW999i1CosrcaUk69abZ2NIGL3CLUdbn3Lk4yRdJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOKM1CWU7Qlcexc4F+El7iLL6T3jWRveNeU0Pl9+jHmrZnETQmi4GUtr1LaVVEBkyPFKRnNzGkUhyA2L/Htp7bNkZ+LvbH67FcXP4ZaYOhHmuzbyXRrOWoWiFVpZku3f44E5DxuGvhcUij+SOIAs8pCOC5D3A7iB3lKE10UpVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLy90jWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B61C4CEEF
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745317344;
	bh=4TOW999i1CosrcaUk69abZ2NIGL3CLUdbn3Lk4yRdJw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VLy90jWfLS4z+XBTk3eaK2LcBL4gE7LZzLIqWii35vDNHmsLNHzjXYcdHKR60RyOy
	 1rf3SOgNGrhXIv9BSo7qHnXH/sH5ZW1lZY1tbX14lSTZ/gkUB0tKtRvd1Y9obYbm0f
	 cvG1QVDWq9kWdcSJNym1+TuYF6R6FyrGhxZvRMmtMENGP/VYQsoSFBgtgHR61RGX0N
	 ywGBzmm6dEfxFPaJzWJVjVo6AV0fUZrmMbIwGBFA0yn82vV/hghy2cwZIP158A0mvy
	 AQtK4Jk3KxfZg7zQeBrjay9JkYwMoqwyKmFyfRFaWrTNX3myujK9GV7rySKmNgdkXI
	 GM0viaqR/A6ww==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac41514a734so715359766b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 03:22:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZyCLEx/tk2eiH+qc1d6E7K9HwDvbH10SwCbklXZerLgQ6U+L4LuILrTO2OZsHAfwSXf0NtAA1VvCLTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYpAzm4/hjBl4oF/KmjzC4poXyeSjZvohFV1wK6yGNmVO0qOyV
	Ps7ZEMxqHV0aWBLXh1STZgkHoVTHkMc1dql3LzfcLHug1kVUnth8fCnDCDu/FipySzbEXsGeFSq
	8CJfo7uAEENUfbsZ29e3BkmTF5Pc=
X-Google-Smtp-Source: AGHT+IHtaS+Ea8P2opu0vemb6dJdBpgQtdXvD+cejlQZ7hYVwSr+4DDfEuQKeOkDzHmeyQ2ZjFi9U5QflzYJpeZVFzY=
X-Received: by 2002:a17:907:7e81:b0:acb:5583:6fe4 with SMTP id
 a640c23a62f3a-acb74ad7dddmr1378762566b.6.1745317343353; Tue, 22 Apr 2025
 03:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9441faad18d711ba7bccd2818e6762df0e948761.1745000301.git.boris@bur.io>
 <CAPjX3FfxxbMN2hEO1TnKV9cSrYUZfdYNBogQFtKFdtgTebCXog@mail.gmail.com>
In-Reply-To: <CAPjX3FfxxbMN2hEO1TnKV9cSrYUZfdYNBogQFtKFdtgTebCXog@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 22 Apr 2025 11:21:46 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6y2i_15DAjQOpYUdR4A0dLZRWUWQDOFyZ=FPOnGjAFOA@mail.gmail.com>
X-Gm-Features: ATxdqUGo97WKiWzEI0ppws8gV-p8Xd00NgfQwF9nuNmw56rWbU5PPH9mb69e8OM
Message-ID: <CAL3q7H6y2i_15DAjQOpYUdR4A0dLZRWUWQDOFyZ=FPOnGjAFOA@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: fix broken drop_caches on extent_buffer folios
To: Daniel Vacek <neelx@suse.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 10:24=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrot=
e:
>
> On Fri, 18 Apr 2025 at 20:24, Boris Burkov <boris@bur.io> wrote:
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
> > However, we can still folio_put() them safely once they are finished
> > being allocated and have called folio_attach_private().
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v3:
> > * call folio_put() before using extent_buffers allocated with
> >   clone_extent_buffer() and alloc_dummy_extent_buffer() to get rid of
> >   the UNMAPPED exception in btrfs_release_extent_buffer_folios().
> > v2:
> > * Used Filipe's suggestion to simplify detach_extent_buffer_folio and
> >   lose the extra folio_get()/folio_put() pair
> > * Noticed a memory leak causing failures in fstests on smaller vms.
> >   Fixed a bug where I was missing a folio_put() for ebs that never got
> >   their folios added to the mapping.
> >
> >
> >  fs/btrfs/extent_io.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 5f08615b334f..a6c74c1957ff 100644
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
> > @@ -2821,9 +2822,6 @@ static void btrfs_release_extent_buffer_folios(co=
nst struct extent_buffer *eb)
> >                         continue;
> >
> >                 detach_extent_buffer_folio(eb, folio);
> > -
> > -               /* One for when we allocated the folio. */
> > -               folio_put(folio);
> >         }
> >  }
> >
> > @@ -2889,6 +2887,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(c=
onst struct extent_buffer *src)
> >                         return NULL;
> >                 }
> >                 WARN_ON(folio_test_dirty(folio));
> > +               folio_put(folio);
>
> Would this cause double puts in case the second iteration of the loop
> fails to attach?

Nop, because a folio_put() was removed from
btrfs_release_extent_buffer_folios() in this patch.
But this introduces a leak here in case attach_extent_buffer_folio()
returns an error, since we will miss a folio_put() for all the folios
we haven't attached.

So this folio_put() should be done in a subsequent loop, and ideally
have a comment similar to the one added to alloc_extent_buffer() in
this patch.

Boris btw, I see you kept my Review tag in v2 and v3, yet the patches
changed in non-trivial ways.
A Review tag is meant to be preserved only in case of trivial changes
like fixing typos for example or exclusively applying suggestions from
a reviewer.

>
> Other than that, it looks good to me.
>
> >         }
> >         copy_extent_buffer_full(new, src);
> >         set_extent_buffer_uptodate(new);
> > @@ -2915,6 +2914,8 @@ struct extent_buffer *alloc_dummy_extent_buffer(s=
truct btrfs_fs_info *fs_info,
> >                 if (ret < 0)
> >                         goto out_detach;
> >         }
> > +       for (int i =3D 0; i < num_extent_folios(eb); i++)
> > +               folio_put(eb->folios[i]);
> >
> >         set_extent_buffer_uptodate(eb);
> >         btrfs_set_header_nritems(eb, 0);
> > @@ -3365,8 +3366,15 @@ struct extent_buffer *alloc_extent_buffer(struct=
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

