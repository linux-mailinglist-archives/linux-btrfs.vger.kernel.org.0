Return-Path: <linux-btrfs+bounces-14872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3AAE46D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 16:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDAE1635DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F50723E330;
	Mon, 23 Jun 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FIWl4fuj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yNiopgv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KZ7H7R83";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJGxJfsV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA414A0B7
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688707; cv=none; b=R+YN2upq6GhGGOb5s9W/s8nMReQqF7+QBlShpWuj1XJ2BxuQ9HDrOwgZ93wntGu/UhTrUWdCdd6aBhEb3bXSuaZKf+oAGwwFrB0ZzKO8A6HaP4PrpNyhYIw8VoxICv2wn/I26QZgNVjujFhxsGdGYVxt61HvPNauZ7sf2BHbzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688707; c=relaxed/simple;
	bh=2thAbP/x2dP4CHS8x1GLqjFHO+2tuPj7kdkfT/hs/0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYdLvOCUuPKf8jwqWjY5o9kpxuro78a28XIKSgzv1sgLKgKQqhVhKrU73kw850lMUSeDo+ZG7cP0UxCQeJvm3LbZwvAM4l5hKiXFvhprFq5PLr4VVAAfcemBv4dd7oMaXzQTyoFG12Wf7GHo2PIArCaBzg4toaeAx84bdtQCbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FIWl4fuj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yNiopgv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KZ7H7R83; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJGxJfsV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E0692116B;
	Mon, 23 Jun 2025 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750688704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qqVKttKNNCknQWqOlFOPy43hheM4hieeAIjadXuvnXY=;
	b=FIWl4fujZvbfHfd7w+jtgTX+9EEszePWrtTeaEuHjDCyifDbcUSUTtWxXu5nj7eq1qTKVC
	pyzs63PRw5vcmnZTyoeiIUChjD6NnGPNxQt+IZXkkxPd3oK9KvPmu/95cKYXO8ZE6Xt2UA
	EEDM8Dfr8GmQY5yYUHaZAHJ90axVza0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750688704;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qqVKttKNNCknQWqOlFOPy43hheM4hieeAIjadXuvnXY=;
	b=2yNiopgv9KingdpYt25oBedOpB33iPyMAnV+6f4uVehwgFmpE34NPKf1+Uk9K0fFz3QYQJ
	zhfPfY8l/XgyNGDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750688703;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qqVKttKNNCknQWqOlFOPy43hheM4hieeAIjadXuvnXY=;
	b=KZ7H7R83HR8ULAcYsuJuAB+8lr9nIwji/oQFs5lWK1zlyUIBCDucH2+Gf7v8BDuh6ARoAh
	cmDjxj7ZnxhLrVg9trOT8hNoZj9D97cjV/dWoCxf7eMQWf+zWHmoSCOAbL+imbWNCmeP29
	lXJ7mAxEHpQWjZxs7KtSNytgZ3hhLEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750688703;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qqVKttKNNCknQWqOlFOPy43hheM4hieeAIjadXuvnXY=;
	b=sJGxJfsVWh9WqyW12tcUfuMQTWlCZ5LfRvqjT2fka+cpmZu8ATD2Okwg6lAY0Li+DUw1qT
	acvbsj9yvC0n0kCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39DAD13485;
	Mon, 23 Jun 2025 14:25:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7WfeDb9jWWjmYwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 23 Jun 2025 14:25:03 +0000
Date: Mon, 23 Jun 2025 16:25:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: index buffer_tree using node size
Message-ID: <20250623142501.GA28944@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250612084724.3149616-1-neelx@suse.com>
 <20250620125744.GT4037@twin.jikos.cz>
 <CAPjX3FdgS4xJBvvsx9zRxiuRm9=5VcTynmtnidga4gcqewLrUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FdgS4xJBvvsx9zRxiuRm9=5VcTynmtnidga4gcqewLrUw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Jun 23, 2025 at 04:04:39PM +0200, Daniel Vacek wrote:
> On Fri, 20 Jun 2025 at 14:57, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Thu, Jun 12, 2025 at 10:47:23AM +0200, Daniel Vacek wrote:
> > > So far we are deriving the buffer tree index using the sector size. But each
> > > extent buffer covers multiple sectors. This makes the buffer tree rather sparse.
> > >
> > > For example the typical and quite common configuration uses sector size of 4KiB
> > > and node size of 16KiB. In this case it means the buffer tree is using up to
> > > the maximum of 25% of it's slots. Or in other words at least 75% of the tree
> > > slots are wasted as never used.
> > >
> > > We can score significant memory savings on the required tree nodes by indexing
> > > the tree using the node size instead. As a result far less slots are wasted
> > > and the tree can now use up to all 100% of it's slots this way.
> > >
> > > Note: This works even with unaligned tree blocks as we can still get unique
> > >       index by doing eb->start >> nodesize_shift.
> >
> > Can we have at least some numbers? As we've talked about it and you
> > showed me the number of radix nodes or other internal xarray structures
> > before/after.
> 
> The numbers are in this email thread. Do you mean to put them directly
> into the commit message?

Yes, it's relevant information and part of why the patch is done. Mails
are for discussion, for permanent stoarge we want it in changelog in a
presentable form.

