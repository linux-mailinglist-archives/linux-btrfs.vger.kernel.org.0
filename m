Return-Path: <linux-btrfs+bounces-5420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410378D8A1C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 21:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6531E1C23B63
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 19:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62F1386DF;
	Mon,  3 Jun 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PDdIvyMA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R1ft69Pl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h/LqEMgT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oltoxbDE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB5135A53
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442802; cv=none; b=gvDkOGVaEphI65VKxCEtXj/9/Q94Le6tr+boTxN8eCFdCV1XuOcK10vV3EPrmDEesD8aWDkKQyB+Q/YpPZ2J9wCQdVDVIniX19QOOTo03rUwO/1Q6ReNKHLuaGXf/q+7MQsM4wWlwWIusVXDhBkJ8R3rDnzNV9IH8WDsI9wsHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442802; c=relaxed/simple;
	bh=lMamezvLYBH71rZ4r1hzJtH6C56Iap31edB0NgD6jAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKnfqneh4A6j1/dcg1DXrrWS2d0wl0zksrtno6QwUkJm7qVY8SQSNri/aDqja9TyOHyh/amfOXJ+j4EtPhev93h8fJki2Heeesy+/LbcgbS6Z2qIBGImpXMWKZ4B+cQ/IBbLIe4MLPlbNxbxogsHkg206WflDyHHjsgfsSvV+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PDdIvyMA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R1ft69Pl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h/LqEMgT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oltoxbDE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 465731F396;
	Mon,  3 Jun 2024 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717442798;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJcDBuounbRUgaE7mbvdt0FWN4Juw4dHVbfGjX39gaw=;
	b=PDdIvyMA1+wjG2Vfe4tF7e+BgeM3ar49jkypPFIxZEUSv+4bottJ5vLk3tZl7v2wV/8lb5
	JsWD8mPeDnm+m7pH/ol+9ildncLQCpO9r2Bih/dJ8279SQ9RLdxZwM03lY1YbHtP/UWx9J
	YmPrWV3MvCMJ+Y4q5Tx7BCaiG6uGkao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717442798;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJcDBuounbRUgaE7mbvdt0FWN4Juw4dHVbfGjX39gaw=;
	b=R1ft69PlZzxnwc3aRXzU6h6b5cK9TotpgKNj8xkrxN14sikzreo98Xbu1GbmV7YBXwVIWl
	/goAcVjzzbUFuQAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717442797;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJcDBuounbRUgaE7mbvdt0FWN4Juw4dHVbfGjX39gaw=;
	b=h/LqEMgTCYyMLcD/EgGVLbK2p4yYADbSafxznBoAsGGcA38RXa/QB3URhDqp9/2025ofbj
	4xWgUIkLanXDztsXZDJ6pYtFa3C1vA7GDbx9Xlw3fn8Aa4hTNHRdPDdEoov7mjq4Wl9uwS
	BVxTwcrOfaJhtdjksVRyo1eu16cbZwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717442797;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJcDBuounbRUgaE7mbvdt0FWN4Juw4dHVbfGjX39gaw=;
	b=oltoxbDE4SNTVRYzI/woJcF3wDne9NOmfM2PC3AVcNsDXyd3zWg4UfgQNRDoK2NY48b7a9
	qBCjCcuGmZ8o3vAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24A3313A93;
	Mon,  3 Jun 2024 19:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 55G8CO0YXmYFQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Jun 2024 19:26:37 +0000
Date: Mon, 3 Jun 2024 21:26:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v4 06/10] btrfs-progs: support byte length for zone
 resetting
Message-ID: <20240603192635.GA12376@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240529071325.940910-1-naohiro.aota@wdc.com>
 <20240529071325.940910-7-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529071325.940910-7-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email,wdc.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]

On Wed, May 29, 2024 at 04:13:21PM +0900, Naohiro Aota wrote:
> Even with "mkfs.btrfs -b", mkfs.btrfs resets all the zones on the device.
> Limit the reset target within the specified length.
> 
> Also, we need to check that there is no active zone outside of the FS
> range. Having an active zone outside FS reduces the number of zones btrfs
> can write simultaneously. Technically, we can still scan all the device
> zones and keep active zones outside FS intact and try to live with the
> limited active zones. But, that will make btrfs operations harder.
> 
> It is generally bad idea to use "-b" on a non-test usage on a device with
> active zone limit in the first place. You really need to take care that FS
> and outside the FS goes over the limit. That means you'll never be able to
> use zones outside the FS anyway.
> 
> So, until there is a strong request for that, I don't think it's worthwhile
> to do so.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/device-utils.c | 17 ++++++++++++-----
>  kernel-shared/zoned.c | 23 ++++++++++++++++++++++-
>  kernel-shared/zoned.h |  7 ++++---
>  3 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 86942e0c7041..7df7d9ce39d8 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -254,16 +254,23 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
>  
>  		if (!zinfo->emulated) {
>  			if (opflags & PREP_DEVICE_VERBOSE)
> -				printf("Resetting device zones %s (%u zones) ...\n",
> -				       file, zinfo->nr_zones);
> +				printf("Resetting device zones %s (%llu zones) ...\n",
> +				       file, byte_count / zinfo->zone_size);
>  			/*
>  			 * We cannot ignore zone reset errors for a zoned block
>  			 * device as this could result in the inability to write
>  			 * to non-empty sequential zones of the device.
>  			 */
> -			if (btrfs_reset_all_zones(fd, zinfo)) {
> -				error("zoned: failed to reset device '%s' zones: %m",
> -				      file);
> +			ret = btrfs_reset_zones(fd, zinfo, byte_count);
> +			if (ret) {
> +				if (ret == EBUSY) {
> +					error("zoned: device '%s' contains an active zone outside of the FS range",
> +					      file);
> +					error("zoned: btrfs needs full control of active zones");
> +				} else {
> +					error("zoned: failed to reset device '%s' zones: %m",
> +					      file);
> +				}
>  				goto err;
>  			}
>  		}
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> index fb1e1388804e..b4244966ca36 100644
> --- a/kernel-shared/zoned.c
> +++ b/kernel-shared/zoned.c
> @@ -395,16 +395,24 @@ static int report_zones(int fd, const char *file,
>   * Discard blocks in the zones of a zoned block device. Process this with zone
>   * size granularity so that blocks in conventional zones are discarded using
>   * discard_range and blocks in sequential zones are reset though a zone reset.
> + *
> + * We need to ensure that zones outside of the FS is not active, so that
> + * the FS can use all the active zones. Return EBUSY if there is an active
> + * zone.
>   */
> -int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo)
> +int btrfs_reset_zones(int fd, struct btrfs_zoned_device_info *zinfo, u64 byte_count)
>  {
>  	unsigned int i;
>  	int ret = 0;
>  
>  	ASSERT(zinfo);
> +	ASSERT(IS_ALIGNED(byte_count, zinfo->zone_size));
>  
>  	/* Zone size granularity */
>  	for (i = 0; i < zinfo->nr_zones; i++) {
> +		if (byte_count == 0)
> +			break;
> +
>  		if (zinfo->zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL) {
>  			ret = device_discard_blocks(fd,
>  					     zinfo->zones[i].start << SECTOR_SHIFT,
> @@ -419,7 +427,20 @@ int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo)
>  
>  		if (ret)
>  			return ret;
> +
> +		byte_count -= zinfo->zone_size;
>  	}
> +	for (; i < zinfo->nr_zones; i++) {
> +		const enum blk_zone_cond cond = zinfo->zones[i].cond;
> +
> +		if (zinfo->zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL)
> +			continue;
> +		if (cond == BLK_ZONE_COND_IMP_OPEN ||
> +		    cond == BLK_ZONE_COND_EXP_OPEN ||
> +		    cond == BLK_ZONE_COND_CLOSED)
> +			return EBUSY;

Should this return -EBUSY? It should not matter for this case but by
convention it would be better to use only negative errnos. I found
another one that's in the same call chain that still returns plain
errno, discard_range(). This should be fixed, possibly separately, so
I'll keep your patch as is.

