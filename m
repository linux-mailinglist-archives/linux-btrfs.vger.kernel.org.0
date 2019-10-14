Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED71BD5983
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 04:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfJNCTs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Oct 2019 22:19:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:51163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbfJNCTs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Oct 2019 22:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571019585;
        bh=I/skHp7hmOaUJ21N0eSzA/EtirVrYpH5VCYpPPGbVnw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=K9DDuV1QJKFc1ppt5sTfDZIVN7wOegStP4/Wx9vIYdYeYaj97ukqz4FVfOPiyv6pD
         zSec3JQSmUTIznTEvK4s3zMjMY1j6T7zHPhDRopkDYWiPupIudiwRT5Arv9zvB92FV
         aTzfPMjUSrJp6jWwBL0RRY4JNq8hQvdKFB9Zs4dI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MaJ7v-1iXoSD00tZ-00WCFm; Mon, 14
 Oct 2019 04:19:45 +0200
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Adam Bahe <adambahe@gmail.com>, linux-btrfs@vger.kernel.org
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
 <ce6a9b8274f5af89d9378aa84e934ce3f3354acd.camel@scientia.net>
 <CAL3q7H5qNE4rizN14qmgrAwtju9KRHspKxo3S-PoTcSUvXYuew@mail.gmail.com>
 <8c0f8fff-5032-07b6-182c-1663d6f3f94e@petezilla.co.uk>
 <CACzgC9gvhGwyQAKm5J1smZZjim-ecEix62ZQCY-wwJYVzMmJ3Q@mail.gmail.com>
 <CACzgC9iSOraUua7YtPz-gsvNRF_6Fp3mvkBenETMsVNwnjvuuQ@mail.gmail.com>
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
Message-ID: <d4f2c381-9c79-651d-453b-947cad5ba958@gmx.com>
Date:   Mon, 14 Oct 2019 10:19:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CACzgC9iSOraUua7YtPz-gsvNRF_6Fp3mvkBenETMsVNwnjvuuQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UGReF0ndgf7a8OS6NHz9f7y6QEIg1T5J2"
X-Provags-ID: V03:K1:TugYYg1z9hYFXVxmJg0HbeYAWSXBT7K46Na0RRJMh7kK2u3PeoG
 VtRIvz/zKjQJZ59WZ0baGiIvU2ZmTWdm7CCN7i9UqzEOOJ738ZO2jUKoFbc2UxUugiMeAzd
 oXkJN1Y48YUYpm/CB5qW3oh53tM5jTruFOYDmJ5Zx/k8G5DCHi9iMBUwLiRXSmQU5cPanA7
 nqC0hzmExEnJuAvHMKJgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7sGJ9b5Foqo=:x3v0SnvKRy2TvCNZ9fTT3s
 It8kmxGctZw47T/23lTnoHLUegXzx1OD2xLdzsr/1SAa/dS6jjtKS5JJ6STWSXh4NkJ7t4XeW
 vM7pK26BqFzKRMBhHEDuAG7dLG1cz6Q0pii+80Qx8wyBVPfsNs2GdNmfQzrwLAu6dVH7rbPxE
 k304uQJf/euMI96WPzrYC83A5ze3iGlk6wdFDlIl5lvde8nbbCOTzaf7xopE1FPIU+UdqLGnj
 93soEaPF6E7cRKFW0/87iYe2QJ7lCakYA9BuNlSf4UgsAOlHCHdcc25hnt5ZKjsgSvPmTtGdL
 RohfDYbDUSlrvGa/yref95jLHr8Nefgu3cMPVXpkmAQ8a0hG/h7RAdjJiR7IrDvBSVczeFd81
 Z5ivEMTMOodpnMzkoL5VPe+z1CiNl+Us+MbsqI0A+nNO0NW1uvet1BbR4LJr67GNo3uOiBimN
 44n4l5ZPhJ33Rz7rld6iBTSEOZvEAWPLM0b4VgRjVKUbH5TRkMTKkciFFhNdNXUT09tpl4JKE
 ILPJjqGLHZXM8DOxkYmjcVo8ZO9d2/66C5oXqDJrVAdkiJqhfVl2b3iOlc4dS/OJKFVYFMjNB
 TISnM0+AhFQ7SYUjav1wa9BRkUI20erqe9aK8BOnSVMEfyn/QjdVLu15tjZEB8JEUEDs2EHNf
 FVdzj27Nk2jNS1x4a7xoGSDtipMMOxYrpl9f08Qvi0qfmtJMDGmfjVipKMPELiYyiWpgGr37R
 9lxtrSNp8MKyCW4nuvhXRCx1n4USnNTK1jt1OCFJG6Xd4FlIJeD2OaWgTVh9Uk/Xfc52Ud77+
 MQk1Bj/52ogTf106HnE4vzU0sSsJP/019sGpsn1m6hGmGdn8uBIk0jnd1C3NlvCHceH5ujLtQ
 tD5SxciYGCUC40Ix9nOMszckIToxAlohWl5vENuqqxQsQPSAyJDnIvjeHtBdCNK+L4mN93kLB
 83nEVFLSrsun0cGqviimLsFAL+mqOsmC62rol68Ti9tz+fcqrxaCHRX+9cFY88DZZaDBlfn1w
 4pKsmMxqBn96FA3rX5PkeC04FUhmHFCgapcHo4BgjA3XUDaYuiaIpsirKtqyLNB+8U7X5T9LV
 NosklvK+4I1b1WkNCdYyESX2ArSkZQe4AxV71Dhusk/YsLcHyy8Zum6mNXoAhOOXwr8VTNLx0
 JSM5rmOjJv7F1E2nAvOBrYMoO5Rl7t40v4+4Oj8aWLxqrgo264zYXeNbNDuAjuS7cs9XOzNdy
 snj7+KroOnvON+/7T/csbfHpkbuEYUgjfTcQtx380B0ZM/poj20zF1qappsE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UGReF0ndgf7a8OS6NHz9f7y6QEIg1T5J2
Content-Type: multipart/mixed; boundary="POkeIMUEdVZneCITdkigh5gfM6gaIydVk"

--POkeIMUEdVZneCITdkigh5gfM6gaIydVk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/14 =E4=B8=8A=E5=8D=8810:07, Adam Bahe wrote:
>> Until the fix gets merged to 5.2 kernels (and 5.3), I don't really rec=
ommend running 5.2 or 5.3.
>=20
> I know fixes went in to distro specific kernels. But wanted to verify
> if the fix went into the vanilla kernel.org kernel? If so, what
> version should be safe? ex:
> https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.3.6
>=20
> With 180 raw TB in raid1 I just want to be explicit. Thanks!

v5.2.15 and newer.
v5.3.0 and newer.

Kernels before v5.2 are not affected.

Thanks,
Qu
>=20
>=20
> On Sun, Oct 13, 2019 at 9:01 PM Adam Bahe <adambahe@gmail.com> wrote:
>>
>>> Until the fix gets merged to 5.2 kernels (and 5.3), I don't really re=
commend running 5.2 or 5.3.
>>
>> I know fixes went in to distro specific kernels. But wanted to verify =
if the fix went into the vanilla kernel.org kernel? If so, what version s=
hould be safe?
>>
>> ex: https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.3.6
>>
>> With 180 raw TB in raid1 I just want to be explicit. Thanks!
>>
>> On Fri, Sep 13, 2019 at 11:16 PM Pete <pete@petezilla.co.uk> wrote:
>>>
>>> On 9/12/19 3:28 PM, Filipe Manana wrote:
>>>
>>>>>> 2) writeback for some btree nodes may never be started and we end =
up
>>>>>> committing a transaction without noticing that. This is really
>>>>>> serious
>>>>>> and that will lead to the "parent transid verify failed on ..."
>>>>>> messages.
>>>
>>>> Two people reported the hang yesterday here on the list, plus at lea=
st
>>>> one more some weeks ago.
>>>
>>> This was one of my messages that I got when I reported an issue in th=
e
>>> thread 'Chasing IO errors' which occurred in mid to late August.
>>>
>>>
>>>> I hit it myself once last week and once 2 evenings ago with test cas=
es
>>>> from fstests after changing my development branch from 5.1 to 5.3-rc=
X.
>>>>
>>>> To hit any of the problems, sure, you still need to have some bad
>>>> luck, but it's impossible to tell how likely to run into it.
>>>> It depends on so many things, from workloads, system configuration, =
etc.
>>>> No matter how likely (and how likely will not be the same for
>>>> everyone), it's serious because if it happens you can get a corrupt
>>>> filesystem.
>>>
>>> I can't help you with any specifics workloads causing it.  I just
>>> notices that my fs went read only, that is all.
>>>
>>>


--POkeIMUEdVZneCITdkigh5gfM6gaIydVk--

--UGReF0ndgf7a8OS6NHz9f7y6QEIg1T5J2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2j2zoACgkQwj2R86El
/qjS4wf/UDXSA1iTGlZSvSxZSXm2EgO6wzO+WPfiqbUJIPG2xa1+Z7LNVd+c6OdV
vGeulPNVvqKxVY/dNhbN2az7dsHzQig7T7mKxpjjsBsbYDnrXIUlTZli9BzYN1Zu
bCCFySrtewJR2NtjAOS4dHdkCiglvlW0IgHzl96YZSYZYHMvB2+mAWE6f1mcRAfa
QK+eYeMilp+sWAa/NNkkkNJ+T7Uw5bVIRPjBCjym5D+ZFzJQMHHk1TaCOygsvjM9
SNUZYAC8m/lgHO6Lb2nGTm5kk+oteEyNJSLp7MmNPYAGERrenMOr4qAjXnRc2URC
8n4FO2peawTGCEjd0WnccLhFvS38hw==
=vgMH
-----END PGP SIGNATURE-----

--UGReF0ndgf7a8OS6NHz9f7y6QEIg1T5J2--
