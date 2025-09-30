Return-Path: <linux-btrfs+bounces-17296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C672BAE0F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 18:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3765B16CF2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A923BCE4;
	Tue, 30 Sep 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IBJB0yd8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGBDbCMS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IBJB0yd8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGBDbCMS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4334BA28
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Sep 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250156; cv=none; b=pUSqgMVjIcqWtBYFTW+cWwpXEZ9m/SUGl3KvxouOR7teFhnmmTWc5U2/Qo8TKyKb+ETmH4MRMp6ZsbE4L26v+gKRVQxm6mwe08W5xf8aVLF9iozP0CgwKOE1Iv1RPiTlQmH4OsOqumd32ovLbVU/dle5b4+zIpoxxvkQQWNTPX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250156; c=relaxed/simple;
	bh=liTWLGm8KZ6nOKzTONwU9G3Cr7WA2LXiUtJC0Y3ghGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRi3igQLrPX+ztFDU/gTf/nMi9M/iIHVNqd3+hxQ7OfmElE8UiGqSME228m+X62qi6MLp8R/CuZGyKrJn7Y2f20AjOEST6mBtH6mJkAZgFJ4WmtSKb5cpO7n7yNv3u//v18TUA+Hv6fAIl72DgsqaiWJDV8shecr+lh07JnMgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IBJB0yd8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGBDbCMS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IBJB0yd8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGBDbCMS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA2831F8BE;
	Tue, 30 Sep 2025 16:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759250152;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrPmnRgK70ArAAhSxCctSIdErUReYUki25UJM4tFjBc=;
	b=IBJB0yd8ydKLDK65wYpUPb0PNcq3EFwCXrOJyhhdeqYvrrbLPY5RcpBEOU3bShURZZhoog
	wz3CIdlmjDjfNKnzlvG0CEEAGuCCVOVrS0Hw9rOqjCq+kzObdCU++9r6vhn8Rz9OPjJkMG
	XjBjJuAMIzuPwW6bs6nSayMLZCyDZIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759250152;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrPmnRgK70ArAAhSxCctSIdErUReYUki25UJM4tFjBc=;
	b=bGBDbCMSBe90BdrVfYcnZ8Nv8yzEwMUGGfDp6VJOf+nvnuWl/hI8FvsVUvWNaIIUO6/DSW
	kmH+xlGFwI1srQCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IBJB0yd8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bGBDbCMS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759250152;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrPmnRgK70ArAAhSxCctSIdErUReYUki25UJM4tFjBc=;
	b=IBJB0yd8ydKLDK65wYpUPb0PNcq3EFwCXrOJyhhdeqYvrrbLPY5RcpBEOU3bShURZZhoog
	wz3CIdlmjDjfNKnzlvG0CEEAGuCCVOVrS0Hw9rOqjCq+kzObdCU++9r6vhn8Rz9OPjJkMG
	XjBjJuAMIzuPwW6bs6nSayMLZCyDZIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759250152;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrPmnRgK70ArAAhSxCctSIdErUReYUki25UJM4tFjBc=;
	b=bGBDbCMSBe90BdrVfYcnZ8Nv8yzEwMUGGfDp6VJOf+nvnuWl/hI8FvsVUvWNaIIUO6/DSW
	kmH+xlGFwI1srQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9BF513A3F;
	Tue, 30 Sep 2025 16:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SME6KegG3Gg9AQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Sep 2025 16:35:52 +0000
Date: Tue, 30 Sep 2025 18:35:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Message-ID: <20250930163547.GC4052@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250930050918.31029-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930050918.31029-2-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BA2831F8BE
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
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Tue, Sep 30, 2025 at 01:09:07PM +0800, Sun YangKai wrote:
> Trivial pattern for the auto freeing without goto -> return conversions.
> No other function cleanup.
> 
> Tested with btrfs/auto group.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/uuid-tree.c | 12 ++++--------
>  fs/btrfs/verity.c    |  9 +++------
>  fs/btrfs/volumes.c   | 44 ++++++++++++++------------------------------
>  fs/btrfs/xattr.c     |  7 ++-----
>  4 files changed, 23 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
> index 17b5e81123a1..30e5d80adda9 100644
> --- a/fs/btrfs/uuid-tree.c
> +++ b/fs/btrfs/uuid-tree.c
> @@ -27,7 +27,7 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
>  				  u8 type, u64 subid)
>  {
>  	int ret;
> -	struct btrfs_path *path = NULL;
> +	BTRFS_PATH_AUTO_FREE(path);
>  	struct extent_buffer *eb;
>  	int slot;
>  	u32 item_size;
> @@ -79,7 +79,6 @@ static int btrfs_uuid_tree_lookup(struct btrfs_root *uuid_root, const u8 *uuid,
>  	}
>  
>  out:
> -	btrfs_free_path(path);

Here and in several other places you did not convert gotos to returns
and removed the out: label. What I've seen in other places in the patch
the conversions are straightforward and you already did that in other
patches. Can you please do it here as well?

The unnecessary gotos are in functions where the patch auto freeing is
not done, this could be another cleanup round.

