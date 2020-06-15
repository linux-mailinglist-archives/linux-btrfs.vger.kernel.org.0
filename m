Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17651F95F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgFOMDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 08:03:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:49209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgFOMDa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 08:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592222605;
        bh=amS7nEItLHUteZ9pzMz1ATTx2KIXM/u9qde4H1jR8MY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UELvFH/zpBg9b7bPtGz17UwB4+HeW/pdc0qRLPyK1BSqx9sqD2EpujrlkF37SGnDR
         4Pm2ph6KE4LdpTd3+06gD2qS4B9jT7uyKWcJYivtFCmSQYAgLQ1ofGByQnTJQG33Kd
         8HHmKsVcRZoZmSn5aEV7yJ1hqtiCz0Y3QQVVygb0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4hzZ-1ijJj00U5v-011kVf; Mon, 15
 Jun 2020 14:03:25 +0200
Subject: Re: [PATCH] generic/471: adapt test when running on btrfs to avoid
 failure on RWF_NOWAIT write
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200612140604.2790275-1-fdmanana@kernel.org>
 <89ce0d58-5c7b-2cb9-ba8b-d4320340c234@gmx.com>
 <CAL3q7H42yO5Z_DGhmgrSPYoWR3i13WOPawJUm-cqN1sJwDekkw@mail.gmail.com>
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
Message-ID: <ea0c9268-cabb-a09d-ab1b-0b00403a7444@gmx.com>
Date:   Mon, 15 Jun 2020 20:03:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H42yO5Z_DGhmgrSPYoWR3i13WOPawJUm-cqN1sJwDekkw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="leDR9sdoaRKQhLbAyNH85Mn2MOG1FWbfX"
X-Provags-ID: V03:K1:AZBWl5Ls+QDCavG+Zd7CWBsEugCzXDv4Q5TgVpuBy2IGU0UIATH
 NhRzpYOoM49Pzl3sF4OjafzqfxjfxQyOi3X4hLO623nB2nkmePwvBG/uU81APLt9zTissYG
 eeqbwSU6ybVlWg4/0JXVXxkMZ75UGUWFBKJz62Gb//ZMudJvgFbF55o0hRsSlFz2SuCReBq
 bKeN8I6WCUpTjrzEXI2gA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CA/zGAgW/Xk=:AkVxVqqj8SaffrHgpz48zR
 L1mJbmVJNt1SfKiIe4EhAbLY2400cu4BjPZJTxGtDwPp+FnLyHVOtKprQEa/VY4S8tZC/PufQ
 F6yo3I+UMAtPo777Z6emH0VsG3HMdMtRyjzgm7G/unXZNkgIUBh4E4c3D8/k5dHB3jFVg1XMY
 kf3s8R6/fz3j7G+awVvw0+MwcGbhRvfSfNgvhfogIR2JEnebdhGXqmFAPdWXn/N6rxbFJ+H9D
 ARgiEMS8eCG4LNh6i/QXUbCPZG3JkQJsWRDAjp2o54W8lg5pU+SMV0NdRCprudRM6cMEXy8W6
 fvkWd51RdHE0IpWTWEyb9gNZB/i8oolHi5wmO5zFWGCKUdIQb4ndVY3iJVtUV+xaG13zr37U6
 F870xKrpkoiq1ooETgpqaBAAvpI/nVKEQp1gRohXcO77/M1hSbSCoBha3gQfENpT9yt1AbIH8
 fVrmW0rxYAn5bzIrIL0GQsoOFUHNSJWd9HMFcDzF4AqUL3y/GAseGz8qPJc2Pstz9fqvgMQDx
 YYyo6tSynQTdzgHcw+VUbwzskVehHd1DWSClAvvy+c4RdLxuOKT5vtgsNDd9IkF/DVaX8mbKZ
 75qETHI+9jc26vaszPDFPYSrtjCZsQYB/mXIsdNtfa9wYSwnE7WOrZj309l7yIuL2/zmEyPHL
 w1crSQoWOfXap4KpAS4GdBaj3sT1u9ZkkvQthpYwcaethi3FIKDfLdfseYZQ83unkeVfhDO3y
 UB00lOquVngWA1dOea4WZLWXiA+ttfv16NP0r3eyBODm4Q0dE1l/xzVTWL/mHXye6BT71yWaj
 LzmkFwaum/9RqIExN8JPckSnSkYLagZW7KhhKWWjpccnU1Etuge2cp/m7zPqyts+mxdkKCZgA
 cSm/pcYrEJe8Nnk2HT+c9NMhA1BM/p2sPWYPK6aU4qWaCyGmCIWRtJWf3wnJlhQWTVgZdQ6kC
 LG+rTUx04HgqBAKLCkwe4nBiEUhiXb//IGUCe9qRauI2rsYEIfqq4ZzZ91m+rBKvCl87Ld5kD
 DPH0W8FoHEpOU1ZMJdD2W+od8UJKjKGBG3RgfM4jIis5K/KP9bAoM2OeYHPq2z5y63+EUjIMF
 c+dt+huzHK2MBBlTYDqauRm8FaU1LXWWUuJQftpeQZEeR3APxY6hP6zVvO5aEHNNv2EwIZjND
 EO+weIpAOL1+EuzsXZEsgaTjV1LRaOkzQ+aYQ3FATaA1kHxZEVZ7+HuB5Ioh2TtZhfwvDc7cZ
 KIKSaQYkCYX2VqJTx
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--leDR9sdoaRKQhLbAyNH85Mn2MOG1FWbfX
Content-Type: multipart/mixed; boundary="73s9CAh13OvoOVHW8oUhRGDu2E7i47Nce"

--73s9CAh13OvoOVHW8oUhRGDu2E7i47Nce
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/15 =E4=B8=8B=E5=8D=887:53, Filipe Manana wrote:
> On Sun, Jun 14, 2020 at 6:14 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2020/6/12 =E4=B8=8B=E5=8D=8810:06, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> This test currently always fails on btrfs:
>>>
>>> generic/471 2s ... - output mismatch (see ...results//generic/471.out=
=2Ebad)
>>>     --- tests/generic/471.out   2020-06-10 19:29:03.850519863 +0100
>>>     +++ /home/fdmanana/git/hub/xfstests/results//generic/471.out.bad =
  ...
>>>     @@ -2,12 +2,10 @@
>>>      pwrite: Resource temporarily unavailable
>>>      wrote 8388608/8388608 bytes at offset 0
>>>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>     -RWF_NOWAIT time is within limits.
>>>     +pwrite: Resource temporarily unavailable
>>>     +(standard_in) 1: syntax error
>>>     +RWF_NOWAIT took  seconds
>>>
>>> This is because btrfs is a COW filesystem and an attempt to write int=
o a
>>> previously written file range allocating a new extent (or multiple).
>>> The only exceptions are when attempting to write to a file range with=
 a
>>> preallocated/unwritten extent or when writing to a NOCOW file that ha=
s
>>> extents allocated in the target range already.
>>>
>>> The test currently expects that writing into a previously written fil=
e
>>> range succeeds, but that is not true on btrfs since we are not dealin=
g
>>> with a NOCOW file. So to make the test pass on btrfs, set the NOCOW b=
it
>>> on the file when the filesystem is btrfs.
>>
>> Completely agree with the point for btrfs.
>>
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>  tests/generic/471 | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/tests/generic/471 b/tests/generic/471
>>> index 7513f023..e9856b52 100755
>>> --- a/tests/generic/471
>>> +++ b/tests/generic/471
>>> @@ -37,6 +37,17 @@ fi
>>>
>>>  mkdir $testdir
>>>
>>> +# Btrfs is a COW filesystem, so a RWF_NOWAIT write will always fail =
with -EAGAIN
>>> +# when writing to a file range except if it's a NOCOW file and an ex=
tent for the
>>> +# range already exists or if it's a COW file and preallocated/unwrit=
ten extent
>>> +# exists in the target range. So to make sure that the last write su=
cceeds on
>>> +# all filesystems, use a NOCOW file on btrfs.
>>> +if [ $FSTYP =3D=3D "btrfs" ]; then
>>
>> Although I'm not sure if really only specific to btrfs.
>> XFS has its always_cow sysfs interface to make data write to always do=

>> COW, just like what btrfs do by default.
>>
>> Thus I believe this may be needed for all fses, and just ignore the
>> error if the fs doesn't support COW.
>=20
> I don't understand your point.
> If that flag is enabled on xfs (iirc it's a debug flag), the test
> would fail on xfs even if we attempt chattr +C (afaics xfs doesn't
> support +C).

Oh, my fault. Didn't know that xfs won't support chattr +C.

Then forget the comment.

Thanks,
Qu
> So I don't see the benefit of always doing it.
>=20
> Thanks.
>=20
>=20
>>
>> Thanks,
>> Qu
>>
>>> +     _require_chattr C
>>> +     touch $testdir/f1
>>> +     $CHATTR_PROG +C $testdir/f1
>>> +fi
>>> +
>>>  # Create a file with pwrite nowait (will fail with EAGAIN)
>>>  $XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
>>>
>>>
>>


--73s9CAh13OvoOVHW8oUhRGDu2E7i47Nce--

--leDR9sdoaRKQhLbAyNH85Mn2MOG1FWbfX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7nY4gACgkQwj2R86El
/qgBugf/ckUZfGxuzDhIGZ/+dUanSDKqUW61qPG/KafNSR9Lkc0hf38KzwMhF1qJ
iU506CrN9gr+LX01DqQQ++hQbGX76oFEqI+vgGs7TwY/tKlYf3BXM3Vo228xKGZN
th1xd3jdYx4idn7xdhQu0zG7L59WEXH2xHUkPu2St2EP3OGyLUn5ZfZC6CUX6fSr
0NEMeyxdsx+OKw/DQzaGqCTCO1zR1HfIYnatfNxduWhw9GPn1NLHAx6GOgwlm013
WB4h/TfyZ1YMbSyryo8kE2fD+OlU/stl3zlQKZ15dWtY1tPj0bZrTRNC5gnSmCgz
d+GUnWAGGKLmPkd8cV2uwdQSwie75Q==
=U0Zn
-----END PGP SIGNATURE-----

--leDR9sdoaRKQhLbAyNH85Mn2MOG1FWbfX--
