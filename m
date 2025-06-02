Return-Path: <linux-btrfs+bounces-14388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D0BACBA4A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 19:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A092188E5E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1650226CFD;
	Mon,  2 Jun 2025 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EQATQFKn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJhqhNeN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EQATQFKn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJhqhNeN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F769224AED
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885293; cv=none; b=eGwmugoo4SnnH55auYLTLKbb3aTTZsfmdeL93MpIjitXs9Ip+CO3l8H4pyeNWrp1vadHlh6NQBYhT+yE9auuM9XtV1eBiHL/2PaJNq9orQJAlqwuqg2gwhUW2aOy14Env7WoyC0phQiR/dMWLYpZCfoBB8LyVkl6cMwEnU5F+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885293; c=relaxed/simple;
	bh=IN90P84B9OQNKubbtwacsH/eHVAdptfZXOwN2cAFTuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Faruqw9uFyRQxnMILjR9ZbVHfmprYQgQW9vPoW1ASutkAsrF2SY/qSAyR4ipa40BhyDVY2sa79lnvCtl1g6KCR5aPG90zpX3kZ8TNCJHZO/5f2Z/2rzravHNspsrbeIVaDG5TQyai4781zuFtwPJMHZPrPbCl4BUNgDqU88HbwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EQATQFKn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJhqhNeN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EQATQFKn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJhqhNeN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F28C219CB;
	Mon,  2 Jun 2025 17:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748885289;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqk0NeiV7YejFqWOyRz7eZivEf+nL0RIo2VbvvupdGE=;
	b=EQATQFKnrt5RylnijrOhiOa8TkSI7Z8CaY3Leqay2gcpaMTY1X/p5riF1ytpGIGLRg7JWo
	8aWZkcLHzM4oVLVsjxRgF/XxlSgfwWJ7ePh7fgqZOaJASWbyPBg8/b6tVBN2Nc/PAxLxSv
	O7DKuRtD0vhFoOOnQs/pmZm1rErMoCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748885289;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqk0NeiV7YejFqWOyRz7eZivEf+nL0RIo2VbvvupdGE=;
	b=LJhqhNeNRbtSD5hWmFxlhD2R9HrkoUunAeQH9cHwkZIRAIyi8/H3eRWX0tZlKTo6+QTaPL
	E07rkhsazL4ysuBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748885289;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqk0NeiV7YejFqWOyRz7eZivEf+nL0RIo2VbvvupdGE=;
	b=EQATQFKnrt5RylnijrOhiOa8TkSI7Z8CaY3Leqay2gcpaMTY1X/p5riF1ytpGIGLRg7JWo
	8aWZkcLHzM4oVLVsjxRgF/XxlSgfwWJ7ePh7fgqZOaJASWbyPBg8/b6tVBN2Nc/PAxLxSv
	O7DKuRtD0vhFoOOnQs/pmZm1rErMoCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748885289;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqk0NeiV7YejFqWOyRz7eZivEf+nL0RIo2VbvvupdGE=;
	b=LJhqhNeNRbtSD5hWmFxlhD2R9HrkoUunAeQH9cHwkZIRAIyi8/H3eRWX0tZlKTo6+QTaPL
	E07rkhsazL4ysuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BCA013A63;
	Mon,  2 Jun 2025 17:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IbbOGSnfPWitJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Jun 2025 17:28:09 +0000
Date: Mon, 2 Jun 2025 19:28:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: harden parsing of compress mount options
Message-ID: <20250602172807.GC4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250602155320.1854888-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602155320.1854888-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -8.00

On Mon, Jun 02, 2025 at 05:53:17PM +0200, Daniel Vacek wrote:
> This series hardens the compress mount option parsing. 
> 
> ---
> v3 changes: Split into two patches to ease backporting,
>             no functional changes.

This is much better, thanks.

