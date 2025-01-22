Return-Path: <linux-btrfs+bounces-11044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 801DCA1951F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 16:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E5F165FC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37F2214227;
	Wed, 22 Jan 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YGIBtb+Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yJQQBxHK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YGIBtb+Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yJQQBxHK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C4212FA6
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559503; cv=none; b=tkImmKMIz0cMw6YhAos8txUEdcvljfO9g0pqgLM3C/hr5dpdu/7GABrJ8zjNKUMg4MqwYDYhFEvFhnu3wvWDJLfYMYGd9Mz1It3F2oYpOk79fPWoWgYEDTIh9lYiJmDGXA9yOA877GqXjANg2h9UxEJ8v1+3j5FBwUBd3QR0x6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559503; c=relaxed/simple;
	bh=OSZi3QHh1sJnGbY/bRVq9MV3vVQ0CNq/VWkMKyFHpaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRydkCzbeCBUXorbbQIsGswETm6JV3knR966xfJasXGx4kuBZGJHy7NTvtrsKUTRo8SVD8YIITaxwZ7Zdiu+qnWnnD8XzBcbHticHzuSCxEprhd5/6vU7p8W4MLG1Moj6vH6QUE6EfPeT97pV8I3gy1f/8aH3BFspJ3l3E8tf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YGIBtb+Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yJQQBxHK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YGIBtb+Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yJQQBxHK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6225C21111;
	Wed, 22 Jan 2025 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737559499;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7O9gFSJZNXiAcjVuXuknzWpCciK+MnRDAmdJ09uoxjo=;
	b=YGIBtb+Ye8mw1GFkw0B/dj1gXkjalPZRKY3FKrhACPT25PA3VwDuRe/ZNdjZB1Yo4IIbOe
	Tq7KXbxY+D0NVmOg9lzxZWw1NfHAS0APFb9Jt2ycOnI3eQSDiMdA7JVQPys3wF5ZIdotlt
	5vpGJr5B4rlbwFn1DDmzIYqUvS078BE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737559499;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7O9gFSJZNXiAcjVuXuknzWpCciK+MnRDAmdJ09uoxjo=;
	b=yJQQBxHKnL6pa9DXMqlByNnXFENYCApYefVsBDq6wLUB9V0SNwmSupEgXAkHGmqqEyndUt
	3VUsPGEUuO0mGZAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YGIBtb+Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yJQQBxHK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737559499;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7O9gFSJZNXiAcjVuXuknzWpCciK+MnRDAmdJ09uoxjo=;
	b=YGIBtb+Ye8mw1GFkw0B/dj1gXkjalPZRKY3FKrhACPT25PA3VwDuRe/ZNdjZB1Yo4IIbOe
	Tq7KXbxY+D0NVmOg9lzxZWw1NfHAS0APFb9Jt2ycOnI3eQSDiMdA7JVQPys3wF5ZIdotlt
	5vpGJr5B4rlbwFn1DDmzIYqUvS078BE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737559499;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7O9gFSJZNXiAcjVuXuknzWpCciK+MnRDAmdJ09uoxjo=;
	b=yJQQBxHKnL6pa9DXMqlByNnXFENYCApYefVsBDq6wLUB9V0SNwmSupEgXAkHGmqqEyndUt
	3VUsPGEUuO0mGZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 387261397D;
	Wed, 22 Jan 2025 15:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VmaHDcsNkWfLdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Jan 2025 15:24:59 +0000
Date: Wed, 22 Jan 2025 16:24:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Fix two misuses of folio_shift()
Message-ID: <20250122152450.GJ5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250121054054.4008049-1-willy@infradead.org>
 <20250121054054.4008049-2-willy@infradead.org>
 <33fa9947-cead-4f38-a61a-39b053f37a03@suse.com>
 <20250121161011.GG5777@suse.cz>
 <Z4_gmbY6_sTVAeIL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4_gmbY6_sTVAeIL@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6225C21111
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Jan 21, 2025 at 05:59:53PM +0000, Matthew Wilcox wrote:
> > > > +			if (folio_contains(folio, i_size >> PAGE_SHIFT) &&
> > > 
> > > Although folio_contains() is already a pretty good improvement, can we 
> > > have a bytenr/i_sized based solution for fs usages?
> > 
> > Good point, something like folio_contains_offset() that does the correct
> > shifts.
> 
> I'd call it folio_contains_pos(), but I'm not sure there's a lot of
> users.  We've got a lot of filesystems converted now, and btrfs is the
> first one to want something like that.  I've had a look through iomap
> and some other filesystems, and I can't see anywhere else that would use
> folio_contains_pos().

Ok then, we can live with that, but please keep it in mind for future
folio API updates. Thanks.

