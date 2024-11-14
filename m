Return-Path: <linux-btrfs+bounces-9666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794B49C91C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 19:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC8A1F2297C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 18:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F8C1990D3;
	Thu, 14 Nov 2024 18:39:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17DE18E030
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609558; cv=none; b=ZecExnyVJ4RS4F8S/uuypfBfQRWfy3pBn8XwmDzcKkmBSqXt7pS5avEcVPJ4lVdSQqb0P6M9J1GYjja6eoVo99SZenFa9Zc3FL7djOKZApwENvi6v4l0+9KMqkCA897LnVrBg2PuRqistcNz39s0uChTS1DH1DTQJcy5BVp5zBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609558; c=relaxed/simple;
	bh=yFb9p1CM9KKXIMqV7z5piViB5DxNlkMXO8I82bz0a20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnvvoI1MzoADrBHgbJDYKFF6x9JNCrtwNkrsmlrJe5dbulba2YeVdHFtTpSOemlv3Cw9aO8qhcIU8JPOQZq3CS8+Qn1oQk2tM6/XBvhQcfZhw1FDQ09uafFr8E4cuGL3SGq9VScxYGngMOZlG//EjxI/VdZc5D06HLTLUUIywcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a850270e2so183046766b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 10:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609555; x=1732214355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpIiC4+dXXXG/ni9NIrBfRiACPRHsAI3/biRUJPax2k=;
        b=hFbB6DTWBSP9xTBjUQ2uBwQ8+h/rCEn9ZJsjxvPM+KyU4hS6iuw4UGnnjbUD7XgbUX
         IXr6VwXr8UnLChvfxwSfgawm1tRBN5H9OUCIHEPtOESR5LP9HipC/HZqYgY0YDNR6Bwr
         YKv2jdMLZDdEO3wCYZNq5vP5x6sPpqWfpfywbbq4Uxm7FZqEj6he0ve3kWhT+gafREfi
         wUtKmZeynfDU9uiZoDKahYtwEyJ4pqvAa4LfX1PD3XtfgQWRzOL6rrby7iyIk5FjLoqg
         i2sWdCYlgZAqPQwBMEIYQX8aC5zGORBnCDsZ28hjeXxMeaFMlt55D578khfrDlvHlV3z
         IIrw==
X-Gm-Message-State: AOJu0Yy+qojvn3T/MpDOaB3fIdN6Pi0Wph1UMovXcDmJVrzao5snG/LE
	fIZ8W2+LP0p/BesThucyihe+Nfjho/Ga72ODMn+AA7jlOqT4a267InR2bhvjJ94=
X-Google-Smtp-Source: AGHT+IHFMdb0o8F/DsEgcu/PHxiFSZpJF5aR+9vxr46ufSQkSTig9FzKgl7DqSAd73bB+ctrz2rmyg==
X-Received: by 2002:a17:906:c143:b0:a9a:ea4:2834 with SMTP id a640c23a62f3a-aa20cd2fdb1mr325887466b.33.1731609554420;
        Thu, 14 Nov 2024 10:39:14 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e04676csm90281566b.157.2024.11.14.10.39.14
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:39:14 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a850270e2so183042466b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 10:39:14 -0800 (PST)
X-Received: by 2002:a17:907:7b9a:b0:a99:8a0e:8710 with SMTP id
 a640c23a62f3a-aa20ccfe85emr316487266b.14.1731609553553; Thu, 14 Nov 2024
 10:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7b550091f427a79ec5a9aa6c5ac6b5efbdb4e8f.1731605782.git.fdmanana@suse.com>
In-Reply-To: <c7b550091f427a79ec5a9aa6c5ac6b5efbdb4e8f.1731605782.git.fdmanana@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 14 Nov 2024 13:38:37 -0500
X-Gmail-Original-Message-ID: <CAEg-Je86Jpte80B9MMmMhGUoUuCuJVx=+u1Rhct3h5+h9d_66g@mail.gmail.com>
Message-ID: <CAEg-Je86Jpte80B9MMmMhGUoUuCuJVx=+u1Rhct3h5+h9d_66g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: sysfs: advertise experimental features only if CONFIG_BTRFS_EXPERIMENTAL=y
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 12:37=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> We are advertising experimental features through sysfs if
> CONFIG_BTRFS_DEBUG is set, without looking if CONFIG_BTRFS_EXPERIMENTAL
> is set. This is wrong as it will result in reporting experimental
> features as supported when CONFIG_BTRFS_EXPERIMENTAL is not set but
> CONFIG_BTRFS_DEBUG is set.
>
> Fix this by checking for CONFIG_BTRFS_EXPERIMENTAL instead of
> CONFIG_BTRFS_DEBUG.
>
> Fixes: 67cd3f221769 ("btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from CON=
FIG_BTRFS_DEBUG")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index b843308e2bc6..fdcbf650ac31 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -295,7 +295,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>  #endif
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>  /* Remove once support for extent tree v2 is feature complete */
>  BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
>  /* Remove once support for raid stripe tree is feature complete. */
> @@ -329,7 +329,7 @@ static struct attribute *btrfs_supported_feature_attr=
s[] =3D {
>  #ifdef CONFIG_BLK_DEV_ZONED
>         BTRFS_FEAT_ATTR_PTR(zoned),
>  #endif
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>         BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
>         BTRFS_FEAT_ATTR_PTR(raid_stripe_tree),
>  #endif
> --
> 2.45.2
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

