Return-Path: <linux-btrfs+bounces-3828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C73895A67
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 19:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB1B281028
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EB615A4AE;
	Tue,  2 Apr 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="BAk6HSlR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lXQLr2/S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9B15990A;
	Tue,  2 Apr 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077686; cv=none; b=Pbjw+qHcHhE6nP82kQfiIeFD3YqXJ7fAsTri2kkia92kCWK3efqgxewlULLoQIeKHjxxSrhr6S1pBdoKqoOWzUGIE5OfBY2uoV+JEL4gDQJNgUSpq4mD5NtqLhbA8TbzNgX9QTAO0Zawwn/P5kDH4nmVo4nlX98W3Y2bSnEsy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077686; c=relaxed/simple;
	bh=NPKBSPd4OtXtJxfl6EHCaRvOP+p8vmUs8gwRYnZmPIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeL9iUlS3PdSHAAA0Dl2PcmFGqPWEB0Aw0X3YuF/dh1PZ7raHVb3MoJIOqNJ+5eFdLWapdbEAJUBihh0j0wVxWS8mXxsx4/U+l/HEV2G38hh+ijPCyL3ZEugAsGzbITyg3xken0Pdbf53FZXBI+1bwMahy19ZqhyPBZ7XxnNC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=BAk6HSlR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lXQLr2/S; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 7CB155C0060;
	Tue,  2 Apr 2024 13:08:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Apr 2024 13:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1712077683; x=1712164083; bh=TURyX1gw0L
	rfp1rYT1WtTcynEOJb+n9CGGHRW+UIORY=; b=BAk6HSlRUeftYgizsoPsLW1a1X
	Vdddm2EPll/xZ9JDRCMJ6g5LmCAn7g2LW8jiEdexhH1iOtIF1ZLSQi5zdpQfPCa1
	nJBA4wB6jANR3Nn5o6wg0DCTZn7eqp3Um+yG21g2fLT9t+JLGtxTa3Uez7ApSUXm
	r2fxQ+lG3HIRnsJJxrNnwgRtFkz7iMzXFa1GF4i6aFTDX1iUdIsT9XfDklymtFe0
	5X3EesHKzP3EqeIn8+M9PpyzQiWzRRb2jPx9uZi79Kc/unqUeqjrxhN/SzJwAswI
	uwO9HYDlU9nLOXcmXgT5mMQ/tRIWTHLj38asq620M8nYyVKF1VozheScDxrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712077683; x=1712164083; bh=TURyX1gw0Lrfp1rYT1WtTcynEOJb
	+n9CGGHRW+UIORY=; b=lXQLr2/SY0ZDTlx7+P8fCtO3feoukrEm6np6gJjWZzM1
	ewlaoCt1kpgstdi8IcjxAOAutVU2oc/rRcUWst+o77+qTOqSoNH3RSFoU6mWqHtL
	mnQ1Qi3KMu+GB2PJJ2uc/r4lq3qudhYIfvh2iotHtyGO3cJ7StJ7ODcAfvtejmPc
	Pj92TmTR6lvH0nQL2sZ7Nmaguh61CD9XfY49nsWhIrj1oZO+A1XZn5JTut7npGyM
	gV8S7jYVoY0ueq4Ony2PIOp9G2O1XCVr+ice0evHdRHog5YgAshqfZFWmqMFPs8u
	d0TP6U8B6FwlsgXn6wSbKS1kP7NUbVae2pjfxqcQnQ==
X-ME-Sender: <xms:czsMZvZhBmSoZ6MiobEeZnTWCG7OkxgCbfpIlRsbeR54ciFE1WkIHg>
    <xme:czsMZubVeD1_v_OVWU7QGEonj16QSVbhQXZnb6z4mVnpO3e-jPdUpa-7wUifeqEiQ
    6hR18HUi98HFI1fWDU>
X-ME-Received: <xmr:czsMZh8PCFg7mjClMC_gpwNm0xLzg1KdOa4pQd2OYFjM0jrY1tue9FG2TOahe7VxLYp6YtQhTtRTHHCg0KleLEW9k28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:czsMZlq2e9Ddy59WnTwjI28a0bZQ-iZNwY0fAteW_fkHZMxCjEmQyQ>
    <xmx:czsMZqpEvU0h-I_b9bs0rvTgujzJpBvj7dIqmiezCRoMKDtnFjYySg>
    <xmx:czsMZrSU5V63x1qMIkbQCXsSIV-nfiei4w8YcXHdhqHPfnpBFPi--w>
    <xmx:czsMZiqa50tEKN5eDbG63ywC2wydTSLTg3TxpKTvokd9sL30VFKULQ>
    <xmx:czsMZnQ8mgMfbtJVhU2hsRUMsfTey2PfHs40zhxZT0Mr4vpZf5GUOIgkJElG>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:08:02 -0400 (EDT)
Date: Tue, 2 Apr 2024 10:09:59 -0700
From: Boris Burkov <boris@bur.io>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>, hch@lst.de,
	Damien LeMoal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH RFC PATCH 3/3] btrfs: zoned: kick cleaner kthread if low
 on space
Message-ID: <20240402170959.GB3175858@zen.localdomain>
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
 <20240328-hans-v1-3-4cd558959407@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-hans-v1-3-4cd558959407@kernel.org>

On Thu, Mar 28, 2024 at 02:56:33PM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Kick the cleaner kthread on chunk allocation if we're slowly running out
> of usable space on a zoned filesystem.

I'm really excited about this and think it probably makes sense on
not-zoned as well.

Have you found that this is a fast enough to help real allocations that
are in trouble? I'd be worried that it's a lot faster than waiting 30
seconds but still not urgent enough to save the day for someone trying
to allocate right now.

Not a blocking request for this patch, which I think is a definite
improvement, but we could do something like add a pass to find_free_extent
(before allocating a fresh BG?!?) that blocks on reclaim running if we
have kicked it (or errors out in a way that signals to the outer loop
that we can wait for reclaim, if needed for locking or whatever)

> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index fb8707f4cab5..25c1a17873db 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1040,6 +1040,7 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
>  u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>  				 u64 hole_end, u64 num_bytes)
>  {
> +	struct btrfs_fs_info *fs_info = device->fs_info;
>  	struct btrfs_zoned_device_info *zinfo = device->zone_info;
>  	const u8 shift = zinfo->zone_size_shift;
>  	u64 nzones = num_bytes >> shift;
> @@ -1051,6 +1052,11 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>  	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
>  	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
>  
> +	if (!test_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags) &&
> +	    btrfs_zoned_should_reclaim(fs_info)) {
> +		wake_up_process(fs_info->cleaner_kthread);
> +	}
> +
>  	while (pos < hole_end) {
>  		begin = pos >> shift;
>  		end = begin + nzones;
> 
> -- 
> 2.35.3
> 

