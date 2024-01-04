Return-Path: <linux-btrfs+bounces-1242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D425824550
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 16:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9122B23887
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42205249F5;
	Thu,  4 Jan 2024 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VTZ/I1ii";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hlKwc6UG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RUXYmSKX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FGj+GITd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27EC249E0
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0A9D21B5D;
	Thu,  4 Jan 2024 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704383266;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiu893GLBw796oNO0M3A/QP/tgm07Ved8cnsJBsH73o=;
	b=VTZ/I1ii+GiAZe3B/SNQFcp71H/X0wcn4jiQE2BSG3bKI6xVNkLZV7KDVghZZbg04bXQ/S
	zMLvv7G5eNA6IwO1csohGHrbMf4p4RaYjZWUIqzglb8Z8wY1oleGFvjVHOrIs4LG2A+y9f
	9igju2cptp7FgOaACy4ZBoeqQ/Hiw24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704383266;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiu893GLBw796oNO0M3A/QP/tgm07Ved8cnsJBsH73o=;
	b=hlKwc6UGZXKOmWIru7Wmg4REjHIBInxN1oHomG915siKkbGeIwlBi3nm7F7V3YYyRqN0dC
	9xA2ijbX7G2hnhDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704383265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiu893GLBw796oNO0M3A/QP/tgm07Ved8cnsJBsH73o=;
	b=RUXYmSKXJ1vC5COoS9JrNj93YHI/rv/0khay/NWpFglc18lrusyxNfLRTH1H4bia+PrAm+
	409gTEgxX6vxc72rNYRA072Obyc/VyDCRLKJglk9v7+8zpKllEzL+5znGMEo2T1Z03ghvw
	isEWuoUaAMkgf/xAltdfIMRCPbO1mIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704383265;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qiu893GLBw796oNO0M3A/QP/tgm07Ved8cnsJBsH73o=;
	b=FGj+GITdFhVmNduCPQxpI3MFkY1SZY9vvsg4IFVmP4v+1gI0YH/dF9VJufn2aNiYJXQgMi
	x7+hZ/0kC09QAyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C95BE13722;
	Thu,  4 Jan 2024 15:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pGj2MCHTlmWTVAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 04 Jan 2024 15:47:45 +0000
Date: Thu, 4 Jan 2024 16:47:34 +0100
From: David Sterba <dsterba@suse.cz>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: David Sterba <dsterba@suse.com>, Denis Efremov <efremov@linux.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix kvcalloc() arguments order
Message-ID: <20240104154734.GE15380@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231221084748.10094-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221084748.10094-1-dmantipov@yandex.ru>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RUXYmSKX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FGj+GITd
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[yandex.ru];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[35.98%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.cz:dkim];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[yandex.ru];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: E0A9D21B5D
X-Spam-Flag: NO

On Thu, Dec 21, 2023 at 11:47:45AM +0300, Dmitry Antipov wrote:
> When compiling with gcc version 14.0.0 20231220 (experimental)
> and W=1, I've noticed the following warning:
> 
> fs/btrfs/send.c: In function 'btrfs_ioctl_send':
> fs/btrfs/send.c:8208:44: warning: 'kvcalloc' sizes specified with 'sizeof'
> in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
>  8208 |         sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
>       |                                            ^
> 
> Since 'n' and 'size' arguments of 'kvcalloc()' are multiplied to
> calculate the final size, their actual order doesn't affect the
> result and so this is not a bug. But it's still worth to fix it.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Added to misc-next, thanks.

