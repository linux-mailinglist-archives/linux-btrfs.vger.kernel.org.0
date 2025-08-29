Return-Path: <linux-btrfs+bounces-16518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC3DB3B014
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 02:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87AA7C7655
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 00:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD618A93F;
	Fri, 29 Aug 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K+hH97ke";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TVcfm5jh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K+hH97ke";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TVcfm5jh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C292AEFD
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756428634; cv=none; b=T7VzEmyFp+BkeEinw/5O30HVB5ktLa7WSwl+yPyuQrnSThZmALNhxYeJquoXKp5UnBp4oFKL/YuQNPjlDFfbRKBcsCJLW2G2zWUqwqwhHV0WkOb11PKzZ/KmEvz92bmPEoRHLc/wz2qKYhXmBPQy6MhmB7Cljs4pe2gqRHj8cgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756428634; c=relaxed/simple;
	bh=lAoNH4bOaLeHMDf53cpfZ9wyOJC4exlOzqJZLGfMrqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLY+UsdXqIDSnKdsoQFXE0+elsjy4KFuIgyV/GqHEZiIqN98pX7c1WRW6RFA5T4axXcTjQ8e7mD7FOcq+RNSvTYylH3TIxg/IU2YPg5x/t2xLUdWiTI9RK34gqkTT81/UPnT3mUD4p5sdZSPRctbrKyCm9JwJCud967NTqJ96gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K+hH97ke; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TVcfm5jh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K+hH97ke; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TVcfm5jh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 497C221014;
	Fri, 29 Aug 2025 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756428628;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEGqwpE2zW0ttjcuCYiW0HD5aBlK9d7gOHV5d1JnjXU=;
	b=K+hH97kehIpJHjkdpLVqta1v2DOtjESkiOmOMojPyo+xyCH7mcmH35gDlbvFKFkQo7DnGr
	735ZlR9mznkUQRGB9r3dm2BASax6H+Qdbf/MngOZhWERPxLD0mHbJzGojQKMUEOdPaB+Kn
	vGu4uTAnyvlCfSXqHGJcjaTs+KvD95U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756428628;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEGqwpE2zW0ttjcuCYiW0HD5aBlK9d7gOHV5d1JnjXU=;
	b=TVcfm5jhFGs7BqCz3Bsx/xkjXI8Y8qs95zLc8dnOFa9HrIJn/zB+GFLxXKXUpcelu+qEEQ
	GsQ/Qekv/CD7w/Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K+hH97ke;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TVcfm5jh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756428628;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEGqwpE2zW0ttjcuCYiW0HD5aBlK9d7gOHV5d1JnjXU=;
	b=K+hH97kehIpJHjkdpLVqta1v2DOtjESkiOmOMojPyo+xyCH7mcmH35gDlbvFKFkQo7DnGr
	735ZlR9mznkUQRGB9r3dm2BASax6H+Qdbf/MngOZhWERPxLD0mHbJzGojQKMUEOdPaB+Kn
	vGu4uTAnyvlCfSXqHGJcjaTs+KvD95U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756428628;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rEGqwpE2zW0ttjcuCYiW0HD5aBlK9d7gOHV5d1JnjXU=;
	b=TVcfm5jhFGs7BqCz3Bsx/xkjXI8Y8qs95zLc8dnOFa9HrIJn/zB+GFLxXKXUpcelu+qEEQ
	GsQ/Qekv/CD7w/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2145E13326;
	Fri, 29 Aug 2025 00:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 14KtB1T5sGj5fwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 29 Aug 2025 00:50:28 +0000
Date: Fri, 29 Aug 2025 02:50:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: add 16K and 64K slabs for extent buffers
Message-ID: <20250829005026.GI29826@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1756417687.git.dsterba@suse.com>
 <8c448bf2fcf0c2e7b52c05234d420b78cfe4b1d7.1756417687.git.dsterba@suse.com>
 <e776e393-896c-4d96-89bb-dd8b18042caa@gmx.com>
 <20250828233011.GE29826@twin.jikos.cz>
 <5a261aae-d172-4481-bde2-633184f285f2@suse.com>
 <20250828234542.GG29826@twin.jikos.cz>
 <48b9874a-2139-47cf-81f5-3af8ecfa8dc7@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b9874a-2139-47cf-81f5-3af8ecfa8dc7@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 497C221014
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Fri, Aug 29, 2025 at 09:20:13AM +0930, Qu Wenruo wrote:
> > On 16k page systems the array will have one entry, similar to what we
> > have now with 64k page systems because of how INLINE_EXTENT_BUFFER_PAGES
> > is calculated as BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE
> 
> It still doesn't work well for 64K page sized systems. As I mentioned, 
> the 16K cachep will have no space for any folio entry, and only 64K one 
> makes sense.
> 
> If you really want to use kmem_cache infrastructure with variable sized 
> array, please move the extent buffer cache to a per-fs basis, so we 
> don't need all those weird "optimization", just a single eb cache no 
> matter the page size/node size.

This shifts away from the idea I wanted to implement, per-fs kmem cache
does not make sense to me due to the internal overhead of a kmem cache.
I hoped that 2 sizes would capture the most common page sizes combined
with node size with a little overhead of the indirection, I did not try
to do most efficient representation of the pages and ebs. I'll think if
there's an intersection what we both could find reasonable to implement
or will drop the patches.

