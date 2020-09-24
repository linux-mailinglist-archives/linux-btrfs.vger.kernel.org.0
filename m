Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02FC276565
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 02:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgIXAsh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 20:48:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:46911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgIXAsh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 20:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600908506;
        bh=SZY0lipYQFC8i50P8GY7rhNIu0Mzq/e7FcIyrwQTBRQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dVsiT3if3hjnXE9ts85wZPQEoTlr6RuBt2K97HlEzXbabItBW2otXOr+g5MvAr8pv
         GWZ4lAv/Tkscbw+VDnWW6Qq2PnTraaePGG442onenAQUp6LN90BhkEau7FzbYGD1Gq
         5o6YavufhXimcA74R2Nan6mvmGNAOhfuPgxG4BGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw3X-1kkeV83lnX-00j0Lg; Thu, 24
 Sep 2020 02:48:26 +0200
Subject: Re: [PATCH v2] btrfs: Add new test for qgroup assign functionality
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Eryu Guan <guan@eryu.me>
References: <20200922153604.10004-1-realwakka@gmail.com>
 <de490dbb-6fd2-be19-54b5-7e4a4c5e10c5@gmx.com>
 <20200923165028.GA1091@realwakka>
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
Message-ID: <0a1b6b19-20bf-b278-13a5-89543e9b7997@gmx.com>
Date:   Thu, 24 Sep 2020 08:48:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923165028.GA1091@realwakka>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bb0bcAV9BeZTggjQomMYExytg5tdFJXYV"
X-Provags-ID: V03:K1:wExzNrDpBNA9Sf31Jxj+Y8YNiDnUDMFnAc2YYU5iQGaZM/pOxXR
 d5A1zuSNBQeQT0ms1G4FYeuOZ7GTW9fHXwrlCvDODP7qRwOk2yIxhp3tEb71r3b8IWBMH4c
 yLVXCJcLO3sgCCE73RbzWSp6h1lkgKwWxK30wYhsYzCFywBDo5NyimZu2shqkZoX8v1LrKW
 TrMLgKXNELW/UoUVJh3zQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6QnQa7Iwlbo=:Xmz9ZXNMjs45y0YPITUvat
 Qknt7TYueZT3+/78S90dPp4HSwJYKRrjHlYa5nZEWd9Z3gFYFYlmiaNoHmEuFyas4tb39oIGf
 HHRxT0ekRLkTWjDW76MLkH3en0/8PrOGxLbo2JE81SOsRZkMT6B2y2hBewWCozcygkzDs+OcC
 afSdLYf2JrOKJmLk3OVySsp3thcBHmBEbYfnUtNiP8iE3fM1X4Svbddf+hUpcwCbcj5VLOITi
 LE35nIVjqoO/Tu1cCbTJkUimI15h0axPtVFu2fPTTTj4ShaI0rEVbJbveNjOxFy6BAaJF8a3b
 x6eIUbYSDjx8teKjjxit3HO/f2R4f+RfBICydX/g48NQFH9Wmfpkhcb7p3RFD45OnMTsLGwLO
 Kdm5c2sLYxkeAayg+eu8Rip9k1EQOjoPK7+xXXMzA7xRRKcYJyzndC0KqstrorgS0tNzYWnTN
 B3F0i8+TQC8YGY6xSw+MyyFRWeFMnBUvjec9VBpAdvOB+aQ+ZnM2KdU22AbfBIkgTE+cgPS5X
 00WFOCy8LIUEo0oJNiZeajLOFCMfPu7aZua1olWrHxvhDbUqEiGve0pj9fFjxvpXlJHlAh9kJ
 Mf2qnXvsmSDH9/xYB91zG+Qw+doKrGw4F+S6PDzgTmOTQ1LzY+w3RufQDddqF0wvsJkK1fPfa
 AYmPG8SBhFUjiw/fOuK/CSlU2ZG3zlu1b0Nz72NsJkwc5YmXKMA/Cuu2uOLsd+PxpbxpU2ylG
 4j9D4b9zF4x5os2FbfVG4HF1BBZbSEdgf0CnjLsWVIOenXAaTG44jeIVen0lDMNm233yX+dnL
 1AG5wMMi62gJYd8Qh4UQVhbvlobZfdpPxxynAFPfGd0JUrqVAWRip+RJy8sGRRp5mDsLc80fn
 8c/hRO8weEq4l922q5B0wOSzdlOhTfIbgjIMvMPVNooEPTvmhiYWMH4dJdveOhTnAQiK88YNF
 C0SaRbxmKE1m7Xcezr8HJ4GJAlCtal32+qdY8+JaScAlZ3T9gxBopQm+5P48yzg1U6KlUqH2m
 keHjKNVoaeJ9wWruS/+NPkIVwX4DX248mtbTMNvM6cabnBeD0FnOf3Sp96riKsWT65Qzz3ps9
 UO0IyGPyDIzPTPQf0vx4gahN1V7sWFnVL8s51ZTXyEHGQaVF6E5HXoik4NpyPhj9/Hog7dPu5
 MHec5mLsu/F/stm3eCfHa1TCP4FbMYiKfT7Awh9nYkTvOOTs+z/Rh+etDbNeLFdrbFqBfFCTn
 BftG6g1/1QMskAL+gmIERVwAUzNGXcBaVgn9V9g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bb0bcAV9BeZTggjQomMYExytg5tdFJXYV
Content-Type: multipart/mixed; boundary="7U4H8tkvLskVhW9IGPCQ81f8LbExqP9eU"

--7U4H8tkvLskVhW9IGPCQ81f8LbExqP9eU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/24 =E4=B8=8A=E5=8D=8812:50, Sidong Yang wrote:
> On Wed, Sep 23, 2020 at 09:55:02AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/9/22 =E4=B8=8B=E5=8D=8811:36, Sidong Yang wrote:
>>> This new test will test btrfs's qgroup assign functionality. The
>>> test has 3 cases.
>>>
>>>  - assign, no shared extents
>>>  - assign, shared extents
>>>  - snapshot -i, shared extents
>>>
>>> Each cases create subvolumes and assign qgroup in their own way
>>> and check with the command "btrfs check".
>>>
>>> Cc: Qu Wenruo <wqu@suse.com>
>>> Cc: Eryu Guan <guan@eryu.me>
>>>
>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>> ---
>>> v2: create new test and use the cases
>>> ---
>>>  tests/btrfs/221     | 121 ++++++++++++++++++++++++++++++++++++++++++=
++
>>>  tests/btrfs/221.out |   2 +
>>>  tests/btrfs/group   |   1 +
>>>  3 files changed, 124 insertions(+)
>>>  create mode 100755 tests/btrfs/221
>>>  create mode 100644 tests/btrfs/221.out
>>>
>>> diff --git a/tests/btrfs/221 b/tests/btrfs/221
>>> new file mode 100755
>>> index 00000000..7fe5d78f
>>> --- /dev/null
>>> +++ b/tests/btrfs/221
>>> @@ -0,0 +1,121 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.
>>
>> So, "YOUR NAME HERE" is your name? :)
>=20
> Oops! I missed it.
>=20
>>
>>> +#
>>> +# FS QA Test 221
>>> +#
>>> +# Test the assign functionality of qgroups
>>> +#
>>> +seq=3D`basename $0`
>>> +seqres=3D$RESULT_DIR/$seq
>>> +echo "QA output created by $seq"
>>> +
>>> +here=3D`pwd`
>>> +tmp=3D/tmp/$$
>>> +status=3D1	# failure is the default!
>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>> +
>>> +_cleanup()
>>> +{
>>> +	cd /
>>> +	rm -f $tmp.*
>>> +}
>>> +
>>> +# get standard environment, filters and checks
>>> +. ./common/rc
>>> +. ./common/filter
>>> +. ./common/reflink
>>> +
>>> +# remove previous $seqres.full before test
>>> +rm -f $seqres.full
>>> +
>>> +# real QA test starts here
>>> +
>>> +# Modify as appropriate.
>>> +_supported_fs generic
>>
>> It's a btrfs specific test.
> Thanks!
>>
>>> +_supported_os Linux
>>> +
>>> +_require_test
>>
>> You don't need test_dev at all.
> Yeah, I just realized that I used only scratch dev noy test dev.
> Thanks!
>>
>>> +_require_scratch
>>> +_require_btrfs_qgroup_report
>>> +_require_cp_reflink
>>> +
>>> +# Test assign qgroup for submodule with shared extents by reflink
>>> +assign_shared_test()
>>> +{
>>> +	echo "=3D=3D=3D qgroup assign shared test =3D=3D=3D" >> $seqres.ful=
l
>>> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
>>
>> I'm not sure if _run_btrfs_util_prog is still recommended.
>> IIRC nowadays we recommend to call $BTRFS_UTIL_PROG directly.
>>
>> Test case btrfs/193 would be the example.
> It's good to replace it! Thanks.
>>
>>> +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
>>> +
>>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
>>> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
>>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
>>
>> "btrfs qgroup assign" can take path directly. This would save your som=
e
>> lines. E.g:
>>
>>   # btrfs qgroup create 1/100 /mnt/btrfs/
>>   # btrfs qgroup assign /mnt/btrfs/ 1/100 /mnt/btrfs/
>>   # btrfs qgroup  show -pc /mnt/btrfs/
>>   qgroupid         rfer         excl parent  child
>>   --------         ----         ---- ------  -----
>>   0/5          16.00KiB     16.00KiB 1/100   ---
>>   1/100        16.00KiB     16.00KiB ---     0/5
> Thanks for good tip!
>=20
>>
>>> +
>>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
>>> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT b)
>>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
>>
>> Shouldn't this assign happens when we have shared extents between the
>> two subvolumes?
>>
>> Now you're just testing the basic qgroup functionality of accounting,
>> not assign.
>>
>> For real assign tests, what we want is either:
>> - After assign, qgroup accounting is still correct
>>   We don't need even to rescan.
>>   And "btrfs check" will verify the numbers are correct.
>>
>> - After assign, qgroup accounting is inconsistent
>>   At least we should either have qgroup inconsistent bit set, or qgrou=
p
>>   rescan kicked in automatically.
>>   And "btrfs check" will skip the qgroup numbers.
>>
>> But in your case, we're assigning two empty subovlumes into the same
>> qgroup, then do some operations.
>> This only covers the "assign, no shared extents" case.
>=20
> You mean that there should be some data with reflink before assigning?
> If so, the code below should be executed before assigning qgroups.
> Should test process be like this?
> make submodules -> make data -> copy with reflink -> assign qgroup

Yep.

Furthermore, we should have qgroup enabled/rescanned before make subvolum=
es.
>=20
>>
>>> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
>>> +
>>> +	_ddt of=3D"$SCRATCH_MNT"/a/file1 bs=3D1M count=3D1 >> $seqres.full =
2>&1
>>> +	cp --reflink=3Dalways "$SCRATCH_MNT"/a/file1 "$SCRATCH_MNT"/b/file1=
 >> $seqres.full 2>&1
>>> +
>>> +	_scratch_unmount
>>
>> Since you're unmounting here, why not keep the _scratch_mkfs and
>> _scratch_unmount pair in the same function?
>>
>>> +	_run_btrfs_util_prog check $SCRATCH_DEV
>>> +}
>>> +
>>> +# Test assign qgroup for submodule without shared extents
>>> +assign_no_shared_test()
>>> +{
>>> +	echo "=3D=3D=3D qgroup assign no shared test =3D=3D=3D" >> $seqres.=
full
>>> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
>>> +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
>>> +
>>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
>>> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
>>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
>>> +
>>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
>>> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT b)
>>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
>>> +
>>> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
>>
>> No, we don't want rescan.
>>
>> And the timing is still wrong.
> Yeah, I'll delete it.
>>
>>> +	_scratch_unmount
>>> +
>>> +	_run_btrfs_util_prog check $SCRATCH_DEV
>>> +}
>>> +
>>> +# Test snapshot with assigning qgroup for submodule
>>> +snapshot_test()
>>> +{
>>> +	echo "=3D=3D=3D qgroup snapshot test =3D=3D=3D" >> $seqres.full
>>> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
>>> +
>>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
>>> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
>>> +
>>> +	_run_btrfs_util_prog subvolume snapshot -i 0/$subvolid $SCRATCH_MNT=
/a $SCRATCH_MNT/b
>>> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT b)
>>
>> Even we're snapshotting on the source subvolume, since it's empty, we
>> will only copy the root item, resulting two empty subvolumes without
>> sharing anything.
>>
>> You need to at least fill the source subvolumes with some data.
>> It's better to bump the tree level with some inline extents.
>=20
> I should write some data before snapshot. is it right?

Right. That's the bare minimal.

Thanks,
qu

> Thanks for all your comments.
>=20
> Thanks,
> Sidong
>=20
>>
>> Thanks,
>> Qu
>>
>>> +
>>> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
>>> +	_scratch_unmount
>>> +
>>> +	_run_btrfs_util_prog check $SCRATCH_DEV
>>> +}
>>> +
>>> +
>>> +_scratch_mkfs > /dev/null 2>&1
>>> +_scratch_mount
>>> +assign_no_shared_test
>>> +
>>> +_scratch_mkfs > /dev/null 2>&1
>>> +_scratch_mount
>>> +assign_shared_test
>>> +
>>> +_scratch_mkfs > /dev/null 2>&1
>>> +_scratch_mount
>>> +snapshot_test
>>> +
>>> +# success, all done
>>> +echo "Silence is golden"
>>> +status=3D0
>>> +exit
>>> diff --git a/tests/btrfs/221.out b/tests/btrfs/221.out
>>> new file mode 100644
>>> index 00000000..aa4351cd
>>> --- /dev/null
>>> +++ b/tests/btrfs/221.out
>>> @@ -0,0 +1,2 @@
>>> +QA output created by 221
>>> +Silence is golden
>>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>>> index 1b5fa695..cdda38f3 100644
>>> --- a/tests/btrfs/group
>>> +++ b/tests/btrfs/group
>>> @@ -222,3 +222,4 @@
>>>  218 auto quick volume
>>>  219 auto quick volume
>>>  220 auto quick
>>> +221 auto quick qgroup
>>>
>>
>=20
>=20
>=20


--7U4H8tkvLskVhW9IGPCQ81f8LbExqP9eU--

--bb0bcAV9BeZTggjQomMYExytg5tdFJXYV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9r7NQACgkQwj2R86El
/qhy9Qf7BmHnjrtsblqW4eIOHpMpInZ92YPHcxxfBpMKInRTE+OpeErZHysOJwgk
E/sAxLpPkFmHpiIuaMJhNPNq1HKvabzGYNQFHZG/52DLCARoKDZ6PCLJF3NMS2/+
Ps15komRV4duyvxR6dzx2Mx8X0yxT5JPbOPFRfFzggCt0V3x3Aku2V7tlvHfLmo/
VGGLPE+PbmA98RYcKEKjtMaLUlnIBtoogTz72YhIe7oWaSOaRrx//fNSbEtxwhok
tdkFqZE44MlHqjvgB2aWhkESac3zx0KB33eqElerip2RY5/BQ+BpH2WmvB6Rj/XH
ch/qHTWex7UjitGPArwgYJcF5Q/Oag==
=cCOp
-----END PGP SIGNATURE-----

--bb0bcAV9BeZTggjQomMYExytg5tdFJXYV--
