Return-Path: <linux-btrfs+bounces-986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D13881518A
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 22:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4E6B21018
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 21:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9788547793;
	Fri, 15 Dec 2023 21:03:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFD47F42;
	Fri, 15 Dec 2023 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a1e2f34467aso90898866b.2;
        Fri, 15 Dec 2023 13:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702674191; x=1703278991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdXPhVoljjpQ/GSCvKTA3xcVcrs4S0B/iVQWRUeQUaw=;
        b=j3FzpsNQY0ye4m28HqDkJlPvdSFEH1SfGgXzYG6486Bn0l12lh7k6A6+KoibRIW++g
         vVWaENSnhh1bglKUx9nPV0TDqMoW8q23rKPhaPLV6RIDouxVuotNUwu3kPDsnpaupwF2
         sIFlJVaWBR0bz4TrIl2PJf+7jXy5r9WNNC38o8dQQvzToT2njKOqo+S59M7f9u+x5Z6d
         7EAdDVm5YMtOlLj3LwcYmxB0mlgrrwBn3Oqt5xczwXcaPu8unUoHySgsrGUuJnQmPNGK
         oEl+8ROGnbDD8oZOhK+V98ixcg7NeONfnErjcuPFt1Bb8ubnTCa0yQPHSsiZFH6h8neb
         eiGw==
X-Gm-Message-State: AOJu0YxzNGLpbAnfQ033GauPUJSSsy0MReSKfJUpR4794wdzg2PMXwF2
	bDJK/zBWU7JgBqgoZPkDW6et/JU+gmp/1rHW
X-Google-Smtp-Source: AGHT+IFrggzcXEeLB86xDwo6+SDJoIT3Q4jjeswibtTl8ZJM25F1sT9EwdrfJOXiRYd7Ei78hhz6gQ==
X-Received: by 2002:a17:907:707:b0:a10:c6ab:9cbe with SMTP id xb7-20020a170907070700b00a10c6ab9cbemr8666300ejb.46.1702674191041;
        Fri, 15 Dec 2023 13:03:11 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id un7-20020a170907cb8700b009fc42f37970sm11262325ejc.171.2023.12.15.13.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 13:03:10 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3364a5ccbb1so966926f8f.1;
        Fri, 15 Dec 2023 13:03:10 -0800 (PST)
X-Received: by 2002:adf:d1ce:0:b0:336:3dcd:186b with SMTP id
 b14-20020adfd1ce000000b003363dcd186bmr3450891wrd.63.1702674190638; Fri, 15
 Dec 2023 13:03:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <27a3901ec5c2f63650441e5c99f430fce864b609.1702652494.git.josef@toxicpanda.com>
In-Reply-To: <27a3901ec5c2f63650441e5c99f430fce864b609.1702652494.git.josef@toxicpanda.com>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 15 Dec 2023 16:02:33 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8A+NJbhXnaWwhCNFW=DnSe-soQc49EVY=pY2wQg+b-bg@mail.gmail.com>
Message-ID: <CAEg-Je8A+NJbhXnaWwhCNFW=DnSe-soQc49EVY=pY2wQg+b-bg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not allow non subvolume root targets for snapshot
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 10:02=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> Our btrfs subvolume snapshot <source> <destination> utility enforces
> that <source> is the root of the subvolume, however this isn't enforced
> in the kernel.  Update the kernel to also enforce this limitation to
> avoid problems with other users of this ioctl that don't have the
> appropriate checks in place.
>
> cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ioctl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 4e50b62db2a8..298edca43901 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1290,6 +1290,16 @@ static noinline int __btrfs_ioctl_snap_create(stru=
ct file *file,
>                          * are limited to own subvolumes only
>                          */
>                         ret =3D -EPERM;
> +               } else if (btrfs_ino(BTRFS_I(src_inode)) !=3D
> +                          BTRFS_FIRST_FREE_OBJECTID) {
> +                       /*
> +                        * Snapshots must be made with the src_inode refe=
rring
> +                        * to the subvolume inode, otherwise the permissi=
on
> +                        * checking above is useless because we may have
> +                        * permission on a lower diretory but not the sub=
vol
> +                        * itself.
> +                        */
> +                       ret =3D -EINVAL;
>                 } else {
>                         ret =3D btrfs_mksnapshot(&file->f_path, idmap,
>                                                name, namelen,
> --
> 2.43.0
>
>

Yes, please!

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

