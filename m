Return-Path: <linux-btrfs+bounces-21925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC8RO1ESn2nVYwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21925-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 16:16:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ECE199613
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 16:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB3FC3061CD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0433D6481;
	Wed, 25 Feb 2026 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvSr7wYc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WR3o88oN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvSr7wYc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WR3o88oN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E933921D3
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032123; cv=none; b=aXBHRb0Zoh4jD89uEnEiSqAEpK0iyVD57uFSJxAsIJu7n6s63KrhXwZ1UCeaYgytdiE8fNPgitHB3ph+YA+HyFy0HOw9va+UKGWr0fR6Czh/fBgwi8NsGjBcmIGI7sLjyXOZz6jLvvJSdqKW6GUQWNyU1ebjZw4RfEJZxA0Jisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032123; c=relaxed/simple;
	bh=Pq1CefqDfr5l16OHoh36ar3k6EJ5w3cMMAMyUfTJZY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU8BbPwt18Dp4t8782/wEZI/oR+renNDY78eDlofam4TXGcSffk1eWqCOzACvkhswvRKcGYAEv5qWVOxJnLZiRvTzCUsGXS+xUKwRp1OjQqDIM8lJ2WjPhLr6MpnrEbPH4+LcjlotiyxwwUy4rCfwUY1gI56TpVx+J50bIV67fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvSr7wYc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WR3o88oN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvSr7wYc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WR3o88oN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D8485C728;
	Wed, 25 Feb 2026 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772032120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntAXgZlbYcCfwiCRS4F5ub52FszhViM+cFBEltEy1Z4=;
	b=zvSr7wYc5IL0SQhr2VQz5P1c7F0nqZQrKD2CXxd8TKag6cSaFhG099L2GHXPnToKGBmEsM
	/y1TwoWb+oRFu/hsulwAqhfUQMu/D/XnZyIMh0LY5HhkiDTez+wFmERsVCJrVHWpopIwLL
	rlFx2jXasTHHcAOxNqwb+j5UYgDFmaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772032120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntAXgZlbYcCfwiCRS4F5ub52FszhViM+cFBEltEy1Z4=;
	b=WR3o88oNpS4ajEcwen78tWpQaioVAkTbwjavwUisjKEhGJer3nFAn36eAi9koaqGOX+Sss
	Gzp1BP3k939N7PDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772032120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntAXgZlbYcCfwiCRS4F5ub52FszhViM+cFBEltEy1Z4=;
	b=zvSr7wYc5IL0SQhr2VQz5P1c7F0nqZQrKD2CXxd8TKag6cSaFhG099L2GHXPnToKGBmEsM
	/y1TwoWb+oRFu/hsulwAqhfUQMu/D/XnZyIMh0LY5HhkiDTez+wFmERsVCJrVHWpopIwLL
	rlFx2jXasTHHcAOxNqwb+j5UYgDFmaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772032120;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntAXgZlbYcCfwiCRS4F5ub52FszhViM+cFBEltEy1Z4=;
	b=WR3o88oNpS4ajEcwen78tWpQaioVAkTbwjavwUisjKEhGJer3nFAn36eAi9koaqGOX+Sss
	Gzp1BP3k939N7PDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B4C13EA65;
	Wed, 25 Feb 2026 15:08:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o0c0EngQn2mDAwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 25 Feb 2026 15:08:40 +0000
Date: Wed, 25 Feb 2026 16:08:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, boris@bur.io, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: fix potential segfault in balance_remap_chunks()
Message-ID: <20260225150835.GF26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260225103535.18430-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225103535.18430-1-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21925-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim,fb.com:email]
X-Rspamd-Queue-Id: 67ECE199613
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:35:31AM +0000, Mark Harmstone wrote:
> Fix a potential segfault in balance_remap_chunks(): if we quit early
> because btrfs_inc_block_group_ro() fails, all the remaining items in the
> chunks list will still have their bg value set to NULL. It's thus not
> safe to dereference this pointer without checking first.
> 
> Link: https://lore.kernel.org/linux-btrfs/20260125120717.1578828-1-clm@meta.com/
> Reported-by: Chris Mason <clm@fb.com>
> Fixes: 81e5a4551c32 ("btrfs: allow balancing remap tree")
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/volumes.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e15e138c515b..18911cdd2895 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4288,17 +4288,19 @@ static int balance_remap_chunks(struct btrfs_fs_info *fs_info, struct btrfs_path
>  
>  		rci = list_first_entry(chunks, struct remap_chunk_info, list);
>  
> -		spin_lock(&rci->bg->lock);
> -		is_unused = !btrfs_is_block_group_used(rci->bg);
> -		spin_unlock(&rci->bg->lock);
> +		if (rci->bg) {
> +			spin_lock(&rci->bg->lock);
> +			is_unused = !btrfs_is_block_group_used(rci->bg);
> +			spin_unlock(&rci->bg->lock);
>  
> -		if (is_unused)
> -			btrfs_mark_bg_unused(rci->bg);

Not related to the patch but isn't this pattern inherently racy?

The "used" is read under lock but then btrfs_mark_bg_unused() is outside
of the lock so the status can change. This can be seen it more places,
but they seem to be related to the remap tree feature.

