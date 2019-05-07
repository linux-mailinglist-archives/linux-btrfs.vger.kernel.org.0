Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3889162A1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEGLN5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 07:13:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:59539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfEGLNz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 May 2019 07:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557227624;
        bh=knQQps/7+Ns8+vgQjaxg8LErxOkUbdCmuXNyEDlwgGk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RUTQ+On8T5kuXChwtDZMN9aGCfo8ysRFZQZEbgYhUZlY3kH4D12ELpS7m5AOypyhD
         19TCvZRqw+7AUou6tBXMzoi8zWdi5mH/oEWEkmLXgvBNLXFoeYpDMH3Lb52R3wE6SB
         CklSDrd5c6DwXTE+kJlu9/EOdZHRvbRgrmInT9ig=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M3NEK-1gXEvf213I-00r151; Tue, 07
 May 2019 13:13:44 +0200
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
To:     fdmanana@gmail.com
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190503010852.10342-1-wqu@suse.com>
 <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
 <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com>
 <CAL3q7H4xp9=Kw3Q1hoDz_2Tbek4NdaULhJX4s7wmUqmku=ex0A@mail.gmail.com>
 <d3e1b3dd-60da-bd6f-24b7-7cda8fde6ac2@gmx.com>
 <CAL3q7H7jmCnObo4Mtnnm9_07pePySbsRqdOFX+348s_q4VnA2Q@mail.gmail.com>
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
Message-ID: <028e58f3-99a6-f4bc-51f0-12eafee92c76@gmx.com>
Date:   Tue, 7 May 2019 19:13:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7jmCnObo4Mtnnm9_07pePySbsRqdOFX+348s_q4VnA2Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Sh0Fbj4uAT5HJ3cn3Ep2j94Ravm0O7yAY"
X-Provags-ID: V03:K1:x79R7troVUH1B4okFPIXgWB/tKe8HnmYyh1Kh8xI0PXjRbEkcsY
 ePJA/N0dgu5ORqOAaURKDvdhpo34CxibKv+5uYmTtzubYVqV/vzlleviHIMzH0YoZWqSOI1
 k7khbTv0wPKEsOFFtwv6J5rtap6sVtheUWbishTr0L6c7JlC3RXAjxZO6iSv3aPhSORMLTh
 QmEYCiyPw42ZiVI8ofJBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5SlkLM81Hys=:Hbg72m3d45TfrMZsMcMCfn
 eJeN0+kzkReaQi1m19lkV8ZlRVYZAtW8f9OdVNevxf7grzgke5mccdm9JsjBX+ecZZjEEeyUh
 anM12Iq72peWmzfMCD4mz9QWKZ8G4awHXf/XeGZqeeHIX3lFYWwGmMFtzt3I4PFvcwpzWiH9W
 YVjv2rd+s2tqilTMTdieAH8CNBbWwxQlObrsulU7uHBp5kLsHMrWOZm173R7TnLe6mSpBMqzF
 onbdz9ACGKC4MEC/XBlTo6GoZSe4DKHdCs6OgPt5kCXCI2gGEHbxBEFtxouPx8nrzDJYi36b6
 OW/3M/olhAez1OLB20Ys0SYh0sTqEJeOgIO/cNUfL+HR0A2yF0w0yMWDE4/TsMzLqaeaJP/g7
 L6IHR+DRYgn9xU4JaCYMeaA4Ub9r98pYxuD7L2oflKV4klZwzrKlRsLnAsG2GCSvBcRpn42eE
 7pNIbCCCpnXzyMYWchBtrMJf5TEjFF5UvdWY/6K/ureDqsZV6QPHtCtquBWw5CToQCZ5QqBcP
 eYde6HjqmEwDIP5n1T3z9xOF0A9m4v57cQnY3K/qNZx2rH1JpwrslIGU8joZeiPzGqMlHeXyl
 xeKiLiTd4w7TsnW1Z1ya+k/wNwuhkjLEHZj0Hu4HEx3k+M8d/jGc1q6jQsxAkb6IVeHONP7vc
 jKXv1tnjR5jkP9uLKabuH36L8K1zNS1c17S0r9himKpPYzvXgqIcWCpFEalMLduwGrmgSoOfg
 dAZcV5pxe9NrPIOmwt8jQuCEkKuG5l6WaL3ufEn31obj9qXDVJnszKzx3WZXShKxpx1f0M8o0
 6GVU/g2UJNLKU7n/bOEIpur5xwAOFz3vBDpZvCFwdct2Wmm3FsdQG+gq5k37/p8g5vCGJggo2
 zdo6Mb2k4P9fBPEMXmsVm/w9MmvRveDQHF2PR1QP3hlB7a9AskwT9bZ0BdA+aO
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sh0Fbj4uAT5HJ3cn3Ep2j94Ravm0O7yAY
Content-Type: multipart/mixed; boundary="iTQ6pMcvTYDbFcA3H3zLjvVek6aFn9vqV";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <028e58f3-99a6-f4bc-51f0-12eafee92c76@gmx.com>
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
References: <20190503010852.10342-1-wqu@suse.com>
 <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
 <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com>
 <CAL3q7H4xp9=Kw3Q1hoDz_2Tbek4NdaULhJX4s7wmUqmku=ex0A@mail.gmail.com>
 <d3e1b3dd-60da-bd6f-24b7-7cda8fde6ac2@gmx.com>
 <CAL3q7H7jmCnObo4Mtnnm9_07pePySbsRqdOFX+348s_q4VnA2Q@mail.gmail.com>
In-Reply-To: <CAL3q7H7jmCnObo4Mtnnm9_07pePySbsRqdOFX+348s_q4VnA2Q@mail.gmail.com>

--iTQ6pMcvTYDbFcA3H3zLjvVek6aFn9vqV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/7 =E4=B8=8B=E5=8D=884:56, Filipe Manana wrote:
> On Mon, May 6, 2019 at 3:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>> [snip]
>>>>
>>>> For data writeback, it should only cause sync related failure.
>>>
>>> Ok, so please remove the transaction abort comments for next iteratio=
n.
>>> By sync related failure, you mean running dealloc fails with ENOSPC,
>>> since when it tries to reserve a data extent it fails as it can't fin=
d
>>> any free extent.
>>
>> Well, btrfs has some hidden way to fix such problem by itself already.=

>>
>> At buffered write time, we have the following call chain:
>> btrfs_buffered_write()
>> |- btrfs_check_data_free_space()
>>    |- btrfs_alloc_data_chunk_ondemand()
>>       |- need_commit =3D 2; /* We have 2 chance to retry, 1 to flush *=
/
>>       |- do_chunk_alloc() /* we have no data space available */
>>       |- if (ret < 0 && ret =3D=3D -ENOSPC)
>>       |-     goto commit_trans;  /* try to free some space */
>>       |- commit_trans:
>>       |-     need_commit--;
>>       |-     if (need_commit > 0) {
>>       |-         btrfs_start_delalloc_roots();
>>       |-         btrfs_wait_ordered_roots();
>>       |-     }
>>
>> This means, as long as we hit ENOSPC for data space, we will start wri=
te
>> back, thus NODATACOW data will still hit disk as NODATACOW.
>>
>> Such hidden behavior along with always-reserve-data-space solves the
>> problem pretty well.
>=20
> It doesn't solve the problem you reported in the rfc patch.

You're right, it doesn't solve the problem at all.
In fact, another bug caused my test script to pass even with some dirty
pages unable to be flushed back.

But it at least make sure all other pages reach disk as NODATACOW except
the last page.

>=20
> What happens:
>=20
> 1) We have a file with a prealloc extent, that isn't shared
>=20
> 2) We have 0 bytes of available data space (or any amount less then
> that of the buffered write size)
>=20
> 3) A buffered write happens that falls within a subrange of the preallo=
c extent.
>     We can't reserve space, we do all those things at
> btrfs_alloc_data_chunk_ondemand(), but we can't get any data space
> released, since it's all allocated.

At that time, we're already flushing all previously buffered write data.

E.g. if we're writing into one 1M preallocated extent.
The first 4K, we have no data space reserved, dirtied the page, prepare
all delalloc.

Then the 2nd 4K, we call btrfs_check_data_free_space(), as we're at low
data free space already, we flush all inodes, including the previous 4K
we just dirtied.
Then the first 4K get written to disk NODATACOW, as expected.

This loop happens until we reach the last page.

>     Therefore we fall back to nodatacow mode. We dirty the pages, mark
> the range as dealloc, etc.
>=20
> 4) The reflink happens, for a subrange of the prealloc extent that
> does not overlap the range of the buffered write.

Just before the reflink, we only have 1 dirty page (the last page of
that buffered write) doesn't reach disk yet.

For the final page, we have no choice but do COW, and it fails with -ENOS=
PC.

However due to some other problem, the -ENOSPC doesn't reach user space
at all.


>=20
> 5) Some time after the reflink, writeback starts for the inode.
>     During the writeback we fallback to COW mode, because the prealloc
> extent is shared, even if the subrange of the buffered write does not
> overlap the reflinked subrange.
>     Now the write silently fails with -ENOSPC, and a user doesn't know
> about it unless it does an fsync after that writeback, which will
> report the error via filemap_check_wb_err().
>=20
>> We either:
>> - reserve data space
>>   Then no matter how it ends, we're OK, although it may end as CoW.
>>
>> - Failed to reserve data space
>>   Writeback will be triggered anyway, no way to screw things around.
>>
>> Thus this workaround has nothing to fix, but only make certain NODATAC=
OW
>> reach disk as NODATACOW.
>>
>> It makes some NODATACOW behaves more correctly but won't fix any obvio=
us
>> bug.
>>
>> My personal take is to fix any strange behavior even it won't cause an=
y
>> problem, but the full inode writeback can be performance heavy.
>>
>> So my question is, do we really need this anyway?
>=20
> Do we need what? Your patch, that logic at
> btrfs_alloc_data_chunk_ondemand(), something else?

I meant the patch, but the deeper I dig into the problem, more problem I
found.

The patch is still needed, but there is a more important bug, that
btrfs_run_delalloc_range() failure won't be reported in sync.

The script here I'm using is:
------
#!/bin/bash

dev=3D/dev/test/test
mnt=3D/mnt/btrfs

#mkfs.btrfs -f $dev -b 1G > /dev/null
#mount $dev $mnt -o nospace_cache

umount $mnt &> /dev/null
umount $dev &> /dev/null

dmesg -C
mkfs.btrfs -f $dev -b 512M > /dev/null

mount $dev $mnt -o nospace_cache

xfs_io -f -c "falloc 8k 64m" $mnt/file1
xfs_io -f -c "pwrite 0 -b 4k 370M" $mnt/padding

sync
btrfs fi df $mnt --raw

xfs_io -c "pwrite 1m 16m" $mnt/file1
echo "nodatacow write finished" >> /dev/kmsg
xfs_io -c "reflink $mnt/file1 8k 0 4k" $mnt/file1
echo "reflink finished" >> /dev/kmsg
sync
echo "sync finished ret=3D$?" >> /dev/kmsg
umount $dev
------

As describe, the last write at 17821696 (17M - 4K) will fail due to ENOSP=
C.
But the sync succeeded without reporting any problem.

Thanks,
Qu

>=20
> Thanks.
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>>> I don't recall starting transactions when running dealloc, and fail=
ed
>>>>> to see where after a quick glance to cow_file_range()
>>>>> and run_delalloc_nocow(). I'm assuming that 'at delalloc time' mean=
s
>>>>> when starting writeback.
>>>>>
>>>>>>
>>>>>> [CAUSE]
>>>>>> This is due to the fact that btrfs can only do extent level share =
check.
>>>>>>
>>>>>> Btrfs can only tell if an extent is shared, no matter if only part=
 of the
>>>>>> extent is shared or not.
>>>>>>
>>>>>> So for above script we have:
>>>>>> - fallocate
>>>>>> - buffered write
>>>>>>   If we don't have enough data space, we fall back to NOCOW check.=

>>>>>>   At this timming, the extent is not shared, we can skip data
>>>>>>   reservation.
>>>>>
>>>>> But in the above example we don't fall to nocow mode when doing the=

>>>>> buffered write, as there's plenty of data space available (1Gb -
>>>>> 24Kb).
>>>>> You need to update the example.
>>>> I have to admit that the core part is mostly based on the worst case=

>>>> *assumption*.
>>>>
>>>> I'll try to make the case convincing by making it fail directly.
>>>
>>> Great, thanks.
>>>
>>>>
>>>>>
>>>>>
>>>>>> - reflink
>>>>>>   Now part of the large preallocated extent is shared.
>>>>>> - delalloc kicks in
>>>>>
>>>>> writeback kicks in
>>>>>
>>>>>>   For the NOCOW range, as the preallocated extent is shared, we ne=
ed
>>>>>>   to fall back to COW.
>>>>>>
>>>>>> [WORKAROUND]
>>>>>> The workaround is to ensure any buffered write in the related exte=
nts
>>>>>> (not the reflink source range) get flushed before reflink.
>>>>>
>>>>> not the reflink source range -> not just the reflink source range
>>>>>
>>>>>>
>>>>>> However it's pretty expensive to do a comprehensive check.
>>>>>> In the reproducer, the reflink source is just a part of a larger
>>>>>
>>>>> Again, the reproducer needs to be fixed (yes, I tested it even if i=
t's
>>>>> clear by looking at it that it doesn't trigger the nocow case).
>>>>>
>>>>>> preallocated extent, we need to flush all buffered write of that e=
xtent
>>>>>> before reflink.
>>>>>> Such backward search can be complex and we may not get much benefi=
t from
>>>>>> it.
>>>>>>
>>>>>> So this patch will just try to flush the whole inode before reflin=
k.
>>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>>>> Reason for RFC:
>>>>>> Flushing an inode just because it's a reflink source is definitely=

>>>>>> overkilling, but I don't have any better way to handle it.
>>>>>>
>>>>>> Any comment on this is welcomed.
>>>>>> ---
>>>>>>  fs/btrfs/ioctl.c | 22 ++++++++++++++++++++++
>>>>>>  1 file changed, 22 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>>> index 7755b503b348..8caa0edb6fbf 100644
>>>>>> --- a/fs/btrfs/ioctl.c
>>>>>> +++ b/fs/btrfs/ioctl.c
>>>>>> @@ -3930,6 +3930,28 @@ static noinline int btrfs_clone_files(struc=
t file *file, struct file *file_src,
>>>>>>                         return ret;
>>>>>>         }
>>>>>>
>>>>>> +       /*
>>>>>> +        * Workaround to make sure NOCOW buffered write reach disk=
 as NOCOW.
>>>>>> +        *
>>>>>> +        * Due to the limit of btrfs extent tree design, we can on=
ly have
>>>>>> +        * extent level share view. Any part of an extent is share=
d then the
>>>>>
>>>>> Any -> If any
>>>>>
>>>>>> +        * whole extent is shared and any write into that extent n=
eeds to fall
>>>>>
>>>>> is -> is considered
>>>>>
>>>>>> +        * back to COW.
>>>>>
>>>>> I would add, something like:
>>>>>
>>>>> That is, btrfs' back references do not have a block level granulari=
ty,
>>>>> they work at the whole extent level.
>>>>>
>>>>>> +        *
>>>>>> +        * NOCOW buffered write without data space reserved could =
to lead to
>>>>>> +        * either data space bytes_may_use underflow (kernel warni=
ng) or ENOSPC
>>>>>> +        * at delalloc time (transaction abort).
>>>>>
>>>>> I would omit the warning and transaction abort parts, that can chan=
ge
>>>>> any time. And we have that information in the changelog, so it's no=
t
>>>>> lost.
>>>>>
>>>>>> +        *
>>>>>> +        * Here we take a shortcut by flush the whole inode. We co=
uld do better
>>>>>> +        * by finding all extents in that range and flush the spac=
e referring
>>>>>> +        * all those extents.
>>>>>> +        * But that's too complex for such corner case.
>>>>>> +        */
>>>>>> +       filemap_flush(src->i_mapping);
>>>>>> +       if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
>>>>>> +                    &BTRFS_I(src)->runtime_flags))
>>>>>> +               filemap_flush(src->i_mapping);
>>>>>
>>>>> So a few comments here:
>>>>>
>>>>> - why just in the clone part? The dedupe side has the same problem,=
 doesn't it?
>>>>
>>>> Right.
>>>>
>>>>>
>>>>> - I would move such flushing to btrfs_remap_file_range_prep - this =
is
>>>>> where we do the source and target range flush and wait.
>>>>>
>>>>> Can you turn the reproducer into an fstests case?
>>>>
>>>> Sure.
>>>>
>>>> Thanks for the info and all the comment,
>>>> Qu
>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>>> +
>>>>>>         /*
>>>>>>          * Lock destination range to serialize with concurrent rea=
dpages() and
>>>>>>          * source range to serialize with relocation.
>>>>>> --
>>>>>> 2.21.0
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
>=20
>=20


--iTQ6pMcvTYDbFcA3H3zLjvVek6aFn9vqV--

--Sh0Fbj4uAT5HJ3cn3Ep2j94Ravm0O7yAY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzRaGMACgkQwj2R86El
/qj7Cwf+KPxRd+OAJ7ybVYZW5HGFbE3oKwKozJc/2/vzGaOY1o7oGDKgtc0qk2vO
HfRj3voCVTGg8Avu9/8pO+QLD1LFgW4XpGRzVD13VkVgwT5Ir0+U8DjaLt4i0L9c
Apm9KorA2sPnmFKDqPBys6Lqj1crjaD2axNY58HL9wVKDOES2swUC9dShTM1NVYs
EXo2YN6ZW8J0lqtXzz2nctmMuOYfeWuLoMfNinRve5U3ZIh7e7mifgcTlqWk0SH9
zElzhkEGZKq8unbZyICXcP+HaoTQJwaxPBmu4R1TV7i6l2GhgPnVjZdr5r2V8IjR
Lrla2e99Dza1zIa7tFCimGfjS9XqdQ==
=coc/
-----END PGP SIGNATURE-----

--Sh0Fbj4uAT5HJ3cn3Ep2j94Ravm0O7yAY--
