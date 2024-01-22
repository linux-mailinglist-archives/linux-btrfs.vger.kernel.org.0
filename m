Return-Path: <linux-btrfs+bounces-1617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BA18374B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3C21C2696A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 20:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE047A6F;
	Mon, 22 Jan 2024 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GkitZGjK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+ps7/nj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GkitZGjK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+ps7/nj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B42CA8
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956977; cv=none; b=nOc+Tg4mnfgEqCqn60zpUZsT9wXei7759uTH3BESmM8P7WYKp4uQNLL/+rUNBLrUn33NlGgFMChOZH1cksV1MHgzUfQcODpxrfQvVHU+m8ECUt5CTNn/xjgsJqsU+gEz/pbAgQcppMDxoq0ApIPBHR21lXpnWIOP2tjTzqxZq/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956977; c=relaxed/simple;
	bh=faB6+L1/pzgkaXPR9EnSdMu/fZ0rMxvwt4puQu+vXMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8SzvyHSU1wfxeUiKDGDQSl52wmPxyhuJjmLjOvzZhyM3/6DxqGNtKpN2I4olBpcXkWk4iRrQtRljE2HqKekuiCzNJg2tMnPzDt/jb9jZfQkOs4E/EouUNFmQJmgKtMe8Z9v291Vzczs2mbNYy065r+OlcK7XZvCi7UWDZPqyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GkitZGjK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+ps7/nj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GkitZGjK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+ps7/nj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 410261F392;
	Mon, 22 Jan 2024 20:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956973;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IzrqiEXSnrPkbPMjTDzlSLE7ptrOxPVrai2MvnBVa9U=;
	b=GkitZGjKnFhfUtZbHyPNg7lzgKlhF4IxFxeyKAPx8g1l19tFUegvmJZeW+F29NDWOxB931
	THTI4wp6mwGAixf2gAf7RNkkFYJbHawCj6Ik4K+rMBypcv14evbs0J19IwmRezDFGWEm5h
	vHRrFGLaKqHKlJhK1ft/vW5Z2OfmsTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956973;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IzrqiEXSnrPkbPMjTDzlSLE7ptrOxPVrai2MvnBVa9U=;
	b=z+ps7/njqMEZQj7iXPQ3kkFH49WcK7xkqlnwrQhoCNgPQ0zNORoMGkHlCmErmlyWWozt/r
	vBtbC1ucbRom8tAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705956973;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IzrqiEXSnrPkbPMjTDzlSLE7ptrOxPVrai2MvnBVa9U=;
	b=GkitZGjKnFhfUtZbHyPNg7lzgKlhF4IxFxeyKAPx8g1l19tFUegvmJZeW+F29NDWOxB931
	THTI4wp6mwGAixf2gAf7RNkkFYJbHawCj6Ik4K+rMBypcv14evbs0J19IwmRezDFGWEm5h
	vHRrFGLaKqHKlJhK1ft/vW5Z2OfmsTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705956973;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IzrqiEXSnrPkbPMjTDzlSLE7ptrOxPVrai2MvnBVa9U=;
	b=z+ps7/njqMEZQj7iXPQ3kkFH49WcK7xkqlnwrQhoCNgPQ0zNORoMGkHlCmErmlyWWozt/r
	vBtbC1ucbRom8tAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 284F813310;
	Mon, 22 Jan 2024 20:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id w4NoCW3WrmWTfAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 20:56:13 +0000
Date: Mon, 22 Jan 2024 21:55:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/4] btrfs: page to folio conversion in put_file_data()
Message-ID: <20240122205551.GA31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705605787.git.rgoldwyn@suse.com>
 <861fb1618d04ccb56c00ac78b4c6ca81dc9a59e4.1705605787.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861fb1618d04ccb56c00ac78b4c6ca81dc9a59e4.1705605787.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GkitZGjK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="z+ps7/nj"
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 410261F392
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Thu, Jan 18, 2024 at 01:46:40PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Use folio instead of page in put_file_data(). This converts usage of all
> page based functions to folio-based.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/send.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 7902298c1f25..0de3d4163f6b 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5257,10 +5257,11 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>  {
>  	struct btrfs_root *root = sctx->send_root;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> -	struct page *page;
> +	struct folio *folio;
>  	pgoff_t index = offset >> PAGE_SHIFT;
>  	pgoff_t last_index;
>  	unsigned pg_offset = offset_in_page(offset);
> +	struct address_space *mapping = sctx->cur_inode->i_mapping;
>  	int ret;
>  
>  	ret = put_data_header(sctx, len);
> @@ -5273,44 +5274,43 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>  		unsigned cur_len = min_t(unsigned, len,
>  					 PAGE_SIZE - pg_offset);
>  
> -		page = find_lock_page(sctx->cur_inode->i_mapping, index);
> -		if (!page) {
> -			page_cache_sync_readahead(sctx->cur_inode->i_mapping,
> +		folio = filemap_lock_folio(mapping, index);
> +		if (IS_ERR(folio)) {
> +			page_cache_sync_readahead(mapping,
>  						  &sctx->ra, NULL, index,
>  						  last_index + 1 - index);

Same question regarding page cache sync and folios, assertions would be
good or an explanation why it's ok like that. IIRC the explicit sync is
only in some odd code like defrag that does not go though the MM
callbacks so we have to manage things on our own.

