Return-Path: <linux-btrfs+bounces-13294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AC3A98889
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 13:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B735A36B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF826FA54;
	Wed, 23 Apr 2025 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RqvIYQKR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5UG9LcV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RqvIYQKR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5UG9LcV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3C26E14D
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407629; cv=none; b=Z/waUVe4AFmVKUsxvMvGNx+ppoIBnVWb2Xcrjon7Kc/F4LpE8JrRYTiGWV0yju++556/rxLOcASRQ/Hg1SvJYwYMqNLMU1i/g59DGfwkC0D8Y/isFziZSaPo3wj54243CRG4m8in00gIx7EDeb0UIBuyNpU1S9zKq8GbTBx87bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407629; c=relaxed/simple;
	bh=LNa7JaJRIJWELbKW0sjW2lWpgbk7eYk7o6DSDUT7JPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okPmT9XpcbvthwCna7z1YxssLoYrL9U2BpRaNF9z8gfUZ5KbLz0n++2LgB1WixiTY0omCA/EEqiOv655/9TILppKYRzmg8ygszIdHL5ZO0PrmA04w0027smLpnJ1LalQ/dygxCvES9LQ7wSXegauq6tfjdXoTIn8n2ua9CtkVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RqvIYQKR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5UG9LcV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RqvIYQKR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5UG9LcV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 626182119E;
	Wed, 23 Apr 2025 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745407624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SKxqyghgouOWHn3k4E3LoAAn994mgcpwA61IAsEW5So=;
	b=RqvIYQKR4D4oEfF9Y+7Guf8JVAV2+XvCYTLnoWwpLkBPSquT6fzQ0sfB358Ml1KVisUaxn
	5Xdzb7gJlPK41Qjr8CyH47S5W8xpttn9QAa53VHyJ2f7i/ZIRPH0jX4md7CcoHm05sXuB3
	ZKYIXF5ypB4tk3y2J3qRRelm09qgMSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745407624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SKxqyghgouOWHn3k4E3LoAAn994mgcpwA61IAsEW5So=;
	b=f5UG9LcVCIf7cFMfjO2n+AP+f3mcSxlT8HUqtydwjuWTfVc7r1IhVp65BTWHod23j8BqZR
	Lrc9UCjSJJ+op/BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745407624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SKxqyghgouOWHn3k4E3LoAAn994mgcpwA61IAsEW5So=;
	b=RqvIYQKR4D4oEfF9Y+7Guf8JVAV2+XvCYTLnoWwpLkBPSquT6fzQ0sfB358Ml1KVisUaxn
	5Xdzb7gJlPK41Qjr8CyH47S5W8xpttn9QAa53VHyJ2f7i/ZIRPH0jX4md7CcoHm05sXuB3
	ZKYIXF5ypB4tk3y2J3qRRelm09qgMSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745407624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SKxqyghgouOWHn3k4E3LoAAn994mgcpwA61IAsEW5So=;
	b=f5UG9LcVCIf7cFMfjO2n+AP+f3mcSxlT8HUqtydwjuWTfVc7r1IhVp65BTWHod23j8BqZR
	Lrc9UCjSJJ+op/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C44D13A3D;
	Wed, 23 Apr 2025 11:27:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BpMPCojOCGjGMQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 23 Apr 2025 11:27:04 +0000
Date: Wed, 23 Apr 2025 13:26:58 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: subpage: reject tree blocks which are not node
 size aligned
Message-ID: <20250423112658.GH3659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <91dc04836a16638e97df7cd50aad462b20400a47.1745391961.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91dc04836a16638e97df7cd50aad462b20400a47.1745391961.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -8.00
X-Spam-Flag: NO

On Wed, Apr 23, 2025 at 04:36:14PM +0930, Qu Wenruo wrote:
> When btrfs subpage support (fs block < page size) is introduced, a subpage
> btrfs will only reject tree blocks which cross page boundaries.
> 
> This used to be a compromise to simplify the tree block handling and
> still allows subpage cases to read some old converted btrfses which do
> not have proper chunk alignment done.
> 
> But in practice, if we have the following unaligned tree block on a 64K
> page sized system:
> 
>   0                           32K           44K             60K  64K
>   |                                         |///////////////|    |
> 
> Although btrfs has no problem reading the tree block at [44K, 60K), if
> extent allocator is allocating another tree block, it may choose the
> range [60K, 74K), as extent allocator has no awareness if it's a subpage
> metadata request.
> 
> Then we got -EINVAL from the following sequence:
> 
>  btrfs_alloc_tree_block()
>  |- btrfs_reserve_extent()
>  |  Which returned range [60K, 74K)
>  |- btrfs_init_new_buffer()
>     |- btrfs_find_create_tree_block()
>        |- alloc_extent_buffer()
>           |- check_eb_alignment()
> 	     Which returned -EINVAL, because the range crosses the page
> 	     boundary.
> 
> This situation will not solve itself and should mostly mark the fs
> read-only.
> 
> Thankfully we didn't really get such reports in the real world because:
> 
> - The original unaligned tree block is only caused by older
>   btrfs-convert
>   It's before the btrfs-convert rework done in v4.6, where converted
>   btrfs can have metadata block groups which are not aligned to
>   node size nor stripe size (64K).
> 
>   But after btrfs-progs v4.6, all chunks allocated will be stripe (64K)
>   aligned, thus no more such problem.
> 
> Considering how old the fix is (v4.x), meanwhile subpage support for
> btrfs is only introduced in v5.15, it should be safe to reject those
> unaligned tree blocks.

I hope so, 4.6 was almost 10 years ago.

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

