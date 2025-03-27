Return-Path: <linux-btrfs+bounces-12619-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54DBA73797
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 18:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055CB8802FD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA4221A428;
	Thu, 27 Mar 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Ar3fLmS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7XvFUPbr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Ar3fLmS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7XvFUPbr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9622192F9
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094685; cv=none; b=Y843zS+0Y8iO87Bqy6mCLFfpJABK9yyjkfoa6i7O57Tc2VxWx1aHXlZ74+pp01s+ZEC+8JgcU4oaFlBPZ/HFTFJBiJJVaMzKExk7sN5tyFaZ/DeB3kHUjaZGD9BFdzTOOR54iFELdL7xc9zNYvfwIuPvkTCo6j9iZ1HpxHbbNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094685; c=relaxed/simple;
	bh=aITLMQmxbLv6EnA7yVGoela5rd2WDhDCu+iZuX0gPPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkyXNKcivWOIzLDcZHx4HqEH7Tadk2LoeT2bmrDjKOptwY4sQM/Hpu+n/P+w4edfYQO6Sg30UAegRol6SJV0qNOviwS5qqcAzu7Qf/RL5BFYk1OPVtA0/+G1cQWvJ4fpek+cO0kxADK/ssKdtIzq/X13NLf7CnmEa4+byHO1FiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Ar3fLmS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7XvFUPbr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Ar3fLmS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7XvFUPbr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DA501F388;
	Thu, 27 Mar 2025 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743094682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT/XBgEmv031Fc9s0xgPxZgCxlM9YMRJ7BU/Af8CwnQ=;
	b=0Ar3fLmSh5s2v8xgIFOJFcFvwCaUzw0SJ7qM55NtSEK+35jI6qJXc+zJcK2+uyhTPXIaMX
	zx6+xAPIqy6AKfHbUT7MWFPbqMp65GbhYe+MrQeTF68ONOoNeas7lgj85Lo9+duaFx1Q18
	zbOO4/o9Wa1xbG6ji3blXG9PYoFHZxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743094682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT/XBgEmv031Fc9s0xgPxZgCxlM9YMRJ7BU/Af8CwnQ=;
	b=7XvFUPbr+JGWsimoGwJulqB/3fdyuMbGkloFiRM4hekar/+TJWxHmFG9yvwKyPhdEa075e
	EFWEu9zzdDyZ0kDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0Ar3fLmS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7XvFUPbr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743094682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT/XBgEmv031Fc9s0xgPxZgCxlM9YMRJ7BU/Af8CwnQ=;
	b=0Ar3fLmSh5s2v8xgIFOJFcFvwCaUzw0SJ7qM55NtSEK+35jI6qJXc+zJcK2+uyhTPXIaMX
	zx6+xAPIqy6AKfHbUT7MWFPbqMp65GbhYe+MrQeTF68ONOoNeas7lgj85Lo9+duaFx1Q18
	zbOO4/o9Wa1xbG6ji3blXG9PYoFHZxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743094682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT/XBgEmv031Fc9s0xgPxZgCxlM9YMRJ7BU/Af8CwnQ=;
	b=7XvFUPbr+JGWsimoGwJulqB/3fdyuMbGkloFiRM4hekar/+TJWxHmFG9yvwKyPhdEa075e
	EFWEu9zzdDyZ0kDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D9881376E;
	Thu, 27 Mar 2025 16:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xd7WApqD5WdnEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Mar 2025 16:58:02 +0000
Date: Thu, 27 Mar 2025 17:58:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: extent buffer flags cleanup
Message-ID: <20250327165800.GX32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250325163139.878473-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325163139.878473-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 2DA501F388
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 25, 2025 at 05:31:35PM +0100, Daniel Vacek wrote:
> There are a few leftover extent buffer flags not being meaningfully used
> anymore for some time. Simply clean them up.
> 
> Daniel Vacek (3):
>   btrfs: cleanup EXTENT_BUFFER_READ_ERR flag
>   btrfs: cleanup EXTENT_BUFFER_READAHEAD flag
>   btrfs: cleanup EXTENT_BUFFER_CORRUPT flag

Added to for-next, thanks. Please write more descriptive subject lines,
'cleanup' is too broad, 'remove unused flag' is ok in this case.
Updated in git.

