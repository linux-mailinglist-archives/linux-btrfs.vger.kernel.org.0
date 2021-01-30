Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4B309801
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 20:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhA3TWd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jan 2021 14:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhA3TWa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jan 2021 14:22:30 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4D7C061573
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Jan 2021 11:21:50 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o18so9304346qtp.10
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Jan 2021 11:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b86EgwHuaDBQ9U8hYiwFU47RjeRX+DDu7MTgkbOp5Sk=;
        b=eB1L++nxBie/f6KfqhZ0RkzlN+0F4E0X3RGsA30HNmm6tkzssEjXAMGF1S53OQdyS/
         TPCtKSCPl8UDnKKcfhesibOP8Bo7l8gXZMSC/8U0V62Kr7/EIyoJgJ3nbEhCt0Aa+7SM
         x51dreGs1+Zbb9kIBDkUPHotrECdgTDLO7ChE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b86EgwHuaDBQ9U8hYiwFU47RjeRX+DDu7MTgkbOp5Sk=;
        b=ayHeZZtIK8HYcLzdshTJqVkJf1JNyQRCzgNyhnugHFLF69af1Pr21dVhui4XR4CEhv
         R9TXDABumYfUO6WHeK7Q5wXVjqn1d6fCOp2Khm1WZ5Nle9lO0OikWsYeRdI4u72/1n1s
         SHfb+drq7OaP7K3cqZ7mi21sv1VGHCwtsoDw1yL5wn1sjyB3jaJ/pGtmGGMif7LsGbC9
         o7tKFVfYpjcYnQVRWQnLt018t3O2KkGcNYxmdEsfnLGc+a+RqTkRGGv82b6pwErM/v6d
         bzx2fXzp7ilzY10cTY4DEV8K2CtgWLeBQK4PSCyXR9mwFIVXHQtRLuXYMNHfjAQJzv9d
         tNkw==
X-Gm-Message-State: AOAM530iSz2AeNwqiwuNQyeBLlXthaKRtFuxPOLrompdMYOA9/CNDFOf
        9WH+m7a8TBjCSsEiInbTFbyEwAQXQpXaDw==
X-Google-Smtp-Source: ABdhPJzDO3WdFltRP7etzinN+JXhkvJlPQuvwmRK0Sp9vDomJQqW6V8OX+lPnxujQ4RQyy3vQrcZyw==
X-Received: by 2002:ac8:382c:: with SMTP id q41mr9265168qtb.288.1612034509661;
        Sat, 30 Jan 2021 11:21:49 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b07-927a-baca-3aff-fe98-1abb.res6.spectrum.com. [2603:6081:7b07:927a:baca:3aff:fe98:1abb])
        by smtp.gmail.com with ESMTPSA id w91sm8986318qte.83.2021.01.30.11.21.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jan 2021 11:21:48 -0800 (PST)
Date:   Sat, 30 Jan 2021 14:21:47 -0500
From:   Tom Rini <trini@konsulko.com>
To:     matthias.bgg@kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Marek Behun <marek.behun@nic.cz>,
        u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] fs: btrfs: Select SHA256 in Kconfig
Message-ID: <20210130192147.GQ7530@bill-the-cat>
References: <20210127094231.11740-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3bp/g53igxzXRwId"
Content-Disposition: inline
In-Reply-To: <20210127094231.11740-1-matthias.bgg@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--3bp/g53igxzXRwId
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2021 at 10:42:30AM +0100, matthias.bgg@kernel.org wrote:

> From: Matthias Brugger <mbrugger@suse.com>
>=20
> Since commit 565a4147d17a ("fs: btrfs: Add more checksum algorithms")
> btrfs uses the sha256 checksum algorithm. But Kconfig lacks to select
> it. This leads to compilation errors:
> fs/built-in.o: In function `hash_sha256':
> fs/btrfs/crypto/hash.c:25: undefined reference to `sha256_starts'
> fs/btrfs/crypto/hash.c:26: undefined reference to `sha256_update'
> fs/btrfs/crypto/hash.c:27: undefined reference to `sha256_finish'
>=20
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/master, thanks!

--=20
Tom

--3bp/g53igxzXRwId
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmAVscoACgkQFHw5/5Y0
tyzlNQv/XD7d74+lTVsoXIlkvCnc/n3l3HQetxxXsF5/EMOWR79HLeU69UEbqnWb
jWB9piFxnMe9doRXTkX6UkQZWQ1FG2CPvQqwnM/SYFNiV8x6HoO/NL+wro+ehwtP
C7ALeU8rNVpTOOXD022/IM+64NKXghJ+TG/LkukSiItyNo8AaC5xHRZh0koUoYQp
EiRwX3gfqEgxaGNhXPzonliu7HNjRhMqk8N//l3PCC8tvq05jIp0s57hGE8M9Z3o
Y22MoepPgJ3SuB73u1SnUcmrF9rci9xthwt+2oFm44gYu6JeNHxUqWn06sFW43Kd
Nsk0tXONmp0mhaIkhwtdlunN9MNXw2yeV4KYv+ynCA/OECMFHGR71zT6YBEeL3jr
wRRJCSQ2q1t4ktmk/0EEutgV6CbWPYZRUe6gXx2cVR7z+Bb4ccp3Hj9I+LFnlR6n
Oaj3pQwjjajRipRmRD4jCYI4ymcZgUikx7hOnnFWBu3cGIBvGyO3ODgyYZnB+aOb
Au4Hcuh0
=9xcX
-----END PGP SIGNATURE-----

--3bp/g53igxzXRwId--
