Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21CA1F0B1B
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgFGMeP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 08:34:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:45663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgFGMeO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 08:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591533252;
        bh=2DrozCofsxw/Pf4TzhoovGEMVLjDGH6qTEGqkinbYFo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IlFJrqi3AfecViz8Aoct5dPsnE8v8P9yvdSFL3IjGS1U2F+YWEMn9UYZ0ttSxJQ8w
         YKlzCi1hsYof4YP36bMgsxUyso4SXWxtBG0ydtlnbgn4guS2yl+a7TC7D54NMiT1OF
         zf811KIfXbeQgNJK3uMtupF6luhx/vRRwnLq3eNQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUowV-1jZLud3oyf-00Qi1o; Sun, 07
 Jun 2020 14:34:11 +0200
Subject: Re: balance + ENOFS -> readonly filesystem
To:     Andrei Borzenkov <arvidjaar@gmail.com>, kreijack@inwind.it,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-btrfs@vger.kernel.org
References: <20200607051217.GE12913@qmqm.qmqm.pl>
 <88e8b58e-9a4c-1f3e-4b08-8a56de191dd4@gmx.com>
 <20200607083452.GA9208@qmqm.qmqm.pl>
 <41bfa30e-cc9f-5f26-3aab-c141a9e3aa91@libero.it>
 <9c219e9c-d398-444d-f817-9160b9cc8520@gmail.com>
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
Message-ID: <17c2958e-98cf-b1b8-3829-56b635d7e5fc@gmx.com>
Date:   Sun, 7 Jun 2020 20:34:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <9c219e9c-d398-444d-f817-9160b9cc8520@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9GpFagjo3aOBxozn63SNEohZrGeDbN1qo"
X-Provags-ID: V03:K1:gMnE8fRTS4FdHqyBbx20Vse/aFOLvqRLfllBoBJq9ONOKWfG8gn
 CpSLM+4qnztwCYGEceu7ORxpP6eNrVQTQ30UBaugxcsR1XJ2WV11CVgWWf8e09/OgSUbaIn
 y7VV7bcCucxvTB0BO9YzgRbexgsflEPta8ssbC9YlDmBI8N2kk4/z3UD6r53xlq2p2Sk2o/
 3rnuC3RK3oLJ8aLLxXb2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RjGtN68cSHA=:11reM5VZdERR7Nleah2kzH
 kpzkOD5pR6E5YnwtMPfUgRbPhA7SJyAVja3Xjz0fr0XrdMI28f2gajGPGOXExFzIV5A7D8seN
 PkOxc1Ob8eAQIJ2WQUBHWlMrcN9mGmCyolo1r7uon9I3ycxXL6KzzMyEnx/Z+wXZ8Mf6P/8t9
 AIayK4RyQ9b7AtQIbuulPHuwmB24e6PHscZdPtPyQXRHZ2DaLScRVFJEdpCkhxKtLLm6uhRfM
 +iwC2+0FeTMcsTaet0bLUbYVQp88aR3azcxLAs3XTdusN2Vm4xXPUN67fOTCwb91y+kPOCULm
 4420sKqGWUwMGFOIx3Rj6BQXpvsDV/2fG/+sKMHvgWRzDC/syq24SQTQ4q1QXM1qRJRs2iRwM
 43tTuNTXkOVrwgnOttKh3pBNsl3IcEB/25FvPPNY1MStCwFYsz/KpEJXVrKN9b3TmoS7Bh4xm
 9qI6TU9uHdFQunZRbspHaiWO4YkUkMRrxc4mV/8rLNiaDKNMnu2uPMXlz8gHPFzsQzJzP0SRP
 7SxJHg7sDs8GuC8pcoFaIUG5GvUjlmVTcGSGwaHokuIDmXICTuAu9VOzwUmKveQl5pIp5T9RR
 di7usur/iIRa3zhZd8fFy49LZO0pJeXYvbwN7iSL/9uXrxgiZ3ufx3z3p3KSIGLcr0tvvnOEs
 1YGrC4UndWovjXsrCr9gKJtBtm7IoOSwovTWo1Qfv0VWamO2nv/W848FclagHgxwjNoE/u5Wg
 1ckDiGzKH5PoX+X7m6EOOMaSHnAFaiIqa53/whLrVqm2atPJtTeugRrhmudBSN5p6vdJq53y3
 1MOa7L4WxgwMPWcrHFt0Yhng87VEGRyNofWHB0LjDjU4ejGjkER+hju3ZGkOntcobAUymniD6
 wZKcS33WdILd6MDgr71m32Sf/2mRkNLGHQC3Q90UkM2nxPC/Xu7Cb6Pu77YaW7lf73ehYtYEJ
 ItYy0xeVnvBsz+x55YvjkpMHzPeu2VSyyo07e6kVXIsr3M7iME0mwLSjAQNAtv9VVAa3LLTXE
 uQ3vSm6Fnw6mDVdaCBGCBlsiv36afCv8Q5wzf+5yHKRYHtEdpSWTBiTT9vQgyr21aJYBiz2jF
 6FfSDVl4ivMgFddRI6ZkPvk9jO9OmpExFYjrfMkegWkHx9k3lm8DZ+dGQpgevQJoZ98wxz8iQ
 /H5S1wqN45DfOOVsViUsJB6ERJZw5Ukp47qztQ089w+ffhOjBn9ytJ7y82nojlXzw6gB0RctG
 d89j0ky+iMKpsye3G
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9GpFagjo3aOBxozn63SNEohZrGeDbN1qo
Content-Type: multipart/mixed; boundary="hNgJ2SmB8INi9fkHNEjcyMWg0JvWghvyA"

--hNgJ2SmB8INi9fkHNEjcyMWg0JvWghvyA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/7 =E4=B8=8B=E5=8D=887:50, Andrei Borzenkov wrote:
> 07.06.2020 13:09, Goffredo Baroncelli =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>> Unallocated:
>>> =C2=A0=C2=A0=C2=A0 /dev/mapper/btrfs1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.02MiB
>>> =C2=A0=C2=A0=C2=A0 /dev/mapper/btrfs2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 930.49GiB
>>
>> The old disk is full. And the fact that Metadata has a raid1 profile
>> prevent further metadata allocation/reshape.
>> The filesystem goes RO after the mount ? If no a simple balance of
>> metadata should be enough; pay attention to select
>> "single" profile for metadata for this first attempt.
>>
>> # btrfs balance start -mconvert=3Dsingle <mnt-point>
>>
>> This should free about 4G from the old disk. Then, balance the data
>>
>=20
> E-h-h ... how btrfs knows it should free 4G from the old and not form
> the new disk? I guess it is old request to allow explicitly select
> "victim" and "target" devices during balance.

Btrfs always choose the disk with the most unallocated space.
That's why btrfs balance would always "balance" the usage when possible.

Thanks,
Qu

>=20
> IOW can we rely on btrfs doing "the right thing" always or is just
> coincidence?
>=20


--hNgJ2SmB8INi9fkHNEjcyMWg0JvWghvyA--

--9GpFagjo3aOBxozn63SNEohZrGeDbN1qo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7c3r8ACgkQwj2R86El
/qjDrQgAq0t3HkDrA6qQQWqqBvH4wkfS7AoyPq3zfPW+4uMuBFfw6mUXTuMf2s8O
8finFgc8s7CBzH5tfzsbh3+ZbKiSlXNUQtJzSS7gAGQdAwSauhrZtLGk2LTIPTxe
fzJOJXSpIhiOdaIpfaO35c60hd7u1e5i0bFBYt3eliauKsAVfmxOSOEkXMaIN3+h
rpEJsQVX+IV6V7qA3IZnliRGmrW6eJP+t+X8pqn/Znj7aBnzDiUqTKEezJLWYHiG
kP5s13l/q5W+GCO/dB+zzcs/SB+FMtvvGhQ6xQkydhtlmzNSPnufy3esKk6ZkLrx
yxSo4jFMyagQHYNJ2guUHpnZqaWN5A==
=UM3I
-----END PGP SIGNATURE-----

--9GpFagjo3aOBxozn63SNEohZrGeDbN1qo--
