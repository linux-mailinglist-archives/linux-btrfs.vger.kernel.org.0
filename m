Return-Path: <linux-btrfs+bounces-17177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F534B9EEB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 13:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14023385A84
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 11:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893282F9D9A;
	Thu, 25 Sep 2025 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cg5lecDX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bQ/6n8qu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zTT1qZOB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RKY/j2XP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B22FA0DE
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799948; cv=none; b=QvzdYhUG8/1XiE4ULnF+kiN9c8cqNGTFnKcXShuGE5vuYxxYsg9WewckO04qTBfGGyLkZEI5v/Q9old3wTJJAEKOY68ehlKhbiWOQmcO3c3Lcf7FM3EOhTFjN2faqYKMCWRd1KCjjZy2ca3hs0WkMIb8VE75JYmKGFFuENHkniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799948; c=relaxed/simple;
	bh=hPit846QG5s/8FxiZ4jAtyjvfFg33VihrTAvhsXCDFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz9/Ok06Z5ZggOHAa8w/5qWgDhADY56GjGIFYBFoXhVCDyOJFc2T3Wr3auVjDsK4SSTaafM/9iY5o4oydYgs60tXXTSMJ/Whn3EFlRGNNqEwY+BCMZxuOpUObK7MNdmasI//v8sva2E1B+i/S6wPgkIDlsjmcsCa9F5PJJDUhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cg5lecDX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bQ/6n8qu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zTT1qZOB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RKY/j2XP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E7FF6A9EC;
	Thu, 25 Sep 2025 11:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758799945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKWz4KvlpIc3gcLaQxb9UJfbqGoib2vplD40XBrX8eQ=;
	b=cg5lecDXKhL6P+hoNjAHNfTWe8ggjztYRpxJAY6WfTXfWrInDwPHpLWKwirZEI0vUpkFL8
	22nqtPyzFPP4ZdYjLQkyob/TL/wmXlN6khRgNqjNh5Cral6yhfPu9IYxULYuKnDIuYK9r9
	1h9H/keBVF1q11dV5zjk/VqmVs8+PBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758799945;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKWz4KvlpIc3gcLaQxb9UJfbqGoib2vplD40XBrX8eQ=;
	b=bQ/6n8qum/l8d+JJTI3ASo9q0lKRh4x9iVsdU46RhRO1SYtNXbN/RbXX5xEgQzBhgAfHcN
	12iRW+Okuhoo6cCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zTT1qZOB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="RKY/j2XP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758799944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKWz4KvlpIc3gcLaQxb9UJfbqGoib2vplD40XBrX8eQ=;
	b=zTT1qZOB99LsZf6GOxOaTuRw8mgIdbmEwqvwReYXWCSoykDJHCcUMh6UydFFTuG8iLVS8c
	QzxQWLFt6GekvXqVB//eeeucNkmSq8lWVIa2wva22sTT9BkvxCkK7pVWzIRublTqDATOHk
	hwWpUdlrDw04C90tZnzNPVMUPzgmtig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758799944;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKWz4KvlpIc3gcLaQxb9UJfbqGoib2vplD40XBrX8eQ=;
	b=RKY/j2XP+XW8yVs6BqMu3P3HR9Mz2nlK1ZY43KvZvTZ7X+2IJmI1mljwn2Zjdq6wBZyQJS
	8xEj+skl/A+AQ6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E68B213869;
	Thu, 25 Sep 2025 11:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cIkgOEco1WjtBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Sep 2025 11:32:23 +0000
Date: Thu, 25 Sep 2025 13:32:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Subject: Re: [PATCH 2/2] btrfs: clear spurious free-space entries
Message-ID: <20250925113222.GO5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250923155523.31617-1-mark@harmstone.com>
 <20250923155523.31617-2-mark@harmstone.com>
 <a7ae58b2-6bdc-4f44-bb3f-9068fe51673d@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7ae58b2-6bdc-4f44-bb3f-9068fe51673d@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0E7FF6A9EC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Wed, Sep 24, 2025 at 06:35:43AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/9/24 01:24, Mark Harmstone 写道:
> > Version 6.16.1 of btrfs-progs fixes a broken btrfs check test for
> > spurious entries in the free-space tree, those that don't belong to any
> > block group. Unfortunately mkfs.btrfs had been generating these, meaning
> > that these filesystems will now fail btrfs check.
> > 
> > Add a compat flag BTRFS_FEATURE_COMPAT_NO_SPURIOUS_FREE_SPACE, and if on
> > mount we find this isn't set, clean any spurious entries from the
> > beginning of the free-space tree.
> 
> I found this compat flag a little overkilled.
> 
> Are we really going to introduce a new compat flag every time there is 
> something wrong with the free space tree?

Agreed, the compat flag does not make sense to me in this case.

> > +	ret = btrfs_search_slot(trans, fst, &key, path, 0, 0);
> > +	if (ret < 0)
> > +		goto end_trans;
> > +
> > +	while (true) {
> > +		leaf = path->nodes[0];
> > +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> > +			ret = btrfs_next_leaf(fst, path);
> > +			if (ret < 0)
> > +				goto end_trans;
> > +			if (ret > 0)
> > +				break;
> > +			leaf = path->nodes[0];
> > +		}
> > +
> > +		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> > +
> > +		bg = btrfs_lookup_first_block_group(fs_info, key.objectid);
> 
> We can do the lookup out of the loop. With a parameter 0 for @bytenr.
> 
> As we just need to delete any entry before the first bg, there is no 
> need to lookup the bg every time.
> 
> Furthermore, since the stale entries are just from the temporary chunks, 
> they should be pretty small, thus we are able to afford the check at 
> every mount.

A one time check per mount sounds like the best solution, it has
negligible cost, compared to compat bits.

