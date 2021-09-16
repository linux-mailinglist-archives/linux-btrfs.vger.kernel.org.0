Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E075940DB53
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbhIPNfg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 09:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbhIPNfg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 09:35:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD16C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Sep 2021 06:34:15 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f22so7331544qkm.5
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Sep 2021 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ofopn97nLt+1i1XEv4UdkrMCgHpyLFxw7hiUU7iwMW0=;
        b=XJWNog5zEZMfTx0jXdDtlU75FpRaeyPbdWb+gbUJb1ICOVFa0cDJRYrP8FGaN+Nym6
         gyVqrmUCzyv29eKNLAmoieE6kVebz8UI6OqNf9UW4CQDa8UO9x6GeSD5lmXZZKH4YvhL
         Kq4hE9cs/IAO50g63yPeUxw2r9Nanq9QTTqgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ofopn97nLt+1i1XEv4UdkrMCgHpyLFxw7hiUU7iwMW0=;
        b=fuoSN8NdYIlKj1GCEh3D3Kza218+zLlG2dAz2ECVDI/ldKCk69GvEblR6pbch+6Nae
         1JOG0YyPrXUvDrsxO+PTVTo3PO9kUM6qwdGuoak2cxJ7KF9/ccMIaX2AVco7HNu0dgnu
         YMLmdGnr/jQcVnz6teaehrLG9z7gZeqlPRzLkY6uuJsI0FMknUzZBt2aETzCcapeqE0c
         WvIgQc9xUIH8S+P2/M3opCMYhbwNCLqX2sJYGJ2lKbR0770OeXBUATeUMtJ4t2kVnpG8
         mLnYNE4v2f/6v7Xm9fbLTUbphTFbdDde7kcT4EA6VVHo1LvoJGqSfut1js7x8Ktr8bDv
         hItA==
X-Gm-Message-State: AOAM533rBo6L9a5nimEP5Ob8Q4tLteBtRZKVS5+AB93CxoFdYnfdx5cp
        H2LInpee7yB/Br1ENX9aTba3AQ==
X-Google-Smtp-Source: ABdhPJzz8bOK1JmApACye9xpHCEGTpV/I2o1tHxYTbEy7vwGmbx0hxqBLh5R2fbWq/eXyTSRfZ1g7g==
X-Received: by 2002:a37:a391:: with SMTP id m139mr1840090qke.186.1631799254768;
        Thu, 16 Sep 2021 06:34:14 -0700 (PDT)
Received: from bill-the-cat (2603-6081-7b01-cbda-d880-4580-a9ce-9f2f.res6.spectrum.com. [2603:6081:7b01:cbda:d880:4580:a9ce:9f2f])
        by smtp.gmail.com with ESMTPSA id u27sm2458403qku.9.2021.09.16.06.34.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Sep 2021 06:34:13 -0700 (PDT)
Date:   Thu, 16 Sep 2021 09:34:11 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Simon Glass <sjg@chromium.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] fs: btrfs: avoid superfluous messages
Message-ID: <20210916133411.GA12964@bill-the-cat>
References: <20210916080245.42757-1-heinrich.schuchardt@canonical.com>
 <20210916140128.4f4fbad9@thinkpad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jbx07SVI+3Id4MEz"
Content-Disposition: inline
In-Reply-To: <20210916140128.4f4fbad9@thinkpad>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--jbx07SVI+3Id4MEz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 16, 2021 at 02:01:28PM +0200, Marek Beh=FAn wrote:

> On Thu, 16 Sep 2021 10:02:45 +0200
> Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>=20
> Heinrich, Simon already sent patch
> https://lore.kernel.org/u-boot/20210818214022.4.I3eb71025472bbb050bcf9a0a=
192dde1b6c07fa7f@changeid/
>=20
> Tom, could you apply Simon's version?

Yes, I should probably do another round of -next patches today and I'll
grab that series.

--=20
Tom

--jbx07SVI+3Id4MEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmFDR80ACgkQFHw5/5Y0
tywkMgv/dJQmoCVoVFKaU+zWWmygh36YaFtJ1NDRpAXo+/2jp9FIEM5iRXHFmylJ
iT1utYrbhSWoDIdjOc9Cn91uo+rNDbptyeklL2adEaun2ocH26A+A2mG1SDDADpF
S7yvWrtNItoVjZp4kNhPapcMatrvkar3cedK4S0RXMP8PVusaUWL+ISPekZPf9Ph
Ze0YdivW3j1nc8shaV2FF3p2eo3yKBVXUXPmMzzifGkB/zbn1BnoxyHcYVJAi6T7
+g8YA72TVv3MTOm6pM2qLcFSGpZj0/CyShax1fVQYFHoJd9jCD0JyDQvBZx3WhHk
uSfnKTWN26RDLS2aLJ43KII66pIs9EtMI2cP+ao7sp9f+3mZqLY/dhYYm9WXJrFt
GumVonF2+XFVcGDfUPEaGq6nUSe4eOqhq7ZgXoQart2R6mrrnqjlml+dJ9cAaPoP
AQuu5V09SsBb6oDQYpF8nMVnmWFt05dhIVIQ77/ugO+QPM7PrseGOni+vagT27H4
oOAian4V
=DB+n
-----END PGP SIGNATURE-----

--jbx07SVI+3Id4MEz--
