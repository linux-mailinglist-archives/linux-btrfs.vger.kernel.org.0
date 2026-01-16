Return-Path: <linux-btrfs+bounces-20633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88728D30DE0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 13:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16C273034928
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 12:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9543A37E307;
	Fri, 16 Jan 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="08zrrz35";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0p8LKQ8Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="08zrrz35";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0p8LKQ8Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30137E313
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565272; cv=none; b=HpIrRDf/av1RTD91Vma5Rmp26BqBOfUnQLgD3I2x8Ipeq/ARxqC/EDo2I+QTRTLG6FJknK7nm/YHug1A0hLobSc1sKmJFA8hTFEBM/nAtOH3yKJsLwdM3jDhKNK2a+odwP5tup2S2ifnodApYNepK3uQktMHXFuVwGbUq7BD13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565272; c=relaxed/simple;
	bh=bkwom7WKY+RPl+ovFEzMQuMs0tFGQegKCZwzVgwCgr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehyqdmpDjUhwQW4mM8Vxvzx/cVgXIoGe1mfQguq7D7C81Npy5kMsSdNW+FOOWsgnpoqwjVBXAedLz3PkgF257X4mhA6mWjo1eyO0RvI1zlrbFeYYigs3SXZCAryGhavQI2TDsWGe/EIjEGNQrhERP4qOGIwsYSHWKSOEw45LHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=08zrrz35; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0p8LKQ8Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=08zrrz35; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0p8LKQ8Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49C075BE12;
	Fri, 16 Jan 2026 12:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768565268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpai2upKefZ7Snv2ZnHi9aisIUJTAeFp+5IprJswKlU=;
	b=08zrrz35N1GijxxF3ln4JY9/9M8BbfVxJIOkuJp+0DcE1ewgNwTqfF86yC2rkAxwZfUzFL
	cOIAyZFGCm6wahGdLH+Iy5EVs/GId0pUFQu1vG3oOCEDMMMjygC0yoQwq4yKoD6Q8gu+Zr
	kWNXsK1T90Lyj+1FywJRyzzM5PaW5PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768565268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpai2upKefZ7Snv2ZnHi9aisIUJTAeFp+5IprJswKlU=;
	b=0p8LKQ8Qm5+ea9N5HEt5eBE+rkmwjiSnx1RYjzimCH5DvWiUrz5mbubSskSdSLR3fM4xtM
	CCAvjQWPHT/vfGBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=08zrrz35;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0p8LKQ8Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768565268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpai2upKefZ7Snv2ZnHi9aisIUJTAeFp+5IprJswKlU=;
	b=08zrrz35N1GijxxF3ln4JY9/9M8BbfVxJIOkuJp+0DcE1ewgNwTqfF86yC2rkAxwZfUzFL
	cOIAyZFGCm6wahGdLH+Iy5EVs/GId0pUFQu1vG3oOCEDMMMjygC0yoQwq4yKoD6Q8gu+Zr
	kWNXsK1T90Lyj+1FywJRyzzM5PaW5PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768565268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpai2upKefZ7Snv2ZnHi9aisIUJTAeFp+5IprJswKlU=;
	b=0p8LKQ8Qm5+ea9N5HEt5eBE+rkmwjiSnx1RYjzimCH5DvWiUrz5mbubSskSdSLR3fM4xtM
	CCAvjQWPHT/vfGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F7063EA63;
	Fri, 16 Jan 2026 12:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hvh1DxQqamlZXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 Jan 2026 12:07:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5EF7A091D; Fri, 16 Jan 2026 13:07:47 +0100 (CET)
Date: Fri, 16 Jan 2026 13:07:47 +0100
From: Jan Kara <jack@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] btrfs: do not strictly require dirty metadata threshold
 for metadata writepages
Message-ID: <sbfwmjgmc5o74mvhuk2qkcjd5kn7kawy6rxkuejffajvecblxu@7erdxsdn5crw>
References: <ccfd051d2ae173d95f3f6e75b7466efbf4596620.1768452808.git.wqu@suse.com>
 <20260115233007.GC2118372@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115233007.GC2118372@zen.localdomain>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 49C075BE12
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Thu 15-01-26 15:30:07, Boris Burkov wrote:
> On Thu, Jan 15, 2026 at 03:23:44PM +1030, Qu Wenruo wrote:
> > [BUG]
> > There is an internal report that btrfs hits a hang at
> > balance_dirty_pages() for btree inode.
> > 
> > [CAUSE]
> > balance_dirty_pages() can be triggered by both internal calls like
> > btrfs_btree_balance_dirty() and external callers like mm or cgroup.
> > 
> > For internal calls, btrfs_btree_balance_dirty() calls
> > __btrfs_btree_balance_dirty() which will check if the current dirty
> > metadata reaches a certain threshold (32M), and if not we just skip the
> > workload.
> > 
> > For external calls they can directly call btree_writepages(), which
> 
> grammar nit: you don't need the "can".
> "External callers directly call btree_writepages()" or something is
> clearer.
> 
> > is doing a similar check against the threshold, and skip the writeback
> > again if it's not reaching the same 32M threshold.
> > 
> > But the threshold is only internal to btrfs, if cgroup or mm chose to
> > balance dirty pages for the metadata inode at a much lower threshold, in
> > this case the dirty pages count is around 28M, lower than btrfs'
> > internal threshold.
> 
> I think this is a good argument. Layering multiple different mechanisms
> for metering writeback doesn't make a ton of sense to me. With that
> said, it's not great for the write performance of the btrees if we
> writeback already cow-ed nodes, so allowing more frequent writeback
> might be harmful in practice.
> 
> I still think it's worth it to simplify things and "find out",
> especially if this existing behavior is buggy...
> 
> > 
> > This causes all writeback request to be ignored, and no dirty pages for
> > btrfs btree inode can be balanced, resulting hang for all
> > balance_dirty_pages() callers.
> 
> Does this happen determinstically if balance_dirty_pages() is called on
> the btrfs sb with <32M dirty eb pages? Or does it depend on the state of
> the dirty file pages too, like if those inodes get back some memory,
> it's OK? Just curious to understand better.

Let me explain here some details of dirty throttling which will hopefully
make things clearer. The system has so called dirty limit which limits
amount of dirty pages in the page cache. For each memory cgroup it also
translates into some limit on the number of dirty pages within that cgroup.
This cgroup dirty limit was what was actually playing the role here because
the cgroup had only a small amount of memory and so the dirty limit for it
was something like 16MB. Dirty throttling is responsible for enforcing that
nobody can dirty (significantly) more dirty memory than there's dirty
limit. Thus when a task is dirtying pages it periodically enters into
balance_dirty_pages() and we let it sleep there to slow down the dirtying.
The sleep time is computed based on estimated page writeback speed and how
far we are from reaching the dirty limit. When the system is over dirty
limit already (either globally or within a cgroup of the running task), we
will not let the task exit from balance_dirty_pages() until the number of
dirty pages drops below the limit. 

So in this particular case, as I already mentioned, there was a cgroup with
relatively small amount of memory and as a result with dirty limit set at
16MB. A task from that cgroup has dirtied about 28MB worth of pages in btrfs
btree inode and these were practically the only dirty pages in that cgroup.
So the only option how to get the cgroup below the dirty limit is to
writeback those btree pages. But writeback for those pages was never
started because of the btrfs internal threshold for the btree inode. So
this was practially a deadlock (tasks stuck in balance_dirty_pages()
indefinitely) although if somebody called sync(2) or something similar that
would force writeback of those btree pages then the processes should get
unstuck.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

