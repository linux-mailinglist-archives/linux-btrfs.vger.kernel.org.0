Return-Path: <linux-btrfs+bounces-20338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6079D0B7C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 18:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4D48302386A
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D337364038;
	Fri,  9 Jan 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="amdheF8g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+UKP/MQv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="amdheF8g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+UKP/MQv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395731280D
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978218; cv=none; b=baFlVaZB4CsA4+A+WLJuS+d+iM4t2slzLLK7R031e5FaHSNMRKDohnydZPhs5heVRpvcOTI07vr8M5ITcetiHWfwNu1y1fWYJnQizyyUOmeYhLZxWD4mGCLcq2DpL+n+JrzRa3V8AxF5Q/FSK374bN695+eOhK4d9mr0wCfvwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978218; c=relaxed/simple;
	bh=PN2zWstCKMETGbfBCXjAtG7Hv6TMDJh95GMrxlu8ne8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpRMJ8MihKi6ySAow6A7Wop24AEQj9k7hyGcGeYTMkca1tAfoOfFtxwNDHE+rLgh7LuNVYmvfzRqotujKkMgPgFf7DPS2wiq3kF9jaRWIx10rFmbbR3ZixO1I0jj3x6LQBMcIkY+tuiWDJVISxSRDkl3vO3HvURv9s4VC+W8yfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=amdheF8g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+UKP/MQv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=amdheF8g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+UKP/MQv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7448F33AAE;
	Fri,  9 Jan 2026 17:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767978215;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEKbm0x9b2pBVqJR3Rlw8llzun9TrQaXQwyooEi7eps=;
	b=amdheF8gLtUsCYKwyR50U8bAzUUkyLH/oP4pPCnGQi+4d8BII2AuYLqYl4Elqy7xvy4th4
	Ye9dn3PEnXz3L44c7kRsklD2mUxGxiLvoGOJ2JC2YQ4jWOa2kTKIg1mXgt0fulnBM8SIfp
	hu8SfVVtt1dcBR4jZr3m62ypuQi3XiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767978215;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEKbm0x9b2pBVqJR3Rlw8llzun9TrQaXQwyooEi7eps=;
	b=+UKP/MQvIMB9ugJ5Tv09JNCgfsBhWGAFahITY/FaAtI4A71uuRtudT0Pf0G703uTgak25G
	8YFyt4SH7pY+xWCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=amdheF8g;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="+UKP/MQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767978215;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEKbm0x9b2pBVqJR3Rlw8llzun9TrQaXQwyooEi7eps=;
	b=amdheF8gLtUsCYKwyR50U8bAzUUkyLH/oP4pPCnGQi+4d8BII2AuYLqYl4Elqy7xvy4th4
	Ye9dn3PEnXz3L44c7kRsklD2mUxGxiLvoGOJ2JC2YQ4jWOa2kTKIg1mXgt0fulnBM8SIfp
	hu8SfVVtt1dcBR4jZr3m62ypuQi3XiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767978215;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEKbm0x9b2pBVqJR3Rlw8llzun9TrQaXQwyooEi7eps=;
	b=+UKP/MQvIMB9ugJ5Tv09JNCgfsBhWGAFahITY/FaAtI4A71uuRtudT0Pf0G703uTgak25G
	8YFyt4SH7pY+xWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6683B3EA63;
	Fri,  9 Jan 2026 17:03:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rFPYGOc0YWkcRgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 09 Jan 2026 17:03:35 +0000
Date: Fri, 9 Jan 2026 18:03:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update the Kconfig string for
 CONFIG_BTRFS_EXPERIMENTAL
Message-ID: <20260109170334.GS21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0dcb589d5f20e70bca6f95c7c6919efa0bedd663.1767929472.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dcb589d5f20e70bca6f95c7c6919efa0bedd663.1767929472.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7448F33AAE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Fri, Jan 09, 2026 at 02:01:14PM +1030, Qu Wenruo wrote:
> The following new features are missing:
> 
> - Async checksum
> 
> - Shutdown ioctl and auto-degradation
> 
> - Larger block size support
>   Which is dependent on larger folios.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

