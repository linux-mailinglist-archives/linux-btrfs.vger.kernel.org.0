Return-Path: <linux-btrfs+bounces-16309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD7B32304
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 21:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F205880FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F232571B3;
	Fri, 22 Aug 2025 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="U5PtD+P6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvBTC5sx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543E815E90
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891645; cv=none; b=HgHOS55xO/4vg5MoE1fyMNA4CzoiZ8njrtGNzFFudCh3b78xc7U//BfeU1sLC6Gdy+ZygCjSgttHzGuW9a/xi3R1bHL5nm1gyumQ4wl+npfIy2NkWDr0ewnpsFiH76Xtfc+73IvRofhitPrBitqrVzYMdxzW/kH9u7YvyXcGEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891645; c=relaxed/simple;
	bh=KYD4A4Wy/OYN2TuwqBEOEfoBDc/sXVccpofHOYZx99E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKQemUYnBABfjwekjeXgTbVRFFQwD+iNlu07u1oMh/EF7aUw6ofq8RJADwqe07rJWX3Rpj73qpyzbnbb6XKYGKkASJsQpxxAgasxxxDnIxs6d6I//c2lH9VqHvEnN+C6LzpjLraa4ZBR6TwSPmhWSLodGgUU+dzoD8tIwTyD0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=U5PtD+P6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvBTC5sx; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 726C9EC00CA;
	Fri, 22 Aug 2025 15:40:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 22 Aug 2025 15:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755891642; x=1755978042; bh=ZZMSpF+hc0
	cNA/+4LGT2Eaiym6vAlylJUmjACJXHCw0=; b=U5PtD+P6X5/YLJZ30qAD2tL/UL
	uv//qMNvHC4T3Wazh+1NWDeW01HvVGulrF0xLPv80ERLxwPQAJSqZ+96WlFVlxhe
	dQ9fYwCRN83furgRUIm1F5MOjCAtB9AFddxlCr1tLW0fcJYK64xxxWJePsQb9APe
	V8ofA9aRj8NFHFia9wbyk8jBe8EQOSA93bRrCVYk2n+P574I8T/tmROon9strsPq
	t3XwUGhSBtjCOz0KXqBdDK2XOSq4DshMBllQfCOI0/j/cjcBlOLvoy18fWxMHWZg
	pz+LABhfGsF9zPt1gcTPtb+7NNCUfTp+TtPJeHNDQ5TiQm9xGIQFpxEDQ1DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755891642; x=1755978042; bh=ZZMSpF+hc0cNA/+4LGT2Eaiym6vAlylJUmj
	ACJXHCw0=; b=mvBTC5sx0kf5OJrI/9YH4HqgFvpMcVz63COenku7g3PyKyGY/KJ
	lM2/ALOObhFImpDqJp3uLAHYCp3QLs8c/J1Hrqo3Gpy6TobWXu2ds0gNMR1cdF9s
	dpuvrhWNxzaKmImM0sI11MtxpSrM3HCaHK4/uarcAfKs5LmISTitwgCm1NLfdI2k
	lbOS5FOObHaLAoXPcB/FoLxhEp1r5zMDeAXrE5Pwi15p10sBX95ARZgyYSvfgP17
	M9aJp2Pdp0pH3IPjZIvmZ6ZbbOi/3SDqh5s/SJ/g5fc7P+ydApN/xY7Qp4de4GzC
	1efcer3zGIAT9E7fTjr2Ek9VcyPYMrMQt8A==
X-ME-Sender: <xms:useoaPPqM6Cb9VPIwJjP5KfPkqFQwB1pkvK8fGs9-51jI6ZjVslhiw>
    <xme:useoaKJRfmHMhUrlOnG1ijagXLGqJerKkpDt9nOm7FKSzIyZa5NUFaVhftaK2lFbo
    aRp3GdZv86A9YJSQvk>
X-ME-Received: <xmr:useoaAGXUuXajdAgqw32SuY4ud1GTNxcn5ipHovspbw7Mh43FyIz0Ra5p3KFUTeSJPV_JN8VhYaCZ_Zwc_m8ul57ZHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:useoaCSvh9Qnr9DmRn-bb-G8L7uwP2S-yoJGMsNlgk0f21bzNZbCvQ>
    <xmx:useoaMHV56-A6AVPCU6V9ECW1e-IxGhLjHfX-KduLVX9l4-an8h_Ug>
    <xmx:useoaO8bQndy-D6DuW1YXoF7mJo6zUGyT9wxv6S7m3uRfmg21toujg>
    <xmx:useoaGKWZODwDn8C9BUUemNvrnC5uMl4UYDvikU4qroVOpwKIPt1xg>
    <xmx:useoaGTdZB88MRHhQhOHYcBYTgBQhy2BKMEAai2C0omjZfWlp4d3rD-d>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 15:40:41 -0400 (EDT)
Date: Fri, 22 Aug 2025 12:42:41 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 08/16] btrfs: redirect I/O for remapped block groups
Message-ID: <20250822194241.GB492925@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-9-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-9-mark@harmstone.com>

On Wed, Aug 13, 2025 at 03:34:50PM +0100, Mark Harmstone wrote:
> Change btrfs_map_block() so that if the block group has the REMAPPED
> flag set, we call btrfs_translate_remap() to obtain a new address.
> 
> btrfs_translate_remap() searches the remap tree for a range
> corresponding to the logical address passed to btrfs_map_block(). If it
> is within an identity remap, this part of the block group hasn't yet
> been relocated, and so we use the existing address.
> 
> If it is within an actual remap, we subtract the start of the remap
> range and add the address of its destination, contained in the item's
> payload.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/relocation.c | 59 +++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/relocation.h |  2 ++
>  fs/btrfs/volumes.c    | 31 +++++++++++++++++++++++
>  3 files changed, 92 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 7256f6748c8f..e1f1da9336e7 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3884,6 +3884,65 @@ static const char *stage_to_string(enum reloc_stage stage)
>  	return "unknown";
>  }
>  
> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
> +			  u64 *length, bool nolock)
> +{
> +	int ret;
> +	struct btrfs_key key, found_key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_remap *remap;
> +	BTRFS_PATH_AUTO_FREE(path);
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	if (nolock) {
> +		path->search_commit_root = 1;
> +		path->skip_locking = 1;
> +	}

We are calling this without a transaction and in a loop in
btrfs_submit_bbio:

btrfs_submit_bbio
  while (blah); btrfs_submit_chunk
    btrfs_map_block
      btrfs_translate_remap

So that means in that loop we can have one remap tree in one step of the
loop and then a transaction can finish and then the next chunk is
remapped on the next remap tree in the next step.

Is that acceptable? Otherwise you need to hold the commit_root_sem for
the whole loop. It seems OK because both copies ought to be around while
we're in the middle of remapping, but let's be sure. I'm also curious
about the paths that are removing things from the remap tree. I would
expect live IO that would use that remapping would block them, as it
is like removing an extent, but also worth considering.

> +
> +	key.objectid = *logical;
> +	key.type = (u8)-1;
> +	key.offset = (u64)-1;
> +
> +	ret = btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
> +				0, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	leaf = path->nodes[0];
> +
> +	if (path->slots[0] == 0)
> +		return -ENOENT;
> +
> +	path->slots[0]--;
> +
> +	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +	if (found_key.type != BTRFS_REMAP_KEY &&
> +	    found_key.type != BTRFS_IDENTITY_REMAP_KEY) {
> +		return -ENOENT;
> +	}
> +
> +	if (found_key.objectid > *logical ||
> +	    found_key.objectid + found_key.offset <= *logical) {
> +		return -ENOENT;
> +	}
> +
> +	if (*logical + *length > found_key.objectid + found_key.offset)
> +		*length = found_key.objectid + found_key.offset - *logical;
> +
> +	if (found_key.type == BTRFS_IDENTITY_REMAP_KEY)
> +		return 0;
> +
> +	remap = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
> +
> +	*logical = *logical - found_key.objectid + btrfs_remap_address(leaf, remap);

nit: I think the readability of this would benefit from some "offset"
helper variable, but your commit message does make it clear enough.

> +
> +	return 0;
> +}
> +
>  /*
>   * function to relocate all extents in a block group.
>   */
> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
> index 5c36b3f84b57..a653c42a25a3 100644
> --- a/fs/btrfs/relocation.h
> +++ b/fs/btrfs/relocation.h
> @@ -31,5 +31,7 @@ int btrfs_should_cancel_balance(const struct btrfs_fs_info *fs_info);
>  struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr);
>  bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
>  u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
> +			  u64 *length, bool nolock);
>  
>  #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 678e5d4cd780..a2c49cb8bfc6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6635,6 +6635,37 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>  	if (IS_ERR(map))
>  		return PTR_ERR(map);
>  
> +	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {

potential optimization (not blocking for this version IMO):
if you can cache the type on the extent_map (I actually think it ought
to already be done, essentially, as we know data vs. not data) then you
don't need to lookup the map at all for a remapped block, and can go
straight to looking up the remap.

> +		u64 new_logical = logical;
> +		bool nolock = !(map->type & BTRFS_BLOCK_GROUP_DATA);
> +
> +		/*
> +		 * We use search_commit_root in btrfs_translate_remap for
> +		 * metadata blocks, to avoid lockdep complaining about
> +		 * recursive locking.

real risk of deadlock or "complaining"?

> +		 * If we get -ENOENT this means this is a BG that has just had
> +		 * its REMAPPED flag set, and so nothing has yet been actually
> +		 * remapped.
> +		 */
> +		ret = btrfs_translate_remap(fs_info, &new_logical, length,
> +					    nolock);
> +		if (ret && (!nolock || ret != -ENOENT))
> +			return ret;
> +
> +		if (ret != -ENOENT && new_logical != logical) {
> +			btrfs_free_chunk_map(map);
> +
> +			map = btrfs_get_chunk_map(fs_info, new_logical,
> +						  *length);
> +			if (IS_ERR(map))
> +				return PTR_ERR(map);
> +
> +			logical = new_logical;
> +		}
> +
> +		ret = 0;
> +	}
> +
>  	num_copies = btrfs_chunk_map_num_copies(map);
>  	if (io_geom.mirror_num > num_copies)
>  		return -EINVAL;
> -- 
> 2.49.1
> 

