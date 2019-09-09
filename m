Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE7ADDFA
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 19:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbfIIRYj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 13:24:39 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36329 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbfIIRYj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 13:24:39 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D17D2212F
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Sep 2019 13:24:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 09 Sep 2019 13:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm3; bh=ZaHKw9Ax4sxmcWIqqfzAlT5hvcg
        ZFUzWQcCHp8Qzob8=; b=au9IRjSuyEsMujWXzCaqoRTYo2EZQoODcn6Bty4qIOi
        VwsD2ArlQbBbfdRKhux0/ahWFPa3UOamVmjucQjPVfQ7Y2XBOt286zUsjhegDHB3
        62gq8jCpEXFl5j4wFLzi2EWpCT1EbvRGweJzmGaml97qYLzpD9ICU9yGj0kt37pN
        irfKaya5IfOlOfg3xKYYaD9xH6b3VMVmoEPlVnpSVUIPjODHK9w8ehK6xDeIzYy2
        JSCkowQ1zo1s+5LVo75soWotKmXUyI+CDz14BzqJ1KXijoy2lu3b9YbvVk312i8F
        pJEw+eq9G5wVTU+GRhiAeTJFLXifvOOvUOxOcJVhaYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZaHKw9
        Ax4sxmcWIqqfzAlT5hvcgZFUzWQcCHp8Qzob8=; b=VoV0aG+AhmaoXBnN3B6mGn
        UkdV/6muUMoTZrfUtjKKgF7/jbQ1emtwGFkE5d4nPRUzi6aa2cN92C+Vn4yY1ZnZ
        UeBTfYHhNnj0MefGG8ze0h72adncRgawoKv4rW0/ZlffBtlzSN4s/NLgp05yyaqI
        eeMpdeGLuOxmnGAjTSHCyzHDFS6X69VCU1i50FPIvJGm0QGt0cDU/9mhHH0vs0YM
        75ux30IER53vwjL5TimgGhcSgYPGBUtavTcFrD7h8uA6jSz3DDHSRu2DNapWeN+P
        HUgw/d/Ng1fDOFQBPD7NidujugeCjgEBK+kCjZ3Mh0UwBk9ZndI4zRFnzJkXf//w
        ==
X-ME-Sender: <xms:1op2XScJwMBFb1C89c4q__3_DlsU9kk1GRNrTpMKDg167XfoZIUxcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudekiedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtd
    erofdtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhg
    ihgrnhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhu
    shhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:1op2XSNB2Vp33EBJ7GYOv2vuWTtSXXDHvrkVIyi5ZpdUP3pnKokElA>
    <xmx:1op2Xf8WR_ha2HrtMA_xfvSWEHTipjeHB4foPJ8vaRPn4VXg09JQXQ>
    <xmx:1op2XVgFb15TzbvNIYQh9k9SGmaPQaWM1KETgE3Od1xE5tR72fGWEw>
    <xmx:1op2XYfMgufhe-HFDSQRGMP4xJmRcSi-gpf-tuWI-Vdr37oMW98hxw>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F3748005B
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Sep 2019 13:24:37 -0400 (EDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
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
Message-ID: <f74dd133-e300-344a-9cd4-e21a2c17eb7a@georgianit.com>
Date:   Mon, 9 Sep 2019 13:24:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9T6TIhqvwgdgSH9Di6T5IPbsng94nNsRf"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9T6TIhqvwgdgSH9Di6T5IPbsng94nNsRf
Content-Type: multipart/mixed; boundary="nO3tb5tKZDArMO5zG34Ogr5kmc4RWuOq7";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <f74dd133-e300-344a-9cd4-e21a2c17eb7a@georgianit.com>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
In-Reply-To: <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>

--nO3tb5tKZDArMO5zG34Ogr5kmc4RWuOq7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-09-09 11:29 a.m., Graham Cobb wrote:

>  and does anyone really care about
> defrag any more?).
>=20


Err, yes, yes absolutely.

I don't have any issues with the current btrfs defrag implementions, but
it's *vital* for btrfs. (which works just as the OP requested, as far as
I can tell, recursively for a subvolume)

Just booting Windows on a BTRFS virtual image, for example, will create
almost 20,000 file fragments.  Even on SSD's, you get into problems
trying to work with files that are over 200,000 fragments.

Another huge problem is rsync --inplace.  which is perfect backup
solution to take advantage of BTRFS snapshots, but fragments larges
files into tiny pieces (and subsequently creates files that are very
slow to read.).. for some reason, autodefrag doesn't catch that one eithe=
r.

But the wiki could do a beter job of trying to explain that the snapshot
duplication of defrag only affects the fragmented portions.  As I
understand, it's really only a problem when using defrag to change
compression.





--nO3tb5tKZDArMO5zG34Ogr5kmc4RWuOq7--

--9T6TIhqvwgdgSH9Di6T5IPbsng94nNsRf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJddorUAAoJEO9Tn/JHRWptbmYH/iypZIviPr+zNCsiR9fkNLCD
kBHk7XuDxmGBTMUh/8eRQw3/DZbppJA+PITYpoZ/qPEppFEXn+chMspakTDXDM1Z
WXF4UngpI2fMoasEOIW+XTMHmZXxoe0xP6RhTqFk6opqc0E6YWH32FmzCEuiSSwH
0O66IyidWFiyNFcPklPbaqP5ZHn28sQe7i074ph5Tdj/exeBaufFopAamIhzCpOb
OUBcf2YvnUp1cFEr8W5p08b/tHT2vh6HZ4J3Uwnjk/MQtTzrkBB6lyMldnajHAp6
stg49yx4nD5fAMDkIdLYPEqUsKRXY0vpaIDKS5fIA26/TeC/0nTYoPwZQ7EIzJc=
=WE6G
-----END PGP SIGNATURE-----

--9T6TIhqvwgdgSH9Di6T5IPbsng94nNsRf--
