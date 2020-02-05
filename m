Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10DDF152922
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 11:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBEK3d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 05:29:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:38223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgBEK3d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 05:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580898570;
        bh=irafO4ZLvFq+DwVDYng9bQfNZszECoZEevtkiGJF2tQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=VenzGVTakppWR3An2wws93KkB+mlBLxsz0vo23Ma79HnmvluGC+RK0fyWLQ4fW+iz
         5FLpb1RDM10gFxZ6gi2pnLBb2SnrqVTrpNyFzlrCKoOHFO9FKSdNUK8ethx7uhORJZ
         8NCjVm/gSLaF1qyJkW+09/AqcuUaUr1Xds/+mT8c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3se8-1jhFgf3g9Y-00zqrJ; Wed, 05
 Feb 2020 11:29:30 +0100
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Chiung-Ming Huang <photon3108@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
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
Message-ID: <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com>
Date:   Wed, 5 Feb 2020 18:29:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nQvKDSFE5cgwNZy5CnW0JhyX2DMNxGU4o"
X-Provags-ID: V03:K1:+hyNdMhOyU2z4g+Rxr5XwoQ7Tdi7GB9TqLswB0vc0aFq9Dpq8XH
 zsvrxxXFIhGhofA/Aj6LqSgd2Ma1auShtg0GOsCs5L+BvWIjLskgYejs11UayJbPZLBdbXz
 aBOSvj2CXYoWf91jZ5Sjx6mfBCE5XBtZzH1Mv5jOTQNMRwkoYfj9dz/f6UHqjd559jdy221
 Q9o0JCf2UUJ7xwchGHQ+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hseC7kYC7x0=:3YokEfhvbtbISjd0KQxgEJ
 BFh75lqBHdcdkGJb62KIH6IfFA9wqvAi2MOptH4dSUUMRBB0OfTr6Y9DnrNdaPINoRScb/Dbm
 rSBzJB8KgbI9BALAiUoVoi2mJWIvi5wgEj6OJXp2otSSh0EtX1R78oXSpnBgNeMOlfSKpd/Gb
 Puy5S6nxk3MWS97pqawcfphejgend6aI5fJCAK/toPRRTNMhFyASv74dRGQa6wSzYRlE2au6u
 TOfcWVwSMn7kA4zm6fTta6DC1xN/iqNnk38bqG6mUQkgWQkqTxqHb6xMXQOvfuGo95S0pBpdt
 yXkApbwfytUuM4kLweoxfSrmfyxI0X/eYrCFEqU3jyZ925G9AYCZpSJJe21Hnf2MyR+UbTISn
 L6z36+0z3kz3ieytHsJEGvu16NOonNzxcjiP2VZskhTnCU0IKjhUC4AUDhe4rU86pR4GrCEQL
 /Xx/5PbUTVf8T7WbTs6HSITz48xC1QCuIIHJ+2zNBA2KEvH/GJRRYGwvMRjzwMfp5zrxSF4x6
 fuQ4RX0sUtZoMFmQAY1HJUevvQ3lypJb7yb5tjzx4SK6nUxEJDVAylWmMvogBHroO4GhpTEfe
 ULQnSC8jKXg5XLPkkTxVQTcf5wy/ZWb3c/GVFo5HvnoRl1NIs/Ixon7PALs060tyMOjdPGRBj
 7uW5tYDqm9zoeaCl2/vRQOL/uinhI5SyF4U638cIegIW6a4mQIPo1KYueYfnN6L0A6CwThToc
 ZZQ279/5LFLa5qGKfonbZyzC3mELBvW8XzK0qMBeDI3g1U4XQjuqgx+n1Sv/0+dZM9nfvjIPV
 JHnV+X/14qoGOSRYaCZwcbDncRTFD+Fpk5SO5+JZECgvWiywU0ERZHNTGNuo6d0XoQF//y2fM
 yTjmGF33PyZe2NtiPPh/4L5U7dbtrpx13juk4z/t9wdNNXqGAZ0UPqlBQjthGGRuHBzrWwPuB
 m8/Sph5uTarx2/W3lt4AZNJedn/K/ji/IKdmlL1hn4na4DtnpTFgkVRSos1GXqipnO/VuYAUv
 T1mkAClAdELzF23PK6WvhuH+meg0ZngnLnTMsQetRukQEusuO7wAGu4S5DhXOkJ3l7j6/j9R6
 5yvmjlKU965IjOHVN3/ST24jMc2RDzwPYVG0LTktT4xxkXNUw0j4KCQ5jvGPQTJpPivxiNO1q
 rRIyyji5aByr7ow0dtNQuJHWkHIZDUfL5SmCoizw662Gns4WklzjCsH6Gesu0f+R8XC++AIk5
 28Ne3eo8QBzarGnu4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nQvKDSFE5cgwNZy5CnW0JhyX2DMNxGU4o
Content-Type: multipart/mixed; boundary="zGLPEnFFAGRX1Z84ZnuZqDscLYbc3huQJ"

--zGLPEnFFAGRX1Z84ZnuZqDscLYbc3huQJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/5 =E4=B8=8B=E5=8D=886:18, Chiung-Ming Huang wrote:
> Hi everyone
>=20
> It's a long story. I try to describe it shortly. My btrfs RAID1
> includes 5 HDDs, 10Tx2, 1Tx1, 2Tx1 and 3Tx1. They all based on bcache
> (1Tx1 SSD as cache) and luks. I tried to reorder it to ` Luks -->
> Bcache --> SSD --> HDD` with only one layer of luks on bcache. But I
> failed because of power-off accidentally. Please help me to fix it.
> Thanks.
>=20
> 1. OS: Ubuntu 18.04
>=20
> 2. $ uname -a
> Linux rescue 5.3.0-26-generic #28~18.04.1-Ubuntu SMP Wed Dec 18
> 16:40:14 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
=2E..
> [Wed Feb  5 17:09:04 2020] BTRFS error (device bcache2): tree level
> mismatch detected, bytenr=3D19499133206528 level expected=3D0 has=3D2
> [Wed Feb  5 17:09:04 2020] BTRFS error (device bcache2): tree level
> mismatch detected, bytenr=3D19499133206528 level expected=3D0 has=3D2
> [Wed Feb  5 17:09:04 2020] BTRFS warning (device bcache2): iterating
> uuid_tree failed -117
> btrfs fi df /
>=20
> ------------------ dmesg part 2/2 ------------------
>=20
> [Wed Feb  5 17:09:36 2020] BTRFS error (device bcache2): tree block
> 14963956514816 owner 3 already locked by pid=3D3187, extent tree
> corruption detected

This shows the problem. Your extent tree is corrupted.

I don't believe the lower storage stack is involved.

Full histroy of the fs please (from mkfs to current stage)


=2E..
>=20
> 7. $ btrfs check -p /dev/bcache4
> Opening filesystem to check...
> Checking filesystem on /dev/bcache4
> UUID: 0b79cf54-c424-40ed-adca-bd66b38ad57a
> Error: could not find extent items for root 257(0:00:00 elapsed, 1199
> items checked)
> [1/7] checking root items                      (0:00:00 elapsed, 7748
> items checked)
> ERROR: failed to repair root items: No such file or directory

Have you tried btrfs check --repair then mount?
Is that mentioned dmesg the first time you hit, not something after
btrfs check --repair?

And `btrfs check` without --repair please, that's the most important
info to evaluate how to fix it (if possible).

Thanks,
Qu

>=20
> 8. $ btrfs scrub start -B -R /mnt
> The status is aborted because the file system was forcely re-mounted re=
adonly.
>=20
> 9. $ lsblk -o NAME,SIZE,TYPE,FSTYPE
> sda                     931.5G disk  bcache
> =E2=94=94=E2=94=80bcache0               931.5G disk  crypto_LUKS
>   =E2=94=94=E2=94=80disk-1t                931.5G crypt btrfs
> sdb                     232.9G disk
> =E2=94=94=E2=94=80sdb6                     10G part  crypto_LUKS
>   =E2=94=94=E2=94=80rescue                 10G crypt btrfs
> sdc                       2.7T disk  crypto_LUKS
> =E2=94=94=E2=94=80disk-3t             2.7T crypt bcache
>   =E2=94=94=E2=94=80bcache3               2.7T disk  btrfs
> sdd                       9.1T disk  crypto_LUKS
> =E2=94=94=E2=94=80disk-10t           9.1T crypt bcache
>   =E2=94=94=E2=94=80bcache2               9.1T disk  btrfs
> sde                       1.8T disk  bcache
> =E2=94=94=E2=94=80bcache1                 1.8T disk  crypto_LUKS
>   =E2=94=94=E2=94=80disk-2t          1.8T crypt btrfs
> sdf                       9.1T disk  crypto_LUKS
> =E2=94=94=E2=94=80disk-10t          9.1T crypt bcache
>   =E2=94=94=E2=94=80bcache4               9.1T disk  btrfs
> nvme0n1                 953.9G disk
> =E2=94=94=E2=94=80nvme0n1p1               636G part  crypto_LUKS
>   =E2=94=94=E2=94=80cache                 636G crypt bcache
>     =E2=94=9C=E2=94=80bcache0           931.5G disk  crypto_LUKS
>     =E2=94=82 =E2=94=94=E2=94=80disk-1t           931.5G crypt btrfs
>     =E2=94=9C=E2=94=80bcache1             1.8T disk  crypto_LUKS
>     =E2=94=82 =E2=94=94=E2=94=80disk-2t          1.8T crypt btrfs
>     =E2=94=9C=E2=94=80bcache2             9.1T disk  btrfs
>     =E2=94=9C=E2=94=80bcache3             2.7T disk  btrfs
>     =E2=94=94=E2=94=80bcache4             9.1T disk  btrfs
>=20
>=20
> Regards,
> Chiung-Ming Huang
>=20


--zGLPEnFFAGRX1Z84ZnuZqDscLYbc3huQJ--

--nQvKDSFE5cgwNZy5CnW0JhyX2DMNxGU4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl46mQYACgkQwj2R86El
/qihcQf+JhOob3oEMhvDKhXDHuk7TDjq6O6LqrPJT7cpc645PKfnUMRJV8TGnPUQ
tKVco1DT+e0A7rry4skim0OqkxPfrkP51P5FNMCeWh0VTaUM+QVkGEk9paYJkK33
7PEvgeVEJlV4u6T6eS1qg1ZEp6Chv9unV5GU/d0PTa7xZoppexU1Vq96QspHIoJP
H566thz3uKYPSjFdawfaJSY/14mrYeg0m7t+f03Ac0p+nJ5no6yGCp+l/nz+fRHx
qa9+cmKyuE0MShvdEun9FsS50Ajmj9miETBl0tetE2IZyJhs8TEGeeg5qRgdbQ1l
Bko6GZpfpFSZ5AGOhJbPc8zDLK6FCA==
=fXma
-----END PGP SIGNATURE-----

--nQvKDSFE5cgwNZy5CnW0JhyX2DMNxGU4o--
