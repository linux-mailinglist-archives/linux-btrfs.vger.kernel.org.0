Return-Path: <linux-btrfs+bounces-19087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F9C6A60D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 124F2364E5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9771F35E522;
	Tue, 18 Nov 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iKI5kwyK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SQPlLJxe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iKI5kwyK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SQPlLJxe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6B1363C61
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480675; cv=none; b=NFRWazSTvxmnuQwbwdi345NV589Zb2ioA+CaMJdHI/iX5bYh+eOswnW80fZRr4IihaFAD1nG/E/c+2dMVy80eusqMKDpdmG0wmAqM5Vrp3ew7JseTUoFwxARYCpcfGVHk2ufQD0MCHJ8TvrTM82NcBsgD66jvAD8dLiAFGOvMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480675; c=relaxed/simple;
	bh=rO+sYhQeuYK3WrzM+aKLPvyCeiqyfXbYOpWUp64ryjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7uoyxJL9gsg7ClpjxkU1+dtYxwr2aCEwjTiF2aXKnbzI+qkq91tZ2ULIVxdwc9aP0tdLGBJfGbNE5YfyUDv4Dp0MAuaZJFJBLwRnk7AzGKe1y00mZRBuUiNr5TZHb6x6rH7va1zGTUskFnQ87vrU2ea9TWsjtPHqvJXF98z3uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iKI5kwyK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SQPlLJxe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iKI5kwyK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SQPlLJxe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0878C1FF7B;
	Tue, 18 Nov 2025 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763480672;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjlWMRgNnTNZLaUjW+gFUy0tJvRmxgomMixTn/QKmyM=;
	b=iKI5kwyKBw4aABTA5FpSy4h3SdmpLR31jsGx9VNXJKGntTW6dO/BftSDp6PxKH5mBsFERc
	8UYi+Yk0woKSae6/yQ41uFoqsWV5+ClritV1Ji20C+twk3kO10GNY5ZdbO3+ugEfGtjXpA
	G0vFRt7XIcB0A3dTLmW0U8OkUmFGaOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763480672;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjlWMRgNnTNZLaUjW+gFUy0tJvRmxgomMixTn/QKmyM=;
	b=SQPlLJxewgAXtVjYrT25b8ZC3h1ZtXYQpN2P1T170L7r6LF0z2LixQQN9RaAYWg2jkm71k
	mAk5+FsdmR+lI9CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763480672;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjlWMRgNnTNZLaUjW+gFUy0tJvRmxgomMixTn/QKmyM=;
	b=iKI5kwyKBw4aABTA5FpSy4h3SdmpLR31jsGx9VNXJKGntTW6dO/BftSDp6PxKH5mBsFERc
	8UYi+Yk0woKSae6/yQ41uFoqsWV5+ClritV1Ji20C+twk3kO10GNY5ZdbO3+ugEfGtjXpA
	G0vFRt7XIcB0A3dTLmW0U8OkUmFGaOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763480672;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjlWMRgNnTNZLaUjW+gFUy0tJvRmxgomMixTn/QKmyM=;
	b=SQPlLJxewgAXtVjYrT25b8ZC3h1ZtXYQpN2P1T170L7r6LF0z2LixQQN9RaAYWg2jkm71k
	mAk5+FsdmR+lI9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA7F13EA61;
	Tue, 18 Nov 2025 15:44:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EBQIOV+UHGnASQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Nov 2025 15:44:31 +0000
Date: Tue, 18 Nov 2025 16:44:22 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use bool type for btrfs_path members used as
 booleans
Message-ID: <20251118154422.GY13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3a03fb6e8f1d35902220f7e8b7b3d0167f6f1bb2.1763136628.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a03fb6e8f1d35902220f7e8b7b3d0167f6f1bb2.1763136628.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Nov 14, 2025 at 04:11:29PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Many fields of struct btrfs_path are used as booleans but their type is
> an unsigned int (of one 1 bit width to save space). Change the type to
> bool keeping the :1 suffix so that they combine with the previous u8
> fields in order to save space. This makes the code more clear by using
> explicit true/false and more in line with the preferred style, preserving
> the size of the structure.

> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -65,21 +65,21 @@ struct btrfs_path {
>  	 * set by btrfs_split_item, tells search_slot to keep all locks
>  	 * and to force calls to keep space in the nodes
>  	 */
> -	unsigned int search_for_split:1;
> +	bool search_for_split:1;
>  	/* Keep some upper locks as we walk down. */
> -	unsigned int keep_locks:1;
> -	unsigned int skip_locking:1;
> -	unsigned int search_commit_root:1;
> -	unsigned int need_commit_sem:1;
> -	unsigned int skip_release_on_error:1;
> +	bool keep_locks:1;
> +	bool skip_locking:1;
> +	bool search_commit_root:1;
> +	bool need_commit_sem:1;
> +	bool skip_release_on_error:1;
>  	/*
>  	 * Indicate that new item (btrfs_search_slot) is extending already
>  	 * existing item and ins_len contains only the data size and not item
>  	 * header (ie. sizeof(struct btrfs_item) is not included).
>  	 */
> -	unsigned int search_for_extension:1;
> +	bool search_for_extension:1;
>  	/* Stop search if any locks need to be taken (for read) */
> -	unsigned int nowait:1;
> +	bool nowait:1;
>  };

I've looked at the generated assembly and it seems taht with bool:1 it's
a bit better in some cases but the same in general. The delta on .ko
size is -133 bytes.

I was curious to see the difference compared to full bool type (which
also increases the size from 112 to 120 bytes) and this is worse, with
+100 bytes on .ko. The additional instructions calculate the offset of
the separate bool indicators, while in the bool:1 version it can be
accessed in the same byte povided that it was already used in the same
function.

As a conclusion using bool:1 is OK, we could the type updates in
structures with more than say 4+ bools, so to have some visible effect
on struct size or code generation.

