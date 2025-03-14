Return-Path: <linux-btrfs+bounces-12284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ED9A616D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92FC166DDA
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96FA20408C;
	Fri, 14 Mar 2025 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TdViZxHx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zu7BZ5Jq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TdViZxHx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zu7BZ5Jq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A418B494
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741971192; cv=none; b=t8u51NgJUlA/uONjCE4orCyfk8qVBFeDIaIb5Vk7pdrP5DICz1rWNPKmbn8ILJ0NZ7zDJl3t7vO7CckNFNLe+VSWD7CdaniM7q0EirCdb6mzQQSwPKnGeBvQmL0U6thAddxMHnOFoAWRrpkF/fJoAFVjXa+8pla2E5ZiepIFc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741971192; c=relaxed/simple;
	bh=yYMcleDLIyNoyH/dQJkmgQhKvBD4FBcsF7B/x4yfsOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD2UTQ1Pavt8X9m25WvcZp4dFqQfJqFbRBS58Y35Mp/+PEXqHIxPuOiEFbQc5ScjDA+RAAmQHQHGJ9sPmB1RjjMm2QK+hYuIR6pbydhllEneebQU0wQPbcci2vc0o1YVDfsimzWrD0w+iZPNRhgBk+Ni7cf9JfF3Reg/3Dh48cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TdViZxHx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zu7BZ5Jq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TdViZxHx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zu7BZ5Jq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 300101F38E;
	Fri, 14 Mar 2025 16:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741971183;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIlo5qeYoCJ3dQTV0mScn5u5VF6+8b3uHg0Md3IXszY=;
	b=TdViZxHxoM31B4JT6o1seHnLLhFQmsqkk8Ym2f1DnPtWJ2BotwT2ovB0/NvEgWO3L23SDQ
	J8bwOjcRvqGpHWjr8VwFM2wTLMWJDA+dT00Rh4VzwQfEwPpvsTEZxypCiTgYCfqdAXxCIq
	vlDNc08pzyDMl41VOMSmlSxoE+5uBd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741971183;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIlo5qeYoCJ3dQTV0mScn5u5VF6+8b3uHg0Md3IXszY=;
	b=Zu7BZ5JqrBTOh8eurK04VmT6qMgYlr4DEbIE7hg4kQsZb8Sds5Pn0RnGKod7GNhj6/m4bA
	8wqDELqfdv/37XDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741971183;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIlo5qeYoCJ3dQTV0mScn5u5VF6+8b3uHg0Md3IXszY=;
	b=TdViZxHxoM31B4JT6o1seHnLLhFQmsqkk8Ym2f1DnPtWJ2BotwT2ovB0/NvEgWO3L23SDQ
	J8bwOjcRvqGpHWjr8VwFM2wTLMWJDA+dT00Rh4VzwQfEwPpvsTEZxypCiTgYCfqdAXxCIq
	vlDNc08pzyDMl41VOMSmlSxoE+5uBd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741971183;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIlo5qeYoCJ3dQTV0mScn5u5VF6+8b3uHg0Md3IXszY=;
	b=Zu7BZ5JqrBTOh8eurK04VmT6qMgYlr4DEbIE7hg4kQsZb8Sds5Pn0RnGKod7GNhj6/m4bA
	8wqDELqfdv/37XDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 129F6132DD;
	Fri, 14 Mar 2025 16:53:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qAHmA+9e1GfrYgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 14 Mar 2025 16:53:03 +0000
Date: Fri, 14 Mar 2025 17:52:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: send: remove the again label inside
 put_file_data()
Message-ID: <20250314165253.GR32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741839616.git.wqu@suse.com>
 <ab9bc3e04e0344667b72edff9127e3fece6c4ab6.1741839616.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9bc3e04e0344667b72edff9127e3fece6c4ab6.1741839616.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Mar 13, 2025 at 02:50:43PM +1030, Qu Wenruo wrote:
> The again label is not really necessary and can be replaced by a simple
> continue.

This should also say why it's needed.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/send.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 0c8c58c4f29b..43c29295f477 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5280,7 +5280,6 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>  		unsigned cur_len = min_t(unsigned, len,
>  					 PAGE_SIZE - pg_offset);
>  
> -again:
>  		folio = filemap_lock_folio(mapping, index);
>  		if (IS_ERR(folio)) {
>  			page_cache_sync_readahead(mapping,
> @@ -5316,7 +5315,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>  			if (folio->mapping != mapping) {
>  				folio_unlock(folio);
>  				folio_put(folio);
> -				goto again;
> +				continue;
>  			}
>  		}
>  
> -- 
> 2.48.1
> 

