Return-Path: <linux-btrfs+bounces-14430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80984ACCE57
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 22:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7FD3A4AE7
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029B2192E1;
	Tue,  3 Jun 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L68/gwOF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yIHiUwL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L68/gwOF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yIHiUwL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4941474B8
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983685; cv=none; b=rsgOCy45RblOzrVsBm2i240vqxU+PwFHpx/sQ1+8vqpc7Zt/MtfjpsQ0m5qaAl4GKvJjmfqBjCw058yhDKAJe8yxsqb/23Vo9IeQy7kpNbQT3VLrnQzSchGeO/+Acd94vg/Xz9yElQAJc4fY5l2lpD7XjuNi9gIUM3FoleimIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983685; c=relaxed/simple;
	bh=9XKnXpZJM92MufoQvhn4s5PoUJss4HL5tquQtaUE/Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd75J7z3fx78CM4lm9OChbA3iep5R2HKamhb330320/2AKo5X3QvmIo1SLFCo75g7Au0WJVwPE96sG2sOyZ2tF5NWh3LOQMXBP02CnT+X4JN0xW7GsPSqQMVGy3jWjK1pKkdo5on0WbfNOV2hUVFLwvRm4m3USAAI6dwEelynBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L68/gwOF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yIHiUwL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L68/gwOF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yIHiUwL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2481F1F443;
	Tue,  3 Jun 2025 20:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748983681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hA3zS8QzzqCPa6wudtZVXm1mpuSAI7IHPYT3k0Q6yOc=;
	b=L68/gwOFhNmCnCK7GH9wgI7zh0cZ0H8VAH3yP30mLePtmkAqB04FmO0fWRivYfHm56LiFq
	wTRPG+ozuJ4wY7Cg3ITjgALAnddbPO0PX82CTWmoE440hYwr1NEVe2o5ux2hVcQYqh5hKs
	CX3nG9uM8u8tIHtuNpdl9y9qaQ/x1FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748983681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hA3zS8QzzqCPa6wudtZVXm1mpuSAI7IHPYT3k0Q6yOc=;
	b=2yIHiUwL6aVGrOfm6C5KYBRebcnypf5SxJd1gzP/gAHxD5uguDN2FG6pikgHsHKzjUC1+M
	+scJlq51g4nrHzCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="L68/gwOF";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2yIHiUwL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748983681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hA3zS8QzzqCPa6wudtZVXm1mpuSAI7IHPYT3k0Q6yOc=;
	b=L68/gwOFhNmCnCK7GH9wgI7zh0cZ0H8VAH3yP30mLePtmkAqB04FmO0fWRivYfHm56LiFq
	wTRPG+ozuJ4wY7Cg3ITjgALAnddbPO0PX82CTWmoE440hYwr1NEVe2o5ux2hVcQYqh5hKs
	CX3nG9uM8u8tIHtuNpdl9y9qaQ/x1FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748983681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hA3zS8QzzqCPa6wudtZVXm1mpuSAI7IHPYT3k0Q6yOc=;
	b=2yIHiUwL6aVGrOfm6C5KYBRebcnypf5SxJd1gzP/gAHxD5uguDN2FG6pikgHsHKzjUC1+M
	+scJlq51g4nrHzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11D7D13A1D;
	Tue,  3 Jun 2025 20:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bZYnBIFfP2hcGAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Jun 2025 20:48:01 +0000
Date: Tue, 3 Jun 2025 22:47:51 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix double unlock of buffer_tree xarray when
 releasing subpage eb
Message-ID: <20250603204751.GP4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0ed0d97779576c626a953c5d2ce23ede647e160a.1748976868.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed0d97779576c626a953c5d2ce23ede647e160a.1748976868.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2481F1F443
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jun 03, 2025 at 07:56:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we break out of the loop because an extent buffer doesn't have the bit
> EXTENT_BUFFER_TREE_REF set, we end up unlocking the xarray twice, once
> before we tested for the bit and break out of the loop, and once again
> after the loop.
> 
> Fix this by testing the bit and exiting before unlocking the xarray.
> The time spent testing the bit is negligible and it's not worth trying
> to do that outside the critical section delimited by the xarray lock due
> to the code complexity required to avoid it (like using a local boolean
> variable to track whether the xarray is locked or not). The xarray unlock
> only needs to be done before calling release_extent_buffer(), as that
> needs to lock the xarray (through xa_cmpxchg_irq()) and does a more
> significant amount of work.
> 
> Fixes: 19d7f65f032f ("btrfs: convert the buffer_radix to an xarray")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-btrfs/aDRNDU0GM1_D4Xnw@stanley.mountain/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

Also now the critical sections of xa_lock and eb->refs_lock are properly
nested.

