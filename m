Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6976F8AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 07:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfGVFCW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 01:02:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:44345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfGVFCW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 01:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563771740;
        bh=SUqwr9b5TRhYrzivqi9h1R7kz7lkCgJe3iABVvSY0Jw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=k+ZX7LU9rwqhd5ku7CYUbpoto9n/WmNE6FDcYV9ZWnQwl1jMiKqldUTv8FFdy7Odd
         6mlLOZte/cwzhKBj2zLNDtL2D+MRCQj7zbyT76h2M2fsxuMgHRSWywlFJrelI6Fe7L
         bWzbPYHoFVwXNmI++acoyIcOAv3xUxC1fa1WK8ps=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KYb-1iV4nC0nc1-016gfH; Mon, 22
 Jul 2019 07:02:19 +0200
Subject: Re: reading/writing btrfs volume regularly freezes system
To:     Nathan Dehnel <ncdehnel@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEEhgEsQD1WgqZBZ2YEsEZKKH6X6PSxZGKbMgSVrzkEjVVDFrg@mail.gmail.com>
 <9338f259-47a7-11f7-8411-54f777a59487@gmx.com>
 <CAEEhgEstmUEZs_ArDxRd0RoF70N+w0Pk=CSisQSNK-NWhLga=Q@mail.gmail.com>
 <f950f86e-e42e-4360-f6bd-0502a7070b91@gmx.com>
 <CAEEhgEu09Bn74-P++eGWD89o5ynopgdHMUtzyyC-M-x5rdoavQ@mail.gmail.com>
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
Message-ID: <a20c7328-99ba-09ac-2b32-ac3d0b6b87d6@gmx.com>
Date:   Mon, 22 Jul 2019 13:02:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEEhgEu09Bn74-P++eGWD89o5ynopgdHMUtzyyC-M-x5rdoavQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QWVbS4GCaYo7T1E8BDK0CYo1fbln3mKP8"
X-Provags-ID: V03:K1:2phU2BBFmkkJlJEcv55wY/giSiyLIlj1vhPXFag5/Gxdb9pymOe
 0tTZbPujq9ONIZGkqIG3G4XoXD89GcFqeZDXbIyTJqqsgn1kR1cYq3f/P2occgTC8tCS2wG
 7WuOPCOe07wJCc6mnabAcXuxYhmDxVrTcM91CN36lbIvpV3exJnrB3V4YXGi+aY+a5P5DpV
 RldYduG1h9xKeslsW0enQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9szwN9HDxL4=:K10ODbEWn2VYboCCt8Dit7
 dRbRIM6nM3/j0aa4KY5hfOhiC9Pspfl6HCCZr8EVjMrOZLrfosAc4u8KGgd6/1U/QNz2/x0uj
 efnaipqmeBAYWuajEbVN2AKKeIUmyimyBA3INMrCoBv6mBoJJZ/Ej1hWuDLs3UfB85yB0TYH3
 q8d5k7TbjOQQG8BihhbqSKWbsnZOiJ13VwiIt0EB5RCc0gniBOvIzIFB7778JwCaGhMVulPxk
 QWODJ4QKzkIm2pcwYooQ4Ua+YQswVNaI87zzd44zLMZkZksi9NcNfJiHBYMZ+rI4ru2Jnbz3/
 shs/ZtozaBX2qT5ygVY6XmLVL5l+6JPD5jHa9CqD4ga+5XnLR18T+X0WTnGakel3ENSO3z1ro
 IfvJGGGLZGNgequFKGAsbcuqczIzZvlPBTv/ummvBa4d5R706bHthRHHJWkTM9/uaUcoMQb6B
 4sKzKoSC1rCZRj/FW6vn6jZohcR5W28N9md3KhLUyIUqHd54DayeKu9ZUc69Tltk3kcS4hT9+
 UjoKFsNsOkRbViEpT1Qvi8/++/XEJK/q+BiZgoTdY61kvAwpQcbIV+7q2NfiWwKvVL2zUyPQ4
 mfoTsIo8fq1vFrtVEEP/5xw5kyLMRasZzgA5w59YnM+buX2qZt4DzZqCP6pgpS9r1dLHDKVM7
 HB6H8i+BJnekHUOhivORb2BHYfaJIKvLs6z1BHwqSDIHyMUyBoX51uB6yasbNZw91FeSwbZAA
 QbYH5wV9Fqx/QdJv11m2YyzwkPwV2mUd3TYz8SyO80nUjAS77xNS9PEAgLwL9i/kX4Q8T2TYq
 zrLnYlR7HQ1JoewODYNupcUtqYdyLE1oJmnm8ENwf8INMm+drV5btaJ07ykdDMHjiZIu/gn5I
 yHTe3cT1L8S8v+KLoq8b8FuxzlmBAONIX/SmsoBC12ITqW57XtljMJdiGwG0wzzHLISFKtZ49
 8sLWalPQ94/LMIIlRZTq3glj++xNpBDBAgwvQO5o4smS05nKb6VvrAd38TPQsYCdc62z3Q5tb
 SdOKFXFtRGrBjaO54r8F/OSU4M6e+3qhOe2+yuqgzGGcbCrLCF2CFmSnqzb0pFN4mJ1PwNEuU
 SYEK8owcXn7Wno=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QWVbS4GCaYo7T1E8BDK0CYo1fbln3mKP8
Content-Type: multipart/mixed; boundary="D1yl2CIDWtF0sEkVkGFYx4Mn4PBufRSUb";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Nathan Dehnel <ncdehnel@gmail.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <a20c7328-99ba-09ac-2b32-ac3d0b6b87d6@gmx.com>
Subject: Re: reading/writing btrfs volume regularly freezes system
References: <CAEEhgEsQD1WgqZBZ2YEsEZKKH6X6PSxZGKbMgSVrzkEjVVDFrg@mail.gmail.com>
 <9338f259-47a7-11f7-8411-54f777a59487@gmx.com>
 <CAEEhgEstmUEZs_ArDxRd0RoF70N+w0Pk=CSisQSNK-NWhLga=Q@mail.gmail.com>
 <f950f86e-e42e-4360-f6bd-0502a7070b91@gmx.com>
 <CAEEhgEu09Bn74-P++eGWD89o5ynopgdHMUtzyyC-M-x5rdoavQ@mail.gmail.com>
In-Reply-To: <CAEEhgEu09Bn74-P++eGWD89o5ynopgdHMUtzyyC-M-x5rdoavQ@mail.gmail.com>

--D1yl2CIDWtF0sEkVkGFYx4Mn4PBufRSUb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/22 =E4=B8=8B=E5=8D=8812:25, Nathan Dehnel wrote:
> I'm still experiencing freezes with kernel 5.2. Here's a backtrace:
>=20
[snip]

This time, there is no backtrace of btrfs functions at all, nor nfs ones.=


Is the backtrace complete? If so, it would be something else causing the
problem.

Thanks,
Qu


>=20
>=20
> On Sat, May 11, 2019 at 6:21 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>> [362108.291969]  btrfs_tree_read_lock+0xbb/0xf1
>>> [362108.291973]  ? wait_woken+0x6d/0x6d
>>> [362108.291978]  find_parent_nodes+0x91d/0x12b8
>>> [362108.291985]  ? btrfs_find_all_roots_safe+0x9c/0x107
>>> [362108.291988]  btrfs_find_all_roots_safe+0x9c/0x107
>>> [362108.291992]  btrfs_find_all_roots+0x57/0x75
>>> [362108.291997]  btrfs_qgroup_trace_extent_post+0x37/0x7c
>>
>> It's qgroup.
>>
>> We have upstream fix for it, 38e3eebff643 ("btrfs: honor
>> path->skip_locking in backref code").
>> It's supported to be backported for all kernels after v4.14.
>> But I'm not sure if it's backported for your kernel.
>>
>> As you're gentoo user, it shouldn't be hard to check the kernel source=

>> to find if the fix is backported.
>> If not, feel free to backport for your kernel.
>>
>> Thanks,
>> Qu
>>
>>
>>> [362108.292002]  btrfs_add_delayed_tree_ref+0x305/0x32b
>>


--D1yl2CIDWtF0sEkVkGFYx4Mn4PBufRSUb--

--QWVbS4GCaYo7T1E8BDK0CYo1fbln3mKP8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl01Q1cACgkQwj2R86El
/qgRrAf+KgvGxfXdKo8W4SwVm6Tg03MLWt5C0OWS0S1nL2caqjcEdLeH4jcLwbsk
Y11CcxhdznTLs5XFrb9ajAwOiKbnnoioyLB5qQpFu/1xSSZmhCrnycjN67lzmD8o
GuCc64sbDsHageAbBwzr+ciOttlbHN33PcWrB/xxTqLDc7GSe61rgswQ2t3tZbW7
uiQWo2Y0Z7XJkwXXlxBAVsVvSQYNHOPklTp1lygkxytswdtoc6b77GjrpkiXaavU
URUY7YNAfB/nRST+3IPwJZhL2mD3PXA429EPGu918POXU/MFNcJOCCtPyArZgc3z
MsLMF07rsDFLWUcaytu8z8w06LIx0Q==
=wW1Q
-----END PGP SIGNATURE-----

--QWVbS4GCaYo7T1E8BDK0CYo1fbln3mKP8--
