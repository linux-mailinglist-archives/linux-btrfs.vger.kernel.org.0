Return-Path: <linux-btrfs+bounces-15277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E452AFAA4B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 05:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B15170EF1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 03:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ECE259CAB;
	Mon,  7 Jul 2025 03:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSkc+t9E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416EFF510
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751859345; cv=none; b=L8kNmaLX2qIwM1S5VPQzJEDwIsAb20I1aivFx5FcvO6hc5HAJ+JgC4hGN8Fsjt9tiPwr99f7+j6iMv2zpUwkj/Te/F0UGaQXmqXAnXg0i6Wgy8B4PR3Bp1vJEIucdNEDaOTFm2C7CLyXtiWcUZPEEu5k6YgV16tXQGeK1sI1muI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751859345; c=relaxed/simple;
	bh=B26fjtY4GM1Gfj1Y/BrISS7kIMhc6T5Hu6EVm0oWMG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qL3S7hHEVHe0vA2Rt1VnqjnVR09Ss0jqk5dYBrjkGh5+TZ4Roj00NEl71EjTts/sQywChXcGJjo7lf1BD63As0zO0MjLJWJ/ES/u3nQbR/QBjWqxy/pN472E+G0QZC5O8bNMlgqv7fjxWrpHorN6FQ8JzRaE88Nl1dRWgR1EFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSkc+t9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE95C4CEE3;
	Mon,  7 Jul 2025 03:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751859344;
	bh=B26fjtY4GM1Gfj1Y/BrISS7kIMhc6T5Hu6EVm0oWMG4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qSkc+t9Ebd4w2c9S3IejMQu9byRisIf6f8vo8zRcnWTymKrqlGaMHNQPSU+0EykNw
	 H1gurn09kgFtQIq2Nm63hnlY7QAvWi+Op++c6eD3Ojg3Y3H9vzF4MAeCegNEz88fOu
	 i72H7YSL6CdEZwurd7kfav//aNXCJwTVjd1qPsYrgVLTF+r3c/4IMcM8aXb6Hfdc1c
	 TW7QopmDd9DoY99eMQTTyKWReqLS2UwIlLI6QjfPrpeFk0TkBvIJgI0+eFtrOW8AYV
	 Tb0+N4tN2PUDrY5mzrr0Jh9hUIFkgaeIKYNUq8hiIIroAbpbW+mpH2tQvwvgkBJUrP
	 uoFdFBHa9LFnw==
Message-ID: <980ce4d7-fa7e-4320-8816-ab22d8021415@kernel.org>
Date: Mon, 7 Jul 2025 12:33:34 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: zoned: fix write time activation failure for
 metadata block group
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <cover.1751611657.git.naohiro.aota@wdc.com>
 <bb200206ae65453c68c2f3e316378838797e2502.1751611657.git.naohiro.aota@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <bb200206ae65453c68c2f3e316378838797e2502.1751611657.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 11:44 AM, Naohiro Aota wrote:
> Since commit 13bb483d32ab ("btrfs: zoned: activate metadata block group on
> write time"), we activate a metadata block group on the write time. If the

on the write time -> at write time

> zone capacity is small enough, we can allocate the entire region before the
> first write. Then, we hit the btrfs_zoned_bg_is_full() in
> btrfs_zone_activate() and the activation fails.
> 
> For a data block group, we already check the fullness condition in the
> caller side. And, the fullness check is not necessary for metadata's
> write-time activation. Replace it with a proper WARN.

I am very confused by this explanation. If the BG is fully allocated before we
issue the first write, we still need to activate that BG, no ? So why the
WARN() ? That seems wrong to me. But I may not be understanding your
explanation, which means you need to clarify it :)

> 
> Fixes: 13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
> CC: stable@vger.kernel.org # 6.6+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/zoned.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 6fb4d95412d6..9c354e84ab07 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2169,10 +2169,13 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
>  		goto out_unlock;
>  	}
>  
> -	/* No space left */
> -	if (btrfs_zoned_bg_is_full(block_group)) {
> -		ret = false;
> -		goto out_unlock;
> +	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA) {
> +		if (WARN_ON_ONCE(btrfs_zoned_bg_is_full(block_group))) {
> +			ret = false;
> +			goto out_unlock;
> +		}
> +	} else {
> +		WARN_ON_ONCE(block_group->meta_write_pointer != block_group->start);
>  	}
>  
>  	for (i = 0; i < map->num_stripes; i++) {


-- 
Damien Le Moal
Western Digital Research

