Return-Path: <linux-btrfs+bounces-4623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E8E8B5E0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162081C216B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8C82D62;
	Mon, 29 Apr 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uAF7RKkP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VIhYpg7p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uAF7RKkP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VIhYpg7p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF06B82881;
	Mon, 29 Apr 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405731; cv=none; b=HIPcl8fX251qosQLhWGb84cXqZUgYIgYjCb4b5jw5uGth8IZTwkROsMzzlK8UDSF4TQGbitToUD5S+haa5QXzN8DegjzD9xRPTq/3lC/MHsn6wqfvy7xgFZN6KoZEwfrGp85WkX8ThD5IqY8EKjGWTGuYD5eqzU3T+OAtvJJUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405731; c=relaxed/simple;
	bh=ASshbnZ7jWX9pd5TRw20sJw/ODhlBaUd5nGRF0zn79E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjjca4JIn+4DOnxU1Ua7uZyGSbEhJJspmeiV2i2M9Ves5XKK0A1KQzxeSzIB+lpydgoK4P83+qvxMS2sm7wXayFYtjhzBnLe/0Z4JGApuEMyKV75DLgxSstr6bRqKzJ84F52XTl7m11yS3oZMctSAHwFcf+tb4T+nQ34DTszUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uAF7RKkP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VIhYpg7p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uAF7RKkP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VIhYpg7p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1C441F385;
	Mon, 29 Apr 2024 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714405727;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5jjxmj79tXKXSAAcN8Nbfso//ZJw6xhbqI3xIoi4d8g=;
	b=uAF7RKkPGOj0D3xHR7VEnqomJpZFc0hdwDpPf5gIedfOjoal9NURtXAh6QRlMD01XxgANo
	7DE10zM91B/TippuZMaoeV7MlTec+ERBIcilS6Bx78vLat/gZlaTr8EpQn0bqXp9L5WSzG
	yogYPzcHqDKG4dhXiUZI+PEEwHBrZMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714405727;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5jjxmj79tXKXSAAcN8Nbfso//ZJw6xhbqI3xIoi4d8g=;
	b=VIhYpg7pg12QOnwfMLbMf/cENDzrukJtUHf6DRzfXBqgPDqZWbMdRmxasN2pwTWUa3GN/9
	6QR8LEhVlrXaqrAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uAF7RKkP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VIhYpg7p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714405727;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5jjxmj79tXKXSAAcN8Nbfso//ZJw6xhbqI3xIoi4d8g=;
	b=uAF7RKkPGOj0D3xHR7VEnqomJpZFc0hdwDpPf5gIedfOjoal9NURtXAh6QRlMD01XxgANo
	7DE10zM91B/TippuZMaoeV7MlTec+ERBIcilS6Bx78vLat/gZlaTr8EpQn0bqXp9L5WSzG
	yogYPzcHqDKG4dhXiUZI+PEEwHBrZMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714405727;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5jjxmj79tXKXSAAcN8Nbfso//ZJw6xhbqI3xIoi4d8g=;
	b=VIhYpg7pg12QOnwfMLbMf/cENDzrukJtUHf6DRzfXBqgPDqZWbMdRmxasN2pwTWUa3GN/9
	6QR8LEhVlrXaqrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B6E4139DE;
	Mon, 29 Apr 2024 15:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3AT0HV/BL2bOJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Apr 2024 15:48:47 +0000
Date: Mon, 29 Apr 2024 17:41:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, clm@fb.com,
	dsterba@suse.com, herbert@gondor.apana.org.au,
	linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	qat-linux@intel.com, embg@meta.com, cyan@meta.com,
	brian.will@intel.com, weigang.li@intel.com
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <20240429154129.GD2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429135645.GA3288472@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A1C441F385
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]

On Mon, Apr 29, 2024 at 09:56:45AM -0400, Josef Bacik wrote:
> On Fri, Apr 26, 2024 at 11:54:29AM +0100, Giovanni Cabiddu wrote:
> > From: Weigang Li <weigang.li@intel.com>
> > 
> > Add support for zlib compression and decompression through the acomp
> > APIs.
> > Input pages are added to an sg-list and sent to acomp in one request.
> > Since acomp is asynchronous, the thread is put to sleep and then the CPU
> > is freed up. Once compression is done, the acomp callback is triggered
> > and the thread is woke up.
> > 
> > This patch doesn't change the BTRFS disk format, this means that files
> > compressed by hardware engines can be de-compressed by the zlib software
> > library, and vice versa.
> > 
> > Limitations:
> >   * The implementation tries always to use an acomp even if only
> >     zlib-deflate-scomp is present
> >   * Acomp does not provide a way to support compression levels
> 
> That's a non-starter.  We can't just lie to the user about the compression level
> that is being used.  If the user just does "-o compress=zlib" then you need to
> update btrfs_compress_set_level() to figure out the compression level that acomp
> is going to use and set that appropriately, so we can report to the user what is
> actually being used.
> 
> Additionally if a user specifies a compression level you need to make sure we
> don't do acomp if it doesn't match what acomp is going to do.
> 
> Finally, for the normal code review, there's a bunch of things that need to be
> fixed up before I take a closer look
> 
> - We don't use pr_(), we have btrfs specific printk helpers, please use those.
> - We do 1 variable per line, fix up the variable declarations in your functions.

I'd skip the style and implementation details for now. The absence of
compression level support seems like the biggest problem, also in
combination with uncondtional use of the acomp interface. We'd have to
enhance the compression format specifier to make it configurable in the
sense: if accelerator is available use it, otherwise do CPU and
synchronous compression.

On the other hand, the compression levels are to trade off time and
space. If the QAT implementation with zlib level 9 is always better than
CPU compression then it's not that bad, not counting the possibly
misleading level to the users.

If QAT can also support ZSTD I'm not sure that lack of levels can work
there though, the memory overhead is bigger and it's a more complex
algorithm. Extending the acomp API with levels would be necessary.

Regarding the implementation, there are many allocations that set up the
async request. This is problematic as the compression is at the end of
the IO path and potentially called after memory pressure. We still do
some allocations there but also try not to fail due to ENOMEM, each
allocation is a new failure point. Anything that could be reused should
be in the workspace memory.

