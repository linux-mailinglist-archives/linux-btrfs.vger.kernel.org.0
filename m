Return-Path: <linux-btrfs+bounces-6989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20B947F57
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 18:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19481F22A45
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4915C15D;
	Mon,  5 Aug 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BVZsLTI1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GDIJt8aK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0YKHBAGm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n5+iq3Lz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5181547E7;
	Mon,  5 Aug 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875332; cv=none; b=DSRXJcIF2fsq/YjOaptuei5GDwQvy0sYnZ+oKvmHGtHyKJ2rvcqLKivg3+yOXUuILn//MWTRStPsBpCDT15VAFlmHSMgmhb2SSjoJ2XaAkFnXX1Ws968vXsORwo9K6tplemoS8EOUhQyw/bd3UHF6aQgI/SQpL6Jt/GtKSY9jbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875332; c=relaxed/simple;
	bh=cc5Tv2P9vNemxQxfWWyYYApoR9ApaMfJlfQnMZFbccs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5j0YXX8G52ZRSu6kOoryotPIVsfSpkVtIQcZmwX2WeU4wmXj5AKbvJVPR5CKod0mMhdV5B2JIdGOGVPDPsL5Io3jWo+GEgwfxKEXQv3Sf1wUeXmKthR6p3ybVYVcukn51CsgDqTWZslt5mLJ4nG/8nBiRuLoewqB52/zhKf5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BVZsLTI1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GDIJt8aK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0YKHBAGm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n5+iq3Lz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9D4421BB6;
	Mon,  5 Aug 2024 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722875329;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czbeFM453uNmNqFmwAP6yYMD9pNd8YGwLlQ4NEB0yUc=;
	b=BVZsLTI1ohoIVwLbhrH5bfkC88pYOwPKi/h7HwOxaOj6nyqGt7Urt6lQqNktglPxjq1jl7
	qXdvmbjaXD8Da2mQfYlCZRZDCNHditNEIGvtkC8kx03sg7mUZnbumtvxDjgXzvJuWjps2r
	aXN+pRvQD5kbIqzRWx5IrYhW9dRaLfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722875329;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czbeFM453uNmNqFmwAP6yYMD9pNd8YGwLlQ4NEB0yUc=;
	b=GDIJt8aKyvoGAZR4Hlm8/l0wUMSy9qyVw0t3IZ6126SedaMQGxr5/Rx8riTuu60psMdGEQ
	uxxcy5Gmc1Mf2cCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0YKHBAGm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=n5+iq3Lz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722875328;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czbeFM453uNmNqFmwAP6yYMD9pNd8YGwLlQ4NEB0yUc=;
	b=0YKHBAGmjX/h7X3W59QO1IGtDheE3vsUe2Ipilms4y7iCQfxlH7+TmjwBgzLO62lVx2FCm
	+Sof6a4i3JqMYCTf0bl3+h198Twz0xZAZvRBmH7sdDC8V8zAOScPy6vjRzc0w6h14s2WZx
	Bb7cfDlhl1+KS4VNVnfD3JUt7RWSNMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722875328;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=czbeFM453uNmNqFmwAP6yYMD9pNd8YGwLlQ4NEB0yUc=;
	b=n5+iq3LzKQ1hnwN3Zn7+uAhHroGmD+xlsjWupqIq1KNegveSo5W8s9z59bteFnTWM5/3wH
	eV4zWcO+jKA4KdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B841B13254;
	Mon,  5 Aug 2024 16:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id acG+LMD9sGZmcQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Aug 2024 16:28:48 +0000
Date: Mon, 5 Aug 2024 18:28:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 3/5] btrfs: set rst_search_commit_root in case of
 relocation
Message-ID: <20240805162843.GZ17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
 <20240731-debug-v3-3-f9b7ed479b10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-debug-v3-3-f9b7ed479b10@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D9D4421BB6
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, Jul 31, 2024 at 10:43:05PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Set rst_search_commit_root in the btrfs_io_stripe we're passing to
> btrfs_map_block() in case we're doing data relocation.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/bio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index dfb32f7d3fc2..c6563616c813 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -679,7 +679,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  	blk_status_t ret;
>  	int error;
>  
> -	smap.rst_search_commit_root = !bbio->inode;
> +	smap.rst_search_commit_root =
> +		(!bbio->inode || btrfs_is_data_reloc_root(inode->root));

Please use an 'if' here

