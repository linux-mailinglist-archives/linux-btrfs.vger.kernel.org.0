Return-Path: <linux-btrfs+bounces-13283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E09A984BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 11:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353D57AB995
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126232505D6;
	Wed, 23 Apr 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soSssiKe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2722F777;
	Wed, 23 Apr 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399063; cv=none; b=RsY1lV4x7QuUO65adMu9erQx/kDwKkNyuWg7hvK0butwMRwUUTzwtx6tVMWRpF9Iq443lK8PDUSHeqU1mHBX9a1/SeyIEr1xDxFr/N5kN7uPVDsPruP6UgWp0Q62jx/ijtbr0C69q4OPd6O2lGjTUeObxVP0WP4glL5qQRy1mE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399063; c=relaxed/simple;
	bh=ZWjJudOIpG9Jg7VsgBy9ZhKQJRli5wFIxhlpwgBZ3OU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecVo2T8JhvyeybZ4B/kwTaOR68NE6uRtLqw9H1kYWoPeZ5obVSjkBHKhgfrrcD5wg6vzNJTmSH/F/CDHxi1pO0Fivgv36BINGSZuChVWRC6t8UzLvoKWR/ON+5bPsrfBFXe9qSrbEudBFsqfxqq2p0dCA2g52abn9iYnXSsC3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soSssiKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D9AC4CEEF;
	Wed, 23 Apr 2025 09:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745399062;
	bh=ZWjJudOIpG9Jg7VsgBy9ZhKQJRli5wFIxhlpwgBZ3OU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=soSssiKedVrbpkdVs7QRwU7NCdm00ZFSDSI/cISoGmEn+IW5SOSK1rJuj8ChCrsvg
	 O0nhS3lGGtzQSB81j0uovcE+Vr5a+MYZG6NNTIr6FxQwOnc7Svuuf+bSv6kdLO/Hqi
	 ZEBdwufr17dy5sWbJ4u/BfGgQDDURPT6GD+nOutRajRUxZJYXOb/YGfRJTBSgGCmQp
	 nAFhkqqbumTuSflVnwHrDt0MOEZ/iaZ6WEPNmpSDqsLhiq03YugrPhr2t+yfkRwquC
	 7ToveTPLHw4Z/L0HEC0a6ONVRkLMjVfRuAadhGKdi4saK/MsA2WJkKTWLs3IQWA/CH
	 2GNMc79pdWtTA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acbb48bad09so438523066b.0;
        Wed, 23 Apr 2025 02:04:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW12axfYHw0g/JpbMGdema1qVDO+tMveqBCNg4InorvjIy/8ooWP9/l8swjXK7qrrVeOL2ZZ1YKTibK/0aJ@vger.kernel.org, AJvYcCXL6UdPbph2KNMTb03YT1eKu7igyTo4Lhgp1cnYFz5AbWXCW5R/siJeKeSmRDRKDNmy2q+mnYH6dV7STw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLI7wvLwhJ4fP5o9+VbK/Bp3cbwuohkR1PQ0Nqa+5TBgSz9wZ
	nB7Y3dF23lMhcxavs7ly14/dvaozuSQKYSSuj6w790ua9zI4MVEcbaZVd/bs9xoVOMdN+FLTFIS
	KL67DD6QCwoCvdYdc4BI2lB0L8ag=
X-Google-Smtp-Source: AGHT+IGUCPhQAELzi3473CFpEJ0ZC3dDvAKOihM/64SRSGtbWET3JI3KSLLtn+NeZ/1h6QH/Nmt2S53HqkQySgm9VCQ=
X-Received: by 2002:a17:906:c349:b0:acb:b6c9:90af with SMTP id
 a640c23a62f3a-acbb6c99479mr607100266b.16.1745399061209; Wed, 23 Apr 2025
 02:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423080940.4025020-1-neelx@suse.com>
In-Reply-To: <20250423080940.4025020-1-neelx@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 23 Apr 2025 10:03:44 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7A_OnTQviZpCgzrGUFe1K=VfMiWXaba56E3ucPHnVkNg@mail.gmail.com>
X-Gm-Features: ATxdqUGjp7aj7hoRjbeuLsV-XldBmYEDEokNYivqRQVPyn8yAs8Ga8JxOZzQpcU
Message-ID: <CAL3q7H7A_OnTQviZpCgzrGUFe1K=VfMiWXaba56E3ucPHnVkNg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fiemap: make the assert more explicit after
 handling the error cases
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:10=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrote=
:
>
> Let's not assert the errors and clearly state the expected result only
> after eventual error handling. It makes a bit more sense this way.

It doesn't make more sense to me...
I prefer to assert expected results right after the function call.

Thanks.

>
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
>  fs/btrfs/fiemap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
> index b80c07ad8c5e7..034f832e10c1a 100644
> --- a/fs/btrfs/fiemap.c
> +++ b/fs/btrfs/fiemap.c
> @@ -568,10 +568,10 @@ static int fiemap_find_last_extent_offset(struct bt=
rfs_inode *inode,
>          * there might be preallocation past i_size.
>          */
>         ret =3D btrfs_lookup_file_extent(NULL, root, path, ino, (u64)-1, =
0);
> -       /* There can't be a file extent item at offset (u64)-1 */
> -       ASSERT(ret !=3D 0);
>         if (ret < 0)
>                 return ret;
> +       /* There can't be a file extent item at offset (u64)-1 */
> +       ASSERT(ret =3D=3D 1);
>
>         /*
>          * For a non-existing key, btrfs_search_slot() always leaves us a=
t a
> --
> 2.47.2
>
>

