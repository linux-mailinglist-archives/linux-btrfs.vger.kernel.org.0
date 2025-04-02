Return-Path: <linux-btrfs+bounces-12761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37235A7980B
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 00:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B52171FF5
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 22:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A141F4C9C;
	Wed,  2 Apr 2025 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FJD5CIHY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KDtakxIR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FJD5CIHY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KDtakxIR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34741E8326
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743631351; cv=none; b=a/b7xLLWZYSKbRjn3GZeB7QKCH7TC/oyTTToRMQ0bsEOOtcIRep5h6+WWVvHpSPpz829xp87T2KvcZhVVOboGT2kk7RfoGimRNyv4AVOxHyA7f9ML7/Fky6aNn7zkfgtBwJoNNVffM7ilN1uqIv3eRss2nXwgMEb7OIwkGziy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743631351; c=relaxed/simple;
	bh=wpOSGMiVfbmUmFysCW9yy7TOzVHHFSRigDdbV3WSaeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icIxhunInFaJSoBlpJ/PffwRHBsNnXY5NUxzElVyI9BbhzEoQy9YTjxmatT3ONkXtBOkGVUS81dGYNvDti/d4tzjwpINq//W60cMoFB+Jb0Cb2uwlilqp6n7xfD042SEx47UHZP7YT/pW6yDV4T28yJacIWZ8Afchwd7/5AczEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FJD5CIHY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KDtakxIR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FJD5CIHY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KDtakxIR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE58E211B3;
	Wed,  2 Apr 2025 22:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743631347;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LyGQ0A4972Jnv40UeEt4ixETeJF7cd1Jc5fL6tFVkY=;
	b=FJD5CIHY0WxtYHpH9bRmaGctx78YQ7YTqd+cXW0QBxKu6Uh5jru1jCXmj0tfZ4pE99DW+x
	GuHp9fhIK2elYylVc+6LYW7FZM07mGslOsdPTsxTMWQ/AjFyTfBKXhT9RhRGRGivqhnM5E
	S91arfy3iRzlZ+66xn+KjhiwfXwvGD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743631347;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LyGQ0A4972Jnv40UeEt4ixETeJF7cd1Jc5fL6tFVkY=;
	b=KDtakxIRWp6TLAhvQK/u3doY4d9uECqwz3Zs1PI9evt8CJJiA3/EtTakQLd3FXe7Xazy/B
	OL1bktfj4TwHdqDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743631347;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LyGQ0A4972Jnv40UeEt4ixETeJF7cd1Jc5fL6tFVkY=;
	b=FJD5CIHY0WxtYHpH9bRmaGctx78YQ7YTqd+cXW0QBxKu6Uh5jru1jCXmj0tfZ4pE99DW+x
	GuHp9fhIK2elYylVc+6LYW7FZM07mGslOsdPTsxTMWQ/AjFyTfBKXhT9RhRGRGivqhnM5E
	S91arfy3iRzlZ+66xn+KjhiwfXwvGD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743631347;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LyGQ0A4972Jnv40UeEt4ixETeJF7cd1Jc5fL6tFVkY=;
	b=KDtakxIRWp6TLAhvQK/u3doY4d9uECqwz3Zs1PI9evt8CJJiA3/EtTakQLd3FXe7Xazy/B
	OL1bktfj4TwHdqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B047F13A4B;
	Wed,  2 Apr 2025 22:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AMKMKvOz7WdSMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 02 Apr 2025 22:02:27 +0000
Date: Thu, 3 Apr 2025 00:02:25 +0200
From: David Sterba <dsterba@suse.cz>
To: David Disseldorp <ddiss@suse.de>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: do more trivial BTRFS_PATH_AUTO_FREE
 conversions
Message-ID: <20250402220225.GP32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1743549291.git.dsterba@suse.com>
 <b4a20aa684dc9f0324c7fe4728c1829a8b996f71.1743549291.git.dsterba@suse.com>
 <20250402113951.06f43687.ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402113951.06f43687.ddiss@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Apr 02, 2025 at 11:39:51AM +1100, David Disseldorp wrote:
> Hi David
> 
> On Wed,  2 Apr 2025 01:18:06 +0200, David Sterba wrote:
> 
> > @@ -308,7 +308,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
> >  	bool locked = false;
> >  
> >  	if (block_group) {
> > -		struct btrfs_path *path = btrfs_alloc_path();
> > +		BTRFS_PATH_AUTO_FREE(path);
> >  
> >  		if (!path) {
> >  			ret = -ENOMEM;
> 
> This one looks broken. btrfs_search_slot() needs it allocated.

Sorry, I don't see what you mean. There's no btrfs_search_slot() in
btrfs_truncate_free_space_cache(), perhaps you mean a different
function?

The macro BTRFS_PATH_AUTO_FREE still declares a pointer, only adds the
__cleanup parameter that calls btrfs_free_path() when the variable
leaves its scope. It's not declaring 'path' as plain variable, if I
interpret the comment 'needs it allocated' in that context.

