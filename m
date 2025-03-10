Return-Path: <linux-btrfs+bounces-12156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E1A5A44D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 21:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DAD1892D5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CBD1DED66;
	Mon, 10 Mar 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lkjIVZr8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jwXb+Ue/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lkjIVZr8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jwXb+Ue/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34921E0B86
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636859; cv=none; b=RjP6J01c1an5LWzqY/MSDxuLZzFq1sRlv650kYt4bDEDJQvr9QhzeGaV1/SmEEMQi8im2nbZ6eFNSaVThuAN0SUgz4x1+F6bXHsSjxfMpA+TZ6OKktInVhrVDa+f9X11/Nuiq+DW+EQdmt/G/ILpb3/v0ru2O+dSJ1Wx5MsHAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636859; c=relaxed/simple;
	bh=Kg1+JcYOYb5X9mvVqfGUlJg4HnG6CnQPEOatIEUt+3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRh/zxqpoJHUOs962mFO/WViAWfwSad0uJc3uG04oVqraT/c0SPfb89nHplXlikzp+UphKJERiJfwBkjqVoWgk+Xdd1iNMuHf3+AYXU68PlsPRvEAd2pT96xSXt4e+QKI75a5YpRKQmuSkEehKviK5hbkx/jlzrKnclgEyjpEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lkjIVZr8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jwXb+Ue/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lkjIVZr8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jwXb+Ue/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA6022115E;
	Mon, 10 Mar 2025 20:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741636855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bnFtliglFvqt08/A5B+FTY+lyir/ITotqj1zl68p7o=;
	b=lkjIVZr8TPBAsNG0CaDPWM57lokkkhPTMNOEFkWNWVmAuVucDKQpe/Nju5Igwd6Da2x/6q
	qy4yipLlRH0oVKlJv5tBRYQ6ekQ/k4oWSdnXnK207LPdfrnuh5wtFvhO2VPliEgYF1Aycd
	qO5R4+iXoogU78yyMeakyQO1E83e5W8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741636855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bnFtliglFvqt08/A5B+FTY+lyir/ITotqj1zl68p7o=;
	b=jwXb+Ue/JTdWhTR6+zHLum6iU7xF9KQhwz0H8b0dilMn7trlw02N4HJ0X+AD35LK0VPups
	c958fK9T7y2HGYDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741636855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bnFtliglFvqt08/A5B+FTY+lyir/ITotqj1zl68p7o=;
	b=lkjIVZr8TPBAsNG0CaDPWM57lokkkhPTMNOEFkWNWVmAuVucDKQpe/Nju5Igwd6Da2x/6q
	qy4yipLlRH0oVKlJv5tBRYQ6ekQ/k4oWSdnXnK207LPdfrnuh5wtFvhO2VPliEgYF1Aycd
	qO5R4+iXoogU78yyMeakyQO1E83e5W8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741636855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6bnFtliglFvqt08/A5B+FTY+lyir/ITotqj1zl68p7o=;
	b=jwXb+Ue/JTdWhTR6+zHLum6iU7xF9KQhwz0H8b0dilMn7trlw02N4HJ0X+AD35LK0VPups
	c958fK9T7y2HGYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCDA91399F;
	Mon, 10 Mar 2025 20:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qjCLLfdEz2fAHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 10 Mar 2025 20:00:55 +0000
Date: Mon, 10 Mar 2025 21:00:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@meta.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: avoid linker error in
 btrfs_find_create_tree_block()
Message-ID: <20250310200054.GE32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250306105900.1961011-1-maharmstone@fb.com>
 <10586e9f-89d7-4d40-b1a0-027c10b5ce97@meta.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10586e9f-89d7-4d40-b1a0-027c10b5ce97@meta.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Mar 06, 2025 at 11:03:46AM +0000, Mark Harmstone wrote:
> The context to this is that I'm fed up of seeing "<optimized out>" in 
> GDB, and am trying to get the kernel to compile with -O0 for development 
> purposes.

You can mention that in the changelog as the reason why to do the
change, making debugging easier namely if it's just a simple change like
that.

In other parts of kernel the -O2 may be necessary to utilize the dead
code elimination enabled at this level, like the if (0) { code... }
where the 0 is result of IS_ENABLED macro magic and "code..." needs to
resolve some symbols. Compiler flags can be set per directory so one can
mix -O2 globally and -O0 e.g. for fs/btrfs/ .

> There's still a couple of issues elsewhere for this to be possible, but 
> this was one of the problems I ran into.

Feel free to send them.

