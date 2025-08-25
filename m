Return-Path: <linux-btrfs+bounces-16340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DAB33E34
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 13:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C42E189C156
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C52EACF0;
	Mon, 25 Aug 2025 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0j1eyRG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A11D63C7;
	Mon, 25 Aug 2025 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121920; cv=none; b=mucE+vII4C2VjBkFW1Blz9wHezf3ysNOSPxUP1AQe8NJkMyLWoBWxtqHY++pKRZ0bMt99V0AH8LHFp++toP3O6WxsGVqA9B+fOPPLbLo4tZk939NydrhrIWOtQZsWpCmXvsJMtfM0IsVsZZ2RLCO/Ij2rT0jSdkVhyFpg6ZwEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121920; c=relaxed/simple;
	bh=6APue8na146l9OnCw5tc6LK/AUe3RQ1uN+CqpFXB2eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UP/x0BV+y4mp4vZ2qovShFoZW/d7rJ+2gRnTOiHKEXxvKDhGGh5a6yFQF5PfdrtPAWUp6+rIyp6tBDB136V2TwbyQx5E4RojGJHvozb5X50iWkX2FBLwXsSqtcIOlpFgSvAWDDLGpXK0AyoqPyw1F1npTVyo0d6qyAF5eOti9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0j1eyRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5ACC116B1;
	Mon, 25 Aug 2025 11:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756121919;
	bh=6APue8na146l9OnCw5tc6LK/AUe3RQ1uN+CqpFXB2eM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L0j1eyRGjxReVhaPGXPc3OCxrSr43piTBZ94lfJEfW+n0rl/OmdwxZnCZtIDWh7Bt
	 EZqDb/KAWoFy0CkpYuBwjf569mi9On3BLcjXOpAGeZKXjlYAp5Oh7ICZTXEVEH/8tU
	 3XEyx9tvJm3yBjH8eYKq+bZTgBZemM+rS1BT//Pi6Mea5FdrAHs2SYntlVYm8NFYGI
	 QN/pxPAZSV1IgKLfla2chLGmXHPGE1hnC6SYXHTsIj5b6tT8b+rlO0pls9I5bIdGYG
	 OY/7DraI5VIaGSBy0c/LTYPPNhI2hHsndNW0DFzcV2oiQwTzVT1KVD84/K5vDe+SJs
	 2M9hRWRMrLRLw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7347e09so729010566b.0;
        Mon, 25 Aug 2025 04:38:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/VIHdWVhmkAUjyCkHxpl/OPWoFnBKWIOTJsiy77YnPFAgHii4SBwZSmLZXVvDhLUU6hd/Zyg6O4rY97HC@vger.kernel.org, AJvYcCX7ljacjG9I9sFcqcNckAfyEgfzI0iy0c/YHbjcDROhbRh9+6yXZoxaLXfCt2lfagzlqIoyEFH9fY0CJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YynD6tkmvR5lmASMKI0LuaKoemv1/vBvqrVl4XV8NaeZz1Qui28
	yP86cK1fwDU0h6WzKNMjTk77LmEfvBEEX7uBNah4I2jw/VjkNKrTga2Pit+bb4i1RCl4vK5Wm+c
	rmjEfIvawAu6qORHdu496WZqgfsrDHAI=
X-Google-Smtp-Source: AGHT+IFZYJ+lV282ntDhnG+FAfTcwX4TZPreBFEEYH542R5PWbLp1BZFVxU5Bb3LcYecnnKruIXfxL/jaXx1DuNxS7s=
X-Received: by 2002:a17:907:3f2a:b0:afc:b13d:ea7a with SMTP id
 a640c23a62f3a-afe2963aca8mr1065036866b.57.1756121918011; Mon, 25 Aug 2025
 04:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2022221.PYKUYFuaPT@saltykitkat> <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
 <aKiSpTytAOXgHan5@mozart.vkv.me> <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>
 <aKj8K8IWkXr_SOk_@mozart.vkv.me> <9cacdafc-98ec-4ad2-99a8-dfb077e4a5fb@gmx.com>
 <aKs2mCRjtv3Ki06Z@mozart.vkv.me> <CAPjX3FeOEg+QhkwKWe+qDH876bp6-t1GFO0sce7a6bmhM7umpw@mail.gmail.com>
 <663c2f5b-3bb1-4a40-b962-11c6d3a7f806@gmx.com>
In-Reply-To: <663c2f5b-3bb1-4a40-b962-11c6d3a7f806@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 25 Aug 2025 12:37:59 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4RgwGZwPdof=5NN6hcB7YRevOjA70vG19sRNXNMRMM3w@mail.gmail.com>
X-Gm-Features: Ac12FXwH3j5pnrD1WiLI-vHL4MJH0eW5jRxhvOdqlx_vIdTC04hwLYGXagFrK5M
Message-ID: <CAL3q7H4RgwGZwPdof=5NN6hcB7YRevOjA70vG19sRNXNMRMM3w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Daniel Vacek <neelx@suse.com>, Calvin Owens <calvin@wbinvd.org>, Sun YangKai <sunk67188@gmail.com>, 
	clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 10:03=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2025/8/25 18:21, Daniel Vacek =E5=86=99=E9=81=93:
> > On Sun, 24 Aug 2025 at 17:58, Calvin Owens <calvin@wbinvd.org> wrote:
> >> From: Calvin Owens <calvin@wbinvd.org>
> >> Subject: [PATCH v3] btrfs: Accept and ignore compression level for lzo
> >>
> >> The compression level is meaningless for lzo, but before commit
> >> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> >> it was silently ignored if passed.
> >>
> >> After that commit, passing a level with lzo fails to mount:
> >>
> >>      BTRFS error: unrecognized compression value lzo:1
> >>
> >> It seems reasonable for users to expect that lzo would permit a numeri=
c
> >> level option, as all the other algos do, even though the kernel's
> >> implementation of LZO currently only supports a single level. Because =
it
> >> has always worked to pass a level, it seems likely to me that users in
> >> the real world are relying on doing so.
> >>
> >> This patch restores the old behavior, giving "lzo:N" the same semantic=
s
> >> as all of the other compression algos.
> >>
> >> To be clear, silly variants like "lzo:one", "lzo:the_first_option", or
> >> "lzo:armageddon" also used to work. This isn't meant to suggest that
> >> any possible mis-interpretation of mount options that once worked must
> >> continue to work forever. This is an exceptional case where it makes
> >> sense to preserve compatibility, both because the mis-interpretation i=
s
> >> reasonable, and because nothing tangible is sacrificed.
> >>
> >> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount opti=
ons")
> >> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> >> ---
> >>   fs/btrfs/super.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > v3 looks good to me. The original hardening was meant to gate complete
> > nonsense like "compress=3Dlzoutput", etc...
> >
> > Reviewed-by: Daniel Vacek <neelx@suse.com>
>
> Now merged and pushed to for-next branch with the latest reviewed-by tags=
.

Btw, don't forget a couple things:

1) In the subject, after the prefix "btrfs: " the first word should
not be capitalized;

2) In the log message (btrfs_warn() call), the first word should also
not be capitalized.

These are the styles we follow, so we should be consistent.

>
> Thanks,
> Qu
> >
> > Thank you.
> >
> >> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> >> index a262b494a89f..18eb00b3639b 100644
> >> --- a/fs/btrfs/super.c
> >> +++ b/fs/btrfs/super.c
> >> @@ -299,9 +299,12 @@ static int btrfs_parse_compress(struct btrfs_fs_c=
ontext *ctx,
> >>                  btrfs_set_opt(ctx->mount_opt, COMPRESS);
> >>                  btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> >>                  btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> >> -       } else if (btrfs_match_compress_type(string, "lzo", false)) {
> >> +       } else if (btrfs_match_compress_type(string, "lzo", true)) {
> >>                  ctx->compress_type =3D BTRFS_COMPRESS_LZO;
> >> -               ctx->compress_level =3D 0;
> >> +               ctx->compress_level =3D btrfs_compress_str2level(BTRFS=
_COMPRESS_LZO,
> >> +                                                              string =
+ 3);
> >> +               if (string[3] =3D=3D ':' && string[4])
> >> +                       btrfs_warn(NULL, "Compression level ignored fo=
r LZO");
> >>                  btrfs_set_opt(ctx->mount_opt, COMPRESS);
> >>                  btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> >>                  btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> >> --
> >> 2.49.1
> >>
>
>

