Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C948116484
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 01:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfLIAll (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Dec 2019 19:41:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:34291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfLIAll (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Dec 2019 19:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575852099;
        bh=4EaKhzcczDGW4Nhw5kmKqMvm7Si+S0R40fAzo2Cw3do=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eF0Ly8kTioilUBTmJ1NvGXZ7/7vapi+updKcl3Z3Fu3xUJ5zprrterJASO3lWuTz6
         bkyrqOh+J0EVzroE+ZAdzhYiDAsgcfsZvfNX4j+XMWil26ZjDFIFGD2xSizUSAFi2o
         WHEn/5AVPgCqCVISWljXVYctE2PYBRbmjXZ+vjOE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZCfD-1iHvYK2gin-00V6CX; Mon, 09
 Dec 2019 01:41:38 +0100
Subject: Re: Unable to remove directory entry
To:     Mike Gilbert <floppymaster@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAJ0EP41toGSPQwB4Ys4aNzGGJNDBS-NHgPOcGanBk6d6Nn_LWw@mail.gmail.com>
 <5eae7d6d-a462-53f4-df0c-3b273426e2b2@gmx.com>
 <CAJ0EP40Wj59=CevVnn1rjxoc4CtGqbRjKFBSbU8BsrSjRC48ng@mail.gmail.com>
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
Message-ID: <6c3454b9-cc23-d22b-c3a7-59697add9b88@gmx.com>
Date:   Mon, 9 Dec 2019 08:41:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJ0EP40Wj59=CevVnn1rjxoc4CtGqbRjKFBSbU8BsrSjRC48ng@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rL6jauLOKHCI8qgQwdbEgyxibBF6HYFBz"
X-Provags-ID: V03:K1:rPSM3ilO0SXwEZYffEkqDzWv0gowZ4Cg5/3SJsoGJU9IVl0HBhh
 V1WOBXwUBoaDy/X9nPn8v0kAsZ9V9uBmc5yzSFyRyr3GxjenKZNrh0AzZhKwXxT/KhVHHog
 xsiXdT5Qdp1N1GJMUxkR/l8FmpqzicSsgb9pDf5TTVO75Xz/e/a4dNgCIJ2S3r9di0W91zC
 tMFcodDP75YaWRY/YB16A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6rDgUHkgukg=:W5hBekhZ2kd4/0d8KcjTwN
 Bj9I2PrH8DKn11RKIfvb6vBuoHUW57shwe49ZhtqgDKL+FxJ56SZcvkdKyEI2EACviExu7rpO
 qoWohkDjtdmPsZmdpYMiqwNGkc3Kj+T/LMoOEDJtxN7jBg+PNkZUcWtK4ZNJBTpuHF+aXVdrG
 LjrybRd6udBk3HLRBCjD5uAV3MKozyTb3qYMtq/+AK1yrD1SPnM8c4kv3eFxRmGV/CyibGAdd
 tKWTdp02HU2on35YD86ymgyMTF7aN06Q3bOS+PLP0mfyeD7d2PkQ+QPeajduWSB4wM1rvKOGz
 hUsERZpBVJYI1iZM+R3+LfU6sOOZavBW0gEKM1lUP1nIxbQ+vrGU2xvIeCs9FsQ9ydfTnZ1Ja
 anWitwC3YfFrSMZ4i26q4hT7MD+Tcu7ATal8zuaulEfNrWwqu4mSIL/si2kPgJs6LCxLtxW/c
 QNtZAIMClwZimffqgN98xH2ASlnQlYQEKxo92zi/QWjR28pbLxOFpzoGcDRTvXAzVLjXbTRlr
 1heD5hwWBBBb8Mj2Ty9KyaTDEix1QKpzNos2vy3JoxLm2u0z7c9bQmkQ7SP8ZN20bg7+prg0Y
 vbAplYp63li6jGapCGv2xMxIs/TfcXCOQ5eoM6OVrh9+MTBoqUAefqX1tzS/gNX5d7bnNlGBp
 Vgz1MqMAPG0htCfH85w++kmJanE0KLdyVygYV3+LNuSTbwMwyInVETAPtYnuz03cLIRIU0nMC
 HW4sxQFLGJZrpon7noh5311sS5LSJGrezqD2A12JDULkTVX8N3dWwXFrHsdBqFW9p5++MFQsd
 iJpcgHcxKQe4Fi2RNoUkXXnucAbDlhUnJxqiF2884/wmDy3Aqug4XTxY7gsTgONncl/lN4wal
 e6jXeJPlZdLBfF+lGvbhFSIQO8lLzo6Mc7ciBd9KFav1YgXS8aTFMofWcy+b7hU36kbYuahkZ
 4kYUYqsWcffgxumtLmc5J0Fm9EhMQXKZPTC5vWQeLyA1tbs7AOe9DF+0GcDMFR5LhfChIv4nY
 dzOD14ppDFCMIoKDxXI0pYeUHFPqXjnGw+sQaSOQg+GZaOPzSE6FrBr71bDTpDpa0SUw80DHD
 4VCb0wB04s9e5BBkMe9BxSU0zmgDKGggxUgG6S4x5z9N4ZL/RGT+8WSuOakUzqtO6ilwYyNxx
 Sdokg4SnpeoUCrKSmlUgwpnN7U9SU5YSqnEC9wx+j+0abFu+E2E7GfcpbJy2zAwdXX7Ok/77E
 9lWwLnvEgukObBMHxitBI1wtlvw41GH6DaatTmxHbbYjIDGGU4rMHhoBzlLs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rL6jauLOKHCI8qgQwdbEgyxibBF6HYFBz
Content-Type: multipart/mixed; boundary="W2t5sXiV1FuCUKT6iGBYiUZrnTxDvHQ5g"

--W2t5sXiV1FuCUKT6iGBYiUZrnTxDvHQ5g
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/9 =E4=B8=8A=E5=8D=888:30, Mike Gilbert wrote:
> On Sun, Dec 8, 2019 at 7:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2019/12/9 =E4=B8=8A=E5=8D=883:19, Mike Gilbert wrote:
>>> Hello,
>>>
>>> I have a directory entry that cannot be stat-ed or unlinked. This
>>> issue persists across reboots, so it seems there is something wrong o=
n
>>> disk.
>>>
>>> % ls -l /var/cache/ccache.bad/2/c
>>> ls: cannot access
>>> '/var/cache/ccache.bad/2/c/0390cb341d248c589c419007da68b2-7351.manife=
st':
>>> No such
>>> file or directory
>>> total 0
>>> -????????? ? ? ? ?            ? 0390cb341d248c589c419007da68b2-7351.m=
anifest
>>
>> Dmesg if any, please.
>=20
> There's nothing btrfs-related in the dmesg output.
>=20
>>>
>>> % uname -a
>>> Linux naomi 4.19.67 #4 SMP Sun Aug 18 14:35:39 EDT 2019 x86_64 AMD
>>> Phenom(tm) II X6 1055T Processor
>>> AuthenticAMD GNU/Linux
>>
>> The kernel is not new enough to btrfs' standard.
>>
>> For this possibility name hash mismatch bug, newer kernel will reporte=
d
>> detailed problems.
>=20
> Would 4.19.88 suffice, or do I need to switch to a newer release branch=
?
>=20
I'd recommend to go at least latest LTS (v5.3.x).

=2E88 is just backports, nothing really different. And sometimes big fixe=
s
won't get backported.

Thanks,
Qu


--W2t5sXiV1FuCUKT6iGBYiUZrnTxDvHQ5g--

--rL6jauLOKHCI8qgQwdbEgyxibBF6HYFBz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3tmDkACgkQwj2R86El
/qj2uAf9FejDvWOThY8pQngoRNVXE5ZW+tJjK0DroQ6A5+pKXlMYgBgKkywuGL/5
PAanUxJH31kfK1ZqK+HseS20EwURi5K2KlBjts+JAG/kKZSAHpCKmHZ5QUxcJ+gK
HM+XQWlAUFIacWbyusB+IzkHGQjgwN0Kw7cmQAHOR/RK/+9lpeFSUHg4WbMeSpYI
/cXxFkiB+PUVPXFEjfECg7vSPr8l3RmnvrwtASAKZSc1kTnNRXMACRTvahxILVWQ
+odmhtI9qaUQUQ6ELNWYNVep0I6IAtK4ioKtEOYMFBHit7E8kNAC1jm7oqjsFvns
YD22j0JtibMArSCgy9taBrp2onQxkQ==
=279x
-----END PGP SIGNATURE-----

--rL6jauLOKHCI8qgQwdbEgyxibBF6HYFBz--
