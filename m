Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5D3332D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 02:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhCJBnN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 20:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhCJBnM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Mar 2021 20:43:12 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCB8C06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Mar 2021 17:43:11 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c131so16062491ybf.7
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Mar 2021 17:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7Bo/GG+ZOOoz2r+BdxCyWN8pNeZsklJL83l7eUx6G2g=;
        b=uRJOUDP1bH3s8Pg9TFmZJWUP55b4TCHqb/rmHy4EYY0jL3BcG6gUc8LwyMC6qUruDY
         UbA0tYXXnFqK74MG+wi0DzFpe/btN1XBBl8BYzdXB1ZBauiSl207tmM/a0HNSNCyenqu
         91x2WRT/MgSnPY+fSMHlAZBgR23iN8kB7/c+11RfdluithkIc23a9EUm4B5u7OioZHxo
         zeAM9eR5Io7BhskDIHPhy1itp9+ufB9l6WP/mdCos9GuXGF9qJVUTeRflQPt2BEhBsAF
         Yl7piK8+z0oZl3HMK8XNf+dDRbN/tYlT5RikTw07Jzu712+8idhD7VLQzyYMokoKWXsk
         bmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7Bo/GG+ZOOoz2r+BdxCyWN8pNeZsklJL83l7eUx6G2g=;
        b=al65xsQV2cU06BYthAUTZHpHMcGaP46PrQvtmoCwIlPsp/Uat5bCT6EOM+/5t94PHA
         BOPta76dVPCa11mcDoSzWmBRWV67790iyMWyEvGcZLBh6L5DYx9lb3IpFzti2RmRG7LT
         dqD6p4l+qYcJZrrREf+j4FhqX0hz41ObZ50N1LiJ8roZuUZe5eGrKUmMmyqOFO1wCNmD
         M2BCsSeKKskowmnlqpgMkdhehsN37NlNAulbjaiWKk+qSMr9L0zmOa+UNqT/VRoNovca
         e/r2YS3Ab29raxfY2A09jnQgpT/DhPb8tqSYWit4lu8VFmWIiFeAJ9m/9a7mr2oMSCUV
         gomg==
X-Gm-Message-State: AOAM531Vlk5zRzNO2txrRjULPyN/yc/v3PsLCp59Yau2/V1ByFw7wKtS
        7yjs8PmXJBKJTK1DzZt8cMknp3exSgfzcWGSIYjy9yvmVtj3lw==
X-Google-Smtp-Source: ABdhPJz4Azsdwghe0DybNysMk8m0ZuSjuFUv/m3uE3yIP+slnPnKHX8H2gXY/dHOJVlFtclERKKQvqjdclrZeYtUVYo=
X-Received: by 2002:a05:6902:727:: with SMTP id l7mr1025056ybt.184.1615340591240;
 Tue, 09 Mar 2021 17:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20210309212440.2136364-1-heirecka@exherbo.org>
In-Reply-To: <20210309212440.2136364-1-heirecka@exherbo.org>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 9 Mar 2021 20:42:35 -0500
Message-ID: <CAEg-Je_uk1Lkppm=77Sb8j=ADFm5igPeWL9GkBskAksS3XJWOQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: build: Use PKG_CONFIG instead of pkg-config
To:     Heiko Becker <heirecka@exherbo.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 9, 2021 at 4:36 PM Heiko Becker <heirecka@exherbo.org> wrote:
>
> Hard-coding the pkg-config executable might result in build errors
> on system and cross environments that have prefixed toolchains. The
> PKG_CONFIG variable already holds the proper one and is already used
> in a few other places.
>
> Signed-off-by: Heiko Becker <heirecka@exherbo.org>
> ---
>  configure.ac | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 1b0e92f9..612a3f87 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -223,17 +223,17 @@ elif test "$with_crypto" =3D "libgcrypt"; then
>         cryptoprovider=3D"libgcrypt"
>         PKG_CHECK_MODULES(GCRYPT, [libgcrypt >=3D 1.8.0])
>         AC_DEFINE([CRYPTOPROVIDER_LIBGCRYPT],[1],[Use libcrypt])
> -       cryptoproviderversion=3D`pkg-config libgcrypt --version`
> +       cryptoproviderversion=3D`${PKG_CONFIG} libgcrypt --version`
>  elif test "$with_crypto" =3D "libsodium"; then
>         cryptoprovider=3D"libsodium"
>         PKG_CHECK_MODULES(SODIUM, [libsodium >=3D 1.0.4])
>         AC_DEFINE([CRYPTOPROVIDER_LIBSODIUM],[1],[Use libsodium])
> -       cryptoproviderversion=3D`pkg-config libsodium --version`
> +       cryptoproviderversion=3D`${PKG_CONFIG} libsodium --version`
>  elif test "$with_crypto" =3D "libkcapi"; then
>         cryptoprovider=3D"libkcapi"
>         PKG_CHECK_MODULES(KCAPI, [libkcapi >=3D 1.0.0])
>         AC_DEFINE([CRYPTOPROVIDER_LIBKCAPI],[1],[Use libkcapi])
> -       cryptoproviderversion=3D`pkg-config libkcapi --version`
> +       cryptoproviderversion=3D`${PKG_CONFIG} libkcapi --version`
>  else
>         AC_MSG_ERROR([unrecognized crypto provider: $with_crypto])
>  fi
> --
> 2.31.0.rc2
>

Looks good to me.

Reviewed-by: Neal Gompa <ngompa13@gmail.com>

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
