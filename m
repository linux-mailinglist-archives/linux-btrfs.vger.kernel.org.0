Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F9021B86
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 18:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfEQQWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 12:22:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52595 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728551AbfEQQWs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 12:22:48 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 38DAA2361B;
        Fri, 17 May 2019 12:22:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 17 May 2019 12:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:cc:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=LcXux7tSbQ95RJ+mCcAIZkfEqcd
        NjKeFO5s3rxayWF0=; b=gHWHHeWcFFHwKaXUdRDgtJG1CHAvGadK45gPths05l/
        M6AgVcy59CcqEFR28U5+07u1cpYC7WzXtgfcAEnE2XpIEnYbbRhCTuYdFwyKY+xe
        g6aFCUEULCg/WFocrsZfzaf3in6miqkehrIZnJ+qDFm3f69cOl2csMy34OxWmjcq
        WPKxyKD17/POtaktpv576yoJAusS+SSv629lfq1+xzZQGcJh53PhvvMKBWTa6i3n
        DsUQiJtL90tc1o0hkt0UDNyLfGIpVUfwV66F/nDrPSqq2UI3X5LTNgToiFwpD8aJ
        UobISvAlUSOjkD0itaUrEuYpzd0g5382aCnLSwfHZzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LcXux7
        tSbQ95RJ+mCcAIZkfEqcdNjKeFO5s3rxayWF0=; b=WTDYyT41x/NkAFpByxmaiz
        gFJN2kBq8sAwcIy2RWWxB1cgEDFOnYLxmZ9pmhFY+xh5Qo5vfRUV17tlyxDlZVKv
        KBAYaW85UTXYktSzYZQmWssndKG2ftzpaSFiBY/f0qzu5cPO8KnRosHdqJARGr8N
        hw8kxMdPrS4ERIOGiTaNvQBKW3hRPEAgsOYOI9DxYD0smcMbnIIuokxxpcAPPsbl
        Z9zMUoxlQFhJVjGQQe+l9OGlte4V1aQG/tndYxLm6fLmQ4i/ddoyCg2fGjStyllj
        gKlT9fjjwsz7mD7GZIUalvxWRJBxEN0ppRbBLV/Lej9V/wUGkrFR8QVekqmdAvMA
        ==
X-ME-Sender: <xms:1t_eXBHx0bMOyJ1xv2-hIwLynIvwLb0TBZOE1tBzpqFehQz2iMjw6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfhfhffkffgfgggjtgesghdtrefotdefjeenucfhrhhomheptfgvmhhi
    ucfirghuvhhinhcuoehrvghmihesghgvohhrghhirghnihhtrdgtohhmqeenucfkphepud
    efhedrvdefrddvgeeirddufedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihes
    ghgvohhrghhirghnihhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:1t_eXAIyEJy86VYaStRErAm2Inny0IdrJiONKdJIpJvBXuAOFw1uWg>
    <xmx:1t_eXB8CVNtLEVu_e0lTLjAmFeVrJ6R-ouMv7D1a15o33DUnKhg36Q>
    <xmx:1t_eXCfrpVHmFW-A-D9hFQQTAJIVPOj2fzVJfBMfi2dJG5yezNyz4Q>
    <xmx:19_eXHUcIbKTxaoCgXcmJ4PRtCP5bPtvcRFwNaprYHRc1e0gB5K1Yg>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5C9638005A;
        Fri, 17 May 2019 12:22:46 -0400 (EDT)
Subject: Re: Used disk size of a received subvolume?
To:     Axel Burri <axel@tty0.ch>
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <cef97a5e-b19e-fdae-2142-f8757d06c4d4@georgianit.com>
 <aed995de-79d4-9932-397d-bd0d12a51b7a@tty0.ch>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
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
Message-ID: <f380d94d-5588-2c0a-577e-41b5f928c291@georgianit.com>
Date:   Fri, 17 May 2019 12:22:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <aed995de-79d4-9932-397d-bd0d12a51b7a@tty0.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Zwa2nC6VCpyZSB7kCmMoU6gfnqaI9IQus"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zwa2nC6VCpyZSB7kCmMoU6gfnqaI9IQus
Content-Type: multipart/mixed; boundary="pkiowLHBeIOTJDgP6eXe1182L0LPCiAAT";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Axel Burri <axel@tty0.ch>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <f380d94d-5588-2c0a-577e-41b5f928c291@georgianit.com>
Subject: Re: Used disk size of a received subvolume?
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <cef97a5e-b19e-fdae-2142-f8757d06c4d4@georgianit.com>
 <aed995de-79d4-9932-397d-bd0d12a51b7a@tty0.ch>
In-Reply-To: <aed995de-79d4-9932-397d-bd0d12a51b7a@tty0.ch>

--pkiowLHBeIOTJDgP6eXe1182L0LPCiAAT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-05-17 10:14 a.m., Axel Burri wrote:

>=20
> Nevertheless I played around with it and it seems to work, I'll keep it=

> in mind for the future.
>=20


fi du was not implemented last time I had to do this, so I had
completely forgotten about it.  It makes much more sense to just use
that for the Excluisve disk usage of a single subvolume.

However, Qgroups does allow you to group multiple subvolumes,, so, for
example, you build a query to find out how much disk space is used
exclusively by the 10 oldest snapshots, which I find to be a more useful
question..


--pkiowLHBeIOTJDgP6eXe1182L0LPCiAAT--

--Zwa2nC6VCpyZSB7kCmMoU6gfnqaI9IQus
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJc3t/VAAoJEO9Tn/JHRWptE2sH/3gnl2SQIbnbE9YII2j75uWc
Q4IffRVZ8oGwrTzy6MifPO8QkS04r3skg6LoDwB5wMzwpjXE9L3+RKeO/wc1ox3U
mKko1Qcs/z9vM51MeVBaNeHWmKElRzIZllw6B8qb1849g5vW4bzas+Ef2noi9rZe
XLJQnAyS3QyHRAtdxR/LLtPQu72c0oS8YuRRIgAbiRWiCgkvYvDu/OV0zNarJsMH
JZwSZLuwZHmtkBVC8tpXMTzjJLQnONq6mE3f4VtUU8uh9avah8YeZIK8RE9R8Jbp
JKJzXX8DRjYi3R46llaBVq88wFkdLg8qGR0L+q9QCMxh1Uq5vT/EiWLzgxQF+ac=
=qMC3
-----END PGP SIGNATURE-----

--Zwa2nC6VCpyZSB7kCmMoU6gfnqaI9IQus--
