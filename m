Return-Path: <linux-btrfs+bounces-12687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47759A76613
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 14:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304453ACC73
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375B1E5B78;
	Mon, 31 Mar 2025 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ8x31zf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A561D799D
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424458; cv=none; b=rIy34jTMl/d+VNeZDHKqZVG+04ykyx7gu0VvXwp8iNZgLH5032uUD6+6rCVNnsWOP05zcQVJkSSvAtOVc1N9yN6Xx+GJp8Cixmumi5h2ol97XIsyb/8dlCiBHmSHEef2S2sl36MvSvwh4ZhuFxocQ/IyVsENEOYS4286ZiG9XxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424458; c=relaxed/simple;
	bh=JbXMrm13OAENFBMdfCeQyilap+G0kWnShZRW4aZ6r/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzxxWdUFh8PtlS5qTHBnqpw1GUiIFjaiMhcZPAjA478oCh0h7NqbOy24aAfZ43pslMCAC3Wh1vmXiuU3FWihOUBmqKvVfuZbxIrvSgwdLHAD+/7bvnRAxIKCUbaotWOmb1f/5j7TIipyqUEI4NkQb226dQ+m9Ratt2wTWes7Y08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ8x31zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE291C4CEE5
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 12:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743424456;
	bh=JbXMrm13OAENFBMdfCeQyilap+G0kWnShZRW4aZ6r/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GJ8x31zfTAJDbN5oWJron/JqgOT7iS3D+uFpVp3HaX7DyZqZNfaC8VwZyypA+azda
	 GFyi5OofloE16WYTe3OIhY7phRc7+p7yRsi//anIgbiUslc9ncHaQMpfa6Na6rK9zM
	 MtBbJ8yK7cm37vCgbxcKvdIQ9trxmcpYmdZhwnS2NyzABfIswc2/Bs0JHGE1DEFeuE
	 B6hs8qrtsMbMFpi2YVioZiAJXU+UQJJ9kW5Reivj/xqc/TRxcWCj8WLYzlM7VElvLf
	 1TgCp2UvmmT6mCN36iY3hkc2mhpW5pxM12a20JTXkD1vjHIVdvDFpMD0MWx6YrmR7G
	 d0CbdEnj9w+dA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so576864566b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 05:34:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YwDydqyxI7wBuuv+z3kDA1vpPFRHQlGjnFLAksRWjtpKHHpvd7j
	Y0RR0tCCCNPCf3Dpc9rpQuiv1k0nxdUQ21/fetvNByYfZonVPOsVxO0OLUemq8AoumkrWfKMvu3
	GxOqDVTcwAXxvyMZb2MARoQDYo1k=
X-Google-Smtp-Source: AGHT+IFSfn0WHr4ZbuMQg9hMVZY893Gm0rF8OKorhWhiaFTo9Re1RSY5oA2ClYwD+DGQuwQ8sV2+tCQSeQzCkgvDXwE=
X-Received: by 2002:a17:907:7250:b0:abc:b96:7bd2 with SMTP id
 a640c23a62f3a-ac738975e17mr835979066b.11.1743424455308; Mon, 31 Mar 2025
 05:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1c50d284270034703a5c99a42799ff77de871934.1742255123.git.boris@bur.io>
In-Reply-To: <1c50d284270034703a5c99a42799ff77de871934.1742255123.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 31 Mar 2025 12:33:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7TjsBzTrCrJ5ibOsBj1LyuJB7ZHUnKXyjr31pqm4bzXw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq6fdTAwd80M9LAj41kRiW5YqVOl4JF7N2OoUoUv4L3Kud-VaKWUthQ6jY
Message-ID: <CAL3q7H7TjsBzTrCrJ5ibOsBj1LyuJB7ZHUnKXyjr31pqm4bzXw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix broken drop_caches on extent_buffer folios
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 11:47=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> The (correct) commit
> e41c81d0d30e ("mm/truncate: Replace page_mapped() call in invalidate_inod=
e_page()")
> replaced the page_mapped(page) check with a refcount check. However,
> this refcount check does not work as expected with drop_caches for
> btrfs's metadata pages.
>
> Btrfs has a per-sb metadata inode with cached pages, and when not in
> active use by btrfs, they have a refcount of 3. One from the initial
> call to alloc_pages, one (nr_pages =3D=3D 1) from filemap_add_folio, and =
one
> from folio_attach_private. We would expect such pages to get dropped by
> drop_caches. However, drop_caches calls into mapping_evict_folio via
> mapping_try_invalidate which gets a reference on the folio with
> find_lock_entries(). As a result, these pages have a refcount of 4, and
> fail this check.
>
> For what it's worth, such pages do get reclaimed under memory pressure,
> so I would say that while this behavior is surprising, it is not really
> dangerously broken.
>
> The following script produces such pages and uses drgn to further
> analyze the state of the folios at various stages in the lifecycle
> including drop_caches and memory pressure.
> https://github.com/boryas/scripts/blob/main/sh/strand-meta/run.sh

Not sure if it's a good thing to add URLs not as permanent as lore and
kernel.org...
I would place the script in the change log itself.

>
> When I asked the mm folks about the expected refcount in this case, I
> was told that the correct thing to do is to donate the refcount from the
> original allocation to the page cache after inserting it.
> https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/
>
> Therefore, attempt to fix this by adding a put_folio() to the critical
> spot in alloc_extent_buffer where we are sure that we have really
> allocated and attached new pages.
>
> Since detach_extent_buffer_folio() has relatively complex logic w.r.t.
> early exits and whether or not it actually calls folio_detach_private(),
> the easiest way to ensure we don't incur a UAF in that function is to
> wrap it in a buffer refcount so that the private reference cannot be the
> last one.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7abe6ca5b38ff..207fa2d0de472 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2823,9 +2823,13 @@ static void btrfs_release_extent_buffer_folios(con=
st struct extent_buffer *eb)
>                 if (!folio)
>                         continue;
>
> +               /*
> +                * Avoid accidentally putting the last refcount during
> +                * detach_extent_buffer_folio() with an extra
> +                * folio_get()/folio_put() pair as a buffer.
> +                */
> +               folio_get(folio);
>                 detach_extent_buffer_folio(eb, folio);
> -
> -               /* One for when we allocated the folio. */
>                 folio_put(folio);

Instead of adding this defensive get/put pair, we could simply change
detach_extent_buffer_folio():

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 19f21540475d..7183ae731288 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2768,6 +2768,7 @@ static bool folio_range_has_eb(struct folio *folio)
 static void detach_extent_buffer_folio(const struct extent_buffer
*eb, struct folio *folio)
 {
        struct btrfs_fs_info *fs_info =3D eb->fs_info;
+       struct address_space *mapping =3D folio->mapping;
        const bool mapped =3D !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags=
);

        /*
@@ -2775,11 +2776,11 @@ static void detach_extent_buffer_folio(const
struct extent_buffer *eb, struct fo
         * be done under the i_private_lock.
         */
        if (mapped)
-               spin_lock(&folio->mapping->i_private_lock);
+               spin_lock(&mapping->i_private_lock);

        if (!folio_test_private(folio)) {
                if (mapped)
-                       spin_unlock(&folio->mapping->i_private_lock);
+                       spin_unlock(&mapping->i_private_lock);
                return;
        }

@@ -2799,7 +2800,7 @@ static void detach_extent_buffer_folio(const
struct extent_buffer *eb, struct fo
                        folio_detach_private(folio);
                }
                if (mapped)
-                       spin_unlock(&folio->mapping->i_private_lock);
+                       spin_unlock(&mapping->i_private_lock);
                return;
        }

@@ -2822,7 +2823,7 @@ static void detach_extent_buffer_folio(const
struct extent_buffer *eb, struct fo
        if (!folio_range_has_eb(folio))
                btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA=
);

-       spin_unlock(&folio->mapping->i_private_lock);
+       spin_unlock(&mapping->i_private_lock);
 }

 /* Release all folios attached to the extent buffer */

It even makes the detach_extent_buffer_folio() code less verbose.

Either way:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>         }
>  }
> @@ -3370,8 +3374,15 @@ struct extent_buffer *alloc_extent_buffer(struct b=
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
> --
> 2.47.1
>
>

