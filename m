Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2A912531
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 01:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEBXkv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 May 2019 19:40:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:34857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfEBXkv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 May 2019 19:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556840448;
        bh=Enx6vjz1EreRTYjVVrmgbyoo2hAagn3+bC12kZF0hq0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Dos5iFVnZ/I2taoZzPI2XtW3vEA8mXhMDFNWnl1QZBjPH7BoeKBwxQ8FmJyTQWf/i
         HUnW4bhx9U2mcyllVwfvGQnps3/8J3N1QVJRTC7I706D628t9Og76Vw/OZsSC5+ILi
         aZchBRlDroGcZ+Y033yxKSSc27En7OEdHGt+wsCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LedVG-1gylST15Vm-00qUoQ; Fri, 03
 May 2019 01:40:48 +0200
Subject: Re: Rough (re)start with btrfs
To:     Hendrik Friedel <hendrik@friedels.name>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>
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
Message-ID: <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
Date:   Fri, 3 May 2019 07:40:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wgbVmR9qKZq2OmunGyJtZs9V2jOLqkMXA"
X-Provags-ID: V03:K1:Raf5xA2c3QT7sxXxoRdP+lX/tayXO/mTFJlTAebb1zfWLxdeLMQ
 l6JccBFHbZD68Q77mwxAugejXEXxggLHdVItBufjLL675aK9r8f4+z2i1X3K1ij2qhMhJEB
 /qea1JuWe8WZMOVipeCnwGNEdUEjPvDNUoPIG+mCJrxznJuPjxQKVqTuyENBPkktNqn1bgs
 HQNsXLPYAS/0lf25fzf3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NX4fFprW6z8=:FuY13Q8MHtaar46j0fPM3r
 7+loxZ0ZVSPgTv6GqLDaUC0g+I4c/P1nx7NSH4RLlsATqnJvJ9xOeTWuoVZpV0u1GmZ1QlxlU
 sflAq323rVsMlBYN3fh8C02braCZ7PqhhZArNrBJWm+S1MI/hDaZKX/4VxcnLXn7cQI5PtiOb
 7AKjMwUxhgTyXGcF3JfZq3rcHMW654Zx/V/roZ4rjew2CiRPxsxC4YhU8xRJdNpIeEGk8t77T
 tTPOcYRFVFMvWzo/xeUXovdGoQjIZbGomL5lVC6P4QUg8VqtmFtb3l7DOjOPlNERMfwWkV4FP
 3uCM+ZdGmvJF8twBCFcxqkpfhfFryAFMVQQcsB4c14PQ89moyIzTZ4TH41p4h9kId41MFgb5t
 +oSVYTLfWV3GO89SWfE+zdhaF3uSfZz6lSkTWgC2Mi8JpaRyNbiiK6W6NEX6/XKlsbvRYY6sR
 Uz8FpRh7ehkT/c4z5006gqMD2i6hWn/emG1ZyoJXepxAKC7tM1DiIGjopyHGux/MZPj5Mc+ev
 UzvHWKDptN+Sl0v+5gsHL3YNhqSkz1JmUMosP5uJamya4coE1Wxlg94bRXYOftP3Fwm4SFJ7Q
 4wlt4pwjy/bsA1N4hM5CsUs7H7YcYUy9LAJtHZqmPTycZ6IHnRdzdvW3MSQ1dft5ypzoFSke2
 TlueJ1N9yvEZGyfvDtj4sDkYSLYd+Tv1uGcqPkCLw87T7T4fDPbrZi8cD1tNC6JJX3vVqiKO5
 jDfwFOxDEqsVxvQThZ7FHCo71hLgCOC75CKW5hkGPct4/2GQKX2+dSrKECXstRI54JoqLWqXU
 4oP/N3+EOVNDwfykQI9/Bjmvkhdrvw4OtIqtWq0QK5mCoaHW9Mmk4O6eiFx/fbn7tB32y7t38
 Zfv16MjF8RN0oeiwyi0jjasCbczG4XYr7GW6Yy3KQpQVqYjrvOm+G8cABkoG43
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wgbVmR9qKZq2OmunGyJtZs9V2jOLqkMXA
Content-Type: multipart/mixed; boundary="E4ZH2i6IFwmwE35Mt3Wfv1l4I72A7xcto";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Hendrik Friedel <hendrik@friedels.name>,
 Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
Subject: Re: Rough (re)start with btrfs
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>
In-Reply-To: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen>

--E4ZH2i6IFwmwE35Mt3Wfv1l4I72A7xcto
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/3 =E4=B8=8A=E5=8D=883:02, Hendrik Friedel wrote:
> Hello,
>=20
> thanks for your replies. I appreciate it!
>>> =C2=A0I am using btrfs-progs v4.20.2 and debian stretch with
>>> =C2=A04.19.0-0.bpo.2-amd64 (I think, this is the latest Kernel availa=
ble in
>>> =C2=A0stretch. Please correct if I am wrong.
>>
>> What scheduler is being used for the drive?
>>
>> # cat /sys/block/<dev>/queue/scheduler
> [mq-deadline] none
>=20
>> If it's none, then kernel version and scheduler aren't likely related
>> to what you're seeing.
>>
>> It's not immediately urgent, but I would still look for something
>> newer, just because the 4.19 series already has 37 upstream updates
>> released, each with dozens of fixes, easily there are over 1000 fixes
>> available in total. I'm not a Debian user but I think there's
>> stretch-backports that has newer kernels?
>> http://jensd.be/818/linux/install-a-newer-kernel-in-debian-9-stretch-s=
table
>>
>=20
> Unfortunately, backports provides 4.19 as the latest.
> I am now manually compiling 5.0. Last time I did that, I was less half
> my current age :-)
>=20
>> We need the entire dmesg so we can see if there are any earlier
>> complaints by the drive or the link. Can you attach the entire dmesg
>> as a file?
> Done (also the two smartctl outputs).
>=20
>>Have you tried stop the workload, and see if the timeout disappears?
>=20
> Unfortunately not. I had the impression that the system did not react
> anymore. I CTRL-Ced and rebooted.
> I was copying all the stuff from my old drive to the new one. I should
> say, that the workload was high, but not exceptional. Just one or two
> copy jobs.

Then it's some deadlock, not regular high load timeout.

> Also, the btrfs drive was in advantage:
> 1) it had btrfs ;-) (the other ext4)
> 2) it did not need to search
> 3) it was connected via SATA (and not USB3 as the source)
>=20
> The drive does not seem to be an SMR drive (WD80EZAZ).
>=20
>> If it just disappear after some time, then it's the disk too slow and
>> too heavy load, combined with btrfs' low concurrency design leading to=

>> the problem.
>=20
> I was tempted to ask, whether this should be fixed. On the other hand, =
I
> am not even sure anything bad happened (except, well, the system -at
> least the copy- seemed to hang).

Definitely needs to be fixed.

With full dmesg, it's now clear that is a real dead lock.
Something wrong with the free space cache, blocking the whole fs to be
committed.

If you still want to try btrfs, you could try "nosapce_cache" mount optio=
n.
Free space cache of btrfs is just an optimization, you can completely
ignore that with minor performance drop.

Thanks,
Qu

>=20
> By the way: I ran a scrub and a smartctl -t long. Both without errors.
>=20
> Greetings,
> Hendrik


--E4ZH2i6IFwmwE35Mt3Wfv1l4I72A7xcto--

--wgbVmR9qKZq2OmunGyJtZs9V2jOLqkMXA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzLf/sACgkQwj2R86El
/qidLwgAgB0r5P1OdUDmYEWAlPvoo2D88BqhzMWZuLqPKvrF84aZI8ZniJ/CRwo2
H/b2tmJYk8bmV2dY2FJlf8prN5pgCjOT8b96b9qvvGBAvamWYf9+9el1hslrGvLP
jLCmCzup0gh5jXg79dbNOo6EJWjqFNfbGzHBIm35+on3qJGoUvDhKXckH8Xdgall
FH4duvahwIXnBcxDaE8fRN3Kasa/u9GqbvhtkfI6V2QtpOR6X9ibTuDl6aro2IxT
A54oRmlyfW5xo7AJ99cdAt44LwI2pD7XJBeYMscSDIsb+8AECOJUmuljC66GxKsl
Yo/NsCpCHquSUofACTtIcGGIaFfO1Q==
=d3ZQ
-----END PGP SIGNATURE-----

--wgbVmR9qKZq2OmunGyJtZs9V2jOLqkMXA--
