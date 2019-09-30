Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12FCFC1B70
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 08:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfI3G1n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 02:27:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:45163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbfI3G1m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 02:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569824860;
        bh=KeIGpCm561Vjc4yiDOcl7ABzyufwdK5Y2NpA9n2/kEA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QHkCUEeh6FqmoOuwrwiYrMqtun1vsVMH/pbEGaV3azi+af4LLcCNlAlNX82ESpod/
         5Wgw7S/Ph0CmW2w0w5w4kzqk1yhYv4c3aa5M1lGGxQwtO2wafiO1LRUKurlLlhCFai
         A9Q8RiEFrtbrw+fsNzQ8KWJhBE+1gQan0tmcI09g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0XCw-1htsWU3YYe-00wSD3; Mon, 30
 Sep 2019 08:27:39 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
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
Message-ID: <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
Date:   Mon, 30 Sep 2019 14:27:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GjQ53AyFjuTQhVJPa5c1Hx2EK63UUWe4z"
X-Provags-ID: V03:K1:frXOigVJKDnV4qQxFu2kgyD/bqbhcD8kB9pbS8V5RuIFC+h1ubz
 mht+47gKttEL4hLHFnCPpi5avNX2eNf6Uw/0Hb83DgFfi+jpCDKYFoIfxZKlEJwGImrwJ/v
 yssAk7RhZsgXssUC4+EN9MwZ7N/e5ZTYEKZ8ojFh+VVxCawSRA6Xy1+VPMtYEJTMt2Cx7fC
 mJVqGf45d+aQD1S0NStVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M5fPzmYTnCU=:nyVyXXkyv4ihti09aOZmZd
 rfqyb7mHX+dFWXTURdukbPDfthJ6NNBbY/+KLtjZjHQPeZLt6lu2g4fZMO+/p+igFPAmnYUDA
 j3UxYTdGRd9HLXRtw4HZHmRdoCO8oVDM+BmviO6qeUrr/0g7/j+F9RGh0Cnn1iQ1lZ8rY6o/W
 RmlQziBRjZ2UpxFd65f7u+5XBO05JAG1g1HpckizMzsUhnP9gSEbzhR2+M7NEOs2zCKYJ4QeU
 ZW9+ZsKjl9n5bY+xQ+uI4GFZwSQLbKSiPE1BB51USPKKoAv/e4sfxYkA+Gvt3wX9HLO92FWDh
 P1cb3AMUo7MjHGMktTsBg0uWj8x1+7OAoIJLAi0MJVpDC6XhTR9GuRohPGg4D5mlfTMchi0J2
 H3aLFl4LWl0CdLi47WXVAr14qd1Ca/K9E0WKhLe11VZ4iS2xZ4+ig7J9KbByfOcDbDdye42iS
 BmXsuspQ39jF5spPEnVqyZwoIoGR2AsYw1ywVqir0AxSJuXrQyH++ASibEbopqp6j2R32igTe
 71QlbzfGgeKO+WmfMQQw+oCGeV2ySr0jrSfVOK1ZE19p84k57zbHcHfFYeytcydkQmCEhjdyL
 GYqPzT5hV9Bw836upUrbP4bN93CTJxrv5tcR6iHJfxnVJ23jybNQYNI0pLtwMmMf09mOIUChk
 dbn9fWeRIURb2ueNx/lX+OE4m8ZFQdLejfntbmc9dLdU6n+COsb/BTzzw1bZGKdGhq97IY2vn
 MRxa2derClZU9XHRp/z6hJw3qqyDjEAbqlLXuBYoawbvDwp7gbzS5p0psVU9fEsxhxnaDgb/N
 7Hk3rISevak+HFN/huBy78tc2usZXp+djyGEB+RHOUyPxzaXCjFPtCFkD0OnoS0BsUzEgIAnS
 igtIg83utIoeH+s5RqKOvYhkmJCJYAMLWzx7RgD5MVYYzZ5RKU8qafKiTPvCkvXp5dYybVPOB
 yjfNaOslhJP5jhPe6diM7Z1EL1PRsdCnRdEE7dG/N5KZCupwg817JhO+ZO0i+FKuUqi9+S2xk
 4d7FvjUKRTi7DbllrwxbCNuPGM4pFgweQc4qiJM7P+wTiDCh89d14RMa+3iHY+49T5eBB+iwr
 4ACrBTkAkSJoWCdphHug6Fc81cv0JL0YO1IHKDkXrcaqMaB3LZzRlQgjGybr0NuBpH2DNs3tk
 +E7EPrsYAk0IszUtT0vHgZUaE3ERGdM4l/NHNyGf6l+HBBTolhIGJkcMLoKeG9zVfGnSdom2d
 ucavkmZ18LV0/itsZBBobFmyhWAW98g/1MRnGrKMAISGYOciyxxCTkNX8n9o=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GjQ53AyFjuTQhVJPa5c1Hx2EK63UUWe4z
Content-Type: multipart/mixed; boundary="2guzk2A78MrpVOzl30g5fqTBgZqUSZHKj"

--2guzk2A78MrpVOzl30g5fqTBgZqUSZHKj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=882:14, Andrey Ivanov wrote:
> On 30.09.2019 7:53, Qu Wenruo wrote:
>> [[PROBLEM]]
>> It's invalid DIR_ITEM, as the dmesg shows:
>>
>> [=C2=A0=C2=A0 49.479561] BTRFS critical (device sda4): corrupt leaf: r=
oot=3D5
>> block=3D134079905792 slot=3D0 ino=3D843063, dir item with invalid data=
 len,
>> have 256 expect 0
>=20
> This is the kernel message for /dev/sda4. It is also have some problems=
,
> but it is successfully mounted. I can't mount /dev/sdc1.
>=20
> Kernel message for /dev/sdc1:
> [=C2=A0=C2=A0=C2=A0 6.503265] BTRFS info (device sdc1): disk space cach=
ing is enabled
> [=C2=A0=C2=A0=C2=A0 6.503266] BTRFS info (device sdc1): has skinny exte=
nts
> [=C2=A0=C2=A0=C2=A0 8.890135] BTRFS critical (device sdc1): corrupt lea=
f: root=3D2
> block=3D855738744832 slot=3D20, unexpected item end, have 15287 expect =
15223
> [=C2=A0=C2=A0=C2=A0 8.899635] BTRFS critical (device sdc1): corrupt lea=
f: root=3D2
> block=3D855738744832 slot=3D20, unexpected item end, have 15287 expect =
15223

This is from extent tree.

Please provide the following dump:

# btrfs ins dump-tree -b 855738744832 /dev/sdc1

This dump doesn't contain anything other than bytenr.
So it should be completely fine to share it.

> [=C2=A0=C2=A0=C2=A0 8.899654] BTRFS error (device sdc1): failed to read=
 block groups: -5
> [=C2=A0=C2=A0=C2=A0 8.906858] BTRFS error (device sdc1): open_ctree fai=
led
>=20
>=20
>> [[EXTRA INFO]]
>> Please provide the following dump of that tree block by:
>> # btrfs ins dump-tree -b 134079905792 /dev/sda4
>=20
> attached btrfs-ins-dump-tree-134079905792.output

Confirmed.

It looks like the data_len got some bitflips.

In that offending leaf, there is only two data_len and all are one bit
flipped.
Considering that directory is not that old, it looks like some memory
bit flip.

It's recommended to do a memtest to ensure it's not memory causing the
problem.

>=20
>=20
>> [[WORKAROUND]]
>> As a workaround, you could try to mount the fs with 4.15 kernel, which=

>> doesn't have the enhanced sanity check while should be still sane enou=
gh.
>>
>> Then find the directory with inode number 843063, copy all its content=
s
>> to a new directory, then remove the old directory.
>=20
> How to find directory with inode number 843063?

$ find <mount point> -inum 843063

In your case, it should be a directory with some files named
"filterlog.html" and "Sent/sbd" in it.

I recommend to do a "btrfs check" on all fses.

Thanks,
Qu


--2guzk2A78MrpVOzl30g5fqTBgZqUSZHKj--

--GjQ53AyFjuTQhVJPa5c1Hx2EK63UUWe4z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2RoFcACgkQwj2R86El
/qgXBQf+O7/lLyj2lrW+t3J70VHdelxtR729Te+OLiluBaZXFx6T2j59TSPZ5KJd
8hSoQ57gCTVvEcYnPaSf7Hw6ohB6d934vf8Pfe22MAkKj0yhdRHJWvJ0szLKYruq
2g3Mmoekw4Rto9Wj8fk1NOf6WMqy30Ks+yVX/++STpwWXxPRonDqBM+OFz/rtYYa
hSmgYzEQbNsKC39p5nEuFwQgjmovgkYThgAtc+HSxbg49xplyRDryL8wWlG5dD9R
3nz0384Ji5ltAyKQt7/UIsVKS6v0EbDVYBssvC5gS7fQaLYWQ/GT5XzBGbY1rHgN
mS/hb9QxJmfgM4cs7F/DywfCGtTd6g==
=e++C
-----END PGP SIGNATURE-----

--GjQ53AyFjuTQhVJPa5c1Hx2EK63UUWe4z--
