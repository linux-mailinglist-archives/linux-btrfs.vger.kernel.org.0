Return-Path: <linux-btrfs+bounces-4499-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E308AE962
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 16:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77B228A2BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 14:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F8813B5A4;
	Tue, 23 Apr 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c1RDJ2Mo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nw8a8Gy2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c1RDJ2Mo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nw8a8Gy2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40A13B2AC
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882281; cv=none; b=HXm4wpxCc7lwCSNSJM0T6yrDGeiicg3UAWXwTFmrAi8Ank5qARyPxdmHA2EN+USfVA3/YOSwhNtwO7pe9LexcNL24EGTH31WglGbYgQ1klmzeVnAmnf4wfjDT/5cmqzLo5ZV/K2YLCDw8A1sLr6yBhhLTh0FYKAjMIrFj6U6ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882281; c=relaxed/simple;
	bh=CqeMQvaumErGDGHLZXLq971quMkNKzsmJ3Rn2llFYBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYz4XPlqp00+M2Z0AQXRdWTUFYSrKUwQUGoc1H7a+ndrxJk9oCuI7o3bElnmLQ714/sd7TsmzjyTYMfwwsTEU70lQV6vpqpRkR+N5VBIZaqEznrBqlWeU7CIPccYEaBQTPM1spmEDqyaCTQGS0Q3ebKGprVkhvcRAsxjA8FVnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c1RDJ2Mo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nw8a8Gy2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c1RDJ2Mo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nw8a8Gy2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B96F260061;
	Tue, 23 Apr 2024 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713882277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABszfnTOWIZ1JayjmjilrF9kIWcVKdJsJoHbgyKYaO4=;
	b=c1RDJ2Mo/0/t308MupcrC+Wd/dpFz7mfeJBsRpo4Ts26ErvYJbj47ButZxrVfDTFoJeYz1
	Qv6xiEpi9aDdxVgbNFi5/bwSFE13zI2hRW4J26O+EAX85CC9d9U8hFvGVlfQgn+CrW83Xw
	m3hZrtIRtxI0xU2WuSXyjk3uepw7/o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713882277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABszfnTOWIZ1JayjmjilrF9kIWcVKdJsJoHbgyKYaO4=;
	b=Nw8a8Gy2oTON9pZzyil1gBmtUMJHPQ4PJoxqvSKiD8PPOPTg0xL3gqhUK/fBw7gxhOrMft
	SOPD9V45O6eFyLDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c1RDJ2Mo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Nw8a8Gy2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713882277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABszfnTOWIZ1JayjmjilrF9kIWcVKdJsJoHbgyKYaO4=;
	b=c1RDJ2Mo/0/t308MupcrC+Wd/dpFz7mfeJBsRpo4Ts26ErvYJbj47ButZxrVfDTFoJeYz1
	Qv6xiEpi9aDdxVgbNFi5/bwSFE13zI2hRW4J26O+EAX85CC9d9U8hFvGVlfQgn+CrW83Xw
	m3hZrtIRtxI0xU2WuSXyjk3uepw7/o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713882277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABszfnTOWIZ1JayjmjilrF9kIWcVKdJsJoHbgyKYaO4=;
	b=Nw8a8Gy2oTON9pZzyil1gBmtUMJHPQ4PJoxqvSKiD8PPOPTg0xL3gqhUK/fBw7gxhOrMft
	SOPD9V45O6eFyLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8DA213929;
	Tue, 23 Apr 2024 14:24:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bS4PKaXEJ2ZgewAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Apr 2024 14:24:37 +0000
Date: Tue, 23 Apr 2024 16:17:00 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: fix btrfs_file_extent_item::ram_bytes of
 btrfs_split_ordered_extent()
Message-ID: <20240423141700.GH3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713329516.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713329516.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B96F260061
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

On Wed, Apr 17, 2024 at 02:24:37PM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Update the comment on file extent item tree-checker 
>   To be less confusing for future readers.
> 
> - Remove one fixes tag of the first patch
>   The bug goes back to the introduction of zoned ordered extent
>   splitting, thus that oldest commit should be the cause.
> 
> During my extent_map members rework, I added a sanity check to make sure
> regular non-compressed extent_map would have its disk_num_bytes to match
> ram_bytes.
> 
> But that extent_map sanity check always fail as we have on-disk file
> extent items which has its ram_bytes much larger than the corresponding
> disk_num_bytes, even if it's not compressed.
> 
> It turns out that, the ram_bytes > disk_num_bytes is caused by
> btrfs_split_ordered_extent(), where it doesn't properly update
> ram_bytes, resulting it larger than disk_num_bytes.
> 
> Thankfully everything is fine, as our code doesn't really bother
> ram_bytes for non-compressed regular file extents, so no real damage.
> 
> Still I'd like to catch such problem in the future, so add another
> tree-checker patch for this case.
> 
> And since the invalid ram_bytes is already in the wild for a while, we
> do not want to bother the end users to fix their fs for nothing.
> So the check is only behind DEBUG builds.
> 
> Furthermore, the tree-checker is only to make sure @ram_bytes <
> @disk_num_bytes for non-compressed file extents.
> As we still have other locations to make @ram_bytes < @disk_num_bytes.
> 
> And for btrfs-progs, I'm going to add extra check and repair support
> soon.
> 
> Qu Wenruo (2):
>   btrfs: set correct ram_bytes when splitting ordered extent
>   btrfs: tree-checker: add one extra file extent item ram_bytes check

Reviewed-by: David Sterba <dsterba@suse.com>

