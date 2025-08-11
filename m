Return-Path: <linux-btrfs+bounces-15991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B1B20CC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9BF188564A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293C2DCF44;
	Mon, 11 Aug 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i3p/vBSI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lj1gAKbF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i3p/vBSI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lj1gAKbF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65942D375B
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924265; cv=none; b=KeXCG/5eanVvGHWwk6dBpgY2UnwDfvTKq57Tq6vUyoTczdQQEginVkb+2ZYkLbXeixSC1FikjEs/660FdU8SzBqwOtN3ywRdpIYwR0Y/bLSpKg0I5zx4dD/NBL1Mp24jS2DJnIrQfWJ/iWvfs4kCwS0inXNudhpoFl1uTMszsKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924265; c=relaxed/simple;
	bh=cnPKBCPKZV2F0WWtiGPa7t+/2wattUDd3fJ9004Vm/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlOjw0VQo08c1AyK3uu+vKPvKVUUF6TL3ns9Az21IcRxJXQGQi0ouqn69EaoU5JS5kBNkurJ3z/rkbkZdSkSrkHTsiC00QWA2uOT7Pf6XoqwuZl1t/emIwWOkngi6c+zulOo6gBOyIytTNDbG0tKxhvGN0YumgcpxDEcA7z2ErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i3p/vBSI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lj1gAKbF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i3p/vBSI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lj1gAKbF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD3DA1F390;
	Mon, 11 Aug 2025 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754924261;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+Reu3IcL/Y+JAohQj7ZyeCe8qUyz6D4OGKsS/QRLRg=;
	b=i3p/vBSIH6Cu/et+Z2/p4nGuysQlzQRI7ZKWU1bASb7I5foeAFGtXOOlF3ZjfJJIxq0yGA
	u5M2BTTbr+q7hvX3qzzvboL59SZY53W4z0ZmkISfOMZvcTzEPERSDlBEIDWzTVs0OmvXU0
	PhdguT9YKneI360t+7A0cjS+3mnwx5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754924261;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+Reu3IcL/Y+JAohQj7ZyeCe8qUyz6D4OGKsS/QRLRg=;
	b=Lj1gAKbFOp7hfp34WmoEfroOl4KF9OknM3ieV5I7Ga8I2NXbjJTw92MqSdbClvwqBUCiCc
	0TRA7Gu7IyHjYFCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="i3p/vBSI";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Lj1gAKbF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754924261;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+Reu3IcL/Y+JAohQj7ZyeCe8qUyz6D4OGKsS/QRLRg=;
	b=i3p/vBSIH6Cu/et+Z2/p4nGuysQlzQRI7ZKWU1bASb7I5foeAFGtXOOlF3ZjfJJIxq0yGA
	u5M2BTTbr+q7hvX3qzzvboL59SZY53W4z0ZmkISfOMZvcTzEPERSDlBEIDWzTVs0OmvXU0
	PhdguT9YKneI360t+7A0cjS+3mnwx5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754924261;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+Reu3IcL/Y+JAohQj7ZyeCe8qUyz6D4OGKsS/QRLRg=;
	b=Lj1gAKbFOp7hfp34WmoEfroOl4KF9OknM3ieV5I7Ga8I2NXbjJTw92MqSdbClvwqBUCiCc
	0TRA7Gu7IyHjYFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D21C113A55;
	Mon, 11 Aug 2025 14:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZNwcM+UEmmguXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 11 Aug 2025 14:57:41 +0000
Date: Mon, 11 Aug 2025 16:57:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: pass btrfs_inode pointer directly into
 btrfs_compress_folios()
Message-ID: <20250811145740.GX6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fd12c8b1c7366dc82b04cc702a82703b3e7d3686.1754822695.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd12c8b1c7366dc82b04cc702a82703b3e7d3686.1754822695.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: DD3DA1F390
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Sun, Aug 10, 2025 at 08:14:57PM +0930, Qu Wenruo wrote:
> For the 3 supported compression algorithms, two of them (zstd and zlib)
> are already grabbing the btrfs inode for error messages.
> 
> It's more common to pass btrfs_inode and grab the address space from it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

