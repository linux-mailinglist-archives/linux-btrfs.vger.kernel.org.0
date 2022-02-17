Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44894BA08D
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Feb 2022 14:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiBQNDU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Feb 2022 08:03:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiBQNDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Feb 2022 08:03:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719FA2A8D04
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 05:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74CFBB8216D
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 13:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42814C36AE3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645102981;
        bh=QJX7LCs7V3GTC6yIrhnKrVdW/dH1gkt17iYnWktjOrY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qGKBW2XUz1cd761MK0iWnO4GwJddLVC6tF+6V/lGQ5PZes38uS9XvFMmuhuStDN/g
         aA9JTGFYKv9DIMq/ij08lfDKrm2vdv7DEcMZTl1X4v7H4JHe2NwmgCl9J0q07+4sIx
         LV7NDo9aUle1+uP/KGL9kgiZWvT8KFSgcGriA+PcttF1nHiGVvi0atBJEeo0gOkm7Q
         J8jzoTeWlvVIc66bwZTfwOQsJxYdwNKnUEz9rdBoiEauWNf/L+e6gBL1Iramr6f+ex
         cUaq9K0m8A6D7r2dzhccU7nyTDPE97EL9oGstc9QInpN5znt3I6gKb7hw+8gV09l2e
         1+A6r6zfFIK6A==
Received: by mail-qv1-f53.google.com with SMTP id d7so8019920qvk.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Feb 2022 05:03:01 -0800 (PST)
X-Gm-Message-State: AOAM5303W7gwKllKysDY5PScII/13Uz2IotBDkeXIOf8mKzWmX3GL/PH
        aaFBlPQf8hkDDPvlnAv4oQrf4d96wirBCufut44=
X-Google-Smtp-Source: ABdhPJycgfjByoQdNVw4YwYS3KRMXYk/rUX3qsnqH8AQdssuv8GrlIJuw7njJJYbXAOBKtTvV943JLTKZHGf2NpeXcE=
X-Received: by 2002:a05:622a:3cf:b0:2dd:57f6:f112 with SMTP id
 k15-20020a05622a03cf00b002dd57f6f112mr1078513qtx.522.1645102980209; Thu, 17
 Feb 2022 05:03:00 -0800 (PST)
MIME-Version: 1.0
References: <f0d4a789788e8e63041dc6d91408f40234daa329.1645091180.git.wqu@suse.com>
 <Yg4uFd40/Y5pQWt2@debian9.Home> <908e62ce-6b4c-b98c-8737-32111ddd7f96@gmx.com>
 <CAL3q7H6pbLvN80YjEZ4mXA7f6o=8oMZ2Drv_3gM0PmB-a9pb3A@mail.gmail.com> <9e08c09b-5190-8c77-90c0-b372ae294517@gmx.com>
In-Reply-To: <9e08c09b-5190-8c77-90c0-b372ae294517@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 17 Feb 2022 13:02:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6bZLPqGboFN9KDs717puFBXZ9Q-UknWxJ-sD9NZ9TpGw@mail.gmail.com>
Message-ID: <CAL3q7H6bZLPqGboFN9KDs717puFBXZ9Q-UknWxJ-sD9NZ9TpGw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: remove an ASSERT() which can cause false alert
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, Su Yue <l@damenly.su>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 17, 2022 at 1:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/2/17 20:32, Filipe Manana wrote:
> > On Thu, Feb 17, 2022 at 11:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2022/2/17 19:14, Filipe Manana wrote:
> >>> On Thu, Feb 17, 2022 at 05:49:34PM +0800, Qu Wenruo wrote:
> >>>> [BUG]
> >>>> Su reported that with his VM running on an M1 mac, it has a high chance
> >>>> to trigger the following ASSERT() with scrub and balance test cases:
> >>>>
> >>>>               ASSERT(cache->start == chunk_offset);
> >>>>               ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
> >>>>                                 dev_extent_len);
> >>>>
> >>>> [CAUSE]
> >>>> The ASSERT() is making sure that the block group cache (@cache) and the
> >>>> chunk offset from the device extent match.
> >>>>
> >>>> But the truth is, block group caches and dev extent items are deleted at
> >>>> different timing.
> >>>>
> >>>> For block group caches and items, after btrfs_remove_block_group() they
> >>>> will be marked deleted, but the device extent and the chunk item is
> >>>> still in dev tree and chunk tree respectively.
> >>>
> >>> This is not correct, what happens is:
> >>>
> >>> 1) btrfs_remove_chunk() will remove the device extent items and the chunk
> >>>      item;
> >>>
> >>> 2) It then calls btrfs_remove_block_group(). This will not remove the
> >>>      extent map if the block group was frozen (due to trim, and scrub
> >>>      itself). But it will remove the block group (struct btrfs_block_group)
> >>>      from the red black tree of block groups, and mark the block group
> >>>      as deleted (set struct btrfs_block_group::removed to 1).
> >>>
> >>>      If the extent map was not removed, meaning the block group is frozen,
> >>>      then no one will be able to create a new block group with the same logical
> >>>      address before the block group is unfrozen (by someone who is holding
> >>>      a reference on it). So a lookup on the red black tree will return NULL
> >>>      for the logical address until the block group is unfrozen and its
> >>>      logical address is reused for a new block group.
> >>>
> >>> So the ordering of what you are saying is reversed - the device extent
> >>> and chunk items are removed before marking the block group as deleted.
> >>>
> >>>>
> >>>> The device extents and chunk items are only deleted in
> >>>> btrfs_remove_chunk(), which happens either a btrfs_delete_unused_bgs()
> >>>> or btrfs_relocate_chunk().
> >>>
> >>> This is also confusing because it gives a wrong idea of the ordering.
> >>> The device extents and chunk items are removed by btrfs_remove_chunk(),
> >>> which happens before marking a block group as deleted.
> >>>
> >>>>
> >>>> This timing difference leaves a window where we can have a mismatch
> >>>> between block group cache and device extent tree, and triggering the
> >>>> ASSERT().
> >>>
> >>> I would like to see more details on this. The sequence of steps between
> >>> two tasks that result in this assertion being triggered.
> >>>
> >>>>
> >>>> [FIX]
> >>>>
> >>>> - Remove the ASSERT()
> >>>>
> >>>> - Add a quick exit if our found bg doesn't match @chunk_offset
> >>>
> >>> This shouldn't happen. I would like to know the sequence of steps
> >>> between 2 (or more) tasks that leads to that.
> >>>
> >>> We are getting the block group with btrfs_lookup_block_group() at
> >>> scrub_enumerate_chunks(), that calls block_group_cache_tree_search()
> >>> with the "contains" argument set to 1, meaning it can return a
> >>> block group that contains the given bytenr but does not start at
> >>> that bytenr necessarily.
> >>>
> >>> This gives me the idea a small block group was deleted and then a
> >>> new one was allocated which starts at a lower logical offset and
> >>> includes "chunk_offset" (ends beyond that).
> >>>
> >>> We should probably be using btrfs_lookup_first_block_group() at
> >>> scrub_enumerate_chunks(), so it looks for a block group that starts
> >>> exactly at the given logical address.
> >>>
> >>> But anyway, as I read this and see the patch's diff, this feels a lot
> >>> like a "bail out if something unexpected happens but we don't know
> >>> exactly why/how that is possible".
> >>
> >> You're completely correct.
> >>
> >> Unfortunately I have no way to reproduce the bug on x86_64 VMs, and all
> >> my ARM VMs are too slow to reproduce.
> >>
> >> Furthermore, due to some unrelated bugs, v5.17-rc based kernels all
> >> failed to boot inside the VMs on Apple M1.
> >>
> >> So unfortunately I don't have extra details for now.
> >>
> >> Will find a way to reproduce first, then update the patch with better
> >> comments.
> >
> > Was it triggered with some specific test case from fstests?
>
> Yes, from a regular run on fstests.

Ok, but which specific test(s)?

>
> But that was on an older branch (some older misc-next, which has the
> patch but still based on v5.16).
>
> The v5.17-rc based branch will not boot inside the ARM vm at all, and no
> early boot messages after the EFI routine.
>
> Will attack the boot problem first.
>
> Thanks,
> Qu
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>>>
> >>>> - Add a comment on the existing checks in scrub_chunk()
> >>>>     This is the ultimate safenet, as it will iterate through all the stripes
> >>>>     of the found chunk.
> >>>>     And only scrub the stripe if it matches both device and physical
> >>>>     offset.
> >>>>
> >>>>     So even by some how we got a dev extent which is no longer owned
> >>>>     by the target chunk, we will just skip this chunk completely, without
> >>>>     any consequence.
> >>>>
> >>>> Reported-by: Su Yue <l@damenly.su>
> >>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>> ---
> >>>> Changelog:
> >>>> v2:
> >>>> - Add a new quick exit with extra comments
> >>>>
> >>>> - Add a new comment in the existing safenet in scrub_chunk()
> >>>> ---
> >>>>    fs/btrfs/scrub.c | 21 ++++++++++++++++++++-
> >>>>    1 file changed, 20 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> >>>> index 11089568b287..1c3ed4720ddd 100644
> >>>> --- a/fs/btrfs/scrub.c
> >>>> +++ b/fs/btrfs/scrub.c
> >>>> @@ -3578,6 +3578,14 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
> >>>>               goto out;
> >>>>
> >>>>       map = em->map_lookup;
> >>>> +
> >>>> +    /*
> >>>> +     * Due to the delayed modification of device tree, this chunk
> >>>> +     * may not own this dev extent.
> >>>
> >>> This is confusing. What delayed modification, what do you mean by it
> >>> exactly? Same below, with more details.
> >>>
> >>>> +     *
> >>>> +     * So we need to iterate through all stripes, and only scrub
> >>>> +     * the stripe which matches both device and physical offset.
> >>>> +     */
> >>>>       for (i = 0; i < map->num_stripes; ++i) {
> >>>>               if (map->stripes[i].dev->bdev == scrub_dev->bdev &&
> >>>>                   map->stripes[i].physical == dev_offset) {
> >>>> @@ -3699,6 +3707,18 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
> >>>>               if (!cache)
> >>>>                       goto skip;
> >>>>
> >>>> +            /*
> >>>> +             * Since dev extents modification is delayed, it's possible
> >>>> +             * we got a bg which doesn't really own this dev extent.
> >>>
> >>> Same as before. Too confusing, what is delayed dev extent modification?
> >>>
> >>> Once added, device extents can only be deleted, they are never modified.
> >>> I think you are referring to the deletions and the fact we use the commit
> >>> roots to find extents, but that should be a more clear comment, without
> >>> such level of ambiguity.
> >>>
> >>> Thanks.
> >>>
> >>>> +             *
> >>>> +             * Here just do a quick skip, scrub_chunk() has a more
> >>>> +             * comprehensive check in it.
> >>>> +             */
> >>>> +            if (cache->start != chunk_offset) {
> >>>> +                    btrfs_put_block_group(cache);
> >>>> +                    goto skip;
> >>>> +            }
> >>>> +
> >>>>               if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
> >>>>                       spin_lock(&cache->lock);
> >>>>                       if (!cache->to_copy) {
> >>>> @@ -3822,7 +3842,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
> >>>>               dev_replace->item_needs_writeback = 1;
> >>>>               up_write(&dev_replace->rwsem);
> >>>>
> >>>> -            ASSERT(cache->start == chunk_offset);
> >>>>               ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
> >>>>                                 dev_extent_len);
> >>>>
> >>>> --
> >>>> 2.35.1
> >>>>
