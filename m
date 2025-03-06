Return-Path: <linux-btrfs+bounces-12044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1193A544D8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 09:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A3F162D94
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16EB2066F0;
	Thu,  6 Mar 2025 08:27:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130E20101A
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249656; cv=none; b=CPafj6QvrqNk6cQDplO8xMigC3x9cfqMic19dPHjfr52dYbJsHkl7zpS/xC/9nHgRamRMlPVFNZQ8pCfQuzzL+N9uAyEXc8Pw3RfNqgxu4y//Soig5WadGx2SkEkEhuC9Nn4ri1a0+hL1+3eTMW4uqiTQImCGf3qSS+2hcTWJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249656; c=relaxed/simple;
	bh=VOfRE8iGuDbILe/ZyFXUHmFvEnz+ymy1NpyVE2qVHUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huu4ov/bqeTuJzVSWB4SGK4vqo45Q+Nc+AEgzV7HSkN/n29XAfdfLF5fFFOMpZL4Y5BLR0yWQO+0jti4KMJlkXGd6zCHedWZRJFpkLXWzLyIkVjpFEBzd+VkSdnboCX9DyMp/8blhrweMWzfuIqUXgUUDx/t+MedMpYeyYu9AlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A5641F385;
	Thu,  6 Mar 2025 08:27:32 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3745013676;
	Thu,  6 Mar 2025 08:27:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7z1ADXRcyWfuAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Mar 2025 08:27:32 +0000
Date: Thu, 6 Mar 2025 09:27:30 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/defrag: implement compression levels
Message-ID: <20250306082730.GG5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250304171403.571335-1-neelx@suse.com>
 <20250305103235.719210-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305103235.719210-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5A5641F385
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Wed, Mar 05, 2025 at 11:32:34AM +0100, Daniel Vacek wrote:
> The zstd and zlib compression types support setting compression levels.
> Enhance the defrag interface to specify the levels as well.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
> v2: Fixed the commit message and added an explicit level range check.

Where is the level range check? It silently clamps the range but this is
not a check. What I had in mind was to return -EINVAL if the level is
out of range.

> @@ -1376,10 +1377,21 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>  		return -EINVAL;
>  
>  	if (do_compress) {
> -		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> -			return -EINVAL;
> -		if (range->compress_type)
> -			compress_type = range->compress_type;
> +		if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
> +			if (range->compress.type >= BTRFS_NR_COMPRESS_TYPES)
> +				return -EINVAL;
> +			if (range->compress.type) {
> +				compress_type = range->compress.type;
> +				compress_level= range->compress.level;

Please put spaces around binary operators, so " = ".

> +				compress_level= btrfs_compress_set_level(compress_type,
> +									 compress_level);

This should check if the test is in the range.

My idea was to add helper like this

bool btrfs_compress_level_valid(type, level) {
	... ops = btrfs_compress_op[type];

	if (level < ops->min_type || level > ops->max_type)
		return false;
}

> +			}
> +		} else {
> +			if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> +				return -EINVAL;
> +			if (range->compress_type)
> +				compress_type = range->compress_type;
> +		}
>  	}
>  
>  	if (extent_thresh == 0)
>  	if (ret)
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index d3b222d7af240..3540d33d6f50c 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -615,7 +615,9 @@ struct btrfs_ioctl_clone_range_args {
>   */
>  #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>  #define BTRFS_DEFRAG_RANGE_START_IO 2
> +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
>  #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
> +					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
>  					 BTRFS_DEFRAG_RANGE_START_IO)
>  
>  struct btrfs_ioctl_defrag_range_args {
> @@ -643,7 +645,13 @@ struct btrfs_ioctl_defrag_range_args {
>  	 * for this defrag operation.  If unspecified, zlib will
>  	 * be used
>  	 */
> -	__u32 compress_type;

Please update the comment mentioning that the type + level are used when
the BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL flag is set.

> +	union {
> +		__u32 compress_type;
> +		struct {
> +			__u8 type;
> +			__s8 level;
> +		} compress;
> +	};
>  
>  	/* spare for later */
>  	__u32 unused[4];
> -- 
> 2.47.2
> 

