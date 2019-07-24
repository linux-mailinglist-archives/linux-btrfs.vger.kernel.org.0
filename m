Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6476724FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 04:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfGXC5p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 22:57:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:57571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfGXC5o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 22:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563937052;
        bh=Dy619/esSrXqinC2AB86BJLeMixsuuoHrPJjZO2izM0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gL02VJ69gQXy72Ye4WBuvKvd6FVKgEHKwz66ldAAAqJmLebJvg98fmmvkPHszC5w2
         nLoDUeWxtw+nTXN5uoz7yVBIx0xZlYoyST2VsqUSt37vqBHm0XPAtLS/o0Quqn9jbP
         uM6oi/xz4j2YotWsQ7gjfmh66PVPi/tzNsy8yvvE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LqV4f-1iKWOw0HcP-00e8Xc; Wed, 24
 Jul 2019 04:57:31 +0200
Subject: Re: [PATCH] fs: btrfs: Fix a possible null-pointer dereference in
 insert_inline_extent()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190724021132.27378-1-baijiaju1990@gmail.com>
 <df4b5d21-0983-3ca2-44de-ea9f1616df7f@gmx.com>
 <800ae777-928f-2969-d4dd-6f358a039e48@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <1b708c0d-8ea1-3898-0340-9cbce1fc2602@gmx.com>
Date:   Wed, 24 Jul 2019 10:57:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <800ae777-928f-2969-d4dd-6f358a039e48@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8P9umWkBRMgPyJVimnHQNeO2GHHfHoECu"
X-Provags-ID: V03:K1:+tg4TFp4xXMj8luL8Hj9V6rXE2w3hCY/b0sLj9NmpLaQUuOCoKF
 QPnvTgEWjXReFL3bqdRY17N6fIGubBw8yBxU6u62g5pCZSdGRC9d8Au2/mR28esaBk8foKS
 E677hGqNn2CaqMV/2059aAlMsq0T+B6L5WrZmTz5GLmjEcF2VuElQA2HpyfOqXZuByJxDdC
 NIvg12ODdfrnzOHbnUOLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fcT9rZx34GA=:5qHBKwGYMwT/Uo4fop1w6A
 xSC7UeKaQTbbexIQPrBl+3+L5Dm3IPFIYh4OpD03Nti0WOytlmfwPjXXbRonOJDwvmpd4oTpR
 RLfY4jFv4/QrTkjX1CQ1fgx2enLUxzbatzRVjmw+HwwZWEKeTlCDNq5pJ/OFKHLcrzmTGin3R
 KeclB1Xq0rEpZ6QGpxUX38Im0fXwRoS5c2nv1rvL1PcJBWv2WJ+HH/KOT9NZPg+ETM/QHrW0y
 9iI733Y0AN8GeQNQb8XyPiVMzTwGafxXAZv7lecOAOHxY3TxnaaV+hbuK+AqTHefQ3B4WbG38
 KKjkv57JtBChpGQt7J6edOOEFEbmv3wow63AiN3ix8cT7DPzYfcSYqrH17PgMsrqLBOZZXMJx
 H4JpYG22Q7TAq7Ciu/q/kt1pvSLNZSAK6M9tVcUPXD+sCCwUEAulVaj5p76ZuHy7DDYsNd/M7
 L1xg79IEffQGfvinT+nGdW1gIeLkRogiDD0e+SzTh4jqeAL94AqOBSLMkRl1kKFXUJAQFaom1
 ViOgcfpxRecvdzh6GwgiX/LY02sLioZjQCiY5663Z2MRP1LOxyDZwRjQl9pEhBw1FSw+25trt
 q7bA01GAxycot2Rv1OUaadfQjFQ0Fkys4KcITX4LH5HBs4xh/6BjyNdBX1Hd65ZuoR3wzbO45
 dmTqrW3Y2yb94bAYFlEfevtb/QJYhvu2TVqbebONHavMRVfO4bW0un4KC00j4iAQ1KRnZWSwV
 cE5Q3KspclLekMyNGTSysZ8EDeh+nGiv/FEhJ57EImOB2yJrN1etgodat0JcIB//Of9Yb8EW5
 BQ2V5J4ArwrbQiDP71B20s1TTpB+KxsW9nJNQ4AcC+hpWK05IemkRIBRbN5LPYAu/N1u+SYfn
 fS/XWl9gITxLjXjo5nloXmpjUDq584+CZAq0DNXmYT8kvlG+yM1cIpGN7L3r9ZarWw8Ao+Iw3
 TGMWyB35DxciPqfvucs/aWp2a+1je7OBl6syGyyCaoHK6KJ+f2M+0dZDEqpPDa0+px2CJBbqG
 1KdhrHjnykqXDUFI4HwgM3DrSRg89tHDEK5bfG2xfF2eCASwjocj8MycWJw/YvpmJafS4KaE3
 rVJVKBb2mEpukQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8P9umWkBRMgPyJVimnHQNeO2GHHfHoECu
Content-Type: multipart/mixed; boundary="9Chnxo7AV2HVOIDJ9jTxczmnC84KP88tt";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1b708c0d-8ea1-3898-0340-9cbce1fc2602@gmx.com>
Subject: Re: [PATCH] fs: btrfs: Fix a possible null-pointer dereference in
 insert_inline_extent()
References: <20190724021132.27378-1-baijiaju1990@gmail.com>
 <df4b5d21-0983-3ca2-44de-ea9f1616df7f@gmx.com>
 <800ae777-928f-2969-d4dd-6f358a039e48@gmail.com>
In-Reply-To: <800ae777-928f-2969-d4dd-6f358a039e48@gmail.com>

--9Chnxo7AV2HVOIDJ9jTxczmnC84KP88tt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/24 =E4=B8=8A=E5=8D=8810:33, Jia-Ju Bai wrote:
>=20
>=20
> On 2019/7/24 10:21, Qu Wenruo wrote:
>>
>> On 2019/7/24 =E4=B8=8A=E5=8D=8810:11, Jia-Ju Bai wrote:
>>> In insert_inline_extent(), there is an if statement on line 181 to ch=
eck
>>> whether compressed_pages is NULL:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (compressed_size && compressed_pages)
>>>
>>> When compressed_pages is NULL, compressed_pages is used on line 215:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 cpage =3D compressed_pages[i];
>>>
>>> Thus, a possible null-pointer dereference may occur.
>>>
>>> To fix this possible bug, compressed_pages is checked on line 214.
>> This can only be hit with compressed_size > 0 and compressed_pages !=3D=

>> NULL.
>>
>> It would be better to have an extra ASSERT() to warn developers about
>> the impossible case.
>=20
> Thanks for the reply :)
> So I should add ASSERT(compressed_size > 0 & compressed_pages) at the
> beginning of the function, and remove "if (compressed_size &&
> compressed_pages)"?

My suggestion is, ASSERT((compressed_size >0 && compressed_pages) ||
(compressed_size =3D=3D 0 && !compressed_pages))

And keeps the original checks.

Anyway, just a suggestion.

Thanks,
Qu

>=20
>=20
> Best wishes,
> Jia-Ju Bai


--9Chnxo7AV2HVOIDJ9jTxczmnC84KP88tt--

--8P9umWkBRMgPyJVimnHQNeO2GHHfHoECu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl03yRQACgkQwj2R86El
/qhQpAf/aASnQHz7PwJ0xw1veji8X3dEG3Yx9WiqBfTEasg+ubm7GUgiIFyulmvF
kTULSCf3IFHn1TNJWC6QlZ5O0QeyAKHKrbLcOBQyanNr9KhfBpxUt6AXG3KwpYWn
rOf1Iz7NoFwJKgHfyQsEkwIpupuY7IIChtyE5D52AoU8Af4XKRIW4Ll6zLiN/DKm
EFudi6f5M5MWNhdjNL2gTaQkyw8wBa2gP061m80VEWhwZdIvYDkrKtX3xucdAjM8
QaJCJpO+1zn0YjdJqHKmh8MzYVqJJ09pcyKo0pW6Q9w2yRRWQBP5zY/5mmZ75CqX
pHqI9SUZxiUlbvs9jDbi1pDgfoYqpQ==
=BUZl
-----END PGP SIGNATURE-----

--8P9umWkBRMgPyJVimnHQNeO2GHHfHoECu--
