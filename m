Return-Path: <linux-btrfs+bounces-13724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133BAAAC3AD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 14:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A463AC270
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02EB27FB07;
	Tue,  6 May 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SGYxuBV7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0071DDE9
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533871; cv=none; b=HB3SuHWUmE7u8vtA6bBxvsrxNUDVSauHcNrI9JG3V0UGbQkYi32Umi7nIlVpfmCOV1+SsYdRkMJP7wVSR0VC5LfYZ1Jh071HQ/LR05Cxsi3jy24IIPgor9AzHNH8xtFwPSxDmpka7Vy39uLFzXHHeNO5zMLSroQ6OsVWlErA73Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533871; c=relaxed/simple;
	bh=hyilGf+B2SQ40H0nDDt5AA3F3gT9O2i0/C7ae6jJddw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxjPuykQTc6ftc6ADgLlkxDynO+Vgsra4EYIuIvGfHWKkN84jwM3z/BMUUpu+T4fHQn++euyPrc9hB6RSecV3UGVOgsaeJPs4QWCsA0NgxgUyFAlpNnZ2ArkzzrE3YxzpY24mjjkbmFMe7hXbyWmT0neU8iHOVs78jPMqdxJySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SGYxuBV7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso288923766b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 May 2025 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746533865; x=1747138665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxf6bRr+iBL1eoGo0M7apeBq39aEo1KvXJxmKUCJYMw=;
        b=SGYxuBV7O8K512w/fK7azyOZBlrH5eejEtp7nyLEPl6laUpwHhw9YCO+VVSrnXMcEz
         kM0o0RnL34J6avsrEv/S4Z1LYPv8m0MDH2QG73GoVkly//0tS/exHa9Zw//2RYDcwrpq
         NbrFYfB+leAJx3alvu6yfmVpDReQQ/TVsbdVKkV4KJdX3b7vfVrji78ftfb5EKoEoGhZ
         5oQP1OrGq8FSNkUCwFansk//OW5S7wZ+EP9pQeWqq35H7E7BPvozm6e4+GY6LrtIeIpi
         TUIJOdTsuyJAQAA2u8FpQ3PclbooT4wjfC2bLk2bfbN6uh+O6NcWn8CDBc/c+RVIfFEr
         KIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746533865; x=1747138665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxf6bRr+iBL1eoGo0M7apeBq39aEo1KvXJxmKUCJYMw=;
        b=HbrxWKSriMCpdLVpsK/PmpBqwSpj3UdNh5l05btPmafzb0KD9y7Tuzn3TlXshl8B6R
         YoDNc0Qhdycn8PncVDNEaidX/b7gBq25t6qH1RX6DHs0TovVNWrfYfjTyZf3f7iI1twZ
         F3YlF9bCzyMRZKSpP0fnwsVpR5Oln5qCak/UajEIPqaAjMbQ8JVk8Ja7iB/RXNlKMLQr
         j2CxiXlfOan3OMv1ZJ5G7Yv5xoZ9jsp66DbXg1RUDboVtJnGwKjs5WKItO8lzhRa0/sM
         zN8EUgTBtjRYEe3Mg753xf3K3VZSAumdVBIIdj/Q8dR4XxhMg9MsojV28XLKPc89GQfa
         V9lg==
X-Forwarded-Encrypted: i=1; AJvYcCXjT1jMF/pztnwx2yJQnbl8oEOKB04bAPIkyhkhifmEE758O99jBNT6YRBP6SqoFJ2zjBFpouzmNp5/Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCA8+gujr7vS7CnYZt87qiwir6JOKj9qMAbOzdlMaPmQKRFiD
	wS74bFKV78wsuEI9YP2hoBzqa3T/KLLCSVwWuxHPqYTkrr6AqKuR0b7RpmlIq03yeqgfzO3x+VA
	9KLmCrEI7DyNlDP0puotP5M3WHVd2ODcVwuXeHA==
X-Gm-Gg: ASbGnctT0aFjdgVB+WyOWw1yG1ChfS7VTts368MbDnXpCrAmmDgeE10rfWEQ0h1AH6c
	gStysd4kjCVWye7fsLnMvf9uzcmvIhGGLarmtu7puEnjEp2QL8qwGzWPjG7rZJY14t+IPkjesbR
	73CzhYZtBT/04TlJZ93m/F
X-Google-Smtp-Source: AGHT+IFaY9NTx6t63Rf5eGzX0h1Pmb3SGuRTLLcpsidynUfFNSFMEv2kzXPv3sTeqUtupPi2t6aNWcxO1tzzfgQT+pM=
X-Received: by 2002:a17:907:6e94:b0:acb:ba01:4a4 with SMTP id
 a640c23a62f3a-ad1a48bcf72mr1154740666b.3.1746533864534; Tue, 06 May 2025
 05:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b1fd74c27ccbc9f967f68e17a443c50411987e19.1746481493.git.boris@bur.io>
 <CAL3q7H5aL=MwYnX54RnLRZzt8baSDqnHD7MMzsDwM93RwSMT4w@mail.gmail.com>
In-Reply-To: <CAL3q7H5aL=MwYnX54RnLRZzt8baSDqnHD7MMzsDwM93RwSMT4w@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 6 May 2025 14:17:32 +0200
X-Gm-Features: ATxdqUEBYamXnmT3glOZqOcKy2FvtvHuMwd151VpyeehMoYe-KAp651uxOO66Fg
Message-ID: <CAPjX3Fc+wML3U34NXfzQtexvSm=vWdP-fLO3yV0LE1ekWx8+yw@mail.gmail.com>
Subject: Re: [PATCH v4] btrfs: fix broken drop_caches on extent buffer folios
To: Filipe Manana <fdmanana@kernel.org>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 6 May 2025 at 12:58, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Mon, May 5, 2025 at 10:48=E2=80=AFPM Boris Burkov <boris@bur.io> wrote=
:
> >
> > The (correct) commit e41c81d0d30e ("mm/truncate: Replace page_mapped()
> > call in invalidate_inode_page()") replaced the page_mapped(page) check
> > with a refcount check. However, this refcount check does not work as
> > expected with drop_caches for btrfs's metadata pages.
> >
> > Btrfs has a per-sb metadata inode with cached pages, and when not in
> > active use by btrfs, they have a refcount of 3. One from the initial
> > call to alloc_pages(), one (nr_pages =3D=3D 1) from filemap_add_folio()=
, and
> > one from folio_attach_private(). We would expect such pages to get drop=
ped
> > by drop_caches. However, drop_caches calls into mapping_evict_folio() v=
ia
> > mapping_try_invalidate() which gets a reference on the folio with
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
>
> The link here after ending a sentence and without any spacing or
> introduction seems unintentional?
> It's already in the Link tag at the bottom, so there's no need to have
> it twice in the change log.
>
> >
> > Therefore, attempt to fix this by adding a put_folio() to the critical
> > spot in alloc_extent_buffer() where we are sure that we have really
> > allocated and attached new pages. We must also adjust
> > folio_detach_private() to properly handle being the last reference to t=
he
> > folio and not do a use-after-free after folio_detach_private().
> >
> > extent_buffers allocated by clone_extent_buffer() and
> > alloc_dummy_extent_buffer() are unmapped, so this transfer of ownership
> > from allocation to insertion in the mapping does not apply to them.
> > However, we can still folio_put() them safely once they are finished
> > being allocated and have called folio_attach_private().
> >
> > Finally, removing the generic put_folio() for the allocation from
> > btrfs_detach_extent_buffer_folios() means we need to be careful to do
> > the appropriate put_folio() in allocation failure paths in
> > alloc_extent_buffer(), clone_extent_buffer() and
> > alloc_dummy_extent_buffer.
> >
> > Link: https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradea=
d.org/
> > Tested-by: Klara Modin <klarasmodin@gmail.com>
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Note: Resending as V4 because of the convoluted history of this patch,
> > the contributions from multiple reviewers/testers, and the non-trivial
> > nature of the two merged patches.
> >
> > Changelog:
> > v4:
> > * merge Daniel Vacek's patch
> >   "btrfs: put all allocated extent buffer folios in failure case"
> >   which fixes the outstanding missing folio_put() calls on the partial
> >   failure path of alloc_extent_buffer.
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
> >  fs/btrfs/extent_io.c | 108 +++++++++++++++++++++++++------------------
> >  1 file changed, 63 insertions(+), 45 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index cbaee10e2ca8..884adc4d4f9d 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2747,6 +2747,7 @@ static bool folio_range_has_eb(struct folio *foli=
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
> > @@ -2754,11 +2755,11 @@ static void detach_extent_buffer_folio(const st=
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
> > @@ -2777,7 +2778,7 @@ static void detach_extent_buffer_folio(const stru=
ct extent_buffer *eb, struct fo
> >                         folio_detach_private(folio);
> >                 }
> >                 if (mapped)
> > -                       spin_unlock(&folio->mapping->i_private_lock);
> > +                       spin_unlock(&mapping->i_private_lock);
> >                 return;
> >         }
> >
> > @@ -2800,7 +2801,7 @@ static void detach_extent_buffer_folio(const stru=
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
> > @@ -2815,9 +2816,6 @@ static void btrfs_release_extent_buffer_folios(co=
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
> > @@ -2852,6 +2850,21 @@ static struct extent_buffer *__alloc_extent_buff=
er(struct btrfs_fs_info *fs_info
> >         return eb;
> >  }
> >
> > +/*
> > + * For use in eb allocation error cleanup paths, as btrfs_release_exte=
nt_buffer()
> > + * does not call folio_put(), and we need to set the folios to NULL so=
 that
> > + * btrfs_release_extent_buffer() will not detach them a second time.
> > + */
> > +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> > +{
> > +       for (int i =3D 0; i < num_extent_folios(eb); i++) {
> > +               ASSERT(eb->folios[i]);
> > +               detach_extent_buffer_folio(eb, eb->folios[i]);
> > +               folio_put(eb->folios[i]);
> > +               eb->folios[i] =3D NULL;
> > +       }
> > +}
> > +
> >  struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_bu=
ffer *src)
> >  {
> >         struct extent_buffer *new;
> > @@ -2869,25 +2882,30 @@ struct extent_buffer *btrfs_clone_extent_buffer=
(const struct extent_buffer *src)
> >         set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
> >
> >         ret =3D alloc_eb_folio_array(new, false);
> > -       if (ret) {
> > -               btrfs_release_extent_buffer(new);
> > -               return NULL;
> > -       }
> > +       if (ret)
> > +               goto release_eb;
> >
> >         for (int i =3D 0; i < num_extent_folios(src); i++) {
> >                 struct folio *folio =3D new->folios[i];
> >
> >                 ret =3D attach_extent_buffer_folio(new, folio, NULL);
> > -               if (ret < 0) {
> > -                       btrfs_release_extent_buffer(new);
> > -                       return NULL;
> > -               }
> > +               if (ret < 0)
> > +                       goto cleanup_folios;
> >                 WARN_ON(folio_test_dirty(folio));
> >         }
> > +       for (int i =3D 0; i < num_extent_folios(src); i++)
> > +               folio_put(new->folios[i]);
> > +
> >         copy_extent_buffer_full(new, src);
> >         set_extent_buffer_uptodate(new);
> >
> >         return new;
> > +
> > +cleanup_folios:
> > +       cleanup_extent_buffer_folios(new);
> > +release_eb:
> > +       btrfs_release_extent_buffer(new);
> > +       return NULL;
> >  }
> >
> >  struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *=
fs_info,
> > @@ -2902,13 +2920,15 @@ struct extent_buffer *alloc_dummy_extent_buffer=
(struct btrfs_fs_info *fs_info,
> >
> >         ret =3D alloc_eb_folio_array(eb, false);
> >         if (ret)
> > -               goto out;
> > +               goto release_eb;
> >
> >         for (int i =3D 0; i < num_extent_folios(eb); i++) {
> >                 ret =3D attach_extent_buffer_folio(eb, eb->folios[i], N=
ULL);
> >                 if (ret < 0)
> > -                       goto out_detach;
> > +                       goto cleanup_folios;
> >         }
> > +       for (int i =3D 0; i < num_extent_folios(eb); i++)
> > +               folio_put(eb->folios[i]);
> >
> >         set_extent_buffer_uptodate(eb);
> >         btrfs_set_header_nritems(eb, 0);
> > @@ -2916,15 +2936,10 @@ struct extent_buffer *alloc_dummy_extent_buffer=
(struct btrfs_fs_info *fs_info,
> >
> >         return eb;
> >
> > -out_detach:
> > -       for (int i =3D 0; i < num_extent_folios(eb); i++) {
> > -               if (eb->folios[i]) {
> > -                       detach_extent_buffer_folio(eb, eb->folios[i]);
> > -                       folio_put(eb->folios[i]);
> > -               }
> > -       }
> > -out:
> > -       kmem_cache_free(extent_buffer_cache, eb);
> > +cleanup_folios:
> > +       cleanup_extent_buffer_folios(eb);
> > +release_eb:
> > +       btrfs_release_extent_buffer(eb);
> >         return NULL;
> >  }
> >
> > @@ -3357,8 +3372,15 @@ struct extent_buffer *alloc_extent_buffer(struct=
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
> > @@ -3371,30 +3393,26 @@ struct extent_buffer *alloc_extent_buffer(struc=
t btrfs_fs_info *fs_info,
> >          * we'll lookup the folio for that index, and grab that EB.  We=
 do not
> >          * want that to grab this eb, as we're getting ready to free it=
.  So we
> >          * have to detach it first and then unlock it.
> > -        *
> > -        * We have to drop our reference and NULL it out here because i=
n the
> > -        * subpage case detaching does a btrfs_folio_dec_eb_refs() for =
our eb.
> > -        * Below when we call btrfs_release_extent_buffer() we will cal=
l
> > -        * detach_extent_buffer_folio() on our remaining pages in the !=
subpage
> > -        * case.  If we left eb->folios[i] populated in the subpage cas=
e we'd
> > -        * double put our reference and be super sad.
> >          */
> > -       for (int i =3D 0; i < attached; i++) {
> > -               ASSERT(eb->folios[i]);
> > -               detach_extent_buffer_folio(eb, eb->folios[i]);
> > -               folio_unlock(eb->folios[i]);
> > -               folio_put(eb->folios[i]);
> > +       for (int i =3D 0; i < num_extent_pages(eb); i++) {
> > +               struct folio *folio =3D eb->folios[i];
> > +
> > +               if (i < attached) {
> > +                       ASSERT(folio);
> > +                       detach_extent_buffer_folio(eb, folio);
> > +                       folio_unlock(folio);
> > +               } else if (!folio)
> > +                       continue;
>
> Please put the else part with { } too, that's part of the general
> coding style preference.
>
> > +
> > +               ASSERT(!folio_test_private(folio));
> > +               folio_put(folio);
> >                 eb->folios[i] =3D NULL;
> >         }
> > -       /*
> > -        * Now all pages of that extent buffer is unmapped, set UNMAPPE=
D flag,
> > -        * so it can be cleaned up without utilizing folio->mapping.
> > -        */
> > -       set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> > -
> >         btrfs_release_extent_buffer(eb);
> > +
> >         if (ret < 0)
> >                 return ERR_PTR(ret);
> > +
>
> These two stray new lines seem accidental and unrelated to the code chang=
es.

I did those just to be a bit more readable and to emphasize the
btrfs_release_extent_buffer(eb) belongs closely to the loop. Well,
after the loop. But logically complementing it's job.

But I don't really mind.

> With those minor things changed:
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks.
>
>
>
> >         ASSERT(existing_eb);
> >         return existing_eb;
> >  }
> > --
> > 2.49.0
> >
> >
>

