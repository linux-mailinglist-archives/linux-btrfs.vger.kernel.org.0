Return-Path: <linux-btrfs+bounces-20474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE4D1B81E
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 23:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E316B304C675
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 21:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1151350D79;
	Tue, 13 Jan 2026 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Trbo7K0R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMLUnrRG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D9274B37
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341597; cv=none; b=KLZmTxen4u3Y5pELCq4ghXc8y59BocrUqfwuhs5bbM+ywAnWgTXwsjb+gThubCPX8pvUtJFisgdWwjIYTJVWNSYoPtMPgIkkeVWI43GdpBeHnlfdNsGlvsOQbl1Es2+0YrwpuSZtd/iVDLe9qq9PzpesGOKfKoJ458I+ZFLhgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341597; c=relaxed/simple;
	bh=3r1iPiUyTYIZHlKv0tzlu6Ag5TOYAMMSupodhwgS8m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVo8J8nqqcC94BTX2HnuVIR4kBm4BP/rCeDXFffRiohr5W9BIO78FExjGZ+fz4AZPtZzqOs60EmrtcLT29LJzpEoZAyt1XvXcow4jWO++xsOsVFIJ+HGiBA+2zX7k4yvDoNSV6R8a1dIVysDRp2y2+wRBoqFvqR7kCfCQWp3AoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Trbo7K0R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMLUnrRG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 293C81400068;
	Tue, 13 Jan 2026 16:59:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 13 Jan 2026 16:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768341595; x=1768427995; bh=01EctzKjhr
	evayOgxzt3g0lhovdKHArC41b4UPcHBsE=; b=Trbo7K0RjbD/voiyjMTXwicnYY
	VRQXBZUk8xh6kXJrDNe2TdBe3z8emMwAz6G+uP4C8sLk3vKwMuXk5T0rsBBqES7T
	UcdKm4W5sM8sUNQfaniUIyV08W8TmkpBlKWL68+ktH3MUvZM+Hh+YPtqu1g0wHXl
	2LElGrEgxMzIfa4TV4/l1a0A1VI72pEFqQGSfTiqHrTLGcEWdqeEY1z4n8tOabDk
	i7nmPa6QuOlL1BtpE/MVlnyQEEmQ+4cus+giPg2dtlmj+yJqOVUej+q7FBB0gmJU
	mOlzUMWmFb95E9K62i0U51eWJ4zKXcInn+50r+5f6rHzvtQfUnvr+uqyw6sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768341595; x=1768427995; bh=01EctzKjhrevayOgxzt3g0lhovdKHArC41b
	4UPcHBsE=; b=qMLUnrRG2knR22Z5rQqSgaP4JdeBbjYGVS+3Yx12Ko9La0SSC8g
	BeDX0c8M4E93QrXczBpfAuZqtCKKP+y7FAo+MOm9YiziRGuNB2CahbT6i/5OuEil
	I9GnULkK39ghDZ09Uw9x6t7B1YlzxPEULg4vXJZjB1dFimZjMy+BAQLgCAvj299m
	2xB8GFK8EkYKVzjSApE5I8ln79rk3VGzqU7GUFyopP7W1nM7vD8EZKmowarN8Mv8
	88LhVhNWBGfowBgTo5N8q5eiX+TAFps4jxKJfxNPkpBHoWtkowFrwyk+zwtPWhZ8
	DCnLKzhKNu/W6pz9LeKUuyjFrM+fkELJZoQ==
X-ME-Sender: <xms:W8Bmafi2x5-JYWcq91N5q3rw5iJ7QlCKrC7dQXnias9a07HCAXcD2g>
    <xme:W8BmaSBXnwvD8BWI5lReDkSPe8SDT0Ea-VBMgnQliT6mq8tx_zuh_3TvF8xKSD6m1
    Nz5gjkejLWoI-Ao_5e60m26B8yDRNEJ81k0QR-ecjMCybctI6JntA>
X-ME-Received: <xmr:W8BmacvO52A42Gt9reRupDZvE-F-siLwO6zKZ97I3K58GBh2B0uQV6_NTRAhTh0vmdSTHwJWZf0MnVLYAAYSBTUkN0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:W8BmaXa3e1v_mggLIIRlk9UV9j1GvQFW8U_bVqaGJNPeEjuXbLzEeg>
    <xmx:W8BmafWeD3nWGdTkW1q-_8Oo-_NcMcr2OVglyvGU8P0VEsA9clPwuw>
    <xmx:W8Bmab636jFGig3ED5GHkqs792ZcGGOrMlNO9_TWppz4mYkeQZUdIw>
    <xmx:W8BmaaiiwSQnzSC5pbbiGwYbN8-C-Mi546N0cgdlrJ4m_pgo186jQA>
    <xmx:W8BmaVuIiKp-56EdpnjYWVw88pxxD6BXjurjNm-XfJz5tz9DxWxtKca7>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:59:54 -0500 (EST)
Date: Tue, 13 Jan 2026 13:59:55 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: shrink the size of btrfs_device
Message-ID: <20260113215955.GC1048609@zen.localdomain>
References: <aa926a3bc890eb51796e6fbc9ca069fc9a4ad57d.1768001871.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa926a3bc890eb51796e6fbc9ca069fc9a4ad57d.1768001871.git.wqu@suse.com>

On Sat, Jan 10, 2026 at 10:08:28AM +1030, Qu Wenruo wrote:
> There are two main causes of holes inside btrfs_device:
> 
> - The single bytes member of last_flush_error
>   Not only it's a single byte member, but we never really care about the
>   exact error number.
> 
> - The @devt member
>   Which is put between two u64 members.
> 
> Shrink the size of btrfs_device by:
> 
> - Use a single bit flag for flush error
>   Use BTRFS_DEV_STATE_FLUSH_FAILED so that we no longer need that
>   dedicated member.
> 
> - Move @devt to the hole after dev_stat_values[]
> 
> This reduces the size of btrfs_device from 528 to exact 512 bytes for
> x86_64.
> 

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c |  6 +++---
>  fs/btrfs/volumes.c |  4 ++--
>  fs/btrfs/volumes.h | 13 +++++++------
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index cecb81d0f9e0..7ce7afe2bdaf 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3839,7 +3839,7 @@ static void write_dev_flush(struct btrfs_device *device)
>  {
>  	struct bio *bio = &device->flush_bio;
>  
> -	device->last_flush_error = BLK_STS_OK;
> +	clear_bit(BTRFS_DEV_STATE_FLUSH_FAILED, &device->dev_state);
>  
>  	bio_init(bio, device->bdev, NULL, 0,
>  		 REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH);
> @@ -3864,7 +3864,7 @@ static bool wait_dev_flush(struct btrfs_device *device)
>  	wait_for_completion_io(&device->flush_wait);
>  
>  	if (bio->bi_status) {
> -		device->last_flush_error = bio->bi_status;
> +		set_bit(BTRFS_DEV_STATE_FLUSH_FAILED, &device->dev_state);
>  		btrfs_dev_stat_inc_and_print(device, BTRFS_DEV_STAT_FLUSH_ERRS);
>  		return true;
>  	}
> @@ -3914,7 +3914,7 @@ static int barrier_all_devices(struct btrfs_fs_info *info)
>  	}
>  
>  	/*
> -	 * Checks last_flush_error of disks in order to determine the device
> +	 * Checks flush failure of disks in order to determine the device
>  	 * state.
>  	 */
>  	if (unlikely(errors_wait && !btrfs_check_rw_degradable(info, NULL)))
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 2c709cf18476..908a89eaeabf 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1169,7 +1169,7 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>  	 * any transaction and set the error state, guaranteeing no commits of
>  	 * unsafe super blocks.
>  	 */
> -	device->last_flush_error = 0;
> +	clear_bit(BTRFS_DEV_STATE_FLUSH_FAILED, &device->dev_state);
>  
>  	/* Verify the device is back in a pristine state  */
>  	WARN_ON(test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
> @@ -7374,7 +7374,7 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
>  
>  			if (!dev || !dev->bdev ||
>  			    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> -			    dev->last_flush_error)
> +			    test_bit(BTRFS_DEV_STATE_FLUSH_FAILED, &dev->dev_state))
>  				missing++;
>  			else if (failing_dev && failing_dev == dev)
>  				missing++;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 4979a7351905..93f45410931e 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -99,6 +99,7 @@ enum btrfs_raid_types {
>  #define BTRFS_DEV_STATE_REPLACE_TGT	(3)
>  #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
>  #define BTRFS_DEV_STATE_NO_READA	(5)
> +#define BTRFS_DEV_STATE_FLUSH_FAILED	(6)
>  
>  /* Special value encoding failure to write primary super block. */
>  #define BTRFS_SUPER_PRIMARY_WRITE_ERROR		(INT_MAX / 2)
> @@ -122,13 +123,7 @@ struct btrfs_device {
>  
>  	struct btrfs_zoned_device_info *zone_info;
>  
> -	/*
> -	 * Device's major-minor number. Must be set even if the device is not
> -	 * opened (bdev == NULL), unless the device is missing.
> -	 */
> -	dev_t devt;
>  	unsigned long dev_state;
> -	blk_status_t last_flush_error;
>  
>  #ifdef __BTRFS_NEED_DEVICE_DATA_ORDERED
>  	seqcount_t data_seqcount;
> @@ -192,6 +187,12 @@ struct btrfs_device {
>  	atomic_t dev_stats_ccnt;
>  	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
>  
> +	/*
> +	 * Device's major-minor number. Must be set even if the device is not
> +	 * opened (bdev == NULL), unless the device is missing.
> +	 */
> +	dev_t devt;
> +
>  	struct extent_io_tree alloc_state;
>  
>  	struct completion kobj_unregister;
> -- 
> 2.52.0
> 

