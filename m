Return-Path: <linux-btrfs+bounces-19912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7468CD239C
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 01:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4903020481
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 00:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC42E40E;
	Sat, 20 Dec 2025 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZeU0zISH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eJZsrVUf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZeU0zISH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eJZsrVUf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804B849C
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Dec 2025 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766189367; cv=none; b=mJMTbkMxwrltiqdo7JH8uadwLGUoWIEejqzeba1Rao2dEIq/ns17di+TgzzUgAeJU/grpq/hSPwQc4V61cyq6ONdPqrqSVFftYmqTLvd3jBCdXe+CJlAMiDIiPnGpr8EtH0jyw6RZFVzKMbLo/Rxx2+1wXPyQxwT4YSL0OHHyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766189367; c=relaxed/simple;
	bh=Bl7HGe8SO5J91vlPKKHufRoG/I8XLAQI/hZQ0mh+zXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoDBqIQr+M0Si8MzNYG1joQHb+tXfqadNdxUMIQldf8lQbc5JFR1tF1H3thBb+8FoWg2VXXWHNC4k+1AIYrpfWo9UnClKdkIw7FAuGsT6B4lnLlVQfpAOyJYv8BZDzdfObbZd9+Jdo9jxwHIyxPnyeR/S0BTXGSoZnk715lmyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZeU0zISH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eJZsrVUf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZeU0zISH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eJZsrVUf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F401E337E9;
	Sat, 20 Dec 2025 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766189362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svE4d05Jt0zNm2tJFz3z3HgrfzR3y04jB9/IB1r06zs=;
	b=ZeU0zISHJj96nx1qBY0lPHZ0jHi/Pq6s5DlTq3Hu6fmHq7yJmVg8b1C5aRUGmcnSfJVtRe
	Fglb+663h23fa8thHXO5bu2Ma2xk+s99PSAVmTGwj4gkLE0J5+rGH22S7ZZcKGoSjBhl5G
	zMQjJV9FIH+Ay+u9rniP1dlTiBqaBJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766189362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svE4d05Jt0zNm2tJFz3z3HgrfzR3y04jB9/IB1r06zs=;
	b=eJZsrVUfPKFYPGWJ9kwVR+UITVI4UkIokW7XgCTFVB+Fd73mqsgprNeMnhlquhVTCq6WBS
	hd0JN4mftAC7VvBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZeU0zISH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eJZsrVUf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766189362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svE4d05Jt0zNm2tJFz3z3HgrfzR3y04jB9/IB1r06zs=;
	b=ZeU0zISHJj96nx1qBY0lPHZ0jHi/Pq6s5DlTq3Hu6fmHq7yJmVg8b1C5aRUGmcnSfJVtRe
	Fglb+663h23fa8thHXO5bu2Ma2xk+s99PSAVmTGwj4gkLE0J5+rGH22S7ZZcKGoSjBhl5G
	zMQjJV9FIH+Ay+u9rniP1dlTiBqaBJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766189362;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svE4d05Jt0zNm2tJFz3z3HgrfzR3y04jB9/IB1r06zs=;
	b=eJZsrVUfPKFYPGWJ9kwVR+UITVI4UkIokW7XgCTFVB+Fd73mqsgprNeMnhlquhVTCq6WBS
	hd0JN4mftAC7VvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7051139DE;
	Sat, 20 Dec 2025 00:09:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qq//NzHpRWkiKQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 20 Dec 2025 00:09:21 +0000
Date: Sat, 20 Dec 2025 01:09:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: simplify check for zoned NODATASUM writes in
 btrfs_submit_chunk()
Message-ID: <20251220000920.GC3195@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251219073649.1157563-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219073649.1157563-1-zhen.ni@easystack.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[easystack.cn:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: F401E337E9
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Fri, Dec 19, 2025 at 03:36:49PM +0800, Zhen Ni wrote:
> This function already dereferences 'inode' multiple times earlier,
> making the additional NULL check at line 840 redundant since the
> function would have crashed already if inode were NULL.
> 
> After commit 81cea6cd7041 ("btrfs: remove btrfs_bio::fs_info by
> extracting it from btrfs_bio::inode"), the btrfs_bio::inode field is
> mandatory for all btrfs_bio allocations and is guaranteed to be
> non-NULL.
> 
> Simplify the condition for allocating dummy checksums for zoned
> NODATASUM data by removing the unnecessary 'inode &&' check.
> 
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>

Added to for-next, thanks.

