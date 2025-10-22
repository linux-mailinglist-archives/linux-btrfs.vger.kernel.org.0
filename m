Return-Path: <linux-btrfs+bounces-18141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B9BFA0CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 07:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76DA402EE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 05:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A2C2E9755;
	Wed, 22 Oct 2025 05:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uw2Ojw5p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GsL2ya5v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pRs7Rg5f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHVz5gqR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F12D4B4B
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110700; cv=none; b=aoMcwKEx8QN+DX+HnimO+y6jTfD0cE3WEp8FyRdfkmdgZFcjtw7UiBhcrn3uzCC3FtJ0AxcW+AjYLRtTJXKNUkBsy+7LgLZs4IAsZPqPPRlVA+9n13VNkrc+JzmJkLigOdmnKVbuXzvgZQ2/OD333n5fwsavuJbJRD15Uejfbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110700; c=relaxed/simple;
	bh=ogyz9Quitfe/Qnky6S1niFjc95na3lJJFIeQmGHj5CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7KA1bBbTd6B36rbOgZEFJbbmL6RZk6/aGNN+1rLPgd8zuvppicxbdqps1OxsPcjBiScZ+Jt3n8jIgzoZj/pgqjYr67qCYy7cjfXf+MidEHYLT529cbKDioP4JJBEnR5U1CEjpfjCn2mgThQp/Jm/zugmVu0SCQcOtzm4/ev+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uw2Ojw5p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GsL2ya5v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pRs7Rg5f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHVz5gqR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DADA121161;
	Wed, 22 Oct 2025 05:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761110693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5WqKzm90qH6arIZUiYgz9ReY/fhffrKxdJVF2nUTd6Q=;
	b=uw2Ojw5pB7x7/iPW2+oiCj8RD9WFs0vYpth5Qqm81rU/WTIZoP5UsyNQ3+GGBzP2cWc3vg
	O3sgZR1xrR1zSlgySsHyoBg9UryT62McMu/qNQWVwb3cWjwI3UyTRRSbSM9AAv/f2nX5DL
	QxgYm45iXGDgVF7yXQaYLAWomHEKkm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761110693;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5WqKzm90qH6arIZUiYgz9ReY/fhffrKxdJVF2nUTd6Q=;
	b=GsL2ya5vtI/S5JtkRU5w1fN3Mce+XyYiSIcs33rfRR3dD7kI9TQoOf90TICTF6UNRHElfE
	KrVkePBaJm59giAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pRs7Rg5f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HHVz5gqR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761110688;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5WqKzm90qH6arIZUiYgz9ReY/fhffrKxdJVF2nUTd6Q=;
	b=pRs7Rg5fGs1zBuKuvQ3kK0eYubciRWMj3t4+QYdtdjCn4bmqUvPbLmJbayOVZCf0AeLELS
	ocG8Ilx86akx8GI97/Z+yd3+Un7WJ+eLplIvq0kAg9WNsanPYWtRoyBRekvJg5upm2N/wq
	L/K35brore3cuOd2eCGUmLd8vbjqnc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761110688;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5WqKzm90qH6arIZUiYgz9ReY/fhffrKxdJVF2nUTd6Q=;
	b=HHVz5gqRz9XfAVFsx6/v2hjsA7+BniYyrp2XOkVBkZsuYCrWXQE7GAIr+R39OGRnazrO5f
	q8l+mZa8bV81HeAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB39B13995;
	Wed, 22 Oct 2025 05:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RzWILaBq+GjVIgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Oct 2025 05:24:48 +0000
Date: Wed, 22 Oct 2025 07:24:43 +0200
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: send: make use of -fms-extensions for
 defining struct fs_path
Message-ID: <20251022052443.GP13776@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
 <20251020142228.1819871-3-linux@rasmusvillemoes.dk>
 <CAHk-=wgHLkpQAEDpA9pwXp_oteWkdcs-56m7rnQD=Th0N2sW9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgHLkpQAEDpA9pwXp_oteWkdcs-56m7rnQD=Th0N2sW9g@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: DADA121161
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[rasmusvillemoes.dk,suse.com,vger.kernel.org,kernel.org,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.71
X-Spam-Level: 

On Mon, Oct 20, 2025 at 09:48:25AM -1000, Linus Torvalds wrote:
> On Mon, 20 Oct 2025 at 04:22, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> >
> > +struct __fs_path {
> > +       char *start;
> > +       char *end;
> > +
> > +       char *buf;
> > +       unsigned short buf_len:15;
> > +       unsigned short reversed:1;
> > +};
> > +static_assert(sizeof(struct __fs_path) < 256);
> >  struct fs_path {
> > +       struct __fs_path;
> > +       /*
> > +        * Average path length does not exceed 200 bytes, we'll have
> > +        * better packing in the slab and higher chance to satisfy
> > +        * an allocation later during send.
> > +        */
> > +       char inline_buf[256 - sizeof(struct __fs_path)];
> >  };
> 
> It strikes me that this won't pack as well as it used to before the change.
> 
> On 64-bit architectrures, 'struct __fs_path' will be 8-byte aligned
> due to the pointers in it, and that means that the size of it will
> also be aligned: it will be 32 bytes in size.
> 
> So you'll get 256-32 bytes of inline_buf.
> 
> And it *used* to be that 'inline_buf[]' was packed righ after the
> 16-bit buf_len / reversed bits, so it used to get an extra six bytes.
> 
> I think it could be fixed with a "__packed" thing on that inner
> struct, but that also worries me a bit because we'd certainly never
> want the compiler to generate the code for unaligned accesses (on the
> broken architectures that would do that). You'd then have to mark the
> containing structure as being aligned to make compilers generate good
> code.
> 
> So either you lose some inline buffer space, or you end up having to
> add extra packing stuff. Either way is a bit of a bother.

For the inline path buffer losing 6 bytes is acceptable, I did some
stats on my system and full paths under /.snapshots from snapper are all
uner 200 bytes, lengths on another random data partition goes up to 380.
Users can of course have path of any length but there's a fallback and
the allocations are done in the steps of slab bucket sizes so it's
reasonably effective.

