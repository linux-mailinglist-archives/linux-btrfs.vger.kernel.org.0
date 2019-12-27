Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B1312B4CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Dec 2019 14:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfL0NVs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Dec 2019 08:21:48 -0500
Received: from mout.gmx.net ([212.227.15.18]:47479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfL0NVr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Dec 2019 08:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577452902;
        bh=pnviNDuBx4iPFanl/Bi6mCz+S7baY6uxkbWZma3W/ao=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XWtXOWfGcaqhmHgQXcb7Lt7auoA1eGrhxnm03pR+j+Bzl6wbLOVIeIDpXzD/CSwZL
         3/k6aCY+XxfA8/g//VCElcPdcyNDbjUKL4TMnYiwRdAYkQZ/vB//cc0aX3qOG5WeMQ
         vZsUtM9MnNvvSiZzJtzTxCPQvlhB6fW2D9DtlDgY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mn2aD-1jRccU1Cxr-00k849; Fri, 27
 Dec 2019 14:21:41 +0100
Subject: Re: Error during balancing '/': Input/output error
To:     Michael Ruiz <michael@mruiz.dev>, linux-btrfs@vger.kernel.org
References: <4196932.LvFx2qVVIh@archlinux>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <c1b81526-5d18-4cd2-563a-0cbca83123c8@gmx.com>
Date:   Fri, 27 Dec 2019 21:21:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <4196932.LvFx2qVVIh@archlinux>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fRsiRrCZqMkPq2vahKgY1SDQFAfN77nav"
X-Provags-ID: V03:K1:XFG1GbQmn0k14dyEb/DrUqWln3GH3SVrUACWNpNEHwhBZ7STQie
 DcYNe5DumeiKCShfqlkYiqTzFWhbzf1pv83iR1ROYIJc8E8NmEAWF/VkP5MMl1y15bHyz/A
 SNufdhM5ce0idMd4tbJHbAWG+G09QYGcoV+uUq7XVKY0LKBumCK46wDWKk9BQVLlXuW1dFw
 7mMToSRg3T/Mllhn5+8Dw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qaYQnFTfIbY=:XC+nOyOz1UVZHZBXCQtTjX
 cUkn0Q4W0JXxFOkIguZ/bMJh+xxzxLhPVA5Tn2YnnGUsJP7teYMdEcrlWH70PDnnQfd8mFd3E
 +AnbVtp/LH/9KQL9XoYUh/TpAQLz6L0+1GGw5uvB0Qbg8D4Jm9aqGJIAdlRgAbqztrEP8lBRi
 d6e8G2NMLmPH4RctQdBzSem9KY/ga3zwwd9Ca2trtZkX2wtjUM0DJ+iZny/P9oZJeDsVcp+Ht
 fHygKmzT75N8UZaGox3Hhs4v+27AYqW1TxXoThootaRkNa7SHuDCDXRyyuj8QAxlK6F6zxdyb
 MrgjuMuaVx398br33B0Isdt+cxmpcdjMrZIMe0ay6LjkiWgZrwp00q+dsUYTkh2/A7c6+Yn7g
 iPA+XhZaZxIahHdM0BWyjBT/uY5OT40hGPSPV+hYApBph4i5zfcC94AoaNMK0dc/AWP1Nrnav
 2BA83SD0X9LThROZ4NbZXBi32Bz2tND7B7OIuiBvaYG5TEE17Kyp4QUMR+7Ln1Oe3Oc6Jh0lQ
 MkaPsbxdQkn/OafbqBNMj5AqU+UtAfaNJamuVQTRpg+yyOjKenfsuvaSlBW8g3ZEyohY9+vKk
 YMI5ApoYNhqg627Sx6AaMLv6f0MwKXms7Gbxe/nYav9NXFjou5Dzs3t3aM0z5fc4fT/nnAT1/
 ZZzEQNs/Um8kNN36nkToJmKNoIAYtQ9cgzgcDDt39GE2YM9XoKbtt8lbiNSfJQOe3Xt5Ak1bv
 YpFotp3K5v4zC7XSkuYJ1M5pfgIouAbBI83lMFYFVWxq/66iVJ0M7L9ds4DiS0Cwil10FWlNG
 bTOaquQCtO0qR/tx5qi3oWnu7pH/fhfu3RFwPnRGMptEd81/FJdBO5SLWkHK3VjYD/GNiKN9b
 YdcS9OjjIZiCcDSRb0OYJ31c0LUWo88gHp/VBbznMNgmewdCkt0KIMUizmswE5NmJzl3Vi7mC
 Qx/GJkMjtu2aKDp3gdcw4ls1bxZJJZUMCcxjebjFMaslQ6S4SD26FFdlClyu8UY8+myXGhzht
 BBqVsx6eJmqqJdAtBBxPqlz399GShhw2hmc9yhdM5MvtzQaj64qty9wm4UzycD5qAayXLufJt
 AnIcYau+K2TfgPWB2Md/yh9Hm+r0noRwJIwwAoWndTLjojXLYktBS96BjC7QITl2DXWt5hA38
 3WaJh/seHfrpWAfK1oUXGZCNw1PtG0P34r3zHPwdox/h57XNKSVjKFi1oxZHL0yF2M59XPq/3
 LPX70kXffSkLYkASxY8M1g6UwYBdhvGM6K9qbD1V7FXa7/ZK7E6wf4IyBvqQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fRsiRrCZqMkPq2vahKgY1SDQFAfN77nav
Content-Type: multipart/mixed; boundary="765z5gzsLKrzUTO2rqReGnrNtnH6AqScd"

--765z5gzsLKrzUTO2rqReGnrNtnH6AqScd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/27 =E4=B8=8B=E5=8D=888:39, Michael Ruiz wrote:
> Hi,
>=20
> I recently did a btrfs-convert from ext4 to btrfs and it went well, so =
I=20
> deleted the ext2 'home-backup' or whatever subvolume it created and I=20
> proceeded to balance the disk. However, I keep getting this error when =
I try=20
> to run this command (see bottom of message for debug info.) This might =
be a=20
> simple question, but I am worried that my root drive is corrupt and if =
I=20
> restart it might not boot so I haven't tried rebooting and mounting the=
 disk=20
> from a live usb. Any suggestions pointing me in the right direction are=
 most=20
> appreciated.

There are quite some reports about this problem. So far no real
corrupted confirmed.

You can confirm it by scrub.

I'm afraid there is some bug in data balance code which leads to this.
We will dig further to pin down the cause.

BTW, does that problem always show up at block group 253562454016? Or it
randomly shows up at different block groups?

Thanks,
Qu

>=20
>=20
> Thanks,
> Michael
>=20
> ``` BEGIN DEBUG INFO ```
> [michael@linux /]$ sudo btrfs balance /
> ERROR: error during balancing '/': Input/output error
> There may be more info in syslog - try dmesg | tail
>=20
> [michael@linux /]$ dmesg | tail
> [ 1235.433416] BTRFS info (device dm-1): relocating block group 2657091=
58400=20
> flags metadata
> [ 1375.701515] BTRFS info (device dm-1): found 65034 extents
> [ 1381.270271] BTRFS info (device dm-1): relocating block group 2646354=
16576=20
> flags metadata
> [ 1483.628290] BTRFS info (device dm-1): found 64995 extents
> [ 1485.160174] BTRFS info (device dm-1): relocating block group 2535624=
54016=20
> flags data
> [ 1485.352336] BTRFS warning (device dm-1): csum failed root -9 ino 265=
 off=20
> 1048576 csum 0x9a7afaa8 expected csum 0x63e15594 mirror 1
> [ 1485.353008] BTRFS warning (device dm-1): csum failed root -9 ino 265=
 off=20
> 1048576 csum 0x9a7afaa8 expected csum 0x63e15594 mirror 1
> [ 1485.375271] BTRFS info (device dm-1): balance: ended with status: -5=

> [ 1485.544838] audit: type=3D1106 audit(1577448716.970:152): pid=3D4178=
 uid=3D0=20
> auid=3D1000 ses=3D1 msg=3D'op=3DPAM:session_close=20
> grantors=3Dpam_limits,pam_unix,pam_permit acct=3D"root" exe=3D"/usr/bin=
/sudo"=20
> hostname=3D? addr=3D? terminal=3D/dev/pts/2 res=3Dsuccess'
> [ 1485.545220] audit: type=3D1104 audit(1577448716.970:153): pid=3D4178=
 uid=3D0=20
> auid=3D1000 ses=3D1 msg=3D'op=3DPAM:setcred grantors=3Dpam_unix,pam_per=
mit,pam_env=20
> acct=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/d=
ev/pts/2=20
> res=3Dsuccess'
> ``` END DEBUG INFO ```
>=20


--765z5gzsLKrzUTO2rqReGnrNtnH6AqScd--

--fRsiRrCZqMkPq2vahKgY1SDQFAfN77nav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4GBWEACgkQwj2R86El
/qijeAf/d8aFOYAFlxAllJG5Cc+JrzB+T6iYTtoWaRIFWT+cpSOzFz2zkyjpGuSX
izA3Pa6N4BzFSdi2poIuTgO24lZ+eNyUpLtXfv1vOP03HFY6DT9I+cconNMDKmHI
v9f5gBIKMPewWnA5Zb7xjE6sXkTjRCR6pfjG2NXDhIyuCFZVKpYyDTN2wfsgxvbT
T2XeR+Zx2Mtdm8j623dxZeBhGcLFAnoaFth1Jx9CZ+QTVDQLYVvQKnGGbgyPQyAi
60zRruvfc3uyiDJ/lEShihBIsg3B6QslEcRYbVJn3HfFOv+XFXHidFXY8V6/YKNV
NLba3fHQ2K6ZLEusgHzXcG5bAU9szQ==
=D9MB
-----END PGP SIGNATURE-----

--fRsiRrCZqMkPq2vahKgY1SDQFAfN77nav--
