Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35452830BD
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgJEHQB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 03:16:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:59395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJEHQA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Oct 2020 03:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601882157;
        bh=+8mfqq5Bq/Weu5FbeMj18EcIUcVmAokWG6WQLi+HQSw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZPUfoiZBYZNqHqKPOA/S/dzQr/rYM0wVPOsGMm7tmw/+fUKGho9nuvgkI8mVJKrjY
         3t+NIp5E+AmEnGvlXMXqUr7RrK+cwNqF3lBTa8pCBz8iZStds5bjCXOdiIHIXVCz25
         tWlWh9mGI5RZ0900wbyPHiae/3RFpLX33vzqG7b8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1kXxfw0sjY-00zl0o; Mon, 05
 Oct 2020 09:15:56 +0200
Subject: Re: BTRFS device unmountable after system freeze
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Pet Eren <peteren@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <trinity-8bafe7e4-3944-4586-8ccf-01fca6664979-1601808281835@3c-app-mailcom-bs04>
 <1c7b7bf3-5912-3d51-c1f2-5c2c889367f6@gmx.com>
 <CAJCQCtQSy5Dknp46G08YHU2XxBuhKO2uCGkyU-eptHx4QSKRvw@mail.gmail.com>
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
Message-ID: <a7f5c202-0a6d-9253-b7ac-49fe89c9d703@gmx.com>
Date:   Mon, 5 Oct 2020 15:15:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQSy5Dknp46G08YHU2XxBuhKO2uCGkyU-eptHx4QSKRvw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RbgKwJp3llNMi4ViInsIk6ZLI1bONxQPz"
X-Provags-ID: V03:K1:i/BLAEntDpPfwifeps1AsdBDoWKAOzMOoZNSusXpOzS9d3iCARW
 pGKFBfIO3jChZYYYHySH0VAQq2tUgmRXE25E84nSJNbvUrA+32epwlzLKEPwH0ZOYuPCP9o
 RZTRZ3r10wpYKKSK505osVqvk8cfDraeyJ5uYCnzX9vuJAcRRL3TYHoHF5OSX9kQYu+0DEF
 wdKpVAYnO9hYBw3wac82A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3BzcTCHh3RU=:cDSLNR+6DLzplgyqlkNQ9z
 lgNuhCNc6tAU7MosHt6eChQKZp+i+9uYh4+nmq0BHbsgWi4BdFZesvn/b7f0gDNuhKmWQlsCa
 D0uYdPooQxA9JyJIKm7ODbfIAD53DZ4DLre2uCKq11pa3R0E+OLPT4D4x4OwqgDi3S+RME2Ew
 GM/8f2zl6gJMUIzchGww2i/tPIHUlaZNktWCjq9oNnnn9MhbpebvV4sxwTt2eRO/TcentkaXH
 TWPIEsSNo80w3gnX8erQ2oSWiZbkDbMdB1NAH6a0pNHJ3FVnpGQ4gTpYtoeC4/pNFPbWtpwYH
 cy0yl8mAEGZHL3mPnIwxuDmH4RzaKfUBey6H96c69iXvxOR9x2vKWHrZ3+lYxzx0YuyjpuZTl
 +VZmV45gakocFbQVp2p5WMW0IBPVk8Dd8S+8STr5Zilx5OyexHBl0ilrPy2ej70YBfId2YzH7
 HfmpfQe5Evngg2DuHRf0djkj4Oven8iPc6psGPuEr+qgjLvfZ1Jabhh8SNVTv/Z+VTIu79OUd
 qV2uFZzeJpWfns8PC/MVk4caz2viXlFY0qwK2P2TYUri76dCnsgNFBFeXET/zEixWn2PfNQD7
 OLSGiSdFro/H0QFKrhKT/aWURXyfvvni5fSvllWZGlS10TS3uOpor9IgDGo944x8NuMkz4yhT
 zeehafQuuOqb3Qaj23g1Ymvy+qjh9OREVYd12DEsr4qH4yYrDvFI7q4zzSR3bStYJQV7BR9xC
 ZcLOmXjwSDy6hWFKgHVHJnm1K/tQ89gpgdpix7ejTFMRYloOOJbXU8Cnx3s3p+mlwtjY01no0
 PZdOcOda/vrLFjm9ms+cDV7eRe4t/NGhQGK9bNcsNnYF+u1mECpTOnQsldDw1r0Qv6M00+ytH
 oyu3sxlO8r36JT2o8xXLOa7mX3FM5ES6WBo2cHhCyoC2YvGcI2dqeL6MK7/XKoB/AnIzhqUGk
 zU1Ftj+D+BJJZaCUl0nvokbrPszbOIGLyFPVSZDOFRF4SBWAsd3WEXvA/yhkO9wGA/9CH1RrC
 OKS4VRj9S2IfdJMvPw+nUKXRE6G8wBhKgyDa+J3ph0X7BS5mSVAeUsueq1FeixZn3Klu3sHbt
 ve53r21JLYWnHYtTfHhp58FDY7D4TWfl/AGbSY0Q7C4g/T+p9gN2Vio2MEmrRKtezoTNppMxD
 0ELKaqKAflu2LI4N+VjQyUw7KFmbX7S0wRq+JoKrfMI9C1C32vxRBHvu7kUm1uo2N49ucK5ks
 0kjW6eZhJcpQRINJdig9/lPQY8naB/LDHzxQJFA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RbgKwJp3llNMi4ViInsIk6ZLI1bONxQPz
Content-Type: multipart/mixed; boundary="Z8c60uJCdAz7XI6ynREwqfUG5azjh2vMC"

--Z8c60uJCdAz7XI6ynREwqfUG5azjh2vMC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/5 =E4=B8=8B=E5=8D=882:01, Chris Murphy wrote:
> On Sun, Oct 4, 2020 at 6:12 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/10/4 =E4=B8=8B=E5=8D=886:44, Pet Eren wrote:
>>> Hi there!
>>>
>>> I have been using BTRFS on an external hdd (WD Elements 8TB, Single m=
ode, data, metadata and system in DUP). The device is LUKS encrypted.
>>> After my Ubuntu 18.04 freezed, I can unlock LUKS, but I am not able t=
o mount the BTRFS filesystem.
>>>
>>> - uname -a =3D 5.8.6-1-MANJARO
>>> - btrfs --version =3D btrfs-progs v5.7
>>> - btrfs fi show =3D Label: 'Elements'  uuid: 62a62962-2ad6-45db-a3ad-=
77d7f64983e8
>>>                           Total devices 1 FS bytes used 2.81TiB
>>>                           devid    1 size 7.28TiB used 5.77TiB path /=
dev/mapper/elements
>>> - btrfs fi df /home =3D Unfortunatly I am not able to mount de btrfs =
filesystem
>>> - dmesg:
>>> [560852.004810] BTRFS info (device dm-4): disk space caching is enabl=
ed
>>> [560852.004812] BTRFS info (device dm-4): has skinny extents
>>> [560852.552878] BTRFS critical (device dm-4): corrupt leaf: block=3D2=
90783232 slot=3D81 extent bytenr=3D2054053203968 len=3D262144 invalid gen=
eration, have 878116864 expect (0, 1475717]
>>> [560852.552884] BTRFS error (device dm-4): block=3D290783232 read tim=
e tree block corruption detected
>>> [560852.557557] BTRFS critical (device dm-4): corrupt leaf: block=3D2=
90783232 slot=3D81 extent bytenr=3D2054053203968 len=3D262144 invalid gen=
eration, have 878116864 expect (0, 1475717]
>>> [560852.557564] BTRFS error (device dm-4): block=3D290783232 read tim=
e tree block corruption detected
>>> [560852.557605] BTRFS error (device dm-4): failed to read block group=
s: -5
>>> [560852.616539] BTRFS error (device dm-4): open_ctree failed
>>>
>>> I also tried to mount the device on another system (where the volume =
is created) with the same results:
>>> - uname -a =3D 4.15.0-118-generic
>>> - btrfs --version =3D btrfs-progs v4.15.1
>>>
>>>
>>> sudo btrfs check --readonly /dev/mapper/elements
>>> Ends like this (with many more "Error: invalid generation for extent"=
 lines)
>>> ..
>>> ERROR: invalid generation for extent 4552998985728, have 150461808037=
10188199 expect (0, 1475717]
>>> ERROR: invalid generation for extent 4555984134144, have 692194499035=
0260720 expect (0, 1475717]
>>> ERROR: invalid generation for extent 4556810252288, have 133837308938=
51772781 expect (0, 1475717]
>>> ERROR: invalid generation for extent 4558174781440, have 864906746759=
2986678 expect (0, 1475717]
>>> ERROR: invalid generation for extent 4558308999168, have 129530214745=
35714951 expect (0, 1475717]
>>
>> Only extent tree corruptions, not a big problem.
>>
>> Nothing of your fs is lost, just kernel is too sensitive to any possib=
le
>> corrupted metadata, thus rejecting it completely, to avoid further pro=
blems.
>>
>> In fact, if you go several kernel version backward, you can mount the =
fs
>> without problem.
>=20
> Well he tried with 4.15 and got the same messages. Would '-o
> usebackuproot' work here? Or is it corruption older than just this one
> crash?
>=20

v4.15 is heavily backported, even for the stable branch.

We need to go several releases back to the v4.15 kernel which doesn't
has such check.

Thanks,
Qu


--Z8c60uJCdAz7XI6ynREwqfUG5azjh2vMC--

--RbgKwJp3llNMi4ViInsIk6ZLI1bONxQPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl96yCkACgkQwj2R86El
/qhNdAf2IUDzHfbFbzOaMwayc6VNdxXntIVUanm2FNAExmsKm38oftN/++atW0/c
c8urRI7PvtvHR7a1j8lXLzcNux0ty7AoLvC+TZ5XpXwQSvMdEjt6VGoB0rrA/X0k
J6VU9PLJ75mVy4QZCnunhslDm1oLVRRlitAHSKvhZizqO1BOc1i6nKkahpKBBRCn
ZL7LBhm6MEJnJ79pQEb5j3N8OQ210Iox+AF0mOqO6Jk3F8oAJafvtLAlBW/r1ddI
uKg875I3QRx7RLYcIELL6UeeAbypJYTLb3OJanjLQIxQhiE03EN6Fic4ttvsNEX4
1SvQeF8V3Szs3ENGAwZEZzSK7PFO
=D1Pk
-----END PGP SIGNATURE-----

--RbgKwJp3llNMi4ViInsIk6ZLI1bONxQPz--
