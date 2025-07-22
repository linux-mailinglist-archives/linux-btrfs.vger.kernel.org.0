Return-Path: <linux-btrfs+bounces-15626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24132B0D639
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 11:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D25A1C2693E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1012DEA82;
	Tue, 22 Jul 2025 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDMUqmMI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53324223702
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177489; cv=none; b=DPfNI7RqAtQwybL1lW2ZsBAZSliYFFNdeqh7YD3rAPx8MKG1KkB9//GzxwgGIbVqILP+ydSH6u2T5oQSHpABFNALVhCeNN65/EtEiP9N5WanUB7vrjQPEyj7IiMSetNgyaI8s47Dl/iOfiCczPfR831XDDUs7XYa9W5KRUZJW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177489; c=relaxed/simple;
	bh=jkK1s3YJSis+DpyVXP71DLpX0lBeZncm6EnHG5pheqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qk25OARrQSpNnlStz18D4m8tfuE04AsF01XCNYosv0cszC0Iea3dh+QKepkLKSwmzuFE5t8nAMJNA7PJpjxGmY+SDQtmb/0wAVyERxTXSbg60/tQM+nmSbbWM+dmgOKE/2mpfYhGwbEd7cNWRQLNl6RSn+rM7bIq1Ls/KUc9zxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDMUqmMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC1FC4CEEB;
	Tue, 22 Jul 2025 09:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753177489;
	bh=jkK1s3YJSis+DpyVXP71DLpX0lBeZncm6EnHG5pheqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dDMUqmMIyI+zfA7lFAj4fjLjZLpq29u511ykG7FGF1iA7tz9gMp2EXAbr8JiQt/Q5
	 AQD1SXvIh24BulBbDYMJin//0rmrTjZOO4QYldVMMf0TSsaYXetKr3EVQcLfu6XRAb
	 aX2SuDXwQT7qZmscA5L+uZvxs70dDWaGk6Lfr5FQsVRb8+rgXTQ+Vyj2JNAlQdgAEX
	 nFclvL/GekqpF0AZmAfeVkTNs/4ByfyrHqYeC45ojxRjMxxHoNGbgcUX6Qar8nWwa3
	 ALkrpyrQIS7c5rf1wivljiQaX5wBt/0+6GAu9Th6iJinapDToeWahJzS9iR0thSihN
	 +2sWVTHvqrNaA==
Message-ID: <a663efc8-dd3c-4880-a477-f0462980e51c@kernel.org>
Date: Tue, 22 Jul 2025 18:42:22 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: directly call do_zone_finish() from
 btrfs_zone_finish_endio_workfn()
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250722093915.13214-1-jth@kernel.org>
 <20250722093915.13214-2-jth@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250722093915.13214-2-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 6:39 PM, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> When btrfs_zone_finish_endio_workfn() is calling btrfs_zone_finish_endio()
> it already has a pointer to the block group. Furthermore
> btrfs_zone_finish_endio() does additional checks if the block group can be
> finished or not.
> 
> But in the context of btrfs_zone_finish_endio_workfn() only the actual
> call to do_zone_finish() is of interest, as the skipping condition when
> there is still room to allocate from the block group cannot be checked.
> 
> Directly call do_zone_finish() on the block group.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 245e813ecd78..5a234f31c8da 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2461,12 +2461,14 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
>  
>  static void btrfs_zone_finish_endio_workfn(struct work_struct *work)
>  {
> +	int ret;
>  	struct btrfs_block_group *bg =
>  		container_of(work, struct btrfs_block_group, zone_finish_work);
>  
>  	wait_on_extent_buffer_writeback(bg->last_eb);
>  	free_extent_buffer(bg->last_eb);
> -	btrfs_zone_finish_endio(bg->fs_info, bg->start, bg->length);
> +	ret = do_zone_finish(bg, true);
> +	ASSERT(!ret);

Why the assert ? Zone finish command may fail if for instance there is a
PHY/link issue. I would rather have something clean here like goig to read-only
rather than this assert == ignoring the error if not in debug mode. No ?

>  	btrfs_put_block_group(bg);
>  }
>  


-- 
Damien Le Moal
Western Digital Research

