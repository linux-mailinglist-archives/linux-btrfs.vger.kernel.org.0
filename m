Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796E617631
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2019 12:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfEHKoy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 May 2019 06:44:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:41643 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfEHKoy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 May 2019 06:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557312285;
        bh=xY73WtsWK1tfZY0exEsg1yNY6OuL80r41QwDXtPmyCI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bSi3B0KB0Fm/0BgA3M5yOUG/AbdfymtR9G0hMgs0LFAxroK68BvxIPdUu876NBRE7
         nemPFd7ylVU/2lu7Z7jNJyKIUb5aBmbVerC6B3zbRQv7KEblBPAJW2iuAv7zqvEyqj
         GcKb2tTrvCR57mpSJcZliKp3EeC8xpd2B+jo/+VU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lusmr-1ggUt03sjx-0107jt; Wed, 08
 May 2019 12:44:45 +0200
Subject: Re: [PATCH v2] fstests: generic: Test if we can still do operations
 which don't take extra data space on a fs without data space
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
References: <20190508094504.15474-1-wqu@suse.com>
 <CAL3q7H5ODBJSAxwRoJM_Nt1YUy4rH-+b39JdGp=yPPUJ=h+axw@mail.gmail.com>
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
Message-ID: <add1d216-d19d-a322-95d4-0a6bbbb1487f@gmx.com>
Date:   Wed, 8 May 2019 18:44:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5ODBJSAxwRoJM_Nt1YUy4rH-+b39JdGp=yPPUJ=h+axw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AaGLY4zXlIlOjfziuaTu4fbJJu19zGopg"
X-Provags-ID: V03:K1:z8E/R0AksU9CHtal8UoKrvEgfKVJC4KXISM0FPKLyDrwFlwcRGP
 LIOan56UeE+RbXamUCEw5doVo2fDiUljrguDzH5SYYec2/NaZ6+D3hbtEGUaBtFOuANlI5t
 FXYARIEU+4SELLJ8KwrLoKMsFyvlG67q24+16q4D4HfEF8Nb28UQ80Lzcga2FJOLY86gPot
 8p2LtK2cFip0P7ZxSquqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+oKEAjL/JwM=:WolWtt0kBxFAqKU2xGbc25
 Cfwc06/qAAjNXOwwNrf0aT0Q3g1uIrsUNzZ85ikFFeOmKdZi1a84LWQER1NUnaqVRjjoRvYyL
 +Z2FDT8pjjr9eKWjYbqI6fGwmOx5Am7ma1p25BuOJZV9Jwg8Bsro3ZDFAhvWuPDpq7naudY4Y
 it7vo9RUtFOJcsuHzdUrxUSFzHqKvXzxoRDiyu7oDEfs7Bg9ghDxYEGspFnKAnfY1bj5DDHdv
 uJUu++fIFzHz2sTZHd9zDnsRxVo7H34yqxTsZcJfnbtSO3ZXlz/rill5XC6pZK4l/739WY7O7
 n7CPRu46XRaGYYhichzQ8FefXL3nz3cEKe3bI2boeHaQS4yHyCJ+8rjootaD4y4969NcstZuw
 8WHOctFytRYM8lLD0qwLItwa33AZgsjes5oGTBEDnayrljhaB/sqi7P7+7+liSWx+k/+T/JzB
 Zvp19oLD9t6yeQheiaeRCigznZ/7UAbKnfybw/QJNnKBP8y0H/oKqlSCgpIHHRmnNQsy7fn9m
 gEXVQhbaTLMdPZwFrwp47f+nSpoAe+C1mpPWIK1vmAH6yYlJTmOtoGoxMCLc8R7fAX/wuREmF
 wcW85B1NQAs+GYg9lpMibVj66CyFPy5YH3brWKmEvL2636WPRdAzqmRQ8mjdlfWWA67ktlyiH
 GlX355jEg77Xp2RLZtSUvMGx4e3dXFv6r3XX+OZEp2ptS8bQzSYagtvgK/NCxdMwZ2XsyN1JP
 8nSdkEd5WiOdX8KdzRn+pAoqRYSl4vRX4BUMHaeINYOJwYJ7G0GK/5iMC+5ma1/0mmVcE/B3m
 9GDbLlsddYbmfaK+YneXzp7aytU0zk2H1s+klGu2imPWyhFVzAYJU9LBNC0zn3L5BKruxad8l
 H4cOA9sjyMXozHqVU/bn8X2P0o+ItUJ1kNDVp3y4Qasy6ml0hVc8Kgx5Fv6b7w
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AaGLY4zXlIlOjfziuaTu4fbJJu19zGopg
Content-Type: multipart/mixed; boundary="G5zbZN9FGwnimqRZcIgRHVvbU5SpBEX1M";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>,
 fstests <fstests@vger.kernel.org>
Message-ID: <add1d216-d19d-a322-95d4-0a6bbbb1487f@gmx.com>
Subject: Re: [PATCH v2] fstests: generic: Test if we can still do operations
 which don't take extra data space on a fs without data space
References: <20190508094504.15474-1-wqu@suse.com>
 <CAL3q7H5ODBJSAxwRoJM_Nt1YUy4rH-+b39JdGp=yPPUJ=h+axw@mail.gmail.com>
In-Reply-To: <CAL3q7H5ODBJSAxwRoJM_Nt1YUy4rH-+b39JdGp=yPPUJ=h+axw@mail.gmail.com>

--G5zbZN9FGwnimqRZcIgRHVvbU5SpBEX1M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/8 =E4=B8=8B=E5=8D=886:38, Filipe Manana wrote:
> On Wed, May 8, 2019 at 11:06 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> This test will test if we can still do the following operations when a=

>> fs has no extra data space:
>> - buffered write into unpopulated preallocated extent
>> - clone the untouched preallocated extent
>> - fsync
>> Above operations in a row should not fail, as they takes no extra data=
 space.
>>
>> Xfs passes the test, while btrfs fails at fsync.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> changelog:
>> v2:
>> - Change the comment and commit message to make it describe the test
>>   itself, not the btrfs specific part.
>> - Use $XFS_IO_PROG to replace xfs_io.
>> ---
>>  tests/generic/545     | 70 ++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/generic/545.out |  2 ++
>>  tests/generic/group   |  1 +
>>  3 files changed, 73 insertions(+)
>>  create mode 100755 tests/generic/545
>>  create mode 100644 tests/generic/545.out
>>
>> diff --git a/tests/generic/545 b/tests/generic/545
>> new file mode 100755
>> index 00000000..9efaf58c
>> --- /dev/null
>> +++ b/tests/generic/545
>> @@ -0,0 +1,70 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 545
>> +#
>> +# Test when a fs is full we can still:
>> +# - Do buffered write into a unpopulated preallocated extent
>> +# - Clone the untouched part of that preallocated extent
>> +# - Fsync
>> +# All operations above should not fail.
>> +#
>> +# Xfs passes the test while btrfs fails. The fix for btrfs is:
>> +# "btrfs: Flush before reflinking any extent to prevent NOCOW write f=
alling
>> +#  back to CoW without data reservation"
>=20
> Again, this part that says it currently fails on btrfs, passes on xfs
> and which patch fixes the problem for btrfs, should be in the
> changelog and not on the test description.
>=20
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1       # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/reflink
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_scratch
>=20
> Not needed, because below you do _require_scratch_reflink
>=20
>> +_require_scratch_reflink
>> +
>> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +# Create preallocated extent where we can write into
>> +$XFS_IO_PROG -f -c 'falloc 8k 64m' "$SCRATCH_MNT/foobar" >> $seqres.f=
ull
>> +
>> +# Use up all data space, to test later write-into-preallocate behavio=
r
>> +_pwrite_byte 0x00 0 512m "$SCRATCH_MNT/padding" >> $seqres.full 2>&1
>> +
>> +# This should not fail
>> +_pwrite_byte 0xcd 1m 16m "$SCRATCH_MNT/foobar" >> $seqres.full
>> +
>> +# Do reflink here, we shouldn't use extra data space, thus it should =
not fail
>> +$XFS_IO_PROG -c "reflink ${SCRATCH_MNT}/foobar 8k 0 4k" "$SCRATCH_MNT=
/foobar" \
>> +       >> $seqres.full
>> +
>> +# Fsync to check if writeback is ok
>> +$XFS_IO_PROG -c 'fsync'  "$SCRATCH_MNT/foobar"
>=20
> It would be more useful to not only check that fsync does not return
> an error, but also to check that if a power failure happens, when we
> mount the fs again all the data previously written is there.

A quick glance into the group shows no enospc test with reflink/clone
and log/replay.

So it makes sense.

Thanks,
Qu

>=20
> Thanks.
>=20
>> +
>> +echo "Silence is golden"
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/generic/545.out b/tests/generic/545.out
>> new file mode 100644
>> index 00000000..920d7244
>> --- /dev/null
>> +++ b/tests/generic/545.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 545
>> +Silence is golden
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 40deb4d0..f26b91fe 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -547,3 +547,4 @@
>>  542 auto quick clone
>>  543 auto quick clone
>>  544 auto quick clone
>> +545 auto quick clone enospc
>> --
>> 2.21.0
>>
>=20
>=20


--G5zbZN9FGwnimqRZcIgRHVvbU5SpBEX1M--

--AaGLY4zXlIlOjfziuaTu4fbJJu19zGopg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzSsxcACgkQwj2R86El
/qjcfwf+L5Yst7xzoxqnMNTEeP327ySkjCIMSlLqc2Qmvmpqapi3UWQffh0lc7sB
LDEUvNt5SngCnAF2RVPm19REtkoUu1j/fx4W097zEm9fnP1oaahO+SOVQxSGhs0q
iEOdL347Fop6ky/WHAeWGozlZqM9dBOP6GgLYjxwUO9kNGcIzCV8R/FpM2Q66J5T
s0Y1bHNzIZGhRwwpW+wPjTdG4VguYGQApZD8aCY4Z7n4ustm91CzfqUfaqzi+Ey6
a+TKaRW8RjdwV5ImS7awADhnRx5S0nUdxntkiPsYBs9VeME3Ap6swhevDD0u3yD+
Z+/LhK0NCe262om45BKBDdW9b7ElPw==
=++Tq
-----END PGP SIGNATURE-----

--AaGLY4zXlIlOjfziuaTu4fbJJu19zGopg--
