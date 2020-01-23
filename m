Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97D14694E
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 14:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgAWNji (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 08:39:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:42811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgAWNji (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 08:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579786769;
        bh=4q+/im4TwIso08J5WX43G2zSuMQaIL3fCOo6H8ef29U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ByIoMOLjcaDbbRLzu9wm0Gl5jeG5HJoxZ88Ys+l4EAzYR6WDO+SIlCoQ4KnusKzXK
         d0RRJZoQN4zocPBvhv7hnfAKBGJmdBBvzTeNSkwE7xnadC/DXnV4W0qrVpbZdIFb7S
         Uirs4bwnzQqgu2NrPkj/Lfl3asqd9MyNvOJbz+nk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWics-1j5gPg1y2K-00X7iN; Thu, 23
 Jan 2020 14:39:29 +0100
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200123073759.23535-1-wqu@suse.com>
 <CAL3q7H4ed9PtALC_xjPeaiKDDhAN1oNzgM0yd=buF_C5r+x7wA@mail.gmail.com>
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
Message-ID: <f32340f7-7e0c-e6fe-3122-4d8e8cab9257@gmx.com>
Date:   Thu, 23 Jan 2020 21:39:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4ed9PtALC_xjPeaiKDDhAN1oNzgM0yd=buF_C5r+x7wA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PD2UYiDnvNhm6SONxRsYPX7e8FKZxQiNa"
X-Provags-ID: V03:K1:huxIpfGrbrryJNDsggPuPpVZQ0+jvC8hynJjsJHzvL9ciRWKsvK
 Uc70RTFJy/rRmBM6zjVy+CZZ3uiXM0p5qlSPiKyjTR63dvZAAASxyA1+wqItvllwBPFZhu+
 hrnovO0uV9nczodbxNsizWel2xeNoZ+4XtX2XB3acvPjBTKwGlR4nGG54d6BBKS2fkOPUpw
 dE/H0QIznjzDDbDELbu0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UXFYSZ+gqkE=:YCIqJ02t78pdE5Tqa5CRVE
 Rxj1bUDgrJF3BcCaAB5ru9f89BDef1bTi4mvvYkYLYxBg5LirvzbkfvB0Np42mk2U1L4kBVrK
 xr8bKsGYP23PcDcAhVyoAelFNl2Mk1vE/JSUqFzpJjUqlX2yXj6Mgb/KjbGjcBW+/oYgRHNux
 EuZlexA2iP/Y9n2vEw7BB29YB8uWjWn1s7bRjmJ9i9+WqB2nxe9aQt+sJfewQ+71SLzGkQqhl
 /ZM2KMAbPQsU8Hz+LmxAy1tE9Xtp6T8KNPR+xbnkVQf4KtSqk8YcHRzcxDifFff5r2ZKXiXs3
 92E6aDV1zy9J4PkHVwxqgWYQ97Kz690U77os45kkA4KSKZmDGCvjxYLpK9wENyqpqCrBgMzt3
 YcDF17J7nM0FB4rv2SVNTAwq0et/5uPg9Xlij+lJmUXDS5wHc4hUdyfyIDegA5k1vo3Th9o9u
 1Ud965wxiObam7o44bc5eflE10E85rL6az97Qm1FUQoNVWZ1hkCxz7At9uv1dLqsiyj7NHxtP
 VjNx/C3DdZlQ/grLBGOhhDw8DMX0h7CN9QmM68vHJ8n1M2+J7b/Gx/ati2S5aZfKpQzPSbnk+
 /kBAVaLxeV+YiOTX35zK0QxBqeXaYGq7r0bwK18am3rCRbZhWfYh9VAEb71DrNZrKsQfHqQyW
 N17K7/lss7pOGCGJ8/1cxw8v44e5x60TontIWUMNQQchlPDVz0g7PlQfQp447PcFqbd1we+DF
 Kp8/ZnmTIX+iGciBvQjZn7N9sc4rd5DNBBMqhOmMgXqSba+IpL3jgPy2mXG25d4jyia1vroLc
 8vywbF3Ih8SqlGqOIiJIFvOPpy7mVN4y3O0TlmKNEu/+9grDpzsm+czl55T9UINkvctCbiTVw
 HjDhgMdGtQmUQ0kHN4r56kSVK72Zz2uMOFS7Jo3Nn5VPExOBK4gbHBfSXXwEkYYYtFAPUnElO
 mfmKcISPPWFtIzE+tEb1M2OH2VeTDLi536YYXbnix9O1c6KxGa2XqqrdEVI5jinwAte5YbViH
 eM3Zm051caiMpTNentNrl48iiNQ1LbCYGyFJ7JbnAFKuyA5it1LZ/IwcMNHEk5l3UfZ8giWn+
 15wulTbBrmjTgtr7rrUmqAbVI2ZwJ3yuqv2Ru6UjhZd0xR2DTkySccCEg4sB1cyKGJHhRcmyT
 NLm5VVQMS3jvXymkOl2KkUArCOqb5FT1p7ctHlLfAYFO3Dv4o1ebNaG4pyHYbxN3kkdEIQraM
 4IRCeMSpMImEwIY8V
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PD2UYiDnvNhm6SONxRsYPX7e8FKZxQiNa
Content-Type: multipart/mixed; boundary="NTC6oFAAMBcqNTECbGAo16taHergNepLm"

--NTC6oFAAMBcqNTECbGAo16taHergNepLm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/23 =E4=B8=8B=E5=8D=888:06, Filipe Manana wrote:
> On Thu, Jan 23, 2020 at 7:38 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> For dev-replace test cases with fsstress, like btrfs/06[45] btrfs/071,=

>> looped runs can lead to random failure, where scrub finds csum error.
>>
>> The possibility is not high, around 1/20 to 1/100, but it's causing da=
ta
>> corruption.
>>
>> The bug is observable after commit b12de52896c0 ("btrfs: scrub: Don't
>> check free space before marking a block group RO")
>>
>> [CAUSE]
>> Dev-replace has two source of writes:
>> - Write duplication
>>   All writes to source device will also be duplicated to target device=
=2E
>>
>>   Content:      Latest data/meta
>=20
> I find the term "latest" a bit confusing, perhaps "not yet persisted
> data and metadata" is more clear.
>=20
>>
>> - Scrub copy
>>   Dev-replace reused scrub code to iterate through existing extents, a=
nd
>>   copy the verified data to target device.
>>
>>   Content:      Data/meta in commit root
>=20
> And so here "previously persisted data and metadata".
>=20
>>
>> The difference in contents makes the following race possible:
>>         Regular Writer          |       Dev-replace
>> -----------------------------------------------------------------
>>   ^                             |
>>   | Preallocate one data extent |
>>   | at bytenr X, len 1M         |
>>   v                             |
>>   ^ Commit transaction          |
>>   | Now extent [X, X+1M) is in  |
>>   v commit root                 |
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Dev replace st=
arts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>                                 | ^
>>                                 | | Scrub extent [X, X+1M)
>>                                 | | Read [X, X+1M)
>>                                 | | (The content are mostly garbage
>>                                 | |  since it's preallocated)
>>   ^                             | v
>>   | Write back happens for      |
>>   | extent [X, X+512K)          |
>>   | New data writes to both     |
>>   | source and target dev.      |
>>   v                             |
>>                                 | ^
>>                                 | | Scrub writes back extent [X, X+1M)=

>>                                 | | to target device.
>>                                 | | This will over write the new data =
in
>>                                 | | [X, X+512K)
>>                                 | v
>>
>> This race can only happen for nocow writes. Thus metadata and data cow=

>> writes are safe, as COW will never overwrite extents of previous trans=

>> (in commit root).
>>
>> This behavior can be confirmed by disabling all fallocate related call=
s
>> in fsstress (*), then all related tests can pass a 2000 run loop.
>>
>> *: FSSTRESS_AVOID=3D"-f fallocate=3D0 -f allocsp=3D0 -f zero=3D0 -f in=
sert=3D0 \
>>                    -f collapse=3D0 -f punch=3D0 -f resvsp=3D0"
>>    I didn't expect resvsp ioctl will fallback to fallocate in VFS...
>>
>> [FIX]
>> Make dev-replace to require mandatory block group RO, and wait for cur=
rent
>> nocow writes before calling scrub_chunk().
>>
>> This patch will mostly revert commit 76a8efa171bf ("btrfs: Continue re=
place
>> when set_block_ro failed") for dev-replace path.
>>
>> ENOSPC for dev-replace is still much better than data corruption.
>=20
> Technically if we flag the block group RO without being able to
> persist that due to ENOSPC, it's still ok.
> We just want to prevent nocow writes racing with scrub copying
> procedure. But that's something for some other time, and this is fine
> to me.
>=20
>>
>> Reported-by: Filipe Manana <fdmanana@suse.com>
>> Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed=
")
>> Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before mark=
ing a block group RO")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> RFC->v1:
>> - Remove the RFC tag
>>   Since the cause is pinned and verified, no need for RFC.
>>
>> - Only wait for nocow writes for dev-replace
>>   CoW writes are safe as they will never overwrite extents in commit
>>   root.
>>
>> - Put the wait call into proper lock context
>>   Previous wait happens after scrub_pause_off(), which can cause
>>   deadlock where we may need to commit transaction in one of the
>>   wait calls. But since we are in scrub_pause_off() environment,
>>   transaction commit will wait us to continue, causing a wait-on-self
>>   deadlock.
>> ---
>>  fs/btrfs/scrub.c | 30 +++++++++++++++++++++++++-----
>>  1 file changed, 25 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 21de630b0730..5aa486cad298 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -3577,17 +3577,27 @@ int scrub_enumerate_chunks(struct scrub_ctx *s=
ctx,
>>                  * This can easily boost the amount of SYSTEM chunks i=
f cleaner
>>                  * thread can't be triggered fast enough, and use up a=
ll space
>>                  * of btrfs_super_block::sys_chunk_array
>> +                *
>> +                * While for dev replace, we need to try our best to m=
ark block
>> +                * group RO, to prevent race between:
>> +                * - Write duplication
>> +                *   Contains latest data
>> +                * - Scrub copy
>> +                *   Contains data from commit tree
>> +                *
>> +                * If target block group is not marked RO, nocow write=
s can
>> +                * be overwritten by scrub copy, causing data corrupti=
on.
>> +                * So for dev-replace, it's not allowed to continue if=
 a block
>> +                * group is not RO.
>>                  */
>> -               ret =3D btrfs_inc_block_group_ro(cache, false);
>> -               scrub_pause_off(fs_info);
>> -
>> +               ret =3D btrfs_inc_block_group_ro(cache, sctx->is_dev_r=
eplace);
>>                 if (ret =3D=3D 0) {
>>                         ro_set =3D 1;
>> -               } else if (ret =3D=3D -ENOSPC) {
>> +               } else if (ret =3D=3D -ENOSPC && !sctx->is_dev_replace=
) {
>>                         /*
>>                          * btrfs_inc_block_group_ro return -ENOSPC whe=
n it
>>                          * failed in creating new chunk for metadata.
>> -                        * It is not a problem for scrub/replace, beca=
use
>> +                        * It is not a problem for scrub, because
>>                          * metadata are always cowed, and our scrub pa=
used
>>                          * commit_transactions.
>>                          */
>> @@ -3596,9 +3606,19 @@ int scrub_enumerate_chunks(struct scrub_ctx *sc=
tx,
>>                         btrfs_warn(fs_info,
>>                                    "failed setting block group ro: %d"=
, ret);
>>                         btrfs_put_block_group(cache);
>> +                       scrub_pause_off(fs_info);
>>                         break;
>>                 }
>>
>> +               /*
>> +                * Now the target block is marked RO, wait for nocow w=
rites to
>> +                * finish before dev-replace.
>> +                * COW is fine, as COW never overwrites extents in com=
mit tree.
>> +                */
>> +               if (sctx->is_dev_replace)
>> +                       btrfs_wait_nocow_writers(cache);
>=20
> So this only waits for nocow ordered extents to be created - it
> doesn't wait for them to complete.

Wait for minute.

This btrfs_wait_nocow_writers() is not just triggering ordered extents
for nocow.
It waits for the nocow_writers count decreased to 0 for that block group.=


Since we have already marked the block group RO, no new nocow writers
can happen, thus that counter can only decrease, no way to increase.

There are several cases involved:
- NoCOW Write back happens before bg RO
  It will increase cache->nocow_writers counter, and decrease the
  counter after finish_oredered_io().
  btrfs_wait_nocow_writers() will wait for such writes

- Writeback happens after bg RO
  Then the write will fallback to COW.

- Writeback happens after bg RO cleared (reverted back to RW)
  No need to bother at all.

Thus this should be enough, no need for btrfs_wait_ordered_roots().

Thanks,
Qu


> After that you still need to call:
>=20
> btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length)=
;
>=20
> Other than that, looks good to me.
>=20
> Thanks.
>=20
>> +
>> +               scrub_pause_off(fs_info);
>>                 down_write(&dev_replace->rwsem);
>>                 dev_replace->cursor_right =3D found_key.offset + lengt=
h;
>>                 dev_replace->cursor_left =3D found_key.offset;
>> --
>> 2.25.0
>>
>=20
>=20


--NTC6oFAAMBcqNTECbGAo16taHergNepLm--

--PD2UYiDnvNhm6SONxRsYPX7e8FKZxQiNa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4pogsACgkQwj2R86El
/qhM/QgApVpO4phf3fExYkP117qgWRAU66v8bWjO2r2ygT1zM+zJzwkggyxIB4OG
9J5oDxfzf1eArXs7M1I0bWi5OhSgZHmYs9X8PIMe2OjFPggMFBsTuKmAzHZLQsYv
3OY5Li/zfGMCbs2XbTrMuk36BvDI0Si55pqPnGXZQV1bW/uZIPTSWXPJh5JZ8SMR
Ql8bawkWiSzkuiYGwz++uxcWMeiu00A1XcqQmFBnDzMJwK21pKS4vT6xReAlBwMy
jmHw1hEhZQoDSdUK24qrC57Wx4J3mzsuEZU0vzuGo4m1PqG0WP2r6YsZbs+EYZgo
kvAvf1SLQHDiJ9+dFgu6dMjSU17czQ==
=zVfk
-----END PGP SIGNATURE-----

--PD2UYiDnvNhm6SONxRsYPX7e8FKZxQiNa--
