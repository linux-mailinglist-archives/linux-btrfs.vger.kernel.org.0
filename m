Return-Path: <linux-btrfs+bounces-17798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E93BDC577
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 05:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8123A4F572A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779B29D277;
	Wed, 15 Oct 2025 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DKMYnL+V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UhZBh2LH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281029ACEE;
	Wed, 15 Oct 2025 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760498999; cv=none; b=PeQBACa/ApCcqZXW77zW/tNJqtz34yh0gDhO63nUL+NW5I5EYctpaLtbHrgBL0Tfyfv/puGsakSPvPbS0iw/OUjLF2Ksx06QjoGTsacJmeMBOlaJA2sdW/uWeNxzVWEb5iLoDL9SVEoMK2fW4/WU9VcN3R93ZDwCNg2sVuM+FEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760498999; c=relaxed/simple;
	bh=3BVjiZX7gwOfDjIVpvYWvIdMgAz3MBA6gQwJCw2Ph0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLQBWH8sWroo4O0A+u0IF83BPuMIrDtBmVbGbJtLXH78TQyEsaKXpmxhBYsw/CA4O5+rQeryuyngQrfz5Ou/LMJd93i3GwX8MEhUQUvFDgU/bHzsznjlleyumoj4j49FuIFoty7+CKQpkToQpA/evcT05HaGvknWOt7N8pveu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DKMYnL+V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UhZBh2LH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15E89140007F;
	Tue, 14 Oct 2025 23:29:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 14 Oct 2025 23:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760498996; x=1760585396; bh=4hX1JI1YXp
	ZJ2d89pwu0keWdyhtOl2pD2J1qbW48Bu0=; b=DKMYnL+VqxLcCx/MCQhdUkgc5B
	dBWGphWN1tBKe7gcMKRvcvVIIPrPAXJ+hUX1eQIZGnN4yOaC4Zf/nWP7SUgxS4oN
	evUGnO+THnd4dF3FRCye47d2mzmDXxIfBbPW005EUuX/pvoqwqk3Kan3iYXt6JxN
	D5DfrazVvGR/tUkCOIVit7uq/+gkWtJUnSsC3jxz5LWshndf/O8XkZ1cghRCkmAd
	EqpjP89BPdtgYhkO5ohpXmEiA9eX395L82yXABaa05liXMDUT61KXAF+c3hx5vpw
	Z2VJ8aa/k7fslFtpNaHuebAPheTtUosjSk9d3Mj+mH73Wk2mB/2V+5mKNbLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760498996; x=1760585396; bh=4hX1JI1YXpZJ2d89pwu0keWdyhtOl2pD2J1
	qbW48Bu0=; b=UhZBh2LH1J8oGI1vZ5yEHYDUWy7edcSmXBjJc+rATk8r2Iendcx
	c0g/flYUspox4rhsR8dYdvZlp6D2e0an/1v6wJKDFJZ+gQyBMYvB1gkfpzELUU/S
	8SCVBx5IAT8nSQIda83YCXHieg9r90fCjNcPXV8QeAmkQ+cofKwtqLvuHtg8DNwi
	HwJbpQWrC3TpxP5WwAEDeR3H1pZT4z6VeHWtNvrpW277BOjNNbJDZLBjApRAgsje
	WxMZ+gXbZu7SGppmhPt77DTNZwWVTMxtqUwrRFwlUcpQKtGlnczMPpaeSTFOPxAj
	tf/gKJhr0EDXH3Wa7w2s7whL0jLlSjlHdQw==
X-ME-Sender: <xms:MxXvaGudzNyWmKuiKioMiOzA51l02hK-6jzcbzNUFYSJDJTGd4QgRA>
    <xme:MxXvaJQ2UZrac_3-5cTntqv3jTnr3opq_Z16cGXsmYKfAjPAiH3AkKkwx8wk46kn-
    _KJycPg4tkxcTjA7g7-XpROmVjuMuEBLSdYAYO6oON7vmrP7u9keCFp>
X-ME-Received: <xmr:MxXvaMNqTgF-AmVnAX1YLzJWT5PIIpRziUTGJkbHr-oKGY2RUpDn-4Cc6-x-Q8rHgVL-e7ld9ohy2SLpOE_aYW4T4vM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlohgvmhhrrgdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthht
    ohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MxXvaOb0qNYCIXd5ZGW5MJBI2uOu8AWyxCwJHGWg51SkoKrLI42UsA>
    <xmx:MxXvaGz96fGiYmj350Bvyb7kJ1qOU0mtkjlzMLyYrcFirMTGV-dCXg>
    <xmx:MxXvaJLVDJ1tMOKO_kDxRTbbYzSsNAWZBruuJ2qbiFz79oSJVvWE1A>
    <xmx:MxXvaAquAojKUdSTDrGTZrzYE-zmkoUCB2QimWWbmU03r7RmKGgBZQ>
    <xmx:NBXvaA9A_b_X153fJVZkl41j1dbkZu1DK9WBM3FrGQwx0z4KsbKKtzc9>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 23:29:55 -0400 (EDT)
Date: Tue, 14 Oct 2025 20:29:35 -0700
From: Boris Burkov <boris@bur.io>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs: remove ffe RAID loop
Message-ID: <20251015032935.GB1702774@zen.localdomain>
References: <cover.1759532729.git.loemra.dev@gmail.com>
 <a46aa0e4fb936ab73748fc9fd92a9404380769b1.1759532729.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46aa0e4fb936ab73748fc9fd92a9404380769b1.1759532729.git.loemra.dev@gmail.com>

On Fri, Oct 03, 2025 at 04:41:57PM -0700, Leo Martins wrote:
> This patch removes the RAID loop from find_free_extent since it
> is impossible to allocate from a block group with a different
> RAID profile.
> 
> Historically, we've been able to fulfill allocation requests
> from mismatched RAID block groups assuming they provided the
> required duplcation. For example, a request for RAID0 could be
> fulfilled by a RAID1 block group.
> 
> 2a28468e525f ("btrfs: extent-tree: Make sure we only allocate extents from block groups with the same type")
> changed this behavior to skip block groups with different flags
> than the request. This makes the duplication compatiblity check
> redundant since we're going to keep searching regardless.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/extent-tree.c | 32 +-------------------------------
>  1 file changed, 1 insertion(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a4416c451b25..28b442660014 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4171,13 +4171,8 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
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
> @@ -4477,9 +4472,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  search:
>  	trace_btrfs_find_free_extent_search_loop(root, ffe_ctl);
>  	ffe_ctl->have_caching_bg = false;
> -	if (ffe_ctl->index == btrfs_bg_flags_to_raid_index(ffe_ctl->flags) ||
> -	    ffe_ctl->index == 0)
> -		full_search = true;
> +	full_search = true;
>  	down_read(&space_info->groups_sem);
>  	list_for_each_entry(block_group,
>  			    &space_info->block_groups[ffe_ctl->index], list) {
> @@ -4498,30 +4491,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
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
> -- 
> 2.47.3
> 

