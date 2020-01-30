Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81C14D96F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 12:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgA3LC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 06:02:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:38069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgA3LC2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 06:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580382136;
        bh=WgyAl7frUGv8iNze8iNgsoIGLQV8F3BG44iiXhjdywg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Gb8rbV5y6sc8n10VKAFHlDh0U2wYGQOO36hmYoYLhR3pPOMTMtrmyv4EbikCorgNn
         ncpin914uZ4Uw+yvKv5P5oJFmxrJBQrDEUN6qFDxYhzxxmW1mCFxU2N+4tTTfUs2L5
         CojA3m5xV/C6jbvoZ1m8XOjJ8ltDjvpHmzvXTRls=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1jKIdu072T-00o1gq; Thu, 30
 Jan 2020 12:02:15 +0100
Subject: Re: [PATCH] btrfs: Allow btrfs_truncate_block() to fallback to nocow
 for data space reservation
To:     fdmanana@gmail.com
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Martin Doucha <martin.doucha@suse.com>,
        Anand Jain <anand.jain@oracle.com>
References: <20200130052822.11765-1-wqu@suse.com>
 <CAL3q7H4ODcwn7LVm=P3BBL7zd3wGRB_Vtr_KNk_2MysNNwgqcQ@mail.gmail.com>
 <8341b76f-bcbe-f2b9-d8b0-cfcd0006a47c@gmx.com>
 <CAL3q7H6Ueu0v8tzozci-dj4s3rTGx78jAGUrcYomZPAZ+6_MsA@mail.gmail.com>
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
Message-ID: <35516074-f0fb-e0b4-bfc4-8b69f5fd9fb4@gmx.com>
Date:   Thu, 30 Jan 2020 19:02:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6Ueu0v8tzozci-dj4s3rTGx78jAGUrcYomZPAZ+6_MsA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eShez4sA9GozNrE1TwSjsSaH1UjdQXiwe"
X-Provags-ID: V03:K1:Nh4B6tDIp8XK+IEnAkoMo2MJpwh9q53g5UbyAVpTSg7//tM6DZT
 a0FFA+P0iz2Yj/mRrQDDzmUFlgZ9Df2gLkdCawGxYdV+gFd/+uVovQ1qnTbAWE2LT2klAav
 cdrdKKKHvlWqGA72NV4DBhH0lTfgh28jKHxXEBncbQr5WJtYDQVk/wTy5vc8Bo+5zllukZr
 c1/tRUdaDJGzabvq51QHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VqYUTI+eKbQ=:C7YI4pTWZIHgfJ4CZAynjt
 wGwg630AT1YCg1NBhODGExREduvPk/1wpk0sqS9SCaj1cEeOxYNXxbs0nqWCTIv27cUFkfu/J
 b408sQZy2ca7yVturX/Yv6sZmhn9GhRRHK61gdbpB5YMKIXYLU/QLIAFLpI9Dl4kS02pykyDj
 aAmLNeblsL12qj2tXHBlgC0gQHVaqThbBFGkNlMcWc4P/s8JjRn7u247X2h0ggKNZH2RnqdBj
 Uw/fWavJF1xPcvFhP7BrRk6r5MEtwFnQDn8hBNkNIU8nDPJ88lfyOaGeiDGCDdUkiBjp3qGKk
 v1UCdz6J6arrXcRtlbdYx+riJWO8CzkSHIjYpLfPOBD2j7KSy31PLR7e9KQyiOrCRYMIdie8l
 qQ9cbsjXiuOtOGf6/XsP4YdmU9JKcAUMJF8lukoAg0HfAhdKT/xQ0QCf+7ZfIIGqVUtFi6F27
 lgqKaTFBa697HriAsMubZteny2SytJCyKf+8+7POio9NJx65QdhfsATW8surLaLdUkmhICM6o
 AAT4Qgt5h4UMsFx5AFG9SpCM/3oI4SYig+QHiveZTyP6uXod1RM9P5NCqbcLCPww0bz3S2ebu
 mwTP4FHF8Q9XLAIBG8q+aBAwGpM9A0D1rrmI1+z3MqgV6gXfWmtcV1jqhwZReFT/Zi3R+/t/g
 Z1vRQpdiHblGOkAvPpjfzivSrZ8LvtISq//m6Fd1oyKv+iH/atvLbWnHfp291VeaF6atnFITm
 xA7dwuRNyoTk/plvRYSbJeL+zkvEQaUF5xIWk/bzZLHsqPrbDTJdTnUUcArWnhHClD7NoAEHW
 DOdKRaLKmh/1wpTY/IFEPhRyPR4s3I8v9NmZcyIa1bnHYRk2c2PkNprqSlHGocyoCuWECu83n
 L/U3TRnVqQrDTlLEAsjKPg4bLJvA6DElTGxQ0mEfzJsDXbHfoHu4O0Hyuof55I3ZUHW54ZjMH
 q9Z8eMOrzl39ZhRRBeSrnsib20r+ofGjODKsrQCqMV7xgCOB+Hs8l8qvJ767ECeSpN2ZSWF5p
 mpHVeu55Uy5PBY9C4ArS0vB0BJJ+eC8ZsvCSRWIKuqItEkn1de6nG902zhaRruvGSgj9aeK3e
 7NMVKivUeMvjgxDeEDj3nY9eCXe5x2b8VWeAcsI5whwqSI3xcoIyY/vd/YxQHFL5UhiOraRPG
 4FF+TzJHnB/wL4z3tBQQVkq+O55I8JLFKnu2JS/bnIIgElYeGdUn45Bj+IPggWPv1oCAAdg9s
 uo2x0U5dwTocce7Af
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eShez4sA9GozNrE1TwSjsSaH1UjdQXiwe
Content-Type: multipart/mixed; boundary="84XS5USARx2A3U4Q1AXa1P0UDqq9SYECz"

--84XS5USARx2A3U4Q1AXa1P0UDqq9SYECz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/30 =E4=B8=8B=E5=8D=886:46, Filipe Manana wrote:
> On Thu, Jan 30, 2020 at 10:36 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>
>>
>>
>> On 2020/1/30 =E4=B8=8B=E5=8D=886:02, Filipe Manana wrote:
>>> On Thu, Jan 30, 2020 at 5:30 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> [BUG]
>>>> When the data space is exhausted, even the inode has NOCOW attribute=
,
>>>> btrfs will still refuse to truncate unaligned range due to ENOSPC.
>>>>
>>>> The following script can reproduce it pretty easily:
>>>>   #!/bin/bash
>>>>
>>>>   dev=3D/dev/test/test
>>>>   mnt=3D/mnt/btrfs
>>>>
>>>>   umount $dev &> /dev/null
>>>>   umount $mnt&> /dev/null
>>>>
>>>>   mkfs.btrfs -f $dev -b 1G
>>>>   mount -o nospace_cache $dev $mnt
>>>>   touch $mnt/foobar
>>>>   chattr +C $mnt/foobar
>>>>
>>>>   xfs_io -f -c "pwrite -b 4k 0 4k" $mnt/foobar > /dev/null
>>>>   xfs_io -f -c "pwrite -b 4k 0 1G" $mnt/padding &> /dev/null
>>>>   sync
>>>>
>>>>   xfs_io -c "fpunch 0 2k" $mnt/foobar
>>>>   umount $mnt
>>>>
>>>> Current btrfs will fail at the fpunch part.
>>>>
>>>> [CAUSE]
>>>> Because btrfs_truncate_block() always reserve space without checking=
 the
>>>> NOCOW attribute.
>>>>
>>>> Since the writeback path follows NOCOW bit, we only need to bother t=
he
>>>> space reservation code in btrfs_truncate_block().
>>>>
>>>> [FIX]
>>>> Make btrfs_truncate_block() to follow btrfs_buffered_write() to try =
to
>>>> reserve data space first, and falls back to NOCOW check only when we=

>>>> don't have enough space.
>>>>
>>>> Such always-try-reserve is an optimization introduced in
>>>> btrfs_buffered_write(), to avoid expensive btrfs_check_can_nocow() c=
all.
>>>>
>>>> Since now check_can_nocow() is needed outside of inode.c, also expor=
t it
>>>> and rename it to btrfs_check_can_nocow().
>>>>
>>>> Reported-by: Martin Doucha <martin.doucha@suse.com>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Test case will be submitted to fstests by the reporter.
>>>
>>> Well, this is a sudden change of mind, isn't it? :)
>>>
>>> We had btrfs/172, which you removed very recently, that precisely tes=
ted this:
>>>
>>> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3D5=
38d8a4bcc782258f8f95fae815d5e859dee9126
>>
>> I didn't notice the nodatacow mount option. Super duper big facepalm.
>>
>> All my bad, especially feel sorry for Anand.
>>
>> With nodatacow mount option there, that test case in fact makes a lot =
of
>> sense.
>> Sorry again for that.
>>
>> Anand, mind to resubmit it to generic group?
>=20
> Why the generic group?

Since all other fses should have the same behavior.
Either it supports COW, and get disabled by that chattr, and go ahead.
Or it doesn't support COW, the truncate should go overwrite directly
with or without that chattr +C.

> The nodatacow mount option is btrfs specific, and most filesystems
> don't support chattr +C (ext4 for example).

We can just ignore the chattr call for unsupported fs, and go ahead
without any problem.

Thanks,
Qu

>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> Even though there are several reasons why this can still fail (at
>>> writeback time), like regular buffered writes through the family of
>>> write() syscalls can, I think it's perfectly fine to have this
>>> behaviour.
>>>
>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>>
>>> So I think we can just resurrect btrfs/172 now...
>>>
>>>> ---
>>>>  fs/btrfs/ctree.h |  2 ++
>>>>  fs/btrfs/file.c  | 10 +++++-----
>>>>  fs/btrfs/inode.c | 41 ++++++++++++++++++++++++++++++++++-------
>>>>  3 files changed, 41 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>> index 54efb21c2727..b5639f3461e4 100644
>>>> --- a/fs/btrfs/ctree.h
>>>> +++ b/fs/btrfs/ctree.h
>>>> @@ -2954,6 +2954,8 @@ int btrfs_fdatawrite_range(struct inode *inode=
, loff_t start, loff_t end);
>>>>  loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
>>>>                               struct file *file_out, loff_t pos_out,=

>>>>                               loff_t len, unsigned int remap_flags);=

>>>> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
>>>> +                         size_t *write_bytes);
>>>>
>>>>  /* tree-defrag.c */
>>>>  int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>> index 8d47c76b7bd1..8dc084600f4e 100644
>>>> --- a/fs/btrfs/file.c
>>>> +++ b/fs/btrfs/file.c
>>>> @@ -1544,8 +1544,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_i=
node *inode, struct page **pages,
>>>>         return ret;
>>>>  }
>>>>
>>>> -static noinline int check_can_nocow(struct btrfs_inode *inode, loff=
_t pos,
>>>> -                                   size_t *write_bytes)
>>>> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
>>>> +                         size_t *write_bytes)
>>>>  {
>>>>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>>>         struct btrfs_root *root =3D inode->root;
>>>> @@ -1645,8 +1645,8 @@ static noinline ssize_t btrfs_buffered_write(s=
truct kiocb *iocb,
>>>>                 if (ret < 0) {
>>>>                         if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NO=
DATACOW |
>>>>                                                       BTRFS_INODE_PR=
EALLOC)) &&
>>>> -                           check_can_nocow(BTRFS_I(inode), pos,
>>>> -                                       &write_bytes) > 0) {
>>>> +                           btrfs_check_can_nocow(BTRFS_I(inode), po=
s,
>>>> +                                                 &write_bytes) > 0)=
 {
>>>>                                 /*
>>>>                                  * For nodata cow case, no need to r=
eserve
>>>>                                  * data space.
>>>> @@ -1923,7 +1923,7 @@ static ssize_t btrfs_file_write_iter(struct ki=
ocb *iocb,
>>>>                  */
>>>>                 if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW=
 |
>>>>                                               BTRFS_INODE_PREALLOC))=
 ||
>>>> -                   check_can_nocow(BTRFS_I(inode), pos, &count) <=3D=
 0) {
>>>> +                   btrfs_check_can_nocow(BTRFS_I(inode), pos, &coun=
t) <=3D 0) {
>>>>                         inode_unlock(inode);
>>>>                         return -EAGAIN;
>>>>                 }
>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>> index 5509c41a4f43..b5ae4bbf1ad4 100644
>>>> --- a/fs/btrfs/inode.c
>>>> +++ b/fs/btrfs/inode.c
>>>> @@ -4974,11 +4974,13 @@ int btrfs_truncate_block(struct inode *inode=
, loff_t from, loff_t len,
>>>>         struct extent_state *cached_state =3D NULL;
>>>>         struct extent_changeset *data_reserved =3D NULL;
>>>>         char *kaddr;
>>>> +       bool only_release_metadata =3D false;
>>>>         u32 blocksize =3D fs_info->sectorsize;
>>>>         pgoff_t index =3D from >> PAGE_SHIFT;
>>>>         unsigned offset =3D from & (blocksize - 1);
>>>>         struct page *page;
>>>>         gfp_t mask =3D btrfs_alloc_write_mask(mapping);
>>>> +       size_t write_bytes =3D blocksize;
>>>>         int ret =3D 0;
>>>>         u64 block_start;
>>>>         u64 block_end;
>>>> @@ -4990,11 +4992,26 @@ int btrfs_truncate_block(struct inode *inode=
, loff_t from, loff_t len,
>>>>         block_start =3D round_down(from, blocksize);
>>>>         block_end =3D block_start + blocksize - 1;
>>>>
>>>> -       ret =3D btrfs_delalloc_reserve_space(inode, &data_reserved,
>>>> -                                          block_start, blocksize);
>>>> -       if (ret)
>>>> +       ret =3D btrfs_check_data_free_space(inode, &data_reserved, b=
lock_start,
>>>> +                                         blocksize);
>>>> +       if (ret < 0) {
>>>> +               if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW =
|
>>>> +                                             BTRFS_INODE_PREALLOC))=
 &&
>>>> +                   btrfs_check_can_nocow(BTRFS_I(inode), block_star=
t,
>>>> +                                         &write_bytes) > 0) {
>>>> +                       /* For nocow case, no need to reserve data s=
pace. */
>>>> +                       only_release_metadata =3D true;
>>>> +               } else {
>>>> +                       goto out;
>>>> +               }
>>>> +       }
>>>> +       ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), bloc=
ksize);
>>>> +       if (ret < 0) {
>>>> +               if (!only_release_metadata)
>>>> +                       btrfs_free_reserved_data_space(inode, data_r=
eserved,
>>>> +                                       block_start, blocksize);
>>>>                 goto out;
>>>> -
>>>> +       }
>>>>  again:
>>>>         page =3D find_or_create_page(mapping, index, mask);
>>>>         if (!page) {
>>>> @@ -5063,10 +5080,20 @@ int btrfs_truncate_block(struct inode *inode=
, loff_t from, loff_t len,
>>>>         set_page_dirty(page);
>>>>         unlock_extent_cached(io_tree, block_start, block_end, &cache=
d_state);
>>>>
>>>> +       if (only_release_metadata)
>>>> +               set_extent_bit(&BTRFS_I(inode)->io_tree, block_start=
,
>>>> +                               block_end, EXTENT_NORESERVE, NULL, N=
ULL,
>>>> +                               GFP_NOFS);
>>>> +
>>>>  out_unlock:
>>>> -       if (ret)
>>>> -               btrfs_delalloc_release_space(inode, data_reserved, b=
lock_start,
>>>> -                                            blocksize, true);
>>>> +       if (ret) {
>>>> +               if (!only_release_metadata)
>>>> +                       btrfs_delalloc_release_space(inode, data_res=
erved,
>>>> +                                       block_start, blocksize, true=
);
>>>> +               else
>>>> +                       btrfs_delalloc_release_metadata(BTRFS_I(inod=
e),
>>>> +                                       blocksize, true);
>>>
>>> I usually find it more intuitive to have it the other way around:
>>>
>>> if (only_release_metadata)
>>>   ...
>>> else
>>>   ...
>>>
>>> E.g., positive case first, negative in the else branch. But that's
>>> likely too much of a personal preference.
>>>
>>> Thanks.
>>>
>>>> +       }
>>>>         btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
>>>>         unlock_page(page);
>>>>         put_page(page);
>>>> --
>>>> 2.25.0
>>>>
>>>
>>>
>>
>=20
>=20


--84XS5USARx2A3U4Q1AXa1P0UDqq9SYECz--

--eShez4sA9GozNrE1TwSjsSaH1UjdQXiwe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4yt7IACgkQwj2R86El
/qjHCwf/Zf06YrEWSBeyhTXj6dP1HzoVq7fbtzbK4O9lZNzQN3Wxs3KIKSJUS3P1
rs0eIgOwVleME+/Qs3q+GjAyLlKN5Vz/vZQ7YxtvmKtT+pTCAuu9Nlh/ttw2/kgB
sugi6K78lQ2O+ZfSvARVmNNzoue02fJJQ7RWbdx9cbt/eA109GluvYVRCmMLES8/
EX8jcDiXHQj/yugIBp+pc6Rc9xCr1GP+zKEOcUb7416zz7NE4ZME1eyk9mUZtyrY
HJrddJvcBq5ndcpwS/N0XSAH3w3HONrEaSx+PmF+50e+kyfCUVWliCgmFkm4O71e
NCaNHAAd+YY1zMsY23nar6TfCX+NYA==
=KBcG
-----END PGP SIGNATURE-----

--eShez4sA9GozNrE1TwSjsSaH1UjdQXiwe--
