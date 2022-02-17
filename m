Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909664BA07D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 14:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbiBQNA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 08:00:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiBQNA1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 08:00:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62A8284212
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 05:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645102804;
        bh=EPH8ckVXUvqh5cHK5aWHxziwO4LMpQMmre7noZTTYvw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YgagUmTExRgGHe2SOGXpIha8dfvBp6btHCvGnlFGG8QqRiRjPh2T0gKxNgY3zY7sf
         OySeJocIl5kUHJzGfxu/EPvA0KvEwIzHEtqZqECQqyXW3LQuJLfhY79XGx2bBgukmY
         VSF03gz9PgTPd1qLz7OiHcRcK8X4O6+qBBlzl9b0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtwZ4-1o8Ffk06Vo-00uLLr; Thu, 17
 Feb 2022 14:00:04 +0100
Message-ID: <9e08c09b-5190-8c77-90c0-b372ae294517@gmx.com>
Date:   Thu, 17 Feb 2022 21:00:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] btrfs: remove an ASSERT() which can cause false alert
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, Su Yue <l@damenly.su>
References: <f0d4a789788e8e63041dc6d91408f40234daa329.1645091180.git.wqu@suse.com>
 <Yg4uFd40/Y5pQWt2@debian9.Home>
 <908e62ce-6b4c-b98c-8737-32111ddd7f96@gmx.com>
 <CAL3q7H6pbLvN80YjEZ4mXA7f6o=8oMZ2Drv_3gM0PmB-a9pb3A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H6pbLvN80YjEZ4mXA7f6o=8oMZ2Drv_3gM0PmB-a9pb3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fErKukLx5Q64gXjL1YUaGHFr/oXC4+82+avg3txlXktZbay7LIC
 esfvSrG82vnFWvHZZVpeuL+eZE+ZNVAaFUTDsvozRfAjWQgWqF70oJJYeLTdVNnokRH31g7
 nrXfU99GMll5OeaN4UAj1ip7G5soV5RDHdFmyMzj6U3absPxZqbCpHSWjle+ZC06HSP3pdT
 G/135UwzgneBtUb5oIPuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x5D/wdwyxEk=:TgVEOQR8IalWrgp2jf1NFb
 Ikx1mLklgQ20lO61L+dqC275coN/TH0B79dc378ekOMT0Q7s8zcTGgPvm7UaQgwf5D+RVdYCG
 EoPKnChs/+MsVDg0AXUFQ9//mypEKD3dyM852M5TtU6TOfpxAy1l5aM3bW0x+hGSnPwrZ4axG
 hfaI0e0lJVn268SUhdyvxEqGp2f6C7NRmUUUtgmC/1Wp6H0K+k/trPccwRrljMWtCx9x1ymJg
 3TKpY9dCGV3qEQtGkE5PkkD8zqbs9xjEl8HmEoFfTxgHux9TiVGHlobYS5pG/dF7ZeBDO7svm
 SDKmDhO+3dw/j7HTmUmtjJJw+/+FEzkKWLnKtUzrKA8pw2HdtXDbujq0EnEMZ89KLfjICYdy3
 qgPbvngczxxJ2UMslbOjfg62kwpdS7FkaRskDIJZk83yOsDNIvsLegoQ9r4wzFL4CvOVoA4hP
 QprTHUMb9IxtYmQ3SW6UOvuAEspRvQ7HuvFDtq1y8p9ttcoUop33MgonZriPojvgwippURcJA
 g50wraprjONJnkqC6PT654g/12SJMRtuXtuzoScSIwkqEhQokwgOJDDBIMbc+skca1WOfUloN
 qZ9C5pc+4AAoBnR8eQ7Jtz/XNmgyLqr/y8BolQGmQRGWoPv52JeG620MDVbjvOSq+Ba+WDTKO
 LlLNTIOfHmoNzv2QvtNxIVbWXwIYMMtgN5AG8ISGP0wPTdfNspPdCgy8ZzAfC3wlOVF2F72Ep
 cQ9Gqk7S7HJem4EAo4SOosgF2H8AJlKDIMBWL3ZQyaIxG5EImemXoBDdVLcbFW8KOKKm+EWoh
 m1NUtoeF4R89mSI3vES5EuwMiMZlf9owESR6H421RtFaBr8+FkIKTJ88YXkgrq7xczfyCo5Nc
 1T0pKSkNTux0XQ8ZFIE4P7WPYx0otpKgtRdmMwheobi33WVxV3zmxFyfuHZWAKOy7wHa4IyVI
 2X1gGZsvnA5ous6/NxWWuR5QWd/uMX2ZoIWXkhox1dnSjZPnwji13tRFTtfGH8y9YZOe7ust+
 HmF8FhU5gYA8ojCe5i3BkNsAkMzX58y8y8FY1c1feT9PCQiKmlrwDnDXVPnP5/ZQKljkYYlaM
 v9rUdYdScblsKc=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/17 20:32, Filipe Manana wrote:
> On Thu, Feb 17, 2022 at 11:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2022/2/17 19:14, Filipe Manana wrote:
>>> On Thu, Feb 17, 2022 at 05:49:34PM +0800, Qu Wenruo wrote:
>>>> [BUG]
>>>> Su reported that with his VM running on an M1 mac, it has a high chan=
ce
>>>> to trigger the following ASSERT() with scrub and balance test cases:
>>>>
>>>>               ASSERT(cache->start =3D=3D chunk_offset);
>>>>               ret =3D scrub_chunk(sctx, cache, scrub_dev, found_key.o=
ffset,
>>>>                                 dev_extent_len);
>>>>
>>>> [CAUSE]
>>>> The ASSERT() is making sure that the block group cache (@cache) and t=
he
>>>> chunk offset from the device extent match.
>>>>
>>>> But the truth is, block group caches and dev extent items are deleted=
 at
>>>> different timing.
>>>>
>>>> For block group caches and items, after btrfs_remove_block_group() th=
ey
>>>> will be marked deleted, but the device extent and the chunk item is
>>>> still in dev tree and chunk tree respectively.
>>>
>>> This is not correct, what happens is:
>>>
>>> 1) btrfs_remove_chunk() will remove the device extent items and the ch=
unk
>>>      item;
>>>
>>> 2) It then calls btrfs_remove_block_group(). This will not remove the
>>>      extent map if the block group was frozen (due to trim, and scrub
>>>      itself). But it will remove the block group (struct btrfs_block_g=
roup)
>>>      from the red black tree of block groups, and mark the block group
>>>      as deleted (set struct btrfs_block_group::removed to 1).
>>>
>>>      If the extent map was not removed, meaning the block group is fro=
zen,
>>>      then no one will be able to create a new block group with the sam=
e logical
>>>      address before the block group is unfrozen (by someone who is hol=
ding
>>>      a reference on it). So a lookup on the red black tree will return=
 NULL
>>>      for the logical address until the block group is unfrozen and its
>>>      logical address is reused for a new block group.
>>>
>>> So the ordering of what you are saying is reversed - the device extent
>>> and chunk items are removed before marking the block group as deleted.
>>>
>>>>
>>>> The device extents and chunk items are only deleted in
>>>> btrfs_remove_chunk(), which happens either a btrfs_delete_unused_bgs(=
)
>>>> or btrfs_relocate_chunk().
>>>
>>> This is also confusing because it gives a wrong idea of the ordering.
>>> The device extents and chunk items are removed by btrfs_remove_chunk()=
,
>>> which happens before marking a block group as deleted.
>>>
>>>>
>>>> This timing difference leaves a window where we can have a mismatch
>>>> between block group cache and device extent tree, and triggering the
>>>> ASSERT().
>>>
>>> I would like to see more details on this. The sequence of steps betwee=
n
>>> two tasks that result in this assertion being triggered.
>>>
>>>>
>>>> [FIX]
>>>>
>>>> - Remove the ASSERT()
>>>>
>>>> - Add a quick exit if our found bg doesn't match @chunk_offset
>>>
>>> This shouldn't happen. I would like to know the sequence of steps
>>> between 2 (or more) tasks that leads to that.
>>>
>>> We are getting the block group with btrfs_lookup_block_group() at
>>> scrub_enumerate_chunks(), that calls block_group_cache_tree_search()
>>> with the "contains" argument set to 1, meaning it can return a
>>> block group that contains the given bytenr but does not start at
>>> that bytenr necessarily.
>>>
>>> This gives me the idea a small block group was deleted and then a
>>> new one was allocated which starts at a lower logical offset and
>>> includes "chunk_offset" (ends beyond that).
>>>
>>> We should probably be using btrfs_lookup_first_block_group() at
>>> scrub_enumerate_chunks(), so it looks for a block group that starts
>>> exactly at the given logical address.
>>>
>>> But anyway, as I read this and see the patch's diff, this feels a lot
>>> like a "bail out if something unexpected happens but we don't know
>>> exactly why/how that is possible".
>>
>> You're completely correct.
>>
>> Unfortunately I have no way to reproduce the bug on x86_64 VMs, and all
>> my ARM VMs are too slow to reproduce.
>>
>> Furthermore, due to some unrelated bugs, v5.17-rc based kernels all
>> failed to boot inside the VMs on Apple M1.
>>
>> So unfortunately I don't have extra details for now.
>>
>> Will find a way to reproduce first, then update the patch with better
>> comments.
>
> Was it triggered with some specific test case from fstests?

Yes, from a regular run on fstests.

But that was on an older branch (some older misc-next, which has the
patch but still based on v5.16).

The v5.17-rc based branch will not boot inside the ARM vm at all, and no
early boot messages after the EFI routine.

Will attack the boot problem first.

Thanks,
Qu
>
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>> - Add a comment on the existing checks in scrub_chunk()
>>>>     This is the ultimate safenet, as it will iterate through all the =
stripes
>>>>     of the found chunk.
>>>>     And only scrub the stripe if it matches both device and physical
>>>>     offset.
>>>>
>>>>     So even by some how we got a dev extent which is no longer owned
>>>>     by the target chunk, we will just skip this chunk completely, wit=
hout
>>>>     any consequence.
>>>>
>>>> Reported-by: Su Yue <l@damenly.su>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Add a new quick exit with extra comments
>>>>
>>>> - Add a new comment in the existing safenet in scrub_chunk()
>>>> ---
>>>>    fs/btrfs/scrub.c | 21 ++++++++++++++++++++-
>>>>    1 file changed, 20 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>>> index 11089568b287..1c3ed4720ddd 100644
>>>> --- a/fs/btrfs/scrub.c
>>>> +++ b/fs/btrfs/scrub.c
>>>> @@ -3578,6 +3578,14 @@ static noinline_for_stack int scrub_chunk(stru=
ct scrub_ctx *sctx,
>>>>               goto out;
>>>>
>>>>       map =3D em->map_lookup;
>>>> +
>>>> +    /*
>>>> +     * Due to the delayed modification of device tree, this chunk
>>>> +     * may not own this dev extent.
>>>
>>> This is confusing. What delayed modification, what do you mean by it
>>> exactly? Same below, with more details.
>>>
>>>> +     *
>>>> +     * So we need to iterate through all stripes, and only scrub
>>>> +     * the stripe which matches both device and physical offset.
>>>> +     */
>>>>       for (i =3D 0; i < map->num_stripes; ++i) {
>>>>               if (map->stripes[i].dev->bdev =3D=3D scrub_dev->bdev &&
>>>>                   map->stripes[i].physical =3D=3D dev_offset) {
>>>> @@ -3699,6 +3707,18 @@ int scrub_enumerate_chunks(struct scrub_ctx *s=
ctx,
>>>>               if (!cache)
>>>>                       goto skip;
>>>>
>>>> +            /*
>>>> +             * Since dev extents modification is delayed, it's possi=
ble
>>>> +             * we got a bg which doesn't really own this dev extent.
>>>
>>> Same as before. Too confusing, what is delayed dev extent modification=
?
>>>
>>> Once added, device extents can only be deleted, they are never modifie=
d.
>>> I think you are referring to the deletions and the fact we use the com=
mit
>>> roots to find extents, but that should be a more clear comment, withou=
t
>>> such level of ambiguity.
>>>
>>> Thanks.
>>>
>>>> +             *
>>>> +             * Here just do a quick skip, scrub_chunk() has a more
>>>> +             * comprehensive check in it.
>>>> +             */
>>>> +            if (cache->start !=3D chunk_offset) {
>>>> +                    btrfs_put_block_group(cache);
>>>> +                    goto skip;
>>>> +            }
>>>> +
>>>>               if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
>>>>                       spin_lock(&cache->lock);
>>>>                       if (!cache->to_copy) {
>>>> @@ -3822,7 +3842,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sc=
tx,
>>>>               dev_replace->item_needs_writeback =3D 1;
>>>>               up_write(&dev_replace->rwsem);
>>>>
>>>> -            ASSERT(cache->start =3D=3D chunk_offset);
>>>>               ret =3D scrub_chunk(sctx, cache, scrub_dev, found_key.o=
ffset,
>>>>                                 dev_extent_len);
>>>>
>>>> --
>>>> 2.35.1
>>>>
