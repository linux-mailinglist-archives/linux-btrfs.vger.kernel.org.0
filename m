Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFAC11A527
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 08:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfLKHfo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 02:35:44 -0500
Received: from mout.gmx.net ([212.227.17.20]:57905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfLKHfn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 02:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576049732;
        bh=qQkXi9zYiISCx/Mu0jLKrkzG6c32juHBWDS+JDrcRK0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZwsTAL4gl7LcZCZT2NpxBbx8KXod3lzWO7dSTZaj33SVvhKub436foX1qVpBoTser
         rsxc2zHnH1iVTByX9rcU8SEhkTYC9HB3IVSsqC/lRyLyRM/EHEWsRM0QYaHJKSCHSU
         aAMUQ7/nDWXBJ/VWNvKHvBLMHQYFGB0xvXvkgWEI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b6b-1ie5ao419B-007yW7; Wed, 11
 Dec 2019 08:35:32 +0100
Subject: Re: [PATCHi RFC] fstest: btrfs/158 fix miss-aligned stripe and device
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com
References: <010f5b0e-939a-b2be-70a2-d8670d1696ab@suse.com>
 <1576044519-28313-1-git-send-email-anand.jain@oracle.com>
 <b89463c5-9f0d-b262-0198-2750e0b2aabc@gmx.com>
 <6025418e-25ce-19f9-3c53-6b094609098c@oracle.com>
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
Message-ID: <1c01a538-2eb8-9e73-9145-93c9fd7c714a@gmx.com>
Date:   Wed, 11 Dec 2019 15:35:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6025418e-25ce-19f9-3c53-6b094609098c@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u6AY7VeH0E4D3bfdHfNRDrYlmQMWQMa30"
X-Provags-ID: V03:K1:7D53C+AzQYRp8M0i83/GQzKY/mwsdaSvs1drUbkGZgopN6ZicHB
 ZkQkQV1DbZlbiHnp6WoXBh3oOw+yCeRlthcM7+NQT3w7xwrXzRPTguTsdhFeFYwrSAi3qL8
 /PkP4EFHFqUC1QXohPkiACzMR79kfNX+A8MpsNUOpKNIlUE1asqfeLRAU8OZ1j8FJatNpJS
 7aroCuCsTnXEo8353g0Dg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MHILUlY8IPs=:vbKb9fFAiMfpy2OutBTYZ6
 gQr7BQpRc8tN9IzI5dKYbj1Ny1Sd2HZ8hhPqaW5q58iXHU4/Fda4Hc1uwmF95Geb264w+U7Zt
 V421e4rKBRlqBU0+5bolUuttrZI0J0gbkCUOaTmAZoTLA845Ibk6QrlY2zJo+um6L+g/hUfLx
 iE+JCgwAG9323WhheRZn/gCCpDhi6KzUFmXmRtW32SSdvGKP/k68pqRUDBgZQMTiFgAFoDV/i
 /oyUoQc9amj/VDC5SviOdPfQVlsyzzyMNLgjmaJ35sRu5UxRPYtv7DqHyyR3j11xHrOAMMdJO
 3vtQOSQyiA/7lXcSqwqt8sESs94J5WJsa7VZi9svcOks7+lmSiqISfHoaT0jbMNzQykq3kh4B
 QTXvRiiB5pY01j+A911yTSgnwEeiNpHrVcHr/UUX1D+m+Ax/GNQc6+LEvq1hmb+ka7Rl1F9Fp
 BBoRsnxXVp2RsoWpFvjJbSD0ymPaFjxAEdJZ+YMRhRo0U5AmC2IGCiH3GLcrBL7ju6I2J4Ds4
 GnB4bg74LcyFwIspk2xvQ6ahz+EXZwAbz4QFaSCl4bYaBp/Oh1vbdhewZjMn+vg9LsGj7uEdN
 qjaprQFKgj3jugg6jCef9bR3hSWtXyyjWJ1OpSb6jdbYmHREjx5dwadO9R/LD6NVI3qMYJ2BD
 24ak3+gNZ148O4S7bfRc58YgHarctKfZnoM5ZyUkinctlMQ3oO9HhCQvuD22OoXPQ4v1D+rxN
 gk5jU+E8y2zeVKC4NIUh9ptXPEbxSild4PCdM+D3b9JW2TlwXQYCGD1Yo1ta2RxcAw7Rx1Z41
 M8EuowETnqhIFkp6HZQzNqMgr3UeK23LfO/4senvtLQ/60IKmX1xR/AafYDiBfn/EtYfcU/VT
 tYSF5+KBkpry2LXM1qdVttv46BBxstbMsvODA1DvMqw1Td1FOzx/Av4YS6zJuvIDmUEOJnQy7
 MJX4DJU4ABKIUBAtJbFujS2irG0RFahSRmQr/7QyDlqTiWQjgIj2caWfnaL3KP11Bs3bVFL54
 IHrczh61omTz8Tcbm7hLU1cQBImPnXGVy6++q/QRMex7zwvDa5HNe9j/DSmpXDdBAoSok6QyB
 8IyGHAPX20qGmgpWGOw6q4CitpGxdl+eLif3oUz81+iJiwHypxvGhtGA8e4+8My8j+W5J70be
 37qWdRpI//1bOjQg8ySsbZ1G7IE60pZHYaaAF6AXJKIqgMAgvhxlwI6BIaEhfC5teShXABnsN
 aSHkEjWflNzDkpYCuKZGlYlc996q+YL9S8l1RonymlSc7wAj983xhXZEjAac=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u6AY7VeH0E4D3bfdHfNRDrYlmQMWQMa30
Content-Type: multipart/mixed; boundary="ZAMLx6I0kUu60UYdHlf46pPArZLHfCA6s"

--ZAMLx6I0kUu60UYdHlf46pPArZLHfCA6s
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/11 =E4=B8=8B=E5=8D=883:23, Anand Jain wrote:
>=20
>=20
> On 12/11/19 3:08 PM, Qu Wenruo wrote:
>>
>>
>> On 2019/12/11 =E4=B8=8B=E5=8D=882:08, Anand Jain wrote:
>>> We changed the order of the allocation on the devices, and
>>> so the test cases which are hard coded to find specific stripe
>>> on the specific device gets failed. So fix it with the new layout.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> Qu, Right we need to fix the dev in the test case as well.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 I saw your patches bit late. Here is what I =
had.. you may
>>> =C2=A0=C2=A0=C2=A0=C2=A0 use it. So I am marking this patch as RFC.
>>
>> I am crafting a better solution, to handle both behavior (and even
>> future behavior), by getting both devid and physical offset.
>=20
> =C2=A0Yep helper function using either,
> =C2=A0=C2=A0 devid and btrfs fi show
> =C2=A0=C2=A0 or
> =C2=A0=C2=A0 uuid=C2=A0 and blkid
>=20
> =C2=A0would dynamically find the right device.

My current helper is going to rely on the fact that all mkfs.btrfs
assigned devid sequentially.
Which means "mkfs.btrfs -f $dev1 $dev2" will always assigned devid 1 to
$dev1, and devid 2 to $dev2.

As long as we don't touch that part, we should be OK.
(And I really hope we won't touch that part).

>=20
> =C2=A0I am ok with either.
>=20
>> And I tend to remove the fail_make_request requirement from some tests=
,
>> and direct read with multiple try should be enough to trigger repair f=
or
>> test btrfs/142 and btrfs/143.
>>
>=20
>> In fact, I don't believe your current fix is good enough to handle bot=
h
>> old and new mkfs.btrfs.
>=20
> =C2=A0It was designed to handle only forward compatible.

Then both Oracle and SUSE QA people will hate such tests...

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>> So we need to investigate more for raid repair test cases to make them=

>> future proof.
>>
>> Thanks,
>> Qu
>>> Thanks.
>>>
>>> =C2=A0 tests/btrfs/158=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++-----
>>> =C2=A0 tests/btrfs/158.out |=C2=A0 4 ++--
>>> =C2=A0 2 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tests/btrfs/158 b/tests/btrfs/158
>>> index 603e8bea9b7e..7f2066384f55 100755
>>> --- a/tests/btrfs/158
>>> +++ b/tests/btrfs/158
>>> @@ -76,14 +76,14 @@ _scratch_unmount
>>> =C2=A0 =C2=A0 stripe_0=3D`get_physical_stripe0`
>>> =C2=A0 stripe_1=3D`get_physical_stripe1`
>>> -dev4=3D`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
>>> -dev3=3D`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
>>> +dev1=3D`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
>>> +dev2=3D`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
>>> =C2=A0 =C2=A0 # step 2: corrupt the 1st and 2nd stripe (stripe 0 and =
1)
>>> -echo "step 2......simulate bitrot at offset $stripe_0 of
>>> device_4($dev4) and offset $stripe_1 of device_3($dev3)" >>$seqres.fu=
ll
>>> +echo "step 2......simulate bitrot at offset $stripe_0 of
>>> device_1($dev1) and offset $stripe_1 of device_2($dev2)" >>$seqres.fu=
ll
>>> =C2=A0 -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 |
>>> _filter_xfs_io
>>> -$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 |
>>> _filter_xfs_io
>>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev1 |
>>> _filter_xfs_io
>>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev2 |
>>> _filter_xfs_io
>>> =C2=A0 =C2=A0 # step 3: scrub filesystem to repair the bitrot
>>> =C2=A0 echo "step 3......repair the bitrot" >> $seqres.full
>>> diff --git a/tests/btrfs/158.out b/tests/btrfs/158.out
>>> index 1f5ad3f76917..5cdaeb238c62 100644
>>> --- a/tests/btrfs/158.out
>>> +++ b/tests/btrfs/158.out
>>> @@ -1,9 +1,9 @@
>>> =C2=A0 QA output created by 158
>>> =C2=A0 wrote 131072/131072 bytes at offset 0
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -wrote 65536/65536 bytes at offset 9437184
>>> +wrote 65536/65536 bytes at offset 22020096
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -wrote 65536/65536 bytes at offset 9437184
>>> +wrote 65536/65536 bytes at offset 1048576
>>> =C2=A0 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> =C2=A0 0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
>>> =C2=A0 *
>>>
>>


--ZAMLx6I0kUu60UYdHlf46pPArZLHfCA6s--

--u6AY7VeH0E4D3bfdHfNRDrYlmQMWQMa30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3wnD4ACgkQwj2R86El
/qhi4QgApvHOy1tHXKDg4U/7JQCpkiFWSr/OkuVI4h/Txb3E8Pu0xLVwPwyQpBgE
nre5eb8VJhoGOMo6xjEu3SHrej2pRJ1ghrMikXMMrerhrLsJDQiMpF1H4iRMKFtq
N4GuMEAwmYiFq5ur+oQW/AkHVei3VTG+fVS+Unu4yNxOV8oT8tWjneuY4jMDo21C
uhj+XFOgdQACToDHugq4f9YT3sQn3DXiSuk0iQw85lTZ89/C2MaLlhQKV8pSHD8b
VctqmgMQzLwKWem2HPMYypPH2fhlJiyQ7M73tFoJIWX4vvNfT1YbcVMuao7KQsdk
G3FCGF+lqs3QizBjFCQLAohEJrUK0w==
=onVz
-----END PGP SIGNATURE-----

--u6AY7VeH0E4D3bfdHfNRDrYlmQMWQMa30--
