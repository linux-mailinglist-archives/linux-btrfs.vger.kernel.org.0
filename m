Return-Path: <linux-btrfs+bounces-12985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55556A87D13
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 12:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB891887025
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D214426A1B3;
	Mon, 14 Apr 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJESOu4b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155426770B
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625303; cv=none; b=UFTJbZYF4Ps8Abdw6liwLhb/Nypv5h8iO2lbvd2io4xcGnllLQ1D1wG8a93k5gBzh+8TTRYDpFLKHbJUpQlGWZX6Sz6gA5z/LSHB/MHg9YaffterK/hVByNuYNad/XmdAcVaUH/nDjxrSA2gMk47gbP3Tp1L2VhkXsHbWXWL9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625303; c=relaxed/simple;
	bh=v+7R4ZaCR+Eciqss807+mKOYM0jwWRbUR1axGBiKWt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRrBs3XlbvRW3rgeN2XYit6A7+zN3fqZ7gYw9xRKDJxtfcHLItWe6ERx6Jd5HtT3AB46Zvh5v9nzZpiMW1QeVilzeWsYEAmlzBKga71+KdJUdWRiQG2GjIvzjNryZDCmD+0J7TbfiQP1Rz/Iyaa+e19PX/FQ08dRBEOBza5RS28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJESOu4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E206C4CEE2
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 10:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625302;
	bh=v+7R4ZaCR+Eciqss807+mKOYM0jwWRbUR1axGBiKWt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BJESOu4bZ/ZtUugFtcKX0ydCb2dmkLzEZecpvjgGAWbDh6A9lSKcvNuiyaHkAysxI
	 ezB3RB0oMg+KNR4QpL5aU3t8KDNUHeezxVCcHbCYc1AXb8cwFplkWQCJk1GISRShMH
	 Y9D55Cgx0oWmCT/EJFaKD8YUjs7aWcQtOe5VoxVTGZQdoJjWK8jVt9X43CPfrSoxiB
	 WlIBVkxC1Q5mSMmoNKUlSGTYiTwLUBsXZAc+767sjCccNJdx+5Hj2HsrOUFIGs+FgD
	 S05/fd0oM55sZPJ9a7KvdPletjDVl0qXLiY63o6CLNRaR7d4s6rSuW86vaiRs+OZf9
	 sgvzQ0I3axEPQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaecf50578eso754928966b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 03:08:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YzTYXAQVOKr6+urjLoQHoNt/Ky2cRRMIG2T32jpP8F4RyXid+5e
	a3MR7xmWBTZaVyzKIa4WU7XYnKsiiWfmFi7NFd/If+HvY9MoNnQH1Cjtka0tE0YhoCLzEs5NPFl
	s+YypSDN6Jkjlgx6Jlblw/23yApI=
X-Google-Smtp-Source: AGHT+IHn9akgNkBtRtlBQLhkGODYkiC/j2b7j2nbuDLWQvffTZv/Zzis4FJ2Aix86IbQ9sNE2oWjWcTRgxTQvxJ3s38=
X-Received: by 2002:a17:907:940a:b0:abf:6ec7:65e9 with SMTP id
 a640c23a62f3a-acad36a6206mr983536666b.43.1744625301106; Mon, 14 Apr 2025
 03:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414074610.2475801-1-davechen@synology.com>
In-Reply-To: <20250414074610.2475801-1-davechen@synology.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 14 Apr 2025 11:07:44 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7ufiHA82vvGM-nh3M9kFoUxBg4cS2WB9duB5D=Zo5C4w@mail.gmail.com>
X-Gm-Features: ATxdqUHn2132DjSIJczF8aUHfR4BjV5vdo41puwKGiJCxvEoxoYi7Rff6aFLCfc
Message-ID: <CAL3q7H7ufiHA82vvGM-nh3M9kFoUxBg4cS2WB9duB5D=Zo5C4w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix COW handling in run_delalloc_nocow function
To: davechen <davechen@synology.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, cccheng@synology.com, 
	robbieko@synology.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 8:54=E2=80=AFAM davechen <davechen@synology.com> wr=
ote:
>
> In run_delalloc_nocow(), when the found btrfs_key's offset > cur_offset,
> it indicates a gap between he current processing region and

he -> the

> the next file extent. The original code would directly jump to
> the "must_cow" label, which implicitly increments the slot and

Implicitly? It's very explicit, we have the expression "path->slots[0]++".
So just remove the "implicitly" word.

> forces a fallback to COW. This behavior might skip an extent item and
> result in an overestimated COW fallback range.
>
> This patch modifies the logic so that when a gap is detected:
>   - If no COW range is already being recorded (cow_start is unset),
>     cow_start is set to cur_offset.
>   - cur_offset is then advanced to the beginning of the next
>     extent (extent_end).
>   - Instead of jumping to "must_cow", control flows directly to
>     "next_slot" so that the same extent item can be reexamined properly.
>
> The change ensures that we accurately account for the extent gap and
> avoid accidentally extending the range that needs to fallback to COW.
>
> Signed-off-by: Dave Chen <davechen@synology.com>
> ---
>  fs/btrfs/inode.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5b842276573e..58457bdf984d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2160,7 +2160,10 @@ static noinline int run_delalloc_nocow(struct btrf=
s_inode *inode,
>                 if (found_key.offset > cur_offset) {
>                         extent_end =3D found_key.offset;
>                         extent_type =3D 0;
> -                       goto must_cow;
> +                       if (cow_start =3D=3D (u64)-1)
> +                               cow_start =3D cur_offset;
> +                       cur_offset =3D extent_end;
> +                       goto next_slot;

Now that we jump to "next_slot" and not "must_cow" anymore, we should also:

1) remove the line above that sets extent_type to 0, no longer needed;

2) no need for setting extent_end either, we can just remove it and
set cur_offset to found_key.offset.

Otherwise it looks good, and with those minor changes made:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>                 }
>
>                 /*
> --
> 2.43.0
>
>

