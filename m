Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAFB10EB20
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 14:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLBNus (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 08:50:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:34007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfLBNur (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Dec 2019 08:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575294606;
        bh=JaJutZ0ej4IjU23+piAHRL8bO+65hIi5XqyneXn7PSw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ar0yBz4WR466AOtpWJsUaaeqOceS/DvEKdIzo38BZOPeiVUgEbsmxNrbPb+W0/UU7
         CpFU8m2WQwTqJSi2by7xgYg/1g3fo2slDdxARsWwNhKfetNWNEk09HxmijLzqnCW11
         08EGzqPPhibklL7KxA2wItfoeIH8XO/77VnagVs4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MqaxO-1hyKc93aHQ-00md7T; Mon, 02
 Dec 2019 14:50:06 +0100
Subject: Re: [PATCH] btrfs: relocation: Allow 'btrfs balance cancel' to return
 quicker
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191202070235.33099-1-wqu@suse.com>
 <CAL3q7H5xSHHgSsXU=S1pspy6hmTSzgUuD83eDEsL=2KLjU5Q2Q@mail.gmail.com>
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
Message-ID: <9bcaea27-f969-0f27-b7d1-c34d32c25512@gmx.com>
Date:   Mon, 2 Dec 2019 21:50:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5xSHHgSsXU=S1pspy6hmTSzgUuD83eDEsL=2KLjU5Q2Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZyCHnsXr9BIkiYEkDMtI10yKOq17Vr6b3"
X-Provags-ID: V03:K1:PHudkqWskT2W1bG1WMxbukTKc4xymoWmzATEKr5uuJsqixMzbnN
 HqNPVqbZTxOuN9Mt/tHW15q/b8PYtEGfUqfdA6L2kMaft1FcymknsFSY2AocEWyyHw5H7Zr
 sKWX947+iQBnbTQVmHLZPED3HhX+g1wV9yVBkbbrRupZpHPMkY/fVW4vn7j/Q7jR4p1y7An
 c/5O9dR/LRQSyJ95tol6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aVZp45XP1DY=:8+06Z1LKjDHfpbSBqmcrPO
 uCEQkP77w6hOUucstaRHcSIWs9EXdlKLJDJ28OCccFkfqFORqQUNDrJWgeJDtAjNKv5JacVQ6
 Ha7y489G2hAOf331cCgax+/nf4WKtK0+I66GQ3hWSFOREnOM5stiVSvjfXLrY4PYyjh7NQ5kI
 /WQxvx2xps/29yCR7ylbgzCmY90L4OX9W093aL/672E/3FnhbfqRyca3y+8R1HdzDCic3vKl5
 OjsIzxwlTaHUkKLIAzT7zyPTI8Fsibv8QPyfVzhGsaN9X+hdHCm6gXx4jRLF0TiOuTfBIgfdJ
 bQ2jcB/g8sT8hZVI469P+DM/kfJN4jRZ1/tNnIejcTrG8J2swBXCPZZp5XHbIL/R5w/UAUm0w
 CHsWvSWl7nHfKb+l4Sr6SRRLwUu/TsfjdszfonD3oz335x1scCoqArA2HpGdE3Cte1RUV16zc
 rHgYu78o6d8d1aunzDcc5v2l3lc6Fuu7AzUdrGyD2ys340OjJGLH5E8wRxYCpHigUlE3p6uv2
 9IUrONlW8yT+rTpMQi+FndWehO6tD3YcJs23wGAvFJa9ii2IyNtlpPPzRhw0JOzKNbtcQnrcG
 jHh+VfH26NL0qwFKJUIXTQe5Ri9QRrs5cVl5IVl/mpv/ZtizItyvnACtuPngkS38LPBEvxTEk
 vzzgH5pPFeiIaTN+DgKpqzt+fWHxKc1uFmnaPqLBf5zuytEsMejCpV4zZC8Dhp+iBYeO1fUcf
 4fbB7MMSNGbxKms8kNaR1UJKNFRmE3XYK+RdrD8vTQX+iD1q+UJFBFvl282HpU3TlSEA8XcRs
 +vnwDgx2PESZNO9SjK+F1zsreN7OqFmD00FYjttYD34YNeE+4uJIFc7JZLsv6bA4FREm7x45f
 nplRfW07aCHzzoPyZ9jnAKJ1JfXBKpvX3XquiSlZBgho5zdNwgQgUF8Qmxkw+vEkIpnwRz5gR
 rhkm224dQdTPx8ktJeNC/iIdbTUC+y3hebaTA8KJR54dxbs5HsrBJcWzDmdCxKFJ1AXGAatHm
 /ZZVdijb1Uopz1s4W6Gg7iE5RPzEfzi5ZrGt5i5/Ziw2rmodzPpdIYRINKR+z332V6HvLujEu
 4PRBXV/IE2hM/zPpqI4bxYqO0scXh1Zacvbtn82o4H2IiVhjozoD2bq8Zx8tliTMJx4b5sOys
 ZJOOdNqhrHXiUU3SiZPxZJ01MvJpSBfBa/p0WFJV7Himp+z0QQZWGNGBRulVhE/h1IavTMUpG
 HYx1u0RJZ1IUqrPF6M75BCjNs0xQ5J1+o9IEQZo0J36FiYlH8jZb6NYUneDw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZyCHnsXr9BIkiYEkDMtI10yKOq17Vr6b3
Content-Type: multipart/mixed; boundary="AjEff3X6IU6C5H14e97qox8H7GSXhE5CY"

--AjEff3X6IU6C5H14e97qox8H7GSXhE5CY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/2 =E4=B8=8B=E5=8D=888:31, Filipe Manana wrote:
> On Mon, Dec 2, 2019 at 7:04 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [PROBLEM]
>> There are quite some users reporting that 'btrfs balance cancel' slow =
to
>> cancel current running balance, or even doesn't work for certain dead
>> balance loop.
>>
>> With the following script showing how long it takes to fully stop a
>> balance:
>>   #!/bin/bash
>>   dev=3D/dev/test/test
>>   mnt=3D/mnt/btrfs
>>
>>   umount $mnt &> /dev/null
>>   umount $dev &> /dev/null
>>
>>   mkfs.btrfs -f $dev
>>   mount $dev -o nospace_cache $mnt
>>
>>   dd if=3D/dev/zero bs=3D1M of=3D$mnt/large &
>>   dd_pid=3D$!
>>
>>   sleep 3
>>   kill -KILL $dd_pid
>>   sync
>>
>>   btrfs balance start --bg --full $mnt &
>>   sleep 1
>>
>>   echo "cancel request" >> /dev/kmsg
>>   time btrfs balance cancel $mnt
>>   umount $mnt
>>
>> It takes around 7~10s to cancel the running balance in my test
>> environment.
>>
>> [CAUSE]
>> Btrfs uses btrfs_fs_info::balance_cancel_req to record how many cancel=

>> request are queued.
>>
>> And btrfs checks this value only in the following call sites:
>> btrfs_balance()
>> |- atomic_read(&fs_info->balance_cancel_req); <<< 1
>> |- __btrfs_balance()
>>    |- while (1) {
>>    |  /* Per chunk iteration */
>>    |-    atomic_read(&fs_info->balance_cancel_req); <<< 2
>>
>> The first check is near useless, as it happens at the very beginning o=
f
>> balance, thus it's too rare to hit.
>>
>> The sencond check is the most common hit, but it's too slow, only hit
>> after each chunk get relocated.
>>
>> For certain bug reports, like "Found 1 extents" loop where we are
>> dead-looping inside btrfs_relocate_block_group(), it's useless.
>>
>> [FIX]
>> This patch will introduce more cancel check at the following call site=
s:
>> btrfs_balance()
>> |- __btrfs_balance()
>>    |- btrfs_relocate_block_group()
>>       |- while (1) { /* Per relocation-stage loop, 2~3 runs */
>>       |-    should_cancel_balance()     <<< 1
>>       |-    balance_block_group()
>>       |- }
>>
>> /* Call site 1 workaround dead balance loop */
>> Call site 1 will allow user to workaround the mentioned dead balance
>> loop by properly canceling it.
>>
>> balance_block_group()
>> |- while (1) { /* Per-extent iteration */
>> |-    relocate_data_extent()
>> |     |- relocate_file_extent_cluster()
>> |        |- should_cancel_balance()     <<< 2
>> |-    should_cancel_balance()           <<< 3
>> |- }
>> |- relocate_file_extent_cluster()
>>
>> /* Call site 2 for data heavy relocation */
>> As we spend a lot of time doing page reading for data relocation, such=

>> check can make exit much quicker for data relocation.
>> This check has a bytes based filter (every 32M) to prevent wasting too=

>> much CPU time checking it.
>=20
> You really think (or observed) that reading an atomic is that much cpu
> intensive?
>=20
> Given the context where this is used, I would say to keep it simple
> and do check after after each page -
> the amount of work we do for each page is at least an order of
> magnitude heavier then reading an atomic.

You're right, I'm over-complicating the situation.

Keeping it simple is much better.

>=20
>>
>> /* Call site 3 for meta heavy relocation */
>> The check has a nr_extent based filter (every 256 extents) to prevent
>> wasting too much CPU time.
>=20
> Same comment as before.
>=20
>>
>> /* Error injection to do full coverage test */
>> This patch packs the regular atomic_read() into a separate function,
>> should_cancel_balance() to allow error injection.
>> So we can do a full coverage test.
>=20
> I suppose I would do that separately (as in a separate patch). Not
> sure if it's that useful to it, despite probably having been useful
> for your testing/debugging.

It looks better to separate it.

The usefulness only shows when it crashes, and there are locations like
in merge_reloc_root() that if we add such check, it will crash like crazy=
=2E

For that crash, it will be solved in another patchset I guess.

I'll update the patchset to reflect the comment.

Thanks for your review,
Qu

> Anyway, that may very well be subjective.
>=20
> Other than that it looks good to me.
> Thanks.
>=20
>>
>> With this patch, the response time has reduced from 7~10s to 0.5~1.5s =
for
>> data relocation.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/ctree.h      |  1 +
>>  fs/btrfs/relocation.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/volumes.c    |  6 +++---
>>  3 files changed, 45 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index b2e8fd8a8e59..a712c18d2da2 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -3352,6 +3352,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pendi=
ng_snapshot *pending,
>>                               u64 *bytes_to_reserve);
>>  int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
>>                               struct btrfs_pending_snapshot *pending);=

>> +int should_cancel_balance(struct btrfs_fs_info *fs_info);
>>
>>  /* scrub.c */
>>  int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 sta=
rt,
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index d897a8e5e430..c42616750e4b 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/blkdev.h>
>>  #include <linux/rbtree.h>
>>  #include <linux/slab.h>
>> +#include <linux/error-injection.h>
>>  #include "ctree.h"
>>  #include "disk-io.h"
>>  #include "transaction.h"
>> @@ -3223,6 +3224,16 @@ int setup_extent_mapping(struct inode *inode, u=
64 start, u64 end,
>>         return ret;
>>  }
>>
>> +int should_cancel_balance(struct btrfs_fs_info *fs_info)
>> +{
>> +       return atomic_read(&fs_info->balance_cancel_req);
>> +}
>> +/* Allow us to do error injection test to cover all cancel exit branc=
hes */
>> +ALLOW_ERROR_INJECTION(should_cancel_balance, TRUE);
>> +
>> +/* Thresholds of when to check if the balance is canceled */
>> +#define RELOC_CHECK_INTERVAL_NR_EXTENTS                (256)
>> +#define RELOC_CHECK_INTERVAL_BYTES             (SZ_32M)
>>  static int relocate_file_extent_cluster(struct inode *inode,
>>                                         struct file_extent_cluster *cl=
uster)
>>  {
>> @@ -3230,6 +3241,7 @@ static int relocate_file_extent_cluster(struct i=
node *inode,
>>         u64 page_start;
>>         u64 page_end;
>>         u64 offset =3D BTRFS_I(inode)->index_cnt;
>> +       u64 checked_bytes =3D 0;
>>         unsigned long index;
>>         unsigned long last_index;
>>         struct page *page;
>> @@ -3344,6 +3356,14 @@ static int relocate_file_extent_cluster(struct =
inode *inode,
>>                 btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SI=
ZE);
>>                 balance_dirty_pages_ratelimited(inode->i_mapping);
>>                 btrfs_throttle(fs_info);
>> +
>> +               checked_bytes +=3D PAGE_SIZE;
>> +               if (checked_bytes >=3D RELOC_CHECK_INTERVAL_BYTES &&
>> +                   should_cancel_balance(fs_info)) {
>> +                       ret =3D -ECANCELED;
>> +                       goto out;
>> +               }
>> +               checked_bytes %=3D RELOC_CHECK_INTERVAL_BYTES;
>>         }
>>         WARN_ON(nr !=3D cluster->nr);
>>  out:
>> @@ -4016,7 +4036,10 @@ static noinline_for_stack int relocate_block_gr=
oup(struct reloc_control *rc)
>>         struct btrfs_path *path;
>>         struct btrfs_extent_item *ei;
>>         u64 flags;
>> +       u64 checked_bytes =3D 0;
>> +       u64 checked_nr_extents =3D 0;
>>         u32 item_size;
>> +       u32 extent_size;
>>         int ret;
>>         int err =3D 0;
>>         int progress =3D 0;
>> @@ -4080,11 +4103,14 @@ static noinline_for_stack int relocate_block_g=
roup(struct reloc_control *rc)
>>                 }
>>
>>                 if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
>> +                       extent_size =3D fs_info->nodesize;
>>                         ret =3D add_tree_block(rc, &key, path, &blocks=
);
>>                 } else if (rc->stage =3D=3D UPDATE_DATA_PTRS &&
>>                            (flags & BTRFS_EXTENT_FLAG_DATA)) {
>> +                       extent_size =3D key.offset;
>>                         ret =3D add_data_references(rc, &key, path, &b=
locks);
>>                 } else {
>> +                       extent_size =3D key.offset;
>>                         btrfs_release_path(path);
>>                         ret =3D 0;
>>                 }
>> @@ -4125,6 +4151,17 @@ static noinline_for_stack int relocate_block_gr=
oup(struct reloc_control *rc)
>>                                 break;
>>                         }
>>                 }
>> +               checked_bytes +=3D extent_size;
>> +               checked_nr_extents++;
>> +
>> +               if ((checked_bytes >=3D RELOC_CHECK_INTERVAL_BYTES ||
>> +                    checked_nr_extents >=3D RELOC_CHECK_INTERVAL_NR_E=
XTENTS) &&
>> +                   should_cancel_balance(fs_info)) {
>> +                       err =3D -ECANCELED;
>> +                       break;
>> +               }
>> +               checked_bytes %=3D RELOC_CHECK_INTERVAL_BYTES;
>> +               checked_nr_extents %=3D RELOC_CHECK_INTERVAL_NR_EXTENT=
S;
>>         }
>>         if (trans && progress && err =3D=3D -ENOSPC) {
>>                 ret =3D btrfs_force_chunk_alloc(trans, rc->block_group=
->flags);
>> @@ -4365,6 +4402,10 @@ int btrfs_relocate_block_group(struct btrfs_fs_=
info *fs_info, u64 group_start)
>>                                  rc->block_group->length);
>>
>>         while (1) {
>> +               if (should_cancel_balance(fs_info)) {
>> +                       err=3D -ECANCELED;
>> +                       goto out;
>> +               }
>>                 mutex_lock(&fs_info->cleaner_mutex);
>>                 ret =3D relocate_block_group(rc);
>>                 mutex_unlock(&fs_info->cleaner_mutex);
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d8e5560db285..afa3ed1b066d 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3505,7 +3505,7 @@ static int __btrfs_balance(struct btrfs_fs_info =
*fs_info)
>>
>>         while (1) {
>>                 if ((!counting && atomic_read(&fs_info->balance_pause_=
req)) ||
>> -                   atomic_read(&fs_info->balance_cancel_req)) {
>> +                   should_cancel_balance(fs_info)) {
>>                         ret =3D -ECANCELED;
>>                         goto error;
>>                 }
>> @@ -3670,7 +3670,7 @@ static int alloc_profile_is_valid(u64 flags, int=
 extended)
>>  static inline int balance_need_close(struct btrfs_fs_info *fs_info)
>>  {
>>         /* cancel requested || normal exit path */
>> -       return atomic_read(&fs_info->balance_cancel_req) ||
>> +       return should_cancel_balance(fs_info) ||
>>                 (atomic_read(&fs_info->balance_pause_req) =3D=3D 0 &&
>>                  atomic_read(&fs_info->balance_cancel_req) =3D=3D 0);
>>  }
>> @@ -3856,7 +3856,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,=

>>
>>         if (btrfs_fs_closing(fs_info) ||
>>             atomic_read(&fs_info->balance_pause_req) ||
>> -           atomic_read(&fs_info->balance_cancel_req)) {
>> +           should_cancel_balance(fs_info)) {
>>                 ret =3D -EINVAL;
>>                 goto out;
>>         }
>> --
>> 2.24.0
>>
>=20
>=20


--AjEff3X6IU6C5H14e97qox8H7GSXhE5CY--

--ZyCHnsXr9BIkiYEkDMtI10yKOq17Vr6b3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3lFokACgkQwj2R86El
/qg2Cgf9G13GML8ZK/7ZfUtuJzRx/H8UgW7SGHQIndCyH4K5NIUdQtq1GGvI52ya
nRRnyM5GvyC3dCwUuXPbNdBhVGwzXdeQqo8BNkOuAuyroMEQ1Z1+VqEEJUWvQAyb
9/Fad6h1Sy+32SiZV0KtMvKHdsj5OIuzZEqu4nt+62meDTta+xuvgs3HmTFKJbKz
7rtDh+OBKmuklsH9rnZlmNMS0kSlI0KPYvEBfenteTlvQGkBGikAVrJsYUp2zkAu
DH5QYCMCB2QZF0oUiuyZS4xx0GtHpg3fXNAchMCh2aa9A/AQoEQvfRHh9A6o0yFV
NTLY8dK3N9VNgBlIOwud2cNv3GqaAg==
=8Jn3
-----END PGP SIGNATURE-----

--ZyCHnsXr9BIkiYEkDMtI10yKOq17Vr6b3--
