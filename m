Return-Path: <linux-btrfs+bounces-13719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B193AAAC1DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 12:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFCA1C2292D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 10:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B96227876F;
	Tue,  6 May 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxWP0AU5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74B262FD3
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529115; cv=none; b=HsuvkX1X9e9bO/n/rTUE4M3//ahCeSb3B5dvfvaVAwJSCjbCaU/eQFu6VUfxwxxg8sDyYHTDPR9wee6VXNh6cSrURQA8aXJCxZfKPENL5x44zJALSv8LSnH5z8YQomm2meYKVvdcsMdol6RsoTFCw/tqqK6DJAkY0/Lwh5gMC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529115; c=relaxed/simple;
	bh=dGQSRxBBEM/ru2drX2U67rDgXASHgykOwYB1D9k49IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXyzgZpkMEjU1HYsILwwZVjguq8iM69VtOummor/XTCyjIE731GK2ZB1bGxjq9myRpxyGW+G3hGFBT9dXI69tJFIIwucPUsPR8DqVNA4Bdo9na4AnQoJq1PnPxGImJdBtTre7ilkgdXCBgJq5papveW7i48ospvpR/wwtQ5zFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxWP0AU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA2EC4CEED
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746529115;
	bh=dGQSRxBBEM/ru2drX2U67rDgXASHgykOwYB1D9k49IM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jxWP0AU5lxmesXOESatUk397/5lLnQweVzAGH+3ySnAn4HLPX1IK39yLR1YP5YpD4
	 PdVq0xCf9rSvSeqsWnTrb8wR/ecjvKoSxRxaKoOt0wZraXUsfQhk3YCUspoG6qTuT3
	 3xH8T48n7A9SdHClENiDoqrbPnnh/6XEgxYQGSSS+eG6EicwHkrpDVrpGys3QMQSkf
	 ohFAmmQ1SzJnNglZUp7lXquDGwV8F+L+Zq/UE9vqwVgmrYo6ykk8hRp2lsSJ+RMHJj
	 roP4aI+XSRvo4GdSfYhtzN6hqt26ac4Gso5i27kj90xndc7J3r5kU/uXqO9sJMpWO6
	 GP+6LTVIOIYtw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2963dc379so791686166b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 06 May 2025 03:58:35 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywe4J/HbewKQwH3cKlXCcS0/paVsDMeoM2yHcFDpgGtM0dbEDsh
	1bPqJ4ggwpwwQGfxQuou2NHKVh3JM+cO/qEWzklTpDTn3FXuDQcJD/s5sut3vFQsz7txDoiZTdD
	llzW66g3Zk+UfWNg64Ttjozoelvg=
X-Google-Smtp-Source: AGHT+IEHIqtQIkO6MZHKu2PPfG0ewFp0Yrfm3eR6hkDf3+w2Y24//XXNxp2cg4UW9xiluorTegwCwmi+2LntZPl1Yqs=
X-Received: by 2002:a17:907:3e0c:b0:ace:d853:ff9a with SMTP id
 a640c23a62f3a-ad1d349911bmr296400766b.16.1746529113700; Tue, 06 May 2025
 03:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b1fd74c27ccbc9f967f68e17a443c50411987e19.1746481493.git.boris@bur.io>
In-Reply-To: <b1fd74c27ccbc9f967f68e17a443c50411987e19.1746481493.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 6 May 2025 11:57:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5aL=MwYnX54RnLRZzt8baSDqnHD7MMzsDwM93RwSMT4w@mail.gmail.com>
X-Gm-Features: ATxdqUFWDch5YDQg-aj5AqU0yjwRY-inLqAk9Dd9MMPQfftWSvrWHjg_X-u6IF4
Message-ID: <CAL3q7H5aL=MwYnX54RnLRZzt8baSDqnHD7MMzsDwM93RwSMT4w@mail.gmail.com>
Subject: Re: [PATCH v4] btrfs: fix broken drop_caches on extent buffer folios
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:48=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> The (correct) commit e41c81d0d30e ("mm/truncate: Replace page_mapped()
> call in invalidate_inode_page()") replaced the page_mapped(page) check
> with a refcount check. However, this refcount check does not work as
> expected with drop_caches for btrfs's metadata pages.
>
> Btrfs has a per-sb metadata inode with cached pages, and when not in
> active use by btrfs, they have a refcount of 3. One from the initial
> call to alloc_pages(), one (nr_pages =3D=3D 1) from filemap_add_folio(), =
and
> one from folio_attach_private(). We would expect such pages to get droppe=
d
> by drop_caches. However, drop_caches calls into mapping_evict_folio() via
> mapping_try_invalidate() which gets a reference on the folio with
> find_lock_entries(). As a result, these pages have a refcount of 4, and
> fail this check.
>
> For what it's worth, such pages do get reclaimed under memory pressure,
> so I would say that while this behavior is surprising, it is not really
> dangerously broken.
>
> When I asked the mm folks about the expected refcount in this case, I
> was told that the correct thing to do is to donate the refcount from the
> original allocation to the page cache after inserting it.
> https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/

The link here after ending a sentence and without any spacing or
introduction seems unintentional?
It's already in the Link tag at the bottom, so there's no need to have
it twice in the change log.

>
> Therefore, attempt to fix this by adding a put_folio() to the critical
> spot in alloc_extent_buffer() where we are sure that we have really
> allocated and attached new pages. We must also adjust
> folio_detach_private() to properly handle being the last reference to the
> folio and not do a use-after-free after folio_detach_private().
>
> extent_buffers allocated by clone_extent_buffer() and
> alloc_dummy_extent_buffer() are unmapped, so this transfer of ownership
> from allocation to insertion in the mapping does not apply to them.
> However, we can still folio_put() them safely once they are finished
> being allocated and have called folio_attach_private().
>
> Finally, removing the generic put_folio() for the allocation from
> btrfs_detach_extent_buffer_folios() means we need to be careful to do
> the appropriate put_folio() in allocation failure paths in
> alloc_extent_buffer(), clone_extent_buffer() and
> alloc_dummy_extent_buffer.
>
> Link: https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.=
org/
> Tested-by: Klara Modin <klarasmodin@gmail.com>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Note: Resending as V4 because of the convoluted history of this patch,
> the contributions from multiple reviewers/testers, and the non-trivial
> nature of the two merged patches.
>
> Changelog:
> v4:
> * merge Daniel Vacek's patch
>   "btrfs: put all allocated extent buffer folios in failure case"
>   which fixes the outstanding missing folio_put() calls on the partial
>   failure path of alloc_extent_buffer.
> v3:
> * call folio_put() before using extent_buffers allocated with
>   clone_extent_buffer() and alloc_dummy_extent_buffer() to get rid of
>   the UNMAPPED exception in btrfs_release_extent_buffer_folios().
> v2:
> * Used Filipe's suggestion to simplify detach_extent_buffer_folio and
>   lose the extra folio_get()/folio_put() pair
> * Noticed a memory leak causing failures in fstests on smaller vms.
>   Fixed a bug where I was missing a folio_put() for ebs that never got
>   their folios added to the mapping.
>
>
>  fs/btrfs/extent_io.c | 108 +++++++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 45 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index cbaee10e2ca8..884adc4d4f9d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2747,6 +2747,7 @@ static bool folio_range_has_eb(struct folio *folio)
>  static void detach_extent_buffer_folio(const struct extent_buffer *eb, s=
truct folio *folio)
>  {
>         struct btrfs_fs_info *fs_info =3D eb->fs_info;
> +       struct address_space *mapping =3D folio->mapping;
>         const bool mapped =3D !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bfla=
gs);
>
>         /*
> @@ -2754,11 +2755,11 @@ static void detach_extent_buffer_folio(const stru=
ct extent_buffer *eb, struct fo
>          * be done under the i_private_lock.
>          */
>         if (mapped)
> -               spin_lock(&folio->mapping->i_private_lock);
> +               spin_lock(&mapping->i_private_lock);
>
>         if (!folio_test_private(folio)) {
>                 if (mapped)
> -                       spin_unlock(&folio->mapping->i_private_lock);
> +                       spin_unlock(&mapping->i_private_lock);
>                 return;
>         }
>
> @@ -2777,7 +2778,7 @@ static void detach_extent_buffer_folio(const struct=
 extent_buffer *eb, struct fo
>                         folio_detach_private(folio);
>                 }
>                 if (mapped)
> -                       spin_unlock(&folio->mapping->i_private_lock);
> +                       spin_unlock(&mapping->i_private_lock);
>                 return;
>         }
>
> @@ -2800,7 +2801,7 @@ static void detach_extent_buffer_folio(const struct=
 extent_buffer *eb, struct fo
>         if (!folio_range_has_eb(folio))
>                 btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADA=
TA);
>
> -       spin_unlock(&folio->mapping->i_private_lock);
> +       spin_unlock(&mapping->i_private_lock);
>  }
>
>  /* Release all folios attached to the extent buffer */
> @@ -2815,9 +2816,6 @@ static void btrfs_release_extent_buffer_folios(cons=
t struct extent_buffer *eb)
>                         continue;
>
>                 detach_extent_buffer_folio(eb, folio);
> -
> -               /* One for when we allocated the folio. */
> -               folio_put(folio);
>         }
>  }
>
> @@ -2852,6 +2850,21 @@ static struct extent_buffer *__alloc_extent_buffer=
(struct btrfs_fs_info *fs_info
>         return eb;
>  }
>
> +/*
> + * For use in eb allocation error cleanup paths, as btrfs_release_extent=
_buffer()
> + * does not call folio_put(), and we need to set the folios to NULL so t=
hat
> + * btrfs_release_extent_buffer() will not detach them a second time.
> + */
> +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> +{
> +       for (int i =3D 0; i < num_extent_folios(eb); i++) {
> +               ASSERT(eb->folios[i]);
> +               detach_extent_buffer_folio(eb, eb->folios[i]);
> +               folio_put(eb->folios[i]);
> +               eb->folios[i] =3D NULL;
> +       }
> +}
> +
>  struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buff=
er *src)
>  {
>         struct extent_buffer *new;
> @@ -2869,25 +2882,30 @@ struct extent_buffer *btrfs_clone_extent_buffer(c=
onst struct extent_buffer *src)
>         set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>
>         ret =3D alloc_eb_folio_array(new, false);
> -       if (ret) {
> -               btrfs_release_extent_buffer(new);
> -               return NULL;
> -       }
> +       if (ret)
> +               goto release_eb;
>
>         for (int i =3D 0; i < num_extent_folios(src); i++) {
>                 struct folio *folio =3D new->folios[i];
>
>                 ret =3D attach_extent_buffer_folio(new, folio, NULL);
> -               if (ret < 0) {
> -                       btrfs_release_extent_buffer(new);
> -                       return NULL;
> -               }
> +               if (ret < 0)
> +                       goto cleanup_folios;
>                 WARN_ON(folio_test_dirty(folio));
>         }
> +       for (int i =3D 0; i < num_extent_folios(src); i++)
> +               folio_put(new->folios[i]);
> +
>         copy_extent_buffer_full(new, src);
>         set_extent_buffer_uptodate(new);
>
>         return new;
> +
> +cleanup_folios:
> +       cleanup_extent_buffer_folios(new);
> +release_eb:
> +       btrfs_release_extent_buffer(new);
> +       return NULL;
>  }
>
>  struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs=
_info,
> @@ -2902,13 +2920,15 @@ struct extent_buffer *alloc_dummy_extent_buffer(s=
truct btrfs_fs_info *fs_info,
>
>         ret =3D alloc_eb_folio_array(eb, false);
>         if (ret)
> -               goto out;
> +               goto release_eb;
>
>         for (int i =3D 0; i < num_extent_folios(eb); i++) {
>                 ret =3D attach_extent_buffer_folio(eb, eb->folios[i], NUL=
L);
>                 if (ret < 0)
> -                       goto out_detach;
> +                       goto cleanup_folios;
>         }
> +       for (int i =3D 0; i < num_extent_folios(eb); i++)
> +               folio_put(eb->folios[i]);
>
>         set_extent_buffer_uptodate(eb);
>         btrfs_set_header_nritems(eb, 0);
> @@ -2916,15 +2936,10 @@ struct extent_buffer *alloc_dummy_extent_buffer(s=
truct btrfs_fs_info *fs_info,
>
>         return eb;
>
> -out_detach:
> -       for (int i =3D 0; i < num_extent_folios(eb); i++) {
> -               if (eb->folios[i]) {
> -                       detach_extent_buffer_folio(eb, eb->folios[i]);
> -                       folio_put(eb->folios[i]);
> -               }
> -       }
> -out:
> -       kmem_cache_free(extent_buffer_cache, eb);
> +cleanup_folios:
> +       cleanup_extent_buffer_folios(eb);
> +release_eb:
> +       btrfs_release_extent_buffer(eb);
>         return NULL;
>  }
>
> @@ -3357,8 +3372,15 @@ struct extent_buffer *alloc_extent_buffer(struct b=
trfs_fs_info *fs_info,
>          * btree_release_folio will correctly detect that a page belongs =
to a
>          * live buffer and won't free them prematurely.
>          */
> -       for (int i =3D 0; i < num_extent_folios(eb); i++)
> +       for (int i =3D 0; i < num_extent_folios(eb); i++) {
>                 folio_unlock(eb->folios[i]);
> +               /*
> +                * A folio that has been added to an address_space mappin=
g
> +                * should not continue holding the refcount from its orig=
inal
> +                * allocation indefinitely.
> +                */
> +               folio_put(eb->folios[i]);
> +       }
>         return eb;
>
>  out:
> @@ -3371,30 +3393,26 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
>          * we'll lookup the folio for that index, and grab that EB.  We d=
o not
>          * want that to grab this eb, as we're getting ready to free it. =
 So we
>          * have to detach it first and then unlock it.
> -        *
> -        * We have to drop our reference and NULL it out here because in =
the
> -        * subpage case detaching does a btrfs_folio_dec_eb_refs() for ou=
r eb.
> -        * Below when we call btrfs_release_extent_buffer() we will call
> -        * detach_extent_buffer_folio() on our remaining pages in the !su=
bpage
> -        * case.  If we left eb->folios[i] populated in the subpage case =
we'd
> -        * double put our reference and be super sad.
>          */
> -       for (int i =3D 0; i < attached; i++) {
> -               ASSERT(eb->folios[i]);
> -               detach_extent_buffer_folio(eb, eb->folios[i]);
> -               folio_unlock(eb->folios[i]);
> -               folio_put(eb->folios[i]);
> +       for (int i =3D 0; i < num_extent_pages(eb); i++) {
> +               struct folio *folio =3D eb->folios[i];
> +
> +               if (i < attached) {
> +                       ASSERT(folio);
> +                       detach_extent_buffer_folio(eb, folio);
> +                       folio_unlock(folio);
> +               } else if (!folio)
> +                       continue;

Please put the else part with { } too, that's part of the general
coding style preference.

> +
> +               ASSERT(!folio_test_private(folio));
> +               folio_put(folio);
>                 eb->folios[i] =3D NULL;
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

These two stray new lines seem accidental and unrelated to the code changes=
.

With those minor things changed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.



>         ASSERT(existing_eb);
>         return existing_eb;
>  }
> --
> 2.49.0
>
>

