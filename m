Return-Path: <linux-btrfs+bounces-1391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766CB82AD97
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 12:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1719EB2300C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 11:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198201549A;
	Thu, 11 Jan 2024 11:35:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B5515482
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so5904236e87.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 03:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704972909; x=1705577709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEfyjaJMhM1H/BiRp7agiyjCKdUFttJns63mgn3ANHY=;
        b=iQo0yyuDLWNH/ljDjaLn53O1LqDie0fAGxBptEwz+qh0YMNzF9fDD/k6NmpwaaWxd2
         BVfRhhcKnFAl3tukr4Ywch5GftI/29OV5e0Cqw6tFMVQB5DpvZ4cn0zQwDFkyJy9dGmf
         IANkT36gnRMowQGHFAi2hP2Pj09vYnJzbAi1KkLK/jUKj8LZZXx3vHTOjCL25+D7Z/Yh
         dru13eO0N1rC0YzO49gb6HRTWl2zHQ+522+PZqy6a4VLXvi58v3gpI22sTsII1Zz569K
         TMOPD7qENlJX/PTxOzGQkttkf8Io6k654L1R9UDdo6P/HXSXP1qHSEr4sstGX967I6lB
         ErHg==
X-Gm-Message-State: AOJu0YzzXBeBVIcrKszen0Zex96Bx46hxQf0xlbtN2dIAFut6gwVI050
	B1vFPDa1qnq4RbYg1sf5UKm27m6kK6ftD7W7
X-Google-Smtp-Source: AGHT+IH3cboZGSaDmZ2dE7OujjQiLLqCGOcXNe0yMuFGifcLJskanZYDyAMmxB7/dCpA/yAu9hFVtQ==
X-Received: by 2002:a05:6512:32bc:b0:50e:7de4:8626 with SMTP id q28-20020a05651232bc00b0050e7de48626mr478195lfe.108.1704972909442;
        Thu, 11 Jan 2024 03:35:09 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id h16-20020a170906399000b00a28a66028bcsm473188eje.91.2024.01.11.03.35.09
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 03:35:09 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2bdc3a3c84so174908766b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 03:35:09 -0800 (PST)
X-Received: by 2002:a17:907:3a54:b0:a26:cee8:3713 with SMTP id
 fc20-20020a1709073a5400b00a26cee83713mr456826ejc.55.1704972909180; Thu, 11
 Jan 2024 03:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18faaced53d356f66b4b1f0f118d15e37e3c8a2c.1704909267.git.josef@toxicpanda.com>
In-Reply-To: <18faaced53d356f66b4b1f0f118d15e37e3c8a2c.1704909267.git.josef@toxicpanda.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 11 Jan 2024 06:34:32 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8K1f-ucrFZuHMGm=fk6ZzAy-j6jMuS9YO9t4s5_pP2vw@mail.gmail.com>
Message-ID: <CAEg-Je8K1f-ucrFZuHMGm=fk6ZzAy-j6jMuS9YO9t4s5_pP2vw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use the original mount's mount options for the
 legacy reconfigure
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 12:57=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> btrfs/330, which tests our old trick to allow
>
> mount -o ro,subvol=3D/x /dev/sda1 /foo
> mount -o rw,subvol=3D/y /dev/sda1 /bar
>
> fails on the block group tree.  This is because we aren't preserving the
> mount options for what is essentially a remount, and thus we're ending
> up without the FREE_SPACE_TREE mount option, which triggers our free
> space tree delete codepath.  This isn't possible with the block group
> tree and thus it falls over.
>
> Fix this by making sure we copy the existing mount options for the
> existing fs mount over in this case.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 3a677b808f0f..f192f8fe0ce6 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1451,6 +1451,14 @@ static int btrfs_reconfigure(struct fs_context *fc=
)
>
>         btrfs_info_to_ctx(fs_info, &old_ctx);
>
> +       /*
> +        * This is our "bind mount" trick, we don't want to allow the use=
r to do
> +        * anything other than mount a different ro/rw and a different su=
bvol,
> +        * all of the mount options should be maintained.
> +        */
> +       if (mount_reconfigure)
> +               ctx->mount_opt =3D old_ctx.mount_opt;
> +
>         sync_filesystem(sb);
>         set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
>
> --
> 2.43.0
>
>

This makes sense, though I don't think this is a particularly intuitive fea=
ture.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

