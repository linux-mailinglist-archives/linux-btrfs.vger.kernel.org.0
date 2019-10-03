Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873FFC9792
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 07:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfJCFAI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Oct 2019 01:00:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:50631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJCFAI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Oct 2019 01:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570078806;
        bh=d7njLbUGCCDTkhvCGoYUgYNose1F0w3q08GyqFHyoqA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=asDk3tu1xSCbQUWS+G0Pe/ObnC7VWEi3ODV2jGdyX0hA4Wylc6EpO4x6ILVwnnIMY
         oG01d+Us/ksak+LlF//HfJnyWRqx+2fhZhPHlmNeHmSfhqrw3pUAtXfcE4BZkiVr9s
         traHwwU+kRTotwU/tJ2HbMNHDlN3hWoUsTvykn50=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9G2-1hkSkl13Re-00oDzn; Thu, 03
 Oct 2019 07:00:06 +0200
Subject: Re: Btrfs partition mount error
To:     Andrey Ivanov <andrey-ivanov-ml@yandex.ru>,
        linux-btrfs@vger.kernel.org
References: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
 <85cb7aff-5fa4-c7f7-c277-04069954d7fe@gmx.com>
 <170d6f2f-65aa-3437-be21-61ac8499460b@yandex.ru>
 <4be73e38-c8b1-8220-1e5a-c0a1287df61d@gmx.com>
 <b0ec0862-e08c-677d-8bf4-8a87b74c1ec2@yandex.ru>
 <54a2e030-3b8f-6680-a1b6-826c2f5c0928@gmx.com>
 <d7a9650c-db8f-34db-fb7c-c1ba55159c93@yandex.ru>
 <a6f68cf9-20b9-f1bf-379a-a361c4387dc7@gmx.com>
 <0ecf3dc2-c884-7c08-5f11-86e1b1d2f631@yandex.ru>
 <8863e0a1-adb5-81d9-e15a-9dedda00f4bc@gmx.com>
 <1f7b1930-bd28-0d3c-c46e-b11618a2629d@yandex.ru>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
Message-ID: <b865123a-f86b-d1e6-7d19-24eeb779a5ba@gmx.com>
Date:   Thu, 3 Oct 2019 13:00:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1f7b1930-bd28-0d3c-c46e-b11618a2629d@yandex.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AlWgnFWqkdhYcS4Qb1uzKsD7r1JcT9BKj"
X-Provags-ID: V03:K1:oW60OLJGUyNf3rIYO4M98q8ZjTX3WPt/xp0npD5UNijI6FTqEMS
 8RKz6T12kiwWj02asyZGuWO2/vfFqyulvpb7yXePGUK125yO1ehpO6W5pLbOqh1zLMLF8d6
 fEhtmxITkS/D2Vk3pdtUuBLw3ko5dfCXbIvWANgsl9TgQ4/OxMAhs6r/uJaNBxHEOOnhr8f
 ct3brfjrr367ci3hD671g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k6IIPriic24=:gL0fHpHXef5sVQAajnp/ka
 AbD/AIjd4vDGqQwZW2V17Z0AwpyuZ2dnMpo9wgIGyQogOk4BIEYkpMjRg4Nld3I1Mzm6K0l2F
 LMj1A9+6c0R7Wakg6st4wPtoCepzh2SCNgtYkf9g+b6H3io98VyugA5qQqHWUZu/DDSd5jCY5
 Gp9VJk7e2lMNqnU9NHlebVjJT0AxS6XP5UHm5aP3V9pRuznUmIr5FXyUAKOLjFDTpdj+edYv1
 hCyDWMK159rsN7+KafP2bjznkOyDEAQIO4c30X2ZqBbevs+pzIeBbGdknmpwvXRzWIqFcGTO5
 kT/bFqDkZ3OlYc+C7PPs8OuGmuppmyuwhkCDzled4Q3KCsUlyNWyiqQDDNXyoZq5rCwDU/XT4
 7/Exd2tJHRDx0dylcg9acumEJeMZue4S3+hAhCNALhtAzd6Xz7qahyU8zOslodzfLNsNDKPNf
 W4uqq5BmKTo/LQhPJC+0xbK2af4GpTcvYDh1jCkm3wapTuZKlyAQK87BxNQwtBS7OGUESkAST
 AQnj3IbRUSXOSJKilkqdnq6tMHMdzuiooCINZurrYKZoGysUht5WTQHdREq28Q1F8JbxHdBbS
 z47qhh5+63vMSk5XJVYMALPsm775RIUcVQJeHIw/UmRfl0LV+e7FwOLd0ig9MTE4+4vJOJPkb
 UW5TXdp/fzRZLIX9INSXo0oE6LiuThp7UqEhfjdyNXKni3DiyOVUqRLCjUNjuscfHdIG1g7/A
 rc4vFKTF8TJdTndwTwWAwcCyz3Oudl5nFgS8opIQPTiNS7tz+cCADwSyj/BTvfhgfWCZNWQKq
 9tAO5X16srz9Sey0tWRs4zrxo2G+4SycHTJa3KhxKafKTqUINhsddowtzOpSRM2YMAdE4TO99
 BnQxMOMsr7O7Dk0In1nLGA/Pr3Cb9FasuGTZMt8A2hGMQLtX5BHGhvhut9ItY+Rld3svjzRpj
 6tF8Po5hObHDDJ9SNKPYMOReMBW57aLkRKuHyNxfVKh+Z10wwUZk64NjIRB8zz4UlkMKCJP/s
 yrBdO826lKJ4Juo2n709XFeofZi2Clkgo/KDQVwhpqxtinucC/wBE59WVzBfyPr7al+lWMQh8
 wSMzNFf0cNC+wD43CyAu46rWh2S6u+2D7ktYjE134lshAUttJbPtAU7TWimcfl3j8il+PFRJm
 3BoyzUkBQiIVJ19FB3GCdGIkIA1+8IMaNwM6no7Sq99eC0EI82ryUvRSlIhbPgNTu7n3qUMEr
 vBiby/Jtv3vKlMLZaxqdjGVp5e3OeA/AuR7nWDtj7+k7//1PyIy32Gex7TlA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AlWgnFWqkdhYcS4Qb1uzKsD7r1JcT9BKj
Content-Type: multipart/mixed; boundary="Sry8vpBHX7deWZh7iuTT0fawK4rNh0fF3"

--Sry8vpBHX7deWZh7iuTT0fawK4rNh0fF3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/3 =E4=B8=8A=E5=8D=8811:07, Andrey Ivanov wrote:
> On 03.10.2019 5:19, Qu Wenruo wrote:
>> The problem is the invalid dir item size caused by that bitflip.
>>
>> I'm afraid there are too many unexpected bitflips.
>>
>> But at least you can try to salvage some data.
>=20
> As I can see, there is only one damaged directory, which did not
> contain any important data. All other data in the partition is intact.
> Partition is perfectly mounts.
>=20
> Will I be able to fix the disk errors if I create a new btrfs partition=

> and copy all the contents of the old partition to it?

That's exactly what I mean by "salvage".

Since the corruption is purely caused by faulty memory, as long as you
fixed that problem, copying files should fix it.

Thanks,
Qu


--Sry8vpBHX7deWZh7iuTT0fawK4rNh0fF3--

--AlWgnFWqkdhYcS4Qb1uzKsD7r1JcT9BKj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2VgFEACgkQwj2R86El
/qjHxgf/UjKQgRMOa68bkprg0sSbdHQ41CRLyzzE8ay9g3ZOhad4B0CjES9NZ5lN
xYgKoPXqThWgfjOZuqHzAkVgAnnN9xC5gI6pyYh0YA1EyjNNUSj/FV/R/lrfD23U
oW7BDq7Ep4WRgqfpmWsFCTUMjdy6FG6dgcuh25dE1C6GikE8ydMgUSLTqA75vdx7
YTcwuLFivA1PFs0G1+oX97jKnzrgF/l75KukE+u6pQ+YXvV+uE0gszQm7v6RRDXk
bVw4wdvi+UTlLhsTH8DjnSJVnXM+R8ESTMoI/adVClFMPdrzUboGMJ/tEFXayfKc
dT9/MccnLUUeJOtIMj67Z9EO7MK7Zw==
=fPoQ
-----END PGP SIGNATURE-----

--AlWgnFWqkdhYcS4Qb1uzKsD7r1JcT9BKj--
