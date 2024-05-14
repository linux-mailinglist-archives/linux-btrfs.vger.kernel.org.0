Return-Path: <linux-btrfs+bounces-4972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8FA8C5928
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 17:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691AC1F2176C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94517F39C;
	Tue, 14 May 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fvommDX9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sBNV+5SO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K7s26ZmJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i3mZ5z05"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403217F381
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702222; cv=none; b=YutM7WGq0ZkjDYKZ9qFNWllqdvdCPvaiYNjD/3OAt0v2uR7g4N9V63P1r2f/Lti/jQV/m+Vm/00Xsi4DQjuaKQ0vXh2Vjxb0WHPBLb6BftdjW/vOth2tn7fHLySrHCaz0m9oR2uUK/KISBdVb1KPtjQnUkNdXdWZiYm9fUzRYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702222; c=relaxed/simple;
	bh=nc4X6DCcqRGWPeuFAdgkAQoTh3h7D3bUjAIFJtLqSDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiEvy3iyd7b4pk2yhZEze1dJBf1ytmBGi/S4IL1bsygvkMt61e44cBmvXJILHKiNCf0t467YTn9M5jUTO+s5n9tn16kprWyGUcZI1ESogPwKuN0MPFv11PxUyr1X0d8S0gmrvS/sVMlPvVeZJmiRuev3q4/hCJDoK/C9Kn8LPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fvommDX9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sBNV+5SO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K7s26ZmJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i3mZ5z05; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B993B3F03E;
	Tue, 14 May 2024 15:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715702218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nL+8ZYOne7tEz598wBhPyS9OXk2AP7Dsv1tZqsemDfA=;
	b=fvommDX9pxdrrg6bBfnfO2ed9xuQllWkJT1qTtJHeTNYYjDEmHeUtTkHG92pbpvnBf7Iod
	39xSc0VPcdO4DEjzve3m3W67NLGQ4vPFPAUpySONnc7B/Kj/uXnvSUSOQ4rPYqNTukZO3q
	km4DYBNvnebJrxG+aJ2kzNyQcqXpBzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715702218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nL+8ZYOne7tEz598wBhPyS9OXk2AP7Dsv1tZqsemDfA=;
	b=sBNV+5SOZDj+ArJeEb2qdPOG+dBen0vPwnCCiQN6UQqPB+0OS+bLtrpiilNU3Mr6BzNSgD
	iO1y3x0QnTOZozCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715702217;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nL+8ZYOne7tEz598wBhPyS9OXk2AP7Dsv1tZqsemDfA=;
	b=K7s26ZmJlWRm8bSZZIKwt4uxxkd8OypxnrSJOrzZBh8V7lC93WWMt0hZXXA8/5Q1UoyPSS
	+jmynJjxz2r9RmioL1nPWkmVTL9HD8HfROBfFANESscHw52kXi9lwnamFNnqZ61FerZePI
	vnxw6lLL5lnvsEPesYSDIfL4MW0avKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715702217;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nL+8ZYOne7tEz598wBhPyS9OXk2AP7Dsv1tZqsemDfA=;
	b=i3mZ5z05LGZo+cZ+027UfYtPjex+5AkJeeo5AV6hfoouilmejR0SdzgOWAik8b00qkmP6J
	ylptfZHd7ShhSrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE82C137C3;
	Tue, 14 May 2024 15:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v4prKsmJQ2boVQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 14 May 2024 15:56:57 +0000
Date: Tue, 14 May 2024 17:49:36 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 01/10] btrfs: use an xarray to track open inodes in a
 root
Message-ID: <20240514154936.GF4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715362104.git.fdmanana@suse.com>
 <3657cd06e219b9f1c0e423fde8a8a7f53bc3e228.1715362104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3657cd06e219b9f1c0e423fde8a8a7f53bc3e228.1715362104.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.99
X-Spam-Flag: NO

On Fri, May 10, 2024 at 06:32:49PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>

The xarray pattern in this patch seems to solve problem with
preallocation and search, I was stuck on that with the extent buffer
conversion from radix -> xarray, so I'm only clarifying things loud for
myself:

> +	ret = xa_reserve(&root->inodes, ino, GFP_NOFS);
> +	if (ret)
> +		return ret;

Unlocked reservation with NOFS

> +
>  	spin_lock(&root->inode_lock);
> -	p = &root->inode_tree.rb_node;
> -	while (*p) {
> -		parent = *p;
> -		entry = rb_entry(parent, struct btrfs_inode, rb_node);
> +	existing = xa_store(&root->inodes, ino, inode, GFP_ATOMIC);

Locked insertion with preallocation, thus no ATOMIC needed

>  	spin_lock(&root->inode_lock);

...

> +		inode = xa_find(&root->inodes, &from, ULONG_MAX, XA_PRESENT);

Locked search that does not need to handle the preallocated but not
inserted element.

What I did with the delayed inodes tree was xa_reserve + xa_load, this
needs the special handling of potentially finding NULL by xa_load. This
worked for the delayed notes but not for the extent buffers. We'd have
to do special cases for that, loop and wait, but xa_find(..., XA_PRESENT)
seems to be doing exactly that.

