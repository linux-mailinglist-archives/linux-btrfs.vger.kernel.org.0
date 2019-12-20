Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77987128157
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 18:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLTRYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 12:24:07 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59965 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727390AbfLTRYH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 12:24:07 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 4FA9B22378;
        Fri, 20 Dec 2019 12:24:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 20 Dec 2019 12:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm1; bh=iqYBhNx14lxS92MdQJoKmgMh3bJ
        VmKAQtNqoRhHlUJ8=; b=UWodEqHK9aYml9XlLriiLTyG9ml+8iyT0lMvduQejtD
        Jdop8Sc97GNQS6YKXjG0k4qHGihzdwliKCCHKy6xkY25fKcAZVB40JvJhbHPxY0J
        rY2wxmtyIhdyoubFFyKF2F+tri5OV/+2nm6OyvzqszTq64LCAloyjMdolMwfMCqP
        fgvBXiZ4mVgDswebFVpopjt5oJEUBT6cj5+0/LXTNOp8K4lxoAmKZNMQ8OgGILen
        lgkWPcxbDzMkMcmA28lNwMQ1uwP1M1wnkxdT4FfIXqqo4GWNFhJx4/aNwQ8PHzBQ
        hfZMmyEfZf1UEeZ14+oe9FKEbrJzY4hOytuD5qZnrtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iqYBhN
        x14lxS92MdQJoKmgMh3bJVmKAQtNqoRhHlUJ8=; b=HlgFXJmQ+oxVFgvHeZ3EPA
        b/OpqVwqjoAITfOB3f7Ic6F8D2WrBS6xwAzdeEztZPROrr9vd0vP/IGXrvuk5+tT
        BGrxLj+lRbizyoDJI0HtOD/JGLdSPgqH8jUwI14FrPNs+f3ZBTb85B+hAlDsX0UH
        Yj2rmzrsSbOe+DfL8gBCM4BrVTS4f95dzXVgIwoxSB8qJCpbO8Ui/4n1SGkVWTSr
        9iVoO1jcbSYDbWQ8A3NJa9WXpLUvmr86pfhtfvLzXGZhLEsy1Ts8Pb6r/7oJnPZF
        7MSx19xKM9BUlrkfbEJZRFCsxb+AiD+87sSJOseJ3pF84tAtMv6irsT/j7a4i7SA
        ==
X-ME-Sender: <xms:tQP9XfIM0W6fcibj6qVz7qJABHGUUl3U_AhJK_bThTfnOyxH-dedcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddufedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgesghdtre
    fotdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhrghhi
    rghnihhtrdgtohhmqeenucfkphepvdefrddvfeefrddutddvrdefkeenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomhenucevlhhushht
    vghrufhiiigvpedt
X-ME-Proxy: <xmx:tQP9XWrUfTIy02UriJds_0VHcWUjydgZbg6wyB6Ck1bnFl2Im7ItsA>
    <xmx:tQP9XQNUNBDUce4SdPHrpmROHIMWXk5p5AB8D5UJ7A-11TfPsGWLnA>
    <xmx:tQP9XbMTgcRXc-XLDpusYI_F5qtYe3HkKwowaOCbgT5GmP_8g8kH_g>
    <xmx:tgP9XZIvuw3l0vHc3VDcG5DX5dqKcoEjnq59bC79fePQf0RH9hDzPA>
Received: from [10.0.0.6] (23-233-102-38.cpe.pppoe.ca [23.233.102.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD86C30608EF;
        Fri, 20 Dec 2019 12:24:05 -0500 (EST)
Subject: Re: btrfs dev del not transaction protected?
To:     Marc Lehmann <schmorp@schmorp.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
 <20191220165008.GA1603@schmorp.de>
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
Message-ID: <45b11982-0847-8e2c-b40f-0c22ed21de2b@georgianit.com>
Date:   Fri, 20 Dec 2019 12:24:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20191220165008.GA1603@schmorp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xFxiGHoEX8PuORCUErQoPrnXCXKwEDQ7C"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xFxiGHoEX8PuORCUErQoPrnXCXKwEDQ7C
Content-Type: multipart/mixed; boundary="WtEpuJeyOHxcwSBzw5k0IazxHJ9Dcyxw5";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Marc Lehmann <schmorp@schmorp.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <45b11982-0847-8e2c-b40f-0c22ed21de2b@georgianit.com>
Subject: Re: btrfs dev del not transaction protected?
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
 <20191220165008.GA1603@schmorp.de>
In-Reply-To: <20191220165008.GA1603@schmorp.de>

--WtEpuJeyOHxcwSBzw5k0IazxHJ9Dcyxw5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-12-20 11:53 a.m., Marc Lehmann wrote:

>=20
>    Filesystem               Size  Used Avail Use% Mounted on
>    /dev/mapper/xmnt-cold15   27T   23T     0 100% /cold1
>=20
>    Overall:
>        Device size:                       24216.49GiB
>        Device allocated:                  20894.89GiB
>        Device unallocated:                 3321.60GiB
>        Device missing:                        0.00GiB
>        Used:                              20893.68GiB
>        Free (estimated):                   3322.73GiB      (min: 1661.9=
3GiB)
>        Data ratio:                               1.00
>        Metadata ratio:                           2.00
>        Global reserve:                        0.50GiB      (used: 0.00G=
iB)
>=20
>    Data,single: Size:20839.01GiB, Used:20837.88GiB (99.99%)
>       /dev/mapper/xmnt-cold15      9288.01GiB
>       /dev/mapper/xmnt-cold12      7427.00GiB
>       /dev/mapper/xmnt-cold13      4124.00GiB
>=20
>    Metadata,RAID1: Size:27.91GiB, Used:27.90GiB (99.97%)
>       /dev/mapper/xmnt-cold15        25.44GiB
>       /dev/mapper/xmnt-cold12        24.46GiB
>       /dev/mapper/xmnt-cold13         5.91GiB
>=20
>    System,RAID1: Size:0.03GiB, Used:0.00GiB (6.69%)
>       /dev/mapper/xmnt-cold15         0.03GiB
>       /dev/mapper/xmnt-cold12         0.03GiB
>=20
>    Unallocated:
>       /dev/mapper/xmnt-cold15         0.01GiB
>       /dev/mapper/xmnt-cold12         0.00GiB
>       /dev/mapper/xmnt-cold13      3321.59GiB
>=20

You don't need hints, the problem is right here.

Your Metadata is Raid 1, (which requires minimum of 2 devices,) Your
allocated metadata is full (27.90GB / 27.91 GB) and you only have 1
device left with unallocated space, so no new metadata space can be
allocated until you fix that.



--WtEpuJeyOHxcwSBzw5k0IazxHJ9Dcyxw5--

--xFxiGHoEX8PuORCUErQoPrnXCXKwEDQ7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJd/QO1AAoJEO9Tn/JHRWpty48H/A0O1yXwrpnW+WgHmKQg1oog
x0xJov8URGoFXQKcOp4qCv9F45CmXXp9LuAgIbDoOyZwjKIhS3+ybBrOLEjkc5x0
EB13EmqYaoECwUS14Ve0L6zS8MDaZ+9RnD4e/z1tK3Tz1ehEy0LwuZ4CcA/+qTqo
lJLNALIXAHRxf5WFH7RxR9lGsbh3KdQldpjhu5VCrc/8ya5hgYWKQdt8IPd0gtF7
dq++bKs/H2CHau3OiZRtYHTZyIJezt76B9oOafsO0RRvYlZlxOmKZpfpyPhM1Yn2
RhTni7Wol+Ww2gkWKDVlFJAqnBWtiDU9E/EpWrNNRiojc/mD9a134m+okWf6Ca4=
=v0uY
-----END PGP SIGNATURE-----

--xFxiGHoEX8PuORCUErQoPrnXCXKwEDQ7C--
