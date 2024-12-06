Return-Path: <linux-btrfs+bounces-10104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF099E795E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 21:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360D21883675
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 20:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B161D6DBC;
	Fri,  6 Dec 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ttt28QrT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FIeaRntn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ttt28QrT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FIeaRntn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7754D145B07
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515202; cv=none; b=IlylSTDxhA4NxOAiBl/pSwkWK1ncEhW/pQgaFpO0ph/RAdtCHrNuueWUiw4Sk5lEGOH2/tZCc5l6xfbATN9ROzB7KgfSZirzeyzlxKRDsiz6ei0/ZzXt+Ni6qnYS6vh3WIHtygbOlC51B0QKc0U07tLgnOFc4YDmOHinLhDnMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515202; c=relaxed/simple;
	bh=EhyaL4pLTD1OVyzbnA8XHIBu3aJBGxeazKxYE/HiKEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT2e0QLW/VGyy3tD4xRyp049oB7/FLfWsOY9G/FcjwcJGEv0hpcu/5RSRcL+jNAaBHyBGXME+Ds48oTvB2sdNJ+0hOhXjqU9deAKyTMwhswp+j3eWYzgNrTU0iT+GgWbilNBOuy6CWrPDWq08rMAzAIJPQfnxk2065vfYfpcHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ttt28QrT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FIeaRntn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ttt28QrT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FIeaRntn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9234121158;
	Fri,  6 Dec 2024 19:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733515198;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHsWBtkeedRsQIINpjrnWZGwWtpHuem9Kbgx1e0FT7U=;
	b=ttt28QrTpOl5TZr23e6WADyon/8l9nYNfUQbXNDoxlUw8ri+ircyofaU3xW9qZ13lkKP7Q
	qi3u9ZKM7lv6ot+om46JK8rRsYZXPH0TzxO3Z91xgJDkHo2FF4paLuc9SM4zdar05EnOAR
	W3uVfD5RdFeEviuaozAGbiq1KZ571wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733515198;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHsWBtkeedRsQIINpjrnWZGwWtpHuem9Kbgx1e0FT7U=;
	b=FIeaRntn2iX4E/3WACbKHHwEhp+4S5660i1cH3VppzclAYIWRsUzCSt4bqN47ERLgllBgs
	4S2KywGtwGS+V/Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733515198;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHsWBtkeedRsQIINpjrnWZGwWtpHuem9Kbgx1e0FT7U=;
	b=ttt28QrTpOl5TZr23e6WADyon/8l9nYNfUQbXNDoxlUw8ri+ircyofaU3xW9qZ13lkKP7Q
	qi3u9ZKM7lv6ot+om46JK8rRsYZXPH0TzxO3Z91xgJDkHo2FF4paLuc9SM4zdar05EnOAR
	W3uVfD5RdFeEviuaozAGbiq1KZ571wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733515198;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHsWBtkeedRsQIINpjrnWZGwWtpHuem9Kbgx1e0FT7U=;
	b=FIeaRntn2iX4E/3WACbKHHwEhp+4S5660i1cH3VppzclAYIWRsUzCSt4bqN47ERLgllBgs
	4S2KywGtwGS+V/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D4F813647;
	Fri,  6 Dec 2024 19:59:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4vZTHr5XU2cZRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Dec 2024 19:59:58 +0000
Date: Fri, 6 Dec 2024 20:59:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: open-code btrfs_copy_from_user()
Message-ID: <20241206195949.GO31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3fd6e78c94b60e15e11ee2d792ced71a367b764d.1730952267.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fd6e78c94b60e15e11ee2d792ced71a367b764d.1730952267.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 07, 2024 at 02:35:07PM +1030, Qu Wenruo wrote:
> The function btrfs_copy_from_user() handles the folio dirtying for
> buffered write. The original design is to allow that function to handle
> multiple folios, but since commit "btrfs: make buffered write to copy one
> page a time" there is no need to support multiple folios.

The patch has been merged and now has stable commit id
c87c299776e4d75bcc5559203ae2c37dc0396d80
> 
> So here open-code btrfs_copy_from_user() to
> copy_folio_from_iter_atomic() and flush_dcache_folio() calls.
> 
> The short-copy check and revert are still kept as-is.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> ---
>  fs/btrfs/file.c | 64 +++++++++++++------------------------------------
>  1 file changed, 17 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fbb753300071..10d51c8dd360 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -37,52 +37,6 @@
>  #include "file.h"
>  #include "super.h"
>  
> -/*
> - * Helper to fault in page and copy.  This should go away and be replaced with
> - * calls into generic code.
> - */
> -static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
> -					 struct folio *folio, struct iov_iter *i)

The function gets removed but there's one stray mention of its name at
btrfs_dirty_folio() comment.

