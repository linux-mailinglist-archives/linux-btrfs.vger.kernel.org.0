Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F66C96AB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 04:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfJCCTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 22:19:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:35877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbfJCCTr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 22:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570069185;
        bh=NNGzCB/E6ur7DnxhFexL4cpUYN3s24/1VxGEnXowi2U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=bt5QCuISrth0nu33wyJwwN/2EbqrNW5NFyA7fF6wic2MLk/pu0VyMjXCdovosBKan
         PsFZS6ZN+oIoJBLmvQ/LnbbrnSx9DcrSFYGmZGZrVInA17wEVAmQ3S3WjY2IdYmmfO
         wA3N3XUP3fypiVzMQ6xoXAwOQhcuAiKsdQfZ9pMg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1i2Sg536f3-014Vib; Thu, 03
 Oct 2019 04:19:45 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <b0ec0862-e08c-677d-8bf4-8a87b74c1ec2@yandex.ru>
 <54a2e030-3b8f-6680-a1b6-826c2f5c0928@gmx.com>
 <d7a9650c-db8f-34db-fb7c-c1ba55159c93@yandex.ru>
 <a6f68cf9-20b9-f1bf-379a-a361c4387dc7@gmx.com>
 <0ecf3dc2-c884-7c08-5f11-86e1b1d2f631@yandex.ru>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <8863e0a1-adb5-81d9-e15a-9dedda00f4bc@gmx.com>
Date:   Thu, 3 Oct 2019 10:19:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <0ecf3dc2-c884-7c08-5f11-86e1b1d2f631@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EezAXiWZyMW80LsE8IncCcbKklj145zQ5"
X-Provags-ID: V03:K1:4I8wfwXvYQoOjFakGlXZ14qZm9BVpaU8U/d7wHPuQdAfwavS0gF
 7QHTGv53zB90UMM7sB6rDlLkc/TO3izCZD1spsaUaTXkeaT39BiX37AhrQhHtsSC1cFfR9M
 oBj+yHSW8iOaPMYwUuOsEGWPAScgV7O85a99ihsK5FWPSmd6OY9wQLS9GICxk6+Jv6lvPIF
 mchy8N+BqrA1i/nKUzNqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QsH+TzPBnCw=:XPIxjErYXzmKvooI73AyEG
 em4BQNHhYBgBfSelfcPX9HCLT8PfTFtNLhxdtsF6xwS+efn6/0zSbt18GBxEKKLr0j7Z0uRVn
 ryHemiJeUTKcBiSHI4q7EIgj8FnGo2pYN6H8vQDaRxm2XiFKtBAqR6b+ObIhcPO/KtqmaGisl
 exJWDifUVfOV0pfqwdGbew93JinjWBqZcKc1YLMMbaey28OEx0w5eNzoxwPL6eOAeU912Vt7F
 UOXCexpdiM7zIYKE1d71A1XieoLiDBC6g8j3w5j2tN9m6Au0cBOSt4tV51DPxAAx+Pfb56BZj
 sQce4hgxX/SnZKyFzrAShhRJe8X7Wr75WexXphMOW+FGnRk5dckh/4fSqjIG3nJf1EEjITinN
 cMIF5bi0S+Wihc3ih+VPTAz5uC5CB6+NNKV07WuyDLCnyQHmdq1MsKfE+preYqUmWlLhi9GAw
 Zf6E0o5tmDtk9Gvh6z19tjgI7KckMtJeuH8bGgUIf4LIfssBAAkQOzrUehnNbYhTPAtQP/0zQ
 qvot8qyIjIFB34e+MBzKl54zAovWYYIXyPYAMZ41QYLOMxWjoDQdP7sQhBRQ+9Fl6awEOTR32
 y0ziPCbBXO/0irThp91hWGmVhLqi0GYp2sD8yEOXtXs6/4eZRVZp4pgFnRE+ty6Sw1vaL+MLo
 bdYOspCO4LlE+gBSEwfkFgg5bTuwPqCm4+7jVD8VZfFzno6wYdnmpmbmd0zZboR5v43asT6hi
 H/q8hb+6StTEheW6+LyBkE4owgofIC1/17FAShI4ko35fvMAibJneoWtiqD5DIClj+rr1QFoo
 VpLRj8Yf8t6lRMQxaKX2HglRrwBwXRaKSxcb8FgNOk7uHYwMZCmjQQbDB38aDLyRfuVTRRKps
 1qiKFopva971tuW39qujHspv8oyPSrTy3nNs9TpHTCMwQmX2HZ6v/1Oj5LBpqDAdFb/PUq2Wu
 uURx80OTuwr4WckzaCT+hjUtClVOi+WvH9VvV10nHF3X9iIPoao4e+oGtDdVzZgsdjkWzCs5P
 nBhMzQn8N6HM0DcDFlNMUmnGRfScdfDEX01t16O41nlmlanrGKxO/mHeYu6W4hBzwOuI5jr/I
 wZSCs5E7GfQAzEWZRFFCAtEcX6Qssdun83v3xPjNXWn5A4/u2aZMMKMGxfzfvzVrgS6TG5AaR
 uhVkXulZwjLTQUGM7UluYRmS07EsZHrKigd9x+aThg7P15FmMKlG7v2pXCj2iyp1HK13Haod6
 H62+gIzfQ+Olv8dFeYYcjrDO6w5HV8KMYEa59EVLNXjkyTjmlbhUHmDQtWSk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EezAXiWZyMW80LsE8IncCcbKklj145zQ5
Content-Type: multipart/mixed; boundary="VDDJ5NzI0W1PbXuSuxeVkVzogxYT3rfvL"

--VDDJ5NzI0W1PbXuSuxeVkVzogxYT3rfvL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/3 =E4=B8=8A=E5=8D=8810:18, Andrey Ivanov wrote:
> On 03.10.2019 5:00, Qu Wenruo wrote:
>>> I think "btrfs check" is looped somewhere. Or not?
>>
>> You can try "btrfs check --mode=3Dlowmem --repair" as an alternative.
>=20
> $ btrfs check -p --mode=3Dlowmem --repair sda4.image.copy
> enabling repair mode
> WARNING: low-memory mode repair support is only partial
> Opening filesystem to check...
> Checking filesystem on sda4.image.copy
> UUID: a942b8da-e92d-4348-8de9-ded1e5e095ad
> [1/7] checking root items=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (0:00:07 elapsed, 509895
> items checked)
> Fixed 0 roots.
> No device size related problem found=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (0:00:47 elapsed, 71347
> items checked)
> [2/7] checking extents=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (0:00:47 elapsed, 71347
> items checked)
> cache and super generation don't match, space cache will be invalidated=

> [3/7] checking free space cache=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0:00:00 elapsed)
> ERROR: root 5 DIR_INDEX[843063 15] data_len shouldn't be 256sed, 1055
> items checked)
> invalid dir item size
> ERROR: fail to repair inode 908624 name filterlog.html filetype 1
> ERROR: root 5 DIR ITEM[843063 15] name filterlog.html filetype 1 missin=
g
> ERROR: root 5 INODE REF[908624, 843063] name filterlog.html filetype 1
> missing
> ERROR: root 5 DIR_INDEX[843063 18] data_len shouldn't be 256
> ERROR: root 5 INODE_ITEM[908627] index 18 name Sent/sbd filetype 2 mism=
ath
> ERROR: root 5 DIR_INDEX[843063 18] should contain only one entry
> Set isize in inode 843063 root 5 to 318
> ERROR: root 5 EXTENT_DATA[843064 45056] csum missing, have: 0, expected=
:
> 16384
> invalid dir item size
> invalid dir item size
> ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
> ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
> invalid dir item size
> invalid dir item size
> ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
> ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
> invalid dir item size
> invalid dir item size
> ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
> ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
> invalid dir item size
> invalid dir item size
> ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
> ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
> invalid dir item size
> invalid dir item size
> ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
> ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
> invalid dir item sizets=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (0:00:13 elapsed, 1297
> items checked)
> invalid dir item size
> ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
> ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
> invalid dir item size
> invalid dir item size
> ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
> ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
> invalid dir item size
> invalid dir item size

The problem is the invalid dir item size caused by that bitflip.

I'm afraid there are too many unexpected bitflips.

But at least you can try to salvage some data.

Thanks,
Qu

> ERROR: fail to repair inode 843091 name Sent.sbd filetype 2
> ERROR: root 5 DIR INDEX[843063 18] missing name Sent.sbd filetype 2
>=20
> ...
>=20
>=20
> I think it looped again.


--VDDJ5NzI0W1PbXuSuxeVkVzogxYT3rfvL--

--EezAXiWZyMW80LsE8IncCcbKklj145zQ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2VWr0ACgkQwj2R86El
/qgQagf/Wpw8b8Rq7hIKLGz/qqeKRA6j1nxdSwxgc3DNPWS6/6zQT5rxqgMhxzKg
Pq99F2wwwOyySFAKgsrShuN9KPfrn0+VrsDIsaYegXSKjuh24WEXI4vDxg67IqzH
fQr0EACCnDK7BDQF/nLUTdBMgGnAu3+so7AIUawSgxJTEAMsBfAteZ5n8hMOhan7
DcIP76jV5EyOQD0JsYEN/CvdkOwqzaBWipkEqlCi9vesdsH/CcZyY/63DfmcpE+Q
xyzG3DTro/9gcVFARekQkHPkMog2fwNjVj0FUGB4RNW377ccSeqRwzv99xlN/5hG
5WTniBOGpOJA7v0Dkb2ZIEsaX1EA0A==
=HjpE
-----END PGP SIGNATURE-----

--EezAXiWZyMW80LsE8IncCcbKklj145zQ5--
