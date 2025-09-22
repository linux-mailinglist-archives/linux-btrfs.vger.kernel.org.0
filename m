Return-Path: <linux-btrfs+bounces-17048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE510B8FB45
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 11:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8572A18A012F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC8C2857CF;
	Mon, 22 Sep 2025 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bv7LDSsd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RdUrCZBe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jpppX/P7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8dfe8Whb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0F21D596
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532354; cv=none; b=qNdKOXorZCLUFcXXL5C3ZT/hdymqj06exoSsR0W5NKrNpRUxKldP0ZenBHUfUCvh+8yX+idljae++l+InMCPQUxRSWPIkN+7xwX6pqDOH2aoJw9sdxF+PZREVf79tEx8GBwKKdXoUn1bD39lleYbnmmWQ89FqgdtkEpLaiY0hpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532354; c=relaxed/simple;
	bh=EReA80lWYS6EjCN2xb0rJQyh87D6GuzdkM82sBJw2BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkfq1Jh7798XmgjIj4UKM3SeQxU/Y9VdPOX6nd9irJ7rjzuFyY7js0L/hOEJVI4PsxUO6W1STJv4EPhdIm+optDhwDj5OT9E71vTsWGCdg5wzXjrTwHXsxeuzcqU5ZUMyf+x0d7z0AQkiPRDUw0tr46qbsAl9Y5nGswK4X5nLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bv7LDSsd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RdUrCZBe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jpppX/P7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8dfe8Whb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EF8B1F8C5;
	Mon, 22 Sep 2025 09:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758532351;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxR4NXS3pFYCJ+bFnFX84KKFOLK2Wm00tfkn6wuL0Xg=;
	b=Bv7LDSsdZcP/Q+0lA0kkpdnEPwDJuinL06aQ46wpXOV9kiKKePUPsWp58DU6jM5RfSymnd
	kuTaa3Pinn7Bx0xoaqa3GwlQcE7Is2rFUHB49sERZSNYQn/lP0bZE4hkjNGuGTc+4r3Xic
	UnDsNUzKIIuVEsuUwcwEWtx7CA7S3rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758532351;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxR4NXS3pFYCJ+bFnFX84KKFOLK2Wm00tfkn6wuL0Xg=;
	b=RdUrCZBenA2xOjR63vQkisNyiT/2IkvKQ/g7iDhMT6IV1gW+4fCKmzwuRg9g1gk7BkCLiC
	eWmTktmM3PpoQ5CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758532349;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxR4NXS3pFYCJ+bFnFX84KKFOLK2Wm00tfkn6wuL0Xg=;
	b=jpppX/P7QeSyHKqvj8becvqnA1EDWs1VLAhV6DuEY5zeTTeIaY7qygKd471vyzzuBUuArP
	UgWyOkDTFr07Vz1v4lWwXdFicCPtLJS4S8sdcWPTYjxf1rpledtUfUophXvtwyMhwbEH7+
	u9KybmFxH5weDVmywmYMl4KxGwPueAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758532349;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxR4NXS3pFYCJ+bFnFX84KKFOLK2Wm00tfkn6wuL0Xg=;
	b=8dfe8Whbb7aq/W/nSp14F+T6uCNR7bV235Q/YTXVvim8jw/0rvzVPgukfXuxPKzGEafgFr
	60kINUqCJPbhamCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EDDD1388C;
	Mon, 22 Sep 2025 09:12:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UuFLC/0S0WidIgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 22 Sep 2025 09:12:29 +0000
Date: Mon, 22 Sep 2025 11:12:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/9] btrfs: initial bs > ps support
Message-ID: <20250922091219.GJ5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1758494326.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758494326.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -8.00

On Mon, Sep 22, 2025 at 08:10:42AM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Add a new patch to fix the incorrect @max_bytes of
>   find_lock_delalloc_range()
>   This in fact also fixes a very rare corner case where bs < ps support
>   is also affected.
> 
>   This allows us to re-enable extra large folios (folio > bs) for
>   bs > ps cases.

> Qu Wenruo (9):
>   btrfs: fix the incorrect @max_bytes value for
>     find_lock_delalloc_range()
>   btrfs: prepare compression folio alloc/free for bs > ps cases
>   btrfs: prepare zstd to support bs > ps cases
>   btrfs: prepare lzo to support bs > ps cases
>   btrfs: prepare zlib to support bs > ps cases
>   btrfs: prepare scrub to support bs > ps cases
>   btrfs: fix symbolic link reading when bs > ps
>   btrfs: add extra ASSERT()s to catch unaligned bios
>   btrfs: enable experimental bs > ps support

As this is preparatory stuff and under experimental build feel free to
add it to for-next so we have it in 6.18. Thanks.

