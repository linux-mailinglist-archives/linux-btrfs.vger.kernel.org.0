Return-Path: <linux-btrfs+bounces-9895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3D09D89CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 16:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1BD289304
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F61B4131;
	Mon, 25 Nov 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dwq5dRXT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mr3Dw550";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dwq5dRXT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mr3Dw550"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643321A0AF0
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550153; cv=none; b=s/fBspGWa5D54RfNfeX543g+nfX5xddlCmZPg/cdHcX/wx0+h8D9feT555tc2eYDNM+LuyQpn2b/XDtmDvNwR2BV33hgxqJ55UNWS5L/j155a692ilPH838c4jN8ZgGVCzECxKr82PSDe9Rt7aM8RQSU+VyI4k/D6VErUVf83wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550153; c=relaxed/simple;
	bh=OmwnBnZKxQaRqT6kHRhUEPOeCHCS2SHfPHd7BMqboI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8gKUdGCQIHfUORlevSjxI8U5EPR6P/cu0jLBkchCQgaA83+8kZYLhOtaBWWYFOZCTd6ADMXh1ePTh9GfUW2AKu0Ki0U7aplUtzCjdjBvazma4NXTqYFE/TSiq7QihQPrO7ioYV6dBFYiLaMnU0WQ2T7HcsUtAOwNpC85HJYnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dwq5dRXT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mr3Dw550; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dwq5dRXT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mr3Dw550; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E09B21114;
	Mon, 25 Nov 2024 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732550149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQzQv+699ruLv10+XDJXrNag0qy2lj+adRDaO2+dInQ=;
	b=dwq5dRXT3eHS8utAKa4OE9MBxiXNUzvyDlTsYXF6Wyy1c13hzmBAAnjQz8SrtFWl3hQLAC
	GKw4cRSBEgqCD/fWkaGc+WWj99lfMJvqhxQn8aBIvF8ylZqStslGXM76qNjZ5c+nHfOq/N
	g1Uh8QxfIrZco+9p8iAhH5CNsUYkmr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732550149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQzQv+699ruLv10+XDJXrNag0qy2lj+adRDaO2+dInQ=;
	b=Mr3Dw550sJ/cCvOaqicb5Q5J+oXOKizOJ2E76bO+Q9eCkMpL9qCrV/cA4rRKVKuZPT6MlO
	nd2yt4nGzuvCOIBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732550149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQzQv+699ruLv10+XDJXrNag0qy2lj+adRDaO2+dInQ=;
	b=dwq5dRXT3eHS8utAKa4OE9MBxiXNUzvyDlTsYXF6Wyy1c13hzmBAAnjQz8SrtFWl3hQLAC
	GKw4cRSBEgqCD/fWkaGc+WWj99lfMJvqhxQn8aBIvF8ylZqStslGXM76qNjZ5c+nHfOq/N
	g1Uh8QxfIrZco+9p8iAhH5CNsUYkmr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732550149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQzQv+699ruLv10+XDJXrNag0qy2lj+adRDaO2+dInQ=;
	b=Mr3Dw550sJ/cCvOaqicb5Q5J+oXOKizOJ2E76bO+Q9eCkMpL9qCrV/cA4rRKVKuZPT6MlO
	nd2yt4nGzuvCOIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 671FB13890;
	Mon, 25 Nov 2024 15:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T1L1GAWeRGfJZgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 25 Nov 2024 15:55:49 +0000
Date: Mon, 25 Nov 2024 16:55:44 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mark Harmstone <maharmstone@fb.com>,
	Omar Sandoval <osandov@osandov.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 1/2] btrfs: fix use-after-free in
 btrfs_encoded_read_endio
Message-ID: <20241125155544.GB31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731407982.git.jth@kernel.org>
 <7a14a2b897cbeb9a149bed18397ead70ec79345a.1731407982.git.jth@kernel.org>
 <5616e932-fbeb-4c97-8966-6b8b99ec145c@gmx.com>
 <6527d44b-c046-496b-8a6a-3bfa104d3770@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6527d44b-c046-496b-8a6a-3bfa104d3770@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,kernel.org,vger.kernel.org,suse.com,fb.com,osandov.com,wdc.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Nov 13, 2024 at 08:01:29AM +0000, Johannes Thumshirn wrote:
> On 12.11.24 21:51, Qu Wenruo wrote:
> >> To fix this, move the call to bio_put() before the atomic_test operation
> >> so the submitter side in btrfs_encoded_read_regular_fill_pages() is not
> >> woken up before the bio is cleaned up.
> >>
> >> Also change atomic_dec_return() to atomic_dec_and_test() to fix the
> >> corruption, as atomic_dec_return() is defined as two instructions on
> >> x86_64, whereas atomic_dec_and_test() is defined as a single atomic
> >> operation.
> > 
> > This means we should not utilize "atomic_dec_return() == 0" as a way to
> > do synchronization.
> 
> At least not for reference counting, hence recount_t doesn't even have 
> an equivalent.
> 
> > And unfortunately I'm also seeing other locations still utilizing the
> > same patter inside btrfs_encoded_read_regular_fill_pages()
> > 
> > Shouldn't we also fix that call site even just for the sake of consistency?
> 
> I have no idea, TBH. The other user of atomic_dec_return() in btrfs is 
> in delayed-inode.c:finish_one_item():
> 
>        /* atomic_dec_return implies a barrier */
>        if ((atomic_dec_return(&delayed_root->items) <
>             BTRFS_DELAYED_BACKGROUND || seq % BTRFS_DELAYED_BATCH == 0))
>                cond_wake_up_nomb(&delayed_root->wait);
> 
> And that one looks safe in my eyes.

A safe pattern where atomic_dec_return() is when once reaching 0 there
will be no increment. Which is for example when setting the pending
counter, possibyl adding e.g. pages one by one (atomic_inc) and then
starting that. Each processed page then decrements the counter, once all
are done the 0 will be there.

There are atomic_dec_return() that could be wrong, I haven't examined
all of them but it seems to be always safer to use
atomic_dec_and_test().

