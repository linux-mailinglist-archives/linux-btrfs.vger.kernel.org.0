Return-Path: <linux-btrfs+bounces-15465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A9EB01940
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 12:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C7C3AE0FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0027E7D8;
	Fri, 11 Jul 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hzLMIrsj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z3NqLUWQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hzLMIrsj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z3NqLUWQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456BAA92E
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228175; cv=none; b=B4VrGkcFk65ihejlGPjHiVdcVnlfxWllNQr9zJRTxBW8KGGv5m6A8H7h6YEEuxELO27ponqOOV6bVnnUNyxbwKjk8qcRPPlUkD/Ygo/168XRUeIMWED7qmHkQGSl4J8i5piyI4zQEJfrhD/X5fxFS2IomXb+bYW8O3kRMNRFb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228175; c=relaxed/simple;
	bh=4UYBbjiwjqZbvBN2NIpy+XkNbUM8g68ErAPrnc0drOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1H6ftrWkFvj+GFAedhEYLihmqP6TOd1x5r4TiMZdA+LjjkRCVNzIe6RfuSM7DDOxryGqex6SRh9k9CG6ZUyomrLEdnt/0mhNUFJAbpQuIoKC+TTyh5PpRTPUEGpK8iOL44umcfrSf5j/z2oEMJ+Sob3JXB/ATh+GXdj9i/EyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hzLMIrsj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z3NqLUWQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hzLMIrsj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z3NqLUWQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3979B1F45E;
	Fri, 11 Jul 2025 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752228172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DuvXCPMfH2iGz+yMhh7E8HqvayFzO4F1CPjL4o1QGg=;
	b=hzLMIrsjYrtfLohBccet6BaWHoB5n/SLI+okYNqoeH7+nD0M7GI2FThQ1h8MEUhWv7thA5
	1RYzFbou7tdSmDOtFUO4W2LRtxKyS9lWBd0XCqxG0pm0vRZ9J+uSOKQmp3A+3IVVSpv95q
	QTFLLwZlyKDpZ5PhsfMu0u2B2/kfNCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752228172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DuvXCPMfH2iGz+yMhh7E8HqvayFzO4F1CPjL4o1QGg=;
	b=z3NqLUWQYybdzmTGWxuYDMUf0tZI18vCf1/Ut2N++kCWOPp9gIQQnFUu0UEG3tSeygBJn+
	G/ubi2wKvSY95TDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hzLMIrsj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=z3NqLUWQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752228172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DuvXCPMfH2iGz+yMhh7E8HqvayFzO4F1CPjL4o1QGg=;
	b=hzLMIrsjYrtfLohBccet6BaWHoB5n/SLI+okYNqoeH7+nD0M7GI2FThQ1h8MEUhWv7thA5
	1RYzFbou7tdSmDOtFUO4W2LRtxKyS9lWBd0XCqxG0pm0vRZ9J+uSOKQmp3A+3IVVSpv95q
	QTFLLwZlyKDpZ5PhsfMu0u2B2/kfNCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752228172;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DuvXCPMfH2iGz+yMhh7E8HqvayFzO4F1CPjL4o1QGg=;
	b=z3NqLUWQYybdzmTGWxuYDMUf0tZI18vCf1/Ut2N++kCWOPp9gIQQnFUu0UEG3tSeygBJn+
	G/ubi2wKvSY95TDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B6401388B;
	Fri, 11 Jul 2025 10:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uaUxBkzhcGjddwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Jul 2025 10:02:52 +0000
Date: Fri, 11 Jul 2025 12:02:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7] btrfs: try to search for data csums in commit root
Message-ID: <20250711100246.GB22472@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <112a66d49285e38d7a567aa780d9545baafd3deb.1752101883.git.boris@bur.io>
 <98154adb-057a-44d7-97a4-9bfd669b9454@suse.com>
 <20250710152606.GB588947@zen.localdomain>
 <1dbd43cb-7e1f-455c-8de8-4b91826b800e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dbd43cb-7e1f-455c-8de8-4b91826b800e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmx.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3979B1F45E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Fri, Jul 11, 2025 at 06:57:06AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/7/11 00:56, Boris Burkov 写道:
> > On Thu, Jul 10, 2025 at 04:45:35PM +0930, Qu Wenruo wrote:
> [...]
> >> If that's the case, I'd prefer to have a dedicated flag for it.
> >>
> >> In fact there is a 7 bytes hole inside btrfs_bio, and we don't need to
> >> bother the extra helpers for this.
> > 
> > I'm happy either way. Sterba said he preferred to not add fields to the
> > btrfs_bio on v2:
> > https://lore.kernel.org/linux-btrfs/20241011174603.GA1609@twin.jikos.cz/
> > 
> > But at that point I didn't even try to find a neat spot in the struct to
> > slot it in, and just dumped a bool on the end of the struct.
> > 
> > For my learning, how are you finding the 7 byte hole? Do you have a tool
> > for dumping a particular compiled version of the struct you like? I
> > started trying to count up the sizes of stuff in struct btrfs_bio and
> > quickly lost steam halfway through the union with nested structs.
> 
> The tried and true pa_hole tool.

It's 'pahole' from https://github.com/acmel/dwarves

