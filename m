Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B206CD6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 13:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfGRLfd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jul 2019 07:35:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:46995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbfGRLfd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jul 2019 07:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563449724;
        bh=QPsHrtl7F2z4pYb2U5TeE06DnAKVEqWC15uohGj3K84=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=X6aZRCz6QFEfXftfjRFVDzeC7gKY3bPTJXyFN5SKUT1tjaUNW1yyfZzoGDdWhpwAV
         n7ldSaI82yBF8CySzHFc3iUfAiBVDOdCWJbEkCNt3Un6QIKzhkh0pWtKg88xJrcESo
         salqDtpqk8X7Kl3MkX6ZnGIuMQg9xv4lTgsCbIV4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M5HZD-1iee2f3S2B-00zW7W; Thu, 18
 Jul 2019 13:35:23 +0200
Subject: Re: [PATCH] btrfs: Remove the duplicated and sometimes too cautious
 btrfs_can_relocate()
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190718054857.8970-1-wqu@suse.com>
 <CAL3q7H5H1BV92bZBv4SmuZ2-c99wOwJz8T8b5MFWV76YvCzmCw@mail.gmail.com>
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
Message-ID: <34ae1f97-e3c2-d823-b0c3-f72b7a9b67dd@gmx.com>
Date:   Thu, 18 Jul 2019 19:35:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5H1BV92bZBv4SmuZ2-c99wOwJz8T8b5MFWV76YvCzmCw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OY5bYjgWOTdEr0HriyrCeh43JCMDDNhhS"
X-Provags-ID: V03:K1:Bb1xmTiQa+4GIcd4YrlO09G1e7iZYYpgU2VIv7RCp29l7rTK3OF
 2OoCWgXvbqA/w202RkkdbOGWFmrsB/efdl+LTeU5uAUcCT5Czkmf0i5Nd1NBpbePI/YmF1g
 M+0DsJglmfoipd7k2s8+u6BSOd3z3CPh9zJCNVWDXMEwZhK/ZSZ9LZGdIBEpWOmkWR99sja
 JuO6f2uUUpraOV0rXXOZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RRvxuKdmNJ8=:C4kjJ7v6Wdcl3fh7KVYWMa
 lxzq28Iw527u/CJZl/aoEStr4A69iIzo7EzNsnoXmrTUwruQJVVeOabcjmm7FtJCpYn7uxrma
 5oaPLBZPeVHV8KbelNzafx2/TVcTs4QtFB24ret/5avr2XI6qD1DLjc6JlzLJlBUFU4jbVJtH
 KV1thc7L/C7/6DhsL4HU+/3qYRouv5RoeJ75qZQKi0gSQQ96QO2ESarNJpAdgN+g7ePVbeGOq
 e/htmAnPTNyvmH1ulf1/bDeIVutfiq2ES66tYvM75LqZ/m7OWAKepwa3mrXZK5mO3QW3Nn95M
 jQ/QYTHOt+Ig1D083ZwOAVm5x8Wy8ZUZrPjdTbqM5aN9Ctq14k2HT78LM5K5nYEx2skWGOfro
 ys3eYc+8h8SiN8+RHRE5bwI4b/wdAyKVPq55KUmbwXAELdhNq0DkU/SwAt65DvcmSw8ddzG21
 qBlmMWzAKV1Q2394FQTh7yQyQ8uGpHmXjf3iGkxMagK7091mSXVBRAzGO2BiAwakdRhNKrMRL
 7+xfKf0QNA+qIT/ViJWowXuTtIsP04+6OoGKib4Rgs5kHSCp3YWm9BlDhZLHwG+CfJuQomgev
 cAzsJdWu/67LS5k3CxdKXjiagnnjDoVgz2WRx4GFuqzjfnwM/3i/8Z7vE3U4AxepCUHwCPMbm
 DOo0IIMmd/rj1In6TzUliC3+N4jj2Fw+z3O/VHcAlDUoH0o7WoUtZGgBtsAPlbB8Wi64pmsoB
 PeuR4Q2gs16DKiCWuz75uS9ECwpG159l7Sbi8Em1pf+RRZgIKqd1MD3r7Y+EiV2NEbRODyXsW
 KC84gEMwfN9uZvZX3BSfAjGlkuA45T2irFceVQCE+E+2ylRADQqGx9oD0dwuUGY6lnTPOboF0
 t056m7OJHdpSCa5p8GsQIVcqR1GUTviplUSNXwv/SXhB22LP9+fxQGtYcLRPZtxmqaC+qZIuf
 xZs6NTTBwgBjiN0ja2fwY7Usxj48GaL7zaPKyMrxDKfvCM/ZPb2C5BbTLAjIKJeEmyIuI66JE
 O9bkOsY9LAWNiarLBda527qj/X33RsuY7kch0rBtdV8aA6gcYc3xWOrGFpI95AyyccfhzyC3u
 Ol1akobGo1hq6w=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OY5bYjgWOTdEr0HriyrCeh43JCMDDNhhS
Content-Type: multipart/mixed; boundary="XQO76jWb38kB5ocmPm2uGhHUDy3nIBalD";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <34ae1f97-e3c2-d823-b0c3-f72b7a9b67dd@gmx.com>
Subject: Re: [PATCH] btrfs: Remove the duplicated and sometimes too cautious
 btrfs_can_relocate()
References: <20190718054857.8970-1-wqu@suse.com>
 <CAL3q7H5H1BV92bZBv4SmuZ2-c99wOwJz8T8b5MFWV76YvCzmCw@mail.gmail.com>
In-Reply-To: <CAL3q7H5H1BV92bZBv4SmuZ2-c99wOwJz8T8b5MFWV76YvCzmCw@mail.gmail.com>

--XQO76jWb38kB5ocmPm2uGhHUDy3nIBalD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/7/18 =E4=B8=8B=E5=8D=887:16, Filipe Manana wrote:
> On Thu, Jul 18, 2019 at 6:50 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> The following script can easily cause unexpected ENOSPC:
>>   umount $dev &> /dev/null
>>   umount $mnt &> /dev/null
>>
>>   mkfs.btrfs -b 1G -m single -d single $dev -f > /dev/null
>>
>>   mount $dev $mnt -o enospc_debug
>>
>>   for i in $(seq -w 0 511); do
>>         xfs_io -f -c "pwrite 0 1m" $mnt/inline_$i > /dev/null
>>   done
>>   sync
>>
>>   btrfs balance start --full $mnt || return 1
>>   sync
>>
>>   # This will report -ENOSPC
>>   btrfs balance start --full $mnt || return 1
>>   umount $mnt
>>
>> Also, btrfs/156 can also fail due to ENOSPC.
>=20
> Well, that script you pasted is btrfs/156 essentially.
>=20
> When did the test started failing? When the test was added, it didn't
> fail, did it?

Biosect to commit 302167c50b32 ("btrfs: don't end the transaction for
delayed refs in throttle").

But that commit itself looks pretty valid to me.

And as described, it failed at btrfs_can_relocate(), not exactly the
test case is expected to fail.
(IIRC when the test case is submitted, the error happens at
inc_block_group_ro(), hence why I added some debug message there)

>=20
>>
>> [CAUSE]
>> The ENOSPC is reported by btrfs_can_relocate().
>>
>> In btrfs_can_relocate(), it does the following check:
>> - If the block group is empty
>>   If empty, definitely we can relocate this block group.
>> - If we are not the only block group and we have enough space
>>   Then we can relocate this block group.
>>
>> Above two checks are completely OK, although I could argue they doesn'=
t
>> make much sense, but the following check is vague and even sometimes
>> too cautious to cause ENOSPC:
>> - If we can allocate a new block group as large as current one.
>>   If we failed previous two checks, we must pass this to relocate this=

>>   block group.
>>
>> There are several problems here:
>> 1. We don't need to allocate as large as the source block group.
>>    E.g. source block group is 1G sized, but only 1M used. We only need=

>>    to allocated a data chunk larger than 1M to continue relocation.
>=20
> Right. But where does btrfs_can_relocate() do such assumption?
> It only tries to check if there's enough space for an amount that
> corresponds to the amount used in the block group, that is, not the
> size of the block group (unless the block group is completely full).

You're right, my description here is wrong.

I'll remove this paragraph completely.

Thanks,
Qu

>=20
>>
>> 2. The check in btrfs_can_relocate() is vague and impossible to be as
>>    accurate as __btrfs_alloc_chunk()
>>    How could this less than 200 lines code do the same work as
>>    __btrfs_alloc_chunk()? And it's hard to maintain two different
>>    functions to do similar work.
>>
>> 3. We have more accurate check in btrfs_inc_block_group_ro().
>>    Btrfs_inc_block_group_ro() is doing similar check but much better.
>>    In btrfs_inc_block_group_ro() we do:
>>    * Forced chunk allocation if we're converting
>>
>>    * Try to mark block group ro first
>>      in inc_btrfs_block_group_ro(), we will do comprehensive space
>>      check to ensure we have enough free space for the used and reserv=
ed
>>      space of the block group.
>>      If succeeded, we're done.
>>
>>    * Force chunk allocation for more space
>>      If we failed here, we indeed hits ENOSPC.
>>
>>    * Try to mark block group ro again
>>      As we have extra space, we can try again.
>>      This is the last chance, either we have enough space now and
>>      success, or the newly allocated space is not large enough, ENOSPC=

>>      is returned.
>>
>>    Such try-allocate-try behavior is way more accurate in every way
>>    compared to btrfs_can_relocate(), we can rely on
>>    btrfs_inc_block_group_ro() to replace btrfs_can_relocate()
>>    completely.
>>
>> [FIX]
>> Since regular balance routine already has a better ENOSPC detector,
>> there is no need to keep the false-alert-prone btrfs_can_relocate().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/ctree.h       |   1 -
>>  fs/btrfs/extent-tree.c | 141 ----------------------------------------=
-
>>  fs/btrfs/volumes.c     |   4 --
>>  3 files changed, 146 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 0a61dff27f57..965d1e5a4af7 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -2772,7 +2772,6 @@ int btrfs_setup_space_cache(struct btrfs_trans_h=
andle *trans);
>>  int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);=

>>  int btrfs_free_block_groups(struct btrfs_fs_info *info);
>>  int btrfs_read_block_groups(struct btrfs_fs_info *info);
>> -int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr);
>>  int btrfs_make_block_group(struct btrfs_trans_handle *trans,
>>                            u64 bytes_used, u64 type, u64 chunk_offset,=

>>                            u64 size);
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index 5faf057f6f37..822a4102980d 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -9774,147 +9774,6 @@ void btrfs_dec_block_group_ro(struct btrfs_blo=
ck_group_cache *cache)
>>         spin_unlock(&sinfo->lock);
>>  }
>>
>> -/*
>> - * Checks to see if it's even possible to relocate this block group.
>> - *
>> - * @return - -1 if it's not a good idea to relocate this block group,=
 0 if its
>> - * ok to go ahead and try.
>> - */
>> -int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
>> -{
>> -       struct btrfs_block_group_cache *block_group;
>> -       struct btrfs_space_info *space_info;
>> -       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
>> -       struct btrfs_device *device;
>> -       u64 min_free;
>> -       u64 dev_min =3D 1;
>> -       u64 dev_nr =3D 0;
>> -       u64 target;
>> -       int debug;
>> -       int index;
>> -       int full =3D 0;
>> -       int ret =3D 0;
>> -
>> -       debug =3D btrfs_test_opt(fs_info, ENOSPC_DEBUG);
>> -
>> -       block_group =3D btrfs_lookup_block_group(fs_info, bytenr);
>> -
>> -       /* odd, couldn't find the block group, leave it alone */
>> -       if (!block_group) {
>> -               if (debug)
>> -                       btrfs_warn(fs_info,
>> -                                  "can't find block group for bytenr =
%llu",
>> -                                  bytenr);
>> -               return -1;
>> -       }
>> -
>> -       min_free =3D btrfs_block_group_used(&block_group->item);
>> -
>> -       /* no bytes used, we're good */
>> -       if (!min_free)
>> -               goto out;
>> -
>> -       space_info =3D block_group->space_info;
>> -       spin_lock(&space_info->lock);
>> -
>> -       full =3D space_info->full;
>> -
>> -       /*
>> -        * if this is the last block group we have in this space, we c=
an't
>> -        * relocate it unless we're able to allocate a new chunk below=
=2E
>> -        *
>> -        * Otherwise, we need to make sure we have room in the space t=
o handle
>> -        * all of the extents from this block group.  If we can, we're=
 good
>> -        */
>> -       if ((space_info->total_bytes !=3D block_group->key.offset) &&
>> -           (btrfs_space_info_used(space_info, false) + min_free <
>> -            space_info->total_bytes)) {
>> -               spin_unlock(&space_info->lock);
>> -               goto out;
>> -       }
>> -       spin_unlock(&space_info->lock);
>> -
>> -       /*
>> -        * ok we don't have enough space, but maybe we have free space=
 on our
>> -        * devices to allocate new chunks for relocation, so loop thro=
ugh our
>> -        * alloc devices and guess if we have enough space.  if this b=
lock
>> -        * group is going to be restriped, run checks against the targ=
et
>> -        * profile instead of the current one.
>> -        */
>> -       ret =3D -1;
>> -
>> -       /*
>> -        * index:
>> -        *      0: raid10
>> -        *      1: raid1
>> -        *      2: dup
>> -        *      3: raid0
>> -        *      4: single
>> -        */
>> -       target =3D get_restripe_target(fs_info, block_group->flags);
>> -       if (target) {
>> -               index =3D btrfs_bg_flags_to_raid_index(extended_to_chu=
nk(target));
>> -       } else {
>> -               /*
>> -                * this is just a balance, so if we were marked as ful=
l
>> -                * we know there is no space for a new chunk
>> -                */
>> -               if (full) {
>> -                       if (debug)
>> -                               btrfs_warn(fs_info,
>> -                                          "no space to alloc new chun=
k for block group %llu",
>> -                                          block_group->key.objectid);=

>> -                       goto out;
>> -               }
>> -
>> -               index =3D btrfs_bg_flags_to_raid_index(block_group->fl=
ags);
>> -       }
>> -
>> -       if (index =3D=3D BTRFS_RAID_RAID10) {
>> -               dev_min =3D 4;
>> -               /* Divide by 2 */
>> -               min_free >>=3D 1;
>> -       } else if (index =3D=3D BTRFS_RAID_RAID1) {
>> -               dev_min =3D 2;
>> -       } else if (index =3D=3D BTRFS_RAID_DUP) {
>> -               /* Multiply by 2 */
>> -               min_free <<=3D 1;
>> -       } else if (index =3D=3D BTRFS_RAID_RAID0) {
>> -               dev_min =3D fs_devices->rw_devices;
>> -               min_free =3D div64_u64(min_free, dev_min);
>> -       }
>> -
>> -       mutex_lock(&fs_info->chunk_mutex);
>> -       list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc=
_list) {
>> -               u64 dev_offset;
>> -
>> -               /*
>> -                * check to make sure we can actually find a chunk wit=
h enough
>> -                * space to fit our block group in.
>> -                */
>> -               if (device->total_bytes > device->bytes_used + min_fre=
e &&
>> -                   !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->de=
v_state)) {
>> -                       ret =3D find_free_dev_extent(device, min_free,=

>> -                                                  &dev_offset, NULL);=

>> -                       if (!ret)
>> -                               dev_nr++;
>> -
>> -                       if (dev_nr >=3D dev_min)
>> -                               break;
>=20
> And here's a bug in that code. Before breaking out of the loop, ret
> should be set to 0.
>=20
> In general I'm ok with the change, but would like an answer to those qu=
estions.
>=20
> Thanks.
>=20
>> -
>> -                       ret =3D -1;
>> -               }
>> -       }
>> -       if (debug && ret =3D=3D -1)
>> -               btrfs_warn(fs_info,
>> -                          "no space to allocate a new chunk for block=
 group %llu",
>> -                          block_group->key.objectid);
>> -       mutex_unlock(&fs_info->chunk_mutex);
>> -out:
>> -       btrfs_put_block_group(block_group);
>> -       return ret;
>> -}
>> -
>>  static int find_first_block_group(struct btrfs_fs_info *fs_info,
>>                                   struct btrfs_path *path,
>>                                   struct btrfs_key *key)
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 1c2a6e4b39da..f209127a8bc6 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3071,10 +3071,6 @@ static int btrfs_relocate_chunk(struct btrfs_fs=
_info *fs_info, u64 chunk_offset)
>>          */
>>         lockdep_assert_held(&fs_info->delete_unused_bgs_mutex);
>>
>> -       ret =3D btrfs_can_relocate(fs_info, chunk_offset);
>> -       if (ret)
>> -               return -ENOSPC;
>> -
>>         /* step one, relocate all the extents inside this chunk */
>>         btrfs_scrub_pause(fs_info);
>>         ret =3D btrfs_relocate_block_group(fs_info, chunk_offset);
>> --
>> 2.22.0
>>
>=20
>=20


--XQO76jWb38kB5ocmPm2uGhHUDy3nIBalD--

--OY5bYjgWOTdEr0HriyrCeh43JCMDDNhhS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl0wWXUACgkQwj2R86El
/qgVPwf9FITj6Po82q8khsMaiWJe2L1gk2tHK00jH/+yrk5pViSOIvetO9ND53th
sQlTPfMffxTqpARBLY9WdRUgH/gYfdeSBbHftvkXGKUy/VwFbBKXOt4737DJCKKh
+z3jgaaaePUfwgj0Wy+gLL6fTwDSpPCmD6iG8TLkL8QcajeuS+cT/WaiBJLJi/6L
QPhOrQwMzYqJ5VGa69tJ0nsfxcMQdNnowlu2jXFjJ/lxRJFo4aCDBEYvlrNuyUGt
sNczxvZo/6RurIu88ANJOAzeI0qoxKiReVPA00qyoCKKsQtFQ9JHGoN0aUcLxy8H
qHZ7UVFnrmOw1FgJRX7bNqVnVcSMeg==
=Fakh
-----END PGP SIGNATURE-----

--OY5bYjgWOTdEr0HriyrCeh43JCMDDNhhS--
