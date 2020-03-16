Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40021186AE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgCPMcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 08:32:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:34627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbgCPMcU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 08:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584361933;
        bh=3dSJCHs/7zsTUbQjTa2bBPmnFYvAyikXlD6bhsk2H04=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Nr7GnTJ9ggbhwvtgzYP1WSp6+3sSwrm2TIOvKPa+hCVEHuew1nKQD4V2bXNRSjkh7
         JaO8vhtQZBB/sz1o6qA6sLTHhqX2vUSx3maYUIqN7m35vK4YiTHtyTmIOsfNO2YoCm
         ivulnDTv9ykGbPLUFNTyRIy9S6peNMHqNnPo53UA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mq2nA-1ji9ja1Mp8-00n77M; Mon, 16
 Mar 2020 13:32:12 +0100
Subject: Re: kernel panic after upgrading to Linux 5.5
To:     Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8374ca28bc970a51b3378a5a92939c01@wpkg.org>
 <fa4d1bf5-b800-edba-1fce-ae7108ae023b@gmx.com>
 <553b4596301e2e7bfa05476065c195d0@wpkg.org>
 <9711f986-0083-0866-68b7-f1cd8e35db11@gmx.com>
 <910611ad09d3efb53b13b77bf3c4d99c@wpkg.org>
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
Message-ID: <1687a3f6-d263-c3f6-fae2-522a05830f10@gmx.com>
Date:   Mon, 16 Mar 2020 20:32:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <910611ad09d3efb53b13b77bf3c4d99c@wpkg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UBqDLHzF5Wt82OwvxWzckmSqaUAVMPcOf"
X-Provags-ID: V03:K1:TsDVLPeDs782cudd3ubaoGchvajpsQ4I0R9f5kuc9FI/Jmy65Ns
 vLAQzS56yDJifGn/4gsuTh7v94cIxcUPUJriwbNP0ye9Zk0Lns9JkKQTOVOjNgZccQkaRWY
 brFI8KOie4hvxqGa9mrtxdW//NRLQwwMmUtLAqInRETbL9U4DGx3U3f2rrnl3dU8saZK5k3
 6lQk23p7QugdNTZJRmawg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dge6Sm3ZnqI=:oL4m7ymep6iL/c+VvjfUtu
 n4ndACUjLNYWWeRn5ZgXAeQxmTL8RW/HJaEzDHQ7wSvDQu66OjZA2P5j0iRuRE+CAAVMsXKot
 d5chwfsLIuvcvs+h6o/JzhK+Eu4NGWAjyH7ryj+azlJ0TFm9W0kMQlIdjpz6E/rljfaKdIRVl
 Nnk0RSpkPvN/6Us2d0iA3L2TX12CcAqnwY1yBblntPhKHIVHzV3O4PAI1xVFxyp6KGn4uTtgD
 HsjGfVXng4h9IKm7mh3fMK31osrwbZO7rHx3Xmrl8bcBKCVt4A0Ua0EcVfPktuWyGSOzF3O3O
 JgUVYDOLdHCx2ayGlpa7kBbY/XoUAdc4+/Vej833bhRF05phJIAtMfw32rh3YCg5yQQSjGAKG
 STJt11jdDmNZVoMVqtlqRorY4Z+m0b62bFMKrHY8silxhA8YfjNwhjR83vR/dAWvOvf4HRk8Z
 hrRTliFUFD2xBtgoLn7dcQ6uAMeE+9cc+BAqQk0h2m2rsdJrWsddZXH1hwCC+3TBir4Of/opX
 mfz3ougnwzrfO9LR2xFMyQPBfzGAeNKDkHN/xRTa52AggY6jd33Uq+O4370sUn5NUP+on22dg
 Q17LMB2/L0m6vmGuSgGbL2sxJvHttyqYDDk0Jx5Wme/gBdP/Zi/pESaMl+QI1ZRwxNjk33Ijz
 9Dth3Wl/yjHEZYreSrpITF/0iSBYwsXK5ArmREm9ixHHTsjiPQgytiQrmpbmkAosIzxk9sNkg
 t29B0tyudIte6AC8x8CbU/B82uUDSU3rBsGpX0oGJ1Q6g3RMzql0Rhj9B/ga/KRqeMUiNggzS
 0OapR+LnVIvqI/E1zuMFF10y5Gl2rQYAgo4EACVauxG8iInpRun0tNtwm0WxWxgK8kEU4EWh7
 2VeNcpWSLsif8ve80bUqIfvGFCeYPREnNhhThDCPqX5AML/N4ZGsXF49nev7LpzYA1boDvl4w
 mRwbHjjC7Mi04nVnGdMekGCYAM7BXHHgxnw+9Flk6Jl9a41aHKeYRT4HchJliGGRHGmTrGBfG
 hSXRjYuUGClZVQepy1GNnVRWLQikjbwKWu78mwxWTeeyieCE0sV+xoK9agEJZq8rAbZWYCEGY
 FYmK8nc/B4O9dppjmGPYW6VOiGJ3aGXPgkOaz6fASMwOEzFxCI7pzGrh1ZU/l73Zyc5Lm0TcW
 fcfzNa3KdcMMLXjb++sEaeqH9CsSXbkSuIx9dTv/kL3qjrWav/1Eb6SLnk57tWIcQC+zVJjGq
 5K1f8O3FfnyTdHKlI
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UBqDLHzF5Wt82OwvxWzckmSqaUAVMPcOf
Content-Type: multipart/mixed; boundary="NaN0IvMU5E0vYbtqXi0WKKrcG0qM0cEex"

--NaN0IvMU5E0vYbtqXi0WKKrcG0qM0cEex
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/16 =E4=B8=8B=E5=8D=888:14, Tomasz Chmielewski wrote:
> On 2020-03-16 19:26, Qu Wenruo wrote:
>> On 2020/3/16 =E4=B8=8B=E5=8D=881:19, Tomasz Chmielewski wrote:
>>> On 2020-03-16 14:06, Qu Wenruo wrote:
>>>> On 2020/3/16 =E4=B8=8A=E5=8D=8811:13, Tomasz Chmielewski wrote:
>>>>> After upgrading to Linux 5.5 (tried 5.5.6, 5.5.9, also 5.6.0-rc5), =
the
>>>>> system panics shortly after mounting and starting to use a btrfs
>>>>> filesystem. Here is a dmesg - please advise how to deal with it.
>>>>> It has since crashed several times, because of panic=3D10 parameter=

>>>>> (system boots, runs for a while, crashes, boots again, and so on).
>>>>>
>>>>> Mount options:
>>>>>
>>>>> noatime,ssd,space_cache=3Dv2,user_subvol_rm_allowed
>>>>>
>>>>>
>>>>>
>>>>> [=C2=A0=C2=A0 65.777428] BTRFS info (device sda2): enabling ssd opt=
imizations
>>>>> [=C2=A0=C2=A0 65.777435] BTRFS info (device sda2): using free space=
 tree
>>>>> [=C2=A0=C2=A0 65.777436] BTRFS info (device sda2): has skinny exten=
ts
>>>>> [=C2=A0=C2=A0 98.225099] BTRFS error (device sda2): parent transid =
verify failed
>>>>> on 19718118866944 wanted 664218442 found 674530371
>>>>> [=C2=A0=C2=A0 98.225594] BTRFS error (device sda2): parent transid =
verify failed
>>>>> on 19718118866944 wanted 664218442 found 674530371
>>>>
>>>> This is the root cause, not quota.
>>>>
>>>> The metadata is already corrupted, and quota is the first to complai=
n
>>>> about it.
>>>
>>> Still, should it crash the server, putting it into a cycle of
>>> crash-boot-crash-boot, possibly breaking the filesystem even more?
>>
>> The transid mismatch in the first place is the cause, and I'm not sure=

>> how it happened.
>>
>> Did you have any history of the kernel used on that server?
>>
>> Some potential corruption source includes the v5.2.0~v5.2.14, which
>> could cause some tree block not written to disk.
>=20
> Yes, it used to run a lot of kernel, starting with 4.18 or perhaps even=

> earlier.
>=20
>=20
>>> Also, how do I fix that corruption?
>>>
>>> This server had a drive added, a full balance (to RAID-10 for data an=
d
>>> metadata) and scrub a few weeks ago, with no errors. Running scrub no=
w
>>> to see if it shows up anything.
>>
>> Then at least at that time, it's not corrupted.
>>
>> Is there any sudden powerloss happened in recent days?
>> Another potential cause is out of spec FLUSH/FUA behavior, which means=

>> the hard disk controller is not reporting correct FLUSH/FUA finish.
>>
>> That means if you use the same disk/controller, and manually to cause
>> powerloss, it would fail just after several cycle.
>=20
> Powerloss - possibly there was.

Don't get me wrong, all modern fs should survive unexpected power loss
in theory.

If it has ran v5.2.0~v5.2.14, and power loss happened, it would be
pretty possible that v5.2.0~v5.2.14 is the cause.

If v5.2.0~v5.2.14 is not involved, and there is no extra layer between
btrfs and the block device, then I may suspect the disk (and maybe do
powerloss tests to ensure it's the disk not btrfs).

Anyway, to be clear again, if everything works as expected, then
powerloss shouldn't cause anything wrong on btrfs.

Thanks,
Qu

>=20
>=20
> Tomasz


--NaN0IvMU5E0vYbtqXi0WKKrcG0qM0cEex--

--UBqDLHzF5Wt82OwvxWzckmSqaUAVMPcOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5vcccACgkQwj2R86El
/qgkLAf/XFBajASOrTB0d1KpUE4N2dpbBGhZiHXoBWq7LWwqZpq2GvsuWNC158Rp
L6dhKUvIhB3XrvC+K9NTD9YCs3Wr3pXDMuL+iiGfKU26TQ6mJlzXD2RWZwdvDOl+
PDv8sJvIBnlmH6Pv/oU+6XEy3VSVnKO/M7+zVJMK9Vs7rD4l0GIgS7sbSP8JrHjT
rhCHw5sZUt10SgVUaxpb9QhaFJ+FeX0jQqA4ORXo3u8QxLKcNybcsOWBkN5q/rrH
AfCBe8r+Ja2uVP/sdQSnYIiPNiHL9XscIWvyXW//QwtwwJ2bpnYhBviWo/wQIf7U
SgpBPa4yVV4DQ++S6PCGpX+DYQaXkA==
=RaB0
-----END PGP SIGNATURE-----

--UBqDLHzF5Wt82OwvxWzckmSqaUAVMPcOf--
