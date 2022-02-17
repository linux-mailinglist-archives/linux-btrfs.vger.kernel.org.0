Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086204B9E80
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 12:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiBQLYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 06:24:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiBQLYo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 06:24:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B5A1285B5
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 03:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645097060;
        bh=WeSrBFSrr2arszxvytVUCLkoFPYQuyVobSU0SWCaZ6s=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cHcHrjQWjOWv1QGXUaBT+EESOXmIiKwBBDIiZqVAbvivjfounL/pOaVGbc0y2DVuh
         YS/Le6FV5XSTJm7kJIXh/yCFB7fRqyavq97FPSMupsyNBvNBfFqa3UU+JnTrtv2LNo
         FZvasjACaMf0GQzyNOurTalVaHmgprhn8VQHB378=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MO9zH-1nenFa2GXh-00Ob2u; Thu, 17
 Feb 2022 12:24:20 +0100
Message-ID: <908e62ce-6b4c-b98c-8737-32111ddd7f96@gmx.com>
Date:   Thu, 17 Feb 2022 19:24:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] btrfs: remove an ASSERT() which can cause false alert
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Su Yue <l@damenly.su>
References: <f0d4a789788e8e63041dc6d91408f40234daa329.1645091180.git.wqu@suse.com>
 <Yg4uFd40/Y5pQWt2@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yg4uFd40/Y5pQWt2@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gnKUNCChkwyWrygtehNkZzQ63PEbnyYHVFEmYcdXyHhub/IFBH3
 P5NJhxlopV2FYkc8d7mrAJ7BvROLYWAv15S9n7ADsa07to4T5plGHvymZSL9e0Zv0u1DOTM
 Z5iV5x2fe8sTmTp0iuzmEG8a3o4BhEh5Fy1xaK2ClgCMrwhXn0iGBuAlqu9NrGssdZSULhI
 pvDNuzv4cFO7jq+ACLLkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nqgoNKBi2Y0=:f3xTVdnOvNcLTE3HBGmXng
 DOO8fJn3Hei6+kUx26kv9rcFJDi4j23kewyw11nF1wP7lj8yiIEUPDwUz1unJ6/9gK6i8Aeu1
 dgtUyPO/dv75xWgrUq3uNdGX1QebdGzRasynEHWsCiD4NFF9T4GRohhJ9SLa1URRynJRsq9xZ
 TKB+elzk/snTE+0/9+ZIymMupOFhJCPo2vlydHrUbO1lVGBf9xHOyrboVztfUBGsszb49k2Vo
 ZuUrFhn3ZbWaRwXLV+gXpx6PjhCR4tuw4YLz7/jdwftb9qreStjjr1PRQVG7wb9+vcwHk7Kyc
 GRU0Ql/fT3L4EqUAbNbShFUI1QAr+7ZgWX9xFtvhfTkB9zpGprUyL/zAsw01U13zsohYYYoc+
 NzHYsdb4uH5BEDs0rd7V/Eo4zC9IdoBa+SOMq24lbhW+/s4xaZ092pmQA97R9DGDSkwRgqu4F
 Y8bDSFxEOPTyzF9iOnZYbXvh3G5VnehvGRzwLXTNCGZynVJ/Hv8+oI8anHmRRdICxtRa8+SwH
 Vb512985kNwaNf3Eaqk8Ydf/39T1Rma99591uQnTLD2yyNPDo7i/GIKNntvxr4OALDb8KtjWr
 kdbzMs3tah5yoHtrG3umErufsrwAma7+T/CGjpG5Q20MDsXbKsQmeAu318BRGGQR7gX/9U3Ss
 5SwgJuEthxysYLAQDu+1ux9OkydxZTuyGW3D/TY/+0W2u5RWsnFzPN4vtQbovzowqbZO027Sn
 dBdvJCSEiUDLKSez+LnJ2m/trytPtJyO95J43PPlkG10phyNhKwShR/VGry0bJLsovC3iiZ/D
 1TkA/r+O+NzNIdTogxNcsKb9aACJy5PQkpWik1q6jJsgckcUr2mtwzOK4TMSYW2CNqyivwB9K
 HdOvbJwAlwwqvyGBNdqGmf77lYAlt4yH5321TFcU9pHUsL01ItO1WPn1CkO730qB3aYx7rM+w
 3glULsXT2UuXBA9C++JEcW8GsZIXNN9w4WQBOslb4yh5QotUgX3CMlWImzuPRApGL1jaH3+6D
 NEvvZMdIrIQ0u6Y/tPDgU3DDjpMZKBIitj2B3xiBgvVgbQpelK2YrlxoYDGjb0aBZCaO+8JkI
 kj2yfNAmrm+zWo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/17 19:14, Filipe Manana wrote:
> On Thu, Feb 17, 2022 at 05:49:34PM +0800, Qu Wenruo wrote:
>> [BUG]
>> Su reported that with his VM running on an M1 mac, it has a high chance
>> to trigger the following ASSERT() with scrub and balance test cases:
>>
>> 		ASSERT(cache->start =3D=3D chunk_offset);
>> 		ret =3D scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
>> 				  dev_extent_len);
>>
>> [CAUSE]
>> The ASSERT() is making sure that the block group cache (@cache) and the
>> chunk offset from the device extent match.
>>
>> But the truth is, block group caches and dev extent items are deleted a=
t
>> different timing.
>>
>> For block group caches and items, after btrfs_remove_block_group() they
>> will be marked deleted, but the device extent and the chunk item is
>> still in dev tree and chunk tree respectively.
>
> This is not correct, what happens is:
>
> 1) btrfs_remove_chunk() will remove the device extent items and the chun=
k
>     item;
>
> 2) It then calls btrfs_remove_block_group(). This will not remove the
>     extent map if the block group was frozen (due to trim, and scrub
>     itself). But it will remove the block group (struct btrfs_block_grou=
p)
>     from the red black tree of block groups, and mark the block group
>     as deleted (set struct btrfs_block_group::removed to 1).
>
>     If the extent map was not removed, meaning the block group is frozen=
,
>     then no one will be able to create a new block group with the same l=
ogical
>     address before the block group is unfrozen (by someone who is holdin=
g
>     a reference on it). So a lookup on the red black tree will return NU=
LL
>     for the logical address until the block group is unfrozen and its
>     logical address is reused for a new block group.
>
> So the ordering of what you are saying is reversed - the device extent
> and chunk items are removed before marking the block group as deleted.
>
>>
>> The device extents and chunk items are only deleted in
>> btrfs_remove_chunk(), which happens either a btrfs_delete_unused_bgs()
>> or btrfs_relocate_chunk().
>
> This is also confusing because it gives a wrong idea of the ordering.
> The device extents and chunk items are removed by btrfs_remove_chunk(),
> which happens before marking a block group as deleted.
>
>>
>> This timing difference leaves a window where we can have a mismatch
>> between block group cache and device extent tree, and triggering the
>> ASSERT().
>
> I would like to see more details on this. The sequence of steps between
> two tasks that result in this assertion being triggered.
>
>>
>> [FIX]
>>
>> - Remove the ASSERT()
>>
>> - Add a quick exit if our found bg doesn't match @chunk_offset
>
> This shouldn't happen. I would like to know the sequence of steps
> between 2 (or more) tasks that leads to that.
>
> We are getting the block group with btrfs_lookup_block_group() at
> scrub_enumerate_chunks(), that calls block_group_cache_tree_search()
> with the "contains" argument set to 1, meaning it can return a
> block group that contains the given bytenr but does not start at
> that bytenr necessarily.
>
> This gives me the idea a small block group was deleted and then a
> new one was allocated which starts at a lower logical offset and
> includes "chunk_offset" (ends beyond that).
>
> We should probably be using btrfs_lookup_first_block_group() at
> scrub_enumerate_chunks(), so it looks for a block group that starts
> exactly at the given logical address.
>
> But anyway, as I read this and see the patch's diff, this feels a lot
> like a "bail out if something unexpected happens but we don't know
> exactly why/how that is possible".

You're completely correct.

Unfortunately I have no way to reproduce the bug on x86_64 VMs, and all
my ARM VMs are too slow to reproduce.

Furthermore, due to some unrelated bugs, v5.17-rc based kernels all
failed to boot inside the VMs on Apple M1.

So unfortunately I don't have extra details for now.

Will find a way to reproduce first, then update the patch with better
comments.

Thanks,
Qu

>
>>
>> - Add a comment on the existing checks in scrub_chunk()
>>    This is the ultimate safenet, as it will iterate through all the str=
ipes
>>    of the found chunk.
>>    And only scrub the stripe if it matches both device and physical
>>    offset.
>>
>>    So even by some how we got a dev extent which is no longer owned
>>    by the target chunk, we will just skip this chunk completely, withou=
t
>>    any consequence.
>>
>> Reported-by: Su Yue <l@damenly.su>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add a new quick exit with extra comments
>>
>> - Add a new comment in the existing safenet in scrub_chunk()
>> ---
>>   fs/btrfs/scrub.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 11089568b287..1c3ed4720ddd 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -3578,6 +3578,14 @@ static noinline_for_stack int scrub_chunk(struct=
 scrub_ctx *sctx,
>>   		goto out;
>>
>>   	map =3D em->map_lookup;
>> +
>> +	/*
>> +	 * Due to the delayed modification of device tree, this chunk
>> +	 * may not own this dev extent.
>
> This is confusing. What delayed modification, what do you mean by it
> exactly? Same below, with more details.
>
>> +	 *
>> +	 * So we need to iterate through all stripes, and only scrub
>> +	 * the stripe which matches both device and physical offset.
>> +	 */
>>   	for (i =3D 0; i < map->num_stripes; ++i) {
>>   		if (map->stripes[i].dev->bdev =3D=3D scrub_dev->bdev &&
>>   		    map->stripes[i].physical =3D=3D dev_offset) {
>> @@ -3699,6 +3707,18 @@ int scrub_enumerate_chunks(struct scrub_ctx *sct=
x,
>>   		if (!cache)
>>   			goto skip;
>>
>> +		/*
>> +		 * Since dev extents modification is delayed, it's possible
>> +		 * we got a bg which doesn't really own this dev extent.
>
> Same as before. Too confusing, what is delayed dev extent modification?
>
> Once added, device extents can only be deleted, they are never modified.
> I think you are referring to the deletions and the fact we use the commi=
t
> roots to find extents, but that should be a more clear comment, without
> such level of ambiguity.
>
> Thanks.
>
>> +		 *
>> +		 * Here just do a quick skip, scrub_chunk() has a more
>> +		 * comprehensive check in it.
>> +		 */
>> +		if (cache->start !=3D chunk_offset) {
>> +			btrfs_put_block_group(cache);
>> +			goto skip;
>> +		}
>> +
>>   		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
>>   			spin_lock(&cache->lock);
>>   			if (!cache->to_copy) {
>> @@ -3822,7 +3842,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx=
,
>>   		dev_replace->item_needs_writeback =3D 1;
>>   		up_write(&dev_replace->rwsem);
>>
>> -		ASSERT(cache->start =3D=3D chunk_offset);
>>   		ret =3D scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
>>   				  dev_extent_len);
>>
>> --
>> 2.35.1
>>
