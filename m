Return-Path: <linux-btrfs+bounces-12046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F626A5453C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 09:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E111893D45
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 08:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD28207DE0;
	Thu,  6 Mar 2025 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G7kGtoIw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hoodZ549";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G7kGtoIw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hoodZ549"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25289207A04
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250643; cv=none; b=Sm9+32J08rbXH0JNjyhAySd8LN4cxtkXZPVZodBUStJd/x4ssvqfP5+JyRLP2JNkyT2kOvb/uaqkq7rpt2ot+q9Fx4O+Nz7ppsfYYcl19leAQHdQFcS4V+qmTuZLlOxH47a74/bpghF3gj6WPf2ucuXu6SDAQbVTy7lCoPdkj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250643; c=relaxed/simple;
	bh=KwQ5o43IKSb0m4Yrui51mr+2VjwbPYSmT7dc9/oi2aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz+0oNFGCN7xLQKcJ2BtCZm58cqTzxodqbFJ28rKIA5uY95c844vrR/n/eY7MLx5g/Wjwc1hkI27QhvahaUAcJEjWWngmFRcZCebL+BXIiCnpUoV0liBjldoP9Sp1GNnmEIwrqqdcwDUZU3ebHkGCVvNvCDmy6PvJmQlEJBXrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G7kGtoIw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hoodZ549; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G7kGtoIw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hoodZ549; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07CCA21190;
	Thu,  6 Mar 2025 08:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741250640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oWMcatiIKTf5L59uDIEyVTY1txC+GvRfr3/adHaIdA=;
	b=G7kGtoIwYYYKEdWJUcZP0AotVUx+xMJe1S6VkQt1C69ChRdZ1loTBtvfLs5wjEsqJo7qtl
	TeJ6XBY+fwb8H7njRG2Rs04iW8CXwXt7UInjxQeq+oV1rBYdqaaG48pG2ZLUOTG50Ph1lZ
	xXWIl2J0n6JG8mqiSoBho7wYxO0sQWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741250640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oWMcatiIKTf5L59uDIEyVTY1txC+GvRfr3/adHaIdA=;
	b=hoodZ549/2jWMdrvgSCX+5v6mIIhnsxSie+G8hCjkI+/6bcWd541Lq/Q+1WwstqdGs5fJW
	d0lHYfEiy52c/BAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G7kGtoIw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hoodZ549
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741250640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oWMcatiIKTf5L59uDIEyVTY1txC+GvRfr3/adHaIdA=;
	b=G7kGtoIwYYYKEdWJUcZP0AotVUx+xMJe1S6VkQt1C69ChRdZ1loTBtvfLs5wjEsqJo7qtl
	TeJ6XBY+fwb8H7njRG2Rs04iW8CXwXt7UInjxQeq+oV1rBYdqaaG48pG2ZLUOTG50Ph1lZ
	xXWIl2J0n6JG8mqiSoBho7wYxO0sQWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741250640;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oWMcatiIKTf5L59uDIEyVTY1txC+GvRfr3/adHaIdA=;
	b=hoodZ549/2jWMdrvgSCX+5v6mIIhnsxSie+G8hCjkI+/6bcWd541Lq/Q+1WwstqdGs5fJW
	d0lHYfEiy52c/BAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6A9613676;
	Thu,  6 Mar 2025 08:43:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qYc2NE9gyWdZCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Mar 2025 08:43:59 +0000
Date: Thu, 6 Mar 2025 09:43:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: reject out-of-band dirty folios during
 writeback
Message-ID: <20250306084354.GI5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7026d8edc3d1ea5b0ef7307298149d06210807ce.1741144890.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7026d8edc3d1ea5b0ef7307298149d06210807ce.1741144890.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 07CCA21190
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Mar 05, 2025 at 01:51:39PM +1030, Qu Wenruo wrote:
> [OUT-OF-BAND DIRTY FOLIOS]
> An out-of-band folio means the folio is marked dirty but without
> notifying the filesystem.
> 
> This can lead to various problems, not limited to:
> 
> - No folio::private to track per block status
> 
> - No proper space reserved for such a dirty folio
> 
> [HISTORY IN BTRFS]
> This used to be a problem related to get_user_page(), but with the
> introduction of pin_user_pages*(), we should no longer hit such
> case anymore.
> 
> In btrfs, we have a long history of catching such out-of-band dirty
> folios by:
> 
> - Mark the folio ordered during delayed allocation
> 
> - Check the folio ordered flag during writeback
>   If the folio has no ordered flag, it means it doesn't go through
>   delayed allocation, thus it's definitely an out-of-band
>   one.
> 
>   If we got one, we go through COW fixup, which will re-dirty the folio
>   with proper handling in another workqueue.
> 
> [PROBLEMS OF COW-FIXUP]
> Such workaround is a blockage for us to migrate to iomap (it requires
> extra flags to trace if a folio is dirtied by the fs or not) and I'd
> argue it's not data checksum safe, since if a folio can be marked dirty
> without informing the fs, the content can also change at any time.
> 
> But with the introduction of pin_user_pages*() during v5.8 merge
> window, such out-of-band dirty folio such be treated as a bug.
> Ext4 has treated such case by warning and erroring out even before
> pin_user_pages*().
> 
> Furthermore, there are already proofs that such folio ordered flag
> tracking can be screwed up by incorrect error handling, check the commit
> messages of the following commits:
> 
>  06f364284794 ("btrfs: do proper folio cleanup when cow_file_range() failed")
>  c2b47df81c8e ("btrfs: do proper folio cleanup when run_delalloc_nocow() failed")
> 
> [FIXES]
> Unlike btrfs, ext4 and xfs (iomap) never bother handling such
> out-of-band dirty folios.
> 
> - Ext4 just warns and errors out
> - Iomap always follows the folio/block dirty flags
> 
> And there is nothing really COW specific, xfs also supports COW too.
> 
> Here we take one step towards ext4 by doing warning and erroring out.
> But since the cow fixup thing is introduced from the beginning, we keep
> the old behavior for non-experimental builds, and only do the new warning
> for experimental builds before we're 100% sure and remove cow fixup.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks, this is a good intermediate step before we remove the cow fixup
for good.

Reviewed-by: David Sterba <dsterba@suse.com>

