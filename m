Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916D507ECA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 04:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348578AbiDTC1I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 22:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348564AbiDTC1H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 22:27:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3E12E9F6
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 19:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650421456;
        bh=xlxounuiEbpJhkvm5JyAVg67z6XK4C2NakOCV2Dhw1E=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=gtZ7zj93E1A0TdYp+lskVR/Kfa9IgiYA9W+bHfz9zojO6Z84gQ4WVAZ1Pe8D4Pikk
         NoXFglej3C44ukUMpLaUYo6Fjz+SxD8VLTowDc76FAmCfqA+4uV7rikI+Ol1coXx/v
         5f7kBdDfmOZtcAP+H/vSyZzGRfqCnamjyWEp+1VY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkYXs-1oLEaP2vK2-00m0QL; Wed, 20
 Apr 2022 04:24:16 +0200
Message-ID: <d3490e45-da8d-7c02-4a2e-c580cf673338@gmx.com>
Date:   Wed, 20 Apr 2022 10:24:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] btrfs: fix assertion failure during scrub due to block
 group reallocation
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <e39beae941fdde3176fe75c35e273e39e0661f4b.1650374396.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e39beae941fdde3176fe75c35e273e39e0661f4b.1650374396.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F/RUhtSfp7xi22G0XeDSq2BiDp28aA+mA9//0tJ/cyymaRipZ4Y
 DY2zk6HxdQ0meZEHfNZkcP50wAaf5igGhd63Nc/W/jDM5ne8Y05RvlcYyFRHkSbeyCrGNuQ
 UuDbKeSEuDcWsuFreYqoi6+BwWbUvA/FPHuwKwgmOJInjuCmZf+a7x0T6U3AWGH8d50AgB+
 85sV27kNi9bzKvYLxiS2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o6Bmv2WIrbA=:hHHs+eE1mNYtCGfrw9clVf
 RE7Qhun/IUm2DHN53CMsVfggqfuwE7HoEpDB85MbhTV0tUxGmoIpx0R2mEbXZBGLqi6CNfuAv
 3s4pHDej1KccLguRftFqw5SF+WC89TvaAYEIeLVDV5Cs1rg+kC3IBi+rJzWbR6pKaKyusCpg5
 Tau95Dm8dLY84PrQlv8BN4/FY0St0PDt/Cz6k6B3uyCmcgqgPJw/waimvhRQAcP7vJH8or1Xx
 C4tOppzNYVmwiIjZN5c9VFrpDspEPBydTHc293Rx6xdvrEdVRP58rIW4KM/yBvt058cBsof74
 bEDA9Znj+PmhKK7fizVvQ4Z0CKTKcaUrg/jIpML4lAyHJk9y3OgiUvFl+vcn5u4irZsvRKhlZ
 Wf9+fUnwDfTOTIUUJ34SV8CNo3zLGa9Y0cTqthHMkGbISs6Wu8wjGVQhRQdlp+F2bvGYRvuqj
 u+8k0pY5vQEiT2+0OVkqbFrTZU4gC4/Z/56bBQNBrE6QFE5E46UnAtycZ4Js2YsF2iCI8g22A
 DZMs7GkvBGzecop9edfcEgUYHfz92m9Rs7pEYlkCIneATHqjxYbkmJkcMosm+f8us2GUpmN9w
 qtuv3w/NjXIa1KrO9qn5v1SI4RZdTW1VjtdjpmYf//c47KmcdGGRYuP1JZvn3xzgnkfJqR1IX
 e0fuo6E+I6yxHAyXrl153H+my8Gnz2Sa7aRoWFZv/cw3DzJRiTOCtEn3eC4SWW/uD8T/m7236
 tSaMPT/JyJBa419r1bX5mAXEs82kK0GMoDtrkTN/46+MzxfyVU4+I6btC55Q69wBGIIW1jHie
 bbZgi2+jlk3szXRCKh4KUAyMB4xmzsjh/QCfisN8dWkX+PHmt+l5jqAoV9DzO4n4TyZwtuEKI
 h2lhgiX4oJprH79e0HzDB24yaepOpgGNHMmPPq5aDTY8R+dUMIiCy75jm7nYk5FuOTl+QN2DF
 B+JJA5aLNOq1wPGGvTc5bi4OYRiNV6rfqUewAiITcF2RMKNmHGD8IXgq27MQ6bxilc4JuKeR3
 ErnFglzxMUzZl42WYHwhRXeI+eFiMQ2ylfQCwWsYrOqRMy/z06L3LMlUTAUHBvjKs9ETaMRt0
 G8ctm6Q8AWk4hg=
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/19 21:23, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> During a scrub, or device replace, we can race with block group removal
> and allocation and trigger the following assertion failure:
>
> [ 7526.385524] assertion failed: cache->start =3D=3D chunk_offset, in fs=
/btrfs/scrub.c:3817
> [ 7526.387351] ------------[ cut here ]------------
> [ 7526.387373] kernel BUG at fs/btrfs/ctree.h:3599!
> [ 7526.388001] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
> [ 7526.388970] CPU: 2 PID: 1158150 Comm: btrfs Not tainted 5.17.0-rc8-bt=
rfs-next-114 #4
> [ 7526.390279] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [ 7526.392430] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
> [ 7526.393520] Code: f3 48 c7 c7 20 (...)
> [ 7526.396926] RSP: 0018:ffffb9154176bc40 EFLAGS: 00010246
> [ 7526.397690] RAX: 0000000000000048 RBX: ffffa0db8a910000 RCX: 00000000=
00000000
> [ 7526.398732] RDX: 0000000000000000 RSI: ffffffff9d7239a2 RDI: 00000000=
ffffffff
> [ 7526.399766] RBP: ffffa0db8a911e10 R08: ffffffffa71a3ca0 R09: 00000000=
00000001
> [ 7526.400793] R10: 0000000000000001 R11: 0000000000000000 R12: ffffa0db=
4b170800
> [ 7526.401839] R13: 00000003494b0000 R14: ffffa0db7c55b488 R15: ffffa0db=
8b19a000
> [ 7526.402874] FS:  00007f6c99c40640(0000) GS:ffffa0de6d200000(0000) knl=
GS:0000000000000000
> [ 7526.404038] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7526.405040] CR2: 00007f31b0882160 CR3: 000000014b38c004 CR4: 00000000=
00370ee0
> [ 7526.406112] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
> [ 7526.407148] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
> [ 7526.408169] Call Trace:
> [ 7526.408529]  <TASK>
> [ 7526.408839]  scrub_enumerate_chunks.cold+0x11/0x79 [btrfs]
> [ 7526.409690]  ? do_wait_intr_irq+0xb0/0xb0
> [ 7526.410276]  btrfs_scrub_dev+0x226/0x620 [btrfs]
> [ 7526.410995]  ? preempt_count_add+0x49/0xa0
> [ 7526.411592]  btrfs_ioctl+0x1ab5/0x36d0 [btrfs]
> [ 7526.412278]  ? __fget_files+0xc9/0x1b0
> [ 7526.412825]  ? kvm_sched_clock_read+0x14/0x40
> [ 7526.413459]  ? lock_release+0x155/0x4a0
> [ 7526.414022]  ? __x64_sys_ioctl+0x83/0xb0
> [ 7526.414601]  __x64_sys_ioctl+0x83/0xb0
> [ 7526.415150]  do_syscall_64+0x3b/0xc0
> [ 7526.415675]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 7526.416408] RIP: 0033:0x7f6c99d34397
> [ 7526.416931] Code: 3c 1c e8 1c ff (...)
> [ 7526.419641] RSP: 002b:00007f6c99c3fca8 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000010
> [ 7526.420735] RAX: ffffffffffffffda RBX: 00005624e1e007b0 RCX: 00007f6c=
99d34397
> [ 7526.421779] RDX: 00005624e1e007b0 RSI: 00000000c400941b RDI: 00000000=
00000003
> [ 7526.422820] RBP: 0000000000000000 R08: 00007f6c99c40640 R09: 00000000=
00000000
> [ 7526.423906] R10: 00007f6c99c40640 R11: 0000000000000246 R12: 00007fff=
746755de
> [ 7526.424924] R13: 00007fff746755df R14: 0000000000000000 R15: 00007f6c=
99c40640
> [ 7526.425950]  </TASK>
>
> That assertion is relatively new, introduced with commit d04fbe19aefd2
> ("btrfs: scrub: cleanup the argument list of scrub_chunk()").
>
> The block group we get at scrub_enumerate_chunks() can actually have a
> start address that is smaller then the chunk offset we extracted from a
> device extent item we got from the commit root of the device tree.
> This is very rare, but it can happen due to a race with block group
> removal and allocation. For example, the following steps show how this
> can happen:
>
> 1) We are at transaction T, and we have the following blocks groups,
>     sorted by their logical start address:
>
>     [ bg A, start address A, length 1G (data) ]
>     [ bg B, start address B, length 1G (data) ]
>     (...)
>     [ bg W, start address W, length 1G (data) ]
>
>       --> logical address space hole of 256M,
>           there used to be a 256M metadata block group here
>
>     [ bg Y, start address Y, length 256M (metadata) ]
>
>        --> Y matches W's end offset + 256M
>
>     Block group Y is the block group with the highest logical address in
>     the whole filesystem;
>
> 2) Block group Y is deleted and its extent mapping is removed by the cal=
l
>     to remove_extent_mapping() made from btrfs_remove_block_group().
>
>     So after this point, the last element of the mapping red black tree,
>     its rightmost node, is the mapping for block group W;
>
> 3) While still at transaction T, a new data block group is allocated,
>     with a length of 1G. When creating the block group we do a call to
>     find_next_chunk(), which returns the logical start address for the
>     new block group. This calls returns X, which corresponds to the
>     end offset of the last block group, the rightmost node in the mappin=
g
>     red black tree (fs_info->mapping_tree), plus one.
>
>     So we get a new block group that starts at logical address X and wit=
h
>     a length of 1G. It spans over the whole logical range of the old blo=
ck
>     group Y, that was previously removed in the same transaction.
>
>     However the device extent allocated to block group X is not the same
>     device extent that was used by block group Y, and it also does not
>     overlap that extent, which must be always the case because we alloca=
te
>     extents by searching through the commit root of the device tree
>     (otherwise it could corrupt a filesystem after a power failure or
>     an unclean shutdown in general), so the extent allocator is behaving
>     as expected;
>
> 4) We have a task running scrub, currently at scrub_enumerate_chunks().
>     There it searches for device extent items in the device tree, using
>     its commit root. It finds a device extent item that was used by
>     block group Y, and it extracts the value Y from that item into the
>     local variable 'chunk_offset', using btrfs_dev_extent_chunk_offset()=
;

That perfectly explains the problem I hit.

Thank you very much for further pin down the cause.

>
>     It then calls btrfs_lookup_block_group() to find block group for
>     the logical address Y - since there's currently no block group that
>     starts at that logical address, it returns block group X, because
>     its range contains Y.
>
>     This results in triggering the assertion:
>
>        ASSERT(cache->start =3D=3D chunk_offset);
>
>     right before calling scrub_chunk(), as cache->start is X and
>     chunk_offset is Y.
>
> This is more likely to happen of filesystems not larger than 50G, becaus=
e
> for these filesystems we use a 256M size for metadata block groups and
> a 1G size for data block groups, while for filesystems larger than 50G,
> we use a 1G size for both data and metadata block groups (except for
> zoned filesystems). It could also happen on any filesystem size due to
> the fact that system block groups are always smaller (32M) than both
> data and metadata block groups, but these are not frequently deleted, so
> much less likely to trigger the race.
>
> So make scrub skip any block group with a start offset that is less than
> the value we expect, as that means it's a new block group that was creat=
ed
> in the current transaction. It's pointless to continue and try to scrub
> its extents, because scrub searches for extents using the commit root, s=
o
> it won't find any. For a device replace, skip it as well for the same
> reasons, and we don't need to worry about the possibility of extents of
> the new block group not being to the new device, because we have the wri=
te
> duplication setup done through btrfs_map_block().
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

The offending commit is relatively new, do we need to Cc to stable just
for v5.17 kernel?

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/dev-replace.c |  7 ++++++-
>   fs/btrfs/scrub.c       | 26 +++++++++++++++++++++++++-
>   2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 677b99e66c21..a7dd6ba25e99 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -707,7 +707,12 @@ static int btrfs_dev_replace_start(struct btrfs_fs_=
info *fs_info,
>
>   	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
>
> -	/* Commit dev_replace state and reserve 1 item for it. */
> +	/*
> +	 * Commit dev_replace state and reserve 1 item for it.
> +	 * This is crucial to ensure we won't miss copying extents for new blo=
ck
> +	 * groups that are allocated after we started the device replace, and
> +	 * must be done after setting up the device replace state.
> +	 */
>   	trans =3D btrfs_start_transaction(root, 1);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 13ba458c080c..b79a3221d7af 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3674,6 +3674,31 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx=
,
>   		if (!cache)
>   			goto skip;
>
> +		ASSERT(cache->start <=3D chunk_offset);
> +		/*
> +		 * We are using the commit root to search for device extents, so
> +		 * that means we could have found a device extent item from a
> +		 * block group that was deleted in the current transaction. The
> +		 * logical start offset of the deleted block group, stored at
> +		 * @chunk_offset, might be part of the logical address range of
> +		 * a new block group (which uses different physical extents).
> +		 * In this case btrfs_lookup_block_group() has returned the new
> +		 * block group, and its start address is less than @chunk_offset.
> +		 *
> +		 * We skip such new block groups, because it's pointless to
> +		 * process them, as we won't find their extents because we search
> +		 * for them using the commit root of the extent tree. For a device
> +		 * replace it's also fine to skip it, we won't miss copying them
> +		 * to the target device because we have the write duplication
> +		 * setup through the regular write path (by btrfs_map_block()),
> +		 * and we have committed a transaction when we started the device
> +		 * replace, right after setting up the device replace state.
> +		 */
> +		if (cache->start < chunk_offset) {
> +			btrfs_put_block_group(cache);
> +			goto skip;
> +		}
> +
>   		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
>   			spin_lock(&cache->lock);
>   			if (!cache->to_copy) {
> @@ -3797,7 +3822,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>   		dev_replace->item_needs_writeback =3D 1;
>   		up_write(&dev_replace->rwsem);
>
> -		ASSERT(cache->start =3D=3D chunk_offset);
>   		ret =3D scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
>   				  dev_extent_len);
>
