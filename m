Return-Path: <linux-btrfs+bounces-7597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE0B961A62
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 01:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E917A1F264B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA1D1D45EB;
	Tue, 27 Aug 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mhGf4Jop";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oQQIGUyu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mhGf4Jop";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oQQIGUyu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C380034
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800699; cv=none; b=DrytD4VJrREtHDa5q4APM14Pa7E3Zs5j7F+3vnLxmbDs9fuisZwSQh66Z0EmNNTda1ZaY/3YDVMRtxGmw5xP9oMb+KHSKCGrX4rLWXxZwS91F026mL1dKR5d1zDRyDeLQKEvQGSunPSW4+XDTtTuNiblF3wTgvGA+H/ZhraPmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800699; c=relaxed/simple;
	bh=DFkXGYey8lwXwJxCHScwGc9w4d34ix9XjvGFsFWGoWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6wWQFEqz45KNJmVgFMlBXmCktLwg16BAkUyNYtXskzf4b8Tk8nruExZEkArn6GmJrqJ7I/KMMon/K/P8Zcm5zmnt3VMd2KdzfvPvxMv0ItvYOUINad3IxIXjcHIhfGqglzA063R51pCq6Y2ivIOroMZj2g+rsJEGCk1QT+6lI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mhGf4Jop; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oQQIGUyu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mhGf4Jop; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oQQIGUyu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19695218FD;
	Tue, 27 Aug 2024 23:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724800691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+VhFNu2jNaYq8iHH3EkmBTVNiVD7uLjzeqfNN4ycAY=;
	b=mhGf4JopNndCgmpA2uneYWWQdfwR9gUcfVD2LNBcJg04rggHZgj+AwxNVDBYgYB2Na0gtc
	8EIEozZ+ZrIUj1pyb/4olbQbZ5DT6G1LxzUU/Rd1ZW9q8U9y0VHP1rr24TWHR3rOR+dLjb
	uLFIQ1RGhufuGsGWKwjZNxl+hgWYt1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724800691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+VhFNu2jNaYq8iHH3EkmBTVNiVD7uLjzeqfNN4ycAY=;
	b=oQQIGUyujqq1sERUwL/+JpuEGldkPGIcQAnPwKpmrseWaO7zfNSIiBE7oy3cDSpaBkI+zC
	6KW3A3inT2U5oaDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mhGf4Jop;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oQQIGUyu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724800691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+VhFNu2jNaYq8iHH3EkmBTVNiVD7uLjzeqfNN4ycAY=;
	b=mhGf4JopNndCgmpA2uneYWWQdfwR9gUcfVD2LNBcJg04rggHZgj+AwxNVDBYgYB2Na0gtc
	8EIEozZ+ZrIUj1pyb/4olbQbZ5DT6G1LxzUU/Rd1ZW9q8U9y0VHP1rr24TWHR3rOR+dLjb
	uLFIQ1RGhufuGsGWKwjZNxl+hgWYt1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724800691;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+VhFNu2jNaYq8iHH3EkmBTVNiVD7uLjzeqfNN4ycAY=;
	b=oQQIGUyujqq1sERUwL/+JpuEGldkPGIcQAnPwKpmrseWaO7zfNSIiBE7oy3cDSpaBkI+zC
	6KW3A3inT2U5oaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00C5A13724;
	Tue, 27 Aug 2024 23:18:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XXI9O7JezmbwMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 27 Aug 2024 23:18:10 +0000
Date: Wed, 28 Aug 2024 01:18:04 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/12] btrfs: clear defragmented inodes using postorder
 in btrfs_cleanup_defrag_inodes()
Message-ID: <20240827231803.GA25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1724795623.git.dsterba@suse.com>
 <e4ad6d8e46f084001770fb9dad6ac8df38cd3e2e.1724795624.git.dsterba@suse.com>
 <b8754522-47d4-41e6-b47a-261bda449d80@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8754522-47d4-41e6-b47a-261bda449d80@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 19695218FD
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Aug 28, 2024 at 08:29:23AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/8/28 07:25, David Sterba 写道:
> > btrfs_cleanup_defrag_inodes() is not called frequently, only in remount
> > or unmount, but the way it frees the inodes in fs_info->defrag_inodes
> > is inefficient. Each time it needs to locate first node, remove it,
> > potentially rebalance tree until it's done. This allows to do a
> > conditional reschedule.
> > 
> > For cleanups the rbtree_postorder_for_each_entry_safe() iterator is
> > convenient but if the reschedule happens and unlocks fs_info->defrag_inodes_lock
> > we can't be sure that the tree is in the same state. If that happens,
> > restart the iteration from the beginning.
> 
> In that case, isn't the rbtree itself in an inconsistent state, and 
> restarting will only cause invalid memory access?
> 
> So in this particular case, since we can be interrupted, the full tree 
> balance looks like the only safe way we can go?

You're right, the nodes get freed so even if the iteration is restarted
it would touch freed memory, IOW rbtree_postorder_for_each_entry_safe()
can't be interrupted. I can drop the reschedule, with the same argument
that it should be relatively fast even for thousands of entries, this
should not hurt for remouunt/umount context.

