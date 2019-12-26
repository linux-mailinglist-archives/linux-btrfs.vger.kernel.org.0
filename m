Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC312AC6F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 14:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLZNos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 08:44:48 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34503 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfLZNos (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 08:44:48 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 4B9697D2;
        Thu, 26 Dec 2019 08:44:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 26 Dec 2019 08:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=Y8P1Rq0wjJsIdaeqzzpENo/7WcU
        +N14Q5iqHmg7eRFA=; b=btxVoisqPI0kfEStXtQeItDEOHia9guuO78jxz92EPf
        fSwUmtTf0rqA3nyJB31ezgG3b8oVWtUfNBWDasGK1kjgXNbP+oROkOvg0zLQNR30
        VscXDIL74A7eNqy+1egbzMPdCZpqj9ZtyRM5OmZgs/jJ+WAW8wBgMv/uxn2xlluj
        2wiiW1QDWyVMLI3CRNqUP+hw8MZJTqcaUH1/D4GPHNLIsKIJK/MXnSv2hV5X5jdA
        SAfhZLbjmp3BaliQIgMDqIGjjRZVWwbjd9dK0WUaBIqVyv8VohPpAJMiT+q0Ry8R
        t+TIHBQ9Rz1tleQPJ7NZ+KYqvRafqhWo6s7rxKllg1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Y8P1Rq
        0wjJsIdaeqzzpENo/7WcU+N14Q5iqHmg7eRFA=; b=iTBXt8R6Gkr/tqVK2UBhUO
        1DoqAhhny7bQ0eMkaG8HIhBPjjTwF8bcIIh+wfg7U5Vib4MhiijjdoD+wwma2jLm
        OaMj8ynGZO9Z7YXoUUq1gyfizrEZsLdKwFSpg78pZQQh087QPypYnacymY1A0X7f
        NYOVDx1MdkN+6dx5ZgRJx1Y5HGmLMeKDZ+NubvbRBhgpVgl3ywCLY+mAIeFKpZpF
        MXYArD1Thw0NovjAotv0yBM4Nl+V0p45isY1pOSt4gOPblr08jCswz/odztwtV2l
        lA5xmcJ2vM7aHkzGZmL2k4+/rhPH3HLPhkWmvE9+B9W8NP12qbpqTs2ljdQ0zFOA
        ==
X-ME-Sender: <xms:TrkEXsUXHYCT-PEqjk-TWe4tHiTbEQCCBRkICAG8OtUXdhWPBfrWmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddviedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtsehgtderofdtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecukfhppedvfe
    drvdeffedruddtvddrfeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgv
    ohhrghhirghnihhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:TrkEXqCgRnZUzr820WknXvGS1INuKGC7UTKpwE3S--CQJu0NWx4QkQ>
    <xmx:TrkEXhN_xHOlsOBbr3ReUM_BYg-fe5_BrzWsQaFOgSwBX0NSt9DLlw>
    <xmx:TrkEXmqCxNCMDhr1SRU6El7o7v2GpqYQa1Zxu5_o3SVFixwbJFhaEA>
    <xmx:TrkEXmXJyaMCYNi36rXVCWGezlADLfSzepw8mFLmDDEszlYxImH8CQ>
Received: from [10.0.0.6] (23-233-102-38.cpe.pppoe.ca [23.233.102.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C3B7306080E;
        Thu, 26 Dec 2019 08:44:46 -0500 (EST)
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Leszek Dubiel <leszek@dubiel.pl>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
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
Message-ID: <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
Date:   Thu, 26 Dec 2019 08:44:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3qjLWTsKews0M2JHPqcQuecfxyAJMRNN1"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3qjLWTsKews0M2JHPqcQuecfxyAJMRNN1
Content-Type: multipart/mixed; boundary="VLNrjXYvKVnAuxxeCSliRyme6n0qHfxNX";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Leszek Dubiel <leszek@dubiel.pl>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
In-Reply-To: <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>

--VLNrjXYvKVnAuxxeCSliRyme6n0qHfxNX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-12-26 8:17 a.m., Leszek Dubiel wrote:

> Not using qgroups.
>=20
> root@wawel:~# btrfs qgroup show -pcre /
> ERROR: can't list qgroups: quotas not enabled
>=20
>=20
> Current data transfer speed is 2Mb/sek.
>=20
>=20


Did you check dmesg to see if you're getting a whole pile of I/O errors
on the failing disk?  It might be necessary to remove it (physically)
and finish replacing it with a degraded array.   (I would not jump to
trying that, however, as there are additional risks if your metadata is
Raid6 as well, and you have any write hole corruption.)



--VLNrjXYvKVnAuxxeCSliRyme6n0qHfxNX--

--3qjLWTsKews0M2JHPqcQuecfxyAJMRNN1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJeBLlNAAoJEO9Tn/JHRWptPDgIAORbeFIal8Jdjpax2OBWVtIG
+6rAXKt8/efQN8aAc9mjqgK6i/80KTk2pxR+NAKU5O+8X+xvMDZpT1kSw8TimYMW
Wlbw+Fyh9UkLtTkYPPizhwhBSUp1o2HgB8NM8E6CI3S/UHDVulJObgnyhrIGxipg
R0udn1ffnNK/wSRYuhf1MSTwI1kx2GAvfOo7VdOxnK7x2u7k2eDyKR+vpvvqivQl
7IxZrNPffurvuJuR5VNQitlNozYOCDiFLcy/wiUpWaYWYaW0t+zObiLqhFFxbZ+i
8GHNkEjfwxJ6ik5q6KqHstX7ttBAlh52QgqfH0mmB9j6pToknPF2AzQRwSETDqk=
=/DI7
-----END PGP SIGNATURE-----

--3qjLWTsKews0M2JHPqcQuecfxyAJMRNN1--
