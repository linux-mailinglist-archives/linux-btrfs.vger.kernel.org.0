Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3011E0CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 10:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLMJc1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 04:32:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:59245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfLMJc1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 04:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576229538;
        bh=KcHIVRdTcJ3dF0079OcJadPNHohs16UB3F2tgEXTYIs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OWwqvFnhPHsUcB1d50FGy53wwaRLzcOKIoHX3fbLdI8ez7jDkaLHLkDRM5LClvrJS
         7FeiQKxDE2vs5nnnctQ7Ld08NjWCwQq7nGrRkpIxsweEaxCTI+ZAPBs2fzcPdhBCZV
         MTxYH+KAHhbMNDmmNWIKNrHIrfa+q6uilqXxZOsU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MyKHm-1hnqdp1vGW-00yeCv; Fri, 13
 Dec 2019 10:32:18 +0100
Subject: Re: FIDEDUPERANGE woes
To:     halfdog <me@halfdog.net>, linux-btrfs@vger.kernel.org
References: <2019-1576167349.500456@svIo.N5dq.dFFD>
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
Message-ID: <691d3af5-da85-5381-7db3-c4ef011b1e4a@gmx.com>
Date:   Fri, 13 Dec 2019 17:32:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <2019-1576167349.500456@svIo.N5dq.dFFD>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="79LqdkX18NTQkmQSCah1KlEj0X797iUKh"
X-Provags-ID: V03:K1:q3geigdJ9c3Jtb1/1KTwQ9al3jgahI+joTNPn+nmlPlnShelK1w
 DZitAcpFy+3UBxD105IbGmcJOmvJH6Qw4WzQgzI9GFuQ9JJVm8FDGozZ1T9EMVk4vHTtdkx
 +YLg5cwJ+RTJdh9vEuKuqWdLC00EHd3ve8deZx7tLFwiMb0rI7kn9jXNTUvmCEorUYoNDHw
 /2bDlylcVwB5wZgQmWGzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L47oknOiXmo=:IHwVSr5NiPZnL31uXHNulf
 XjjPRHZKyDM24+jEC1rsPnKbNZhsn+VRDZNqNtoh3xUiYGdjAxnv5vS685viOcTH1Kj5/jDSP
 wm+O9tic7sajVWmbZki1iLJWUtvVoG7t23K4xVpQ3kUijhUa7U3E/qBxja+ur4NM7oyqnTndi
 UewLQSt1odDqqkeADNAbCpK95+E9XcWpNOlZi2Eaxu+/iWOeW2s/Ium0muSz6BL3hYWVgMOq7
 S762YCOiO/IQhPvcUr/8gkcEHH+2JIfOKNyWlfY+vuL8YHfWBF13KOEqJoewEjB/fHP/+HChX
 zSpdPbX0WPRl9bzzikv31sarl+15qCBdLSpugPDoQJzgCDPq8cSJMVy08TRi4KuCh8t87D9/T
 geUoZb57G7A1pBl2Se2s/N+zgh8djefoH8uxEthEVuVhzALceGnjB2xqSfu8haJ7Ulz8x04nd
 1YUhJK9cSJWc4UWGIjDEnqgGTzwp53uagPDL/pQWDV/2vk2hC4w7JFeVbMZVvNkDPXjZzAB4T
 TW6YabPjvlNOcJLfZ1MkvuS/rNauv/3AMjiL0POzz3LsSdR2YNF9ucENhmVxDUSdjC5B+jEGB
 hlzgD7W43UtXWL4umSZxIxwbtyraDsMhviUAv76VhkH/MEm8F6Ufml7kJrOITWzb5En5Q91L3
 oom0G7U2GO552rK/5y7kdf3PiSJGaoi+6cnw7KznDqjCje+IiP4cjt/+W00I4rbMW/w4LBNO1
 mxjtNDFAGsN3uSrpI/wHD+Km7JriVjOQfwFtFdcYsByB0BIQAdKwJ24LQ3NiCo3HU6us9oB8D
 lS2DSwtnPTV4DdoL+QDYDq4CROg6bK9Lfu12C04DSj83ZKS4EGbn1LhJLrQxT+KgsGiUvs+YH
 kHg3JOs8c0L3OyoslajbRzGViDOkwN/vnY4C0mc+QY8rs5SYXGlJgJZ///vItpsYUPho4zGK9
 oiRW3WYFSzfmtUxAW/cI65Jv7t4T7NnYh7vqwgHu3vPUNjYaIQIe8/q0f5cnyDZfSrIVXP8hb
 QuBLgMkhwjCVT12/Nce6E/mjHB4UdCwIsrTm5a5TGbHOYHwThnKhj7t3qjodYhuMiumaWNOn7
 xGwCK6VTKYAxQ2tR7g2PuSINXleWshvUqJDMIjU5Lt27d0t7rvxVV4ij8kCKjLS/orCUtGT3J
 Zd1vuAQT+/las5OWZL++4lDGonJuLnKveabRYc/C2/yhPNxiPfxwa1VvpLbLbrwaG7d7OqEVR
 U8c6Zy5LU3fq42evXZGfICGlqIKJ9/ve7uKyTRSt3SRQOX9/Nu8uAd2QJ0tc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--79LqdkX18NTQkmQSCah1KlEj0X797iUKh
Content-Type: multipart/mixed; boundary="OROGCk7fGUdJwbMsEslMIjTfINY01q3dS"

--OROGCk7fGUdJwbMsEslMIjTfINY01q3dS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/13 =E4=B8=8A=E5=8D=8812:15, halfdog wrote:
> Hello list,
>=20
> Using btrfs on
>=20
> Linux version 5.3.0-2-amd64 (debian-kernel@lists.debian.org) (gcc versi=
on 9.2.1 20191109 (Debian 9.2.1-19)) #1 SMP Debian 5.3.9-3 (2019-11-19)
>=20
> the FIDEDUPERANGE exposes weird behaviour on two identical but
> not too large files that seems to be depending on the file size.
> Before FIDEDUPERANGE both files have a single extent, afterwards
> first file is still single extent, second file has all bytes sharing
> with the extent of the first file except for the last 4096 bytes.
>=20
> Is there anything known about a bug fixed since the above mentioned
> kernel version?
>=20
>=20
>=20
> If no, does following reproducer still show the same behaviour
> on current Linux kernel (my Python test tools also attached)?
>=20
>> dd if=3D/dev/zero bs=3D1M count=3D32 of=3Ddisk
>> mkfs.btrfs --mixed --metadata single --data single --nodesize 4096 dis=
k
>> mount disk /mnt/test
>> mkdir /mnt/test/x
>> dd bs=3D1 count=3D155489 if=3D/dev/urandom of=3D/mnt/test/x/file-0

155489 is not sector size aligned, thus the last extent will be padded
with zero.

>> cat /mnt/test/x/file-0 > /mnt/test/x/file-1

Same for the new file.

For the tailing padding part, it's not aligned, and it's smaller than
the inode size.

Thus we won't dedupe that tailing part.

Thanks,
Qu

>=20
>> ./SimpleIndexer x > x.json
>> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json /mnt/test/x =
> dedup.list
> Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)], b'/mnt/test/x=
/file-1': [(0, 5472256, 155648)]}
> ...
>> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0 0 /mnt/tes=
t/x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D0, =
src_length=3D155489, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=3D=
0}]} =3D> {info=3D[{bytes_deduped=3D155489, status=3D0}]}) =3D 0
>> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json /mnt/test/x =
> dedup.list
> Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)], b'/mnt/test/x=
/file-1': [(0, 5316608, 151552), (151552, 5623808, 4096)]}
> ...
>> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0 0 /mnt/tes=
t/x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D0, =
src_length=3D155489, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=3D=
0}]} =3D> {info=3D[{bytes_deduped=3D155489, status=3D0}]}) =3D 0
>> strace -s256 -f btrfs-extent-same 4096 /mnt/test/x/file-0 151552 /mnt/=
test/x/file-1 151552 2>&1 | grep -E -e FIDEDUPERANGE
> ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D151=
552, src_length=3D4096, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=
=3D151552}]}) =3D -1 EINVAL (Invalid argument)
>=20


--OROGCk7fGUdJwbMsEslMIjTfINY01q3dS--

--79LqdkX18NTQkmQSCah1KlEj0X797iUKh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3zWp4ACgkQwj2R86El
/qiH/gf/djjlL1xhL0d/njCx1KydF3+p+wY1Okm8Ss8V75XLMDaxQCIIUn0KTety
M1v6FBkl8LAn9AThEGuf097bSWey2hT6n3FQmNFWhtq+SL/uFNTVollmHkjX+622
8d3v4GXUDNHa9aV2NpynzOwoW93gS5LxS2njynpBmD2saOmsO3/C7w6VfdgbdX9y
0hZWr0pxtRf5iDD2TqDYTJ9N9LLMgFZIify8NCM0qSgbTFg0Ydl/mL4aM3VXty5x
kyVatGFYfnHA7Oq5MR5sLCUVAdjLFMnOWlxcq6xBC4SPdKwgsxxlV3i5ga0ipm16
06E2wSUyT87SXEjXO5ONUqoc8KBLFw==
=xV/c
-----END PGP SIGNATURE-----

--79LqdkX18NTQkmQSCah1KlEj0X797iUKh--
