Return-Path: <linux-btrfs+bounces-4270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EF78A50D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 15:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D3F1C20D71
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D5985654;
	Mon, 15 Apr 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loGHcxR+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1085266
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185890; cv=none; b=efvM6T+MK2ybj8Vvn2HQAyTo7Je2my2gZLwMJwSMsmi2ElII6fZQ4YpstrqcIMmeACQL7JTfL3vzLj1Fyx1XBEnnYK2//zfnfTtzzW2BZcqms3YNDYslINGJfO1EdPZ3kl37AQGbct9iP+2HVtUV75ocUJ7qXkho85vlGJ5nOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185890; c=relaxed/simple;
	bh=cQr2mWxqyGQgswRBBVVEp1dlzGtwDpCNR4dkQQ9eBgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saIyQyKHvaf0puA94D7GxlX+NHfeXdEVPwhqh0+NF+7EePVnva7/yki/oAMzYStpiRsYYjFWUbzmpzGp0iUNzP315mlFtpjrcJ//OqRm78FkpkSk6cuQhjAirPAaAeC/K6jt+GOlkyJD+R676me6S29/EAJIR0+97ZRw+V0JdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loGHcxR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D2CC2BD10
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185890;
	bh=cQr2mWxqyGQgswRBBVVEp1dlzGtwDpCNR4dkQQ9eBgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=loGHcxR+/e93O5v9fFvsQ1C3JQpzzKRFs2coN5uDcyx6UtZsXYqbiGT6E0B4BQHrE
	 gK2SLieAw3CVk7nhJJ6PVbVx+6Te95uDO7ks5PrLQrjCZR10IZPhwMXCt38ITLuX6s
	 inYs1CBu6+mzN97aTs4gQNh+fsBjKeMvMp0hWOJOTlgXPKIl/K0SHLzAPP5HNL+SIY
	 CiwkdSYVGTUsX13AmB2DRoYQc8nCvhhCZUwTUKc/Y8u4DVLHi/dCp4asKVeKBawmmA
	 xMuepP22AcQZKX7tC8G3BbvGFDPptFPLUhAsqTw0ARtVEDcrjetelKSovph83/Sg3Q
	 rVFbghx80hAVw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4715991c32so407600466b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 05:58:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YwCaSAsGpBemyrAlBjvfbn/T9YYeEy4fCOcNj3COd/2LNQS2lGL
	C1kcGq5l05grryBk467y01pbUmJpOO3o0J334OTHym9OA7iUp3464MQ1dYgTRANrGjJmrEqip/P
	Bqfa9pOjtuAItr9spPdWdOx1Ru5Y=
X-Google-Smtp-Source: AGHT+IEw/Z55QNr9eYbp4AICnhzr6ALiYLjBTPWRF2QfuyNpDP+nSVTjjk6LIZwzy2m+5J2WThDSXCflx8Wd3PiuDvo=
X-Received: by 2002:a17:907:ea3:b0:a52:22e7:4003 with SMTP id
 ho35-20020a1709070ea300b00a5222e74003mr7710641ejc.49.1713185889075; Mon, 15
 Apr 2024 05:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713052088.git.josef@toxicpanda.com> <a9d11bba7cab6dcef20c578a9546361daad1ed5f.1713052088.git.josef@toxicpanda.com>
In-Reply-To: <a9d11bba7cab6dcef20c578a9546361daad1ed5f.1713052088.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Apr 2024 13:57:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H74hbGhfKUroHWjCMxdd+g1efd6ShZRChZ3ZwQzUt+KtA@mail.gmail.com>
Message-ID: <CAL3q7H74hbGhfKUroHWjCMxdd+g1efd6ShZRChZ3ZwQzUt+KtA@mail.gmail.com>
Subject: Re: [PATCH 12/19] btrfs: rename btrfs_data_ref->ino to ->objectid
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 12:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> This is how we refer to it in the rest of the extent reference related
> code, make it consistent.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/delayed-ref.c | 4 ++--
>  fs/btrfs/delayed-ref.h | 2 +-
>  fs/btrfs/ref-verify.c  | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index f9779142a174..397e1d0b4010 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -983,7 +983,7 @@ static void init_delayed_ref_common(struct btrfs_fs_i=
nfo *fs_info,
>         INIT_LIST_HEAD(&ref->add_list);
>
>         if (generic_ref->type =3D=3D BTRFS_REF_DATA) {
> -               ref->data_ref.objectid =3D generic_ref->data_ref.ino;
> +               ref->data_ref.objectid =3D generic_ref->data_ref.objectid=
;
>                 ref->data_ref.offset =3D generic_ref->data_ref.offset;
>         } else {
>                 ref->tree_ref.level =3D generic_ref->tree_ref.level;
> @@ -1014,7 +1014,7 @@ void btrfs_init_data_ref(struct btrfs_ref *generic_=
ref, u64 ino, u64 offset,
>         /* If @real_root not set, use @root as fallback */
>         generic_ref->real_root =3D mod_root ?: generic_ref->ref_root;
>  #endif
> -       generic_ref->data_ref.ino =3D ino;
> +       generic_ref->data_ref.objectid =3D ino;
>         generic_ref->data_ref.offset =3D offset;
>         generic_ref->type =3D BTRFS_REF_DATA;
>         if (skip_qgroup || !(is_fstree(generic_ref->ref_root) &&
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 6ad48e0a0a1a..3e7afac518ac 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -226,7 +226,7 @@ struct btrfs_data_ref {
>         /* For EXTENT_DATA_REF */
>
>         /* Inode which refers to this data extent */
> -       u64 ino;
> +       u64 objectid;
>
>         /*
>          * file_offset - extent_offset
> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
> index 94bbb7ef9a13..cf531255ab76 100644
> --- a/fs/btrfs/ref-verify.c
> +++ b/fs/btrfs/ref-verify.c
> @@ -688,7 +688,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
>                 owner =3D generic_ref->tree_ref.level;
>         } else if (!parent) {
>                 ref_root =3D generic_ref->ref_root;
> -               owner =3D generic_ref->data_ref.ino;
> +               owner =3D generic_ref->data_ref.objectid;
>                 offset =3D generic_ref->data_ref.offset;
>         }
>         metadata =3D owner < BTRFS_FIRST_FREE_OBJECTID;
> --
> 2.43.0
>
>

