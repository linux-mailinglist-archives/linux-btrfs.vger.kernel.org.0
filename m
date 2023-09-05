Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C726791FCC
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 02:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbjIEAVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Sep 2023 20:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjIEAVh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Sep 2023 20:21:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF4F18C
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 17:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693873287; x=1694478087; i=quwenruo.btrfs@gmx.com;
 bh=iUTp3g1DkUm2gAPWL8eIA+FQYF4tDIgvlqxsLfe8vSs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=iK48XisRkiGA3y9f4/tfFCfXNrCF3AazH6G1FA4e7fwf1MBpDAuR68ZGgmcIh5wBJKstrRr
 +6zxjhWgya3sTLwxn4Y/MlfYmvVCN+GdtH6TOOcr306GU7GNPimc6h8k3KnamRcAj2TRVUVQ3
 dDFu9mz83mfQchSbTLmTd9ueesNKwJLAlEmmW/a96+lsNMEMccFn102C/cz1fJ66s5UMBP3Z1
 8ny/nbItFlC/6DEK+pn/qYAP+W/NZvoH2bJ+o8DeEa57WqB4WtvdMknbPwCjY/+eS25vLYWxm
 wwyITJMA3nIrlsJjw4OJ5u/qKtH9A+9sQ47275n0n9LcvPqTFBUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEFvp-1qTemh128r-00AH9p; Tue, 05
 Sep 2023 02:21:26 +0200
Message-ID: <993ff43e-744d-4807-8f29-1e70418a8cd4@gmx.com>
Date:   Tue, 5 Sep 2023 08:21:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix race between finishing block group creation
 and its item update
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <f5eda1ba8b7a776d3407d30939078b63d02aaff4.1693825574.git.fdmanana@suse.com>
 <2141e167-99ba-4a12-b053-af2cd7124a7a@gmx.com>
 <CAL3q7H4QR8aLRFtVOuhXoxSyFAdRJqCgvD7v9W=pNaUnLyKmhg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H4QR8aLRFtVOuhXoxSyFAdRJqCgvD7v9W=pNaUnLyKmhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4DRiM+shrXJ2G+IFkIsbem0u0eVA45jfWoqUddA36C4cNHyUvUa
 f5nSxvxo3Sj6qz4FUDA7TbZGUKe09Ow9s8v7L5KEUjngBRmAGuNUMUiaad45QdTHOp/imgl
 RDpMjmxJPhNjlLfCOgji+usOGs2DnW1UTqsuoFNstWkJV10g6u+Ndryc4qsk69OU250fpuF
 HWtC0C+IOGR6sPwJjcfYg==
UI-OutboundReport: notjunk:1;M01:P0:AQkT9cN3ejk=;sAvFJBb7IfvClW5z1+xCuUHgxVa
 ow4NMEHo72k5YadgAr6LBiqJGuvWJ7JgcOQE+9Cqby6qCuvB12kIItMmqj3VSQza3CrooY6/3
 qXvsgQo/xaQCazx3gA1KYixpMpSkZ0NFZnxDeZnGF2E4s1J6O2QYbkto8998/OW0FwZQDjxWv
 m/mm7GkE31zkMWwWqpV35unR92K0nWbEAMIi2wJB/u3w7uMLi9LyvODB46KzSbNlLiwPN9qTW
 maaSlMsHo78KGXVdt+ZYDhT6twRp6BSSvHUzxW5yJcHeiP7B0l1C8SAC2rlM8EOp6lNBv/6MT
 B5Rp8qoctPznwqmu2qwgEYbM+Zmrf5aYHKmtnqTjmSgwVCKsyRdA4nZE/6m/fIm4GG+nSzbHO
 7Y9esnwFzSGY962A9bJOyL1Yt7W0axdDRWqqppXLJZj1CixEw6QJL2+pBitmDbfeR61vtlzMw
 UYllU524CH/3V7OA2B6zZb5cvpqUS+sWCGHmWngchTtKdXyQHLfEcNzubUJKRD80HT4pjp06f
 NXJEb02qfYVjrn5J+7bBeurMGzfHleFH0RJmqIPu8MRzZu/Q3qJQuZfx3IWh/Uj4ShUJLl4wM
 aWGYrjXXFKccYmLMrrI2bAQ14CMhExcLu3nptekZoWelS/zTREmFEQ/Ty7XJGx+ihehpp7kJY
 jTMfByu7OkzKNLfz+z6Qxl/8H+oPTuqwcgjkc7PIxnsS38jil4Q9kuoqDOEWTjzcCgEkc/bfB
 7tlKU2U4ZmCsWLauJKOl4UuvwecwP1sh+gbZLdv9lJdps58Tw2qXR+TnJQ5XRGO/voS/XDiSJ
 f3aIC9T1JdjX/YD7o553XiWc/OLF/WYMMYZP5bvfs4zSN1o7+IW16ax1QBpJaI+qnthKhQJ3y
 p/xgJ3R0H5hiM5OyyHrWSfq26rIlfRDBMEWIraBo4Hgu0uIX1cj69DVUU2PhQbeU0ZSLut6qD
 Qo8vz+6yV8Z6BUWJevLE6Rk80s8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/4 21:26, Filipe Manana wrote:
> On Mon, Sep 4, 2023 at 1:22=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>
>>
>>
>> On 2023/9/4 19:10, fdmanana@kernel.org wrote:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Commit 675dfe1223a6 ("btrfs: fix block group item corruption after
>>> inserting new block group") fixed one race that resulted in not persis=
ting
>>> a block group's item when its "used" bytes field decreases to zero.
>>> However there's another race that can happen in a much shorter time wi=
ndow
>>> that results in the same problem. The following sequence of steps expl=
ains
>>> how it can happen:
>>>
>>> 1) Task A creates a metadata block group X, its "used" and "commit_use=
d"
>>>      fields are initialized to 0;
>>>
>>> 2) Two extents are allocated from block group X, so its "used" field i=
s
>>>      updated to 32K, and its "commit_used" field remains as 0;
>>>
>>> 3) Transaction commit starts, by some task B, and it enters
>>>      btrfs_start_dirty_block_groups(). There it tries to update the bl=
ock
>>>      group item for block group X, which currently has its "used" fiel=
d with
>>>      a value of 32K and its "commited_used" field with a value of 0. H=
owever
>>>      that fails since the block group item was not yet inserted, so at
>>>      update_block_group_item(), the btrfs_search_slot() call returns 1=
, and
>>>      then we set 'ret' to -ENOENT. Before jumping to the label 'fail'.=
..
>>>
>>> 4) The block group item is inserted by task A, when for example
>>>      btrfs_create_pending_block_groups() is called when releasing its
>>>      transaction handle. This results in insert_block_group_item() ins=
erting
>>>      the block group item in the extent tree (or block group tree), wi=
th a
>>>      "used" field having a value of 32K and setting "commit_used", in =
struct
>>>      btrfs_block_group, to the same value (32K);
>>>
>>> 5) Task B jumps to the 'fail' label and then resets the "commit_used"
>>>      field to 0. At btrfs_start_dirty_block_groups(), because -ENOENT =
was
>>>      returned from update_block_group_item(), we add the block group a=
gain
>>>      to the list of dirty block groups, so that we will try again in t=
he
>>>      critical section of the transaction commit when calling
>>>      btrfs_write_dirty_block_groups();
>>>
>>> 6) Later the two extents from block group X are freed, so its "used" f=
ield
>>>      becomes 0;
>>>
>>> 7) If no more extents are allocated from block group X before we get i=
nto
>>>      btrfs_write_dirty_block_groups(), then when we call
>>>      update_block_group_item() again for block group X, we will not up=
date
>>>      the block group item to reflect that it has 0 bytes used, because=
 the
>>>      "used" and "commit_used" fields in struct btrfs_block_group have =
the
>>>      same value, a value of 0.
>>>
>>>      As a result after committing the transaction we have an empty blo=
ck
>>>      group with its block group item having a 32K value for its "used"=
 field.
>>>      This will trigger errors from fsck ("btrfs check" command) and af=
ter
>>>      mounting again the fs, the cleaner kthread will not automatically=
 delete
>>>      the empty block group, since its "used" field is not 0. Possibly =
there
>>>      are other issues due to this incosistency.
>>>
>>>      When this issue happens, the error reported by fsck is like this:
>>>
>>>        [1/7] checking root items
>>>        [2/7] checking extents
>>>        block group [1104150528 1073741824] used 39796736 but extent it=
ems used 0
>>>        ERROR: errors found in extent allocation tree or chunk allocati=
on
>>>        (...)
>>>
>>> So fix this by not resetting the "commit_used" field of a block group =
when
>>> we don't find the block group item at update_block_group_item().
>>>
>>> Fixes: 7248e0cebbef ("btrfs: skip update of block group item if used b=
ytes are the same")
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Although considering we have hit at least two bugs around "commit_used"=
,
>> can we have a more generic way like setting "commit_used" to some
>> impossible values (e.g, U64_MAX) so that the bg is ensured to be update=
d?
>
> I don't see how initializing commit_used to U64_MAX, or anything else,
> would have prevented any of these two bugs...

I'm talking about something like this diff:

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0cb1dee965a0..c9b582bb7112 100644
=2D-- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3031,7 +3031,7 @@ static int update_block_group_item(struct
btrfs_trans_handle *trans,
         /* We didn't update the block group item, need to revert
@commit_used. */
         if (ret < 0) {
                 spin_lock(&cache->lock);
-               cache->commit_used =3D old_commit_used;
+               cache->commit_used =3D U64_MAX;
                 spin_unlock(&cache->lock);
         }
         return ret;

The analyze shows that at step 7), the original code would skip the
update as @commit_used is the same as @used, all 0.

But with above diff, we would be forced to update the block group item
no matter what.

And with this change, if there is some unexpected return value we didn't
take into consideration, it would still act as a safenet, as the next
time the block group would still be updated.

Thanks,
Qu
>
>>
>> Thanks,
>> Qu
>>> ---
>>>    fs/btrfs/block-group.c | 12 ++++++++++--
>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>> index 0cb1dee965a0..b2e5107b7cec 100644
>>> --- a/fs/btrfs/block-group.c
>>> +++ b/fs/btrfs/block-group.c
>>> @@ -3028,8 +3028,16 @@ static int update_block_group_item(struct btrfs=
_trans_handle *trans,
>>>        btrfs_mark_buffer_dirty(leaf);
>>>    fail:
>>>        btrfs_release_path(path);
>>> -     /* We didn't update the block group item, need to revert @commit=
_used. */
>>> -     if (ret < 0) {
>>> +     /*
>>> +      * We didn't update the block group item, need to revert commit_=
used
>>> +      * unless the block group item didn't exist yet - this is to pre=
vent a
>>> +      * race with a concurrent insertion of the block group item, wit=
h
>>> +      * insert_block_group_item(), that happened just after we attemp=
ted to
>>> +      * update. In that case we would reset commit_used to 0 just aft=
er the
>>> +      * insertion set it to a value greater than 0 - if the block gro=
up later
>>> +      * becomes with 0 used bytes, we would incorrectly skip its upda=
te.
>>> +      */
>>> +     if (ret < 0 && ret !=3D -ENOENT) {
>>>                spin_lock(&cache->lock);
>>>                cache->commit_used =3D old_commit_used;
>>>                spin_unlock(&cache->lock);
