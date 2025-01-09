Return-Path: <linux-btrfs+bounces-10843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EB3A0760D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 13:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539483A0F99
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 12:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF764217F4E;
	Thu,  9 Jan 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0r8SoZ9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE453802;
	Thu,  9 Jan 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426796; cv=none; b=fW8YpG94EVzcPCR2lyjjtxWaBJLQjEj3EvAy4uC5r4coDWBLjRCjezjy7cojgEa3e2pWGF07EyYDBpMdgbY8MwWFxVE8kxmfFkmyth6mHqwXW//d8icflt+GAYb3cwjL6fgHHrcgUmL6GT2HZoy2xUpxcNR0J/AEWN48j8R9iGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426796; c=relaxed/simple;
	bh=hHv4/ANbgu1xe5m+XdjVAo41zaArkxD3xfd673Ro1ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9oKUenOeDwpc2oqakUEJCwjXPTub9gjM4UMQrPSnKHi+HsgUf5ae21qMAB+/ZXcjMZRSMoVtE1iKH8Ohr/AE3GCo1NQGwvJXEkYVinocgncKvw7Fwy+j99gGY0vXNIzL1sMBoVjPoHR22eMBO2PWUuhek8DRSDYoMVjw/NUQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0r8SoZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68050C4CED2;
	Thu,  9 Jan 2025 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736426796;
	bh=hHv4/ANbgu1xe5m+XdjVAo41zaArkxD3xfd673Ro1ZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h0r8SoZ9qhj23O89IDloXZx9NS5GnsxrAEDRY6X/i4seMEh69CeoEpn1jJpjGBUBp
	 0NrkYdrhxq98wxKQVwwekDeoERN2XFNOZMOaLxa35uBG8EExtRTXJ2WIbJx/GMBrXL
	 bs/V8lOsuYamQFIxpu/4vvkOralNDt6hjo8/qK62n/ZNLNk28hVQNpNdnX3o42R648
	 e/VVWoDXWLBHq8i3yOEN+ry9f3Zbs5jLcqQ3oURn46117tagdhsXrfV7dMj4KlG88E
	 u6EXU5gJrh5+8tL5JRwCGAIZG9/izlqceKGiemVPT/J14YbwMAI6yWg6vN6lw2fD5k
	 zqAiQdERsUDiw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso168712466b.2;
        Thu, 09 Jan 2025 04:46:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPvhQP0wV9IvhcGc7PvHxjXw2Ih6pcdAEhB96+NkI8yG2w7xLZf8HE5yCSZ3Pwd88A2R90CqAhdvYqGA==@vger.kernel.org, AJvYcCWTc3lPP7/RsSO8CHfksb9V51yD4bfTkcD9BzAp0+j3bRWzy8n03E9FuwKal/dy4oikmXyZZrnrxMVnQ+9X@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkd76nQNPzfYp/FndV5PQJ3GvNrFd0sIoZkVTBn+EZctXvapDy
	IfDEDEpIRPXf9Ax+tgWfpsyof9/p9oKQ4coXTO+Lm488fE4tledB7chaS1U5uMKSW2/g0V4QVuM
	XarEXbeRK+TrzzLRefuHLr/H15tk=
X-Google-Smtp-Source: AGHT+IFjBsys8MBQ8yVHI66vZb95vkUA8twdfVDEx4tOM1+YRayflcJSIS2pctpVQLbF/AHP0RvOW6W8fXzK+zU3ofE=
X-Received: by 2002:a17:906:c110:b0:aa6:3da3:db48 with SMTP id
 a640c23a62f3a-ab2abca061amr505028666b.53.1736426795003; Thu, 09 Jan 2025
 04:46:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org> <20250107-rst-delete-fixes-v2-5-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-5-0c7b14c0aac2@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 Jan 2025 12:45:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5BsgAhOgTi-Xrq8JX6J8xw6ZhNvQQF+AqgycrtJQxV2Q@mail.gmail.com>
X-Gm-Features: AbW1kvbk68P8eCE7cBcN7XpNgvzAoztY7zn6HGnN2f9IEuGeeD9hr5jS80d6Gao
Message-ID: <CAL3q7H5BsgAhOgTi-Xrq8JX6J8xw6ZhNvQQF+AqgycrtJQxV2Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] btrfs: fix tail delete of RAID stripe-extents
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:49=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Fix tail delete of RAID stripe-extents, if there is a range to be deleted
> as well after the tail delete of the extent.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/raid-stripe-tree.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 7fc6ef214f87d480df27023816dd800610d7dcf0..79f8f692aaa8f6df2c9482fbd=
7777c2812528f65 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -123,11 +123,18 @@ int btrfs_delete_raid_extent(struct btrfs_trans_han=
dle *trans, u64 start, u64 le
>                  * length to the new size and then re-insert the item.
>                  */
>                 if (found_start < start) {
> -                       u64 diff =3D start - found_start;
> +                       u64 diff_start =3D start - found_start;
>
>                         btrfs_partially_delete_raid_extent(trans, path, &=
key,
> -                                                          diff, 0);
> -                       break;
> +                                                          diff_start, 0)=
;
> +
> +                       start +=3D (key.offset - diff_start);
> +                       length -=3D (key.offset - diff_start);
> +                       if (length =3D=3D 0)
> +                               break;
> +
> +                       btrfs_release_path(path);
> +                       continue;
>                 }
>
>                 /*
>
> --
> 2.43.0
>
>

