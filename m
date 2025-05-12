Return-Path: <linux-btrfs+bounces-13889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26CAB3BA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604C03B813C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6825C2356A0;
	Mon, 12 May 2025 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gJ4bjfSK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E0621578F
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062451; cv=none; b=fsB2DcoFdefP7ju/QY53rylzQnmSysn4yjMBFh0SuhMopjrfxFEmxBcbG2Kg0pmxP0wivpUTqVB6PzocMgFyJfn+TbwZ4RU8Zvw0qsGTNC0hhLUohz86Q4LBYsG0PF5FpfXoATAhHqEM3Pc68cfl3bi1Hnd2KSA2Xtn3Xj0Y+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062451; c=relaxed/simple;
	bh=QIz7wem/VuGCpsFa+UaqqI6qpDOgSj7niMTb25b+5C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfmyOL9BJpeVM9ikbZ7ZMmSZnsCiUEApBS88+aUXOu1/iXxWZGOIgpqAcqb96aEZEygYn3Whjq2VTX0cwpb7STYXZgM5flVzfnjUg+XMr6ey/8WvZfDa5TekzJjmdVDh8HXb44QiMiB45vegwwX779FAJ9o51evk2xxi5MsOB+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gJ4bjfSK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a0be321968so2732084f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747062448; x=1747667248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VybPP6Tmuc45wUynLgBf/L2830ZeC7QxsZNP4PaizIk=;
        b=gJ4bjfSKCZ6lcUOVT8WZ0lB52HESgp3cSBCjSL6PhNIxRBGW0KTnZyuxZq96MVqOg2
         HvGe1vSgecssHPTWIeblaw8hbdgwIWC180V1Nzl/gCRfzG89FMjUy52iTiE0SukI7isf
         kq6cVV3upd6sVaaBq1J6LIIeRm97zM2RGOZoQq4FWBWZlhr1FdqPGWr5BhCYwlAgDKJa
         hprNVo/WckSyUyIEfeXfHF2E61uBUZNvs+zvW/4g1SQHKl5XlTLsiKvhA0m8XJ8sH4Yf
         7QLWlSDssFgzY6oZUhwsthWLEZyD5Kf8mf4oE1Uc+ry37Yb+lchoAmjJk6P0gkLrTqm/
         id5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747062448; x=1747667248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VybPP6Tmuc45wUynLgBf/L2830ZeC7QxsZNP4PaizIk=;
        b=kaWL3V8onmfKVZMP2WXoTQ7U+6WK2ISUSeNAXwK4w4bwyEGaG8R2BSVQOfmCO8T4Pz
         3YgCpbQuL2TPqWw9b4aV2SVhFDuvcGBp/bzeKsqBdPA25Rc6CEQErHGCTMsY1uBkkMmW
         mYUC6jPqx9MMx54QtE/vVfIjyR/pfrmNcOfB3xana1MDQX3x9Nouye4B0HqeXbcuNuX0
         +p5daoIEHoo6Rvwb2nzIL4TsV5Je964KJFRqkmparmwkhBx3NrS8MwZ/SibTfWcoQ0sx
         Xf3zdaL91Nj3R2F4ySoTC5WoiXbdvPde/mvchDXp2+PyXPAgjW/Lz31dP52lrWJIFGQO
         /gXA==
X-Forwarded-Encrypted: i=1; AJvYcCVfd7upRiEuNFMyOaLtySp4stnQ5MI8GM3c4Kn7xlrkZEmDBaWQBzHANlhoiUXj7rYbv0fPuBo7UbsYpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTd0o1XpmiK6EifZDOAGsh1D2DngAmPh6svOqH7iuYEMqZgFAq
	sX2mHYBXaw2/TfmHaNVatdoC6WPfUF545DmOhjKSqNO5DI20i/fQNiiJFxnjjU3+heOyCwpw9K5
	6gVQS1o+aFKDv1oFPUccM0PstZTpzgHxO4w42ww==
X-Gm-Gg: ASbGnctLvTyOA9Bmparl4BEvOhtM0rDGc1Q5eVZtZ1SdzgULMJ53GTKG0BsNKNJD691
	rZbm4JIvpHmKrxrzMsvzOffSZ+dtgA6rT+bzAR8oFFKjR4Trf+CS+AnrFIRmUzI5a+7fjp8SxLp
	CJxBDu7f2kRVOm5NocZ6AX+Y41pl5UBnI=
X-Google-Smtp-Source: AGHT+IFlC1nfr4JhgkSddmYfz8TMBzkgoX+TRjRJnPN1eDaMJo+BcOHPlqM5rUJ89EGY95Fh7Adx5xsUhZab0+8xQ+E=
X-Received: by 2002:a05:6000:186f:b0:3a0:b4fa:a260 with SMTP id
 ffacd0b85a97d-3a1f642981amr10131771f8f.5.1747062443578; Mon, 12 May 2025
 08:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
 <20250512145939.GL9140@twin.jikos.cz>
In-Reply-To: <20250512145939.GL9140@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 12 May 2025 17:07:12 +0200
X-Gm-Features: AX0GCFsrqibXB7Fv3Ieu3TMtsagp76czncB993LzhAsYwPYf64aJsjuPvBCMOhc
Message-ID: <CAPjX3Ff+XrWHJq_cBPUaK5memR3eMh-xpCeR7rk3uOa3yPE8Mg@mail.gmail.com>
Subject: Re: [PATCH v5] btrfs: fix broken drop_caches on extent buffer folios
To: dsterba@suse.cz
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	fdmanana@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 16:59, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, May 06, 2025 at 09:47:32AM -0700, Boris Burkov wrote:
> > @@ -2852,9 +2850,27 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
> >       return eb;
> >  }
> >
> > +/*
> > + * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
> > + * does not call folio_put(), and we need to set the folios to NULL so that
> > + * btrfs_release_extent_buffer() will not detach them a second time.
> > + */
> > +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> > +{
> > +     int num_folios = num_extent_folios(eb);
> > +
> > +     for (int i = 0; i < num_folios; i++) {
>
> You can use num_extent_folios() directly without the temporary variable,
> see bd06bce1b387c5 ("btrfs: use num_extent_folios() in for loop bounds")

Not if the loop does eb->folios[0] = NULL; We've been there and had to
actually change it this way.

Using num_extent_folios() directly is a bug here.

> > +             ASSERT(eb->folios[i]);
> > +             detach_extent_buffer_folio(eb, eb->folios[i]);
> > +             folio_put(eb->folios[i]);
> > +             eb->folios[i] = NULL;
> > +     }
> > +}
> > +
> >  struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
> >  {
> >       struct extent_buffer *new;
> > +     int num_folios;
> >       int ret;
> >
> >       new = __alloc_extent_buffer(src->fs_info, src->start);
> > @@ -2869,25 +2885,33 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
> >       set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
> >
> >       ret = alloc_eb_folio_array(new, false);
> > -     if (ret) {
> > -             btrfs_release_extent_buffer(new);
> > -             return NULL;
> > -     }
> > +     if (ret)
> > +             goto release_eb;
> >
> > -     for (int i = 0; i < num_extent_folios(src); i++) {
> > +     ASSERT(num_extent_folios(src) == num_extent_folios(new),
> > +            "%d != %d", num_extent_folios(src), num_extent_folios(new));
> > +     num_folios = num_extent_folios(src);
>
> Same.
>
> > +     for (int i = 0; i < num_folios; i++) {
> >               struct folio *folio = new->folios[i];
> >
> >               ret = attach_extent_buffer_folio(new, folio, NULL);
> > -             if (ret < 0) {
> > -                     btrfs_release_extent_buffer(new);
> > -                     return NULL;
> > -             }
> > +             if (ret < 0)
> > +                     goto cleanup_folios;
> >               WARN_ON(folio_test_dirty(folio));
> >       }
> > +     for (int i = 0; i < num_folios; i++)
> > +             folio_put(new->folios[i]);
> > +
> >       copy_extent_buffer_full(new, src);
> >       set_extent_buffer_uptodate(new);
> >
> >       return new;
> > +
> > +cleanup_folios:
> > +     cleanup_extent_buffer_folios(new);
> > +release_eb:
> > +     btrfs_release_extent_buffer(new);
> > +     return NULL;
> >  }
> >
> >  struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,

