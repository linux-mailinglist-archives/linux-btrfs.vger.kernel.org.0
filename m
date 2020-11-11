Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D92AFCC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 02:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgKLBdr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 20:33:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:35845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgKKXua (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 18:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605138625;
        bh=5OSZQDP4D87FBV1kl66gNJiBAWWCNu9Ba27vJGQsof8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VtGNdBdUUG5ghar18dvDNlPW5X++slD+1q9MrzGlEOdMrkVe/SpNNmsPLr7yUz51x
         6UAaUdQlkerDDyScvptFH3rQiSBOV9dcqK8iAF68sNgLb7qxmMROsVTW+6m2aLRhZm
         AIho9FEx2wCQQyy5QMOMczNZl1YMiczGNG51R9gM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU5b-1k99BC0qup-00eciJ; Thu, 12
 Nov 2020 00:50:25 +0100
Subject: Re: [PATCH] fstests: btrfs: check qgroup doesn't crash when beyond
 limit
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
References: <20201111113152.136729-1-wqu@suse.com>
 <CAL3q7H5W6U4jYGBszQF59RLi-aehO9vBTNU_HMTi8hRfK7gjGg@mail.gmail.com>
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
Message-ID: <d5cabe8e-37cb-42b7-9bd4-ba7ddca68b20@gmx.com>
Date:   Thu, 12 Nov 2020 07:50:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5W6U4jYGBszQF59RLi-aehO9vBTNU_HMTi8hRfK7gjGg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SCivVPeb1toH683Zn6twflo29GVpvuHmT"
X-Provags-ID: V03:K1:UQ5LHKZcXCeYtyhfoBBdsVKOpY7MgFx48ahYnDix1q1givCUhSp
 q331sRh5TIItrLBMaTw2ochWjSZop76fAzsullskNcEo0/4eyq4/Y/y9woDayR38uVF1G8V
 X5uBqh5rvQieAq3OODJWTLJEdJHRhlvr6Y8hXmSc4h7es10p7AF5fLd2QjgqMS+4+hJva3H
 S1DCsdCZt7kDAnOlCLS5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixrAe8otU2s=:ma36CmYeQ1HmqGV0Z8rori
 9pmfM7EgneOQ1IL+5yyr7T0aE/9hn5RTGOyEUJx0LkzqRMNsyTVJJCP4GBi/xaZUh6lNiOm1M
 30jRJeXwFTnjM2S/Jy10mobprswOkP7mrDfbVt7l6E/0CEvTy38ucD7LFTa6qEaWj+qtIIUmO
 LrVhL2hP6EEKz6njldZf6EFwsb1l/3OTELiwq4hSE9L1CgFw9T204LKyw2GMbwVHP3rPlsrOv
 hh8x2GmaFHcwz67h0T0CsCoXOtR1sKbR+cvimQrRCZMOwOTiA+zkTAzp8nnai4eFeZBszXL72
 KgkmeO+wNXltf8o7xlmP9httLggo9xT6oyNQCzxtFkifAbkmTIU1y3Y9u1cVNUekf4R9InQ2x
 dT75v8xlJVDsGca8KQVm/gnF5Ukkg1n5fNT1n9mw52Q+C8XI52JLa4LofuI/eCw/ib4fzCo28
 23j+hMO2I3mrWDitbEOgpYFw8F/pbLIa6rLi4gI3wONjEa7VBjs/917TdBdmB5lBjTKjVQWJZ
 J7kmmKG/DC0OTPHB0keMaPZ/3i4lyVCgGtyWseAwTBt2sYZ9b/eAbeQicBysicZY6do9IukMn
 xt1ijCfQ6BDYuiVBkTKP58xgQCOOEJcWa3J2LnIdpsR9XWLwsRRvKAsahCte9v5jg9h5onP7/
 qiG/OrSogDjckYxr9/H02I8QaAFu1/yaWHPKUtCxTv4DSKj/WRbR9UOax2moNC7FsbY7ytpcn
 nAciBlzL2FRrXxkOO2ja9TcuHRRvNIYnNoxu3egiuSox9pNvU93VpLO8uusT4rSjhxMBBw7Q9
 E4HGId2GuNbyigy3xBOwah3jeS+e7ZY4ADkwFvln/ftN9qM1tPt7vJppwsHOyeJa1E955XhJf
 02elgRJlqRbAFWYIPG6w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SCivVPeb1toH683Zn6twflo29GVpvuHmT
Content-Type: multipart/mixed; boundary="pZ7CjlKSlK0bMyPMwcFiFPUE9KkDTH3M0"

--pZ7CjlKSlK0bMyPMwcFiFPUE9KkDTH3M0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/11 =E4=B8=8B=E5=8D=8810:38, Filipe Manana wrote:
> On Wed, Nov 11, 2020 at 11:32 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There is a bug that, when btrfs is beyond qgroup limit, touching a fil=
e
>> could crash btrfs.
>>
>> Such beyond limit situation needs to be intentionally created, e.g.
>> writing 1GiB file, then limit the subvolume to 512 MiB.
>> As current qgroup works pretty well at preventing us from reaching the=

>> limit.
>>
>> This makes existing qgroup test cases unable to detect it.
>>
>> The regression is introduced by commit c53e9653605d ("btrfs: qgroup: t=
ry
>> to flush qgroup space when we get -EDQUOT"), and the fix is titled
>> "btrfs: qgroup: don't commit transaction when we have already
>>  hold a transaction handler"
>>
>> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1178634
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>=20
> Looks good, just one comment below.
>=20
>> ---
>>  tests/btrfs/154     | 62 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/btrfs/154.out |  2 ++
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 65 insertions(+)
>>  create mode 100755 tests/btrfs/154
>>  create mode 100644 tests/btrfs/154.out
>>
>> diff --git a/tests/btrfs/154 b/tests/btrfs/154
>> new file mode 100755
>> index 00000000..2a65d182
>> --- /dev/null
>> +++ b/tests/btrfs/154
>> @@ -0,0 +1,62 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2020 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 154
>> +#
>> +# Test if btrfs qgroup would crash if we're modifying the fs
>> +# after exceeding the limit
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
>> +
>> +# Need at least 2GiB
>> +_require_scratch_size $((2 * 1024 * 1024))
>> +_scratch_mkfs > /dev/null 2>&1
>> +
>> +_scratch_mount
>> +
>> +_pwrite_byte 0xcd 0 1G $SCRATCH_MNT/file >> $seqres.full
>> +
>> +# Make sure the data reach disk so later qgroup scan can see it
>> +sync
>> +
>> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>> +
>> +# Set the limit to just 512MiB, which is way below the existing usage=

>> +$BTRFS_UTIL_PROG qgroup limit  512M $SCRATCH_MNT $SCRATCH_MNT
>=20
> $SCRATCH_MNT twice by mistake, though the command still works and the
> test still reproduces the issue.


Nope, that's the expected behavior.

Btrfs qgroup limit <size> <path>|<qgroupid> <path>

The first path is to determine qgroupid, while the last path is to
determine the fs.

In this particular case, since we're limit the 0/5 qgroup, it's also the
as the mount point, thus we specific it twice.

Thanks,
Qu
>=20
> Eryu can probably remove one occurrence when picking this patch.
>=20
> Thanks.
>=20
>> +
>> +# Touch above file, if kernel not patched, it will trigger an ASSERT(=
)
>> +#
>> +# Even for patched kernel, we will still get EDQUOT error, but that
>> +# is expected behavior.
>> +touch $SCRATCH_MNT/file 2>&1 | _filter_scratch
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/154.out b/tests/btrfs/154.out
>> new file mode 100644
>> index 00000000..b526c3f3
>> --- /dev/null
>> +++ b/tests/btrfs/154.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 154
>> +touch: setting times of 'SCRATCH_MNT/file': Disk quota exceeded
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index d18450c7..c491e339 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -156,6 +156,7 @@
>>  151 auto quick volume
>>  152 auto quick metadata qgroup send
>>  153 auto quick qgroup limit
>> +154 auto quick qgroup limit
>>  155 auto quick send
>>  156 auto quick trim balance
>>  157 auto quick raid
>> --
>> 2.28.0
>>
>=20
>=20


--pZ7CjlKSlK0bMyPMwcFiFPUE9KkDTH3M0--

--SCivVPeb1toH683Zn6twflo29GVpvuHmT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+seL4ACgkQwj2R86El
/qhgfwgAg8iX5YWkeNK8R2XRmNmWQu3AoIkDgB+uvfkIuzTSGR5qbHailvOZEbPc
dK/5p7EqjHUX7tTYBL2/1MhRoylcCQ1DulHsagqSKyAfjsSNK/X9ptuEjtWdM2N4
BR9XD+kYReXJ7VpDxFHR2VzLm7ab8DcmO/6umpZ1rPSik2BdOV4tVRbz7KOHXdSr
rTdtUc+eng1+Q4Ki9w15h1ugSnEybbxEYYfwiMfAIq73ZZIW0bWzlmih3FQq1c/n
kfNis3U9i/ONBLSmDZkxxxHJ00NjYbk9UP5SZslyXXd8nxxyTNnTQLnNtwSJJQ9O
mgbkN4wTeAIGp+VCSrG2Y1iruIC//Q==
=kTl9
-----END PGP SIGNATURE-----

--SCivVPeb1toH683Zn6twflo29GVpvuHmT--
