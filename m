Return-Path: <linux-btrfs+bounces-2359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B8A853A96
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 20:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080092855CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 19:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AB81CD33;
	Tue, 13 Feb 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CxjMWrgR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S1ZwjYpS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a/PxyH8T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dAnpL8rz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC721171A5
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851544; cv=none; b=WRMIPdolYHtt1xzNrx+BKqhdRWjn3uoaCD4RhgpaHzmR324PaV+HehpBuBV1DNR9EmzfTZ+5hQSy+hY44EUpZ3zr1LiRIvMwfx7mZGyWR1pgVQO32pRaaWMWilLuRAs7KNe4bj6Ui+3Jj8aTIh5JRf94rRcbGa47DxhOCRw0r5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851544; c=relaxed/simple;
	bh=nGeo1ri44hWBrpmw0smZTUL9W41t2NjTAq3K2U+/g7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJj9M5g2+PALPZuKAaKmwigb1OAWLvzVh91SRExPgFLyjRWuJ0Ctlve3VGG5xDTMNH9L6CJW9mrGKGbK8iq8pgcGxdgzM9qzr3WNGsij3LrUqHqehq6vqsZREMhXVUmZeaWUAGOJSfnrxB6+buzyhUbIIlGRihV0g52kKjqmRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CxjMWrgR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S1ZwjYpS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a/PxyH8T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dAnpL8rz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD6161FCEC;
	Tue, 13 Feb 2024 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707851540;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CTBcRJX2mMS+fN2mHy7M76qq3iQVwt/rQUoIOY1+MVY=;
	b=CxjMWrgR/v/SfOjJ/d0j/h+oRd/7qm96uu6UoprDQ+2RIyLoMpaTFoO5bhtNoxZZxAjYBT
	THIhcW5KMm6y0Ue7XntGjnOosWWHtUvw8+ViRXO/jp36p5q3+OwtXqb9UNn4QqP470fFtX
	vUIcr6ZGtiZIZqGCa+ytiaSpK6+qIMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707851540;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CTBcRJX2mMS+fN2mHy7M76qq3iQVwt/rQUoIOY1+MVY=;
	b=S1ZwjYpSEFBZWq7sLpQyASIVbNnCJG63KlIBr+G3w9SWXqdt778ASyH3G7x7IPEYYrWKkM
	uQMIiyPfKbxF58AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707851538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CTBcRJX2mMS+fN2mHy7M76qq3iQVwt/rQUoIOY1+MVY=;
	b=a/PxyH8TkE8XQ97v1qvl8YneghSlM6lzUbQl2ImXIItyJAyYa1gRLvUsPt6fO0TjsuBPmV
	YzJl1IjFcI9xSgqGcOfWzZyj9x75ZrfKiKFNXrkF4GQYuDVyZQ6b1drUOHk59ScI7M/sQW
	Jwq2/e2E5nOsX5x959l5fAj9HvL5Lz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707851538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CTBcRJX2mMS+fN2mHy7M76qq3iQVwt/rQUoIOY1+MVY=;
	b=dAnpL8rzrHA5+6dL2B4mXce3VBaxDc8f6lJfjm8VGpdrbQw9iMjevfmtCBt5+cOBilexIk
	dMsDtGeYfKcJnQAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BAE0113583;
	Tue, 13 Feb 2024 19:12:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KOQhLRK/y2WgLQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 13 Feb 2024 19:12:18 +0000
Date: Tue, 13 Feb 2024 20:11:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: fix deadlock with fiemap and extent locking
Message-ID: <20240213191145.GG355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <49c34d4ede23d28d916eab4a22d4ec698f77f498.1707756893.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c34d4ede23d28d916eab4a22d4ec698f77f498.1707756893.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="a/PxyH8T";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dAnpL8rz
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[37.95%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: DD6161FCEC
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Mon, Feb 12, 2024 at 11:56:02AM -0500, Josef Bacik wrote:
> While working on the patchset to remove extent locking I got a lockdep
> splat with fiemap and pagefaulting with my new extent lock replacement
> lock.
> 
> This deadlock exists with our normal code, we just don't have lockdep
> annotations with the extent locking so we've never noticed it.
> 
> Since we're copying the fiemap extent to user space on every iteration
> we have the chance of pagefaulting.  Because we hold the extent lock for
> the entire range we could mkwrite into a range in the file that we have
> mmap'ed.  This would deadlock with the following stack trace
> 
> [<0>] lock_extent+0x28d/0x2f0
> [<0>] btrfs_page_mkwrite+0x273/0x8a0
> [<0>] do_page_mkwrite+0x50/0xb0
> [<0>] do_fault+0xc1/0x7b0
> [<0>] __handle_mm_fault+0x2fa/0x460
> [<0>] handle_mm_fault+0xa4/0x330
> [<0>] do_user_addr_fault+0x1f4/0x800
> [<0>] exc_page_fault+0x7c/0x1e0
> [<0>] asm_exc_page_fault+0x26/0x30
> [<0>] rep_movs_alternative+0x33/0x70
> [<0>] _copy_to_user+0x49/0x70
> [<0>] fiemap_fill_next_extent+0xc8/0x120
> [<0>] emit_fiemap_extent+0x4d/0xa0
> [<0>] extent_fiemap+0x7f8/0xad0
> [<0>] btrfs_fiemap+0x49/0x80
> [<0>] __x64_sys_ioctl+0x3e1/0xb50
> [<0>] do_syscall_64+0x94/0x1a0
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> I wrote an fstest to reproduce this deadlock without my replacement lock
> and verified that the deadlock exists with our existing locking.
> 
> To fix this simply don't take the extent lock for the entire duration of
> the fiemap.  This is safe in general because we keep track of where we
> are when we're searching the tree, so if an ordered extent updates in
> the middle of our fiemap call we'll still emit the correct extents
> because we know what offset we were on before.
> 
> The only place we maintain the lock is searching delalloc.  Since the
> delalloc stuff can change during writeback we want to lock the extent
> range so we have a consistent view of delalloc at the time we're
> checking to see if we need to set the delalloc flag.
> 
> With this patch applied we no longer deadlock with my testcase.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Fixed up the various formatting comments.
> - Added a comment for the locking.

Reviewed-by: David Sterba <dsterba@suse.com>

