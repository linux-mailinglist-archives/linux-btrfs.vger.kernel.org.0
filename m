Return-Path: <linux-btrfs+bounces-13158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE83A93533
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 11:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949E6467E64
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F91526FDA1;
	Fri, 18 Apr 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QFDqhyVw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB526FD85
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968270; cv=none; b=VZjBUC3LvymHJbtTQR5PSN9urxCQtFsiSoP6we7iwufW3kRrwci+Ufbd2ri6Y0dm3pTYkl9uvQIMYiZ1qx2CwN6eFht9hQecuHF3SWNAzSZVWsVVhJjZWE8Tg6B/ZG53VduGUY/xrDHrix6O8MDGr+Vlx1Zi+9wwXOoWIw1CwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968270; c=relaxed/simple;
	bh=B3FqIsNPYmypq3LYZv2H0LP/aR5Be3OT93AkcV/8C3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guRXt6LwDkL9g9JsnyucMJY5bLVGAT2B80hl+R3N7VA/bGWI/emX37CUDs7GAqh2iyW86wSLw3jpmFY1P6Ex59cXO/lRn7z9ZeVk76GYSNEGXDtnFw+63FqURIOjI6WYmQcsSjBQj698GhXPzuFCAMVsxeBSWQDqzyUPojirwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QFDqhyVw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so2887016a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744968266; x=1745573066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPNIrh+dfcoWoxI4CcfRxfSjyEXMxkOP+t/Kq9BbD+s=;
        b=QFDqhyVwO13clbjm69A1vkpxN5x+Z1I9L277I1lJAOt8FbgwzXp2TuctPy9lmoFqx6
         j/2MnT2Gu2iiEbT/ijH+4ke610pfNqlXYRIHxlKLDk9jd3nzD9EEMUd6oCG2pkvkVmRu
         L9MCaLKkBY1Vi+AfEHGxfpi4TQNdIsECad9XVJJ4MgD/lHze97a47Z/imlFbBRdRvpPU
         8o2GoU+Yi0Y+JuUP0vWYlRw5+333+kzQNSxtJhESa9krmgN49gJVw12oQUEHxd6H9h1E
         Sgzgk2YjdTSrqVl8LOJuC3U1JpykYFP4u+zJIg+LoaUsN/hlPohh1EcqpX/trqGYiLOA
         h4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744968266; x=1745573066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPNIrh+dfcoWoxI4CcfRxfSjyEXMxkOP+t/Kq9BbD+s=;
        b=nJnPu9FyccFIPThCGBHtbdevPj3liPGfb9ver+DbZetY0iIP/loDya9J8nCm4APxAb
         J34f8GHC1HTfanesgOqw7DfbIA2yMBrK9H469tWuY/kDT6WVtac87DXPOXl3DRntIlcs
         xr5sQKkIirpiVABYRU8gbxFH80mZbUsICuOgqkbrAnMIbdFI3EW+N6YHoMFyzKJQoSHO
         U7LWzrjiuWpcE2IhCbYzHLVCg4O4HcB6laEao2ghpnb95VFXyK83M79L0xQAa1g/uklF
         vuDwYGs+5qNCDQ/tQNqpYb7uJCojgkZ19K/GzsOyPG9lGg3PAyPaWll3sXb4wfW7SytG
         xeiA==
X-Gm-Message-State: AOJu0YycOT7I+BWqob9ga7n0X6F2LmtoA2KMOZ9BWutvgWeUJM+FuaBB
	jvhmmE0s+zVCqe7N5vom9mZd0xBEDdmguoaxZZLxhOwMulw+bMT3/VJWpBPRX6viKJCXKfbho/W
	mqhLCWY6oaRwiGgSz1I6WzmzSAjuhoM4IsFILug==
X-Gm-Gg: ASbGncsQaGovbtXtTZgACteuPrdbgCV/BjyTQUyvfu9K3hJ8U6oYjEjgqgRR2sDTMHZ
	8+xrtoFACh4YDi5sTG7KUfS3ylqFb5trNEvzAbKtuZLHuVsRMBXnPGShFUNNzv/7e5t9CReoCIs
	605LCA0j5vHtGIj7IDlyc/rwBz0ELeuro=
X-Google-Smtp-Source: AGHT+IG/T8hquMNoaESxf8JmxRsuNGkFTnirzDVfHohCZPWhiPNnq2pX/vzt9OgUWJCSie87wxZDo+6W8QE62FPDWD0=
X-Received: by 2002:a17:907:2d0b:b0:ac7:391b:e689 with SMTP id
 a640c23a62f3a-acb74e75fcbmr149449666b.59.1744968265986; Fri, 18 Apr 2025
 02:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5a3cbb2f51851dc55ff51647a214f912d6d5043.1744931654.git.boris@bur.io>
In-Reply-To: <f5a3cbb2f51851dc55ff51647a214f912d6d5043.1744931654.git.boris@bur.io>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 18 Apr 2025 11:24:15 +0200
X-Gm-Features: ATxdqUGrIrgEgmzgrXW92J1yqaWU6ClG1zY2wD-_g-8znv1EvOFqS42XX57mypc
Message-ID: <CAPjX3Fc9YAmfKGdNrQK=Zsv6NVERUnK9Fxg=7Z4vCBrimEjyVg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix broken drop_caches on extent_buffer folios
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 01:15, Boris Burkov <boris@bur.io> wrote:
>
> The (correct) commit
> e41c81d0d30e ("mm/truncate: Replace page_mapped() call in invalidate_inode_page()")
> replaced the page_mapped(page) check with a refcount check. However,
> this refcount check does not work as expected with drop_caches for
> btrfs's metadata pages.
>
> Btrfs has a per-sb metadata inode with cached pages, and when not in
> active use by btrfs, they have a refcount of 3. One from the initial
> call to alloc_pages, one (nr_pages == 1) from filemap_add_folio, and one
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
> When I asked the mm folks about the expected refcount in this case, I
> was told that the correct thing to do is to donate the refcount from the
> original allocation to the page cache after inserting it.
> https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/
>
> Therefore, attempt to fix this by adding a put_folio() to the critical
> spot in alloc_extent_buffer where we are sure that we have really
> allocated and attached new pages. We must also adjust
> folio_detach_private to properly handle being the last reference to the
> folio and not do a UAF after folio_detach_private().
>
> Finally, extent_buffers allocated by clone_extent_buffer() and
> alloc_dummy_extent_buffer() are unmapped, so this transfer of ownership
> from allocation to insertion in the mapping does not apply to them.
> Therefore, they still need a folio_put() as before.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> * Used Filipe's suggestion to simplify detach_extent_buffer_folio and
>   lose the extra folio_get()/folio_put() pair
> * Noticed a memory leak causing failures in fstests on smaller vms.
>   Fixed a bug where I was missing a folio_put() for ebs that never got
>   their folios added to the mapping.
>
>  fs/btrfs/extent_io.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5f08615b334f..90499124b8a5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2752,6 +2752,7 @@ static bool folio_range_has_eb(struct folio *folio)
>  static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct folio *folio)
>  {
>         struct btrfs_fs_info *fs_info = eb->fs_info;
> +       struct address_space *mapping = folio->mapping;
>         const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
>
>         /*
> @@ -2759,11 +2760,11 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
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
> @@ -2783,7 +2784,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
>                         folio_detach_private(folio);
>                 }
>                 if (mapped)
> -                       spin_unlock(&folio->mapping->i_private_lock);
> +                       spin_unlock(&mapping->i_private_lock);
>                 return;
>         }
>
> @@ -2806,7 +2807,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
>         if (!folio_range_has_eb(folio))
>                 btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
>
> -       spin_unlock(&folio->mapping->i_private_lock);
> +       spin_unlock(&mapping->i_private_lock);
>  }
>
>  /* Release all folios attached to the extent buffer */
> @@ -2821,9 +2822,13 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
>                         continue;
>
>                 detach_extent_buffer_folio(eb, folio);
> -
> -               /* One for when we allocated the folio. */
> -               folio_put(folio);

So far so good, but...

> +               /*
> +                * We only release the allocated refcount for mapped extent_buffer
> +                * folios. If the folio is unmapped, we have to release its allocated
> +                * refcount here.
> +                */
> +               if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))
> +                       folio_put(folio);

...is this really correct? I'd do rather this instead:

@@ -3393,22 +3393,21 @@ struct extent_buffer
*alloc_extent_buffer(struct btrfs_fs_info *fs_info,
         * case.  If we left eb->folios[i] populated in the subpage case we'd
         * double put our reference and be super sad.
         */
-       for (int i = 0; i < attached; i++) {
-               ASSERT(eb->folios[i]);
-               detach_extent_buffer_folio(eb, eb->folios[i]);
+       for (int i = 0; i < num_extent_folios(eb); i++) {
+               if (i < attached) {
+                       ASSERT(eb->folios[i]);
+                       detach_extent_buffer_folio(eb, eb->folios[i]);
+               } else if (!eb->folios[i])
+                       continue;
                folio_unlock(eb->folios[i]);
                folio_put(eb->folios[i]);
                eb->folios[i] = NULL;

And perhaps `struct folio *folio = eb->folios[i];` first and substitute.

Or is this unrelated and we need both?

And honestly, IMO, there's no reason to set the EXTENT_BUFFER_UNMAPPED
at all after this loop as it's just going to be freed.

        }
-       /*
-        * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
-        * so it can be cleaned up without utilizing folio->mapping.
-        */
-       set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
-
        btrfs_release_extent_buffer(eb);
+
        if (ret < 0)
                return ERR_PTR(ret);
+
        ASSERT(existing_eb);
        return existing_eb;
 }

>         }
>  }
>
> @@ -3365,8 +3370,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>          * btree_release_folio will correctly detect that a page belongs to a
>          * live buffer and won't free them prematurely.
>          */
> -       for (int i = 0; i < num_extent_folios(eb); i++)
> +       for (int i = 0; i < num_extent_folios(eb); i++) {
>                 folio_unlock(eb->folios[i]);
> +               /*
> +                * A folio that has been added to an address_space mapping
> +                * should not continue holding the refcount from its original
> +                * allocation indefinitely.
> +                */
> +               folio_put(eb->folios[i]);
> +       }
>         return eb;
>
>  out:
> --
> 2.49.0
>
>

