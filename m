Return-Path: <linux-btrfs+bounces-13736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58573AACC11
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 19:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4299179920
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F6B27CB31;
	Tue,  6 May 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="alYGl3JR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1F38382
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551814; cv=none; b=U+68yrPkEaIqUydHsTMnxo+/91zx1kgdUgwGuaUQ5oN1g2liIaJMHfsVbnGULxBgcP8msg7NkIsbpaXe15GebxtOaHgThkwekQl9dVJfs5bGX7iBOID7kfGwH5cu3+Y0fEbW3fq4vXBTwbFowxtYHTQayreYLIQaUs4jHyLpx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551814; c=relaxed/simple;
	bh=4c8FEHiHf1q7X7bnEH6qJba7NWlh18oHeetsUjbIP2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/Yn+gsrbKQS56s8mlrqs6jIKT4a+lWwRNzT6kfSrgrauouZlGvN81jPvsvSUif9nZiquarWFBxJty8VUo+JQjBXxGmM4sZPdCaFw3ROeQ3USgs3u32ebAnqtg1eDSvwk1NCFK7nlVgNYpncPSFM/2VQrp7dKLY+3CLrR7G7/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=alYGl3JR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac34257295dso276684966b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 06 May 2025 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746551809; x=1747156609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u9JcENQqnynaoKnC0q0QWc4x6WuPboSvmL+Wpx9TkDU=;
        b=alYGl3JR5A6kGGZeA/GUY2XGe/MokysaGNd13YP/f6rfZu6pAeOG73R1br/YTKg7WH
         m4s7teAPtVeMZvEStQklfVDXDzKvnMEV6hkJjvH/VXkb6CjxFusL0OoNouVFIFIJPphc
         xyqc5VI4uuXd72x33ZPHWCkKHQsLVXQZj8mxxDTaPD8QvydJ0lF3JOWorP+VIGQimAps
         qb7JwV9Acx01oNtY5gx4WY13We4ugiYU6sVj/2RHeZCv45aJXkgztQ49ClGQizmnpeYo
         cF0XKR27DzaBT1h5yz5mkCqYNa7Olj5dEEK6PxC+n5MArjShYbyGfAku5JwvwrioW8dX
         UayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746551809; x=1747156609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9JcENQqnynaoKnC0q0QWc4x6WuPboSvmL+Wpx9TkDU=;
        b=PiTUquUvfZKKug+kYl51fZzMlLRHyaLl4/pEJo/qJWmQxRsGDqIb6K3jR4w5FhfMZL
         GZ8g0GK9qiniwoYsLlcwCrZgnR8BPZLetC3IQBwj/cc5NrhM/idkunX72nJComx2uzC+
         tr56C1iKXgMGiLdpmmpaHRrkN6ImOZxJAMe2MDL6YeRGuBpf2T5gfhkgHYI44S9QjIQA
         rTgrFIiz0dVlW9jXmyl72kk6w/Z6Lz5Dbkm5+VQh+ULaYjVM41pFo6DroiMOBZ3ZUTsq
         lH/gEKCqUxcSGYLTAfhlzv0GAMlUW3nNtYW+sjsz4QPGjUb0Y4MjUJcpIwkgFq9Uouia
         blBw==
X-Gm-Message-State: AOJu0YwXbJK8ADS7ypcdOc1tHJNXHLNqQnMzo9VGcU+n8RBgk5EbwQPx
	uuBuRasYcj5XtjaPyuWyl8TC5Vh3dbvjrRu/Y/WBUM+GINlM+SFbt3djxz/SVKPWKT+5cs7Cydc
	0hxdTsl5Q0stRZcOcUMEHOxXI2gUMkKmJZ7vOWAmbFQKLWFMOSRI=
X-Gm-Gg: ASbGncv6HOM0jITiTchneh7qVOm8Taz/44sX9IBxjRHKzwKlIbhPwH9eYPzvvJGb6Uz
	AxsRcVSNSH5OLIyOArf1D/kYja8m5oJcI2Q2RBxoHnrYFm48hBGdbF5rfwBZNcBV3kzGiA04T48
	j5588ZHa5DUvQ91LKr3yUh
X-Google-Smtp-Source: AGHT+IH+8EPXfNsPuiNx6PNmWIBmL34GNX68PVpSe7sGKeeTm+6a0/MyNq9YgskdgTXc0qBCu1WxCNJKWP3xBlr2BAk=
X-Received: by 2002:a17:906:ba90:b0:acb:63a4:e8e5 with SMTP id
 a640c23a62f3a-ad1e8b92457mr32830566b.6.1746551809226; Tue, 06 May 2025
 10:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b1fd74c27ccbc9f967f68e17a443c50411987e19.1746481493.git.boris@bur.io>
 <CAPjX3FdHRgRU4u+n2=JsEWz-yDghJ6xVjoFQtLPgNupVgE0etA@mail.gmail.com> <20250506163429.GA574131@zen.localdomain>
In-Reply-To: <20250506163429.GA574131@zen.localdomain>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 6 May 2025 19:16:38 +0200
X-Gm-Features: ATxdqUGM5Gh2qGdSRm3EWVHoLxrzxIPGoQnZbUYyFLHhIRCo5zmKn8H29efD6fc
Message-ID: <CAPjX3FdOr20qa-stn+ftFy65vdxczKjSg=7P3x14nVpKTPN2PA@mail.gmail.com>
Subject: Re: [PATCH v4] btrfs: fix broken drop_caches on extent buffer folios
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 18:33, Boris Burkov <boris@bur.io> wrote:
>
> On Tue, May 06, 2025 at 02:11:37PM +0200, Daniel Vacek wrote:
> > On Mon, 5 May 2025 at 23:48, Boris Burkov <boris@bur.io> wrote:
> > >
> > > The (correct) commit e41c81d0d30e ("mm/truncate: Replace page_mapped()
> > > call in invalidate_inode_page()") replaced the page_mapped(page) check
> > > with a refcount check. However, this refcount check does not work as
> > > expected with drop_caches for btrfs's metadata pages.
> > >
> > > Btrfs has a per-sb metadata inode with cached pages, and when not in
> > > active use by btrfs, they have a refcount of 3. One from the initial
> > > call to alloc_pages(), one (nr_pages == 1) from filemap_add_folio(), and
> > > one from folio_attach_private(). We would expect such pages to get dropped
> > > by drop_caches. However, drop_caches calls into mapping_evict_folio() via
> > > mapping_try_invalidate() which gets a reference on the folio with
> > > find_lock_entries(). As a result, these pages have a refcount of 4, and
> > > fail this check.
> > >
> > > For what it's worth, such pages do get reclaimed under memory pressure,
> > > so I would say that while this behavior is surprising, it is not really
> > > dangerously broken.
> > >
> > > When I asked the mm folks about the expected refcount in this case, I
> > > was told that the correct thing to do is to donate the refcount from the
> > > original allocation to the page cache after inserting it.
> > > https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/
> > >
> > > Therefore, attempt to fix this by adding a put_folio() to the critical
> > > spot in alloc_extent_buffer() where we are sure that we have really
> > > allocated and attached new pages. We must also adjust
> > > folio_detach_private() to properly handle being the last reference to the
> > > folio and not do a use-after-free after folio_detach_private().
> > >
> > > extent_buffers allocated by clone_extent_buffer() and
> > > alloc_dummy_extent_buffer() are unmapped, so this transfer of ownership
> > > from allocation to insertion in the mapping does not apply to them.
> > > However, we can still folio_put() them safely once they are finished
> > > being allocated and have called folio_attach_private().
> > >
> > > Finally, removing the generic put_folio() for the allocation from
> > > btrfs_detach_extent_buffer_folios() means we need to be careful to do
> > > the appropriate put_folio() in allocation failure paths in
> > > alloc_extent_buffer(), clone_extent_buffer() and
> > > alloc_dummy_extent_buffer.
> > >
> > > Link: https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.org/
> > > Tested-by: Klara Modin <klarasmodin@gmail.com>
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > > Note: Resending as V4 because of the convoluted history of this patch,
> > > the contributions from multiple reviewers/testers, and the non-trivial
> > > nature of the two merged patches.
> > >
> > > Changelog:
> > > v4:
> > > * merge Daniel Vacek's patch
> > >   "btrfs: put all allocated extent buffer folios in failure case"
> > >   which fixes the outstanding missing folio_put() calls on the partial
> > >   failure path of alloc_extent_buffer.
> > > v3:
> > > * call folio_put() before using extent_buffers allocated with
> > >   clone_extent_buffer() and alloc_dummy_extent_buffer() to get rid of
> > >   the UNMAPPED exception in btrfs_release_extent_buffer_folios().
> > > v2:
> > > * Used Filipe's suggestion to simplify detach_extent_buffer_folio and
> > >   lose the extra folio_get()/folio_put() pair
> > > * Noticed a memory leak causing failures in fstests on smaller vms.
> > >   Fixed a bug where I was missing a folio_put() for ebs that never got
> > >   their folios added to the mapping.
> > >
> > >
> > >  fs/btrfs/extent_io.c | 108 +++++++++++++++++++++++++------------------
> > >  1 file changed, 63 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index cbaee10e2ca8..884adc4d4f9d 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -2747,6 +2747,7 @@ static bool folio_range_has_eb(struct folio *folio)
> > >  static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct folio *folio)
> > >  {
> > >         struct btrfs_fs_info *fs_info = eb->fs_info;
> > > +       struct address_space *mapping = folio->mapping;
> > >         const bool mapped = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> > >
> > >         /*
> > > @@ -2754,11 +2755,11 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
> > >          * be done under the i_private_lock.
> > >          */
> > >         if (mapped)
> > > -               spin_lock(&folio->mapping->i_private_lock);
> > > +               spin_lock(&mapping->i_private_lock);
> > >
> > >         if (!folio_test_private(folio)) {
> > >                 if (mapped)
> > > -                       spin_unlock(&folio->mapping->i_private_lock);
> > > +                       spin_unlock(&mapping->i_private_lock);
> > >                 return;
> > >         }
> > >
> > > @@ -2777,7 +2778,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
> > >                         folio_detach_private(folio);
> > >                 }
> > >                 if (mapped)
> > > -                       spin_unlock(&folio->mapping->i_private_lock);
> > > +                       spin_unlock(&mapping->i_private_lock);
> > >                 return;
> > >         }
> > >
> > > @@ -2800,7 +2801,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
> > >         if (!folio_range_has_eb(folio))
> > >                 btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
> > >
> > > -       spin_unlock(&folio->mapping->i_private_lock);
> > > +       spin_unlock(&mapping->i_private_lock);
> > >  }
> > >
> > >  /* Release all folios attached to the extent buffer */
> > > @@ -2815,9 +2816,6 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
> > >                         continue;
> > >
> > >                 detach_extent_buffer_folio(eb, folio);
> > > -
> > > -               /* One for when we allocated the folio. */
> > > -               folio_put(folio);
> > >         }
> > >  }
> > >
> > > @@ -2852,6 +2850,21 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
> > >         return eb;
> > >  }
> > >
> > > +/*
> > > + * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
> > > + * does not call folio_put(), and we need to set the folios to NULL so that
> > > + * btrfs_release_extent_buffer() will not detach them a second time.
> > > + */
> > > +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> > > +{
> > > +       for (int i = 0; i < num_extent_folios(eb); i++) {
> >
> > This is a nice cleanup and I like it. Though I think you need to
> >
> > for (int i = 0, num_folios = num_extent_folios(eb); i < num_folios; i++) {
> >
> > otherwise the second iteration compares i < 0 after eb->folios[0] is
> > set to NULL in the first iteration. This is where my v1 failed.
> >
>
> Oh, wow. Thanks. Missed that as what went wrong in your first try.
> I really wish we had some code that actually hit these cases :)

I think you blinded yourself with
https://lore.kernel.org/linux-btrfs/a17705cfccb9cb49d48c393fd0f46bdb4281b556.1745618308.git.boris@bur.io/

I was getting hard crashes with NULL pointer dereference before this.

> Maybe time to try to write some unit tests.
>
> > > +               ASSERT(eb->folios[i]);
> > > +               detach_extent_buffer_folio(eb, eb->folios[i]);
> > > +               folio_put(eb->folios[i]);
> > > +               eb->folios[i] = NULL;
> > > +       }
> > > +}
> > > +
> > >  struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
> > >  {
> > >         struct extent_buffer *new;
> > > @@ -2869,25 +2882,30 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
> > >         set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
> > >
> > >         ret = alloc_eb_folio_array(new, false);
> > > -       if (ret) {
> > > -               btrfs_release_extent_buffer(new);
> > > -               return NULL;
> > > -       }
> > > +       if (ret)
> > > +               goto release_eb;
> > >
> > >         for (int i = 0; i < num_extent_folios(src); i++) {
> >
> > Should `src` be rather `new` here?
> >
>
> I think they are equal, right, since itt's a clone. This line didn't change
> and I don't see why it would need to. Happy to change it if we think it
> makes more sense.

Oh, my bad. Of course it did not change. I must have noticed the other
one first and then checked and commented on both overlooking this one
is not new.

Yes, I believe they should be equal, it's just that `src` is not the
one used in the loop block. The code is clearly looping over `new`.

> > >                 struct folio *folio = new->folios[i];
> > >
> > >                 ret = attach_extent_buffer_folio(new, folio, NULL);
> > > -               if (ret < 0) {
> > > -                       btrfs_release_extent_buffer(new);
> > > -                       return NULL;
> > > -               }
> > > +               if (ret < 0)
> > > +                       goto cleanup_folios;
> > >                 WARN_ON(folio_test_dirty(folio));
> > >         }
> > > +       for (int i = 0; i < num_extent_folios(src); i++)
> >
> > The same.
> >
>
> This one makes more sense to me, since it's new and is for putting the
> folios in new. HOWEVER, that might theoretically run afoul of the same
> bug with num_extent_folios() changing answer mid loop. So maybe best to
> store num_extent_folios(src) in a variable ahead of all of this?

I don't think putting a reference to folio would change the value
here. Would it?

I believe you would have to set src->folios[0] to NULL to break the iteration.

So while strictly not needed, caching the loop count may still be a
slight optimization. I just did not mention it as it is not strictly
necessary and most loops follow this pattern.

> > > +               folio_put(new->folios[i]);
> > > +
> > >         copy_extent_buffer_full(new, src);
> > >         set_extent_buffer_uptodate(new);
> > >
> > >         return new;
> > > +
> > > +cleanup_folios:
> > > +       cleanup_extent_buffer_folios(new);
> > > +release_eb:
> > > +       btrfs_release_extent_buffer(new);
> > > +       return NULL;
> > >  }
> > >
> > >  struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> > > @@ -2902,13 +2920,15 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> > >
> > >         ret = alloc_eb_folio_array(eb, false);
> > >         if (ret)
> > > -               goto out;
> > > +               goto release_eb;
> > >
> > >         for (int i = 0; i < num_extent_folios(eb); i++) {
> > >                 ret = attach_extent_buffer_folio(eb, eb->folios[i], NULL);
> > >                 if (ret < 0)
> > > -                       goto out_detach;
> > > +                       goto cleanup_folios;
> > >         }
> > > +       for (int i = 0; i < num_extent_folios(eb); i++)
> > > +               folio_put(eb->folios[i]);
> > >
> > >         set_extent_buffer_uptodate(eb);
> > >         btrfs_set_header_nritems(eb, 0);
> > > @@ -2916,15 +2936,10 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> > >
> > >         return eb;
> > >
> > > -out_detach:
> > > -       for (int i = 0; i < num_extent_folios(eb); i++) {
> > > -               if (eb->folios[i]) {
> > > -                       detach_extent_buffer_folio(eb, eb->folios[i]);
> > > -                       folio_put(eb->folios[i]);
> > > -               }
> > > -       }
> > > -out:
> > > -       kmem_cache_free(extent_buffer_cache, eb);
> > > +cleanup_folios:
> > > +       cleanup_extent_buffer_folios(eb);
> > > +release_eb:
> > > +       btrfs_release_extent_buffer(eb);
> > >         return NULL;
> > >  }
> > >
> > > @@ -3357,8 +3372,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> > >          * btree_release_folio will correctly detect that a page belongs to a
> > >          * live buffer and won't free them prematurely.
> > >          */
> > > -       for (int i = 0; i < num_extent_folios(eb); i++)
> > > +       for (int i = 0; i < num_extent_folios(eb); i++) {
> > >                 folio_unlock(eb->folios[i]);
> > > +               /*
> > > +                * A folio that has been added to an address_space mapping
> > > +                * should not continue holding the refcount from its original
> > > +                * allocation indefinitely.
> > > +                */
> > > +               folio_put(eb->folios[i]);
> > > +       }
> > >         return eb;
> > >
> > >  out:
> > > @@ -3371,30 +3393,26 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> > >          * we'll lookup the folio for that index, and grab that EB.  We do not
> > >          * want that to grab this eb, as we're getting ready to free it.  So we
> > >          * have to detach it first and then unlock it.
> > > -        *
> > > -        * We have to drop our reference and NULL it out here because in the
> > > -        * subpage case detaching does a btrfs_folio_dec_eb_refs() for our eb.
> > > -        * Below when we call btrfs_release_extent_buffer() we will call
> > > -        * detach_extent_buffer_folio() on our remaining pages in the !subpage
> > > -        * case.  If we left eb->folios[i] populated in the subpage case we'd
> > > -        * double put our reference and be super sad.
> > >          */
> > > -       for (int i = 0; i < attached; i++) {
> > > -               ASSERT(eb->folios[i]);
> > > -               detach_extent_buffer_folio(eb, eb->folios[i]);
> > > -               folio_unlock(eb->folios[i]);
> > > -               folio_put(eb->folios[i]);
> > > +       for (int i = 0; i < num_extent_pages(eb); i++) {
> > > +               struct folio *folio = eb->folios[i];
> > > +
> > > +               if (i < attached) {
> > > +                       ASSERT(folio);
> > > +                       detach_extent_buffer_folio(eb, folio);
> > > +                       folio_unlock(folio);
> > > +               } else if (!folio)
> > > +                       continue;
> > > +
> > > +               ASSERT(!folio_test_private(folio));
> > > +               folio_put(folio);
> > >                 eb->folios[i] = NULL;
> > >         }
> > > -       /*
> > > -        * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
> > > -        * so it can be cleaned up without utilizing folio->mapping.
> > > -        */
> > > -       set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> > > -
> > >         btrfs_release_extent_buffer(eb);
> > > +
> > >         if (ret < 0)
> > >                 return ERR_PTR(ret);
> > > +
> > >         ASSERT(existing_eb);
> > >         return existing_eb;
> > >  }
> > > --
> > > 2.49.0
> > >
> > >

