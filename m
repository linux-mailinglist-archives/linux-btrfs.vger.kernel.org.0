Return-Path: <linux-btrfs+bounces-13216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63AA96429
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17F33AEE52
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3FE1F5851;
	Tue, 22 Apr 2025 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bhIxhvhB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542101F4C8B
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313819; cv=none; b=jsf7xOnnoGOKC3z/+mPxe8blueQ+kZgXK6aPeLx9n3PQ0topUf+vWrCxU8iBBvvlU8FNUE9it5DUJFGniq9ZaY2WLTdT7ZgOMnO31tvFUCftYlwAWqHVJP7AUWD5Rt14xXjwQf2vAOsmWs1EeKePJm1FLvsCYQ36w/CchFZ2g0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313819; c=relaxed/simple;
	bh=g+arCTPfW3Ka2spVaV+IK5s9Y+qMXLQbqK9ywefbDrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdIfkq16ZSWKe7JUAcK4ntAZ4yAqMCZZ3nsVcLrtLEACeUCADKnwP8wv4qhoh9qkT1S0dPPiNeeunDbtoMcabm+0grLaq1+3c09yflRkriIzFQ4txD0Z4iLWhILnKl88MG/C2GIMJLp0foNEwS6P4qzEpT1hvRji4hzESVkB12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bhIxhvhB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2c663a3daso823543566b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745313815; x=1745918615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt5gOuX9WwblsKsXeSe4B56iFBrB3BYESHvwN+z/Zkk=;
        b=bhIxhvhB19nyx+OdsK6h11d8JIRv6PxSBIb8WpT44Rx6qsdOoDeh6j5/IDdndUOApq
         JrytGR7lWpTtjmQ6u5mfbDsx8ORLfz6PJ1RqlbzYoxUOlyWox2tPlikiQmYMHhtSYH6M
         8vwUyUmQxhqoUunJCs3vfnwGgyqmSwbVt/mimR8/1t1ZX5S+XzsdwnJmvzGABWdVR1AC
         nWu54kShkzdBWYLg63NT0VOm8Yg1VOMLn4ibdxEVXa7wTAxxMcrsyKviu70tw/3hpMK8
         s7wR074QYlfZ3hbVQdl2q6qZhAbL1DGDzA7NWcgTu0w/Hv/WrARPVWLuLMHt9k1uK5U9
         sY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745313815; x=1745918615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dt5gOuX9WwblsKsXeSe4B56iFBrB3BYESHvwN+z/Zkk=;
        b=UrHJnmLwpwlmFezDLwT+bTjDsYGYEqwUWtzoKm9saTx6ysyW2VFS3nhzSGbnSlYITz
         CrHrcXaDlTXa701KyclKSgDhcWacU0W8V715nCHsablR4qcSFlJN4CGbvNe/7by4bTkz
         QCHUnUdj7X0XFTLjYwpqP58KLAmgk1ktEs8S7CNUUW9IhtfAPJ3K9VTqnmU2LxQ4rqpZ
         HinO2Jlk0zp8B+3Bp9XAdp8p9NirEouEP6OU2bxwBMZmrgmmi5mQR67U7ZWAsTwbOVP7
         k5Q4xH8hqwTqmP8uP88g9srzq2Wyg0cLwyHdzgeAItr+y/Yr+1ydEWZzcRrKDW79byfw
         t2Hg==
X-Gm-Message-State: AOJu0YxXSH7xjK8M6CYihqT5nXUFJq3CLBB6rNkBQF2vTwXzWnMUMtcm
	/+0+qUq3o7h7jiLSw/2x1Bud9oYfVzASVuAOsg35sIe+YiI6WwjE24LwG61L+m2pY2wln4C5xDn
	5oerb77T5HCMn3aSdKNo5zzA8BbU3XrAOy9u7W0DfZyvI/ObX
X-Gm-Gg: ASbGncvNQEMrGeW598cPEAfBDTySvPnu6ETYbEmwH1ZjXSUqHFhcMfs6lH+T5BteMBf
	PR1xk37Ft7/hmqBsvD28uqocF81u0Pm10IfaTGG4JyjZe77MVaoaNCKJCGmPTx7zljfFSSD52wH
	fJVqeA/zV2hXKTOyaak0Bd
X-Google-Smtp-Source: AGHT+IGth3mTQT5fci0YnGkJZ0IHTaO8f6pgGfAdTJjtvImCUWMDsQDw1tdLpz2oZtJtYQoNkWX04OWNZ+nLsI/bZug=
X-Received: by 2002:a17:907:3f29:b0:ac8:197f:3ff6 with SMTP id
 a640c23a62f3a-acb74b82f91mr1502609366b.28.1745313815406; Tue, 22 Apr 2025
 02:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9441faad18d711ba7bccd2818e6762df0e948761.1745000301.git.boris@bur.io>
In-Reply-To: <9441faad18d711ba7bccd2818e6762df0e948761.1745000301.git.boris@bur.io>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 22 Apr 2025 11:23:24 +0200
X-Gm-Features: ATxdqUG5h0Skq2LzbH4K49_H_xjFFCH7ye8GyQ9BQtcHj8yzXkmbEcvX_5rWdHU
Message-ID: <CAPjX3FfxxbMN2hEO1TnKV9cSrYUZfdYNBogQFtKFdtgTebCXog@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: fix broken drop_caches on extent_buffer folios
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 20:24, Boris Burkov <boris@bur.io> wrote:
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
> However, we can still folio_put() them safely once they are finished
> being allocated and have called folio_attach_private().
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
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
>  fs/btrfs/extent_io.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5f08615b334f..a6c74c1957ff 100644
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
> @@ -2821,9 +2822,6 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
>                         continue;
>
>                 detach_extent_buffer_folio(eb, folio);
> -
> -               /* One for when we allocated the folio. */
> -               folio_put(folio);
>         }
>  }
>
> @@ -2889,6 +2887,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>                         return NULL;
>                 }
>                 WARN_ON(folio_test_dirty(folio));
> +               folio_put(folio);

Would this cause double puts in case the second iteration of the loop
fails to attach?

Other than that, it looks good to me.

>         }
>         copy_extent_buffer_full(new, src);
>         set_extent_buffer_uptodate(new);
> @@ -2915,6 +2914,8 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>                 if (ret < 0)
>                         goto out_detach;
>         }
> +       for (int i = 0; i < num_extent_folios(eb); i++)
> +               folio_put(eb->folios[i]);
>
>         set_extent_buffer_uptodate(eb);
>         btrfs_set_header_nritems(eb, 0);
> @@ -3365,8 +3366,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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

