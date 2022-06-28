Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2447055E893
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 18:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbiF1ORP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jun 2022 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344829AbiF1ORN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jun 2022 10:17:13 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DAE2EA07
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 07:17:12 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id t16so20200956qvh.1
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jun 2022 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fHm0CiyWSHETp6z498ld+K0sQYjE7jLFHNiGgd3eMCY=;
        b=akyGWAPhtroBWr7EzHV5dgf4YFI+WGYskWDgZqRJrt7XUe38A/YlzQZPnoIHiwRbB0
         dYg0bdHkBrzVKo7If4vopSsxFf5nLkMkao+Q2RqL9f90DJRF6nB/QHXpamx1zq4HOGVm
         s8WWELsQhP7cHJ+dPeFoTGQ9qot48tr1y+njk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fHm0CiyWSHETp6z498ld+K0sQYjE7jLFHNiGgd3eMCY=;
        b=BGLcipUoEJvhhmVktcu53IFPLd0Y0Xx+KDDfO/GDqam4r47YfCzrD+4EZFq3pu2uP8
         IFblT7Fp7kpD3Lo5PKWceCwskirX6V7Gh/LUsb5uEqmkWNR09iboBbeOZ3a0f0C3uPpB
         hXAm5m0RRgpa/NG6sPBNIGC0duBGpJelWdjHUtcwZBh//AKOaDWJl0+mVYLdAXHNP/0X
         ThXggzrVET+kJQpmcB6ALzyLuD99n9/Fcjq8Ht6aW5VDLAq7wQJVrdR1HENwlpXSAnLB
         A4Cfwwbuz2MvTJv2goAc25PC4IkdQ1l15m6j7Btix66cru8UmHav+AHT2F+CblbPj8Qi
         jIBg==
X-Gm-Message-State: AJIora+zqrNpFps7HRYsdGJXeGKBWbPQuFuc0/prCt+S5m6zMJBMeL1z
        XJkNaycZs8lbaVrFh+9LTNqULg==
X-Google-Smtp-Source: AGRyM1uc/3vUDj6VXEJ5EwykkdJtRsV9TdsqmJs/EdgWZSm7yWChU2GMIn5VtKjI2Ja7iwVjJ7Y2NA==
X-Received: by 2002:ad4:5005:0:b0:470:347e:ccdd with SMTP id s5-20020ad45005000000b00470347eccddmr3744706qvo.123.1656425831906;
        Tue, 28 Jun 2022 07:17:11 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id f15-20020ac87f0f000000b00304e8938800sm9367395qtk.96.2022.06.28.07.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:17:10 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:17:08 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, marek.behun@nic.cz,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH 0/8] u-boot: fs: add generic unaligned read handling
Message-ID: <20220628141708.GJ1146598@bill-the-cat>
References: <cover.1656401086.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zOcTNEe3AzgCmdo9"
Content-Disposition: inline
In-Reply-To: <cover.1656401086.git.wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--zOcTNEe3AzgCmdo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2022 at 03:28:00PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> Unlike FUSE/Kernel which always pass aligned read range, U-boot fs code
> just pass the request range to underlying fses.
>=20
> Under most case, this works fine, as U-boot only really needs to read
> the whole file (aka, 0 for both offset and len, len will be later
> determined using file size).
>=20
> But if some advanced user/script wants to extract kernel/initramfs from
> combined image, we may need to do unaligned read in that case.
>=20
> [ADVANTAGE]
> This patchset will handle unaligned read range in _fs_read():
>=20
> - Get blocksize of the underlying fs
>=20
> - Read the leading block contianing the unaligned range
>   The full block will be stored in a local buffer, then only copy
>   the bytes in the unaligned range into the destination buffer.
>=20
>   If the first block covers the whole range, we just call it aday.
>=20
> - Read the aligned range if there is any
>=20
> - Read the tailing block containing the unaligned range
>   And copy the covered range into the destination.
>=20
> [DISADVANTAGE]
> There are mainly two problems:
>=20
> - Extra memory allocation for every _fs_read() call
>   For the leading and tailing block.
>=20
> - Extra path resolving
>   All those supported fs will have to do extra path resolving up to 2
>   times (one for the leading block, one for the tailing block).
>   This may slow down the read.

This conceptually seems like a good thing.  Can you please post some
before/after times of reading large images from the supported
filesystems?

--=20
Tom

--zOcTNEe3AzgCmdo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmK7DV0ACgkQFHw5/5Y0
tyw4wgwAgFBSQUmc0vXnm32m15bLKbLt97pqXjfpsq+cDbddcLNsue4tH8KXKvOd
t7L9GnC82BCdcUiAX6hoyEzN75EkZEMmjNU6lDYW7V35LFjab4Qy139pRFdx+DLO
QwP0uvyOb27F9NkbEAH48YF34QB5m6uk2klwdEcj9zUgD6Gff4cNeOLQEjI0WnVr
nxGdyLMMd0L4MiMDHmP8kAGw69viHgxqtRzOJsospvcss5Q0L9yOvEualFasXnfx
RjrFF5pBJGQQXvjG+Uv82cMy4IJkUQ0zPr5RRTE6/ig9QRIAdNwgvPCyRrqt1stQ
DNiUT19fQ8N6V0pfxDOT+3qcFc0CCYvFGyKI2j7VBvZRcLH7CpvZpE//trknCzF8
yk1M32UbRgFrpWS/U5vqbweLE4Oj6eOHndbvZE4DRUWKxHscGkJE2Kc1OYDkAfmi
dAKVJLDMZ1qPs11zGW5Li11vdY1nyQvZoIk4XzgbTmXElItHOkhF5FK6yRvgLmmo
G+IC+hYb
=FjO5
-----END PGP SIGNATURE-----

--zOcTNEe3AzgCmdo9--
