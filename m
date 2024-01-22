Return-Path: <linux-btrfs+bounces-1621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBEF837577
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 22:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4771C22F98
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28F248790;
	Mon, 22 Jan 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ejiCP1VO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="18DIKOhg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ejiCP1VO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="18DIKOhg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59022481A5;
	Mon, 22 Jan 2024 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959297; cv=none; b=MH0RdirYxEh36kArg5i/0I8oos/5adPeVmmkcnMN2ApZBBopI57E5JFTjG3QzDswq3y2WAGWT6NnyJ4oP9y9QlOmVMP93OIWcr0WUdjsEjUmdYRP33HZYl1AY5elCYh7jfm70K+KubLVKMT7evvMdW6HiyZP7WfgtQlfQcg1mBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959297; c=relaxed/simple;
	bh=AvisTLD9wXTFCZ0+eSEooOBpcWR8LOo3Vu/9ugqVbRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5ziffTSsHSLhzXyeg7SrkIS2nYgbCz6t+O+cYZlAUnfoGwvXssIjDfZETOGNpitwycqRYb2r1E5Jhu6nG7+eoTXYVsEQbMfi8b4iMszeHYpehNWPsEPQ6/YPWRDg9pM1ZFdEwXclrpHjbhhkVZikDwkO057VFF/mDFTg3aj5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ejiCP1VO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=18DIKOhg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ejiCP1VO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=18DIKOhg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 805C61F391;
	Mon, 22 Jan 2024 21:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705959293;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4V8EMIiewNXIpjskcZ/asr7GAbLav864HbAcqkeBWDA=;
	b=ejiCP1VOck0JH8EV2FpNiyMOC0Qng47tmgubMjJO5KFYw/gNGS2/o9RDPjxmGKqOUVrqEx
	jiFhtg+YFtv/QbvEF6HpGbuGYkW4okwPY16UHUQduT6cJCUY6aCNSK6Gm67Uf7cmXNkpx6
	4gwHnEzFGWVZtL2dMxTab5zlWsdgNmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705959293;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4V8EMIiewNXIpjskcZ/asr7GAbLav864HbAcqkeBWDA=;
	b=18DIKOhgNI2S3WVE6dmQYHsp2Uh7JitA1mvuovx+xmV7i6lz1+xlUOsxmEh8G94kSOO6rW
	w34cBlddncKAjqDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705959293;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4V8EMIiewNXIpjskcZ/asr7GAbLav864HbAcqkeBWDA=;
	b=ejiCP1VOck0JH8EV2FpNiyMOC0Qng47tmgubMjJO5KFYw/gNGS2/o9RDPjxmGKqOUVrqEx
	jiFhtg+YFtv/QbvEF6HpGbuGYkW4okwPY16UHUQduT6cJCUY6aCNSK6Gm67Uf7cmXNkpx6
	4gwHnEzFGWVZtL2dMxTab5zlWsdgNmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705959293;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4V8EMIiewNXIpjskcZ/asr7GAbLav864HbAcqkeBWDA=;
	b=18DIKOhgNI2S3WVE6dmQYHsp2Uh7JitA1mvuovx+xmV7i6lz1+xlUOsxmEh8G94kSOO6rW
	w34cBlddncKAjqDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DD0F13310;
	Mon, 22 Jan 2024 21:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lHdkFn3frmUSAgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 21:34:53 +0000
Date: Mon, 22 Jan 2024 22:34:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] btrfs: zoned: use rcu list for iterating devices to
 collect stats
Message-ID: <20240122213428.GE31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
 <20240122-reclaim-fix-v1-1-761234a6d005@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-reclaim-fix-v1-1-761234a6d005@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.26 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.46)[79.03%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.26

On Mon, Jan 22, 2024 at 02:51:03AM -0800, Johannes Thumshirn wrote:
> As btrfs_zoned_should_reclaim only has to iterate the device list in order
> to collect stats on the device's total and used bytes, we don't need to
> take the full blown mutex, but can iterate the device list in a rcu_read
> context.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 168af9d000d1..b7e7b5a5a6fa 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2423,15 +2423,15 @@ bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
>  	if (fs_info->bg_reclaim_threshold == 0)
>  		return false;
>  
> -	mutex_lock(&fs_devices->device_list_mutex);
> -	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
>  		if (!device->bdev)
>  			continue;
>  
>  		total += device->disk_total_bytes;
>  		used += device->bytes_used;
>  	}
> -	mutex_unlock(&fs_devices->device_list_mutex);
> +	rcu_read_unlock();

This is basically only a hint and inaccuracies in the total or used
values would be transient, right? The sum is calculated each time the
funciton is called, not stored anywhere so in the unlikely case of
device removal it may skip reclaim once, but then pick it up later.
Any actual removal of the block groups in verified again and properly
locked in btrfs_reclaim_bgs_work().

