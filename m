Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 313C31437F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2019 04:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfEFCEg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 May 2019 22:04:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:56037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfEFCEf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 May 2019 22:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557108266;
        bh=HuRTr1bZQPEkDXW3NuY1pK1lNGT9keC52xKbt72k5QE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=P96h6W71D6hLYbIOBi+v/VzuQRYldu5+Jl4arXxf1AxW6BDvidOjToziQCadCqjih
         zIAmkYuNfBySslUAKKva9UWVHu4hpfZVrweSynz3FRD0nP1n4sP3zRrHDMMIZgYa+P
         sZKQDbkoJtpJShQ3I/icBTDUZUezMQU49pWdHrJ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MJBn4-1hKitx2OBG-002p2R; Mon, 06
 May 2019 04:04:26 +0200
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
To:     fdmanana@gmail.com
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190503010852.10342-1-wqu@suse.com>
 <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
 <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com>
 <CAL3q7H4xp9=Kw3Q1hoDz_2Tbek4NdaULhJX4s7wmUqmku=ex0A@mail.gmail.com>
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
Message-ID: <d3e1b3dd-60da-bd6f-24b7-7cda8fde6ac2@gmx.com>
Date:   Mon, 6 May 2019 10:04:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4xp9=Kw3Q1hoDz_2Tbek4NdaULhJX4s7wmUqmku=ex0A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EU3AM96Ve3nwePSgwks3nnyn7Lz5yxxwj"
X-Provags-ID: V03:K1:E3L4qdvV6HBjvCVQNpF6edUkxjnTebJ//8HkYcb8hj4YdHvr2JU
 1JhZqoBbc4QloR7BeZFN6JyB5MVhUav449nczMou8AXN7iM4upsyu4BDQWxTl6oT7r2pc/n
 48RCUtUFmPSTw2iEWc+jwuyLM31hN6Rqsi5sKkNQXMVnkEXIjo1y+boifq6B9o2J5+xFaMs
 doqqGAsTd41sFQDSLa7yw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D6Bnwzngpjc=:KR72Ckc3IP+ObFH12moPc3
 QRpTLq+P3ciDhYu6OsCYRpUjm7G02OT4k6zXnlhJJQfKgMrAOcADODzWFLwJlMz0w9sYa7v6s
 koyZhK3sECBsJMvfzKluzoygelQre2+sMtBg1H7ubH3/w6uU/gIRk3LZb/J4DRh9azCmcfswX
 guGCZh/e3JuidqWOo2c4zD5ZvVkbUIlChsBwpkTTWAoIHbN1oute0AViKUrxqqhUF5evFNiXR
 CElRUSfAFLpMc6DPStcKpMPsXvRQArgrSmk4+Sd3uCKimcganT1DdgZxd4/lU1VnuS7EC2Mr5
 thuh8yquyL3I7zw2IcmvcULtKUUvmL1bGvrEKvQ613NjiseXeumYZg8ybmvTkCj/3R1VjJk2+
 wBQwiApHRtSQQuPIEnJ85pb7jSpMMrgUhc/ugSoz+0YcOU5xgOpIWRLEeCA8WVpfnmtpdRpLM
 uIVXoDezQ88t0XaPCmdEJrcnf0aNrVMhMzAWivz1X2tDWmyleVeaSt2p0f4eh/mMiUAQ+EtwW
 ddyojaZ08qtV3PpWF1zg45l4yAVWbwB8RRabArbGYzHv9k9PKmU+I2WC5EKgTPgDVnCpU7+1C
 qYt8fSPaUAkmM16FTYEu9fngEWoxDiBTk2X9sjHLIQLTmgP4XahLBY5e6E8cf68hZtl0id9wv
 f9J2ET6SFtfxKHrcr8x3D+OzgnUykX5rRnhBd3R7zXtt38fHA8kyKsayFJDDidSXoTv+SwX3G
 gDGpi+wxNWf65qI27WsfSHAX67zYFhnUr1fEY+8B03nDDvYPgYgLheDvbfEoWxcCtyzwuxZYc
 Cb6y1aNchNW01aBcQpQGAiEYsmlMz17XQOS1g7CD/HMkE0JupvWAw4YjcuFg+NPDi0lHDXfb4
 zx0Zfsn1KS42XUbJMHcrIlH4hfFqYKzGLMuLfiVd0/tixBlbsOo4PWhdY8I/sC
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EU3AM96Ve3nwePSgwks3nnyn7Lz5yxxwj
Content-Type: multipart/mixed; boundary="JDPmTZpyHKp1L742RI6VA9rqOzy4p9xu8";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <d3e1b3dd-60da-bd6f-24b7-7cda8fde6ac2@gmx.com>
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
References: <20190503010852.10342-1-wqu@suse.com>
 <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
 <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com>
 <CAL3q7H4xp9=Kw3Q1hoDz_2Tbek4NdaULhJX4s7wmUqmku=ex0A@mail.gmail.com>
In-Reply-To: <CAL3q7H4xp9=Kw3Q1hoDz_2Tbek4NdaULhJX4s7wmUqmku=ex0A@mail.gmail.com>

--JDPmTZpyHKp1L742RI6VA9rqOzy4p9xu8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[snip]
>>
>> For data writeback, it should only cause sync related failure.
>=20
> Ok, so please remove the transaction abort comments for next iteration.=

> By sync related failure, you mean running dealloc fails with ENOSPC,
> since when it tries to reserve a data extent it fails as it can't find
> any free extent.

Well, btrfs has some hidden way to fix such problem by itself already.

At buffered write time, we have the following call chain:
btrfs_buffered_write()
|- btrfs_check_data_free_space()
   |- btrfs_alloc_data_chunk_ondemand()
      |- need_commit =3D 2; /* We have 2 chance to retry, 1 to flush */
      |- do_chunk_alloc() /* we have no data space available */
      |- if (ret < 0 && ret =3D=3D -ENOSPC)
      |-     goto commit_trans;  /* try to free some space */
      |- commit_trans:
      |-     need_commit--;
      |-     if (need_commit > 0) {
      |-         btrfs_start_delalloc_roots();
      |-         btrfs_wait_ordered_roots();
      |-     }

This means, as long as we hit ENOSPC for data space, we will start write
back, thus NODATACOW data will still hit disk as NODATACOW.

Such hidden behavior along with always-reserve-data-space solves the
problem pretty well.
We either:
- reserve data space
  Then no matter how it ends, we're OK, although it may end as CoW.

- Failed to reserve data space
  Writeback will be triggered anyway, no way to screw things around.

Thus this workaround has nothing to fix, but only make certain NODATACOW
reach disk as NODATACOW.

It makes some NODATACOW behaves more correctly but won't fix any obvious
bug.

My personal take is to fix any strange behavior even it won't cause any
problem, but the full inode writeback can be performance heavy.

So my question is, do we really need this anyway?

Thanks,
Qu

>=20
>>
>>> I don't recall starting transactions when running dealloc, and failed=

>>> to see where after a quick glance to cow_file_range()
>>> and run_delalloc_nocow(). I'm assuming that 'at delalloc time' means
>>> when starting writeback.
>>>
>>>>
>>>> [CAUSE]
>>>> This is due to the fact that btrfs can only do extent level share ch=
eck.
>>>>
>>>> Btrfs can only tell if an extent is shared, no matter if only part o=
f the
>>>> extent is shared or not.
>>>>
>>>> So for above script we have:
>>>> - fallocate
>>>> - buffered write
>>>>   If we don't have enough data space, we fall back to NOCOW check.
>>>>   At this timming, the extent is not shared, we can skip data
>>>>   reservation.
>>>
>>> But in the above example we don't fall to nocow mode when doing the
>>> buffered write, as there's plenty of data space available (1Gb -
>>> 24Kb).
>>> You need to update the example.
>> I have to admit that the core part is mostly based on the worst case
>> *assumption*.
>>
>> I'll try to make the case convincing by making it fail directly.
>=20
> Great, thanks.
>=20
>>
>>>
>>>
>>>> - reflink
>>>>   Now part of the large preallocated extent is shared.
>>>> - delalloc kicks in
>>>
>>> writeback kicks in
>>>
>>>>   For the NOCOW range, as the preallocated extent is shared, we need=

>>>>   to fall back to COW.
>>>>
>>>> [WORKAROUND]
>>>> The workaround is to ensure any buffered write in the related extent=
s
>>>> (not the reflink source range) get flushed before reflink.
>>>
>>> not the reflink source range -> not just the reflink source range
>>>
>>>>
>>>> However it's pretty expensive to do a comprehensive check.
>>>> In the reproducer, the reflink source is just a part of a larger
>>>
>>> Again, the reproducer needs to be fixed (yes, I tested it even if it'=
s
>>> clear by looking at it that it doesn't trigger the nocow case).
>>>
>>>> preallocated extent, we need to flush all buffered write of that ext=
ent
>>>> before reflink.
>>>> Such backward search can be complex and we may not get much benefit =
from
>>>> it.
>>>>
>>>> So this patch will just try to flush the whole inode before reflink.=

>>>
>>>
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Reason for RFC:
>>>> Flushing an inode just because it's a reflink source is definitely
>>>> overkilling, but I don't have any better way to handle it.
>>>>
>>>> Any comment on this is welcomed.
>>>> ---
>>>>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
>>>>  1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>> index 7755b503b348..8caa0edb6fbf 100644
>>>> --- a/fs/btrfs/ioctl.c
>>>> +++ b/fs/btrfs/ioctl.c
>>>> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struct =
file *file, struct file *file_src,
>>>>                         return ret;
>>>>         }
>>>>
>>>> +       /*
>>>> +        * Workaround to make sure NOCOW buffered write reach disk a=
s NOCOW.
>>>> +        *
>>>> +        * Due to the limit of btrfs extent tree design, we can only=
 have
>>>> +        * extent level share view. Any part of an extent is shared =
then the
>>>
>>> Any -> If any
>>>
>>>> +        * whole extent is shared and any write into that extent nee=
ds to fall
>>>
>>> is -> is considered
>>>
>>>> +        * back to COW.
>>>
>>> I would add, something like:
>>>
>>> That is, btrfs' back references do not have a block level granularity=
,
>>> they work at the whole extent level.
>>>
>>>> +        *
>>>> +        * NOCOW buffered write without data space reserved could to=
 lead to
>>>> +        * either data space bytes_may_use underflow (kernel warning=
) or ENOSPC
>>>> +        * at delalloc time (transaction abort).
>>>
>>> I would omit the warning and transaction abort parts, that can change=

>>> any time. And we have that information in the changelog, so it's not
>>> lost.
>>>
>>>> +        *
>>>> +        * Here we take a shortcut by flush the whole inode. We coul=
d do better
>>>> +        * by finding all extents in that range and flush the space =
referring
>>>> +        * all those extents.
>>>> +        * But that's too complex for such corner case.
>>>> +        */
>>>> +       filemap_flush(src->i_mapping);
>>>> +       if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
>>>> +                    &BTRFS_I(src)->runtime_flags))
>>>> +               filemap_flush(src->i_mapping);
>>>
>>> So a few comments here:
>>>
>>> - why just in the clone part? The dedupe side has the same problem, d=
oesn't it?
>>
>> Right.
>>
>>>
>>> - I would move such flushing to btrfs_remap_file_range_prep - this is=

>>> where we do the source and target range flush and wait.
>>>
>>> Can you turn the reproducer into an fstests case?
>>
>> Sure.
>>
>> Thanks for the info and all the comment,
>> Qu
>>
>>>
>>> Thanks.
>>>
>>>> +
>>>>         /*
>>>>          * Lock destination range to serialize with concurrent readp=
ages() and
>>>>          * source range to serialize with relocation.
>>>> --
>>>> 2.21.0
>>>>
>>>
>>>
>>
>=20
>=20


--JDPmTZpyHKp1L742RI6VA9rqOzy4p9xu8--

--EU3AM96Ve3nwePSgwks3nnyn7Lz5yxxwj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzPlhkACgkQwj2R86El
/qjSUQf8CJ2s0lDmRqYdkklUIjCpKDOHLTP2RlB5VXvup4S/Jd9ej/4wqsxIzWST
c2bjH1FAn+W6ljcCM1dEB5wSdxHiM01ySxLe7Y6eqDmr++AMYsvJz2Kfe1kn3xnr
fJYKyy0UgdmlBn3F68y3tchTGJOwRNqKD6oflu7BDgikY96qNXbg+0T9fvpcqC39
dBTQ8HpXy5IGVH7nKuuGc6vciVyDFS4Bz4xwTtsoWzZGUmLeDzpAFcfHT0nAs91Q
r2M6E2HrlQi9wF6TQ3kHIhE+Wcj1GMB1r1SQAb6phNQq9YSYD1UGtR1FQ0HGT+H3
Idhtj8nUeIfhrKLkRE6w4kR+bsmQCA==
=dBlN
-----END PGP SIGNATURE-----

--EU3AM96Ve3nwePSgwks3nnyn7Lz5yxxwj--
