Return-Path: <linux-btrfs+bounces-2211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0FE84CCC4
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 15:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B8328D574
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66F47E57A;
	Wed,  7 Feb 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD33pLPi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF298374E0
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316304; cv=none; b=VFYHCSJRlSNTigVBGWXNVPNLjAEBjQHLl6O5yW6OwXchVql6yW2fxQVnMmntJ0tagLh16k4WKWlkN3m7fBxX6n2h6nBgn/V0RtUDAGvJxD+DHTruPrHvR0K/vEhsgWrHrr79e0+KAz48yAvGSZTN0UmXEr/qZDwP1bfpYk/7+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316304; c=relaxed/simple;
	bh=ogGfk0DCqoDnpAJ1UEcDDgjwA+T3LPkL7pzDfW4kokU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZowq/4gbeM2pOxFE6/k98VdIMW/wy1XxAw4AgAtfYBSqODbrzej8bt4kmPZcEeWUPD+0LxzVj56xfEVapkF7VE7hrxcoCwGCgvyRzyBpRLcJm3QZDsq8/P61CQjezbmt48HDsLA2OiYwtOFmDFVb/lyNfJolOw4DHJYYHilCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD33pLPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58274C43390
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707316304;
	bh=ogGfk0DCqoDnpAJ1UEcDDgjwA+T3LPkL7pzDfW4kokU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GD33pLPiD1V0nMJD0kcaaGDa0KrPA5iWUb6VqMKtjJiZgX+JBHjFgMM+KPZ7Ge4di
	 QpcshCcfMhYyRAM3Og4ssyNXx5qD5R8MKo/y3le+lSYvGgeCylL/c4+c0uVyQYxO37
	 SV42AX7tKn1vLRxPko4PBtbwj/Qv5ldPurvdTy0JHUtlVBpiLqnTP5+/lEayP+biOv
	 JH/usiyHr4tKuAxptaHtSIuShYrmSpzug381TU1xueIH1lZuPCU3PuF75S3Lxg/NcY
	 jGrgNomo5kHuDZVnO0kTMw9588Wsm46p06zN4yfXj9AfmP/+4xjp6cgU8gpJWdEf6V
	 n+56WGj5drPog==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a370328e8b8so86674266b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Feb 2024 06:31:44 -0800 (PST)
X-Gm-Message-State: AOJu0Yykb4ikMn5DNNDw7VvYykYAtxW6CzBCiaJImWknMtVy579AS9AS
	N9L3hIpqfYGdA6vXyfUl3tBLRDdi/F4OFDmHE7WzOVwjsAImDq2o4cFM9M/+Mz9g8/LMVWSM/bx
	VzroLGdnlXUD4UgEivEmxh1CpHg4=
X-Google-Smtp-Source: AGHT+IFYTsKXX5YoN0J2wC69kyUpCdf+CAZDJwb+h6Ua3wJsu5Kqw08LnFpdIaGBbxzKqaCtw65KIeC6qNWQ+lj2slk=
X-Received: by 2002:a17:906:fac5:b0:a38:63d4:2273 with SMTP id
 lu5-20020a170906fac500b00a3863d42273mr1853597ejb.35.1707316302600; Wed, 07
 Feb 2024 06:31:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abb506b3d54837f79119cdff6c3e08a61e28eba7.1707259963.git.wqu@suse.com>
In-Reply-To: <abb506b3d54837f79119cdff6c3e08a61e28eba7.1707259963.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 7 Feb 2024 14:31:05 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5YavN98A2HyAfSumebCx-7SwtbhP6+w9uJXdvP3OwwVA@mail.gmail.com>
Message-ID: <CAL3q7H5YavN98A2HyAfSumebCx-7SwtbhP6+w9uJXdvP3OwwVA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: defrag: avoid unnecessary defrag caused by
 incorrect extent size
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:30=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> With the following file extent layout, defrag would do unnecessary IO
> and result more on-disk space usage.
>
>  # mkfs.btrfs -f $dev
>  # mount $dev $mnt
>  # xfs_io -f -c "pwrite 0 40m" $mnt/foobar
>  # sync
>  # xfs_io -f -c "pwrite 40m 16k" $mnt/foobar.

Unintended . at the end of the filenamme.

>  # sync
>
> Above command would lead to the following file extent layout:
>
>         item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>                 generation 7 type 1 (regular)
>                 extent data disk byte 298844160 nr 41943040
>                 extent data offset 0 nr 41943040 ram 41943040
>                 extent compression 0 (none)
>         item 7 key (257 EXTENT_DATA 41943040) itemoff 15763 itemsize 53
>                 generation 8 type 1 (regular)
>                 extent data disk byte 13631488 nr 16384
>                 extent data offset 0 nr 16384 ram 16384
>                 extent compression 0 (none)
>
> Which is mostly fine. We can allow the final 16K to be merged with the
> previous 40M, but it's upon the end users' preference.
>
> But if we defrag the file using the default parameters, it would result
> worse file layout:
>
>  # btrfs filesystem defrag $mnt/foobar
>  # sync
>
>         item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>                 generation 7 type 1 (regular)
>                 extent data disk byte 298844160 nr 41943040
>                 extent data offset 0 nr 8650752 ram 41943040
>                 extent compression 0 (none)
>         item 7 key (257 EXTENT_DATA 8650752) itemoff 15763 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 340787200 nr 33292288
>                 extent data offset 0 nr 33292288 ram 33292288
>                 extent compression 0 (none)
>         item 8 key (257 EXTENT_DATA 41943040) itemoff 15710 itemsize 53
>                 generation 8 type 1 (regular)
>                 extent data disk byte 13631488 nr 16384
>                 extent data offset 0 nr 16384 ram 16384
>                 extent compression 0 (none)
>
> Note the original 40M extent is still there, but a new 32M extent is
> created for no benefit at all.
>
> [CAUSE]
> There is an existing check to make sure we won't defrag a large enough
> extent (the threshold is by default 32M).
>
> But the check is using the length to the end of the extent:
>
>         range_len =3D em->len - (cur - em->start);
>
>         /* Skip too large extent */
>         if (range_len >=3D extent_thresh)
>                 goto next;
>
> This means, for the first 8MiB of the extent, the range_len is always
> smaller than the default threshold, and would not be defragged.
> But after the first 8MiB, the remaining part would fit the requirement,
> and be defragged.
>
> Such different behavior inside the same extent caused the above problem,
> and we should avoid different defrag decision inside the same extent.
>
> [FIX]
> Instead of using @range_len, just use @em->len, so that we have a
> consistent decision among the same file extent.
>
> Now with this fix, we won't touch the extent, thus not making it any
> worse.
>
> Fixes: 0cb5950f3f3b ("btrfs: fix deadlock when reserving space during def=
rag")
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>


> ---
>  fs/btrfs/defrag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 8fc8118c3225..eb62ff490c48 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1046,7 +1046,7 @@ static int defrag_collect_targets(struct btrfs_inod=
e *inode,
>                         goto add;
>
>                 /* Skip too large extent */
> -               if (range_len >=3D extent_thresh)
> +               if (em->len >=3D extent_thresh)
>                         goto next;
>
>                 /*
> --
> 2.43.0
>
>

