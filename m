Return-Path: <linux-btrfs+bounces-10035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0649D9E22B5
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 16:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18EC2866BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978D31F7569;
	Tue,  3 Dec 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Noq6nfhQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+WDVKQR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Noq6nfhQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+WDVKQR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD631F473A;
	Tue,  3 Dec 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239685; cv=none; b=Y3pmFXt+GJZFFIv+zcy7od2Iy1NJGkWavHoWSAyKwZBaUQcFcAhdLmMtJq9WfqAJbwY2KEierVUYUvtNMO00zieQ+bWsS4rsXsSs3YnhikieRzi8PsA01k2xX1UsX1Xq636p46Wp6ylYJgyWxnUkD5cUAm+DQbhlWET5ObR2YEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239685; c=relaxed/simple;
	bh=P4n7rPKm9mrTUtGHFa7kPSSjh8ttAxE0FDkxfYxVJDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+5bh2R2UxtcXmoZ/InplRRcQoq4V2oY3pAj30rYUxBdx/p4QZIq/d+S2uyr+pjbQSLly1ISEKlKVo1yr1jwwE2eNZKOmbs144ebGdKzPyqlHURQdiSU6yLJGtYDMiXSkM70cb0BaPgD8897t9j27LoMQLzy/LoRhQKMaIubSjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Noq6nfhQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+WDVKQR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Noq6nfhQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+WDVKQR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 073221F445;
	Tue,  3 Dec 2024 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733239682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ka17MrpqXsNinCHXoX/M7oeZ+vUwmqY5SaiKN8Zkfk0=;
	b=Noq6nfhQZMNzQvn6uTTyWWgL5kLOgJvzF4ZFf9beeKbs0D4L5WHnjsyJzYTJ2SbqG+4wvI
	X8TzCGse5lNbJ3SbwC0DuorUC9pUrL1dTEFav6bRrK/J2V3KGg/zr0xZ9JmuolgtpV6GMk
	u3X7ro2WNlx4/otYfivcXo6rwpkiW0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733239682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ka17MrpqXsNinCHXoX/M7oeZ+vUwmqY5SaiKN8Zkfk0=;
	b=z+WDVKQR+/AF6qMHOIozf5okHQ03V8pIIPs4R1eBa889H8MTmcjfyLoAlPpx7+yRv83ckA
	0QBHbIC2p1WM94Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Noq6nfhQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=z+WDVKQR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733239682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ka17MrpqXsNinCHXoX/M7oeZ+vUwmqY5SaiKN8Zkfk0=;
	b=Noq6nfhQZMNzQvn6uTTyWWgL5kLOgJvzF4ZFf9beeKbs0D4L5WHnjsyJzYTJ2SbqG+4wvI
	X8TzCGse5lNbJ3SbwC0DuorUC9pUrL1dTEFav6bRrK/J2V3KGg/zr0xZ9JmuolgtpV6GMk
	u3X7ro2WNlx4/otYfivcXo6rwpkiW0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733239682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ka17MrpqXsNinCHXoX/M7oeZ+vUwmqY5SaiKN8Zkfk0=;
	b=z+WDVKQR+/AF6qMHOIozf5okHQ03V8pIIPs4R1eBa889H8MTmcjfyLoAlPpx7+yRv83ckA
	0QBHbIC2p1WM94Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4B2513A15;
	Tue,  3 Dec 2024 15:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /wSaN4EjT2e3RwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Dec 2024 15:28:01 +0000
Date: Tue, 3 Dec 2024 16:27:56 +0100
From: David Sterba <dsterba@suse.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: David Sterba <dsterba@suse.com>, stable@vger.kernel.org,
	linux-btrfs@vger.kernel.org, git@atemu.net,
	Luca Stefani <luca.stefani.ge1@gmail.com>
Subject: Re: [PATCH 6.6.x] btrfs: add cancellation points to trim loops
Message-ID: <20241203152756.GA31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241125180729.13148-1-dsterba@suse.com>
 <2024120245-molar-antidote-e93a@gregkh>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024120245-molar-antidote-e93a@gregkh>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 073221F445
X-Spam-Score: -2.71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,atemu.net,gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.com:email];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Dec 02, 2024 at 12:15:54PM +0100, Greg KH wrote:
> On Mon, Nov 25, 2024 at 07:07:28PM +0100, David Sterba wrote:
> > From: Luca Stefani <luca.stefani.ge1@gmail.com>
> > 
> > There are reports that system cannot suspend due to running trim because
> > the task responsible for trimming the device isn't able to finish in
> > time, especially since we have a free extent discarding phase, which can
> > trim a lot of unallocated space. There are no limits on the trim size
> > (unlike the block group part).
> > 
> > Since trime isn't a critical call it can be interrupted at any time,
> > in such cases we stop the trim, report the amount of discarded bytes and
> > return an error.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> > Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> > CC: stable@vger.kernel.org # 5.15+
> > Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> > Reviewed-by: David Sterba <dsterba@suse.com>
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> 
> No git id?  :(

I forgot to add it but meanwhile Sasha looked up the commit and added it for me.

