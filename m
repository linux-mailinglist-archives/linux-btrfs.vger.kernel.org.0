Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5284FAC1
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 10:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfFWIJG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 04:09:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:56011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfFWIJG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 04:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561277343;
        bh=kkIrZxhGY+rZCXdIc6V0v3hgqoQfc4fBMRaWMnSRNVY=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=FUQ66fnJOKCgEVe9Rjy/CKW20FmK4mJTLaFHj7wz17H6C+q5H5XpBDFzuqSsVHdB+
         FjAjwePz3Estyprm4tS0uqwDI3TbgirUwB19memcvM08vX2TVmV+DxAzE5JHrytn3Q
         vGh8D1b7kSkL+eoJSjd1PSZUrtu/mzMZX+kEMeC8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXQ5-1huhgp3U7r-00JbOR; Sun, 23
 Jun 2019 10:09:03 +0200
Subject: Re: Confused by btrfs quota group accounting
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
 <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
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
Message-ID: <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
Date:   Sun, 23 Jun 2019 16:08:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oPGdnt3cVRCumgV5iBeldaORc4F4w32Mv"
X-Provags-ID: V03:K1:dcAjhIxUa71EpuSkEdxm/xk6NkqaRWSwJlqk2YJLIiJ1MO0L5Ry
 051cjLg1+N0eXZBKXw329fbGGUuSrZEY2dEFLOK1oXo0qkuGAGmsI5evNFSM8DtwSdvyFDE
 04momw9+wNtg1eSuQ5K/i9Ebg141DrpEnF6Svo2x+ZtLs3MGbWgWOPFLy6yyL1MHZ3d/0XA
 DHH4SqR6WPj6Nv4FYgMGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BUgKrAb2Ors=:wVZmXHmITIEc+ueeA6UF0f
 jf3O8WwaxefQGkdeJ2OXf+LCMBYdRAvbibfYgUKt+RExB5urACpmJ/Nk1t8adm0RlFQWQ4RgB
 BYDjFMDZpBTGrJdwwJJkq0KrphJzXNswu/w8mkoWSvcp08cMqkIfTMPC3E2AScvB2+Qgn/R00
 G8ZJTagf38DSDWhSLdYWIGZjqWzzYCSsz3VYioF/JlEyW1LAdBFL5VTauvhMTOJOWgb3pEiod
 pWfZlkADmgbth2RoBXW3hHyQQcbgiKCAO65xNUmsXyhjHR4t0j9lqfYqeBYbdAnK3Q+dtciqq
 Z73gQgrWuHEp0oITiVeMTxjWbgqfSVD6YjMXtuy4jZe31YF+ktsvzPAPVJZE9QU0+c0VhvTGq
 aOBid9XHtbAaFWWF4DC7x+3uVU7vTBGWxlka71fnHhUzwXPA0XE3rVgeqdubNYvJgklXECytB
 3RROPx4iHF/gb3vUBgITjpeNSZCZu+66WUcivB0bX3sUgnCxkRSa5K5AG+Ted4ql36hWCGIYA
 b05FzcvDcuPdwzA3wFQuHiXn9ZahWPkYfV5hBVgavp/kz/gPTpiUvO7QtHxYZ8hkMD5VOI73g
 DnoBjEVMfGfeQ4pTU9SHQZEeRp/nwDZ9g4ua+4XURgb6yQxzRX1mg2rHIOZSpi9cd5mUvHd5B
 VxJBKNPbNsYUhdUjOLj2VU2Zc1BxjT96QyxI13+T91N5/4sTm/pw6gzTr+inGQojck/BvNQn8
 KzSYOeJPWgmf9LTe97w4tYX7hMyWnZBG2hiRs7OgwtPtYGxMEbyMB7cu0sv9evRIts8U0msjr
 CGkhQLMdxFMJZ3AIdEKOGFKjANx5kgAvMzgwOaOKryvwiZpkDQl6w8OaVHoZ7Xg7S0aohw8xh
 MKCgvlUWvwqLqtfNF6fsMlScGarRzooqK0fwHto9y4LwqeDYq6b65Z6mVy04mpfu3CKuV9oU/
 JAfCIRdY3KIJCtgTxiLmCfQwQZCjTZTs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oPGdnt3cVRCumgV5iBeldaORc4F4w32Mv
Content-Type: multipart/mixed; boundary="3vdLqSbBTcsQxvc5a8N6rBRIBvfnRoen0";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Andrei Borzenkov <arvidjaar@gmail.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
Subject: Re: Confused by btrfs quota group accounting
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
 <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
In-Reply-To: <669a0428-0517-a10e-c658-c8137463450a@gmx.com>

--3vdLqSbBTcsQxvc5a8N6rBRIBvfnRoen0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/6/23 =E4=B8=8B=E5=8D=883:55, Qu Wenruo wrote:
>=20
>=20
> On 2019/6/22 =E4=B8=8B=E5=8D=8811:11, Andrei Borzenkov wrote:
> [snip]
>>
>> 10:/mnt # dd if=3D/dev/urandom of=3Dtest/file bs=3D1M count=3D100 seek=
=3D0
>> conv=3Dnotrunc
>> 100+0 records in
>> 100+0 records out
>> 104857600 bytes (105 MB, 100 MiB) copied, 0.685532 s, 153 MB/s
>> 10:/mnt # sync
>> 10:/mnt # btrfs qgroup show .
>> qgroupid         rfer         excl
>> --------         ----         ----
>> 0/5          16.00KiB     16.00KiB
>> 0/258         1.01GiB    100.02MiB
>> 0/263         1.00GiB     85.02MiB
>=20
> Sorry, I can't really reproduce it.
>=20
> 5.1.12 kernel, using the following script:
> ---
> #!/bin/bash
>=20
> dev=3D"/dev/data/btrfs"
> mnt=3D"/mnt/btrfs"
>=20
> umount $dev &> /dev/null
> mkfs.btrfs -f $dev > /dev/null
>=20
> mount $dev $mnt
> btrfs sub create $mnt/subv1
> btrfs quota enable $mnt
> btrfs quota rescan -w $mnt
>=20
> xfs_io -f -c "pwrite 0 1G" $mnt/subv1/file1
> sync
> btrfs sub snapshot $mnt/subv1 $mnt/subv2
> sync
> btrfs qgroup show -prce $mnt
>=20
> xfs_io -c "pwrite 0 100m" $mnt/subv1/file1
> sync
> btrfs qgroup show -prce $mnt
> ---
>=20
> The result is:
> ---
> Create subvolume '/mnt/btrfs/subv1'
> wrote 1073741824/1073741824 bytes at offset 0
> 1 GiB, 262144 ops; 0.5902 sec (1.694 GiB/sec and 444134.2107 ops/sec)
> Create a snapshot of '/mnt/btrfs/subv1' in '/mnt/btrfs/subv2'
> qgroupid         rfer         excl     max_rfer     max_excl parent  ch=
ild
> --------         ----         ----     --------     -------- ------  --=
---
> 0/5          16.00KiB     16.00KiB         none         none ---     --=
-
> 0/256         1.00GiB     16.00KiB         none         none ---     --=
-
> 0/259         1.00GiB     16.00KiB         none         none ---     --=
-
> wrote 104857600/104857600 bytes at offset 0
> 100 MiB, 25600 ops; 0.0694 sec (1.406 GiB/sec and 368652.9766 ops/sec)
> qgroupid         rfer         excl     max_rfer     max_excl parent  ch=
ild
> --------         ----         ----     --------     -------- ------  --=
---
> 0/5          16.00KiB     16.00KiB         none         none ---     --=
-
> 0/256         1.10GiB    100.02MiB         none         none ---     --=
-
> 0/259         1.00GiB     16.00KiB         none         none ---     --=
-
> ---
>=20
>> 10:/mnt # filefrag -v test/file
>> Filesystem type is: 9123683e
>> File size of test/file is 1073741824 (262144 blocks of 4096 bytes)

My bad, I'm still using 512 bytes as blocksize.
If using 4K blocksize, then the fiemap result matches.

Then please discard my previous comment.

Then we need to check data extents layout to make sure what's going on.

Would you please provide the following output?
# btrfs ins dump-tree -t 258 /dev/vdb
# btrfs ins dump-tree -t 263 /dev/vdb
# btrfs check /dev/vdb

If the last command reports qgroup mismatch, then it means qgroup is
indeed incorrect.

Also, I see your subvolume id is not continuous, did you created/removed
some other subvolumes during your test?

Thanks,
Qu

>> Oops. Where 85MiB exclusive usage in snapshot comes from? I would expe=
ct
>> one of
>>
>> - 0 exclusive, because original first extent is still referenced by te=
st
>> (even though partially), so if qgroup counts physical space usage, sna=
p1
>> effectively refers to the same physical extents as test.
>>
>> - 100MiB exclusive if qgroup counts logical space consumption, because=

>> snapshot now has 100MiB different data.
>>
>> But 85MiB? It does not match any observed value. Judging by 1.01GiB of=

>> referenced space for subvolume test, qrgoup counts physical usage, at
>> which point snapshot exclusive space consumption remains 0.
>>
>=20


--3vdLqSbBTcsQxvc5a8N6rBRIBvfnRoen0--

--oPGdnt3cVRCumgV5iBeldaORc4F4w32Mv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0PM5gACgkQwj2R86El
/qiVsQf9E8SD6ejIYptwJrX05RXe/JKJYyHz0v+rkv6whSBW6r9SmuEAJQstlCPn
8ftro+ONvZq1NUMn38xWOl5oUAQnn1sxRanvYLMaoRawsXR5XWz56+Lkrwt38Ogk
M4rXsBOu9/Oy+nCdY2MpCCoLoX13tTNGLL8E8Sd94fsyViBo+eCLKESY2GLOwG0I
/G3bl7C53b856XiveFWmKNzp2wDoXjYSKswSJJbW/rW0eVdK0ySpel2ZH8DQyGsa
w0yu57xMO1BJRH2cah/b6xzHI1xxUgOx+QaE+9ZD4Bk/p3zPN6wSzA2LGmgm33JK
UxwPq4e/US5W1Rvpdrqf+NnPaj0jXg==
=4B1I
-----END PGP SIGNATURE-----

--oPGdnt3cVRCumgV5iBeldaORc4F4w32Mv--
