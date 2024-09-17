Return-Path: <linux-btrfs+bounces-8084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5854B97B2F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 18:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642281C2156C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5273A17AE01;
	Tue, 17 Sep 2024 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJK5mHGT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yjT2IGaQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJK5mHGT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yjT2IGaQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94B13D8A2;
	Tue, 17 Sep 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590276; cv=none; b=h2JmKoto+WvRI/PuuNx5W381mYZMvN3Wz+PB4OxVyiLBxBxwIS+dzCZCZFLA3OU8B1tOClOUlbxAedxeGKcqjiZywhOHtabn49yCsphmjDsgxJd8B5h9+VSMpfilFccFY+v6iexy0GwRwfNavj8tkAhhw1cap9T2HLDu8puMFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590276; c=relaxed/simple;
	bh=p0mabAtvdQgldA0klAPpKWE4J1yQmj/bSrPfUjfveiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9qXstc5glxSbBY+2wIWvns/9J0L0XegPITSCENT3fypkRsEAlioVVwWJ1UuIesLZOBQVoFavxgRekSamdqV7Zzdq7OQ/k9v0QEamni7MN5nzYErbesnm1JyXk98PBOWHVYvXeDR/To8WwqBBXyPOy5D2mvvvtWykDqyg74FZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gJK5mHGT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yjT2IGaQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gJK5mHGT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yjT2IGaQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71BC4222E9;
	Tue, 17 Sep 2024 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726590272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nEGp6JEUTHka4vKdkzaO/HQR4XC425zgJ2xZrNZctiA=;
	b=gJK5mHGTIvWkXdKU7fMK2TQIXJNmj+hqVTbZnb9MMQku0OjS0DtdEiqTAarlzvJ55+LesL
	PoF/XdAdvU+rucms5sGmw7PipwJKp0Hz5/0OWMXxsQ5VwmxcG3iF34a4sC8WugHRLmXnko
	xryujmy7NPamJzhVfB3hQDNfGTZvYQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726590272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nEGp6JEUTHka4vKdkzaO/HQR4XC425zgJ2xZrNZctiA=;
	b=yjT2IGaQ/cm6K9A9US7N4TV5skZbWwtqvZSsUVAYe1LYxesA8anpsfIrIcxU6AaIps+F+P
	xPSs91uGMDv38tBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gJK5mHGT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yjT2IGaQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726590272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nEGp6JEUTHka4vKdkzaO/HQR4XC425zgJ2xZrNZctiA=;
	b=gJK5mHGTIvWkXdKU7fMK2TQIXJNmj+hqVTbZnb9MMQku0OjS0DtdEiqTAarlzvJ55+LesL
	PoF/XdAdvU+rucms5sGmw7PipwJKp0Hz5/0OWMXxsQ5VwmxcG3iF34a4sC8WugHRLmXnko
	xryujmy7NPamJzhVfB3hQDNfGTZvYQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726590272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nEGp6JEUTHka4vKdkzaO/HQR4XC425zgJ2xZrNZctiA=;
	b=yjT2IGaQ/cm6K9A9US7N4TV5skZbWwtqvZSsUVAYe1LYxesA8anpsfIrIcxU6AaIps+F+P
	xPSs91uGMDv38tBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D3CD13AB6;
	Tue, 17 Sep 2024 16:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id humcEkCt6WZPZQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Sep 2024 16:24:32 +0000
Date: Tue, 17 Sep 2024 18:24:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] btrfs: Don't block system suspend during fstrim
Message-ID: <20240917162431.GC2920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240916125707.127118-1-luca.stefani.ge1@gmail.com>
 <20240916125707.127118-3-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916125707.127118-3-luca.stefani.ge1@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 71BC4222E9
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Mon, Sep 16, 2024 at 02:56:15PM +0200, Luca Stefani wrote:
> Sometimes the system isn't able to suspend because the task
> responsible for trimming the device isn't able to finish in
> time, especially since we have a free extent discarding phase,
> which can trim a lot of unallocated space, and there is no
> limits on the trim size (unlike the block group part).
> 
> Since discard isn't a critical call it can be interrupted
> at any time, in such cases we stop the trim, report the amount
> of discarded bytes and return failure.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>

I went through the cancellation points, some of them don't seem to be
necessary, eg. in a big loop when some function is called to do trim
(extents, bitmaps) and then again does the signal and freezing check.

Next, some of the functions are called from async discard and errors are
not checked: btrfs_trim_block_group_bitmaps() called from
btrfs_discard_workfn().

Ther's also check for signals pending in trim_bitmaps() in
free-space-cache.c. Given that the space cache code is on the way out we
don't necesssarily need to fix it but if the patch gets backported to
older kernels it still makes sense.

> ---
>  fs/btrfs/extent-tree.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 79b9243c9cd6..cef368a30731 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -16,6 +16,7 @@
>  #include <linux/percpu_counter.h>
>  #include <linux/lockdep.h>
>  #include <linux/crc32c.h>
> +#include <linux/freezer.h>
>  #include "ctree.h"
>  #include "extent-tree.h"
>  #include "transaction.h"
> @@ -1235,6 +1236,11 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static bool btrfs_trim_interrupted(void)
> +{
> +	return fatal_signal_pending(current) || freezing(current);
> +}
> +
>  static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>  			       u64 *discarded_bytes)
>  {
> @@ -1316,6 +1322,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>  		start += bytes_to_discard;
>  		bytes_left -= bytes_to_discard;
>  		*discarded_bytes += bytes_to_discard;
> +
> +		if (btrfs_trim_interrupted()) {
> +			ret = -ERESTARTSYS;
> +			break;
> +		}
>  	}
>  
>  	return ret;
> @@ -6470,7 +6481,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
>  		start += len;
>  		*trimmed += bytes;
>  
> -		if (fatal_signal_pending(current)) {
> +		if (btrfs_trim_interrupted()) {
>  			ret = -ERESTARTSYS;
>  			break;
>  		}
> @@ -6519,6 +6530,11 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>  
>  	cache = btrfs_lookup_first_block_group(fs_info, range->start);
>  	for (; cache; cache = btrfs_next_block_group(cache)) {
> +		if (btrfs_trim_interrupted()) {
> +			bg_ret = -ERESTARTSYS;
> +			break;
> +		}
> +
>  		if (cache->start >= range_end) {
>  			btrfs_put_block_group(cache);
>  			break;
> @@ -6558,6 +6574,11 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>  
>  	mutex_lock(&fs_devices->device_list_mutex);
>  	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (btrfs_trim_interrupted()) {
> +			dev_ret = -ERESTARTSYS;

This one seems redundant.

> +			break;
> +		}
> +
>  		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>  			continue;
>  
> -- 
> 2.46.0
> 

