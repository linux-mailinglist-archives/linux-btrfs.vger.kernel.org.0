Return-Path: <linux-btrfs+bounces-13220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44894A96741
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 13:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C4A3B8DEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 11:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C168827BF8E;
	Tue, 22 Apr 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m1HaMxpa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="95YmAc/S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m1HaMxpa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="95YmAc/S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE452777E5
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321066; cv=none; b=LxkBSvbqSc8u5ooe8LS+YnwEoXF5cyu3P/nQ/kZub6Y9a3I1VicyeLxhGn/MqIlX34EBseaKmqtI7tS2A/tweNgmodtNfAehJVqMJY08yH/zTc2jejOMYV8Qs/A63LnAiD2aBcFeNVR2uH28u4+xUL9bGKCixfLNKtwrFc/ixCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321066; c=relaxed/simple;
	bh=pA/B4ZnrPUmnsbOKsAWHS0EypfAvsJS0RATGobZrhuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxrign57FXYWaxqxJ/mgx8R+2OJ7nxGQU6zTfPx/t3n1dbeleyFhH5l/sx1dEfHeh0QSdkyYrKGaxWiyphQrPMQlNfOWsCiy8r6VQSlvm1mSDXk6ZGXXqlxdryS7RNpWNGRvRuywFvp9awmt77loj3mr+6QXd6vJquKMe1gvRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m1HaMxpa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=95YmAc/S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m1HaMxpa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=95YmAc/S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7891821192;
	Tue, 22 Apr 2025 11:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745321062;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYDdhs3taVFyAILO9qQlPWX+HJ9PZfnMXsFNTPjFSd8=;
	b=m1HaMxpaq3m1ULVdgoWuQs2c5lp7yesc9wz8gcIDvxgbPmLzox8af/y5IH5pJpH2e3Cmdh
	8qEramdgttdujsFYwy1/Rra/9dyh+dGwUh1hoXiFSzRdl34gprDS/JqP//LcxhN6/cJkCM
	F2lbRR2ZND+pSpbu1SvBE47gzFpNJ+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745321062;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYDdhs3taVFyAILO9qQlPWX+HJ9PZfnMXsFNTPjFSd8=;
	b=95YmAc/ScmRSmM+9D1m3ruRV0mAd7YT1f0HLv8RhHYdqgGwBCJI6+ZJD70wtz5wvGf+3Zp
	v53IMKXznuTQ9wCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m1HaMxpa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="95YmAc/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745321062;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYDdhs3taVFyAILO9qQlPWX+HJ9PZfnMXsFNTPjFSd8=;
	b=m1HaMxpaq3m1ULVdgoWuQs2c5lp7yesc9wz8gcIDvxgbPmLzox8af/y5IH5pJpH2e3Cmdh
	8qEramdgttdujsFYwy1/Rra/9dyh+dGwUh1hoXiFSzRdl34gprDS/JqP//LcxhN6/cJkCM
	F2lbRR2ZND+pSpbu1SvBE47gzFpNJ+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745321062;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYDdhs3taVFyAILO9qQlPWX+HJ9PZfnMXsFNTPjFSd8=;
	b=95YmAc/ScmRSmM+9D1m3ruRV0mAd7YT1f0HLv8RhHYdqgGwBCJI6+ZJD70wtz5wvGf+3Zp
	v53IMKXznuTQ9wCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C7D6139D5;
	Tue, 22 Apr 2025 11:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ub7yEWZ8B2jgCgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 22 Apr 2025 11:24:22 +0000
Date: Tue, 22 Apr 2025 13:24:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] btrfs: update __btrfs_lookup_delayed_item to to
 use rb helper
Message-ID: <20250422112413.GB3659@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250422081504.1998809-1-frank.li@vivo.com>
 <20250422081504.1998809-2-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422081504.1998809-2-frank.li@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 7891821192
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:replyto,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Apr 22, 2025 at 02:14:53AM -0600, Yangtao Li wrote:
> Update __btrfs_lookup_delayed_item() to use rb_find().
> 
> Suggested-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/btrfs/delayed-inode.c | 39 ++++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 3f1551d8a5c6..dbc1bc1cdf20 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -336,6 +336,20 @@ static struct btrfs_delayed_item *btrfs_alloc_delayed_item(u16 data_len,
>  	return item;
>  }
>  
> +static int btrfs_delayed_item_key_cmp(const void *k, const struct rb_node *node)

Please don't use single letter variables, here you can use 'key'

The function name should be something like 'delayed_item_index_cmp' so
it's clear what object and what its member it compares. This applies to
other patches too.

> +{
> +	const u64 *index = k;
> +	const struct btrfs_delayed_item *delayed_item =
> +		rb_entry(node, struct btrfs_delayed_item, rb_node);
> +
> +	if (delayed_item->index < *index)
> +		return 1;
> +	else if (delayed_item->index > *index)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  /*
>   * Look up the delayed item by key.
>   *

