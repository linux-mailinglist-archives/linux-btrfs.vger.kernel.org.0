Return-Path: <linux-btrfs+bounces-11772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B444A44008
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 14:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D88B7A3B8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E62268FE2;
	Tue, 25 Feb 2025 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JdosYAm5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ZcQGgch";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JdosYAm5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ZcQGgch"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D508203709
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488678; cv=none; b=t1ddWQDBKzCvKotseBXkim9xOY3idG1ZqWbfvtqBiRQD//8HmYIf3mMjIvGrIFc7HaShPiVh3zXTSB5/kCwTfvvEM/EhczZVoGnA4PtcNbHSbF7EV96ycIJ3ZQ6rcF4PDY9/cJb8WhU+dhzSoo7RDyxbIIt3vh+ynM502bL1X68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488678; c=relaxed/simple;
	bh=yHMq7eW7G/rKcE3Vm+6VTDhQHJ4x35r9QjL7Y36TInw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAzVsJR025clV5R2gQfgXd6gaAiKEcKQaF2HUrHL5vPmCUqWp72nkrpet4vgmnb7UZeaAgaR9y1rKnJlUNua1rfBblMMACGhA5m2Qwlr7DKe87hd78R4/HiWYgQN5UjNDbTwpXA8LmwmfMaolaN5+fCc5Czm5XSgZiEupVuCPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JdosYAm5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ZcQGgch; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JdosYAm5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ZcQGgch; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CC0B21195;
	Tue, 25 Feb 2025 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740488674;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UTxF7CfqJJavXtO1WWvUnUBkM/2lzPK47avtmwzwvc=;
	b=JdosYAm5DR5rTD//4+wb56jtH90YRYbPurCG03pKYrXGFpA9Qkic5KXQi/inEBDbbT5uA6
	++EcYWsr+hSy9XZqODdNldjR7ur6Eac7rw/N3uJDazrXJky119LzU5RvgFiAKJg/vPqi15
	GF3lkQy4VozGBXXatEznigjnyGm0jX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740488674;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UTxF7CfqJJavXtO1WWvUnUBkM/2lzPK47avtmwzwvc=;
	b=4ZcQGgchk3USGEaNsaYnzC7/lJ52GcaNLyhXXzXvRrZFrhbCxGFEetI/1Pz7FeGqpzIJGr
	zPb9GtyAbx9+orBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JdosYAm5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4ZcQGgch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740488674;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UTxF7CfqJJavXtO1WWvUnUBkM/2lzPK47avtmwzwvc=;
	b=JdosYAm5DR5rTD//4+wb56jtH90YRYbPurCG03pKYrXGFpA9Qkic5KXQi/inEBDbbT5uA6
	++EcYWsr+hSy9XZqODdNldjR7ur6Eac7rw/N3uJDazrXJky119LzU5RvgFiAKJg/vPqi15
	GF3lkQy4VozGBXXatEznigjnyGm0jX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740488674;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0UTxF7CfqJJavXtO1WWvUnUBkM/2lzPK47avtmwzwvc=;
	b=4ZcQGgchk3USGEaNsaYnzC7/lJ52GcaNLyhXXzXvRrZFrhbCxGFEetI/1Pz7FeGqpzIJGr
	zPb9GtyAbx9+orBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BD2E13332;
	Tue, 25 Feb 2025 13:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id slDwIeK/vWekWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Feb 2025 13:04:34 +0000
Date: Tue, 25 Feb 2025 14:04:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btrfs: make btrfs_do_readpage() to do
 block-by-block read
Message-ID: <20250225130433.GP5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1739328504.git.wqu@suse.com>
 <14cfa9f204c6f2f840b87102f59e8343559f03d6.1739328504.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14cfa9f204c6f2f840b87102f59e8343559f03d6.1739328504.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9CC0B21195
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.com:email,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 12, 2025 at 01:22:46PM +1030, Qu Wenruo wrote:
> Currently if a btrfs has block size (the older sector size) < page size,
> btrfs_do_readpage() will handle the range extent by extent, this is good
> for performance as it doesn't need to re-lookup the same extent map again
> and again.
> (Although __get_extent_map() already does extra cached em check, thus

Minor thing, __get_extent_map has been renamed to get_extent_map.

> the optimization is not that obvious)
> 
> This is totally fine and is a valid optimization, but it has an
> assumption that, there is no partial uptodate range in the page.
> 
> Meanwhile there is an incoming feature, requiring btrfs to skip the full
> page read if a buffered write range covers a full block but not a full
> page.
> 
> In that case, we can have a page that is partially uptodate, and the
> current per-extent lookup can not handle such case.
> 
> So here we change btrfs_do_readpage() to do block-by-block read, this
> simplifies the following things:
> 
> - Remove the need for @iosize variable
>   Because we just use sectorsize as our increment.
> 
> - Remove @pg_offset, and calculate it inside the loop when needed
>   It's just offset_in_folio().
> 
> - Use a for() loop instead of a while() loop
> 
> This will slightly reduce the read performance for
> block size < page size cases, but for the future where we can skip a
> full page read for a lot of cases, it should still be worthy.
> 
> For block size == page size, this brings no performance change.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

