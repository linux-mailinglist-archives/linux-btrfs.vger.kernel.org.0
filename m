Return-Path: <linux-btrfs+bounces-10836-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8058A07396
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6AC167364
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0105215F6A;
	Thu,  9 Jan 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vTi0V274";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TfXJqr/J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vTi0V274";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TfXJqr/J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8665D215779;
	Thu,  9 Jan 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419371; cv=none; b=QOLDhFnUEqll9j89ieqooypkw1zgahUEF/kfyny+wELaY7Pax6s5aZt1L2L0VLCHwBTjuYOxnOFv73nETUQlDVEwIFtOMQCfCSqFpsarsTm6HphO+7rLAYzoaAbANGL3NJN43xUayrKLp+59yebjbi44wnoVLCB+EtPKOoIPfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419371; c=relaxed/simple;
	bh=Zx8JEpzuy0SY21/7VJls3AxTDO46XkKjFYbMs6hUWIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUNdYtlr28dGJvSzPeQ25Ktp124SflrzS6O+NaG4vUq5CRbV8OjPq3CcX4Ma/fK8NU+o/HT9H+6A2puzkYR+bAMFFzUCKTl7NthpCZEpWmFYd8R+IpzNqic0NMgcFAIJ01kPDYYBqbw4AOUeA4jzTfcRm1N1/JGFTGpjO4gZlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vTi0V274; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TfXJqr/J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vTi0V274; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TfXJqr/J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8FA621157;
	Thu,  9 Jan 2025 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736419367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fgUsGrPszyqRZTnoq5X/VlbE8cjq4jVz64Fzl5bl9l4=;
	b=vTi0V274p38mEM/Ij2R7Ts0q86PSdUokyO02cnh3bhC853Xh4fvQeF6g76Cb1vGuk8t6Ue
	W6bE1uVfYa6Bnq/y/quX2ihP36+f30kg7UPWqTZGpk/KOYFarrGjAGY6rEbVx8well6qxj
	G1PfM31pWW/5Sw/yPJDRZQjvZrOx55k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736419367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fgUsGrPszyqRZTnoq5X/VlbE8cjq4jVz64Fzl5bl9l4=;
	b=TfXJqr/JdxONxdJtjLF39KzsWERrYkBP58b93lRrz/JHdjwfjAzrLwuSzBWfAKZ/SnczGp
	tVoSLAgyhw7KK5Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vTi0V274;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="TfXJqr/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736419367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fgUsGrPszyqRZTnoq5X/VlbE8cjq4jVz64Fzl5bl9l4=;
	b=vTi0V274p38mEM/Ij2R7Ts0q86PSdUokyO02cnh3bhC853Xh4fvQeF6g76Cb1vGuk8t6Ue
	W6bE1uVfYa6Bnq/y/quX2ihP36+f30kg7UPWqTZGpk/KOYFarrGjAGY6rEbVx8well6qxj
	G1PfM31pWW/5Sw/yPJDRZQjvZrOx55k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736419367;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fgUsGrPszyqRZTnoq5X/VlbE8cjq4jVz64Fzl5bl9l4=;
	b=TfXJqr/JdxONxdJtjLF39KzsWERrYkBP58b93lRrz/JHdjwfjAzrLwuSzBWfAKZ/SnczGp
	tVoSLAgyhw7KK5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83AE6139AB;
	Thu,  9 Jan 2025 10:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aifrHyeof2dMFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 Jan 2025 10:42:47 +0000
Date: Thu, 9 Jan 2025 11:42:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 03/14] btrfs: fix search when deleting a RAID
 stripe-extent
Message-ID: <20250109104242.GD2097@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-3-0c7b14c0aac2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-rst-delete-fixes-v2-3-0c7b14c0aac2@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: A8FA621157
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Jan 07, 2025 at 01:47:33PM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Only pick the previous slot, when btrfs_search_slot() returned '1'.

"which means we did not find the key."

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 5c6224ed3eda53a11a41bffdf6c789fbd6d3a503..0c4d218a99d4aaea5da6c39624e20e77758a89d3 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -89,8 +89,12 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
>  		if (ret < 0)
>  			break;
>  
> -		if (path->slots[0] == btrfs_header_nritems(path->nodes[0]))
> -			path->slots[0]--;
> +		if (ret == 1) {
> +			ret = 0;
> +			if (path->slots[0] ==
> +			    btrfs_header_nritems(path->nodes[0]))
> +				path->slots[0]--;
> +		}
>  
>  		leaf = path->nodes[0];
>  		slot = path->slots[0];
> 
> -- 
> 2.43.0
> 

