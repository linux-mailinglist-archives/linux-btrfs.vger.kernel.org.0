Return-Path: <linux-btrfs+bounces-14273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF5BAC6B07
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 15:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB4818909DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 13:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85592882A6;
	Wed, 28 May 2025 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I4t/ixB/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="96nbUur6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I4t/ixB/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="96nbUur6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6B914E2F2
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440313; cv=none; b=qksXornW42jOlE8cvydx1k9Zn2/Z8pXwLVhLM9SwawTjFj8rNqZjBpZ/rp12eC3FobEpANkXjPfhEa+mCZuXYWZGAa8Lwj57xN8sXkr15avp0E58Af+qtfPxMgW9hLKfFB/dMSWUddCOfhdsI42my8u03HIUnRggD2vIhue7S10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440313; c=relaxed/simple;
	bh=Ge1F7sYdP1vOPJQz4XTQLjXxNLEivz7tADj6cUNZw/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qyqm2J77fJAFZsC20aM18lE/ThzYrrnRjAgRrIkWHPrJhnDapdDG64O5ZjIKTPANI1KFJgsa9D9yaJ0Iw57MPUNyH/FPDzfPs+On6Z79eCtYf3+R/DkRxBLtlKgKrug0zzIOcxdEFLVnioIQhlf/Noii+wGPb8Oyh0PjHzA4lM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I4t/ixB/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=96nbUur6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I4t/ixB/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=96nbUur6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BF3E21B0D;
	Wed, 28 May 2025 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748440309;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/OdPAUzrK5rpNEYSb3gfTBBsx7WR2/LOKboupbybwc=;
	b=I4t/ixB/5VQh1SfXQ6jA1Yp3klm9q0tsplCTCpoK3ZqJVTn/Sx8p6WiuFWN5I75CdpiGV6
	2GlQ4P8gJS0QJUuWpfmulq0EeSAiAgaqSqhWw42n9CJljtwyoWSFc53jUPx1aa6HQoOHt6
	R7RUFWOEz6WIrDC+sdH24mC0H8qfs8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748440309;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/OdPAUzrK5rpNEYSb3gfTBBsx7WR2/LOKboupbybwc=;
	b=96nbUur64GA48f4bBbLaHy2GtJeR1dNPmO2EhrGerqYWHDcGO3DIphBxIDCiNY3+COoqwS
	OQEZTndllfNS51Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748440309;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/OdPAUzrK5rpNEYSb3gfTBBsx7WR2/LOKboupbybwc=;
	b=I4t/ixB/5VQh1SfXQ6jA1Yp3klm9q0tsplCTCpoK3ZqJVTn/Sx8p6WiuFWN5I75CdpiGV6
	2GlQ4P8gJS0QJUuWpfmulq0EeSAiAgaqSqhWw42n9CJljtwyoWSFc53jUPx1aa6HQoOHt6
	R7RUFWOEz6WIrDC+sdH24mC0H8qfs8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748440309;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/OdPAUzrK5rpNEYSb3gfTBBsx7WR2/LOKboupbybwc=;
	b=96nbUur64GA48f4bBbLaHy2GtJeR1dNPmO2EhrGerqYWHDcGO3DIphBxIDCiNY3+COoqwS
	OQEZTndllfNS51Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 887D3136E3;
	Wed, 28 May 2025 13:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oE0ZIfUUN2h+QQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 13:51:49 +0000
Date: Wed, 28 May 2025 15:51:44 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: some cleanups for btrfs_copy_root()
Message-ID: <20250528135144.GG4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1747649462.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747649462.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid]
X-Spam-Level: 

On Mon, May 19, 2025 at 11:42:03AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple simple cleanups, details in the change logs.
> 
> Filipe Manana (2):
>   btrfs: unfold transaction abort at btrfs_copy_root()
>   btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()

Reviewed-by: David Sterba <dsterba@suse.com>

