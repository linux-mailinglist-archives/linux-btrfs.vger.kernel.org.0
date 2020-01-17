Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A4C140198
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 02:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbgAQByz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 20:54:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:57659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgAQByz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 20:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579226089;
        bh=BuWFGHWuUwXZV6KT5oxOSJy6zeE28JD5gWuS5q3OFBE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EKD4EVajDAmRhY/Mcxh9/uTIHjQSDAAitRXqmY6WADgjXLnUH1AnXu3Lq/ffNBxMv
         gmVgluvPHvdPNC1t3nLrezod77UuplYLsoB2V3Tc0wji0+zcTe6bTXDnp+idf+jEYW
         wp0bR0U+BZutiISFVddOcSy/1ydK7NRBlAAV63O8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpDJX-1jQo6x3R1j-00qkln; Fri, 17
 Jan 2020 02:54:49 +0100
Subject: Re: [PATCH v6 1/5] btrfs: Introduce per-profile available space
 facility
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200116060404.95200-1-wqu@suse.com>
 <20200116060404.95200-2-wqu@suse.com>
 <49727617-91d3-9cff-c772-19d7cd371b55@toxicpanda.com>
 <3818d217-b64a-5f44-c80e-c49521bb3698@gmx.com>
 <4380a833-eb7c-cabe-3a97-9346d803873f@toxicpanda.com>
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
Message-ID: <525d34e8-1c14-b13f-bb03-91754e5882f1@gmx.com>
Date:   Fri, 17 Jan 2020 09:54:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <4380a833-eb7c-cabe-3a97-9346d803873f@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="440yJvpZS6Ui621RfwhSLbe8plqPS1kJ7"
X-Provags-ID: V03:K1:BixdMm3ZcPviYzAu4DdS5lUTP7McopqfZ+Uq7fN/f20JXlnhf4Y
 oU/klORaM9JCTzmc+BoI9fvPKYOKp3sbdbcD9QlKmjRJ/5MLDAK3rORFuioG3d1TvOhor/G
 u1+PnMa779VNSsXrNbNMVv8ytDqazVn0gKMvCSvs9CKDE8vPbhHjWL4VCO88U2r02Ae5IlR
 4/nU5G9v2RoJa46jKE1ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RIsFvQo2q40=:+1EOp8/rrUo3XF4nyDKfSP
 1lzcSHHK+lVRUyvu2l0Z8dMyW4QlFOSTFFemiHVQbsq0uaJqoEYOcJQ2c/MZCo/qLewAK7Nrs
 Xqac5r0OIqjrmXBm3fT0DtjP369Nvl/g01mAsSGj66XVf3gFU6xdy0E2+J44/ksLIN92UF3z3
 MDUjjLsN1iHS3qI9KmuazHtBP49BoDnDp1Y9b6nA1JJcxE3i2g+dUpgSfPU/G+cP/rSNHNJL5
 Dxx3SsDMlU8dedM72p8dNKJEjlfdP4A9a4M9TT8y4Zhgc4QCKc21IzeHTHQRyFF0wkUn/omCX
 PLtu0j++7c0twQsdK+2sL4kzuwZvtn0pIl5scrzXmOThzAX3RYUgNtpgA/G1iPY8IGlQbGBWQ
 ZO+W9zGxjPzqjINsqem24wh4gbksrI/SF6GoqAaTBqUtsXBt2b6n/cTl5osKMU1U3x/aMyGh2
 B3fu1rOf6lh0nz6zMYfz1IGRd2efKP97+oB5WD4H62Q67gH/KBiGNS33sjVkKwNvZfh/DSvU6
 oRNCcbn4aIwS5wswUSNyoiCxfyG1azGrtG+Uq+xTyl1BwaoCVNY32sQaZhwHtMk14NNgwI6B5
 zJAovnxLMn6sW9o7+STr5GVRJT2Rz4CYh4G62GNmO55X+FDcf1sQNYzsO3pJDW350CLlOdbps
 MLz8kYcC8fq08yWjYwiLdPQGLWLpFHqsAbNYMfEqjf8sWe9IciHXMhoMEEhS59BnnaZLPX20Q
 nC8Ly+TkPUwvyWEIgIIEP6vDNGxmJJBrRwzDtaz7adMZTUR9CUyZSPr1qzv64sJ768rwWJcs0
 uFJltbpsV6i0jd4xL0HGBDtgiYFrAovc8NX1W6igOM/KT4s5NizWqEltQ+aiH+IsnxcAVMJ19
 tCZQoFx1Ck15iNd9g/YdgJb3ZrAEZFbS/duU/h8HgB+qPk5PkYGmvz6pM5o72c4Rdv1dOtEfh
 CFGF1UB4P+kTBpLo3UqfrMlAFx1K21YqgCBY9JPnn8k/Xid2OVBaH7IUpJyfYeyer0QZ2ZCwL
 hoblmGFxzBXxuxg5/ePFPykSueSFUdqmIGED6X13Gp5wo7iEP40IcNeMQTXbIW3UHjceGMSGB
 QQDhUvVk1sf9ofrZCevq7+xX5kgx8mwyjZPyYcasCUIU/54f6/QSNSXq4po/5PvhYMYIaspVb
 mtAqtlmIXC/i2lSEKHMPm4O6b9tsq/jK7FArvaEYzzPcSQ6KnjlSzEYQpTJ/UDjo6cqLAN4gr
 qL7FbsVpbuFTqE5uE+nGHXHeJQpFd4vEw7GYeAXEXsodN5RQp/RFGOpYHFEc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--440yJvpZS6Ui621RfwhSLbe8plqPS1kJ7
Content-Type: multipart/mixed; boundary="vdRDD2plO630RmfXfUXudnvg2Q0F7rc0h"

--vdRDD2plO630RmfXfUXudnvg2Q0F7rc0h
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/17 =E4=B8=8A=E5=8D=889:50, Josef Bacik wrote:
> On 1/16/20 7:55 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/1/17 =E4=B8=8A=E5=8D=8812:14, Josef Bacik wrote:
>>> On 1/16/20 1:04 AM, Qu Wenruo wrote:
>> [...]
>>>
>>> Instead of creating a weird error handling case why not just set the
>>> per_profile_avail to 0 on error?=C2=A0 This will simply disable overc=
ommit
>>> and we'll flush more.=C2=A0 This way we avoid making a weird situatio=
n
>>> weirder, and we don't have to worry about returning an error from
>>> calc_one_profile_avail().=C2=A0 Simply say "hey we got enomem, metada=
ta
>>> overcommit is going off" with a btrfs_err_ratelimited() and carry on.=

>>> Maybe the next one will succeed and we'll get overcommit turned back
>>> on.=C2=A0 Thanks,
>>
>> Then the next user statfs() get screwed up until next successful updat=
e.
>>
>=20
> Then do a
>=20
> #define BTRFS_VIRTUAL_IS_FUCKED (u64)-1
>=20
> and set it to that so statfs can call in itself and re-calculate.=C2=A0=
 Thanks,

Then either we keep the old behavior (inaccurate for
RAID5/6/RAID1C2/C3), or hold chunk_mutex to do the calculation (slow).
Neither looks good enough to me.

The proper error handling still looks better to me.

Either way, we need to revert the device size when we failed in those 4
timings. With or without the patchset.

Doing proper revert not only enhance the existing error handling, but
also makes the per-profile available array sane.

Thanks,
Qu

>=20
> Josef


--vdRDD2plO630RmfXfUXudnvg2Q0F7rc0h--

--440yJvpZS6Ui621RfwhSLbe8plqPS1kJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4hE+UACgkQwj2R86El
/qiKmAf7BpB8s013tpk8vFvUvVSE03H+iCCUnlKWNhQ4b8ThRqLZnETssJCfnHNn
Fi1aWX9tZdcnHqqPua6HSkiYeTx4XJnGkred5OfFelQnMSZE/SYZdEekYm+MCQZr
M0NrEiHtnJBXBB47TslTJk+UPrvUnGVU0zF9OIlEJXwtKhIOPWaEMB7xRBicyc7n
MnbAE9xAPhulL7K/Fk4lfihpQOQFzEzSjfKXeVpiX2krvNQw8HQPIMbTfoQR1tLO
Fohu24jYFroJ4aOlXdBI7LFq87Kb377CUfDEsHks7vKjlMtCU3djxqD9sy7zsHl3
CN0aioiuz7t7itUlgF85SNSG6/2UGg==
=Crzz
-----END PGP SIGNATURE-----

--440yJvpZS6Ui621RfwhSLbe8plqPS1kJ7--
