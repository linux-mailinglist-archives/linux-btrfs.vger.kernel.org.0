Return-Path: <linux-btrfs+bounces-18669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3179C316A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 15:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E565188BA00
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656C332BF54;
	Tue,  4 Nov 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqBFoHXh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5472F658D
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265157; cv=none; b=eJT4cBNzrtxL2V1FGTzSXW+5cx8m6JIbABnsoc4ptx/AugLDbdaQLzNw7wLNWW28of3akEtHsHUbVmeJqQ6ga3Ha2eSx3uEZ8fGdgWRMY7nLTK5xw96IOdLer/luf5Dm8+V4QK4qXBRDVh5lBZOFl8sViLQb1Zly8p1NYR14Rg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265157; c=relaxed/simple;
	bh=xwNceA9wbeOqYxoJU3Jt1SIQ1eC8AGuVP4fS8PiKhhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNSb5k/bO/gk8BDFUzvOIEXLRFe+yYbM9+VDZuDCfHH1Nix/4BhnsF2idiPEH7qIBxQQ7k6JE/d3JBpYN4NwscqUiSMky/KhrsMma4HOpO92KhT9IC9ujyDSvT2FhL99QG3ESuWrRNMHx4owNYgF7P/ig7kFo61eauQN9dicu/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqBFoHXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D051C16AAE
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265157;
	bh=xwNceA9wbeOqYxoJU3Jt1SIQ1eC8AGuVP4fS8PiKhhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VqBFoHXhz6diMg/8q0xA7OPm5EkEB54OVdv1aV2fvm8vP1O8B34q8B1baEukkrXTY
	 8+Ynm23qDkV3NOChiO78oPJKCcNfUbv74a60dsEHeA6UeXEx28NRqnL7/4NsnvGTij
	 kWoDbmhAAgHDYk9cs2pIVQsF4k9xfdf0jyAcZbtdMXKyQ2N6FflV+qxyocpAG8nI+z
	 fVx2mCBvclXnBSt76MXOZgl5/G8w0qTfYx20aPuv3oiINUiOulxRvi4Q4v5T6Qdj56
	 2/DT4HlBjBq4gvwt59p93PyeZwvpQYWrwMNMF3oO21famAzI1QJy9CtuIK0APrv3b2
	 y0X12tOqOr+Uw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b714b1290aeso306804066b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Nov 2025 06:05:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0tYMvFgQdCRtfW13nD7S3qvnms7urbCeODg6004u5HUfoYuMvnvFU0qFdXOwakMcrar98pKZCo6GHbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpBvZ+XEhEfxHS3Pg/LkRHx0Rv3MWwIFq/m2Vyk9ZvDwu2xTVt
	7U1A3W9SaSODwjg4ri4YW3oyitlFTt+sY1Rb6pdLjwvuEruYUjHmlwVFqE9dirVN2WgnJoDNbQx
	Xr+PB3Ta/fbrdwzTpDsXe5NJW6c0XbrM=
X-Google-Smtp-Source: AGHT+IFRHXrgFcRL1kF6f7O7o4U2loCiIItvRf1yYOccI40aSz2GtslTGdxn8g9J/CSSWk8lxoqLVHVURoUzpviRt1I=
X-Received: by 2002:a17:907:7252:b0:b46:8bad:6981 with SMTP id
 a640c23a62f3a-b70701917e6mr1848664066b.20.1762265155999; Tue, 04 Nov 2025
 06:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104084509.763078-1-zhen.ni@easystack.cn>
In-Reply-To: <20251104084509.763078-1-zhen.ni@easystack.cn>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 4 Nov 2025 14:05:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6QKShugKSvTrbYw5aE8mWmYth55jJ2c8cNJVP_XQTSVQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmbyp8qWqgrsAg7ufQXCfXSafXLHCiRemr0CtzT2PZBHt9N6niDcvhg-gE
Message-ID: <CAL3q7H6QKShugKSvTrbYw5aE8mWmYth55jJ2c8cNJVP_XQTSVQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix resource leak in do_walk_down()
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 1:21=E2=80=AFPM Zhen Ni <zhen.ni@easystack.cn> wrote=
:
>
> When check_next_block_uptodate() fails, do_walk_down() returns directly
> without cleaning up the locked extent buffer allocated earlier,
> causing memory and lock leaks.
>
> Fix by using the existing out_unlock cleanup path instead of direct
> return.
>
> Fixes: 562d425454e8 ("btrfs: factor out eb uptodate check from do_walk_do=
wn()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>  fs/btrfs/extent-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index dc4ca98c3780..742e476bf815 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5770,7 +5770,7 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>
>         ret =3D check_next_block_uptodate(trans, root, path, wc, next);
>         if (ret)
> -               return ret;
> +               goto out_unlock;

This is wrong and will cause a double unlock and double free.

When check_next_block_uptodate() returns an error, it has already
unlocked and freed the extent buffer.

Thanks.

>
>         level--;
>         ASSERT(level =3D=3D btrfs_header_level(next));
> --
> 2.20.1
>
>

