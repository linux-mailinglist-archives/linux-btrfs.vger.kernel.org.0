Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE3C2BB8
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 03:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfJABl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 21:41:59 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:37821 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfJABl7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 21:41:59 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D01646BE;
        Mon, 30 Sep 2019 21:41:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 30 Sep 2019 21:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=fsIbNzrkPNXjdxsp2RDltB+jdUW
        f5vCZkcp+w6JgdN8=; b=qG9I/cEFzSnVs7DW4u4Qbb2nbdph0jdMaO1G97BBjCP
        C4dy5OzCNg+84nblaax4jNp+8tLKnW6nNOasyYyUbssWtKjTZMdsO2Qd56vhguUn
        JmCOzfQ6hQfVhupdeIBIlNhrdvQaPLjToEoe0Nezfs4HKegSSh5doJ/Re16wrYbC
        LSMDwyZvc0aQWNDTsfOxlliYyoXEjfCMMtsBey52PpnZNOTkdi1lJIxBL3QPzcdN
        nLtQg8lZFMu4f3w7voA4vJtYLtjeIM8ywqqbe71PckDl/AfWMTZ4+UKXffnQxxE+
        cxXZnH2Gawc0cdrpH2OLOs37JLjrsSsJpwr0R02d8UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fsIbNz
        rkPNXjdxsp2RDltB+jdUWf5vCZkcp+w6JgdN8=; b=Get3UJCqj/Yg6APXqtcZoa
        J9cgvi2Eu00lIYWGghMfbKTOWOelDQ/6slBgSGGw30smAAAQtW2oBqiPzkPoszF3
        clKisnMrGsG1x6W68YGa2JzD5VQ9dzwUEHbkBICEcis9ZT8aX7IhnCrDNw+XFSUp
        v0RCjM2tBq3tgE5srEllm4VrHrdWjrs70Fda4TXWj2xIOARo9mPSg7/2EIr+vsJd
        gO91H4ZwVf1lxT3i8k+6+Uf5/eadBmjRy7s4GRV02D4gDjj/pUftCIAq1mFbBdJq
        gwNj9ufsP8eFIpDd4PTD7C5pzxPSGqzfqGE5UZr4y83f09Ci7sBM4lkoCk+H4nOw
        ==
X-ME-Sender: <xms:4q6SXeHhRXUSbV25HWHfDC7_YeI6E75EIZAsGBA298nUkPuky5dJIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrgeefgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtderof
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecukfhppedufeehrddvfedrvdegiedrudefudenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:4q6SXTlIQrL6ll6-_MXL2mtzVM6JsyA171vj1MCles0HKT3-cI-tKA>
    <xmx:4q6SXTLjUjerLXG268l9pMRiXM5IbVPLAqCL5UwtkN7iKUuferAXfQ>
    <xmx:4q6SXcaxgOPNhmWc4k5xz_XdK3mlwNh_yRMXf4irKQ4k4JRmbPPB8w>
    <xmx:4q6SXdT6dssldbR2QFYdxy7VujeUh_roKRsd3KS2GYxXFM6H74VqOA>
Received: from [10.0.0.6] (135-23-246-131.cpe.pppoe.ca [135.23.246.131])
        by mail.messagingengine.com (Postfix) with ESMTPA id C953ED6005A;
        Mon, 30 Sep 2019 21:41:53 -0400 (EDT)
Subject: Re: BTRFS corruption, mounts but comes read-only
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <1d65213e-6237-2c5b-4820-81a0d3bd3e53@georgianit.com>
 <44df5407-b7c9-bbd1-eae0-d5ebf6ad75d8@georgianit.com>
 <6022d6c9-3022-01fd-3b97-67bd08ce36f1@gmx.com>
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
Message-ID: <fe22fa62-7b13-f417-1af8-3ed12bf082f8@georgianit.com>
Date:   Mon, 30 Sep 2019 21:41:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6022d6c9-3022-01fd-3b97-67bd08ce36f1@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8akMAoBq0cKHS6RwMz5Ye0wMvhoMpYrjP"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8akMAoBq0cKHS6RwMz5Ye0wMvhoMpYrjP
Content-Type: multipart/mixed; boundary="bW4wIBXCVykHqZJh3PAPSXXKyAetcc1rm";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <fe22fa62-7b13-f417-1af8-3ed12bf082f8@georgianit.com>
Subject: Re: BTRFS corruption, mounts but comes read-only
References: <1d65213e-6237-2c5b-4820-81a0d3bd3e53@georgianit.com>
 <44df5407-b7c9-bbd1-eae0-d5ebf6ad75d8@georgianit.com>
 <6022d6c9-3022-01fd-3b97-67bd08ce36f1@gmx.com>
In-Reply-To: <6022d6c9-3022-01fd-3b97-67bd08ce36f1@gmx.com>

--bW4wIBXCVykHqZJh3PAPSXXKyAetcc1rm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-09-30 9:30 p.m., Qu Wenruo wrote:
>=20
>=20
> On 2019/10/1 =E4=B8=8A=E5=8D=885:08, Remi Gauvin wrote:
>> Mounting the FS after that btrfs check, kernel 5.3.1, here is the dmes=
g log:
>=20
> As that btrfs check shows, your extent tree is corrupted.
> Quite some backref is lost, thus no wonder some write opeartion would
> cause problem.
>=20
> In that case, it looks like only extent tree is corrupted, and no
> transid error.
>=20
> If you have data backed up, you would like to btrfs check --repair to
> see if it can repair them.
>=20
> Thanks,
> Qu


This is itself a back-up system, but not wishing to tempt fate, I'm
going to have to create a working substitute before I do anything risky
with it.  It would take me several days and lots of travel to re-aquire
them.

Any idea what could have happened?  The data and meta data should be
raid1, and none of the drives have any io errors of any kinds in their
SMART log.

Thank you for your guidance.





--bW4wIBXCVykHqZJh3PAPSXXKyAetcc1rm--

--8akMAoBq0cKHS6RwMz5Ye0wMvhoMpYrjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJdkq7hAAoJEO9Tn/JHRWpt3AUH/RtENpNS9h84JA9uk9NXmGxI
bE3aLGU54BSPwYz0/Wzropz7oRaBKzDLMTsO90jH3h+SGgH7D/lxcgTVs1g3S+RU
fnaM/K7uNBQVI9erWunQFkKGyFi2Fl9xfh0oWzWZAh3I9REIrXeRcEwphmBkYI18
Ddi+1nMHwJz1ju31UY7k4hffOGruPKLF3N0qzS6Nv46KAcLUUWvXToXX9lbU1uIY
YMNhIOMfQ4OB+6+hCstZyQxFnM7JhCuhMXLVYQXNdbjlmwICQM89TD70SJXI8AiL
w2rg462rxlVulcY+6XBMgRroOWIqxePeRUppHeBGwBUkue0xACv5HI2WVga7Um8=
=z8G7
-----END PGP SIGNATURE-----

--8akMAoBq0cKHS6RwMz5Ye0wMvhoMpYrjP--
