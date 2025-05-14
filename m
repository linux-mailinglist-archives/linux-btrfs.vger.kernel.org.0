Return-Path: <linux-btrfs+bounces-14018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAD7AB766D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 22:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D5172D4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 20:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5F2951D0;
	Wed, 14 May 2025 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e6i5xZRT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Algp2pcr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZzARZC4a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qE8mqSmR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C81F4623
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253369; cv=none; b=K5EF38KXZRes10W5/a8EaE2H4hvdqCFas5iAejJP1lDxrI+V0cbtnZ1EPpo8FNAI9BYBDuB5/BDz4LeQWF8lyz43cJE57vfZ9Gu93158A0wKg+TESclRksR7CP8dOsHb2ZhX9WwvChGH4p7RA/0H6JQJrPsZOTjiNEy3bXxwfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253369; c=relaxed/simple;
	bh=hki97g+0dXWUgOWh4cYp259WX/rw++zw2n+hwFmAilY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzKOryNSH3n+kYjE3ldU9c6auCgzzc1X59is/wAa+DCx98bqQ5mJAOSMBz7XiLatSO3o/4uNHku0Ab6w2DcerfnX9zELjmADtcb+YKfjYOFYHn2fujJ+Fe8du4PO71iR3wuX4h5xSQQadVuVr+rW1DYutH7u3H+e3wT+1Ehg0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e6i5xZRT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Algp2pcr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZzARZC4a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qE8mqSmR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFC0C1F6E6;
	Wed, 14 May 2025 20:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747253365;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUU5JCmKF5vAa3kokqFXNJ69r0I3NWj5zAgLoKPUmaQ=;
	b=e6i5xZRTWc5hjSfQSDE3B+r/YDqBOB6O3tl68fm8zenJd8aJ3MhzBYnKZ8YsI8GxTeXgEo
	RoEB/W7KRAj2FzpjYA2gcVziBBATdnB0AZ3ufLVhNlZSvb4YIcsR9pVzK+ndBDCgEB22PK
	nhLTwByv6aNhgFkpHFfbiNZLKCNhPng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747253365;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUU5JCmKF5vAa3kokqFXNJ69r0I3NWj5zAgLoKPUmaQ=;
	b=Algp2pcrB8PNUridZ36+mV3JaaZQjRw85X/m62nuBTPQdZSk53L/rr4FJ/hKxLUIWbWzHt
	gsRS0dgNGqGNF9DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZzARZC4a;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qE8mqSmR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747253364;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUU5JCmKF5vAa3kokqFXNJ69r0I3NWj5zAgLoKPUmaQ=;
	b=ZzARZC4a2suluFdXod5JxijF12FC+r/CcBAJ9vaOovD7c1kMMZtBz+KvR3xo690q0k7VIu
	dQD3yVXjVzMxiN+Dpo5qRKqFSKekyiy2iG3zzmKg4UGhrcMcA3N3viIaEWc9ocOUwrkZNV
	WuMmBeQ/acaDVdX0x0U9jUP4knEv4SI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747253364;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tUU5JCmKF5vAa3kokqFXNJ69r0I3NWj5zAgLoKPUmaQ=;
	b=qE8mqSmRkWestJBWNpGHMxNqVjPDxiOMEKypN3OIJOulp/26rbR/Ii3mIRS/2sZg/ydYd4
	B2P1miol/Fd/1gCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D594313306;
	Wed, 14 May 2025 20:09:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i8PgM3T4JGjEdwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 14 May 2025 20:09:24 +0000
Date: Wed, 14 May 2025 22:09:23 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove standalone "nologreplay" mount option
Message-ID: <20250514200923.GE9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <dd6b4aadc3f5ed0eb1d86795c1822d26b2eb02fc.1747194062.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6b4aadc3f5ed0eb1d86795c1822d26b2eb02fc.1747194062.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EFC0C1F6E6
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Action: no action

On Wed, May 14, 2025 at 01:11:03PM +0930, Qu Wenruo wrote:
> Standalone "nologreplay" mount option is marked deprecated since commit
> 74ef00185eb8 ("btrfs: introduce "rescue=" mount option"), which dates
> back to v5.9.
> 
> Furthermore there is no other filesystem with the same named mount
> option, so this one is btrfs specific and we will not hit the same
> problem when removing "norecovery" mount option.
> 
> So let's remove the standalone "nologreplay" mount option.c.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

