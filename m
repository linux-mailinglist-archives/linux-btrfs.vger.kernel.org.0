Return-Path: <linux-btrfs+bounces-13757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59314AAD179
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 01:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2847B6044
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E988219A79;
	Tue,  6 May 2025 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfNccyt+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0855139E
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746573004; cv=none; b=UqxX72GJvitfMp1PBRHf3QPYkRqfeLo40OULtwb3i9A/jzbEb0PRKVYa4xR5fXUM+axnthiI/iy1oPFHhp0NJOC5hguZQ7z6bwmra7wr53cv94JvvpQGs5IsyZ3oo+nTsqOr5wvs3YsHnkeUITtVLFq6Rw2B40LzDpMaP8QrHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746573004; c=relaxed/simple;
	bh=OzbQxFzVBFUqiPM3th5MUJc8pA09HoMiykoWc3+eXrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlWt7nDtigBtna3ZzlN/aoE1Z00ApLkCFlwLe+0nEAti2qmsD9jhbptioGaqCNjx7tfj8g1l+WnZrGOCAJTjlAU//+gshxcfT/1cMeiq69HA4vOq/0HzCcJpTdlFq3tUL2Ann4MnAbTUX3B4JMZTtzqDZYHn9+AQICbwGZS4BZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfNccyt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F7FC4CEE4
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746573004;
	bh=OzbQxFzVBFUqiPM3th5MUJc8pA09HoMiykoWc3+eXrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XfNccyt+09Bq85w523WNJ/7ncTNU0Wo9ZOnC0UqnlJwSUEaAnQ7Sp8a5v04wNYOCQ
	 aaDutnC7jUEQEHX1Fu/fzlXsNcnwn2aryDdDKRlqrIaVHRaVSLmZgHZHx+iTCMqm4p
	 O0/FHLFlIRte/pIssO1QzBSoDdeDYsw+5iVw9p8Zqw8FP7CDfT4Ir0EiK3PVVdNpxn
	 6oiFXWy94weryQZpUOaxtu9CR/fu0ASlWR8EffOl0DsCZ0TYr0hBBlAsdZp4L39apX
	 oqVEf/fZp74tA5TyLh0AkeyDn11bAznLqQHKouWMdXarE5ul22FSz/SSRNrJKPV4nC
	 OFNgOXkhImbWQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so864131966b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 06 May 2025 16:10:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YxqKOCDJjcdFDvnp3FsUGpwLnD85Wxrg5dMrPTbhCzY3vl10vCv
	u9i4/ngfb7kUKy24ZBIGiL0BJP9qS+/jJtd805tJeJMVgIaIh/5NXUoL3tnt5ASBlp6xOdmcvHT
	3eTo8R4YA6cMTp/zhSSdLZ6JLcIc=
X-Google-Smtp-Source: AGHT+IH7LPSxJcG02dgeNVSl2A6fg8BsLHVIYXIfjnUCmEnGcFT0sejwyewjzNjddEu05cvHwuIXakJ8W/+mYSu/924=
X-Received: by 2002:a17:907:a641:b0:abf:fb78:673a with SMTP id
 a640c23a62f3a-ad1e8bf960emr126395266b.29.1746573002812; Tue, 06 May 2025
 16:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
In-Reply-To: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 7 May 2025 00:09:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6YY=Wwjs3+305SOAU-8zs-TCCp-sUz5dC8nTV6HnaE3A@mail.gmail.com>
X-Gm-Features: ATxdqUGWalkA4K0qtTuZKkYoCm6cBDrpCoE-yb-USHdFQNorHccGinsGTl40bDI
Message-ID: <CAL3q7H6YY=Wwjs3+305SOAU-8zs-TCCp-sUz5dC8nTV6HnaE3A@mail.gmail.com>
Subject: Re: [PATCH v5] btrfs: fix broken drop_caches on extent buffer folios
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, neelx@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:46=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
> Changelog:
> v5:
> * fix num_extent_folios() iteration bug in cleanup_extent_buffer_folios()
> * make usage of num_extent_folios() clearer in clone_extent_buffer()
> * make some code style fixes in alloc_extent_buffer
> * remove extra link in commit message
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
>  fs/btrfs/extent_io.c | 115 ++++++++++++++++++++++++++-----------------
>  1 file changed, 69 insertions(+), 46 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index cbaee10e2ca8..0b6017d9d223 100644
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
> @@ -2852,9 +2850,27 @@ static struct extent_buffer *__alloc_extent_buffer=
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
> +       int num_folios =3D num_extent_folios(eb);
> +
> +       for (int i =3D 0; i < num_folios; i++) {
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
> +       int num_folios;
>         int ret;
>
>         new =3D __alloc_extent_buffer(src->fs_info, src->start);
> @@ -2869,25 +2885,33 @@ struct extent_buffer *btrfs_clone_extent_buffer(c=
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
> -       for (int i =3D 0; i < num_extent_folios(src); i++) {
> +       ASSERT(num_extent_folios(src) =3D=3D num_extent_folios(new),
> +              "%d !=3D %d", num_extent_folios(src), num_extent_folios(ne=
w));
> +       num_folios =3D num_extent_folios(src);
> +       for (int i =3D 0; i < num_folios; i++) {
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
> +       for (int i =3D 0; i < num_folios; i++)
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
> @@ -2902,13 +2926,15 @@ struct extent_buffer *alloc_dummy_extent_buffer(s=
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
> @@ -2916,15 +2942,10 @@ struct extent_buffer *alloc_dummy_extent_buffer(s=
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
> @@ -3357,8 +3378,15 @@ struct extent_buffer *alloc_extent_buffer(struct b=
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
> @@ -3371,27 +3399,22 @@ struct extent_buffer *alloc_extent_buffer(struct =
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
> +               } else if (!folio) {
> +                       continue;
> +               }
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
>         if (ret < 0)
>                 return ERR_PTR(ret);
> --
> 2.49.0
>

