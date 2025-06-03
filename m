Return-Path: <linux-btrfs+bounces-14427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CAFACCE26
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 22:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4E216D40B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E1221DBD;
	Tue,  3 Jun 2025 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wUSfXyBw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I9q7De5Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wUSfXyBw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I9q7De5Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1BEC2E0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982357; cv=none; b=h2+FiTm7DbZJdAehtG9UsAdx2tOVyzIE5UKqASpexbapCGHyzM2eiwFrkyd5W6lfPHmv9ZNOpzPRlQq8pRfyujhq/QUzsrT8baBKqsDRPX8VjJWV0vJnCGNsjgySHb/9nO2fOk40jmtc+5ZNAFvPasdAs3V+16B2QJD20Wy3ywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982357; c=relaxed/simple;
	bh=aChvu6Xl5YGXJE+K554IiFSpDPZUcnp1pSAYAbukR6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRm3tfkpIAGkm/4OLCQdekSV4ocW70fcG5Pwiv1MfchcZ18CA9GH3ZlavzJ2yc9yhbzjLl48xbqMcl6fDJiK9MoQ7AQ+Cg/oKtcqOLf8mHecGUwzIeDCj4gEtUpOEAXJaxT4tLFsuZj6bDI4/j87ezVxR1gyF11tIYRekxff2XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wUSfXyBw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I9q7De5Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wUSfXyBw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I9q7De5Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71F111FD09;
	Tue,  3 Jun 2025 20:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748982353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMIoH9Um1Yy3RMNop20o4YTc/N/YKlI90Te+qSh0UjE=;
	b=wUSfXyBwbBMz6krV7JqwG7x1Ec7I1sLmN2unx269F5wT+XfeamNiQrBpRVZaTWbcYHpSml
	fbjGr94VAjZ3RfZYnTFZWJ1jp2bsobFRubBRkDliisR8HO3VtA61+hzGQvExDzzMHJxJEi
	z1K/qIoi7/XkfHJkKFywkCEjv0bSvV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748982353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMIoH9Um1Yy3RMNop20o4YTc/N/YKlI90Te+qSh0UjE=;
	b=I9q7De5QycAIIe51Y7C7IRjS6sexeXQg6Or2wPLt/O2FjKzGYw2HYqIywHc1HesAwe1ohz
	X7Byw3shu2huFkAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wUSfXyBw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=I9q7De5Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748982353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMIoH9Um1Yy3RMNop20o4YTc/N/YKlI90Te+qSh0UjE=;
	b=wUSfXyBwbBMz6krV7JqwG7x1Ec7I1sLmN2unx269F5wT+XfeamNiQrBpRVZaTWbcYHpSml
	fbjGr94VAjZ3RfZYnTFZWJ1jp2bsobFRubBRkDliisR8HO3VtA61+hzGQvExDzzMHJxJEi
	z1K/qIoi7/XkfHJkKFywkCEjv0bSvV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748982353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMIoH9Um1Yy3RMNop20o4YTc/N/YKlI90Te+qSh0UjE=;
	b=I9q7De5QycAIIe51Y7C7IRjS6sexeXQg6Or2wPLt/O2FjKzGYw2HYqIywHc1HesAwe1ohz
	X7Byw3shu2huFkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AE2513A92;
	Tue,  3 Jun 2025 20:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +8v0FVFaP2hSEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Jun 2025 20:25:53 +0000
Date: Tue, 3 Jun 2025 22:25:52 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: use refcount_t type for extent buffers and
 cleanups
Message-ID: <20250603202552.GM4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1748962110.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748962110.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 71F111FD09
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jun 03, 2025 at 03:50:24PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Switch from a bare atomic to refcount_t type to track extent buffer
> reference count and a couple cleanups. Details in the change logs.

Right, apart from the atomic xchg it's a refcount so using the API makes
sense.

> Filipe Manana (3):
>   btrfs: reorganize logic at free_extent_buffer() for better readability
>   btrfs: add comment for optimization in free_extent_buffer()
>   btrfs: use refcount_t type for the extent buffer reference counter

Reviewed-by: David Sterba <dsterba@suse.com>

