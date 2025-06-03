Return-Path: <linux-btrfs+bounces-14437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF19ACCFFA
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 00:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4381894A61
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD6253937;
	Tue,  3 Jun 2025 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="INRdE9fI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wjkIxx8V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J1550thc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMsA7CEA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FE2C3253
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990770; cv=none; b=ksXLEwXU2HcKBMiuZ2qMCmrNq4OXRq6X3kmynAf+Tb9XflC9Cyet6QT98h0pBdxw5JYdsaDf7IxrOjTjnBM1Yyb7YDbjsSXakKQENZYi8zJDLuM++Ls1CAT/vrBB7GPQAk0ZJlX9mbiX6MV5djP7aXS+vnlF67QHtkvVef0O5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990770; c=relaxed/simple;
	bh=ukRbTl/rGjc8KNo1li3kG8CQSVkPABhQd5YXoKGPrns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ7YIxA2vXLtMcxZtLj38xZARJzDj9O5rkuSyv0UOLewO0zmcJhwhpJ/k11x8S+k5IRE9jk0rv23D0IbRGioCq/zTmzIoHq4hsiFsbGKdRPj4lfAIp+SLFPZybeyY5Jq3U7P2sUOrXJBazGHtyyvQZX0Q1hNEOv6uYAMhTqGI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=INRdE9fI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wjkIxx8V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J1550thc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMsA7CEA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D929D1F38D;
	Tue,  3 Jun 2025 22:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748990767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E296e64qWrNheVMxXk2hD6bB5k2+uzt0S+GZkfgUEmI=;
	b=INRdE9fIrn842/5inDC3ejzvralS8sUAKoR1gj6C/QUj/zoaz+yCpa1YsLjJ6aAvWNo9sg
	XC0cwUNvVkfliSaQWBn6JRwP+06SOnFV/oaGIdcpAOVvfLy5ZgO1rauCs9ewJ/3B19sDDi
	zaDchmhFg4ehBWupjJGAMtjpPwYNB5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748990767;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E296e64qWrNheVMxXk2hD6bB5k2+uzt0S+GZkfgUEmI=;
	b=wjkIxx8VOac1DtiXZuvv6ItWPQfvy6mnUimaVv3k0oXz88nawcs39pd9yjhT5TSL8UYOxI
	2gLwjQ3y+Aj+3fAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J1550thc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZMsA7CEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748990766;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E296e64qWrNheVMxXk2hD6bB5k2+uzt0S+GZkfgUEmI=;
	b=J1550thcPTmbXlghSVjAmDVYquS/oyNq+Wg9wuVB3915+AvU4iKNryN6bM5FAQv8acgGpu
	aQCfc1TgG7YWCk4T10jkvue3EobwKwV0+OzgqiA++aLsh5tOtKrpvpZSJfyHJmzcoXkfXz
	EN4HbFYEV3H/ED8FjB/giozzXJRElec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748990766;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E296e64qWrNheVMxXk2hD6bB5k2+uzt0S+GZkfgUEmI=;
	b=ZMsA7CEAdO/hIJ60sMuNaa2ulWvdL4ShSC8yE0Us5KASRmX2UPeqo4Z//pxnzI2X555cNl
	+CKDkoHQqLgo/cCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C645413A1D;
	Tue,  3 Jun 2025 22:46:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OdI3MC57P2hQOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Jun 2025 22:46:06 +0000
Date: Wed, 4 Jun 2025 00:46:01 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: add helper folio_end()
Message-ID: <20250603224601.GR4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748938504.git.dsterba@suse.com>
 <bb27f76180bb5bc365b4917310c7bc283ba91c6b.1748938504.git.dsterba@suse.com>
 <20250603185442.GA2633115@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603185442.GA2633115@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D929D1F38D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jun 03, 2025 at 11:54:42AM -0700, Boris Burkov wrote:
> > --- a/fs/btrfs/defrag.c
> > +++ b/fs/btrfs/defrag.c
> > @@ -849,7 +849,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
> >  	struct address_space *mapping = inode->vfs_inode.i_mapping;
> >  	gfp_t mask = btrfs_alloc_write_mask(mapping);
> >  	u64 folio_start;
> > -	u64 folio_end;
> > +	u64 folio_last;
> 
> This is nitpicky, but I think introducing the new word "last" in in an
> inconsistent fashion is a mistake.
> 
> In patch 2 at truncate_block_zero_beyond_eof()

In truncate_block_zero_beyond_eof if zero_end is folio_end() exactly
then we don't have to do "zero_end - zero_start + 1" in the length
parameter of folio_zero_range() as the -1 and +1 cancel out.

> and btrfs_writepage_fixup_worker,

Here the page_start and page_end are passed to the extent locking where
the end of the range is "-1" but from what I've seen we're using the
"end" in the variable names.

To avoid confusion I'd rename the folio_start and folio_end in
defrag_prepare_one_folio to lock_start and lock_end so the _last
semantic for ranges does exist.

> you have variables called "X_end" that get
> assigned to folio_end() - 1. Either those should also get called
> "X_last" or this one should have "end" in its name.

