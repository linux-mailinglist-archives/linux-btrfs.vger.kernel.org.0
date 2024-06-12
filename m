Return-Path: <linux-btrfs+bounces-5673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD5905C4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 21:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB3B28322C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425DD83CD5;
	Wed, 12 Jun 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l4bWXWYD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZRZMYPIM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l4bWXWYD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZRZMYPIM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604BF381C4
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221895; cv=none; b=K5GbfFp9PqKhCt+FzrJJez+pfAXXMuRdDh1Erqm2rsS5uD708J8QHKSIEt3MXtu74MsYUJxCloUoZNShup6H4pNdVk8NRtWJ8SSFrIQNu+bYvidiEK3We/qdinZwo8whkPpMyeFJvzEUnzs6KiLa3C5PSx1bLEAgO6JFueI+wXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221895; c=relaxed/simple;
	bh=LpeZXDluWJWmrZYy58VUxluNSFubHcGPyYkG6fQq31I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6cgQjxa8lN7Jx9VUXid6hB2/6sfLyvh7LOPybcSixcWyK35HmkxGM8YXhn1+EcDl4WKLkT4MiPPmWwibn6tbhbXuBPZ0V0bIIUAcdemQqBHi2eh7TyQUYdPrL8esAmDUpv/YKyvZXHl1/2pC+CMuUINCUUZU/i84K7I3AJTKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l4bWXWYD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZRZMYPIM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l4bWXWYD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZRZMYPIM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2371B3484F;
	Wed, 12 Jun 2024 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718221891;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVrCNHbTgjq3AmFe0NKBKW0LDTDeQczMq0rI3+9kWTA=;
	b=l4bWXWYDc4koD/QYS3NC4gi+lORlvGDh+4vOLmv8lGeteQXrzAB26DArNQWvmMq9g9X1xE
	aOeHzuxxKjrAYMBFelyqxKDD9+C3DrRi1nZe38Oxmxqhizs2HofPdWqtCWbNaKNzpxcmYL
	y2E1wcarukMjxpRRqxvnr9/OsLtiUmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718221891;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVrCNHbTgjq3AmFe0NKBKW0LDTDeQczMq0rI3+9kWTA=;
	b=ZRZMYPIMv/aXjvI+PpopBFDMYUYytta5bkM1zkvZo6d3xZeCJJt2SpcO0YbuPUS/XgqBYW
	mR+f5xIpjpFR9VAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=l4bWXWYD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZRZMYPIM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718221891;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVrCNHbTgjq3AmFe0NKBKW0LDTDeQczMq0rI3+9kWTA=;
	b=l4bWXWYDc4koD/QYS3NC4gi+lORlvGDh+4vOLmv8lGeteQXrzAB26DArNQWvmMq9g9X1xE
	aOeHzuxxKjrAYMBFelyqxKDD9+C3DrRi1nZe38Oxmxqhizs2HofPdWqtCWbNaKNzpxcmYL
	y2E1wcarukMjxpRRqxvnr9/OsLtiUmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718221891;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVrCNHbTgjq3AmFe0NKBKW0LDTDeQczMq0rI3+9kWTA=;
	b=ZRZMYPIMv/aXjvI+PpopBFDMYUYytta5bkM1zkvZo6d3xZeCJJt2SpcO0YbuPUS/XgqBYW
	mR+f5xIpjpFR9VAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 131E51372E;
	Wed, 12 Jun 2024 19:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3w9HBEP8aWZ9IgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Jun 2024 19:51:31 +0000
Date: Wed, 12 Jun 2024 21:51:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix initial free space detection
Message-ID: <20240612195129.GN18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ec2aafb75c235d9c37aef52068992dca0d060d5f.1718096605.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2aafb75c235d9c37aef52068992dca0d060d5f.1718096605.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2371B3484F
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jun 11, 2024 at 06:05:52PM +0900, Naohiro Aota wrote:
> When creating a new block group, it calls btrfs_fadd_new_free_space() to
> add the entire block group range into the free space
> accounting. __btrfs_add_free_space_zoned() checks if size ==
> block_group->length to detect the initial free space adding, and proceed
> that case properly.
> 
> However, if the zone_capacity == zone_size and the over-write speed is fast
> enough, the entire zone can be over-written within one transaction. That
> confuses __btrfs_add_free_space_zoned() to handle it as an initial free
> space accounting. As a result, that block group becomes a strange state: 0
> used bytes, 0 zone_unusable bytes, but alloc_offset == zone_capacity (no
> allocation anymore).
> 
> The initial free space accounting can properly be checked by checking
> alloc_offset too.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Fixes: 98173255bddd ("btrfs: zoned: calculate free space from zone capacity")
> CC: stable@vger.kernel.org # 6.1+
> ---
>  fs/btrfs/free-space-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index fcfc1b62e762..72e60764d1ea 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2697,7 +2697,7 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
>  	u64 offset = bytenr - block_group->start;
>  	u64 to_free, to_unusable;
>  	int bg_reclaim_threshold = 0;
> -	bool initial = (size == block_group->length);
> +	bool initial = (size == block_group->length) && block_group->alloc_offset == 0;

I'm not recommending to use compound conditions in the initializer block
as it can hide some important detail, but in this case it's both related
to the block group and still related to the variable name. Please put
the pair of ( ) to the whole expression.

Reviewed-by: David Sterba <dsterba@suse.com>

