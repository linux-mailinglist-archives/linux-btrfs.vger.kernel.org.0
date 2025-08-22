Return-Path: <linux-btrfs+bounces-16284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA58B3185C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 14:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66DE1D04811
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473A2FC038;
	Fri, 22 Aug 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nCvgsUM1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UFiwkDwF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nCvgsUM1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UFiwkDwF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEA28AB1E
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867033; cv=none; b=EWunHBZxvhNSrL+ioPW+o6GGbQK1L0ESaQkMjaZGipuLnn5BFtliiwwJNNvhuoE8xxOWpoVBREtdffYF24o8LsDZWDPbjadrh662AltmW5nkK1rY3I1kqDkiI1Nv027DD3o5mKz4EXNMAvgJxG6wB+RTcuUZL3545OuPstDj4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867033; c=relaxed/simple;
	bh=hl4XsNVd0oZpRjoheIr6tx5khI9qcwwfbMkQb3sXfi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP76jYSavM+TEHGUhD2N59tClvWbDGMzJkm12EO6NCqpAgmBZeSOSag1oXArsUucYc9MAfLGy27mB/D5Vx0onYH11Q1fmLoYZwLDTn4MG56xpMDauGAfDXu6u0qql0S6cnKBIgFiFtmTHF56PVilnel+pk2YX2dlfhEG52hlQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nCvgsUM1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UFiwkDwF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nCvgsUM1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UFiwkDwF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 967121F38E;
	Fri, 22 Aug 2025 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755867029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbj8YovJGPlRhCXSYwnpZGbwjy9T842i9akOmKw0WQs=;
	b=nCvgsUM1GVPmdfGBSXNi/UH6yhCVmk4B/D8tcoALFta6FfhnwTdDZa+Bvp1dufxPnARMqZ
	KnuBGoSyCYxfEXCK7T6Tf1/6oNY/vrQe0+AzBrL27qlZ2dddYBDVdgd0sxJuGrySm7NVUX
	KwVn6mvnGmXIpgLf+5enKltIcdA+nSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755867029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbj8YovJGPlRhCXSYwnpZGbwjy9T842i9akOmKw0WQs=;
	b=UFiwkDwF81PXwj1zDLMDfqGPdN6LvasYANYul22gWtqGCP5W02gUjYe/a5dHqJj9nDpMMN
	wokTtQY4w72jPbCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755867029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbj8YovJGPlRhCXSYwnpZGbwjy9T842i9akOmKw0WQs=;
	b=nCvgsUM1GVPmdfGBSXNi/UH6yhCVmk4B/D8tcoALFta6FfhnwTdDZa+Bvp1dufxPnARMqZ
	KnuBGoSyCYxfEXCK7T6Tf1/6oNY/vrQe0+AzBrL27qlZ2dddYBDVdgd0sxJuGrySm7NVUX
	KwVn6mvnGmXIpgLf+5enKltIcdA+nSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755867029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbj8YovJGPlRhCXSYwnpZGbwjy9T842i9akOmKw0WQs=;
	b=UFiwkDwF81PXwj1zDLMDfqGPdN6LvasYANYul22gWtqGCP5W02gUjYe/a5dHqJj9nDpMMN
	wokTtQY4w72jPbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8543F13AF6;
	Fri, 22 Aug 2025 12:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gl+5H5VnqGjcawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 22 Aug 2025 12:50:29 +0000
Date: Fri, 22 Aug 2025 14:50:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: get_inode_info(): check NULL info parameter
 early
Message-ID: <20250822125027.GU22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250821131557.5185-1-sunk67188@gmail.com>
 <20250821131557.5185-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821131557.5185-2-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Aug 21, 2025 at 09:12:23PM +0800, Sun YangKai wrote:
> Move the NULL pointer check for the @info parameter to the beginning
> of get_inode_info() function to avoid unnecessary operations when no
> output is required.
> 
> This change provides two benefits:
> 1. Avoids allocating path and performing tree lookups when @info is NULL
> 2. Simplifies the control flow by eliminating the redundant check
>    before writing output
> 
> The functional behavior remains unchanged except for the performance
> improvement when called with NULL info parameter.

Reordering conditional usually leads to behaviour changes and I think it
does in this case as well.

> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/send.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 7664025a5af4..5010d17878f9 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -913,6 +913,9 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
>  	struct btrfs_inode_item *ii;
>  	struct btrfs_key key;
>  
> +	if (!info)
> +		return 0;

Moving the check as the first statement will skip anything else. There's
one call of get_inode_info() with info == NULL, in apply_dir_move(),
otherwise all callers fill in a stack variable.

> +
>  	path = alloc_path_for_send();
>  	if (!path)
>  		return -ENOMEM;
> @@ -927,9 +930,6 @@ static int get_inode_info(struct btrfs_root *root, u64 ino,
>  		goto out;
>  	}

Right before this there's call to btrfs_search_slot() looking up
INODE_ITEM for 'ino', there are 3 results, and two are still valid for
the callers. Only if ret == 0 then the 'if (!info)' check is done.
Otherwise it's either an error (ret < 0) or -ENOENT (when ret == 1).

So get_inode_info() is also has the semantics of that the inode exists,
with the reordered 'info' check it never happens.

>  
> -	if (!info)
> -		goto out;
> -
>  	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
>  			struct btrfs_inode_item);
>  	info->size = btrfs_inode_size(path->nodes[0], ii);
> -- 
> 2.50.1
> 

