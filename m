Return-Path: <linux-btrfs+bounces-12984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A6A87C04
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 11:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4287A95E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01955263F48;
	Mon, 14 Apr 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IidmJ1u8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r5Sc05bg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IidmJ1u8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r5Sc05bg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EBD1B21A7
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623452; cv=none; b=gXBFsWxoh7Ccv58jBmQj/OLgt1+MiinA6WwFxm96WVKk8ANNFRG5okrhbaIAyRob34BPvHsx3hk+w+Y0edqKxdM0H8TWChsimYfK8fxg5/0h5J6Q/1u9Tfw8Mzg4M7z499uHJJR2TbBS7khTr3PTjlkjQS7ynFmwDBKpghzQQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623452; c=relaxed/simple;
	bh=IhLyXwuYheBjVEVxaMy5980Oauc1OEHNPpGuOtpKrcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0bvHGAzvcAlvJ4dBbc54OkIaV8EwUS9gj4orGHBmEjU674zhg6pPLPS+vt55ynpIoVaq5m8qMbJoD7pThgrGb4GTCZ8hf1+FwpDI6qt+Gr/Ac1imNm5h5qU42VrmRRzm4HdZYLyxrDFdignHsAMsv7AQMG2CoBOrrtESeYcFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IidmJ1u8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r5Sc05bg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IidmJ1u8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r5Sc05bg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A5CE1F458;
	Mon, 14 Apr 2025 09:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744623447;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmBBQpa1y0uoauy46Pz+6qrIH5Gt6qQHqLKaec4xStM=;
	b=IidmJ1u8NQNe2HuwFIqTsF2ZyAuxowGAf1sdY59HxcKs8/yu0lnaj3CxUgapyuhnxaXP8h
	2rbf861zQe1a9RNA+n6iFGhIZTeLeRBzDXx2Q57V7KVNhQeS4wYyW8EzW/0AdpMHfsOpGS
	AS06esk1AuWHN+p8c/NN13WQpMqBDCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744623447;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmBBQpa1y0uoauy46Pz+6qrIH5Gt6qQHqLKaec4xStM=;
	b=r5Sc05bgcKAf6rH9FsVPGVSFgtOdomkF0GfEAqk/VAXWYJ9nqcbZJkx419ZBqE9c/zwdPb
	qSHz8FUc3uOaMTCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IidmJ1u8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=r5Sc05bg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744623447;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmBBQpa1y0uoauy46Pz+6qrIH5Gt6qQHqLKaec4xStM=;
	b=IidmJ1u8NQNe2HuwFIqTsF2ZyAuxowGAf1sdY59HxcKs8/yu0lnaj3CxUgapyuhnxaXP8h
	2rbf861zQe1a9RNA+n6iFGhIZTeLeRBzDXx2Q57V7KVNhQeS4wYyW8EzW/0AdpMHfsOpGS
	AS06esk1AuWHN+p8c/NN13WQpMqBDCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744623447;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmBBQpa1y0uoauy46Pz+6qrIH5Gt6qQHqLKaec4xStM=;
	b=r5Sc05bgcKAf6rH9FsVPGVSFgtOdomkF0GfEAqk/VAXWYJ9nqcbZJkx419ZBqE9c/zwdPb
	qSHz8FUc3uOaMTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4834A136A7;
	Mon, 14 Apr 2025 09:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lYptEVfX/GeXNQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 14 Apr 2025 09:37:27 +0000
Date: Mon, 14 Apr 2025 11:37:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: make error handling more appropriate in
 btrfs_delayed_ref_init()
Message-ID: <20250414093725.GC16750@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250410113858.149032-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410113858.149032-1-frank.li@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6A5CE1F458
X-Spam-Score: -4.21
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email,suse.cz:replyto,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Apr 10, 2025 at 05:38:58AM -0600, Yangtao Li wrote:
> 1. Remove unnecessary goto
> 2. Make the execution logic of the function jumped by goto more appropriate
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/btrfs/delayed-ref.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 98c5b61dabe8..e984f1761afa 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1339,11 +1339,11 @@ int __init btrfs_delayed_ref_init(void)
>  {
>  	btrfs_delayed_ref_head_cachep = KMEM_CACHE(btrfs_delayed_ref_head, 0);
>  	if (!btrfs_delayed_ref_head_cachep)
> -		goto fail;
> +		return -ENOMEM;
>  
>  	btrfs_delayed_ref_node_cachep = KMEM_CACHE(btrfs_delayed_ref_node, 0);
>  	if (!btrfs_delayed_ref_node_cachep)
> -		goto fail;
> +		goto out;
>  
>  	btrfs_delayed_extent_op_cachep = KMEM_CACHE(btrfs_delayed_extent_op, 0);
>  	if (!btrfs_delayed_extent_op_cachep)
> @@ -1351,6 +1351,8 @@ int __init btrfs_delayed_ref_init(void)
>  
>  	return 0;
>  fail:
> -	btrfs_delayed_ref_exit();
> +	kmem_cache_destroy(btrfs_delayed_ref_node_cachep);
> +out:
> +	kmem_cache_destroy(btrfs_delayed_ref_head_cachep);

This is partially duplicating btrfs_delayed_ref_exit(), I'd rather reuse
the exit helper.

I've checked if this can be done elsewhere, seems that there's only one
other case btrfs_bioset_init(), which is partially duplicating
btrfs_bioset_exit(). All other init/exit functions are trivial and
allocate one structure. So if you want to do that cleanup, please update
btrfs_bioset_init() to the preferred pattern. Thanks.

