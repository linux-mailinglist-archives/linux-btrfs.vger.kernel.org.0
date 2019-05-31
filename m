Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B92330830
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 07:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfEaF4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 01:56:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:57235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbfEaF4f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 01:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559282184;
        bh=FbsLnkKGA4jXZYNqiNmUa95mw4W+PGuX5k9Bp+5VQkg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YgmgZJ1AOSqb7fYvvDPasaTzJFGXR7ZYG7Axm1WTO9JGarMcmQcDdBBApeuxZrjxB
         AtUnZS0lNiMLx/DHjLIez4e/t3P37uqLjFrNvZPUuWTHKWf2H2rzijMNbu5Ezh0281
         W0NN/VGHKkyrs82mIX2kxfSpgvfBZM3K08ZY5G7w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Ma1tv-1hJ3cH2tEV-00Lp7r; Fri, 31
 May 2019 07:56:23 +0200
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20190528082154.6450-1-wqu@suse.com>
 <3ee71943-70f3-67c9-92ed-3a8719aee7f8@oracle.com>
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
Message-ID: <9218c153-f452-a4bc-f36b-d400bd835c86@gmx.com>
Date:   Fri, 31 May 2019 13:56:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3ee71943-70f3-67c9-92ed-3a8719aee7f8@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RO9arXksnG9sNop64QfQDbxuEqG6DOvwz"
X-Provags-ID: V03:K1:o/er9aM94o+04Ad1fcpIjf1ZbckVh/bjdFchQUZEJlKxN6qsGa2
 faigg0jJo633N9V5qk3tJf6P3i1n06siqKi1GC3Sr1DQzFlWHydkZbnQ1b1+PmpviGCeHWl
 OarYtt6Vu9RoG8IakJjPIgivjtAdRWWWRVH0z16lKrGrVkdz12yHlhKl7eZICDSGHoAMqzl
 J3ELfBrs4itcxEAVBI5gw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6JnPrL4ZTtY=:iZ/cXLNDsdbGYnzH5DfGFG
 csXVBYlHAf5dhbtShV+wZZazeVcHa8ye9hU6tX0LfgJ5zq2mKqA+IV4YVAHsjT7JdPDB1z4Zh
 X1KxBVYhxNGLrhPRY3SLSOCCWP4j0Q4Rd9fzp/qXXJCiGaCmlKFL0frtHIYBuAOT5CCVk0+Hj
 wvNErJZPCPsCjm11pM6r1hmo92hBUtD2XTh9qF1ikKGlCx+1zbEHfvZ+r7KM0mxQtJFsGDEeY
 e3bzl/sKrVZonWI8YLOCnM9bY9114jhtit4BogN5WD8UW5sQ/tYfnt0iJbZIYEwZOdwTtif/V
 AExmBcQQQa7jLPAJ4H7UcAHLpbtpWwRRzjBg8RgpSVUnRyyrCGKxeoNWTONwPILK9nYp3ihk1
 3Vhgj5URnf7tSwZzgQoyLXN544Roi8aiw+iCIvbosGfFAsiWECwTPGl86WmdNcIaECSrYFmjO
 eO0DL1paOhWzc8Djt7Ejd+pZwPCAmHELbpeXWilEoIsII34CsiqAZrsB2RWmGNRI0k8JaIQUV
 8sRL3BG7yGsfzA394GETh+PzlGZI5NwgrS1jPX7fg1S5Zd55Y2RW2d0yD+jW15Bb+SSMPFJmJ
 E58zUeWJa2GB3VDd/Hfl8jnSqj5/lkuNxN8ks89xr8PAU2DyPd4Zpx3s6GkUuqzOBO5LmrAKX
 uHZWsbGsa7dsbWQBK6DBpaqLOq23zr7TY84+Yf7zxO/c1KZd6TnQt9e5jkm+DF5wxmwqsVRts
 My/1hSf0iCWXqpzw+5d0CrJFKRN57OFh/MISB6Lc99n6Wp58iO1W0L+qurozHWnenklnWusuK
 DVux0kUvC+anIXC49QEblZ8t7AvtGKMJbDAmlag9Ub+EbaT/7QrmVXHMvWDfpOwflNwEO1c5o
 AMUJHse8vWqCRcfeQmwNT+6OD7kMIHckxFADHt3C9Alh5ZRe5dSSFdPqGyrdSdw11L+VeZHpf
 zubWNiQkVszjh9w5k7leeU9Yq9Pyonbc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RO9arXksnG9sNop64QfQDbxuEqG6DOvwz
Content-Type: multipart/mixed; boundary="NK2LODk5xEvPxFSNXY3qvmfIHFNUjEDwg";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
Message-ID: <9218c153-f452-a4bc-f36b-d400bd835c86@gmx.com>
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
References: <20190528082154.6450-1-wqu@suse.com>
 <3ee71943-70f3-67c9-92ed-3a8719aee7f8@oracle.com>
In-Reply-To: <3ee71943-70f3-67c9-92ed-3a8719aee7f8@oracle.com>

--NK2LODk5xEvPxFSNXY3qvmfIHFNUjEDwg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/31 =E4=B8=8B=E5=8D=881:35, Anand Jain wrote:
> On 5/28/19 4:21 PM, Qu Wenruo wrote:
>> Normally the range->len is set to default value (U64_MAX), but when it=
's
>> not default value, we should check if the range overflows.
>>
>> And if overflows, return -EINVAL before doing anything.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> fstests patch
> =C2=A0=C2=A0 https://patchwork.kernel.org/patch/10964105/
> makes the sub-test like [1] in generic/260 skipped
>=20
> [1]
> -----
> fssize=3D$($DF_PROG -k | grep "$SCRATCH_MNT" | grep "$SCRATCH_DEV"=C2=A0=
 | awk
> '{print $3}')
> beyond_eofs=3D$((fssize*2048))
> fstrim -o $beyond_eofs $SCRATCH_MNT <-- should_fail
> -----

As I mentioned in the commit message and offline, the idea of *end of
filesystem* is not clear enough.

For regular fs, they have every byte mapped directly to its block device
(except external journal).
So its end of filesystem is easy to determine.
But we can still argue, how to trim the external journal device? Or
should the external journal device contribute to the end of the fs?


Now for btrfs, it's a dm-linear space, then dm-raid/dm-linear for each
chunk. Thus we can argue either the end of btrfs is U64MAX (from
dm-linear view), or the end of last block group (from mapped chunk view).=


Further more, how to define end of a filesystem when the fs spans across
several devices?

I'd say this is a good timing for us to make the fstrim behavior more cle=
ar.

Thanks,
Qu

>=20
> Originally [1] reported expected EINVAL until the patch
> =C2=A0 6ba9fc8e628b btrfs: Ensure btrfs_trim_fs can trim the whole file=
system
>=20
> Not sure how will some of the production machines will find this as,
> not compatible with previous versions? Nevertheless in practical terms
> things are fine.
>=20
> =C2=A0Reviewed-by: Anand Jain <anand.jain@oracle.com>
>=20
> Thanks, Anand
>=20
>> ---
>> =C2=A0 fs/btrfs/extent-tree.c | 14 +++++++++++---
>> =C2=A0 1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index f79e477a378e..62bfba6d3c07 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -11245,6 +11245,7 @@ int btrfs_trim_fs(struct btrfs_fs_info
>> *fs_info, struct fstrim_range *range)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_device *device;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *devices;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 group_trimmed;
>> +=C2=A0=C2=A0=C2=A0 u64 range_end =3D U64_MAX;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 start;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 end;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 trimmed =3D 0;
>> @@ -11254,16 +11255,23 @@ int btrfs_trim_fs(struct btrfs_fs_info
>> *fs_info, struct fstrim_range *range)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int dev_ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Check range overflow if range->len is set.=

>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The default range->len is U64_MAX.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (range->len !=3D U64_MAX && check_add_overflow(=
range->start,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 range->len, &range_end))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache =3D btrfs_lookup_first_block_grou=
p(fs_info, range->start);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (; cache; cache =3D next_block_grou=
p(cache)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache->key.objectid >=3D=
 (range->start + range->len)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cache->key.objectid >=3D=
 range_end) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 btrfs_put_block_group(cache);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start =3D=
 max(range->start, cache->key.objectid);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =3D min(range->start +=
 range->len,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cache->key.objectid + cache->key.offset);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =3D min(range_end, cac=
he->key.objectid + cache->key.offset);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (end =
- start >=3D range->minlen) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!block_group_cache_done(cache)) {
>>
>=20


--NK2LODk5xEvPxFSNXY3qvmfIHFNUjEDwg--

--RO9arXksnG9sNop64QfQDbxuEqG6DOvwz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzwwfwACgkQwj2R86El
/qgYpAf/de4mxnT8G1p5xpqqFSbHCfujCrYlDSgOn1yi2qRuF9WX52XpfuU02i/7
ywJ6THsK90G/9OX9Yk8lTPSZRJLaZeh9S7+gURMJgEd6fFRZLGn5nVBJRQbcPcN0
0Hc5AG+Jw7dyGiCY3L22v251pwX0XIsGSntpH74CeWnAYW2Ue7kDcTuF/Yl5mJiC
W16zKfr152YYZv1cPsaV0wxLvJhjRnGzNQPTlF2ODTixQ2iLi4NG0cNFiFR9iyHi
buIBf0GZ1+uYDaPiBM2V02QBK/vlc7TULXHC55P4/0vQM15xd71B9SdZSiif+vPh
0roDOQMwGyYmLPRO+vepbBhAwru16Q==
=iXTA
-----END PGP SIGNATURE-----

--RO9arXksnG9sNop64QfQDbxuEqG6DOvwz--
