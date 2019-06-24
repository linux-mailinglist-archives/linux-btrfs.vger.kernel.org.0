Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71EE251F3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 01:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfFXXsW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 19:48:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:37709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbfFXXsW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 19:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561420099;
        bh=cV8/kmKddIP47opigmvq2zWpct8RT2MxeIYlpT7tacM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UnesE+Flo3hAisAx6x3WabGbS1rRRYxLQqNPBHEqthNbzp+Zv+7Drpf0gxDWCtekK
         OCl06bPQp7Dm4qszOVAe+D3vqiEH61Ox5sH+hKdTG9cG31Jo4+poKNcVMqtsbv9wNn
         5LwmnHIl8ADo8S/PPgnwy14ajkByV8oaPavEQiqc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LaFmY-1iRWZj1pew-00m1Uh; Tue, 25
 Jun 2019 01:48:19 +0200
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't
 allow"
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
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
Message-ID: <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com>
Date:   Tue, 25 Jun 2019 07:48:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ERTMZ5gPoR2lfwfJbaiMqwURmxjkWoKB1"
X-Provags-ID: V03:K1:GeR4pQAtVWxn8GYODIHBo7PTj09Fa8UDliQ8rhPp62VE8gF9N4S
 58DsvdnIhP7ycr4UYme1Nl2WT7j1g7w6pxFs5PMnQGRtXyLth1A0xEGMH8WECdUzp+O1sqC
 DOwjpvS8lEbAKj2vDwUOpCiaetaWp/Lgqje5Hdlo9DL8/oAiEHKvIK1T3ZNq3HV8i4j48wd
 jTD/6zKy4HyZ/UsapOClA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TovSeRwtnHI=:xe4cWPmJ4kbLM6QPhwLeNP
 oDKfVtqHnf1YW35YAFoD3JxVVm1X7Mib8rUKKLL0EAraD60NbbJ94nia15xo4ZFm4t62VaDlG
 ggP7QTLQHAhG1oKHBRbeec3/JQAFq4spEatejje00Ahbpq6CWFqfbXqp8qBNdtMLPr1fwl3u2
 EFf8c2+JLpMmuiFa2YgTX2flTEaulqGyQ4ypl4Eb710SmbTCer9i3ELGTuvLwkJn4r0Em5f9h
 uMJZWgUD1C9H5l/8sR1GlP02aUrmACRkcQTyKeiWYnaNeQhHb7Xi1MFTBwqlUAbbShloaaDuA
 ghHGA6X4/PUw8bvZZXwmrkUhcTVMvoaLADLr6QcFhvTYVbzZhJrfueA9RbPigRxqCyxzZCzcy
 qtAImFOYg6O6IYHW5LjO2i/a4p5ji+fL073wmXuOOBFatxgU8fnGjU5mH/2xS5jV2l7bN7fXd
 YH64QPiR8ArGB5LVuAiJvIJG6A0ZVWwVrZWG5Uey7VXbtW1/PdoAwie1CPA1nrsJWy/++VPj8
 pQPKeh1Dq5dItXnhA1Kt57U3r6NBJpEf0/EhqN+8qrJG4Ga3v8A1jcJbSYxk7wi6j0jQQdRF+
 1WYB+4hDLnMqd9WtLUXkn2CYLRdL1nc0Iok2KAo3KqsE57vgU7shT2CK4+aRFrhmausnPhKxX
 GZqW0owKwc6oaAr4AFoAKlndWosOhmTzP3r0fxh/AXTiiMs/h9gN59AmJ2PHhrPa3CRHyVuKZ
 CCIkaFHToQlM0NHAz2SgilUkPozvObrveuJMr8+jTHjzlTiNmauGz/YKd/IxeAQy7RLQZxxoo
 AY3orTSQ7Ku2LkC8QtPM++Eu3W69kaa7G8iE0iT1SnyxqqZc/Qqq4aeYciPmUon7EieSyrWpO
 SQiUptAjDE01wV6lBumI+mOTgouN4q3onu4zYkCP+gW7yABxwecxYGPER0J0R/Axc555pQqxi
 CaG/BHYIxl+aNw1p5CL3aFJCfOZ0xFzA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ERTMZ5gPoR2lfwfJbaiMqwURmxjkWoKB1
Content-Type: multipart/mixed; boundary="J1hnCbGVCjUgB6cwz5uWrJBge1JoWCQa6";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't
 allow"
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
In-Reply-To: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>

--J1hnCbGVCjUgB6cwz5uWrJBge1JoWCQa6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/25 =E4=B8=8A=E5=8D=885:19, Chris Murphy wrote:
> Short version:
> sysroot is Btrfs. I made a rw snapshot of an ro snapshot in order to
> do a rollback, and then rebooted. The umount was clean, but during
> startup I noticed many services had failed, but couldn't tell why and
> I had no shell or remote service to get into the system. I don't know
> if a rw mount happened, journald is set to volatile journal so there's
> no log of this failed boot. I waited about 5 minutes in this state
> then forced a poweroff, rebooted from USB stick and btrfs check finds
> errors and collect  information. There are many btrfs check errors in
> lowmem mode. It does mount ro without complaint using kernel 5.0.7.

The errors from lowmem and original mode are matching each other.
Just lowmem mode prints every missing csum it hits while original mode
report in an inode basis.

The problem is not complex, one inode which shouldn't go through
compression (maybe nodatacow or nodatasum set) has go through compression=
=2E

This leads to missing csum while still compressed.

This could cause read time error.

The solution should be pretty easy, find inode 4665463 in root 492, and
remove it.

But before deleting it, would you please provide the filename and the
following output?

# btrfs ins dump-tree -t 492 | grep -C20 "4665463 INODE_ITEM"

Normally we shouldn't have any nodatacow/nodatasum inode goes through
compression, maybe zstd compression code doesn't follow that rule?

Thanks,
Qu
>=20
> This system has used Btrfs for years with zero corruptions until now.
> This system was clean installed with Fedora Rawhide ~ 2 weeks ago,
> with a newly created file system.
>=20
> Hardware:
> Apple Macbook Pro (2011)
> Samsung SSD 840 EVO 250GB, Firmware Version: EXT0DB6Q
>=20
> Detail version:
> only btrfs-progs 5.1 used
> mix of kernel 5.2rc2, rc3, and rc5, at the time of the snapshot and
> reboot with scary failures, it was using rc5+, specifically git
> bed3c0d84e7e
>=20
> mkfs.btrfs -d single -m single -n 32K /dev/sda6
> mount options: noatime,ssd,space_cache=3Dv2,compress=3Dzstd
>=20
> btrfs check (normal)
> https://drive.google.com/open?id=3D1ZkIPq01lz1BxjOjxA22SUh0kSQaEeRex
> btrfs check lowmem
> https://drive.google.com/open?id=3D11INxc1OQbdpmqrVRlk0mNuLwmgSnnB1K
> btrfs super
> https://drive.google.com/open?id=3D13cNGSvjPTiYgG0smEFWecP3fk9P2Tn5G
> btrfs debug tree, 97MB zstd compressed
> https://drive.google.com/open?id=3D1TaxKikn9gKDjnkQpOrqWzdGYw17maCpt
> btrfs image, 31MB
> https://drive.google.com/open?id=3D1is_prjUhu8IBjq9oadugOi_YBYbGYGRA
>=20
>=20


--J1hnCbGVCjUgB6cwz5uWrJBge1JoWCQa6--

--ERTMZ5gPoR2lfwfJbaiMqwURmxjkWoKB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0RYT4ACgkQwj2R86El
/qiYJAgAqdLxN9dyIx8TlJuM+j+WqDhwLcnZU/AoQdp1bGamuEeub4prNjoaSFfm
T3olIlqtoRUGqM/rusqKGGyGEfxCmurlofvGSvjnsYkvMJSZCdu2FW3J4/lCufQi
A89pb+Ha+1fmduiG71hipgyL/gbUQ4luNvoa18PFYCOZs2sZPs5tX+kNpxPaEkFO
ZY8nE8s/RY74fSvLSdb/Qj5Eko3OCjcyO8nMtGNk3gSKjwDStrzkXIsNHHyeI7C8
kHMhD/VmBxRtyzhUZd/HVI4cZ3PZuvgWJo3Xn09lcCd25uA6e1edStlpp4xXCLfA
8PxKx1Icldao6uOl+ZREePnwzHIIkA==
=1H6C
-----END PGP SIGNATURE-----

--ERTMZ5gPoR2lfwfJbaiMqwURmxjkWoKB1--
