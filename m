Return-Path: <linux-btrfs+bounces-13632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED9BAA7500
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 16:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E75C1B607F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D4D2417D4;
	Fri,  2 May 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zMUmMRQ/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LI3YmHyZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oWt5d3Ih";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pVZMzrvx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9F18E3F
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196311; cv=none; b=UdSVczvjO8xgzCQBIeDkYa5Ek8oqktueyQAhZUPEpcL+UCaNU9fXp9SYedg2UeRNyKvvQal4TOaDTiJQzRAYKOouxqHbR7kmVZXOibLm154h03RiXgvY14wFN8oHSm/tsdYp+okkxYXdyp+YOegM6K3hCjYg3bmrcJNrZa/x80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196311; c=relaxed/simple;
	bh=0ijHQXnRC1sbg6T5iYFu2im4gF5RGEe8jQaH1h+UifQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TImUVGM2bhHObBZhmYMTCCxTxbuu3Mm8UeNI9ImfyKg2EnuejRpUjL2Lyb0G6ZlOu4vL17BehqTdMBm6niA7jpVkkmAIKD9/OmoansR6T1b0b/Ak//okGqvY96y8yuyjjy6kWr/GcAxCssXxaLP8esFoKiMLPxtw2ZHnAiCRjgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zMUmMRQ/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LI3YmHyZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oWt5d3Ih; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pVZMzrvx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDE5C2124E;
	Fri,  2 May 2025 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746196308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZhE5/yH/lBZfAJ6fRKIYgF8wr6v9rQeD4LzR+3x984=;
	b=zMUmMRQ/79wSVFDsSlpS5342YB+rzysDKCFQBxKD5jqLvupVChLxTv5u71WowbS8zX7Oea
	kH1GiZoDLRzfFJSC8WscRUsM6iOlkf5ewnAZKiLSyj+kSJl/s+OkZr8Rk6abksOFdXi4jQ
	SMVP/EPeA/jhS98lY23UrfGiiSunb+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746196308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZhE5/yH/lBZfAJ6fRKIYgF8wr6v9rQeD4LzR+3x984=;
	b=LI3YmHyZfiWwUf/Wwt09b4uqBHPdgXBDfNgQrRwxd9hpXfjxVQMhh6pq8p9gAh339L0CGs
	Xa9BNqEwTy47wKCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oWt5d3Ih;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pVZMzrvx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746196307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZhE5/yH/lBZfAJ6fRKIYgF8wr6v9rQeD4LzR+3x984=;
	b=oWt5d3IhiBtvl1geH7Q06n6LHuMm0xuVn4lZH64OeZREiHjO/O1iNu9LQZ1JSMt4Y1l7mt
	5kZ//laCymcYqv4AqlxImNFPkYNhgpDUxCaFba8KYVP43Lr9o/6y8BCbo8sC651vdyLX/n
	2pTiT2JLS9i/MEL3LqBWdvep53xDoyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746196307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MZhE5/yH/lBZfAJ6fRKIYgF8wr6v9rQeD4LzR+3x984=;
	b=pVZMzrvxNq2gmqmQ+5I69jvAlStx7wp7CcuMURlEymT4dKCLjk/ab9gLTtlGOUgSy5gzDC
	jBO+k1DxKKR1tIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCFBE1372E;
	Fri,  2 May 2025 14:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2ui0NVPXFGibLAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 02 May 2025 14:31:47 +0000
Date: Fri, 2 May 2025 16:31:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Transaction aborts in free-space-tree.c
Message-ID: <20250502143142.GS9140@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1746031378.git.dsterba@suse.com>
 <CAPjX3FcAA=2cR4WqxFUOXZ4zYHS8hS75-ii0HPKQddgwhtr=Vg@mail.gmail.com>
 <20250502132407.GR9140@suse.cz>
 <CAPjX3FfMsjumdvv+BxtknhuGbXROKSioo5KGf-pj0_DafXsYkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FfMsjumdvv+BxtknhuGbXROKSioo5KGf-pj0_DafXsYkA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: EDE5C2124E
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
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:replyto,suse.cz:email,suse.com:email,btrfs.readthedocs.io:url];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, May 02, 2025 at 03:32:52PM +0200, Daniel Vacek wrote:
> On Fri, 2 May 2025 at 15:24, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Fri, May 02, 2025 at 03:15:49PM +0200, Daniel Vacek wrote:
> > > On Wed, 30 Apr 2025 at 18:45, David Sterba <dsterba@suse.com> wrote:
> > > >
> > > > Fix the transaction abort pattern in free-space-tree, it's been there
> > > > from the beginning and not conforming to the pattern we use elsewhere.
> > > >
> > > > David Sterba (4):
> > > >   btrfs: move transaction aborts to the error site in
> > > >     convert_free_space_to_bitmaps()
> > > >   btrfs: move transaction aborts to the error site in
> > > >     convert_free_space_to_extents()
> > > >   btrfs: move transaction aborts to the error site in
> > > >     remove_from_free_space_tree()
> > > >   btrfs: move transaction aborts to the error site in
> > > >     add_to_free_space_tree()
> > > >
> > > >  fs/btrfs/free-space-tree.c | 48 +++++++++++++++++++++++++-------------
> > > >  1 file changed, 32 insertions(+), 16 deletions(-)
> > >
> > > This looks like unnecessary duplicating the code. Shall we rather go
> > > the other way around?
> >
> > What do you mean? There's some smilarity among the functions so yeah
> > the add/remove pairs can be merged to one, but this is orthogonal to the
> > transaction abot calls.
> 
> Not that. I meant the code looks simpler without these patches. If
> this is the pattern used elsewhere, maybe we should rather change
> elsewhere to follow free-space-tree.c?

https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#error-handling-and-transaction-abort

"Please keep all transaction abort exactly at the place where they happen
and do not merge them to one. This pattern should be used everywhere and
is important when debugging because we can pinpoint the line in the code
from the syslog message and do not have to guess which way it got to the
merged call."

