Return-Path: <linux-btrfs+bounces-18960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A803C59B5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 20:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8051B3BD3D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B599B31A7EA;
	Thu, 13 Nov 2025 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cCp5X8Np"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303C3126D1
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061381; cv=none; b=hanYucSkODd1z4v8uwRAs1YJL9ad3GmpaEQ49AUAMOG+Bt+iyEgbNPy+1T7f+pICfwXGJ/A/dEhPC7s/aLYk8Y0IOFi3tC0dKiReh2nbuqEKC8xhflynjMyXIDdV4tJybSnsZ8Tg11erw2/x2dBryz3GIhB+nbp5OzDVy8HReGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061381; c=relaxed/simple;
	bh=Niexo7MY4Inf6aXOBWZmfiaWyE8QuvzaiFjwsw6yjpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2m2dS+oy4U548wRrh1ubR0X8WEBAtmXHsvMQehAWuJwOokadmvExw4oXOy9G13uLBObPRL+7r7T5JWIeGbRAIjBEUY/J1xcw1lqJlbJxD8CXNVLJk0p7MBk8cHMQbd4SElBw7CvNT71JaV3y8JqUVdUVt/rnqMfKy5uDA1iw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cCp5X8Np; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so652548f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763061375; x=1763666175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHIb9Gkdf/r3ZXZMJXv9rAah4/j84m+Miez37Ni8abQ=;
        b=cCp5X8NpMREcKjnvX/yFjlYZkyGtW6AhNpfUKQBDXzOP01alkIKNrMDxyfEG8clkdf
         VyRgeRB6gDVJjMGhAmaBBOUynh9B6vJclEm9t0ICHKL2FIGSDAbcFsSVRIDAzNKGnwm1
         hIEoPXHdYfz1w4YJ+qapCjEBSioXBHPmjOiB8nbGEYfhUxJcWxU/NI0Fe/1+nDtkn4o9
         OqQ5+U+NqvaRP96WMN0fICJmRKooYwx70vFIE61QOtBL11Ar4odmZyQoay2QGMGAtIMd
         e3GZXZ/MxvUeVM0SrFrfWW0SzuzUDtWkGG4jfLBY6OL3ZpTvC8C32OXIFhCwZKeIonio
         0eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763061375; x=1763666175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yHIb9Gkdf/r3ZXZMJXv9rAah4/j84m+Miez37Ni8abQ=;
        b=LyOwPgN7Eb/m85ZKeFgCWJhT4rUYbpL3nQPKBYkBs9w29i9n7jUTV2f7vAjB3RU3a2
         VOqonSPyEcSHe/ntRjpAvYq+tbGHebxq8qa5I2NMY/xGPODHVmhzgwhixSUiM9Pahpw0
         zTzL1cUzD3RyIXbZYg8biaLjetXIHO9JlWD49XxMJJkSPNe0OVJzYgJ0ztE7RZ+lD+J9
         ypGwoxsuUd1ddbAAxOAEjsYbeBYPqjGA7LoFNXkW0ETisz+gHUlo2nyiRxfTn+hm9ijq
         yob1o503O4x7ZP3l+V9M1TxwIXqoRUgMzm6Kuj79GEGdlZsG8cSw8SJwfXgWXH++3seM
         2ipQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtgt6GDqa+9zZ+IElWEnzkQ2OsGfgDjRPhG7CwqIAQxahB2Sv73bRBstKHTHABOIeU5dPAy38CzHp8Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNYnyX5ha2f+m6d0K89JuutJkKpG+wC337x1YTB21LTPYEEoX
	XX+tVAdkHvbPA2bt+s/LhC8kksid8ncwngVz7TadNxS7/7kxMO7a+bNNg5a5ccgCyE15LRe+siF
	yCnmqtDvcq9jKBgTT59M8d6RuYoYoM0F1QVbyMwBkVA==
X-Gm-Gg: ASbGncvnQzWw8yroeYqO1+mXnyhWHY6ly7y++g4zxhWq9WyfeHZY8b9b0ZGiHP+lB1u
	kZDQ/XAYaXflGICFIgy6iVq5b34MdxodxRdPdqHF32eWmGy4FHIpm6OBCf+tfmSrKZBauPXtHn6
	9EQLploF+Oo5RoHaQVnFtMO2AL3HIFCb3O6uuhE+5vVeUSVoDj7N/D32NTyGqeh2ANHJkY6t0ER
	Ph/8AbP8duWmtDvUPwz0h8JN6P/Zlf6p/LlAVpa2x70EqcLrBlLFL18YALUtfIavruHGS3Wd8OA
	SoJ43JBKyhgoQmFWieHKLBpxcdqjptYwz57rUCAR2i7qQe0Utai+BGBNOA==
X-Google-Smtp-Source: AGHT+IFX7CkwrBPT6rkpB8tXKEGPG2GwkzA9tfNbPQzPK4R+W7cBOLoYtUa9w7TSdyJGk7BBnml//C8803ayW8fOra8=
X-Received: by 2002:a05:6000:1a8d:b0:429:dde3:659d with SMTP id
 ffacd0b85a97d-42b59388831mr390035f8f.47.1763061374772; Thu, 13 Nov 2025
 11:16:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193611.2536093-1-neelx@suse.com> <20251112193611.2536093-5-neelx@suse.com>
 <56d545ff-3b72-430b-86e9-fd630dbac942@suse.com>
In-Reply-To: <56d545ff-3b72-430b-86e9-fd630dbac942@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 13 Nov 2025 20:16:03 +0100
X-Gm-Features: AWmQ_bmNoBW86Wb4oFNcPU98fp1DMqsgVX66eYTga3gKQoup5cznGShgyPCU5ac
Message-ID: <CAPjX3Fc9tRWZiwdx_E9Fa33gpBNzB-3V0MthDZGpJR7Bu9jg2w@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] btrfs: add orig_logical to btrfs_bio
To: Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 at 22:07, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/11/13 06:06, Daniel Vacek =E5=86=99=E9=81=93:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > When checksumming the encrypted bio on writes we need to know which
> > logical address this checksum is for.  At the point where we get the
> > encrypted bio the bi_sector is the physical location on the target disk=
,
> > so we need to save the original logical offset in the btrfs_bio.  Then
> > we can use this when csum'ing the bio instead of the
> > bio->iter.bi_sector.
>
> We have already btrfs_bio::csum_saved_iter, we can just reuse it to grab
> logical bytenr by csum_saved_iter->bi_iter.bi_sector.
>
> Although that member is only for data writes with data checksum, it's
> not hard to adapt it for encryption.
>
> But in that case, we may want to rename that member to something more
> generic, maybe like write_saved_iter?

Yeah, something like that could work. Later fscrypt change uses
bbio->saved_iter for checking the checksum on encrypted read. Perhaps
we can use the same one in both cases?

--nX

> Thanks,
> Qu
>
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > No code changes other than context since v5.
> > ---
> >   fs/btrfs/bio.c       | 10 ++++++++++
> >   fs/btrfs/bio.h       |  2 ++
> >   fs/btrfs/file-item.c |  2 +-
> >   3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index a69174b2b6b6..aba452dd9904 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -94,6 +94,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs=
_fs_info *fs_info,
> >       if (bbio_has_ordered_extent(bbio)) {
> >               refcount_inc(&orig_bbio->ordered->refs);
> >               bbio->ordered =3D orig_bbio->ordered;
> > +             bbio->orig_logical =3D orig_bbio->orig_logical;
> > +             orig_bbio->orig_logical +=3D map_length;
> >       }
> >       bbio->csum_search_commit_root =3D orig_bbio->csum_search_commit_r=
oot;
> >       atomic_inc(&orig_bbio->pending_ios);
> > @@ -726,6 +728,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *b=
bio, int mirror_num)
> >               goto end_bbio;
> >       }
> >
> > +     /*
> > +      * For fscrypt writes we will get the encrypted bio after we've
> > +      * remapped our bio to the physical disk location, so we need to
> > +      * save the original bytenr so we know what we're checksumming.
> > +      */
> > +     if (bio_op(bio) =3D=3D REQ_OP_WRITE && is_data_bbio(bbio))
> > +             bbio->orig_logical =3D logical;
> > +
> >       map_length =3D min(map_length, length);
> >       if (use_append)
> >               map_length =3D btrfs_append_map_length(bbio, map_length);
> > diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> > index c5a6c66d51a0..5015e327dbd9 100644
> > --- a/fs/btrfs/bio.h
> > +++ b/fs/btrfs/bio.h
> > @@ -52,6 +52,7 @@ struct btrfs_bio {
> >                * - pointer to the checksums for this bio
> >                * - original physical address from the allocator
> >                *   (for zone append only)
> > +              * - original logical address, used for checksumming fscr=
ypt bios.
> >                */
> >               struct {
> >                       struct btrfs_ordered_extent *ordered;
> > @@ -61,6 +62,7 @@ struct btrfs_bio {
> >                       struct bio *csum_bio;
> >                       struct bvec_iter csum_saved_iter;
> >                       u64 orig_physical;
> > +                     u64 orig_logical;
> >               };
> >
> >               /* For metadata reads: parentness verification. */
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index 474949074da8..d2ecd26727ac 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -812,7 +812,7 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, stru=
ct bio *bio, bool async)
> >       if (!sums)
> >               return -ENOMEM;
> >
> > -     sums->logical =3D bio->bi_iter.bi_sector << SECTOR_SHIFT;
> > +     sums->logical =3D bbio->orig_logical;
> >       sums->len =3D bio->bi_iter.bi_size;
> >       INIT_LIST_HEAD(&sums->list);
> >       bbio->sums =3D sums;
>

