Return-Path: <linux-btrfs+bounces-12063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1477FA55511
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 19:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D0F7A58CD
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F9325D914;
	Thu,  6 Mar 2025 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vYfhG17u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXRRKkpw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vYfhG17u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXRRKkpw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5D136341
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286025; cv=none; b=p4HFnCRMAYLmsNQwW7rZ0/sEco4FqZuyrcMqWCyM4tU8sS3hSAwFqg9Gh2uIvrD1DqdaPuYMl2JP09m55TZVAZvL/7kI5PbaNKqTbgZYy7+SPgAYDUT0M0nGz1Uq6fM96fEy/ijAtDSgVQADYaGWlBwKM62y/rryaUbT6H+lMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286025; c=relaxed/simple;
	bh=jSJegy77y2xOipuCEOgog7ZhZQKd/ph0r0nmGJP2PSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVrP/YO/ke1ek/QEHEyVHvR545oMFvtS1fP1hTx+rvrIQE/WOJWyOYl+ILLXGUw8bDMjw9khKjY7SI+wdYL47vG0o+OZq91km9e42xVEC3ELssh5nqILf63s+2iNBO9jbNzuqmxu4qJPppcQU+9Gv8Gro/LpnoU7eP91KbWYgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vYfhG17u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FXRRKkpw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vYfhG17u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FXRRKkpw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3FA82117D;
	Thu,  6 Mar 2025 18:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741286022;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBpox4NlA0YC4VjqhZvX24I5GotjKmUKqF2+SghWWt4=;
	b=vYfhG17uNoZ1t8u86ZvOIzIuq3ZDkqHEUjInU8eBL4TQyGDk6y4wATI8FMRUYJPly4ypBw
	BK3MmLpklWFnfG2WLkcIp8XjCtaJJ1PAbGR6NpLR6kcQXKrWy1IcMyUdb6lx+MyFM5SQO2
	ma0OA4lKy25TonjuZxX6BfbTMoOnHS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741286022;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBpox4NlA0YC4VjqhZvX24I5GotjKmUKqF2+SghWWt4=;
	b=FXRRKkpwhcDu2Wp8qTYFYPRrtC5Rbnd4gxRJTJsxzk8FXFfWT/tdocjZF4i3hgs2Klw6Q+
	hWgr1ZrH9EdCKjCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741286022;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBpox4NlA0YC4VjqhZvX24I5GotjKmUKqF2+SghWWt4=;
	b=vYfhG17uNoZ1t8u86ZvOIzIuq3ZDkqHEUjInU8eBL4TQyGDk6y4wATI8FMRUYJPly4ypBw
	BK3MmLpklWFnfG2WLkcIp8XjCtaJJ1PAbGR6NpLR6kcQXKrWy1IcMyUdb6lx+MyFM5SQO2
	ma0OA4lKy25TonjuZxX6BfbTMoOnHS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741286022;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBpox4NlA0YC4VjqhZvX24I5GotjKmUKqF2+SghWWt4=;
	b=FXRRKkpwhcDu2Wp8qTYFYPRrtC5Rbnd4gxRJTJsxzk8FXFfWT/tdocjZF4i3hgs2Klw6Q+
	hWgr1ZrH9EdCKjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1CD813676;
	Thu,  6 Mar 2025 18:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lycPM4XqyWdsTwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Mar 2025 18:33:41 +0000
Date: Thu, 6 Mar 2025 19:33:40 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid unnecessary bio dereference at
 run_one_async_done()
Message-ID: <20250306183340.GM5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f0e1ad9fd2ed3e76e041e3f19f493de3e9771057.1741278026.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e1ad9fd2ed3e76e041e3f19f493de3e9771057.1741278026.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 06, 2025 at 04:21:06PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have dereferenced the async_submit_bio structure and extracted the bio
> pointer into a local variable, so there's no need to dereference it again
> when calling btrfs_bio_end_io(). Just use "bio->bi_status" instead of the
> longer expression "async->bbio->bio.bi_status".
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

