Return-Path: <linux-btrfs+bounces-10260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF7D9ED4D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 19:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54705169167
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E6202F67;
	Wed, 11 Dec 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vxE7Rgh/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Ds9B1qn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MwO0vQRt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uzlj8gXd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E71D958E
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942769; cv=none; b=U8ebeqsi0+Nv1OLGQ2dOxAxT3gOq479nlvSCn05C1RpSmSg8UT5o3MkhbKA3aM1XDBJvFOFg9V7gMYqEdgrqP8I8xwUd9Sl52VOM5t0cXwoKy5+9BOUgG1ajmWElTz73rWwkN9qdFpPSB8q9riVjrgfxAHyXpGVKeoip7Ux4s+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942769; c=relaxed/simple;
	bh=CjXqRuvz2f64taqrScjCMXE2mOumr/ZOQi+WEx1NMSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI2JbUuXOLiYipHuxpNWaYe2XoYriNz5mHlZ9ySz45SoQqkwHsyaXDBvjgVa9MZd6HXauGf9NOxzXQioqsgsQOG5AccyU4wR+eAMDMX2A9khZR1TURwfZ48ZbMi59KwVtSp9CWiFAvUQ9UxhCQXlVKw4uSJVBfWjVXAEgtngLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vxE7Rgh/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Ds9B1qn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MwO0vQRt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uzlj8gXd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 261301F38C;
	Wed, 11 Dec 2024 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733942765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1LzV5dKcZBqtjKGtk6HDps7PV6m7nGQihYZsfJQvKw=;
	b=vxE7Rgh/QRIlfP7YRJaDsvDtzUBCZgUE3AsVTi/aN+cnAhB6NP8voJI7MsInZJQPhdx8OH
	hWV1/1qb4BEsYo6sKTDzJn+kXUiNk9ukl66Jf+BCMwn7VWtgpK6EhS7svpMca4LUXe9SlT
	XZ90qfjm6RkJ4iOqXX3AjX+krgD/wLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733942765;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1LzV5dKcZBqtjKGtk6HDps7PV6m7nGQihYZsfJQvKw=;
	b=/Ds9B1qncWji7yVpdv/GJwBzZHrO7L80/DXFBgZoJSqsTMB9zm7cs6izwPCIAgYQuH9Zxj
	NY2tAn6FcKLt93Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MwO0vQRt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uzlj8gXd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733942764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1LzV5dKcZBqtjKGtk6HDps7PV6m7nGQihYZsfJQvKw=;
	b=MwO0vQRtcq2WF8C7LYDfU1cyvRf5OWI/9AJvaTOnzvI8bYprtQkTQvHgZZWdXm86qEEvHH
	Rf935WSyuXR2WoMq+wQda1nn74A05jaMtPXHoWpZVsksG1xZg5OSPEx12wjWL/BIaorE5u
	FZRpFlVS7oWRNAM+fabwIvebnghb+jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733942764;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1LzV5dKcZBqtjKGtk6HDps7PV6m7nGQihYZsfJQvKw=;
	b=uzlj8gXd5HD1Ff8+PufJYufIv0SdiNG6Lk/iMEZYTZNyiV8ufLYtyAUylaPALnfWLrFNmT
	R0e9dohdHV8oMHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0726613927;
	Wed, 11 Dec 2024 18:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fOqFAezdWWdwAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 11 Dec 2024 18:46:04 +0000
Date: Wed, 11 Dec 2024 19:45:58 +0100
From: David Sterba <dsterba@suse.cz>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 2/6] btrfs: edit btrfs_add_block_group_cache() to use rb
 helper
Message-ID: <20241211184558.GS31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1733850317.git.beckerlee3@gmail.com>
 <2c3972c084ab074fd1b6a2e03ada8c20dde6d060.1733850317.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3972c084ab074fd1b6a2e03ada8c20dde6d060.1733850317.git.beckerlee3@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 261301F38C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Dec 10, 2024 at 01:06:08PM -0600, Roger L. Beckermeyer III wrote:
> Edits fs/btrfs/block-group.c to use rb_find_add_cached(),

Please don't use 'edit' for changelogs, 'update to use' or 'use'
describes it better.

> also adds a comparison function, btrfs_add_block_blkgrp_cmp(),
> for use with rb_find_add_cached().
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> ---
>  fs/btrfs/block-group.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5be029734cfa..ccff051de43a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -173,40 +173,34 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
>  	}
>  }
>  
> +static int btrfs_add_blkgrp_cmp(struct rb_node *new, const struct rb_node *exist)

This is a comparator so 'add' is confusing here, so 'btrfs_bg_start_cmp'
for exmample.

> +{
> +	struct btrfs_block_group *cmp1 = rb_entry(new, struct btrfs_block_group, cache_node);
> +	struct btrfs_block_group *cmp2 = rb_entry(exist, struct btrfs_block_group, cache_node);

The types don't match, 'exist' is const.

> +
> +	if (cmp1->start < cmp2->start)
> +		return -1;
> +	if (cmp1->start > cmp2->start)
> +		return 1;
> +	return 0;
> +}

