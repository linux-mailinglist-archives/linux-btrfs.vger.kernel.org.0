Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13715B0FDE
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 00:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIGWfn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 18:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIGWfm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 18:35:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4325B7E011
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662590136;
        bh=GxKg9uoLa/tGN71ecePqvRVSX0p6GUQvFkhO5ZM4smk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jnFqJ2xciYpO2q6ys5pF69sRnEgUt3YfZOwJDiUkPF+vYzMXDtlB4GHtlzN8AmGkz
         ypu4+w039Z8S8rzd6otHefiF+UB+mlP3+oB271querwk/p1kpmwfoiiujVjN7ot8oJ
         3AWf/vLMKv1RJvp9np5HARIWmXR/mA/wv7WdHHTg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9Bu-1pBSOM0PLy-00oBRf; Thu, 08
 Sep 2022 00:35:36 +0200
Message-ID: <b09834f6-99c0-6253-4009-9975b5c2de88@gmx.com>
Date:   Thu, 8 Sep 2022 06:35:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs: don't update the block group item if used bytes
 are the same
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
 <YxirXjl1Ur3VV3B6@localhost.localdomain>
 <YxjVDY7jIH3Vv/il@localhost.localdomain>
 <8fe1128c-ebd9-87b6-a2ac-0a427223b456@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8fe1128c-ebd9-87b6-a2ac-0a427223b456@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yoNvqIvzrlkrIorhvHJwok3DfVahvYsV5hio7rOPM9j4NHyn44c
 WBJjW469bgnZkigvvEt7tVwT1FPy+9i5pHejVj8ETF8r0/9CWU/o74tyKFgbKHA9VHcKUxd
 S7se6kZj5CraL1P7StPjgj8OtIgl9yOfYIB77fWjPisgsZzesANzROPEDDH1pTtocVvE2OZ
 0uXDtN7Uh+etjWTZ+f5gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qZLF1Rhytio=:K6aKO7eUx4wTVvqIXTlnZr
 G+neQj+Mv2RWBpVZVTJdsDjgejtWjF2lBVpPVcEu54cqKBQxiB7m64Av0oSyB3sHZU+Cl86GB
 CP2XipMEoLgffPWUBYIR9WFng05vax7D49Tcqxo8R0MmF4lLAaDiaWrATjLJrIIpMKSff3c6I
 AFXPgxQzsZyiTDbMu6gDT3uPwdUW+qbGLu+dqv7uVQ6i28wFdUNySWKH49YjUGXqlkB8lhZxz
 x5F63U0oOZzHx53E9msRzJXCh+5ozOQtcegzvKOG14GSuYXG9IYV/jPJP2C4T07tcXQHSE0Uh
 lAcF7UbLlV/i/lVUPC6jV/5JrMdT1dQq5GlmeSliYsU8SeM/Yj8d4v6n2/BRWZ7x0jSCVI7kn
 Ea2GHWtY7NEOq2h9KX8qJ3Ev70/4YFzwp+2/Vn4kKqzje325zY4wczkVfA6lLtVqZFctxfV+H
 V49PD5Qo5FLsnGESVWX1Wzy4JyY90CUHrtfKd/BYXJYzhXaUOP7hFMBR3dv0X+lK96uzTxwFa
 2jzq9OXvFaFqRXa7SN7fRppFHwVoycofFD82lwgLPuZ3Z+AdxnBRwo3Q3Akl6gSaSnz4dQH9f
 7VmoIdgGSmcBLzEG3XpxTMZhtgReHJBRlbs1HlfTDcydD+4KtISkDt98CJOudZTcz68ie9oHw
 dsXiO32cqzqeWXuixi1H09oqMLWzyerUv4EPwOxAaWoyGsXkuIA3PN/WpLaetgMVU4Qw4ohUy
 Rg8uXAMmqx1AbzewzbRYxNugwr63EkD4ugLaq42kPKJT+HYXJMSoHvRIkrj5Kyh6JmPbxQ1pD
 HeMa9DR5PsOJ4u5XyO/eIiKX5E4veTFpFch/T1xI2K7W4/3xLkaRm+t2+PPY2gPWWyPsHUUTM
 ItPvnZWDbSVV6hpOU1igkzMZO3OVTF/2CkjDnuyRm3gtMxjVdhC0laEMUs8xm+W5ylz4mkUxK
 9pNHaOncWj8WUFsQfYS2l8nO6rlLoa1Trb90XRD7QUSEIuDJeQVLeTyxLi5+043QlsL0vFiML
 4O6s+j/6TtI6ajFtaTqX6YJIJPYDmMwrvoTUllwl3dea8f7r+5W4nBDku7w/Tu/neGqjPJMK+
 hl8pAPv/RyVIgxgK7n1zPUl/UsKZ/QanCbgmPsDG7dbQC5E+tgi6w883O4qdqUnc4dGZqKXPJ
 oBAttbYGL/N+p56CUUS5a9Ez10
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/8 06:20, Qu Wenruo wrote:
>
>
> On 2022/9/8 01:29, Josef Bacik wrote:
>> On Wed, Sep 07, 2022 at 10:31:58AM -0400, Josef Bacik wrote:
>>> On Mon, Jul 11, 2022 at 02:37:52PM +0800, Qu Wenruo wrote:
>>>> When committing a transaction, we will update block group items for a=
ll
>>>> dirty block groups.
>>>>
>>>> But in fact, dirty block groups don't always need to update their blo=
ck
>>>> group items.
>>>> It's pretty common to have a metadata block group which experienced
>>>> several CoW operations, but still have the same amount of used bytes.
>>>>
>>>> In that case, we may unnecessarily CoW a tree block doing nothing.
>>>>
>>>> This patch will introduce btrfs_block_group::commit_used member to
>>>> remember the last used bytes, and use that new member to skip
>>>> unnecessary block group item update.
>>>>
>>>> This would be more common for large fs, which metadata block group ca=
n
>>>> be as large as 1GiB, containing at most 64K metadata items.
>>>>
>>>> In that case, if CoW added and the deleted one metadata item near
>>>> the end
>>>> of the block group, then it's completely possible we don't need to
>>>> touch
>>>> the block group item at all.
>>>>
>>>> I don't have any benchmark to prove this, but this should not cause a=
ny
>>>> hurt either.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> I've been seeing random btrfs check failures on our overnight testing
>>> since this
>>> patch was merged.=C2=A0 I can't blame it directly yet, I've mostly see=
n it on
>>> TEST_DEV, and once while running generic/648.=C2=A0 I'm running it in =
a
>>> loop now to
>>> reproduce and then fix it.
>>>
>>> We can start updating block groups before we're in the critical
>>> section, so we
>>> can update block_group->bytes_used while we're updating the block
>>> group item in
>>> a different thread.=C2=A0 So if we set the block_group item to some va=
lue of
>>> bytes_used, then update it in another thread, and then set
>>> ->commit_used to the
>>> new value we'll fail to update the block group item with the correct
>>> value
>>> later.
>>>
>>> We need to wrap this bit in the block_group->lock to avoid this
>>> particular
>>> problem.=C2=A0 Once I reproduce and validate the fix I'll send that, b=
ut I
>>> wanted to
>>> reply in case that takes longer than I expect.=C2=A0 Thanks,
>>
>> Ok this is in fact the problem, this fixup made the problem go away.
>> Thanks,
>
> This fix means, a bg members can change even we are at
> update_block_group_item().
>
> The old code is completely relying on the one time access on cache->used=
.
>
> Anyway thanks for the fix.

So this is only happening if we execute
btrfs_start_dirty_block_groups(), which unlike
btrfs_write_dirty_block_groups(), is not yet protected by transaction
critical path.

Thus we can have bg members changing halfway and caused the race.


To David, do I need to send a updated version with extra comments on this?

Thanks,
Qu

>
> Thanks,
> Qu
>>
>> Josef
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 6e7bb1c0352d..1e2773b120d4 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2694,10 +2694,16 @@ static int update_block_group_item(struct
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *leaf;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_item bgi;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> +=C2=A0=C2=A0=C2=A0 u64 used;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No change in used bytes, can safely s=
kip it. */
>> -=C2=A0=C2=A0=C2=A0 if (cache->commit_used =3D=3D cache->used)
>> +=C2=A0=C2=A0=C2=A0 spin_lock(&cache->lock);
>> +=C2=A0=C2=A0=C2=A0 used =3D cache->used;
>> +=C2=A0=C2=A0=C2=A0 if (cache->commit_used =3D=3D used) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&cache->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 spin_unlock(&cache->lock);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.objectid =3D cache->start;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>> @@ -2712,13 +2718,14 @@ static int update_block_group_item(struct
>> btrfs_trans_handle *trans,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf =3D path->nodes[0];
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi =3D btrfs_item_ptr_offset(leaf, path-=
>slots[0]);
>> -=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_used(&bgi, cache->used)=
;
>> +
>> +=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_used(&bgi, used);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_chunk_object=
id(&bgi,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->global_root_id);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_flags(&bgi, =
cache->flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_extent_buffer(leaf, &bgi, bi, size=
of(bgi));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_mark_buffer_dirty(leaf);
>> -=C2=A0=C2=A0=C2=A0 cache->commit_used =3D cache->used;
>> +=C2=A0=C2=A0=C2=A0 cache->commit_used =3D used;
>> =C2=A0 fail:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(path);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
