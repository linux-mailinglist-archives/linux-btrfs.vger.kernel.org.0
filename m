Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054BB84A72
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfHGLPw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 07:15:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:44457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbfHGLPw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 07:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565176536;
        bh=IJXojDAVdaTGb1gx0FvQc00f2dCSs9BezlvqbtYmSs0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jLkfWvocd6eTp1zxYwAM3OvdyrfMISBvUaNoc+eeKLzVgHsOMxs0ncLkzd9D5rauY
         EV4CK5530rZQ6EBYNzVhts/IBW/UoNgx2nUClAgDKSBiZZNTo+brpFogsmPYIVmzpr
         eqYvoSxm0MCUsUvGg/US3Pz0cNCh3XvL30v78H7w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Lg5kl-1if3ng3Y1D-00peuD; Wed, 07
 Aug 2019 13:15:36 +0200
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
References: <20190807082054.1922-1-anand.jain@oracle.com>
 <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
 <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
 <237D0D12-0975-4504-970E-81FB775ECD6A@oracle.com>
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
Message-ID: <b5140d67-1422-2265-d597-130aaa108167@gmx.com>
Date:   Wed, 7 Aug 2019 19:15:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <237D0D12-0975-4504-970E-81FB775ECD6A@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IXh7IeNkm5GbCWocOZ0tYD1jlmMN7NN9Z"
X-Provags-ID: V03:K1:N/O8wpvn0+riFa0yZMdtU4wZv2/7/FKvfLmmm10v+8P6hplUhUz
 OUIR//Z3ei5hi8VIJqoAyEr8GbHkzMlJeMLGuE65MKT+vWworEyBOTSsRaMQvJH+w1D4bAg
 K4nbeDEdkCljrxUOTToUOtHK5dXoBPoBoLGWJCo8kP1eODh0/Z0BYBQJuBkzc4xo5RGWw2j
 UcU4TDkR5Lj465huonnRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KyqmvD8r4h8=:Y04REpPm07huhLhu/tfzGU
 OrVa7sJPANwIHl7fk3CBMN2Ca/t+wPhMpdRhRIXBHXGsKhqM2VkEBzfOyBdvg8uPBbY7MT1ro
 KzBa+1+JjyfjmHEJYZjXAfaWQZjGUPT9xd1LmXIyQKW3jdGMXdWhdOp2c0EXEWPsdgluSfpsg
 Rm4HFyBvrx8xPNN+7sxdO/+XOq4DnuSnFOMKfAycL1C8x1S/sgpx3EsbA70F/1qaCkSvjEsoC
 a4w40adtw1QZSUZ8gP+mu2453gdvJtGVbJd4vdyHlqAVsOL/ta3KJGa3bu9LXdaEzg/7sDGcK
 derLz9atYUf7vCeHHeuzWrcUGW3AYpY5GL5gUGMeiNRINT71VSukv7OT4GUCq62T7Sr97zEuF
 HChyk25WMY0SE2foT4etNA5LqRb2AYO4DdoIsF/8buoeTMVkoRUWzOxoAIZ5dvLm1yZhLiYwz
 68RNredzqtMD5XzGZu/P6DU72cPMraOXQkIqphamD2QK3d7nLw867ZvKtKhyrHI2qKPFZGN76
 X3qVapoAkC/kvoNjUNV6U4UzeoJ0Y7ZHUO7Lplu3AzehqAUhEYe/tMJA1ZnQasVxjXjl1iKSR
 lvJnGO2A5JSkqbVgScse1YccHHXnBJsKirJSKNefepYisxPdEtX/KoUehmIqDDyfLnREbEm8r
 NK2FA+E2DWnlIrYdZrJgcO1yqV2AWzORT2z4e3mgoXRCQG7O6SzTCyrFb1s9Hy5NwHXeVuzAM
 EnT8z+cqR3QiO2Vcxa5H+oAfyLSRUExgOZeY3+qwmpT7zSO3Wz/fbf6W3OUFIzV8eMO2b9IYv
 plXHFojQdlTKMrZhhglSydBeFZJstyjNOYpfBjNLs1tH3VvhCuKleAYBxz3+abr6WsirJN+3X
 W8EvolE9FZ4jku11yo6ARiaaz9sqspbrK869I+B4NxjNKJwK62V0T7fYAvUqcl/i4wm+cZ0Dh
 xOJSfEN+KjmddjG4r63f3xoCNgym5vSs5I+o8J+yV27pUbIBEVU3ASYIchfrehcKVj3Q0uX4+
 iuSu+HNqlWfVKX+e/1M7PUWtk/930H+Cr4XhA2r/8kitk2P/oNXUSbLvqz2bt+zkaLNekeEMG
 CZsgzCMNR2a41DqsU0mLn+tHOW2SIxFWtH3ur7T50hwmvlaHTRaG/yu/Q==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IXh7IeNkm5GbCWocOZ0tYD1jlmMN7NN9Z
Content-Type: multipart/mixed; boundary="Prte5qK6fIOxDv20I5WTmDyiTNyfeHa9Y";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
 Qu Wenruo <wqu@suse.com>
Message-ID: <b5140d67-1422-2265-d597-130aaa108167@gmx.com>
Subject: Re: [PATCH] btrfs: trim: fix range start validity check
References: <20190807082054.1922-1-anand.jain@oracle.com>
 <CAL3q7H7WRPuFNh3+534kF7SgLe0NmQAwCejfW9DJgasXfkQ1qQ@mail.gmail.com>
 <11d658dd-060e-536b-9bf7-907f6d36eaf9@gmx.com>
 <237D0D12-0975-4504-970E-81FB775ECD6A@oracle.com>
In-Reply-To: <237D0D12-0975-4504-970E-81FB775ECD6A@oracle.com>

--Prte5qK6fIOxDv20I5WTmDyiTNyfeHa9Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/8/7 =E4=B8=8B=E5=8D=885:43, Anand Jain wrote:
>=20
>=20
>> On 7 Aug 2019, at 4:55 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2019/8/7 =E4=B8=8B=E5=8D=884:44, Filipe Manana wrote:
>>> On Wed, Aug 7, 2019 at 9:35 AM Anand Jain <anand.jain@oracle.com> wro=
te:
>>>>
>>>> Commit 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the whole
>>>> filesystem) makes sure we always trim starting from the first block =
group.
>>>> However it also removed the range.start validity check which is set =
in the
>>>> context of the user, where its range is from 0 to maximum of filesys=
tem
>>>> totalbytes and so we have to check its validity in the kernel.
>>>>
>>>> Also as in the fstrim(8) [1] the kernel layers may modify the trim r=
ange.
>>>>
>>>> [1]
>>>> Further, the kernel block layer reserves the right to adjust the dis=
card
>>>> ranges to fit raid stripe geometry, non-trim capable devices in a LV=
M
>>>> setup, etc. These reductions would not be reflected in fstrim_range.=
len
>>>> (the --length option).
>>>>
>>>> This patch undos the deleted range::start validity check.
>>>>
>>>> Fixes: 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the whole =
filesystem)
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>> ---
>>>>  With this patch fstests generic/260 is successful now.
>>>>
>>>> fs/btrfs/ioctl.c | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>> index b431f7877e88..9345fcdf80c7 100644
>>>> --- a/fs/btrfs/ioctl.c
>>>> +++ b/fs/btrfs/ioctl.c
>>>> @@ -521,6 +521,8 @@ static noinline int btrfs_ioctl_fitrim(struct fi=
le *file, void __user *arg)
>>>>                return -EOPNOTSUPP;
>>>>        if (copy_from_user(&range, arg, sizeof(range)))
>>>>                return -EFAULT;
>>>> +       if (range.start > btrfs_super_total_bytes(fs_info->super_cop=
y))
>>>> +               return -EINVAL;
>>>
>>> This makes it impossible to trim block groups that start at an offset=

>>> greater then the super_total_bytes values.
>>
>=20
>  what did I miss? As there is no limit on the range::length
>  so we can still trim beyond super_total_bytes. So I don=E2=80=99t
>  understand why not? More below.
>=20
>=20
>> Exactly.
>>
>>> In fact, in extreme cases
>>> it's possible all block groups start at offsets larger then
>>> super_total_bytes.
>>> Have you considered that, or am I missing something?
>>
>> And, I have already mentioned exactly the same reason in that commit
>> message.
>>
>> To address it once again, the bytenr is btrfs logical address space, h=
as
>> nothing to do with any device.
>> Thus it can be [0, U64MAX].
>>
>=20
>  Fundamentally, logical address space has no relevance in the user cont=
ext,
>  so also I don=E2=80=99t understand your view on how anyone shall use t=
he range::start
>  even if there is no check?

range::start =3D=3D bg_bytenr, range::len =3D bg_len to trim only a bg.

And that bg_bytenr is at 128T, since the fs has gone through several
balance.
But there is only one device, and its size is only 1T.

Please tell me how to trim that block group only?

>=20
>  As in the man page it's ok to adjust the range internally, and as leng=
th
>  can be up to U64MAX we can still trim beyond super_total_bytes?

As I said already, super_total_bytes makes no sense in logical address
space.
As super_total_bytes is just the sum of all devices, it's a device layer
thing, nothing to do with logical address space.

You're mixing logical bytenr with something not even a device physical
offset, how can it be correct?

Let me make it more clear, btrfs has its own logical address space
unrelated to whatever the devices mapping are.
It's always [0, U64_MAX], no matter how many devices there are.

If btrfs is implemented using dm, it should be more clear.

(single device btrfs)
          |
(dm linear, 0 ~ U64_MAX, virtual devices)<- that's logical address space
  |   |   |    |
  |   |   |    \- (dm raid1, 1T ~ 1T + 128M, devid1 XXX, devid2 XXX)
  |   |   \------ (dm raid0, 2T ~ 2T + 1G, devid1 XXX, devid2 XXX)
  |   \---------- (dm raid1, 128G ~ 128G + 128M, devi1 XXX, devid xxx)
  \-------------- (dm raid0, 1M ~ 1M + 1G, devid1 xxx, devid2 xxx).

If we're trim such fs layout, you tell me which offset you should use.

Thanks,
Qu

>=20
> Thanks, Anand
>=20
>=20
>> Thanks,
>> Qu
>>
>>>
>>> The change log is also vague to me, doesn't explain why you are
>>> re-adding that check.
>>>
>>> Thanks.
>>>
>>>>
>>>>        /*
>>>>         * NOTE: Don't truncate the range using super->total_bytes.  =
Bytenr of
>>>> --
>>>> 2.21.0 (Apple Git-120)
>>>>
>>>
>>>
>>
>=20


--Prte5qK6fIOxDv20I5WTmDyiTNyfeHa9Y--

--IXh7IeNkm5GbCWocOZ0tYD1jlmMN7NN9Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1KstIACgkQwj2R86El
/qgcoQf8DlmK+68GKMWEutib0VYVbcPIXJoeQTTTmPrtqAT7Jha0NLlD7P5brb41
Z6ffzq5ffUD/xUjiodJ9bOQ1fPuFkR8N03da5icQFZzmQypoRjSTORynncA8G47n
nrzmJsoQHPlzd58YKYeoo3G5zRi2AKEzQWcVgwLU5jAbKxciAJke6vv3/4sAsWgD
D0QBEjyXty6hl5KAsBuimIo/94Rue2b3Qzx0S9eYlx0/jWifvjBtPkw2kDScjbzb
riGQuMm3CTuvn9iIx7e2B4g77H7kSqfuKYGXFyU/T1uoGeBq6ll6otAjAJTy85Ut
bKJxzLeqdCix2y4YIrPOinp9iyAVoQ==
=nht7
-----END PGP SIGNATURE-----

--IXh7IeNkm5GbCWocOZ0tYD1jlmMN7NN9Z--
