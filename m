Return-Path: <linux-btrfs+bounces-20215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DC1CFFA70
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 20:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4823E301500A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4213130F923;
	Wed,  7 Jan 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="rKE26j10";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y7smM+cv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5D258ED4
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812906; cv=none; b=PN++eRzNR1/ElTRpjFiFaZF7ZWnbbutS2/93BTnRBVvHc9mNDbX8lxS5tO3Me5QewkMt/st2F++1GHKfbH7pZ/FVlicfBPTwdtkmTx+7knj36ftacTqa0yYqZK+DOFvlFcssn7Ijq/4gNOfi7Y3r32QHurjYkPQOzwbvHUJrBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812906; c=relaxed/simple;
	bh=vk/DfmLZC0r9k/aytoO+2I5oeWnN+dI6mRLnUDHWwss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHa1oyBg9oE6Fk1H2pKtadRGosoPDqwvNVda038JqR4n+JjJ39iZWfXgxnskROh6SI3lg5L+nCpUWWkzGRZCzgUGITpNFNnwQhhZ6wZwfEuoVkiM2gfBotJJQcRWY7/oS5NgQJHIRh7dPmp80snUACHAF6DbWKsEpRkFM0ejwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=rKE26j10; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y7smM+cv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7CF21400164;
	Wed,  7 Jan 2026 14:08:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 07 Jan 2026 14:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767812902; x=1767899302; bh=yYmxYHhEUg
	TRKr6RrAIvAu/9A3QFxLBrm1mi2yrKdD4=; b=rKE26j10SEDZrhh3kBlMdlvqer
	Zn0WclEg48ttUjzHRv5dTXRVPYggmlkHv/n/Fl7CqdkmhNyEXoJ5Rf1Nf22DZm8U
	1Jy89JSP8kaI1Ri+Ln0lw3kT7D749UoM06vpKlb0o15inckq7ZbvLqVhVQw5yBNS
	LTJ56JYyrqcAWwtVRysxSPbhycILXR2rlR3G5J4YJBLhm/w8WDbnhUGD3NdfMqJa
	tc5ldXygApwfMSxlygl88eN3RWBI6cTGEDQy13OzVL/E/iMGTLJmd0C0C80uvPWg
	tQuiUBf7uvY/ofdC2CgKRPgKi1I81cMZiAeAoebcDESjr1bEABcqNOGutWcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767812902; x=1767899302; bh=yYmxYHhEUgTRKr6RrAIvAu/9A3QFxLBrm1m
	i2yrKdD4=; b=y7smM+cvbddl4ZLffpDGQZFbG0VVLyjsFl8+BCW+4CE/isOPpMj
	OhGqUMUJSSzPWEvdrV7GlD0AJqgczeuE/9igaZO2mkGg+5RjB9oHOWkp67q9edYi
	jzz9Lh81dsiC66Bly1m8asByRW0XkLBFKYCYIcaMZZpVE8xZmRZfyWe+K2biy3UT
	3T8A2SEtYURU/MgBhR18hA7IApKxPSU7sUe5QZR8V2KZqQRhDklsu9pPTkIXXHVk
	kL58fpYv55oJTSYlKnl4JQxBD6FdTmQ3rsGHmjiJkh8T+J6PyzsvfE8cO5kcUpQB
	JepmPFnJL+Y1D9t2wJ5NrZS5A526ZhJXnnA==
X-ME-Sender: <xms:Jq9eacm44yip7L6rXQ426bp7RawTXBnhtRyDdM5l-1wir2TGYxq5dg>
    <xme:Jq9eaTQ7GFpJg5AgyqmrdGiUPw7d4EOBwJq_BQ1DmVzYLtZSrnO2C5OX9JE8yFDaM
    ssYa0Mwisnx72HAAXcq4EV3EDzjYCzQkHeZAneHZTi4dK3MnVPkFVg>
X-ME-Received: <xmr:Jq9eaYD17wFIpwJPZv9RZhtg9voG-9uzAEWgE71PTyCj1M5KwdcFgwL5KQ2Sq1CaaGwLyfylIHCc_AxEg3ns7TdQN6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehtd
    fhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhhikhhkvghlodgsthhrfhhssehmihhkkhgvlhdrtggt
X-ME-Proxy: <xmx:Jq9eaSQLh6RSUdnIFmaLVEMMNe-5TOUegkK4MACFtmK0hhjPeHOHJQ>
    <xmx:Jq9eaeqRE0mAiGD0xy5QT9yp5zhiEpmw2iXfejZdPzzfvm8YFTJQQg>
    <xmx:Jq9eaczdtiwNIM1a028hHXfignlB47jEY04JJBL7wh9FAzU1b1zmWQ>
    <xmx:Jq9eabLBBCNyDDjLiqIP_OldOPjICUIRb4UyWyVw6jPWDP5eVeb5iA>
    <xmx:Jq9eaU8rHRgHuBwDsbBifFYLlyhtCDn7r3guTuSDzaCrz3R3p0NUOR9l>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 14:08:21 -0500 (EST)
Date: Wed, 7 Jan 2026 11:08:33 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, mikkel+btrfs@mikkel.cc
Subject: Re: [PATCH] btrfs: dump the leaf if we failed to locate an inode ref
Message-ID: <20260107190833.GB2216040@zen.localdomain>
References: <c0c129ddce57c27eb0ce22af51767047c80a0f3b.1766967799.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c129ddce57c27eb0ce22af51767047c80a0f3b.1766967799.git.wqu@suse.com>

On Mon, Dec 29, 2025 at 10:53:35AM +1030, Qu Wenruo wrote:
> There are already two reports (one public and one private) of bitflips
> that corrupted the fs and caused transaction abort.
> 
> The public report has a very strong indication of the bitflip in the
> INODE_REF key type. Thankfully btrfs-check is able to detect it.
> 
> But the private report didn't preserve the environment and re-formatted
> instead, making it much harder to know exactly what bitflip is, but the
> call trace is the same as the public report, thus I have a strong
> feeling it's a similar situation.
> 
> The problem here is, the only error message we got is just "failed to
> delete reference to", no tree dump to confirm the root cause.
> 
> This is partly due to the fact that btrfs_del_inode_ref() doesn't
> provide a path for us to dump the leaf.
> 
> To improve the situation, do an inode extref search (which should not
> hit) and dump the leaf.
> This will not cover all corner cases, e.g. an inode with a lot of
> hard links, and our target ref is inside the regular inode ref item.
> But for most inodes with few hard links, this should be good enough.
> 
> I created an image with exactly the same bitflip in inode ref key, and
> try to delete the inode, with this patch the dump leaf is enough to pin
> down the root cause:
> 
>  BTRFS critical (device dm-3): failed to delete reference to inline_13, root 5 inode 270 parent 256
>  BTRFS info (device dm-3): leaf 30572544 gen 11 total ptrs 16 free space 2574 owner 5
>  BTRFS info (device dm-3): refs 2 lock_owner 0 current 2634
>  	item 0 key (267 EXTENT_DATA 0) itemoff 14214 itemsize 2069
>  		generation 9 type 0
>  		inline extent data size 2048 ram_bytes 2048 compression 0
> 	[...]
>  	item 7 key (270 INODE_ITEM 0) itemoff 9558 itemsize 160
>  		inode generation 9 transid 9 size 2048 nbytes 2048
>  		block group 0 mode 100600 links 1 uid 0 gid 0
>  		rdev 0 sequence 1 flags 0x0
>  	item 8 key (270 UNKNOWN.8 256) itemoff 9539 itemsize 19 <<<
>  	item 9 key (270 EXTENT_DATA 0) itemoff 7470 itemsize 2069
>  		generation 9 type 0
>  		inline extent data size 2048 ram_bytes 2048 compression 0
> 	[...]
>  ------------[ cut here ]------------
>  BTRFS: Transaction aborted (error -2)
>  WARNING: inode.c:4445 at __btrfs_unlink_inode+0x42c/0x460 [btrfs], CPU#4: rm/2634
>  [...]
>  ---[ end trace 0000000000000000 ]---
>  BTRFS: error (device dm-3 state A) in __btrfs_unlink_inode:4445: errno=-2 No such entry
>  BTRFS info (device dm-3 state EA): forced readonly
> 
> Reported-by: mikkel+btrfs@mikkel.cc
> Link: https://lore.kernel.org/linux-btrfs/5d5e344e-96be-4436-9a58-d60ba14fdb4f@gmx.com/T/#me22cef92653e660e88a4c005b10f5201a8fd83ac
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/inode.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index aa9ce054ab1f..370dfb13d6f3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -72,6 +72,7 @@
>  #include "raid-stripe-tree.h"
>  #include "fiemap.h"
>  #include "delayed-inode.h"
> +#include "print-tree.h"
>  
>  #define COW_FILE_RANGE_KEEP_LOCKED	(1UL << 0)
>  #define COW_FILE_RANGE_NO_INLINE	(1UL << 1)
> @@ -4349,6 +4350,36 @@ static void update_time_after_link_or_unlink(struct btrfs_inode *dir)
>  	inode_set_mtime_to_ts(&dir->vfs_inode, now);
>  }
>  
> +static __cold void dump_tree_for_inode_ref(struct btrfs_root *root,
> +					   const struct fscrypt_str *name,
> +					   u64 ino, u64 dir_ino)
> +{
> +	BTRFS_PATH_AUTO_RELEASE(path);
> +	struct btrfs_key key;
> +	int ret;
> +
> +	/*
> +	 * We're here because we failed to find the inode ref, meaning neither
> +	 * a matching INODE_REF nor INODE_EXTREF is found.
> +	 * So we can directly go searching INODE_EXTREF.
> +	 */

Given how specific this is, maybe rename the helper function to
"dump_tree_for_missing_inode_ref" or something along those lines.

Thanks,
Boris

> +	key.objectid = ino;
> +	key.type = BTRFS_INODE_EXTREF_KEY;
> +	key.offset = btrfs_extref_hash(dir_ino, name->name, name->len);
> +	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +	if (ret < 0)
> +		return;
> +
> +	/*
> +	 * We're at the slot where INODE_EXTREF should be inserted.
> +	 * For an inode with tons of hard links it may not cover what we want
> +	 * (e.g. a regular INODE_REF item).
> +	 * But it should be good enough for most inodes which have very few
> +	 * hard links.
> +	 */
> +	btrfs_print_leaf(path.nodes[0]);
> +}
> +
>  /*
>   * unlink helper that gets used here in inode.c and in the tree logging
>   * recovery code.  It remove a link in a directory with a given name, and
> @@ -4410,6 +4441,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
>  		btrfs_crit(fs_info,
>  	   "failed to delete reference to %.*s, root %llu inode %llu parent %llu",
>  			   name->len, name->name, btrfs_root_id(root), ino, dir_ino);
> +		dump_tree_for_inode_ref(root, name, ino, dir_ino);
>  		btrfs_abort_transaction(trans, ret);
>  		return ret;
>  	}
> -- 
> 2.52.0
> 

