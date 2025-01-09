Return-Path: <linux-btrfs+bounces-10842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF72DA075F5
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 13:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D35167DF7
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B8217F48;
	Thu,  9 Jan 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdkhfHjc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374F63B9;
	Thu,  9 Jan 2025 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426568; cv=none; b=gCfhR4sM0A1M3R+3ddbMsSfPr4edfHmKYMkZ5gBhhKcHCoO3bzzEcs+3t8XK7bNV0oA2p9ojTe9PgWbEVBSxKmVs3hRzK9lgbn9J+J1UhrrG5ZTrsTZbsg+12nbH1wP1rxJu3Cmr/L9XyzATXW/t9FZGYTDuAnztTuHRuOxujrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426568; c=relaxed/simple;
	bh=GyiJVdLfxWRjwMCQGM1yEOqUnrnAZoj0+gA7JUOWlS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOq2uSmfzeWmeRzwiodl7kC9aRALYbPKh8fooxEfF1aUV9RLb/TEydthLVUPG8B8sqVtBBwxFTd0NyUR3vxiW3PZuuvi6ahN16XtyvwvMbAjyL3GfEl1YsvAysN67AeOxMuAYidEyjkn56lEhnLt7tRBFd0Tw4BUfQXg1smgDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdkhfHjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5B9C4CEE2;
	Thu,  9 Jan 2025 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736426567;
	bh=GyiJVdLfxWRjwMCQGM1yEOqUnrnAZoj0+gA7JUOWlS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cdkhfHjcorcwIt16ZhPbAjDBSLutGTFgbtfQ6dfxq2l7Z3qjqW0vMo6GSPE9YybAi
	 TiCSnLZIBhLF0rQ1YvrMx8FWaEmSWRbUxiihEgczMxVXZZa9cAx9vRJxYopOqxh8hD
	 YvSYMx5OK4Vg2KB8xZjliu+iYt1BMGgFjLvvD1ZFnL5BEllzY7JUZdPAMytLIq0FcR
	 px+KNBJ6PeZCmT0dnE4EzC9QojYrPlUb4wj+i3IiIJuJpV3/wI8ytzGlJJLoyTjLAN
	 S/HIegxGOiUxg4CFJKm9cejuW6OI5GK7QLiPrKrBl4wsx4gPi7N/BiF1XuIrP1dVii
	 LNBDCZD6xkKbQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d982bce8f9so1465269a12.1;
        Thu, 09 Jan 2025 04:42:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7TKUz7MEKYypfcYP8kP2MaiCiWcNE7dxrZc1h5IUjY0w03GsH1H7prmSPepgxZ22wfNFz+knGdnqcig==@vger.kernel.org, AJvYcCXVLJS8Jr7WacwzRTFN113TtUhXnASgrSAKhY/5O/G7rgN+IMdPqmBCQQbJq5w6VtDMPJtv2pJP9RhNevZM@vger.kernel.org
X-Gm-Message-State: AOJu0YyNASQwRZdK+9Bi3nzJI1uRMykpvYHb58lYHRzi+OZee1igrMlf
	9Uclt28cN8SZnNjDVPSsX/RU5eTnTMoROOuDf7TT7DXI3myEqFIZ6sZCRYqr9VNmg2pDljA2LGB
	YBp2NBUDt2TO2GcCpymkyNJI5/CY=
X-Google-Smtp-Source: AGHT+IEf+LiMqD3xEZIm2zwiU5aU02OdKX324Z3G1T1a4SyYp0RBg92tbrbQ2bgHO16ODLcAgePsfTO4+dVNDydfReA=
X-Received: by 2002:a17:907:7f24:b0:aa6:5eae:7ece with SMTP id
 a640c23a62f3a-ab2abc93e22mr565250966b.43.1736426566419; Thu, 09 Jan 2025
 04:42:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org> <20250107-rst-delete-fixes-v2-3-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-3-0c7b14c0aac2@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 Jan 2025 12:42:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H40wEFPz19ce+Fv5CkJVviTESearHBzLMFQc2UHZqJqNQ@mail.gmail.com>
X-Gm-Features: AbW1kvYExxphPMtu3Qb1JzqkpQd_iDoO5nD5yusdnApYD-fSe1luIjLCU70zoR0
Message-ID: <CAL3q7H40wEFPz19ce+Fv5CkJVviTESearHBzLMFQc2UHZqJqNQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] btrfs: fix search when deleting a RAID stripe-extent
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:48=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Only pick the previous slot, when btrfs_search_slot() returned '1'.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 5c6224ed3eda53a11a41bffdf6c789fbd6d3a503..0c4d218a99d4aaea5da6c3962=
4e20e77758a89d3 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -89,8 +89,12 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle=
 *trans, u64 start, u64 le
>                 if (ret < 0)
>                         break;
>
> -               if (path->slots[0] =3D=3D btrfs_header_nritems(path->node=
s[0]))
> -                       path->slots[0]--;
> +               if (ret =3D=3D 1) {
> +                       ret =3D 0;
> +                       if (path->slots[0] =3D=3D
> +                           btrfs_header_nritems(path->nodes[0]))

Btw this can fit in a single line, it stays at 83 characters which is
acceptable nowadays, making things a bit more readable.
I've commented on this many times before in other patches.

Can you explain what bug is this patch fixing?
The changelog doesn't provide any information about that.

path->slots[0] should only match btrfs_header_nritems(path->nodes[0])
when the key wasn't found, that is, when ret =3D=3D 1.
So I don't see what this patch is trying to fix or improve.

Also, the 'ret =3D 0' is pointless, as we do it shortly after this code.

Thanks.


> +                               path->slots[0]--;
> +               }
>
>                 leaf =3D path->nodes[0];
>                 slot =3D path->slots[0];
>
> --
> 2.43.0
>
>

