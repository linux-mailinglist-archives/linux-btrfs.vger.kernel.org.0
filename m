Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD120B29B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgFZNgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 09:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFZNgp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 09:36:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F05C03E979
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 06:36:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c139so8704872qkg.12
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 06:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r62vYC+XY39G93hDI30btmsEGk9/8I5pHCl84D4KrKM=;
        b=Mj+WWJrfQrN0z6tBzdcZrgOyqGa2lF7WdpBspE0Z4lpOQMobD9V5hOo+vUlT0880+J
         jKKn0KH07ku5QrgyE34k+qOtBJ2COLj8G47UPnrhlym7DIC8lzcuO1JkDFKeJy4Rt7a/
         MxsNhmq9Ze8BRhrCt5H+c2bvSjZHYejdmBEic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r62vYC+XY39G93hDI30btmsEGk9/8I5pHCl84D4KrKM=;
        b=W9e0XvKIxCKD9OK3jflZaw3HgTo7Y/kofndNZkBdT+FVQn3QoStsMVnwaob3dMAREa
         clejxiXTRCHfp4qr4r3vzXbC5hdkAeFtZafZwg/wQxPyErXHQNTP1I1rXFhV2JpVxYoY
         omvV+77hg0xH6skhNTLBvJUa/kGrxYGQMc8j9HaaUbM9Il+3DzbNFROBp2Br6ENNqgCK
         3JeGbQEDnWCulNhRrPY/epLATWzLnDLw4kih/+YrOEeqXnV30TzljGnmu6Mi0vuLTlOn
         WsYCj+fOZkakEVTu/pbYqKplyCz792rULArOXJqz67W7BA3ZuOAPAh4VD199DA4+n9eE
         SUwQ==
X-Gm-Message-State: AOAM533bb7fvehawwasT/7NtvLSUmQXA0hOHaanyIcunGZLY19gKXG/+
        4OqxNHf897Kf7mbVelkKScvM0w==
X-Google-Smtp-Source: ABdhPJwgNFWp3xpGdKf/b6TSccjEXAY+33ukL3xcDaHgl6aTZqxu/QIhW+Cy3ATo0G8e0uUdwXtKaw==
X-Received: by 2002:a37:6cc1:: with SMTP id h184mr2736256qkc.259.1593178604549;
        Fri, 26 Jun 2020 06:36:44 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-8080-bd3e-bf60-4b70-2dd4.inf6.spectrum.com. [2606:a000:1401:8080:bd3e:bf60:4b70:2dd4])
        by smtp.gmail.com with ESMTPSA id e16sm4435491qtm.74.2020.06.26.06.36.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 06:36:43 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:36:41 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Simon Glass <sjg@chromium.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Alberto =?iso-8859-1?Q?S=E1nchez?= Molero 
        <alsamolero@gmail.com>, Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH U-BOOT v3 00/30] PLEASE TEST fs: btrfs: Re-implement
 btrfs support using code from btrfs-progs
Message-ID: <20200626133641.GX8432@bill-the-cat>
References: <20200624160316.5001-1-marek.behun@nic.cz>
 <CAPnjgZ2Pus57k3JS=cqiwwhm1p_bH4E_K4x4=znnD+2ch9cCRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qa1NXTiqN6KSzHv0"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2Pus57k3JS=cqiwwhm1p_bH4E_K4x4=znnD+2ch9cCRg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--qa1NXTiqN6KSzHv0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 07:43:20PM -0600, Simon Glass wrote:
> Hi Marek,
>=20
> On Wed, 24 Jun 2020 at 10:03, Marek Beh=FAn <marek.behun@nic.cz> wrote:
> >
> > Hello,
> >
> > this is a cleaned up version of Qu's patches that reimplements U-Boot's
> > btrfs driver with code from btrfs-progs.
> >
> > I have tested this series, found and corrected one bug (failure when
> > accesing files via symlinks), and it looks it is working now, but I
> > would like more people to do some testing.
> >
> > There are a lot of checkpatch warnings and errors left, I shall fix
> > this in the future.
> >
> > Marek
>=20
> Please can you add a test for this one? See fs-test.sh

Not more fs-test.sh tests, test/py/tests/test_fs/ tests please, thanks!

--=20
Tom

--qa1NXTiqN6KSzHv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl71+eIACgkQFHw5/5Y0
tyzoMAv/YgcJM6B0QU1xHGpcscEcf318ihOlwN4vulriG/GSYUjmcPWWOqhrP7tR
otjj6/z+qtuSyHFsmSe6bjv+lZg5AiBRIpoMo6/xDZsNQrEbl6gn4beRrIZEJv4D
DeJ6RdOVrWL6hd1xEA7oGyUkEE0th6cupgX59i5GwGfXsQkWzVJAMHempwLJwTUt
YT3udbmIOxXjUCvtjoonN+Yw9jKL+SqJyyvw/OrK48TDUINJALXDp1Zx6l1ozPOp
KpvYwEZCiZgPHghNXAGTpY85XwViaJHafL5GhNaB535Lfj2U/t72bZcYjzUpIFbI
qS47HroWLD8Lvhns2ZQRiZP5vyfNSDPjPH8vRbV9Diamt/4k5nqwB6XF1iYSiSgc
x5RjJjXCvMo6/JYVNzEzcTbzvXB4p6MTlMfNIle8wrqMCGKk9bmcJYdRv2WKoGlS
0XFC0C3Zn9WQB2avJv329Oykd8S8+cYQe7IlmsI0kwpmnHLLQ0qqhRg92b1x2V+q
4bh74NPv
=MzUl
-----END PGP SIGNATURE-----

--qa1NXTiqN6KSzHv0--
