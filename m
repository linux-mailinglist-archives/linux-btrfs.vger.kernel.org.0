Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D382606F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 00:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgIGWfN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 18:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgIGWfK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Sep 2020 18:35:10 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039EC061573
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Sep 2020 15:35:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 19so9154747qtp.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Sep 2020 15:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7v6x2fvhBe3ExTys2SJOmZJoLvpBVqbv2GHkjH+un/g=;
        b=PC93oVbrM1UaMfSmPVVWxjnTB/lK7WgyLGF6ZmVEIavNU0lDVn+dNP83v5oiMaXuzY
         veowtU7vN7NXtt7Eco9HnmPs5VAr/navFlAJa7k8Sy/TICRF8BgwXYDbipnubUq0lgR3
         p2FL9nGTextdDler+rDnwWdWQV28jUekhrFTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7v6x2fvhBe3ExTys2SJOmZJoLvpBVqbv2GHkjH+un/g=;
        b=eHpGhLIyhsvo1w/fcymeTKNDY+DP9kWgfo8wXli7yRaRN24U2rQjzwacQrC1abK0rb
         VVlvNYoY0wQbPGDtXt0lTRrfV3hW0j0FcaBvgUtg6VEIMBpL8uCbVrm/eKOUCbMHf3zx
         7AajK9EDDEN5EhNRVa1sT4d2ZNOg8MXSfIKV5fC2pVJWPJIFYikNf1ZthcLxmnBKp3cr
         IcEdIWvvQBiy140BcLB3brwtVLT2+wg9nMOxOvUqeauDVx6wqXlBQFePV0jwDk4kxFe+
         mXuXEYOmEF8Qu1VxV9Z8dYK96pTf8AG6HKksZAxaeSHQ03pJOQ6Ah5WZewxSvQOlMwXz
         NJJA==
X-Gm-Message-State: AOAM530eKCH8U8mmdS3buPrwkBbDS2CCSUIg8HW4qasvIYmfOV8gYW+f
        BbDqx22NoR90GdSPBjRP1N3hUQ==
X-Google-Smtp-Source: ABdhPJw/TL2R/p6LCeAlxDo8LZxHpM35/3wsCM25IVOOtBGMazPsNQhJ0j+eKogiVUa+8qXehKZdrQ==
X-Received: by 2002:ac8:71cc:: with SMTP id i12mr22259006qtp.201.1599518109472;
        Mon, 07 Sep 2020 15:35:09 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-8ebe-8cc9-065c-5dd5-0752.inf6.spectrum.com. [2606:a000:1401:8ebe:8cc9:65c:5dd5:752])
        by smtp.gmail.com with ESMTPSA id v42sm13141650qth.35.2020.09.07.15.35.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Sep 2020 15:35:08 -0700 (PDT)
Date:   Mon, 7 Sep 2020 18:35:01 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     u-boot@lists.denx.de,
        Alberto =?iso-8859-1?Q?S=E1nchez?= Molero 
        <alsamolero@gmail.com>, Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH U-BOOT v3 25/30] fs: btrfs: Implement btrfs_file_read()
Message-ID: <20200907223501.GA11147@bill-the-cat>
References: <20200624160316.5001-1-marek.behun@nic.cz>
 <20200624160316.5001-26-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20200624160316.5001-26-marek.behun@nic.cz>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 06:03:11PM +0200, Marek Beh=FAn wrote:

> From: Qu Wenruo <wqu@suse.com>
>=20
> This version of btrfs_file_read() has the following new features:
> - Tries all mirrors
> - More handling on unaligned size
> - Better compressed extent handling
>   The old implementation doesn't handle compressed extent with offset
>   properly: we need to read out the whole compressed extent, then
>   decompress the whole extent, and only then copy the requested part.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Marek Beh=FAn <marek.behun@nic.cz>

Note that this introduces a warning with LLVM-10:
fs/btrfs/btrfs.c:246:6: warning: variable 'real_size' is used uninitialized=
 whenever 'if' condition is false [-Wsometimes-uninitialized]
        if (!len) {
            ^~~~
fs/btrfs/btrfs.c:255:12: note: uninitialized use occurs here
        if (len > real_size - offset)
                  ^~~~~~~~~
fs/btrfs/btrfs.c:246:2: note: remove the 'if' if its condition is always tr=
ue
        if (!len) {
        ^~~~~~~~~~
fs/btrfs/btrfs.c:228:18: note: initialize the variable 'real_size' to silen=
ce this warning
        loff_t real_size;
                        ^
                         =3D 0
1 warning generated.

and I have silenced as suggested.  I'm not 100% happy with that, but
leave fixing it here and in upstream btrfs-progs to the btrfs-experts.

--=20
Tom

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl9WtZUACgkQFHw5/5Y0
tyw54Av9HWaPp1NViTBgFf1NghCrKY+/ZBw4jUq7ndBeCX1wP3yqnhn3yToouc4d
imOI117N70iI2yn21Dbi814IQc2wvcXvE6kIqXljmC0gR8iclLRICHe5G7MgUtHo
5yT4dRDUn8iINoryP2/G+W538ALk4y41krZnunI5RHX2CM6iOKSFltfe4sPoq0Gl
hGJsLC0q59XegNEHP/tQzCDbfWP0tqBW6epKy4hZdgq0mq0MM/HsOIL4KTp1rqnn
SjP1qngai9hymD0NBnrIh+IvfCJY/oUdfZIctYblgMBDGsVFWR4fWyEApt6nfZJD
iCYSOsDc6aK1j2vQjO7TE5RODFIN/1fBECwg/B0TorgdJf24fcibXrwCjLX3nTZY
/X6DxsvqPu7QRbndKvkPnuLYe8OuyHfYKGqkRuu5IqcOi6lcA/mby3kOSW3ZuQAu
nXRsDtdUldFWXoqckvWObi1Fi/Ia/Dpu0k6y9PTAjaI0Pw9UN4Rpfj+e7hWlrdQn
ZCiu/1yD
=RqWS
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
