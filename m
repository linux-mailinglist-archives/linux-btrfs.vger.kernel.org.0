Return-Path: <linux-btrfs+bounces-5945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9069159D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 00:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DE91C22E14
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 22:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C971A0AF8;
	Mon, 24 Jun 2024 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="ORZ+vC+J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351AE17BCC
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267923; cv=none; b=HhsSFIcnw8BuTH+6ZsoJBoa+aX7Qo+huLfKOPqErIOpy9ewH39kb4co4X4z0t5ZhRk0GeNmIB42zKktf868ONEIHNBPqvqceSgrKI3qz4GlgOGMfkV9UpTMtl9UfJH3ElDKajhYBcXJ+Ck5h+jEp7VB+1PgGVgF5wV7lJtz2x8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267923; c=relaxed/simple;
	bh=6BOem4s8ZdrAkLfE15dxzrcd0kIfS2a93RzNs1CdaMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izy3j3XOlwWNI2vi3neCpCFm3V5TNq/o8Kee/pehmaVU5zyWYUGqqPbEjwBceojmphB/oyhrXcMYAvJjP6j2aIN/35vGo9EdXtUeLRxqfA63Q+6FnlOc88CKHOhwmdoOB15uVd9nRREzXtI4MLL8bcbqEiXcde2mV2qCZRKinfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=ORZ+vC+J; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25ca169f861so2068098fac.1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1719267921; x=1719872721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3BQVe2ZkGb5oKsbZWj4akMFfRpy534mrpTR0TsZCu8E=;
        b=ORZ+vC+JCJHC8RiH5OmJfRe9EEtrxf0+P6S1Fl/A6dmoBKOb/M2YCvPXPVTg8YvuXt
         BS2cnv3J/rtQGY8rV6FWna4d4Sw27bEzDCwb/4rPFl3uh5aRLri/hRaJ3I/RbpV1zZ2u
         tPIBvDxRo4pN3yIi6zZdSwimM8NJE1epCN2Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267921; x=1719872721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BQVe2ZkGb5oKsbZWj4akMFfRpy534mrpTR0TsZCu8E=;
        b=jvJyKHy68ryPJuk6ejCKdFd3NzWI7ff9M62ZE/7TozND/Z3ykQ/gV3REBDwKZPVPtH
         n7JplhTIpTHOv9SXEgmQJ5oSPtAy2gbYzoMWwFwKdT2yI8Oovvb97MwDLDksLY42jdyJ
         6Okd4QxBKkDoH5bdldbXaGhC7c8bmJXsPXKFODF3gtDoHXWRRYlODNtlPrFgEYi338/X
         vU0zH5negcUTn/TkGd8DlNn9hoAazYiS2/GNVx7zmAL2Gfxip6xfJPJv4fJOn0cAlJMM
         sj3CxpmiS8q6qju8KpKlVfI8g2LaXflUfwzVvrbAz88nhNosZ56FW5GDCbAUGlLB29xK
         ogdA==
X-Forwarded-Encrypted: i=1; AJvYcCWEgKw9amSv3D7H6cJP21Wn1LnxiccJCOKasBFQorSiU8y9ZMG3dGalhmwnl1yxgAggSo/Tk7FVGjje972InKE51CcGdU6YjQspeOQ=
X-Gm-Message-State: AOJu0Yy2EuSX0KlGF2tcaHNUQQskEmB0XbNKc5FcJgJDrgKKBXgOt7lI
	A1fMpxfb3+qN0aatLM1NCXEMctvn64FDMUfkX5z9WZpyTlxqKBhmPJQBaCWvxbQ=
X-Google-Smtp-Source: AGHT+IEiYiaVwnrFpcgOFI+M5ICpYb3DWBSaWeszzXsn4DeHm9tFJA69kIUHgxJB76M7op7bt040AA==
X-Received: by 2002:a05:6870:4208:b0:24f:e15a:6536 with SMTP id 586e51a60fabf-25cf8c5f3b4mr2758731fac.18.1719267921208;
        Mon, 24 Jun 2024 15:25:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net. [187.190.197.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd49d1893sm2140568fac.29.2024.06.24.15.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 15:25:20 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:25:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Alex ThreeD <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Dan Carpenter <dan.carpenter@linaro.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fs: btrfs: fix out of bounds write
Message-ID: <20240624222518.GM38804@bill-the-cat>
References: <20240618214138.3212175-1-alexthreed@gmail.com>
 <CAF4oh-NEUG4rVqiUg_wFVaRF+_dFCXQNbrTPNA90Y2iGqksh2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b4VdyNqfNIuLpdBP"
Content-Disposition: inline
In-Reply-To: <CAF4oh-NEUG4rVqiUg_wFVaRF+_dFCXQNbrTPNA90Y2iGqksh2Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett


--b4VdyNqfNIuLpdBP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 01:22:01AM +0300, Alex ThreeD wrote:

> Hi all,
>=20
> Is there something on my side needed to push this forward?

I will pick it up for -next in a while, thanks.

>=20
> On Wed, Jun 19, 2024 at 12:41=E2=80=AFAM Alex Shumsky <alexthreed@gmail.c=
om> wrote:
>=20
> > Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> > buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> > Previously this OOB write have not been noticed because distroboot usua=
lly
> > read files into huge static memory areas.
> >
> > Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> > Fixes: e342718 ("fs: btrfs: Implement btrfs_file_read()")
> > ---
> >
> > Changes in v2:
> > - fix error path handling
> > - add Fixes tag
> > - use min3
> >
> >  fs/btrfs/inode.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 4691612eda..3998ffc2c8 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -640,7 +640,11 @@ static int read_and_truncate_page(struct btrfs_path
> > *path,
> >         extent_type =3D btrfs_file_extent_type(leaf, fi);
> >         if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
> >                 ret =3D btrfs_read_extent_inline(path, fi, buf);
> > -               memcpy(dest, buf + page_off, min(page_len, ret));
> > +               if (ret < 0) {
> > +                       free(buf);
> > +                       return ret;
> > +               }
> > +               memcpy(dest, buf + page_off, min3(page_len, ret, len));
> >                 free(buf);
> >                 return len;
> >         }
> > @@ -652,7 +656,7 @@ static int read_and_truncate_page(struct btrfs_path
> > *path,
> >                 free(buf);
> >                 return ret;
> >         }
> > -       memcpy(dest, buf + page_off, page_len);
> > +       memcpy(dest, buf + page_off, min(page_len, len));
> >         free(buf);
> >         return len;
> >  }
> > --
> > 2.34.1
> >
> >

--=20
Tom

--b4VdyNqfNIuLpdBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ58ksACgkQFHw5/5Y0
tywA9wwAmCDb6CVM56ER7RwePimtMlpBoa8zCRCB8lB7JsjFz1FxHF7gtSDyOT+F
/xHeJaUNgsuN2ysBzZJAKE4FaumgYk5iGGAt9t/WxIUzgVzZlApOvM56gid+oAGG
ZzNlxpWvT4DctsdnoSAkq/0rvnlni06qwL4btIAVUeBn1r6zEJtyQ4N2rxznBtpu
aSr1Z2tfPv+XKx+TCuzmdrBo7H1zq4nnn2VBwwE/pr0gBMlDRECOQ7wBDRiQxOYn
VLvX2Itc+U78MeBxGnEIVlsGkmmvYvESs4Qq88cwlyrjIvZC2EGOOptVJC1CoIs4
mXBVHGgVtMHyKGVfHrxJCi9AjhZc/+53a/HY4nahSgs0ZKSHyoAPZWtCxWxwRWyN
XrWeFfBZf4BzQllMIRGjHs+fO5Hhhl0j41azHXXR9Ysqxzekn1EgoR3lfkdG1IVt
qH0UEaf0+3jOUjT6SMYLhMLDS8KdwocYu7Ushc2GcNty0rK46FJ1Y8tgjhaqbBfM
hXfqmUCf
=mqts
-----END PGP SIGNATURE-----

--b4VdyNqfNIuLpdBP--

