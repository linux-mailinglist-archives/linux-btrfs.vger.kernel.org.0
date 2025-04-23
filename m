Return-Path: <linux-btrfs+bounces-13288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9380A98694
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 11:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DEA1B62F95
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447FE262FE7;
	Wed, 23 Apr 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLw7TtcG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C81A83E2;
	Wed, 23 Apr 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402112; cv=none; b=fjwBTTOd8apIDLZQYKo9BORPlfmHmdBhnCre4ULiN7xg4f7lDBKuR1DAtKl1nrMVz3HJUY1TUrXk3Krnt2vGEryyC+pQwkMk3YE3PX/sW1W8u9LuAraz6IzeIRGZzMkfloKppqDFUSCPZU+mj3vO0uXQfV12ipFuzi8VH3UgaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402112; c=relaxed/simple;
	bh=HSftoXvQSlOw4Xxkgs6KWUUAYAy78hGoeqnzScItdHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pejJk2cdPngchZm9q456q3y6tSZfdnkYUGRTME/ROsTCV1UBvC/XP+PCgdqcepgY6qfFla8lQas9O2+yq9ycuyqK6UT4k0usdsFTBa+fotuUi+y4YqA0DySeYRo/6WIv2DhIKKBTzBpYbKKvsYximKhwVUi5/LvoBOPweOMxlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLw7TtcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E953BC4AF09;
	Wed, 23 Apr 2025 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745402111;
	bh=HSftoXvQSlOw4Xxkgs6KWUUAYAy78hGoeqnzScItdHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XLw7TtcGATvcTkoSrmSWCq0a4RsoQkjXbc8l+MFxcdOliZqFXabh1E30KeXYwG/L1
	 UMyjkVdyIJN+rinnRlX8JJrNP8aNbo1zPVA9IalEVMy0DJsQaflqXGokMx7exK4Ypp
	 ls0eQqEaac5CRT+gC6HvKYs0x3dCar78snDjeCjSknXM4RG5tdT4ZVSLdDiHegMxDp
	 SS4tqK/CB/9oHMZBNtcPJiFHz2fUCrOr9jbZbIUAMeqZqS+aoBcLuxrTyUnG+zbEn6
	 sGDS4IgP15c8aV5WZLwF6bcpJtkCOXoFwX+AUHYmZf4aLlS6gcvo1JaDPQX54XpMx1
	 yYouWxhd5QN2Q==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f4ca707e31so9260049a12.2;
        Wed, 23 Apr 2025 02:55:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU16YM2oIpfWxf7R27R0B5JK1llbrEBiFBAzWhEv9Kb4PDKmWThWQbclV0JHNxu20Q3BEmzDdZfQFP93Q==@vger.kernel.org, AJvYcCXnp7nNzTUSbThGWcCFBOKd0KUpLFYU6WG+6V2gE4K5SiCeMctc3l93h79+/ieEvchjZLGxJF6mhQ/Pg/gX@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJsegCVsxElGI2XU3osfjMlsQzRvzfcSMqbbOoLhR+jHbd+w0
	lYa/+QMytmr6MVTEyJcrfqU1w/xEVkT2kf++mIs13MxO7Su7EvrHS2AYhK0zNWqpr7jY3FP+BhS
	zGBjwpqTQswZ4MZRWWyVaRjkhvkw=
X-Google-Smtp-Source: AGHT+IFFkT/rib5KuvX63LPygFLm+a3qeCHF988/Xzsb491RdVNuxslG2Tt4cSq2zr8PqIsXGxawPeC+UOy1uPdF3pA=
X-Received: by 2002:a17:907:9727:b0:acb:5f9a:7303 with SMTP id
 a640c23a62f3a-acb74bcc517mr1552608966b.35.1745402110486; Wed, 23 Apr 2025
 02:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423080940.4025020-1-neelx@suse.com> <CAL3q7H7A_OnTQviZpCgzrGUFe1K=VfMiWXaba56E3ucPHnVkNg@mail.gmail.com>
 <CAPjX3Fdor0TgkQtb2meJD4PFerOQV1Qcjs5HEyBCt5TNt8-vsA@mail.gmail.com>
In-Reply-To: <CAPjX3Fdor0TgkQtb2meJD4PFerOQV1Qcjs5HEyBCt5TNt8-vsA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 23 Apr 2025 10:54:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7g3xvs8TnSsYwaBP1n_EyRn1eC6SgeMP41G7BT=VZ2-A@mail.gmail.com>
X-Gm-Features: ATxdqUGGvf68i6_amx5SyZJ_4EZLwc7s01Fa8LpDbspgq3qUeFU-G7uawmhhJJQ
Message-ID: <CAL3q7H7g3xvs8TnSsYwaBP1n_EyRn1eC6SgeMP41G7BT=VZ2-A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fiemap: make the assert more explicit after
 handling the error cases
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 10:48=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrot=
e:
>
> On Wed, 23 Apr 2025 at 11:04, Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Wed, Apr 23, 2025 at 9:10=E2=80=AFAM Daniel Vacek <neelx@suse.com> w=
rote:
> > >
> > > Let's not assert the errors and clearly state the expected result onl=
y
> > > after eventual error handling. It makes a bit more sense this way.
> >
> > It doesn't make more sense to me...
> > I prefer to assert expected results right after the function call.
>
> Oh well, if an error is expected then I get it. Is an error likely
> here?

The assertion serves to state what is never expected, and not what is
likely or unlikely.
It's about stating that an exact match shouldn't happen, i.e. ret =3D=3D 0.

We do this sort of asserts in many places, and I find it more clear this wa=
y.

> I understood the comment says there can't be a file extent item
> at offset (u64)-1 which implies a strict return value of 1 and not an
> error or something >1. So that's why. And it's still quite after the
> function call.
>
> But I'm happy to scratch it if you don't like it.
>
> > Thanks.
> >
> > >
> > > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > > ---
> > >  fs/btrfs/fiemap.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
> > > index b80c07ad8c5e7..034f832e10c1a 100644
> > > --- a/fs/btrfs/fiemap.c
> > > +++ b/fs/btrfs/fiemap.c
> > > @@ -568,10 +568,10 @@ static int fiemap_find_last_extent_offset(struc=
t btrfs_inode *inode,
> > >          * there might be preallocation past i_size.
> > >          */
> > >         ret =3D btrfs_lookup_file_extent(NULL, root, path, ino, (u64)=
-1, 0);
> > > -       /* There can't be a file extent item at offset (u64)-1 */
> > > -       ASSERT(ret !=3D 0);
> > >         if (ret < 0)
> > >                 return ret;
> > > +       /* There can't be a file extent item at offset (u64)-1 */
> > > +       ASSERT(ret =3D=3D 1);
> > >
> > >         /*
> > >          * For a non-existing key, btrfs_search_slot() always leaves =
us at a
> > > --
> > > 2.47.2
> > >
> > >

