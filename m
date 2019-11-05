Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8894CEF241
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 01:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfKEAwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 19:52:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:56093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbfKEAwt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 19:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572915160;
        bh=UqNaJ1comd7X3ga4fhYiOx6a29s5rsn2PVtoRpZSuVA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Q1udsTJ1mDlIu/rW50oT0x/SzuUIzEwb+hxbK56yFiGssy+z1sAimuxDufyJQG/eE
         JcXudW443vp8iFs+hpn/03ux80VvrXTD1q96pJboKBObxXHp5/xAodiVJjnw/FAvRY
         74P9Bjh26ZK8cFsgZjRE9RDRtlBAEMr9yvYbn4/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8ygO-1iXqoz1qsw-0067dp; Tue, 05
 Nov 2019 01:52:40 +0100
Subject: Re: CPU: 6 PID: 13386 at fs/btrfs/ctree.h:1593
 btrfs_update_device.cold+0x10/0x1b [btrfs]
To:     Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     linux-btrfs@vger.kernel.org
References: <0a25bc52b9d3649d499b76d06e0d117b@wpkg.org>
 <d24256c7-4398-7627-4352-1878af1467e9@gmx.com>
 <94c49648ea714dcd1f087f24ee796115@wpkg.org>
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
Message-ID: <c44c5868-6351-4d38-de12-c7903b64a441@gmx.com>
Date:   Tue, 5 Nov 2019 08:52:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <94c49648ea714dcd1f087f24ee796115@wpkg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B9ptu0UfHjJLYN6aw9jil0ghgMfRZ6lkl"
X-Provags-ID: V03:K1:w8acGYvGwEV5tVufb//DnymkcK8B/4RfceEUd58U50O53tUOW6Y
 pPTdZOun2KF9x8tUQFxHB6hdl1jRnSbBeDg7b9YvM/lWjZH8A1BBXISo6q4vHsmLoDRp1cY
 59U7tjCG1ZDuEM9AbHIcIpwDHo8tB2AnwcLQzLAX44hTMzqaXtloSBbZqoXGySW86AEEdep
 TaeqOg5IKFs/0fJ0u6+uQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kfJwe+cZCCE=:nLNnD6r3N5bkvkC/eLo89S
 xxrO6GJHUggFLlMyCJGGdOyYWvmRbB+0iJeJOW/TFhZ31bJDg0cZGPVaA7NemrDRiAUuRQ8gn
 +6/TUjzY4ABwNV2MCFRiKLrNy5SYviNmB5V+6nIdm+V6iRAcEInUdT/UtKKyfmqkuS7GJbXHL
 YyTm5zqwfS5EXO8a1sphUSNR5qQQueK2U4LRUiofE8Raeo/FYZDLf3aegVreREnoWCgFqrm0p
 IQ8AiaLKnm2f4UE2qFwj9xbNtQYv07eNWWV0bt4V0YMkedWEdHyDIs/QrPe9aPQmu29SYSZYp
 vgQntfRPLe24rOLYrp4c6s/bY2CMs22o2KokN+BgMEYyZ+tSrNz4fc4fICoLoZT8xIyaqe4z1
 7is1X1W5jmgk5IFvMLdkX9ruO1Ccso820n5k0PwluLqs+j5Pb51sr8au9BL5F0fvyW0AtMZzp
 QYVfIEF7rjPgwO5fFfwkXYM4R0YDVjBCL2+9GrgEu/QWuWIFqcON46KpWLWgLZwHCJd1igdAe
 VC+KzYQl9GBV+z1F6hFUJgSr6yMRGw+82YqOSPIoKlda59AmS6OfonW56x8WQXXDFclbX4Rqe
 4pj2OmyQfuiCIA8ZWofIZ5RFYMKD3EMEAbNRyZs3rhTaFlq7UulGyxbCfGf/5u4MBs2Ubkhzv
 n/e09o8DyB8imeO7ewe4Y3nVVgfr8iJdpj0NVJ3rMAMKRZpklHnkzJFERKKUdGvr69B7Y7AEZ
 UjBoTgFvbF5wuORsrvL6Qo4QMt1PFI/ygs9xs42BL0nr59nhvZ+OFhHdM0XUpdGB4nZuC5ERx
 cMBqadqC16WHuFrnwo1IT5Wi96EM1RWKTqjWvig9heeKHSDr7a3TqsLJyCEFmHLS8JOVa8ZMB
 +jeX6fcIGDH7L7UoAhnN5c0tRRVHp1bn6FUl+wT0QS3gC0cNkmX3YZSy3HHxNXw7JTgSdO1XQ
 ftEQTKuBUAWoqjKe863l+mWdQdQVAJ0H6qs3VW0kG0F5LQnruciPg60Uy41KSJk00+5mxX2vh
 7eC7WD1G74Hhi4C9NeRc/+wFHDv8YAJBNH7qIJTYL7kGJbBNVSioVVXJaTa8mLJ/xJw8RYqT2
 gv1ovVbg6cZhZWurpbKTJdmvXSB4ep7epX/TylZKgeutiOUaChm+G78az6Rg4SBaSJTa1n9d2
 SOaxeCW+QCNVCm6NX5dYWPL/wemP14l2MT1FP1DZNeAGLCQLkWYrKQ6Gp+BrADW4agDlW2uaZ
 sOmUnk4KRgmaW97kf4IjSzvArxeiHCAi2x2U3gqZOZsRXwNNCGssyYfO5AYc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B9ptu0UfHjJLYN6aw9jil0ghgMfRZ6lkl
Content-Type: multipart/mixed; boundary="Uf12YxckWvrbGShSqiBcJPoGnTxdpBmgS"

--Uf12YxckWvrbGShSqiBcJPoGnTxdpBmgS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/5 =E4=B8=8A=E5=8D=888:47, Tomasz Chmielewski wrote:
> On 2019-11-02 12:38, Qu Wenruo wrote:
>> On 2019/11/2 =E4=B8=8A=E5=8D=889:13, Tomasz Chmielewski wrote:
>>> I'm getting these recently from time to time (first noticed in 5.3.x,=

>>> but maybe they were showing up before and I didn't notice).
>>>
>>> Everything seems to work fine so far. Anything to worry about?
>>
>> This is a warning about unaligned device size.
>>
>> You can either fix it by reducing the device size by 4K for each devic=
e,
>> or use btrfs rescue fix-dev-size unmounted to repair.
>=20
> Unfortunately "btrfs rescue fix-device-size" doesn't seem to help. I'm
> still seeing these entries in dmesg some time after using the command.
>=20
> Also:
>=20
> # umount /home
>=20
> # btrfs rescue fix-device-size /dev/sdb4
> Fixed device size for devid 2, old size: 3950855921152 new size:
> 3950855917568
> Fixed device size for devid 3, old size: 3950855921152 new size:
> 3950855917568
> Fixed super total bytes, old size: 7901711842304 new size: 790171183513=
6
> Fixed unaligned/mismatched total_bytes for super block and device items=


So far so good.

>=20
> # btrfs rescue fix-device-size /dev/sdb4
> No device size related problem found
>=20
> # btrfs rescue fix-device-size /dev/sda4
> No device size related problem found
>=20
> # dmesg -c
>=20
> # mount /home
>=20
>=20
> Now let's try to unmount and see what "btrfs rescue fix-device-size"
> shows again - I'd expect "No device size related problem found", correc=
t?
>=20
>=20
> # umount /home
>=20
> # btrfs rescue fix-device-size /dev/sda4
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> parent transid verify failed on 265344253952 wanted 42646 found 46119

This is not correct. What happened during your /home mount and unmount?

The fs looks already screwed up.

Thanks,
Qu

> Ignoring transid failure
> Fixed super total bytes, old size: 7901711842304 new size: 790171183513=
6
> Fixed unaligned/mismatched total_bytes for super block and device items=

>=20
> # btrfs rescue fix-device-size /dev/sda4
> No device size related problem found
>=20
> # btrfs rescue fix-device-size /dev/sdb4
> No device size related problem found
>=20
> # mount /home ; umount /home
>=20
> # btrfs rescue fix-device-size /dev/sdb4
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> parent transid verify failed on 265344253952 wanted 42646 found 46119
> Ignoring transid failure
> Fixed super total bytes, old size: 7901711842304 new size: 790171183513=
6
> Fixed unaligned/mismatched total_bytes for super block and device items=

>=20
> # mount /home
>=20
>=20
>=20
> Tomasz Chmielewski
> https://lxadm.com


--Uf12YxckWvrbGShSqiBcJPoGnTxdpBmgS--

--B9ptu0UfHjJLYN6aw9jil0ghgMfRZ6lkl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3Ax9AACgkQwj2R86El
/qi2CAf/Tmd6eEdMph34QxRqho1UXu5NQBUBlzGsPxRFiHvpzqaAvCJFxC0D/gO5
QIXA3v35nClGOu+0zYl+NEFJyVrD9FbDJPiVSFqc9uuZRrkk9UKQVs3wDnjRpgMJ
9YZ5/275f0kK4HAyMlTNir8ec9vm7AMfCkABNTEMpA/4RCubh9LCrb3ttGnGhwKo
EGrw8vMWBG0lYjXdR5eYb/n+32+Ot8XbrXgn1OjKTXz22sfhdeBUo0hOfyS/cQIZ
gWBedyDWtgoffw/Sb9/Izk5hS89cZ9/OxmuytM4g5C6EhrdA56zwTOslObp/coef
AoQm8olfdePiB8dIf0qrzVbwn1RWVw==
=k0ML
-----END PGP SIGNATURE-----

--B9ptu0UfHjJLYN6aw9jil0ghgMfRZ6lkl--
