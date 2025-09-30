Return-Path: <linux-btrfs+bounces-17291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E2EBACF73
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 15:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB0717006D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D8303C9D;
	Tue, 30 Sep 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oU6vfXi3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bkudy7Oo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sCedy/q5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0bb3V8Uh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383B2FB97D
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237449; cv=none; b=Sh5NRbIhSd1ItoxjBaWPzl1DTv214KQJ+fn2Gjei67vqtkW08kzy+vHCR9pYLPH0S0BRBJbqkZI1kACLx7zvNEYhwiGXAjV6hBHR8pQlbslR86pUOCRBecwLC4h2sRATCqFBHNfqO12oPu7lIFjH/qGzhN93cYFtRBqLUVfawFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237449; c=relaxed/simple;
	bh=ro76ONjtxuhp9Jih1z2g4aG1dRL+Su8zX2IGE7+2GsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piKf8if8gyHQvN68grxHzkYNyY8gPVsfuJwCR0iBvctPhL4xvUgSKt9a8xijS12Pta55TzeHPwMZR56W8Kk0VmqVekxe43y0/KquYjzWzCy8IwLumVd/qpgxCR2Jad6KZDsgbg6GQKxY0LCD4xUmnGdhhNCFzT7ex9a7/mvbUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oU6vfXi3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bkudy7Oo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sCedy/q5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0bb3V8Uh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1066336E6;
	Tue, 30 Sep 2025 13:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759237445;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L35wnh9HCYKBdlIaJBJq36JfdQcWBIL170zr2OXssQE=;
	b=oU6vfXi3F+lQg4NiLgkvvPgPFMy9g2CkQGkgYQ58roHNvchJjB85Ef+Ualpl4R1cG/OmEe
	WToGOOpQdsoB0d7ugKLL4PFpVEPVoM6EqgX/c93xdJhpttpEvXeQ2RTPqMA70sCUILPXeK
	tOOajwTwL4iVsA/hNLjmWnGGak/ilHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759237445;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L35wnh9HCYKBdlIaJBJq36JfdQcWBIL170zr2OXssQE=;
	b=bkudy7OoGDN5BBZiqBXeZM/Yry9V8XtGe919RRb6B8IMHVMfqQAiUibhT3PdKXrjTr49VT
	2n+UFYlU6Znh0oDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="sCedy/q5";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0bb3V8Uh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759237444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L35wnh9HCYKBdlIaJBJq36JfdQcWBIL170zr2OXssQE=;
	b=sCedy/q5KymGDoyiYfAfEZcZzsOYwt3YjrJ6vA7sx8QhdHK78hO76doj8TM54QCsn/UnB7
	yLd0frbONj8uUFH50r+y5iLLVWvGeZLUrNvCV89/70OW9VJ3QNfF70L2qMXac0AQagTFWY
	I07Klyoi3NRRZs30Ovbcbuc20DEXCuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759237444;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L35wnh9HCYKBdlIaJBJq36JfdQcWBIL170zr2OXssQE=;
	b=0bb3V8UhhubshMERfF5rAwDEbl54XVcJv8XMPtOpOxKkgiAFlXufzD83kjQijLyqasZDuA
	qAqOxItAliDGX2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9EC613A3F;
	Tue, 30 Sep 2025 13:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x6obMUTV22ghPAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Sep 2025 13:04:04 +0000
Date: Tue, 30 Sep 2025 15:04:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 6.18
Message-ID: <20250930130403.GA4052@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1758696658.git.dsterba@suse.com>
 <CAHk-=wjuu2-7z3ALpt6v7L3Zoa_cqz+imGNGwaL=QPGLw7eKNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjuu2-7z3ALpt6v7L3Zoa_cqz+imGNGwaL=QPGLw7eKNQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E1066336E6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Mon, Sep 29, 2025 at 02:35:20PM -0700, Linus Torvalds wrote:
> On Wed, 24 Sept 2025 at 07:41, David Sterba <dsterba@suse.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-tag
> >
> > for you to fetch changes up to 45c222468d33202c07c41c113301a4b9c8451b8f:
> 
> I see the for-6.18 branch, and it matches that commit, but no for-6.8-tag.
> 
> I suspect you just forgot to push that one out,

Ah yes, sorry, now pushed.

