Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDF52736CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 01:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgIUXt3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 19:49:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:55657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbgIUXt3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 19:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600732163;
        bh=b5MIxytuutY6FEopVEBlxAjD0Z5KIymJ1J/FJw2bCRo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MpI4jlY4jreeYNps7aVPSy3rfXuofVQrpq0M5oWWNdAHNaJBXrf3ji5C4o/1uVvrv
         g05ptztj9VuX+pvdxeGXXey1WH9xZ5FfzEqlo/AQJ5wrvG8zfwFGrAJPkBlNBcyALF
         9mjYdQ1LbYPzfGotyjetJOJFMOiSRqIIrTJsOWUI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeU0k-1kuwJ43Y4S-00aYgW; Tue, 22
 Sep 2020 01:49:23 +0200
Subject: Re: [PATCH] btrfs/022: Add qgroup assign test
To:     Sidong Yang <realwakka@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20200920085753.277590-1-realwakka@gmail.com>
 <585901fa-663a-b9e6-3f2f-9d060cd345c7@suse.com>
 <20200921151641.GB28122@realwakka>
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
Message-ID: <4538473b-eff3-8e2f-2ac4-b66d90beebb9@gmx.com>
Date:   Tue, 22 Sep 2020 07:49:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921151641.GB28122@realwakka>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9sxVCYXqFExXiGZiYrQcgAZlzltE78ayJ"
X-Provags-ID: V03:K1:ddrrWZg4UP3p8h8yUDzZrNzLTnMliIOlaVhxkyUXtvkwnJ2r5g4
 Aa4rpbo+ydJQ1usm2ry2LSXIu6eq7E8RdV8IauMnX4le4Ea5wDGAQJCy5X9tGD61iDnNo2V
 gxcSNUOr6D/PI55tYsPpy1n7p0mn3z+TqUkoEJ0JanX5p4jcSmIIVjC6vkL21o5NoDK7Sw7
 /SG8XCUFkYfu7lgHnkXsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gfeybGwq3Yo=:FC+VacrNWoBqRCRQJmcYke
 +DaSlZTg0ouT4XNthnnwZdT/kxNI3ZH150IhtBodmaiK+8UvaX6lteSVZ4XNQbjCRB30BKyXa
 rEMQi/mHWLRv1jk7sruCGGIF+CZrL9XQ1bYjlElb2nn5uKNQFtmnDqss+pHmqmpXKDsGUJZSL
 2/Vu7jySj9ycn3tkv3rvkqdVS2EtCOOBQ2TVvVmq1scT4zBJnu7KImfh53fQF5ohOyBb/R2+i
 gHG7tj0mR3MY2oRkAV5oEjZb+Qf+Tzb8E837C8qQ+mwQnOR34wJ/5SxVLHUue2Rj8QWf9Sq4z
 mPJso0wc7iV6ByaIIPD9uxbIoxfbEd/9Mam3u1VmhLIKDx+L26NfJKe7p8Lify7CP5BMR41L6
 MEzBX/oyr9/NCoy+VN4ogdgpYEkQomx5nVH8tmCWBnALEv1EhagL31qsY817mNKlz1ujFnBT3
 rlAULDfKNsDPKfLphHJ8XrIyiZIVV31tqZX93aNCcL/ZCUv2b6bLpJXry7fVE4/c7nuZzGNMb
 qfg5lHEvKvtI+OvjZ7l460eBTSKXvCdiXpg+r76jd3hvWLQv5SqFMMAVPp9aK8JHiBRqxI4Uy
 VQnM3Ox7tj+jeJ6cbSEoEFkuFwANsrvNwByATWTBjfaK8MRuA4UrL1Um7cOcfSF1u7u30NTWb
 PT2VmykpPl3m57i7HQ9aWIjIDBLYOWUkK25f0h/XJE2+wtyGJlqXfkqW3d4fM7nQljDA+o/TL
 ATBTzx+CUlFEYwScSJ8tBt6/1ntQK0aP2P25Emjik0GSvA87L2Z3aeyoYzGvh/3AxUpdQtNm3
 BAyzJM3mrAI9jJN+5v95zzK/PTayMrWo9eiHdUSVZu6qAOFUjDPwt3u/JmT1zX3jGmaesyqCr
 MfbTkMaifdCmRVKtUz7b8iA++e6HmS9S2SaecNJnVVmKrLRlpUHCgFF/PdIi7eBgl72yxrvFo
 KG8Qo4o3GlHfQNiuKtEkVS0w4if4lI9LFhc1nOATyysPfaAsWHxdYoL/tEJXpr10O1KVkwIiq
 pGy5pH3AILIqgNwfpeuqbSNDt8aUcYBfiOxqnmhagT6zncZk2GtY+rvOinFdNaT+Gh/htTnk2
 oYB/TS/Ft95WiVpaFhMp18bw2MoCmK7WWMt3D3HBewdd/OI7Y2VLqNdKEtD1K2xL8cuu/FviO
 h2VRxJr0wI3LEdxUKX4pqffNZ6LJ2JdnA+OPdGhWW201BNfnI4/kJjAnV0Sm3/iuNWGsN4VMT
 8MNGxK28D5Az6QKgfm8FQiKFNU1KvFq3ZE9SfTw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9sxVCYXqFExXiGZiYrQcgAZlzltE78ayJ
Content-Type: multipart/mixed; boundary="qy3YxZTpM0DwGnE6wTUUDWSN5SDMOC6Rb"

--qy3YxZTpM0DwGnE6wTUUDWSN5SDMOC6Rb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/21 =E4=B8=8B=E5=8D=8811:16, Sidong Yang wrote:
> On Mon, Sep 21, 2020 at 09:21:33AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/9/20 =E4=B8=8B=E5=8D=884:57, Sidong Yang wrote:
>>> The btrfs/022 test is basic test about qgroup. but it doesn't have
>>> test with qgroup assign function. This patch adds parent assign
>>> test. parent assign test make two subvolumes and a qgroup for assign.=

>>> Assign two subvolumes with a qgroup and check that quota of group
>>> has same value with sum of two subvolumes.
>=20
> Hi Qu!
> Thanks for review!
>=20
>>
>> A little surprised that I haven't submitted such test case, especially=

>> we had a fix in kernel.
>>
>> cbab8ade585a ("btrfs: qgroup: mark qgroup inconsistent if we're
>> inherting snapshot to a new qgroup")
>=20
> Yeah, there was no test code for qgroup.
>=20
>>
>> Despite the comment from Eryu, some btrfs specific comment inlined bel=
ow.
>>
>>>
>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>> ---
>>>  tests/btrfs/022 | 40 ++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>>
>>> diff --git a/tests/btrfs/022 b/tests/btrfs/022
>>> index aaa27aaa..cafaa8b2 100755
>>> --- a/tests/btrfs/022
>>> +++ b/tests/btrfs/022
>>> @@ -110,6 +110,40 @@ _limit_test_noexceed()
>>>  	[ $? -eq 0 ] || _fail "should have been allowed to write"
>>>  }
>>> =20
>>> +#basic assign testing
>>> +_parent_assign_test()
>>> +{
>>> +	echo "=3D=3D=3D parent assign test =3D=3D=3D" >> $seqres.full
>>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
>>> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
>>> +	subvolid_a=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
>>> +
>>> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
>>> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
>>> +	subvolid_b=3D$(_btrfs_get_subvolid $SCRATCH_MNT b)
>>> +
>>> +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
>>> +
>>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid_a 1/100 $SCRATCH_MNT=

>>> +	_run_btrfs_util_prog qgroup assign 0/$subvolid_b 1/100 $SCRATCH_MNT=

>>
>> The coverage is not good enough.
>>
>> Qgroup assign (or inherit) happens not only during "btrfs qgroup assig=
n"
>> but also "btrfs subvolume snapshot -i".
>>
>> And we also need to consider cases like shared extents between two
>> subvolumes (either caused by snapshot or reflink).
>>
>> That means we have two factors, assign or snapshot -i, subvolumes with=

>> shared extents or not.
>> That means we need at least 3 combinations:
>>
>> - assign, no shared extents
>> - assign, shared extents
>> - snapshot -i, shared extents
>>
>> (snapshot -i, no shared extents is invalid, as snapshot will always
>> cause shared extents)
>=20
> Thanks for good example!
> but there is a question. How can I make shared extents in test code?

Reflink is the most simple solution.

> It's okay that write some file and make a snapshot from it?

If you only want some shared extents, reflink is easier than snapshot.

Thanks,
Qu

>=20
>>
>>> +
>>> +	_ddt of=3D$SCRATCH_MNT/a/file bs=3D4M count=3D1 >> $seqres.full 2>&=
1
>>> +	_ddt of=3D$SCRATCH_MNT/b/file bs=3D4M count=3D1 >> $seqres.full 2>&=
1
>>> +	sync
>>> +
>>> +	a_shared=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | gre=
p "0/$subvolid_a")
>>> +	a_shared=3D$(echo $a_shared | awk '{ print $2 }' | tr -dc '0-9')
>>> +
>>> +	b_shared=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | gre=
p "0/$subvolid_b")
>>> +	b_shared=3D$(echo $b_shared | awk '{ print $2 }' | tr -dc '0-9')
>>> +	sum=3D$(expr $b_shared  + $a_shared)
>>> +
>>> +	q_shared=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | gre=
p "1/100")
>>> +	q_shared=3D$(echo $q_shared | awk '{ print $2 }' | tr -dc '0-9')
>>> +
>>> +	[ $sum -eq $q_shared ] || _fail "shared values don't match"
>>
>> Nope, we don't need to do such complex checking all by ourselves.
>>
>> Just let "btrfs check" to handle it, as it will also check the qgroup
>> numbers.
>=20
> It's very easy way to check! Thanks.
>=20
> Taken together, I'll work for new test case that tests qgroup cases.
>=20
> Sincerely,
> Sidong
>=20
>>
>> Thanks,
>> Qu
>>
>>> +}
>>> +
>>>  units=3D`_btrfs_qgroup_units`
>>> =20
>>>  _scratch_mkfs > /dev/null 2>&1
>>> @@ -133,6 +167,12 @@ _check_scratch_fs
>>>  _scratch_mkfs > /dev/null 2>&1
>>>  _scratch_mount
>>>  _limit_test_noexceed
>>> +_scratch_unmount
>>> +_check_scratch_fs
>>> +
>>> +_scratch_mkfs > /dev/null 2>&1
>>> +_scratch_mount
>>> +_parent_assign_test
>>> =20
>>>  # success, all done
>>>  echo "Silence is golden"
>>>
>>


--qy3YxZTpM0DwGnE6wTUUDWSN5SDMOC6Rb--

--9sxVCYXqFExXiGZiYrQcgAZlzltE78ayJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9pO/8ACgkQwj2R86El
/qg8Ugf+PhRow7QrLgb0ZTZJMY9W1+hCZ5Q9vNdfN6loP7aUXdA0R4CowIhsk+8Q
PhbMA5hKnf9ixJPkzJw9HC8kRIsQG0D5+jFV8RiCcS0A+DncYGofKSFs50samMpL
MSeBaljsY/GofcgV+LK9MFNN0k/wXGqWNzQndwJqo0B7Tj7iOjPrsMoDIqOyZEsF
/Vj3d10UrqyKjnnG2M2Y7cElicUOfsa73p4hv/fCSVMTRAOGkiR3+CwF/D+adBfR
fFyF/4F//CXKQWHzOAIM8KCJ8+xZqFGywKfnNoOgte1M1B4OSCheC5BvbugoM/Zx
dFMATsG5XLfyLFYbNGr3uNt6iqeuxg==
=3Xhs
-----END PGP SIGNATURE-----

--9sxVCYXqFExXiGZiYrQcgAZlzltE78ayJ--
