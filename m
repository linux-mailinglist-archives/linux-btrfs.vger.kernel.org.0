Return-Path: <linux-btrfs+bounces-20336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8AD0AD6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 16:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FC6C301C3FF
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EFC363C57;
	Fri,  9 Jan 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NogRjoMg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zYGx+Hfx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NogRjoMg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zYGx+Hfx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3202B363C4C
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971865; cv=none; b=baI16JK/+g0Gu6DQIB+ZPOeD+wbSyLhE59QI5/FuTxikedLaq+CeofkVc6lRN60ZmvrVZ7OxeEOFA9yUMDrgqRRwhwPFrlTU8FfFrYB9xcSOyBhinpFvFdEjWzwdM+/VFD8ONAz6FqZcg7JLKYz8C6qPGYfL3otIqN6brD54seQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971865; c=relaxed/simple;
	bh=iiddjW9KrKYAuVh+5lXqT2NJHi8EyuQvMdhzZY1j9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjybuYBfEN1fqGCtKzjjBBDMg6Fkk4Xj0t8oKn96lIuQ8nX/qzooiLbY9s57XeV929a1fTXR2efO5mobRc1l32mIodw9ZZiza20nhi5RqZ9JqKMdYYcFfXANat+S5j0UMeAFtqUttNMGQOT7fB1S6jfzUM5AJMV41VXDUJtwe8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NogRjoMg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zYGx+Hfx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NogRjoMg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zYGx+Hfx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C62933B68;
	Fri,  9 Jan 2026 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767971862;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaVpDDqXwnvKUTD67pD9ZbmrCsCOsE5/imV5ysO8DB0=;
	b=NogRjoMgp36zWuAUlpi4wqEXuIFg2jtDCoMFv/CQfdc6RmZIgsKOFBF5mZG4eqLU6HaUgP
	NvKFmLVkAbQBavkGmjfxGwHNn/iYyrUEbfp9e7ng2cMD4ilwxRU4ops02MjmBqyX73hWoC
	q/SGbALRKe1Ka7XML2YRZ1MB8f0xz6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767971862;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaVpDDqXwnvKUTD67pD9ZbmrCsCOsE5/imV5ysO8DB0=;
	b=zYGx+HfxL/X7AIT0HsO3iwA7HOGOoE29yWygOQGVazbYJ0i5sJ4ZgR1QFhJxKeBVKx9r+7
	55h0n/fCMeXgLxDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NogRjoMg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zYGx+Hfx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767971862;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaVpDDqXwnvKUTD67pD9ZbmrCsCOsE5/imV5ysO8DB0=;
	b=NogRjoMgp36zWuAUlpi4wqEXuIFg2jtDCoMFv/CQfdc6RmZIgsKOFBF5mZG4eqLU6HaUgP
	NvKFmLVkAbQBavkGmjfxGwHNn/iYyrUEbfp9e7ng2cMD4ilwxRU4ops02MjmBqyX73hWoC
	q/SGbALRKe1Ka7XML2YRZ1MB8f0xz6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767971862;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaVpDDqXwnvKUTD67pD9ZbmrCsCOsE5/imV5ysO8DB0=;
	b=zYGx+HfxL/X7AIT0HsO3iwA7HOGOoE29yWygOQGVazbYJ0i5sJ4ZgR1QFhJxKeBVKx9r+7
	55h0n/fCMeXgLxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DD1F3EA63;
	Fri,  9 Jan 2026 15:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AtHtDhYcYWnAXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 09 Jan 2026 15:17:42 +0000
Date: Fri, 9 Jan 2026 16:17:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: add missing ASSERT for system space_info in
 reserve_chunk_space
Message-ID: <20260109151740.GR21071@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260108194502.653-1-jiashengjiangcool@gmail.com>
 <3a9648fa-49c2-4f07-84ee-50a1c7d7196f@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a9648fa-49c2-4f07-84ee-50a1c7d7196f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,suse.com,vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5C62933B68
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Fri, Jan 09, 2026 at 10:02:00AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/1/9 06:15, Jiasheng Jiang 写道:
> > In reserve_chunk_space(), btrfs_find_space_info() is called to retrieve
> > the space_info for the SYSTEM block group. However, the returned pointer
> > is immediately dereferenced by spin_lock(&info->lock) without validation.
> > 
> > While the SYSTEM space_info is expected to be present during normal
> > operations, direct dereference without checking creates a risk of a
> > null pointer dereference. This deviates from the coding pattern seen
> > in peer functions like btrfs_chunk_alloc() where such returns are
> > validated with an ASSERT.
> > 
> > Add an ASSERT() to ensure the pointer is valid before access, improving
> > code robustness and consistency with the rest of the block-group logic.
> 
> If you know how system chunk works, you must understand without a system 
> chunk a btrfs will never be mounted.
> 
> The ASSERT() looks unnecessary to me.

Agreed. I tried to look for justification or an assertion pattern we
might have yet incomplete but I don't see it. The system chunk assertion
is in some functions but not everywhere, was added when zoned code was
extended so this makes some sense. We also don't validate most of the
btrfs_find_space_info() calls and I don't think we should, besides the
initial setup that must lead to a real error.

