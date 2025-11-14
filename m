Return-Path: <linux-btrfs+bounces-18991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8BFC5D25A
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 13:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8966B34EF71
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022711B87EB;
	Fri, 14 Nov 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t6IMPhNm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmulVlnz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O/nAu01r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GmfOFEJv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B5147C9B
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763123613; cv=none; b=tygcN4cRNejnauGrWNjfZl8ahRSf56TKpoc5iU8tqPh45EWI/vNPYVii6jPpbhl1kpL4jrRi8HH8zp3K0UZQt3uDhN9WZE8+iI3L9d0+iBYNGeabZclhZ3QNVDp/rlzdnsNsKDdhf2vzyC2uURNMyxDeIgpmoum6mT975ETE3wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763123613; c=relaxed/simple;
	bh=zpar4Kbq4d3tXzlXtpYOyIvuI9LqdYIBWuhsu7wd3v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIawXjK067XzX2aaJOmfRlG+9ljiiO3pDYLAwdf/8HlsI+RZ7U3PIL5C6QbBn/FNaKxHxX5zarhJCZyW4z2w3n8n1A/g89UJ+iAeTQzmM9MXh+L1sOkexpqWlkmFlcWXw/EsF4HukS2cn+yx2aY6Ztqez8IpNiSnSFEcZDxpjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t6IMPhNm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmulVlnz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O/nAu01r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GmfOFEJv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEC8821229;
	Fri, 14 Nov 2025 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763123604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLxO230d8kQmbFLEHVEtexhf7vtDP7iIfD/XAtjf5dg=;
	b=t6IMPhNmnAchPE8FzSMlZHWTsvR1KfD8GQY14xkJn/trpfx1L737iDp76FDHygBQNrDfoc
	eGmYUpzfSINN+bJ1LlEiClvyNJGIGs0osWCHFjDh8J+Mp5TxldLcA0utTqgDYaPBexVakF
	8V5rVDnRd0aQSoqWm87KKK5juiAEm+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763123604;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLxO230d8kQmbFLEHVEtexhf7vtDP7iIfD/XAtjf5dg=;
	b=HmulVlnznVTqnIsthxEdsVvs2mAXDjw9GEeRiY1Kcw8DQUj6L7P/s3+fN4EwhT+J7UWCDW
	DoOEdVBx4PEOSgCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="O/nAu01r";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GmfOFEJv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763123602;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLxO230d8kQmbFLEHVEtexhf7vtDP7iIfD/XAtjf5dg=;
	b=O/nAu01rQh9BFbjDW/ctAIuX/ieBI+Q59ovpNL1cV7HPuB7ZAXr0/oBOMkQjfmB0GjzDnm
	DCsPt93DQ5AuS09ZG404vuKNB0NinabuYlMqxuVMaRORGehvNLJMSxPuKk11Q9OqwZgwQ9
	BXP2UXfzZuXoqwAy5fXCtU8L57mJTN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763123602;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLxO230d8kQmbFLEHVEtexhf7vtDP7iIfD/XAtjf5dg=;
	b=GmfOFEJv0N6cdoUz3JpPlld4IE3T3cLPSmnU0zzY0FqhFV2KylONUxyEQyI+vtcv6DIVuV
	z0Z6NI1aad4hoxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E00E73EA61;
	Fri, 14 Nov 2025 12:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id up9+NpIhF2lxCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 14 Nov 2025 12:33:22 +0000
Date: Fri, 14 Nov 2025 13:33:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix incomplete parameter rename in
 btrfs_decompress
Message-ID: <20251114123317.GS13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251114075313.1944180-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114075313.1944180-1-zhen.ni@easystack.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EEC8821229
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,easystack.cn:email,twin.jikos.cz:mid]
X-Spam-Score: -4.21

On Fri, Nov 14, 2025 at 03:53:13PM +0800, Zhen Ni wrote:
> Commit 2c25716dcc25 ("btrfs: zlib: fix and simplify the inline extent
> decompression") renamed the 'start_byte' parameter to 'dest_pgoff' in
> the btrfs_decompress(). The remaining 'start_byte' references are
> inconsistent with the actual implementation and may cause confusion for
> developers.
> 
> Ensure consistency between function declaration and implementation.
> 
> Fixes: 2c25716dcc25 ("btrfs: zlib: fix and simplify the inline extent decompression")

The Fixes tak is not necessary for such changes, it's not a functional
fix.

> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>

Added to for-next, thanks.

