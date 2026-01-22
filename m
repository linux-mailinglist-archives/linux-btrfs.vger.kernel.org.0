Return-Path: <linux-btrfs+bounces-20885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHTrOaOAcWk1IAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20885-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 02:42:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E960757
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 02:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27DB84F7924
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 01:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D250354ADF;
	Thu, 22 Jan 2026 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PD9sM5Cj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L745B1wO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PD9sM5Cj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L745B1wO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354E03559CD
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046168; cv=none; b=cgCcD63gFXQrwALA8KHzaGFJBMIXGzwsX1uEZwIFbHPc2zOFtsjgfLGvNlIFoh8LjRMubNqlvXSPg7Pp5RgwQdSjHMQKtbD4vY/1eB+1tUrAXDhCqMoi+vqZv9aG6aYouqkcvKoUQWS05mxlw3F8UQvTwh5qECD8mh/lkiNK3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046168; c=relaxed/simple;
	bh=pajYxcyeoD6+0DWcFdiuSEesPUlQyfohckrVNbO0fU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lug6eHqTSzKGcT2VcRrcKZ3R7N3dGJAuwhGqd42ayI6Y1bBWt60gODSVWyzHMilT5zIPPGoMltGLRDbFcrH46/MrQD2UM0LkSovqr0UjamB/FLOYBjF2DAk1BjIV/33JdYv9ybERt7rcoCcABh3dVl+LCLDzPx8bxZD+YabuQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PD9sM5Cj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L745B1wO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PD9sM5Cj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L745B1wO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BEA45BCC3;
	Thu, 22 Jan 2026 01:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769046162;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SwOSowd91xoTuvXjWZ28drp6BIP8b3vYYoTOjHWJ3j0=;
	b=PD9sM5CjqjCu+j65SNtbLngDC7kPHT35snpTL/cNrpjGZG8hZBrZeK4aPlDEPpP5n7v1/0
	nZE1Tr9FPGWIqz+/qRvXqC5zOY9pQYs1DchSR/WtfuGuiJQjJlixj1OTiY0jXwTDdKfHQ3
	s+ADC1VZT+D2SZjezJmuf69zqAQ2H2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769046162;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SwOSowd91xoTuvXjWZ28drp6BIP8b3vYYoTOjHWJ3j0=;
	b=L745B1wOUXaU4uv1bVw3Nu0HGxEZNYalpZEW+7sSiI8FBb52MnZe53+Us0JvFdaT4mt80k
	u7zOKg94lEgEIGDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769046162;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SwOSowd91xoTuvXjWZ28drp6BIP8b3vYYoTOjHWJ3j0=;
	b=PD9sM5CjqjCu+j65SNtbLngDC7kPHT35snpTL/cNrpjGZG8hZBrZeK4aPlDEPpP5n7v1/0
	nZE1Tr9FPGWIqz+/qRvXqC5zOY9pQYs1DchSR/WtfuGuiJQjJlixj1OTiY0jXwTDdKfHQ3
	s+ADC1VZT+D2SZjezJmuf69zqAQ2H2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769046162;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SwOSowd91xoTuvXjWZ28drp6BIP8b3vYYoTOjHWJ3j0=;
	b=L745B1wOUXaU4uv1bVw3Nu0HGxEZNYalpZEW+7sSiI8FBb52MnZe53+Us0JvFdaT4mt80k
	u7zOKg94lEgEIGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBF3C3EA63;
	Thu, 22 Jan 2026 01:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g81tOZGAcWkjbwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 22 Jan 2026 01:42:41 +0000
Date: Thu, 22 Jan 2026 02:42:32 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: deal with missing root in
 sample_block_group_extent_item()
Message-ID: <20260122014232.GT26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1769028677.git.fdmanana@suse.com>
 <30034e48a39502638fbac40662914132895cca4b.1769028677.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30034e48a39502638fbac40662914132895cca4b.1769028677.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[suse.cz];
	TAGGED_FROM(0.00)[bounces-20885-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email,twin.jikos.cz:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E2E960757
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 08:52:38PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In case the does not exists, which is unexpected, btrfs_extent_root()
> returns NULL, but we ignore that and so if it happens we can trigger
> a NULL pointer dereference later. So verify if we found the root and
> log an error message in case it's missing.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/block-group.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 6387e11f8f8e..b3345792f3a1 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -607,6 +607,12 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
>  	lockdep_assert_held_read(&fs_info->commit_root_sem);
>  
>  	extent_root = btrfs_extent_root(fs_info, block_group->start);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "Could not find extent root for block group at offset %llu\n",

This is probably a message copied from elsewhere, we do't capitalize the
first letter and the trailing "\n" is provided by btrfs_err()

> +			  block_group->start);
> +		return -EUCLEAN;
> +	}
>  
>  	search_offset = index * div_u64(block_group->length, max_index);
>  	search_key.objectid = block_group->start + search_offset;
> -- 
> 2.47.2
> 

