Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61B2DE67
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2019 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfE2NhC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 May 2019 09:37:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:42951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfE2NhB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 May 2019 09:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559137019;
        bh=B70JE5iVmw88HGttx420qjFz64MFt++NoGnfPSGd2Yo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZW6+X82KARa61W2he5w+RFICYna8TVPb8VSqaiJ/Jd78QA+mHc0ap28QLOqO7TqcH
         lRGLnEcatzEKuvx4vkld4FBnILTlznUptIex+9MKwgLhHvZkm7ncSpl4eDrUKSi+Q2
         ldb5p11U17JFl02kJ2B4T6Hyn1K7ibL9hkQ3t6eA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MLunc-1hX5kc2Lim-007otP; Wed, 29
 May 2019 15:36:59 +0200
Subject: Re: kernel BUG at fs/btrfs/relocation.c:2595! on 5.1.4
To:     =?UTF-8?B?V8OoaSBDxY1uZ3J1w6w=?= <crvv.mail@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAPxZtjG1DdHN9c6adtiyDahUJ85earQS5=9skgWopYg+m_7uUQ@mail.gmail.com>
 <CAPxZtjH-4XL8L6CikHS1i_RyvLhMQNbavmq0e-bbFXy3i+uRag@mail.gmail.com>
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
Message-ID: <236042ed-6903-17b2-c005-ec3ae2d4c2f1@gmx.com>
Date:   Wed, 29 May 2019 21:36:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPxZtjH-4XL8L6CikHS1i_RyvLhMQNbavmq0e-bbFXy3i+uRag@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p1AJti17b7994EAwgtCPSOcV517xUSKsZ"
X-Provags-ID: V03:K1:5TFV+CLda5ozOmjc7s8e251aaSbBuAxPyMYOoNyM4s+fYY5XPb4
 5H/bq10r403tTmzrRjLn+VcXzrxAGkUG5ZKxdbH3yNVr+j+0Q3K8FMe2SKw9I0k7ZiNveWG
 QhkGljy9ZHQlisimvX+KJzeiHJdO+Qg7c9kJ5DnnWXBSDWa0Ot6eL1zViaF1jjH6HmGZLkT
 LArfcdmCDMsuFo1Wd72bA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+6q007i4uik=:fecMwb3XLOzXjG5a24ZeEb
 7ZO6MBnZMnEDKfln9AcyXRSvgIwG0KUqnM/abZhQMAYr1xbhdgcojXCa1JjmbLBY1MO403u1X
 cY5HoU7qfs0PbiUDtF+Dddf+1lsbpxX41UC04+ZCs3Ne9Od942pmJDrHhf2d28PSw8t3HA4tm
 zsTBFIoQpafKWrlPUOWPtkwORKHPek/3IkMVHxBY64f7/V/7Ef9/gMpmt0b7jZxf34Xd0o+NG
 SDgqMNReCg9qRkvQpm2A6iSSGkw4XVexgoMzeOeUkRYF8tQwGZvYi29vHoPZS7wCCs3zUOJy+
 HV28JXawtQSeIdOQy3ZYQDNdmqyYw1TEkmg9vfDp3zgmfQO6qrOy0/Wzfzeh1l4zMtXoYtPZp
 bXQEUsZfcr2h7+ZClK28Y7Vxgre0hIpvKJB64ulhFtyLALXDBL7BCDMQPH79JhSZfyW+Fy3Vg
 XDOH0J4/uwmxYdzxpzcqjg8QBmRtPG6vXHeFnRx4i1oowYTECzTwvyAT53unX+ls8cxlHHPkQ
 tZ8c93SZSel+l2rLvmTtsAikxZR+u5k93WYM78s9EYIRxRdI0P6tKe7gDmPi5BPDxGINQ5uYX
 HpVc84q1K/7qjKxNQjX0+Lc97ET02+2WzI89JWP52aM73sLDLAmL4yJ8hSdJ78KkfujjbYlJP
 bnf7JrF5hNUjpKA9ZdDOkoo/9COQGJK6OHy7MwARfjFL/vjOKDslWbp/7wLYkI3tiOvQWfB3k
 BQiD/Ll6UkY7sP2vYwB47AlmNQGmejSzmOzdLhk5D6/8+XVjJp0XL851RdJ0TnfYx2Zg880Yq
 +8oVnctmG8NpD2VSR1xpXbozr82f7ravRWn4qihvg1n8cKanDF1ptkHzP01sViSM/foQW8Jjn
 1RaGTtr52si1sPbyHGcr+JIolMOtvjVP1+s8sYupl1KsOQpZ82xDndRaU/6guAIC6GcInL9b3
 CBM4F3KKZVlk9xJY2eZii0BaQCMnryv8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p1AJti17b7994EAwgtCPSOcV517xUSKsZ
Content-Type: multipart/mixed; boundary="Af1eLeKR5tlqa9xa42CKp2Re0y38Spt0r";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: =?UTF-8?B?V8OoaSBDxY1uZ3J1w6w=?= <crvv.mail@gmail.com>,
 linux-btrfs@vger.kernel.org
Message-ID: <236042ed-6903-17b2-c005-ec3ae2d4c2f1@gmx.com>
Subject: Re: kernel BUG at fs/btrfs/relocation.c:2595! on 5.1.4
References: <CAPxZtjG1DdHN9c6adtiyDahUJ85earQS5=9skgWopYg+m_7uUQ@mail.gmail.com>
 <CAPxZtjH-4XL8L6CikHS1i_RyvLhMQNbavmq0e-bbFXy3i+uRag@mail.gmail.com>
In-Reply-To: <CAPxZtjH-4XL8L6CikHS1i_RyvLhMQNbavmq0e-bbFXy3i+uRag@mail.gmail.com>

--Af1eLeKR5tlqa9xa42CKp2Re0y38Spt0r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/29 =E4=B8=8B=E5=8D=889:23, W=C3=A8i C=C5=8Dngru=C3=AC wrote:
> I upgraded the kernel to 5.1.5.
> Got the same error with the command "btrfs device remove 4 ." again.
>=20
It a known bug and is going to be fixed by this patch:
https://patchwork.kernel.org/patch/10955321/

The backport will happen soon, but I'm afraid it's not backported to
stable branch yet.

Thanks,
Qu


--Af1eLeKR5tlqa9xa42CKp2Re0y38Spt0r--

--p1AJti17b7994EAwgtCPSOcV517xUSKsZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzuivYACgkQwj2R86El
/qh+AQf+OHS/JdgMLrklAH4Hz1jOJBbRu7buDNRVNPGjIviYaqUZVYeug9stETfo
iTew2Q3YbfH5XNyx4MTm7pWxGfCbZZOn5wVvHs7/UcdzKxY/4kOtXFBwmK43XIOq
7ydLu6aWA5Av5wuh3yEN52Svabs7jIOZJkbhKaAEtrc7XobgzFIQg9ap7jgQiO27
6GTd/hj+NqLE0+q75tN6+P2hxh6J2k01XzmHymfHN5+HFeTYVTo2lK2G5dV37r/j
jLkB7LP1IAaygy4aoI3Wvvsm/uMF9oRh/dxgXHgQx/O0CH9Y4MBD7hbuqjKCnP3H
llwRJUXi5DXlJYjkEHcAGUN+uSwanw==
=F/u3
-----END PGP SIGNATURE-----

--p1AJti17b7994EAwgtCPSOcV517xUSKsZ--
