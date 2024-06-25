Return-Path: <linux-btrfs+bounces-5953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3999E916538
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 12:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B443EB23F2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179914A0B7;
	Tue, 25 Jun 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF4yDV7U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E37145FF4
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311181; cv=none; b=bgM9DAphbp5+hNMc8fPtFkZ2TkrarM/xKQ33XVfsytLXoOnpy+G1T3xj+m+cKFiXNZ4F0wKRPSeP0wfb4cPOG8yZ8SqAJkqfdb2ymm4NxpzPuZPsBMK1R44wdtU3d+lS3d6rhTL4sC1iw6wkX1JgEK2IpVwqol/kqyNOhs50fyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311181; c=relaxed/simple;
	bh=RgQdQxrlfyIsQgOK+5ItmwoTUIkauz90sEy2GjJKLtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSWMfQeTwuPpRmOFd023tMtj8yS8Ee5IeZBP3eMCNFTolHiG1BE74+hT8uP3MZi+uBoDkaimz4n3tqg0M9SV6OhO4vBDSvg5m3Yf0HspCqxWjoY4wAgaVaMJcZkL7q+RFWEqesXwuKaoAQgDrgKn4wjjAl04+6p1O5fBE0ZG+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF4yDV7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB56C32781
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719311181;
	bh=RgQdQxrlfyIsQgOK+5ItmwoTUIkauz90sEy2GjJKLtU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AF4yDV7U7kSdqPChkPrTkXEt/NST7+fPkNshxaU9TWRilr4xdwPodxtwQtC9j0OJV
	 wZmnr7Zt3bQZkBPVTucxarjZ7UEaez+HoDV2k/xQ6CwyxDRON8DTGAnUVcmUlUsh2K
	 1gBp6VmYGBy6fhIYyIJUTqJtjy8shLkffldfPp0Dim0w2EftF8sU0DerIZ2jlGZi2F
	 p/x3iK735Jao2dyZ1bkf4gspE6jFxQJ1+udYZHt1/nNTQJ23kytsZC9S/NsJa176Ir
	 h5p6KuGzQzNwTtAqVcAtwUUs9m7Chmoi5Lqn4RYGlmRVwp+IRBjApqGaD/lFnjrAcl
	 quTuNnIq8gpHw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so682133266b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 03:26:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz7uUYNEJM7KvGaSYcfyIeBxlaZ1hGx8UFErK3O5+dKgxUSGiaL
	lSWzxEjMxsYTNJwwU0c9SGegCDoniqBkefvl0J7/k7Np/cGh9Y1r8ehQmmaA1t0B8nXKjdPXdlm
	Ne+/9SRNeQcBeyhiBhUIbI7u991o=
X-Google-Smtp-Source: AGHT+IEdogP5SQiGopk/3gBcNjLjTsmPZu+2JsUvOqCk0VRkVNPx3WCYEpe2rn86qUBg3FUqWdhGLfzz8v/XmvJZ0mA=
X-Received: by 2002:a17:906:1948:b0:a6f:593f:d336 with SMTP id
 a640c23a62f3a-a7245c85b75mr381274566b.11.1719311179818; Tue, 25 Jun 2024
 03:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719291793.git.wqu@suse.com> <8ae9d9cbfce4a3c1d21a413d5072694b1814aad1.1719291793.git.wqu@suse.com>
In-Reply-To: <8ae9d9cbfce4a3c1d21a413d5072694b1814aad1.1719291793.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Jun 2024 11:25:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H79UHYJ83a90r94Tn7T+yS37ShG0GYyRUAT2qZAhsoEeg@mail.gmail.com>
Message-ID: <CAL3q7H79UHYJ83a90r94Tn7T+yS37ShG0GYyRUAT2qZAhsoEeg@mail.gmail.com>
Subject: Re: [PATCH 2/4] btrfs: make validate_extent_map() to catch ram_bytes mismatch
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 6:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Previously validate_extent_map() is only to catch bugs related to
> extent_map member cleanups.
>
> But with recent btrfs-check enhancement to catch ram_bytes mismatch with
> disk_num_bytes, it would be much better to catch such extent maps
> earlier.
>
> So this patch would add extra ram_bytes validation for extent maps.

would add -> adds

>
> Please note that, older filesystems with such mismatch won't trigger this=
 error:
>
> - extent_map::ram_bytes is already fixed when reading from disk
>   At btrfs_extent_item_to_extent_map() we override extent_map::ram_bytes
>   to disk_num_bytes for non-compressed regular/preallocated extents.

At btrfs_extent_item_to_extent_map() we override ram_bytes for any
type of extent, it's not conditional on anything.
So this is confusing because it doesn't match the code.

>
> So this enhanced sanity checks should not affect end users.

checks -> check, otherwise "this" should be "these" (but there's only
one check).

The code looks good, thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_map.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index b869a0ee24d2..6961cc73fe3f 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -317,6 +317,11 @@ static void validate_extent_map(struct btrfs_fs_info=
 *fs_info, struct extent_map
>                 if (em->offset + em->len > em->disk_num_bytes &&
>                     !extent_map_is_compressed(em))
>                         dump_extent_map(fs_info, "disk_num_bytes too smal=
l", em);
> +               if (!extent_map_is_compressed(em) &&
> +                   em->ram_bytes !=3D em->disk_num_bytes)
> +                       dump_extent_map(fs_info,
> +               "ram_bytes mismatch with disk_num_bytes for non-compresse=
d em",
> +                                       em);
>         } else if (em->offset) {
>                 dump_extent_map(fs_info, "non-zero offset for hole/inline=
", em);
>         }
> --
> 2.45.2
>
>

