Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466625B59AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiILLxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiILLxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 07:53:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904DF3C8E9
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662983579;
        bh=DctC49GBqs+ikkxc+r5j67+jjfV7TxB1kzyZchzuNww=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=gPHcGzyieLe/Nu+H3Z3GIoAgICu7eUwbJiRXQqfMzwbt4HnJhumEkTYvR8TgVpbPe
         weFkujEm9leygz1XdbGb064rVnjFGsOZNUpzz1XidOdwlMyPssnmQ6NLv2ciuCIPQv
         J31Nzy29nKdF1gJpi2RvI48bQDee/oxuLpYKI+u0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8ygY-1oRdiW0iUY-0065K9; Mon, 12
 Sep 2022 13:52:58 +0200
Message-ID: <edc41634-3e58-33a2-e1a3-9f137be49534@gmx.com>
Date:   Mon, 12 Sep 2022 19:52:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <d1da73f6ed291d53d4cc7dcab142ebfb0541f06e.1662730491.git.josef@toxicpanda.com>
 <20220912095907.GA269395@falcondesktop>
 <0a2ffcd7-148b-e64b-5c9c-dc901c968e10@gmx.com>
 <CAL3q7H4kq28Y5TK+jJ-OE7L3vSQej5iBgSfS62Xk=gySg-BXmg@mail.gmail.com>
 <c2a2b438-531f-5e56-24e4-f383eb9f53ac@gmx.com>
 <CAL3q7H79PnrhgWQDgozcJ0p0eqPT5EMd54KBO+XGZ9nD_mZ6zw@mail.gmail.com>
 <794bed84-f665-2509-b655-4f6dac05237e@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY
In-Reply-To: <794bed84-f665-2509-b655-4f6dac05237e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dI+vklJigzKh9wweemtzYvXrRrhmTr5lxY5nirNDuk6j1pK7Rp6
 6e8LL0CfpjsesEDuOiL7xnb9EROHopVcZQLVJNTy/kMF96FbX57YpDDPOf5ufIz5ehfU5me
 nd5AzyOOW5Koi4QlrIwlBVtf72aVe5FAnuPpcCMHTAU8JHT1Uy8F1ntDZACUOq/flpdnA4X
 e2CAirQnSQQ9RC9vrlp/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jTOewr5c2gg=:lcHmtQPQUSEZUHcoDUgA3H
 raY7f8gZALU7BtGPdKlmMocN373R+5kmNm9VBHZVB6xqmIFi/NZlXHh+lOH5B6PPtrSDKjbjk
 BXhHaUroGrbUSVvYX26zFmBZs4CqICjZ63WFYpy7thpUjVW71j8HpmZbZJIJJkAbZLeB2HyfM
 FDlkkv6uH9+S0cg/6NU9P72WGatZUDyHn2nwd3e6Dw+WGYRuZBiqNCU6veD2grsCcVXj+m1cZ
 vkvnTkxfkVtsNG9UN5vYSXMBOTJNQ08TQ3k4AYScj0gnO/GICrakKksSruWm84Om+KIYcilrE
 2xvnRROwy7+0P1bPIsOF/I3mjfKTD1AzA+CdUl8tUX5bg4XE9313ba87Ex0/z+8rPImopTMfU
 aiM75nmCcMtY98CuFX4AWzDUk3kNKbMLJ6xdHZ1oAkuh1cCMj2Lx5GXggy3kuiouNtaPNdpJU
 wVyKtXso98K/KXoQHaY+wpuNlnZKThYSsiWoYBAVSk6/crxUOcwRR9dXFZST0oH64B/33iKvE
 eY9q4YNWuxo/3tGUhcEU+FIfmuG5bLrIQ/ZTumkPsPdvE5pZH++jkQJT23Mgs97XhLSG3B0Nj
 gQwVSxyp0Vgl2sq74TvMttVL2c2hXO46Ks3X1NZBK70QBCZKBr2TFwhk0ra/ZLPCJGJDSI5Z2
 x8RJ/yo9pB1Gd8lfs9hGqvZTNUUkwqiQCxkh3CPYKiH8C8xdinkUPzf4Aavz3Fpbidt2VGYvm
 /N2Qc7PHLscGWjXNFog5RqDxb6Ybm4eileld6DwZaPqWKjB66ldtKD5OuJ9Va1qk7oOVQn/mj
 GkSVlORU4m8E/npgp7yzS+TBgiCHbvtl9yqoQlu4JaARGZDNGNM8M/ovPln2iZgEfZrVVtrqz
 aoBUtR8hK2PBI4vOvtHQKUvcxLUgUcCFyUeON27dQivq4HxrcJDSU3uSUlqNFU2NGTm7cJ2AB
 7SxNEvPjq2xvdIveCA8LCS4OgKVpd+286j2s1KR3nPPQtD4K60UeQeBXWbEfc6kgRLaJy+M9L
 rsExL/tNCheFZrikUfk3ZRWj02iGwEdLuw84Q0lo6yTH6gxAcNGSFt+6GJxxEuN5lBtB8ZmoY
 vIDLIPjOrgrvDDoPb4dgJurx6l2mF8mzoLjIURuaBsQF74ZpFzqehH8+ltqg2WOx/AXQU8UYV
 VQG1TEkBszaNGftUVkeOltoi3E
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/12 19:31, Qu Wenruo wrote:
>
>
> On 2022/9/12 19:21, Filipe Manana wrote:
>> On Mon, Sep 12, 2022 at 12:02 PM Qu Wenruo <quwenruo.btrfs@gmx.com>
>> wrote:
>>>
>>>
>>>
>>> On 2022/9/12 18:42, Filipe Manana wrote:
>>>> On Mon, Sep 12, 2022 at 11:26 AM Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2022/9/12 17:59, Filipe Manana wrote:
>>>>>> On Fri, Sep 09, 2022 at 09:35:01AM -0400, Josef Bacik wrote:
>>>>>>> Inside of FB, as well as some user reports, we've had a consistent
>>>>>>> problem of occasional ENOSPC transaction aborts.=C2=A0 Inside FB w=
e were
>>>>>>> seeing ~100-200 ENOSPC aborts per day in the fleet, which is a
>>>>>>> really
>>>>>>> low occurrence rate given the size of our fleet, but it's not
>>>>>>> nothing.
>>>>>>>
>>>>>>> There are two causes of this particular problem.
>>>>>>>
>>>>>>> First is delayed allocation.=C2=A0 The reservation system for dela=
lloc
>>>>>>> assumes that contiguous dirty ranges will result in 1 file extent
>>>>>>> item.
>>>>>>> However if there is memory pressure that results in fragmented
>>>>>>> writeout,
>>>>>>> or there is fragmentation in the block groups, this won't
>>>>>>> necessarily be
>>>>>>> true.=C2=A0 Consider the case where we do a single 256MiB write to=
 a
>>>>>>> file and
>>>>>>> then close it.=C2=A0 We will have 1 reservation for the inode upda=
te, the
>>>>>>> reservations for the checksum updates, and 1 reservation for the
>>>>>>> file
>>>>>>> extent item.=C2=A0 At some point later we decide to write this ent=
ire
>>>>>>> range
>>>>>>> out, but we're so fragmented that we break this into 100
>>>>>>> different file
>>>>>>> extents.=C2=A0 Since we've already closed the file and are no long=
er
>>>>>>> writing
>>>>>>> to it there's nothing to trigger a refill of the delalloc block
>>>>>>> rsv to
>>>>>>> satisfy the 99 new file extent reservations we need.=C2=A0 At this
>>>>>>> point we
>>>>>>> exhaust our delalloc reservation, and we begin to steal from the
>>>>>>> global
>>>>>>> reserve.=C2=A0 If you have enough of these cases going in parallel=
 you
>>>>>>> can
>>>>>>> easily exhaust the global reserve, get an ENOSPC at
>>>>>>> btrfs_alloc_tree_block() time, and then abort the transaction.
>>>>>>
>>>>>> There's also another problem I pointed out in the past regarding
>>>>>> delalloc
>>>>>> reservations. The thing is that we assume for each ordered extent,
>>>>>> the new
>>>>>> file extent item will require changing only 1 leaf in the
>>>>>> subvolume tree.
>>>>>>
>>>>>> If our new extent has a size of 128M and currently for that range w=
e
>>>>>> have 32768 extents each with a size of 4K, then we need to touch 15=
7
>>>>>> leaves in order to drop those file extent items before inserting
>>>>>> the new
>>>>>> one at ordered extent completion. And our reservation that
>>>>>> happened at
>>>>>> buffered write time only accounted for 1 leaf/path for file extent
>>>>>> items
>>>>>> (plus 1 for the inode item). This is assuming the default leaf
>>>>>> size of 16K,
>>>>>> where we can have at most 208 file extent items per leaf.
>>>>>>
>>>>>> If we have just a single ordered extent triggering this case we
>>>>>> probably
>>>>>> won't reach -ENOSPC and a transaction abort, as we end up
>>>>>> consuming from
>>>>>> the global reserve and that may be able to satisfy our space needs.
>>>>>> However with multiple ordered extents hitting such cases of
>>>>>> insufficient
>>>>>> reserved space, and other tasks doing other things and consuming
>>>>>> from the
>>>>>> global reserve, then the chances of hitting -ENOSPC at
>>>>>> btrfs_finish_ordered_io()
>>>>>> become very high, leading to a transaction abort there.
>>>>>
>>>>> In fact, I'm also considering these problems, and for the highly
>>>>> fragmented free space case (and other cases like delayed refs
>>>>> generated
>>>>> delayed refs case), can we let btrfs itself to learn from last
>>>>> (several)
>>>>> delalloc (delayed refs) runs to generate an overall idea on how
>>>>> fragmented the free space is.
>>>>
>>>> That won't help for the case I described, because it has nothing to
>>>> do with
>>>> fragmentation.
>>>
>>> Isn't it?
>>
>> It isn't.
>>
>>>
>>> We have a 128MiB range dirtied, and we only reserve enough metadata fo=
r
>>> one ordered extent since at write/dirty time they are continous.
>>>
>>> But then we only have a bunch of 4K fragmented free extents, every tim=
e
>>> btrfs_reserve_extent() can only return a 4K extent for data.
>>>
>>> Aren't the two cases the same?
>>
>> Nop. That's the case Josef mentioned.
>>
>> In what I mentioned we have 1 ordered extent, say 128M for example.
>> So there were no issues with free space fragmentation.
>>
>> What I was saying, and I believe it was explicit enough, is that for
>> that file
>> range we have 32K 4K file extent items, so at finish ordered io, we
>> have to
>> drop all those file extent items before inserting the new one (the
>> 128M one).
>> And 32K spans much more than 1 leaf (path) - 157/158 leaves in case of
>> a 16K leaf/node size.
>
> OK, I see the problem now, it's in the drop time, not the reserve time,
> which I completely ignored previously...

But wait for a min, although this is indeed a problem for our current
btrfs_drop_extents(), it's less serious than the one mentioned by Josef
at reserve time.

The net result (for that subvolume tree at least) is, we should have
much less tree blocks needed for the subvolume.

Thus if we enhance btrfs_drop_extents() to locate the first leave and
the last leave, we can drop all the file extents extents between the two
leaves, without always doing the COW for 100+ leaves.

Although the delayed refs will be another huge problem...
We can only hope all these 32K extents are near each other, or we're
doomed again...

Thanks,
Qu
>
> Thanks,
> Qu
>
>>
>> See the problem?
>> At dealloc time we assume that to insert/replace the new extent item,
>> we will touch
>> only 1 leaf - only one path.
>>
>> This of course is not a problem if we are writing into a previously
>> unallocated file
>> range.
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> There's also other case where more than 1 ordered extent is created,
>>>> but
>>>> at reservation time we think it's only 1 ordered extent - compression=
,
>>>> it will split
>>>> into many 128K ordered extents. Again, this one has nothing do with
>>>> fragmentation.
>>>>
>>>>>
>>>>> Then round (down) that value for write/dirty time delalloc
>>>>> reservation?
>>>>>
>>>>> The same can go to delayed refs reservation too.
>>>>>
>>>>> If by somehow, the delayed refs are generating more than expected
>>>>> delayed refs, we increase the pre-reserved space accordingly.
>>>>>
>>>>>
>>>>>
>>>>> Another less dynamic method (but still the same idea) is to
>>>>> introduce a
>>>>> doomsday mode.
>>>>>
>>>>> In that mode, every time we need to reserve space for delalloc, we
>>>>> consider the extent can only be at most 4K, double the pre-reserve f=
or
>>>>> delayed refs etc.
>>>>>
>>>>> But I'm afraid this can only reduce, but not really eliminate the
>>>>> ENOSPC
>>>>> at critical path.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> The other case is the delayed refs reserve.=C2=A0 The delayed refs
>>>>>>> reserve
>>>>>>> updates its size based on outstanding delayed refs and dirty block
>>>>>>> groups.=C2=A0 However we only refill this block reserve when retur=
ning
>>>>>>> excess reservations and when we call
>>>>>>> btrfs_start_transaction(root, X).
>>>>>>> We will reserve 2*X credits at transaction start time, and fill in=
 X
>>>>>>> into the delayed refs reserve to make sure it stays topped off.
>>>>>>> Generally this works well, but clearly has downsides.=C2=A0 If we =
do a
>>>>>>> particularly delayed ref heavy operation we may never catch up in
>>>>>>> our
>>>>>>> reservations.=C2=A0 Additionally running delayed refs generates mo=
re
>>>>>>> delayed
>>>>>>> refs, and at that point we may be committing the transaction and
>>>>>>> have no
>>>>>>> way to trigger a refill of our delayed refs rsv.=C2=A0 Then a simi=
lar
>>>>>>> thing
>>>>>>> occurs with the delalloc reserve.
>>>>>>>
>>>>>>> Generally speaking we well over-reserve in all of our block
>>>>>>> rsvs.=C2=A0 If we
>>>>>>> reserve 1 credit we're usually reserving around 264k of space,
>>>>>>> but we'll
>>>>>>> often not use any of that reservation, or use a few blocks of that
>>>>>>> reservation.=C2=A0 We can be reasonably sure that as long as you w=
ere
>>>>>>> able to
>>>>>>> reserve space up front for your operation you'll be able to find
>>>>>>> space
>>>>>>> on disk for that reservation.
>>>>>>
>>>>>> That's another elephant in the room. We assume that if a task
>>>>>> reserves
>>>>>> space, it will be able to allocate that space later.
>>>>>>
>>>>>> There are several things that can happen which will result in not
>>>>>> being
>>>>>> able to allocate space we reserved before:
>>>>>>
>>>>>> 1) Discard/fitrim - it removes a free space entry, does the
>>>>>> discard, and
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 after that it adds back the free spa=
ce entry. If all the
>>>>>> available space
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is in such an entry being discarded,=
 the task fails to
>>>>>> allocate space;
>>>>>>
>>>>>> 2) fsync - it joins a transaction, doesn't reserve space and
>>>>>> starts allocating
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 space for tree blocks, without ever =
reserving space (because
>>>>>> we want it
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to be fast and for most cases we don=
't know in advance, or
>>>>>> can estimate,
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 how many tree blocks we will need to=
 allocate). So it can
>>>>>> steal space that
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 was reserved by some other task;
>>>>>>
>>>>>> 3) Scrub - scrub temporarily turns a block group into RO mode - if
>>>>>> all the
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 available space was in that block gr=
oup, than when the task
>>>>>> tries to
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 allocate it will fail because the bl=
ock group is now RO;
>>>>>
>>>>> Yes, that's one concern of the existing per-dev scrub.
>>>>> If we have 10 devices, all single profiles, then we may mark 10 bloc=
k
>>>>> groups RO at once, hugely increase the chance of ENOSPC.
>>>>>
>>>>>>
>>>>>> 4) During space reservation we only check if free space counters.
>>>>>> There
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 may be block groups with plenty of f=
ree space but their
>>>>>> profile is not
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible, so when trying to alloca=
te an extent we are
>>>>>> forced to allocate
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a new block group with the necessary=
 profile, which will
>>>>>> fail if there's
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not enough unallocated space.
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This mostly affects degraded mode on=
ly (hopefully).
>>>>>
>>>>> This is still pretty common, for RAID1 usage especially one device i=
s
>>>>> just slightly (like 10MiB) larger than the other.
>>>>>
>>>>> The metadata over-reserve still believe we can allocate new
>>>>> metadata bg,
>>>>> but nope, and hit a ENOSPC at critical path.
>>>>>
>>>>> IIRC I had some very old patches for the problem, but haven't update=
d
>>>>> for a long time.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> I documented these at btrfs_chunk_alloc() sometime ago, but there
>>>>>> are a few
>>>>>> more similar cases.
>>>>>>
>>>>>>>
>>>>>>> So introduce a new flushing state,
>>>>>>> BTRFS_RESERVE_FLUSH_EMERGENCY.=C2=A0 This
>>>>>>> gets used in the case that we've exhausted our reserve and the
>>>>>>> global
>>>>>>> reserve.=C2=A0 It simply forces a reservation if we have enough ac=
tual
>>>>>>> space
>>>>>>> on disk to make the reservation, which is almost always the
>>>>>>> case.=C2=A0 This
>>>>>>> keeps us from hitting ENOSPC aborts in these odd occurrences
>>>>>>> where we've
>>>>>>> not kept up with the delayed work.
>>>>>>>
>>>>>>> Fixing this in a complete way is going to be relatively
>>>>>>> complicated and
>>>>>>> time consuming.=C2=A0 This patch is what I discussed with Filipe
>>>>>>> earlier this
>>>>>>> year, and what I put into our kernels inside FB.=C2=A0 With this p=
atch
>>>>>>> we're
>>>>>>> down to 1-2 ENOSPC aborts per week, which is a significant
>>>>>>> reduction.
>>>>>>> This is a decent stop gap until we can work out a more wholistic
>>>>>>> solution to these two corner cases.
>>>>>>
>>>>>> Well, it's a lot more than 2 corner cases :)
>>>>>>
>>>>>> The change looks fine to me, it's simple and it should help reduce
>>>>>> the
>>>>>> frequency of several ENOSPC cases. So,
>>>>>>
>>>>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>>>> ---
>>>>>>> =C2=A0=C2=A0=C2=A0 fs/btrfs/block-rsv.c=C2=A0 | 12 ++++++++++++
>>>>>>> =C2=A0=C2=A0=C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 18 ++++++++++++++++++
>>>>>>> =C2=A0=C2=A0=C2=A0 fs/btrfs/space-info.c | 27 ++++++++++++++++++++=
++++++-
>>>>>>> =C2=A0=C2=A0=C2=A0 3 files changed, 56 insertions(+), 1 deletion(-=
)
>>>>>>>
>>>>>>> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
>>>>>>> index ec96285357e0..89e3e7d1bff6 100644
>>>>>>> --- a/fs/btrfs/block-rsv.c
>>>>>>> +++ b/fs/btrfs/block-rsv.c
>>>>>>> @@ -552,5 +552,17 @@ struct btrfs_block_rsv
>>>>>>> *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!ret)
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
global_rsv;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * All hope is lost, but of course our re=
servations are overly
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * pessimistic, so instead of possibly ha=
ving an ENOSPC
>>>>>>> abort here, try
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * one last time to force a reservation i=
f there's enough
>>>>>>> actual space
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * on disk to make the reservation.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_reserve_metadata_bytes(fs_info, =
block_rsv,
>>>>>>> blocksize,
>>>>>>> +
>>>>>>> BTRFS_RESERVE_FLUSH_EMERGENCY);
>>>>>>> +=C2=A0=C2=A0=C2=A0 if (!ret)
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return block_rsv;
>>>>>>> +
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(ret);
>>>>>>> =C2=A0=C2=A0=C2=A0 }
>>>>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>>>>> index 0108585d838d..f221b3cb718d 100644
>>>>>>> --- a/fs/btrfs/ctree.h
>>>>>>> +++ b/fs/btrfs/ctree.h
>>>>>>> @@ -2986,6 +2986,24 @@ enum btrfs_reserve_flush_enum {
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Can be interrupted by=
 a fatal signal.
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_RESERVE_FLUSH_ALL_STEAL=
,
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This is for btrfs_use_block_rsv only.=
=C2=A0 We have exhausted
>>>>>>> our block
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * rsv and our global block rsv.=C2=A0 Th=
is can happen for things
>>>>>>> like
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * delalloc where we are overwriting a lo=
t of extents with a
>>>>>>> single
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * extent and didn't reserve enough space=
.=C2=A0 Alternatively it
>>>>>>> can happen
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * with delalloc where we reserve 1 exten=
ts worth for a
>>>>>>> large extent but
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * fragmentation leads to multiple extent=
s being created.
>>>>>>> This will
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * give us the reservation in the case of
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * if (num_bytes < (space_info->total_byt=
es -
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_spac=
e_info_used(space_info, false))
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Which ignores bytes_may_use.=C2=A0 Thi=
s is potentially
>>>>>>> dangerous, but our
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reservation system is generally pessim=
istic so is able to
>>>>>>> absorb this
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * style of mistake.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> +=C2=A0=C2=A0=C2=A0 BTRFS_RESERVE_FLUSH_EMERGENCY,
>>>>>>> =C2=A0=C2=A0=C2=A0 };
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0 enum btrfs_flush_state {
>>>>>>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>>>>>>> index 2e06b7c422c7..a0abc6dd01c2 100644
>>>>>>> --- a/fs/btrfs/space-info.c
>>>>>>> +++ b/fs/btrfs/space-info.c
>>>>>>> @@ -1583,6 +1583,16 @@ static inline bool can_steal(enum
>>>>>>> btrfs_reserve_flush_enum flush)
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 flush =3D=3D BTRFS_RESERVE_FLUSH_EVICT);
>>>>>>> =C2=A0=C2=A0=C2=A0 }
>>>>>>>
>>>>>>> +/*
>>>>>>> + * NO_FLUSH and FLUSH_EMERGENCY don't want to create a ticket,
>>>>>>> they just want to
>>>>>>> + * fail as quickly as possible.
>>>>>>> + */
>>>>>>> +static inline bool can_ticket(enum btrfs_reserve_flush_enum flush=
)
>>>>>>> +{
>>>>>>> +=C2=A0=C2=A0=C2=A0 return (flush !=3D BTRFS_RESERVE_NO_FLUSH &&
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 flush !=3D BTRFS_RESERVE_FLUSH_EMERGENCY);
>>>>>>> +}
>>>>>>> +
>>>>>>> =C2=A0=C2=A0=C2=A0 /**
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 * Try to reserve bytes from the block_rsv=
's space
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 *
>>>>>>> @@ -1644,6 +1654,21 @@ static int __reserve_bytes(struct
>>>>>>> btrfs_fs_info *fs_info,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>
>>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Things are dire, we need to make a res=
ervation so we
>>>>>>> don't abort.=C2=A0 We
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * will let this reservation go through a=
s long as we have
>>>>>>> actual space
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * left to allocate for the block.
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ret && unlikely(flush =3D=3D BTRFS_RESERVE=
_FLUSH_EMERGENCY)) {
>>>>>>
>>>>>> Does the unlikely() really makes any difference in this context?
>>>>>>
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 used =3D btrfs_space_info_used(space_info, false);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (used + orig_bytes <=3D
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 writable_total_bytes(fs_info, space_info)) {
>>>>>>> +
>>>>>>> btrfs_space_info_update_bytes_may_use(fs_info, space_info,
>>>>>>> +
>>>>>>> orig_bytes);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>> +
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we couldn't make a=
 reservation then setup our
>>>>>>> reservation ticket
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and kick the async wo=
rker if it's not already running.
>>>>>>> @@ -1651,7 +1676,7 @@ static int __reserve_bytes(struct
>>>>>>> btrfs_fs_info *fs_info,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we are a priority =
flusher then we just need to add
>>>>>>> our ticket to
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the list and we will =
do our own flushing further down.
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>> -=C2=A0=C2=A0=C2=A0 if (ret && flush !=3D BTRFS_RESERVE_NO_FLUSH) =
{
>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ret && can_ticket(flush)) {
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ticket.bytes =3D orig_bytes;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ticket.error =3D 0;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 space_info->reclaim_size +=3D ticket.bytes;
>>>>>>> --
>>>>>>> 2.26.3
>>>>>>>
