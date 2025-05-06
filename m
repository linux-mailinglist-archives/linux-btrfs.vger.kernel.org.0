Return-Path: <linux-btrfs+bounces-13739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C604DAACC38
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 19:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F15160A6F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD2284B49;
	Tue,  6 May 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VFXcaOY6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED9227574
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552532; cv=none; b=XSEcdqGuErAZWnlGhmvjOthrT6gnWiQvYVNTjTvB5AKLRJRjR3iRuXlMgQvE9YWaOXC0XMeBi2W2vEKZo++hs7T2iJQ+/+lB9HwEanhC7BadX1dB+09S/OY4CfCvxIcGWc8uwmBXaOC0ccN+jn52JbilsU+bDyZg2YyY0/A8LAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552532; c=relaxed/simple;
	bh=nflriQtPmeEggUCkSLd+tiFD656ZM97ZDuNSOdqBWxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtkTO0UzvdBHnK0JnvTaiQr9nftgTSwA360EHZvjUppuYJcKBIbZSiyve30EbbXrrn5LHHeaeHn7uo+fOf+QqIdUtl+PlQca4z8I/zLLj2QiO+QebYM+sXwfYp9jvgFxbZImkhs40ffXooqDDwabifx0p4/zCbhEHkivV8o4dlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VFXcaOY6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so850475466b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 May 2025 10:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746552528; x=1747157328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iuspk8OA2n/Ff65BomVUhcEaj7//iH/OlfywadzmWcU=;
        b=VFXcaOY6+ltlrkXnJH9MCwfS0GCNk0TsXC0ry+Ons72tjQjugQG0EMM6R2PGCElkkF
         VtxeBafXeprKs8FZ5cujFqx587nKbSu537tw3KbutKak22Ld9BnokWffVVZVAtnC5xpE
         xGhdRyo1Kq/oeCet/uAfP8eLb/QJerCG/3wGFUxBfLJOE2xXnNTEUp2gEw7eJ1jimOfX
         N7LthnwMg8nirmGusUovXSipaqI8ITltnnyDFV53vIRLVR/5PinjpRvWTkoMlAnovyqo
         9YeSyGXzKC0aeWqrAbf2Kie5XcwE+er4t8orNYGlsNvr0wWN8AK+sIp3fTWNgH46xOOM
         I19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746552528; x=1747157328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuspk8OA2n/Ff65BomVUhcEaj7//iH/OlfywadzmWcU=;
        b=oMzxKaVezk5JpnYZXP7HfYbj+usbCDzGeM8M2MKWYTubLMR3/kWWTkBkwL5B03AeJi
         W1IQDXnFhPDL6IyWZ21HAAyEHO9A+Xfi+3K99HppNy/6cUxv6fJaroBBVdX06KS+AZRX
         8p9etSGm9UKlAjULBrlLlzBq1UdWcrclIcP7jLLJoMVp2ariAiY+wSk+gATd5lVKa8S/
         VECgQJVyJQwZiuRsZpoRcuZMQx3Y1d7dkuXLV+4a3IgNF/1Z3Wz3LWlqWqs1NgxUFYi8
         LfK3cdfEpUlYOs/qi63sX3Yf7U0WehHkzWibe3Ceq63YDNowe4JAqG8/IslPAaip07ON
         RFFA==
X-Gm-Message-State: AOJu0Yxauz5y5HYOD934F0u8fjyIODPW9mOpN1t5h6M6+u1lIhKbUxxw
	eOxEW6ODxORgje7cZmcvnVSby85zHhvr34VAzRY6Wa/KxLoe4jVRBncRf+158wEm7u4SGSPr4Io
	9CQVuB6tCuZCfl/uKe8LsVSwYv3jYufUUNUFtxePmR9bGmo5v
X-Gm-Gg: ASbGncvHMK2pvkWfyzQqOMvpU/oHZF1i/HxLv6DtkOyLeBsKq3AAhJN4UrPMCZ+e/zx
	e2BlkEQeDejwCGcfJ142r4JpwFV8gw5MYw3VCDpZnjo5LNWk/P3SnYL2HzWB0o+7VmyU/oFgWck
	o9TiiqZAHdBec5HtpEkjrd
X-Google-Smtp-Source: AGHT+IFM0E7p35FoWp+PHM2p7f3Yh/Ldf7xn7Gazb3xcPuCCOA9uAb3ZoQcch0nl31z8P2CdnwwVKWiXNOq0uq76si4=
X-Received: by 2002:a17:907:c1e:b0:ace:3a1b:d3d with SMTP id
 a640c23a62f3a-ad1e8cace5fmr32602366b.2.1746552527678; Tue, 06 May 2025
 10:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
In-Reply-To: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 6 May 2025 19:28:36 +0200
X-Gm-Features: ATxdqUGkLIJlmdSV4OyG9-mKwq4b0GqrMrTe7uaReb33jSx5YybNawYMtjwgiuw
Message-ID: <CAPjX3Fekb=F-xgs0hwCXCr86CnOkizdLUdYrS6tJfaSj8+bfRg@mail.gmail.com>
Subject: Re: [PATCH v5] btrfs: fix broken drop_caches on extent buffer folios
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fdmanana@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 18:46, Boris Burkov <boris@bur.io> wrote:
>
> The (correct) commit e41c81d0d30e ("mm/truncate: Replace page_mapped()
> call in invalidate_inode_page()") replaced the page_mapped(page) check
> with a refcount check. However, this refcount check does not work as
> expected with drop_caches for btrfs's metadata pages.
>
> Btrfs has a per-sb metadata inode with cached pages, and when not in
> active use by btrfs, they have a refcount of 3. One from the initial
> call to alloc_pages(), one (nr_pages == 1) from filemap_add_folio(), and
> one from folio_attach_private(). We would expect such pages to get dropped
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
> Link: https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/
> Tested-by: Klara Modin <klarasmodin@gmail.com>
> Signed-off-by: Boris Burkov <boris@bur.io>
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
>  static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct folio *folio)
>  {
>         struct btrfs_fs_info *fs_info = eb->fs_info;
> +       struct address_space *mapping = folio->mapping;
>         const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
>
>         /*
> @@ -2754,11 +2755,11 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
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
> @@ -2777,7 +2778,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
>                         folio_detach_private(folio);
>                 }
>                 if (mapped)
> -                       spin_unlock(&folio->mapping->i_private_lock);
> +                       spin_unlock(&mapping->i_private_lock);
>                 return;
>         }
>
> @@ -2800,7 +2801,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
>         if (!folio_range_has_eb(folio))
>                 btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
>
> -       spin_unlock(&folio->mapping->i_private_lock);
> +       spin_unlock(&mapping->i_private_lock);
>  }
>
>  /* Release all folios attached to the extent buffer */
> @@ -2815,9 +2816,6 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
>                         continue;
>
>                 detach_extent_buffer_folio(eb, folio);
> -
> -               /* One for when we allocated the folio. */
> -               folio_put(folio);
>         }
>  }
>
> @@ -2852,9 +2850,27 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
>         return eb;
>  }
>
> +/*
> + * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
> + * does not call folio_put(), and we need to set the folios to NULL so that
> + * btrfs_release_extent_buffer() will not detach them a second time.
> + */
> +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> +{
> +       int num_folios = num_extent_folios(eb);
> +
> +       for (int i = 0; i < num_folios; i++) {
> +               ASSERT(eb->folios[i]);
> +               detach_extent_buffer_folio(eb, eb->folios[i]);
> +               folio_put(eb->folios[i]);
> +               eb->folios[i] = NULL;
> +       }
> +}
> +
>  struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>  {
>         struct extent_buffer *new;
> +       int num_folios;
>         int ret;
>
>         new = __alloc_extent_buffer(src->fs_info, src->start);
> @@ -2869,25 +2885,33 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>         set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>
>         ret = alloc_eb_folio_array(new, false);
> -       if (ret) {
> -               btrfs_release_extent_buffer(new);
> -               return NULL;
> -       }
> +       if (ret)
> +               goto release_eb;
>
> -       for (int i = 0; i < num_extent_folios(src); i++) {
> +       ASSERT(num_extent_folios(src) == num_extent_folios(new),
> +              "%d != %d", num_extent_folios(src), num_extent_folios(new));
> +       num_folios = num_extent_folios(src);

I meant using `new` here but the assert makes it explicit that they
are the same now.

Nice, thanks.

Reviewed-by: Daniel Vacek <neelx@suse.com>

> +       for (int i = 0; i < num_folios; i++) {
>                 struct folio *folio = new->folios[i];
>
>                 ret = attach_extent_buffer_folio(new, folio, NULL);
> -               if (ret < 0) {
> -                       btrfs_release_extent_buffer(new);
> -                       return NULL;
> -               }
> +               if (ret < 0)
> +                       goto cleanup_folios;
>                 WARN_ON(folio_test_dirty(folio));
>         }
> +       for (int i = 0; i < num_folios; i++)
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
>  struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> @@ -2902,13 +2926,15 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>
>         ret = alloc_eb_folio_array(eb, false);
>         if (ret)
> -               goto out;
> +               goto release_eb;
>
>         for (int i = 0; i < num_extent_folios(eb); i++) {
>                 ret = attach_extent_buffer_folio(eb, eb->folios[i], NULL);
>                 if (ret < 0)
> -                       goto out_detach;
> +                       goto cleanup_folios;
>         }
> +       for (int i = 0; i < num_extent_folios(eb); i++)
> +               folio_put(eb->folios[i]);
>
>         set_extent_buffer_uptodate(eb);
>         btrfs_set_header_nritems(eb, 0);
> @@ -2916,15 +2942,10 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>
>         return eb;
>
> -out_detach:
> -       for (int i = 0; i < num_extent_folios(eb); i++) {
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
> @@ -3357,8 +3378,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
> @@ -3371,27 +3399,22 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>          * we'll lookup the folio for that index, and grab that EB.  We do not
>          * want that to grab this eb, as we're getting ready to free it.  So we
>          * have to detach it first and then unlock it.
> -        *
> -        * We have to drop our reference and NULL it out here because in the
> -        * subpage case detaching does a btrfs_folio_dec_eb_refs() for our eb.
> -        * Below when we call btrfs_release_extent_buffer() we will call
> -        * detach_extent_buffer_folio() on our remaining pages in the !subpage
> -        * case.  If we left eb->folios[i] populated in the subpage case we'd
> -        * double put our reference and be super sad.
>          */
> -       for (int i = 0; i < attached; i++) {
> -               ASSERT(eb->folios[i]);
> -               detach_extent_buffer_folio(eb, eb->folios[i]);
> -               folio_unlock(eb->folios[i]);
> -               folio_put(eb->folios[i]);
> +       for (int i = 0; i < num_extent_pages(eb); i++) {
> +               struct folio *folio = eb->folios[i];
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
>                 eb->folios[i] = NULL;
>         }
> -       /*
> -        * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
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

