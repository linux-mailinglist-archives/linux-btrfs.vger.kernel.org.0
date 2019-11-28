Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21C10C8C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 13:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfK1Mky (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 07:40:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:55475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1Mky (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 07:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574944776;
        bh=SKCMaRH936zg97zI02QMPiRAQPGPng8JCMN2Jdah1rw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aYvIuAZolZORvTxxHDjNJLhGr0rmmaK1ftjUm7lHMjfcGHNjn8uCrBTqIOQi2muC3
         0DGsoXTjnCuzeFaiVgKzjeD4u1AfjuiOsY+wNLMAioC3D41mLOz5lkUCFha8mEttEa
         p0NPw95FnDRlAmvmtjZ1Zro5H3QQjzhlN0Is1Rrc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Rm-1iEnxB4ADW-00La9l; Thu, 28
 Nov 2019 13:39:36 +0100
Subject: Re: [PATCH 3/3] btrfs: volumes: Allocate degraded chunks if rw
 devices can't fullfil a chunk
To:     Qu WenRuo <wqu@suse.com>, "dsterba@suse.cz" <dsterba@suse.cz>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-4-wqu@suse.com>
 <6cc25dbd-55e4-43bb-7b95-86c62bee27c7@oracle.com>
 <f928122d-4e77-e83b-9a53-d2eea7ee16d3@gmx.com>
 <20191127192329.GA2734@twin.jikos.cz>
 <8c0a2816-1a7d-7d75-f591-c8712a85efd5@gmx.com>
 <20191128112449.GF2734@twin.jikos.cz>
 <366d5a96-4670-5839-6bef-e8d3a77fd00b@suse.com>
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
Message-ID: <4eb3d18b-b938-c52d-8cc8-c21433c15183@gmx.com>
Date:   Thu, 28 Nov 2019 20:39:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <366d5a96-4670-5839-6bef-e8d3a77fd00b@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uJWQPLi11BvHrGijVpM4HWv785P6o4D71"
X-Provags-ID: V03:K1:Jzw7In5czesBgnxpLXYzovjQ4fwWdc2H2hBbTqyNhBlr4apjLgs
 DJYXUDnwKqzo0DUUbqOIHOzpOI5UacWnbb9cyNlvcYI+5I6lRiAsqoUJKB+v8W1nFtxjg8A
 Cn3zdmQ3PqnbFUxbhp7tVVl9Q27/qYiW+U1+mNE5MJBb8P2V+VKtczdHlF6szHr20zMCaAB
 gLaecbVrXQonquK/fPaIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xm8t3foxMkQ=:K/1JipKKS38Sg1uybPMzao
 CmtKozhAJr2xNedJbTcyjzyt+sUe/jU6h1RY+T1MifertcOAq1BDrMxiWi9lUY/j//t8GYZ1/
 D/8QBJ/f6JWed6OsWZVqFkbtgsWvd8LwTUTBqNUHYBX1dL8S7OjI8uiMGkTp28otcNByQhBDh
 WwFb9vI1KpUQfyAhFOe+f9mMqzUgF1Rw0Mt1bOgsuuRBMwOVSYEHOBA9nhOb2EhnqgGBs5iwe
 DbSasfLJ+9xYeb/eEW1lYy8rMgEKoASruaofWo+lIBd1yygrlEqnudzLkxPn5Q+v/xrxf+Y1N
 Zv+BXzu/lHo07RD8TrqWGhBK8O8eNlGcgSL/StL+SdGt4j6YppiNgxDcrU54q1qDS3V3zySuE
 1CBsisx1v1On8IgJRPADKtpsk5CY8oxbsu/vT/7oqlOmfocl1hnsaXdYIIPxRNYkioTNfP2Wq
 v2NufRX0HcEItFFTtt2tgNvNzvtKksc3hdX2KULGvxC5eFBlRaFLnFYxtNF2dotof5I8JUyB4
 QJYXK7/rQQrL+0A8a42sZe2h+2aKOURFSCemc9hGbOyh2aSymKdjcbzXRVAmOYHV1euVyqDbd
 Jrj4Qc5R3fi82Vm/2A8iEHVFt4mmB9u7+PVJLHOrcGqmYnjkRTy0nRQQNlqMCY0MdFxiUj0TL
 kTILl96x1wBIh0j0iSqrOFlUQhTlaosGqATDeNBxjpjbFCapIiljUx/XBGf29gY/cgCzenub6
 /dRdElAM7kispu6+sTJGEX0ao8zYZhHr33CZa2pgiZHmHvSTy4R7/V8PTLbmkjZ/VK5k32bE3
 Vcz08aVClWvowo614j2Ey/e0fudiY43KMQTmHQZkblPSHP9D0oLafNRDy50w5UIPyktHMUcUM
 PWgOCCJ+VdQkCvJznmFCZ8uGOzS58H+5EuSNRV/+q9DQWkbm590Y6G05H3tT4KznuZoLpDy0W
 GsBp3DhKBLid4mjrP8Ur9IXUaqYdpCrYv7VPOVkGksoSpMUlUyxccBpPKWxHa0UN8s7XZsL6D
 YPn6vbc6iA84ORGDpk/zmxuMA2P7axeMXnHDGL8JrFKDdLEngk32ojxUWU7dJoa1J0WuVjOMb
 8///dAxofPqqRd0iX3Ca/gbKbn5MjDxQCwlpSqJXDq2hfVxe8uA/+D0+66aSAoXO2J1AYBhOO
 sXtgGEVhDEtXT58HCWI1133i67j1YydAqDpfipawvG7ODwJU9NnhZdMcLwJkql3/WIGnjVDVE
 YeycelztpAk80dnP4AFm94piwj6jwpf8lAwzEm7hksLonPQlndO5a8mlXunM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uJWQPLi11BvHrGijVpM4HWv785P6o4D71
Content-Type: multipart/mixed; boundary="mfwFf28n43XKHGKDlL0gAP0JDVB2q9Xc8"

--mfwFf28n43XKHGKDlL0gAP0JDVB2q9Xc8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/28 =E4=B8=8B=E5=8D=888:30, Qu WenRuo wrote:
>=20
>=20
> On 2019/11/28 =E4=B8=8B=E5=8D=887:24, David Sterba wrote:
>> On Thu, Nov 28, 2019 at 07:36:41AM +0800, Qu Wenruo wrote:
>>> On 2019/11/28 =E4=B8=8A=E5=8D=883:23, David Sterba wrote:
>>>> On Tue, Nov 19, 2019 at 06:41:49PM +0800, Qu Wenruo wrote:
>>>>> On 2019/11/19 =E4=B8=8B=E5=8D=886:05, Anand Jain wrote:
>>>>>> On 11/7/19 2:27 PM, Qu Wenruo wrote:
>>>>>>> [PROBLEM]
>>>>>>> Btrfs degraded mount will fallback to SINGLE profile if there are=
 not
>>>>>>> enough devices:
>>>>>>
>>>>>> =C2=A0Its better to keep it like this for now until there is a fix=
 for the
>>>>>> =C2=A0write hole. Otherwise hitting the write hole bug in case of =
degraded
>>>>>> =C2=A0raid1 will be more prevalent.
>>>>>
>>>>> Write hole should be a problem for RAID5/6, not the degraded chunk
>>>>> feature itself.
>>>>>
>>>>> Furthermore, this design will try to avoid allocating chunks using
>>>>> missing devices.
>>>>> So even for 3 devices RAID5, new chunks will be allocated by using
>>>>> existing devices (2 devices RAID5), so no new write hole is introdu=
ced.
>>>>
>>>> That this would allow a 2 device raid5 (from expected 3) is similar =
to
>>>> the reduced chunks, but now hidden because we don't have a detailed
>>>> report for stripes on devices. And rebalance would be needed to make=

>>>> sure that's the filesystem is again 3 devices (and 1 device lost
>>>> tolerant).
>>>>
>>>> This is different to the 1 device missing for raid1, where scrub can=

>>>> fix that (expected), but the balance is IMHO not.
>>>>
>>>> I'd suggest to allow allocation from missing devices only from the
>>>> profiles with redundancy. For now.
>>>
>>> But RAID5 itself supports 2 devices, right?
>>> And even 2 devices RAID5 can still tolerant 1 missing device.
>>
>>> The tolerance hasn't changed in that case, just unbalanced disk usage=
 then.
>>
>> Ah right, the constraints are still fine. That the usage is unbalanced=

>> is something I'd still consider a problem because it's silently changi=
ng
>> the layout from the one that was set by user.
>>
>> As there are two conflicting ways to continue from the missing device =
state:
>>
>> - try to use remaining devices to allow writes but change the layout
>> - don't allow writes, let user/admin sort it out
>>
>> I'd rather have more time to understand the implications and try to
>> experiment with that.
>>
> Ah, makes sense.
>=20
> So no need for a new version.
>=20
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>=20
> Thanks,
> Qu
>=20
Facepalm, that's for another thread....

Reviewing patch from myself, WTF....


--mfwFf28n43XKHGKDlL0gAP0JDVB2q9Xc8--

--uJWQPLi11BvHrGijVpM4HWv785P6o4D71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3fwAMACgkQwj2R86El
/qiPWQf/bDgLwDe1tQzltFv7emeMqoq0gpDW8sT+raY46rWd1DuP8oYw2Az7kfG6
A0955olAxHcVbhHhJ7LUHE+/fi+p25UlL5bPAFfbiuiAiPpEe3VtlbeBCsf2pwgM
+3tr+wLm3rzEkuCg3kDZuZLjp7NYoxr0qa/4ov8wjvuY2y2pM4VEVYWmh6YMEuFy
AEcJJgnKAlp6stTrUcwLdE5qqW385TUoRrRY5kLtq5V++xnjfa5iKKijA3sW04L/
XqRk1JOyLECVbISXd/WvaaTFBPTUZYyYoVR+OkzdCbWcSy1VhG9RIcBVb5CMoHzt
H7Lpw1k1mpdUMUOH8B40J2GjdQWoUQ==
=niz+
-----END PGP SIGNATURE-----

--uJWQPLi11BvHrGijVpM4HWv785P6o4D71--
