Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA77BAC25
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 02:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfIWANw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Sep 2019 20:13:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:39837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfIWANw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Sep 2019 20:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569197621;
        bh=ffJQ19qL4QCGHbXRDhmVE5C/ykzSeDbwYvSfEfWI9gE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=d3rqbeg7k3b2E0+d6dC6lSMSMVjaqOLL7LuKkJyWOhW8LIUhw4jXRafEhHl83+m9k
         h/Sx/S9beKL4CIN3DXOs/51s03Dodb7jZw6sO84ehNbUOV0Fd7sIKUq15MJAbdaYyU
         yucXdfY8dxEyPU+OP0oyH0O+7ecqRKOgy/OY4sns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GMq-1i83Do32X2-014E6w; Mon, 23
 Sep 2019 02:13:41 +0200
Subject: Re: btrfs filesystem not mountable after unclear shutdown
To:     Kenneth Topp <toppk@bllue.org>
Cc:     linux-btrfs@vger.kernel.org
References: <e9073c1dc608dc8d50ee8d131bc86887@bllue.org>
 <aa88fe5f-51f9-cfca-6193-cc2cf0d3ead5@gmx.com>
 <cae0f117bd93af5df07f5f1604eab32b@bllue.org>
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
Message-ID: <05d97a5a-248c-c11d-dc40-3aea877b2e91@gmx.com>
Date:   Mon, 23 Sep 2019 08:13:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <cae0f117bd93af5df07f5f1604eab32b@bllue.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2bJ3VpD3ihCUJ2ohdOMisGRXs7z9F2jDY"
X-Provags-ID: V03:K1:bOBrSWhW9ASpOLUjbshyOaVdu7Umhug1X342Zgd62XlkJAQLQP4
 kuBNQyYlXQuOMqrHLgVaWSmDUgQdavu88+bWgPiT4ZGwe/fIjOi1H5YUq6YLUxHUlGY6LXM
 gZBM2Z6jTxv/z17Wki/xp0GB4+2mevE70y7U54Nck6uB+FHHRWmk42mmAqhvEf/xeMBJqHJ
 2OkY/mkJp+TKU0KjfbNzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8M9C+H0HU2w=:Im5OedccplAMupRV+wclgn
 o+xmo999U20EUqAWIri9eZZH39+QzyV1CgK66tXDCMjNRuHdQMOXOOqsfcC1TQSAlyBG2vB0N
 JmvXWuhlipvDxe6/DF6xn8ysuXNIyEtfMU2ZBR/TwbhgCqVjRSSQR9oJBo1XAm6c2wnOJV2CJ
 MkUYXssV6BoSYU62Hofb33bAvvszdSfyfCWWX94wXIPnKRz5HMIqXcYJXjICWYgqyi951thdP
 fLXHYsiTyi45WgFVZ7bMuDDMljBKKxVxJMoGTV/pUBD+fH38bA2I0508pYk7/AfE91OwU8CnC
 KKVu7vIX0fTepyq2o/QltP68DgK2ocYgjIfYOJBXApPCfHRLpG1rw1VAXx2rkliLFy2Pm1OO6
 D/dozwew77fBz9LgSt+aU554L3L9jhGl8AN7pgOd/pVrUL4FYLQkR7UsYYCTi1Yv+qdjGsMJF
 YfWXgAdMACtgczIDTFjZXRhbRxvwRp7tIh74/LKxh6+ejAV6t4dx2dOjjISpAmLtR97MzPiF/
 9ftRkOoIIq6/IndbQabuU29MMeNIxq1G2nUVrEWj7co8j1JOlb4N4PfftJkMDBFhdVJY9HKSi
 FuXDUMqsE2iNgSephXW4sSYuPIWU+FnhJ0dJZow0+xQqpWa7D5535ZbsqPvRtuvGk5/92rXuf
 V4mcT6e/W75iaZ7J5jBIJhkujBVojP2IPuniHRVENJcybjA69UoohdE8E/jIF0TzIXNwIOvAO
 /TOlOwHy2DRX0Pt9mwwN3vITL7qzOGNUPgfgs95RuGEXDS1lt/4aoq+KhbmD2wed/z+9c1yt5
 T9pm1J+sSeL3xyNwhXoDlDqweQVSH2LGxoqSSeVM4wRpeW6Ssf15o5ykJnh/MmSzAuMbemLI1
 5Qfa1dsaOw+X8WKKMiihApYh28pgxq7KcMusjqzvf5S1+/Q6aYlaG3Sr/r+KOaiQBTOX4TgUL
 Myuf27ca4BB+WcVxHXeKgZnaf/XmIWvjwb6kuEJ8/tmv6iPBwTOx5BLB6CWvS27UHMkC9mFwp
 fmO1fBCl40n//PeCAtKUOT8XxOESEGRgXI3BTC8EFv+nhqmo+Vwldvx+B/qAaKYOga8TilaN+
 i4Mkj99AC1x5Q0mhKb/I+2zd5RTlQaDxqYoYRnJYcH+b3SMAgjjDAxHqwx7bnX0S7XQ8vVjMd
 pzufd4fSu3iiJuuuoTzfZsGR8hnkTamswFzseNrq8Lw91XYTVx2k+4xQQvRh12TciHl19N1Yt
 7bQWcDEHzmHuN1te485T4R2MJgWt0tq1vlQFP5shs5wU0cJBvAJ/wHtzhrm8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2bJ3VpD3ihCUJ2ohdOMisGRXs7z9F2jDY
Content-Type: multipart/mixed; boundary="ekyXwH2tJYxGP6VY9dVE7Qx5jkO7tIsxa"

--ekyXwH2tJYxGP6VY9dVE7Qx5jkO7tIsxa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/22 =E4=B8=8B=E5=8D=8811:09, Kenneth Topp wrote:
> On 2019-09-22 06:02, Qu Wenruo wrote:
>> On 2019/9/22 =E4=B8=8A=E5=8D=889:12, Kenneth Topp wrote:
>>> after a couple unclean reboots, this filesystem became un-mountable.=C2=
=A0
>>> btrfs check didn't help either.=C2=A0 This should be a raid 1 metadat=
a/raid 0
>>> data volume.=C2=A0 I've had this filesystem for several years, but I =
think it
>>> was after any major on disk options.
>>>
>>> I tend to run a current kernel.=C2=A0=C2=A0 I got to 5.2.15 quickly a=
fter the
>>> btrfs bug report, and just was switching to 5.2.17 when things died.=C2=
=A0 I
>>> still have these disks as they are, but will wipe them out tomorrow a=
nd
>>> restore from backups unless someone has any further diagnostics they'=
d
>>> like me to run.
>>>
>>> On a related subject, are there any tips for creating a new filesyste=
m,
>>> I think I used to specify "-l 16K -n 16K" during mkfs.=C2=A0 I'll be
>>> switching to 4kn soon, and but currently using 512e, any notes regard=
ing
>>> using 4kn disks?
>>>
>>>
>>> here are some diagnostics:
>>>
>>> [toppk@static ~]$ cat btrfs-failure.txt
>>> # btrfs filesystem show /dev/mapper/cprt-47
>>> Label: 'tm'=C2=A0 uuid: 2f8c681b-1973-4fe6-a6b6-0be182944528
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes u=
sed 17.16TiB
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 =
size 9.09TiB used 8.65TiB path /dev/mapper/cprt-46
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 =
size 9.09TiB used 8.65TiB path /dev/mapper/cprt-47
>>> # btrfs check /dev/mapper/cprt-46
>>> Opening filesystem to check...
>>> parent transid verify failed on 6751397658624 wanted 2012643 found
>>> 2012295
>>> parent transid verify failed on 6751397658624 wanted 2012643 found
>>> 2012295
>>> parent transid verify failed on 6751397658624 wanted 2012643 found
>>> 2012295
>>
>> Well, this transid mismatch looks exactly the bug introduced in v5.2-r=
c.
>>
>> Kernel mount dmesg please, it would help us to determine which tree is=

>> causing the problem.
>=20
>=20
> here it is.
>=20
> [ 2470.719919] BTRFS info (device dm-9): disabling log replay at mount =
time
> [ 2470.719921] BTRFS info (device dm-9): disk space caching is enabled
> [ 2470.719923] BTRFS info (device dm-9): has skinny extents
> [ 2482.112442] BTRFS error (device dm-9): parent transid verify failed
> on 6751397658624 wanted 2012643 found 2012295
> [ 2482.124103] BTRFS error (device dm-9): parent transid verify failed
> on 6751397658624 wanted 2012643 found 2012295
> [ 2482.124112] BTRFS error (device dm-9): failed to read block groups: =
-5

Extent tree, you have a high chance to recover if that's the only
corruption.

If you feel like to salvage the data, you can go btrfs-store or the new
rescue=3D patchset (not merged yet).

> [ 2482.163205] BTRFS error (device dm-9): open_ctree failed
>=20
>=20
>>
>> But please keep in mind, we can only salvage data from the fs, not
>> really fix it to RW mountable status.
>=20
> I have good backups when the filesystem was mounted.=C2=A0 If it is tha=
t bug,
> should I expect my backups to contain corrupt data?

Normally not. But you can always ensure that by doing a readonly btrfs
check.

Thanks,
Qu

>=20
> Thanks,
>=20
> Ken
>=20
>=20
>>
>> Thanks,
>> Qu
>>
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D7267733438464 item=3D33 pa=
rent
>>> level=3D2 child level=3D0
>>> [root@static ~]# btrfs check -b /dev/mapper/cprt-46
>>> Opening filesystem to check...
>>> parent transid verify failed on 6751304908800 wanted 2012643 found
>>> 2012294
>>> parent transid verify failed on 6751305105408 wanted 2012643 found
>>> 2012295
>>> parent transid verify failed on 6751381258240 wanted 2012643 found
>>> 2012295
>>> parent transid verify failed on 6751397658624 wanted 2012643 found
>>> 2012295
>>> parent transid verify failed on 6751397658624 wanted 2012643 found
>>> 2012295
>>> parent transid verify failed on 6751397658624 wanted 2012643 found
>>> 2012295
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=3D6751265570816 item=3D33 pa=
rent
>>> level=3D2 child level=3D0
>>> ERROR: cannot open file system
>>> [root@static ~]#=C2=A0=C2=A0 uname -a
>>> Linux static.bllue.org 5.2.17-200.fc30.x86_64 #1 SMP Sat Sep 21 16:13=
:27
>>> EDT 2019 x86_64 x86_64 x86_64 GNU/Linux
>>> [root@static ~]#=C2=A0=C2=A0 btrfs --version
>>> btrfs-progs v5.2.1
>>>
>>>
>>> Thanks,
>>>
>>> Ken


--ekyXwH2tJYxGP6VY9dVE7Qx5jkO7tIsxa--

--2bJ3VpD3ihCUJ2ohdOMisGRXs7z9F2jDY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2IDi8ACgkQwj2R86El
/qjqbQf/VaTCctP7s+wVudS0uem9SScQv6YmwXsVFOsG8KisZCofpwjl9tjw+RcV
HSstpV8+K3IFT6Dg+wK4W/tyvpIl92lXNL1p3wew3NwrpGjPWtl0Xg2cpSQKtUmK
CqLItvO07VJkqwq4Yy/CfeaK1lw/uFFXtp/w/2EAiM4mVISRpiSqJN9s+B8XhJ3F
kNENsHgEMvc02H+zW89fshTUX0A5sKmBxLBhWmA8KTmvzxil5bq1XTJJGrQ722vL
eUmEji1DYHAY1gT4Y9O6B5tVIcCJmVu1GR2ChfQIf1+fLasLkKQdyuufVzh+c+pP
0gg/D9b26pYjerLUhUezd5MsNPkKdA==
=yL0y
-----END PGP SIGNATURE-----

--2bJ3VpD3ihCUJ2ohdOMisGRXs7z9F2jDY--
