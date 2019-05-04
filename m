Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4061369C
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2019 02:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEDAce (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 20:32:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:47411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfEDAce (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 May 2019 20:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556929941;
        bh=pEOnjEK1HLZDDnxIoLgIrf8apfNPKtqOX8HegZXJco8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=goEKzXxA5Vemcm4MFFGbWdzlnFSK6coz5xQ5dGQJIVAroPHs3QfHx5d4spIuUtK5z
         uK/F/41TA22pIpcMVEcpQX/CiAghRTzEEIXeQbm5oPwjISLdoLMhfehE1o9fOBajPQ
         pOJzudrPO4g1JrRLS52XTopvBssERzPbymUeuft0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M3ARX-1gVR9o48Nr-00ssCM; Sat, 04
 May 2019 02:32:21 +0200
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20190503010852.10342-1-wqu@suse.com>
 <20190503215622.GC20359@hungrycats.org>
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
Message-ID: <448c9a50-98b0-15aa-cbde-81b294bd74e4@gmx.com>
Date:   Sat, 4 May 2019 08:32:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503215622.GC20359@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kVZB3UtCmpzrBBE0kuwEUQENpVjfPr0Pn"
X-Provags-ID: V03:K1:JMbLDopGQsAj7NMwXvedGbkj1mAsqkxiPZirk+hxtLQ8HhrYJAx
 2AK5JH3RgzYyRzicFNRRrNj9ay6XJMgV4A5zkJB9iBoYqqeNoMPG5we5aSqLqnl9eJH9FpJ
 D3FOeb37k25TQpKZdZ5m0Ge2o6xHFkrr8BO/7aOJWL9UDUjBBsvH5sRAoaP/7KOGWAU6c9A
 /EWLFDoNv6q7/6/aYsNPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ul1azIncqQ8=:pKU14hGKPijp5z4ktXPf28
 vJbSpVfgLMrs2YdaitM+hMKDqyDH0JF4lEXqpqqKRlqdtUTYc1OzGIZViji0olVSLg8Tzg7LZ
 iKJNTr6ppfKw+eHtlzKVldFp+MKHrYvYIpxtug4qSb7f/8+zhtNNCnK3Q17Jgb80w8bsKfDFs
 3dA7IyHmpYW2fizJLGJ1/4I/e7cyMLzFGn75MGcX6kWhxsPi1rrgl/UNC//ZRCapmehRcLjol
 H9+iu8oMxh/3znpaXvfOKZ/HmnoKKhYnOG0GdNeFM7keqMt6vyp5NFYH6rojcMwfn6U2y1qLo
 V5DjzI/En7lCIvDHAlz5cpvIrDknmXxlqT1bG4zVhAd0TmJ6kcvLKCr1qH0Lg/+Q+fRZkZRen
 xNCYGuyqhG6ls86SGG34iNvuuMwKkzywOBmgo40C3NHdg3VOs1xiAwm6psKTUeQwlYuP4Bh4b
 hvLD6bm5pT71EZnDfu3o4QqEJjk1C2ZrZafhMWfKuSQYlbRFkUrCZ+/5xPmk03AuydAk7BVI7
 GD/zEncjSyZDLirkQ/fjtslpEC5av6KoOOUW2w8IFuEix8pZn8JRs9A3dvC47pk+LvNIru0BP
 snbO0shQJmx3iU4uVfDR3lRi6snaZIt6eYAgFwnAbsWP4V9YSvzc0qbuK0QhI2B6woZGCAGm2
 x6S2uVJUiy50L7a5BWrVdKLat6FvYd2cBugRzvPS7RcgIpPN+B+wnAcKAC5IUdBCwdzD2DuSY
 ShAQtzM6h5GbsVQ9nkB6pbnW277vXUg80HqpRBXw7acOsPXB4KfUSSWjAeo8L1VoxjWHg3FRd
 ufYZ1s/heRO/kozDYoFpaBBegmESZql8AqDb85nRRQYrH1sFmj8Ol7R94J/Jsg3qFsAkuo12z
 QpAulX85V35mZRHjmPZUEVWNnOxr8BTWnx/ZjVD73PVzOug8jOVFgoZhFrhQFZ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kVZB3UtCmpzrBBE0kuwEUQENpVjfPr0Pn
Content-Type: multipart/mixed; boundary="XLJwA6FRRPG1Pr4fxlSfUApZQkIAtAlIc";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Message-ID: <448c9a50-98b0-15aa-cbde-81b294bd74e4@gmx.com>
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
References: <20190503010852.10342-1-wqu@suse.com>
 <20190503215622.GC20359@hungrycats.org>
In-Reply-To: <20190503215622.GC20359@hungrycats.org>

--XLJwA6FRRPG1Pr4fxlSfUApZQkIAtAlIc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/4 =E4=B8=8A=E5=8D=885:56, Zygo Blaxell wrote:
> On Fri, May 03, 2019 at 09:08:52AM +0800, Qu Wenruo wrote:
>> [BUG]
>> The following command can lead to unexpected data COW:
>>
>>   #!/bin/bash
>>
>>   dev=3D/dev/test/test
>>   mnt=3D/mnt/btrfs
>>
>>   mkfs.btrfs -f $dev -b 1G > /dev/null
>>   mount $dev $mnt -o nospace_cache
>>
>>   xfs_io -f -c "falloc 8k 24k" -c "pwrite 12k 8k" $mnt/file1
>>   xfs_io -c "reflink $mnt/file1 8k 0 4k" $mnt/file1
>>   umount $dev
>>
>> The result extent will be
>>
>> 	item 7 key (257 EXTENT_DATA 4096) itemoff 15760 itemsize 53
>> 		generation 6 type 2 (prealloc)
>> 		prealloc data disk byte 13631488 nr 28672
>> 	item 8 key (257 EXTENT_DATA 12288) itemoff 15707 itemsize 53
>> 		generation 6 type 1 (regular)
>> 		extent data disk byte 13660160 nr 12288 <<< COW
>> 	item 9 key (257 EXTENT_DATA 24576) itemoff 15654 itemsize 53
>> 		generation 6 type 2 (prealloc)
>> 		prealloc data disk byte 13631488 nr 28672
>>
>> Currently we always reserve space even for NOCOW buffered write, thus
>> under most case it shouldn't cause anything wrong even we fall back to=

>> COW.
>>
>> However when we're out of data space, we fall back to skip data space =
if
>> we can do NOCOW write.
>>
>> If such behavior happens under that case, we could hit the following
>> problems:
>> - data space bytes_may_use underflow
>>   This will cause kernel warning.
>>
>> - ENOSPC at delalloc time
>>   This will lead to transaction abort and fs forced to RO.
>>
>> [CAUSE]
>> This is due to the fact that btrfs can only do extent level share chec=
k.
>>
>> Btrfs can only tell if an extent is shared, no matter if only part of =
the
>> extent is shared or not.
>>
>> So for above script we have:
>> - fallocate
>> - buffered write
>>   If we don't have enough data space, we fall back to NOCOW check.
>>   At this timming, the extent is not shared, we can skip data
>>   reservation.
>> - reflink
>>   Now part of the large preallocated extent is shared.
>> - delalloc kicks in
>>   For the NOCOW range, as the preallocated extent is shared, we need
>>   to fall back to COW.
>>
>> [WORKAROUND]
>> The workaround is to ensure any buffered write in the related extents
>> (not the reflink source range) get flushed before reflink.
>>
>> However it's pretty expensive to do a comprehensive check.
>> In the reproducer, the reflink source is just a part of a larger
>> preallocated extent, we need to flush all buffered write of that exten=
t
>> before reflink.
>> Such backward search can be complex and we may not get much benefit fr=
om
>> it.
>>
>> So this patch will just try to flush the whole inode before reflink.
>=20
> Does that mean that if a large file is being written and deduped
> simultaneously, that the dedupes would now trigger flushes over the
> entire file?  That seems like it could be slow.

Yes, also my reason for RFC.

But it shouldn't be that heavy, as after the first dedupe/reflink, most
IO should be flushed back, later dedupe has much less work to do.


>=20
> e.g. if the file is a big VM image file and it is used src and for dedu=
pe
> (which is quite common in VM image files), we'd be hammering the disk
> with writes similar to hitting it with fsync() in a tight loop?

The original behavior also flush the target and source range, so we're
not completely creating some new overhead.

Thanks,
Qu

>=20
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>> Flushing an inode just because it's a reflink source is definitely
>> overkilling, but I don't have any better way to handle it.
>>
>> Any comment on this is welcomed.
>> ---
>>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 7755b503b348..8caa0edb6fbf 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struct fi=
le *file, struct file *file_src,
>>  			return ret;
>>  	}
>> =20
>> +	/*
>> +	 * Workaround to make sure NOCOW buffered write reach disk as NOCOW.=

>> +	 *
>> +	 * Due to the limit of btrfs extent tree design, we can only have
>> +	 * extent level share view. Any part of an extent is shared then the=

>> +	 * whole extent is shared and any write into that extent needs to fa=
ll
>> +	 * back to COW.
>> +	 *
>> +	 * NOCOW buffered write without data space reserved could to lead to=

>> +	 * either data space bytes_may_use underflow (kernel warning) or ENO=
SPC
>> +	 * at delalloc time (transaction abort).
>> +	 *
>> +	 * Here we take a shortcut by flush the whole inode. We could do bet=
ter
>> +	 * by finding all extents in that range and flush the space referrin=
g
>> +	 * all those extents.
>> +	 * But that's too complex for such corner case.
>> +	 */
>> +	filemap_flush(src->i_mapping);
>> +	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
>> +		     &BTRFS_I(src)->runtime_flags))
>> +		filemap_flush(src->i_mapping);
>> +
>>  	/*
>>  	 * Lock destination range to serialize with concurrent readpages() a=
nd
>>  	 * source range to serialize with relocation.
>> --=20
>> 2.21.0
>>


--XLJwA6FRRPG1Pr4fxlSfUApZQkIAtAlIc--

--kVZB3UtCmpzrBBE0kuwEUQENpVjfPr0Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzM3YsACgkQwj2R86El
/qjXAgf9Gp68aWUl9H89BJM9narugAVVrQHsNQ+f5R6SVAKvDAKeHPUHlZGg7ANY
qfG3asUh/t+oajnti4oKMiw3+ep9EHFWZcKi8Bk02MbKGI0BYeGA33VUE3j15AZh
qfujgoI4+M2IkAfDcKkuXxCRPymxb/W5O8IXk/LJ48J/3sJGU7LQrrr4xIsdiv2S
y7KHwSzMj4tvQuUcQv2xwuCPEABX+RU1i1A9bD8DxmIV7Y4FGuMtG8oDps7N+60p
kS0m7+Ox4in/+nm/fXW7v6VekPXbDyw3NYLw8Gwbygm3KD24Z4G6d0em65zmwidW
CYtk4FzNimJbjkgFZ4TStkXo/cU/Rw==
=ETv1
-----END PGP SIGNATURE-----

--kVZB3UtCmpzrBBE0kuwEUQENpVjfPr0Pn--
