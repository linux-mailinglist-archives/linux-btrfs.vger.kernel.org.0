Return-Path: <linux-btrfs+bounces-17418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E508FBB74B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5AF3A8B0F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49828507F;
	Fri,  3 Oct 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q/h8+DAC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dfyptc0M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q/h8+DAC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dfyptc0M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF9283683
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759504514; cv=none; b=N9redzkOa6N8k9wmatjQ5mdNjw+EbT3+GhQJLca87I9pI8BFjoLxlkvu5ci6dPjOap/wMsAf16JLD9ueRNSYkckRYO6fdJizMf81BLjDWQS/wLEb2hH5hCmGynC8Vsj7HhEDM5fXeWMncQ6DzUyMIE5xRNcYpIN2RTsmIIqYTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759504514; c=relaxed/simple;
	bh=C7CfKgcHYLApAV6Hfjkaw2zl7XixfTDgEWSfeNSz2IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjpoJMKRdJ9XhdASHOsKElEcXIsVh1aGM9dgAxy12ZwGZvh9oS2puUJ1zVNLntgqfg8Le3eyxu9slp28Rlng3XTPjg0TZ1+9fnOhLnXu40oiQmq4sTcqR4S4burDZnmxaCCCtrf9MFF3hBtxC5ie5a2e7xjHNs4+SK/P9WEFaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q/h8+DAC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dfyptc0M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q/h8+DAC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dfyptc0M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF8C31F391;
	Fri,  3 Oct 2025 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759504510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSuUcYJ4MTFp6S1moFWEPmO11ItH6Z/9twvYE6qnuZY=;
	b=q/h8+DAC9X52znJDx0snQfaKI02FhnRQnmU2JkCN+8OMqYedLyZ+Not33KIqxXrSKwlUno
	d5jkz5Sj78gl63kRKKxeTlMCYT9HyMIx2AgJAw0XYvhhV8Aug80Yg5cNh8CZc8ugjTfrKV
	3bJ3/3t1ecGoBVChMYqThOib+Rcv/Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759504510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSuUcYJ4MTFp6S1moFWEPmO11ItH6Z/9twvYE6qnuZY=;
	b=dfyptc0MPtNOIG2tL+VRqFpFMoIZvr2mnuO38D6ozakWZ/LtyKH4fT1IrRd9XyplMbLVKj
	Dw21BLvsvruvh3CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759504510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSuUcYJ4MTFp6S1moFWEPmO11ItH6Z/9twvYE6qnuZY=;
	b=q/h8+DAC9X52znJDx0snQfaKI02FhnRQnmU2JkCN+8OMqYedLyZ+Not33KIqxXrSKwlUno
	d5jkz5Sj78gl63kRKKxeTlMCYT9HyMIx2AgJAw0XYvhhV8Aug80Yg5cNh8CZc8ugjTfrKV
	3bJ3/3t1ecGoBVChMYqThOib+Rcv/Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759504510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSuUcYJ4MTFp6S1moFWEPmO11ItH6Z/9twvYE6qnuZY=;
	b=dfyptc0MPtNOIG2tL+VRqFpFMoIZvr2mnuO38D6ozakWZ/LtyKH4fT1IrRd9XyplMbLVKj
	Dw21BLvsvruvh3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95DA213990;
	Fri,  3 Oct 2025 15:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JFpmJH7o32gQYgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 03 Oct 2025 15:15:10 +0000
Date: Fri, 3 Oct 2025 17:15:09 +0200
From: David Sterba <dsterba@suse.cz>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <20251003151509.GK4052@suse.cz>
Reply-To: dsterba@suse.cz
References: <aN_Zeo7JH9nogwwq@kspp>
 <20251003143502.GJ4052@suse.cz>
 <b59ed01f-d9d5-4de8-8a12-1e506962b2d9@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b59ed01f-d9d5-4de8-8a12-1e506962b2d9@embeddedor.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Oct 03, 2025 at 03:51:24PM +0100, Gustavo A. R. Silva wrote:
> >>
> >> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> >> index 9230e5066fc6..2b7cf49a35bb 100644
> >> --- a/fs/btrfs/send.c
> >> +++ b/fs/btrfs/send.c
> >> @@ -178,7 +178,6 @@ struct send_ctx {
> >>   	u64 cur_inode_rdev;
> >>   	u64 cur_inode_last_extent;
> >>   	u64 cur_inode_next_write_offset;
> >> -	struct fs_path cur_inode_path;
> >>   	bool cur_inode_new;
> >>   	bool cur_inode_new_gen;
> >>   	bool cur_inode_deleted;
> >> @@ -305,6 +304,9 @@ struct send_ctx {
> >>   
> >>   	struct btrfs_lru_cache dir_created_cache;
> >>   	struct btrfs_lru_cache dir_utimes_cache;
> >> +
> >> +	/* Must be last --ends in a flexible-array member. */
> >                          ^^
> > 
> > Is this an en dash?
> 
> Not sure what you mean.

En dash is a punctuation mark not typically used in comments, nowadays
found in AI generated code/text. I was just curious.

