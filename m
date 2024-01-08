Return-Path: <linux-btrfs+bounces-1310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E111827715
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 19:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E051C20F0A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jan 2024 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060E54BEA;
	Mon,  8 Jan 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B5JHaQ9H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/7eVSimo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/nMrzym";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GG9vkmle"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DDD54BC0
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jan 2024 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38B5C21A44;
	Mon,  8 Jan 2024 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704737494;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlMbv3fnW8LLh4NJ35a5rDa0mr0N1R1gN6luzCqxR9k=;
	b=B5JHaQ9HmDsEoj/c9Y91hElEslUpKKxjKl2l6w6+t75HBR65GRKSgJvFUo1nwKDYrtC7U8
	Cjpc1dvuiwIMl9e5FldPTGi6dOTPqi4RL39mQCtHYwW14UvlZVorDJ56fcInjrtySOECV3
	9EDx/yDUQvsqZfHO/KCPgWS/NSsgM7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704737494;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlMbv3fnW8LLh4NJ35a5rDa0mr0N1R1gN6luzCqxR9k=;
	b=/7eVSimoVRaWWI3XWcZ5h7bojeOHYrDVFtV4Qy33vp1vbkvIBSsTq3caDwNed/04TYvTWJ
	uMFMe0S3w5tFWYCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704737493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlMbv3fnW8LLh4NJ35a5rDa0mr0N1R1gN6luzCqxR9k=;
	b=n/nMrzymVUjF8Duj1mP/R/2NSA5Ih+W9dp0JMxjxTGTuMH//uIRuIvSOoPSfQwNpDzOh3N
	tpXtUqjb5NKrQuK4390FmDP8bt8Ga4/1ofnw+luVD1+nzgncB53JqgW7+KNmLopfTPXI7i
	NBchxAmXIfDujOLo7xXMXpylGSYmgpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704737493;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlMbv3fnW8LLh4NJ35a5rDa0mr0N1R1gN6luzCqxR9k=;
	b=GG9vkmlejXkHOnU7hGjdFXKzPaD+KxsrfKmyiZrT9+Qw3NY7OG1LDZuXg6GzLq9UwP0dOy
	niBCumnvpVzonBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F219713686;
	Mon,  8 Jan 2024 18:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5y/rONQ6nGXOWQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Jan 2024 18:11:32 +0000
Date: Mon, 8 Jan 2024 19:11:18 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove the pg_offset parameter from
 btrfs_get_extent()
Message-ID: <20240108181118.GD28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b9e7e1925514a545c91f7e67cace5feda37fc82e.1704684018.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e7e1925514a545c91f7e67cace5feda37fc82e.1704684018.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[42.23%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Mon, Jan 08, 2024 at 01:50:20PM +1030, Qu Wenruo wrote:
> The parameter @pg_offset of btrfs_get_extent() is only utilized for
> inlined extent, and we already have an ASSERT() and tree-checker, to
> make sure we can only get inline extent at file offset 0.
> 
> Any invalid inline extent with non-zero file offset would be rejected by
> tree-checker in the first place.
> 
> Thus the @pg_offset parameter is not really necessary, just remove it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -984,7 +984,7 @@ void btrfs_clear_data_folio_managed(struct folio *folio)
>  }
>  
>  static struct extent_map *
> -__get_extent_map(struct inode *inode, struct page *page, size_t pg_offset,
> +__get_extent_map(struct inode *inode, struct page *page,

In such cases also please try to fix the coding style, so the type and
name is on the same line and with the removed pg_offset it does not
overflow 80 columns (while about 85 would be also fine).

There are some other oportunities to glue lines. What I do is to open
the file in vimdiff (using fugitive's command :GDiff HEAD^ and with
colorcolumn=81 it's clear what can be updated.

