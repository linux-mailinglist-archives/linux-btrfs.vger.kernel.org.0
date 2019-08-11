Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5067E88EE1
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2019 02:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfHKANW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Aug 2019 20:13:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:58361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfHKANV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Aug 2019 20:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565482398;
        bh=GeH2RydFT3zBL7o+bis3VITwsDYfxPoXHrgUTOCxEKg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZDZ7qyGHMOnzQAKHoFuyS/B8kIhR8dxGwPQObfaS4tcty8+bG5E1JrTAS6jo7OMrn
         Pl22zl6VqlPDCeOLPBa3mgbvltEKOkTnO+rA28N2jQ0ofXnmbxgbTh9AGX5IUJGL1y
         B5VtU/wxQem7Q9LD8KYqCe3uwMUHWsRGWdsGyPcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5QF5-1hvDuC35CX-001PY2; Sun, 11
 Aug 2019 02:13:18 +0200
Subject: Re: Mount failure with 5.2.7 but mounts with 5.1.4
To:     Peter Chant <pete@petezilla.co.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <9240f2ad-905d-533a-8bb6-55af0aaafbb7@gmx.com>
Date:   Sun, 11 Aug 2019 08:13:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BHQeBqOwqfA7xZzzUtcYP4NYuWXLU6TxJ"
X-Provags-ID: V03:K1:MJqsbdudPCU5YR0wewCt0lM1Zsz1l3SwCS8vUfqrFs4EXSf7xe9
 iBN+NZCG+BOo681g8qUQXYD7RoGjQErnTv6nZ+95xf6aqXldH7PAfARA9cnW/LKaPyBrPa/
 tqwOI90oQUuod8J0vIO1A3qGEwpXnmZlAYVTZM2DmZB9MPaqqRRWqoV4Pz0TUlNv0I5mLgo
 lSSJ5OZzhXyVojmReX3KQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lyyqTbiYlao=:Ig++iD/KtHSN11tlkQS5F1
 /L+8UsG4mw9+OzrgQG66vpiPPS7mTHWttQM8MkTgqq5K5ENbWX80UTq6+aEUK4ZZ11pw9XY7u
 rCe7aPAYnoZBCTOHUtP+csG+Jda23ctKPHC8gbVj+Zg2iVerdTMd4D8els0ztBcUPmN6GQlvQ
 RezjqhdOxcWa/UdmwpPeXyD8ZTSW1BczaepAbjoVeVIU/x2G4X63ZGTJEkw+HmncssW6rfbCv
 RzTe2eHiBcp4L06EAYG9s3YJCVjAmg/WMydifVrFNaWobc0+6pT0JYHh4DnYgyUCU0pvH1Z0p
 LaSlX4NjZBzKQrIWlpXFv9Oacje7W1NLZy8cxjladJ9GIKd2THygA4H/VBkd1ELfeL1eoP3p+
 1an3OYu/bsviI17ewEAoyQAy8KEHeldtIulBvZ6s3IxiKj1n1e6lGnmvFlWQCj9A3WzU2REm5
 nQfmQgwNPWaI2CbVGoZYvI3+bWXNAgp0ItgImuPCJBFjEh+yjXyGwR42NpAIWe002vo1g6X97
 2YtmBvGgJ5n4IfA5OfZAyULRVb6M/+9vTf5L54azcgXwVai6LrTiPJ2e/l6exdd5PwFaUczNA
 MwRJdhbIWhWyq+X7EPo3Hv/e5c3kQUVn5SwnMB/+k21n3VODHLIVklk35q7A26CejIWuHQZ65
 DM8IGg1CoazshB6zxroVdk60+Av66Sw7ja9kRIqnWrQvT1lqUVKGW/LlJD6DZ0o0vVWe4GIld
 zw0EKAoA6OAGVvkBLlKAKbKZs1vCeSMgQ8Hdk2yQjlWpMJ2rDceTiacdr4t4htkmdYsUmS5bA
 X0KlR7yPgTzgVD0GqkZa5qnwuBhkLGt2LXKlZwRpk4VB25dtuYzx4+mKWNvDprJre7ts7+54W
 y7TPCfuHY1AoqjSaYPr4NvWIFcAz5U63pDiovmHj58LmQBjEo3QqmMAys79XhwFXYQpmLtdNY
 UUbZdfr4ioQeMnANIJ9hw0hX1sfOWzszfj+eaWxngzV3di8i12aJAPi0DosPqj8dIWAroTsC7
 UW8cIZ1jH8kNLjQX35LIVkYpuxoOI3OURLjJYsm2u1FT5EqmrIHVZH8kLtm//1i78ch/IBxpu
 QoP3ok8qG2LwZGCF+PbQ59qFfdvAJtdjVd9s1KoYfB14pKRk8W1q/Eq9g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BHQeBqOwqfA7xZzzUtcYP4NYuWXLU6TxJ
Content-Type: multipart/mixed; boundary="gg3YbgoK7GujaWMjpGmX2mPCEH9rqDXDk";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Peter Chant <pete@petezilla.co.uk>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <9240f2ad-905d-533a-8bb6-55af0aaafbb7@gmx.com>
Subject: Re: Mount failure with 5.2.7 but mounts with 5.1.4
References: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
In-Reply-To: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>

--gg3YbgoK7GujaWMjpGmX2mPCEH9rqDXDk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/10 =E4=B8=8B=E5=8D=8811:54, Peter Chant wrote:
> I attempted update an i5 machine today with kernel 5.2.7.  Unfortunatel=
y
> I could not mount the file system.  However, reverting the kernel back
> to 5.1.4 allowed it to mount with no issue.
>=20
> This issue is not critical to me, machine boots with older kernel, I
> have a backup and the machine is only lightly used anyway.  However, I
> wonder whether this info is useful to anyone?
>=20
> I have a spare ext4 root partition on the hard drive of the affected
> machine, so I booted to that, with 5.2.7, and got the following behavio=
ur.
>=20
> dmesg:
>=20
> [   55.139154] BTRFS: device fsid 5128caf4-b518-4b65-ae46-b5505281e500
> devid 1 transid 66785 /dev/sda4
> [   55.139623] BTRFS info (device sda4): disk space caching is enabled
> [   55.813959] BTRFS critical (device sda4): corrupt leaf: root=3D5
> block=3D38884884480 slot=3D1 ino=3D45745394, invalid inode generation: =
has
> 18446744073709551492 expect [0, 66786]

Please provide the following output:

# btrfs ins dump-tree -b 38884884480 /dev/sda4

I'm not sure if it's an really invalid case or a false alert I haven't
found.

For the workaround, just like Nikolay mentioned, reverted to older
kernel and remove the inode by:

# find <mnt> -inum 45745394 -exec rm {} \;

Thanks,
Qu

> [   55.817296] BTRFS error (device sda4): block=3D38884884480 read time=

> tree block corruption detected
> [   55.817342] BTRFS warning (device sda4): failed to read fs tree: -5
> [   55.834802] BTRFS error (device sda4): open_ctree failed
>=20
> /var/log/messages:
> Aug 10 11:59:05 retreat dbus[903]: [system] Activating service
> name=3D'org.freedesktop.PolicyKit1' (using servicehelper)
> Aug 10 11:59:05 retreat polkitd[975]: started daemon version 0.105 usin=
g
> authority implementation `local' version `0.105'
> Aug 10 11:59:05 retreat dbus[903]: [system] Successfully activated
> service 'org.freedesktop.PolicyKit1'
> Aug 10 11:59:31 retreat kernel: [   55.139154] BTRFS: device fsid
> 5128caf4-b518-4b65-ae46-b5505281e500 devid 1 transid 66785 /dev/sda4
> Aug 10 11:59:31 retreat kernel: [   55.139623] BTRFS info (device sda4)=
:
> disk space caching is enabled
>=20
> uname -a:
> Linux retreat 5.2.7 #1 SMP Wed Aug 7 23:53:42 BST 2019 x86_64 Intel(R)
> Core(TM) i5-4430 CPU @ 3.00GHz GenuineIntel GNU/Linux
>=20
> Rebooting with 5.1.4 showed no problems.
>=20
>=20
> A very similar kernel, with AMD rather than Intel processor options, is=

> running on the Ryzen machine I am typing this on.  I did have my hdd
> file system seem to hang, but not sure if that is related.
>=20
> I have not tried the intel kernel on my laptop, but the laptop is a lot=

> older, as it is a core2duo.
>=20
> Seems a bit odd to me that 5.2.7 should show such an issue but 5.1.4 be=

> OK with it.
>=20
> Pete
>=20


--gg3YbgoK7GujaWMjpGmX2mPCEH9rqDXDk--

--BHQeBqOwqfA7xZzzUtcYP4NYuWXLU6TxJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1PXZgACgkQwj2R86El
/qiuXQf/Sd4WV+fSZuJQEWcop/xR7EBaw4KD71/qTssGA85Qgxyfm4UhLYML+NP7
AGTSs06g2vDCb6emT6oiD2LGEYUvFu3ppqEamNSXABJrcV1SWumW1XQhwlYec3Hv
fRgEX3Kj4XQrFWICwHxEULEyzM0fVCw1JCpjR11UNI+KWBNUpnye1SBAK9bqquCt
pwuvl/6roxKFAkqSbMLrxKcAl0ixzT5gQ1pweSruNBxrs3wzgXzLc8vXoYPZA0H3
Mv7gfuknBaSNFYu5Eh8SfjCEJ+hv3wVKpfzBrLvkBtNlTv6nb14rY5QehtoaQ77W
iPUIC63flYhoUDGJhOGqfSoW3GT5dw==
=UNm+
-----END PGP SIGNATURE-----

--BHQeBqOwqfA7xZzzUtcYP4NYuWXLU6TxJ--
