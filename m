Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEE8492C8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 18:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347439AbiARRjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 12:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347506AbiARRjq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 12:39:46 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF0C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 09:39:45 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id t7so52377qvj.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 09:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UmxPiE8dmtuSnedB7/PTPz//P9miwcfJ2SEONYZ89B0=;
        b=l+do/TxVcLbbF7+NJyai1RzSFiKTEL39p3L93SV58AHHpAcFh+JbxOU4g+rjoA+Qse
         iNgmc1wif3Dxi2/kSU0/fIUh0II2nd1/a6fBwqmB4HRlPJp9Fv7lHKwO5d3klttKS9yx
         gCY00EWildYKY2m9MbAovOg1QhGotyVIB5bww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UmxPiE8dmtuSnedB7/PTPz//P9miwcfJ2SEONYZ89B0=;
        b=A0TS8Wx6ym6F7/PU0A+qJCsvTY7450RSXh28lOc2+HusIQzT1EI+m10gtnb3cM7rr4
         Pt5ih90510Soph5Hm9eVFLl8Alft/BBQBtQp0gx1fDjPWt28KhZrhs6d4TJkH3nDjVes
         Zxupo/Ttn67ksSdVbtNvE097bWhgY6d95O8rKEH+rJDr7mwmH3bYm4s199mYaxlKK3xn
         maXFmlIr1iElzKbMMaEE7iHEijS+UxJRXWY2FobiBYZOXqT+9YNxUnf+fmpWAHU7WfOQ
         MAH5GkcDIwMKPTWdPtHvGQXd4znzRf1A0Bdk/SBTObZH5t/2KudSbM70Vns8uPBvu96o
         fIng==
X-Gm-Message-State: AOAM532dA9IIwg+4tc5aTDZhJQ3KwDEWCnnNnLmtkvtx6JtqcYk534mG
        EzIguSXNlv74fCyC+Mz/TswSu4bPmcgfaA==
X-Google-Smtp-Source: ABdhPJz4QIkGuTLR6lTkFu1r4HaO9D++ovn20GiXPk9fioTNwjSXPTk8BwcK4GlDWYzzsdoiPQqxuw==
X-Received: by 2002:ad4:5dc1:: with SMTP id m1mr23692635qvh.26.1642527585020;
        Tue, 18 Jan 2022 09:39:45 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b01-cbda-ec5d-c40e-552f-ed0c.res6.spectrum.com. [2603:6081:7b01:cbda:ec5d:c40e:552f:ed0c])
        by smtp.gmail.com with ESMTPSA id g13sm4829908qko.59.2022.01.18.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 09:39:44 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:39:42 -0500
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] lib: add BLAKE2 hash support
Message-ID: <20220118173942.GR2631111@bill-the-cat>
References: <20211227061208.54497-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ch6x/diZ8cQC324S"
Content-Disposition: inline
In-Reply-To: <20211227061208.54497-1-wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--ch6x/diZ8cQC324S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 02:12:07PM +0800, Qu Wenruo wrote:

> The code is cross-ported from BLAKE2 reference implementation
> (https://github.com/BLAKE2/BLAKE2).
>=20
> With minimal change to remove unused macros/features.
>=20
> Currently there is only one user inside U-boot (btrfs), and since it
> only utilize BLAKE2B, all other favors are all removed.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [trini: Rename ROUND to R to avoid clash with <linux/bitops.h>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--ch6x/diZ8cQC324S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmHm+14ACgkQFHw5/5Y0
tywk/Qv9GxBAZ40AzDM//qRf9VnU3T+R3t+Kh5nB22hzZdnJ+Nf/JqXJXgp41qCY
eeItsrAKISsbLNbRZHVD0ZL8trDIMFDs52GfPcvX+eEdJsPnD4SYMc9JZyYpHbmo
e116fu+Rtv77G+pYaB47DI42X20m3Vs2k54I+oNY9O9dUOIauru+UcFxXngcqId0
1Qjmg5JKTqeBxXrbLcUiugAAOgDz5eTCTV3Uvynu1M9R/wrXT+SQNVGmk6s9gPR7
DPUrK6ji7LJVrhL1+UwQ5IJO9LDtFIXbP29ryoRqq1kQTU43dTOekNP+QTONYlGu
XOIMeWPbG7eRuk8IxUeEdWZSLV4b+QX30QvXt3nHXjRIBza3xlTGrc+7PaxpiVSI
/EAkLA2DJfffrNJyi1VTMKU64OaDcBRpLE5PBiFiv0rrPrsXyX+6Znt/evIUB4sY
80zj9haQkN8AadEqXNLiOhzI2rpqRwhgw2iKHneMXD2FylA3CcKr0gqXD/6SQi82
XA+Alc9o
=kqLK
-----END PGP SIGNATURE-----

--ch6x/diZ8cQC324S--
