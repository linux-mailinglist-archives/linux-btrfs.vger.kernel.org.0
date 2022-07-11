Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE08F56D8A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiGKIrf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiGKIrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 04:47:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E18F251
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657529249;
        bh=sHpNeYsfqP82oH8wLnNtpATi/2E8gHZtX2+7E6NJJGM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=OHrYuIyu4NKtLJqpI57Wl+cXs4Fd2fZNuQAuEOY7hjY3wg2V3Osv/CAZbx2BNhaKB
         jbmE1PO/gCmkf7WFxOJzlFHE5OqHqDnmAZJqZeDmPW/DLmAAG7G4t71eWnbYBHbT6k
         vjiD3b6buWQEViyfoRnGSCFbWq+ZDSSMN3mpHS5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GQs-1nX09w1I6y-014AuI; Mon, 11
 Jul 2022 10:47:28 +0200
Message-ID: <ab444642-8a17-cc97-8fff-3446d1ddef0e@gmx.com>
Date:   Mon, 11 Jul 2022 16:47:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: don't update the block group item if used bytes
 are the same
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <64e4434370badd801a79a782613c405830475dde.1657521468.git.wqu@suse.com>
 <5db1f702-f6fa-3b0e-e34b-30c7ac6358e4@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <5db1f702-f6fa-3b0e-e34b-30c7ac6358e4@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lc2TkuJzqy49+R/zkIIbJvN+WXkaZXwv+y7045r0dTbQJ1OiFJC
 7VlyJpGCY6mjwQYLO1pQMzSnev+iDNa0AhECaYYsmrq0gCv5njg3fCX+/zFCqNDjtUhGV2k
 Ujim5NxavX9GIwO8peFRZGKfUwVDhpuwvAIjGCchiyVzr2915PbWFN0FRWKqR9mXZHkBnpq
 WV96dQFQlDdoOv9Uxig3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sN+mO/zF6fw=:OUUSvl2Yte90u4XAbJByRr
 kAM1XnVUd8hl5nUhpTrRCt+UYdQyJUAiGQAv626bjgX5zV9dUzYSb+St3zJaqv6QK+1mxtM+X
 sk7Zfp95r41nPoFjh/2zfkHrn5LUmFvCourKXwoS9PZgTBNSiABQZioY04we4Q7Yn7Syx/nXk
 XrLvWLT+CMHy/JWV7+/tFu7z33ynfWXRgOZN557kCS5jap6RJT5pp/elwnCHOl7jwpcDqUktU
 hPRdIlPer1rCfDUwy/ZIqzf4+GB50En1Kg2htP+tgJ3C66bTI0CHlD+vhCORhjByx0zATsDBA
 OuPesyvaP1AblFOWx2Klvr6yqvk0pkKYKrIBPRfZQ9ecB3GHCYOwNEfKpPuAFoT6rdxl8uRPU
 xXdrSV8tTrirBv2CCyLqAZXFnEJhhizbGTA+s12PqCN0gjAXRcpafIZzFKhp3ZhBGmUp8ZZ5Q
 vGCIZP26e1JmDnhpGSlWbUeZusCU6TZMG5+ilrYcr7DfQildABXeld2ORUwCh5rxtJCR44W4e
 NC5Mv9KYHBHEDkwKg4IggR/r8eXl8TOOyKVR6yooxzXn0JU4eMXhWhMgIWrtJFkEPzCGLDW2F
 xvm3MFOeM6Keew7Bog5IcEuIVXYZ/Fwki4rWZZ0fuuRds/BkMxXfpCHufNjhovQtLm/nfzqL6
 GkTd9whbE6C0MOyUXe5nAfo1pu0y4tf33wuDkV+F1iq8nN/l4cVZ8Wm4VEJSuXg/M/0jAUwXU
 /Tiyt30NwEpTcGIeSJSdJfN0fiSRiCHp3y9ukTWPltC8+G1KZZcpfx9FvdY3HQmVBdUKlo1fj
 8lkkI3XMwsKDauaLIwfxYQIZYQDWwu/6b7Qroz5h7kzbPNrje4JUCYGYOhoV6Ts9VNE9Vmvk6
 Dac69X2XaAgMENJcq3K5cIMqphsxkFbXIwEV6aMAkBqdMduoJLRV7j9hCUSZfFBcCPfGkTmbw
 GzATqsZAg87iiJ2iVbnCrOc3+oHQY1Mqs3QRXb6Fk2dZ4ICBGQCjEnwWuo1F+Cmd2vO7JcLfX
 HhqzZFg2dYM+Bx25H4ZvVGkbNck+qxKQXOgY2HMiBFVmWg1xPDkn1QW09zhLydyL7cbm4bDxq
 ttSnKY3Rxju0VbNXMFPjL0sEP4aMGtTgEzPuUjBaFy0eJ+H+HAN4d6yaw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/11 16:30, Nikolay Borisov wrote:
>
>
> On 11.07.22 =D0=B3. 9:37 =D1=87., Qu Wenruo wrote:
>> When committing a transaction, we will update block group items for all
>> dirty block groups.
>>
>> But in fact, dirty block groups don't always need to update their block
>> group items.
>> It's pretty common to have a metadata block group which experienced
>> several CoW operations, but still have the same amount of used bytes.
>
> This could happen if for example the allocated/freed extents in a single
> transaction cancel each other out, right? Are there other cases where it
> could matter?

No need to completely cancel each other.

In fact, just COWing a path without adding/deleting new cousins would be
enough, and that would be very common for a lot of tree block operations.

>
>>
>> In that case, we may unnecessarily CoW a tree block doing nothing.
>>
>> This patch will introduce btrfs_block_group::commit_used member to
>> remember the last used bytes, and use that new member to skip
>> unnecessary block group item update.
>>
>> This would be more common for large fs, which metadata block group can
>> be as large as 1GiB, containing at most 64K metadata items.
>>
>> In that case, if CoW added and the deleted one metadata item near the e=
nd
>> of the block group, then it's completely possible we don't need to touc=
h
>> the block group item at all.
>>
>> I don't have any benchmark to prove this, but this should not cause any
>> hurt either.
>
> It should not but adds more state and is overall a maintenance burden.
> One way to test this would be to rig up the fs to count how many times
> the optimization has been hit over the course of, say, a full xfstest
> run or at least demonstrate a particular workload where this makes
> tangible difference.

But in this particular case, there is really not that much status to bothe=
r.

In fact, we don't care about if there is any status, we only care about
the block_group::used is different from committed one.
Even no change to lock schemes.

Thanks,
Qu
>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/block-group.c | 6 ++++++
>> =C2=A0 fs/btrfs/block-group.h | 6 ++++++
>> =C2=A0 2 files changed, 12 insertions(+)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 0148a6d719a4..5b08ac282ace 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -2024,6 +2024,7 @@ static int read_one_block_group(struct
>> btrfs_fs_info *info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->length =3D key->offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->used =3D btrfs_stack_block_group_=
used(bgi);
>> +=C2=A0=C2=A0=C2=A0 cache->commit_used =3D cache->used;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->flags =3D btrfs_stack_block_group=
_flags(bgi);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache->global_root_id =3D
>> btrfs_stack_block_group_chunk_objectid(bgi);
>> @@ -2724,6 +2725,10 @@ static int update_block_group_item(struct
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_block_group_item bgi;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> +=C2=A0=C2=A0=C2=A0 /* No change in used bytes, can safely skip it. */
>> +=C2=A0=C2=A0=C2=A0 if (cache->commit_used =3D=3D cache->used)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.objectid =3D cache->start;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D cache->length;
>> @@ -2743,6 +2748,7 @@ static int update_block_group_item(struct
>> btrfs_trans_handle *trans,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_stack_block_group_flags(&bgi, =
cache->flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_extent_buffer(leaf, &bgi, bi, size=
of(bgi));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_mark_buffer_dirty(leaf);
>> +=C2=A0=C2=A0=C2=A0 cache->commit_used =3D cache->used;
>> =C2=A0 fail:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(path);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
>> index 35e0e860cc0b..3f92b8eb9a05 100644
>> --- a/fs/btrfs/block-group.h
>> +++ b/fs/btrfs/block-group.h
>> @@ -74,6 +74,12 @@ struct btrfs_block_group {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 cache_generation;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 global_root_id;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The last committed used bytes of this block=
 group, if above @used
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * is still the same as @commit_used, we don't=
 need to update block
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * group item of this block group.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 u64 commit_used;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the free space extent count e=
xceeds this number, convert
>> the block
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * group to bitmaps.
