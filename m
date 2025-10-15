Return-Path: <linux-btrfs+bounces-17849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A3BDFB72
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 18:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF04E39F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 16:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B287338F24;
	Wed, 15 Oct 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ndSlJwvX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Or+ThANT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HKvycH+p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i7EX8w9c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2843375D3
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546600; cv=none; b=FOkZrgVRd4j35LYTdy9hak2BWOdGNfZMnOp0BBd0POFLZjnr2hgVvI5bptP1lwvdYnTUJKkoDgdz2SEx2fQw10Zjc180/Bcbz5c2MA+3IVCxQw0PTa7yvRsSRVSXhU55EqhRmwLEKhsS9ELEORfPXED2nTZdN39hOXs3E77ahcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546600; c=relaxed/simple;
	bh=Tvb8NzW5FA6gsz+ynZvmSwKolyvBuACusQYpduUL/e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHccGj46Gsq1wVoJhfO3LysEkMQcngSWqHm+QovdffshjnTp3Nf+qBsbCv+qbAhnErnl6ZGTxcF5OtAzooJLVp7Z4uyz8mTOa4YBnwwfIfYH3oMDo52mu938u9KGciIVY9EJuzHAXp2lgTtPu4ywSj7GaXGuuNfx5wftAB6Fmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ndSlJwvX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Or+ThANT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HKvycH+p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i7EX8w9c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 072F75BE14;
	Wed, 15 Oct 2025 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760546597;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6j8T1FokYqjW+441LVC0vUPj+cUFRigyX6Pnvob8J9M=;
	b=ndSlJwvXXSTStcDzF2l1OuT3a+W/nZF8TfIg9ai0dfgc95eywb+QwsFqE17U1ciOG/LNbr
	Xbe99w0j5EIE0KvNe2IWTVdu5jKoFzD/RoKCdN+/iW+nS8oU7BJYBqOkhJTFAgwImdgO/C
	VvOZP9rHC5AfeV9qWOIArR2m3oGNUZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760546597;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6j8T1FokYqjW+441LVC0vUPj+cUFRigyX6Pnvob8J9M=;
	b=Or+ThANTi1iQVlAoWu8yjh9Oh9c6YI640H4m23OB2y5cdhYqtCD+8fx/WY0LTpkuouGv3W
	8Zas8gVbiwX1Z1Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HKvycH+p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i7EX8w9c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760546596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6j8T1FokYqjW+441LVC0vUPj+cUFRigyX6Pnvob8J9M=;
	b=HKvycH+pnsV+PszGyItkuz0cvCLVbW84UOA54TaQXF9enc3LwZIAXyinOfjusIPQZ5zC8o
	RDJl7X4CmwSmtpYvB4VcBdCxVxBgu/9U3SFikfryEgMrB6xl2/Y3GfFkw/XqjB3OjrQGuD
	LXdGWv04kljDL5t3SjPoLM6UTCzy3Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760546596;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6j8T1FokYqjW+441LVC0vUPj+cUFRigyX6Pnvob8J9M=;
	b=i7EX8w9c7uaxqcHQnJ3dtA6JKiU1X3581S5/e08HyL+ZsSW7ariJ4VFxRlkZY6vCtOf904
	r2DVnbwYgrmagDBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E473113A29;
	Wed, 15 Oct 2025 16:43:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sU+ZNyPP72hDDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 Oct 2025 16:43:15 +0000
Date: Wed, 15 Oct 2025 18:43:14 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: add and use helper macros to print keys
Message-ID: <20251015164314.GF13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1760530704.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760530704.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 072F75BE14
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Wed, Oct 15, 2025 at 01:21:19PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Details in the change logs.
> 
> Filipe Manana (2):
>   btrfs: add macros to facilitate printing of keys
>   btrfs: use the key format macros when printing keys

Reviewed-by: David Sterba <dsterba@suse.com>

Nice. I was thinking about naming it only KEY_FMT, as we have CSUM_FMT
without the prefix but BTRFS_KEY_FMT is more clear, so maybe we should
use it in csum format as well for consistency.

