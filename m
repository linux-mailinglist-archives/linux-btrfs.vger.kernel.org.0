Return-Path: <linux-btrfs+bounces-6858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2553C940123
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 00:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE1A1F2305A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 22:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01D3190063;
	Mon, 29 Jul 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eneCS+PI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mGXYa5NV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UqnO83yy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hKO91JX5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B318F2E5
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292513; cv=none; b=MOnhX4rEGgMC7w6SLxJKXTgMmDf176RW4xL9oCQEJ8H0JhYAzG3oeob775AgmiHZpUyiUfBQSTwXNF+/s9KjV6kDC26aMQ2Z3J6hdoqGlrvpaT+oMvhB6SL3uEnhdVE14odoTvp99hghCYg/i4uIrr2bkSUsTnQlvijftkZO/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292513; c=relaxed/simple;
	bh=+gJKx4BlZYWXFUTvaATdhWXP5SRWZHABlUh33ewssIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXrcdqobAiP6MsuDtUyJf1CrAAuM8qC5OD2LE7ejnnCDtAF8ksS5ICdo8Ltb3UCMckUMNMbMb/JTPH02xxQyi5HVzQVQIxgj3hzpm47i7rbgk2r9R+uyVS+/c40XmnayIfd+1tmrF8xEzGKDxxlyCHcK9ZiC6aRb4/ymuxDo9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eneCS+PI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mGXYa5NV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UqnO83yy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hKO91JX5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1929A21AB3;
	Mon, 29 Jul 2024 22:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722292510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfYkmnZs14vc8wffrfOS4g/UkYMvBsOTRv1ibYTL7H4=;
	b=eneCS+PIKAxHDJALdvXt1sjwKzMXV4TIheqPjnTMlt3AZune7z/pcGt9xWLuGWwSNN9iBO
	9yh2Ud0a5kkVocAb9qakGhmWRiBuj9Sn/8AE+VPsSXZFChiTUAV8hwqB5lLEsW/tZKGqAH
	KBm8Z/3W3IXXOQeZd/eFytU6ILhFR/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722292510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfYkmnZs14vc8wffrfOS4g/UkYMvBsOTRv1ibYTL7H4=;
	b=mGXYa5NVObHEyRhzzTob2hUzy3mnscWUFBg1ZJvsmLtB3IAismHlrXYjllTjLCsA+aikeC
	wtkJJhNInIof9uDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UqnO83yy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hKO91JX5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722292509;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfYkmnZs14vc8wffrfOS4g/UkYMvBsOTRv1ibYTL7H4=;
	b=UqnO83yyjLH/bsL9D7OrTC6SsLxccv6zxXEr4G1CHPRQc9Ez4aT78i3fWqTwDaAFlhJRFF
	mARQ8beX6EocsUW/THk2/VIjpiYkxqd2WMpVu2c9GAc7cVpa0vmJ6kuyhGVCzFAKvai6vw
	uwIpNOGu2a80+r54h1ZbIfF22Sp9sg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722292509;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfYkmnZs14vc8wffrfOS4g/UkYMvBsOTRv1ibYTL7H4=;
	b=hKO91JX5AyRo0fLJrGtHqFFuH1YubBBnVtS/OPDlvAf5vkI42pJR/YbZXG1BnEwPVjNh5M
	rvHwaIXglvUVqyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AF27138A7;
	Mon, 29 Jul 2024 22:35:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xZNxAh0ZqGYmaQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Jul 2024 22:35:09 +0000
Date: Tue, 30 Jul 2024 00:35:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: set transid in btrfs_insert_dir_item
Message-ID: <20240729223507.GW17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240722133320.835470-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722133320.835470-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 1929A21AB3

On Mon, Jul 22, 2024 at 02:33:02PM +0100, Mark Harmstone wrote:
> btrfs_insert_dir_item wasn't setting the transid field in
> btrfs_dir_item. Set it to the current transaction ID rather than writing
> uninitialized memory to disk.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Qu merged it to devel, thanks.

