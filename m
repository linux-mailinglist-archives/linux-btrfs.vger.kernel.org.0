Return-Path: <linux-btrfs+bounces-8249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A289870B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4097B1F252B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A2C1AC44E;
	Thu, 26 Sep 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VucRxMSg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91051A727E;
	Thu, 26 Sep 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344268; cv=none; b=OV6p/2xevzfsKtQPw+gPATslh9ZhXOji5dBvBllqjPVvJBzx5PkKYfdQeDUPSvc+G8UzwHxPg0K9xHB9rYKB5xO3CREAs0M1HGly8pTv9S+v4xUDPUXV6REVyvlcYi7glQScEuG0vb7xi6XBCflGuCBbWJhN9Hyq+Jogw2Td/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344268; c=relaxed/simple;
	bh=9ZXXL62CO9L7MkrvKkBtHpmLLSVAGUPp16RKqcXHYC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPGjTP4R0iVlMzkRzEQ2wnWN94iQF4XL/foGiDYFLlnUShKombzLx5d2wjUboMLuROLTOrKnkxwVOJdWDthDk/TvTTw5HQOsQJwzJqqOtJ9Lnai6kcBCfPC4kln1r+qEIZ5YKwGoM6AvTQQguVBkf6Fax0d3cvuNOWzGbkqhRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VucRxMSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8447AC4CEC9;
	Thu, 26 Sep 2024 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727344267;
	bh=9ZXXL62CO9L7MkrvKkBtHpmLLSVAGUPp16RKqcXHYC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VucRxMSg0Bzqr/XQx12JhsBQyChNLaTrAsNX19Nk0BtrX70gL9WmhZfByXTM2i9dl
	 ZLALfX0/VJ+5O+PsqmDQ3aIs8SY2m+nzQmI37gyzEJNV33isj4c2Y2SUuqnFGxpYIU
	 04iwSkyN8kYlGgE2aR0zNqpkcmGME767+m2QpTygM2xhgQhmtzgfT0HLCx68kVdtjh
	 Fo/WV9lnmEpWplRJb92R7gn1StkBqGbMnL1FbUErlkbJ+8UGSw9MIA7wSLCB4xuMXp
	 U7VLtMTrxRBqcNa+lkzgUF0FbdPP1TN4Mh46HeiXB5L6a8Z//e2ZLvMBHpJK+JVM/l
	 Z0pfhIqWrL90w==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53655b9bbcdso945698e87.2;
        Thu, 26 Sep 2024 02:51:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSALlFoK1yVs6z27sZDIIsW7LGSXNwIIyw7PdPx9zMzbruYm64JYeFPCVXMZ77IaNX+QaphnHmrXGAv6Vq@vger.kernel.org, AJvYcCWs+xDn/xBTJAQyUqyZLUHAU19T+jeTK6mupoB1nXvDlWZQlb+39a4NZA4Vo7MwQis/IxNxjSTSqZTfqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Wu29/46ZOCvSLkNnb6j7BZXoMug2AZ2AUuxyZ7241PApMbh6
	GtV1jBuqjd2nfnDxJMEZ+Lxvlnpcy0xSYa7vR3Huh6LTifZmCX9iDhFz3R1H62bj+6ME0KXbhjU
	6H7AnRc0NUScMDruvPJg6CIdYavo=
X-Google-Smtp-Source: AGHT+IHtPY0AigQvOzwkGNuTgd7iJ/Zv5NiFYFAHgUF62JdilGYhzTjPpXGhd784w+LX3XVQNDNDIm3KXtZc1SoDDV0=
X-Received: by 2002:a05:6512:220f:b0:52e:fd53:a251 with SMTP id
 2adb3069b0e04-538775666edmr3675097e87.59.1727344265738; Thu, 26 Sep 2024
 02:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926075034.39475-1-riyandhiman14@gmail.com>
In-Reply-To: <20240926075034.39475-1-riyandhiman14@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Sep 2024 10:50:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7AG9+mAXv7Fk6td8KdAWfqK51MzXAMZHT0TnHSsbjHwA@mail.gmail.com>
Message-ID: <CAL3q7H7AG9+mAXv7Fk6td8KdAWfqK51MzXAMZHT0TnHSsbjHwA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove redundant stop_loop variable in scrub_stripe()
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 8:51=E2=80=AFAM Riyan Dhiman <riyandhiman14@gmail.c=
om> wrote:
>
> The variable stop_loop was originally introduced in commit
> 625f1c8dc66d7 (Btrfs: improve the loop of scrub_stripe). It was initializ=
ed
> to 0 in commit 3b080b2564287 (Btrfs: scrub raid56 stripes in the right wa=
y).
> However, in a later commit 18d30ab961497 (btrfs: scrub: use scrub_simple_=
mirror()
> to handle RAID56 data stripe scrub), the code that modified stop_loop was=
 removed,
> making the variable redundant.
>
> Currently, stop_loop is only initialized with 0 and is never used or modi=
fied
> within the scrub_stripe() function. As a result, this patch removes the
> stop_loop variable to clean up the code and eliminate unnecessary redunda=
ncy.
>
> This change has no impact on functionality, as stop_loop was never utiliz=
ed
> in any meaningful way in the final version of the code.
>
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Compile tested only
>
>  fs/btrfs/scrub.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 3a3427428074..43431065d981 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2256,7 +2256,6 @@ static noinline_for_stack int scrub_stripe(struct s=
crub_ctx *sctx,
>         /* Offset inside the chunk */
>         u64 offset;
>         u64 stripe_logical;
> -       int stop_loop =3D 0;
>
>         /* Extent_path should be released by now. */
>         ASSERT(sctx->extent_path.nodes[0] =3D=3D NULL);
> @@ -2370,14 +2369,8 @@ static noinline_for_stack int scrub_stripe(struct =
scrub_ctx *sctx,
>                 logical +=3D increment;
>                 physical +=3D BTRFS_STRIPE_LEN;
>                 spin_lock(&sctx->stat_lock);
> -               if (stop_loop)
> -                       sctx->stat.last_physical =3D
> -                               map->stripes[stripe_index].physical + dev=
_stripe_len;
> -               else
> -                       sctx->stat.last_physical =3D physical;
> +               sctx->stat.last_physical =3D physical;
>                 spin_unlock(&sctx->stat_lock);
> -               if (stop_loop)
> -                       break;
>         }
>  out:
>         ret2 =3D flush_scrub_stripes(sctx);
> --
> 2.46.1
>
>

