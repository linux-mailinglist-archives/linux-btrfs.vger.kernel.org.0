Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492A567F000
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 21:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjA0U4W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 15:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjA0U4T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 15:56:19 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A1618A82
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 12:56:18 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C66955C008E;
        Fri, 27 Jan 2023 15:56:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 27 Jan 2023 15:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674852977; x=1674939377; bh=q2aEmyY/D6
        jmoqjF6Alh9uAD5vBV2QQ0Q7ft2bXiZKc=; b=dTW/klxAIwo5ovz5+X6VRUFCBh
        2Vb2YtsR7sNDopw7cjfBq/t/RzFW7t7RBjyBmcdhZTRUZ4O4Jq7IAd193BtYi5GM
        J2vg9HragU5pftMoKIIvVsbYt7mM4f9DSxIu3rU0trmSEdq2DgBznrDUWDYHA7D3
        oKpwWcTCOpZhUIQFi5t2WYgTsvKLLZAY2iXloVHLWiZNgJU0uKWwGtBCMliu7qV+
        g5guxxVxvc2Zx7WDp2M63x5G4tx+xAknBKnQsE/9aiJs/0ynuFBsJvOTBzb1WR1K
        /V2wF4/83FB9DRU94xSc8frcpCDXInrgz+BWvfexGuaOHqW1n77IMMpnlsYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674852977; x=1674939377; bh=q2aEmyY/D6jmoqjF6Alh9uAD5vBV
        2QQ0Q7ft2bXiZKc=; b=r72C0UH7AqSi08lhu+0BdTdELc5SdbNCN5Fb3nsbi1Zk
        cgQV3n2Y/aL7Z1iHEEz/xdXc4tKPv5o/Rp6PLJ5aoQIGprm/RUISzto7gLSNu+y+
        khgyDjDpfeqQjiLSgvK7n2BPRi4IMHR0UbneBd6WjMD0QA+kIwWwCQUyaSo6SqiU
        IUwrOkNvFpDUQPqby8UHwFpONCKtpz2Og3kZdHEd5vbhhy8l/g/U40OJcs3FYt1r
        ontvng7Ffv0S/kyIRLc5ionXccxNJPfDrapZJjpG1zuAZFBKt8dipvEBPiMgCtX2
        wdtS8D/rqwaxzRQpC+4jECUcAl6Z2+2cospE73nkLQ==
X-ME-Sender: <xms:cTrUYwR8WZuj4toG9nEaIxEX8ZpPdwM1mneSKw1GQE3AnPtFqSqZFA>
    <xme:cTrUY9yBK57py6uCUxtKYT-YPqF48YAdD0NePJ58c9szYq8ay3uxOhrDnW1xJXKC6
    STCyBKal9SmhWqOVkY>
X-ME-Received: <xmr:cTrUY91KYuWpq-cqzGK3wSVuiRrZtQBU9XQXsAbbU8-m-DAgGj19i9Ef>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:cTrUY0Dau-i87v9KoYGl6VxUCWZ0IQBOhdf5AiaRBpbtJr1Bz643tA>
    <xmx:cTrUY5gxVc3FCZ3huIjVhbsLuVJ8k19K6Da6KPlQfT6DEEI3_JOtlg>
    <xmx:cTrUYwpK2wCrBdkyF3tsq7Yo63owiB-odg5imIKunMkjGW41D-uYog>
    <xmx:cTrUY5IGadtNblzj7WarFYpvjUOYNpRzel94y5vjIz-N1Ll_TqCosg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jan 2023 15:56:17 -0500 (EST)
Date:   Fri, 27 Jan 2023 12:56:15 -0800
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: avoid unnecessary extent tree search for
 simple stripes
Message-ID: <Y9Q6bxJ5g9oF3REv@zen>
References: <e8b3a59de5f43c185427a8d87c303ba3e8ff6ff1.1673244671.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b3a59de5f43c185427a8d87c303ba3e8ff6ff1.1673244671.git.wqu@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 09, 2023 at 02:11:15PM +0800, Qu Wenruo wrote:
> [BUG]
> When scrubing an empty fs with RAID0, we will call scrub_simple_mirror()
> again and again on ranges which has no extent at all.
> 
> This is especially obvious if we have both RAID0 and SINGLE.
> 
>  # mkfs.btrfs -f -m single -d raid0 $dev
>  # mount $dev $mnt
>  # xfs_io -f -c "pwrite 0 4k" $mnt/file
>  # sync
>  # btrfs scrub start -B $mnt
> 
> With extra call trace on scrub_simple_mirror(), we got the following
> trace:
> 
>   256.028473: scrub_simple_mirror: logical=1048576 len=4194304 bg=1048576 bg_len=4194304
>   256.028930: scrub_simple_mirror: logical=5242880 len=8388608 bg=5242880 bg_len=8388608
>   256.029891: scrub_simple_mirror: logical=22020096 len=65536 bg=22020096 bg_len=1073741824
>   256.029892: scrub_simple_mirror: logical=22085632 len=65536 bg=22020096 bg_len=1073741824
>   256.029893: scrub_simple_mirror: logical=22151168 len=65536 bg=22020096 bg_len=1073741824
>   ... 16K lines skipped ...
>   256.048777: scrub_simple_mirror: logical=1095630848 len=65536 bg=22020096 bg_len=1073741824
>   256.048778: scrub_simple_mirror: logical=1095696384 len=65536 bg=22020096 bg_len=1073741824
> 
> The first two lines shows we just call scrub_simple_mirror() for the
> metadata and system chunks once.
> 
> But later 16K lines are all scrub_simple_mirror() for the almost empty
> RAID0 data block group.
> 
> Most of the calls would exit very quickly since there is no extent in
> that data chunk.
> 
> [CAUSE]
> For RAID0/RAID10 we go scrub_simple_stripe() to handle the scrub for the
> block group. And since inside each stripe it's just plain SINGLE/RAID1,
> thus we reuse scrub_simple_mirror().
> 
> But there is a pitfall, that inside scrub_simple_mirror() we will do at
> least one extent tree search to find the extent in the range.
> 
> Just like above case, we can have a huge gap which has no extent in them
> at all.
> In that case, we will do extent tree search again and again, even we
> already know there is no more extent in the block group.
> 
> [FIX]
> To fix the super inefficient extent tree search, we introduce
> @found_next parameter for the following functions:
> 
> - find_first_extent_item()
> - scrub_simple_mirror()
> 
> If the function find_first_extent_item() returns 1 and @found_next
> pointer is provided, it will store the bytenr of the bytenr of the next
> extent (if at the end of the extent tree, U64_MAX is used).
> 
> So for scrub_simple_stripe(), after scrubing the current stripe and
> increased the logical bytenr, we check if our next range reaches
> @found_next.
> 
> If not, increase our @cur_logical by our increment until we reached
> @found_next.
> 
> By this, even for an almost empty RAID0 block group, we just execute
> "cur_logical += logical_increment;" 16K times, not doing tree search 16K
> times.
> 
> With the optimization, the same trace looks like this now:
> 
>   1283.376212: scrub_simple_mirror: logical=1048576 len=4194304 bg=1048576 bg_len=4194304
>   1283.376754: scrub_simple_mirror: logical=5242880 len=8388608 bg=5242880 bg_len=8388608
>   1283.377623: scrub_simple_mirror: logical=22020096 len=65536 bg=22020096 bg_len=1073741824
>   1283.377625: scrub_simple_mirror: logical=67108864 len=65536 bg=22020096 bg_len=1073741824
>   1283.377627: scrub_simple_mirror: logical=67174400 len=65536 bg=22020096 bg_len=1073741824
> 
> Note the scrub at logical 67108864, that's because the 4K write only
> lands there, not at the beginning of the data chunk (due to super block
> reserved space split the 1G chunk into two parts).
> 
> And the time duration of the chunk 22020096 is much shorter
> (18887us vs 4us).

Nice! The optimization makes sense, and LGTM.

> 
> Unfortunately this optimization only works for RAID0/RAID10 with big
> holes in the block group.
> 
> For real world cases it's much harder to find huge gaps (although we can
> still skip several stripes).
> And even for the huge gap cases, the optimization itself is hardly
> observable (less than 1 second even for an almost empty 10G block group).
> 
> And also unfortunately for RAID5 data stripes, we can not go the similar
> optimization for RAID0/RAID10 due to the extra rotation.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 46 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 52b346795f66..c60cd4fd9355 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3066,7 +3066,8 @@ static int compare_extent_item_range(struct btrfs_path *path,
>   */
>  static int find_first_extent_item(struct btrfs_root *extent_root,
>  				  struct btrfs_path *path,
> -				  u64 search_start, u64 search_len)
> +				  u64 search_start, u64 search_len,
> +				  u64 *found_next)

I think at the very least, it would be nice to document the found_next
parameter in the function documentation.

Going one step further, I think the semantics could probably be
streamlined as well. I'm thinking something along the lines of always
using the path parameter to return the extent, and then the caller can
decide whether to grab the "found_next" from that before releasing the
path.

I don't see much harm in always filling in the "next" return, even if
RAID5 wants to ignore it.

Thanks,
Boris

>  {
>  	struct btrfs_fs_info *fs_info = extent_root->fs_info;
>  	struct btrfs_key key;
> @@ -3102,8 +3103,11 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
>  search_forward:
>  	while (true) {
>  		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> -		if (key.objectid >= search_start + search_len)
> +		if (key.objectid >= search_start + search_len) {
> +			if (found_next)
> +				*found_next = key.objectid;
>  			break;
> +		}
>  		if (key.type != BTRFS_METADATA_ITEM_KEY &&
>  		    key.type != BTRFS_EXTENT_ITEM_KEY)
>  			goto next;
> @@ -3111,8 +3115,11 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
>  		ret = compare_extent_item_range(path, search_start, search_len);
>  		if (ret == 0)
>  			return ret;
> -		if (ret > 0)
> +		if (ret > 0) {
> +			if (found_next)
> +				*found_next = key.objectid;
>  			break;
> +		}
>  next:
>  		path->slots[0]++;
>  		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
> @@ -3120,6 +3127,13 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
>  			if (ret) {
>  				/* Either no more item or fatal error */
>  				btrfs_release_path(path);
> +
> +				/*
> +				 * No more extent tree items, set *found_next
> +				 * directly to U64_MAX.
> +				 */
> +				if (ret > 0 && found_next)
> +					*found_next = U64_MAX;
>  				return ret;
>  			}
>  		}
> @@ -3186,7 +3200,8 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
>  		u64 extent_mirror_num;
>  
>  		ret = find_first_extent_item(extent_root, path, cur_logical,
> -					     logical + map->stripe_len - cur_logical);
> +					     logical + map->stripe_len - cur_logical,
> +					     NULL);
>  		/* No more extent item in this data stripe */
>  		if (ret > 0) {
>  			ret = 0;
> @@ -3385,7 +3400,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>  			       struct map_lookup *map,
>  			       u64 logical_start, u64 logical_length,
>  			       struct btrfs_device *device,
> -			       u64 physical, int mirror_num)
> +			       u64 physical, int mirror_num,
> +			       u64 *found_next)
>  {
>  	struct btrfs_fs_info *fs_info = sctx->fs_info;
>  	const u64 logical_end = logical_start + logical_length;
> @@ -3437,7 +3453,8 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
>  		spin_unlock(&bg->lock);
>  
>  		ret = find_first_extent_item(extent_root, &path, cur_logical,
> -					     logical_end - cur_logical);
> +					     logical_end - cur_logical,
> +					     found_next);
>  		if (ret > 0) {
>  			/* No more extent, just update the accounting */
>  			sctx->stat.last_physical = physical + logical_length;
> @@ -3552,6 +3569,7 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
>  	int ret = 0;
>  
>  	while (cur_logical < bg->start + bg->length) {
> +		u64 found_next = 0;
>  		/*
>  		 * Inside each stripe, RAID0 is just SINGLE, and RAID10 is
>  		 * just RAID1, so we can reuse scrub_simple_mirror() to scrub
> @@ -3559,13 +3577,23 @@ static int scrub_simple_stripe(struct scrub_ctx *sctx,
>  		 */
>  		ret = scrub_simple_mirror(sctx, extent_root, csum_root, bg, map,
>  					  cur_logical, map->stripe_len, device,
> -					  cur_physical, mirror_num);
> +					  cur_physical, mirror_num, &found_next);
>  		if (ret)
>  			return ret;
>  		/* Skip to next stripe which belongs to the target device */
>  		cur_logical += logical_increment;
>  		/* For physical offset, we just go to next stripe */
>  		cur_physical += map->stripe_len;
> +
> +		/*
> +		 * If the next extent is still beyond our current range, we
> +		 * can skip them until the @found_next.
> +		 */
> +		while (cur_logical + map->stripe_len < found_next &&
> +		       cur_logical < bg->start + bg->length) {
> +			cur_logical += logical_increment;
> +			cur_physical += map->stripe_len;
> +		}
>  	}
>  	return ret;
>  }
> @@ -3652,7 +3680,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>  		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
>  				bg->start, bg->length, scrub_dev,
>  				map->stripes[stripe_index].physical,
> -				stripe_index + 1);
> +				stripe_index + 1, NULL);
>  		offset = 0;
>  		goto out;
>  	}
> @@ -3706,7 +3734,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>  		 */
>  		ret = scrub_simple_mirror(sctx, root, csum_root, bg, map,
>  					  logical, map->stripe_len,
> -					  scrub_dev, physical, 1);
> +					  scrub_dev, physical, 1, NULL);
>  		if (ret < 0)
>  			goto out;
>  next:
> -- 
> 2.39.0
> 
