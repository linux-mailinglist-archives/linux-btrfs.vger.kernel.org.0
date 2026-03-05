Return-Path: <linux-btrfs+bounces-22253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL07F7G9qWnNDQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22253-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 18:30:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D2F2163C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 18:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD44B319D978
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 17:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23EA3E5EFE;
	Thu,  5 Mar 2026 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GlqIaBDR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hzvHTsI+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99003E5EC2
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731507; cv=none; b=ZKQmAywOrQjPJ3w0KyGF1cU3bP0ak/KdQiosmCbZBdSa3OWiUbwOi/fXpT1Rd3UW3NKAa607KcNwiTfl5X/0AufUpyHBJ+ClBFr1zKcMbkeWX4wjrVPCuVeIiCPN1j2Hi8v+TBw6bJCXb9zURxlnhHGlhoUpKWmmF5kyLANi8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731507; c=relaxed/simple;
	bh=aDj5FN68IknNg92KEfY1lp7Q7DPK5tYm5gb054FwEnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7UUPGeLVbskAoQjLH7VhR1rMdkPhTaEphtmGXV2PkU83UxmZ3EIpsNq8qHrQ8uithAiJsfSIM08HaH9rPILH24iOCDJD93hBS8FV+G/5u8FYsHj7K7Ddj2b9tKC8e2p3dAY0Wsy6SXRXc2xWkPXMT9ano8lTNRz+/MFJYqG5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GlqIaBDR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hzvHTsI+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A78314001D0;
	Thu,  5 Mar 2026 12:25:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 12:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772731504; x=1772817904; bh=8jA/EjgEeu
	5TfegT7/d/R4C2oAMPJNmOOQaXGZKqIOU=; b=GlqIaBDR9fbGfw5OkoGXAXJ4lv
	kHq63ToGaKvujSL+jsMG6r15hqOdUzEvt1mItla7kZySoaQaXr/nkDFxUh8OdyfW
	p+cF+QKRvyqnHkjq0RQo7lhlbnik2bLd6pumbksjRrJ/iRZoN1n6BJUcj3LJoE/+
	C5r1qC+SHxafahWTCssVWlG+HiSQDuIMmda7ouzZWKlLNHrxnSmk46ox+ZXxUjut
	MPVPXZhOqlYvJxgr2BPP1Z9NDa6Uu9xWFZYsNgPPpZYnm0unX+WDHqehiU7tIu3/
	Jb6zGttymVhInLzlubzpv/2FiZqpIQCBQta6wxbT5DgOAMBLNNexqqPCmeNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772731504; x=1772817904; bh=8jA/EjgEeu5TfegT7/d/R4C2oAMPJNmOOQa
	XGZKqIOU=; b=hzvHTsI+XrflRfIJ8K9XbFyxWSrxo+OKHPzFgX6AGdliT1CLSvN
	Yh4yntb4QNumB2KRg50oK8VrfW/ZUCJgc7eKp0O0jJLDRAvjVYkVb+LFb7nEHVDV
	XnT1O5VGRX+0kQrJnqJlRykr+cDQKvQYfqevdeifpChhG2lBw8I9f3+EGuJGAsNi
	rJOcGknmgkEKDmRbpK6SxFSKONdxLgUbvoyIY90qMYMWIDnKUnl4QWB7IsOlh0i6
	cJhJ1VTCNkcvenRvUFseWt62oTjF9HV8dPDSzCRIhxQisWKPf5ClwJ1ENrV2i1t2
	B62SMweAQ34eOIz6O/QM5yhigO38f2DKtwA==
X-ME-Sender: <xms:b7ypaX1qUQge6mpBHKtOSdu1SmQPhLy4LC7N73dTN832G0RmfOli2w>
    <xme:b7ypac-Lv1wb2qtLmBnYBXknuJNQker58P7VAf2mJENq0CfELkwSFQtUk4t4yehjM
    61R47LqWdWP2SttN2IfNWG2fE68-trxkbf05Msh7Nm0xXxkT7I-ahtM>
X-ME-Received: <xmr:b7ypaQMUEZ3L-qqS2hMhOaCbOP8_JkShp7LXVKPVuQIuMSvjlGUgBAYy8A1QHmmaMXn2VibwjxhAgJlQ-2E1uUx8VdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeileejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhthhhumhhshhhirhhnseifuggtrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehshhhinhhitghhihhrohdrkhgrfigrshgrkhhiseifuggtrdgtohhmpdhrtghpthhtoh
    epnhgrohhhihhrohdrrghothgrseifuggtrdgtohhmpdhrtghpthhtohepughlvghmohgr
    lheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:b7ypaYdhpcomDFI3nG9M45PWdua2rWKrrD-4aBC67pxNC4QgQbp5MA>
    <xmx:b7ypaXWNkw3zWzOUxoCgA-Rg29Tkk7-lIfuYqhaKyyvr_cYl_qv6-Q>
    <xmx:b7ypaYiywjrggb88TIXCJp5prHT1lxi1nwq3e1lmSf0AVkNeC0c7JQ>
    <xmx:b7ypae975cyB-G4lAsvX0wAD5RhFm5Ya50Pko4-W7Wr1igRmVZkdCQ>
    <xmx:cLypaVM5Ey7zR007nVXkZNUp-2pmnUjqRlQG6nVITBb50s1tGWSmcpqg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 12:25:01 -0500 (EST)
Date: Thu, 5 Mar 2026 09:25:41 -0800
From: Boris Burkov <boris@bur.io>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 1/3] btrfs: move reclaiming of a single block group
 into its own function
Message-ID: <20260305172541.GA926642@zen.localdomain>
References: <20260305100644.356177-1-johannes.thumshirn@wdc.com>
 <20260305100644.356177-2-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305100644.356177-2-johannes.thumshirn@wdc.com>
X-Rspamd-Queue-Id: C7D2F2163C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22253-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 11:06:42AM +0100, Johannes Thumshirn wrote:
> The main work of reclaiming a single block-group in
> btrfs_reclaim_bgs_work() is done inside the loop iterating over all the
> block_groups in the fs_info->reclaim_bgs list.
> 
> Factor out reclaim of a single block group from the loop to improve
> readability.
> 
> No functional change intented.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 256 +++++++++++++++++++++--------------------
>  1 file changed, 133 insertions(+), 123 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index b5c274715809..4df076bd93f5 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1909,6 +1909,137 @@ static bool should_reclaim_block_group(const struct btrfs_block_group *bg, u64 b
>  	return true;
>  }
>  
> +static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = bg->fs_info;
> +	struct btrfs_space_info *space_info = bg->space_info;
> +	u64 used;
> +	u64 reserved;
> +	u64 old_total;
> +	int ret = 0;
> +
> +	/* Don't race with allocators so take the groups_sem */
> +	down_write(&space_info->groups_sem);
> +
> +	spin_lock(&space_info->lock);
> +	spin_lock(&bg->lock);
> +	if (bg->reserved || bg->pinned || bg->ro) {
> +		/*
> +		 * We want to bail if we made new allocations or have
> +		 * outstanding allocations in this block group.  We do
> +		 * the ro check in case balance is currently acting on
> +		 * this block group.
> +		 */
> +		spin_unlock(&bg->lock);
> +		spin_unlock(&space_info->lock);
> +		up_write(&space_info->groups_sem);
> +		return 0;
> +	}
> +
> +	if (bg->used == 0) {
> +		/*
> +		 * It is possible that we trigger relocation on a block
> +		 * group as its extents are deleted and it first goes
> +		 * below the threshold, then shortly after goes empty.
> +		 *
> +		 * In this case, relocating it does delete it, but has
> +		 * some overhead in relocation specific metadata, looking
> +		 * for the non-existent extents and running some extra
> +		 * transactions, which we can avoid by using one of the
> +		 * other mechanisms for dealing with empty block groups.
> +		 */
> +		if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +			btrfs_mark_bg_unused(bg);
> +		spin_unlock(&bg->lock);
> +		spin_unlock(&space_info->lock);
> +		up_write(&space_info->groups_sem);
> +		return 0;
> +	}
> +
> +	/*
> +	 * The block group might no longer meet the reclaim condition by
> +	 * the time we get around to reclaiming it, so to avoid
> +	 * reclaiming overly full block_groups, skip reclaiming them.
> +	 *
> +	 * Since the decision making process also depends on the amount
> +	 * being freed, pass in a fake giant value to skip that extra
> +	 * check, which is more meaningful when adding to the list in
> +	 * the first place.
> +	 */
> +	if (!should_reclaim_block_group(bg, bg->length)) {
> +		spin_unlock(&bg->lock);
> +		spin_unlock(&space_info->lock);
> +		up_write(&space_info->groups_sem);
> +		return 0;
> +	}
> +
> +	spin_unlock(&bg->lock);
> +	old_total = space_info->total_bytes;
> +	spin_unlock(&space_info->lock);
> +
> +	/*
> +	 * Get out fast, in case we're read-only or unmounting the
> +	 * filesystem. It is OK to drop block groups from the list even
> +	 * for the read-only case. As we did take the super write lock,
> +	 * "mount -o remount,ro" won't happen and read-only filesystem
> +	 * means it is forced read-only due to a fatal error. So, it
> +	 * never gets back to read-write to let us reclaim again.
> +	 */

nit: this name is getting stretched if we are now calling this outside
the cleaner context.

> +	if (btrfs_need_cleaner_sleep(fs_info)) {
> +		up_write(&space_info->groups_sem);
> +		return 0;
> +	}
> +
> +	ret = inc_block_group_ro(bg, false);
> +	up_write(&space_info->groups_sem);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The amount of bytes reclaimed corresponds to the sum of the
> +	 * "used" and "reserved" counters. We have set the block group
> +	 * to RO above, which prevents reservations from happening but
> +	 * we may have existing reservations for which allocation has
> +	 * not yet been done - btrfs_update_block_group() was not yet
> +	 * called, which is where we will transfer a reserved extent's
> +	 * size from the "reserved" counter to the "used" counter - this
> +	 * happens when running delayed references. When we relocate the
> +	 * chunk below, relocation first flushes delalloc, waits for
> +	 * ordered extent completion (which is where we create delayed
> +	 * references for data extents) and commits the current
> +	 * transaction (which runs delayed references), and only after
> +	 * it does the actual work to move extents out of the block
> +	 * group. So the reported amount of reclaimed bytes is
> +	 * effectively the sum of the 'used' and 'reserved' counters.
> +	 */
> +	spin_lock(&bg->lock);
> +	used = bg->used;
> +	reserved = bg->reserved;
> +	spin_unlock(&bg->lock);
> +
> +	trace_btrfs_reclaim_block_group(bg);
> +	ret = btrfs_relocate_chunk(fs_info, bg->start, false);
> +	if (ret) {
> +		btrfs_dec_block_group_ro(bg);
> +		btrfs_err(fs_info, "error relocating chunk %llu",
> +			  bg->start);
> +		used = 0;
> +		reserved = 0;
> +		spin_lock(&space_info->lock);
> +		space_info->reclaim_errors++;
> +		spin_unlock(&space_info->lock);
> +	}
> +	spin_lock(&space_info->lock);
> +	space_info->reclaim_count++;
> +	space_info->reclaim_bytes += used;
> +	space_info->reclaim_bytes += reserved;
> +	if (space_info->total_bytes < old_total)
> +		btrfs_set_periodic_reclaim_ready(space_info, true);
> +	spin_unlock(&space_info->lock);
> +
> +	return ret;
> +}
> +
>  void btrfs_reclaim_bgs_work(struct work_struct *work)
>  {
>  	struct btrfs_fs_info *fs_info =
> @@ -1942,10 +2073,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	 */
>  	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);
>  	while (!list_empty(&fs_info->reclaim_bgs)) {
> -		u64 used;
> -		u64 reserved;
> -		u64 old_total;
> -		int ret = 0;
> +		int ret;
>  
>  		bg = list_first_entry(&fs_info->reclaim_bgs,
>  				      struct btrfs_block_group,
> @@ -1954,126 +2082,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  
>  		space_info = bg->space_info;
>  		spin_unlock(&fs_info->unused_bgs_lock);
> +		ret = btrfs_reclaim_block_group(bg);
>  
> -		/* Don't race with allocators so take the groups_sem */
> -		down_write(&space_info->groups_sem);
> -
> -		spin_lock(&space_info->lock);
> -		spin_lock(&bg->lock);
> -		if (bg->reserved || bg->pinned || bg->ro) {
> -			/*
> -			 * We want to bail if we made new allocations or have
> -			 * outstanding allocations in this block group.  We do
> -			 * the ro check in case balance is currently acting on
> -			 * this block group.
> -			 */
> -			spin_unlock(&bg->lock);
> -			spin_unlock(&space_info->lock);
> -			up_write(&space_info->groups_sem);
> -			goto next;
> -		}
> -		if (bg->used == 0) {
> -			/*
> -			 * It is possible that we trigger relocation on a block
> -			 * group as its extents are deleted and it first goes
> -			 * below the threshold, then shortly after goes empty.
> -			 *
> -			 * In this case, relocating it does delete it, but has
> -			 * some overhead in relocation specific metadata, looking
> -			 * for the non-existent extents and running some extra
> -			 * transactions, which we can avoid by using one of the
> -			 * other mechanisms for dealing with empty block groups.
> -			 */
> -			if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
> -				btrfs_mark_bg_unused(bg);
> -			spin_unlock(&bg->lock);
> -			spin_unlock(&space_info->lock);
> -			up_write(&space_info->groups_sem);
> -			goto next;
> -
> -		}
> -		/*
> -		 * The block group might no longer meet the reclaim condition by
> -		 * the time we get around to reclaiming it, so to avoid
> -		 * reclaiming overly full block_groups, skip reclaiming them.
> -		 *
> -		 * Since the decision making process also depends on the amount
> -		 * being freed, pass in a fake giant value to skip that extra
> -		 * check, which is more meaningful when adding to the list in
> -		 * the first place.
> -		 */
> -		if (!should_reclaim_block_group(bg, bg->length)) {
> -			spin_unlock(&bg->lock);
> -			spin_unlock(&space_info->lock);
> -			up_write(&space_info->groups_sem);
> -			goto next;
> -		}
> -
> -		spin_unlock(&bg->lock);
> -		old_total = space_info->total_bytes;
> -		spin_unlock(&space_info->lock);
> -
> -		/*
> -		 * Get out fast, in case we're read-only or unmounting the
> -		 * filesystem. It is OK to drop block groups from the list even
> -		 * for the read-only case. As we did take the super write lock,
> -		 * "mount -o remount,ro" won't happen and read-only filesystem
> -		 * means it is forced read-only due to a fatal error. So, it
> -		 * never gets back to read-write to let us reclaim again.
> -		 */
> -		if (btrfs_need_cleaner_sleep(fs_info)) {
> -			up_write(&space_info->groups_sem);
> -			goto next;
> -		}
> -
> -		ret = inc_block_group_ro(bg, false);
> -		up_write(&space_info->groups_sem);
> -		if (ret < 0)
> -			goto next;
> -
> -		/*
> -		 * The amount of bytes reclaimed corresponds to the sum of the
> -		 * "used" and "reserved" counters. We have set the block group
> -		 * to RO above, which prevents reservations from happening but
> -		 * we may have existing reservations for which allocation has
> -		 * not yet been done - btrfs_update_block_group() was not yet
> -		 * called, which is where we will transfer a reserved extent's
> -		 * size from the "reserved" counter to the "used" counter - this
> -		 * happens when running delayed references. When we relocate the
> -		 * chunk below, relocation first flushes delalloc, waits for
> -		 * ordered extent completion (which is where we create delayed
> -		 * references for data extents) and commits the current
> -		 * transaction (which runs delayed references), and only after
> -		 * it does the actual work to move extents out of the block
> -		 * group. So the reported amount of reclaimed bytes is
> -		 * effectively the sum of the 'used' and 'reserved' counters.
> -		 */
> -		spin_lock(&bg->lock);
> -		used = bg->used;
> -		reserved = bg->reserved;
> -		spin_unlock(&bg->lock);
> -
> -		trace_btrfs_reclaim_block_group(bg);
> -		ret = btrfs_relocate_chunk(fs_info, bg->start, false);
> -		if (ret) {
> -			btrfs_dec_block_group_ro(bg);
> -			btrfs_err(fs_info, "error relocating chunk %llu",
> -				  bg->start);
> -			used = 0;
> -			reserved = 0;
> -			spin_lock(&space_info->lock);
> -			space_info->reclaim_errors++;
> -			spin_unlock(&space_info->lock);
> -		}
> -		spin_lock(&space_info->lock);
> -		space_info->reclaim_count++;
> -		space_info->reclaim_bytes += used;
> -		space_info->reclaim_bytes += reserved;
> -		if (space_info->total_bytes < old_total)
> -			btrfs_set_periodic_reclaim_ready(space_info, true);
> -		spin_unlock(&space_info->lock);
> -
> -next:
>  		if (ret && !READ_ONCE(space_info->periodic_reclaim))
>  			btrfs_link_bg_list(bg, &retry_list);
>  		btrfs_put_block_group(bg);
> -- 
> 2.53.0
> 

