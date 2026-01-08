Return-Path: <linux-btrfs+bounces-20222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44046D0104B
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 05:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA5E303F780
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 04:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF902C21D8;
	Thu,  8 Jan 2026 04:51:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A878E2C0F7F
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847892; cv=none; b=nU2WifTzZXZQ35zF8JF2s10cqAjs3E7SZEbssDav57r4YWhIUFyFTz1P3MY3su3D4EW91SW0nTvl2EcmabMjRaW9dxHXIVrovbbg7T3vVdoRnlpDIWK9KVijK9T1mXRUDNG0uZ8mTrSgxmep+mQQ6+gWCfsvbjif1AYz+s/Tza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847892; c=relaxed/simple;
	bh=3HWnOpQ9Evv2wfx6b26kVFpBdhuLeav874ueveOUGLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1aqzisest4EAw/7q2sE5TiHM/wT2xpZabPB3TC37oTtIvhJWGe3RPgFVz5WyiH/N3HsVudrSXjOAvZAtkEeQE5ukZjDJ+33VWWPgIdnjpk/6WPhJSjRxkmPbFFyLbErAu35DUONUZUzE95fvhzUHz/oEL+nEmnpn14zn8uC8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.0.romanrm.net [IPv6:fd39:ade8:5a17:b555:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 57D8740617;
	Thu,  8 Jan 2026 04:51:21 +0000 (UTC)
Date: Thu, 8 Jan 2026 09:51:20 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: use device_discard_blocks() to
 replace prepare_discard_device()
Message-ID: <20260108095120.0d85f706@nvm>
In-Reply-To: <284c38aeccd4abefa2349d2bab1cefb09e89b5bd.1767847334.git.wqu@suse.com>
References: <284c38aeccd4abefa2349d2bab1cefb09e89b5bd.1767847334.git.wqu@suse.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Jan 2026 15:12:17 +1030
Qu Wenruo <wqu@suse.com> wrote:

> -static void prepare_discard_device(const char *filename, int fd, u64 byte_count, unsigned opflags)
> -{
> -	u64 cur = 0;
> -
> -	while (cur < byte_count) {
> -		/* 1G granularity */
> -		u64 chunk_size = (cur == 0) ? SZ_1M : min_t(u64, byte_count - cur, SZ_1G);
> -		int ret;
> -
> -		ret = discard_range(fd, cur, chunk_size);
> -		if (ret)
> -			return;
> -		/*
> -		 * The first range discarded successfully, meaning the device supports
> -		 * discard.
> -		 */
> -		if (opflags & PREP_DEVICE_VERBOSE && cur == 0)
> -			printf("Performing full device TRIM %s (%s) ...\n",
> -			       filename, pretty_size(byte_count));
> -		cur += chunk_size;
> -	}
> -}
> -
>  /*
>   * Write zeros to the given range [start, start + len)
>   */
> @@ -293,8 +270,16 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
>  		goto err;
>  	}
>  
> -	if (!(opflags & PREP_DEVICE_ZONED) && (opflags & PREP_DEVICE_DISCARD))
> -		prepare_discard_device(file, fd, byte_count, opflags);
> +	if (!(opflags & PREP_DEVICE_ZONED) && (opflags & PREP_DEVICE_DISCARD)) {
> +		ret = device_discard_blocks(fd, 0, byte_count);
> +		if (ret < 0) {
> +			errno = -ret;
> +			warning("failed to discard device '%s': %m", file);
> +		} else {
> +			printf("Performing full device TRIM %s (%s) ...\n",
> +			       file, pretty_size(byte_count));
> +		}
> +	}
>  
>  	ret = btrfs_wipe_existing_sb(fd, zinfo);
>  	if (ret < 0) {

Before: the message is printed after the first successful discard of a 1G
range, so with any real-world device at the very beginning of operation.

After: the message is printed only after the full device is discarded???
And it still implies the operation has just begun and is in progress.

It could take a significant time and it was good to print it in the beginning
to let the user know what is going on.

Or I am missing something here?

-- 
With respect,
Roman

