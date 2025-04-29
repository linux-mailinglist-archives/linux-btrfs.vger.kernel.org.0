Return-Path: <linux-btrfs+bounces-13497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EF2AA0774
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 11:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE703A4305
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D742BCF47;
	Tue, 29 Apr 2025 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fDmQ4btV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7WbdGYnv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fDmQ4btV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7WbdGYnv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2236C214225
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745919330; cv=none; b=VJFPoiTgVb61MnDqAIk/mfAphCc7ATnUiZkmWjcs+7vHxktt67urLxxfkOUkrcNyCqMNdrVeYIL5iikvJA0nermxzgXq5DS/zMcL4+iwSe8lFE3saPQA9kn19olusAKTXRWJCgkp49EZt+TCxa2koy4n+OPuWnsK/2Bi86sreA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745919330; c=relaxed/simple;
	bh=MyEPStoQjALaLk/dDDI3na1c7FIO7F/Q4D0mSda8vAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqZxaWudwYm+YbTykzwiekh+BUbxdoTLgpB/aDsMjqIVAvjdF2AGESXVUKngGEh0zy0e2oFGRxusJq/m6/Zkf852YnjSJqafZfxnl1fIqd3ZHfXcwbkZmRwZ2C8FIBsL0bIJfDoZb3ejDv+4F7MIp058oTerd7XiLJzdJuaXgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fDmQ4btV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7WbdGYnv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fDmQ4btV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7WbdGYnv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 292A9210ED;
	Tue, 29 Apr 2025 09:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745919327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClxPtmgGIQS5o1NBF4GbbvDvyZEAV5ATOUTtP1ZpBOc=;
	b=fDmQ4btVWA044oXKOssx/nav6vEzVrzPKpKdBuFlyj6ynSnC+HxL+xl39DWegqB2ZZjxbv
	Vg2AUWYfaVhW09noJBaJHFW2uN70a8G8ZIAuzUyU3TSynVpiF75W7Ec06X2bIfdeureqLp
	p5ZLHzN+1mJm0WKJRfNX4pe1vZe01UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745919327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClxPtmgGIQS5o1NBF4GbbvDvyZEAV5ATOUTtP1ZpBOc=;
	b=7WbdGYnvsRPTU2Gu+BvGZYE2g7vGz0b3HXxqBdfLDa6JJh6U08V6+sMr6EO6hYtJ1rxdmT
	1Hy1QvqrVo4mOGAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fDmQ4btV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7WbdGYnv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745919327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClxPtmgGIQS5o1NBF4GbbvDvyZEAV5ATOUTtP1ZpBOc=;
	b=fDmQ4btVWA044oXKOssx/nav6vEzVrzPKpKdBuFlyj6ynSnC+HxL+xl39DWegqB2ZZjxbv
	Vg2AUWYfaVhW09noJBaJHFW2uN70a8G8ZIAuzUyU3TSynVpiF75W7Ec06X2bIfdeureqLp
	p5ZLHzN+1mJm0WKJRfNX4pe1vZe01UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745919327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClxPtmgGIQS5o1NBF4GbbvDvyZEAV5ATOUTtP1ZpBOc=;
	b=7WbdGYnvsRPTU2Gu+BvGZYE2g7vGz0b3HXxqBdfLDa6JJh6U08V6+sMr6EO6hYtJ1rxdmT
	1Hy1QvqrVo4mOGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AA801340C;
	Tue, 29 Apr 2025 09:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zlBBAl+dEGieHAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Apr 2025 09:35:27 +0000
Date: Tue, 29 Apr 2025 11:35:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Bo Liu <liubo03@inspur.com>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Use refcount_t instead of atomic_t for mmap_count
Message-ID: <20250429093525.GC9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250429072033.3382-1-liubo03@inspur.com>
 <021ca5c7-bdf8-4ec1-b59f-dce8333fe158@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <021ca5c7-bdf8-4ec1-b59f-dce8333fe158@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 292A9210ED
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
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Apr 29, 2025 at 05:12:27PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/29 16:50, Bo Liu 写道:
> > Use an API that resembles more the actual use of mmap_count.
> > Found by cocci:
> > fs/btrfs/bio.c:153:5-24: WARNING: atomic_dec_and_test variation before object free at line 155
> 
> Please explain this better, I didn't see anything wrong about the 
> decreasing the atomic to zero then freeing it.

Yeah, we'd need better explanation for that.  The refcount can catch
underflow, which I'm not expecting to happen for the repair bio as it's
set up, sent and the endio is done. We might assert that the
repair_count is 0 right before freeing the bios, but otherwise the
repair_count does not match a refcount semantics.

