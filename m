Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E1D12B5C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfECKSn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 06:18:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:51143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfECKSm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 May 2019 06:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556878713;
        bh=yCNppPy4AbE2psqB4jWcfLMAi69zoV79BNOs3j8lFr4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=E+aJGyiRU4RrScglBoh5sXbLO3fb7TS5Ad3vJPIQ3cszChLvKj1pyxYqR7HVbGST3
         NupJ7hguQO4oPojtGPtNlJBej1fDymGWKPmjNBFFkEiDDHX3VS35saznOwGzj2S65C
         t0WXgjNwujenF6GQjDLMjoq++02+Nn7HnadWO4NQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([52.197.165.36]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhU5R-1gseUn3VHH-00ee5A; Fri, 03
 May 2019 12:18:33 +0200
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190503010852.10342-1-wqu@suse.com>
 <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
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
Message-ID: <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com>
Date:   Fri, 3 May 2019 18:18:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cfPM0Sp2lVhanyEGh2VJwkQ7XpBOFuhJH"
X-Provags-ID: V03:K1:YOoE9XYFk23f9HDdidzUI67Y17Geam4diCzJE6DIWbZefGvy8DR
 pq0KZSQGBSk/I72UCe1rkiSP9qoNT88Apotqp3qAZiUPbjRLoaEzxLRRBj7w2NUFKLtmLFY
 T81uNdWXgYe6av5mkO1d/CfbtNWyPGOKPWJ9YXcAhZFgxB1c2egcDUVNh8aVZQw0D4FkSyx
 lAYfoQRnNJBu5VPR8eOLA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:stA0UjbShhc=:ry5BCCKlSvz8PGu2t077Ww
 lZPv0kEAaEG9QEvnIksyrJTM9QgQ9PgxgzxwtHb+iECrW3Y45frUI94MwkRzL2phj+S2kb8jx
 bdFErHcfh4O/kO54RU0cH/x4QZzoCvSCcxvqe9u3F//DYqhbOexaakEojueJKiG1bgawdXdeF
 PM7btPWzx2Pd8WiRzLDbxoXdPP0u1rv4LJf95v1IKZxDCzN3pGps7nXi/0wrL6FyfC1MGEjre
 t5jqMUPh/xXZ2u2zN11YEnrI3fVozgRrpr2yH3rq+xXjayM64tuGkks8azV/AVOYAo71w0/Bc
 C0Zg9vQNJBHZok4rf2Y5ljJZg6KXrsBqEupY4QZml/UsFXSEpqPTpaiefW7zJOQjx4cqBmcLd
 pkuByOXDxDSfj04TTxLKqLpoeQS2bNjq9jolrJFeKnlNEdJzJQQGeJHUca9mDO/I+7DW2w1JE
 1UhGMa/Bh78ah4ct2xPVcwmZTGDo2z1Gfys0nsFqZS8yZTbT0ygDdjnJmkF4QSigLyIAyDteu
 fnxb2EZTYK820+J3atigx1mzLSwoQsTuY0Hy/xeraQN3C4aGwxZb8wn8etRQLV7JGvpVFDSYX
 epFmEP/F3s86pID1MQYdlaF3X2A5xr0YSyvEcg+g83svNlkcqo4+tkYrxg/MjT2uQtg6wPPhA
 T+F3v6cimGfxBo0eXjynULhjG6kxi9B0k9oTcwMyMwpEcI2AjnphiiRf441N8M6OlE99Unla6
 wzYfnpXjK4npvYFILl9GO+suY/y4DWY3HUI7C5v2vb8u5JvrOqn0IfUWlsuOItFE9vEuCUTNQ
 qfrwgpq4CMKBhU7tQ6YplcEYAJEsNvuR45hiIkyZkB8ZrSaOXTFxi5ck4wsr40IbjMPaOgCR+
 shFUSIGRPBiqQHxGxCBl+CmKdp1UoEQEwAu22JPb1H/VO8N1hi6Q/t1C8/6LOp
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cfPM0Sp2lVhanyEGh2VJwkQ7XpBOFuhJH
Content-Type: multipart/mixed; boundary="eDS6y53YNaQPziYvu6xGvs0buDvnEA7P3";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1e36e9e2-dbd3-3ab0-b908-25cfdf1d310d@gmx.com>
Subject: Re: [PATCH RFC] btrfs: reflink: Flush before reflink any extent to
 prevent NOCOW write falling back to CoW without data reservation
References: <20190503010852.10342-1-wqu@suse.com>
 <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>
In-Reply-To: <CAL3q7H5uLiPzCQpLdM=4yjz+fA-mQAe_XP1=5fHQ83dyBwcK5w@mail.gmail.com>

--eDS6y53YNaQPziYvu6xGvs0buDvnEA7P3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/3 =E4=B8=8B=E5=8D=885:21, Filipe Manana wrote:
> On Fri, May 3, 2019 at 2:46 AM Qu Wenruo <wqu@suse.com> wrote:
>=20
> What a great subject. The "reflink:" part is unnecessary, since the
> rest of the subject already mentions it, that makes it a bit shorter.
>=20
>>
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
>>         item 7 key (257 EXTENT_DATA 4096) itemoff 15760 itemsize 53
>>                 generation 6 type 2 (prealloc)
>>                 prealloc data disk byte 13631488 nr 28672
>>         item 8 key (257 EXTENT_DATA 12288) itemoff 15707 itemsize 53
>>                 generation 6 type 1 (regular)
>>                 extent data disk byte 13660160 nr 12288 <<< COW
>>         item 9 key (257 EXTENT_DATA 24576) itemoff 15654 itemsize 53
>>                 generation 6 type 2 (prealloc)
>>                 prealloc data disk byte 13631488 nr 28672
>>
>> Currently we always reserve space even for NOCOW buffered write, thus
>=20
> I would add 'data' between 'reserve' and 'space', to be clear.
>=20
>> under most case it shouldn't cause anything wrong even we fall back to=

>> COW.
>=20
> even we ... -> even if we fallback to COW when running delalloc /
> starting writeback.
>=20
>>
>> However when we're out of data space, we fall back to skip data space =
if
>> we can do NOCOW write.
>=20
> we fall back to skip data space ... -> we fallback to NOCOW write
> without reserving data space.
>=20
>>
>> If such behavior happens under that case, we could hit the following
>> problems:
>=20
>> - data space bytes_may_use underflow
>>   This will cause kernel warning.
>=20
> Ok.
>=20
>>
>> - ENOSPC at delalloc time
>=20
> at delalloc time - that is an ambiguous term you use through the change=
 log.

In fact, I have a lot of uncertain terminology through kernel.

Things like flush get referred multiple times in different context (e.g.
filemap flush, flushoncommit, super block flush).

If we have a terminology list, we can't be more happy to follow.

> You mean when running/starting delalloc, which happens when starting wr=
iteback,
> but that could be confused with creating delalloc, which happens
> during the buffered write path.

Another confusion due to different terminology.

My understanding of the write path is:
buffered write -> delalloc (start delalloc) -> ordered extent -> finish
ordered io.

Thus I missed the delalloc creating part.

>=20
> So I would always replace 'dealloc time' with 'when running delalloc'
> (or when starting writeback).

I will change use running delalloc, with extra comment reference to the
function name (btrfs_run_delalloc_range()).

>=20
>>   This will lead to transaction abort and fs forced to RO.
>=20
> Where does that happen exactly?
My bad, I got confused with metadata writeback path.

For data writeback, it should only cause sync related failure.

> I don't recall starting transactions when running dealloc, and failed
> to see where after a quick glance to cow_file_range()
> and run_delalloc_nocow(). I'm assuming that 'at delalloc time' means
> when starting writeback.
>=20
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
>=20
> But in the above example we don't fall to nocow mode when doing the
> buffered write, as there's plenty of data space available (1Gb -
> 24Kb).
> You need to update the example.
I have to admit that the core part is mostly based on the worst case
*assumption*.

I'll try to make the case convincing by making it fail directly.

>=20
>=20
>> - reflink
>>   Now part of the large preallocated extent is shared.
>> - delalloc kicks in
>=20
> writeback kicks in
>=20
>>   For the NOCOW range, as the preallocated extent is shared, we need
>>   to fall back to COW.
>>
>> [WORKAROUND]
>> The workaround is to ensure any buffered write in the related extents
>> (not the reflink source range) get flushed before reflink.
>=20
> not the reflink source range -> not just the reflink source range
>=20
>>
>> However it's pretty expensive to do a comprehensive check.
>> In the reproducer, the reflink source is just a part of a larger
>=20
> Again, the reproducer needs to be fixed (yes, I tested it even if it's
> clear by looking at it that it doesn't trigger the nocow case).
>=20
>> preallocated extent, we need to flush all buffered write of that exten=
t
>> before reflink.
>> Such backward search can be complex and we may not get much benefit fr=
om
>> it.
>>
>> So this patch will just try to flush the whole inode before reflink.
>=20
>=20
>>
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
>>                         return ret;
>>         }
>>
>> +       /*
>> +        * Workaround to make sure NOCOW buffered write reach disk as =
NOCOW.
>> +        *
>> +        * Due to the limit of btrfs extent tree design, we can only h=
ave
>> +        * extent level share view. Any part of an extent is shared th=
en the
>=20
> Any -> If any
>=20
>> +        * whole extent is shared and any write into that extent needs=
 to fall
>=20
> is -> is considered
>=20
>> +        * back to COW.
>=20
> I would add, something like:
>=20
> That is, btrfs' back references do not have a block level granularity,
> they work at the whole extent level.
>=20
>> +        *
>> +        * NOCOW buffered write without data space reserved could to l=
ead to
>> +        * either data space bytes_may_use underflow (kernel warning) =
or ENOSPC
>> +        * at delalloc time (transaction abort).
>=20
> I would omit the warning and transaction abort parts, that can change
> any time. And we have that information in the changelog, so it's not
> lost.
>=20
>> +        *
>> +        * Here we take a shortcut by flush the whole inode. We could =
do better
>> +        * by finding all extents in that range and flush the space re=
ferring
>> +        * all those extents.
>> +        * But that's too complex for such corner case.
>> +        */
>> +       filemap_flush(src->i_mapping);
>> +       if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
>> +                    &BTRFS_I(src)->runtime_flags))
>> +               filemap_flush(src->i_mapping);
>=20
> So a few comments here:
>=20
> - why just in the clone part? The dedupe side has the same problem, doe=
sn't it?

Right.

>=20
> - I would move such flushing to btrfs_remap_file_range_prep - this is
> where we do the source and target range flush and wait.
>=20
> Can you turn the reproducer into an fstests case?

Sure.

Thanks for the info and all the comment,
Qu

>=20
> Thanks.
>=20
>> +
>>         /*
>>          * Lock destination range to serialize with concurrent readpag=
es() and
>>          * source range to serialize with relocation.
>> --
>> 2.21.0
>>
>=20
>=20


--eDS6y53YNaQPziYvu6xGvs0buDvnEA7P3--

--cfPM0Sp2lVhanyEGh2VJwkQ7XpBOFuhJH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzMFXAACgkQwj2R86El
/qh9Ygf+IYERu/lQlY8cGG8tLshuzjHtkCYlM9nnKcmdy6O0JwCnUs1B5gHdZFue
ctlI5LdcLZGUnUYSnpOjlannNo8S1bRhtWVsHRO4LMIRtXLezkcqS+RTQntmVEgq
HiO4l0ONhaW8jVy2LcGvEdITfwiMzR+IV9G0+cf2CL1gKMDVuJ0+MyuZMh7CqS9m
+Hw4gm6aurUXPiLaTxKZcP0dypyXCAfmEWdpVK9GAumrEdMgEgSYAgDAeBdc1tVn
UbdkxXx3wiVyeupeInHL59xlxuK4vqOtAWauvzK3xuUCJwBdcGdVsOeTMacKmVNz
iVEvSnR9wg8XsxfSKwC0uGpHqjE0Wg==
=Ui/q
-----END PGP SIGNATURE-----

--cfPM0Sp2lVhanyEGh2VJwkQ7XpBOFuhJH--
