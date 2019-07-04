Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E714F5F19E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 04:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGDCzI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 22:55:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:46929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfGDCzI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jul 2019 22:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562208892;
        bh=Se0AvvOKfy3VaGrKr38EmJnwCor+qADq+SpzNe/n/5Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fEP/3NiNUbe0ejbVGvO/FtYvDav96Fjxp86DIxIjqr4YUaQ4rB/N++eCApoDBo030
         MTWF8q9FePWTkuThT9xFJHasKlbOA3ngd3yTF0HQrrhl8kn9MjEUK3jx/oZsdJobQx
         dXoQz4BakdkU0SJD44q7aPv0CSezRNJ2oUZUOpnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdNY8-1iICiJ3jiy-00ZPuB; Thu, 04
 Jul 2019 04:54:52 +0200
Subject: Re: [PATCH v2 00/14] btrfs-progs: image: Enhance and bug fixes
To:     Anand Jain <anand.jain@oracle.com>, WenRuo Qu <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190702100650.2746-1-wqu@suse.com>
 <67e5ce0a-3a4d-3392-a2c8-fca86ef90fbe@oracle.com>
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
Message-ID: <6b1c93ba-9d99-62e0-5074-6d84de555efb@gmx.com>
Date:   Thu, 4 Jul 2019 10:54:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <67e5ce0a-3a4d-3392-a2c8-fca86ef90fbe@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eXOwjslegawnt3EpykUzHh5me3tPyK0aV"
X-Provags-ID: V03:K1:2otoonNMibWcK+aIwwdr8oFwwtDV9u1F48eS9Br/whtK2DmlQoz
 4FODnrbMa6TB3nnJCDbx2pCzGL/lPZw3nw1U5XZt/c+UyhelHnH/E3VcUTd5vr1U+CUbT5G
 +3spOSDnzQ45q4F6/Yft1WX0i7THwIJdkOAa2v/CNugN1gkgnjBzrqDaXA8KPqkiBQCG+Gv
 xyRJDu3xNfclMlv6xHgJQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:P9JmqCN2wB0=:b6z4wPzZdd+pSu9q+rT5bL
 nsQjUxOAAJzd4WGogBPAeZMlxdvktnZaHRjJ8QghoclnyosA2dFysiMFHT1sX7sKlFc4pDD03
 Ws5zhkLv55zNUWjQUTFM6+SoVhaTwCMChz4JnM+go7zUXOcK7+Z3R9OWY9u5V4O78ImyxbLEh
 o3/oEyoxZ7CGe0QYL94wIBXeTw93wT5l3Z/1F07DwtT8dq8qwCjcJY+znjT6U2oQj/GiBM+U9
 RQdSWlLoyXuG9XDUHqmK5u0kFqRwVsGOVcyw80CMB1ItPHvs/TDYmB2qI7DDsQmSEran9LJKT
 mgG84OakjyGqgPrLju6baAlULLpZTRzkZb/ovdxo+b4MES11BXoYMciA+4ZuwMDObRI8S/D10
 orODw35AQ4KYYdvXRCyglMH0bziGOVZrjw5LV7IgeTcDsLkcJnj+6zxzS1eW/V61v6nPwXL/e
 XPjQIJ3E3iftMa+Vkd9bYbFvTerNZuqZmyK/YLKPfsP3eubBmfXGcUPkT/SCyGmcB8v5jDMg/
 EUyJx0SI8kHayTro6uq+Wz30kvdT91oRjmmXHE9xJgN55CrdNuckHZdTcBRSR0Kf9WomwlK0V
 1A5MGjgmeg3CpBzATUjkJ/8k+RE5xy2JQWYkF//wkkEqkPYae+vHCuprqPjVYrtmw0b1iteCu
 PMXJncgGH9FWg0O7ZTU+vioIXX3pO3EuYtUbbCfPr1/bRYfwPiwfN4bL3uSu5RCDChHKG7RbD
 Rek1bwv6RgOD52NB5MTK8sy+1E8a43cSvxyc0iCIm9DH0JGoBbuyCJZbAspvLv0ob3Mkrmsd2
 gGAQkKSOA7xsmZefedjsaeufm59HxEr07JPrN+MlOYy4V2cAocJ1sHibBqKYqdq5nr40MS1HY
 jjFGNlhVZqRQ/RY9LNsmz2WQDdwo2uTg/jfPETunN9GMeYMED9FNoQMgDGTSvpxUFyQ5zVhjQ
 C2ckzcGbnAsD23vQVC25TjCKgwKnIqYF83hrSCJupyHSlJA9IzqFFa9Fsubg8nkmToVDiCNMo
 hUW5+jR9Ljlf/HH4QmOuvufVd6KUKEpxsjQQGNb9as/Nj666FFGFm4CyYbheSbl//7+1NVERY
 VkeVksoqxqtQbg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eXOwjslegawnt3EpykUzHh5me3tPyK0aV
Content-Type: multipart/mixed; boundary="HrDCemZv8SjvDA1HRzripyOALSP2ZqWDj";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, WenRuo Qu <wqu@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <6b1c93ba-9d99-62e0-5074-6d84de555efb@gmx.com>
Subject: Re: [PATCH v2 00/14] btrfs-progs: image: Enhance and bug fixes
References: <20190702100650.2746-1-wqu@suse.com>
 <67e5ce0a-3a4d-3392-a2c8-fca86ef90fbe@oracle.com>
In-Reply-To: <67e5ce0a-3a4d-3392-a2c8-fca86ef90fbe@oracle.com>

--HrDCemZv8SjvDA1HRzripyOALSP2ZqWDj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/4 =E4=B8=8A=E5=8D=8810:13, Anand Jain wrote:
> On 2/7/19 6:07 PM, WenRuo Qu wrote:
>> This patchset is based on v5.1.1 tag.
>>
>> With this update, the patchset has the following features:
>> - various small fixes and enhancements for btrfs-image
>> =C2=A0=C2=A0 * Fix an indent misalign
>> =C2=A0=C2=A0 * Fix an access-beyond-boundary bug
>> =C2=A0=C2=A0 * Fix a confusing error message due to unpopulated errno
>> =C2=A0=C2=A0 * Output error message for chunk tree build error
>> =C2=A0=C2=A0 * Use SZ_* to replace intermediate number
>> =C2=A0=C2=A0 * Verify superblock before restore
>>
>> - btrfs-image dump support
>> =C2=A0=C2=A0 This introduce a new option -d to dump data.
>> =C2=A0=C2=A0 Due to item size limit, we have to enlarge the existing l=
imit from
>> =C2=A0=C2=A0 256K (enough for tree blocks, but not enough for free spa=
ce cache) to
>> =C2=A0=C2=A0 256M.
>> =C2=A0=C2=A0 This change will cause incompatibility, thus we have to i=
ntroduce a
>> =C2=A0=C2=A0 new magic as version. While keeping all other on-disk for=
mat the same.
>>
>> - Reduce memory usage for both compressed and uncompressed images
>> =C2=A0=C2=A0 Originally for compressed extents, we will use 4 * max_pe=
nding_size as
>> =C2=A0=C2=A0 output buffer, which can be 1G for 256M newer limit.
>>
>> =C2=A0=C2=A0 Change it to use at most 512K for compressed extent outpu=
t buf, and
>> =C2=A0=C2=A0 also use 512K fixed buffer size for uncompressed extent.
>>
>> - btrfs-image restore optimization
>> =C2=A0=C2=A0 This will speed up chunk item search during restore.
>>
>> Changelog:
>> v2:
>> - New small fixes:
>> =C2=A0=C2=A0 * Fix a confusing error message due to unpopulated errno
>> =C2=A0=C2=A0 * Output error message for chunk tree build error
>> =C2=A0=C2=A0 - Fix a regression of previous version
>> =C2=A0=C2=A0 Patch "btrfs-progs: image: Rework how we search chunk tre=
e blocks"
>> =C2=A0=C2=A0 deleted a "ret =3D 0" line which could cause false early =
exit.
>>
>> - Reduce memory usage for data dump
>=20
>=20
>> Qu Wenruo (14):
>> =C2=A0=C2=A0 btrfs-progs: image: Use SZ_* to replace intermediate size=

>> =C2=A0=C2=A0 btrfs-progs: image: Fix an indent misalign
>> =C2=A0=C2=A0 btrfs-progs: image: Fix an access-beyond-boundary bug whe=
n there are
>> =C2=A0=C2=A0=C2=A0=C2=A0 32 online CPUs
>> =C2=A0=C2=A0 btrfs-progs: image: Verify the superblock before restore
>> =C2=A0=C2=A0 btrfs-progs: image: Introduce framework for more dump ver=
sions
>> =C2=A0=C2=A0 btrfs-progs: image: Introduce -d option to dump data
>> =C2=A0=C2=A0 btrfs-progs: image: Allow restore to record system chunk =
ranges for
>> =C2=A0=C2=A0=C2=A0=C2=A0 later usage
>> =C2=A0=C2=A0 btrfs-progs: image: Introduce helper to determine if a tr=
ee block is
>> =C2=A0=C2=A0=C2=A0=C2=A0 in the range of system chunks
>> =C2=A0=C2=A0 btrfs-progs: image: Rework how we search chunk tree block=
s
>> =C2=A0=C2=A0 btrfs-progs: image: Reduce memory requirement for decompr=
ession
>> =C2=A0=C2=A0 btrfs-progs: image: Don't waste memory when we're just ex=
tracting
>> =C2=A0=C2=A0=C2=A0=C2=A0 super block
>> =C2=A0=C2=A0 btrfs-progs: image: Reduce memory usage for chunk tree se=
arch
>> =C2=A0=C2=A0 btrfs-progs: image: Output error message for chunk tree b=
uild error
>> =C2=A0=C2=A0 btrfs-progs: image: Fix error output to show correct retu=
rn value
>>
>=20
> How about separating the -d option enhancement patch from rest of
> the patches? Looks like -d option patch is only one, and the rest
> can go independently?.

For all the minor fixes like error message, the already merged ones, and
the chunk tree search part, no problem.

For the memory reduce part, it's only needed if we're going to support
data dump.

Unfortunately (or fortunately), the decompression memory usage reduction
is only needed if we enlarge the max_pending_size (used by data dump).

The original max_pending_size is just 256K, 4 * 256K per-thread is just
a piece of cake for modern systems.

If we don't need data dump, then the memory reduce part doesn't make
much sense.

I'll update the patchset to sort them into the following parts:
- Minor fixes
- Chunk tree search enhancement
- Data dump
- Memory reduction

Thanks,
Qu
>=20
>=20
>> =C2=A0 disk-io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 6 +-
>> =C2=A0 disk-io.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 1 +
>> =C2=A0 image/main.c=C2=A0=C2=A0=C2=A0=C2=A0 | 874 ++++++++++++++++++++=
+++++++++++++++------------
>> =C2=A0 image/metadump.h |=C2=A0 15 +-
>> =C2=A0 4 files changed, 666 insertions(+), 230 deletions(-)
>>
>=20


--HrDCemZv8SjvDA1HRzripyOALSP2ZqWDj--

--eXOwjslegawnt3EpykUzHh5me3tPyK0aV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0danYACgkQwj2R86El
/qg0SAgAnKNHxD5ukn0LhISd/JQfKxvOHYqfFmcJQ2kQZwdKMLcrchV/6vPAtZHe
y1Ptfik/DaHBql/2IynJ3cGnFX7SIcEusnjXaal+QGVHJ7uGVyTiq+d/rrpuuRdY
OAvBm9Leas1GWki1jduU7E2uG1e0J61C8eQ9ngPy4GtwxnNIVrEMNfI1UyIiHkmk
5Ue8uleqvRnrRSk9rzcrXYpNEyj/sNmm83vKzv5xvnsomAnjRDdyLR9M99sMjPD6
JUXymZyECdBJSIRDUKnJR+R4MbcCbo7F9BSKaGGhTMeZ8AUNYJxvSPGZLUaBWIxr
gQsAFvB15fFS2+FawxJwipWdNWJpSA==
=/eQB
-----END PGP SIGNATURE-----

--eXOwjslegawnt3EpykUzHh5me3tPyK0aV--
