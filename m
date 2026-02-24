Return-Path: <linux-btrfs+bounces-21887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO+UBnvcnWmuSQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21887-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:14:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159EF18A62A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DA70306106D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023C70809;
	Tue, 24 Feb 2026 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uDBz5b0H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UcIjirxZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uDBz5b0H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UcIjirxZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7EC3A9631
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952819; cv=none; b=m07AtPmSsQSxDuInS7tDN+T8O1SsRBTjfcmWCglB+KfqS8EmDjfG0QHYJ+k1h9DGLHy3k+Ezd9eblR6+ZN4NgtuRgNZLMi098O9PDwlCeM9enMRVTfnSNu8IJK6s281HivIk44hDcIwrrY6677OnGEoXYsHCZ0SdFk1VVzJMoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952819; c=relaxed/simple;
	bh=+j57NrR6Yv7b5zPqFkfU/9lOJ84v5mWUxHiySTaM8CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWB2asBx7fovITeq7mP2LeswM6COeLzJCZs+rZs6G8TsmXUyTvj1j4aRZlLGc5n51iYLNkXh5Tr2qU2DbOm1BUFBZuUwa2KGOO1jNyAj7Rq+2R3bBYNSYmc4KTl7jP5yn57gK1uJ1BBmHnH1TbnYAcK00HLq9fKwIGzfB24/5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uDBz5b0H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UcIjirxZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uDBz5b0H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UcIjirxZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C85F73F311;
	Tue, 24 Feb 2026 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771952814;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2NaTwTzeciWkLRIAAkJLzsvgR8QeFT8QC4CsubsRacE=;
	b=uDBz5b0HLWmUChCE3NixXPwN76dT5u8oDvCjGIMnBZv4dBmzJ20XCkaSyA1IjkSVAN0b7k
	kMHxFVdGrz2koof/CShsXZn5NsA773fxkmWR7djvSi1g9vAb8HyO4sDIFJVh/JzZWsrxA6
	Enj7wnI9BCmQj942mFwdY6hPopLLMzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771952814;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2NaTwTzeciWkLRIAAkJLzsvgR8QeFT8QC4CsubsRacE=;
	b=UcIjirxZNA9TSTPa9gG6mm3TKd6ZnzcnmUJcG46eQEOsGiOkRW/1vCP7+H4TnRd/VqM/zP
	+BcFgH9BTod3m5Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uDBz5b0H;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UcIjirxZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771952814;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2NaTwTzeciWkLRIAAkJLzsvgR8QeFT8QC4CsubsRacE=;
	b=uDBz5b0HLWmUChCE3NixXPwN76dT5u8oDvCjGIMnBZv4dBmzJ20XCkaSyA1IjkSVAN0b7k
	kMHxFVdGrz2koof/CShsXZn5NsA773fxkmWR7djvSi1g9vAb8HyO4sDIFJVh/JzZWsrxA6
	Enj7wnI9BCmQj942mFwdY6hPopLLMzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771952814;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2NaTwTzeciWkLRIAAkJLzsvgR8QeFT8QC4CsubsRacE=;
	b=UcIjirxZNA9TSTPa9gG6mm3TKd6ZnzcnmUJcG46eQEOsGiOkRW/1vCP7+H4TnRd/VqM/zP
	+BcFgH9BTod3m5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6AFD3EA68;
	Tue, 24 Feb 2026 17:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nIWFKK7anWmDdQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 24 Feb 2026 17:06:54 +0000
Date: Tue, 24 Feb 2026 18:06:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@meta.com>
Subject: Re: [PATCH] btrfs: hold space_info->lock when clearing periodic
 reclaim ready
Message-ID: <20260224170653.GZ26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260209130248.29418-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209130248.29418-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21887-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 159EF18A62A
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 08:53:39PM +0800, Sun YangKai wrote:
> btrfs_set_periodic_reclaim_ready() requires space_info->lock to be held,
> as enforced by lockdep_assert_held(). However, btrfs_reclaim_sweep() was
> calling it after do_reclaim_sweep() returns, at which point
> space_info->lock is no longer held.
> 
> Fix this by explicitly acquiring space_info->lock before clearing the
> periodic reclaim ready flag in btrfs_reclaim_sweep().
> 
> Fixes: 19eff93dc738 ("btrfs: fix periodic reclaim condition")
> Reported-by: Chris Mason <clm@meta.com>
> Closes: https://lore.kernel.org/linux-btrfs/20260208182556.891815-1-clm@meta.com/

Please use Link: for the original report unless the tag is known to be
used for some sort of automation, e.g. what syzbot does.

> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

Added to for-next, thanks.

