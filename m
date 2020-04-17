Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42261AE748
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 23:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgDQVJJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 17:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgDQVJI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 17:09:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56A5C061A0C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 14:09:06 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x66so3976069qkd.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 14:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jv3+4pMA1nrNFJihOp448FjrqIswiseQcY7ieTJ/2ek=;
        b=cSJZLuHQ982b5f8DOuh/8ekSIEYWr/nozBtQMSL+N6E02G5RCWj/cKTOt6FhmougCi
         6r71y9lV/1d05gXrw5rYe+cs1SQdtRY9ImpKfEi9/KsFkg3f64jpSd5EQtP4xcXIDiIw
         L049DOo27CEwSWaR4Iin6jPAUmvfhGMQPYPCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jv3+4pMA1nrNFJihOp448FjrqIswiseQcY7ieTJ/2ek=;
        b=ZCQel/hl8MphVLfFhM9Mb2sPRMqmsEch+HA8Ir2QWF4AtQFqVSHNGQTFpTTrSHpdRT
         r0aqTgJNQUQWkbfUQTQJHehVzFeEbLkEQ2wGTU5l2Q9uWUgcjyQc0U0H7RSf6Y6Agm/f
         sDPuqwxDVtYIzt4Rg7F3p9nvzJlh4CZYZ2qGxxB67l0QKtLcksyibg0TYO9drYF7YZ+J
         TU1tN7QPeIDn+IhMDxMUr1rw8MIHZ45MfS5TFEz2OppO+REjlngXZi5Bnk0uPbedxA49
         5CcxTeCXfWRgYgBJBRgBWS3lpC4Nr5rBTdG1ZKYlp6G0Tc4aPBUL9zzcX+RL1nYoodhi
         TppQ==
X-Gm-Message-State: AGi0PubnPNnlbMcBADUYex4pCN3dLn+dbqwa5BCqFYu8rsqWcFXlFqfY
        lvoXp0Q6VMlgiKFNsEWsRPZlKQ==
X-Google-Smtp-Source: APiQypLTtz5C33R7bLduwxLpeg7z2BzEuv0QyabXCizQcSJcf5Oz1bF4FmFzdwwn81E5LQ20neI7vQ==
X-Received: by 2002:a37:b03:: with SMTP id 3mr5089427qkl.67.1587157745965;
        Fri, 17 Apr 2020 14:09:05 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-826f-4058-2b78-ede2-0695.inf6.spectrum.com. [2606:a000:1401:826f:4058:2b78:ede2:695])
        by smtp.gmail.com with ESMTPSA id n92sm18290573qtd.68.2020.04.17.14.09.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 14:09:05 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:09:03 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH U-BOOT v2 2/3] fs: btrfs: Reject fs with sector size
 other than PAGE_SIZE
Message-ID: <20200417210903.GO4555@bill-the-cat>
References: <20200326053556.20492-1-wqu@suse.com>
 <20200326053556.20492-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U5yJ31ax00IavOwq"
Content-Disposition: inline
In-Reply-To: <20200326053556.20492-3-wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--U5yJ31ax00IavOwq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 01:35:55PM +0800, Qu Wenruo wrote:

> Although in theory u-boot fs driver could easily support more sector
> sizes, current code base doesn't have good enough way to grab sector
> size yet.
>=20
> This would cause problem for later LZO fixes which rely on sector size.
>=20
> And considering that most u-boot boards are using 4K page size, which is
> also the most common sector size for btrfs, rejecting fs with
> non-page-sized sector size shouldn't cause much problem.
>=20
> This should only be a quick fix before we implement better sector size
> support.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Cc: Marek Behun <marek.behun@nic.cz>
> Reviewed-by: Marek Beh=FAn <marek.behun@nic.cz>

Applied to u-boot/master, thanks!

--=20
Tom

--U5yJ31ax00IavOwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl6aGu4ACgkQFHw5/5Y0
tyyvUgv/UZRVfjrQLFU7dJdhXph5QrM3Vsxy33ZnQ0+cV9BeU9mW1cGKzTnO6Wbv
0mXEuYdnqBy27Npj9aN2xbww/xaTUOwW3ZRSC5Cokot2aA85kuXVkB+T7nNklAC+
iEpqDqXcRq+NqcMdMo5FVSiKQj3qi/9yxO3tVt2L4a2apPZNaIVPQHAVLP6Ven+R
YA0Aepf5wB2yaqvCgUEpGnEETLt9oXKzwbPSCfoHnel7MI0JdV5SerobCC97JQIj
AUDLblw6+mAJXj2zOGwRR9+dDOZlWXwydWPP+pKJ5OtBIcGoCO8kymexC70pDxFs
gpKMMAsJfm2FXdbRw+ACcWVu5rlI2w/rn9HpujaPmr+gt0oxbk6IK2puswFvqU1k
1Ko3z6cXbka0F20t8LJanDotoRtqQyzB4LpTTCKoLYCliX7+E882LYD65aC22L6W
IYA3pkFI2xZDXOAOZaI4MqoGIre42s0OsE9HF9Fl9QxK1Q2pTMh12nC6x/Ek3AVx
LA7f4Qa6
=qq78
-----END PGP SIGNATURE-----

--U5yJ31ax00IavOwq--
