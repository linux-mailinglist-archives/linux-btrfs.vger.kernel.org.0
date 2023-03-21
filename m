Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048586C3BE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 21:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCUUeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 16:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCUUeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 16:34:06 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0486022CA8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 13:34:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 167AC5C0078;
        Tue, 21 Mar 2023 16:34:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Mar 2023 16:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679430840; x=1679517240; bh=PX
        549W/vBGXp62J+355fcIs/Qhuz7J8BabRh//8pcmA=; b=GvHRJgIpVHOK2Fx/Zl
        NLbgiNZD9+JuGBAC7uwZXwEPDgsU4rZVorfeaMAIR4ft5uFqeEnEPg88d7R2AEgu
        UIkWhrwLEVCVXlqAO6OhAzrmbclCYYmb7CCQTwzzm8J1rRtt6N/rHNHnInU/kLXJ
        K/asMol3FXCyl3D6PqSC1LmbWx+cubRrH5331UK9f4f731p4gA/smc1/2fHpBwSl
        mfwlIjnDAPh5ulU9hokpi9odP7k+G64UL0h0Re9nrU7Zex5ikLpRniEfEnWHaeox
        lIHamqrbD9s4KH9x26VhK6aDEUuyy51jwKDwUuoXnQJ1mB9zwkNEA3tWYGVf+Zf2
        tqGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679430840; x=1679517240; bh=PX549W/vBGXp6
        2J+355fcIs/Qhuz7J8BabRh//8pcmA=; b=rGGuMVS6HcjVGFmAMnc8WRfC5igsS
        tOa5Mhb8tnqcueMb2IWDanm6P8k6RtZPUHa/v8QuiFa//A/p0B35xQMvAMD1rd6K
        9yO+VyY4eATQN3/mQh1eYdEUxMpLFV1uNrKwH56gxldzh9nqUa0vmhv2kvuqh1Lv
        4Aovj9/WUzN4l5eiDHxpz2U5F0HJIwulB/e/0zGrsC+qaVAuclwQcIWbHbxT+vsF
        jHDlpua0/bGU3qHNNUbZTLGH1I4X0wws6WKeMfoEW+SqgFScwd98eulyCeDNPGM/
        OYbSjeiGmjqUJWwElpdDCpyqPyTGvVtmgO/gMHQx8Frs4pg0eyAHQZUUw==
X-ME-Sender: <xms:txQaZOIoymwqlzBq7pdigRCIgukO6C7sPMkdtjlziC01Zpw4jp3PmA>
    <xme:txQaZGKQHOeNJHG4hHCDmkw7ktwjhGdsOgN0hcZKPzx-bCAvyKpce6hiuVSDcAuns
    l1LNG4ZNdhdVqNs8nE>
X-ME-Received: <xmr:txQaZOvdmR5NMK8nIV5923IjZQDeCN_vWHdW7ifOj9ibA8buTvsFcw3F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepheduveelkeeiteelveeiuefhudehtdeigfehke
    effeegledvueevgefgudeuveefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:txQaZDYLbOjFLrnGR5FKRTxJYkm_EhkhzJQbnuq2tV8riWs1PfyAog>
    <xmx:txQaZFYOH25c_DnhupD6jyW_xv-RHRT0Lpu1YWWp2OA70LD5_BHL0A>
    <xmx:txQaZPD6SBYzz285MyxxrYyOuyS9CQBDDNrmrWM9sk8XGUZm0WtwDw>
    <xmx:uBQaZGCt7rJHnpPxg-SrpX6nnevnCTzZ5I8zcC-5lcQfdDmBtCOd3Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 16:33:59 -0400 (EDT)
Date:   Tue, 21 Mar 2023 13:33:58 -0700
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 3/6] btrfs: repurpose split_zoned_em for partial dio
 splitting
Message-ID: <20230321203358.GA24993@zen>
References: <cover.1679416511.git.boris@bur.io>
 <5faf0148f526b4e9eb373c177de3c70284999ce7.1679416511.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5faf0148f526b4e9eb373c177de3c70284999ce7.1679416511.git.boris@bur.io>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 21, 2023 at 09:45:30AM -0700, Boris Burkov wrote:
> In a subsequent patch I will be "extracting" a partial dio write bio
> from its ordered extent, creating a 1:1 bio<->ordered_extent relation.
> This is necessary to avoid triggering an assertion in unpin_extent_cache
> called from btrfs_finish_ordered_io that checks that the em matches the
> finished ordered extent.
> 
> Since there is already a function which splits an uncompressed
> extent_map for a zoned bio use case, adapt it to this new, similar
> use case. Mostly, modify it to handle the case where the extent_map is
> bigger than the ordered_extent, and we cannot assume the em "post" split
> can be computed from the ordered_extent and bio. This comes up in
> btrfs/250, for example.
> 
> I felt that these relaxations where not so damaging to the legibility of
> the zoned case as to merit a fully separate codepath, but I admit that is
> not my area of expertise.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/inode.c | 104 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 71 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5ab486f448eb..2f8baf4797ea 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2512,37 +2512,59 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
>  }
>  
>  /*
> - * Split an extent_map at [start, start + len]
> + * Split out a middle extent_map [start, start+len] from within an extent_map.
>   *
> - * This function is intended to be used only for extract_ordered_extent().
> + * @inode: the inode to which the extent map belongs.
> + * @start: the start index of the middle split
> + * @len: the length of the middle split
> + *
> + * The result is two or three extent_maps inserted in the tree, depending on
> + * whether start and len imply an uncovered area at the beginning or end of the
> + * extent map. If the implied split lines up with the end or beginning, there
> + * will only be two extent maps in the resulting split, otherwise there will be
> + * three. (If they both match, the split operation is a no-op)
> + *
> + * extent map splitting assumptions:
> + * end = start + len
> + * em-end = em-start + em-len
> + * start >= em-start
> + * len < em-len
> + * end <= em-end
> + *
> + * Diagrams explaining the splitting cases:
> + * original em:
> + *   [em-start---start---end---em-end)
> + * resulting ems:
> + * start != em-start && end != em-end (full tri split):
> + *   [em-start---start) [start---end) [end---em-end)
> + * start == em-start (no pre split):
> + *   [em-start---end) [end---em-end)
> + * end == em-end (no post split):
> + *   [em-start---start) [start--em-end)
> + *
> + * Returns: 0 on success, -errno on failure.
>   */
> -static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
> -			  u64 pre, u64 post)
> +static int split_em(struct btrfs_inode *inode, u64 start, u64 len)
>  {
>  	struct extent_map_tree *em_tree = &inode->extent_tree;
>  	struct extent_map *em;
> +	u64 pre_start, pre_len, pre_end;
> +	u64 mid_start, mid_len, mid_end;
> +	u64 post_start, post_len, post_end;
>  	struct extent_map *split_pre = NULL;
>  	struct extent_map *split_mid = NULL;
>  	struct extent_map *split_post = NULL;
>  	int ret = 0;
>  	unsigned long flags;
>  
> -	/* Sanity check */
> -	if (pre == 0 && post == 0)
> -		return 0;
> -
>  	split_pre = alloc_extent_map();
> -	if (pre)
> -		split_mid = alloc_extent_map();
> -	if (post)
> -		split_post = alloc_extent_map();
> -	if (!split_pre || (pre && !split_mid) || (post && !split_post)) {
> +	split_mid = alloc_extent_map();
> +	split_post = alloc_extent_map();
> +	if (!split_pre || !split_mid || !split_post) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> -	ASSERT(pre + post < len);
> -
>  	lock_extent(&inode->io_tree, start, start + len - 1, NULL);
>  	write_lock(&em_tree->lock);
>  	em = lookup_extent_mapping(em_tree, start, len);
> @@ -2551,19 +2573,38 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
>  		goto out_unlock;
>  	}
>  
> -	ASSERT(em->len == len);
> +	pre_start = em->start;
> +	pre_end = start;
> +	pre_len = pre_end - pre_start;
> +	mid_start = start;
> +	mid_end = start + len;
> +	mid_len = len;
> +	post_start = mid_end;
> +	post_end = em->start + em->len;
> +	post_len = post_end - post_start;
> +	ASSERT(pre_start == em->start);
> +	ASSERT(pre_start + pre_len == mid_start);
> +	ASSERT(mid_start + mid_len == post_start);
> +	ASSERT(post_start + post_len == em->start + em->len);
> +
> +	/* Sanity check */
> +	if (pre_len == 0 && post_len == 0) {
> +		ret = 0;
> +		goto out_unlock;
> +	}
> +
>  	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
>  	ASSERT(em->block_start < EXTENT_MAP_LAST_BYTE);
> -	ASSERT(test_bit(EXTENT_FLAG_PINNED, &em->flags));

I am currently digging into this more, as I think we want the em to be
pinned. The length is likely the same issue, so maybe I can figure them
both out. I was seeing it violated on btrfs/250.

>  	ASSERT(!test_bit(EXTENT_FLAG_LOGGING, &em->flags));
>  	ASSERT(!list_empty(&em->list));
>  
>  	flags = em->flags;
> -	clear_bit(EXTENT_FLAG_PINNED, &em->flags);
> +	if (test_bit(EXTENT_FLAG_PINNED, &em->flags))
> +		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
>  
>  	/* First, replace the em with a new extent_map starting from * em->start */
>  	split_pre->start = em->start;
> -	split_pre->len = (pre ? pre : em->len - post);
> +	split_pre->len = (pre_len ? pre_len : mid_len);
>  	split_pre->orig_start = split_pre->start;
>  	split_pre->block_start = em->block_start;
>  	split_pre->block_len = split_pre->len;
> @@ -2577,16 +2618,15 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
>  
>  	/*
>  	 * Now we only have an extent_map at:
> -	 *     [em->start, em->start + pre] if pre != 0
> -	 *     [em->start, em->start + em->len - post] if pre == 0
> +	 *     [em->start, em->start + pre_len] if pre_len != 0
> +	 *     [em->start, em->start + mid_len] if pre == 0
>  	 */
> -
> -	if (pre) {
> +	if (pre_len) {
>  		/* Insert the middle extent_map */
> -		split_mid->start = em->start + pre;
> -		split_mid->len = em->len - pre - post;
> +		split_mid->start = mid_start;
> +		split_mid->len = mid_len;
>  		split_mid->orig_start = split_mid->start;
> -		split_mid->block_start = em->block_start + pre;
> +		split_mid->block_start = em->block_start + pre_len;
>  		split_mid->block_len = split_mid->len;
>  		split_mid->orig_block_len = split_mid->block_len;
>  		split_mid->ram_bytes = split_mid->len;
> @@ -2596,11 +2636,11 @@ static int split_zoned_em(struct btrfs_inode *inode, u64 start, u64 len,
>  		add_extent_mapping(em_tree, split_mid, 1);
>  	}
>  
> -	if (post) {
> -		split_post->start = em->start + em->len - post;
> -		split_post->len = post;
> +	if (post_len) {
> +		split_post->start = post_start;
> +		split_post->len = post_len;
>  		split_post->orig_start = split_post->start;
> -		split_post->block_start = em->block_start + em->len - post;
> +		split_post->block_start = em->block_start + pre_len + mid_len;
>  		split_post->block_len = split_post->len;
>  		split_post->orig_block_len = split_post->block_len;
>  		split_post->ram_bytes = split_post->len;
> @@ -2632,7 +2672,6 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
>  	u64 len = bbio->bio.bi_iter.bi_size;
>  	struct btrfs_inode *inode = bbio->inode;
>  	struct btrfs_ordered_extent *ordered;
> -	u64 file_len;
>  	u64 end = start + len;
>  	u64 ordered_end;
>  	u64 pre, post;
> @@ -2671,14 +2710,13 @@ blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
>  		goto out;
>  	}
>  
> -	file_len = ordered->num_bytes;
>  	pre = start - ordered->disk_bytenr;
>  	post = ordered_end - end;
>  
>  	ret = btrfs_split_ordered_extent(ordered, pre, post);
>  	if (ret)
>  		goto out;
> -	ret = split_zoned_em(inode, bbio->file_offset, file_len, pre, post);
> +	ret = split_em(inode, bbio->file_offset, len);
>  
>  out:
>  	btrfs_put_ordered_extent(ordered);
> -- 
> 2.38.1
> 
