Return-Path: <linux-btrfs+bounces-13467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DC0A9F402
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34CD07A408E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D77027979E;
	Mon, 28 Apr 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IRs2gL/l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vXpVP0uT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IRs2gL/l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vXpVP0uT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00733189BAC
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852570; cv=none; b=ISh4ZH5t8EGCKO13CWpGOYilPibO8kRmkj5bwVio9Kh2lBYO/ToTLAknMKMdAbkqMUAALAxKUxZvE5SZBgglZ4Ngd8XAP0cgolYEU4ipOyayhn21JhSOD8fZu2uw0aE5RRalahy2HQHMZ+n2Z7SxXRu3q3F0In1ofkbF8hgNuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852570; c=relaxed/simple;
	bh=K0i6N6XU/eo+JUwWVPtNBjxcS3VAlT6S7AcsTS0MjJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRVdPK1q6C27FaKO9slYEgfDQwqnp8LiPnlrgPLA6Y4q+8Zg1cyzD4zYcLrxpZToyCPVVJA6U9i5ywAG2Eth1BEwDPqwZvuVgTmMZqCguYZTrXUhO6qJMURDo+3cefM0wYZtTURxr08d9nm1lXLUa/Ktlf1kCPU6ppd3hpTH8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IRs2gL/l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vXpVP0uT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IRs2gL/l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vXpVP0uT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36B5321202;
	Mon, 28 Apr 2025 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745852567;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DlCcLKUjlD1OxNHq0D8n3cf+N2ql/QeYWJgB4UAAMsQ=;
	b=IRs2gL/lp/hOjHgeg7Dv3IJQI702xSVxGuwV26VjHeZRBDs65X1BvxZ2Rs2cuxfWrVfWpI
	FGNwIemtVkMDHyYcyQos++rRJ4A5WXT1LfKgGw7SNXRWjmsWDkTPwazii2FL9NGDR7Szqm
	uzFEGWPcUtHKuODZGH+BhvceDrRhccQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745852567;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DlCcLKUjlD1OxNHq0D8n3cf+N2ql/QeYWJgB4UAAMsQ=;
	b=vXpVP0uTDoQSKKrFFMJtCdl8rF2//Meb8elg2OP3Go3ZhnwRlMu4bfKB7tvmPy49Kf/Kto
	fKA8UAKSw+7yerDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="IRs2gL/l";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vXpVP0uT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745852567;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DlCcLKUjlD1OxNHq0D8n3cf+N2ql/QeYWJgB4UAAMsQ=;
	b=IRs2gL/lp/hOjHgeg7Dv3IJQI702xSVxGuwV26VjHeZRBDs65X1BvxZ2Rs2cuxfWrVfWpI
	FGNwIemtVkMDHyYcyQos++rRJ4A5WXT1LfKgGw7SNXRWjmsWDkTPwazii2FL9NGDR7Szqm
	uzFEGWPcUtHKuODZGH+BhvceDrRhccQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745852567;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DlCcLKUjlD1OxNHq0D8n3cf+N2ql/QeYWJgB4UAAMsQ=;
	b=vXpVP0uTDoQSKKrFFMJtCdl8rF2//Meb8elg2OP3Go3ZhnwRlMu4bfKB7tvmPy49Kf/Kto
	fKA8UAKSw+7yerDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0938F13A25;
	Mon, 28 Apr 2025 15:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5lAIApeYD2gEAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 28 Apr 2025 15:02:47 +0000
Date: Mon, 28 Apr 2025 17:02:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Kees Cook <kees@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] btrfs: compression: Adjust cb->compressed_folios
 allocation type
Message-ID: <20250428150241.GC7139@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250426062328.work.065-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426062328.work.065-kees@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 36B5321202
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Apr 25, 2025 at 11:23:29PM -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct folio **" but the returned type will be
> "struct page **". These are the same allocation size (pointer size), but
> the types don't match. Adjust the allocation type to match the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Added to for-next, thanks.

