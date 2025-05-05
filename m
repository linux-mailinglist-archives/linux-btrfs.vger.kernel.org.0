Return-Path: <linux-btrfs+bounces-13657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D98AA9794
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 17:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEA71893A68
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4A1922F5;
	Mon,  5 May 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v2H+kxS1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xperP2jc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v2H+kxS1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xperP2jc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F198494
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459237; cv=none; b=E2N9rS6PoiGOdnnOxzC0XlW/sQCwcb8fUWhCxBt5I6HZNwzK5H+v4ANGbSQRx318PHzNjT5553Ff379GisXrIm3RlLVrWUVE06o4pt1OINlCryy+Xa8QwSHYtMsSfTAPLiEQ7pG8nezxFVd1Vbuqjc5s3poCHYB1eglqm5iVA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459237; c=relaxed/simple;
	bh=fDpTLCikU1GUgsGFR0UcZUdb2qZ11eE89r5DTXz8W6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2XfG0Ok0rAcNhYr1/H8bNuFH3ZoVwWCxzzIpy+H9mqaLnNxU4CHmywe373GJwMfQXOE4jFYQN9bqydzhilJbUjcEJ9lmb/5i73MFp/qdKUOJso6Jhh6z1HwuTiNTrdVNXM5ZwB8K0y0MXyI358YkteJmBofbyNI88N+YfIPqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v2H+kxS1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xperP2jc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v2H+kxS1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xperP2jc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B6A2B211E8;
	Mon,  5 May 2025 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746459232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jOUwEvciz3UCx6B7rVT8vzxMdY9bS0bCVj3UByPSlPo=;
	b=v2H+kxS136VNJNiIt6+u626e64WoU4f8eH+noyhP0Yt2NaW+BYX8XXWbm9GXDieVc+emvW
	sjlIsyMj/EsCXqWAgbx3HVkCA/zBLyBxreBVK2z+2awvRu7+HC031LhstFmFbIG1Dd8k75
	5yGYI91bScrejzEHKU1pGG5rTNZkjjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746459232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jOUwEvciz3UCx6B7rVT8vzxMdY9bS0bCVj3UByPSlPo=;
	b=xperP2jcCSMjkNhCVzbINWDGMIaFTqhmtDNn6BWpSsZs3Bv/RKrRzj42/AjhKRAGzjwo/9
	hpWpgZn+JXq6C8CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v2H+kxS1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xperP2jc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746459232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jOUwEvciz3UCx6B7rVT8vzxMdY9bS0bCVj3UByPSlPo=;
	b=v2H+kxS136VNJNiIt6+u626e64WoU4f8eH+noyhP0Yt2NaW+BYX8XXWbm9GXDieVc+emvW
	sjlIsyMj/EsCXqWAgbx3HVkCA/zBLyBxreBVK2z+2awvRu7+HC031LhstFmFbIG1Dd8k75
	5yGYI91bScrejzEHKU1pGG5rTNZkjjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746459232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jOUwEvciz3UCx6B7rVT8vzxMdY9bS0bCVj3UByPSlPo=;
	b=xperP2jcCSMjkNhCVzbINWDGMIaFTqhmtDNn6BWpSsZs3Bv/RKrRzj42/AjhKRAGzjwo/9
	hpWpgZn+JXq6C8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A25201372E;
	Mon,  5 May 2025 15:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ydVpJ2DaGGgJXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 May 2025 15:33:52 +0000
Date: Mon, 5 May 2025 17:33:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 0/2] btrfs: fix beyond EOF truncation for subpage
 generic/363 failures
Message-ID: <20250505153347.GY9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1745619801.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1745619801.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B6A2B211E8
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, Apr 26, 2025 at 08:06:48AM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v5:
> - Shrink the parameter list for btrfs_truncate_block()
>   Remove the @front and @len, instead passing a new pair of @start/@end,
>   so that we can determine if @from is in the head or tail block,
>   thus no need for @front.
> 
>   This will give callers more freedom (a little too much),
>   e.g. for the following zero range/hole punch case:
> 
>     Page size is 64K, fs block size is 4K.
>     Truncation range is [6K, 58K).
> 
>     0        8K                32K                  56K      64K
>     |      |/|//////////////////////////////////////|/|      |
>            6K                                         58K
> 
>     To truncate the first block to zero out range [6K, 8K),
>     caller can pass @from = 6K, @start = 6K, @end = 58K - 1.
>     In fact, any @from inside range [6K, 8K) will work.
> 
>     To truncate the last block to zero out range [56K, 58K),
>     caller can pass @from=58K - 1, @start = 6K, @end = 58K -1.
>     Any @from inside range [56K, 58K) will also work.
> 
>     Furthermore, if aligned @from is passed in, e.g. 8K,
>     btrfs_truncate_block() will detect that there is nothing to do,
>     and exit properly.
> 
> - Only do the extra zeroing if we're truncating beyond EOF
>   Especially for the recent large folios support, we can do a lot of
>   unnecessary zeroing for a very large folio.
> 
> - Remove the lock-wait-retry loop if we're doing aligned truncation
>   beyond EOF
>   Since it's already EOF, there is no need to wait for the OE anyway.

The patches have been in linux-next but I don't think they got coverage
on the 64k/4k setups. If you don't have further updates please add the
series to for-next. Thanks.

