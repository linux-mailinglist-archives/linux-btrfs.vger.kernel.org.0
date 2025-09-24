Return-Path: <linux-btrfs+bounces-17141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEC1B9B91C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 20:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BD4420507
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Sep 2025 18:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E078313E0C;
	Wed, 24 Sep 2025 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="W09vl1P5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LrTDufZq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C419CCF5
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Sep 2025 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740100; cv=none; b=CjnqqywHkYB/LISdyCzMmeIMtoNJNcQ6fQeKwaXI03t9oEjDEw4hzvQ+nTl4J4q3SZkAcbEBqFeaDwhpD8X3gy0yPRac8nGnm1tCCktveBGYLZN5xoGzmDQM/NN9tANXgWtem7T6Sh78FL2yugyQm+RWGpe5WCUho2AXjWwXQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740100; c=relaxed/simple;
	bh=Q+GE2ZogX+7UQuGohkfIoiVl0nzScMhUSBPcCQswhBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrXiwL8PZ0AUoWw2Um9vgBqqFAQZbI8RSFw14tybMje9O7KWHyJHlNR/oJNKzdeHT2n1wNXMsNAAiFm+nGqrkwog9p1D9qyE8JyEeJo9gzEd1uIPmkf/p+/FxttfvpvYbizdXIitiDjB81HzK73jlAmuTplCddX73zUSC8w4qZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=W09vl1P5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LrTDufZq; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A583A7A016E;
	Wed, 24 Sep 2025 14:54:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 14:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1758740097; x=1758826497; bh=z9Oiare8KH
	/x4gZm/2odaS0YiHTYG+TAcpqI8ZPqhQw=; b=W09vl1P5dVhuSGPUwC6LFhAe+t
	zw4EMAcGUvwvbM3r8C0tXkf9AxzysLgU6tIjGPHKcA5BJpzZT5SCbsHDsiITKlEx
	nD/qR5zTO2bihu038DqbcH8gBiuW6/ax1fu+CY4tgsG6E1RyDmke8Us84wc1jY4C
	1hqp5EpqAZT3HrR+Xce+sAYIG/atD1DL4gvlNe+YU26FWtnCTZUmgz5XJPQMkvTg
	zcXgTYRlCRO043lhh+539DQ0ZXM5aSYU2mD1hDcHockG/3frj0+pmV8pb8FWE+3C
	X2ZM0zmV3zWJWnmwlml1tSQZut2kdkD8MMPXfaJykdJPydxB/IAKfLAGFAIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758740097; x=1758826497; bh=z9Oiare8KH/x4gZm/2odaS0YiHTYG+TAcpq
	I8ZPqhQw=; b=LrTDufZq5mlBD1+V6XPkN1qfHA2w9lk+HBT3C1ek6wznFmlDlm8
	D3AftVL6sXkXq+xrCN5z7HHvDy7fQynTRew0dHcuDoDTaAa7gOrECJpN2oBAZ3vo
	oJaKuAJjSAM0LeAVfQ60EAWZ7fOP9F5OBJwIIXvIoFjeI7w4K+quCQnIO8U1K94N
	6mj0OrUIZZdcu8e6KfjTQyyM+c2afyi482rk76OWo7jGubep8PoWqFZY507Vyd/N
	zpX66rwbojxokG6Kh8Cxq13t5emeFdzTH0+muqxL5DerLkzZmRS8SToOmDWhB2od
	Q74q26blxQ57PZF32hBMZME7Dl5K/WzS7lQ==
X-ME-Sender: <xms:gT7UaG8Sys_GDt3G76kGKJzoUP7SMDiYKiAqW6lOQn_YfHsdv_RoVg>
    <xme:gT7UaOKKv_dcAtP7tsR0LOaikGUaU0y5dQ7_SKreQx4mEVZM42h-Yj_aqS8p7ER9g
    3rUq3zt9OB84Gi54wfWFnZpUj62oUSpj0Qecr9mcdff-WA4pBZ85bMh>
X-ME-Received: <xmr:gT7UaJY2K8ytFBnCyKmjotXLsn5Owi4kXBZBTF5M9oAwYZLDhc_nqmPUULtVjrC7ZPmkflO_4JDnJnDn3FefZowlL2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhhovghmrhgrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:gT7UaIKFgxADsfBsQvD-XP0c9NvHuaSWAsjXfuI-1s_eTvTYKV_B0Q>
    <xmx:gT7UaPAfLGzpsoQr2WM_wQi0S3qlwOQ3erIvg4JUedksoWJWOyTKMg>
    <xmx:gT7UaFq6TE9_wYJ5KTnLN0iZKCE5LKhUSs4CENzHnSHmNoWq3LMDqA>
    <xmx:gT7UaCg-4_dR7O7lasBTb7rjGO8gpqAgzeAycuuzMAus4uSbuBbbpQ>
    <xmx:gT7UaJrpn2Vjw7aEM0pDLejrI0wunNF0z_wVV11NkD4JF_s2e-731Cqh>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 14:54:56 -0400 (EDT)
Date: Wed, 24 Sep 2025 11:54:55 -0700
From: Boris Burkov <boris@bur.io>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: remove ffe RAID loop
Message-ID: <20250924185455.GB3027411@zen.localdomain>
References: <cover.1758587352.git.loemra.dev@gmail.com>
 <f873e980f092dc282ea934d5a77ca2ad463e377d.1758587352.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f873e980f092dc282ea934d5a77ca2ad463e377d.1758587352.git.loemra.dev@gmail.com>

On Mon, Sep 22, 2025 at 06:13:14PM -0700, Leo Martins wrote:
> This patch removes the RAID loop from find_free_extent since it
> is impossible to allocate from a block group with a different
> RAID profile.

I hope we can pull this off; removing one of these loops will be great
for readability, even if most of them are empty/trivial 99%+ of the time
and it has no meaningful impact on performance.

> 
> Historically, we've been able to fulfill allocation requests
> from any block group. For example, a request for RAID0 could be
> fulfilled by a RAID1 block group or a request for METADATA could be
> fulfilled by a DATA block group.
> 
> "btrfs: extent-tree: Make sure we only allocate extents from block
> groups with the same type" changed this behavior to skip block groups

Please use the standardized format for referring to previous patches.
e.g.,
2a28468e525f ("btrfs: extent-tree: Make sure we only allocate extents from block groups with the same type")
I have the git alias:
fixes = show -s --pretty='format:%h (\"%s\")'
in my gitconfig that generates it for Fixes: tags, but you can adapt
that however is most helpful for you.

> with different flags than the request. This makes the duplication
> compatibility check redundant since we're going to keep searching
> regardless.

I agree with you from reading the code, but I would sleep easier at
night if you had evidence that this doesn't appreciably change the
outcome during raid rebalances. Can you check if there is an fstest that
keeps allocating during a raid rebalance, and if there isn't, can you
add one?

Thanks,
Boris

> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/extent-tree.c | 40 +++-------------------------------------
>  1 file changed, 3 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a4416c451b25..072d9bb84dd8 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4153,8 +4153,7 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
>  static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>  					struct btrfs_key *ins,
>  					struct find_free_extent_ctl *ffe_ctl,
> -					struct btrfs_space_info *space_info,
> -					bool full_search)
> +					struct btrfs_space_info *space_info)
>  {
>  	struct btrfs_root *root = fs_info->chunk_root;
>  	int ret;
> @@ -4171,20 +4170,15 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>  	if (ffe_ctl->loop >= LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
>  		return 1;
>  
> -	ffe_ctl->index++;
> -	if (ffe_ctl->index < BTRFS_NR_RAID_TYPES)
> -		return 1;
> -
>  	/* See the comments for btrfs_loop_type for an explanation of the phases. */
>  	if (ffe_ctl->loop < LOOP_NO_EMPTY_SIZE) {
> -		ffe_ctl->index = 0;
>  		/*
>  		 * We want to skip the LOOP_CACHING_WAIT step if we don't have
>  		 * any uncached bgs and we've already done a full search
>  		 * through.
>  		 */
>  		if (ffe_ctl->loop == LOOP_CACHING_NOWAIT &&
> -		    (!ffe_ctl->orig_have_caching_bg && full_search))
> +		    (!ffe_ctl->orig_have_caching_bg))
>  			ffe_ctl->loop++;
>  		ffe_ctl->loop++;
>  
> @@ -4384,7 +4378,6 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  	int cache_block_group_error = 0;
>  	struct btrfs_block_group *block_group = NULL;
>  	struct btrfs_space_info *space_info;
> -	bool full_search = false;

I'm not 100% sure this is compatible with hints. If our allocation is
hinted (or clustered for that matter, but already not handled...) we
will jump into the middle of the loop without setting full_search=true,
so it is not true that we have looked at the caching state of every bg,
and waiting for caching could be a useful step. However, we will just
loop at LOOP_UNSET_SIZE_CLASS instead, which is also probably fine.

So I would say this is *probably* fine but does constitute a behavior
change and violates an existing invariant, even if it's one that is not
that heavily relied upon.

>  
>  	WARN_ON(ffe_ctl->num_bytes < fs_info->sectorsize);
>  
> @@ -4477,9 +4470,6 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  search:
>  	trace_btrfs_find_free_extent_search_loop(root, ffe_ctl);
>  	ffe_ctl->have_caching_bg = false;
> -	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
> -	    ffe_ctl->index == 0)
> -		full_search = true;
>  	down_read(&space_info->groups_sem);
>  	list_for_each_entry(block_group,
>  			    &space_info->block_groups[ffe_ctl->index], list) {
> @@ -4498,30 +4488,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		btrfs_grab_block_group(block_group, ffe_ctl->delalloc);
>  		ffe_ctl->search_start = block_group->start;
>  
> -		/*
> -		 * this can happen if we end up cycling through all the
> -		 * raid types, but we want to make sure we only allocate
> -		 * for the proper type.
> -		 */
>  		if (!block_group_bits(block_group, ffe_ctl->flags)) {
> -			u64 extra = BTRFS_BLOCK_GROUP_DUP |
> -				BTRFS_BLOCK_GROUP_RAID1_MASK |
> -				BTRFS_BLOCK_GROUP_RAID56_MASK |
> -				BTRFS_BLOCK_GROUP_RAID10;
> -
> -			/*
> -			 * if they asked for extra copies and this block group
> -			 * doesn't provide them, bail.  This does allow us to
> -			 * fill raid0 from raid1.
> -			 */
> -			if ((ffe_ctl->flags & extra) && !(block_group->flags & extra))
> -				goto loop;
> -
> -			/*
> -			 * This block group has different flags than we want.
> -			 * It's possible that we have MIXED_GROUP flag but no
> -			 * block group is mixed.  Just skip such block group.
> -			 */
>  			btrfs_release_block_group(block_group, ffe_ctl->delalloc);
>  			continue;
>  		}
> @@ -4620,8 +4587,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  	}
>  	up_read(&space_info->groups_sem);
>  
> -	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, space_info,
> -					   full_search);
> +	ret = find_free_extent_update_loop(fs_info, ins, ffe_ctl, space_info);
>  	if (ret > 0)
>  		goto search;
>  
> -- 
> 2.47.3
> 

