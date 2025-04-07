Return-Path: <linux-btrfs+bounces-12856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2FFA7EBFF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 21:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B56717D71E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DA2246333;
	Mon,  7 Apr 2025 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3lP6dhl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aL0wFEuT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3lP6dhl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aL0wFEuT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E98221DA8
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050302; cv=none; b=fceJhkafn0Em6SvAw8LY3P3gjAUssI8N3Q+X2JsAi6qejSQ0VDjzKRGidNL31PvjsGzp0F6GE4I9qtlJyajLZgYxi6JBer9Dq2wpmLZmg8BTOkvaAnOC3BeZe8nB+zByAYX8UExHC/h8+y5W+5rpVhbM8PyGirw9psjCX2ZkbjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050302; c=relaxed/simple;
	bh=BSFc4rOpwKPUi7sHIUxDTw1yVzfv5LDWvGx+ABImQgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcSirlPp59aS/GbiKfXZZEKzmI5E21vflaC9TsWVCyCNjj/MD9vaOVkPjLPLemIT6oc6q0ePOD6LQhX4UO68acCuj2AhuKhJi5oM/hD+18dtTdpHo1ohvqMmFRGWWjnHwD+HAas9FVYOtSwY9vs/J81UsaXuqBRXitDOExvwKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3lP6dhl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aL0wFEuT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3lP6dhl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aL0wFEuT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21F801F388;
	Mon,  7 Apr 2025 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744050299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AENwLnW9qRdSz4+oL1qic+h1UdWFf/3Q/ldvA8AjI+g=;
	b=r3lP6dhlI86x0TaNTpWaTRd1bD5wy/Fq9SnJY6ccfjaDRpDdnTGwAP2oKHQfzUbBJpexTC
	8NnygBlnbQ0Fij+fZ0O2KUPXBClF5LEnlLPML5LfT9MbQz1s74dr73rTOKkrxCrp5+vNFW
	+bvzpRHnY+g8R1O+Zek9uIJ1kP8OTn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744050299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AENwLnW9qRdSz4+oL1qic+h1UdWFf/3Q/ldvA8AjI+g=;
	b=aL0wFEuTRNNBpW9L8R2m9U+opVanFBtWYz+VXuQdWG2M0XHXkqq3oBvo8Y9KKTTR+rmyZr
	r/G+rQoktEa8wYCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r3lP6dhl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aL0wFEuT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744050299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AENwLnW9qRdSz4+oL1qic+h1UdWFf/3Q/ldvA8AjI+g=;
	b=r3lP6dhlI86x0TaNTpWaTRd1bD5wy/Fq9SnJY6ccfjaDRpDdnTGwAP2oKHQfzUbBJpexTC
	8NnygBlnbQ0Fij+fZ0O2KUPXBClF5LEnlLPML5LfT9MbQz1s74dr73rTOKkrxCrp5+vNFW
	+bvzpRHnY+g8R1O+Zek9uIJ1kP8OTn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744050299;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AENwLnW9qRdSz4+oL1qic+h1UdWFf/3Q/ldvA8AjI+g=;
	b=aL0wFEuTRNNBpW9L8R2m9U+opVanFBtWYz+VXuQdWG2M0XHXkqq3oBvo8Y9KKTTR+rmyZr
	r/G+rQoktEa8wYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0830E13691;
	Mon,  7 Apr 2025 18:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9YaEAXsY9GdpcQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Apr 2025 18:24:59 +0000
Date: Mon, 7 Apr 2025 20:24:57 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/16] btrfs: some cleanups for extent-io-tree (mostly
 renames)
Message-ID: <20250407182457.GA32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 21F801F388
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Mon, Apr 07, 2025 at 06:36:07PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> These are mostly to rename exported functions so that they have a 'btrfs_'
> prefix and follow coding style, to avoid potential clashes in the future
> with other kernel functions defined elsewhere outside btrfs. As more
> functions are added to extent-io-tree.h, there's a tendency to follow the
> existing style and not add a 'btrfs_' prefix for consistency with the
> other function names, so as time passes we get more exported functions
> that don't follow the coding style by missing a 'btrfs_' prefix. I'm in
> the process of adding another new exported function to extent-io-tree.h
> and found my self unconfortable adding a 'btrfs_' prefix to it while the
> other exported functions don't have one.
> 
> I tried to split the rename into several and more reasonably sized patches
> to make it easier to review and also because a few do a bit more than
> simply renaming, but with notes in the change logs.
> 
> Filipe Manana (16):
>   btrfs: remove extent_io_tree_to_inode() and is_inode_io_tree()
>   btrfs: add btrfs prefix to trace events for extent state alloc and free
>   btrfs: add btrfs prefix to main lock, try lock and unlock extent functions
>   btrfs: add btrfs prefix to dio lock and unlock extent functions
>   btrfs: rename __lock_extent() and __try_lock_extent()
>   btrfs: rename the functions to clear bits for an extent range
>   btrfs: rename set_extent_bit() to include a btrfs prefix
>   btrfs: rename the functions to search for bits in extent ranges
>   btrfs: rename the functions to get inode and fs_info from an extent io tree
>   btrfs: directly grab inode at __btrfs_debug_check_extent_io_range()
>   btrfs: rename the functions to init and release an extent io tree
>   btrfs: rename the functions to count, test and get bit ranges in io trees
>   btrfs: rename free_extent_state() to include a btrfs prefix
>   btrfs: rename remaining exported functions from extent-io-tree.h
>   btrfs: remove double underscore prefix from __set_extent_bit()
>   btrfs: make btrfs_find_contiguous_extent_bit() return bool instead of int

Reviewed-by: David Sterba <dsterba@suse.com>

Fairbly big number of changes so stable backports may not apply cleanly,
but it's a change that should have been done long time ago.

