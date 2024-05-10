Return-Path: <linux-btrfs+bounces-4891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830348C25F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 15:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE501F26D8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108412C491;
	Fri, 10 May 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oYtwbo3s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J7eSVpt7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oYtwbo3s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J7eSVpt7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1703481C0;
	Fri, 10 May 2024 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348507; cv=none; b=Cdddrupj+qAIqikotAAvm/xXi/3Rr0R8SZ2YsvJVsV3UfP4Vd/qB2QTJ1p5WvRHFphDLBR8CHKyGPDqwhZtaTNw505Rz27wxJi5sXtv5zbgWH8eq2Glh3qax7wGPjnizS9Zg5dQsBH1PnNHDBsKpX4oIbUtWkEav3/J4/wzI87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348507; c=relaxed/simple;
	bh=2TAjCWP9elY765mx4vZnGpxRVWJAHosIdyfnQgz0xmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVI+1qZ6waxC0YPqBoJZQ+s5sOnIE+Xh5tx9wvz02cFQfNiwJ911ZHD1OlzhvvLOdTG7p8wqlOOh9zDkS8srT5ZpJMTrwE1unbwoaQ4t6s0VBMvXOOfi64nyNiX7xzQ9vSoy6Y2UYiRKkRg3fQzXo5LuG1iMld/dsaV1vzUdiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oYtwbo3s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J7eSVpt7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oYtwbo3s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J7eSVpt7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0F023EEFC;
	Fri, 10 May 2024 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715348503;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BFeztLl63ZY6qsImDaMwSB0wfTCQoHEo2nNkjtDtVA=;
	b=oYtwbo3sbzyym+0R6HNK7lzqEaTUv0TePjJ5SeH4HvFRHCF4QQ7PMdECRwuypGYHuvpp9W
	mjBtTOLO/rvm5dYNCeOWr/1w58ysVWiAwPblGFDumpCYcn8URC2g3N8AQmdciRTSI6cfkm
	EXbw25rMUjfu5tTwTOoDg9lmasZCvOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715348503;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BFeztLl63ZY6qsImDaMwSB0wfTCQoHEo2nNkjtDtVA=;
	b=J7eSVpt797gdGIGU81F9Rh/tsjxDO3HY+FjTc6GuXpQq/jIm0tp4Fq57EA/RgiOqj+u6VL
	sX9Lp4y0y8f4sWDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oYtwbo3s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=J7eSVpt7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715348503;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BFeztLl63ZY6qsImDaMwSB0wfTCQoHEo2nNkjtDtVA=;
	b=oYtwbo3sbzyym+0R6HNK7lzqEaTUv0TePjJ5SeH4HvFRHCF4QQ7PMdECRwuypGYHuvpp9W
	mjBtTOLO/rvm5dYNCeOWr/1w58ysVWiAwPblGFDumpCYcn8URC2g3N8AQmdciRTSI6cfkm
	EXbw25rMUjfu5tTwTOoDg9lmasZCvOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715348503;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BFeztLl63ZY6qsImDaMwSB0wfTCQoHEo2nNkjtDtVA=;
	b=J7eSVpt797gdGIGU81F9Rh/tsjxDO3HY+FjTc6GuXpQq/jIm0tp4Fq57EA/RgiOqj+u6VL
	sX9Lp4y0y8f4sWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83838139AA;
	Fri, 10 May 2024 13:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sY3oHxckPmb1CQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 10 May 2024 13:41:43 +0000
Date: Fri, 10 May 2024 15:41:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 7/9] btrfs_get_bdev_and_sb(): call set_blocksize()
 only for exclusive opens
Message-ID: <20240510134140.GT13977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240503031833.GU2118490@ZenIV>
 <20240503032329.2392931-1-viro@zeniv.linux.org.uk>
 <20240503032329.2392931-7-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503032329.2392931-7-viro@zeniv.linux.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.03 / 50.00];
	BAYES_HAM(-2.82)[99.24%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B0F023EEFC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.03

On Fri, May 03, 2024 at 04:23:27AM +0100, Al Viro wrote:
> btrfs_get_bdev_and_sb() has two callers - btrfs_open_one_device(),
> which asks for open to be exclusive and btrfs_get_dev_args_from_path(),
> which doesn't.  Currently it does set_blocksize() in all cases.
> 
> I'm rather dubious about the need to do set_blocksize() anywhere in btrfs,
> to be honest - there's some access to page cache of underlying block
> devices in there, but it's nowhere near the hot paths, AFAICT.
> 
> In any case, btrfs_get_dev_args_from_path() only needs to read
> the on-disk superblock and copy several fields out of it; all
> callers are only interested in devices that are already opened
> and brought into per-filesystem set, so setting the block size
> is redundant for those and actively harmful if we are given
> a pathname of unrelated device.
> 
> So we only need btrfs_get_bdev_and_sb() to call set_blocksize()
> when it's asked to open exclusive.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David Sterba <dsterba@suse.com>

