Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA32184849
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfHGIzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 04:55:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:38037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfHGIzY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 04:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565168109;
        bh=YoxHAdJKm3F2nPOZ6oBrNQ79FfIplBh8AbaIu2uyVGk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UhRWuHh60EfSKsbz3hh9MgnPiddKUYBa/5KJcsIW07xEuLjy6dG2qsoG1Mg3EyXD2
         hE7iLGOkKvsuOlTN2LfueP5pq4af5BUHFHDuzr7g1D9u1thg8ZMsmSkYVSK1X2UF5o
         7gpOcj8qSEBtdWAzDLw5p7f3PYV2U1oZNcQFCvEQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Lug4m-1iLeEG2pLE-00zkyR; Wed, 07
 Aug 2019 10:55:09 +0200
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
To:     fdmanana@gmail.com, Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
References: <20190807082054.1922-1-anand.jain@oracle.com>
 <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
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
Message-ID: <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
Date:   Wed, 7 Aug 2019 16:55:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0vmzZ54ARJG2e9VWikLrKZzDX15G4swJ8"
X-Provags-ID: V03:K1:IC/A6IdF2lh1xqN2ukcR76ayDMjRXpr2H8E5wsdMq78vy6CQeJS
 obxvd9uVRsH9PkG9gqKcf+lfXTIItws7QMIJbz7JnpTvyf3SRoLWj2ouBkneJdWbhrhE4i3
 i3gox9xsZ1Z17Y1Ycv3Pk0SzMLbr9I4REj5Ea7CiYKzZT178Sizsfl3CtskZojR86O16mB2
 jSa/fwZUWeKqd9YIbcUtg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X5D66Ork1/c=:itqux9+9DejkjyEAVcJWFy
 74cFQm8eYQdU7UdRVQjLWVA1j1juIGuhHgbBLhFk9QpOhVwGAWVsuNHtJu22HCJ/XQJU7KBY3
 +xx4y1B6WRnOt8pmSGI3f/TsLZ/Ow/RXnmh3CxgHFR68fCbuTKvCXUKifA3BQovISB4J+er7V
 Ek74QCxvDD+snydJ+N8lidsKPFNiTbpsyn2x3D1mojPANfQDhhQanTVHaZJJwZMDV+HTwUQZM
 M0y80eNeMmDvJbOC0Vg2HKvjz54aL8UK20wWJO+hfJ1uLrWRWX5Qu2QwP2K447DZzOajUzcjJ
 ddThP8vP5L0ZllQsQWC4Nkoxw6cbLCX/Ew530F4I40k7jmVXcAOc0mmhqISZrbqGmXl8arJfg
 42E6CCHZk4f7Pp9xuVwuJGq/4cYZ0MR5lOZS2nvTVJ5mzU4t5TDQBc9Iaroh//2f9kb+KCSoK
 ZqkeAHaZfkZ5ih808w+iWCMztTX738pPzdiVV7eD9kKrr43EROHCb1Zr+Erg55RIIhOvEYDdg
 pDpIB7+pmxwnwX8rmJEnwhYeJrwy/c4I29jnEFpPk6O/FUQ826lfO9k6whFPCa7mWk3PiFPUh
 kFvqckMuqS8GUQPY8sfXguVjjER6EqE/U3xS4YwqHDZyDJ3LyEnrjxjxAdLU1wASk8h9jdLoJ
 VZ6STKrSH50UxwtqTU7PhUMxWhxhB7shvQfQhsQtDuprC2FmqVoPUfDBUtK29eHgNpxWeU0Np
 ICquVpizyW6uTkIX9bgNZiTbeqgxqVWL79cFtHZovJ4hpxKqQdjdEwwfkmi3M3hacL3IhSbs/
 RVGMnZnwZOsAN/PX94ywyntyV5I2admkk1PSRXGJxJ35HIx9/JEJS1YfoRZVZRL2uJgezAn9S
 CB+6Rhl5SkCvk+gAYZ/o0f0IXRYKH18Op3ZHwvplvI+myPyuT6NTtJDY0726bN/RL3KHPUey8
 tmcNwUNPnROCV7iQynIjQVh3a3Hj5pKTjo3VK6qKumTe59vKq4UVxfGGDdQ1+oDNoxQnndaCE
 dbyUi/8kcMOUhRt1wxEvG9MMMQ5ha+YGohpQ1+0/N7DE5ZXLoupx876jgDrPF6JPjLsPQUhe3
 Ee3jo2h1j8xjyMUpcVRCKdwVyLpRhD+qOLF6xElbY+wpcIZg45CCMXFeQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0vmzZ54ARJG2e9VWikLrKZzDX15G4swJ8
Content-Type: multipart/mixed; boundary="atmiOGUQ04AUm5nXdzox6e5kh33gk5s1E";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Message-ID: <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
References: <20190807082054.1922-1-anand.jain@oracle.com>
 <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>

--atmiOGUQ04AUm5nXdzox6e5kh33gk5s1E
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/7 =E4=B8=8B=E5=8D=884:44, Filipe Manana wrote:
> On Wed, Aug 7, 2019 at 9:35 AM Anand Jain <anand.jain@oracle.com> wrote=
:
>>
>> Commit 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the whole
>> filesystem) makes sure we always trim starting from the first block gr=
oup.
>> However it also removed the range.start validity check which is set in=
 the
>> context of the user, where its range is from 0 to maximum of filesyste=
m
>> totalbytes and so we have to check its validity in the kernel.
>>
>> Also as in the fstrim(8) [1] the kernel layers may modify the trim ran=
ge.
>>
>> [1]
>> Further, the kernel block layer reserves the right to adjust the disca=
rd
>> ranges to fit raid stripe geometry, non-trim capable devices in a LVM
>> setup, etc. These reductions would not be reflected in fstrim_range.le=
n
>> (the --length option).
>>
>> This patch undos the deleted range::start validity check.
>>
>> Fixes: 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the whole fi=
lesystem)
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   With this patch fstests generic/260 is successful now.
>>
>>  fs/btrfs/ioctl.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index b431f7877e88..9345fcdf80c7 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -521,6 +521,8 @@ static noinline int btrfs_ioctl_fitrim(struct file=
 *file, void __user *arg)
>>                 return -EOPNOTSUPP;
>>         if (copy_from_user(&range, arg, sizeof(range)))
>>                 return -EFAULT;
>> +       if (range.start > btrfs_super_total_bytes(fs_info->super_copy)=
)
>> +               return -EINVAL;
>=20
> This makes it impossible to trim block groups that start at an offset
> greater then the super_total_bytes values.

Exactly.

> In fact, in extreme cases
> it's possible all block groups start at offsets larger then
> super_total_bytes.
> Have you considered that, or am I missing something?

And, I have already mentioned exactly the same reason in that commit
message.

To address it once again, the bytenr is btrfs logical address space, has
nothing to do with any device.
Thus it can be [0, U64MAX].

Thanks,
Qu

>=20
> The change log is also vague to me, doesn't explain why you are
> re-adding that check.
>=20
> Thanks.
>=20
>>
>>         /*
>>          * NOTE: Don't truncate the range using super->total_bytes.  B=
ytenr of
>> --
>> 2.21.0 (Apple Git-120)
>>
>=20
>=20


--atmiOGUQ04AUm5nXdzox6e5kh33gk5s1E--

--0vmzZ54ARJG2e9VWikLrKZzDX15G4swJ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1KkeYACgkQwj2R86El
/qjE7Qf+LtATYnbmar+3fHUgcwFHVVuC8qIBFcEz7B4q8LcKHIPDECnwYUkZlcma
qp8hfREnybqiGklYwh6C3VhruZnrfa5A5uxJrPNfuxT5nfMfej9rwXb81fntyqKu
NrwXsoceVjkcmwC7RyzYKe9Q2ZsgL9szA3EKNu1DOLUU/vE/Sk594HSxZNq9LRHH
xZIxf6Ju2Ol/S0ZWd+wWUXeLap9eK2YsmqzqsOlx6j6HpgR4LiXmnZN+WeDT8gs9
XSZhuceIAEvBMfS1PQhZe/wV/tM0eO5Wgl6t8Arlo3LWcHmnySXMlj2zvdRv3dSv
L32FeAUatJIWK0ceg27yjzexS4uSyg==
=KXrM
-----END PGP SIGNATURE-----

--0vmzZ54ARJG2e9VWikLrKZzDX15G4swJ8--
