Return-Path: <linux-btrfs+bounces-12775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B702A7AFC1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 22:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2754411AE
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3E266B7B;
	Thu,  3 Apr 2025 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FNRkzoPU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KEXPSI5u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FNRkzoPU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KEXPSI5u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDFA257425
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Apr 2025 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709042; cv=none; b=EFIpe6WOkw7S2pVEJNiJu82IGEtvKv6xQzD1rgjwGLVVfxSKiUAMcoyJTTCDr1VPDtG9Buh96dSaWtXBf1bArrgMXcGrkHBn3Bf2JYSFzTRkZAUOQAHz4Umg8QfQJYzk0FBEHB6+NV5/Hp/q4BMG+eeMQPlBDqs4qr1nprZaefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709042; c=relaxed/simple;
	bh=d8lUFtnuGU+qKcG7YT8E43JldZggmy6jQX82o4cd0E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSibXbMd4NqLCmjePEKAMy5i9gQYWAfLs5OtT0ilyopwtlp9yuP6mMBuLgA1d9WV+3O0K/5ZkdHayzTkFPQ+Trpnu/HhiGjP36qUyAl+ojvd1sfIDXB9WFNBk6n/fXgkokwH31sjlapr3+2uFHjFecvB0zEAv3zNGZbbEgHkKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FNRkzoPU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KEXPSI5u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FNRkzoPU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KEXPSI5u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18CE01F385;
	Thu,  3 Apr 2025 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743709039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqOifOutKdpPWL1O1YO1fHxka0WSdoG+BFgX/u/Y4l4=;
	b=FNRkzoPUoeZOudQ6kfPQr49REeWXpnbkT1OYUSHODcrdkdI15vbV0FzUxtoQDQ1378Qzoa
	me36bUVgtCjZWGyahkmHmoLUdIdcexxPVnoeWFtChIeNyp2f4Co4ZC38IirqjANVYdn5wi
	ryN9zo4Yn9JF4xv6/PI6/Iul/T8z1K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743709039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqOifOutKdpPWL1O1YO1fHxka0WSdoG+BFgX/u/Y4l4=;
	b=KEXPSI5uAZACSHiqHKqsN0w7swQ21WDX9zzSed/ZaVWx7pHTjDpBoxPcaIPr+PKn9/djfY
	lD3/FPzSaQn0gpCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FNRkzoPU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KEXPSI5u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743709039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqOifOutKdpPWL1O1YO1fHxka0WSdoG+BFgX/u/Y4l4=;
	b=FNRkzoPUoeZOudQ6kfPQr49REeWXpnbkT1OYUSHODcrdkdI15vbV0FzUxtoQDQ1378Qzoa
	me36bUVgtCjZWGyahkmHmoLUdIdcexxPVnoeWFtChIeNyp2f4Co4ZC38IirqjANVYdn5wi
	ryN9zo4Yn9JF4xv6/PI6/Iul/T8z1K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743709039;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqOifOutKdpPWL1O1YO1fHxka0WSdoG+BFgX/u/Y4l4=;
	b=KEXPSI5uAZACSHiqHKqsN0w7swQ21WDX9zzSed/ZaVWx7pHTjDpBoxPcaIPr+PKn9/djfY
	lD3/FPzSaQn0gpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F336F13A2C;
	Thu,  3 Apr 2025 19:37:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bxoDO27j7mdnMQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 03 Apr 2025 19:37:18 +0000
Date: Thu, 3 Apr 2025 21:37:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
	clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 40/54] btrfs: reject out-of-band dirty
 folios during writeback
Message-ID: <20250403193717.GS32661@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250403190209.2675485-1-sashal@kernel.org>
 <20250403190209.2675485-40-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403190209.2675485-40-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 18CE01F385
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Apr 03, 2025 at 03:01:55PM -0400, Sasha Levin wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> [ Upstream commit 7ca3e84980ef6484a5c6f004aa180b61ce0c37d9 ]

Please drop this commit from all stable branches, it's relevant only for
testing.

