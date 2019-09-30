Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198EDC1FB1
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 13:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfI3LCS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 07:02:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:56815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbfI3LCS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 07:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569841309;
        bh=QJE6Pusg0DSSoBjW8iRLBot5X1TxGVOCs9s3dLmcyLk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UaHbkUPYzwF03BXFxm7yWUhLj+JaaldeAPKGnJFaUgF9oKLO7l+56KZv6wY6dpmxy
         Mkyr5FjDxrBVswU2KZUqyoGd3jfuBVoIncPtaFMd89JEyZJb702Yx6nEH8iBjtDCXL
         JAZSADDgPbaPr/E+cMY6pdrZa93VRQkVoisH4KvA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdNY8-1hfYcO3lFw-00ZQkM; Mon, 30
 Sep 2019 13:01:49 +0200
Subject: Re: [PATCH] fstests: btrfs: Add regression test to check if btrfs can
 handle high devid
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190930083735.21284-1-wqu@suse.com>
 <CAL3q7H5mVHUQJ31wANwM8hXbbumwcUNrxSCebv46zpgEGYA2zw@mail.gmail.com>
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
Message-ID: <7716f94d-214a-6756-6065-806c0707d85d@gmx.com>
Date:   Mon, 30 Sep 2019 19:01:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5mVHUQJ31wANwM8hXbbumwcUNrxSCebv46zpgEGYA2zw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m2ukn0GdM0IGyte4aBKtQPwQfKm2syjNg"
X-Provags-ID: V03:K1:iMpBcL/gMJJ4SbxS+DwEn2xH5qJAn1bZo59lMgB4fpaYC/xtqz7
 fqR2JqV45ABBaJgS42bLPiooKpLynbipHQ3cYWAuaV5/ZlbrPeREuQJGiqL3Bo0SOvbBBSA
 HhDlZU7qmjF26VxThagRp+O5P6li23JQSiOTj/nKTY8zDwG2XQHtQveTtxDtX7Bk6Euhw1c
 gdkGYWN2xZGuzmFDpaUVQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v7EqxhCjTzg=:ZXTxExWaxOio1I9cn0YNSZ
 9BFQlpOVhLnDowQ+jXtzSU3y5IhcJN0oiqo9cFHhIFEKFgk164tTkzGZhtHvY2CNZVEI3IWFh
 mVTQBd7mTeGL576PmQjcwExIArz45IfnskraUivDMLqL9vOzMhyUJZr7hVSGpHMwuiLqwe1lQ
 wWdqTPUEJxVix1eUDSVgqlVgCl1Ot9c6Ak6VtJzxsV2MGieck2vr2ulcHsULM/2TRyXJEg0nk
 TSKMQZnHRXDJk073S91l6nZJbWJ7qVI86JN320HOjw6vHns3DKJOZNo8Jfl63YW6rbl3tZc+6
 O6suiU3AFiJCkK2CNmgXaF+BLX1qqlPO3h0TiFDbvwV+OSuOcyst513XgTn685td8fbBx4LX3
 FSEr82KYu/LeQ+dl62yGvCOr3wzmaQuXZs7aGAzXz2uF9Q9qHzg7MFx0xKmuqYS2FVh+DREuf
 wNCyVlXBlExQPsAg6rrKC/DZcVtRAlmmENKGVgB/pXaUnAhYaQn6U1PmOdMfCC2dpqkn/V1Tk
 85IJW/vmzx/ZvpgXTsSY54iGLhVWmYrDn1lwyyebNHEV/acM9oYUAs+fC+F1/qTL4z5BJJszJ
 xg0zidCHVjLZDNbGSy0x+qEkXdhnIPEwY4tozqjY7HvT9h028zgkLN4ov77n2S3z9EAev5zS4
 Vv0RUcQgy2vAe6rEd/s6AavpAT/Uzhk4BQiPbGN/3tIP54q3w4nTtlqQ1ajIN97bN0xqouylh
 U5pEoLRuszxzgV3i3DAZlDg8dUDEARUzotn3Bc5phrKyHCJrbbi2c6NjnqFhMtJbrkMjxkxDW
 qrfW8AQXCO/S99Spa8oksANbrFzC5nD/kNgONrEhpYUGodfvc5lv990MqUIy8CwRFFGVq4gEB
 9FdlF8paZQxhD9fSKk2/mF8t3XPOg1IDrnnmWlfFHg4fBlwv6dXOs1OvvFIuvm90CLsHRYr5/
 xPv+zxZTLbwy9wP34kt2Xqarvhrb3OVe6qtmSjSnf5etlf+Ma8RBDJK75/6fT5DOpNFjgn3rg
 EmhdYyv0C1jx/D0Z83cBG3Ol7zG+xI19twV50eDDtentCoDb/RX/rVWXyfpkcrsqbhNq9UzyJ
 x6XhwEePuUCdQZFqlFq48yMM3GMFZ9LiyCaXp1D6W2CotY1dACOKFxfa2GuEMrLagk30zrlJe
 z6yU5YKpattIoaaq6sB6okHLKEop2z4obr150+Mc/KSidzo/ad4D9F/2KRHaPxTcE7tcQmjzS
 TOACHHP4aExXJkbX1nwX/M+IOhxGa1gxpAX4B3jNYF2OPWDST4i/SEG3Tnok=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m2ukn0GdM0IGyte4aBKtQPwQfKm2syjNg
Content-Type: multipart/mixed; boundary="HkkywR8IVE5heDnCYKXVj4NsogFcWlYJt"

--HkkywR8IVE5heDnCYKXVj4NsogFcWlYJt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=886:33, Filipe Manana wrote:
> On Mon, Sep 30, 2019 at 9:39 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Add a regression test to check if btrfs can handle high devid.
>>
>> The test will add and remove devices to a btrfs fs, so that the devid
>> will increase to uncommon but still valid values.
>>
>> The regression is introduced by kernel commit ab4ba2e13346 ("btrfs:
>> tree-checker: Verify dev item").
>> The fix is titled "btrfs: tree-checker: Fix wrong check on max devid".=

>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/btrfs/194     | 73 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/btrfs/194.out |  2 ++
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 76 insertions(+)
>>  create mode 100755 tests/btrfs/194
>>  create mode 100644 tests/btrfs/194.out
>>
>> diff --git a/tests/btrfs/194 b/tests/btrfs/194
>> new file mode 100755
>> index 00000000..7a52ed86
>> --- /dev/null
>> +++ b/tests/btrfs/194
>> @@ -0,0 +1,73 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 194
>> +#
>> +# Test if btrfs can handle large device ids.
>> +#
>> +# The regression is introduced by kernel commit ab4ba2e13346 ("btrfs:=

>> +# tree-checker: Verify dev item").
>> +# The fix is titlted: "btrfs: tree-checker: Fix wrong check on max de=
vid"
>=20
> type, titlted -> titled
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
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch_dev_pool 2
>> +_scratch_dev_pool_get 2
>> +
>> +# The wrong check limit is based on node size, to reduce runtime, we =
only
>> +# support 4K page size system for now
>> +if [ $(get_page_size) !=3D 4096 ]; then
>> +       _notrun "This test need 4k page size"
>> +fi
>> +
>> +device_1=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
>> +device_2=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>> +
>> +echo device_1=3D$device_1 device_2=3D$device_2 >> $seqres.full
>> +
>> +# Use 4K nodesize to reduce runtime
>=20
> How does the node size reduces runtime?

The old wrong check is based on how large a chunk item can be.
The macro we use is BTRFS_MAX_DEVS() which takes fs_info->nodesize to
calculate.

The largest chunk item (or any item) is based on nodesize.
Thus nodesize will affect the runtime.

> It's obvious when one wants to create deeper/larger trees for some
> purpose, but this test doesn't populate the filesystem, it uses an
> empty filesystem.
> So that deserves an explanation of how the node size influences the
> test's running time.

Indeed.

>=20
>> +_scratch_mkfs -n 4k >> $seqres.full
>> +_scratch_mount
>> +
>> +# Add and remove device in a loop, one loop will increase devid by 2.=

>=20
> " ... one loop will ..." -> "... each iteration will ..."
>=20
>> +# for 4k nodesize, the wrong check will be triggered at devid 123.
>=20
> Why 123? It's not clear to me why, the test case doesn't explain and
> neither does the btrfs patch that fixes the regression.
> If it's related to the value of the constants/functions
> BTRFS_MAX_DEVS and BTRFS_MAX_DEVS_SYS_CHUNK, it should be mentioned
> here.

OK, I'll mention
>=20
>> +# here 64 is enough to trigger such regression
>> +for (( i =3D 0; i < 64; i++ )); do
>> +       $BTRFS_UTIL_PROG device add -f $device_2 $SCRATCH_MNT
>> +       $BTRFS_UTIL_PROG device del $device_1 $SCRATCH_MNT
>> +       $BTRFS_UTIL_PROG device add -f $device_1 $SCRATCH_MNT
>> +       $BTRFS_UTIL_PROG device del $device_2 $SCRATCH_MNT
>> +done
>> +_scratch_dev_pool_put
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
>> new file mode 100644
>> index 00000000..7bfd50ff
>> --- /dev/null
>> +++ b/tests/btrfs/194.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 194
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index b92cb12c..ef1f0e1b 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -196,3 +196,4 @@
>>  191 auto quick send dedupe
>>  192 auto replay snapshot stress
>>  193 auto quick qgroup enospc limit
>> +194 auto
>=20
> Maybe volume group as well.

Thanks for the hint, I was looking into the groups but can't find a good
candidate.

At least volume makes more sense.

Thanks,
Qu
>=20
> Thanks Qu.
>=20
>> --
>> 2.22.0
>>
>=20
>=20


--HkkywR8IVE5heDnCYKXVj4NsogFcWlYJt--

--m2ukn0GdM0IGyte4aBKtQPwQfKm2syjNg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2R4JgACgkQwj2R86El
/qhkGgf/VKKi6IiwZvAUtsLMvi0fD/TLfBpAYv6XFhW+u1YCj4f7JbBUMzP8pCUb
2/iN4YWaHFbVsFk1GjuCD0UOiFAlRAPNpI+HEp5fhWrA/JvroRCg/Qe88pXVXP9B
jF4R0aiYzpVWyhy2/duzXmiFk7n541bpqsW1g0GdN65TU8aKq8SzLXMueRP58dTi
LUjvQCAXJnpUI/V666cvA/f6N/TCLQmW/UNAtBleROr6VGitu2Er6VM7rklRNinC
T2nbW3L0WjrCgYuOYFLf+fb+WOA2j3uNsvOTqi5/omB2b8cN+Wqw1qP8pTfTJ9ta
P4Qxk29FQIaIpJiyLeXTH743tczvag==
=Jq20
-----END PGP SIGNATURE-----

--m2ukn0GdM0IGyte4aBKtQPwQfKm2syjNg--
