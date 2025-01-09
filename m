Return-Path: <linux-btrfs+bounces-10835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A74A07364
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C0D3A4B5F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6A215F4E;
	Thu,  9 Jan 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y9v63FRf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hcZMUzQy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y9v63FRf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hcZMUzQy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7EB204C0D;
	Thu,  9 Jan 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419032; cv=none; b=hFWTbfcpRA9bAggaQKPJu+63JJozV6lt9DVTyhrIPxlPtRJtY15+YxHksO416UVPZygNsG7wvwNyiytNWM//Cek1htUETEPa5ZtypsU3sEgz9HE4Cu8JJk5kA6McQZEnSNfBYCSh8lvbY2zFcWgrUbhBjQfDnE+rol0IaOhE1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419032; c=relaxed/simple;
	bh=43VpVqRuTlFk3VjXYsIpasyg4JdtYwsZ4h1WDhq2Qh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBav/YD5SfuprsyV9BAxnZogY149+sfjy/xx2aHAD22zLWG3kx5ZH14iBE122qT9Ysi113DCESLfn0iMX7uRYK1EHp+I2cQnNjbY/wTtiMsFXLjxpaScjTvFzhDCF4Y7Sy4/dvD2/Lm7VUlNVRP5rnSwavU+CLhNuxHJWLbcvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y9v63FRf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hcZMUzQy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y9v63FRf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hcZMUzQy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6723C1F385;
	Thu,  9 Jan 2025 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736419027;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xroa/QStKsSWZZ0RZ7h7LzahwZQ384g5wi3Zozlhx2U=;
	b=Y9v63FRfQOd0xYBpbtlHWWQHXs40KljO804i17zYu05u3v3vigYgOvmogN8HvX9YON7Qhm
	949Y71vyTioHSjPzd06ziZZxQGkAZJmSc+dsXew2WWKlYC6Ly3hnDDgrNYRsc1XB7RunHL
	wAUQi96nsyC9r30eJnF+qbZy5B3avkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736419027;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xroa/QStKsSWZZ0RZ7h7LzahwZQ384g5wi3Zozlhx2U=;
	b=hcZMUzQyXF97QRGvXf6AJyh+z0OWCuUTW486PCpYVSNHM6og2tKAN4Y+z990eLdAafWwfX
	1qTrQfZoPvhssFDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y9v63FRf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hcZMUzQy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736419027;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xroa/QStKsSWZZ0RZ7h7LzahwZQ384g5wi3Zozlhx2U=;
	b=Y9v63FRfQOd0xYBpbtlHWWQHXs40KljO804i17zYu05u3v3vigYgOvmogN8HvX9YON7Qhm
	949Y71vyTioHSjPzd06ziZZxQGkAZJmSc+dsXew2WWKlYC6Ly3hnDDgrNYRsc1XB7RunHL
	wAUQi96nsyC9r30eJnF+qbZy5B3avkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736419027;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xroa/QStKsSWZZ0RZ7h7LzahwZQ384g5wi3Zozlhx2U=;
	b=hcZMUzQyXF97QRGvXf6AJyh+z0OWCuUTW486PCpYVSNHM6og2tKAN4Y+z990eLdAafWwfX
	1qTrQfZoPvhssFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 405DC139AB;
	Thu,  9 Jan 2025 10:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QMp8D9Omf2dvFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 Jan 2025 10:37:07 +0000
Date: Thu, 9 Jan 2025 11:37:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 01/14] btrfs: don't try to delete RAID stripe-extents
 if we don't need to
Message-ID: <20250109103702.GC2097@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-1-0c7b14c0aac2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-rst-delete-fixes-v2-1-0c7b14c0aac2@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6723C1F385
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Jan 07, 2025 at 01:47:31PM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Don't try to delete RAID stripe-extents if we don't need to.

Please add why it's not needed.

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c             | 15 ++++++++++++++-
>  fs/btrfs/tests/raid-stripe-tree-tests.c |  3 ++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 45b823a0913aea5fdaab91a80e79d253a66bb700..757e9c681f6c49f2d0295c1b3b2de56aad3c94a6 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -59,9 +59,22 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
>  	int slot;
>  	int ret;
>  
> -	if (!stripe_root)
> +	if (!btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE) || !stripe_root)
>  		return 0;
>  
> +	if (!btrfs_is_testing(fs_info)) {
> +		struct btrfs_chunk_map *map;
> +		bool use_rst;
> +
> +		map = btrfs_find_chunk_map(fs_info, start, length);
> +		if (!map)
> +			return -EINVAL;
> +		use_rst = btrfs_need_stripe_tree_update(fs_info, map->type);
> +		btrfs_free_chunk_map(map);
> +		if (!use_rst)
> +			return 0;
> +	}
> +
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
> index 30f17eb7b6a8a1dfa9f66ed5508da42a70db1fa3..f060c04c7f76357e6d2c6ba78a8ba981e35645bd 100644
> --- a/fs/btrfs/tests/raid-stripe-tree-tests.c
> +++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
> @@ -478,8 +478,9 @@ static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
>  		ret = PTR_ERR(root);
>  		goto out;
>  	}
> -	btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
> +	btrfs_set_super_incompat_flags(root->fs_info->super_copy,
>  					BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE);
> +	btrfs_set_fs_incompat(root->fs_info, RAID_STRIPE_TREE);
>  	root->root_key.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
>  	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
>  	root->root_key.offset = 0;
> 
> -- 
> 2.43.0
> 

