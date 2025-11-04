Return-Path: <linux-btrfs+bounces-18603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4AFC2E900
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 01:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B449234B494
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 00:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E85448CFC;
	Tue,  4 Nov 2025 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i+Js2kag";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D0NloXk3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i+Js2kag";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D0NloXk3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5F20311
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215489; cv=none; b=YLKUSmTWAn6mj/Q3/lMnDy8tIkNAOTlpz7Xt6lqX62wsJYWeYISuONq/n74ffNwMMITjmIuS+i6CXQlQXgwGtvF+KujYLjqqYocJTRhJGrI2eWP4HCojgoy1X/TLm1EpPrPdDgpERil5hg7qRS5rNB+pZnWfmEYaMFbTGoeR0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215489; c=relaxed/simple;
	bh=DIybKqsOv5ZP5SQJ/0zU1HAOaDwoPp1CB30t9+caZVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cv+Yg2pbPpnd8EzHSCgLUE1+P1mmjITZzyW4alH5uP9lKMYhbYsvC2aNpeHtIf0ffyYiy6Pn5DPz2UQ1czrgwdp+3chAlSqktvImFsPq1bUsE01Dv0Lfnl0OfXJPMn9BguOl0p7un4tjc6KzZF+TYcUpFZnex3TFjOslsNmUCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i+Js2kag; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D0NloXk3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i+Js2kag; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D0NloXk3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B85D12128B;
	Tue,  4 Nov 2025 00:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762215485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qBkh+VPC0L7lilKwKnFHdQGAX9w0BnkehFZ6H9L4j0=;
	b=i+Js2kagrJ7GtfymiY+3EVKtQh9JNYveq9u++TjsiHr+olDUgZGI6x3kTPa16R2t59h3A8
	6xYikcfge7yK2GXj+hw7tOQFZkognFs/NPgHJxksiSTmlUELKWDsz7XDySToTNZA4LSHe4
	Z4IhYL3dx/MgeD+kSWf4mTHtRm96+qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762215485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qBkh+VPC0L7lilKwKnFHdQGAX9w0BnkehFZ6H9L4j0=;
	b=D0NloXk3v16y+rtc2Ofz2zNaoK+nj1nmW3vPcrkWWRG6UDFKAKk7GqBnFQJNsi00CJ+bJL
	SUQZrYclKj9xUUAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i+Js2kag;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D0NloXk3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762215485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qBkh+VPC0L7lilKwKnFHdQGAX9w0BnkehFZ6H9L4j0=;
	b=i+Js2kagrJ7GtfymiY+3EVKtQh9JNYveq9u++TjsiHr+olDUgZGI6x3kTPa16R2t59h3A8
	6xYikcfge7yK2GXj+hw7tOQFZkognFs/NPgHJxksiSTmlUELKWDsz7XDySToTNZA4LSHe4
	Z4IhYL3dx/MgeD+kSWf4mTHtRm96+qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762215485;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qBkh+VPC0L7lilKwKnFHdQGAX9w0BnkehFZ6H9L4j0=;
	b=D0NloXk3v16y+rtc2Ofz2zNaoK+nj1nmW3vPcrkWWRG6UDFKAKk7GqBnFQJNsi00CJ+bJL
	SUQZrYclKj9xUUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C9DB1388E;
	Tue,  4 Nov 2025 00:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H8INJj1GCWnkEQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 04 Nov 2025 00:18:05 +0000
Date: Tue, 4 Nov 2025 01:18:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: make ASSERT no-op in release builds
Message-ID: <20251104001800.GM13846@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251102073904.2149103-1-foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102073904.2149103-1-foxido@foxido.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B85D12128B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Sun, Nov 02, 2025 at 10:38:52AM +0300, Gladyshev Ilya wrote:
> The current definition of `ASSERT(cond)` as `(void)(cond)` is redundant,
> since these checks have no side effects and don't affect code logic.

Have you checked that none of the assert expressions really don't have
side effects other than touching the memory?

> However, some checks contain READ_ONCE or other compiler-unfriendly
> constructs. For example, ASSERT(list_empty) in btrfs_add_dealloc_inode
> was compiled to a redundant mov instruction due to this issue.
> 
> This patch defines ASSERT as BUILD_BUG_ON_INVALID for !CONFIG_BTRFS_ASSERT
> builds. It also marks `full_page_sectors_uptodate` as __maybe_unused to
> suppress "unneeded declaration" warning (it's needed in compile time)
> 
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
> Changes from v1:
> - Annotate full_page_sectors_uptodate as __maybe_unused to avoid
>   compiler warning
> 
> Link to v1: https://lore.kernel.org/linux-btrfs/20251030182322.4085697-1-foxido@foxido.dev/
> ---
>  fs/btrfs/messages.h | 2 +-
>  fs/btrfs/raid56.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
> index 4416c165644f..f80fe40a2c2b 100644
> --- a/fs/btrfs/messages.h
> +++ b/fs/btrfs/messages.h
> @@ -168,7 +168,7 @@ do {										\
>  #endif
>  
>  #else
> -#define ASSERT(cond, args...)			(void)(cond)
> +#define ASSERT(cond, args...)			BUILD_BUG_ON_INVALID(cond)

I'd rather have the expression open coded rather than using
BUILD_BUG_ON_INVALID, the name is confusing as it's not checking build
time condtitons.

