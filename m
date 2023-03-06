Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2346ABBE8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Mar 2023 11:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCFKXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Mar 2023 05:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCFKXQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Mar 2023 05:23:16 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559B011B
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Mar 2023 02:23:14 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLi8m-1pqnP91sxc-00Hfxf; Mon, 06
 Mar 2023 11:23:08 +0100
Message-ID: <46a4023e-f55f-d118-2092-34f48c514b6e@gmx.com>
Date:   Mon, 6 Mar 2023 18:23:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <257397e78b93bcb888daec01c1e02be87cd4dee7.1678097398.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: fix block group item corruption after inserting
 new block group
In-Reply-To: <257397e78b93bcb888daec01c1e02be87cd4dee7.1678097398.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:op/9ywGkVsve9WF2BaTksOXpUET7uSAGZhCD6bSTqxkU+9IUoOT
 S/Cb3Xv60aH1/T68EQhi24gwSiQFhPZRg/H1vW+H91q/msy9qqaebZUnHjohrjCCCVd904D
 n3pvdNewA9VhRglIgjxINJghqzWY7U70e7rkVm5/dMtblEdfPucWMf4Z24HSFLpiJLSqBUf
 eidGnd2QEfLjV/JrRErOg==
UI-OutboundReport: notjunk:1;M01:P0:G7H1i+cUKcM=;75Fb4+xEie7sjUslhmif4UhDxAo
 M7aCjmyxTmYqYN1kXriTJtygFNi6cgt/BU3aILhjg/5tZ9mo5Q2UnNcfW1Gy6xfsWijczqJmn
 EM7+cdunxgOa3tNhhIN3yt7Uha3zBTR12qKwpTEpR+BqnN3rDalQ6JxLipK5m8X0Z1ejXVmkK
 WnvDSmxQQ+xE6qdmpEAdt7BpC2b3zCIJ0QVbQvGYnzcIqh5NtIuwVQFgdzB96Hl1guV4ZAdXd
 HzFvvgaliAVRzGN0KekYyePq3m3YRurORLUrMfpR3+b8qQLeLkS0McyWL0jgC7wHWG9jdLJ86
 7i6EDRhxdNRPlzb/ztevYig37agj5CV+PibW7R6XllWnjSFhpGlc6VfHSLCyXlPFHnHYkMZVl
 lce21ZjycSVRd7ZBG703WJSH8ONZgpRV8EGFvWZWIBaUqpreJCwXvVhGwtEWKECiggkFI2Sc1
 zTbPf/KpG14ajVVEj70HK7eGKHvQmOh2iW7aCSkyY3a1Wq9QKM1GvABESrk6a2Use3XMkQtbJ
 WMckgAxROUnLmPX0tp18yIq6yuumKyPClP/duxA9leQNu0s+Up6/daaaWHYTFi0c9rI8zayCB
 hajdXYGOEcCuosri914Ua0qIa7gpfaPsUzinOLL1Q/wsEzbMxGEkdmUT5anRRsUqlK+xxvhdG
 FVbtTyMTEXp1TNLRJCStGOD8GxLzS6qIHKmYEIJgqGJWE7U1E+1+W1+S8efSJ2zBynyrjf5hR
 yq5j8Tl2fN9NJAmavu7zfYtb+GfsnH9THUoss+ECDK48oCcWMN11kI9Xv7J9BuP9tYz150NbY
 68fci+0mAE1tk4DR7kkKrOEHd6Mv0fEO2pzx+YPkOrm0uJ0LnFWs/xg1VXKxz8MUCJCDHrCXA
 g8RB+DjI2KozU2CBiHL8Pb3SaZ1ris4X6nBoDoS+iVozmnwf28k+E1eBnNdlH0JMN0tiN+vCO
 Pjd/Dt7uCAAk8IJkZul7/e1rktE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/6 18:13, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We can often end up inserting a block group item, for a new block group,
> with a wrong value for the used bytes field.
> 
> This happens if for the new allocated block group, in the same transaction
> that created the block group, we have tasks allocating extents from it as
> well as tasks removing extents from it.
> 
> For example:
> 
> 1) Task A creates a metadata block group X;
> 
> 2) Two extents are allocated from block group X, so its "used" field is
>     updated to 32K, and its "commit_used" field remains as 0;
> 
> 3) Transaction commit starts, by some task B, and it enters
>     btrfs_start_dirty_block_groups(). There it tries to update the block
>     group item for block group X, which currently has its "used" field with
>     a value of 32K. But that fails since the block group item was not yet
>     inserted, and so on failure update_block_group_item() sets the
>     "commit_used" field of the block group back to 0;
> 
> 4) The block group item is inserted by task A, when for example
>     btrfs_create_pending_block_groups() is called when releasing its
>     transaction handle. This results in insert_block_group_item() inserting
>     the block group item in the extent tree (or block group tree), with a
>     "used" field having a value of 32K, but without updating the
>     "commit_used" field in the block group, which remains with value of 0;
> 
> 5) The two extents are freed from block X, so its "used" field changes
>     from 32K to 0;
> 
> 6) The transaction commit by task B continues, it enters
>     btrfs_write_dirty_block_groups() which calls update_block_group_item()
>     for block group X, and there it decides to skip the block group item
>     update, because "used" has a value of 0 and "commit_used" has a value
>     of 0 too.
> 
>     As a result, we end up with a block item having a 32K "used" field but
>     no extents allocated from it.
> 
> When this issue happens, a btrfs check reports an error like this:
> 
>     [1/7] checking root items
>     [2/7] checking extents
>     block group [1104150528 1073741824] used 39796736 but extent items used 0
>     ERROR: errors found in extent allocation tree or chunk allocation
>     (...)
> 
> Fix this by making insert_block_group_item() update the block group's
> "commit_used" field.
> 
> Fixes: 7248e0cebbef ("btrfs: skip update of block group item if used bytes are the same")
> CC: stable@vger.kernel.org # 6.2+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for pinning down the bug, I hit it several times randomly but 
didn't even consider it's related to that commit.

The last several runs hitting can be found here in btrfs/073:

https://h.anonymoususers.xyz:8443/results/details/btrfs-rock5b-global/2023-03-05T18:37:09/index.html

Thanks,
Qu
> ---
>   fs/btrfs/block-group.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index fd11d03a50ff..953e9547ca07 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2493,18 +2493,29 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
>   	struct btrfs_block_group_item bgi;
>   	struct btrfs_root *root = btrfs_block_group_root(fs_info);
>   	struct btrfs_key key;
> +	u64 old_commit_used;
> +	int ret;
>   
>   	spin_lock(&block_group->lock);
>   	btrfs_set_stack_block_group_used(&bgi, block_group->used);
>   	btrfs_set_stack_block_group_chunk_objectid(&bgi,
>   						   block_group->global_root_id);
>   	btrfs_set_stack_block_group_flags(&bgi, block_group->flags);
> +	old_commit_used = block_group->commit_used;
> +	block_group->commit_used = block_group->used;
>   	key.objectid = block_group->start;
>   	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>   	key.offset = block_group->length;
>   	spin_unlock(&block_group->lock);
>   
> -	return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
> +	ret = btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
> +	if (ret < 0) {
> +		spin_lock(&block_group->lock);
> +		block_group->commit_used = old_commit_used;
> +		spin_unlock(&block_group->lock);
> +	}
> +
> +	return ret;
>   }
>   
>   static int insert_dev_extent(struct btrfs_trans_handle *trans,
