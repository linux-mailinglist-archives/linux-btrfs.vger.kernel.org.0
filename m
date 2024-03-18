Return-Path: <linux-btrfs+bounces-3353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF187E9B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 14:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C847C2831C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58AD383B2;
	Mon, 18 Mar 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHiDK/BI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527138387
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766968; cv=none; b=kBjMXLuY9C6HhSljwmYbN15EIMXaVKhHQn3MUdN+JyMIYmj/H3n48hFHzgHFdgcrhA5/sqhkjoWrreosBMFOqm/tBYHLFD31iyNTL4QSktbKO5uUJoduqwfYvrx60ODsxaI5PrIjti0F2LNYNPyQE8mLr1h1qbAA+iNTMbUV4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766968; c=relaxed/simple;
	bh=CFlsGWv61liP0EyveJhhDTS+ciRMbtr+YTJFQOH8LBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMg2IvTtBQsQqAaTDWlPXMYmj1KUdM51d0Hrp8Zt/iiEIlCIHsp3BQtkZbQeVIjKoJoTolWsN0EcS4o7z0x92/umxHyrLBlJXpsyz5KqyhGMopOO+idedY1ycAEMY1Eh1q/NY0fO3+6PHw2KmBlxNEsHz7/c3YLlBVDr9oSlrH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHiDK/BI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71434C433B1
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 13:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710766967;
	bh=CFlsGWv61liP0EyveJhhDTS+ciRMbtr+YTJFQOH8LBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jHiDK/BIzdn3zgcm76gn9oZ+Wa1+E8g7mxdGvhrG7PYJyFgpnr/Qjasd38lGSnY5n
	 m8Xncs6Mc4L7UwTvI3UuxKLpdPqzSoM5Ticvg1a3fmUpaKBeaC4qLDOOI2JWdfoViC
	 BUf6OTN6f6uElpk80+RObgyXOnmByF0c1QRIRUWrGB7E83hTTebYw88MS171uogNLO
	 99wEbj5C/wHhbYqlr1HNio+m85ZJlgJdU5cE2la9G9S6chTjf9G/DFfICUYhjXMz/r
	 2zAKpWS7zlMDN6V2qSTblfo5GF9zQC5Zi6jKby1TRcC8B1fV9v0cb3j6tsrWFBizZ1
	 W/mYhmV2zazFA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46cc947929so76847966b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 06:02:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzmkwrj7AC30ck8ZWdeaBy+UKXFDf1DQuqaY4rjfwNjhFXc2R+V
	vYtxltrxysp1WxL7EXkwDvi7naPNoWsXBPlojt4W9sP8eTfelerW+UHhjcf9s8ZK0gocAucEAjQ
	YJKhh5Tqmo37ebOsyzbOz53VPY7I=
X-Google-Smtp-Source: AGHT+IHty+dQfEq1nmHibKNFxK+yQ0uaSGGMNupRJBlW53GNNZHuAQOkGF9XfEfHRKxGpW4O5BsVZTlKWefRC4/6mvk=
X-Received: by 2002:a17:907:1119:b0:a46:2c22:7f4c with SMTP id
 qu25-20020a170907111900b00a462c227f4cmr5912624ejb.35.1710766966033; Mon, 18
 Mar 2024 06:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b46794f0115a70b4d0dd1ececa993bd0186a80d8.1710766178.git.jth@kernel.org>
In-Reply-To: <b46794f0115a70b4d0dd1ececa993bd0186a80d8.1710766178.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 18 Mar 2024 13:02:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7=VvC1_O81fsdVYxL5AyS0PESO5_5m2oOV_9HU_Eu4=g@mail.gmail.com>
Message-ID: <CAL3q7H7=VvC1_O81fsdVYxL5AyS0PESO5_5m2oOV_9HU_Eu4=g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: don't skip bgs with 100% zone unusable
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 12:50=E2=80=AFPM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Commit f4a9f219411f ("btrfs: do not delete unused block group if it may b=
e
> used soon") changed the behaviour of deleting unused block-groups on zone=
d
> filesystems. Starting with this commit, we're using
> btrfs_space_info_used() to calculate the number of used bytes in a
> space_info. But btrfs_space_info_used() also accounts
> btrfs_space_info::bytes_zone_unusable as used bytes.
>
> So if a block group is 100% zone_unusable it is skipped from the deletion
> step.
>
> In order not to skip fully zone_unusable block-groups, also check if the
> block-group has bytes left that can be used on a zoned filesystem.
>
> Fixes: f4a9f219411f ("btrfs: do not delete unused block group if it may b=
e used soon")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/block-group.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5f7587ca1ca7..1e09aeea69c2 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1559,7 +1559,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *=
fs_info)
>                  * needing to allocate extents from the block group.
>                  */
>                 used =3D btrfs_space_info_used(space_info, true);
> -               if (space_info->total_bytes - block_group->length < used)=
 {
> +               if (space_info->total_bytes - block_group->length < used =
&&
> +                   block_group->zone_unusable < block_group->length) {
>                         /*
>                          * Add a reference for the list, compensate for t=
he ref
>                          * drop under the "next" label for the
> --
> 2.35.3
>
>

