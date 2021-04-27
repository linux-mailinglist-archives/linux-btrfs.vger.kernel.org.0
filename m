Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1436C9B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhD0Qqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 12:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbhD0Qqt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 12:46:49 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF883C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 09:46:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id o1so2978702qta.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bd2sVLsulUz/H6wMEcloj2GBKX9/LiSxzfvXHAlEIhc=;
        b=LClO9lsbYcauU6S1A8KD9fKjqEI+PJ+L9xuIZLOAoufPQ7gGChNYyJ6cMFsqXIDFK7
         /ygW6SnYGywtiOsEHsXvdqLnXo2e+MqnatyfWBRDmqhO6Z5rW9kRZKDkhxg01ZbfdduC
         633A71uQ6K+YaaworRaPbFrrd28+q9KmJ4Esc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bd2sVLsulUz/H6wMEcloj2GBKX9/LiSxzfvXHAlEIhc=;
        b=PeKz7NFwBB61bQhnIqE3xPZU+A3XceJwBNgIXakOyKC1aCkGfY3VIziPPwZ9KwjwhT
         XIRmGPraejufiAr0RRTiCGgl5dvEtLoTbYPLsY5U2Re09P8Bs6m3zWxo0ncJQd8iY+wa
         SQt1tBDF6Pvc/stvpLPRhxQzWRiAYldIbc3E/Wx9ANwbHsAX2K/GASdW664IjqHhCvYQ
         YtkOb0F2lcKsS20PYaK5o9Feon1mzHzeVRmfu0XTvAJfAcFt6Vy30wk5ARFhoCKyxH2p
         IvaLWdyGhSwktE6Cd+Kh0zaTByAxeIgQnW8fZNlEM7vpmI8nILNVNM1HIWINqxiCwgxN
         zVWg==
X-Gm-Message-State: AOAM531iWe8gHLKpjlaStoRtX+GyswjIFTo+IK5Jgxk2AdfRzVDYKBC7
        rSDoEi3sc/4YM6sBPx1tW72aIw==
X-Google-Smtp-Source: ABdhPJw/nA77my/mPW0b3y7nwMVVxfwgZ2nRHOUEJ5htgNo/28OdiIYCCxhn3tzxGBVUQNFm9GSz9Q==
X-Received: by 2002:ac8:7947:: with SMTP id r7mr22015141qtt.104.1619541965039;
        Tue, 27 Apr 2021 09:46:05 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-140-239.ec.res.rr.com. [65.184.140.239])
        by smtp.gmail.com with ESMTPSA id a29sm309344qtd.15.2021.04.27.09.46.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 09:46:04 -0700 (PDT)
Date:   Tue, 27 Apr 2021 12:46:02 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Matwey Kornilov <matwey.kornilov@gmail.com>
Subject: Re: [PATCH U-boot v2] fs: btrfs: fix the false alert of
 decompression failure
Message-ID: <20210427164602.GS17669@bill-the-cat>
References: <20210417125213.132066-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37cJpJlYZwAfNbm5"
Content-Disposition: inline
In-Reply-To: <20210417125213.132066-1-wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--37cJpJlYZwAfNbm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 17, 2021 at 08:52:13PM +0800, Qu Wenruo wrote:

> There are some cases where decompressed sectors can have padding zeros.
>=20
> In kernel code, we have lines to address such situation:
>=20
>         /*
>          * btrfs_getblock is doing a zero on the tail of the page too,
>          * but this will cover anything missing from the decompressed
>          * data.
>          */
>         if (bytes < destlen)
>                 memset(kaddr+bytes, 0, destlen-bytes);
>         kunmap_local(kaddr);
>=20
> But not in U-boot code, thus we have some reports of U-boot failed to
> read compressed files in btrfs.
>=20
> Fix it by doing the same thing of the kernel, for both inline and
> regular compressed extents.
>=20
> Reported-by: Matwey Kornilov <matwey.kornilov@gmail.com>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1183717
> Fixes: a26a6bedafcf ("fs: btrfs: Introduce btrfs_read_extent_inline() and=
 btrfs_read_extent_reg()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/master, thanks!

--=20
Tom

--37cJpJlYZwAfNbm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmCIP8oACgkQFHw5/5Y0
tyzu9Av/YvmzPOqQ88xAC9o+X1rQgdFPFHPQmfBnYYz/yIMhLoGhXu5dKYhj/+DI
v6efBLj/aN/MleH6FSYdzFV3YWvbZHDv7uw3KeprqPS9kXvJs0n1LyIiUn5jm68Q
U+YR461xHJ+83AIgmviqxoks3KsMKeRpAeF4zCvcZA3s6bDvZYKi2JPkwkcXv0NU
a8ffIwvumCQRRQNuimpWXTzrOVgMwpj7MxuSvPTAOaOGW/btKiTm722MQIRV6XHy
61XL0lRfDtCAJcd+bleTzdmXboY9JAUr1H6k/PIsgj8mvEbbX96R49uGWI2tieei
RRb+G+F3yHnjY7BDYtJpVZPsbFNVjuNUGM5k+5sVv3U362KTij70q+9O/4Vt1pd8
95SEEDU89Apl8KT/wbObgX2UTvUF3MXIjXRMASAQuuneOtCcfd5suIsCGLYKSMgR
SVi3w68hVhb2iiXmzNYIhVixYtMB2y9pmWd1Iht5Zuh67fnGzBt5JQEplIpPFboD
la64rOU9
=pN2c
-----END PGP SIGNATURE-----

--37cJpJlYZwAfNbm5--
