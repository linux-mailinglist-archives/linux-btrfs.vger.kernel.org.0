Return-Path: <linux-btrfs+bounces-15293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51CAFB608
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 16:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13ACC189118A
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4FB2D8376;
	Mon,  7 Jul 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ANdm94jz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TpBCVi9b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ANdm94jz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TpBCVi9b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2B729A9ED
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898333; cv=none; b=irih6XdvURmVvx5n/RuV5jzO2IPH/vSVRV6cNLrPXxCjLRMUSwVWkBWmkLW+A6Us2M0fI7oyprPfxG8frvY9xU6IBL4RdyuxYdxccgbk+2yBkiN+0HfMd0pU6oDiqGKXEK2eHCrgd7s+NePpWMC+7dROkpj1EtksdhsvfQ/xdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898333; c=relaxed/simple;
	bh=SKlFJKnD/30IwXqzouJGZXtNm8tirTI6FGzKZhB5/mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQA04T0IiRObUflhLVe0kx8lKr3UPbI8XGqPKq701jXdGSfU5JQJ4o6EV50s3A0Poo6VgjtwH49Kv6KVM7SOGTI98oOnroM7tWU8JM9Yu7b11yZAMNz+2Jw/F/jPwAQ3KZNbvdR2w3J3+Is1GLDbZvSCWfq/Yv0jppGsN1ItAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ANdm94jz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TpBCVi9b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ANdm94jz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TpBCVi9b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E9CD21163;
	Mon,  7 Jul 2025 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751898329;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TRVMEKdOqpAh9kVyquhf7Lpu7iVCAXKkKD27RKi3RM=;
	b=ANdm94jzvSZY63kjf/82vppiFxGVeHT0IlOD63TYi1tfF/IF0lHSmjz0ijFWcxJokIlSDb
	5/iJ0zGj7kYCttOEmTMfdC9eDLhvuEblyTPVMzikm3rNyhRW1TxNxhmMpxlXcvLFnn2YwV
	Y9mOR5X8OcqAoMAAr69LBGj7lyf4F9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751898329;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TRVMEKdOqpAh9kVyquhf7Lpu7iVCAXKkKD27RKi3RM=;
	b=TpBCVi9b2O3MtUS9HIcBflg/CEQPeCy68bJAgSYNRqhPYNufccqmr3Ui2lY5XkMnt/SbM5
	i8RxfsJEzZtUWiCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751898329;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TRVMEKdOqpAh9kVyquhf7Lpu7iVCAXKkKD27RKi3RM=;
	b=ANdm94jzvSZY63kjf/82vppiFxGVeHT0IlOD63TYi1tfF/IF0lHSmjz0ijFWcxJokIlSDb
	5/iJ0zGj7kYCttOEmTMfdC9eDLhvuEblyTPVMzikm3rNyhRW1TxNxhmMpxlXcvLFnn2YwV
	Y9mOR5X8OcqAoMAAr69LBGj7lyf4F9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751898329;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8TRVMEKdOqpAh9kVyquhf7Lpu7iVCAXKkKD27RKi3RM=;
	b=TpBCVi9b2O3MtUS9HIcBflg/CEQPeCy68bJAgSYNRqhPYNufccqmr3Ui2lY5XkMnt/SbM5
	i8RxfsJEzZtUWiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AA9013757;
	Mon,  7 Jul 2025 14:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EX2xAdnYa2iTLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Jul 2025 14:25:29 +0000
Date: Mon, 7 Jul 2025 16:25:23 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs: accessors: use type sizeof constants directly
Message-ID: <20250707142523.GG4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751390044.git.dsterba@suse.com>
 <eedbe03f6ee33939841d4bf895519304dfa1c59f.1751390044.git.dsterba@suse.com>
 <20250702175854.GA2308047@zen.localdomain>
 <20250703212015.GZ31241@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703212015.GZ31241@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [1.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Level: *
X-Spam-Score: 1.00

On Thu, Jul 03, 2025 at 11:20:15PM +0200, David Sterba wrote:
> > nit: the names oil and part are pretty non-sensical to me. Oil used to
> > be oip for Offset In Page. Is it Offset In foLio?
> > 
> > I can't figure out what part should mean.
> 
> It confused me the whole time I was looking at the code, it snuck in
> with the folio changes, it should have been 'oif' follwing the previous
> naming pattern.
> 
> > So while I see why you're doing all the changes, I can' help but notice
> > that you removed the two named variables with logical names and left the
> > confusing ones. :)
> 
> So I can sneak in a patch renaming it at the beginning or at the end,
> naming it 'oif' or 'foff' (there's the eb related offset as parameter so
> we need some kind of distinction).

Appended a patch renaming it to 'oif'.

