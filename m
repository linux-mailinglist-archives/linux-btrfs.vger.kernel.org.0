Return-Path: <linux-btrfs+bounces-20603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF15D2916F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 23:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CF9305B1C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 22:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1531AABA;
	Thu, 15 Jan 2026 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="F4bMw3bM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u+jf7D50"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDAC50094C;
	Thu, 15 Jan 2026 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517250; cv=none; b=cZeuTjNOkorFFK/MGcbNEDn5LZ37LmwD6QW7gqXUM9WnThmoQt0QV9R3kqHDJ4UC0d+43yKMzGPK2BhFOLGHvSmf2zmD4U8z+czuUwRkGC4L/ndSFPRwBkAYMvgtk07T3ARaWEMo/ygyTB13g2Je1sIITEx5P8+kb2gLL5UDJN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517250; c=relaxed/simple;
	bh=t5X4TfulTs7ImIEAgDj0NJj2vA9q4FkGlIve8mp8738=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIEU0HYEB1rjHHqGr+csqMoy5VO5ssW9ejUKCA9NPDAKXeBgBDnlddkbpisy6EAP+ail15xpTp2CYN5gjTIq90m0dYfyehbVgPB1B0W1fZxJWKQqP9ZhnPxdS1PxGvAMrXG2qQgeb8gX6+gDiog27mjv11CS1b4jSSym/5Kr9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=F4bMw3bM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u+jf7D50; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86C557A007B;
	Thu, 15 Jan 2026 17:47:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Jan 2026 17:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768517248; x=1768603648; bh=2JIKgs1Hqf
	n9oQAIfi1Vtb/eXrI2GRHBVWpAhBeqAPo=; b=F4bMw3bMd+EF/kDdRSazXDcVO7
	ggw4O4p099NhQNZ6LC99pWQZu38tmdfRIjLak2wT03gQRaDglNFusQKJ574tnZYi
	glzdU2Mmpl4GL6A9VyspwLjqvVuWMjYbTtgefL3NuFdDDJrfUNFpiOAlcBNvO1jk
	WlEcdECL/6Fyi9td8dR1+dvhCnKu8bubOdxagSq8pozhyOQLykxE100V4DEjVhTn
	3D+f3wyiLH8lT67R9b9kFXU+GFebUnUuyyyNhu2NgIQNZIIyM8qEq+xv9MqEQjXy
	p8WEah03/GSBcXX067sxj/1x6d22hV4Ew/ErQNo7XpFPdw5ak0/sIAU4dfSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768517248; x=1768603648; bh=2JIKgs1Hqfn9oQAIfi1Vtb/eXrI2GRHBVWp
	AhBeqAPo=; b=u+jf7D50RejUgzY/2SZnODEqzb18KxWHIRqWywKp+SJDfSoZLgo
	V4S68sbAaxMIZfYe7RTDSzWf7I7orvl8m0FRlySCaMVjkkLqNs10LT8wtRrxhjtl
	rAsKdVPuDDCXvcb/CqKu1/3afO9CdcYYC/9f9ZMPGPlFxR/s+yxkHXmrYLdWmcct
	s6x/LWOOeBRFRR6ScBtDNgCdl7gAgN6JptbErkMzUlbkQULOM8hjbrBi3mFtytgY
	RW9q06UGf/vj0hGMBuYgz99phJKtXtKrU2qNywfMuIJl3KybJ62sFX4wd0ce80fH
	W74OiwPzK/fDn38L3O2g1/6oRZANQ9QrzFQ==
X-ME-Sender: <xms:gG5paQNjyevqGq5ajiSjgsaphFXkcggIyu_xcw9YAi72tzGaBoUDkQ>
    <xme:gG5paYcEGbrUBkOg_vu4iG0HePChRm3yJ_VoWR31mRx88rJM5QYYrUkuhkYdCeead
    1B2jjjR3Pi_j8DU7EYDZuqdn2k56R8TJbEThV9FHgH765kJv6dR0Hc>
X-ME-Received: <xmr:gG5paXX0QSravSKpE-mBLlgPYbzXP5yiWTxHUqu9t_ChZYbmG0MsJL8nKTdkalKxXtdrI3Si75yovrcL8tM2ennth0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhirghshhgvnhhgjhhirghnghgtohholhesghhmrghilhdrtghomhdprhgtphhtth
    hopegtlhhmsehfsgdrtghomhdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:gG5paYiNjhVrnqhRQ1M3_BBJzN8G1S4LFi-oZ2XMDxVWq1hkUeay5Q>
    <xmx:gG5pae-6cwCWKOH54Oba4J12Ri_r0kGz-VAVR7H7VoD8juxdOuFcMQ>
    <xmx:gG5paSaT_rif-D1x9O08YkhgyZ_9ZdZ40YJZXYV1f7kX0VggLloURg>
    <xmx:gG5pad0lZGAcIMvZOyczQlxY1p7Vi9JuguXV5L_Tbe9eAFwb09qe2A>
    <xmx:gG5paY58t2mSqIS1b9x2dRoKbCIroxR2v-Q0mo8jn-EWz2kd-dtQ7Z94>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 17:47:27 -0500 (EST)
Date: Thu, 15 Jan 2026 14:47:24 -0800
From: Boris Burkov <boris@bur.io>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unnecessary RCU protection in
 clear_incompat_bg_bits
Message-ID: <20260115224724.GB2118372@zen.localdomain>
References: <20260115143826.17725-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115143826.17725-1-jiashengjiangcool@gmail.com>

On Thu, Jan 15, 2026 at 02:38:26PM +0000, Jiasheng Jiang wrote:
> The function clear_incompat_bg_bits() currently uses
> list_for_each_entry_rcu() to iterate over the fs_info->space_info list.
> However, inside the loop, it calls down_read(&sinfo->groups_sem).
> 
> Since down_read() is a blocking operation that can sleep, calling it
> inside an implied RCU read-side critical section is illegal and can
> trigger "scheduling while atomic" errors or lockdep warnings.

Since we aren't actually in an rcu critical section this isn't really
the case. You did say "implied" but that is kind of hiding a lot of
meaning for a quick read. And the suggestion of hitting a scheduling
while atomic warning *is* wrong and misleading.

The debug warning this will really trigger is __list_check_rcu()
calling rcu_read_lock_any_held() if CONFIG_PROVE_RCU_LIST is enabled.

> 
> As established in commit 728049050012 ("btrfs: kill the RCU protection
> for fs_info->space_info"), the space_info list is initialized upon mount
> and destroyed during unmount. It does not change during the runtime of
> the filesystem, making RCU protection unnecessary.
> 
> Fix this by switching to the standard list_for_each_entry() iterator,
> which safely allows blocking operations like semaphore acquisition within
> the loop.

Please rephrase the commit message to indicate that the problem is the
unnecessary/misleading usage of the _rcu variant since we are not
in an rcu read critical section, rather than focusing on the semaphore,
which is a code smell but not actually wrong.

In general, my advice to you for your contributions going forward is to
focus on the specific improvement your fix results in, ideally with a
demonstration that it truly happens, as opposed to theoretical issues
with the code that may or may not actually be realized.

So in this case, for example, you would point out that the code hits the
CONFIG_PROVE_RCU_LIST warning and show the dmesg snippet. That also
has the positive side effect of improving reviewer confidence that you
are fully understanding and validating your changes.

Thanks,
Boris

> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  fs/btrfs/block-group.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 08b14449fabe..d2cb26f130eb 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1011,7 +1011,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
>  		struct list_head *head = &fs_info->space_info;
>  		struct btrfs_space_info *sinfo;
>  
> -		list_for_each_entry_rcu(sinfo, head, list) {
> +		list_for_each_entry(sinfo, head, list) {
>  			down_read(&sinfo->groups_sem);
>  			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5]))
>  				found_raid56 = true;
> -- 
> 2.25.1
> 

