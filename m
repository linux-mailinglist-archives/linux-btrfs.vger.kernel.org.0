Return-Path: <linux-btrfs+bounces-19300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD9C81E06
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 18:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029563A1460
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD54233149;
	Mon, 24 Nov 2025 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G9EQh8R2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NREqumGi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G9EQh8R2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NREqumGi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969B339A8
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005028; cv=none; b=E315ZgBPD2XapeNt7fn+EnIBZ5ls3FYsVO/6KkEmgUz9asJW4lvbgSmWnuSNaSPpRbwfod24ESYcmE8fmSnnKQEZ9JiLNAs8wJMzjlqnpOrg/fEKG98X0DTi4WxDf+yH4rW3rY9QzzFR07kFl0INfDPvb4yd0/fVxvEN4fwmTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005028; c=relaxed/simple;
	bh=TeS700pJhY4CRJlhbTyFqbYNspnXQdFTlVY5d6+7ddU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAj12LQWTf5LtXIBqbELncx61MFhVUOFgyWzVdpGMmlMFj0VijbgOELrKokltPivMC5I+anAvZQsotEGslLSzmzw/d428iPuRNANla98DXlSrhJ+CpKoX2ZwIA9yLzdI92WH7tO806t4dKhC8sMgbYFdPzXFfb0/k4cbTk5Xllw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G9EQh8R2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NREqumGi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G9EQh8R2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NREqumGi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08376220EA;
	Mon, 24 Nov 2025 17:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764005025;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5XsqUeKd6aRdwYCe7gAF41yhpt5SUmNRoM2G5ulmSqM=;
	b=G9EQh8R2BZGCiwnnV1XiCWutP1/fosvTnzmMPqiXffmpRqXUAw1obnXxN6VQn7u8F5CDP/
	TZBS+qvXnXGv+cSwwzYfkVhNBCdY2Xj00ZaLLxpFA0eY/BIvjEsBf4ERpUNTlT/SFHWnWQ
	/IRMKBw57S4QHX/DNdj75+W4TeHZrlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764005025;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5XsqUeKd6aRdwYCe7gAF41yhpt5SUmNRoM2G5ulmSqM=;
	b=NREqumGiF1yfyL7NdvMz4gfBRp0hQ6NLmXf4SvQfTELxC32s0dMOQsXLUAqrljp9KKgKxs
	vrZfIDUjcYIMO7BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G9EQh8R2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NREqumGi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764005025;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5XsqUeKd6aRdwYCe7gAF41yhpt5SUmNRoM2G5ulmSqM=;
	b=G9EQh8R2BZGCiwnnV1XiCWutP1/fosvTnzmMPqiXffmpRqXUAw1obnXxN6VQn7u8F5CDP/
	TZBS+qvXnXGv+cSwwzYfkVhNBCdY2Xj00ZaLLxpFA0eY/BIvjEsBf4ERpUNTlT/SFHWnWQ
	/IRMKBw57S4QHX/DNdj75+W4TeHZrlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764005025;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5XsqUeKd6aRdwYCe7gAF41yhpt5SUmNRoM2G5ulmSqM=;
	b=NREqumGiF1yfyL7NdvMz4gfBRp0hQ6NLmXf4SvQfTELxC32s0dMOQsXLUAqrljp9KKgKxs
	vrZfIDUjcYIMO7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CED53EA63;
	Mon, 24 Nov 2025 17:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g3tWHqCUJGnHOQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Nov 2025 17:23:44 +0000
Date: Mon, 24 Nov 2025 18:23:43 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: remove useless smp_mb in start_transaction
Message-ID: <20251124172343.GQ13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1763736921.git.josef@toxicpanda.com>
 <47165cb8ed8a4a576e83a0ab13813ebe2de808bf.1763736921.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47165cb8ed8a4a576e83a0ab13813ebe2de808bf.1763736921.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 08376220EA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, Nov 21, 2025 at 09:59:22AM -0500, Josef Bacik wrote:
> trans->state is protected by a spin_lock() and there's no mb when we set
> it, simply the spin_unlock(). The correct pairing with that is
> smp_load_acquire(), so replace the smp_mb with the appropriate helper.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/transaction.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 863e145a3c26..be2f1b88a0c1 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -737,8 +737,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>  	INIT_LIST_HEAD(&h->new_bgs);
>  	btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLOCK_RSV_DELOPS);
>  
> -	smp_mb();
> -	if (cur_trans->state >= TRANS_STATE_COMMIT_START &&
> +	if (smp_load_acquire(&cur_trans->state) >= TRANS_STATE_COMMIT_START &&

This is a memory barrier so it should be documented.

