Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79200F34F5
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 17:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfKGQuF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 11:50:05 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:37039 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfKGQuE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Nov 2019 11:50:04 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 1F1C3413;
        Thu,  7 Nov 2019 11:50:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 07 Nov 2019 11:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=TXKEiSz1NhU/dDgxhUhidSQPYfH
        BY4XOd7M0XDxKhWI=; b=YIKKb4k6eevyYsW21N9Reu/PNJwVkPeVgHItTmVEXbR
        iI0qxXq5M+ds7aVi6nziBuRPAJQ0BOXqSWwx/N0HJq2Eyi+pklDW84H3/ekJyD//
        9LpoMCfigN/tk2wOJg55AKXNzCJIZyYnXa7ZcwWcRZV8gU59+nPIkSr/pX0EtjXO
        uTWALj1RQXq0vR1ft9s7C28oiK8o5Fyp8YUQMpPDjWOtfXH9C6QU4/UYc9SntuY6
        f2jKMBhWYr0NWl6eI0DSyguay+gsnu1lOG+QHM7CzvGEjmg6/pVXcNV6xgcQ/JjY
        G/we6L63nssF2orK9RhDeCVXX00qsfyLBs8PHJPUwiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TXKEiS
        z1NhU/dDgxhUhidSQPYfHBY4XOd7M0XDxKhWI=; b=ST67uVK+ntKPvPgfmgHyVS
        bA0SOeWcMmSE0NgLkTpUsg6tYpnLhhxkZfdR4xuoI0C7GkYybi7dzpdY1ttgKfsv
        9iL+sA9TxCGfuCFB7sU28u0oVoZGyblwCZH4LmkuXcDYH93tLPkzCqgGpaJrLGcC
        aLz0hHI10k2HaOxxqWpVQTf0S6yPxRSDfiwKk9/FkUvUpvL2e7LXriNAdq9QBCg3
        D+NwC0ZHBi8QDyRXpdZTKwCMzeOsXWp13UG5SE/q9IhiyJsTFTfjJF30GllkkNfi
        kdgMtboHdtuVwwjB/NUYsoZeQSLz94eJliuSYJEj5+MNZyEoOCEFd5Sz2Cxu6f0w
        ==
X-ME-Sender: <xms:OkvEXTG0SJOZuNPdlU_TWKIsFUZoou__V7C8BDM5E92z_ooa3Zhljw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudduledgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtsehgtderofdtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecukfhppedufe
    ehrddvfedrvdegiedrudefudenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehg
    vghorhhgihgrnhhithdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:OkvEXQCBfyyz0QpR7B-2QsVd7o51K2HX5SK3gt3W2tjZC2UotLO76g>
    <xmx:OkvEXQxzqM591vyeHSf9_mA58C7KmNdoXLbc7sR_rboOEgxos5x5Uw>
    <xmx:OkvEXc4HdMPwbUO9JUTAazi4HU2MDyNZ97aTW70Sv8PVIHu7DqJtnA>
    <xmx:OkvEXXfc2kdtqBL8hRxaD9pyPFhz8hUSApryn5iT-lw9qzO9edNzPg>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA0128005C;
        Thu,  7 Nov 2019 11:50:01 -0500 (EST)
Subject: Re: Defragmenting to recover wasted space
To:     Nate Eldredge <nate@thatsmathematics.com>
References: <alpine.DEB.2.21.1911070814430.3492@moneta>
From:   Remi Gauvin <remi@georgianit.com>
Openpgp: url=http://www.georgianit.com/pgp/Remi%20Gauvin%20remi%40georgianit.com%20(0xEF539FF247456A6D)%20pub.asc
Autocrypt: addr=remi@georgianit.com; prefer-encrypt=mutual;
 keydata= mQENBFogjcYBCADvI0pxdYyVkEUAIzT6HwYnZ5CAy2czT87Si5mqk4wL4Ulupwfv9TLzaj3R
 CUgHPNpFsp1n/nKKyOq1ZmE6w5YKx4I8/o9tRl+vjnJr2otfS7XizBaVV7UwziODikOimmT+
 sGNfYGcjdJ+CC567g9aAECbvnyxNlncTyUPUdmazOKhmzB4IvG8+M2u+C4c9nVkX2ucf3OuF
 t/qmeRaF8+nlkCMtAdIVh0F7HBYJzvYG3EPiKbGmbOody3OM55113uEzyw39k8WHRhhaKhi6
 8QY9nKCPVhRFzk6wUHJa2EKbKxqeFcFzZ1ok7l7vrX3/OBk2dGOAoOJ4UX+ozAtrMqCBABEB
 AAG0IVJlbWkgR2F1dmluIDxyZW1pQGdlb3JnaWFuaXQuY29tPokBPgQTAQIAKAUCWiCNxgIb
 IwUJCWYBgAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ71Of8kdFam2V1Qf9Fs6LSx1i
 OoVgOzjWwiI06vJrZznjmtbJkcm/Of5onITZnB4h+tbqEyaMYYsEIk1r4oFMfKB7SDpQbADj
 9CI2EbpygwZa24Oqv4gWEzb4c7mSJuLKTnrhmwCOtdeDQXO/uu6BZPkazDAaKHUM6XqNEVvt
 WHBaGioaV4dGxzjXALQDpLc4vDreSl9nwlTorwJR9t6u5BlDcdh3VOuYlgXjI4pCk+cihgtY
 k3KZo/El1fWFYmtSTq7m/JPpKZyb77cbzf2AbkxJuLgg9o0iVAg81LjElznI0R5UbYrJcJeh
 Jo4rvXKFYQ1qFwno1jlSXejsFA5F3FQzJe1JUAu2HlYqRrkBDQRaII3GAQgAo0Y6FX84QsDp
 R8kFEqMhpkjeVQpbwYhqBgIFJT5cBMQpZsHmnOgpYU0Jo8P3owHUFu569g6j4+wSubbh2+bt
 WL0QoFZcng0a2/j3qH98g9lAn8ZgohxavmwYINt7b+LEeDoBvq0s/0ZeXx47MOmbjROq8L/g
 QOYbIWoJLO2emyxmVo1Fg00FKkbuCEgJPW8U/7VX4EFYaIhPQv/K3mpnyWXIq5lviiMCHzxE
 jzBh/35DTLwymDdmtzWgcu1rzZ6j2s+4bTxE8mYXd4l2Xonn7v448gwvQmZJ8EPplO/pWe9F
 oISyiNxZnQNCVEO9lManKPFphfVHqJ1WEtYMiLxTkQARAQABiQElBBgBAgAPBQJaII3GAhsM
 BQkJZgGAAAoJEO9Tn/JHRWptnn0H+gOtkumwlKcad2PqLFXCt2SzVJm5rHuYZhPPq4GCdMbz
 XwuCEPXDoECFVXeiXngJmrL8+tLxvUhxUMdXtyYSPusnmFgj/EnCjQdFMLdvgvXI/wF5qj0/
 r6NKJWtx3/+OSLW0E9J/gLfimIc3OF49E3S1c35Wj+4Okx9Tpwor7Tw8KwBVbdZA6TyQF08N
 phFkhgnTK6gl2XqIHaoxPKhI9pKU5oPkg2eI27OICZrpTCppaSh3SGUp0EHPkZuhVfIxg4vF
 nato30VZr+RMHtPtx813VZ/kzj+2pC/DrwZOtqFeaqJfCi6JSik3vX9BQd9GL4mxytQBZKXz
 SY9JJa155sI=
Message-ID: <cc5fba8b-baf3-f984-c99d-c5be9ce3a2d9@georgianit.com>
Date:   Thu, 7 Nov 2019 11:50:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911070814430.3492@moneta>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ySX7wMzNNVHsX0zXOZsOrUrcF8Px0LrTm"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ySX7wMzNNVHsX0zXOZsOrUrcF8Px0LrTm
Content-Type: multipart/mixed; boundary="sknpIWXlPFwYjRVfLJIVY94pFDuLGpsfy";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Nate Eldredge <nate@thatsmathematics.com>
Message-ID: <cc5fba8b-baf3-f984-c99d-c5be9ce3a2d9@georgianit.com>
Subject: Re: Defragmenting to recover wasted space
References: <alpine.DEB.2.21.1911070814430.3492@moneta>
In-Reply-To: <alpine.DEB.2.21.1911070814430.3492@moneta>

--sknpIWXlPFwYjRVfLJIVY94pFDuLGpsfy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-11-07 9:03 a.m., Nate Eldredge wrote:

> 1. What causes this?=C2=A0 I saw some references to "unused extents" bu=
t it
> wasn't clear how that happens, or why they wouldn't be freed through
> normal operation.=C2=A0 Are there certain usage patterns that exacerbat=
e it?

Virtual Box Image files are subject to many, many small writes... (just
booting windows, for example, can create well over 5000 file fragments.)
 When the image file is new, the extents will be very large.  In BTRFS,
the extents are immutable. When a small write creates a new 4K COW
extent, the old 4k remains as part of the old extent as well.  This
situation will remain until all the data in the old extent is
re-written.. when none of that data is referenced anymore, the extent
will be freed.

> 5. Is there a better way to detect this kind of wastage, to distinguish=

> it from more mundane causes (deleted files still open, etc) and see how=

> much space could be recovered? In particular, is there a way to tell
> which files are most affected, so that I can just defragment those?

Generally speaking, files that are subject to many random writes are
few, and you should be well aware of the larger ones where this might be
an issues,, (virtual image files, large databases, etc.)  These files
should be defragmented frequently.  I don't see any reason not run
defrag over the whole subvolume, but if you want to search for files
with absurd fragments, you can always use the find command to search for
files, run the filefrag command on them, then use whatever tools you
like to search the output for files with thousands of fragments.





--sknpIWXlPFwYjRVfLJIVY94pFDuLGpsfy--

--ySX7wMzNNVHsX0zXOZsOrUrcF8Px0LrTm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdxEs5AAoJEO9Tn/JHRWptV3QH/0elt76DYvVXavEUYQY8ykB7
BO1X0fA4RPu4TsHf9l32VA5xya/ebN2K5lD8U07hCCGJI9UDWBYgOu9ebe1F6Z+0
wRChScF85JaoYFLu0zxAJ7EThvKIRU73SsKC7n0oDTdY31wt6532KogollX7rueQ
mnRo//7loW+ouvNyfqJl257lnnrHU9gcyEtWjfSHOnsSOvoXAtlAWhsq3V7pImmB
TI0B8z8SiYZ1W7SSxPUn1VKWu84DaDWlBzxjEwr1u/NujEVAr1+sN3skbYPADjI7
l/Zl+HmB8+V4hmRZ4kekH4nKg51S3FdDOg5K77eqAUVcNbndaEB098hftMXmJ+s=
=uMsN
-----END PGP SIGNATURE-----

--ySX7wMzNNVHsX0zXOZsOrUrcF8Px0LrTm--
