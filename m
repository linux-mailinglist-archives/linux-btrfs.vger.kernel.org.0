Return-Path: <linux-btrfs+bounces-15049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94535AEB833
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 14:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CC16408EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3DD2D9787;
	Fri, 27 Jun 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzfNh/J0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191D29993D
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028843; cv=none; b=mwxV1HLxS04C1BkIZ6R5rXJFYD6h4YTbcQ+IChNR3rip3vlq0mbSN3XQRNIyPlBVjstDU2XzoVd2WDPiy3EvZQOkhs97qxMJxkaK98l4kgWzIZfiOx2Voj3Ie7tP4hs5EPwAuQFzvZLYIw362F4k81KzrR1K1+VNTjLhIMgIoew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028843; c=relaxed/simple;
	bh=yMDUzK96/4QWn4rsPDmaFmh/zPSEjbPhpAp3ZRIoOqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYBRiRteuWwUV83nl2+cP6DAKVEJdxT4gEVroI235IaDZPMetSSRuIzoepBNRXb2B1iYPefc5H1RqAHEtzu5QqsMpWCAcmI/oc9yJVW1EACbKdSG9pxHrQyjKf5vuJkAI6x8LqFyXThxWZa0GgT8Lef36MsY7ushjV7nGN9BETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzfNh/J0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F356DC4CEED
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751028843;
	bh=yMDUzK96/4QWn4rsPDmaFmh/zPSEjbPhpAp3ZRIoOqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uzfNh/J00/mY0XVYPt3/uurBg4hRfzWVRvebSUS0Hw6Tl9DoAwzfQQ2a4lRbaP4G7
	 PyBOGEi7NpNsIxgt04OpUYYcrz6bhVS+42Sg2x+B2npSBWcilXEOEAHRI6svTgfTxJ
	 9DKr2FRWOZiWq1Mx1kiSWou6vK0+M8Aw6BL5ZZ1pCqo98gtbN94BF4u1cLxVL7NpVt
	 K9fJ3wP+dhNlnXDv9NyE0A1yJGVnLZqiqR1cL25V80eDq710AB5ziXDT2NZAt/6zfP
	 lH91NXcJBirT4EqCg+XuXuQjF3AwGgAuvPy8cgnxf8Acze9J4yFnaJujlCzsQkhiZZ
	 OZkMYIbkn/oSw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0df6f5758so258335266b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 05:54:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVivaeeVQh5OMapJLxIUWiNL3DnuwfNHlvbIl1A4DbIcGferYXEKzsffukLw1EWwfkT2rc624U5cOofgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7ZksV1fu7iNfl4/mocKT2tWHD1B9h66ELz33XwrAujz4vYwi
	HsSK9wCyGpSQKfhNwQqDLJlacFHqcnl37v32NxZupQcCpeWOeDj3Uz6bin6d0Ob7vdrgpztaMx6
	kWg5+uqQlrDsnVPXXutbLWcRzo72S7DI=
X-Google-Smtp-Source: AGHT+IFhjHvAssCYXBfwhRapXKmx9DlMWf3//c4Pp+W5aHH6ZX17qYOJNtJNu+oZKNCfIQ2nyQqya1fn45br/8awNZY=
X-Received: by 2002:a17:907:c807:b0:add:f0a2:d5d8 with SMTP id
 a640c23a62f3a-ae34fd1847bmr273137566b.11.1751028841586; Fri, 27 Jun 2025
 05:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627085117.738091-1-dmantipov@yandex.ru>
In-Reply-To: <20250627085117.738091-1-dmantipov@yandex.ru>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Jun 2025 13:53:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7X=QJ2VSj=bwANby7XeFfJkK4B+fB0pYVi7Hpc85BDjQ@mail.gmail.com>
X-Gm-Features: Ac12FXwXnZc5a7ytQUND1_R9_UY45Kz3IoqE555jql6MSOKlGO1EDl9dg8YFweI
Message-ID: <CAL3q7H7X=QJ2VSj=bwANby7XeFfJkK4B+fB0pYVi7Hpc85BDjQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: avoid extra calls to strlen() in gen_unique_name()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 9:52=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> Since 'snprintf()' returns the number of characters which would
> be emitted and output truncation is handled by 'ASSERT()', it
> should be safe to use that return value instead of the subsequent
> calls to 'strlen()' in 'gen_unique_name()'. Compile tested only.

Looks good and it passes fstests.
It also reduces the btrfs module's text size.

Before:

$ size fs/btrfs/btrfs.ko
   text    data     bss     dec     hex filename
1897006 161571   16136 2074713 1fa859 fs/btrfs/btrfs.ko

After:

$ size fs/btrfs/btrfs.ko
   text    data     bss     dec     hex filename
1896848 161571   16136 2074555 1fa7bb fs/btrfs/btrfs.ko

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I'll push this to the btrfs for-next branch at github, removing the
"Compile tested only." sentence from the changelog (it doesn't look
good you know..") and also mention that it reduces the module's text
size too.

Thanks.

>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  fs/btrfs/send.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 2891ec4056c6..a045c1be49ba 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -1804,7 +1804,7 @@ static int gen_unique_name(struct send_ctx *sctx,
>                                 ino, gen, idx);
>                 ASSERT(len < sizeof(tmp));
>                 tmp_name.name =3D tmp;
> -               tmp_name.len =3D strlen(tmp);
> +               tmp_name.len =3D len;
>
>                 di =3D btrfs_lookup_dir_item(NULL, sctx->send_root,
>                                 path, BTRFS_FIRST_FREE_OBJECTID,
> @@ -1843,7 +1843,7 @@ static int gen_unique_name(struct send_ctx *sctx,
>                 break;
>         }
>
> -       ret =3D fs_path_add(dest, tmp, strlen(tmp));
> +       ret =3D fs_path_add(dest, tmp, len);
>
>  out:
>         btrfs_free_path(path);
> --
> 2.50.0
>
>

