Return-Path: <linux-btrfs+bounces-10752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFB3A02C41
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B7C7A2974
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6DB1DE89E;
	Mon,  6 Jan 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e2wyKqN+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmZKXZiL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e2wyKqN+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmZKXZiL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F081DDC2C
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178712; cv=none; b=a3/MroEwSJPm7EzDtHyAJIlX0Xs6UF7KJZfz4bcmUVsPWvpZast8FUvHnEpCV7dM3mCKSZ1uhIBE590dAa5oHw/7OpjLuw5yuFIzGimSzbgTmAn8IVEYfSU+3JcawdmGXPY2F8ZADbvjRXnkMYN6Ntp7RO3qp/MAf/bHpSdgYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178712; c=relaxed/simple;
	bh=xX1hLqTFOFm1ucyQJmwgmHh8WrxuNxy1XVhVIQmp0Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXll4Z5BWxQFDz4TcA69jIIfqpFtosRS3XTP1OONZcg6a00/clU18kB8PbzC6eqw3y0/ORJuZsYScWBJKW1En7VgDEFf21PL+jk235HDHGCmxxxMXccv3X3+6DsgIEHq9+tBw0TWFHCvKP0wwYWt+HtyG4u+jgzKtf2y2vVQJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e2wyKqN+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmZKXZiL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e2wyKqN+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmZKXZiL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6522721167;
	Mon,  6 Jan 2025 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736178708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++RAcB8XWQfyOMg9u7XmuUAEOWdAIxo8WSagqmgLcl0=;
	b=e2wyKqN+fQWO4f2nAwfJl0ZfOvowgJNJQdAUEfpVQAWSGTrqevN+lp8gdyOcBTiSRvXMNI
	8LR5FstoNaz8WuMJAcsgmUUzlj67JYOkmFXqvncPFw72W2KfotZc6NKugfh2HGEQXUkInl
	pYecH3vvrgdYsLel7HZh9jDnjMSIEKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736178708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++RAcB8XWQfyOMg9u7XmuUAEOWdAIxo8WSagqmgLcl0=;
	b=hmZKXZiLd39zFQBnXobtZWfMYVtN0rWxX9eIFntx4s1B7fVfdA7iwtDYNgiXJIU+UFnUqW
	nM43aclMzkvQ3FAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e2wyKqN+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hmZKXZiL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736178708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++RAcB8XWQfyOMg9u7XmuUAEOWdAIxo8WSagqmgLcl0=;
	b=e2wyKqN+fQWO4f2nAwfJl0ZfOvowgJNJQdAUEfpVQAWSGTrqevN+lp8gdyOcBTiSRvXMNI
	8LR5FstoNaz8WuMJAcsgmUUzlj67JYOkmFXqvncPFw72W2KfotZc6NKugfh2HGEQXUkInl
	pYecH3vvrgdYsLel7HZh9jDnjMSIEKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736178708;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++RAcB8XWQfyOMg9u7XmuUAEOWdAIxo8WSagqmgLcl0=;
	b=hmZKXZiLd39zFQBnXobtZWfMYVtN0rWxX9eIFntx4s1B7fVfdA7iwtDYNgiXJIU+UFnUqW
	nM43aclMzkvQ3FAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EFF8139AB;
	Mon,  6 Jan 2025 15:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ejsSExT8e2cnUAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Jan 2025 15:51:48 +0000
Date: Mon, 6 Jan 2025 16:51:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: validate system chunk array at
 btrfs_validate_super()
Message-ID: <20250106155146.GC31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3c0c676a4618b0f8a933847afa9cb3410fe30628.1734755681.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c0c676a4618b0f8a933847afa9cb3410fe30628.1734755681.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6522721167
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
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, Dec 21, 2024 at 04:15:19PM +1030, Qu Wenruo wrote:
> Currently btrfs_validate_super() only does a very basic check on the
> array chunk size (not too large than the available space, but not too
> small to contain no chunk).
> 
> The more comprehensive checks (the regular chunk checks and size check
> inside the system chunk array) is all done inside
> btrfs_read_sys_array().
> 
> It's not a big deal, but it also means we do not do any validation on
> the system chunk array at super block writeback time either.
> 
> So this patch does the following modification to concetrate the system
> chunk array check into btrfs_validate_super():
> 
> - Make chunk_err() helper to accept stack chunk pointer
>   If @leaf parameter is NULL, then the @chunk pointer will be a pointer
>   to the chunk item, other than the offset inside the leaf.
> 
>   And since @leaf can be NULL, add a new @fs_info parameter for that
>   case.
> 
> - Make btrfs_chekc_chunk_valid() to handle stack chunk pointer
>   The same as chunk_err(), a new @fs_info parameter, and if @leaf is
>   NULL, then @chunk will be a pointer to a stack chunk.
> 
>   If @chunk is NULL, then all needed btrfs_chunk members will be read
>   using the stack helper instead of the leaf helper.
>   This means we need to read out all the needed member at the beginning
>   of the function.
> 
>   Furthermore, at super block read time, fs_info->sectorsize is not yet
>   initialized, we need one extra @sectorsize parameter to grab the
>   correct sectorsize.
> 
> - Introduce a helper validate_sys_chunk_array()
>   * Validate the disk key
>   * Validate the size before we access the full chunk items.
>   * Do the full chunk item validation
> 
> - Call validate_sys_chunk_array() at btrfs_validate_super()
> 
> - Simplify the checks inside btrfs_read_sys_array()
>   Now the checks will be converted to an ASSERT().
> 
> - Simplify the checks inside read_one_chunk()
>   Now all chunk items inside system chunk array and chunk tree is
>   verified, there is no need to verify it again inside read_one_chunk().
> 
> This change has the following advantages:
> 
> - More comprehensive checks at write time
>   And unlike the sys_chunk_array read routine, this time we do not need
>   to allocate a dummy extent buffer to do the check.
>   All the checks done here requires no new memory allocation.

Nice that you found a way around the allocation.

> 
> - Slightly improved readablity when iterating the system chunk array
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:

I've fixed some typos and moved the patch from misc-next to for-next,
thanks.

