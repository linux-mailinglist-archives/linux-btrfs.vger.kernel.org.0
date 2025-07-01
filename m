Return-Path: <linux-btrfs+bounces-15162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C8AEFCC1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 16:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0E71C000DF
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 14:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ACA22759C;
	Tue,  1 Jul 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="glcS/nFX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o5LhHhK2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QtT0A/i/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZmhrIHo/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F3199FAB
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380728; cv=none; b=bnSz9YbisbWfqUnzqzZ4gtoGuntpGifugVGoR3ay6deyu9bL2P+0B6mDZyu5rloH+MmLgmDYqL2tsvbE/pi/T5t0jbuG1m5Av1wuqX/16X0St3SGYDIc8Gm4aSAyoJoqpGOfqCyJbfVkGCJrJOCLsoE4fa5aWxiiaHE24KPhgSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380728; c=relaxed/simple;
	bh=7r5OWTmB5j/no898NepssjAXzHOqhhass3aXK9XAH3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST7R2Vi3JdnbwDVFWSEk7HWNWbu4YyJqYUUWhvKp6sDYwob+Ap9gYXEqKX50DXrvqDV0PN6yOGkp80WWjVcXKc5z61vKKQNsA82dstp/ywKf7SSDfbTj7qu2mz5FY6EY0SVzsJHTg88BmNxWMtEkakNQyREnL2s4pTlJdkuupNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=glcS/nFX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o5LhHhK2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QtT0A/i/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZmhrIHo/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0433321163;
	Tue,  1 Jul 2025 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751380725;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpQs+cBR7JTLrZWJAWCkuKf9EVIJ0RxGJ/VJ/doUv58=;
	b=glcS/nFX4/eKNWwt3ru622M7y8wbqtEXw7me+gFuFPQWa4caLzxPuK6DvWSnwQTw8XUgzZ
	Oy5YV+N9MggiZPfjCFKEtorKFbVqsP4LTnUhLPp2dbCQUoNQzcFwtkdQVjSm32xNpRaFeW
	su3H9l9/GulBoAddGtGnUU7Klmz4Zi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751380725;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpQs+cBR7JTLrZWJAWCkuKf9EVIJ0RxGJ/VJ/doUv58=;
	b=o5LhHhK25l+Zw0IXARz79mLibKhkIFuFDX99LzljdeZC7W4OB789t/XQxv7ZFIMp3yJAdf
	TvdDHPpMezwVoyCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="QtT0A/i/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ZmhrIHo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751380724;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpQs+cBR7JTLrZWJAWCkuKf9EVIJ0RxGJ/VJ/doUv58=;
	b=QtT0A/i/rsaXgH2GrrWsGbalBi4fsoPsd/cW3R+L2SsQkLXPNPq/Y8dC7APw68niHw4dhM
	pUWBRJ50lYThKMzZPjDWKvXUmswOTSQ6aH3l08smMiik/McsH220LfDTyCuZ+36pO4ew4E
	IO8E22TKpKBMktJHjCMZv5JwRXiBN88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751380724;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KpQs+cBR7JTLrZWJAWCkuKf9EVIJ0RxGJ/VJ/doUv58=;
	b=ZmhrIHo/9fh3ubwssLFMUXaNI8xawmprZvGb6/hWbmi1qvWMCmHWZGyRaIMB8B+GFlq4R9
	55oOkrMjxWh673Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7CCF1364B;
	Tue,  1 Jul 2025 14:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id joBgOPPyY2i6EwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Jul 2025 14:38:43 +0000
Date: Tue, 1 Jul 2025 16:38:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 0/8] btrfs: use fs_holder_ops for btrfs
Message-ID: <20250701143842.GP31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751261286.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751261286.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0433321163
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, Jun 30, 2025 at 02:59:04PM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v6:
> - Fix an error handling bug that can lead to use-after-free
>   Reported by syzbot, that inside btrfs_get_tree_super() that if we
>   didn't open the devices, there are corner cases that
>   fs_info->fs_devices can be freed twice, causing use-after-free bug.
> 
>   This one fixed two error paths:
>   * sget_fc() failure
>     Which is not the one reported by syzbot, but still possible to hit.
> 
>   * btrfs_open_devices() failure
>     Which I believe is the one reported by syzbot.
> 
>   There is a dedicated fix pushed into linux-next.
> 
>   This refreshed series is for the proper merge into our for-next
>   branch.

Updated in linux-next. There were some conflicts between branches so
this got a bit delayed. If there are no significant problems found,
please add the branch to for-next by Friday or on Monday at the latest.
Thanks.

