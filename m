Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64176415560
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 04:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhIWCKX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 22:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbhIWCKW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 22:10:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C65AC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 19:08:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q125so2249343qkd.12
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 19:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p6enpCf2lE+kPdc1mKSMrl4L9fKO0cA4agDbPcM7Mu8=;
        b=fLvWwjMnciOHBtsd6T3xGRCEX9irkbmXT7gg+cBAHkKa0V4wl1EY8Y9QBGjDF8bshc
         xVA0RAvKvxmcXUjSCq6mPZxDTtSxG73St6QXAf/5TEI54WPLx/KqIYq2FX5EaTnMJrPb
         cv4ZW3dfD28FTiyLaXlqrjkFMMUyc7NQR0aXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6enpCf2lE+kPdc1mKSMrl4L9fKO0cA4agDbPcM7Mu8=;
        b=wx4zjOd/UZmAwd58puFTJijOr6cUVB898BCwtSWgtapHVt8nBKpYAuqch1DK5quEeA
         XDpn7vLP0J1G0iyvotzz8KeXYgeWpCb2D4Z7dElUCnxoBR/ji3t++T3RlRruWri5SnCA
         6cVenNER6zqAMQ3dgNv32S31yI1ZMD5ftyW35fYJfjOGZm4t4wL01ZDyKQipMEf3GetY
         dahn7dyBiVFWXnzULgBem+46YaJvvr5LEOzkRRpv9BfW0/IqavMJAFR4PWff0wbTilJt
         EfufHkwY7TypKT6gufXPD3QlZ5S8avRR4o2oWrdBU56x2jpa6BECPGU/VphW+DEaXNPK
         YGgg==
X-Gm-Message-State: AOAM531wGbcElPSp33TobIJlrCQWFARPPxBVHssKBU+Otos3MJWwkFMq
        HLOPt6Hiq0q6R8SjGgkx7dO/Gij2Cx+1MA==
X-Google-Smtp-Source: ABdhPJz69MO1fx36cuLvC0p6Od1SqfnpAPwPAnogFLswiitf44fVnWF1kHzAc7+SI1mOQzknHEVoQg==
X-Received: by 2002:a05:620a:88d:: with SMTP id b13mr2567019qka.145.1632362931460;
        Wed, 22 Sep 2021 19:08:51 -0700 (PDT)
Received: from bill-the-cat (2603-6081-7b01-cbda-a58e-d475-4878-38e2.res6.spectrum.com. [2603:6081:7b01:cbda:a58e:d475:4878:38e2])
        by smtp.gmail.com with ESMTPSA id o21sm2692411qtt.12.2021.09.22.19.08.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Sep 2021 19:08:50 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:08:49 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Simon Glass <sjg@chromium.org>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/11] btrfs: Suppress the message about missing
 filesystem
Message-ID: <20210923020849.GS31748@bill-the-cat>
References: <20210819034033.1617201-1-sjg@chromium.org>
 <20210818214022.4.I3eb71025472bbb050bcf9a0a192dde1b6c07fa7f@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6eUvXotnMb6+obQB"
Content-Disposition: inline
In-Reply-To: <20210818214022.4.I3eb71025472bbb050bcf9a0a192dde1b6c07fa7f@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--6eUvXotnMb6+obQB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 18, 2021 at 09:40:26PM -0600, Simon Glass wrote:

> This message comes up a lot when scanning filesystems. It suggests to the
> user that there is some sort of error, but in fact there is no reason to
> expect that a particular partition has a btrfs filesystem. Other
> filesystems don't print this error.
>=20
> Turn it into a debug message.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Marek Beh=FAn <marek.behun@nic.cz>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Applied to u-boot/next, thanks!

--=20
Tom

--6eUvXotnMb6+obQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmFL4bEACgkQFHw5/5Y0
tyxuzQv9GX6gc1jC3//Fn9ZrymfbNDbXe/dT0VwrMYI9ynnI5UmcC+oZTED3jLqZ
lMoZ3fqgTU0rUbzdlu61TQv3sfmknL0YHVECuTj2rW18rB/e9SxkM/Oiyh/9kcHn
+iIzNvvR2GmyFtkroLaSknfSlUEyL6I4GB9CXdXvyhg6f8DgAETYnVa6gzzlRT2R
19h/IrbnLpGAVGDPvOLrQrAALDurQ9ETUoQqAhMuFv4lPJjKkGpeLnYYMvv7EiVp
2C6YsKbH4sFPJJOTLduq4s0nxIBr+VwgjVBkFU+VlLM5m9RH9tJY3ReR3m7JZO0M
VRVe6T2b2B/CSpP2a0jfqQviFTQuNIiBEqKne7U9ucIq95KlvuuGdMdCh3tv1Ic6
ZMOX/uzPaLtvRj7FZSN2y1uonm091/L5RQae0iBwBvvpWkhtbR4UKXZzM7TJPXjW
MWLtM/YzxZCn3WepDdzpTKBz+zeVLmvNVGZLL8SN4sSvLgQWbP2tmbO4yKOWqgqy
YDaUFkSi
=D7AE
-----END PGP SIGNATURE-----

--6eUvXotnMb6+obQB--
