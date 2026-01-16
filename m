Return-Path: <linux-btrfs+bounces-20644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A639D3879A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 21:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6D0E30704FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C0B2882AA;
	Fri, 16 Jan 2026 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xjVRyP6+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dEEeQo18";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xjVRyP6+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dEEeQo18"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AD264A9D
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595424; cv=none; b=FVJJXnQdHv3GzV+HpFqrqmRBoCCaGxzTsOLJsZLcB6CYT65wd062TF8PLe23v9H2xz01j8iDMFNwe5hZYSKkkHSbM/V4rN3L+Be+zwkj+jGubVPai1OQC5i1RdCMoTSzc8FcY6qrGrzxgos/tQr+UvVj0pEIFt6w33mzbmwA34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595424; c=relaxed/simple;
	bh=uQUadSFRoi6hGzoq+l7J4rOnSisBU2Gi4Zr/YUG68L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIadbn5glJESCanycVOTTGi8P5DHZTiZ2xsDmLbP3fGM4y4xgtWQRtyRfsqKlvU+poK5A2GJ4j5r1a1bjF+rUAXknUt5r7fPlvou8Rw/bzY6Pxj88aKlhBM0aeUSzNAvkF37jKQuP6VlrNDGPPtDw1gID7zk6G63bu2btSCZze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xjVRyP6+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dEEeQo18; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xjVRyP6+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dEEeQo18; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C41B633699;
	Fri, 16 Jan 2026 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768595420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4LBPgvDnVQ7xl/Azv+cL+R0+YYDKNJrVk1IZa2fCup0=;
	b=xjVRyP6+GERMgRA5AAmf3pWlWkNKzAS3bT8FYfAPAYj9VkHHOHfTgCZk2qrvmMHFDCuFRg
	tbzw/GlWeDHLkjbt2OK16e/yfACnRwg6tIbIVp99cYeoGQTZnhBbRFCuHmXIW4jzIlne/o
	/RwL4MOaOvJLx0Jr7Y+LdCIyhbft6AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768595420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4LBPgvDnVQ7xl/Azv+cL+R0+YYDKNJrVk1IZa2fCup0=;
	b=dEEeQo18OqHfRqGMbTO3jDaYbYjITA80MzXL2DznzCgzhk1kjJ3a928hZOdv39jonFUuA4
	D/UIw7KlHWqYAiBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xjVRyP6+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dEEeQo18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768595420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4LBPgvDnVQ7xl/Azv+cL+R0+YYDKNJrVk1IZa2fCup0=;
	b=xjVRyP6+GERMgRA5AAmf3pWlWkNKzAS3bT8FYfAPAYj9VkHHOHfTgCZk2qrvmMHFDCuFRg
	tbzw/GlWeDHLkjbt2OK16e/yfACnRwg6tIbIVp99cYeoGQTZnhBbRFCuHmXIW4jzIlne/o
	/RwL4MOaOvJLx0Jr7Y+LdCIyhbft6AM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768595420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4LBPgvDnVQ7xl/Azv+cL+R0+YYDKNJrVk1IZa2fCup0=;
	b=dEEeQo18OqHfRqGMbTO3jDaYbYjITA80MzXL2DznzCgzhk1kjJ3a928hZOdv39jonFUuA4
	D/UIw7KlHWqYAiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B68CA3EA63;
	Fri, 16 Jan 2026 20:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O6mILNyfammOSgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 Jan 2026 20:30:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 66431A09D8; Fri, 16 Jan 2026 21:30:20 +0100 (CET)
Date: Fri, 16 Jan 2026 21:30:20 +0100
From: Jan Kara <jack@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Jan Kara <jack@suse.cz>, Qu Wenruo <wqu@suse.com>, 
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not strictly require dirty metadata threshold
 for metadata writepages
Message-ID: <gx573tj7iapu6u35qrhgvrdnclngkfsa324halhjmks5necgfp@7rolltaw44dk>
References: <ccfd051d2ae173d95f3f6e75b7466efbf4596620.1768452808.git.wqu@suse.com>
 <20260115233007.GC2118372@zen.localdomain>
 <sbfwmjgmc5o74mvhuk2qkcjd5kn7kawy6rxkuejffajvecblxu@7erdxsdn5crw>
 <20260116171236.GA2507766@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116171236.GA2507766@zen.localdomain>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: C41B633699
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Fri 16-01-26 09:12:36, Boris Burkov wrote:
> On Fri, Jan 16, 2026 at 01:07:47PM +0100, Jan Kara wrote:
> > On Thu 15-01-26 15:30:07, Boris Burkov wrote:
> > > On Thu, Jan 15, 2026 at 03:23:44PM +1030, Qu Wenruo wrote:
> > > > [BUG]
> > > > There is an internal report that btrfs hits a hang at
> > > > balance_dirty_pages() for btree inode.
> > > > 
> > > > [CAUSE]
> > > > balance_dirty_pages() can be triggered by both internal calls like
> > > > btrfs_btree_balance_dirty() and external callers like mm or cgroup.
> > > > 
> > > > For internal calls, btrfs_btree_balance_dirty() calls
> > > > __btrfs_btree_balance_dirty() which will check if the current dirty
> > > > metadata reaches a certain threshold (32M), and if not we just skip the
> > > > workload.
> > > > 
> > > > For external calls they can directly call btree_writepages(), which
> > > 
> > > grammar nit: you don't need the "can".
> > > "External callers directly call btree_writepages()" or something is
> > > clearer.
> > > 
> > > > is doing a similar check against the threshold, and skip the writeback
> > > > again if it's not reaching the same 32M threshold.
> > > > 
> > > > But the threshold is only internal to btrfs, if cgroup or mm chose to
> > > > balance dirty pages for the metadata inode at a much lower threshold, in
> > > > this case the dirty pages count is around 28M, lower than btrfs'
> > > > internal threshold.
> > > 
> > > I think this is a good argument. Layering multiple different mechanisms
> > > for metering writeback doesn't make a ton of sense to me. With that
> > > said, it's not great for the write performance of the btrees if we
> > > writeback already cow-ed nodes, so allowing more frequent writeback
> > > might be harmful in practice.
> > > 
> > > I still think it's worth it to simplify things and "find out",
> > > especially if this existing behavior is buggy...
> > > 
> > > > 
> > > > This causes all writeback request to be ignored, and no dirty pages for
> > > > btrfs btree inode can be balanced, resulting hang for all
> > > > balance_dirty_pages() callers.
> > > 
> > > Does this happen determinstically if balance_dirty_pages() is called on
> > > the btrfs sb with <32M dirty eb pages? Or does it depend on the state of
> > > the dirty file pages too, like if those inodes get back some memory,
> > > it's OK? Just curious to understand better.
> > 
> > Let me explain here some details of dirty throttling which will hopefully
> > make things clearer. The system has so called dirty limit which limits
> > amount of dirty pages in the page cache. For each memory cgroup it also
> > translates into some limit on the number of dirty pages within that cgroup.
> > This cgroup dirty limit was what was actually playing the role here because
> > the cgroup had only a small amount of memory and so the dirty limit for it
> > was something like 16MB. Dirty throttling is responsible for enforcing that
> > nobody can dirty (significantly) more dirty memory than there's dirty
> > limit. Thus when a task is dirtying pages it periodically enters into
> > balance_dirty_pages() and we let it sleep there to slow down the dirtying.
> > The sleep time is computed based on estimated page writeback speed and how
> > far we are from reaching the dirty limit. When the system is over dirty
> > limit already (either globally or within a cgroup of the running task), we
> > will not let the task exit from balance_dirty_pages() until the number of
> > dirty pages drops below the limit. 
> > 
> > So in this particular case, as I already mentioned, there was a cgroup with
> > relatively small amount of memory and as a result with dirty limit set at
> > 16MB. A task from that cgroup has dirtied about 28MB worth of pages in btrfs
> > btree inode and these were practically the only dirty pages in that cgroup.
> > So the only option how to get the cgroup below the dirty limit is to
> > writeback those btree pages. But writeback for those pages was never
> > started because of the btrfs internal threshold for the btree inode. So
> > this was practially a deadlock (tasks stuck in balance_dirty_pages()
> > indefinitely) although if somebody called sync(2) or something similar that
> > would force writeback of those btree pages then the processes should get
> > unstuck.
> 
> Thank you for the extra explanation on the stuck condition, that is
> helpful.
> 
> I am curious if you have seen this series I wrote last year:
> https://lore.kernel.org/linux-btrfs/20250829015247.GJ29826@twin.jikos.cz/
> (similar to something Qu had worked on in the past) which makes it so that
> btrfs btree inode pages are not accounted to a cgroup. With those patches,
> I think the likelihood that we would have a situation where the dirty
> pages are less than 32MB but we are over the balance_dirty_pages limit
> in a way that perma-throttled a task seems low, since you couldn't have
> a cgroup with a tiny limit full of btree inode pages. The btree inode
> pages would be associated with the global limit which I imagine would
> tend to be higher and correspond to a greater total amount (more than
> 32MB) of btree inode pages, and more likely to also have data pages we
> can writeback. How likely is it that the global limit would be <32MB?

No, I haven't seen that series and you're right it should practically solve
the issue as well because global dirty limit is unlikely to be below 32MB.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

